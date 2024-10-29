Return-Path: <linux-kernel+bounces-387521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DAB9B5248
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686291F21461
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB04205E2D;
	Tue, 29 Oct 2024 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tupS9+wn"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64158205142
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228371; cv=none; b=PDmhC4ftP6jx24IAt21d16ieuggkgs4TJF7KxhL5QpSxfGKDUvmzSAH+LjUvAyCy8/brbFvqEzMAFirB+GrREoKqnCPe0ya0sNTEtD/nH0Kqv/LZP4soCChZfh7mbv1GnShkboux6RJ9a98caSfUSnVzi7WD4l4My3L5v9wC2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228371; c=relaxed/simple;
	bh=EC1W0Hb3ftu/MQ3s2LErqBWwUtBPgyarsmvuSNvy75I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7DCAHbzAGUe18wpmV9vuyTSimLW1Zy20vLA+uUpbsKpuZDCSia6ytMLS7HGAZ4qrz2DqrRABlz0qgXA8OXzBPNZjr4waXLxsDl/NzMhDy1h/yFTdqkn7nrShqOOjbL3pVT8ooH9TWyf398hzGPIIG39xRjkges+82IdnpCke60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tupS9+wn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TFlxCt023296;
	Tue, 29 Oct 2024 18:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Fvbt/8
	vyt27ze/hQ5Fu23EsHBwrSHE4HpbcyfuwJwfY=; b=tupS9+wn1rVr/h5wzokjpq
	Ikb5k5SgZZvdwKTJrLdoQTVK627zcTUJDHhZ4g2rRhqk52IVoBPBJk3OmErTpbI7
	vIKjnzpGssIK/RJAvehB8BMUtRSXkI31fUqxHQdQLIBoHPzRaPyr+k938Jp1n/hz
	y/A5oz3g1AtaQkESTPr4Vh64eLXsd7U3cNEal81LjhOGHbT7vbwnUSq1LwfYVfW5
	jlLV0tUjar5M+yHncQ/AIOykKCLmoH9bM/F7zI+m9Dvsi+apUvuBZH+RKss+byTR
	CdVEzPG89KcEHcTGwVQp93/x29I9JL5L3ZYRra9jQ+bsETWwRAkPL3Z8WxZDc5TA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j43g2khx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 18:57:35 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49TIvYJs030703;
	Tue, 29 Oct 2024 18:57:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j43g2khr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 18:57:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49THexuD028170;
	Tue, 29 Oct 2024 18:57:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hb4xvkdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 18:57:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49TIvVA348562492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 18:57:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11DA820043;
	Tue, 29 Oct 2024 18:57:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14D7220040;
	Tue, 29 Oct 2024 18:57:28 +0000 (GMT)
Received: from [9.124.209.192] (unknown [9.124.209.192])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Oct 2024 18:57:27 +0000 (GMT)
Message-ID: <db8b8b80-2e40-4753-ae6f-244cd3ba2312@linux.ibm.com>
Date: Wed, 30 Oct 2024 00:27:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] sched: Add Lazy preemption model
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
        efault@gmx.de, tglx@linutronix.de, mingo@kernel.org
References: <20241007074609.447006177@infradead.org>
 <20241007075055.331243614@infradead.org>
 <e334aff9-248c-4a00-98e1-7bcb7cdd5e90@linux.ibm.com>
 <20241025131930.cVOckvQQ@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20241025131930.cVOckvQQ@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LSzjYbC_hMCiYqh5k8HBxmNrgTulQjm0
X-Proofpoint-ORIG-GUID: jrxJsRTEyLDuXj3h1IlGQiEvCZG9PzO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 adultscore=0 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410290139


Hi Sebastian.

On 10/25/24 18:49, Sebastian Andrzej Siewior wrote:
> On 2024-10-22 22:14:41 [+0530], Shrikanth Hegde wrote:
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -1251,7 +1251,7 @@ static void update_curr(struct cfs_rq *c
>>>    		return;
>>>    	if (resched || did_preempt_short(cfs_rq, curr)) {
>>
>>
>>
>> If there is a long running task, only after it is not eligible, LAZY would be set and
>> subsequent tick would upgrade it to NR. If one sets sysctl_sched_base_slice to a large
>> value (max 4seconds), LAZY would set thereafter(max 4 seconds) if there in no wakeup in
>> that CPU.
>>
>> If i set sysctl_sched_base_slice=300ms, spawn 2 stress-ng on one CPU, then LAZY bit is
>> set usually after 300ms of sched_switch if there are no wakeups. Subsequent tick NR is set.
>> Initially I was thinking, if there is a long running process, then LAZY would be set after
>> one tick and on subsequent tick NR would set. I was wrong. It might take a long time for LAZY
>> to be set, and On subsequent tick NR would be set.
>>
>> That would be expected behavior since one setting sysctl_sched_base_slice know what to expect?
> 
> I guess so. Once the slice is up then the NEED_RESCHED bit is replaced
> with the LAZY bit. That means a return-to-userland (from a syscall) or
> the following tick will lead to a scheduling event.

ok.

> 
>>> -		resched_curr(rq);
>>> +		resched_curr_lazy(rq);
>>>    		clear_buddies(cfs_rq, curr);
>>>    	}
>>>    }
>>> @@ -5677,7 +5677,7 @@ entity_tick(struct cfs_rq *cfs_rq, struc
>>>    	 * validating it and just reschedule.
>>>    	 */
>>>    	if (queued) {
>>
>> What's this queued used for? hrtick seems to set it. I haven't understood how it works.
> 
> from 20241009074631.GH17263@noisy.programming.kicks-ass.net:
> | hrtick is disabled by default (because expensive) and so it doesn't
> | matter much, but it's purpose is to increase accuracy and hence I left
> | it untouched for now.
> 
> This setups a hrtimer for the (remaining) time slice and invokes the
> task_tick from there (instead of the regular tick).

thanks. will take a look and try to understand.

> 
>>> -		resched_curr(rq_of(cfs_rq));
>>> +		resched_curr_lazy(rq_of(cfs_rq));
>>>    		return;
>>>    	}
>>>    	/*
>>> @@ -8832,7 +8832,7 @@ static void check_preempt_wakeup_fair(st
>>>    	return;
>>>    preempt:
>>> -	resched_curr(rq);
>>
>> Is it better to call resched_curr here? When the code arrives here, it wants to
>> run pse as soon as possible right?
> 
> But wouldn't then every try_to_wakeup()/ wake_up() result in immediate
> preemption? Letting it run and waiting to give up on its own, having the
> preemption on return to userland results usually in better performance.
> At least this is what I observed while playing with this.
> 

yes. I agree that preemption at every ttwu is bad. But that may not 
happen with latest code. i.e if RUN_TO_PARITY is enabled or pick_eevdf 
doesn't pick the waiting task as the best candidate.

My concern was also this code in check_preempt_wakeup_fair
         /*
          * Preempt an idle entity in favor of a non-idle entity (and 
don't preempt
          * in the inverse case).
          */
         if (cse_is_idle && !pse_is_idle)
                 goto preempt;
         if (cse_is_idle != pse_is_idle)
                 return;

If the current is idle and waking is not idle, we should set NR instead 
of LAZY is what I was thinking. Not sure if there is such pattern that 
happen in exit to kernel path, since exit to user is taken care by 
setting LAZY bit.


>>> +	resched_curr_lazy(rq);
>>>    }
>>>    static struct task_struct *pick_task_fair(struct rq *rq)
> 
> Sebastian


