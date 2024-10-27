Return-Path: <linux-kernel+bounces-383725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D619B1F87
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 19:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA771F21537
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0912C16F8F5;
	Sun, 27 Oct 2024 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdqBQ8sp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5828F5
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730052235; cv=none; b=jYx+R9cgpoPsFEwrfse9xhlRb1eOdz3/SlHkWax6vu4hCZsBEusT7vnjCU1ZhQsXosR2YOdn2ElqLRfWk9wGNhu79sy2B6dUsT66/3Io7un3OQyLOUJKnSEg+AHbM4Oem4Bc9KSWVonLFuPo4nnc4Q4sWztEHvpPx0vvJI0NfxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730052235; c=relaxed/simple;
	bh=/hIsMd6rdRDYha3A27+FzlsMw32f6kZGTal0sz54thY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niqJqbRrfrfbSukNEDjbC2VYPfQn7yA0Nlwe19dIlZvHFBX15Y8r1zWCAhqHfsnNkFYGCJWOVg2QGIeDu8Uhaj58Z3B2G3RJ8k2PssCCPrbOBtJoXTtjbRIE13hQhC4gd5MkMemp6JHlNRCriDDZOdOq6lux99FTSHOVMykbO40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdqBQ8sp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D191DC4CEC3;
	Sun, 27 Oct 2024 18:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730052235;
	bh=/hIsMd6rdRDYha3A27+FzlsMw32f6kZGTal0sz54thY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QdqBQ8spphZDq6y5tYQMEBdcSjc7KjGBt7TaK5WdqFxNvnhleOARfmDrQrG2hDHpJ
	 K0hiMQgQOEhi68F8hkh6GKFeMp+zqgwZTWeI33YONxVEcP1OqHokgy8nChUJ/3i02R
	 ACUDtSAxg31nmjG025Rf5HjyN9dDNBjr+myNLUFT3GPohzQ6pEXkRNzeR6pD2a6BjK
	 aJ8FP0V7TmA9en9q4/3t5LzCChNMZi0zJM1Ex/Pxe4crEWBFsPbRRVdZAjjL607pTX
	 +XGZqzgdJDVts3+XRXn3Lly01gL2I0SdriNVhvtRy/izrGFLatv/hTWykJSQ7P0lCL
	 MMgMq7kyhkdKw==
Date: Sun, 27 Oct 2024 08:03:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched_ext: Introduce NUMA awareness to the default
 idle selection policy
Message-ID: <Zx6AiTja6jX7bC7R@slm.duckdns.org>
References: <20241027174953.49655-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027174953.49655-1-arighi@nvidia.com>

Hello,

On Sun, Oct 27, 2024 at 06:49:53PM +0100, Andrea Righi wrote:
...
> +static void update_selcpu_topology(void)
>  {
> +	bool enable_llc = false, enable_numa = false;
> +	s32 cpu;
>  
> +	rcu_read_lock();
> +	for_each_possible_cpu(cpu) {
> +		struct sched_domain *sd;
> +		const struct cpumask *cpus;
> +
> +		sd = rcu_dereference(per_cpu(sd_llc, cpu));
> +		if (sd) {
> +			cpus = sched_domain_span(sd);
> +			pr_debug("sched_ext: LLC cpu%d: %*pbl\n",
> +				 cpu, cpumask_pr_args(cpus));
> +			if (cpumask_weight(cpus) < num_possible_cpus())
> +				enable_llc = true;
> +		}
> +
> +		sd = highest_flag_domain(cpu, SD_NUMA);
> +		if (sd) {
> +			cpus = sched_group_span(sd->groups);
> +			pr_debug("sched_ext: NUMA cpu%d: %*pbl\n",
> +				 cpu, cpumask_pr_args(cpus));
> +			if (cpumask_weight(cpus) < num_possible_cpus())
> +				enable_numa = true;

This isn't a big problem but the loop looks a bit odd in that once both are
set, it's obvious that there's no reason to continue. Doesn't this need to
check only one CPU in fact? e.g. for the first possible CPU, if sd doesn't
exist or cpumask_weight(sd) == num_possible_cpu(), don't we know for sure
that llc or numa doesn't need to be enabled and vice-versa?

>  static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  			      u64 wake_flags, bool *found)
>  {
> +	const struct cpumask *llc_cpus = NULL;
> +	const struct cpumask *numa_cpus = NULL;
>  	s32 cpu;
>  
>  	*found = false;
...
> +	if (p->nr_cpus_allowed >= num_possible_cpus()) {
> +		if (static_branch_unlikely(&scx_selcpu_topo_numa))
> +			numa_cpus = cpumask_of_node(cpu_to_node(prev_cpu));
> +
> +		if (static_branch_unlikely(&scx_selcpu_topo_llc)) {

static_branch_maybe() is probably the better one for llc.

Thanks.

-- 
tejun

