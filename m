Return-Path: <linux-kernel+bounces-375654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C68FA9A98C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F741C20DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC25D1E529;
	Tue, 22 Oct 2024 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GxriNLJ1"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B715131E38
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575718; cv=none; b=EBa8mgdRbc2tK/IRsYySPyUCqrx6wQGMiyASJbZlJTUuSSs59wjvlYdZnEWvgxQcWbypuDm9jNtUJckrGELJszzG8l+pbDaQisnZ+u9NJfXtIerqa+n41wTtQpu9HIAAdshkokdLwtaOLh8faF5sIr936XIMrTfrVaoVdFxL+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575718; c=relaxed/simple;
	bh=HelJ7BuO5xeh+l1EGp4CUoROuW0RBAc9rXL7w+jlmho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cawRm9OHAUFQobMsjBclp45a1CqrUiiT65QXqNdQKr2LE82sUgSLjx+ppn2vQmxdYtH70tmnTTGFT+Fjh3XYV9a03omqSQtobG5Ic+iZcyzc3n/mFo83eVSVM7TYbeaJVgQI+pSetyvhDmjLsutBAHksRJpv+3uA6DSHNPhZYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GxriNLJ1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M2HFwM009345;
	Tue, 22 Oct 2024 05:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Jr7j4l
	WcAKT1zuz94zoLVIb8tWfpTVgo2z8674/TKoU=; b=GxriNLJ1tRmEfxN0FaQhgt
	ywJAHPMFKZ9U6ggfVMBBoz7OK/tBoHjaGurbWa0cn7WmcQ+y/E9YHtLHsQiMkmWQ
	b+BGtQmpZKi7Nn8LX0ckbp6y4BxOIndA2Ol8TscNky0YuRLYnpptqaPeoKqxib4l
	bNDHcYXAWhpXMwWfP/4oV33odd2UAvf1CwQ+iT00ASFX/5uzO+R9k0IKPwRraZkb
	kKz8qAcW5LN3f9epngu08PyKLTB/6vRHKbc+hFa/WN+M+D1hd+XwT4BXTZ+snQWq
	q1meGO9U8rDpHD23vkOtmw/UdENhkalj7oJE2c8TtomwrECJT2J7pu9ouxDL95tg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5hmd0pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 05:41:27 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49M5fQgd013969;
	Tue, 22 Oct 2024 05:41:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5hmd0pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 05:41:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49M4xW06009296;
	Tue, 22 Oct 2024 05:41:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42cr3mst7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 05:41:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49M5fNUZ54264224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 05:41:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A8D02004B;
	Tue, 22 Oct 2024 05:41:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E52B220040;
	Tue, 22 Oct 2024 05:41:19 +0000 (GMT)
Received: from [9.124.208.49] (unknown [9.124.208.49])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Oct 2024 05:41:19 +0000 (GMT)
Message-ID: <19a072e1-cfd8-43e1-9e8e-aa1950b20533@linux.ibm.com>
Date: Tue, 22 Oct 2024 11:11:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] sched: warn for high latency with
 TIF_NEED_RESCHED_LAZY
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
        efault@gmx.de
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-2-ankur.a.arora@oracle.com>
 <c8dd612a-1851-471f-b5c5-f4201593e7b0@linux.ibm.com>
 <87iktli7o6.fsf@oracle.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <87iktli7o6.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: usf6-aVYRlsWImRD6O-ARk41k-Uy-5y1
X-Proofpoint-GUID: iEgEjaitKUNbnWhJGrjzIRJDkU4aAHXV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220035



On 10/22/24 00:51, Ankur Arora wrote:
> 
> Shrikanth Hegde <sshegde@linux.ibm.com> writes:
> 
>> On 10/9/24 22:24, Ankur Arora wrote:
>>> resched_latency_warn() now also warns if TIF_NEED_RESCHED_LAZY is set
>>> without rescheduling for more than the latency_warn_ms period.
>>>
>>
>> I am bit confused here. Why do we need to warn if LAZY is set for a long time?
>>
>> If lazy set, the subsequent tick, it would be set to upgraded to NEED_RESCHED.
>>
>> Since the value of latency_warn_ms=100ms, that means even on system with HZ=100,
>> that means 10 ticks before that warning would be printed no?
> 
> That's a fair point. However, the assumption there is that there are no
> bugs in upgrade on tick or that there's no situation in which the tick
> is off for a prolonged period.
> 

ok.

But if tick is off, then ticks_without_resched isn't incremented either. 
IIUC, this check is for situation when NR is set and tick is on.

> Ankur
> 
>> IIUC, the changelog c006fac556e40 ("sched: Warn on long periods of pending
>> need_resched") has the concern of need_resched set but if it is non-preemptible
>> kernel it would spend a lot of time in kernel mode. In that case print a
>> warning.
>>
>> If someone enables Lazy, that means it is preemptible and probably this whole
>> notion of resched_latency_warn doesn't apply to lazy. Please correct me if i am
>> not understanding this correctly.
>>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Peter Ziljstra <peterz@infradead.org>
>>> Cc: Juri Lelli <juri.lelli@redhat.com>
>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>> ---
>>>    kernel/sched/core.c  | 2 +-
>>>    kernel/sched/debug.c | 7 +++++--
>>>    2 files changed, 6 insertions(+), 3 deletions(-)
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 694bfcf153cb..1229766b704e 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -5571,7 +5571,7 @@ static u64 cpu_resched_latency(struct rq *rq)
>>>    	if (sysctl_resched_latency_warn_once && warned_once)
>>>    		return 0;
>>>    -	if (!need_resched() || !latency_warn_ms)
>>> +	if ((!need_resched() && !tif_need_resched_lazy()) || !latency_warn_ms)
>>>    		return 0;
>>>      	if (system_state == SYSTEM_BOOTING)
>>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>>> index 9abcc6ead11b..f0d551ba64bb 100644
>>> --- a/kernel/sched/debug.c
>>> +++ b/kernel/sched/debug.c
>>> @@ -1293,9 +1293,12 @@ void proc_sched_set_task(struct task_struct *p)
>>>    void resched_latency_warn(int cpu, u64 latency)
>>>    {
>>>    	static DEFINE_RATELIMIT_STATE(latency_check_ratelimit, 60 * 60 * HZ, 1);
>>> +	char *nr;
>>> +
>>> +	nr = tif_need_resched() ? "need_resched" : "need_resched_lazy";
>>>      	WARN(__ratelimit(&latency_check_ratelimit),
>>> -	     "sched: CPU %d need_resched set for > %llu ns (%d ticks) "
>>> +	     "sched: CPU %d %s set for > %llu ns (%d ticks) "
>>>    	     "without schedule\n",
>>> -	     cpu, latency, cpu_rq(cpu)->ticks_without_resched);
>>> +	     cpu, nr, latency, cpu_rq(cpu)->ticks_without_resched);
>>>    }
> 
> 
> --
> ankur


