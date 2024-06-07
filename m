Return-Path: <linux-kernel+bounces-206510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAE3900ABB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB39528493A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F55019AD51;
	Fri,  7 Jun 2024 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QD13S1gv"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290AB19007A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717778959; cv=none; b=sJbgUuQK0Hx/oX0xdoiGfxB1f/0QVa/zbn1E81bf93CMsgSYi7YlLB7I7+9HUKtfOSFA8pf/ZSQUvg1FZiFHEtV6IA4XFUevLik5Sz38uNkd3KmgDotSMm61RHp2NA9Z7h80nIviIy01Jz4dy5ikxnrr+8Ahca0XTd+M+8Ku89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717778959; c=relaxed/simple;
	bh=Di5A8LPnmhwJzeMLt1uEvLIy5ioqrIfxl0SdvcNbxZY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UfcVaKtIOXC2zElLGkTEZPaGHpurMmvZxS4vQsQKjp4CBjss2W3xBp0AfFERO1hwyaiKijh/i8HWiJqfep84MMkAe7a1K1b2UXOvDXnCoA/DYp6Kc0F9Db3c0ewfx3TOUpp+2HF123RrO7WRyQXW75tiKmKY3miVYu8ASkLuIIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QD13S1gv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457GFI2P012334;
	Fri, 7 Jun 2024 16:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=WFeEPbzwDYfzW5+rKmDa6gD+6sj3N898ljKT8Dy9bGg=;
 b=QD13S1gv8fu4ba7P2OgJ9oSfe3KHgsUqsrR0nGe6g/LyscbFxDIYkqlLGbT5YTEsil9L
 9Lv2VW81QVkp+UeSP8riSijidl19noAKHAS45Rekvcvub4G6XFCNtIQz5o72zMc2lmS2
 PtJri2/2il6I7KEtGgRkLx2UDkJegfeIMMKXsUdt/098T9d7Xbu2CcJpqOiQQ0HMExk2
 vrEdormZdBA7K7gczePxwhbyHsriI6xDzF9XOk/Lsi6YpfcOcS3FRc3ewSDz8mPI6gTQ
 3G+KPZHccP0bpZwE2W26D4keu0hZUPxJxVkiKAp+Un6dcy8RWb4dQBZ9I9I/+IgtPvVZ ug== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ym5j4g3d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 16:48:41 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 457GmeOr004818;
	Fri, 7 Jun 2024 16:48:40 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ym5j4g3cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 16:48:40 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 457Gk8h2022835;
	Fri, 7 Jun 2024 16:48:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ygg6mshsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 16:48:39 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 457Gmbxm56230392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jun 2024 16:48:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 089E55806D;
	Fri,  7 Jun 2024 16:48:37 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5A5158054;
	Fri,  7 Jun 2024 16:48:32 +0000 (GMT)
Received: from [9.195.40.55] (unknown [9.195.40.55])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Jun 2024 16:48:32 +0000 (GMT)
Message-ID: <bbeca067-ae70-43ff-afab-6d06648c5481@linux.ibm.com>
Date: Fri, 7 Jun 2024 22:18:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <2d6ef6d8-6aef-4703-a9c7-90501537cdc5@linux.ibm.com>
 <8734pw51he.fsf@oracle.com>
 <71efae1a-6a27-4e1f-adac-19c1b18e0f0c@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <71efae1a-6a27-4e1f-adac-19c1b18e0f0c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A4k5-a5BaDfWxnsTCmzn1ciBq9U-N50S
X-Proofpoint-GUID: 4oSboUBhM73G8sthSfZ-vgIMYyreEG_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_10,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070124



On 6/4/24 1:02 PM, Shrikanth Hegde wrote:
> 
> 
> On 6/1/24 5:17 PM, Ankur Arora wrote:
>>
>> Shrikanth Hegde <sshegde@linux.ibm.com> writes:
>>
>>> On 5/28/24 6:04 AM, Ankur Arora wrote:
>>>> Hi,
>>>>
>>>> This series adds a new scheduling model PREEMPT_AUTO, which like
>>>> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
>>>> preemption model. Unlike, PREEMPT_DYNAMIC, it doesn't depend
>>>> on explicit preemption points for the voluntary models.
>>>>
>>>> The series is based on Thomas' original proposal which he outlined
>>>> in [1], [2] and in his PoC [3].
>>>>
>>>> v2 mostly reworks v1, with one of the main changes having less
>>>> noisy need-resched-lazy related interfaces.
>>>> More details in the changelog below.
>>>>
>>>
>>> Hi Ankur. Thanks for the series.
>>>
>>> nit: had to manually patch 11,12,13 since it didnt apply cleanly on
>>> tip/master and tip/sched/core. Mostly due some word differences in the change.
>>>
>>> tip/master was at:
>>> commit e874df84d4a5f3ce50b04662b62b91e55b0760fc (HEAD -> master, origin/master, origin/HEAD)
>>> Merge: 5d145493a139 47ff30cc1be7
>>> Author: Ingo Molnar <mingo@kernel.org>
>>> Date:   Tue May 28 12:44:26 2024 +0200
>>>
>>>     Merge branch into tip/master: 'x86/percpu'
>>>
>>>
>>>
>>>> The v1 of the series is at [4] and the RFC at [5].
>>>>
>>>> Design
>>>> ==
>>>>
>>>> PREEMPT_AUTO works by always enabling CONFIG_PREEMPTION (and thus
>>>> PREEMPT_COUNT). This means that the scheduler can always safely
>>>> preempt. (This is identical to CONFIG_PREEMPT.)
>>>>
>>>> Having that, the next step is to make the rescheduling policy dependent
>>>> on the chosen scheduling model. Currently, the scheduler uses a single
>>>> need-resched bit (TIF_NEED_RESCHED) which it uses to state that a
>>>> reschedule is needed.
>>>> PREEMPT_AUTO extends this by adding an additional need-resched bit
>>>> (TIF_NEED_RESCHED_LAZY) which, with TIF_NEED_RESCHED now allows the
>>>> scheduler to express two kinds of rescheduling intent: schedule at
>>>> the earliest opportunity (TIF_NEED_RESCHED), or express a need for
>>>> rescheduling while allowing the task on the runqueue to run to
>>>> timeslice completion (TIF_NEED_RESCHED_LAZY).
>>>>
>>>> The scheduler decides which need-resched bits are chosen based on
>>>> the preemption model in use:
>>>>
>>>> 	       TIF_NEED_RESCHED        TIF_NEED_RESCHED_LAZY
>>>>
>>>> none		never   		always [*]
>>>> voluntary       higher sched class	other tasks [*]
>>>> full 		always                  never
>>>>
>>>> [*] some details elided.
>>>>
>>>> The last part of the puzzle is, when does preemption happen, or
>>>> alternately stated, when are the need-resched bits checked:
>>>>
>>>>                  exit-to-user    ret-to-kernel    preempt_count()
>>>>
>>>> NEED_RESCHED_LAZY     Y               N                N
>>>> NEED_RESCHED          Y               Y                Y
>>>>
>>>> Using NEED_RESCHED_LAZY allows for run-to-completion semantics when
>>>> none/voluntary preemption policies are in effect. And eager semantics
>>>> under full preemption.
>>>>
>>>> In addition, since this is driven purely by the scheduler (not
>>>> depending on cond_resched() placement and the like), there is enough
>>>> flexibility in the scheduler to cope with edge cases -- ex. a kernel
>>>> task not relinquishing CPU under NEED_RESCHED_LAZY can be handled by
>>>> simply upgrading to a full NEED_RESCHED which can use more coercive
>>>> instruments like resched IPI to induce a context-switch.
>>>>
>>>> Performance
>>>> ==
>>>> The performance in the basic tests (perf bench sched messaging, kernbench,
>>>> cyclictest) matches or improves what we see under PREEMPT_DYNAMIC.
>>>> (See patches
>>>>   "sched: support preempt=none under PREEMPT_AUTO"
>>>>   "sched: support preempt=full under PREEMPT_AUTO"
>>>>   "sched: handle preempt=voluntary under PREEMPT_AUTO")
>>>>
>>>> For a macro test, a colleague in Oracle's Exadata team tried two
>>>> OLTP benchmarks (on a 5.4.17 based Oracle kernel, with the v1 series
>>>> backported.)
>>>>
>>>> In both tests the data was cached on remote nodes (cells), and the
>>>> database nodes (compute) served client queries, with clients being
>>>> local in the first test and remote in the second.
>>>>
>>>> Compute node: Oracle E5, dual socket AMD EPYC 9J14, KVM guest (380 CPUs)
>>>> Cells (11 nodes): Oracle E5, dual socket AMD EPYC 9334, 128 CPUs
>>>>
>>>>
>>>> 				  PREEMPT_VOLUNTARY                        PREEMPT_AUTO
>>>> 				                                        (preempt=voluntary)
>>>>                               ==============================      =============================
>>>>                       clients  throughput    cpu-usage            throughput     cpu-usage         Gain
>>>>                                (tx/min)    (utime %/stime %)      (tx/min)    (utime %/stime %)
>>>> 		      -------  ----------  -----------------      ----------  -----------------   -------
>>>>
>>>>
>>>>   OLTP                  384     9,315,653     25/ 6                9,253,252       25/ 6            -0.7%
>>>>   benchmark	       1536    13,177,565     50/10               13,657,306       50/10            +3.6%
>>>>  (local clients)       3456    14,063,017     63/12               14,179,706       64/12            +0.8%
>>>>
>>>>
>>>>   OLTP                   96     8,973,985     17/ 2                8,924,926       17/ 2            -0.5%
>>>>   benchmark	        384    22,577,254     60/ 8               22,211,419       59/ 8            -1.6%
>>>>  (remote clients,      2304    25,882,857     82/11               25,536,100       82/11            -1.3%
>>>>   90/10 RW ratio)
>>>>
>>>>
>>>> (Both sets of tests have a fair amount of NW traffic since the query
>>>> tables etc are cached on the cells. Additionally, the first set,
>>>> given the local clients, stress the scheduler a bit more than the
>>>> second.)
>>>>
>>>> The comparative performance for both the tests is fairly close,
>>>> more or less within a margin of error.
>>>>
>>>> Raghu KT also tested v1 on an AMD Milan (2 node, 256 cpu,  512GB RAM):
>>>>
>>>> "
>>>>  a) Base kernel (6.7),
>>>>  b) v1, PREEMPT_AUTO, preempt=voluntary
>>>>  c) v1, PREEMPT_DYNAMIC, preempt=voluntary
>>>>  d) v1, PREEMPT_AUTO=y, preempt=voluntary, PREEMPT_RCU = y
>>>>
>>>>  Workloads I tested and their %gain,
>>>>                     case b           case c       case d
>>>>  NAS                +2.7%              +1.9%         +2.1%
>>>>  Hashjoin,          +0.0%              +0.0%         +0.0%
>>>>  Graph500,          -6.0%              +0.0%         +0.0%
>>>>  XSBench            +1.7%              +0.0%         +1.2%
>>>>
>>>>  (Note about the Graph500 numbers at [8].)
>>>>
>>>>  Did kernbench etc test from Mel's mmtests suite also. Did not notice
>>>>  much difference.
>>>> "
>>>>
>>>> One case where there is a significant performance drop is on powerpc,
>>>> seen running hackbench on a 320 core system (a test on a smaller system is
>>>> fine.) In theory there's no reason for this to only happen on powerpc
>>>> since most of the code is common, but I haven't been able to reproduce
>>>> it on x86 so far.
>>>>
>>>> All in all, I think the tests above show that this scheduling model has legs.
>>>> However, the none/voluntary models under PREEMPT_AUTO are conceptually
>>>> different enough from the current none/voluntary models that there
>>>> likely are workloads where performance would be subpar. That needs more
>>>> extensive testing to figure out the weak points.
>>>>
>>>>
>>>>
>>> Did test it again on PowerPC. Unfortunately numbers shows there is regression
>>> still compared to 6.10-rc1. This is done with preempt=none. I tried again on the
>>> smaller system too to confirm. For now I have done the comparison for the hackbench
>>> where highest regression was seen in v1.
>>>
>>> perf stat collected for 20 iterations show higher context switch and higher migrations.
>>> Could it be that LAZY bit is causing more context switches? or could it be something
>>> else? Could it be that more exit-to-user happens in PowerPC? will continue to debug.
>>
>> Thanks for trying it out.
>>
>> As you point out, context-switches and migrations are signficantly higher.
>>
>> Definitely unexpected. I ran the same test on an x86 box
>> (Milan, 2x64 cores, 256 threads) and there I see no more than a ~4% difference.
>>
>>   6.9.0/none.process.pipe.60:       170,719,761      context-switches          #    0.022 M/sec                    ( +-  0.19% )
>>   6.9.0/none.process.pipe.60:        16,871,449      cpu-migrations            #    0.002 M/sec                    ( +-  0.16% )
>>   6.9.0/none.process.pipe.60:      30.833112186 seconds time elapsed                                          ( +-  0.11% )
>>
>>   6.9.0-00035-gc90017e055a6/none.process.pipe.60:       177,889,639      context-switches          #    0.023 M/sec                    ( +-  0.21% )
>>   6.9.0-00035-gc90017e055a6/none.process.pipe.60:        17,426,670      cpu-migrations            #    0.002 M/sec                    ( +-  0.41% )
>>   6.9.0-00035-gc90017e055a6/none.process.pipe.60:      30.731126312 seconds time elapsed                                          ( +-  0.07% )
>>
>> Clearly there's something different going on powerpc. I'm travelling
>> right now, but will dig deeper into this once I get back.
>>
>> Meanwhile can you check if the increased context-switches are voluntary or
>> involuntary (or what the division is)?
> 
> 
> Used "pidstat -w -p ALL 1 10" to capture 10 seconds data at 1 second interval for 
> context switches per second while running "hackbench -pipe 60 process 100000 loops" 
> 
> 
> preempt=none				6.10			preempt_auto
> =============================================================================
> voluntary context switches	    	7632166.19	        9391636.34(+23%)
> involuntary context switches		2305544.07		3527293.94(+53%)
> 
> Numbers vary between multiple runs. But trend seems to be similar. Both the context switches increase 
> involuntary seems to increase at higher rate. 
> 
> 


Continued data from hackbench regression. preempt=none in both the cases.
From mpstat, I see slightly higher idle time and more irq time with preempt_auto. 

6.10-rc1:
=========
10:09:50 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
09:45:23 AM  all    4.14    0.00   77.57    0.00   16.92    0.00    0.00    0.00    0.00    1.37
09:45:24 AM  all    4.42    0.00   77.62    0.00   16.76    0.00    0.00    0.00    0.00    1.20
09:45:25 AM  all    4.43    0.00   77.45    0.00   16.94    0.00    0.00    0.00    0.00    1.18
09:45:26 AM  all    4.45    0.00   77.87    0.00   16.68    0.00    0.00    0.00    0.00    0.99

PREEMPT_AUTO:
===========
10:09:50 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
10:09:56 AM  all    3.11    0.00   72.59    0.00   21.34    0.00    0.00    0.00    0.00    2.96
10:09:57 AM  all    3.31    0.00   73.10    0.00   20.99    0.00    0.00    0.00    0.00    2.60
10:09:58 AM  all    3.40    0.00   72.83    0.00   20.85    0.00    0.00    0.00    0.00    2.92
10:10:00 AM  all    3.21    0.00   72.87    0.00   21.19    0.00    0.00    0.00    0.00    2.73
10:10:01 AM  all    3.02    0.00   72.18    0.00   21.08    0.00    0.00    0.00    0.00    3.71

Used bcc tools hardirq and softirq to see if irq are increasing. softirq implied there are more 
timer,sched softirq. Numbers vary between different samples, but trend seems to be similar. 

6.10-rc1:
=========
SOFTIRQ          TOTAL_usecs
tasklet                   71
block                    145
net_rx                  7914
rcu                   136988
timer                 304357
sched                1404497



PREEMPT_AUTO:
===========
SOFTIRQ          TOTAL_usecs
tasklet                   80
block                    139
net_rx                  6907
rcu                   223508
timer                 492767
sched                1794441


Would any specific setting of RCU matter for this? 
This is what I have in config. 

# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_TREE_SRCU=y
CONFIG_NEED_SRCU_NMI_SAFE=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_NEED_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem


# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem


