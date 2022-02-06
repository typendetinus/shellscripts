#!/bin/bash
###########################A##################################################################################################
## script       :   oracle_check.sh
## by           :   Martijn Kalf
## desc         :   Checks the availability of the Oracle databases for login before the start of all schedules
## version      :   initial
##############################################################################################################################
config=.dblist.cfg
echo -e "Result \t User ID\t   Instance"
cat ${config} | while read a b c
do
    echo "exit" | sqlplus -L ${a}/${b}@${c} | grep Connected > /dev/null
    if [ $? -eq 0 ]
    then
        tput setaf 2;echo -e "[OK]"  "`tput sgr0` ${a} \t ${c}" | column -t -s'   '
    else
        tput setaf 1;echo -e "[FAIL]`tput sgr0` ${a} \t ${c}" | column -t -s '    '
    fi
done
