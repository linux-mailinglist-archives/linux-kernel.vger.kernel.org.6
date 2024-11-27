Return-Path: <linux-kernel+bounces-422971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D937F9DA0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 03:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A84628268B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 02:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90E52E859;
	Wed, 27 Nov 2024 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmOnq/Qh"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1302B77112
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732674922; cv=none; b=LtKPXzxZRfsqr45swfRn3VB79nR8E2yj6LTunVhW09Vx9ddUL/lI9K79bnTSeJjyibQ/o739NCg1Kkh2bX4fpc01ae2a/0WEOh2H5Z3IxUGw/k0zbg8HGn9I6/0dVkzkqZGvSDKnj5+d6NpqCq9sewqVgyjrA3Se/ECk60zz/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732674922; c=relaxed/simple;
	bh=YFFhjxBYCI8R3xKn/OWERghkPwp55GW77M7uWiSDgFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPc9aEmgUYCoGRVsEpz5vYWrJ+iRPU90q75qL23KQ+kiTmbiPHH11wimJ/8CwsUmjFY6nuzE6kp+haHLu8e57lRvo5Rtu0uSagF63fR1Ocaq8g74TUQeLeM2doSvHewtbmpulsyPJBfAZw90B9MtaxnQN8tp4P1vzglAvbbkicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmOnq/Qh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-724f41d550cso2453283b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732674920; x=1733279720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/2tmddblsLbw5WrjKiCilncGLR40FO9o1UMwc/1in0Y=;
        b=XmOnq/QhEA4SBZpFHY3h2s8kEVRKFThV9e3bTCTDTeF05N7IKzS/pCBfuz7b14zrGT
         SVMPPsuN1yvEkB2I72TWlhKjzrkpS+NNr2B3S0uFhs++0F4lOk+mvWpmls5po466h0jC
         9Y9f0zBRa3PTgSg4tdsi5mIlyuLk1x3FgGDrUUXf7JOuCJtLtBoRbtUsDMQlXyEGxHuu
         3Sf4OS4AXh2dPLwaRVryH4IEqQ92tTlmTix3KFs3SWu91CQPvaWscUe46PJWTu54OsY0
         vzNm16V5uD0qrdhJV1mYAT+5qE1j9NbxsWU8L1wJ6PSEzgr7Eppmft9QI6Twr9EUh4Od
         yGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732674920; x=1733279720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2tmddblsLbw5WrjKiCilncGLR40FO9o1UMwc/1in0Y=;
        b=IHsy80ZZeCujdVlRst3TtBk5loiay+CIgLJRj19z6Vun09VO3mOtwkIZkKRNl44t3i
         1PKq1C1IFZwSk8EQ7JbVKx3AzzR/oijhwJZPYFLeXb75YWyYpNgqKQ3tF2X7ogEy8LSs
         h5ObhtRCdqzVFy3xNdsUSD1VaPvfsX8iehNnmThRqEanpqsIyyiq/mev7yC6wDsKTH39
         0VLfq3hTgm+qxiVes1TyIthF+vNURnNYzGXev159gZoK1jCi7KcRzLgSuL7z+qBeMJXX
         IfoRqO8jXwpookCUZZoCLGhtxnwOfKhs43EASwqzVCezTicQcBfrJwCPYi4CSrT9+c/J
         K1uw==
X-Forwarded-Encrypted: i=1; AJvYcCXw2Oh+12ql8ymX+B3RWZu3mCr/gRaonzNhr5BkBw+2qbfm7LLTbwYx1GZZYx4bExNk1r62VJUiIbZTme8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Ei/pRkiEJhsiWODJw0ZV+cNdSK/NmIEReO/q+7G81WLrzYDn
	hQ7+Tl7a7obGlM2izFX1K1artYB5cvaEyca2EQlKJ4lYv90SESlY
X-Gm-Gg: ASbGnctrjhmc/UGyGsZ2ZRL7M2pCyzm3rC2aZ07uLJaL26LEW/oObZl/gRIHVNaF2r4
	pZ3k8i8DBY0kLDxh4HtjXl/nPgvm6R6527Jio0QQAH4N+diW0fr44Y29V4pNJYiLEo1Sy3j8d1N
	W9cUF4ecW/OBvni7Lsgb7cZRupGViDe/aJU4OLmc5ILWW6mQV2sdCAE0Tbhd2SGhUNCmowJr3/z
	GvtWCTaGM8L7MjToLrMMWGZpB6y+FJQPGxs1hZlrTqCRK6PZQ==
X-Google-Smtp-Source: AGHT+IEDGk+9SHGrV88cpOaAWUxUBYTsG08yWGeYLxNVAnGPFOW5RO6nqlFc5Jmp2bdTGrau9XhrRw==
X-Received: by 2002:a05:6a00:3c8c:b0:71e:6489:d18 with SMTP id d2e1a72fcca58-72530163068mr1907383b3a.22.1732674920161;
        Tue, 26 Nov 2024 18:35:20 -0800 (PST)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de558bcbsm9140064b3a.152.2024.11.26.18.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 18:35:19 -0800 (PST)
Date: Tue, 26 Nov 2024 18:35:16 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z0aFZJZ85LUwapZE@yury-ThinkPad>
References: <20241126101259.52077-1-arighi@nvidia.com>
 <20241126101259.52077-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126101259.52077-3-arighi@nvidia.com>

On Tue, Nov 26, 2024 at 10:56:40AM +0100, Andrea Righi wrote:
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

This all is definitely a complication of the code. Have you any numbers to
justify it?
 
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
>  kernel/sched/ext.c | 110 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 78 insertions(+), 32 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 3c4a94e4258f..ea2fae2db10e 100644
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
> +		if (cpumask_intersects(smt, idle_smt))
> +			cpumask_andnot(idle_smt, idle_smt, smt);

cpumask_andnot() is a no-op if masks don't intersect.
cpumask_intersects() is O(N), and you can safely drop it and
save some cycles.

> +		else if (cpumask_test_cpu(cpu, idle_smt))
> +			__cpumask_clear_cpu(cpu, idle_smt);

Same here. If the CPU is clear, __cpumask_clear_cpu() is a no-op.
I feel like you can just clear all that CPUs unconditionally. In
the worst case, you'll clear them twice, which is harmless. Or I
misunderstand something?

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
> +	int node, cnt, cpu;
>  
>  retry:
>  	if (sched_smt_active()) {
> -		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
> -		if (cpu < nr_cpu_ids)
> -			goto found;
> +		for_each_node_state_from(node, N_ONLINE, start, cnt) {
> +			cpu = cpumask_any_and_distribute(idle_masks[node]->smt,
> +							 cpus_allowed);

Nit: no need to break the line here.

> +			if (cpu < nr_cpu_ids)
> +				goto found;
> +		}
>  
>  		if (flags & SCX_PICK_IDLE_CORE)
>  			return -EBUSY;
>  	}
>  
> -	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
> -	if (cpu >= nr_cpu_ids)
> -		return -EBUSY;
> +	for_each_node_state_from(node, N_ONLINE, start, cnt) {
> +		cpu = cpumask_any_and_distribute(idle_masks[node]->cpu,
> +						 cpus_allowed);
> +		if (cpu < nr_cpu_ids)
> +			goto found;
> +	}
> +	return -EBUSY;
>  
>  found:
>  	if (test_and_clear_cpu_idle(cpu))
> @@ -3401,7 +3440,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  		 * piled up on it even if there is an idle core elsewhere on
>  		 * the system.
>  		 */
> -		if (!cpumask_empty(idle_masks.cpu) &&
> +		if (!cpumask_empty(get_idle_cpumask(cpu)) &&
>  		    !(current->flags & PF_EXITING) &&
>  		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
>  			if (cpumask_test_cpu(cpu, p->cpus_ptr))

cpumask_empty() is O(N), and the other checks are O(1). If you reorder
them such that cpumask_empty() would be the last check, you can
increase probability that you will not check it at all.

> @@ -3417,7 +3456,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  		/*
>  		 * Keep using @prev_cpu if it's part of a fully idle core.
>  		 */
> -		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
> +		if (cpumask_test_cpu(prev_cpu, get_idle_smtmask(prev_cpu)) &&
>  		    test_and_clear_cpu_idle(prev_cpu)) {
>  			cpu = prev_cpu;
>  			goto cpu_found;
> @@ -3560,12 +3599,18 @@ static void set_cpus_allowed_scx(struct task_struct *p,
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
> +		cpumask_and(idle_masks[node]->smt, cpu_online_mask, node_mask);

cpumask_copy(idle_masks[node]->smt, idle_masks[node]->cpu)

> +	}
>  }
>  
>  void __scx_update_idle(struct rq *rq, bool idle)
> @@ -3579,13 +3624,15 @@ void __scx_update_idle(struct rq *rq, bool idle)
>  	}
>  
>  	if (idle)
> -		cpumask_set_cpu(cpu, idle_masks.cpu);
> +		cpumask_set_cpu(cpu, get_idle_cpumask(cpu));
>  	else
> -		cpumask_clear_cpu(cpu, idle_masks.cpu);
> +		cpumask_clear_cpu(cpu, get_idle_cpumask(cpu));

assign_cpu(cpu, get_idle_cpumask(cpu), idle)

Thanks,
Yury

>  
>  #ifdef CONFIG_SCHED_SMT
>  	if (sched_smt_active()) {
>  		const struct cpumask *smt = cpu_smt_mask(cpu);
> +		struct cpumask *idle_cpu = get_idle_cpumask(cpu);
> +		struct cpumask *idle_smt = get_idle_smtmask(cpu);
>  
>  		if (idle) {
>  			/*
> @@ -3593,12 +3640,12 @@ void __scx_update_idle(struct rq *rq, bool idle)
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
> @@ -6174,8 +6221,7 @@ void __init init_sched_ext_class(void)
>  
>  	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
>  #ifdef CONFIG_SMP
> -	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
> -	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
> +	idle_masks_init();
>  #endif
>  	scx_kick_cpus_pnt_seqs =
>  		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
> @@ -7321,7 +7367,7 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
>  
>  /**
>   * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
> - * per-CPU cpumask.
> + * per-CPU cpumask of the current NUMA node.
>   *
>   * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
>   */
> @@ -7333,7 +7379,7 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
>  	}
>  
>  #ifdef CONFIG_SMP
> -	return idle_masks.cpu;
> +	return get_idle_cpumask(smp_processor_id());
>  #else
>  	return cpu_none_mask;
>  #endif
> @@ -7341,8 +7387,8 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
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
> @@ -7355,9 +7401,9 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
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
> 2.47.0

