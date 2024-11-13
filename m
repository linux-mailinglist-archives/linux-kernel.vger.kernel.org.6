Return-Path: <linux-kernel+bounces-407229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C97DA9C6A83
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 538CEB22810
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462CF189F47;
	Wed, 13 Nov 2024 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpPE2xMc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5269017837A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731486264; cv=none; b=D9gYPMH4Lx09LWBVM4XDo1sM/aJwVzgh5GU3gyjTpVdC+CGOAxbFcB1NRmnblxv2szEc+gaZx4TZPPk8kwfPVoG56MrOjUEt2L6+4UhhqHW0arvM3VKG2rjhBXUR2QI7bygoAB9r+Ba+Xv2kfuwpa/jnMZSA/PWZlm65WKSRFTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731486264; c=relaxed/simple;
	bh=E6NmNe5r0OVhK9kcBFpuSvzgak15G7aCepFbbnbQmD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T89AniwAvxQVycWtV7q9Ees4l1LeoVmHW8AFuVUxIfBrTUUe7FV6pGaPADqlOJepnojSruAT5BsDwr2gb0PFaqKovQFuAk13s9XXlWDV0vCaTqn3o+6PMLfq5kC3yEIWqMD454XiA7J+VlZdBBNBIfUghsEC7SrQyxqjusyN5FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpPE2xMc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731486263; x=1763022263;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=E6NmNe5r0OVhK9kcBFpuSvzgak15G7aCepFbbnbQmD4=;
  b=bpPE2xMcFnVSlcVwTA4nuTLsYk4ToHJBD8iEzaH7MbC8HNiIeOH3SFn4
   JSCOkEPyr32s3wk33i96zw+x9w7OiKSOY4C3YcntTOspPMivjWE1tyKnn
   lhetcn71oeVQ5PfurU8aQA3Hq7ulR3vyUjn+6CuxUWiKWXZaQSf2JP+26
   hJwTLLBA8LxKW5Cucms2o/MzRiYJQWDCl3TzOBd1O8NoS6v61KoT3y3r1
   QYu8nScaaUn6Dabsu1fZmOL2U9f9YzD6AtD9vORUP5bhcr7ksLc3A4B2S
   lIOXtlHOw3gZo1wCNF833bj4XWJUQoT+Ji9l/hr4Z5H0Tc7NmXmxiHJ8D
   A==;
X-CSE-ConnectionGUID: cSxMP18yTOqudlsgUxmcZQ==
X-CSE-MsgGUID: NTvhyapWR3Ok+mn4Pp8ZBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="18975281"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="18975281"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 00:23:26 -0800
X-CSE-ConnectionGUID: czodun8uQgyH/FGZDqMEdg==
X-CSE-MsgGUID: 8UOD8/y0RIGVLrXeGQ4vCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="92757051"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 00:23:24 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Barry Song
 <v-songbaohua@oppo.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Hugh
 Dickins <hughd@google.com>,  Kalesh Singh <kaleshsingh@google.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, swap: fix allocation and scanning race with swapoff
In-Reply-To: <20241112083414.78174-1-ryncsn@gmail.com> (Kairui Song's message
	of "Tue, 12 Nov 2024 16:34:14 +0800")
References: <20241112083414.78174-1-ryncsn@gmail.com>
Date: Wed, 13 Nov 2024 16:19:50 +0800
Message-ID: <87cyizzgt5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> There are two flags used to synchronize allocation and scanning with
> swapoff: SWP_WRITEOK and SWP_SCANNING.
>
> SWP_WRITEOK: Swapoff will first unset this flag, at this point any
> further swap allocation or scanning on this device should just abort
> so no more new entries will be referencing this device. Swapoff
> will then unuse all existing swap entries.
>
> SWP_SCANNING: This flag is set when device is being scanned. Swapoff
> will wait for all scanner to stop before the final release of the swap
> device structures to avoid UAF. Note this flag is the highest used bit
> of si->flags so it could be added up arithmetically, if there are
> multiple scanner.
>
> commit 5f843a9a3a1e ("mm: swap: separate SSD allocation from
> scan_swap_map_slots()") ignored SWP_SCANNING and SWP_WRITEOK flags while
> separating cluster allocation path from the old allocation path. Add
> the flags back to fix swapoff race. The race is hard to trigger as
> si->lock prevents most parallel operations, but si->lock could be
> dropped for reclaim or discard. This issue is found during code review.
>
> This commit fixes this problem. For SWP_SCANNING, Just like before,
> set the flag before scan and remove it afterwards.
>
> For SWP_WRITEOK, there are several places where si->lock could
> be dropped, it will be error-prone and make the code hard to follow
> if we try to cover these places one by one. So just do one check before
> the real allocation, which is also very similar like before.
> With new cluster allocator it may waste a bit of time iterating
> the clusters but won't take long, and swapoff is not performance
> sensitive.
>
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Closes: https://lore.kernel.org/linux-mm/87a5es3f1f.fsf@yhuang6-desk2.ccr.corp.intel.com/
> Fixes: 5f843a9a3a1e ("mm: swap: separate SSD allocation from scan_swap_map_slots()")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swapfile.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 9c85bd46ab7f..b0a9071cfe1d 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -664,12 +664,15 @@ static bool cluster_scan_range(struct swap_info_struct *si,
>  	return true;
>  }
>  
> -static void cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster_info *ci,
> +static bool cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster_info *ci,
>  				unsigned int start, unsigned char usage,
>  				unsigned int order)
>  {
>  	unsigned int nr_pages = 1 << order;
>  
> +	if (!(si->flags & SWP_WRITEOK))
> +		return false;
> +
>  	if (cluster_is_free(ci)) {
>  		if (nr_pages < SWAPFILE_CLUSTER) {
>  			list_move_tail(&ci->list, &si->nonfull_clusters[order]);
> @@ -690,6 +693,8 @@ static void cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster
>  		list_move_tail(&ci->list, &si->full_clusters);
>  		ci->flags = CLUSTER_FLAG_FULL;
>  	}
> +
> +	return true;
>  }
>  
>  static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si, unsigned long offset,
> @@ -713,7 +718,10 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si, unsigne
>  
>  	while (offset <= end) {
>  		if (cluster_scan_range(si, ci, offset, nr_pages)) {
> -			cluster_alloc_range(si, ci, offset, usage, order);
> +			if (!cluster_alloc_range(si, ci, offset, usage, order)) {
> +				offset = SWAP_NEXT_INVALID;

We set offset to SWAP_NEXT_INVALID for 3 times in this function.  Can we
use a local variable to remove the duplication?  For example,

        unsigned long ret = SWAP_NEXT_INVALID;

And set ret if we allocate swap entry successfully.  We can do this in a
separate patch.

Otherwise, LGTM, Thanks!  Feel free to add,

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> +				goto done;
> +			}
>  			*foundp = offset;
>  			if (ci->count == SWAPFILE_CLUSTER) {
>  				offset = SWAP_NEXT_INVALID;
> @@ -805,7 +813,11 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
>  	if (!list_empty(&si->free_clusters)) {
>  		ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
>  		offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci), &found, order, usage);
> -		VM_BUG_ON(!found);
> +		/*
> +		 * Either we didn't touch the cluster due to swapoff,
> +		 * or the allocation must success.
> +		 */
> +		VM_BUG_ON((si->flags & SWP_WRITEOK) && !found);
>  		goto done;
>  	}
>  
> @@ -1041,6 +1053,8 @@ static int cluster_alloc_swap(struct swap_info_struct *si,
>  
>  	VM_BUG_ON(!si->cluster_info);
>  
> +	si->flags += SWP_SCANNING;
> +
>  	while (n_ret < nr) {
>  		unsigned long offset = cluster_alloc_swap_entry(si, order, usage);
>  
> @@ -1049,6 +1063,8 @@ static int cluster_alloc_swap(struct swap_info_struct *si,
>  		slots[n_ret++] = swp_entry(si->type, offset);
>  	}
>  
> +	si->flags -= SWP_SCANNING;
> +
>  	return n_ret;
>  }

--
Best Regards,
Huang, Ying

