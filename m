Return-Path: <linux-kernel+bounces-193497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5158D2D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE9A289439
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E79315B124;
	Wed, 29 May 2024 06:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sHzbfxfl"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794B815B141
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963446; cv=none; b=O4ullds4L1g0Ro+7+CXNkRClRmjRum986uOv33CvXCuessZX9XPH7WSwSTtMSKnt8L+YMxjy4WkUnnnOYxXXsNxfvXPpUdslnuYs2y2juz1REP4IMUsjE+i/L9a/ia/jxpgbtkRRvshjEfHt+N/f05W6QzLRw1mWqWFaa9SFaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963446; c=relaxed/simple;
	bh=gjkKEbdqQGGjcXUGhan/JT9wXBx7cMwYodHiXtGXH/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdsrBKK4FnXbIM7sNNspg759bBQdFXrP07BMpTTxNLXOdv2iS47stenEPWslXAw1AQUZF49O7Hin/41Xjb507ni44/Q7Rgg4RDI2HT7oYADVv+HQKD6PbsBynaMHhpJL5jO0OITM5G2/1XYLFd5y7R/9JeBoEfE2DfFGFbRr2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sHzbfxfl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44T61R3u015910;
	Wed, 29 May 2024 06:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=vsSrXAlX71a3hs0mXRSj4O2SmIig+Fb2iL2MhJG6YIA=;
 b=sHzbfxflNQ2T0AqCbleT58WweW6BDiTdPoJzXsnSAEa3vvNoVGCQr0KGSqb0/ujwAMO4
 wYq4F7v9oJptIGmpR3rLwY4Ti+y2J5bpf5RA0EWQ8EoVlXk/Uj2t9bUmVCKm6VPFS9e2
 Jmr1sxjRAMRGiqwe2IuCYTdcJ9vRYV34XHSEm0Ex1op5DX+K5Xq9oCl5ZwSXVjisPrG2
 KsGOeW5vFJjLwNQHzxJAlcMZ7v/mbOfHDF+rT2hPq9r5kUOzVXL9yfLIblYO2GPKY/GL
 wRVOLj8ANDqWHWelwzu/AhI8MMBQaOBWzBQwgWondH49QA6Ivqp0bvnxIMqflSo/7BEt ng== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydwv704yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 06:16:49 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44T6GnXI005241;
	Wed, 29 May 2024 06:16:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydwv704yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 06:16:49 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44T4Ej90029563;
	Wed, 29 May 2024 06:16:48 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ydpayj7kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 06:16:48 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44T6Gj0u26084028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 06:16:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F9C25804E;
	Wed, 29 May 2024 06:16:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C4525803F;
	Wed, 29 May 2024 06:16:40 +0000 (GMT)
Received: from [9.124.218.235] (unknown [9.124.218.235])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 May 2024 06:16:40 +0000 (GMT)
Message-ID: <2d6ef6d8-6aef-4703-a9c7-90501537cdc5@linux.ibm.com>
Date: Wed, 29 May 2024 11:46:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D5NnyF-z_iYlWkhVqYGD8f0vDTaUR9NG
X-Proofpoint-GUID: AqAgvuC3QLfa7t8jZP86jjEeEp0E0EdC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405290039



On 5/28/24 6:04 AM, Ankur Arora wrote:
> Hi,
> 
> This series adds a new scheduling model PREEMPT_AUTO, which like
> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
> preemption model. Unlike, PREEMPT_DYNAMIC, it doesn't depend
> on explicit preemption points for the voluntary models.
> 
> The series is based on Thomas' original proposal which he outlined
> in [1], [2] and in his PoC [3].
> 
> v2 mostly reworks v1, with one of the main changes having less
> noisy need-resched-lazy related interfaces.
> More details in the changelog below.
>

Hi Ankur. Thanks for the series. 

nit: had to manually patch 11,12,13 since it didnt apply cleanly on
tip/master and tip/sched/core. Mostly due some word differences in the change. 

tip/master was at:
commit e874df84d4a5f3ce50b04662b62b91e55b0760fc (HEAD -> master, origin/master, origin/HEAD)
Merge: 5d145493a139 47ff30cc1be7
Author: Ingo Molnar <mingo@kernel.org>
Date:   Tue May 28 12:44:26 2024 +0200

    Merge branch into tip/master: 'x86/percpu'
    

 
> The v1 of the series is at [4] and the RFC at [5].
> 
> Design
> ==
> 
> PREEMPT_AUTO works by always enabling CONFIG_PREEMPTION (and thus
> PREEMPT_COUNT). This means that the scheduler can always safely
> preempt. (This is identical to CONFIG_PREEMPT.)
> 
> Having that, the next step is to make the rescheduling policy dependent
> on the chosen scheduling model. Currently, the scheduler uses a single
> need-resched bit (TIF_NEED_RESCHED) which it uses to state that a
> reschedule is needed.
> PREEMPT_AUTO extends this by adding an additional need-resched bit
> (TIF_NEED_RESCHED_LAZY) which, with TIF_NEED_RESCHED now allows the
> scheduler to express two kinds of rescheduling intent: schedule at
> the earliest opportunity (TIF_NEED_RESCHED), or express a need for
> rescheduling while allowing the task on the runqueue to run to
> timeslice completion (TIF_NEED_RESCHED_LAZY).
> 
> The scheduler decides which need-resched bits are chosen based on
> the preemption model in use:
> 
> 	       TIF_NEED_RESCHED        TIF_NEED_RESCHED_LAZY
> 
> none		never   		always [*]
> voluntary       higher sched class	other tasks [*]
> full 		always                  never
> 
> [*] some details elided.
> 
> The last part of the puzzle is, when does preemption happen, or
> alternately stated, when are the need-resched bits checked:
> 
>                  exit-to-user    ret-to-kernel    preempt_count()
> 
> NEED_RESCHED_LAZY     Y               N                N
> NEED_RESCHED          Y               Y                Y
> 
> Using NEED_RESCHED_LAZY allows for run-to-completion semantics when
> none/voluntary preemption policies are in effect. And eager semantics
> under full preemption.
> 
> In addition, since this is driven purely by the scheduler (not
> depending on cond_resched() placement and the like), there is enough
> flexibility in the scheduler to cope with edge cases -- ex. a kernel
> task not relinquishing CPU under NEED_RESCHED_LAZY can be handled by
> simply upgrading to a full NEED_RESCHED which can use more coercive
> instruments like resched IPI to induce a context-switch.
> 
> Performance
> ==
> The performance in the basic tests (perf bench sched messaging, kernbench,
> cyclictest) matches or improves what we see under PREEMPT_DYNAMIC.
> (See patches 
>   "sched: support preempt=none under PREEMPT_AUTO"
>   "sched: support preempt=full under PREEMPT_AUTO"
>   "sched: handle preempt=voluntary under PREEMPT_AUTO")
> 
> For a macro test, a colleague in Oracle's Exadata team tried two
> OLTP benchmarks (on a 5.4.17 based Oracle kernel, with the v1 series
> backported.)
> 
> In both tests the data was cached on remote nodes (cells), and the
> database nodes (compute) served client queries, with clients being
> local in the first test and remote in the second.
> 
> Compute node: Oracle E5, dual socket AMD EPYC 9J14, KVM guest (380 CPUs)
> Cells (11 nodes): Oracle E5, dual socket AMD EPYC 9334, 128 CPUs
> 
> 
> 				  PREEMPT_VOLUNTARY                        PREEMPT_AUTO
> 				                                        (preempt=voluntary)          
>                               ==============================      =============================
>                       clients  throughput    cpu-usage            throughput     cpu-usage         Gain
>                                (tx/min)    (utime %/stime %)      (tx/min)    (utime %/stime %)
> 		      -------  ----------  -----------------      ----------  -----------------   -------
> 				                                            
> 
>   OLTP                  384     9,315,653     25/ 6                9,253,252       25/ 6            -0.7%
>   benchmark	       1536    13,177,565     50/10               13,657,306       50/10            +3.6%
>  (local clients)       3456    14,063,017     63/12               14,179,706       64/12            +0.8%
> 
> 
>   OLTP                   96     8,973,985     17/ 2                8,924,926       17/ 2            -0.5%
>   benchmark	        384    22,577,254     60/ 8               22,211,419       59/ 8            -1.6%
>  (remote clients,      2304    25,882,857     82/11               25,536,100       82/11            -1.3%
>   90/10 RW ratio)
> 
> 
> (Both sets of tests have a fair amount of NW traffic since the query
> tables etc are cached on the cells. Additionally, the first set,
> given the local clients, stress the scheduler a bit more than the
> second.)
> 
> The comparative performance for both the tests is fairly close,
> more or less within a margin of error.
> 
> Raghu KT also tested v1 on an AMD Milan (2 node, 256 cpu,  512GB RAM):
> 
> "
>  a) Base kernel (6.7),
>  b) v1, PREEMPT_AUTO, preempt=voluntary
>  c) v1, PREEMPT_DYNAMIC, preempt=voluntary
>  d) v1, PREEMPT_AUTO=y, preempt=voluntary, PREEMPT_RCU = y
>  
>  Workloads I tested and their %gain,
>                     case b           case c       case d
>  NAS                +2.7%              +1.9%         +2.1%
>  Hashjoin,          +0.0%              +0.0%         +0.0%
>  Graph500,          -6.0%              +0.0%         +0.0%
>  XSBench            +1.7%              +0.0%         +1.2%
>  
>  (Note about the Graph500 numbers at [8].)
>  
>  Did kernbench etc test from Mel's mmtests suite also. Did not notice
>  much difference.
> "
> 
> One case where there is a significant performance drop is on powerpc,
> seen running hackbench on a 320 core system (a test on a smaller system is
> fine.) In theory there's no reason for this to only happen on powerpc
> since most of the code is common, but I haven't been able to reproduce
> it on x86 so far.
> 
> All in all, I think the tests above show that this scheduling model has legs.
> However, the none/voluntary models under PREEMPT_AUTO are conceptually
> different enough from the current none/voluntary models that there
> likely are workloads where performance would be subpar. That needs more
> extensive testing to figure out the weak points.
> 
> 
> 
Did test it again on PowerPC. Unfortunately numbers shows there is regression 
still compared to 6.10-rc1. This is done with preempt=none. I tried again on the 
smaller system too to confirm. For now I have done the comparison for the hackbench 
where highest regression was seen in v1.  

perf stat collected for 20 iterations show higher context switch and higher migrations. 
Could it be that LAZY bit is causing more context switches? or could it be something 
else? Could it be that more exit-to-user happens in PowerPC? will continue to debug. 

Meanwhile, will do more test with other micro-benchmarks and post the results.


More details below. 
CONFIG_HZ = 100
/hackbench -pipe 60 process 100000 loops

====================================================================================
On the larger system. (40 Cores, 320CPUS)
====================================================================================
				6.10-rc1		+preempt_auto
				preempt=none		preempt=none
20 iterations avg value
hackbench pipe(60)		26.403			32.368 ( -31.1%)

++++++++++++++++++
baseline 6.10-rc1:
++++++++++++++++++
 Performance counter stats for 'system wide' (20 runs):
    168,980,939.76 msec cpu-clock                        # 6400.026 CPUs utilized               ( +-  6.59% )
     6,299,247,371      context-switches                 #   70.596 K/sec                       ( +-  6.60% )
       246,646,236      cpu-migrations                   #    2.764 K/sec                       ( +-  6.57% )
         1,759,232      page-faults                      #   19.716 /sec                        ( +-  6.61% )
577,719,907,794,874      cycles                           #    6.475 GHz                         ( +-  6.60% )
226,392,778,622,410      instructions                     #    0.74  insn per cycle              ( +-  6.61% )
37,280,192,946,445      branches                         #  417.801 M/sec                       ( +-  6.61% )
   166,456,311,053      branch-misses                    #    0.85% of all branches             ( +-  6.60% )

            26.403 +- 0.166 seconds time elapsed  ( +-  0.63% )

++++++++++++
preempt auto
++++++++++++
 Performance counter stats for 'system wide' (20 runs):
    207,154,235.95 msec cpu-clock                        # 6400.009 CPUs utilized               ( +-  6.64% )
     9,337,462,696      context-switches                 #   85.645 K/sec                       ( +-  6.68% )
       631,276,554      cpu-migrations                   #    5.790 K/sec                       ( +-  6.79% )
         1,756,583      page-faults                      #   16.112 /sec                        ( +-  6.59% )
700,281,729,230,103      cycles                           #    6.423 GHz                         ( +-  6.64% )
254,713,123,656,485      instructions                     #    0.69  insn per cycle              ( +-  6.63% )
42,275,061,484,512      branches                         #  387.756 M/sec                       ( +-  6.63% )
   231,944,216,106      branch-misses                    #    1.04% of all branches             ( +-  6.64% )

            32.368 +- 0.200 seconds time elapsed  ( +-  0.62% )


============================================================================================
Smaller system ( 12Cores, 96CPUS)
============================================================================================
				6.10-rc1		+preempt_auto
				preempt=none		preempt=none
20 iterations avg value
hackbench pipe(60)		55.930			65.75 ( -17.6%)

++++++++++++++++++
baseline 6.10-rc1:
++++++++++++++++++
 Performance counter stats for 'system wide' (20 runs):
    107,386,299.19 msec cpu-clock                        # 1920.003 CPUs utilized               ( +-  6.55% )
     1,388,830,542      context-switches                 #   24.536 K/sec                       ( +-  6.19% )
        44,538,641      cpu-migrations                   #  786.840 /sec                        ( +-  6.23% )
         1,698,710      page-faults                      #   30.010 /sec                        ( +-  6.58% )
412,401,110,929,055      cycles                           #    7.286 GHz                         ( +-  6.54% )
192,380,094,075,743      instructions                     #    0.88  insn per cycle              ( +-  6.59% )
30,328,724,557,878      branches                         #  535.801 M/sec                       ( +-  6.58% )
    99,642,840,901      branch-misses                    #    0.63% of all branches             ( +-  6.57% )

            55.930 +- 0.509 seconds time elapsed  ( +-  0.91% )


+++++++++++++++++
v2_preempt_auto
+++++++++++++++++
 Performance counter stats for 'system wide' (20 runs):
    126,244,029.04 msec cpu-clock                        # 1920.005 CPUs utilized               ( +-  6.51% )
     2,563,720,294      context-switches                 #   38.356 K/sec                       ( +-  6.10% )
       147,445,392      cpu-migrations                   #    2.206 K/sec                       ( +-  6.37% )
         1,710,637      page-faults                      #   25.593 /sec                        ( +-  6.55% )
483,419,889,144,017      cycles                           #    7.232 GHz                         ( +-  6.51% )
210,788,030,476,548      instructions                     #    0.82  insn per cycle              ( +-  6.57% )
33,851,562,301,187      branches                         #  506.454 M/sec                       ( +-  6.56% )
   134,059,721,699      branch-misses                    #    0.75% of all branches             ( +-  6.45% )

             65.75 +- 1.06 seconds time elapsed  ( +-  1.61% )


