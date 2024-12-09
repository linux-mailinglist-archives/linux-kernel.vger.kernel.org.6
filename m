Return-Path: <linux-kernel+bounces-438319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0D19E9FB3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13902280A24
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8622197A68;
	Mon,  9 Dec 2024 19:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iipk+jMF"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6161914E2CC
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772781; cv=none; b=Sj33+qALvIleU2tlP2dfkn3gwsyNaBI0ws8yRYUuqNwTmgdEanusoPwIHJYC2hKra8ATRbX4z83dNcD7FYbSR+yRCOPMMrsXNi83JdttorqbRn33czQmCllbQ7tFO2wLy9EMQwRpzIprppgkF3fsroG2n1h8fY8ccT9axmAqeyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772781; c=relaxed/simple;
	bh=pQ22r6uZcmF/8EdPMzgvO6J3rHW63xWihLbkw2dPZAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ecp6Gz+wdFX3EYCHIfdyPKGQfD1j2glRfBGg1rEYqNQGKY3kyIrgtRwBOQg4dWyjnRj6rVVdhdnkZtGCy6eB2CimCxc1yZRmrV6adaOSI49DYT7OU5ymx+b3hnc2XvGeD3zMUxgqY0olG6YQhbcqctEiP6t80ZnESG6O+KgKtoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iipk+jMF; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ef7f8d4f30so37637307b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 11:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733772778; x=1734377578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXDfo6Jl3nsI66EagCUadtbLEoh2Hrf/ltiVcF+GY8g=;
        b=iipk+jMFS4eqU9SvKvvFlU2P1aVMdK30YA0VMaXNdxEVOlIzGZqHM2lJJLuuOUN5tW
         N3t5Hgph6VndFiVEMmUmlUQSzYh+joqrb1TnttauAq73cdh2O8r2sMImFHdMbMZ47meL
         +8J/iYYhm/qWbGmy4+dmaLCYIbSDVrMwdzIfvDF6UYQl0+fEcRUlwpE3pyrUSWtLJRxy
         VRK/mExuMT4Y8CCx2ih6jMLJSQBX0sm+DOTE1HcB8tO8sZRlFTSscC7XOq6Z0bL8xeCh
         f8I7kVsUfc+uI8J0HAfc7lylTn8u9hWKr9+qQm4kwNijc5zfTfO9mxNWX5aw9p+PfeG0
         vyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733772778; x=1734377578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXDfo6Jl3nsI66EagCUadtbLEoh2Hrf/ltiVcF+GY8g=;
        b=H8ulx5TMxwFU3xGy8O4LDI/1iz2ghaECxuQOtlaQaEDGNvYLDOT1XI7exl6FBFyBnJ
         QWOuFtfidEslc3QadCgtrHsyKnLTI7hRTng2twTlE7lhuxeiIvvPr0HP1gvlDsBWX7wt
         zcv4lQHCxnLJIQ8qB8Bc7/3g++wUqfhptW5aAAUL+nRXsuyKJVr+oLEGFXCTa2wQUA/b
         DSYyqbsAysa2uQOhd2+7H7zsMy3aYpeFmDI+vfV33praEi0qNBhPtMHMMmyh7twFTsb/
         tQXjZcaGtcCJ+PMiIKWXVBcB7zBUjz7oSWLIL0dx24TUIEkX980lShiouhFxcSyH1xx3
         r21g==
X-Forwarded-Encrypted: i=1; AJvYcCWkHaSF0G/TmufZ9Ne5r3izVLyd8+7arpoUKBjYM29X4yESlOoD9mQlaZIsDFS1dlfjhBM5NnkfrKWlDn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gY/aqFO5Wwoi6MoID5MyMGmUTv6Wu9JbJheDnzZCHOiU0aMM
	Jb6Cr0sBByc6sDUF+6/Wn15Jl3HjaVSvNvHr/B+x1Q4vNOM+EuUB
X-Gm-Gg: ASbGncsEQvbise4wa3S9Jg/iLWD3Yo/OgtcoeMqw3+aUbS2U+zYRkuoSHwFJpiy/SPp
	PEI7al8V7rSLeXtm7/2rh49bKlGTFk1Ig9p4M9OeymB3rWVbyyEEYkgFsDah2po6pNdRPvmrimt
	1H+MHJPdYhqh0yDdk4tXP+GMn88WKwu2sjrKXS2cMU05xFHwQgFXKsrusCiX6HnU2fX+sbBuXl9
	xAGRzqdOyz1y1vKBshEG1kTL0wRJCI70UmwOvVzoeUIELDDOoDo7GSzbsKZPhNhgKgv4su62Z88
	g8w3MJ+Epg==
X-Google-Smtp-Source: AGHT+IFZfX9JO2ddNGDWDcjWiKQ41mlp1ChXs0T6Z9pBDGa+MYdcNv5+4ZiD7h1K9jHKcPjdtfyizg==
X-Received: by 2002:a05:690c:670d:b0:6ef:8451:dd99 with SMTP id 00721157ae682-6f022eb2631mr22542437b3.24.1733772777715;
        Mon, 09 Dec 2024 11:32:57 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6efe5c1c37esm18907457b3.79.2024.12.09.11.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:32:57 -0800 (PST)
Date: Mon, 9 Dec 2024 11:32:56 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z1dF6HuEI2nyUD2V@yury-ThinkPad>
References: <20241209104632.718085-1-arighi@nvidia.com>
 <20241209104632.718085-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209104632.718085-2-arighi@nvidia.com>

On Mon, Dec 09, 2024 at 11:40:55AM +0100, Andrea Righi wrote:
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
> NOTE: the scx_bpf_get_idle_cpu/smtmask() kfunc's, that are supposed to
> return a single cpumask for all the CPUs, have been changed to report
> only the cpumask of the current NUMA node (using the current CPU).
> 
> This is breaking the old behavior, but it will be addressed in the next
> commits, introducing a new flag to switch between the old single global
> flat idle cpumask or the multiple per-node cpumasks.

Why don't you change the order of commits such that you first
introduce the flag and then add new feature? That way you'll not have
to explain yourself.

Also, the kernel/sched/ext.c is already 7k+ LOCs. Can you move the
per-node idle masks to a separate file? You can also make this feature
configurable, and those who don't care (pretty much everyone except
for PLATINUM 8570 victims, right?) will not have to even compile it.

I'd like to see it enabled only for those who can really benefit from it.

> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c | 221 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 166 insertions(+), 55 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 71342f3719c1..7e7f2869826f 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -933,8 +933,60 @@ static struct delayed_work scx_watchdog_work;
>  static struct {
>  	cpumask_var_t cpu;
>  	cpumask_var_t smt;
> -} idle_masks CL_ALIGNED_IF_ONSTACK;
> +} **idle_masks CL_ALIGNED_IF_ONSTACK;
>  
> +static struct cpumask *get_idle_cpumask_node(int node)
> +{
> +	return idle_masks[node]->cpu;
> +}
> +
> +static struct cpumask *get_idle_smtmask_node(int node)
> +{
> +	return idle_masks[node]->smt;
> +}

This implies that NUMA_NO_NODE, which is -1, will never be passed.
Is that indeed impossible?

> +
> +static struct cpumask *get_curr_idle_cpumask(void)
> +{
> +	int node = cpu_to_node(smp_processor_id());
> +
> +	return get_idle_cpumask_node(node);
> +}
> +
> +static struct cpumask *get_curr_idle_smtmask(void)
> +{
> +	int node = cpu_to_node(smp_processor_id());
> +
> +	if (sched_smt_active())
> +		return get_idle_smtmask_node(node);
> +	else
> +		return get_idle_cpumask_node(node);
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

for_each_node(node)

> +		idle_masks[node] = kzalloc_node(sizeof(**idle_masks), GFP_KERNEL, node);
> +		BUG_ON(!idle_masks[node]);
> +
> +		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->cpu, GFP_KERNEL, node));
> +		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->smt, GFP_KERNEL, node));
> +	}
> +}
> +#else	/* !CONFIG_SMP */
> +static struct cpumask *get_curr_idle_cpumask(void)
> +{
> +	return cpu_none_mask;
> +}
> +
> +static struct cpumask *get_curr_idle_smtmask(void)
> +{
> +	return cpu_none_mask;
> +}
>  #endif	/* CONFIG_SMP */
>  
>  /* for %SCX_KICK_WAIT */
> @@ -3166,6 +3218,9 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
>  
>  static bool test_and_clear_cpu_idle(int cpu)
>  {
> +	int node = cpu_to_node(cpu);
> +	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
> +
>  #ifdef CONFIG_SCHED_SMT
>  	/*
>  	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
> @@ -3174,29 +3229,34 @@ static bool test_and_clear_cpu_idle(int cpu)
>  	 */
>  	if (sched_smt_active()) {
>  		const struct cpumask *smt = cpu_smt_mask(cpu);
> +		struct cpumask *idle_smt = get_idle_smtmask_node(node);
>  
>  		/*
>  		 * If offline, @cpu is not its own sibling and
>  		 * scx_pick_idle_cpu() can get caught in an infinite loop as
> -		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
> -		 * is eventually cleared.
> +		 * @cpu is never cleared from the idle SMT mask. Ensure that
> +		 * @cpu is eventually cleared.
> +		 *
> +		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
> +		 * reduce memory writes, which may help alleviate cache
> +		 * coherence pressure.
>  		 */
> -		if (cpumask_intersects(smt, idle_masks.smt))
> -			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
> -		else if (cpumask_test_cpu(cpu, idle_masks.smt))
> -			__cpumask_clear_cpu(cpu, idle_masks.smt);
> +		if (cpumask_intersects(smt, idle_smt))
> +			cpumask_andnot(idle_smt, idle_smt, smt);
> +		else if (cpumask_test_cpu(cpu, idle_smt))
> +			__cpumask_clear_cpu(cpu, idle_smt);
>  	}
>  #endif
> -	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
> +	return cpumask_test_and_clear_cpu(cpu, idle_cpu);
>  }
>  
> -static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> +static s32 scx_pick_idle_cpu_from_node(int node, const struct cpumask *cpus_allowed, u64 flags)
>  {
>  	int cpu;
>  
>  retry:
>  	if (sched_smt_active()) {
> -		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
> +		cpu = cpumask_any_and_distribute(get_idle_smtmask_node(node), cpus_allowed);
>  		if (cpu < nr_cpu_ids)
>  			goto found;
>  
> @@ -3204,15 +3264,66 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
>  			return -EBUSY;
>  	}
>  
> -	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
> -	if (cpu >= nr_cpu_ids)
> -		return -EBUSY;
> +	cpu = cpumask_any_and_distribute(get_idle_cpumask_node(node), cpus_allowed);
> +	if (cpu < nr_cpu_ids)
> +		goto found;
> +
> +	return -EBUSY;

What for did you change the error handling logic? Can you keep the
original?

>  
>  found:
>  	if (test_and_clear_cpu_idle(cpu))
>  		return cpu;
>  	else
>  		goto retry;
> +
> +}
> +
> +static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
> +{
> +	const struct cpumask *node_mask;
> +	s32 cpu;
> +
> +	/*
> +	 * Only node 0 is used if per-node idle cpumasks are disabled.
> +	 */
> +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> +		return scx_pick_idle_cpu_from_node(0, cpus_allowed, flags);
> +
> +	/*
> +	 * Traverse all nodes in order of increasing distance, starting from
> +	 * prev_cpu's node.
> +	 */
> +	rcu_read_lock();
> +	for_each_numa_hop_mask(node_mask, cpu_to_node(prev_cpu)) {

This 'node_mask' misleads. This is not a nodemask. This is a cpumask -
all cpus in the hop. Can you name it 'hop_cpus', or similar?

> +		/*
> +		 * scx_pick_idle_cpu_from_node() can be expensive and redundant
> +		 * if none of the CPUs in the NUMA node can be used (according
> +		 * to cpus_allowed).
> +		 *
> +		 * Therefore, check if the NUMA node is usable in advance to
> +		 * save some CPU cycles.
> +		 */
> +		if (!cpumask_intersects(node_mask, cpus_allowed))
> +			continue;
> +
> +		/*
> +		 * It would be nice to have a "node" iterator, instead of the
> +		 * cpumask, to get rid of the cpumask_first() to determine the
> +		 * node.
> +		 */

I'm not aware about such case. And this one doesn't look like that because you
filter against a cpumask (cpus_allowed). Right?

> +		cpu = cpumask_first(node_mask);
> +		if (cpu >= nr_cpu_ids)
> +			continue;

for_each_numa_hop_mask() doesn't traverse per-node CPUs. It traverses
per-hop CPUs. The difference is that the hop may include more than one
node if distances from a given node to those belonging the hop are the
same.

So, imagine we have nodes 1 and 2 in the same hop, but cpus_allowed
has only cpus from node 2. With this configuration you pass the
cpumask_intersects() check, but when picking a CPU, you ignore the
cpus_allowed and pick node 1. This is wrong, I guess.

Instead, I would make a single check:

        cpu = cpumask_first_and(node_mask, cpus_allowed);
        if (cpu >= nr_cpu_ids)
                continue;

> +
> +		cpu = scx_pick_idle_cpu_from_node(cpu_to_node(cpu), cpus_allowed, flags);
> +		if (cpu >= 0)
> +			goto out_unlock;

The code in scx_pick_idle_cpu_from_node() is written such that CPUs
that your picks are well distributed across the nodes. Your code above
always picks 1st node in the hop. I think here you should use 

        cpumask_any_and_distribute()
 
like the scx_pick_idle_cpu_from_node() does with idle_masks.

Another problem is that high-level hops include CPUs from lower-level
ones. It means that you will traverse the same lower-level CPUs again
for nothing. So, you need to mask them out.

Another-another problem: if your hop has more than one node, you should
not jump to the next hop until you tried every node from the current hop.
This brings another loop, but doesn't increase complexity if you
carefully mask-out all visited nodes.

> +	}
> +	cpu = -EBUSY;

This hides the actual error returned from scx_pick_idle_cpu_from_node().

> +
> +out_unlock:
> +	rcu_read_unlock();
> +	return cpu;
>  }

And altogether this should look like:

 int scx_pick_idle_cpu_from_hop(struct cpumask *hop_cpus, struct cpumask *cpus_allowed)
 {
         int node, cpu, random_cpu;

         do {

                 /* Pick a 'random' CPU in the hop */
                 random_cpu = cpumask_any_and_distribute(hop_cpus, cpus_allowed);
                 if (random_cpu >= nr_cpu_ids)
                         continue;

                 node = cpu_to_node(random_cpu);

                 /* Find an idle CPU in the same node */
                 cpu = scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
                 if (cpu >= 0)
                         break;

                 /* No luck? Try other nodes */
         } while (cpumask_andnot(hop_cpus, hop_cpus, cpumask_of_node(node)));

         return cpu;
 }

 static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
 {
        const struct cpumask *next, *prev = cpu_none_mask;
        int prev_node = cpu_to_node(prev_cpu);
 ...
	for_each_numa_hop_mask(next, prev_node) {
                cpumask_andnot(hop_cpus, next, prev);
                cpu = scx_pick_idle_cpu_from_hop(hop_cpus, cpus_allowed);
                prev = next;
        }
 ...
 }

Not tested, but should work.

>  /*
> @@ -3420,6 +3531,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  {
>  	const struct cpumask *llc_cpus = NULL;
>  	const struct cpumask *numa_cpus = NULL;
> +	int node = cpu_to_node(prev_cpu);
>  	s32 cpu;
>  
>  	*found = false;
> @@ -3477,9 +3589,9 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  		 * piled up on it even if there is an idle core elsewhere on
>  		 * the system.
>  		 */
> -		if (!cpumask_empty(idle_masks.cpu) &&
> -		    !(current->flags & PF_EXITING) &&
> -		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
> +		if (!(current->flags & PF_EXITING) &&
> +		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
> +		    !cpumask_empty(get_idle_cpumask_node(cpu_to_node(cpu)))) {
>  			if (cpumask_test_cpu(cpu, p->cpus_ptr))
>  				goto cpu_found;
>  		}
> @@ -3493,7 +3605,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  		/*
>  		 * Keep using @prev_cpu if it's part of a fully idle core.
>  		 */
> -		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
> +		if (cpumask_test_cpu(prev_cpu, get_idle_smtmask_node(node)) &&
>  		    test_and_clear_cpu_idle(prev_cpu)) {
>  			cpu = prev_cpu;
>  			goto cpu_found;
> @@ -3503,7 +3615,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  		 * Search for any fully idle core in the same LLC domain.
>  		 */
>  		if (llc_cpus) {
> -			cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
> +			cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, SCX_PICK_IDLE_CORE);
>  			if (cpu >= 0)
>  				goto cpu_found;
>  		}
> @@ -3512,7 +3624,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  		 * Search for any fully idle core in the same NUMA node.
>  		 */
>  		if (numa_cpus) {
> -			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
> +			cpu = scx_pick_idle_cpu_from_node(node, numa_cpus, SCX_PICK_IDLE_CORE);
>  			if (cpu >= 0)
>  				goto cpu_found;
>  		}
> @@ -3520,7 +3632,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  		/*
>  		 * Search for any full idle core usable by the task.
>  		 */
> -		cpu = scx_pick_idle_cpu(p->cpus_ptr, SCX_PICK_IDLE_CORE);
> +		cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, SCX_PICK_IDLE_CORE);
>  		if (cpu >= 0)
>  			goto cpu_found;
>  	}
> @@ -3537,7 +3649,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  	 * Search for any idle CPU in the same LLC domain.
>  	 */
>  	if (llc_cpus) {
> -		cpu = scx_pick_idle_cpu(llc_cpus, 0);
> +		cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, 0);
>  		if (cpu >= 0)
>  			goto cpu_found;
>  	}
> @@ -3546,7 +3658,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  	 * Search for any idle CPU in the same NUMA node.
>  	 */
>  	if (numa_cpus) {
> -		cpu = scx_pick_idle_cpu(numa_cpus, 0);
> +		cpu = scx_pick_idle_cpu_from_node(node, numa_cpus, 0);
>  		if (cpu >= 0)
>  			goto cpu_found;
>  	}
> @@ -3554,7 +3666,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  	/*
>  	 * Search for any idle CPU usable by the task.
>  	 */
> -	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
> +	cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, 0);
>  	if (cpu >= 0)
>  		goto cpu_found;
>  
> @@ -3636,17 +3748,27 @@ static void set_cpus_allowed_scx(struct task_struct *p,
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

for_each_node()

> +		const struct cpumask *node_mask = cpumask_of_node(node);
> +		struct cpumask *idle_cpu = get_idle_cpumask_node(node);
> +		struct cpumask *idle_smt = get_idle_smtmask_node(node);
> +
> +		cpumask_and(idle_cpu, cpu_online_mask, node_mask);
> +		cpumask_copy(idle_smt, idle_cpu);
> +	}
>  }
>  
>  void __scx_update_idle(struct rq *rq, bool idle)
>  {
>  	int cpu = cpu_of(rq);
> +	int node = cpu_to_node(cpu);
> +	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
>  
>  	if (SCX_HAS_OP(update_idle) && !scx_rq_bypassing(rq)) {
>  		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
> @@ -3654,27 +3776,25 @@ void __scx_update_idle(struct rq *rq, bool idle)
>  			return;
>  	}
>  
> -	if (idle)
> -		cpumask_set_cpu(cpu, idle_masks.cpu);
> -	else
> -		cpumask_clear_cpu(cpu, idle_masks.cpu);
> +	assign_cpu(cpu, idle_cpu, idle);
>  
>  #ifdef CONFIG_SCHED_SMT
>  	if (sched_smt_active()) {
>  		const struct cpumask *smt = cpu_smt_mask(cpu);
> +		struct cpumask *idle_smt = get_idle_smtmask_node(node);
>  
>  		if (idle) {
>  			/*
> -			 * idle_masks.smt handling is racy but that's fine as
> -			 * it's only for optimization and self-correcting.
> +			 * idle_smt handling is racy but that's fine as it's
> +			 * only for optimization and self-correcting.
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
> @@ -3722,7 +3842,10 @@ static void rq_offline_scx(struct rq *rq)
>  #else	/* CONFIG_SMP */
>  
>  static bool test_and_clear_cpu_idle(int cpu) { return false; }
> -static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags) { return -EBUSY; }
> +static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
> +{
> +	return -EBUSY;
> +}
>  static void reset_idle_masks(void) {}
>  
>  #endif	/* CONFIG_SMP */
> @@ -6255,8 +6378,7 @@ void __init init_sched_ext_class(void)
>  
>  	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
>  #ifdef CONFIG_SMP
> -	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
> -	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
> +	idle_masks_init();
>  #endif
>  	scx_kick_cpus_pnt_seqs =
>  		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
> @@ -7402,7 +7524,7 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
>  
>  /**
>   * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
> - * per-CPU cpumask.
> + * per-CPU cpumask of the current NUMA node.
>   *
>   * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
>   */
> @@ -7413,17 +7535,13 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
>  		return cpu_none_mask;
>  	}
>  
> -#ifdef CONFIG_SMP
> -	return idle_masks.cpu;
> -#else
> -	return cpu_none_mask;
> -#endif
> +	return get_curr_idle_cpumask();
>  }
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
> @@ -7434,14 +7552,7 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
>  		return cpu_none_mask;
>  	}
>  
> -#ifdef CONFIG_SMP
> -	if (sched_smt_active())
> -		return idle_masks.smt;
> -	else
> -		return idle_masks.cpu;
> -#else
> -	return cpu_none_mask;
> -#endif
> +	return get_curr_idle_smtmask();
>  }
>  
>  /**
> @@ -7508,7 +7619,7 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
>  		return -EBUSY;
>  	}
>  
> -	return scx_pick_idle_cpu(cpus_allowed, flags);
> +	return scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
>  }
>  
>  /**
> @@ -7531,7 +7642,7 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
>  	s32 cpu;
>  
>  	if (static_branch_likely(&scx_builtin_idle_enabled)) {
> -		cpu = scx_pick_idle_cpu(cpus_allowed, flags);
> +		cpu = scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
>  		if (cpu >= 0)
>  			return cpu;
>  	}
> -- 
> 2.47.1

