Return-Path: <linux-kernel+bounces-193795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867028D3243
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BB11C23530
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D134817839F;
	Wed, 29 May 2024 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDwxm+ri"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383DB168C3D
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972516; cv=none; b=iaYMCZqBxwZExGrjTcEhzYaES/Xj1SUV1LXLI8rV5dgsHCAbMdifQUSIKd/Eukri2UJ69IdfiglRzzewLYHZGak8VmG7+i4mRdXHprbOReO+hqTSTwrLR2M8QdeT2S2E0uqlxVOfxohc/QpThdG5rcBU5X9yl16mG9fQdqPVr9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972516; c=relaxed/simple;
	bh=PrRYvHxncK6/QaZIkMASNTHoJUYnaW+KRUFSC2LogsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FQ6eIJH4N+AE+R33MFKHg2FSG5FRzXgOI7+DXn4EsbIw260dre4D+7FkpN8T0lkLX1CqwJ8jVTsCc+xQgJxLSRARkMuED4aN9tHY4tVAo+tUYp2xKjr9tkfn2DOB8sKP1ktu1RicgTOx3RBqzQUv3TiDl6jAtcAcp4Ct95Ww7uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDwxm+ri; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716972515; x=1748508515;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=PrRYvHxncK6/QaZIkMASNTHoJUYnaW+KRUFSC2LogsU=;
  b=nDwxm+ripuZwQ1jOZKvF6CXUE3AcTi8gXqEOnlsQPyQZbGPLS3T0EpUv
   0iZod5a+nKHPSp+MjOGv0yjZtjMgGcfVjA58YyG2N3kb9KyAC5kCrmQLR
   hQSkKkZzzhbPbGyzNlWk4apU/OXcBK3Wr1nmQPr3iCRfQIh0LU9EE5TW/
   ARkwilJp+Kcf042nHy49GenKJqwqqMei+L9cACTwPzNyWyPlSEyTJUpEc
   mcr76waCHCBa+bpTD7GRnFuFzsNy906NmupBt61tDhkDHi+qnhQYMfGzs
   +bXPzjNKneb/RVnmg05HuuWf4HeDU++CMvzUoQbAGXV7ocN4MeWLHTvLW
   A==;
X-CSE-ConnectionGUID: MY97i+DmR/eS/uXKjKFYeQ==
X-CSE-MsgGUID: 4Ixq8cJzSlOE4M9ZRiuqVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17195335"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="17195335"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 01:48:34 -0700
X-CSE-ConnectionGUID: zmbtDpRkThqVcG2nmrrw8Q==
X-CSE-MsgGUID: N3RucX5rRXS0vT5TaJTOrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="39797436"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 01:48:31 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH 1/2] mm: swap: swap cluster switch to double link list
In-Reply-To: <20240524-swap-allocator-v1-1-47861b423b26@kernel.org> (Chris
	Li's message of "Fri, 24 May 2024 10:17:18 -0700")
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
	<20240524-swap-allocator-v1-1-47861b423b26@kernel.org>
Date: Wed, 29 May 2024 16:46:39 +0800
Message-ID: <87h6eh57kg.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chris Li <chrisl@kernel.org> writes:

> Previously, the swap cluster used a cluster index as a pointer
> to construct a custom single link list type "swap_cluster_list".
> The next cluster pointer is shared with the cluster->count.
> The assumption is that only the free cluster needs to be put
> on the list.
>
> That assumption is not true for mTHP allocators any more.

I think that the words aren't correct here.  mTHP swap entry allocators
can work with current cluster definition.

> Need to track the non full cluster on the list as well. =C2=A0Move the
> current cluster single link list into standard double link list.

It's an optimization to track non-full cluster with a list.

I understand that you want to change cluster list definition.  I just
feel the wording isn't accurate.

> Remove the cluster getter/setter for accessing the cluster
> struct member. =C2=A0Move the cluster locking in the caller function
> rather than the getter/setter function. That way the locking can
> protect more than one member, e.g. cluster->flag.

Sorry, I don't understand the locking in above words.  I don't find that
we lock/unlock in the original getter/setter functions.  I found that
the cluster locking rule for cluster list is changed.  Better to make
this explicit.

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
> on the average memory usage per swap entry. =C2=A0Other than the list
> conversion, there is no real function change in this patch.

On 64bit platform, the size of swap_cluster_info increases from 8 bytes
to 24 bytes.  For a 1TB swap device, the memory usage will increase from
4MB to 12MB.  This looks OK for me.

Another choice is to use a customized double linked list using "unsigned
int" as pointer to cluster.  That will reduce the size of cluster to 16
bytes.  But it may be not necessary to do that.

Anyway, I think that it's better to add more calculation in changelog
for memory usage increment.

> ---
>  include/linux/swap.h |  14 ++--
>  mm/swapfile.c        | 231 ++++++++++++++-------------------------------=
------
>  2 files changed, 68 insertions(+), 177 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 11c53692f65f..0d3906eff3c9 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -254,11 +254,12 @@ struct swap_cluster_info {
>  				 * elements correspond to the swap
>  				 * cluster
>  				 */
> -	unsigned int data:24;
> +	unsigned int count:16;
>  	unsigned int flags:8;

If we use 16bits and 8 bits in bit fields, why not just use u8 and u16
instead?

> +	struct list_head next;

"next" isn't a good naming because prev pointer is in list_head too.
The common naming is "list".

Need to revise comments for swap_cluster_info.lock and add the locking
rule comments for swap_cluster_info.next.

>  };
>  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> -#define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster */
> +
>=20=20
>  /*
>   * The first page in the swap file is the swap header, which is always m=
arked
> @@ -283,11 +284,6 @@ struct percpu_cluster {
>  	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
>  };
>=20=20
> -struct swap_cluster_list {
> -	struct swap_cluster_info head;
> -	struct swap_cluster_info tail;
> -};
> -
>  /*
>   * The in-memory structure used to track swap areas.
>   */
> @@ -300,7 +296,7 @@ struct swap_info_struct {
>  	unsigned int	max;		/* extent of the swap_map */
>  	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
>  	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
> -	struct swap_cluster_list free_clusters; /* free clusters list */
> +	struct list_head free_clusters; /* free clusters list */
>  	unsigned int lowest_bit;	/* index of first free in swap_map */
>  	unsigned int highest_bit;	/* index of last free in swap_map */
>  	unsigned int pages;		/* total of usable pages of swap */
> @@ -333,7 +329,7 @@ struct swap_info_struct {
>  					 * list.
>  					 */
>  	struct work_struct discard_work; /* discard worker */
> -	struct swap_cluster_list discard_clusters; /* discard clusters list */
> +	struct list_head discard_clusters; /* discard clusters list */
>  	struct plist_node avail_lists[]; /*
>  					   * entries in swap_avail_heads, one
>  					   * entry per node.
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4f0e8b2ac8aa..205a60c5f9cb 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -290,64 +290,11 @@ static void discard_swap_cluster(struct swap_info_s=
truct *si,
>  #endif
>  #define LATENCY_LIMIT		256
>=20=20
> -static inline void cluster_set_flag(struct swap_cluster_info *info,
> -	unsigned int flag)
> -{
> -	info->flags =3D flag;
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
> -	info->data =3D c;
> -}
> -
> -static inline void cluster_set_count_flag(struct swap_cluster_info *info,
> -					 unsigned int c, unsigned int f)
> -{
> -	info->flags =3D f;
> -	info->data =3D c;
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
> -	info->data =3D n;
> -}
> -
> -static inline void cluster_set_next_flag(struct swap_cluster_info *info,
> -					 unsigned int n, unsigned int f)
> -{
> -	info->flags =3D f;
> -	info->data =3D n;
> -}
> -
>  static inline bool cluster_is_free(struct swap_cluster_info *info)
>  {
>  	return info->flags & CLUSTER_FLAG_FREE;
>  }
>=20=20
> -static inline bool cluster_is_null(struct swap_cluster_info *info)
> -{
> -	return info->flags & CLUSTER_FLAG_NEXT_NULL;
> -}
> -
> -static inline void cluster_set_null(struct swap_cluster_info *info)
> -{
> -	info->flags =3D CLUSTER_FLAG_NEXT_NULL;
> -	info->data =3D 0;
> -}
> -
>  static inline struct swap_cluster_info *lock_cluster(struct swap_info_st=
ruct *si,
>  						     unsigned long offset)
>  {
> @@ -394,65 +341,11 @@ static inline void unlock_cluster_or_swap_info(stru=
ct swap_info_struct *si,
>  		spin_unlock(&si->lock);
>  }
>=20=20
> -static inline bool cluster_list_empty(struct swap_cluster_list *list)
> -{
> -	return cluster_is_null(&list->head);
> -}
> -
> -static inline unsigned int cluster_list_first(struct swap_cluster_list *=
list)
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
> -		unsigned int tail =3D cluster_next(&list->tail);
> -
> -		/*
> -		 * Nested cluster lock, but both cluster locks are
> -		 * only acquired when we held swap_info_struct->lock
> -		 */
> -		ci_tail =3D ci + tail;
> -		spin_lock_nested(&ci_tail->lock, SINGLE_DEPTH_NESTING);
> -		cluster_set_next(ci_tail, idx);
> -		spin_unlock(&ci_tail->lock);
> -		cluster_set_next_flag(&list->tail, idx, 0);
> -	}
> -}
> -
> -static unsigned int cluster_list_del_first(struct swap_cluster_list *lis=
t,
> -					   struct swap_cluster_info *ci)
> -{
> -	unsigned int idx;
> -
> -	idx =3D cluster_next(&list->head);
> -	if (cluster_next(&list->tail) =3D=3D idx) {
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
> +	unsigned int idx =3D ci - si->cluster_info;
>  	/*
>  	 * If scan_swap_map_slots() can't find a free cluster, it will check
>  	 * si->swap_map directly. To make sure the discarding cluster isn't
> @@ -462,17 +355,16 @@ static void swap_cluster_schedule_discard(struct sw=
ap_info_struct *si,
>  	memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>  			SWAP_MAP_BAD, SWAPFILE_CLUSTER);
>=20=20
> -	cluster_list_add_tail(&si->discard_clusters, si->cluster_info, idx);
> -
> +	spin_lock_nested(&ci->lock, SINGLE_DEPTH_NESTING);

If we don't use ci->lock to protect ci->next, we don't need spin_lock here.

> +	list_add_tail(&ci->next, &si->discard_clusters);
> +	spin_unlock(&ci->lock);
>  	schedule_work(&si->discard_work);
>  }
>=20=20
> -static void __free_cluster(struct swap_info_struct *si, unsigned long id=
x)
> +static void __free_cluster(struct swap_info_struct *si, struct swap_clus=
ter_info *ci)
>  {
> -	struct swap_cluster_info *ci =3D si->cluster_info;
> -
> -	cluster_set_flag(ci + idx, CLUSTER_FLAG_FREE);
> -	cluster_list_add_tail(&si->free_clusters, ci, idx);
> +	ci->flags =3D CLUSTER_FLAG_FREE;
> +	list_add_tail(&ci->next, &si->free_clusters);
>  }
>=20=20
>  /*
> @@ -481,21 +373,21 @@ static void __free_cluster(struct swap_info_struct =
*si, unsigned long idx)
>  */
>  static void swap_do_scheduled_discard(struct swap_info_struct *si)
>  {
> -	struct swap_cluster_info *info, *ci;
> +	struct swap_cluster_info *ci;
>  	unsigned int idx;
>=20=20
> -	info =3D si->cluster_info;
> -
> -	while (!cluster_list_empty(&si->discard_clusters)) {
> -		idx =3D cluster_list_del_first(&si->discard_clusters, info);
> +	while (!list_empty(&si->discard_clusters)) {
> +		ci =3D list_first_entry(&si->discard_clusters, struct swap_cluster_inf=
o, next);
> +		idx =3D ci - si->cluster_info;
>  		spin_unlock(&si->lock);
>=20=20
>  		discard_swap_cluster(si, idx * SWAPFILE_CLUSTER,
>  				SWAPFILE_CLUSTER);
>=20=20
>  		spin_lock(&si->lock);
> -		ci =3D lock_cluster(si, idx * SWAPFILE_CLUSTER);
> -		__free_cluster(si, idx);
> +
> +		spin_lock(&ci->lock);
> +		__free_cluster(si, ci);
>  		memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>  				0, SWAPFILE_CLUSTER);
>  		unlock_cluster(ci);
> @@ -521,20 +413,20 @@ static void swap_users_ref_free(struct percpu_ref *=
ref)
>  	complete(&si->comp);
>  }
>=20=20
> -static void alloc_cluster(struct swap_info_struct *si, unsigned long idx)
> +static struct swap_cluster_info *alloc_cluster(struct swap_info_struct *=
si, unsigned long idx)
>  {
> -	struct swap_cluster_info *ci =3D si->cluster_info;
> +	struct swap_cluster_info *ci =3D list_first_entry(&si->free_clusters, s=
truct swap_cluster_info, next);
>=20=20
> -	VM_BUG_ON(cluster_list_first(&si->free_clusters) !=3D idx);
> -	cluster_list_del_first(&si->free_clusters, ci);
> -	cluster_set_count_flag(ci + idx, 0, 0);
> +	VM_BUG_ON(ci - si->cluster_info !=3D idx);
> +	list_del(&ci->next);
> +	ci->count =3D 0;
> +	ci->flags =3D 0;
> +	return ci;
>  }
>=20=20
> -static void free_cluster(struct swap_info_struct *si, unsigned long idx)
> +static void free_cluster(struct swap_info_struct *si, struct swap_cluste=
r_info *ci)
>  {
> -	struct swap_cluster_info *ci =3D si->cluster_info + idx;
> -
> -	VM_BUG_ON(cluster_count(ci) !=3D 0);
> +	VM_BUG_ON(ci->count !=3D 0);
>  	/*
>  	 * If the swap is discardable, prepare discard the cluster
>  	 * instead of free it immediately. The cluster will be freed
> @@ -542,11 +434,11 @@ static void free_cluster(struct swap_info_struct *s=
i, unsigned long idx)
>  	 */
>  	if ((si->flags & (SWP_WRITEOK | SWP_PAGE_DISCARD)) =3D=3D
>  	    (SWP_WRITEOK | SWP_PAGE_DISCARD)) {
> -		swap_cluster_schedule_discard(si, idx);
> +		swap_cluster_schedule_discard(si, ci);
>  		return;
>  	}
>=20=20
> -	__free_cluster(si, idx);
> +	__free_cluster(si, ci);
>  }
>=20=20
>  /*
> @@ -559,15 +451,15 @@ static void add_cluster_info_page(struct swap_info_=
struct *p,
>  	unsigned long count)
>  {
>  	unsigned long idx =3D page_nr / SWAPFILE_CLUSTER;
> +	struct swap_cluster_info *ci =3D cluster_info + idx;
>=20=20
>  	if (!cluster_info)
>  		return;
> -	if (cluster_is_free(&cluster_info[idx]))
> +	if (cluster_is_free(ci))
>  		alloc_cluster(p, idx);
>=20=20
> -	VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE_CLUSTER);
> -	cluster_set_count(&cluster_info[idx],
> -		cluster_count(&cluster_info[idx]) + count);
> +	VM_BUG_ON(ci->count + count > SWAPFILE_CLUSTER);
> +	ci->count +=3D count;
>  }
>=20=20
>  /*
> @@ -581,24 +473,20 @@ static void inc_cluster_info_page(struct swap_info_=
struct *p,
>  }
>=20=20
>  /*
> - * The cluster corresponding to page_nr decreases one usage. If the usage
> - * counter becomes 0, which means no page in the cluster is in using, we=
 can
> - * optionally discard the cluster and add it to free cluster list.
> + * The cluster ci decreases one usage. If the usage counter becomes 0,
> + * which means no page in the cluster is in using, we can optionally dis=
card
> + * the cluster and add it to free cluster list.
>   */
> -static void dec_cluster_info_page(struct swap_info_struct *p,
> -	struct swap_cluster_info *cluster_info, unsigned long page_nr)
> +static void dec_cluster_info_page(struct swap_info_struct *p, struct swa=
p_cluster_info *ci)
>  {
> -	unsigned long idx =3D page_nr / SWAPFILE_CLUSTER;
> -
> -	if (!cluster_info)
> +	if (!p->cluster_info)
>  		return;
>=20=20
> -	VM_BUG_ON(cluster_count(&cluster_info[idx]) =3D=3D 0);
> -	cluster_set_count(&cluster_info[idx],
> -		cluster_count(&cluster_info[idx]) - 1);
> +	VM_BUG_ON(ci->count =3D=3D 0);
> +	ci->count--;
>=20=20
> -	if (cluster_count(&cluster_info[idx]) =3D=3D 0)
> -		free_cluster(p, idx);
> +	if (!ci->count)
> +		free_cluster(p, ci);
>  }
>=20=20
>  /*
> @@ -611,10 +499,10 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info=
_struct *si,
>  {
>  	struct percpu_cluster *percpu_cluster;
>  	bool conflict;
> -
> +	struct swap_cluster_info *first =3D list_first_entry(&si->free_clusters=
, struct swap_cluster_info, next);
>  	offset /=3D SWAPFILE_CLUSTER;
> -	conflict =3D !cluster_list_empty(&si->free_clusters) &&
> -		offset !=3D cluster_list_first(&si->free_clusters) &&
> +	conflict =3D !list_empty(&si->free_clusters) &&
> +		offset !=3D  first - si->cluster_info &&
>  		cluster_is_free(&si->cluster_info[offset]);
>=20=20
>  	if (!conflict)
> @@ -655,10 +543,14 @@ static bool scan_swap_map_try_ssd_cluster(struct sw=
ap_info_struct *si,
>  	cluster =3D this_cpu_ptr(si->percpu_cluster);
>  	tmp =3D cluster->next[order];
>  	if (tmp =3D=3D SWAP_NEXT_INVALID) {
> -		if (!cluster_list_empty(&si->free_clusters)) {
> -			tmp =3D cluster_next(&si->free_clusters.head) *
> -					SWAPFILE_CLUSTER;
> -		} else if (!cluster_list_empty(&si->discard_clusters)) {
> +		if (!list_empty(&si->free_clusters)) {
> +			ci =3D list_first_entry(&si->free_clusters, struct swap_cluster_info,=
 next);
> +			list_del(&ci->next);
> +			spin_lock(&ci->lock);
> +			ci->flags =3D 0;
> +			spin_unlock(&ci->lock);
> +			tmp =3D (ci - si->cluster_info) * SWAPFILE_CLUSTER;
> +		} else if (!list_empty(&si->discard_clusters)) {
>  			/*
>  			 * we don't have free cluster but have some clusters in
>  			 * discarding, do discard now and reclaim them, then
> @@ -670,7 +562,8 @@ static bool scan_swap_map_try_ssd_cluster(struct swap=
_info_struct *si,
>  			goto new_cluster;
>  		} else
>  			return false;
> -	}
> +	} else
> +		ci =3D si->cluster_info + tmp;
>=20=20
>  	/*
>  	 * Other CPUs can use our cluster if they can't find a free cluster,
> @@ -1062,8 +955,9 @@ static void swap_free_cluster(struct swap_info_struc=
t *si, unsigned long idx)
>=20=20
>  	ci =3D lock_cluster(si, offset);
>  	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> -	cluster_set_count_flag(ci, 0, 0);
> -	free_cluster(si, idx);
> +	ci->count =3D 0;
> +	ci->flags =3D 0;
> +	free_cluster(si, ci);
>  	unlock_cluster(ci);
>  	swap_range_free(si, offset, SWAPFILE_CLUSTER);
>  }
> @@ -1336,7 +1230,7 @@ static void swap_entry_free(struct swap_info_struct=
 *p, swp_entry_t entry)
>  	count =3D p->swap_map[offset];
>  	VM_BUG_ON(count !=3D SWAP_HAS_CACHE);
>  	p->swap_map[offset] =3D 0;
> -	dec_cluster_info_page(p, p->cluster_info, offset);
> +	dec_cluster_info_page(p, ci);
>  	unlock_cluster(ci);
>=20=20
>  	mem_cgroup_uncharge_swap(entry, 1);
> @@ -2985,8 +2879,8 @@ static int setup_swap_map_and_extents(struct swap_i=
nfo_struct *p,
>=20=20
>  	nr_good_pages =3D maxpages - 1;	/* omit header page */
>=20=20
> -	cluster_list_init(&p->free_clusters);
> -	cluster_list_init(&p->discard_clusters);
> +	INIT_LIST_HEAD(&p->free_clusters);
> +	INIT_LIST_HEAD(&p->discard_clusters);
>=20=20
>  	for (i =3D 0; i < swap_header->info.nr_badpages; i++) {
>  		unsigned int page_nr =3D swap_header->info.badpages[i];
> @@ -3037,14 +2931,15 @@ static int setup_swap_map_and_extents(struct swap=
_info_struct *p,
>  	for (k =3D 0; k < SWAP_CLUSTER_COLS; k++) {
>  		j =3D (k + col) % SWAP_CLUSTER_COLS;
>  		for (i =3D 0; i < DIV_ROUND_UP(nr_clusters, SWAP_CLUSTER_COLS); i++) {
> +			struct swap_cluster_info *ci;
>  			idx =3D i * SWAP_CLUSTER_COLS + j;
> +			ci =3D cluster_info + idx;
>  			if (idx >=3D nr_clusters)
>  				continue;
> -			if (cluster_count(&cluster_info[idx]))
> +			if (ci->count)
>  				continue;
> -			cluster_set_flag(&cluster_info[idx], CLUSTER_FLAG_FREE);
> -			cluster_list_add_tail(&p->free_clusters, cluster_info,
> -					      idx);
> +			ci->flags =3D CLUSTER_FLAG_FREE;
> +			list_add_tail(&ci->next, &p->free_clusters);
>  		}
>  	}
>  	return nr_extents;

--
Best Regards,
Huang, Ying

