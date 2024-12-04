Return-Path: <linux-kernel+bounces-432223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0629E47DE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE861880368
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95141C3C1F;
	Wed,  4 Dec 2024 22:29:49 +0000 (UTC)
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9614D43D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.14.175.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733351389; cv=none; b=WIEsFyQ8hYvzLJ/IZFOukXWPSYQWOI5zOp6U/X8CLyuCGHpSGJ1lsn7TXEtSczQ5drWcO4qvy3znkSybfqItMENQmruqRh+4wO6wPvS4tZO63FHMzQa+YnugsNqvLuGKE/cZXzqf8gR1YXqoqjE03VB4CSH24ONab3vVTeCNGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733351389; c=relaxed/simple;
	bh=ux5zMYTkey3E5tiiH4Tq3NsLZqwUsZVzg1+aB3mwpPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zh4d/4fYARcIV6mm87W1gMvuL1yYIQxex9tJ++1uD9immlqMGHpjVnThFfUFPsxTV/M6Y7lVkYux9E/qpcNFOYWuw1BnYDxjYjGuHaFt8oYdS19IhrRRpECt8pRenR0BaveuVb7/XfiXsT1RtXoVU3bkECtfwmNKJl39EFKOAK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ruivo.org; spf=pass smtp.mailfrom=ruivo.org; arc=none smtp.client-ip=173.14.175.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ruivo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruivo.org
Received: by lobo.ruivo.org (Postfix, from userid 1011)
	id 4416A102562; Wed,  4 Dec 2024 17:21:11 -0500 (EST)
X-Spam-Level: 
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
	by lobo.ruivo.org (Postfix) with ESMTPSA id CDAE4102550;
	Wed,  4 Dec 2024 17:20:54 -0500 (EST)
Received: by jake.ruivo.org (Postfix, from userid 1000)
	id B087C17A0923; Wed, 04 Dec 2024 17:20:54 -0500 (EST)
Date: Wed, 4 Dec 2024 17:20:54 -0500
From: Aristeu Rozanski <aris@ruivo.org>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlb: prioritize surplus allocation from current node
Message-ID: <20241204222054.GA37229@cathedrallabs.org>
References: <20241204165503.628784-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204165503.628784-1-koichiro.den@canonical.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Thu, Dec 05, 2024 at 01:55:03AM +0900, Koichiro Den wrote:
> Previously, surplus allocations triggered by mmap were typically made
> from the node where the process was running. On a page fault, the area
> was reliably dequeued from the hugepage_freelists for that node.
> However, since commit 003af997c8a9 ("hugetlb: force allocating surplus
> hugepages on mempolicy allowed nodes"), dequeue_hugetlb_folio_vma() may
> fall back to other nodes unnecessarily even if there is no MPOL_BIND
> policy, causing folios to be dequeued from nodes other than the current
> one.
> 
> Also, allocating from the node where the current process is running is
> likely to result in a performance win, as mmap-ing processes often
> touch the area not so long after allocation. This change minimizes
> surprises for users relying on the previous behavior while maintaining
> the benefit introduced by the commit.
> 
> So, prioritize the node the current process is running on when possible.
> 
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---
>  mm/hugetlb.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5c8de0f5c760..0fa24e105202 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2463,7 +2463,13 @@ static int gather_surplus_pages(struct hstate *h, long delta)
>  	long needed, allocated;
>  	bool alloc_ok = true;
>  	int node;
> -	nodemask_t *mbind_nodemask = policy_mbind_nodemask(htlb_alloc_mask(h));
> +	nodemask_t *mbind_nodemask, alloc_nodemask;
> +
> +	mbind_nodemask = policy_mbind_nodemask(htlb_alloc_mask(h));
> +	if (mbind_nodemask)
> +		nodes_and(alloc_nodemask, *mbind_nodemask, cpuset_current_mems_allowed);
> +	else
> +		alloc_nodemask = cpuset_current_mems_allowed;
>  
>  	lockdep_assert_held(&hugetlb_lock);
>  	needed = (h->resv_huge_pages + delta) - h->free_huge_pages;
> @@ -2479,8 +2485,16 @@ static int gather_surplus_pages(struct hstate *h, long delta)
>  	spin_unlock_irq(&hugetlb_lock);
>  	for (i = 0; i < needed; i++) {
>  		folio = NULL;
> -		for_each_node_mask(node, cpuset_current_mems_allowed) {
> -			if (!mbind_nodemask || node_isset(node, *mbind_nodemask)) {
> +
> +		/* Prioritize current node */
> +		if (node_isset(numa_mem_id(), alloc_nodemask))
> +			folio = alloc_surplus_hugetlb_folio(h, htlb_alloc_mask(h),
> +					numa_mem_id(), NULL);
> +
> +		if (!folio) {
> +			for_each_node_mask(node, alloc_nodemask) {
> +				if (node == numa_mem_id())
> +					continue;
>  				folio = alloc_surplus_hugetlb_folio(h, htlb_alloc_mask(h),
>  						node, NULL);
>  				if (folio)

Acked-by: Aristeu Rozanski <aris@ruivo.org>

-- 
Aristeu


