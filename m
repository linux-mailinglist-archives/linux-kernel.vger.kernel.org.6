Return-Path: <linux-kernel+bounces-226578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BD891408E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521571F23592
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9764C97;
	Mon, 24 Jun 2024 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SI1LYvbm"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE14A2D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719196559; cv=none; b=nbvGbLbpzTYYbcoulJi0gITvCBiCNUs2h53/w22nDxwyNqovEv0xLgC3HvHwiFWXOyN9zaa9PaT6fNH2doDzhmH4s6QVJdzLI4MTqvYXiNY/Bke3teL+AjrSHF3brGzk6CyAIUBZJJB7KDZBcxSSuWj6OLq31aYSh13fL6cfqDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719196559; c=relaxed/simple;
	bh=Yz/lCxxxxoFA9QnCVT2EvlDlUZ4YvLC6CQ3eNeHqRvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqu42hkRlEzthRqJ2NInmR/H1DWJHYLbkBTGViF5bRgLYsMOdMePYJrQEHNs8LN02OSO7JUtlRDgtiMP4tMk+cShiQbvMorgVOySTkUB0cSM7LaOCBko2uQnvNJbRyPWSYxiN8Ld3j6RyRsNbsyXZCRzWs9+WBZ4+ZFvxrbwUjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SI1LYvbm; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719196548; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MkFxE/rtIPTdOvyHQREWAUOuP0YCioTrW98F+FyCA3U=;
	b=SI1LYvbmGRnSvhbNaqAZ+QL/KCMto7VHN+iWRXwKJBdtH9x+XnlVOG6r6t6LZw/aVB9SZIHtkY+C8XNzkcbB/Cp6m/aIhy7g4YFhJA+KXQzRWWZuqTjTJe4RToBoejTzNLrrX0xo9dxUS/hwGgK2a7w4CVFNdhMVbNl/sprRkno=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W90zdNb_1719196544;
Received: from 30.97.48.223(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W90zdNb_1719196544)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 10:35:46 +0800
Message-ID: <dd6c29cf-3ca0-4aa3-8cfe-e85a35e300e4@linux.alibaba.com>
Date: Mon, 24 Jun 2024 10:35:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/35] sched: handle preempt=voluntary under
 PREEMPT_AUTO
Content-Language: en-US
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
 juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
 sshegde@linux.ibm.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-30-ankur.a.arora@oracle.com>
 <8e6f02a0-2bd0-4e75-9055-2cb7c508ce4e@linux.alibaba.com>
 <87h6dmazs5.fsf@oracle.com>
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <87h6dmazs5.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/22 02:58, Ankur Arora wrote:
> 
> Tianchen Ding <dtcccc@linux.alibaba.com> writes:
> 
>> On 2024/5/28 08:35, Ankur Arora wrote:
>>> The default preemption policy for voluntary preemption under
>>> PREEMPT_AUTO is to schedule eagerly for tasks of higher scheduling
>>> class, and lazily for well-behaved, non-idle tasks.
>>> This is the same policy as preempt=none, with an eager handling of
>>> higher priority scheduling classes.
>>> Comparing a cyclictest workload with a background kernel load of
>>> 'stress-ng --mmap', shows that both the average and the maximum
>>> latencies improve:
>>>    # stress-ng --mmap 0 &
>>>    # cyclictest --mlockall --smp --priority=80 --interval=200 --distance=0 -q -D 300
>>>                                        Min     (  %stdev )    Act     (  %stdev
>>> )   Avg     (  %stdev )   Max      (  %stdev )
>>>     PREEMPT_AUTO, preempt=voluntary    1.73  ( +-  25.43% )   62.16 ( +-
>>> 303.39% )  14.92 ( +-  17.96% )  2778.22 ( +-  15.04% )
>>>     PREEMPT_DYNAMIC, preempt=voluntary 1.83  ( +-  20.76% )  253.45 ( +- 233.21% )  18.70 ( +-  15.88% )  2992.45 ( +-  15.95% )
>>> The table above shows the aggregated latencies across all CPUs.
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Peter Ziljstra <peterz@infradead.org>
>>> Cc: Juri Lelli <juri.lelli@redhat.com>
>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>>> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>> ---
>>>    kernel/sched/core.c  | 12 ++++++++----
>>>    kernel/sched/sched.h |  6 ++++++
>>>    2 files changed, 14 insertions(+), 4 deletions(-)
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index c25cccc09b65..2bc3ae21a9d0 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -1052,6 +1052,9 @@ static resched_t resched_opt_translate(struct task_struct *curr,
>>>    	if (preempt_model_preemptible())
>>>    		return RESCHED_NOW;
>>>    +	if (preempt_model_voluntary() && opt == RESCHED_PRIORITY)
>>> +		return RESCHED_NOW;
>>> +
>>>    	if (is_idle_task(curr))
>>>    		return RESCHED_NOW;
>>>    @@ -2289,7 +2292,7 @@ void wakeup_preempt(struct rq *rq, struct task_struct
>>> *p, int flags)
>>>    	if (p->sched_class == rq->curr->sched_class)
>>>    		rq->curr->sched_class->wakeup_preempt(rq, p, flags);
>>>    	else if (sched_class_above(p->sched_class, rq->curr->sched_class))
>>> -		resched_curr(rq);
>>> +		resched_curr_priority(rq);
>>>
>> Besides the conditions about higher class, can we do resched_curr_priority() in the same class?
>> For example, in fair class, we can do it when SCHED_NORMAL vs SCHED_IDLE.
> 
> So, I agree about the specific case of SCHED_NORMAL vs SCHED_IDLE.
> (And, that case is already handled by resched_opt_translate() explicitly
> promoting idle tasks to TIF_NEED_RESCHED.)
> 
> But, on the general question of doing resched_curr_priority() in the
> same class: I did consider it. But, it seemed to me that we want to
> keep run to completion semantics for lazy scheduling, and so not
> enforcing priority in a scheduling class was a good line.
> 

OK, on general question, this is just a suggestion :-)

Actually, my key point is about SCHED_IDLE. It's not a real idle task, but a 
normal task with lowest priority. So is_idle_task() in resched_opt_translate() 
does not fit it. Should add task_has_idle_policy().

However, even using task_has_idle_policy() may be still not enough. Because 
SCHED_IDLE policy:
   1. It is the lowest priority, but still belongs to fair_sched_class, which is 
the same as SCHED_NORMAL.
   2. Not only tasks, *se of cgroup* can be SCHED_IDLE, too. (introduced by 
commit 304000390f88d)

So in the special case about SCHED_NORMAL vs SCHED_IDLE, I suggest still do some 
work in fair.c.

Thanks.

