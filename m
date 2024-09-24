Return-Path: <linux-kernel+bounces-336998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 600079843D8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CC51F23B92
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4538319C54E;
	Tue, 24 Sep 2024 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3bUtDg3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9585584D29
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174613; cv=none; b=rvLJzLpgkPgbqxv94SXwUD0L9tiZ0vBeBaud5WZDC5zP+F/51dH0e4zNbiCeFoc0+0QFMw2NZTeO5sje5rXJP1YnjT79no3e8n5OoExIkEAwW/k4pGBjAsRdcim2iFg/qCP9KBisb8PALEBdGk221QjpPrV6U9B5SHarFxSWzBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174613; c=relaxed/simple;
	bh=n6p35akJn0rRYtV1CZC9RwbESxlhP2Wfb9BUsBQBiJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhOl8Gi9zO/jMRQOFWY4Hqy1VQM5sNKr2wGbXJCSurFsodmGP8BZwDz9LtUVWpIUqW9qG9zkkdOuQh+JNyzDbcGfpjyvd10hLu45VRdrZZMQLEAMlB1RtMO7VBuv20bhOX189L/c1uceHmFTfbDnfiv/4vrNfkSK3tqxZ+Bfmo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3bUtDg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA78C4CEC4;
	Tue, 24 Sep 2024 10:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727174613;
	bh=n6p35akJn0rRYtV1CZC9RwbESxlhP2Wfb9BUsBQBiJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3bUtDg3Ko+zNOastVUWuBFPx6lw/1Ebt07RUaJep/dat5b/31IZ+dNKvZlVOk0Kr
	 dO/bMzrzFtaPIYa2FE1hDUuy0Pi7Zn6vr0Wa2tnyf6WG5yOVavtl/vBdpjMap9mkGU
	 KeThdN4rY8SNEj5SK2yiZE3i6XPw8yU4u9PITACGh8yYCptTKdH4YvmFeBqMg79BrI
	 03pni9juOjvHZi8nDgt3BcYqw+rja6n8lwNmsmr8btZ93ChJ6ZdU75yzvd3ewQM1bm
	 4CFoQpz3pMIeV1KnWMCtEDNQNF8/BEWxep9/CMdZGlIPqtJAjt6kRvN1cJ0RTyfhQB
	 EXruNGy8t9sdg==
Date: Tue, 24 Sep 2024 13:40:22 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Bruno Faccini <bfaccini@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, ziy@nvidia.com, ttabi@nvidia.com,
	jhubbard@nvidia.com
Subject: Re: [PATCH] mm/fake-numa: per-phys node fake size
Message-ID: <ZvKXFnriMlH2y5Oo@kernel.org>
References: <20240921081348.10016-1-bfaccini@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240921081348.10016-1-bfaccini@nvidia.com>

On Sat, Sep 21, 2024 at 01:13:49AM -0700, Bruno Faccini wrote:
> Determine fake numa node size on a per-phys node basis to
> handle cases where there are big differences of reserved
> memory size inside physical nodes, this will allow to get
> the expected number of nodes evenly interleaved.
> 
> Consider a system with 2 physical Numa nodes where almost
> all reserved memory sits into a single node, computing the
> fake-numa nodes (fake=N) size as the ratio of all
> available/non-reserved memory can cause the inability to
> create N/2 fake-numa nodes in the physical node.

I'm not sure I understand the problem you are trying to solve.
Can you provide more specific example?

> Signed-off-by: Bruno Faccini <bfaccini@nvidia.com>
> ---
>  mm/numa_emulation.c | 66 ++++++++++++++++++++++++++-------------------
>  1 file changed, 39 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/numa_emulation.c b/mm/numa_emulation.c
> index 031fb9961bf7..0c72c85cfc10 100644
> --- a/mm/numa_emulation.c
> +++ b/mm/numa_emulation.c
> @@ -77,20 +77,19 @@ static int __init emu_setup_memblk(struct numa_meminfo *ei,
>  }
>  
>  /*
> - * Sets up nr_nodes fake nodes interleaved over physical nodes ranging from addr
> - * to max_addr.
> + * Sets up nr_nodes fake nodes interleaved over all physical nodes
>   *
>   * Returns zero on success or negative on error.
>   */
>  static int __init split_nodes_interleave(struct numa_meminfo *ei,
>  					 struct numa_meminfo *pi,
> -					 u64 addr, u64 max_addr, int nr_nodes)
> +					 int nr_nodes)
>  {
>  	nodemask_t physnode_mask = numa_nodes_parsed;
> -	u64 size;
> -	int big;
> -	int nid = 0;
> -	int i, ret;
> +	int nid = 0, physnodes_with_mem = 0;
> +	int i, ret, phys_blk;
> +	static u64 sizes[MAX_NUMNODES] __initdata;
> +	static int bigs[MAX_NUMNODES] __initdata;
>  
>  	if (nr_nodes <= 0)
>  		return -1;
> @@ -100,25 +99,41 @@ static int __init split_nodes_interleave(struct numa_meminfo *ei,
>  		nr_nodes = MAX_NUMNODES;
>  	}
>  
> -	/*
> -	 * Calculate target node size.  x86_32 freaks on __udivdi3() so do
> -	 * the division in ulong number of pages and convert back.
> -	 */
> -	size = max_addr - addr - mem_hole_size(addr, max_addr);
> -	size = PFN_PHYS((unsigned long)(size >> PAGE_SHIFT) / nr_nodes);
> +	/* count physical nodes with memory */
> +	for_each_node_mask(i, physnode_mask) {
> +		phys_blk = emu_find_memblk_by_nid(i, pi);
> +		if (phys_blk < 0)
> +			continue;
> +		physnodes_with_mem++;
> +	}
>  
>  	/*
> -	 * Calculate the number of big nodes that can be allocated as a result
> -	 * of consolidating the remainder.
> +	 * Calculate target fake nodes sizes for each physical node with memory.
> +	 * x86_32 freaks on __udivdi3() so do the division in ulong number of
> +	 * pages and convert back.
>  	 */
> -	big = ((size & ~FAKE_NODE_MIN_HASH_MASK) * nr_nodes) /
> -		FAKE_NODE_MIN_SIZE;
> +	for_each_node_mask(i, physnode_mask) {
> +		phys_blk = emu_find_memblk_by_nid(i, pi);
> +		if (phys_blk < 0)
> +			continue;
>  
> -	size &= FAKE_NODE_MIN_HASH_MASK;
> -	if (!size) {
> -		pr_err("Not enough memory for each node.  "
> -			"NUMA emulation disabled.\n");
> -		return -1;
> +		sizes[i] = pi->blk[phys_blk].end - pi->blk[phys_blk].start -
> +			   mem_hole_size(pi->blk[phys_blk].start, pi->blk[phys_blk].end);
> +		sizes[i] = PFN_PHYS((unsigned long)(sizes[i] >> PAGE_SHIFT) /
> +			   nr_nodes * physnodes_with_mem);
> +
> +		/*
> +		 * Calculate the number of big nodes that can be allocated as a result
> +		 * of consolidating the remainder.
> +		 */
> +		bigs[i] = ((sizes[i] & ~FAKE_NODE_MIN_HASH_MASK) * nr_nodes) / physnodes_with_mem /
> +			  FAKE_NODE_MIN_SIZE;
> +		sizes[i] &= FAKE_NODE_MIN_HASH_MASK;
> +		if (!sizes[i]) {
> +			pr_err("Not enough memory for each node inside physical numa node %d. NUMA emulation disabled.\n",
> +			       i);
> +			return -1;
> +		}
>  	}
>  
>  	/*
> @@ -138,16 +150,16 @@ static int __init split_nodes_interleave(struct numa_meminfo *ei,
>  			}
>  			start = pi->blk[phys_blk].start;
>  			limit = pi->blk[phys_blk].end;
> -			end = start + size;
> +			end = start + sizes[i];
>  
> -			if (nid < big)
> +			if (nid < bigs[i])
>  				end += FAKE_NODE_MIN_SIZE;
>  
>  			/*
>  			 * Continue to add memory to this fake node if its
>  			 * non-reserved memory is less than the per-node size.
>  			 */
> -			while (end - start - mem_hole_size(start, end) < size) {
> +			while (end - start - mem_hole_size(start, end) < sizes[i]) {
>  				end += FAKE_NODE_MIN_SIZE;
>  				if (end > limit) {
>  					end = limit;
> @@ -169,7 +181,7 @@ static int __init split_nodes_interleave(struct numa_meminfo *ei,
>  			 * next node, this one must extend to the end of the
>  			 * physical node.
>  			 */
> -			if (limit - end - mem_hole_size(end, limit) < size)
> +			if (limit - end - mem_hole_size(end, limit) < sizes[i])
>  				end = limit;
>  
>  			ret = emu_setup_memblk(ei, pi, nid++ % nr_nodes,
> @@ -432,7 +444,7 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
>  		unsigned long n;
>  
>  		n = simple_strtoul(emu_cmdline, &emu_cmdline, 0);
> -		ret = split_nodes_interleave(&ei, &pi, 0, max_addr, n);
> +		ret = split_nodes_interleave(&ei, &pi, n);
>  	}
>  	if (*emu_cmdline == ':')
>  		emu_cmdline++;
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

