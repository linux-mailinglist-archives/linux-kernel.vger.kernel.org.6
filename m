Return-Path: <linux-kernel+bounces-380564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85F49AF286
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51AFFB2494C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E7E218D77;
	Thu, 24 Oct 2024 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVDQ9p4y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01782141CB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797360; cv=none; b=eHiQt+shr2wBAfjw2Q/l4P2iBfXirR7jvLAbBCsaPf6mlmvFV2M9aHmRFJcuVC+RofKUrqxwJhDtWCxdrLTD5I5cXO7OU666iuBT/2qe5ryC4HttUsOswzN1Wi3PmIl7Udi9dVmDC6PY1BSNeS6sdcP727Qemp4Ll3fKB8SCE5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797360; c=relaxed/simple;
	bh=7weJOZEsWOSAOwDAiOkxBkv6Rd9Sn6yxZTioyNl1eog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CriVoJNffMDH5VRibGHrmyczcwiHT7uP0hNNDwoAmR8GShIuUsf5kw8tehB9fw2p6jwPW8xALjgbTCSWFVGd1SnqNpygaNcfSZdY1tMUuEAuvzkkXWpEQDlMPx+VeQvnSSxeBaUEZiG4cyiCV5b1JVCe+9YjohnBEu7pomKaHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVDQ9p4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F7EC4CEC7;
	Thu, 24 Oct 2024 19:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729797359;
	bh=7weJOZEsWOSAOwDAiOkxBkv6Rd9Sn6yxZTioyNl1eog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVDQ9p4yMGpB1m8bUqQjg9euiGM7f0F3DFBG7b3p/aS1gEqWBOmDYwMxL2np8fjxp
	 36vPTvuSgj4VzukQWwC50Wkm7ide32c8He7WmxfI9AqtegM/8OfDohPlx2eXuhLNzt
	 XcPoAaNUqQm8jGDPg7GdrkYI9pATTVWlcbYgcD1mUNBA0BQJmkCZ2PN2zvbrDYMOUw
	 GzJBCuM2Mo4b61ODU9YqQK3kDaSlKBrorwvQYx/P9dnTYUI6/MfQKgryEkMjG15TRa
	 trCyzKmDMlle2B5BYTu7AgDMW4mRogKVjPYqn9GpP7wPFvC+LPrmumM2o5+I9tDFdh
	 vnuOgKjnRUX1Q==
Date: Thu, 24 Oct 2024 09:15:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Introduce NUMA awareness to the default idle
 selection policy
Message-ID: <Zxqc7jI8USKFX9-p@slm.duckdns.org>
References: <20241024083615.64948-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024083615.64948-1-arighi@nvidia.com>

Hello, Anrea.

On Thu, Oct 24, 2024 at 10:36:15AM +0200, Andrea Righi wrote:
> Similarly to commit dfa4ed29b18c ("sched_ext: Introduce LLC awareness to
> the default idle selection policy"), extend the built-in idle CPU
> selection policy to also prioritize CPUs within the same NUMA node.
> 
> With this change applied, the built-in CPU idle selection policy follows
> this logic:
>  - always prioritize CPUs from fully idle SMT cores,
>  - select the same CPU if possible,
>  - select a CPU within the same LLC domain,
>  - select a CPU within the same NUMA node.
> 
> Note that LLC and NUMA awareness optimizations are only applied when
> CONFIG_SCHED_MC is enabled.

The idea generally looks good to me but I have a couple quibbles about the
implementation.

...
> +enum scx_domain_type {
> +	SCX_DOM_LLC,		/* Use the same last-level cache (LLC) */
> +	SCX_DOM_NUMA,		/* Use the same NUMA node */
> +};
> +
>  #ifdef CONFIG_SCHED_MC
>  /*
> - * Return the cpumask of CPUs usable by task @p in the same LLC domain of @cpu,
> - * or NULL if the LLC domain cannot be determined.
> + * Return the cpumask of CPUs usable by task @p in the same domain of @cpu, or
> + * NULL if the domain cannot be determined.
>   */
> -static const struct cpumask *llc_domain(const struct task_struct *p, s32 cpu)
> +static const struct cpumask *
> +scx_domain(const struct task_struct *p, s32 cpu, enum scx_domain_type type)
>  {
> -	struct sched_domain *sd = rcu_dereference(per_cpu(sd_llc, cpu));
> -	const struct cpumask *llc_cpus = sd ? sched_domain_span(sd) : NULL;
> +	struct sched_domain *sd;
>  
>  	/*
> -	 * Return the LLC domain only if the task is allowed to run on all
> -	 * CPUs.
> -	 */
> -	return p->nr_cpus_allowed == nr_cpu_ids ? llc_cpus : NULL;
> +	 * Determine the scheduling domain only if the task is allowed to run
> +	 * on all CPUs.
> +	 *
> +	 * This is done primarily for efficiency, as it avoids the overhead of
> +	 * updating a cpumask every time we need to select an idle CPU (which
> +	 * can be costly in large SMP systems), but it also aligns logically:
> +	 * if a task's scheduling domain is restricted by user-space (through
> +	 * CPU affinity), the task will simply use the flat scheduling domain
> +	 * defined by user-space.
> +	 */
> +	if (p->nr_cpus_allowed < nr_cpu_ids)
> +		return NULL;
> +
> +	switch (type) {
> +	case SCX_DOM_LLC:
> +		sd = rcu_dereference(per_cpu(sd_llc, cpu));
> +		break;
> +	case SCX_DOM_NUMA:
> +		sd = rcu_dereference(per_cpu(sd_numa, cpu));
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		sd = NULL;
> +	}
> +	if (!sd)
> +		return NULL;
> +
> +	return sched_domain_span(sd);
>  }
>  #else /* CONFIG_SCHED_MC */
> -static inline const struct cpumask *llc_domain(struct task_struct *p, s32 cpu)
> +static const struct cpumask *
> +scx_domain(const struct task_struct *p, s32 cpu, enum scx_domain_type type)
>  {
>  	return NULL;
>  }
>  #endif /* CONFIG_SCHED_MC */
...
> @@ -3156,7 +3210,8 @@ static inline const struct cpumask *llc_domain(struct task_struct *p, s32 cpu)
>  static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  			      u64 wake_flags, bool *found)
>  {
> -	const struct cpumask *llc_cpus = llc_domain(p, prev_cpu);
> +	const struct cpumask *llc_cpus = scx_domain(p, prev_cpu, SCX_DOM_LLC);
> +	const struct cpumask *numa_cpus = scx_domain(p, prev_cpu, SCX_DOM_NUMA);

This feels like a lot of code which can just be:

	const struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;

#ifdef CONFIG_SCHED_MC
	llc_cpus = rcu_dereference(per_cpu(sd_llc, cpu));
	numa_cpus = rcu_dereference(per_cpu(sd_numa, cpu));
#endif

>  	s32 cpu;
>  
>  	*found = false;
> @@ -3226,6 +3281,15 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  				goto cpu_found;
>  		}
>  
> +		/*
> +		 * Search for any fully idle core in the same NUMA node.
> +		 */
> +		if (numa_cpus) {
> +			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
> +			if (cpu >= 0)
> +				goto cpu_found;
> +		}

I'm not convinced about the argument that always doing extra pick is
beneficial. Sure, the overhead is minimal but isn't it also trivial to avoid
by just testing llc_cpus == numa_cpus (they resolve to the same cpumasks on
non-NUMA machines, right)? Taking a step further, the topology information
is really static and can be determined during boot. Wouldn't it make more
sense to just skip the unnecessary steps depending on topology? I'm not sure
the difference would be measurable but if you care we can make them
static_keys too.

Thanks.

-- 
tejun

