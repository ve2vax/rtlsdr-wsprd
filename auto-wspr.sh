#!/bin/bash
CALL="VE2VAX"
FREQ="144.489M"
GRID="FN35jo"
###tail -f /root/out.txt | sed '/decoded q'
i=10
s=1
  nohup /home/pi/rtlsdr-wsprd/rtlsdr_wsprd -f $FREQ -c $CALL -l $GRID -p 0.5 -a 1 -S > /tmp/out.txt 2>&1 &

while [ $i -gt 4 ]
do
 sleep 2
 s1=$(cat /tmp/out.txt | grep "spot" |wc | awk '{print $1}')
  if [ $s1 -gt 2 ];
  then
   echo "" > /tmp/out.txt;pkill -9 -f rtlsdr_wsprd
   sleep 1
   (( s++ ))
   nohup /home/pi/rtlsdr-wsprd/rtlsdr_wsprd -f $FREQ -c $CALL -l $GRID  -p 0.5 -a 1 -S > /tmp/out.txt 2>&1 &
  fi
 if [ $s -eq 1 ]; then FREQ="50.293M"
 fi
 if [ $s -eq 2 ]; then FREQ="144.489M"
 fi
 if [ $s -eq 3 ]; then FREQ="222.293M"
 fi
 if [ $s -eq 4 ]; then FREQ="432.300M"
 fi
 if [ $s -eq 5 ]; then s=1
 fi
done
