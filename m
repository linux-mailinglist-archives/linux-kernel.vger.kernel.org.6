Return-Path: <linux-kernel+bounces-223826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865A19118E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A501C21884
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 03:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901BE129A7E;
	Fri, 21 Jun 2024 03:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OF7fE8Qo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B64F1272A7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 03:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718938879; cv=none; b=OZSHak5LCTQRmyexs19ahYMTp4vs9EyFzSdhHFQ+3hw/qIGzJb51hSCIco32zsDJjkU/BhgXqj7SAUEgjDdScCi1GitrSen1IVbTO8u8g7wI6eWxm4Ytfib4TSEyFXjjjzBJ8nqBLdHOfPLdJmuFmn/f4CLh/8fOW2LiMabKliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718938879; c=relaxed/simple;
	bh=Nv0Rvw/INyCA4dZuB/Y+A7IFhJs/3yVzXGpJ5qG0rgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FbSIcfgj6Ho4fu6H+DZatDcpPg2j4SK1Jgs3+Cf2lVbHcJDLGJBd2Qbw1qP0YqhL/zcGgz2wDqoBl31Td00pddxOXmQajne2AkkTPeuKP2eLe55+kVtRNQl2VuOeisw0Nrudmi6VmmB2atqVqeL616Wm8IbFXqeunBZdIh5iFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OF7fE8Qo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718938877; x=1750474877;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Nv0Rvw/INyCA4dZuB/Y+A7IFhJs/3yVzXGpJ5qG0rgA=;
  b=OF7fE8QomUgEQ3TRYgj7ITDVmXMkpN/bUq3iPPAXr3zpaCxwtN9zx1xh
   8CZT+jqkfk0NLVOI1yL/wjJnVVSzWLFdPTnJrg8UflzVa4ZgLYGQJoFXJ
   6fRrA4Hck4tqhWCUoxP7LAaqQup3oIStDl/4QkgIBUhFrh8c4YXXa47Ku
   sRvaWwmBnyF/jgpcZrpCO07ej0+Vwt35BjtvEOMQSoCWZ/35B1ysomTMS
   ppK6UHQ1Ch51irdEw7pfHJDurq+3g5FTzMtVY/f9avgvwSoqVQkf7ovdb
   LwlWs82EvoQTsDEey8k0v4dwuIZrEEChknvFPZuQfE70zq6D/2QM0NjPF
   A==;
X-CSE-ConnectionGUID: ViMPCFWFSRigSO9KDVwKcw==
X-CSE-MsgGUID: xtqpMBfGTgap5HLn4TFsFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="27094556"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="27094556"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 20:01:16 -0700
X-CSE-ConnectionGUID: okM1n49nRt+ku8LTypWbJA==
X-CSE-MsgGUID: fpR7RwQZTNCFa1uTk0RZNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="46905713"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 20:01:14 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Kalesh Singh
 <kaleshsingh@google.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v3 1/2] mm: swap: swap cluster switch to double link list
In-Reply-To: <20240619-swap-allocator-v3-1-e973a3102444@kernel.org> (Chris
	Li's message of "Wed, 19 Jun 2024 02:20:29 -0700")
References: <20240619-swap-allocator-v3-0-e973a3102444@kernel.org>
	<20240619-swap-allocator-v3-1-e973a3102444@kernel.org>
Date: Fri, 21 Jun 2024 10:59:23 +0800
Message-ID: <87o77v0zn8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Chris Li <chrisl@kernel.org> writes:

> Previously, the swap cluster used a cluster index as a pointer
> to construct a custom single link list type "swap_cluster_list".
> The next cluster pointer is shared with the cluster->count.
> It prevents puting the non free cluster into a list.
>
> Change the cluster to use the standard double link list instead.
> This allows tracing the nonfull cluster in the follow up patch.
> That way, it is faster to get to the nonfull cluster of that order.
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
>
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
>  include/linux/swap.h |  26 +++---
>  mm/swapfile.c        | 227 ++++++++++++++-------------------------------------
>  2 files changed, 70 insertions(+), 183 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 3df75d62a835..690a04f06674 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -243,22 +243,21 @@ enum {
>   * free clusters are organized into a list. We fetch an entry from the list to
>   * get a free cluster.
>   *
> - * The data field stores next cluster if the cluster is free or cluster usage
> - * counter otherwise. The flags field determines if a cluster is free. This is
> - * protected by swap_info_struct.lock.
> + * The flags field determines if a cluster is free. This is
> + * protected by cluster lock.
>   */
>  struct swap_cluster_info {
>  	spinlock_t lock;	/*
>  				 * Protect swap_cluster_info fields
> -				 * and swap_info_struct->swap_map
> -				 * elements correspond to the swap
> -				 * cluster
> +				 * other than list, and swap_info_struct->swap_map
> +				 * elements correspond to the swap cluster.
>  				 */
> -	unsigned int data:24;
> -	unsigned int flags:8;
> +	u16 count;
> +	u8 flags;
> +	struct list_head list;
>  };
>  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> -#define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster */
> +
>  
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
> index 9c6d8e557c0f..0b11c437f9cc 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -290,64 +290,11 @@ static void discard_swap_cluster(struct swap_info_struct *si,
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
>  	return info->flags & CLUSTER_FLAG_FREE;
>  }
>  
> -static inline bool cluster_is_null(struct swap_cluster_info *info)
> -{
> -	return info->flags & CLUSTER_FLAG_NEXT_NULL;
> -}
> -
> -static inline void cluster_set_null(struct swap_cluster_info *info)
> -{
> -	info->flags = CLUSTER_FLAG_NEXT_NULL;
> -	info->data = 0;
> -}
> -
>  static inline struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
>  						     unsigned long offset)
>  {
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

IIRC, we have reached consensus that we will add a helper for this
pattern.

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
> +	ci->flags = CLUSTER_FLAG_FREE;
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

If you really don't like lock_cluster(), please replace unlock_cluster()
below with spin_unlock() too.

> +		__free_cluster(si, ci);
>  		memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>  				0, SWAPFILE_CLUSTER);
>  		unlock_cluster(ci);
> @@ -521,20 +412,20 @@ static void swap_users_ref_free(struct percpu_ref *ref)
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
> +	ci->flags = 0;
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
> @@ -542,11 +433,11 @@ static void free_cluster(struct swap_info_struct *si, unsigned long idx)
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
> @@ -559,15 +450,15 @@ static void add_cluster_info_page(struct swap_info_struct *p,
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
> @@ -581,24 +472,20 @@ static void inc_cluster_info_page(struct swap_info_struct *p,
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
> @@ -611,10 +498,10 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>  {
>  	struct percpu_cluster *percpu_cluster;
>  	bool conflict;
> -
> +	struct swap_cluster_info *first = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
>  	offset /= SWAPFILE_CLUSTER;
> -	conflict = !cluster_list_empty(&si->free_clusters) &&
> -		offset != cluster_list_first(&si->free_clusters) &&
> +	conflict = !list_empty(&si->free_clusters) &&
> +		offset !=  first - si->cluster_info &&
>  		cluster_is_free(&si->cluster_info[offset]);
>  
>  	if (!conflict)
> @@ -655,10 +542,14 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
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

IIRC, we shouldn't delete the cluster from the free list here, because
we will delete it later in alloc_cluster().

> +			spin_lock(&ci->lock);
> +			ci->flags = 0;

And also shouldn't set ci->flags here too.  Because the cluster may be
kept in free list if scan_swap_map_ssd_cluster_conflict() returns true.

> +			spin_unlock(&ci->lock);
> +			tmp = (ci - si->cluster_info) * SWAPFILE_CLUSTER;
> +		} else if (!list_empty(&si->discard_clusters)) {
>  			/*
>  			 * we don't have free cluster but have some clusters in
>  			 * discarding, do discard now and reclaim them, then

[snip]

--
Best Regards,
Huang, Ying

