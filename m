Return-Path: <linux-kernel+bounces-275852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD38948AF9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391B5B25449
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30861BCA1D;
	Tue,  6 Aug 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JZuUkt23"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804981BC9FD
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931986; cv=none; b=Rn/KayRzkYr1nhFqKROH8d+Sq6TQXLGGOssLDPKSv0CZK9fUQkcylN8lSP2HstGW9/Q+sXe8gPHLAsy/uqPnhvZlGyyaiZLnalJr7Q0dB0w7CZb2TXoKrd/P06ArQX+DM1bYQUdyyvj4h8I7EqQpe2sirKt+u4lzSSJYYDdvj3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931986; c=relaxed/simple;
	bh=Eykk5CEI9ChfCe9VFQS0LmnY3AeYxMezO8USgev3eLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGh7tI7h4tL+jr8M/DrvgI34TFhX1JOBg1uR4rJgqA7QergZ22Wr/+CCV5ypZ4xzBp46gFOUFAPx6rFqiwpZDYMkO5c1gbe4LGaZ0jqKvGVXhHk+bTIrvj06YxgMOTzBzbMrn4BYV8rttKQFKTtNKYQfcbeDx9a6Cm75GhcV1Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JZuUkt23; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xFbLXFlol+Qo+8ArHYZ18jx4Vj3gElKGQSoeJh/9HNw=; b=JZuUkt23SjYhM/zkXhYfWCaOk+
	v6T2RXnJuRbM4+Pe/0oYIFQ3vMqzwFghRUU9YV9qpH+RBSDBsu9vwkDb4nIzMi/86qUB5o4jMUYGh
	XhyM/X8t82udmabg/jwaUboWp51ayxlk8q2m+fcWoqLEqjoQ7+tOyDg0OHBx9ZQTFn2SJUM80OVkj
	yVoBMxHj8ZGUw5wg03DUseza6BJhr/zjJBcSR9cw6r+uQFElFgI7LIaBMd0iOSRNnUqwemR2kockz
	iO11ANryvqTlejbHXlxhOC+X8KBtzmSEQpVinStkZXmwb1TCzWecoD57SHc9Qv0ux26yHGfDEQzPd
	q1xV44Mg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbFJT-00000006OQX-2lXO;
	Tue, 06 Aug 2024 08:13:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4822230049D; Tue,  6 Aug 2024 10:12:59 +0200 (CEST)
Date: Tue, 6 Aug 2024 10:12:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	mingo@redhat.com
Subject: Re: [PATCH 6/6] sched_ext: Make task_can_run_on_remote_rq() use
 common task_allowed_on_cpu()
Message-ID: <20240806081259.GN37996@noisy.programming.kicks-ass.net>
References: <20240804024047.100355-1-tj@kernel.org>
 <20240804024047.100355-7-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804024047.100355-7-tj@kernel.org>

On Sat, Aug 03, 2024 at 04:40:13PM -1000, Tejun Heo wrote:
> task_can_run_on_remote_rq() is similar to is_cpu_allowed() but there are
> subtle differences. It currently open codes all the tests. This is
> cumbersome to understand and error-prone in case the intersecting tests need
> to be updated.
> 
> Factor out the common part - testing whether the task is allowed on the CPU
> at all regardless of the CPU state - into task_allowed_on_cpu() and make
> both is_cpu_allowed() and SCX's task_can_run_on_remote_rq() use it. As the
> code is now linked between the two and each contains only the extra tests
> that differ between them, it's less error-prone when the conditions need to
> be updated. Also, improve the comment to explain why they are different.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> ---
>  kernel/sched/core.c  |  4 ++--
>  kernel/sched/ext.c   | 21 ++++++++++++++++-----
>  kernel/sched/sched.h | 18 ++++++++++++++++++
>  3 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d2ccc2c4b4d3..3c22d0c8eed1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2311,7 +2311,7 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
>  static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
>  {
>  	/* When not in the task's cpumask, no point in looking further. */
> -	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> +	if (!task_allowed_on_cpu(p, cpu))
>  		return false;
>  
>  	/* migrate_disabled() must be allowed to finish. */
> @@ -2320,7 +2320,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
>  
>  	/* Non kernel threads are not allowed during either online or offline. */
>  	if (!(p->flags & PF_KTHREAD))
> -		return cpu_active(cpu) && task_cpu_possible(cpu, p);
> +		return cpu_active(cpu);
>  
>  	/* KTHREAD_IS_PER_CPU is always allowed. */
>  	if (kthread_is_per_cpu(p))
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 7837a551022c..60a7eb7d8a9e 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2224,19 +2224,30 @@ static void consume_local_task(struct rq *rq, struct scx_dispatch_q *dsq,
>  
>  #ifdef CONFIG_SMP
>  /*
> - * Similar to kernel/sched/core.c::is_cpu_allowed() but we're testing whether @p
> - * can be pulled to @rq.
> + * Similar to kernel/sched/core.c::is_cpu_allowed(). However, there are two
> + * differences:
> + *
> + * - is_cpu_allowed() asks "Can this task run on this CPU?" while
> + *   task_can_run_on_remote_rq() asks "Can the BPF scheduler migrate the task to
> + *   this CPU?".
> + *
> + *   While migration is disabled, is_cpu_allowed() has to say "yes" as the task
> + *   must be allowed to finish on the CPU that it's currently on regardless of
> + *   the CPU state. However, task_can_run_on_remote_rq() must say "no" as the
> + *   BPF scheduler shouldn't attempt to migrate a task which has migration
> + *   disabled.
> + *
> + * - The BPF scheduler is bypassed while the rq is offline and we can always say
> + *   no to the BPF scheduler initiated migrations while offline.
>   */
>  static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq)
>  {
>  	int cpu = cpu_of(rq);
>  
> -	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> +	if (!task_allowed_on_cpu(p, cpu))
>  		return false;
>  	if (unlikely(is_migration_disabled(p)))
>  		return false;
> -	if (!(p->flags & PF_KTHREAD) && unlikely(!task_cpu_possible(cpu, p)))
> -		return false;
>  	if (!scx_rq_online(rq))
>  		return false;
>  	return true;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 9b88a46d3fce..2b369d8a36b1 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2530,6 +2530,19 @@ extern void sched_balance_trigger(struct rq *rq);
>  extern int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx);
>  extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx);
>  
> +extern inline bool task_allowed_on_cpu(struct task_struct *p, int cpu)

This wants to be "static inline". no? I think we try and avoid "extern
inline".

> +{
> +	/* When not in the task's cpumask, no point in looking further. */
> +	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> +		return false;
> +
> +	/* Can @cpu run a user thread? */
> +	if (!(p->flags & PF_KTHREAD) && !task_cpu_possible(cpu, p))
> +		return false;
> +
> +	return true;
> +}
> +
>  static inline cpumask_t *alloc_user_cpus_ptr(int node)
>  {
>  	/*
> @@ -2563,6 +2576,11 @@ extern int push_cpu_stop(void *arg);
>  
>  #else /* !CONFIG_SMP: */
>  
> +static inline bool task_allowed_on_cpu(struct task_struct *p, int cpu)
> +{
> +	return true;
> +}
> +
>  static inline int __set_cpus_allowed_ptr(struct task_struct *p,
>  					 struct affinity_context *ctx)
>  {
> -- 
> 2.46.0
> 

