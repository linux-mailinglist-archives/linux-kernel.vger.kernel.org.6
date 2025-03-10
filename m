Return-Path: <linux-kernel+bounces-554864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11A1A5A297
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6645918953D9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493B52309BD;
	Mon, 10 Mar 2025 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a7gXiGuL"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F58156861
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630908; cv=none; b=A5NHWt4jvNpUBCZ71E7TrST1wOxryvovK8qCB5nTgJZ8YXim1XUyHtSNgAusaDrD6M0xyX6aj0Do3M6oWPQ+IU90ghwgllO94S8aUjWEkro+/BEiLpCI0I9VrIlpbC4ANjspplmvIJjCWdFUFVlutc2sqZ3VnviD8aoM3qCF9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630908; c=relaxed/simple;
	bh=zOuWnaznoBEsLoOm8W2GkMwOjThOD4VIeNfSt39PiBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYDp0ox+saBz5TZaTZOuo29a8vRnvcTvoW3LDV1Z5LaNxCuuUXVlrEIE8UlyxIIOY0BoS791R+YA04IqQoIcOXkbZfL+qRMKOkf66jcsUHsbfC/UAPXsMs2t+zJmpNWO8c4ZdRIEzb6GEPg77D5ZRpy8oS/O1bXaFzUWhzmhvX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a7gXiGuL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AE36FQ027805;
	Mon, 10 Mar 2025 18:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cFPRrY
	C5kUbEKVr6KVYDVjuxeBAaKJjw+U2sd/PrfYE=; b=a7gXiGuLBRsboMLI2XYYAK
	LoJuSzpXYpKmkaSvIW7KGcwtRvou44mefwjYBri9Dupjzk8E2iAgTHG4S6xwF012
	4Wp18ArwvyNeWZs13UILpGkwIHfZB/LpBAIXEqlRUBM9KT6hH4KBs7OZci9Qtow4
	olq/9JsODM4GcKnCsI9QfQ1ZCK65TMk1AavokNhxHCbDeVwSIDn063Fyti60zzHf
	+bGPWVMYkux1qCiOBVHyw9D0GrUOiGiYTKHmTgpysQH98VilO0NxFFZPjebmsve1
	RvK9uqyw048h9E4/IF3UMOgRmJt/gIlckf/ZCEhuzwScIa7W/lSwp9Xsb26ce3/A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a1gp1etv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 18:20:19 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52AIDpAn011231;
	Mon, 10 Mar 2025 18:20:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a1gp1etq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 18:20:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52AHIKYj023851;
	Mon, 10 Mar 2025 18:20:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4590kyr74u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 18:20:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52AIKFoO17498500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:20:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79ACA2004B;
	Mon, 10 Mar 2025 18:20:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B5E520040;
	Mon, 10 Mar 2025 18:20:11 +0000 (GMT)
Received: from [9.39.22.126] (unknown [9.39.22.126])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Mar 2025 18:20:11 +0000 (GMT)
Message-ID: <0dabf19f-96be-4c55-a4bb-8325d288eacc@linux.ibm.com>
Date: Mon, 10 Mar 2025 23:50:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7 v5] sched/fair: Add push task mechanism for EAS
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: qyousef@layalina.io, hongyan.xia2@arm.com, christian.loehle@arm.com,
        luis.machado@arm.com, qperret@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, lukasz.luba@arm.com, rafael.j.wysocki@intel.com,
        pierre.gondois@arm.com, linux-kernel@vger.kernel.org
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
 <20250302210539.1563190-6-vincent.guittot@linaro.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250302210539.1563190-6-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3CJWtl5ZC2_w3zhHAf0WVAOo0KckhDe6
X-Proofpoint-ORIG-GUID: xwQz7MTp4z0R8HmHqEADpM5OTSK7bVdt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 mlxlogscore=999 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100140


Hi Vincent, trying to understand this series. I see most of the places 
are with sched_energy_enabled() checks. So it shouldn't affect non-EAS 
systems.

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
>   kernel/sched/fair.c  | 220 +++++++++++++++++++++++++++++++++++++++++++
>   kernel/sched/sched.h |   2 +
>   2 files changed, 222 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a9b97bbc085f..c3e383b86808 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7051,6 +7051,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>   	hrtick_update(rq);
>   }
>   
> +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p);
>   static void set_next_buddy(struct sched_entity *se);
>   
>   /*
> @@ -7081,6 +7082,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>   		h_nr_idle = task_has_idle_policy(p);
>   		if (task_sleep || task_delayed || !se->sched_delayed)
>   			h_nr_runnable = 1;
> +
> +		fair_remove_pushable_task(rq, p);
>   	} else {
>   		cfs_rq = group_cfs_rq(se);
>   		slice = cfs_rq_min_slice(cfs_rq);
> @@ -8589,6 +8592,197 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>   	return target;
>   }
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

Does this need preempt disable/enable guards similar to sched_balance_rq?

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

Isnt it better to print it everytime? it could different process each 
time no?

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

has_pushable_task has any tasks iff sched_energy_enabled. so this check 
may not be needed. But it shouldnt hurt, since it is static key.

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
>   /*
>    * select_task_rq_fair: Select target runqueue for the waking task in domains
>    * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
> @@ -8758,6 +8952,10 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   	return sched_balance_newidle(rq, rf) != 0;
>   }
>   #else
> +static inline void check_pushable_task(struct task_struct *p, struct rq *rq) {}
> +static inline void fair_queue_pushable_tasks(struct rq *rq) {}
> +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p) {}
> +static inline void fair_add_pushable_task(struct rq *rq, struct task_struct *p) {}
>   static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
>   #endif /* CONFIG_SMP */
>   
> @@ -8947,6 +9145,12 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>   		put_prev_entity(cfs_rq, pse);
>   		set_next_entity(cfs_rq, se);
>   
> +		/*
> +		 * The previous task might be eligible for being pushed on
> +		 * another cpu if it is still active.
> +		 */
> +		fair_add_pushable_task(rq, prev);
> +
>   		__set_next_task_fair(rq, p, true);
>   	}
>   
> @@ -9019,6 +9223,13 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
>   		cfs_rq = cfs_rq_of(se);
>   		put_prev_entity(cfs_rq, se);
>   	}
> +
> +	/*
> +	 * The previous task might be eligible for being pushed on another cpu
> +	 * if it is still active.
> +	 */
> +	fair_add_pushable_task(rq, prev);
> +
>   }
>   
>   /*
> @@ -13151,6 +13362,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>   	if (static_branch_unlikely(&sched_numa_balancing))
>   		task_tick_numa(rq, curr);
>   
> +	check_pushable_task(curr, rq);
>   	update_misfit_status(curr, rq);
>   	check_update_overutilized_status(task_rq(curr));
>   
> @@ -13303,6 +13515,8 @@ static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool firs
>   {
>   	struct sched_entity *se = &p->se;
>   
> +	fair_remove_pushable_task(rq, p);
> +
>   #ifdef CONFIG_SMP
>   	if (task_on_rq_queued(p)) {
>   		/*
> @@ -13320,6 +13534,11 @@ static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool firs
>   	if (hrtick_enabled_fair(rq))
>   		hrtick_start_fair(rq, p);
>   
> +	/*
> +	 * Try to push prev task before checking misfit for next task as
> +	 * the migration of prev can make next fitting the CPU
> +	 */
> +	fair_queue_pushable_tasks(rq);
>   	update_misfit_status(p, rq);
>   	sched_fair_update_stop_tick(rq, p);
>   }
> @@ -13350,6 +13569,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
>   	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
>   	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
>   #ifdef CONFIG_SMP
> +	plist_head_init(&cfs_rq->pushable_tasks);
>   	raw_spin_lock_init(&cfs_rq->removed.lock);
>   #endif
>   }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ab16d3d0e51c..2db198dccf21 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -722,6 +722,8 @@ struct cfs_rq {
>   	struct list_head	leaf_cfs_rq_list;
>   	struct task_group	*tg;	/* group that "owns" this runqueue */
>   
> +	struct plist_head	pushable_tasks;
> +
>   	/* Locally cached copy of our task_group's idle value */
>   	int			idle;
>   


