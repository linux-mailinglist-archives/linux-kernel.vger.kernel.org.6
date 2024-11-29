Return-Path: <linux-kernel+bounces-425919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB6A9DEC89
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D16E281B00
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2481A256F;
	Fri, 29 Nov 2024 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5DRXg23"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A9A14D430
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732909139; cv=none; b=p7ZKgekseyGz7Ciu1nzjOz1uIoM9JKD3fC7JzW3sObuM6qKpebY1leYsJ8JHmsrkhD03rHDNSzeYwpm/FW/5kB1kqqWnSEHyXLt6jZAcII8WpGmJgHS0fqmi7EjIJkmr7aXsLMFQTmrPNXqhMJ5+pmrliFaw5fPGo6LovbH0tKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732909139; c=relaxed/simple;
	bh=C0DPIjvhpBCM5WYpqRyUZZ+4P19aBevaLurvEZXPEVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHq71biN86OWfmVamorwIuPnyqZV7/LAtpUVGhWVPzFaCVj9ai6ivOX3L64gz8LgzZcwSlvsGOMYuki48bxHME9LGLWqwEG6gjQlowmO7yMlAkiikn2H2UzKbh+T8GEaqt4cU5KMRSra8QIq81XAoclESBAjnnqCUPyZNvkGfh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5DRXg23; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2154e3af730so5636575ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732909137; x=1733513937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5njRe0SbZHoPTTvghKSiXR5ZpgXnZX2ZopplgKzPij4=;
        b=g5DRXg23OLvosbedoZEOsoENcZCpZR0Q3M7dp8oWcmLm/GP5vR4IRfK65pdA7JrU9S
         mshIzofoMQG3HmHrxeTqw8hxgi2zTBcB+HKuL/Mnwptw2KZp1tzPfNrf7nvlI6sJp+zn
         wh/vhJEkqAlUPAUqFkm8xo82yMPHQtlydkPKwEQWDF0jFiNcLzt7FI9bMkrpVfjZq8VF
         Rf3qHCLYZcSMM7LODlPcrvaE9y7sL6wMue78oGecrEVToqatTgrvqkwb7F4AoObv5UwL
         5B+2xcps5cUAPw+UB/oIaGVei5NgkYYjq6aIk4FmGe4rubgI6Mr/PMIEL4ha38wePXED
         sagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732909137; x=1733513937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5njRe0SbZHoPTTvghKSiXR5ZpgXnZX2ZopplgKzPij4=;
        b=Mq63Sbdv8Ns0yFCv2AU5y9SreJS9w8BmMy4hVe5RKDsZ2vCF45qnu58JOCFXxrrzj4
         YtinU8VTesx8gdRzSlj88pIe3zOFl63CNzS8GnHs47Ik4bQcMZGl6s5tbNGPgulWfRYQ
         POiPwF1w5vN11mEeWQvUQm0nPZ3B5LhgnBqRuQY+VCGr04CiX5tYd8gMzoHCnxjfbqpc
         DT3mBbOeKlGvAzffkwyB4AHPA5SHpTN9OM6osXA3jkQruU/DRtJlbhAEt4FBDMo2mHI7
         hMTFgw8pVFk7MBJt6mfjKIY3hWXjAxxBT1t6okANwLjf5qSYXifdM/5V2Fi+OfbNzcQU
         1aZA==
X-Forwarded-Encrypted: i=1; AJvYcCXPDkrRHDTq6hip2CmEu9AiPlQAaw0eXTzLMT9hoRbDvP971S8XDm+aoOm/5ERs7n6eSiGBw3ZPqGTkPeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq97rE/M+hcgR2rqb/0Iv7vd2hY1eOzBbn5GSD+Wzp4DauasQv
	Vqyv9u6cyHCOVzQPSCBZuCOmLuVmAhf7XDymREQEHdH5qLDRLjNo
X-Gm-Gg: ASbGncvLIHisLXMpCTT8ZUKvue5Y2eWc+Wm6wyxjdu19JnB+z+URQp6USak9oyBsKNo
	HYQ9jKMFkXeTl/z3Dwt9iRTUTb7Q7AA3PJGfTyVI0dinbunXqgVHbz1F1fmDldvg4sKnKdlda4y
	hxg0u5LijeTnQPOVgGZjzJ0VIp2KPa56LXHNY0lqV8SRaEnmL/dnbtuCjMr2J+pQlQcGA3e/TG4
	5IsnD6WcHeyavgokgoLNjzdlL/pVVUoQWKxp37mjBspgTcbcg==
X-Google-Smtp-Source: AGHT+IHvSWaS/4RPfW90hh9vlkUFnr3/jZEmZEQ/kU6HSXtBV1A4Ec4J0MfVdqp5KT22dIZsxU/Hww==
X-Received: by 2002:a17:902:ce86:b0:211:efa9:a4e6 with SMTP id d9443c01a7336-21501287f97mr147122475ad.23.1732909136566;
        Fri, 29 Nov 2024 11:38:56 -0800 (PST)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219b01f1sm34349225ad.239.2024.11.29.11.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 11:38:56 -0800 (PST)
Date: Fri, 29 Nov 2024 11:38:53 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z0oYTbacS0lnO-jS@yury-ThinkPad>
References: <20241129181230.69213-1-arighi@nvidia.com>
 <20241129181230.69213-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129181230.69213-3-arighi@nvidia.com>

On Fri, Nov 29, 2024 at 06:54:32PM +0100, Andrea Righi wrote:
> Using a single global idle mask can lead to inefficiencies and a lot of
> stress on the cache coherency protocol on large systems with multiple
> NUMA nodes, since all the CPUs can create a really intense read/write
> activity on the single global cpumask.
> 
> Therefore, split the global cpumask into multiple per-NUMA node cpumasks
> to improve scalability and performance on large systems.
> 
> The concept is that each cpumask will track only the idle CPUs within
> its corresponding NUMA node, treating CPUs in other NUMA nodes as busy.
> In this way concurrent access to the idle cpumask will be restricted
> within each NUMA node.
> 
> [Open issue]
> 
> The scx_bpf_get_idle_cpu/smtmask() kfunc's, that are supposed to return
> a single cpumask for all the CPUs, have been changed to report only the
> cpumask of the current NUMA node (using the current CPU); this breaks
> the old behavior, so it can potentially introduce regressions in some
> scx schedulers.
> 
> An alternative approach could be to construct a global cpumask
> on-the-fly, but this could add significant overhead to ops.select_cpu()
> for schedulers relying on these kfunc's. Additionally, it would be less
> reliable than accessing the actual cpumasks, as the copy could quickly
> become out of sync and not represent the actual idle state very well.
> 
> Probably a better way to solve this issue is to introduce new kfunc's to
> explicitly select specific per-NUMA cpumask and modify the scx
> schedulers to transition to this new API, for example:
> 
>   const struct cpumask *scx_bpf_get_idle_numa_cpumask(int node)
>   const struct cpumask *scx_bpf_get_idle_numa_smtmask(int node)
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c | 115 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 79 insertions(+), 36 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 508845f0c25a..c10131171dfb 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -933,7 +933,37 @@ static struct delayed_work scx_watchdog_work;
>  static struct {
>  	cpumask_var_t cpu;
>  	cpumask_var_t smt;
> -} idle_masks CL_ALIGNED_IF_ONSTACK;
> +} **idle_masks CL_ALIGNED_IF_ONSTACK;
> +
> +static struct cpumask *get_idle_cpumask(int cpu)
> +{
> +	int node = cpu_to_node(cpu);
> +
> +	return idle_masks[node]->cpu;
> +}
> +
> +static struct cpumask *get_idle_smtmask(int cpu)
> +{
> +	int node = cpu_to_node(cpu);
> +
> +	return idle_masks[node]->smt;
> +}
> +
> +static void idle_masks_init(void)
> +{
> +	int node;
> +
> +	idle_masks = kcalloc(num_possible_nodes(), sizeof(*idle_masks), GFP_KERNEL);
> +	BUG_ON(!idle_masks);
> +
> +	for_each_node_state(node, N_POSSIBLE) {
> +		idle_masks[node] = kzalloc_node(sizeof(**idle_masks), GFP_KERNEL, node);
> +		BUG_ON(!idle_masks[node]);
> +
> +		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->cpu, GFP_KERNEL, node));
> +		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->smt, GFP_KERNEL, node));
> +	}
> +}
>  
>  #endif	/* CONFIG_SMP */
>  
> @@ -3156,39 +3186,48 @@ static bool test_and_clear_cpu_idle(int cpu)
>  	 */
>  	if (sched_smt_active()) {
>  		const struct cpumask *smt = cpu_smt_mask(cpu);
> +		struct cpumask *idle_smt = get_idle_smtmask(cpu);
>  
>  		/*
>  		 * If offline, @cpu is not its own sibling and
>  		 * scx_pick_idle_cpu() can get caught in an infinite loop as
> -		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
> -		 * is eventually cleared.
> +		 * @cpu is never cleared from the idle SMT mask. Ensure that
> +		 * @cpu is eventually cleared.
>  		 */
> -		if (cpumask_intersects(smt, idle_masks.smt))
> -			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
> -		else if (cpumask_test_cpu(cpu, idle_masks.smt))
> -			__cpumask_clear_cpu(cpu, idle_masks.smt);
> +		cpumask_andnot(idle_smt, idle_smt, smt);
> +		__cpumask_clear_cpu(cpu, idle_smt);
>  	}
>  #endif
> -	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
> +	return cpumask_test_and_clear_cpu(cpu, get_idle_cpumask(cpu));
>  }
>  
>  static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
>  {
> -	int cpu;
> +	int start = cpu_to_node(smp_processor_id());
> +	int node, cpu;
>  
>  retry:
>  	if (sched_smt_active()) {
> -		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
> -		if (cpu < nr_cpu_ids)
> -			goto found;
> +		for_each_node_state_wrap(node, N_ONLINE, start) {
> +			if (!cpumask_intersects(idle_masks[node]->smt, cpus_allowed))
> +				continue;
> +			cpu = cpumask_any_and_distribute(idle_masks[node]->smt, cpus_allowed);
> +			if (cpu < nr_cpu_ids)
> +				goto found;
> +		}

Here the same consideration is applicable as for v1:
if idle_masks[node]->smt and cpus_allowed are disjoint, the
cpumask_any_and_distribute() will return >= nr_cpu_ids, and we'll go to
the next iteration. No need to call cpumask_intersects(). 

>  
>  		if (flags & SCX_PICK_IDLE_CORE)
>  			return -EBUSY;
>  	}
>  
> -	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
> -	if (cpu >= nr_cpu_ids)
> -		return -EBUSY;
> +	for_each_node_state_wrap(node, N_ONLINE, start) {
> +		if (!cpumask_intersects(idle_masks[node]->cpu, cpus_allowed))
> +			continue;
> +		cpu = cpumask_any_and_distribute(idle_masks[node]->cpu, cpus_allowed);
> +		if (cpu < nr_cpu_ids)
> +			goto found;
> +	}
> +	return -EBUSY;
>  
>  found:
>  	if (test_and_clear_cpu_idle(cpu))
> @@ -3459,9 +3498,9 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  		 * piled up on it even if there is an idle core elsewhere on
>  		 * the system.
>  		 */
> -		if (!cpumask_empty(idle_masks.cpu) &&
> -		    !(current->flags & PF_EXITING) &&
> -		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
> +		if (!(current->flags & PF_EXITING) &&
> +		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
> +		    !cpumask_empty(get_idle_cpumask(cpu))) {
>  			if (cpumask_test_cpu(cpu, p->cpus_ptr))
>  				goto cpu_found;
>  		}
> @@ -3475,7 +3514,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  		/*
>  		 * Keep using @prev_cpu if it's part of a fully idle core.
>  		 */
> -		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
> +		if (cpumask_test_cpu(prev_cpu, get_idle_smtmask(prev_cpu)) &&
>  		    test_and_clear_cpu_idle(prev_cpu)) {
>  			cpu = prev_cpu;
>  			goto cpu_found;
> @@ -3618,12 +3657,18 @@ static void set_cpus_allowed_scx(struct task_struct *p,
>  
>  static void reset_idle_masks(void)
>  {
> +	int node;
> +
>  	/*
>  	 * Consider all online cpus idle. Should converge to the actual state
>  	 * quickly.
>  	 */
> -	cpumask_copy(idle_masks.cpu, cpu_online_mask);
> -	cpumask_copy(idle_masks.smt, cpu_online_mask);
> +	for_each_node_state(node, N_POSSIBLE) {
> +		const struct cpumask *node_mask = cpumask_of_node(node);
> +
> +		cpumask_and(idle_masks[node]->cpu, cpu_online_mask, node_mask);
> +		cpumask_copy(idle_masks[node]->smt, idle_masks[node]->cpu);
> +	}
>  }
>  
>  void __scx_update_idle(struct rq *rq, bool idle)
> @@ -3636,14 +3681,13 @@ void __scx_update_idle(struct rq *rq, bool idle)
>  			return;
>  	}
>  
> -	if (idle)
> -		cpumask_set_cpu(cpu, idle_masks.cpu);
> -	else
> -		cpumask_clear_cpu(cpu, idle_masks.cpu);
> +	assign_cpu(cpu, get_idle_cpumask(cpu), idle);
>  
>  #ifdef CONFIG_SCHED_SMT
>  	if (sched_smt_active()) {
>  		const struct cpumask *smt = cpu_smt_mask(cpu);
> +		struct cpumask *idle_cpu = get_idle_cpumask(cpu);
> +		struct cpumask *idle_smt = get_idle_smtmask(cpu);
>  
>  		if (idle) {
>  			/*
> @@ -3651,12 +3695,12 @@ void __scx_update_idle(struct rq *rq, bool idle)
>  			 * it's only for optimization and self-correcting.
>  			 */
>  			for_each_cpu(cpu, smt) {
> -				if (!cpumask_test_cpu(cpu, idle_masks.cpu))
> +				if (!cpumask_test_cpu(cpu, idle_cpu))
>  					return;
>  			}
> -			cpumask_or(idle_masks.smt, idle_masks.smt, smt);
> +			cpumask_or(idle_smt, idle_smt, smt);
>  		} else {
> -			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
> +			cpumask_andnot(idle_smt, idle_smt, smt);
>  		}
>  	}
>  #endif
> @@ -6232,8 +6276,7 @@ void __init init_sched_ext_class(void)
>  
>  	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
>  #ifdef CONFIG_SMP
> -	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
> -	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
> +	idle_masks_init();
>  #endif
>  	scx_kick_cpus_pnt_seqs =
>  		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
> @@ -7379,7 +7422,7 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
>  
>  /**
>   * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
> - * per-CPU cpumask.
> + * per-CPU cpumask of the current NUMA node.
>   *
>   * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
>   */
> @@ -7391,7 +7434,7 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
>  	}
>  
>  #ifdef CONFIG_SMP
> -	return idle_masks.cpu;
> +	return get_idle_cpumask(smp_processor_id());
>  #else
>  	return cpu_none_mask;
>  #endif
> @@ -7399,8 +7442,8 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
>  
>  /**
>   * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
> - * per-physical-core cpumask. Can be used to determine if an entire physical
> - * core is free.
> + * per-physical-core cpumask of the current NUMA node. Can be used to determine
> + * if an entire physical core is free.
>   *
>   * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
>   */
> @@ -7413,9 +7456,9 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
>  
>  #ifdef CONFIG_SMP
>  	if (sched_smt_active())
> -		return idle_masks.smt;
> +		return get_idle_smtmask(smp_processor_id());
>  	else
> -		return idle_masks.cpu;
> +		return get_idle_cpumask(smp_processor_id());
>  #else
>  	return cpu_none_mask;
>  #endif
> -- 
> 2.47.1

