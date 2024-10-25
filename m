Return-Path: <linux-kernel+bounces-382535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C709B0F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CAD282822
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770BD20D4FC;
	Fri, 25 Oct 2024 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3qy+E+B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A23524F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729886552; cv=none; b=Cv1AzrnKHwinJ6ktxqOuspysVZGeKiNbLZqmMyjRjWh/dIzjd4dJB2Dkb8tLZfahxD/cy5o/ZbpH/L6AeHqp1unHzjli1akU+qhguYUkgjeETTueFnKxNpmcuSVOP2fMtA5Jo2y13YsFGtYNDyVNrGaXj6W1aGKhSlvLnxRFMlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729886552; c=relaxed/simple;
	bh=2F+91o0q2lmJmn3g1uSq5NWW9wIqZHZcjEOBdYEU4pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdWe3rOR5IPErBBrEcodpqv5wQIOdiEa/98rKrN25ltK8O40K17CPA8Yz5pVE8XC64ejKSeXVEXOQSNLU0pqRNgaMY+UkVvraRvqRMY2MkuNU23PmlydjUhr5tj2aZlDG7QrGfde3euDQiaqvPUwyqpVDB4GMSQa9yFgdusmotM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3qy+E+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087E3C4CEC3;
	Fri, 25 Oct 2024 20:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729886552;
	bh=2F+91o0q2lmJmn3g1uSq5NWW9wIqZHZcjEOBdYEU4pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U3qy+E+BYzg129FGRsgmLnWKJwk6r1dPEJTFvxcTtfdDHsHJgHAxPzyb5P2ZHBvmh
	 zMWypDwIGbmvFk1BOlJa0a5yIoNoUL9P8MnKdO6CYta1AunFg7wa7AIHj+8m2zuEH+
	 6geWOQiNJJ3mx/pUkJpEnrzCOycRqUhopZ/9oU3Ezq0xRFdaTu07mRMdpl9MzRiDYC
	 z7/ogO7sUWZo33anCZj0bxLglG0hX1rnyYlsh9pz62AfBC5gme1snZNUhPeNyjpDSR
	 VMjut6UsuLXL1s7XgaHVL6Dw5ZtkQu7UH9xbtcr/x3BXYceNwRsn5bruDOaP4+BlzY
	 IiVAvATyrQx8g==
Date: Fri, 25 Oct 2024 10:02:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Introduce NUMA awareness to the default
 idle selection policy
Message-ID: <Zxv5V5mwDAlGzpBb@slm.duckdns.org>
References: <20241025162535.88059-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025162535.88059-1-arighi@nvidia.com>

Hello,

On Fri, Oct 25, 2024 at 06:25:35PM +0200, Andrea Righi wrote:
...
> +static DEFINE_STATIC_KEY_FALSE(scx_topology_llc);
> +static DEFINE_STATIC_KEY_FALSE(scx_topology_numa);

Maybe name them sth like scx_selcpu_topo_llc given that this is only used by
selcpu?

> +static void init_topology(void)

Ditto with naming.

>  {
> -	struct sched_domain *sd = rcu_dereference(per_cpu(sd_llc, cpu));
> -	const struct cpumask *llc_cpus = sd ? sched_domain_span(sd) : NULL;
> +	const struct cpumask *cpus;
> +	int nid;
> +	s32 cpu;
> +
> +	/*
> +	 * Detect if the system has multiple NUMA nodes distributed across the
> +	 * available CPUs and, in that case, enable NUMA-aware scheduling in
> +	 * the default CPU idle selection policy.
> +	 */
> +	for_each_node(nid) {
> +		cpus = cpumask_of_node(nid);
> +		if (cpumask_weight(cpus) < nr_cpu_ids) {

Comparing number of cpus with nr_cpu_ids doesn't work. The above condition
can trigger on single node machines with some CPUs offlines or unavailable
for example. I think num_node_state(N_CPU) should work or if you want to
keep with sched_domains, maybe highest_flag_domain(some_cpu,
SD_NUMA)->groups->weight would work?

...
> +	for_each_possible_cpu(cpu) {
> +		struct sched_domain *sd = rcu_dereference(per_cpu(sd_llc, cpu));
> +
> +		if (!sd)
> +			continue;
> +		cpus = sched_domain_span(sd);
> +		if (cpumask_weight(cpus) < nr_cpu_ids) {

Ditto. 

...
> +	/*
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
> +	if (p->nr_cpus_allowed == nr_cpu_ids) {

Should compare against nr_possible_cpus.

Thanks.

-- 
tejun

