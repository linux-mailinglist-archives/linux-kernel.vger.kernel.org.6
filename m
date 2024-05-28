Return-Path: <linux-kernel+bounces-192150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264C78D1924
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD631F23409
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D1516C455;
	Tue, 28 May 2024 11:09:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A302614373C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716894586; cv=none; b=uypY1nlUfClaZzXjgwNZSfYeoJVkGkIf5Q/hIyZv4n/UAnTtrdd5T5TNHA29tyj4X8zR7b7s9i6QsiGdjfWy6HGLubLfxTRFLb2i+aHw6bFpdVWySDBBGf3E53Gr1nCPxXhxepp9fo5Csjm8o6ZV+HgkrfJdnmR7O33zKREyVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716894586; c=relaxed/simple;
	bh=Mt1acxPCnyHW/P4KAXryAu1exCKvXb9y1yr3zEaDZ3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ip+Ij/Qv/PeUWdJHwOP+RmyrhkGBqw3qU27smJs9Lq65QBrRjFhdXaW+JBSNf9fYZH9TjG0edrD7by8/03dGnv9ft3TUDtw1h1g6AEB9FlNpUeaNyqPZXKg14ZNJPpGB6sp42RQVYuIwBrFf9qHMKhiBOeuXGfWk59e3ThqyDTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D324DA7;
	Tue, 28 May 2024 04:10:08 -0700 (PDT)
Received: from [10.1.36.57] (e133649.arm.com [10.1.36.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C21F93F762;
	Tue, 28 May 2024 04:09:40 -0700 (PDT)
Message-ID: <1b36141c-1ad7-4c34-b293-92003f473465@arm.com>
Date: Tue, 28 May 2024 12:09:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/6] sched/uclamp: Track a new util_avg_bias signal
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>, pierre.gondois@arm.com,
 linux-kernel@vger.kernel.org
References: <cover.1715082714.git.hongyan.xia2@arm.com>
 <2e43dc6b376ea6d785976a398b5d9ffe823cf35d.1715082714.git.hongyan.xia2@arm.com>
 <fdde3285-6d40-458d-84bd-3d7badc1e592@arm.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <fdde3285-6d40-458d-84bd-3d7badc1e592@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/05/2024 23:52, Dietmar Eggemann wrote:
> On 07/05/2024 14:50, Hongyan Xia wrote:
>> Add a util_avg_bias signal in sched_avg, which is obtained by:
>>
>> util_avg_bias = clamp(util_avg, uclamp_min, uclamp_max) - util_avg
>>
>> The task utilization after considering uclamp is;
>>
>> util_avg_uclamp = util_avg + util_avg_bias
>>
>> We then sum up all biases on the same rq and use the total bias to bias
>> the rq utilization. This is the core idea of uclamp sum aggregation. The
>> rq utilization will be
>>
>> rq_util_avg_uclamp = rq_util_avg + total_util_avg_bias
>>
>> Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
>> ---
>>   include/linux/sched.h |  4 +++-
>>   kernel/sched/debug.c  |  2 +-
>>   kernel/sched/fair.c   | 16 ++++++++++++++++
>>   kernel/sched/pelt.c   | 39 +++++++++++++++++++++++++++++++++++++++
>>   kernel/sched/sched.h  | 28 ++++++++++++++++++++++++++++
>>   5 files changed, 87 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index c75fd46506df..4ea4b8b30f54 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -476,8 +476,10 @@ struct sched_avg {
>>   	u32				period_contrib;
>>   	unsigned long			load_avg;
>>   	unsigned long			runnable_avg;
>> -	unsigned long			util_avg;
>> +	unsigned int			util_avg;
>> +	int				util_avg_bias;
>>   	unsigned int			util_est;
>> +	unsigned int			util_est_uclamp;
> 
> Looks like you only introduce uclamped util_est functions in 3/6. It's
> easy to grasp when data changes go together with new functions. Maybe
> introduce a specific util_est patch before 3/6 "Use util biases for
> utilization and frequency"?

Makes sense. I can do that in the next rev.

> 
>>   } ____cacheline_aligned;
>>   
>>   /*
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index 8d5d98a5834d..c4dadb740e96 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -682,7 +682,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
>>   			cfs_rq->avg.load_avg);
>>   	SEQ_printf(m, "  .%-30s: %lu\n", "runnable_avg",
>>   			cfs_rq->avg.runnable_avg);
>> -	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
>> +	SEQ_printf(m, "  .%-30s: %u\n", "util_avg",
>>   			cfs_rq->avg.util_avg);
>>   	SEQ_printf(m, "  .%-30s: %u\n", "util_est",
>>   			cfs_rq->avg.util_est);
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index ef5bb576ac65..571c8de59508 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1083,6 +1083,7 @@ void post_init_entity_util_avg(struct task_struct *p)
>>   	}
>>   
>>   	sa->runnable_avg = sa->util_avg;
>> +	sa->util_avg_bias = 0;
>>   }
>>   
>>   #else /* !CONFIG_SMP */
>> @@ -6801,6 +6802,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>   
>>   	/* At this point se is NULL and we are at root level*/
>>   	add_nr_running(rq, 1);
>> +	util_bias_enqueue(&rq->cfs.avg, p);
>> +	/* XXX: We should skip the update above and only do it once here. */
> 
> By 'above' you're referring to the update in enqueue_entity() ->
> update_load_avg(..., DO_ATTACH) -> attach_entity_load_avg() ->
> cfs_rq_util_change() ?
> 
> I assume you won't have the problem of having to add a
> cpufreq_update_util(rq, 0) call after the util_bias enqueue or dequeue
> with "[PATCH v4] sched: Consolidate cpufreq updates"
> https://lkml.kernel.org/r/20240516204802.846520-1-qyousef@layalina.io
> anymore?

Yes. That series would solve this problem nicely.

>> +	cpufreq_update_util(rq, 0);
>>   
>>   	/*
>>   	 * Since new tasks are assigned an initial util_avg equal to
>> @@ -6892,6 +6896,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>   
>>   	/* At this point se is NULL and we are at root level*/
>>   	sub_nr_running(rq, 1);
>> +	util_bias_dequeue(&rq->cfs.avg, p);
>> +	/* XXX: We should skip the update above and only do it once here. */
>> +	cpufreq_update_util(rq, 0);
>>   
>>   	/* balance early to pull high priority tasks */
>>   	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
>> @@ -6900,6 +6907,15 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>   dequeue_throttle:
>>   	util_est_update(&rq->cfs, p, task_sleep);
>>   	hrtick_update(rq);
>> +
>> +#ifdef CONFIG_UCLAMP_TASK
>> +	if (rq->cfs.h_nr_running == 0) {
>> +		WARN_ONCE(rq->cfs.avg.util_avg_bias,
>> +			"0 tasks on CFS of CPU %d, but util_avg_bias is %d\n",
>> +			rq->cpu, rq->cfs.avg.util_avg_bias);
>> +		WRITE_ONCE(rq->cfs.avg.util_avg_bias, 0);
>> +	}
>> +#endif
>>   }
>>   
>>   #ifdef CONFIG_SMP
>> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
>> index ef00382de595..56346988182f 100644
>> --- a/kernel/sched/pelt.c
>> +++ b/kernel/sched/pelt.c
>> @@ -266,6 +266,40 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
>>   	WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
>>   }
>>   
>> +#ifdef CONFIG_UCLAMP_TASK
>> +/* avg must belong to the queue this se is on. */
>> +static void update_util_bias(struct sched_avg *avg, struct task_struct *p)
> 
> You could pass a `struct rq *rq` here? I assume this code is already
> there to include rt-tasks (via per-entity load-tracking in rt class)?

The intention is definitely to make things easier for RT tasks later. We 
can do CFS like:

	update_util_bias(&rq->cfs.avg, p);

and then do RT like this:

	update_util_bias(&rq->avg_rt, p);

If the signature is update_util_bias(rq, p), then inside this function 
we need to condition on the type of p to know whether we want to fetch 
&rq->cfs.avg or &rq->avg_rt, and I think the former idea is simpler.

Unless if I misunderstood something?

>> +{
>> +	unsigned int util, uclamp_min, uclamp_max;
>> +	int old, new;
>> +
>> +	/*
>> +	 * We MUST update the rq summed total every time we update the
>> +	 * util_avg_bias of a task. If we are on a rq but we are not given the
>> +	 * rq, then the best thing is to just skip this update.
>> +	 */
>> +	if (p->se.on_rq && !avg)
>> +		return;
>> +
>> +	util = READ_ONCE(p->se.avg.util_avg);
>> +	uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
>> +	uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
>> +	if (uclamp_max == SCHED_CAPACITY_SCALE)
>> +		uclamp_max = UINT_MAX;
> 
> This is done to not cap a task util_avg > 1024 in case the task has
> default uclamp_max?

Yes. In some corner cases you can end up with util_avg > 1024. If the 
task has the default uclamp_max of 1024, it certainly doesn't mean we 
want to have a negative bias here.

I can add some comments.

>> +	old = READ_ONCE(p->se.avg.util_avg_bias);
>> +	new = (int)clamp(util, uclamp_min, uclamp_max) - (int)util;
>> +
>> +	WRITE_ONCE(p->se.avg.util_avg_bias, new);
>> +	if (!p->se.on_rq)
>> +		return;
>> +	WRITE_ONCE(avg->util_avg_bias, READ_ONCE(avg->util_avg_bias) + new - old);
>> +}
>> +#else /* !CONFIG_UCLAMP_TASK */
>> +static void update_util_bias(struct sched_avg *avg, struct task_struct *p)
>> +{
>> +}
>> +#endif
>> +
>>   /*
>>    * sched_entity:
>>    *
>> @@ -296,6 +330,8 @@ int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
>>   {
>>   	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
>>   		___update_load_avg(&se->avg, se_weight(se));
>> +		if (entity_is_task(se))
>> +			update_util_bias(NULL, task_of(se));
> 
> IMHO,
> 
> update_util_bias(struct sched_avg *avg, struct sched_entity *se)
> 
>      if (!entity_is_task(se))
>          return;
> 
>      ...
> 
> would be easier to read.

Yeah, that would work, and might be a good way to prepare for group 
clamping if it ever becomes a thing.

>>   		trace_pelt_se_tp(se);
>>   		return 1;
>>   	}
>> @@ -310,6 +346,9 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
>>   
>>   		___update_load_avg(&se->avg, se_weight(se));
>>   		cfs_se_util_change(&se->avg);
>> +		if (entity_is_task(se))
>> +			update_util_bias(&rq_of(cfs_rq)->cfs.avg,
>> +					 task_of(se));
>>   		trace_pelt_se_tp(se);
>>   		return 1;
>>   	}
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index cb3792c04eea..aec812e6c6ba 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -3095,6 +3095,24 @@ static inline bool uclamp_is_used(void)
>>   {
>>   	return static_branch_likely(&sched_uclamp_used);
>>   }
>> +
>> +static inline void util_bias_enqueue(struct sched_avg *avg,
>> +				     struct task_struct *p)
>> +{
>> +	int avg_val = READ_ONCE(avg->util_avg_bias);
>> +	int p_val = READ_ONCE(p->se.avg.util_avg_bias);
>> +
>> +	WRITE_ONCE(avg->util_avg_bias, avg_val + p_val);
>> +}
>> +
>> +static inline void util_bias_dequeue(struct sched_avg *avg,
>> +				     struct task_struct *p)
>> +{
>> +	int avg_val = READ_ONCE(avg->util_avg_bias);
>> +	int p_val = READ_ONCE(p->se.avg.util_avg_bias);
>> +
>> +	WRITE_ONCE(avg->util_avg_bias, avg_val - p_val);
>> +}
> 
> Maybe enqueue_util_bias() and dequeue_util_bias() since there is the
> related update_util_bias()? I know that there is util_est_enqueue() but
> util_est also has util_est_update().

I don't have much of a strong preference here, so either works for me.

> [...]

