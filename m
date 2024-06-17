Return-Path: <linux-kernel+bounces-216732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1845390A554
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5B41F23A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A587B1836DF;
	Mon, 17 Jun 2024 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yk/oUo8/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1714AA0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605258; cv=none; b=fhxTOLSTw16zaUStUgEH9vIqiZxRc5crnjU1vR3/0ZVzybOYEqScshgO29zGAzQXmHUUpVSZQhG1zcIzyU60EmBqyGoOrA7E5kzhSrCgc+3iUL+w5bEBCCZYZczSjjw/MqJRcU5G2m9txJvaOpDcTpb8vW1npyTPAzpJThJJ/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605258; c=relaxed/simple;
	bh=dK2Mi/BhfKWjW+UWurcHIbKRW6z1FP74+iw69tD6t5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OrrbaoRTZz2dKLRK5D6NlzHyfKjwcbaZmdBM26QAA8Q6+QCFVcGYCuDhgq5MLv9+DJ4bWVJxrJ76Q50rsbcHBFgK3FrWzNJqiC645Ad/4lQab4+oW6UkzfsBMaCWC1hg7xq85TbCWhPfsbjDjbNNRSq6zZ4cHgO+blDLCXeVBjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yk/oUo8/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718605256; x=1750141256;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=dK2Mi/BhfKWjW+UWurcHIbKRW6z1FP74+iw69tD6t5w=;
  b=Yk/oUo8/5kjbevSA9dlrqduMJ3NIJVZv+v4Q20C7HPw6DzMOAuk4ZFKG
   g6Gq3Utzq22ZquICNGyRJr0oR75pesDSFyK3btByF8CnwkYxYb8yjx4KR
   A4h4pCn/TFfh9rlcmEJq9Sk+DVkqM7VZl37Kf8+Tnx6n+wYdCGQ3IIMz8
   XeQiOvgVTCME7MqhVnW72aPkHqthlzQPMPDL79elYJlYmE9iyzeWtI8Cn
   eifLw97t7tRPiClXwc7/++E7z8y/ScW9YeVh9DOA0x/WO+U4KKiqyugI/
   0gd/0HxQ2Tv67Yf4trn833GJ6nvIlDUI1mx4hlPHjIlURNQs+2iYKrUz6
   g==;
X-CSE-ConnectionGUID: SrTbiM82QYS33zAKMjaAAA==
X-CSE-MsgGUID: 79c6ICMJTSG/OJzdon0NOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="25996835"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="25996835"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:20:56 -0700
X-CSE-ConnectionGUID: 2fFd7fbDQbe2rVAw8X+MCg==
X-CSE-MsgGUID: iH04UVgKQlSMuk7gOYHY0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41794831"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:20:53 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Kalesh Singh
 <kaleshsingh@google.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v2 1/2] mm: swap: swap cluster switch to double link list
In-Reply-To: <20240614-swap-allocator-v2-1-2a513b4a7f2f@kernel.org> (Chris
	Li's message of "Fri, 14 Jun 2024 16:48:07 -0700")
References: <20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org>
	<20240614-swap-allocator-v2-1-2a513b4a7f2f@kernel.org>
Date: Mon, 17 Jun 2024 14:19:01 +0800
Message-ID: <87frtc5bxm.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Chris,

Chris Li <chrisl@kernel.org> writes:

> Previously, the swap cluster used a cluster index as a pointer
> to construct a custom single link list type "swap_cluster_list".
> The next cluster pointer is shared with the cluster->count.
> It prevents puting the non free cluster into a list.
> Change the cluster to use the standard double link list instead.
> This allows tracing the nonfull cluster in the follow up patch.
>
> Remove the cluster getter/setter for accessing the cluster
> struct member.
>
> The list operation is protected by the swap_info_struct->lock.
>
> Change cluster code to use "struct swap_cluster_info *" to
> reference the cluster rather than by using index. That is more
> consistent with the list manipulation. It avoids the repeat
> adding index to the cluser_info. The code is easier to understand.
>
> Remove the cluster next pointer is NULL flag, the double link
> list can handle the empty list pretty well.

The above is more about "what" instead of "why".  We can identify "what"
from the patch itself.  I expect more "why".  I guess that we can reduce
swap_map[] scanning if we have lists of non-full/non-free clusters.

> The "swap_cluster_info" struct is two pointer bigger, because
> 512 swap entries share one swap struct, it has very little impact
> on the average memory usage per swap entry. For 1TB swapfile, the
> swap cluster data structure increases from 8MB to 24MB.
>
> Other than the list conversion, there is no real function change
> in this patch.
>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
>  include/linux/swap.h |  28 +++----
>  mm/swapfile.c        | 227 +++++++++++++--------------------------------------
>  2 files changed, 70 insertions(+), 185 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 3df75d62a835..cd9154a3e934 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -242,23 +242,22 @@ enum {
>   * space with SWAPFILE_CLUSTER pages long and naturally aligns in disk. All
>   * free clusters are organized into a list. We fetch an entry from the list to
>   * get a free cluster.
> - *
> - * The data field stores next cluster if the cluster is free or cluster usage
> - * counter otherwise. The flags field determines if a cluster is free. This is
> - * protected by swap_info_struct.lock.
>   */
>  struct swap_cluster_info {
>  	spinlock_t lock;	/*
> -				 * Protect swap_cluster_info fields
> -				 * and swap_info_struct->swap_map
> +				 * Protect swap_cluster_info count and state

Protect swap_cluster_info fields except 'list' ?

> +				 * field and swap_info_struct->swap_map
>  				 * elements correspond to the swap
>  				 * cluster
>  				 */
> -	unsigned int data:24;
> -	unsigned int flags:8;
> +	unsigned int count:12;
> +	unsigned int state:3;

I still prefer normal data type over bit fields.  How about

        u16 usage;
        u8  state;

And, how about use 'usage' instead of 'count'?  Personally I think that
it is more clear.  But I don't have strong opinions on this.

> +	struct list_head list;	/* Protected by swap_info_struct->lock */
>  };
> -#define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> -#define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster */
> +
> +#define CLUSTER_STATE_FREE	1 /* This cluster is free */

Can we use swap_cluster_info->count == 0?

> +#define CLUSTER_STATE_PER_CPU	2 /* This cluster on per_cpu_cluster  */
> +

There's no users of this state in this patch.  IMHO, it's better to
introduce a symbol with its users, otherwise, it's hard to understand
why do we need it and how to use it.  And, IIUC, the state isn't
maintained properly, it should be changed when we move the cluster off
the per-cpu cluster.

>  /*
>   * The first page in the swap file is the swap header, which is always marked
> @@ -283,11 +282,6 @@ struct percpu_cluster {
>  	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
>  };
>  
> -struct swap_cluster_list {
> -	struct swap_cluster_info head;
> -	struct swap_cluster_info tail;
> -};
> -
>  /*
>   * The in-memory structure used to track swap areas.
>   */
> @@ -300,7 +294,7 @@ struct swap_info_struct {
>  	unsigned int	max;		/* extent of the swap_map */
>  	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
>  	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
> -	struct swap_cluster_list free_clusters; /* free clusters list */
> +	struct list_head free_clusters; /* free clusters list */
>  	unsigned int lowest_bit;	/* index of first free in swap_map */
>  	unsigned int highest_bit;	/* index of last free in swap_map */
>  	unsigned int pages;		/* total of usable pages of swap */
> @@ -331,7 +325,7 @@ struct swap_info_struct {
>  					 * list.
>  					 */
>  	struct work_struct discard_work; /* discard worker */
> -	struct swap_cluster_list discard_clusters; /* discard clusters list */
> +	struct list_head discard_clusters; /* discard clusters list */
>  	struct plist_node avail_lists[]; /*
>  					   * entries in swap_avail_heads, one
>  					   * entry per node.
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 9c6d8e557c0f..2f878b374349 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -290,62 +290,9 @@ static void discard_swap_cluster(struct swap_info_struct *si,
>  #endif
>  #define LATENCY_LIMIT		256
>  
> -static inline void cluster_set_flag(struct swap_cluster_info *info,
> -	unsigned int flag)
> -{
> -	info->flags = flag;
> -}
> -
> -static inline unsigned int cluster_count(struct swap_cluster_info *info)
> -{
> -	return info->data;
> -}
> -
> -static inline void cluster_set_count(struct swap_cluster_info *info,
> -				     unsigned int c)
> -{
> -	info->data = c;
> -}
> -
> -static inline void cluster_set_count_flag(struct swap_cluster_info *info,
> -					 unsigned int c, unsigned int f)
> -{
> -	info->flags = f;
> -	info->data = c;
> -}
> -
> -static inline unsigned int cluster_next(struct swap_cluster_info *info)
> -{
> -	return info->data;
> -}
> -
> -static inline void cluster_set_next(struct swap_cluster_info *info,
> -				    unsigned int n)
> -{
> -	info->data = n;
> -}
> -
> -static inline void cluster_set_next_flag(struct swap_cluster_info *info,
> -					 unsigned int n, unsigned int f)
> -{
> -	info->flags = f;
> -	info->data = n;
> -}
> -
>  static inline bool cluster_is_free(struct swap_cluster_info *info)
>  {
> -	return info->flags & CLUSTER_FLAG_FREE;
> -}
> -
> -static inline bool cluster_is_null(struct swap_cluster_info *info)
> -{
> -	return info->flags & CLUSTER_FLAG_NEXT_NULL;
> -}
> -
> -static inline void cluster_set_null(struct swap_cluster_info *info)
> -{
> -	info->flags = CLUSTER_FLAG_NEXT_NULL;
> -	info->data = 0;
> +	return info->state == CLUSTER_STATE_FREE;
>  }
>  
>  static inline struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
> @@ -394,65 +341,11 @@ static inline void unlock_cluster_or_swap_info(struct swap_info_struct *si,
>  		spin_unlock(&si->lock);
>  }
>  
> -static inline bool cluster_list_empty(struct swap_cluster_list *list)
> -{
> -	return cluster_is_null(&list->head);
> -}
> -
> -static inline unsigned int cluster_list_first(struct swap_cluster_list *list)
> -{
> -	return cluster_next(&list->head);
> -}
> -
> -static void cluster_list_init(struct swap_cluster_list *list)
> -{
> -	cluster_set_null(&list->head);
> -	cluster_set_null(&list->tail);
> -}
> -
> -static void cluster_list_add_tail(struct swap_cluster_list *list,
> -				  struct swap_cluster_info *ci,
> -				  unsigned int idx)
> -{
> -	if (cluster_list_empty(list)) {
> -		cluster_set_next_flag(&list->head, idx, 0);
> -		cluster_set_next_flag(&list->tail, idx, 0);
> -	} else {
> -		struct swap_cluster_info *ci_tail;
> -		unsigned int tail = cluster_next(&list->tail);
> -
> -		/*
> -		 * Nested cluster lock, but both cluster locks are
> -		 * only acquired when we held swap_info_struct->lock
> -		 */
> -		ci_tail = ci + tail;
> -		spin_lock_nested(&ci_tail->lock, SINGLE_DEPTH_NESTING);
> -		cluster_set_next(ci_tail, idx);
> -		spin_unlock(&ci_tail->lock);
> -		cluster_set_next_flag(&list->tail, idx, 0);
> -	}
> -}
> -
> -static unsigned int cluster_list_del_first(struct swap_cluster_list *list,
> -					   struct swap_cluster_info *ci)
> -{
> -	unsigned int idx;
> -
> -	idx = cluster_next(&list->head);
> -	if (cluster_next(&list->tail) == idx) {
> -		cluster_set_null(&list->head);
> -		cluster_set_null(&list->tail);
> -	} else
> -		cluster_set_next_flag(&list->head,
> -				      cluster_next(&ci[idx]), 0);
> -
> -	return idx;
> -}
> -
>  /* Add a cluster to discard list and schedule it to do discard */
>  static void swap_cluster_schedule_discard(struct swap_info_struct *si,
> -		unsigned int idx)
> +		struct swap_cluster_info *ci)
>  {
> +	unsigned int idx = ci - si->cluster_info;

I see this multiple times in the patch, can we define a helper for this?

>  	/*
>  	 * If scan_swap_map_slots() can't find a free cluster, it will check
>  	 * si->swap_map directly. To make sure the discarding cluster isn't
> @@ -462,17 +355,14 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
>  	memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>  			SWAP_MAP_BAD, SWAPFILE_CLUSTER);
>  
> -	cluster_list_add_tail(&si->discard_clusters, si->cluster_info, idx);
> -
> +	list_add_tail(&ci->list, &si->discard_clusters);
>  	schedule_work(&si->discard_work);
>  }
>  
> -static void __free_cluster(struct swap_info_struct *si, unsigned long idx)
> +static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
>  {
> -	struct swap_cluster_info *ci = si->cluster_info;
> -
> -	cluster_set_flag(ci + idx, CLUSTER_FLAG_FREE);
> -	cluster_list_add_tail(&si->free_clusters, ci, idx);
> +	ci->state = CLUSTER_STATE_FREE;
> +	list_add_tail(&ci->list, &si->free_clusters);
>  }
>  
>  /*
> @@ -481,21 +371,22 @@ static void __free_cluster(struct swap_info_struct *si, unsigned long idx)
>  */
>  static void swap_do_scheduled_discard(struct swap_info_struct *si)
>  {
> -	struct swap_cluster_info *info, *ci;
> +	struct swap_cluster_info *ci;
>  	unsigned int idx;
>  
> -	info = si->cluster_info;
> -
> -	while (!cluster_list_empty(&si->discard_clusters)) {
> -		idx = cluster_list_del_first(&si->discard_clusters, info);
> +	while (!list_empty(&si->discard_clusters)) {
> +		ci = list_first_entry(&si->discard_clusters, struct swap_cluster_info, list);
> +		list_del(&ci->list);
> +		idx = ci - si->cluster_info;
>  		spin_unlock(&si->lock);
>  
>  		discard_swap_cluster(si, idx * SWAPFILE_CLUSTER,
>  				SWAPFILE_CLUSTER);
>  
>  		spin_lock(&si->lock);
> -		ci = lock_cluster(si, idx * SWAPFILE_CLUSTER);
> -		__free_cluster(si, idx);
> +
> +		spin_lock(&ci->lock);

Personally, I still prefer to use lock_cluster(), which is more readable
and matches unlock_cluster() below.

> +		__free_cluster(si, ci);
>  		memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>  				0, SWAPFILE_CLUSTER);
>  		unlock_cluster(ci);
> @@ -521,20 +412,19 @@ static void swap_users_ref_free(struct percpu_ref *ref)
>  	complete(&si->comp);
>  }
>  
> -static void alloc_cluster(struct swap_info_struct *si, unsigned long idx)
> +static struct swap_cluster_info *alloc_cluster(struct swap_info_struct *si, unsigned long idx)
>  {
> -	struct swap_cluster_info *ci = si->cluster_info;
> +	struct swap_cluster_info *ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
>  
> -	VM_BUG_ON(cluster_list_first(&si->free_clusters) != idx);
> -	cluster_list_del_first(&si->free_clusters, ci);
> -	cluster_set_count_flag(ci + idx, 0, 0);
> +	VM_BUG_ON(ci - si->cluster_info != idx);
> +	list_del(&ci->list);
> +	ci->count = 0;

Do we need this now?  If we keep CLUSTER_STATE_FREE, we need to change
it here.

> +	return ci;
>  }
>  
> -static void free_cluster(struct swap_info_struct *si, unsigned long idx)
> +static void free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
>  {
> -	struct swap_cluster_info *ci = si->cluster_info + idx;
> -
> -	VM_BUG_ON(cluster_count(ci) != 0);
> +	VM_BUG_ON(ci->count != 0);
>  	/*
>  	 * If the swap is discardable, prepare discard the cluster
>  	 * instead of free it immediately. The cluster will be freed
> @@ -542,11 +432,11 @@ static void free_cluster(struct swap_info_struct *si, unsigned long idx)
>  	 */
>  	if ((si->flags & (SWP_WRITEOK | SWP_PAGE_DISCARD)) ==
>  	    (SWP_WRITEOK | SWP_PAGE_DISCARD)) {
> -		swap_cluster_schedule_discard(si, idx);
> +		swap_cluster_schedule_discard(si, ci);
>  		return;
>  	}
>  
> -	__free_cluster(si, idx);
> +	__free_cluster(si, ci);
>  }
>  
>  /*
> @@ -559,15 +449,15 @@ static void add_cluster_info_page(struct swap_info_struct *p,
>  	unsigned long count)
>  {
>  	unsigned long idx = page_nr / SWAPFILE_CLUSTER;
> +	struct swap_cluster_info *ci = cluster_info + idx;
>  
>  	if (!cluster_info)
>  		return;
> -	if (cluster_is_free(&cluster_info[idx]))
> +	if (cluster_is_free(ci))
>  		alloc_cluster(p, idx);
>  
> -	VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE_CLUSTER);
> -	cluster_set_count(&cluster_info[idx],
> -		cluster_count(&cluster_info[idx]) + count);
> +	VM_BUG_ON(ci->count + count > SWAPFILE_CLUSTER);
> +	ci->count += count;
>  }
>  
>  /*
> @@ -581,24 +471,20 @@ static void inc_cluster_info_page(struct swap_info_struct *p,
>  }
>  
>  /*
> - * The cluster corresponding to page_nr decreases one usage. If the usage
> - * counter becomes 0, which means no page in the cluster is in using, we can
> - * optionally discard the cluster and add it to free cluster list.
> + * The cluster ci decreases one usage. If the usage counter becomes 0,
> + * which means no page in the cluster is in using, we can optionally discard
> + * the cluster and add it to free cluster list.
>   */
> -static void dec_cluster_info_page(struct swap_info_struct *p,
> -	struct swap_cluster_info *cluster_info, unsigned long page_nr)
> +static void dec_cluster_info_page(struct swap_info_struct *p, struct swap_cluster_info *ci)
>  {
> -	unsigned long idx = page_nr / SWAPFILE_CLUSTER;
> -
> -	if (!cluster_info)
> +	if (!p->cluster_info)
>  		return;
>  
> -	VM_BUG_ON(cluster_count(&cluster_info[idx]) == 0);
> -	cluster_set_count(&cluster_info[idx],
> -		cluster_count(&cluster_info[idx]) - 1);
> +	VM_BUG_ON(ci->count == 0);
> +	ci->count--;
>  
> -	if (cluster_count(&cluster_info[idx]) == 0)
> -		free_cluster(p, idx);
> +	if (!ci->count)
> +		free_cluster(p, ci);
>  }
>  
>  /*
> @@ -611,10 +497,10 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>  {
>  	struct percpu_cluster *percpu_cluster;
>  	bool conflict;
> -

Usually we use one blank line after local variable declaration.

> +	struct swap_cluster_info *first = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
>  	offset /= SWAPFILE_CLUSTER;
> -	conflict = !cluster_list_empty(&si->free_clusters) &&
> -		offset != cluster_list_first(&si->free_clusters) &&
> +	conflict = !list_empty(&si->free_clusters) &&
> +		offset !=  first - si->cluster_info &&
>  		cluster_is_free(&si->cluster_info[offset]);
>  
>  	if (!conflict)
> @@ -655,10 +541,14 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>  	cluster = this_cpu_ptr(si->percpu_cluster);
>  	tmp = cluster->next[order];
>  	if (tmp == SWAP_NEXT_INVALID) {
> -		if (!cluster_list_empty(&si->free_clusters)) {
> -			tmp = cluster_next(&si->free_clusters.head) *
> -					SWAPFILE_CLUSTER;
> -		} else if (!cluster_list_empty(&si->discard_clusters)) {
> +		if (!list_empty(&si->free_clusters)) {
> +			ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
> +			list_del(&ci->list);

The free cluster is deleted from si->free_clusters now.  But later you
will call scan_swap_map_ssd_cluster_conflict() and may abandon the
cluster.  And in alloc_cluster() later, it may be deleted again.

> +			spin_lock(&ci->lock);
> +			ci->state = CLUSTER_STATE_PER_CPU;

Need to change ci->state when move a cluster off the percpu_cluster.

> +			spin_unlock(&ci->lock);
> +			tmp = (ci - si->cluster_info) * SWAPFILE_CLUSTER;
> +		} else if (!list_empty(&si->discard_clusters)) {
>  			/*
>  			 * we don't have free cluster but have some clusters in
>  			 * discarding, do discard now and reclaim them, then
> @@ -1062,8 +952,8 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>  
>  	ci = lock_cluster(si, offset);
>  	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> -	cluster_set_count_flag(ci, 0, 0);
> -	free_cluster(si, idx);
> +	ci->count = 0;
> +	free_cluster(si, ci);
>  	unlock_cluster(ci);
>  	swap_range_free(si, offset, SWAPFILE_CLUSTER);
>  }
> @@ -1336,7 +1226,7 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
>  	count = p->swap_map[offset];
>  	VM_BUG_ON(count != SWAP_HAS_CACHE);
>  	p->swap_map[offset] = 0;
> -	dec_cluster_info_page(p, p->cluster_info, offset);
> +	dec_cluster_info_page(p, ci);
>  	unlock_cluster(ci);
>  
>  	mem_cgroup_uncharge_swap(entry, 1);
> @@ -3003,8 +2893,8 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
>  
>  	nr_good_pages = maxpages - 1;	/* omit header page */
>  
> -	cluster_list_init(&p->free_clusters);
> -	cluster_list_init(&p->discard_clusters);
> +	INIT_LIST_HEAD(&p->free_clusters);
> +	INIT_LIST_HEAD(&p->discard_clusters);
>  
>  	for (i = 0; i < swap_header->info.nr_badpages; i++) {
>  		unsigned int page_nr = swap_header->info.badpages[i];
> @@ -3055,14 +2945,15 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
>  	for (k = 0; k < SWAP_CLUSTER_COLS; k++) {
>  		j = (k + col) % SWAP_CLUSTER_COLS;
>  		for (i = 0; i < DIV_ROUND_UP(nr_clusters, SWAP_CLUSTER_COLS); i++) {
> +			struct swap_cluster_info *ci;
>  			idx = i * SWAP_CLUSTER_COLS + j;
> +			ci = cluster_info + idx;
>  			if (idx >= nr_clusters)
>  				continue;
> -			if (cluster_count(&cluster_info[idx]))
> +			if (ci->count)
>  				continue;
> -			cluster_set_flag(&cluster_info[idx], CLUSTER_FLAG_FREE);
> -			cluster_list_add_tail(&p->free_clusters, cluster_info,
> -					      idx);
> +			ci->state = CLUSTER_STATE_FREE;
> +			list_add_tail(&ci->list, &p->free_clusters);
>  		}
>  	}
>  	return nr_extents;

--
Best Regards,
Huang, Ying

