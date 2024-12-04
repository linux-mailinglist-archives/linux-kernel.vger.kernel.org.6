Return-Path: <linux-kernel+bounces-430381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180E69E3038
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FCA283940
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914B87FD;
	Wed,  4 Dec 2024 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt6Z4mAl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECABD632
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270657; cv=none; b=VTP1B2/HM/QdR0fUr5mrr3ieu+cpGE7x/fd5bm2MnxEjWk3zV0pWEe76HPx2Tgf6AU+ttXDDPtjW2qsdQTUGP32NWYi/1xWx1RsmSdrvoDwh0McZWBA3GSesza4fL+RScn/MAwoKnC8TgsK5mwbMP1hUFnSZdYeFFlek0Pw64MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270657; c=relaxed/simple;
	bh=XuVfx6SKEaUU8HOecuMdDWUZhTxlEqblhrMLwMnIMPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1sBT+2Q1+RYGnhKsbgEaLUEHvIGN6J5RMbf3dIM6f7EMs2F+dMM4YMJXHSlZffFgZk2k60D6GttT1+MYiRc9tnHTRPyYtEH19LAhsy6FxUYikWiNzll63URkKZxVXdHY6totYdPhVXf2V0cKk3gaCTl2igCW8Wzm9u29OHLCa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt6Z4mAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B8AC4CEDC;
	Wed,  4 Dec 2024 00:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733270656;
	bh=XuVfx6SKEaUU8HOecuMdDWUZhTxlEqblhrMLwMnIMPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mt6Z4mAlE7yn6BYIXwt4apxGd+C9Gb4m3BvF7MVPIL642Fls1J2Ap7C7vXwOVQTnR
	 nx1QvB6Bi0V7fcvH6HxqeQLncUoG/53Po/+TTzyPk7SqxtuLGVIqF0ONqpv4hR66oB
	 Q+mHCSAVXhj474bkkn1CSLtq+w7QIu30x2p7fPZ/a2xkPR8TKrKEGK2RavEL6+B0tV
	 V7J4HFe0SmnXbt34g/0QVxN9zeApdjwrAEU2NQWbbY8KqwlDNSC63FsNS/SxqqbnNA
	 yQMHGyvlf5yGmEeYO2kOU3yzwMHwo+2NBV/HGlywf5FzQiDA96FT2hxdVJKNiqcXFQ
	 rKOB8aByhPbFg==
Date: Tue, 3 Dec 2024 14:04:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z0-cf7gUzV8jIWIX@slm.duckdns.org>
References: <20241203154917.123419-1-arighi@nvidia.com>
 <20241203154917.123419-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203154917.123419-3-arighi@nvidia.com>

Hello,

On Tue, Dec 03, 2024 at 04:36:11PM +0100, Andrea Righi wrote:
...
> Probably a better way to solve this issue is to introduce new kfunc's to
> explicitly select specific per-NUMA cpumask and modify the scx
> schedulers to transition to this new API, for example:
> 
>   const struct cpumask *scx_bpf_get_idle_numa_cpumask(int node)
>   const struct cpumask *scx_bpf_get_idle_numa_smtmask(int node)

Yeah, I don't think we want to break backward compat here. Can we introduce
a flag to switch between node-aware and flattened logic and trigger ops
error if the wrong flavor is used? Then, we can deprecate and drop the old
behavior after a few releases. Also, I think it can be named
scx_bpf_get_idle_cpumask_node().

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

Hmm... why are they keyed by cpu? Wouldn't it make more sense to key them by
node?

> +static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> +{
> +	int start = cpu_to_node(smp_processor_id());
> +	int node, cpu;
> +
> +	for_each_node_state_wrap(node, N_ONLINE, start) {
> +		/*
> +		 * scx_pick_idle_cpu_from_node() can be expensive and redundant
> +		 * if none of the CPUs in the NUMA node can be used (according
> +		 * to cpus_allowed).
> +		 *
> +		 * Therefore, check if the NUMA node is usable in advance to
> +		 * save some CPU cycles.
> +		 */
> +		if (!cpumask_intersects(cpumask_of_node(node), cpus_allowed))
> +			continue;
> +		cpu = scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
> +		if (cpu >= 0)
> +			return cpu;

This is fine for now but it'd be ideal if the iteration is in inter-node
distance order so that each CPU radiates from local node to the furthest
ones.

Thanks.

-- 
tejun

