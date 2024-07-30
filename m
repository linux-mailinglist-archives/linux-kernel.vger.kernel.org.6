Return-Path: <linux-kernel+bounces-267007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E3940B28
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5FF1F23FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487D71922F6;
	Tue, 30 Jul 2024 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AEqjYOfr"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F12167D83
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327649; cv=none; b=tsIlsqsYWt+590Pt2eFXv4ObYEPyGib/SGK8JWnyIa98g/Uy6yfz2bs21swsatWzSieYfsGc910wWa0mC9P1QlF72iw4FSR829yCQAFZObHmT3jN5TKtZraNCaadAPZB4aOf9alvo7mvD4przHN5ukAh1DeEAKUSD18dEvGFUJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327649; c=relaxed/simple;
	bh=WW2mY7HiQIsCzAiCRzc87OMPGGCBvuGmTjOrzAW8Aq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V94vGIY4MpmFOXe67ka+ukkLN0gjJhv591ekd2RYpmKM9yXf0n4EuxFYa+74xnOfMXLCYYL0i/QsrL4/F+KQ719UEry5OZY59wi92YztvAt+ECHraTuPChX8yC1GsvVSGsVz/UOzas0yZvWGxOSM49SwE2EZ+9G6B5Y3LvoOFpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AEqjYOfr; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722327638; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=13VFHkQ5EKKSlLcss4J5ZWHUutiLOAeHwk1lZO1Xyp8=;
	b=AEqjYOfrEyg9QajQjZ0WuJoyu7tnlb+N/0MSB8SoM8aTilfLKEEEnAGFh2m22scZuYtKjTH1AMYOt6H3It9v0SA2yyNcQ5gO2WEKk+OynoZXXws0dViKU/4b1vQz4vRg2OKPWAu2VdhsLgnDRDIlgCFfWW86PBd/2pAOlkemx7w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0WBessTl_1722327318;
Received: from 30.97.56.73(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBessTl_1722327318)
          by smtp.aliyun-inc.com;
          Tue, 30 Jul 2024 16:15:19 +0800
Message-ID: <18a6bed3-112b-4107-9aaa-6963b6b0bc08@linux.alibaba.com>
Date: Tue, 30 Jul 2024 16:15:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: swap: add nr argument in swapcache_prepare and
 swapcache_clear to support large folios
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org,
 hughd@google.com, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org,
 nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org,
 shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com
References: <20240730071339.107447-1-21cnbao@gmail.com>
 <20240730071339.107447-2-21cnbao@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240730071339.107447-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/30 15:13, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Right now, swapcache_prepare() and swapcache_clear() supports one entry
> only, to support large folios, we need to handle multiple swap entries.
> 
> To optimize stack usage, we iterate twice in __swap_duplicate(): the
> first time to verify that all entries are valid, and the second time
> to apply the modifications to the entries.
> 
> Currently, we're using nr=1 for the existing users.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Thanks Barry. Tested it with my shmem swap patches, and works well. So
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   include/linux/swap.h |   4 +-
>   mm/memory.c          |   6 +--
>   mm/swap.h            |   5 ++-
>   mm/swap_state.c      |   2 +-
>   mm/swapfile.c        | 101 +++++++++++++++++++++++++------------------
>   5 files changed, 68 insertions(+), 50 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index ba7ea95d1c57..5b920fa2315b 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -480,7 +480,7 @@ extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
>   extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>   extern void swap_shmem_alloc(swp_entry_t);
>   extern int swap_duplicate(swp_entry_t);
> -extern int swapcache_prepare(swp_entry_t);
> +extern int swapcache_prepare(swp_entry_t entry, int nr);
>   extern void swap_free_nr(swp_entry_t entry, int nr_pages);
>   extern void swapcache_free_entries(swp_entry_t *entries, int n);
>   extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> @@ -554,7 +554,7 @@ static inline int swap_duplicate(swp_entry_t swp)
>   	return 0;
>   }
>   
> -static inline int swapcache_prepare(swp_entry_t swp)
> +static inline int swapcache_prepare(swp_entry_t swp, int nr)
>   {
>   	return 0;
>   }
> diff --git a/mm/memory.c b/mm/memory.c
> index 833d2cad6eb2..b8675617a5e3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4081,7 +4081,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   			 * reusing the same entry. It's undetectable as
>   			 * pte_same() returns true due to entry reuse.
>   			 */
> -			if (swapcache_prepare(entry)) {
> +			if (swapcache_prepare(entry, 1)) {
>   				/* Relax a bit to prevent rapid repeated page faults */
>   				schedule_timeout_uninterruptible(1);
>   				goto out;
> @@ -4387,7 +4387,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   out:
>   	/* Clear the swap cache pin for direct swapin after PTL unlock */
>   	if (need_clear_cache)
> -		swapcache_clear(si, entry);
> +		swapcache_clear(si, entry, 1);
>   	if (si)
>   		put_swap_device(si);
>   	return ret;
> @@ -4403,7 +4403,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   		folio_put(swapcache);
>   	}
>   	if (need_clear_cache)
> -		swapcache_clear(si, entry);
> +		swapcache_clear(si, entry, 1);
>   	if (si)
>   		put_swap_device(si);
>   	return ret;
> diff --git a/mm/swap.h b/mm/swap.h
> index baa1fa946b34..7c6330561d84 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -59,7 +59,7 @@ void __delete_from_swap_cache(struct folio *folio,
>   void delete_from_swap_cache(struct folio *folio);
>   void clear_shadow_from_swap_cache(int type, unsigned long begin,
>   				  unsigned long end);
> -void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
> +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr);
>   struct folio *swap_cache_get_folio(swp_entry_t entry,
>   		struct vm_area_struct *vma, unsigned long addr);
>   struct folio *filemap_get_incore_folio(struct address_space *mapping,
> @@ -120,7 +120,7 @@ static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
>   	return 0;
>   }
>   
> -static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
> +static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr)
>   {
>   }
>   
> @@ -172,4 +172,5 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
>   	return 0;
>   }
>   #endif /* CONFIG_SWAP */
> +
>   #endif /* _MM_SWAP_H */
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index a1726e49a5eb..b06f2a054f5a 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -477,7 +477,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>   		/*
>   		 * Swap entry may have been freed since our caller observed it.
>   		 */
> -		err = swapcache_prepare(entry);
> +		err = swapcache_prepare(entry, 1);
>   		if (!err)
>   			break;
>   
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 5f73a8553371..757d38a86f56 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3363,7 +3363,7 @@ void si_swapinfo(struct sysinfo *val)
>   }
>   
>   /*
> - * Verify that a swap entry is valid and increment its swap map count.
> + * Verify that nr swap entries are valid and increment their swap map counts.
>    *
>    * Returns error code in following case.
>    * - success -> 0
> @@ -3373,60 +3373,77 @@ void si_swapinfo(struct sysinfo *val)
>    * - swap-cache reference is requested but the entry is not used. -> ENOENT
>    * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
>    */
> -static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
> +static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
>   {
>   	struct swap_info_struct *p;
>   	struct swap_cluster_info *ci;
>   	unsigned long offset;
>   	unsigned char count;
>   	unsigned char has_cache;
> -	int err;
> +	int err, i;
>   
>   	p = swp_swap_info(entry);
>   
>   	offset = swp_offset(entry);
> +	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
>   	ci = lock_cluster_or_swap_info(p, offset);
>   
> -	count = p->swap_map[offset];
> +	err = 0;
> +	for (i = 0; i < nr; i++) {
> +		count = p->swap_map[offset + i];
>   
> -	/*
> -	 * swapin_readahead() doesn't check if a swap entry is valid, so the
> -	 * swap entry could be SWAP_MAP_BAD. Check here with lock held.
> -	 */
> -	if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
> -		err = -ENOENT;
> -		goto unlock_out;
> -	}
> +		/*
> +		 * swapin_readahead() doesn't check if a swap entry is valid, so the
> +		 * swap entry could be SWAP_MAP_BAD. Check here with lock held.
> +		 */
> +		if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
> +			err = -ENOENT;
> +			goto unlock_out;
> +		}
>   
> -	has_cache = count & SWAP_HAS_CACHE;
> -	count &= ~SWAP_HAS_CACHE;
> -	err = 0;
> +		has_cache = count & SWAP_HAS_CACHE;
> +		count &= ~SWAP_HAS_CACHE;
>   
> -	if (usage == SWAP_HAS_CACHE) {
> +		if (usage == SWAP_HAS_CACHE) {
> +			/* set SWAP_HAS_CACHE if there is no cache and entry is used */
> +			if (!has_cache && count)
> +				continue;
> +			else if (has_cache)		/* someone else added cache */
> +				err = -EEXIST;
> +			else				/* no users remaining */
> +				err = -ENOENT;
>   
> -		/* set SWAP_HAS_CACHE if there is no cache and entry is used */
> -		if (!has_cache && count)
> -			has_cache = SWAP_HAS_CACHE;
> -		else if (has_cache)		/* someone else added cache */
> -			err = -EEXIST;
> -		else				/* no users remaining */
> -			err = -ENOENT;
> +		} else if (count || has_cache) {
>   
> -	} else if (count || has_cache) {
> +			if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> +				continue;
> +			else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> +				err = -EINVAL;
> +			else if (swap_count_continued(p, offset + i, count))
> +				continue;
> +			else
> +				err = -ENOMEM;
> +		} else
> +			err = -ENOENT;			/* unused swap entry */
>   
> -		if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> +		if (err)
> +			goto unlock_out;
> +	}
> +
> +	for (i = 0; i < nr; i++) {
> +		count = p->swap_map[offset + i];
> +		has_cache = count & SWAP_HAS_CACHE;
> +		count &= ~SWAP_HAS_CACHE;
> +
> +		if (usage == SWAP_HAS_CACHE)
> +			has_cache = SWAP_HAS_CACHE;
> +		else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
>   			count += usage;
> -		else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> -			err = -EINVAL;
> -		else if (swap_count_continued(p, offset, count))
> -			count = COUNT_CONTINUED;
>   		else
> -			err = -ENOMEM;
> -	} else
> -		err = -ENOENT;			/* unused swap entry */
> +			count = COUNT_CONTINUED;
>   
> -	if (!err)
> -		WRITE_ONCE(p->swap_map[offset], count | has_cache);
> +		WRITE_ONCE(p->swap_map[offset + i], count | has_cache);
> +	}
>   
>   unlock_out:
>   	unlock_cluster_or_swap_info(p, ci);
> @@ -3439,7 +3456,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
>    */
>   void swap_shmem_alloc(swp_entry_t entry)
>   {
> -	__swap_duplicate(entry, SWAP_MAP_SHMEM);
> +	__swap_duplicate(entry, SWAP_MAP_SHMEM, 1);
>   }
>   
>   /*
> @@ -3453,29 +3470,29 @@ int swap_duplicate(swp_entry_t entry)
>   {
>   	int err = 0;
>   
> -	while (!err && __swap_duplicate(entry, 1) == -ENOMEM)
> +	while (!err && __swap_duplicate(entry, 1, 1) == -ENOMEM)
>   		err = add_swap_count_continuation(entry, GFP_ATOMIC);
>   	return err;
>   }
>   
>   /*
> - * @entry: swap entry for which we allocate swap cache.
> + * @entry: first swap entry from which we allocate nr swap cache.
>    *
> - * Called when allocating swap cache for existing swap entry,
> + * Called when allocating swap cache for existing swap entries,
>    * This can return error codes. Returns 0 at success.
>    * -EEXIST means there is a swap cache.
>    * Note: return code is different from swap_duplicate().
>    */
> -int swapcache_prepare(swp_entry_t entry)
> +int swapcache_prepare(swp_entry_t entry, int nr)
>   {
> -	return __swap_duplicate(entry, SWAP_HAS_CACHE);
> +	return __swap_duplicate(entry, SWAP_HAS_CACHE, nr);
>   }
>   
> -void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
> +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr)
>   {
>   	unsigned long offset = swp_offset(entry);
>   
> -	cluster_swap_free_nr(si, offset, 1, SWAP_HAS_CACHE);
> +	cluster_swap_free_nr(si, offset, nr, SWAP_HAS_CACHE);
>   }
>   
>   struct swap_info_struct *swp_swap_info(swp_entry_t entry)

