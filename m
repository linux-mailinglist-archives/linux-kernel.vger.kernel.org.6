Return-Path: <linux-kernel+bounces-175499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0F88C2076
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BA91C21B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A175F161935;
	Fri, 10 May 2024 09:11:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814DE161B53
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332312; cv=none; b=ZZOfRrcOPimQyclMivq+2e2nFKu0JbGxEmVlxkBx2T3ZDhlTaqbz0gXNhLmnshb4ktxwR0hOjNRC2eqqSm5unaMon8xi41RexVX8XTKtQKPzoP5HJFebqI3c6Rs/OvJW4XUB4r4KNOA9hKWXBEQyfaZiCTrjd7Y0hSTDMa/EzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332312; c=relaxed/simple;
	bh=COs3X9Gm3kLwixpGoYn/exS3jJs+Unca6Md1IRsfVrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyQyKWMA3vmtov2YwuDpqhAmXwPnjhmYsm/Xkr86aFsksYYw4Ydy64LS3ISA7k1WSj9EwvhmhFUUpiZdQrN8sF1udAEWrvOAcEJG97PIXrlb1AfQ43CakT64kdiVzd68xGDHO2laXkX8oMG90GuvnC9tMCaZCfLBBh9yFAqAM+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD316106F;
	Fri, 10 May 2024 02:12:14 -0700 (PDT)
Received: from [10.57.65.1] (unknown [10.57.65.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F5CD3F762;
	Fri, 10 May 2024 02:11:46 -0700 (PDT)
Message-ID: <38caf210-0607-4937-b6d0-13b99f155060@arm.com>
Date: Fri, 10 May 2024 10:11:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] mm: remove the implementation of swap_free() and
 always use swap_free_nr()
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
 ziy@nvidia.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
 Christoph Hellwig <hch@infradead.org>
References: <20240508224040.190469-1-21cnbao@gmail.com>
 <20240508224040.190469-3-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240508224040.190469-3-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/05/2024 23:40, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> To streamline maintenance efforts, we propose removing the implementation
> of swap_free(). Instead, we can simply invoke swap_free_nr() with nr
> set to 1. swap_free_nr() is designed with a bitmap consisting of only
> one long, resulting in overhead that can be ignored for cases where nr
> equals 1.
> 
> A prime candidate for leveraging swap_free_nr() lies within
> kernel/power/swap.c. Implementing this change facilitates the adoption
> of batch processing for hibernation.
> 
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Christoph Hellwig <hch@infradead.org>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/swap.h | 10 +++++-----
>  kernel/power/swap.c  |  5 ++---
>  mm/swapfile.c        | 17 ++++-------------
>  3 files changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index d1d35e92d7e9..48131b869a4d 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -482,7 +482,6 @@ extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>  extern void swap_shmem_alloc(swp_entry_t);
>  extern int swap_duplicate(swp_entry_t);
>  extern int swapcache_prepare(swp_entry_t);
> -extern void swap_free(swp_entry_t);
>  extern void swap_free_nr(swp_entry_t entry, int nr_pages);
>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
>  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> @@ -561,10 +560,6 @@ static inline int swapcache_prepare(swp_entry_t swp)
>  	return 0;
>  }
>  
> -static inline void swap_free(swp_entry_t swp)
> -{
> -}
> -
>  static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
>  {
>  }
> @@ -613,6 +608,11 @@ static inline void free_swap_and_cache(swp_entry_t entry)
>  	free_swap_and_cache_nr(entry, 1);
>  }
>  
> +static inline void swap_free(swp_entry_t entry)
> +{
> +	swap_free_nr(entry, 1);
> +}
> +
>  #ifdef CONFIG_MEMCG
>  static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
>  {
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 5bc04bfe2db1..75bc9e3f9d59 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -200,12 +200,11 @@ void free_all_swap_pages(int swap)
>  
>  	while ((node = swsusp_extents.rb_node)) {
>  		struct swsusp_extent *ext;
> -		unsigned long offset;
>  
>  		ext = rb_entry(node, struct swsusp_extent, node);
>  		rb_erase(node, &swsusp_extents);
> -		for (offset = ext->start; offset <= ext->end; offset++)
> -			swap_free(swp_entry(swap, offset));
> +		swap_free_nr(swp_entry(swap, ext->start),
> +			     ext->end - ext->start + 1);
>  
>  		kfree(ext);
>  	}
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index ec12f2b9d229..99e701620562 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1343,19 +1343,6 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
>  	swap_range_free(p, offset, 1);
>  }
>  
> -/*
> - * Caller has made sure that the swap device corresponding to entry
> - * is still around or has not been recycled.
> - */
> -void swap_free(swp_entry_t entry)
> -{
> -	struct swap_info_struct *p;
> -
> -	p = _swap_info_get(entry);
> -	if (p)
> -		__swap_entry_free(p, entry);
> -}
> -
>  static void cluster_swap_free_nr(struct swap_info_struct *sis,
>  		unsigned long offset, int nr_pages)
>  {
> @@ -1385,6 +1372,10 @@ static void cluster_swap_free_nr(struct swap_info_struct *sis,
>  	unlock_cluster_or_swap_info(sis, ci);
>  }
>  
> +/*
> + * Caller has made sure that the swap device corresponding to entry
> + * is still around or has not been recycled.
> + */
>  void swap_free_nr(swp_entry_t entry, int nr_pages)
>  {
>  	int nr;


