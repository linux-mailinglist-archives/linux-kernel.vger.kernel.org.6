Return-Path: <linux-kernel+bounces-571057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10961A6B892
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8E03B646A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EF81F2BA4;
	Fri, 21 Mar 2025 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QFDzlmE3"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BB01EA7E3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552161; cv=none; b=pIMUpKM/Ql6L9seD/0Th51iYQvISL7nSta+odpIoiIZR6RqxxRgfFC74E2RBO3Ap603zx01FGTQC4MC5mozH+mQEMxfRpHdSWCR+ubpfg6oL4gvw0qSprNGpgxhulO0mTENFS40O/B0SFiFMOlvHNizwWUMZaKc9ifPBvWtmSdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552161; c=relaxed/simple;
	bh=F11BMJdh6ERI7+h/4obdT2A+8mFbi3+r9NRzEDK34mU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Pb1HMpBOwZbXhJBJGSOTkz1BmjHq+AJ4W1xCaA6sCpmf1QbeBzEUnRLot0dPt9iM8kkWaWXnYpjNnBVxYVS6bsVv3BGU2nmncviX5d4BfaB6qoFN1sDvqzehxbaJ1m3ekpiRKNFT1OcfrkG9ODSG9GiqtksdBBm2PvVPAHaYd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QFDzlmE3; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0XuNPdHu9UK90Cq1vG5kkz5iKvTEhoBs69F28DrlPDY=; b=QFDzlmE3OApTxRbLTehBVMjdID
	U7dTaCa0wNJW3NJcfaxBti0A3lWNAhlxmDYQ247VHXCdTwOkk/Jh0jMUJwmbYuZJTDgGIG8hZSHbq
	iyzIbUGllZDemEeL+o1aUPh4/GYm3Ideq/sFckhBFelsyWqfW9wnL37LbGXsi7hASj3eZCJt4MS4X
	WR/xVEzz70xW+O1jQGsp39BwTErSyPxs92UVOkZe9QB9fzI78OdZhn/64dtYJGj5Zwy/i84vYGaWj
	omlwb4THVI6sVWP0TpsXUm5UfukGw6HP8g7YP/RTgb0Qe8E09fbKm7WFZLley0giXu3UOTHWvBFTV
	leHTNZOg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tvZPg-0049GN-0H; Fri, 21 Mar 2025 11:15:40 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1tvZPe-005HSF-10; Fri, 21 Mar 2025 11:15:39 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <changwoo@igalia.com>)
	id 1tvZPS-00ALqy-1C;
	Fri, 21 Mar 2025 11:15:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Mar 2025 19:15:37 +0900
From: changwoo <changwoo@igalia.com>
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, David
 Vernet <void@manifault.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] sched_ext: idle: Explicitly pass allowed cpumask to
 scx_select_cpu_dfl()
In-Reply-To: <20250320073927.216147-3-arighi@nvidia.com>
References: <20250320073927.216147-1-arighi@nvidia.com>
 <20250320073927.216147-3-arighi@nvidia.com>
Message-ID: <5c932b64-82f6-4374-b48f-e3983013b759@igalia.com>
X-Sender: changwoo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-2.2, Tests=ALL_TRUSTED=-3,BAYES_50=0.8,URIBL_BLOCKED=0.001,URIBL_DBL_BLOCKED_OPENDNS=0.001
X-Spam-Score: -21
X-Spam-Bar: --

Hi Andrea,

On 3/20/25 16:36, Andrea Righi wrote:
> Modify scx_select_cpu_dfl() to take the allowed cpumask as an explicit
> argument, instead of implicitly using @p->cpus_ptr.
> 
> This prepares for future changes where arbitrary cpumasks may be passed
> to the built-in idle CPU selection policy.
> 
> This is a pure refactoring with no functional changes.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>   kernel/sched/ext.c      |  2 +-
>   kernel/sched/ext_idle.c | 45 ++++++++++++++++++++++++++---------------
>   kernel/sched/ext_idle.h |  3 ++-
>   3 files changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 06561d6717c9a..f42352e8d889e 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3395,7 +3395,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
>   	} else {
>   		s32 cpu;
>   
> -		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0);
> +		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
>   		if (cpu >= 0) {
>   			p->scx.slice = SCX_SLICE_DFL;
>   			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index e1e020c27c07c..a90d85bce1ccb 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -397,11 +397,19 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
>   		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
>   }
>   
> +static inline bool task_allowed_all_cpus(const struct task_struct *p)
> +{
> +	return p->nr_cpus_allowed >= num_possible_cpus();
> +}

This function will be renamed to task_affinity_all() in patch #3.
Can we use the same name from the beginning?
That will make the commits easier to read.

> +
>   /*
> - * Return the subset of @cpus that task @p can use or NULL if none of the
> - * CPUs in the @cpus cpumask can be used.
> + * Return the subset of @cpus that task @p can use, according to
> + * @cpus_allowed, or NULL if none of the CPUs in the @cpus cpumask can be
> + * used.
>    */
> -static const struct cpumask *task_cpumask(const struct task_struct *p, const struct cpumask *cpus,
> +static const struct cpumask *task_cpumask(const struct task_struct *p,
> +					  const struct cpumask *cpus_allowed,
> +					  const struct cpumask *cpus,
>   					  struct cpumask *local_cpus)
>   {
>   	/*
> @@ -410,12 +418,10 @@ static const struct cpumask *task_cpumask(const struct task_struct *p, const str
>   	 * intersection of the architecture's cpumask and the task's
>   	 * allowed cpumask.
>   	 */
> -	if (!cpus || p->nr_cpus_allowed >= num_possible_cpus() ||
> -	    cpumask_subset(cpus, p->cpus_ptr))
> +	if (!cpus || task_allowed_all_cpus(p) || cpumask_subset(cpus, cpus_allowed))
>   		return cpus;
>   
> -	if (!cpumask_equal(cpus, p->cpus_ptr) &&
> -	    cpumask_and(local_cpus, cpus, p->cpus_ptr))
> +	if (cpumask_and(local_cpus, cpus, cpus_allowed))
>   		return local_cpus;
>   
>   	return NULL;
> @@ -454,7 +460,8 @@ static const struct cpumask *task_cpumask(const struct task_struct *p, const str
>    * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
>    * we never call ops.select_cpu() for them, see select_task_rq().
>    */
> -s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags)
> +s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
> +		       const struct cpumask *cpus_allowed, u64 flags)
>   {
>   	const struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;
>   	int node = scx_cpu_node_if_enabled(prev_cpu);
> @@ -469,13 +476,19 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
>   	 * Determine the subset of CPUs that the task can use in its
>   	 * current LLC and node.
>   	 */
> -	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
> -		numa_cpus = task_cpumask(p, numa_span(prev_cpu),
> +	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa)) {
> +		numa_cpus = task_cpumask(p, cpus_allowed, numa_span(prev_cpu),
>   					 this_cpu_cpumask_var_ptr(local_numa_idle_cpumask));
> +		if (cpumask_equal(numa_cpus, cpus_allowed))

Since task_cpumask() can return NULL, I think we should test if
numa_cpus is NULL or not here, something like this: 

if (numa_cpus && cpumask_equal(numa_cpus, cpus_allowed))

> +			numa_cpus = NULL;
> +	}
>   
> -	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
> -		llc_cpus = task_cpumask(p, llc_span(prev_cpu),
> +	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
> +		llc_cpus = task_cpumask(p, cpus_allowed, llc_span(prev_cpu),
>   					this_cpu_cpumask_var_ptr(local_llc_idle_cpumask));
> +		if (cpumask_equal(llc_cpus, cpus_allowed))

Same here.

		if (llc_cpus && cpumask_equal(llc_cpus, cpus_allowed))

> +			llc_cpus = NULL;
> +	}
>   
>   	/*
>   	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
> @@ -512,7 +525,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
>   		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
>   		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
>   		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
> -			if (cpumask_test_cpu(cpu, p->cpus_ptr))
> +			if (cpumask_test_cpu(cpu, cpus_allowed))
>   				goto out_unlock;
>   		}
>   	}
> @@ -557,7 +570,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
>   		 * begin in prev_cpu's node and proceed to other nodes in
>   		 * order of increasing distance.
>   		 */
> -		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags | SCX_PICK_IDLE_CORE);
> +		cpu = scx_pick_idle_cpu(cpus_allowed, node, flags | SCX_PICK_IDLE_CORE);
>   		if (cpu >= 0)
>   			goto out_unlock;
>   
> @@ -605,7 +618,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
>   	 * in prev_cpu's node and proceed to other nodes in order of
>   	 * increasing distance.
>   	 */
> -	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags);
> +	cpu = scx_pick_idle_cpu(cpus_allowed, node, flags);
>   	if (cpu >= 0)
>   		goto out_unlock;
>   
> @@ -861,7 +874,7 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>   		goto prev_cpu;
>   
>   #ifdef CONFIG_SMP
> -	cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0);
> +	cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
>   	if (cpu >= 0) {
>   		*is_idle = true;
>   		return cpu;
> diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
> index 511cc2221f7a8..37be78a7502b3 100644
> --- a/kernel/sched/ext_idle.h
> +++ b/kernel/sched/ext_idle.h
> @@ -27,7 +27,8 @@ static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node
>   }
>   #endif /* CONFIG_SMP */
>   
> -s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags);
> +s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
> +		       const struct cpumask *cpus_allowed, u64 flags);
>   void scx_idle_enable(struct sched_ext_ops *ops);
>   void scx_idle_disable(void);
>   int scx_idle_init(void);

Regards,
Changwoo Min


