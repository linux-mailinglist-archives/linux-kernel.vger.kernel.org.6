Return-Path: <linux-kernel+bounces-442060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EBA9ED776
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FEF188942B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54AE20ADC5;
	Wed, 11 Dec 2024 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP/QQoT0"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595832036F6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950050; cv=none; b=LBXT7ir+vFlOnKLeQ+Dhy0dlt667PnuAcCC0Ep5xn9Dv6m1E8u/qX2vGjFPzt8wxL/YifJYuq2GblBQYT77EJkx5O0hkifdO33lEDk5XLW/Pm75w/m12wHb2Kmcx9jm6J+sr1CbgWLTLMGBv6N6scVFvF7NzYGBxn0yfwGjwFEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950050; c=relaxed/simple;
	bh=SVXI7B4tQFbrr4uL1gPWa7TxmcpWGgeMMwIzdJtp/VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dv3f1Wz5F0YgGR4fK6poHSkkqkhRSOtl8D2bdL1bZ0s19tF2MjCtSQHj8aS359/IOZsWS+YQQQT72txLmxPQe0wai+H0zOAu5W1C1vH/L5DWYMyXo7wu7+ZcVsuyvPeJtcAFU1ZkTMkMZL546GAPbaLfQOAK/a0a9IxZYSYMerM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XP/QQoT0; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fdc6e04411so1823943a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733950046; x=1734554846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JXW56JDFSeahHkq9DCvmGpFWzpWQTdGbuHyzCs7XuxU=;
        b=XP/QQoT0nLj+sFak7hSUojDZMKU5yzU11jrt2Z/uTzT7W5FTi3uXsa8JoDUZaAqiLM
         gd/Yr1dnsAfx9mNp0kECPoeRFUUu13vRhduHko83wv7UAgFNp2dSGs6Aus93x1Fdk+7j
         3XGxGZZC46j26lRbYYuYLj5Asb6nQgMH9efZERPkdfI3Hnv2tTdSNuHz7pYi1M+4y3sQ
         190rMsXd56FPkNLkIyApGnhjgtBboHQgoHBte5iHTv6BZxluUr319xuW4ou4H0NAQMFA
         jtEXTihJWhH0yFoZaNAqAAFz8BplJ+waP918eHli5FspMKSSP53pslJPDfKFi73uhA4q
         lYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950046; x=1734554846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXW56JDFSeahHkq9DCvmGpFWzpWQTdGbuHyzCs7XuxU=;
        b=uYfZzI8aSZMha4sYj4D/xsuoSO9sIh+DhULbDX91v2WXMpd4EZVwlJQMn2ZsYQz51E
         kdYweE+WAtf5aiY+opuVkFaK9ErDXStxOpxEVz/nO8UpuapRmNWaZ8ePqggSrMr3gtTl
         jQdtrkjoR/8rkkU+ES+4Jqmm8KCDMX2xazpuqw+rBNWPw2vAjCpy2kmHpI4konQJFDPW
         pk84oZgh7YYJff8R0SgmOHX5B+RPEaJyP231DJgOOF1PJ64AT7j3J8lyGPLL+fHztSkz
         JwIkrxG/Lk6h/NBe+LMPB0x4WbRlcpICQKbpjQl09f3f5/mWetOe41ZC2uGeUxPyrpkY
         r4OA==
X-Forwarded-Encrypted: i=1; AJvYcCXvZdiNHoRaFAH3huxCpYysa7gV8x9/aWOtBIkC4WTYww1f8uU2rVklq5zKRZzeiOGMegviK4HVzFyoUjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Q1mebXDmswjjPVVD3h1L/afh5iEusPO0e+Pu5UmjbALkfUjU
	4P6F5Y7q8+CHnvhnpyJc87jkh4bzNCvS1ZPjHw5yup1M5OOoJYlt
X-Gm-Gg: ASbGnctx3ZZsgR62HHLb6Qo6iOxVqSLILxK87EsiPT4wXeyEx9+wsZS6UcTXUEk2SuW
	3Jiwdy2prxkRnLMxRUBcXG9HM2DurO7lNYAkT0w+YjbPDeFNXRYrkf/ef4vw5F7HGGd1BB5o+TF
	HRJPDxSqth3gcSDCvgcbnPlH6dj1o9IJ0jFRtPpiFBTfbWUS8pundAcHWaa0/rGxfaWQOmvGrdy
	lZS2/IwsGOAcP6nUgvqh8C9I8gkZgOYWemcKFvXd205EmJrlgHB/A==
X-Google-Smtp-Source: AGHT+IH2KYO+HZRq6TW/3DEvDjNzj7umUXBq0pORHBOAazfQ94IC2gF8iV2GRBVTdM/bTKMpiwKzCw==
X-Received: by 2002:a17:90b:1c88:b0:2ee:d63f:d73 with SMTP id 98e67ed59e1d1-2f127fbad41mr6332439a91.11.1733950045885;
        Wed, 11 Dec 2024 12:47:25 -0800 (PST)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef7315fd3asm9679277a91.44.2024.12.11.12.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:47:25 -0800 (PST)
Date: Wed, 11 Dec 2024 12:47:22 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sched_ext: Introduce NUMA aware idle cpu kfunc
 helpers
Message-ID: <Z1n6WgfTBBBIH2of@yury-ThinkPad>
References: <20241209104632.718085-1-arighi@nvidia.com>
 <20241209104632.718085-5-arighi@nvidia.com>
 <Z1nPPhe_83lBTna4@yury-ThinkPad>
 <Z1n0KLQcA-F2DVa8@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1n0KLQcA-F2DVa8@gpd3>

On Wed, Dec 11, 2024 at 09:20:56PM +0100, Andrea Righi wrote:
> On Wed, Dec 11, 2024 at 09:43:26AM -0800, Yury Norov wrote:
> > On Mon, Dec 09, 2024 at 11:40:58AM +0100, Andrea Righi wrote:
> > > Add the following kfunc's to provide scx schedulers direct access to
> > > per-node idle cpumasks information:
> > > 
> > >  const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> > >  const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
> > >  s32 scx_bpf_pick_idle_cpu_node(int node,
> > >                                 const cpumask_t *cpus_allowed, u64 flags)
> > >  int scx_bpf_cpu_to_node(s32 cpu)
> > > 
> > > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > > ---
> > >  kernel/sched/ext.c                       | 96 +++++++++++++++++++++++-
> > >  tools/sched_ext/include/scx/common.bpf.h |  4 +
> > >  tools/sched_ext/include/scx/compat.bpf.h | 19 +++++
> > >  3 files changed, 117 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > > index d0d57323bcfc..ea7cc481782c 100644
> > > --- a/kernel/sched/ext.c
> > > +++ b/kernel/sched/ext.c
> > > @@ -433,6 +433,7 @@ struct sched_ext_ops {
> > >  	 * - scx_bpf_select_cpu_dfl()
> > >  	 * - scx_bpf_test_and_clear_cpu_idle()
> > >  	 * - scx_bpf_pick_idle_cpu()
> > > +	 * - scx_bpf_pick_idle_cpu_node()
> > >  	 *
> > >  	 * The user also must implement ops.select_cpu() as the default
> > >  	 * implementation relies on scx_bpf_select_cpu_dfl().
> > > @@ -955,6 +956,8 @@ static struct cpumask *get_idle_cpumask_node(int node)
> > >  	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> > >  		return idle_masks[0]->cpu;
> > >  
> > > +	if (node < 0 || node >= num_possible_nodes())
> > > +		return NULL;
> > 
> > 1. This sanity should go before the check above.
> > 2. In-kernel users don't need to do sanity checks. BPF users should,
> >    but for them you need to move it in BPF wrapper.
> > 3. -1 is a valid parameter, means NUMA_NO_NODE. 
> 
> Ok, but what would you return with NUMA_NO_NODE, in theory we should return
> a global system-wide cpumask, that doesn't exist with the per-node
> cpumasks. Maybe just return cpu_none_mask? That's what I've done in the
> next version, that seems safer than returning NULL.
 
To begin with, you can just disallow NUMA_NO_NODE for this interface.
Put a corresponding comment or warning, and you're done.

On the other hand, you can treat it as 'I don't care' hint and return
a cpumask for any node that has idle CPUs.

Returning cpu_none_mask?.. OK, it's possible, but what does that
bring? User will have to traverse empty mask just to find nothing.
I'd rather disallow NUMA_NO_NODE than returning something useless.

> > >  	return idle_masks[node]->cpu;
> > >  }
> > >  
> > > @@ -963,6 +966,8 @@ static struct cpumask *get_idle_smtmask_node(int node)
> > >  	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> > >  		return idle_masks[0]->smt;
> > >  
> > > +	if (node < 0 || node >= num_possible_nodes())
> > > +		return NULL;
> > >  	return idle_masks[node]->smt;
> > >  }
> > >  
> > > @@ -7469,6 +7474,16 @@ __bpf_kfunc u32 scx_bpf_nr_cpu_ids(void)
> > >  	return nr_cpu_ids;
> > >  }
> > >  
> > > +/**
> > > + * scx_bpf_cpu_to_node - Return the NUMA node the given @cpu belongs to
> > > + */
> > > +__bpf_kfunc int scx_bpf_cpu_to_node(s32 cpu)
> > > +{
> > > +	if (cpu < 0 || cpu >= nr_cpu_ids)
> > > +		return -EINVAL;
> > > +	return cpu_to_node(cpu);
> > > +}
> > 
> > I believe this wrapper should be declared somewhere in
> > kernel/sched/topology.c, and better be a separate patch.
> 
> Maybe kernel/bpf/helpers.c? And name it bpf_cpu_to_node()?

Sure, even better
 
> > > +
> > >  /**
> > >   * scx_bpf_get_possible_cpumask - Get a referenced kptr to cpu_possible_mask
> > >   */
> > > @@ -7499,11 +7514,32 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
> > >  	 */
> > >  }
> > >  
> > > +/**
> > > + * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the idle-tracking
> > > + * per-CPU cpumask of a target NUMA node.
> > > + *
> > > + * Returns an empty cpumask if idle tracking is not enabled, if @node is not
> > > + * valid, or running on a UP kernel.
> > > + */
> > > +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> > > +{
> > > +	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
> > > +		scx_ops_error("built-in idle tracking is disabled");
> > > +		return cpu_none_mask;
> > > +	}
> > > +	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
> > > +		scx_ops_error("per-node idle tracking is disabled");
> > > +		return cpu_none_mask;
> > > +	}
> > 
> > Nub question: is it possible that scx_builtin_idle_per_node is enable,
> > but scx_builtin_idle_enabled not? From my naive perspective, we can't
> > enable per-node idle masks without enabling general idle masks. Or I
> > mislead it?
> 
> In theory a BPF scheduler could set SCX_OPS_BUILTIN_IDLE_PER_NODE (without
> SCX_OPS_KEEP_BUILTIN_IDLE) in .flags while implementing ops.update_idle().
> 
> In this way we would have scx_builtin_idle_enabled==false and
> scx_builtin_idle_per_node==true, which doesn't make much sense, so we
> should probably handle this case in validate_ops() and trigger an error.
> 
> Good catch!
> 
> > 
> > > +
> > > +	return get_idle_cpumask_node(node) ? : cpu_none_mask;
> > > +}
> > >  /**
> > >   * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
> > >   * per-CPU cpumask of the current NUMA node.
> > >   *
> > > - * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
> > > + * Returns an emtpy cpumask if idle tracking is not enabled, or running on a UP
> > > + * kernel.
> > >   */
> > >  __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
> > >  {
> > > @@ -7515,12 +7551,35 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
> > >  	return get_curr_idle_cpumask();
> > >  }
> > >  
> > > +/**
> > > + * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the idle-tracking,
> > > + * per-physical-core cpumask of a target NUMA node. Can be used to determine
> > > + * if an entire physical core is free.
> > > + *
> > > + * Returns an empty cpumask if idle tracking is not enabled, if @node is not
> > > + * valid, or running on a UP kernel.
> > > + */
> > > +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
> > > +{
> > > +	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
> > > +		scx_ops_error("built-in idle tracking is disabled");
> > > +		return cpu_none_mask;
> > > +	}
> > > +	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
> > > +		scx_ops_error("per-node idle tracking is disabled");
> > > +		return cpu_none_mask;
> > > +	}
> > 
> > Can you add vertical spacing between blocks?
> 
> You mean a blank between the two blocks, right?

Yes

> Anyway, ...
> 
> > 
> > Also, because you use this construction more than once, I think it
> > makes sense to make it a helper.
> 
> With a proper error check in validate_ops() we can just get rid of the
> scx_builtin_idle_enabled block and simply check scx_builtin_idle_per_node.

But still, having a helper is better than opencoding the same 4-lines
pattern again and again

> > > +
> > > +	return get_idle_smtmask_node(node) ? : cpu_none_mask;
> > > +}
> > > +
> > >  /**
> > >   * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
> > >   * per-physical-core cpumask of the current NUMA node. Can be used to determine
> > >   * if an entire physical core is free.
> > >   *
> > > - * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
> > > + * Returns an empty cumask if idle tracking is not enabled, or running on a UP
> > > + * kernel.
> > >   */
> > >  __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
> > >  {
> > > @@ -7569,6 +7628,35 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
> > >  		return false;
> > >  }
> > >  
> > > +/**
> > > + * scx_bpf_pick_idle_cpu_node - Pick and claim an idle cpu from a NUMA node
> > > + * @node: target NUMA node
> > > + * @cpus_allowed: Allowed cpumask
> > > + * @flags: %SCX_PICK_IDLE_CPU_* flags
> > > + *
> > > + * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
> > > + * Returns the picked idle cpu number on success. -%EBUSY if no matching cpu
> > > + * was found.
> > > + *
> > > + * Unavailable if ops.update_idle() is implemented and
> > > + * %SCX_OPS_KEEP_BUILTIN_IDLE is not set or if %SCX_OPS_KEEP_BUILTIN_IDLE is
> > > + * not set.
> > > + */
> > > +__bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(int node, const struct cpumask *cpus_allowed,
> > > +				      u64 flags)
> > > +{
> > 
> > Sanity checks here?
> 
> Indeed, thanks!
> 
> -Andrea

