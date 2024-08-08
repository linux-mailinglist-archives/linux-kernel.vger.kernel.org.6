Return-Path: <linux-kernel+bounces-278767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D06F794B483
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F46D282B40
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B80F4C97;
	Thu,  8 Aug 2024 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJlYO9cx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB4E4A21
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723079666; cv=none; b=DorRy2AUhPL3MplSRlI0pDax7yxY6o2l8vMqdXA3IeS5dWHwYWvLudk+sqJkJMpZDzMPF/0i84D8QBT75TdP39JAbweV0ZX/xd50ZVYYGZLSofmw3tiLdS4dgGI3LzFLbHU1oYFto0wz8gyfMnAYLVMV67a3aaIOVJHF4Pu0ceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723079666; c=relaxed/simple;
	bh=KVRXnwhDzlJ1x4EWzHkrk++oaj81s9b2aa5MsQ2UqdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ufizgMY+xCDkOYhx5Vsw8AQjLQSQz76zJJWfxDC5I9wEIFRc6AwsqvRvuqye4cXzxVUoiQT0oC1zWV6jbSJdkkZLqQp5j+wWNvhygLGCgy54GZlEbjez2li98sKCTwySS9CqOaLc5dnXGVApLGx1uD+IDuBr+EfxlaAyW+gE9IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJlYO9cx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723079661; x=1754615661;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=KVRXnwhDzlJ1x4EWzHkrk++oaj81s9b2aa5MsQ2UqdQ=;
  b=BJlYO9cxS2VmdePPvAHTc4XygQB8ELI0FQcYQOR4p+uhPObajWU2enf4
   Zh78BC3imcLx1WilJXzCgP/ivB4hKpNXhhRb63yANvJIE3cV6WlakbSWL
   zrMZ6q4jz/crcOMPT7N1LtqYmGj0pJ4cFIUncFvFQzvZlBh3o7gV1sLit
   wAWZ3yH2wJ7vmhR6qYQ8+jx8B2yXgEEbJZzmrRoWovltT2fv0Mp+ylbCB
   ifu810SfFqgfg8SWfVD6rKO0hHjL1eixmWECosjEGSU13ryKn4mLXZQo0
   2B/B17va+7uo1yHBjHFBP2pilu4FRjX/CmYN3y5AVC4tl3G2oDatgty+Y
   A==;
X-CSE-ConnectionGUID: T7y6+bXmS7WZLY8EliQzzg==
X-CSE-MsgGUID: U+9VKY3HSG63Ht9L38XuPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="31854516"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="31854516"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 18:14:20 -0700
X-CSE-ConnectionGUID: HoETQTuoRv+d9lx/Rc9P7A==
X-CSE-MsgGUID: 2Fcr6raiQ+e3DkdhFfJDYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="57748887"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 18:14:17 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Hugh Dickins <hughd@google.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Kalesh Singh <kaleshsingh@google.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH v5 2/9] mm: swap: mTHP allocate swap entries from
 nonfull list
In-Reply-To: <20240730-swap-allocator-v5-2-cb9c148b9297@kernel.org> (Chris
	Li's message of "Tue, 30 Jul 2024 23:49:14 -0700")
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
	<20240730-swap-allocator-v5-2-cb9c148b9297@kernel.org>
Date: Thu, 08 Aug 2024 09:10:44 +0800
Message-ID: <87bk23250r.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> Track the nonfull cluster as well as the empty cluster
> on lists. Each order has one nonfull cluster list.
>
> The cluster will remember which order it was used during
> new cluster allocation.
>
> When the cluster has free entry, add to the nonfull[order]
> list. =C2=A0When the free cluster list is empty, also allocate
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
>  mm/swapfile.c        | 38 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index edafd52d7ac4..6716ef236766 100644
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
>=20=20
>  /*
>   * The first page in the swap file is the swap header, which is always m=
arked
> @@ -295,6 +297,8 @@ struct swap_info_struct {
>  	unsigned long *zeromap;		/* vmalloc'ed bitmap to track zero pages */
>  	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
>  	struct list_head free_clusters; /* free clusters list */
> +	struct list_head nonfull_clusters[SWAP_NR_ORDERS];
> +					/* list of cluster that contains at least one free slot */
>  	unsigned int lowest_bit;	/* index of first free in swap_map */
>  	unsigned int highest_bit;	/* index of last free in swap_map */
>  	unsigned int pages;		/* total of usable pages of swap */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index bceead7f9e3c..dcf09eb549db 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -361,14 +361,22 @@ static void swap_cluster_schedule_discard(struct sw=
ap_info_struct *si,
>  	memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>  			SWAP_MAP_BAD, SWAPFILE_CLUSTER);
>=20=20
> -	list_add_tail(&ci->list, &si->discard_clusters);
> +	VM_BUG_ON(ci->flags & CLUSTER_FLAG_FREE);
> +	if (ci->flags & CLUSTER_FLAG_NONFULL)
> +		list_move_tail(&ci->list, &si->discard_clusters);
> +	else
> +		list_add_tail(&ci->list, &si->discard_clusters);
> +	ci->flags =3D 0;

As Ryan pointed out before, it's better to clear the specific bit
instead of assigning 0.  This will make code future proof.

>  	schedule_work(&si->discard_work);
>  }
>=20=20
>  static void __free_cluster(struct swap_info_struct *si, struct swap_clus=
ter_info *ci)
>  {
> +	if (ci->flags & CLUSTER_FLAG_NONFULL)
> +		list_move_tail(&ci->list, &si->free_clusters);
> +	else
> +		list_add_tail(&ci->list, &si->free_clusters);
>  	ci->flags =3D CLUSTER_FLAG_FREE;
> -	list_add_tail(&ci->list, &si->free_clusters);
>  }
>=20=20
>  /*
> @@ -491,8 +499,15 @@ static void dec_cluster_info_page(struct swap_info_s=
truct *p, struct swap_cluste
>  	VM_BUG_ON(ci->count =3D=3D 0);
>  	ci->count--;
>=20=20
> -	if (!ci->count)
> +	if (!ci->count) {
>  		free_cluster(p, ci);
> +		return;
> +	}
> +
> +	if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
> +		list_add_tail(&ci->list, &p->nonfull_clusters[ci->order]);
> +		ci->flags |=3D CLUSTER_FLAG_NONFULL;
> +	}
>  }
>=20=20
>  /*
> @@ -553,6 +568,19 @@ static bool scan_swap_map_try_ssd_cluster(struct swa=
p_info_struct *si,
>  	if (tmp =3D=3D SWAP_NEXT_INVALID) {
>  		if (!list_empty(&si->free_clusters)) {
>  			ci =3D list_first_entry(&si->free_clusters, struct swap_cluster_info,=
 list);
> +			list_del(&ci->list);
> +			spin_lock(&ci->lock);
> +			ci->order =3D order;
> +			ci->flags =3D 0;
> +			spin_unlock(&ci->lock);
> +			tmp =3D cluster_index(si, ci) * SWAPFILE_CLUSTER;
> +		} else if (!list_empty(&si->nonfull_clusters[order])) {
> +			ci =3D list_first_entry(&si->nonfull_clusters[order],
> +					      struct swap_cluster_info, list);
> +			list_del(&ci->list);
> +			spin_lock(&ci->lock);
> +			ci->flags =3D 0;
> +			spin_unlock(&ci->lock);
>  			tmp =3D cluster_index(si, ci) * SWAPFILE_CLUSTER;
>  		} else if (!list_empty(&si->discard_clusters)) {

We should check discard_clusters before nonfull clusters.

>  			/*
> @@ -967,6 +995,7 @@ static void swap_free_cluster(struct swap_info_struct=
 *si, unsigned long idx)
>  	ci =3D lock_cluster(si, offset);
>  	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
>  	ci->count =3D 0;
> +	ci->order =3D 0;
>  	ci->flags =3D 0;
>  	free_cluster(si, ci);
>  	unlock_cluster(ci);
> @@ -2922,6 +2951,9 @@ static int setup_swap_map_and_extents(struct swap_i=
nfo_struct *p,
>  	INIT_LIST_HEAD(&p->free_clusters);
>  	INIT_LIST_HEAD(&p->discard_clusters);
>=20=20
> +	for (i =3D 0; i < SWAP_NR_ORDERS; i++)
> +		INIT_LIST_HEAD(&p->nonfull_clusters[i]);
> +
>  	for (i =3D 0; i < swap_header->info.nr_badpages; i++) {
>  		unsigned int page_nr =3D swap_header->info.badpages[i];
>  		if (page_nr =3D=3D 0 || page_nr > swap_header->info.last_page)

--
Best Regards,
Huang, Ying

