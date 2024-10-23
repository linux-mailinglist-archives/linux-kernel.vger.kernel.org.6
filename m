Return-Path: <linux-kernel+bounces-377849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9269AC7A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2631F210A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43E71A08DF;
	Wed, 23 Oct 2024 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bpi5fKvc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0441A0721
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678797; cv=none; b=KeVrZFgI7lX94hY+CeuG385TUdkOL3Itstj4ZQeMcZGQ9TCfKKe/TKzWhyQvDtYeZUK4IJf4FGGCd/RxHh2sSiaC+k6tAVkQ7metPI7oA/fqNLPNBq9RX5Ci0X4cwnJFpTtokbtn7PeVY4FZD2jsFfW578dLApcsy+TA8XxGE7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678797; c=relaxed/simple;
	bh=xAKR+QAqI5mHNcd2iXdESHdVThBghjOvZpMPeX7VMas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1dbMY6p3GAatYdYE9ymHVE9hYSi6cK0QKFC3LFVezfhFwEFzpEh3SNxUBlPb7Ste+COClIwcZ+5cnMZLDJ4I1yK4NkRHO36B+MIko9AuxEaO91IXZ0x0aEAT/sGnVDPeOaI9sh2j3ssQhnzeRMbhIXsihw5A33byw6UFVsHJjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bpi5fKvc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TOlw9CchO0GwRlnpGLylHaf5DED3aVlpTfUkpKfmzcg=; b=Bpi5fKvcft9JqEnG8yy9hoICDQ
	VVlhsFg5DTcYQlkgWDOtykNUWDHCG9J3F3KIeMWaKpYcv56vTmVGQVk3CP3r3HT4TvjMP2w+0FC6s
	rxY58X/4OlE3fp73G4MnyMWepC2zarGNbIk5fgJSbHvj9kxKEecy0punS8orbRaJNLC8F6iNvTXSV
	IGucajiglwIaRsAhEeSZcm8kKRVNVMYVf5QLqi7KNqENcilN7LSNKSf1cOq2t6g/hFD1pKujvKiED
	SwvxLQXgytfuNStEzpKvhjkgIV/cq3unKMfuXstSmdgXnoS+J7gro4H8R0zjRI0MjVrWI6taWOLmg
	eTDuY7Cw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3YSz-00000008Nme-1YTH;
	Wed, 23 Oct 2024 10:19:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7332830073F; Wed, 23 Oct 2024 12:19:48 +0200 (CEST)
Date: Wed, 23 Oct 2024 12:19:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: mpe@ellerman.id.au, Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Make ASYM_PACKING compile-time arch config
Message-ID: <20241023101948.GH16066@noisy.programming.kicks-ass.net>
References: <32c0aed9-bae1-4273-938d-36acb420eb56@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32c0aed9-bae1-4273-938d-36acb420eb56@arm.com>

On Thu, Oct 17, 2024 at 10:46:49PM +0100, Christian Loehle wrote:
> Only x86 and Power7 set SD_ASYM_PACKING at boot-time depending on the
> system. All other platforms don't make use of asym-packing anyway,
> so introduce auxiliary ARCH_HAS_SCHED_ASYM_PACKING and guard all the
> related logic behind that so it isn't compiled when not needed.
> 
> On arm64 this reduces
> size kernel/sched/fair.o
>    text	   data	    bss	    dec	    hex	filename
>   74120	   4097	     88	  78305	  131e1	kernel/sched/fair.o
> to
> size kernel/sched/fair.o
>    text	   data	    bss	    dec	    hex	filename
>   72896	   4065	     88	  77049	  12cf9	kernel/sched/fair.o
> 
> Most of that is on the load-balance hot-path, in particular
> need_active_balance() reduces from 141 to 84 instructions.
> 
> hackbench -pTl 20000 on a rk3399 goes from
> 58.4664 to 57.6056 (-1.5%), mean over 20 iterations.

*sigh* more ifdef is the very last thing we need :/ What's the error on
that measurement? Is it statistically relevant etc.


> @@ -9186,12 +9179,14 @@ enum group_type {
>  	 * a task on SMT with busy sibling to another CPU on idle core.
>  	 */
>  	group_smt_balance,
> +#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
>  	/*
>  	 * SD_ASYM_PACKING only: One local CPU with higher capacity is available,
>  	 * and the task should be migrated to it instead of running on the
>  	 * current CPU.
>  	 */
>  	group_asym_packing,
> +#endif

Do we really need to remove the value from the enum !?

>  	/*
>  	 * The tasks' affinity constraints previously prevented the scheduler
>  	 * from balancing the load across the system.
> @@ -9876,7 +9871,9 @@ struct sg_lb_stats {
>  	unsigned int idle_cpus;                 /* Nr of idle CPUs         in the group */
>  	unsigned int group_weight;
>  	enum group_type group_type;
> +#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
>  	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
> +#endif

just leave it be, who cares if it goes unused?

>  	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
>  	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its capacity */
>  #ifdef CONFIG_NUMA_BALANCING
> @@ -10136,8 +10133,10 @@ group_type group_classify(unsigned int imbalance_pct,
>  	if (sg_imbalanced(group))
>  		return group_imbalanced;
>  
> +#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
>  	if (sgs->group_asym_packing)
>  		return group_asym_packing;
> +#endif

Add a helper that returns false such that the compiler can DCE it?

> @@ -10360,10 +10402,12 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  
>  	sgs->group_weight = group->group_weight;
>  
> +#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
>  	/* Check if dst CPU is idle and preferred to this group */
>  	if (!local_group && env->idle && sgs->sum_h_nr_running &&
>  	    sched_group_asym(env, sgs, group))
>  		sgs->group_asym_packing = 1;
> +#endif

Just make sure sched_group_asym() is unconditionally false and the
compiler will DCE it, no?

>  
>  	/* Check for loaded SMT group to be balanced to dst CPU */
>  	if (!local_group && smt_balance(env, sgs, group))
> @@ -10436,9 +10480,11 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  		 */
>  		return false;
>  
> +#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
>  	case group_asym_packing:
>  		/* Prefer to move from lowest priority CPU's work */
>  		return sched_asym_prefer(sds->busiest->asym_prefer_cpu, sg->asym_prefer_cpu);
> +#endif

Just leave it be, it'll never get selected.

>  	case group_misfit_task:
>  		/*
> @@ -10691,7 +10737,9 @@ static bool update_pick_idlest(struct sched_group *idlest,
>  		break;
>  
>  	case group_imbalanced:
> +#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
>  	case group_asym_packing:
> +#endif

idem

>  	case group_smt_balance:
>  		/* Those types are not used in the slow wakeup path */
>  		return false;
> @@ -10823,7 +10871,9 @@ sched_balance_find_dst_group(struct sched_domain *sd, struct task_struct *p, int
>  		break;
>  
>  	case group_imbalanced:
> +#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
>  	case group_asym_packing:
> +#endif

and again.

>  	case group_smt_balance:
>  		/* Those type are not used in the slow wakeup path */
>  		return NULL;
> @@ -11058,7 +11108,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  		return;
>  	}
>  
> -	if (busiest->group_type == group_asym_packing) {
> +	if (check_asym_packing(busiest)) {
>  		/*
>  		 * In case of asym capacity, we will try to migrate all load to
>  		 * the preferred CPU.
> @@ -11265,7 +11315,7 @@ static struct sched_group *sched_balance_find_src_group(struct lb_env *env)
>  		goto out_balanced;
>  
>  	/* ASYM feature bypasses nice load balance check */
> -	if (busiest->group_type == group_asym_packing)
> +	if (check_asym_packing(busiest))
>  		goto force_balance;
>  
>  	/*

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index b1c3588a8f00..51d49700f643 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -937,11 +937,17 @@ static inline long se_weight(struct sched_entity *se)
>  	return scale_load_down(se->load.weight);
>  }
>  
> -
> +#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
>  static inline bool sched_asym_prefer(int a, int b)
>  {
>  	return arch_asym_cpu_priority(a) > arch_asym_cpu_priority(b);
>  }
> +#else
> +static inline bool sched_asym_prefer(int a, int b)
> +{
> +	return false;
> +}
> +#endif

Or you can write:

static inline bool sched_asym_prefer(int a, int b)
{
	if (!IS_ENABLED(CONFIG_ARCH_HAS_SCHED_ASYM_PACKING))
		return false;
	return arch_asym_cpu_priority(a) > arch_asym_cpu_priority(b);
}


Anyway, ifdef bad, less is more. DCE good.

