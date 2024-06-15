Return-Path: <linux-kernel+bounces-215914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EFD9098BE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75618B216E2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 15:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5E349632;
	Sat, 15 Jun 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FNUWpo2W"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8563C482
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718463926; cv=none; b=GZzFBsmD9fkXpVaJmWMS23gckxBDSK0HnRyUMzYwAh1bAQ+cp/K+c2u8caBlaCwANs0mtDPluEdvhXvLd9B2ZX9/hozhe/DK8+m+cpzjAGsqwH0+36I7Xcy08Jmwbel1Dp5g7XH04oYj09ysVwYrnp/CRGDSLTLhcxZglTrT5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718463926; c=relaxed/simple;
	bh=t2KYc9Dyrg15SffwbV6Gs79G2B4vlb2whm47yQivLDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lj2lksWPv5pwgrOSxejMIDO1h/+RPDahR8PD+abSqSkVHGd5JsOGXUWbTTrWaam6qYEuxqoWlnxjz+FChKRsCf7imvm4LViCmDFLcBqcIu0QlUInRPa+xC+eL0IvVSXCHiXyAExJGlhY3f0L9GXX6ITu9WtCF9IleVUbXUjntgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FNUWpo2W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45FDR8Un030677;
	Sat, 15 Jun 2024 15:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=A
	03AwZ1BVoMemm7xGptbOTIuV26URNqK0xmX02MVB64=; b=FNUWpo2WyRvMLXtFG
	IVhiWPYkm1x+anJJMG/bdfMChHsLfN5MDGDlTK6eFYagY9geHwNCZ2ug/SzlzK86
	Xy4Tahw+xDZrRpMtszu9P+7IAWs0IVKI7gAvVtxqzSyDLiCum6htKDMtTH9nE/o7
	XKDsE1GyiwqcQmcaKptxMsI8Dd+KmAdWKIXfyKFlIZsGE2I3S0Ng5te2m0i+E/8S
	Jmu9TgXTtOv/F2hB9BbthtxOjuDCMRSj0JvovQaa5GRuDuAV9maS/drYUjl4YSr9
	xL4Q9YhfX/6zwkTv79yFtZgym7gWNzPB56qvoKipnyngrsblEYLjnxaUyTPtG+bG
	jAJ1w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ysaj3g979-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 15:04:53 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45FF4qtV023509;
	Sat, 15 Jun 2024 15:04:52 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ysaj3g976-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 15:04:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45FBMBKd023604;
	Sat, 15 Jun 2024 15:04:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn3unhdk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 15:04:51 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45FF4n0225428488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Jun 2024 15:04:51 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1DB858056;
	Sat, 15 Jun 2024 15:04:48 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E17458052;
	Sat, 15 Jun 2024 15:04:45 +0000 (GMT)
Received: from [9.195.47.148] (unknown [9.195.47.148])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 15 Jun 2024 15:04:45 +0000 (GMT)
Message-ID: <17555273-a361-48b8-8543-9f63c2b8856b@linux.ibm.com>
Date: Sat, 15 Jun 2024 20:34:44 +0530
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
 <2d6ef6d8-6aef-4703-a9c7-90501537cdc5@linux.ibm.com>
 <8734pw51he.fsf@oracle.com>
 <71efae1a-6a27-4e1f-adac-19c1b18e0f0c@linux.ibm.com>
 <bbeca067-ae70-43ff-afab-6d06648c5481@linux.ibm.com>
 <87zfrts1l1.fsf@oracle.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <87zfrts1l1.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4LLXIFRSWk-dXtx-XCTJBO-JK18g4te1
X-Proofpoint-GUID: KkAHsARM6YgTZZdL2qOy1tCfMr-umxSf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-15_10,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406150113



On 6/10/24 12:53 PM, Ankur Arora wrote:
> 
_auto.
>>
>> 6.10-rc1:
>> =========
>> 10:09:50 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>> 09:45:23 AM  all    4.14    0.00   77.57    0.00   16.92    0.00    0.00    0.00    0.00    1.37
>> 09:45:24 AM  all    4.42    0.00   77.62    0.00   16.76    0.00    0.00    0.00    0.00    1.20
>> 09:45:25 AM  all    4.43    0.00   77.45    0.00   16.94    0.00    0.00    0.00    0.00    1.18
>> 09:45:26 AM  all    4.45    0.00   77.87    0.00   16.68    0.00    0.00    0.00    0.00    0.99
>>
>> PREEMPT_AUTO:
>> ===========
>> 10:09:50 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>> 10:09:56 AM  all    3.11    0.00   72.59    0.00   21.34    0.00    0.00    0.00    0.00    2.96
>> 10:09:57 AM  all    3.31    0.00   73.10    0.00   20.99    0.00    0.00    0.00    0.00    2.60
>> 10:09:58 AM  all    3.40    0.00   72.83    0.00   20.85    0.00    0.00    0.00    0.00    2.92
>> 10:10:00 AM  all    3.21    0.00   72.87    0.00   21.19    0.00    0.00    0.00    0.00    2.73
>> 10:10:01 AM  all    3.02    0.00   72.18    0.00   21.08    0.00    0.00    0.00    0.00    3.71
>>
>> Used bcc tools hardirq and softirq to see if irq are increasing. softirq implied there are more
>> timer,sched softirq. Numbers vary between different samples, but trend seems to be similar.
> 
> Yeah, the %sys is lower and %irq, higher. Can you also see where the
> increased %irq is? For instance are the resched IPIs numbers greater?

Hi Ankur,


Used mpstat -I ALL to capture this info for 20 seconds. 

HARDIRQ per second:
===================
6.10:
===================
18		19		22		23		48	49	50	51	LOC		BCT	LOC2	SPU	PMI	MCE	NMI	WDG	DBL
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
417956.86	1114642.30	1712683.65	2058664.99	0.00	0.00	18.30	0.39	31978.37	0.00	0.35	351.98	0.00	0.00	0.00	6405.54	329189.45

Preempt_auto:
===================
18		19		22		23		48	49	50	51	LOC		BCT	LOC2	SPU	PMI	MCE	NMI	WDG	DBL
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
609509.69	1910413.99	1923503.52	2061876.33	0.00	0.00	19.14	0.30	31916.59	0.00	0.45	497.88	0.00	0.00	0.00	6825.49	88247.85

18,19,22,23 are called XIVE interrupts. These are IPI interrupts. I am not sure which type of IPI are these. will have to see why its increasing. 


SOFTIRQ per second:
===================
6.10:
=================== 
HI	TIMER	NET_TX	NET_RX	BLOCK	IRQ_POLL	TASKLET		SCHED		HRTIMER		RCU	
0.00	3966.47	0.00	18.25	0.59	0.00		0.34		12811.00	0.00		9693.95

Preempt_auto:
===================
HI	TIMER	NET_TX	NET_RX	BLOCK	IRQ_POLL	TASKLET		SCHED		HRTIMER		RCU	
0.00	4871.67	0.00	18.94	0.40	0.00		0.25		13518.66	0.00		15732.77

Note: RCU softirq seems to increase significantly. Not sure which one triggers. still trying to figure out why. 
It maybe irq triggering to softirq or softirq causing more IPI. 



Also, Noticed a below config difference which gets removed in preempt auto. This happens because PREEMPTION make them as N. Made the changes in kernel/Kconfig.locks to get them 
enabled. I still see the same regression in hackbench. These configs still may need attention?
		
					6.10				       | 					preempt auto 
  CONFIG_INLINE_SPIN_UNLOCK_IRQ=y                                              |  CONFIG_UNINLINE_SPIN_UNLOCK=y                                               
  CONFIG_INLINE_READ_UNLOCK=y                                                  |  ----------------------------------------------------------------------------
  CONFIG_INLINE_READ_UNLOCK_IRQ=y                                              |  ----------------------------------------------------------------------------
  CONFIG_INLINE_WRITE_UNLOCK=y                                                 |  ----------------------------------------------------------------------------
  CONFIG_INLINE_WRITE_UNLOCK_IRQ=y                                             |  ----------------------------------------------------------------------------


> 
>> 6.10-rc1:
>> =========
>> SOFTIRQ          TOTAL_usecs
>> tasklet                   71
>> block                    145
>> net_rx                  7914
>> rcu                   136988
>> timer                 304357
>> sched                1404497
>>
>>
>>
>> PREEMPT_AUTO:
>> ===========
>> SOFTIRQ          TOTAL_usecs
>> tasklet                   80
>> block                    139
>> net_rx                  6907
>> rcu                   223508
>> timer                 492767
>> sched                1794441
>>
>>
>> Would any specific setting of RCU matter for this?
>> This is what I have in config.
> 
> Don't see how it could matter unless the RCU settings are changing
> between the two tests? In my testing I'm also using TREE_RCU=y,
> PREEMPT_RCU=n.
> 
> Let me see if I can find a test which shows a similar trend to what you
> are seeing. And, then maybe see if tracing sched-switch might point to
> an interesting difference between x86 and powerpc.
> 
> 
> Thanks for all the detail.
> 
> Ankur
> 
>> # RCU Subsystem
>> #
>> CONFIG_TREE_RCU=y
>> # CONFIG_RCU_EXPERT is not set
>> CONFIG_TREE_SRCU=y
>> CONFIG_NEED_SRCU_NMI_SAFE=y
>> CONFIG_TASKS_RCU_GENERIC=y
>> CONFIG_NEED_TASKS_RCU=y
>> CONFIG_TASKS_RCU=y
>> CONFIG_TASKS_RUDE_RCU=y
>> CONFIG_TASKS_TRACE_RCU=y
>> CONFIG_RCU_STALL_COMMON=y
>> CONFIG_RCU_NEED_SEGCBLIST=y
>> CONFIG_RCU_NOCB_CPU=y
>> # CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
>> # CONFIG_RCU_LAZY is not set
>> # end of RCU Subsystem
>>
>>
>> # Timers subsystem
>> #
>> CONFIG_TICK_ONESHOT=y
>> CONFIG_NO_HZ_COMMON=y
>> # CONFIG_HZ_PERIODIC is not set
>> # CONFIG_NO_HZ_IDLE is not set
>> CONFIG_NO_HZ_FULL=y
>> CONFIG_CONTEXT_TRACKING_USER=y
>> # CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
>> CONFIG_NO_HZ=y
>> CONFIG_HIGH_RES_TIMERS=y
>> # end of Timers subsystem
> 
> 
> --
> ankur

