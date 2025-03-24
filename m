Return-Path: <linux-kernel+bounces-574033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FC9A6DFDB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D90A18938EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51720263C88;
	Mon, 24 Mar 2025 16:34:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4895261577
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834058; cv=none; b=azslDUrV8OxmzQOSByPWc+xcXH2LQj2TqB1MmryfK+ijVgeVOyW7hNO26whuWvE+/3KuEgFKnEKgbNdiIWBb/gLNFCNeHbpjDMtCWkjtBxpuEW8WVaDEBC8eTR5Zbp2PiSBIUPZm2PIi7OxyOsmcSZoQ/wRVd6gx/qULDueit6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834058; c=relaxed/simple;
	bh=bcw/hb++a9qIJ+07FSSoYRi2RitNhYjgys+PeUOzrmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6ut57fQx802chL9Vgr1PVGSmraeEvmWlEt1f/iM47cGGI5DvtZeasqNbLNNFS8YlCB/Kv7+2iYoL2bqVUIc7Hen0sbiT1timn+jmauNLui5Z44h2GlYqoUHjW4x34zh1k4e3zFdgV6rY/LNx7dB91zXIKKPxq6RO0QDTgxdNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C70F16F3;
	Mon, 24 Mar 2025 09:34:22 -0700 (PDT)
Received: from [192.168.188.123] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FE7F3F58B;
	Mon, 24 Mar 2025 09:34:13 -0700 (PDT)
Message-ID: <eb91803c-04ca-4100-aae3-5385bf71f618@arm.com>
Date: Mon, 24 Mar 2025 16:34:12 +0000
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

So during OSPM25 there was a discussion around this saving energy (even for
!UCLAMP_MAX tasks) because currently when a task has an increased compute
demand all of a sudden, we let it trigger the inefficient OPPs on little and
mid CPUs until they are misfit or the system is overutilized and CAS kicks in.
In particular I've presented a workload (internal VideoScroller which loads a
new video every 3s) which performs worse on power with EAS than CAS. Ignoring
overutilized while attempting feec does help a bit. (-5% energy with CAS, -2%
energy with feec() during OU). This push mechanism was also mentioned to
mitigate such situations.
In theory I agree, but I'm afraid it doesn't help in my testing.
Throughout various workloads where the described issue would appear the push
mechanism is only triggered around once every 2 minutes (i.e. absolutely
negligible).
In particular within 1 hour of testing I've only seen 5 pushed tasks that
fit the described scenarios ("Going from inefficient OPPs on little/mid to
more efficient OPPs on the more capable CPUs"). The described scenario is
very common (triggering at least every few seconds during many workloads).
The vast majority of pushed tasks were pushed within a cluster.
This was on Pixel 6.

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
> +	while (push_fair_task(rq))
> +		;
> +}
> +
> +static DEFINE_PER_CPU(struct balance_callback, fair_push_head);
> +
> +static inline void fair_queue_pushable_tasks(struct rq *rq)
> +{
> +	if (!sched_energy_enabled() || !has_pushable_tasks(rq))
> +		return;
> +
> +	queue_balance_callback(rq, &per_cpu(fair_push_head, rq->cpu), push_fair_tasks);
> +}
> +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p)
> +{
> +	if (sched_energy_enabled())
> +		plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +}
> +
> +static void fair_add_pushable_task(struct rq *rq, struct task_struct *p)
> +{
> +	if (sched_energy_enabled() && task_on_rq_queued(p) && !p->se.sched_delayed) {
> +		if (sched_energy_push_task(p, rq)) {
> +			plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +			plist_node_init(&p->pushable_tasks, p->prio);
> +			plist_add(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +		}
> +	}
> +}
> +
>  /*
>   * select_task_rq_fair: Select target runqueue for the waking task in domains
>   * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
> @@ -8758,6 +8952,10 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	return sched_balance_newidle(rq, rf) != 0;
>  }
>  #else
> +static inline void check_pushable_task(struct task_struct *p, struct rq *rq) {}
> +static inline void fair_queue_pushable_tasks(struct rq *rq) {}
> +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p) {}
> +static inline void fair_add_pushable_task(struct rq *rq, struct task_struct *p) {}
>  static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
>  #endif /* CONFIG_SMP */
>  
> @@ -8947,6 +9145,12 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  		put_prev_entity(cfs_rq, pse);
>  		set_next_entity(cfs_rq, se);
>  
> +		/*
> +		 * The previous task might be eligible for being pushed on
> +		 * another cpu if it is still active.
> +		 */
> +		fair_add_pushable_task(rq, prev);
> +
>  		__set_next_task_fair(rq, p, true);
>  	}
>  
> @@ -9019,6 +9223,13 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
>  		cfs_rq = cfs_rq_of(se);
>  		put_prev_entity(cfs_rq, se);
>  	}
> +
> +	/*
> +	 * The previous task might be eligible for being pushed on another cpu
> +	 * if it is still active.
> +	 */
> +	fair_add_pushable_task(rq, prev);
> +
>  }
>  
>  /*
> @@ -13151,6 +13362,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  	if (static_branch_unlikely(&sched_numa_balancing))
>  		task_tick_numa(rq, curr);
>  
> +	check_pushable_task(curr, rq);
>  	update_misfit_status(curr, rq);
>  	check_update_overutilized_status(task_rq(curr));
>  
> @@ -13303,6 +13515,8 @@ static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool firs
>  {
>  	struct sched_entity *se = &p->se;
>  
> +	fair_remove_pushable_task(rq, p);
> +
>  #ifdef CONFIG_SMP
>  	if (task_on_rq_queued(p)) {
>  		/*
> @@ -13320,6 +13534,11 @@ static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool firs
>  	if (hrtick_enabled_fair(rq))
>  		hrtick_start_fair(rq, p);
>  
> +	/*
> +	 * Try to push prev task before checking misfit for next task as
> +	 * the migration of prev can make next fitting the CPU
> +	 */
> +	fair_queue_pushable_tasks(rq);
>  	update_misfit_status(p, rq);
>  	sched_fair_update_stop_tick(rq, p);
>  }
> @@ -13350,6 +13569,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
>  	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
>  	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
>  #ifdef CONFIG_SMP
> +	plist_head_init(&cfs_rq->pushable_tasks);
>  	raw_spin_lock_init(&cfs_rq->removed.lock);
>  #endif
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ab16d3d0e51c..2db198dccf21 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -722,6 +722,8 @@ struct cfs_rq {
>  	struct list_head	leaf_cfs_rq_list;
>  	struct task_group	*tg;	/* group that "owns" this runqueue */
>  
> +	struct plist_head	pushable_tasks;
> +
>  	/* Locally cached copy of our task_group's idle value */
>  	int			idle;
>  


