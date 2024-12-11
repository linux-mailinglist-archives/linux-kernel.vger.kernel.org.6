Return-Path: <linux-kernel+bounces-441830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06239ED4A5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB68283BA9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C01202F61;
	Wed, 11 Dec 2024 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjd5uMiB"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130024632E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941315; cv=none; b=X5H8rm9higYai0Va9hOx+vd8vNrbwC3h7022FRJX8U9Yf0zqgBjRschKzweAbYPHKlDbGwwbJ7kMl7LMK7nFWDTg+jQwJUiwKrUHICHX4KkoNoy3odOEkV60EAUXXE08o5ibO5xNsMquEzbLO3aygqgC/xFyvx1rh45nGjph3tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941315; c=relaxed/simple;
	bh=39y3LIxQSYXXsHReqQf7/YEMoMK094vyykUc6thGcXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3xuDuLCLqKmYUIRJx3Ozrxd3zHs+y+PRyG1FBStbURaaFT+ZaTpJAeL35yRlyBOYLLBtXYRh2TNQuD09UcxjVWMq9t2yP5SnvENlg6V54L61QN0/oeMoPDSdX+h7Xxy5s96fWF+t3/vPEf39kQ8k78c4e+pWZe/yUtD8I/g718=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjd5uMiB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2163b0c09afso39969095ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733941313; x=1734546113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wGOOxE0jM72m31paBdMUmPoYiJJErI/sjBTCdnx8B5g=;
        b=fjd5uMiB7O8RPhCElAMf5oAa26TChCK1XzJL2NFYigYT4uy0F1xQz+5B6zsxxE6OLN
         v+1sTVfH2SVdbKxG9eS+cGUTI4sD8CGcZzcFkSZRq9dIbK5D8JJNGPPKRZDSWWHhEjZ0
         iKt2EapTe3aU4wzbWq2pEe3fLImW6Vf8W8yq65d6IpJVqhMZTrGX0x1gG62aD2kLsFke
         +qkaj7CT0HhRKYnQyypoVN2ztawSbjNyJahcf7mjj7L6lHSE/jZvMl1ML6Rs+vQdX07B
         Hy80/YfFlxSCYZvAitlgH0G7SDmoTeKcMN+/87ZWy1TymXu09MFRW2+XNXCjcCg+iEx3
         a1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733941313; x=1734546113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGOOxE0jM72m31paBdMUmPoYiJJErI/sjBTCdnx8B5g=;
        b=qPolXwu4ur9/CcwFj8Wj3axkl4PcVA53poBgVdww7THbPJDWOrNDbvoLPx57bjWgEe
         UMH44PTlE4ag2RuVMY42NtSoJgWlHhxoxn4wh7nKDkH0m4rYkBVlbb1yhtmNjq5DHtDZ
         siN1rVZBfNWAjUWFw7B5pES8D834ODzNjpgYYdrUW8A1zHhJPWr+vIFTo9B/eldb+yJt
         A+cr16Zy/z56vq1gzwcm/MEf0kXH1BGr+9IaIqFNv3+GsHuhk/MQ/wt6k1f/cH84Q+Hd
         uhwnuRXP/v21NVA/uoTGw6w7/v4orjgjSC8QBYd2ITkNVqbi0yKzk/Z3RQ6U5kO9bezW
         MDEg==
X-Forwarded-Encrypted: i=1; AJvYcCWuyx0scfICmwB1u/n2h3N5zOvs39HyR2eYefIxJ/cpP39aXoNMWVI/9/rHJRaKpO/G4sYLCeYMZzEvU3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeUd1bDCS4uieeZYBQygUMYTRkWJ6GtcC+5JPbq4neJGe1+qjS
	PDZy3OOdmbwSIZNWqa2sJtFVPFRIL70D24m3xwFAqy8cuUQoWi0/9HQrAg==
X-Gm-Gg: ASbGncuInvyNZ0+NKGTaiUtSHUV5bGR97By0fvuECvzmmJmtss8Zo1Pgz7NvlzvHlMS
	jKvZt8zN560XH3Zcig1s78EvLiIKsWZEQnn+4JKqCWWZ5GjtNkqCTqDMCZ0zaPWno9lnimiaXkJ
	Pk6IEIpEHNgRBhvf+9m0PmuoTYpu9/1+GPW2k/4OgPt25/FCsjX/xJJ4sOzNlkjhufyDX+qa22v
	nAC3caaG8CiNaXj2igXPr0r7kryRCBimvcLv6k6kFCWloVjzT5LHA==
X-Google-Smtp-Source: AGHT+IFQlDCu3Ps4BvNYpBgHoOtNxlaC6UM925HkIm9I3Rp5ShviAFbJGrYqGIBPL48wJf2dXqibSw==
X-Received: by 2002:a17:902:f54c:b0:216:6c88:efd9 with SMTP id d9443c01a7336-2178ae5cbefmr9914495ad.15.1733941312973;
        Wed, 11 Dec 2024 10:21:52 -0800 (PST)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216634dd69esm46866075ad.40.2024.12.11.10.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 10:21:52 -0800 (PST)
Date: Wed, 11 Dec 2024 10:21:49 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] sched_ext: Introduce SCX_OPS_NODE_BUILTIN_IDLE
Message-ID: <Z1nYPWeJvmizCvJJ@yury-ThinkPad>
References: <20241209104632.718085-1-arighi@nvidia.com>
 <20241209104632.718085-4-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209104632.718085-4-arighi@nvidia.com>

On Mon, Dec 09, 2024 at 11:40:57AM +0100, Andrea Righi wrote:
> Add a flag (SCX_OPS_NODE_BUILTIN_IDLE) to toggle between a global flat
> idle cpumask and multiple per-node CPU masks.
> 
> This allows each sched_ext scheduler to choose between the new or old
> model, preserving backward compatibility and preventing disruptions to
> existing behavior.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c | 56 +++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index ed2f0d13915c..d0d57323bcfc 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -122,6 +122,12 @@ enum scx_ops_flags {
>  	 */
>  	SCX_OPS_SWITCH_PARTIAL	= 1LLU << 3,
>  
> +	/*
> +	 * If set, enable per-node idle cpumasks. If clear, use a single global
> +	 * flat idle cpumask.
> +	 */
> +	SCX_OPS_BUILTIN_IDLE_PER_NODE = 1LLU << 4,
> +
>  	/*
>  	 * CPU cgroup support flags
>  	 */
> @@ -131,6 +137,7 @@ enum scx_ops_flags {
>  				  SCX_OPS_ENQ_LAST |
>  				  SCX_OPS_ENQ_EXITING |
>  				  SCX_OPS_SWITCH_PARTIAL |
> +				  SCX_OPS_BUILTIN_IDLE_PER_NODE |
>  				  SCX_OPS_HAS_CGROUP_WEIGHT,
>  };
>  
> @@ -886,6 +893,7 @@ static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
>  
>  #ifdef CONFIG_SMP
>  static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
> +static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
>  #endif
>  
>  static struct static_key_false scx_has_op[SCX_OPI_END] =
> @@ -929,18 +937,32 @@ static struct delayed_work scx_watchdog_work;
>  #define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
>  #endif
>  
> -static struct {
> +struct idle_cpumask {
>  	cpumask_var_t cpu;
>  	cpumask_var_t smt;
> -} **idle_masks CL_ALIGNED_IF_ONSTACK;
> +};
> +
> +/*
> + * cpumasks to track idle CPUs within each NUMA node.
> + *
> + * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not specified, a single flat cpumask
> + * from node 0 is used to track all idle CPUs system-wide.
> + */
> +static struct idle_cpumask **idle_masks CL_ALIGNED_IF_ONSTACK;
>  
>  static struct cpumask *get_idle_cpumask_node(int node)
>  {
> +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> +		return idle_masks[0]->cpu;
> +
>  	return idle_masks[node]->cpu;
>  }
>  
>  static struct cpumask *get_idle_smtmask_node(int node)
>  {
> +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> +		return idle_masks[0]->smt;
> +
>  	return idle_masks[node]->smt;
>  }
>  
> @@ -3423,7 +3445,7 @@ static bool llc_numa_mismatch(void)
>   * CPU belongs to a single LLC domain, and that each LLC domain is entirely
>   * contained within a single NUMA node.
>   */
> -static void update_selcpu_topology(void)
> +static void update_selcpu_topology(struct sched_ext_ops *ops)
>  {
>  	bool enable_llc = false;
>  	unsigned int nr_cpus;
> @@ -3442,8 +3464,16 @@ static void update_selcpu_topology(void)
>  	rcu_read_lock();
>  	nr_cpus = llc_weight(cpu);
>  	if (nr_cpus > 0) {
> -		if ((nr_cpus < num_online_cpus()) && llc_numa_mismatch())
> +		if (nr_cpus < num_online_cpus())
>  			enable_llc = true;
> +		/*
> +		 * No need to enable LLC optimization if the LLC domains are
> +		 * perfectly overlapping with the NUMA domains when per-node
> +		 * cpumasks are enabled.
> +		 */
> +		if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
> +		    !llc_numa_mismatch())
> +			enable_llc = false;
>  		pr_debug("sched_ext: LLC=%*pb weight=%u\n",
>  			 cpumask_pr_args(llc_span(cpu)), llc_weight(cpu));
>  	}
> @@ -3456,6 +3486,14 @@ static void update_selcpu_topology(void)
>  		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
>  	else
>  		static_branch_disable_cpuslocked(&scx_selcpu_topo_llc);
> +
> +	/*
> +	 * Check if we need to enable per-node cpumasks.
> +	 */
> +	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
> +		static_branch_enable_cpuslocked(&scx_builtin_idle_per_node);
> +	else
> +		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
>  }

The patch that introduces the flag should go the very first in the series,
but should unconditionally disable scx_builtin_idle_per_node.

The following patches should add all the machinery you need. The machinery
should be conditional on the scx_builtin_idle_per_node, i.e. disabled for
a while.

Doing that, you'll be able to introduce your functionality as a whole:

   static struct cpumask *get_idle_cpumask_node(int node)
   {
   	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
   		return idle_masks[0]->cpu;
   
   	return idle_masks[node]->cpu;
   }

Much better than patching just introduced code, right?

The very last patch should only be a chunk that enables scx_builtin_idle_per_node
based on SCX_OPS_BUILTIN_IDLE_PER_NODE.

This way, when your feature will get merged, from git-bisect perspective
it will be enabled atomically by the very last patch, but those interested
in internals will have nice coherent history.

Thanks,
Yury

>  
>  /*
> @@ -3683,6 +3721,12 @@ static void reset_idle_masks(void)
>  {
>  	int node;
>  
> +	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
> +		cpumask_copy(get_idle_cpumask_node(0), cpu_online_mask);
> +		cpumask_copy(get_idle_smtmask_node(0), cpu_online_mask);
> +		return;
> +	}
> +
>  	/*
>  	 * Consider all online cpus idle. Should converge to the actual state
>  	 * quickly.
> @@ -3740,7 +3784,7 @@ static void handle_hotplug(struct rq *rq, bool online)
>  	atomic_long_inc(&scx_hotplug_seq);
>  
>  	if (scx_enabled())
> -		update_selcpu_topology();
> +		update_selcpu_topology(&scx_ops);
>  
>  	if (online && SCX_HAS_OP(cpu_online))
>  		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
> @@ -5618,7 +5662,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  
>  	check_hotplug_seq(ops);
>  #ifdef CONFIG_SMP
> -	update_selcpu_topology();
> +	update_selcpu_topology(ops);
>  #endif
>  	cpus_read_unlock();
>  
> -- 
> 2.47.1

