Return-Path: <linux-kernel+bounces-252759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C182D9317C6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41C01C2197A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241AA18F2E4;
	Mon, 15 Jul 2024 15:40:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B5CF9EC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721058024; cv=none; b=UYFdinUHbPjf3scHO/Ic4s61+A4upaZGPxz9fu7qGLNPThe2tIQ6AnmMkA4fzOLJX67zT5pvfH1Umd54k8LC46Ii2d/CWs3SQvIf5muvDdWjHuhcpoBU4jYAnWydeo0f3aUXG5aO3rrlDfI23WWlWGR8Ipi8O+B8u4gUHnLHsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721058024; c=relaxed/simple;
	bh=KbKdkXC/IMzhJcCil9kkkuvNTPTYYRu99BpPkIgiRl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwjqntQJieBEGK2L2VoPbT3Vzm/toZpiFR0arlxxnifPuYSWSbpb2r2bNZH4P2Xt5vaabJ+gA44LzBRDp/Wu0pX267F9SQ/2kJDzrc4LEUScf7BX2qKEFixtX6SVsA+scpWWFQahx0FhPCIxY1xFuzarI3/bQqwEc7iwI4UU0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD944FEC;
	Mon, 15 Jul 2024 08:40:46 -0700 (PDT)
Received: from [10.57.77.136] (unknown [10.57.77.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EE1B3F766;
	Mon, 15 Jul 2024 08:40:20 -0700 (PDT)
Message-ID: <ea720b4a-da70-4ee3-8f74-2c7344480170@arm.com>
Date: Mon, 15 Jul 2024 16:40:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from nonfull
 list
Content-Language: en-GB
To: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>,
 "Huang, Ying" <ying.huang@intel.com>, Kalesh Singh <kaleshsingh@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <baohua@kernel.org>
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
 <20240711-swap-allocator-v4-2-0295a4d4c7aa@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240711-swap-allocator-v4-2-0295a4d4c7aa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/07/2024 08:29, Chris Li wrote:
> Track the nonfull cluster as well as the empty cluster
> on lists. Each order has one nonfull cluster list.
> 
> The cluster will remember which order it was used during
> new cluster allocation.
> 
> When the cluster has free entry, add to the nonfull[order]
> list.  When the free cluster list is empty, also allocate
> from the nonempty list of that order.
> 
> This improves the mTHP swap allocation success rate.
> 
> There are limitations if the distribution of numbers of
> different orders of mTHP changes a lot. e.g. there are a lot
> of nonfull cluster assign to order A while later time there
> are a lot of order B allocation while very little allocation
> in order A. Currently the cluster used by order A will not
> reused by order B unless the cluster is 100% empty.
> 
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
>  include/linux/swap.h |  4 ++++
>  mm/swapfile.c        | 34 +++++++++++++++++++++++++++++++---
>  2 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index e9be95468fc7..db8d6000c116 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -254,9 +254,11 @@ struct swap_cluster_info {
>  				 */
>  	u16 count;
>  	u8 flags;
> +	u8 order;
>  	struct list_head list;
>  };
>  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> +#define CLUSTER_FLAG_NONFULL 2 /* This cluster is on nonfull list */
>  
>  
>  /*
> @@ -296,6 +298,8 @@ struct swap_info_struct {
>  	unsigned long *zeromap;		/* vmalloc'ed bitmap to track zero pages */
>  	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
>  	struct list_head free_clusters; /* free clusters list */
> +	struct list_head nonfull_clusters[SWAP_NR_ORDERS];
> +					/* list of cluster that contains at least one free slot */
>  	unsigned int lowest_bit;	/* index of first free in swap_map */
>  	unsigned int highest_bit;	/* index of last free in swap_map */
>  	unsigned int pages;		/* total of usable pages of swap */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f70d25005d2c..e13a33664cfa 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -361,14 +361,21 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
>  	memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>  			SWAP_MAP_BAD, SWAPFILE_CLUSTER);
>  
> -	list_add_tail(&ci->list, &si->discard_clusters);
> +	if (ci->flags)

I'm not sure this is future proof; what happens if a flag is added in future
that does not indicate that the cluster is on a list. Perhaps explicitly check
CLUSTER_FLAG_NONFULL? Or `if (!list_empty(&ci->list))`.

> +		list_move_tail(&ci->list, &si->discard_clusters);
> +	else
> +		list_add_tail(&ci->list, &si->discard_clusters);
> +	ci->flags = 0;

Bug: (I think?) the cluster ends up on the discard_clusters list and
swap_do_scheduled_discard() calls __free_cluster() which will then call
list_add_tail() to put it on the free_clusters list. But since it is on the
discard_list at that point, shouldn't it call list_move_tail()?

>  	schedule_work(&si->discard_work);
>  }
>  
>  static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
>  {
> +	if (ci->flags & CLUSTER_FLAG_NONFULL)
> +		list_move_tail(&ci->list, &si->free_clusters);
> +	else
> +		list_add_tail(&ci->list, &si->free_clusters);
>  	ci->flags = CLUSTER_FLAG_FREE;
> -	list_add_tail(&ci->list, &si->free_clusters);
>  }
>  
>  /*
> @@ -491,7 +498,12 @@ static void dec_cluster_info_page(struct swap_info_struct *p, struct swap_cluste
>  	ci->count--;
>  
>  	if (!ci->count)
> -		free_cluster(p, ci);
> +		return free_cluster(p, ci);

nit: I'm not sure what the kernel style guide says about this, but I'm not a
huge fan of returning void. I'd find it clearer if you just turn the below `if`
into an `else if`.

> +
> +	if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
> +		list_add_tail(&ci->list, &p->nonfull_clusters[ci->order]);

I find the transitions when you add and remove a cluster from the
nonfull_clusters list a bit strange (if I've understood correctly): It is added
to the list whenever there is at least one free swap entry if not already on the
list. But you take it off the list when assigning it as the current cluster for
a cpu in scan_swap_map_try_ssd_cluster().

So you could have this situation:

  - cpuA allocs cluster from free list (exclusive to that cpu)
  - cpuA allocs 1 swap entry from current cluster
  - swap entry is freed; cluster added to nonfull_clusters
  - cpuB "allocs" cluster from nonfull_clusters

At this point both cpuA and cpuB share the same cluster as their current
cluster. So why not just put the cluster on the nonfull_clusters list at
allocation time (when removed from free_list) and only remove it from the
nonfull_clusters list when it is completely full (or at least definitely doesn't
have room for an `order` allocation)? Then you allow "stealing" always instead
of just sometimes. You would likely want to move the cluster to the end of the
nonfull list when selecting it in scan_swap_map_try_ssd_cluster() to reduce the
chances of multiple CPUs using the same cluster.

Another potential optimization (which was in my hacked version IIRC) is to only
add/remove from nonfull list when `total - count` crosses the (1 << order)
boundary rather than when becoming completely full. You definitely won't be able
to allocate order-2 if there are only 3 pages available, for example.

> +		ci->flags |= CLUSTER_FLAG_NONFULL;
> +	}
>  }
>  
>  /*
> @@ -550,6 +562,18 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>  	if (tmp == SWAP_NEXT_INVALID) {
>  		if (!list_empty(&si->free_clusters)) {
>  			ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
> +			list_del(&ci->list);
> +			spin_lock(&ci->lock);
> +			ci->order = order;
> +			ci->flags = 0;
> +			spin_unlock(&ci->lock);
> +			tmp = cluster_index(si, ci) * SWAPFILE_CLUSTER;
> +		} else if (!list_empty(&si->nonfull_clusters[order])) {
> +			ci = list_first_entry(&si->nonfull_clusters[order], struct swap_cluster_info, list);
> +			list_del(&ci->list);
> +			spin_lock(&ci->lock);
> +			ci->flags = 0;
> +			spin_unlock(&ci->lock);
>  			tmp = cluster_index(si, ci) * SWAPFILE_CLUSTER;
>  		} else if (!list_empty(&si->discard_clusters)) {
>  			/*
> @@ -964,6 +988,7 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>  	ci = lock_cluster(si, offset);
>  	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
>  	ci->count = 0;
> +	ci->order = 0;
>  	ci->flags = 0;

Wonder if it would be better to put this in __free_cluster()?

Thanks,
Ryan

>  	free_cluster(si, ci);
>  	unlock_cluster(ci);
> @@ -2919,6 +2944,9 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
>  	INIT_LIST_HEAD(&p->free_clusters);
>  	INIT_LIST_HEAD(&p->discard_clusters);
>  
> +	for (i = 0; i < SWAP_NR_ORDERS; i++)
> +		INIT_LIST_HEAD(&p->nonfull_clusters[i]);
> +
>  	for (i = 0; i < swap_header->info.nr_badpages; i++) {
>  		unsigned int page_nr = swap_header->info.badpages[i];
>  		if (page_nr == 0 || page_nr > swap_header->info.last_page)
> 


