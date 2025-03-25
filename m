Return-Path: <linux-kernel+bounces-575190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294F3A6F0F9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B72F169E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D471EF0AE;
	Tue, 25 Mar 2025 11:16:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA6016A395
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901374; cv=none; b=ltfFehE77KKkMzMB/cE9zvL3J5n/sk8zx1dVjfyPZSR69pnCKCVc/wQM0EExz3XEeBmz93F1Z0VxxxbpIDXISxCVF40cCwfW/hNIy6hIK7+9DY5kTGG4Cl16w+fyAJbytaA7YsL4YTEs/pdzoMjRR/SX5EST8SHD5j2CndrQlw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901374; c=relaxed/simple;
	bh=YWVQ6PM10pQEwods3bxAs0yE58TK/G7E2yvIn/gqjXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+7Iiy9hqVqe/jZ0vSjsVvduA3QyivOsherbbubknfHKmMAKNWa0NF+dbIyXN1BkBenCRQ6zsV+99vP+3ilBXCAjCdZrxKe3EGC2tvc0z2VN7jsTYUfcvsHy+gn2V1FEy7+P0OQgXkKBJxIUSX2KdyPokGlIMpnFB2K70uAOl+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ACA91756;
	Tue, 25 Mar 2025 04:16:18 -0700 (PDT)
Received: from [10.57.41.137] (unknown [10.57.41.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C5163F58B;
	Tue, 25 Mar 2025 04:16:08 -0700 (PDT)
Message-ID: <b19a857c-4c01-471b-94be-c465de636cd9@arm.com>
Date: Tue, 25 Mar 2025 11:16:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7 v5] sched/fair: Add push task mechanism for EAS
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, lukasz.luba@arm.com, rafael.j.wysocki@intel.com,
 pierre.gondois@arm.com, linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io, hongyan.xia2@arm.com, luis.machado@arm.com,
 qperret@google.com
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
 <20250302210539.1563190-6-vincent.guittot@linaro.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250302210539.1563190-6-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/25 21:05, Vincent Guittot wrote:
> EAS is based on wakeup events to efficiently place tasks on the system, but
> there are cases where a task doesn't have wakeup events anymore or at a far
> too low pace. For such situation, we can take advantage of the task being
> put back in the enqueued list to check if it should be pushed on another
> CPU. When the task is alone on the CPU, it's never put back in the enqueued
> list; In this special case, we use the tick to run the check.
> 
> Wake up events remain the main way to migrate tasks but we now detect
> situation where a task is stuck on a CPU by checking that its utilization
> is larger than the max available compute capacity (max cpu capacity or
> uclamp max setting)
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c  | 220 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h |   2 +
>  2 files changed, 222 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a9b97bbc085f..c3e383b86808 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7051,6 +7051,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	hrtick_update(rq);
>  }
>  
> +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p);
>  static void set_next_buddy(struct sched_entity *se);
>  
>  /*
> @@ -7081,6 +7082,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>  		h_nr_idle = task_has_idle_policy(p);
>  		if (task_sleep || task_delayed || !se->sched_delayed)
>  			h_nr_runnable = 1;
> +
> +		fair_remove_pushable_task(rq, p);
>  	} else {
>  		cfs_rq = group_cfs_rq(se);
>  		slice = cfs_rq_min_slice(cfs_rq);
> @@ -8589,6 +8592,197 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	return target;
>  }
>  
> +static inline bool task_stuck_on_cpu(struct task_struct *p, int cpu)
> +{
> +	unsigned long max_capa, util;
> +
> +	max_capa = min(get_actual_cpu_capacity(cpu),
> +		       uclamp_eff_value(p, UCLAMP_MAX));
> +	util = max(task_util_est(p), task_runnable(p));
> +
> +	/*
> +	 * Return true only if the task might not sleep/wakeup because of a low
> +	 * compute capacity. Tasks, which wake up regularly, will be handled by
> +	 * feec().
> +	 */
> +	return (util > max_capa);
> +}
> +
> +static inline bool sched_energy_push_task(struct task_struct *p, struct rq *rq)
> +{
> +	if (p->nr_cpus_allowed == 1)
> +		return false;
> +
> +	if (is_rd_overutilized(rq->rd))
> +		return false;
> +
> +	if (task_stuck_on_cpu(p, cpu_of(rq)))
> +		return true;
> +
> +	return false;
> +}
> +
> +static int active_load_balance_cpu_stop(void *data);
> +
> +static inline void check_pushable_task(struct task_struct *p, struct rq *rq)
> +{
> +	int new_cpu, cpu = cpu_of(rq);
> +
> +	if (!sched_energy_enabled())
> +		return;
> +
> +	if (WARN_ON(!p))
> +		return;
> +
> +	if (WARN_ON(!task_current(rq, p)))
> +		return;
> +
> +	if (is_migration_disabled(p))
> +		return;
> +
> +	/* If there are several task, wait for being put back */
> +	if (rq->nr_running > 1)
> +		return;
> +
> +	if (!sched_energy_push_task(p, rq))
> +		return;
> +
> +	new_cpu = find_energy_efficient_cpu(p, cpu);
> +
> +	if (new_cpu == cpu)
> +		return;
> +
> +	/*
> +	 * ->active_balance synchronizes accesses to
> +	 * ->active_balance_work.  Once set, it's cleared
> +	 * only after active load balance is finished.
> +	 */
> +	if (!rq->active_balance) {
> +		rq->active_balance = 1;
> +		rq->push_cpu = new_cpu;
> +	} else
> +		return;
> +
> +	raw_spin_rq_unlock(rq);
> +	stop_one_cpu_nowait(cpu,
> +		active_load_balance_cpu_stop, rq,
> +		&rq->active_balance_work);
> +	raw_spin_rq_lock(rq);
> +}
> +
> +static inline int has_pushable_tasks(struct rq *rq)
> +{
> +	return !plist_head_empty(&rq->cfs.pushable_tasks);
> +}
> +
> +static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
> +{
> +	struct task_struct *p;
> +
> +	if (!has_pushable_tasks(rq))
> +		return NULL;
> +
> +	p = plist_first_entry(&rq->cfs.pushable_tasks,
> +			      struct task_struct, pushable_tasks);
> +
> +	WARN_ON_ONCE(rq->cpu != task_cpu(p));
> +	WARN_ON_ONCE(task_current(rq, p));
> +	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
> +	WARN_ON_ONCE(!task_on_rq_queued(p));
> +
> +	/*
> +	 * Remove task from the pushable list as we try only once after that
> +	 * the task has been put back in enqueued list.
> +	 */
> +	plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +
> +	return p;
> +}
> +
> +/*
> + * See if the non running fair tasks on this rq can be sent on other CPUs
> + * that fits better with their profile.
> + */
> +static bool push_fair_task(struct rq *rq)
> +{
> +	struct task_struct *next_task;
> +	int prev_cpu, new_cpu;
> +	struct rq *new_rq;
> +
> +	next_task = pick_next_pushable_fair_task(rq);
> +	if (!next_task)
> +		return false;
> +
> +	if (is_migration_disabled(next_task))
> +		return true;
> +
> +	/* We might release rq lock */
> +	get_task_struct(next_task);
> +
> +	prev_cpu = rq->cpu;
> +
> +	new_cpu = find_energy_efficient_cpu(next_task, prev_cpu);

We aren't gating this on a overutilized check for both call sites of this patch
like the other feec() call and testing shows that this calls feec when OU
relatively often.
Why would it be OK to call feec() here when it isn't on task placement?

> +
> +	if (new_cpu == prev_cpu)
> +		goto out;
> +
> +	new_rq = cpu_rq(new_cpu);
> +
> +	if (double_lock_balance(rq, new_rq)) {
> +		/* The task has already migrated in between */
> +		if (task_cpu(next_task) != rq->cpu) {
> +			double_unlock_balance(rq, new_rq);
> +			goto out;
> +		}
> +
> +		deactivate_task(rq, next_task, 0);
> +		set_task_cpu(next_task, new_cpu);
> +		activate_task(new_rq, next_task, 0);
> +
> +		resched_curr(new_rq);
> +
> +		double_unlock_balance(rq, new_rq);
> +	}
> +
> +out:
> +	put_task_struct(next_task);
> +
> +	return true;
> +}
> +
> +static void push_fair_tasks(struct rq *rq)
> +{
> +	/* push_fair_task() will return true if it moved a fair task */

This isn't technically true, a bit of a nit, push_fair_task() also
will return true when the task found wasn't moveable.

[snip]

