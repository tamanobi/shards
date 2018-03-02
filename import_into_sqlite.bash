# !/bin/bash
set -eux

### how to use
# zcat huge.csv.gz | sqlite3 --init $commandfile sqlite.db

CSV_FILE=$1
DB=$2
TABLE_NAME=$3

commandfile=$(mktemp)
cat <<__EOF__ > $commandfile
.mode csv ${TABLE_NAME}
.separator ","
.import /dev/stdin ${TABLE_NAME}
__EOF__

zcat ${CSV_FILE} | sed '1,1d' | sqlite3 --init $commandfile ${DB}
rm $commandfile
