Return-Path: <linux-kernel+bounces-573983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 363FEA6DF3E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F3C3A9CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6F125EFA4;
	Mon, 24 Mar 2025 16:06:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D68A261584
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832377; cv=none; b=fV+rOaZWQekkrqYt9ux8FDZ5dHetZq9rjC7g9aTc1yFS7d+QQr/0f06aM2ohTdC6nIjTL1Db8IfJgetX8kI7cRz9OjvppxLCt4x1tKmu2XkG3K7MmrQPSasRgpTRXYAiy/jzWAV1+iyBwHNXCzW5uCbI1uW01OCJsxrv9l2fjQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832377; c=relaxed/simple;
	bh=WQCIJdCnlZlNFzh0vKMJt+7ek+uPiTZPiLYOTCSdIYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M32cgHXNwZ88HWK74EQLD92VDuWktIv35XJyTDVkCHly4tg9WtDWDoxMvMkOPQI/KWIGFwxpPbM0q0D9rEuYJYDBo0rD+5650Xj5mWoKlxt8vIP/TfuxAmXuxzjS4jkP8bcVJjMYpP7dmepBt4/BRQl4YOrx6mYegUefawyxFEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A104106F;
	Mon, 24 Mar 2025 09:06:19 -0700 (PDT)
Received: from [192.168.188.123] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBC4A3F58B;
	Mon, 24 Mar 2025 09:06:09 -0700 (PDT)
Message-ID: <2415346f-f7ae-4bda-a6bc-f20a9628d3a0@arm.com>
Date: Mon, 24 Mar 2025 16:06:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7 v5] sched/fair: Add misfit case to push task mecanism
 for EAS
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, lukasz.luba@arm.com, rafael.j.wysocki@intel.com,
 pierre.gondois@arm.com, linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io, hongyan.xia2@arm.com, luis.machado@arm.com,
 qperret@google.com
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
 <20250302210539.1563190-7-vincent.guittot@linaro.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250302210539.1563190-7-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/25 21:05, Vincent Guittot wrote:
> Some task misfit cases can be handled directly by the push mecanism
> instead of triggering an idle load balance to pull the task on a better
> CPU.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

So why is one better than the other?
In my testing most misfit migrations were still handled by load-balance,
simply because the push mechanism is only triggered when switching from
the task (but it's still running, often 'uncontended' for a while).
I can provide some numbers here if desired.

> ---
>  kernel/sched/fair.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c3e383b86808..d21fe0a26633 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8508,6 +8508,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			target_stat.runnable = cpu_runnable(cpu_rq(cpu));
>  			target_stat.capa = capacity_of(cpu);
>  			target_stat.nr_running = cpu_rq(cpu)->cfs.h_nr_runnable;
> +			if ((p->on_rq) && (!p->se.sched_delayed) && (cpu == prev_cpu))
> +				target_stat.nr_running--;
>  
>  			/* If the target needs a lower OPP, then look up for
>  			 * the corresponding OPP and its associated cost.
> @@ -8613,6 +8615,9 @@ static inline bool sched_energy_push_task(struct task_struct *p, struct rq *rq)
>  	if (p->nr_cpus_allowed == 1)
>  		return false;
>  
> +	if (!task_fits_cpu(p, cpu_of(rq)))
> +		return true;
> +
>  	if (is_rd_overutilized(rq->rd))
>  		return false;
>  
> @@ -8624,33 +8629,33 @@ static inline bool sched_energy_push_task(struct task_struct *p, struct rq *rq)
>  
>  static int active_load_balance_cpu_stop(void *data);
>  
> -static inline void check_pushable_task(struct task_struct *p, struct rq *rq)
> +static inline bool check_pushable_task(struct task_struct *p, struct rq *rq)
>  {
>  	int new_cpu, cpu = cpu_of(rq);
>  
>  	if (!sched_energy_enabled())
> -		return;
> +		return false;
>  
>  	if (WARN_ON(!p))
> -		return;
> +		return false;
>  
>  	if (WARN_ON(!task_current(rq, p)))
> -		return;
> +		return false;
>  
>  	if (is_migration_disabled(p))
> -		return;
> +		return false;
>  
>  	/* If there are several task, wait for being put back */
>  	if (rq->nr_running > 1)
> -		return;
> +		return false;
>  
>  	if (!sched_energy_push_task(p, rq))
> -		return;
> +		return false;
>  
>  	new_cpu = find_energy_efficient_cpu(p, cpu);
>  
>  	if (new_cpu == cpu)
> -		return;
> +		return false;
>  
>  	/*
>  	 * ->active_balance synchronizes accesses to
> @@ -8661,13 +8666,15 @@ static inline void check_pushable_task(struct task_struct *p, struct rq *rq)
>  		rq->active_balance = 1;
>  		rq->push_cpu = new_cpu;
>  	} else
> -		return;
> +		return false;
>  
>  	raw_spin_rq_unlock(rq);
>  	stop_one_cpu_nowait(cpu,
>  		active_load_balance_cpu_stop, rq,
>  		&rq->active_balance_work);
>  	raw_spin_rq_lock(rq);
> +
> +	return true;
>  }
>  
>  static inline int has_pushable_tasks(struct rq *rq)
> @@ -8952,7 +8959,11 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	return sched_balance_newidle(rq, rf) != 0;
>  }
>  #else
> -static inline void check_pushable_task(struct task_struct *p, struct rq *rq) {}
> +static inline bool check_pushable_task(struct task_struct *p, struct rq *rq)
> +{
> +	return false;
> +}
> +
>  static inline void fair_queue_pushable_tasks(struct rq *rq) {}
>  static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p) {}
>  static inline void fair_add_pushable_task(struct rq *rq, struct task_struct *p) {}
> @@ -13362,9 +13373,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  	if (static_branch_unlikely(&sched_numa_balancing))
>  		task_tick_numa(rq, curr);
>  
> -	check_pushable_task(curr, rq);
> -	update_misfit_status(curr, rq);
> -	check_update_overutilized_status(task_rq(curr));
> +	if (!check_pushable_task(curr, rq)) {
> +		update_misfit_status(curr, rq);
> +		check_update_overutilized_status(task_rq(curr));
> +	}
>  
>  	task_tick_core(rq, curr);
>  }


