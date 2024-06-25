Return-Path: <linux-kernel+bounces-228673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA96916541
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D246228412D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E7514A0BC;
	Tue, 25 Jun 2024 10:30:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E882572
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311430; cv=none; b=Nyrfhsq8XlBZ0pWG0rr3ehDwxTatExMK1mIFaC28BF7qQyoyWBxEgTpYDSM+2RBYXEJRIYJKabdJEU9NLhyK5Vp/YH702uK1GYrNQvA3GoMzYEsCE54dXFJYuxMg7qm7uiHI7c0hlBtQTXa4aInNbOItJJVbH0VW8zellEEEXsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311430; c=relaxed/simple;
	bh=RG7i8BbS3oLExfzZPoEqd4sruJk/PQYW68eT2gc3ry0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QT7WikFzwKOSGEzxHF8KQMWjARuzpq5zWb6dFY6ti79A9AWdKhadbNtTeYxuat6GwKExPf0WT/clRjbfjHOp4+7kYrOWt6bl3cobsO+tmz7c4sKv4R4Ep+psxrs5PPxkE0yXDcaXzA6HHlC1yuycOoVQAnB/nHhA2f5oNJBHjuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA50B339;
	Tue, 25 Jun 2024 03:30:50 -0700 (PDT)
Received: from [10.1.25.77] (e133649.arm.com [10.1.25.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66C473F766;
	Tue, 25 Jun 2024 03:30:22 -0700 (PDT)
Message-ID: <40c984f3-289d-4f8a-b06a-57052dad565e@arm.com>
Date: Tue, 25 Jun 2024 11:30:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] Propagate negative bias
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Qais Yousef <qyousef@layalina.io>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Youssef Esmat <youssefesmat@google.com>, linux-kernel@vger.kernel.org
References: <cover.1719223916.git.hongyan.xia2@arm.com>
 <60985d07acd8a2daf4f3adf31ce4bf3be2982306.1719223916.git.hongyan.xia2@arm.com>
 <0aa84916-bf29-2207-e0b4-a99fefba5a2e@amd.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <0aa84916-bf29-2207-e0b4-a99fefba5a2e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Thanks for taking a look!

On 25/06/2024 05:48, K Prateek Nayak wrote:
> Hello Hongyan,
> 
> On 6/24/2024 3:53 PM, Hongyan Xia wrote:
>> Negative bias is interesting, because dequeuing such a task will
>> actually increase utilization.
>>
>> Solve by applying PELT decay to negative biases as well. This in fact
>> can be implemented easily with some math tricks.
>>
>> Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
>> ---
>>   kernel/sched/fair.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>>   kernel/sched/sched.h |  4 ++++
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 3bb077df52ae..d09af6abf464 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4878,6 +4878,45 @@ static inline unsigned long 
>> root_cfs_util_uclamp(struct rq *rq)
>>       return max(ret, 0L);
>>   }
>> +
>> +/*
>> + * Negative biases are tricky. If we remove them right away then 
>> dequeuing a
>> + * uclamp_max task has the interesting effect that dequeuing results 
>> in a higher
>> + * rq utilization. Solve this by applying PELT decay to the bias itself.
>> + *
>> + * Keeping track of a PELT-decayed negative bias is extra overhead. 
>> However, we
>> + * observe this interesting math property, where y is the decay 
>> factor and p is
>> + * the number of periods elapsed:
>> + *
>> + *    util_new = util_old * y^p - neg_bias * y^p
>> + *         = (util_old - neg_bias) * y^p
>> + *
>> + * Therefore, we simply subtract the negative bias from util_avg the 
>> moment we
>> + * dequeue, then the PELT signal itself is the total of util_avg and 
>> the decayed
>> + * negative bias, and we no longer need to track the decayed bias 
>> separately.
>> + */
>> +static void propagate_negative_bias(struct task_struct *p)
>> +{
>> +    if (task_util_bias(p) < 0 && !task_on_rq_migrating(p)) {
>> +        unsigned long neg_bias = -task_util_bias(p);
>> +        struct sched_entity *se = &p->se;
>> +        struct cfs_rq *cfs_rq;
>> +
>> +        p->se.avg.util_avg_bias = 0;
>> +
>> +        for_each_sched_entity(se) {
>> +            u32 divider, neg_sum;
>> +
>> +            cfs_rq = cfs_rq_of(se);
>> +            divider = get_pelt_divider(&cfs_rq->avg);
>> +            neg_sum = neg_bias * divider;
>> +            sub_positive(&se->avg.util_avg, neg_bias);
>> +            sub_positive(&se->avg.util_sum, neg_sum);
> 
> Most cases where I've seen "get_pelt_divider()" followed by
> "add_positive()" or "sub_positive()" on "util_avg" and "util_sum" I've
> seen a correction step that does:
> 
>      util_sum = max_t(u32, util_sum, util_avg * PELT_MIN_DIVIDER)
> 
> There is a comment on its significance in "update_cfs_rq_load_avg()".
> Would it also apply in this case?
> 

That's a good point. The problem in update_cfs_rq_load_avg() should also 
be possible here. I can add the guard logic in the next rev.

But if we change the code in a way suggested below, then this problem is 
solved anyway.

>> +            sub_positive(&cfs_rq->avg.util_avg, neg_bias);
>> +            sub_positive(&cfs_rq->avg.util_sum, neg_sum);
>> +        }
>> +    }
>> +}
>>   #else
>>   static inline long task_util_bias(struct task_struct *p)
>>   {
>> @@ -6869,6 +6908,7 @@ static void dequeue_task_fair(struct rq *rq, 
>> struct task_struct *p, int flags)
>>       /* At this point se is NULL and we are at root level*/
>>       sub_nr_running(rq, 1);
>>       util_bias_dequeue(rq, p);
>> +    propagate_negative_bias(p);
> 
> Perhaps I'm pointing to a premature optimization but since the hierarchy
> is traversed above in "dequeue_task_fair()", could the "neg_bias" and
> "neg_sum" removal be done along the way above instead of
> "propagate_negative_bias()" traversing the hierarchy again? I don't see
> a dependency on "util_bias_dequeue()" (which modifies
> "rq->cfs.avg.util_avg_bias") for "propagate_negative_bias()" (which
> works purely with task_util_bias() or "p->se.avg.util_avg_bias") but if
> I'm missing something please do let me know.
> 
> Since you mentioned this patch isn't strictly necessary in the cover
> letter, I would wait for other folks to chime in before changing this :)

I've been thinking about similar things for both enqueue() and 
dequeue(). Currently this series makes util_avg_bias completely separate 
from util_avg to ease review, acting more like util_est, but like you 
said we do things twice in a couple of places.

enqueue_task_fair():
	for_each_sched_entity()
		enqueue_entity()
			if root_cfs()
				cpufreq_update_util()
	util_bias_enqueue(p)
	cpufreq_update_util()  // duplicate cpufreq update

dequeue_task_fair():
	for_each_sched_entity()
		dequeue_entity()
			if root_cfs()
				cpufreq_update_util()
	util_bias_dequeue(p)
	propagate_negative_bias() // duplicate tree traversal
	cpufreq_update_util()  // duplicate cpufreq update

But we can integrate the bias closer into the hierarchy, like this:

enqueue_task_fair():
	for_each_sched_entity()
		enqueue_entity()
			if (entity_is_task())
				util_bias_enqueue(p)
			if root_cfs()
				// No duplicate cpufreq updates
				cpufreq_update_util()

dequeue_task_fair():
	for_each_sched_entity()
		dequeue_entity()
			if (entity_is_task())
				util_bias_dequeue(p)
				// No need to traverse twice.
				propagate_negative_bias(p)
			if root_cfs()
				// No duplicate cpufreq updates
				cpufreq_update_util()

This new structure will address both of your concerns.

>>       /* balance early to pull high priority tasks */
>>       if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
>> [..snip..]
> 

