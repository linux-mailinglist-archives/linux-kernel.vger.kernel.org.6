Return-Path: <linux-kernel+bounces-205837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A80AC90010A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EC41F25AE1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB47C16EC17;
	Fri,  7 Jun 2024 10:35:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B62E167262
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756545; cv=none; b=luNS1kS5sZ/mPtFUKM2MAHqkoo0EiYNQgcoMmfoj6TE7qSauEj6nJ/JAm6mUNHv4Z2YSo6JHpbOMuCV/E+Gq/3z0jAnQqUMleNRVZMixrPIkHmZZJ8TB0k8eCmLMOadH1L/hKFxxCjG0c6ImmXSuXC5wTww4ttpr150t2/d+Mlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756545; c=relaxed/simple;
	bh=7BXqu3/vkij+bIX4tN8z01PJ9Iub1i4XYvtUypEXy4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fIveglaF0OagIhG4KVn0o4gfcOYTZLWN6gNyY0R7FmJOesX9iIRYhroM7HZTKZpjP+yz5MyqQqdPQEU04kyLFvEhnro+yKSr6qo0+XSMZ/E+dtIDsQ0+nzmHdMLSzoyp0WW5GNig0kjW+Dz2ILREAr7qy4H/dU4iFhcjPY68VXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 119952F4;
	Fri,  7 Jun 2024 03:36:05 -0700 (PDT)
Received: from [10.57.70.246] (unknown [10.57.70.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1A9F3F64C;
	Fri,  7 Jun 2024 03:35:39 -0700 (PDT)
Message-ID: <edb439ea-4754-4d63-8d5f-edc116465d7b@arm.com>
Date: Fri, 7 Jun 2024 11:35:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: swap: mTHP allocate swap entries from nonfull
 list
Content-Language: en-GB
To: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, "Huang, Ying" <ying.huang@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <baohua@kernel.org>
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <20240524-swap-allocator-v1-2-47861b423b26@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240524-swap-allocator-v1-2-47861b423b26@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/05/2024 18:17, Chris Li wrote:
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

If I've understood correctly, the aim here is to link all the current per-cpu
clusters for a given order together so that if a cpu can't allocate a new
cluster for a given order, then it can steal another CPU's current cluster for
that order?

If that's the intent, couldn't that be done just by iterating over the per-cpu,
per-order cluster pointers? Then you don't need all the linked list churn
(althogh I like the linked list changes as a nice cleanup, I'm not sure the
churn is neccessary for this change?). There would likely need to be some
locking considerations, but it would also allow you to get access to the next
entry within the cluster for allocation.

However, fundamentally, I don't think this change solves the problem; it just
takes a bit longer before the allocation fails. The real problem is
fragmentation due to freeing individual pages from swap entries at different times.

Wouldn't it be better to just extend scanning to support high order allocations?
Then we can steal a high order block from any cluster, even clusters that were
previously full, just like we currently do for order-0. Given we are already
falling back to this path for order-0, I don't think it would be any more
expensive; infact its less expensive because we only scan once for the high
order block, rather than scan for every split order-0 page.

Of course that still doesn't solve the proplem entirely; if swap is so
fragmented that there is no contiguous block of the required order then you
still have to fall back to splitting. As an extra optimization, you could store
the largest contiguous free space available in each cluster to avoid scanning in
case its too small?


> 
> There are limitations if the distribution of numbers of
> different orders of mTHP changes a lot. e.g. there are a lot
> of nonfull cluster assign to order A while later time there
> are a lot of order B allocation while very little allocation
> in order A. Currently the cluster used by order A will not
> reused by order B unless the cluster is 100% empty.
> 
> This situation is best addressed by the longer term "swap
> buddy allocator", in future patches.
> ---
>  include/linux/swap.h |  4 ++++
>  mm/swapfile.c        | 25 +++++++++++++++++++++++--
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 0d3906eff3c9..1b7f0794b9bf 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -255,10 +255,12 @@ struct swap_cluster_info {
>  				 * cluster
>  				 */
>  	unsigned int count:16;
> +	unsigned int order:8;
>  	unsigned int flags:8;
>  	struct list_head next;
>  };
>  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> +#define CLUSTER_FLAG_NONFULL 2 /* This cluster is on nonfull list */
>  
>  
>  /*
> @@ -297,6 +299,8 @@ struct swap_info_struct {
>  	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
>  	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
>  	struct list_head free_clusters; /* free clusters list */
> +	struct list_head nonfull_clusters[SWAP_NR_ORDERS];
> +					/* list of cluster that contains at least one free slot */
>  	unsigned int lowest_bit;	/* index of first free in swap_map */
>  	unsigned int highest_bit;	/* index of last free in swap_map */
>  	unsigned int pages;		/* total of usable pages of swap */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 205a60c5f9cb..51923aba500e 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -363,8 +363,11 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
>  
>  static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
>  {
> +	if (ci->flags & CLUSTER_FLAG_NONFULL)
> +		list_move_tail(&ci->next, &si->free_clusters);
> +	else
> +		list_add_tail(&ci->next, &si->free_clusters);
>  	ci->flags = CLUSTER_FLAG_FREE;
> -	list_add_tail(&ci->next, &si->free_clusters);
>  }
>  
>  /*
> @@ -486,7 +489,12 @@ static void dec_cluster_info_page(struct swap_info_struct *p, struct swap_cluste
>  	ci->count--;
>  
>  	if (!ci->count)
> -		free_cluster(p, ci);
> +		return free_cluster(p, ci);
> +
> +	if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
> +		list_add_tail(&ci->next, &p->nonfull_clusters[ci->order]);
> +		ci->flags |= CLUSTER_FLAG_NONFULL;
> +	}
>  }
>  
>  /*
> @@ -547,6 +555,14 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>  			ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, next);
>  			list_del(&ci->next);
>  			spin_lock(&ci->lock);
> +			ci->order = order;
> +			ci->flags = 0;
> +			spin_unlock(&ci->lock);
> +			tmp = (ci - si->cluster_info) * SWAPFILE_CLUSTER;
> +		} else if (!list_empty(&si->nonfull_clusters[order])) {
> +			ci = list_first_entry(&si->nonfull_clusters[order], struct swap_cluster_info, next);
> +			list_del(&ci->next);
> +			spin_lock(&ci->lock);
>  			ci->flags = 0;
>  			spin_unlock(&ci->lock);
>  			tmp = (ci - si->cluster_info) * SWAPFILE_CLUSTER;

This looks wrong to me; if the cluster is on the nonfull list then it will have
had some entries already allocated (by another cpu). So pointing tmp to the
first block in the cluster will never yield a free block. The cpu from which you
are stealing the cluster stores the next free block location in its per-cpu
structure. So perhaps iterating over the other cpu's `struct percpu_cluster`s is
a better approach than the nonfull list?

Additionally, this cluster will be stored back to this cpu's current cluster at
the bottom of the function. That may or may not be what you intended.

> @@ -578,6 +594,7 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>  				break;
>  			tmp += nr_pages;
>  		}
> +		WARN_ONCE(ci->order != order, "expecting order %d got %d", order, ci->order);
>  		unlock_cluster(ci);
>  	}
>  	if (tmp >= max) {
> @@ -956,6 +973,7 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>  	ci = lock_cluster(si, offset);
>  	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
>  	ci->count = 0;
> +	ci->order = 0;
>  	ci->flags = 0;
>  	free_cluster(si, ci);
>  	unlock_cluster(ci);
> @@ -2882,6 +2900,9 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
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


