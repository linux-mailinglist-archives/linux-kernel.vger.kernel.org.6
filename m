Return-Path: <linux-kernel+bounces-245940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A37C92BB9B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3308283776
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3C115E5B8;
	Tue,  9 Jul 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BVPvs3PL"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2472A156862
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532554; cv=none; b=bfjWzfizWe5lVoHEdlKo/lGbsriHg8VhyYSlvRX/YykUrGB1YOXI/EzUhiacFVZIjeE0WaYqQlJmi1oi+3LxA/x1lsNNdVemL8KJcVJqMqmEH1GreCnVfbCJMrRz94qKLRD2higZk+8XQSfgvTl9Z4F9HN4cMCe95fGNU92ejsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532554; c=relaxed/simple;
	bh=EspSogR5zp6eFKslARKjMPxGzUG2nbAc6Ltmy2Img4M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mYGHJne6c5I6o7Y6RfGnDC7wRwYW6BnBXGVJLptefwM6cIs8bKWdXq1Ii3YP+ToahUQQ3P33/fWDFzV81yGIX7XFuDf4YxixylGjPG+ndjWLTgn36im2YX2AqkTE90WDj5V0HjXjhv0OjaeDnNqntjB1aep50uHyNDOlVqQXzCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BVPvs3PL; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720532549; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=Ntjs7JCwe7wJBINcbmRne+37UCjn2+nGAvSYhrixaLQ=;
	b=BVPvs3PLkeH9ugx5/zFsabHSzhAwZWu2mpSfb4ZLJOxq5aO+nCBVjjqkLmRsaLJiDrxNnKCKt5+1idtgdgUQlMYnNPMR3jvUJLCvEFcc/OP1d5KkHL1DxzUGRepYwMF/hSoQvMBa1SFXlFGrRyznfcUwESJE8H41Y7gzazTISXw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0WAC8-g5_1720532546;
Received: from 30.212.157.16(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WAC8-g5_1720532546)
          by smtp.aliyun-inc.com;
          Tue, 09 Jul 2024 21:42:28 +0800
Message-ID: <eab4db35-9cd2-4348-b41c-ea6176583ef4@linux.alibaba.com>
Date: Tue, 9 Jul 2024 21:42:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tianchen Ding <dtcccc@linux.alibaba.com>
Subject: Re: [PATCH v2] sched/fair: Make SCHED_IDLE entity be preempted in
 strict hierarchy
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Josh Don <joshdon@google.com>, Vincent Guittot <vincent.guittot@linaro.org>
References: <20240626023505.1332596-1-dtcccc@linux.alibaba.com>
 <20240708120254.GA27299@noisy.programming.kicks-ass.net>
 <CAKfTPtDxdLpm6cC-vv1PpHaEtiOeLtuCwChgZ6Ypg6owz3Vvsw@mail.gmail.com>
 <20240708142832.GB27299@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20240708142832.GB27299@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/8 22:28, Peter Zijlstra wrote:
> On Mon, Jul 08, 2024 at 02:47:34PM +0200, Vincent Guittot wrote:
>> On Mon, 8 Jul 2024 at 14:02, Peter Zijlstra <peterz@infradead.org> wrote:
> 
>>>> @@ -8409,6 +8400,15 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>>>>        if (cse_is_idle != pse_is_idle)
>>>>                return;
>>>>
>>>> +     /*
>>>> +      * Batch tasks do not preempt non-idle tasks (their preemption
>>>> +      * is driven by the tick).
>>>> +      * We've done the check about "only one of the entities is idle",
>>>> +      * so cse must be non-idle if p is a batch task.
>>>> +      */
>>>> +     if (unlikely(entity_is_task(pse) && p->policy == SCHED_BATCH))
>>>> +             return;
>>>
>>> I'm not convinced this condition is right. The current behaviour of
>>> SCHED_BATCH doesn't care about pse, only p.
>>>
>>> That is, if p is SCHED_BATCH it will not preempt -- except an
>>> SCHED_IDLE.
>>>
>>> So I'm tempted to delete this first part of your condition and have it
>>> be:
>>>
>>>          if (p->policy == SCHED_BATCH)
>>>                  return;
>>>
>>> That is, suppose you have:
>>>
>>>                          root
>>>                           |
>>>                ------------------------
>>>                |                      |
>>>          normal_cgroup          normal_cgroup
>>>                |                      |
>>>          SCHED_BATCH task_A     SCHED_BATCH task_B
>>>
>>> Then the preemption crud will end up comparing the groups to one another
>>> and still allow A to preempt B -- except we explicitly do not want this.
>>>
>>> The 'problem' is that the whole BATCH thing isn't cgroup aware ofcourse,

Agree.

>>> but I'm not sure we want to go fix that -- esp. not in this patch.
>>>
>>> Hmm?
>>
>> Good question, but do we want to make SCHED_BATCH tasks behave
>> differently than SCHED_IDLE tasks in a group in this case ?
> 
> I suspect we'll have to. People added the idle-cgroup thing, but never
> did the same for batch. With the result that they're now fundamentally
> different.
> 
>> With this patch, we don't want task_B to preempt task_A for the case
>> but task_A will preempt task_B whereas task A is SCHED_IDLE
>>
>>                           root
>>                            |
>>                 ------------------------
>>                 |                      |
>>           normal_cgroup          idle_cgroup
>>                 |                      |
>>           SCHED_IDLE task_A     SCHED_NORMAL task_B
>>
>> As we only look at the common level of hierarchy between the tasks,
>> the below will make A to preempt B whereas both are SCHED_IDLE
>>
>>                           root
>>                            |
>>                 ------------------------
>>                 |                      |
>>           normal_cgroup          normal_cgroup
>>                 |                      |
>>           SCHED_IDLE task_A     SCHED_IDLE task_B
> 
> So we can make the last test be:
> 
> 	if (unlikely(p->policy != SCHED_NORMAL))
> 		return;
> 
> Much like the original condition removed here:
> 
> -       if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
> +       if (!sched_feat(WAKEUP_PREEMPTION))
> 
> Except now after all that cgroup nonsense. Then the OP case will preempt
> because normal_cgroup vs idle_cgroup, my BATCH example will not preempt,
> because BATCH != NORMAL, your IDLE example will not preempt either,
> because IDLE != NORMAL.
> 

So there may be 2 interesting issues. Let's take the example of:

                            root
                             |
                  ------------------------
                  |                      |
            normal_cgroup          normal_cgroup
                  |                      |
            SCHED_IDLE task_A     SCHED_IDLE task_B


The first issue is the scope of task policy. My original proposal is to only 
compare the common level of hierarchy (pse and cse), and ignore all their 
children. So that the scope of task policy will be limited within its own 
cgroup, and A may preempt B.

However, If we simply check

         if (p->policy == SCHED_BATCH)
                 return;

or

  	if (p->policy != SCHED_NORMAL)
  		return;

Then the scope of task policy will "overflow" and take effect "across" the 
cgroups. So A will not preempt B.

I don't know which one is better, and both are reasonable and acceptable for me.


The second issue is about SCHED_BATCH. Now let's make task_A be SCHED_BATCH.

In vanilla kernel, A will preempt B because "Idle tasks are by definition 
preempted by non-idle tasks."

However, with my original patch, A may preempt B. (depending on pse and cse)

With your modification, A will not preempt B.

Again, which one should be preferred?

Thanks.

