Return-Path: <linux-kernel+bounces-371152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2159A3719
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF231C20316
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29147188731;
	Fri, 18 Oct 2024 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gr6p6CvA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847620E33B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236400; cv=none; b=RbCbDHToahQHjW0nx31KkyNL/GoJ9Sy8S1cDcYuU8A35OGk8jbnFN5bAZ+ihMxBp4YwJ0AW06Sk6vB0qnuU0Qz2ewWP8ndRXro+kI/DwCY0JB/07TjWZ8ICvuprccButBwAYQUPP1CHjk3GWCbA7WpTp+GXlFcrQuA5UPOB9nVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236400; c=relaxed/simple;
	bh=cHFCgSOKRipGA1Tzq56CsX5vA/rLMUVcle1EsAAq5LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUjCYsm9A2NmB0YnJaa4J57Dv1vR6WWzarRsOLcA12k97kj87QpA6C8G1PpPQXF1NGz8Rl/v3AknVdhSnEGhsfk5iKjnB8cz+5XKiAhX/D9uTOLVVoi/3lOB+jenm0Q2PwCFbvdn0+aCl+93dSXI4XA/py7dvXNURSMlYHQULYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gr6p6CvA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729236397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8AGcEcniV7JEoT0eT14L592DwxMl3eMM1xcWVFG915U=;
	b=Gr6p6CvAndQ/C0QTyiwxcKzwLdIIufTEJljqFMkrZ3sgA7ag+/D2T7iyQtrZBRmW6f8BLk
	dz2YH7Iq6FcFjhirYcz2LCkLDJjJmArGoCl+PXdFzMxRqIcxlWb3la7yYBG1G74KVd//+F
	rUTA01AbOY3GC+dlnsdIGYRBnyahYbQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-v0BaA7N5NxmJ9B0qs09dpQ-1; Fri, 18 Oct 2024 03:26:35 -0400
X-MC-Unique: v0BaA7N5NxmJ9B0qs09dpQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d4922d8c7so849924f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729236394; x=1729841194;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8AGcEcniV7JEoT0eT14L592DwxMl3eMM1xcWVFG915U=;
        b=dkMsZqYPYCKQdJDNlN5UU+M6ZrHZF1WJSkVX3N6D8wC6fuMGjNf8id+9Zc4Epo5iaw
         Psc5U4nV8tYwFzdkPOKye5mJpVjbx9/MjT/5PM3Xj7jSxt9OGo4bI7dSysHUJvOiqx5D
         GNQtcpxfmDPVFsEog7K+AJ967/MviPpUjEYY+2dtWtjqNHRHXIOaLSE6mbb6ZJZVixpp
         d8yZ9i2MAI1GzBxIimqTnO/TnywXQ4rAnah3NV1VDATqCZ2KYDgWxtmzM/QDuEHFPwrT
         zdvbawn8PgQInGk0BKmzfknw7mowB12aWuGPOSqISp2oQNI6OgtdxDyX/lE/xeeEUzpV
         LuQg==
X-Forwarded-Encrypted: i=1; AJvYcCUvchZz7bzyomhzpDqUACxXLIVakujT7pq+rn+BVIklXAX0ZIsbJMUuUzpflB7PAaSABTqz2j45u4KvHsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj9ERoXfMvgTPUZWpTEYdD+gi/pURVxbkTUdn2a/wRezTkpkZR
	XYg6OeYQcJyuQtgPGi/RhY2eApZ3ts67jtc0PxvxzMOCfU8xJgDHy6gfkK4nlYwSD3GxF8k0BYj
	UnFu39lO18FCaKcSPV1EYxYyLDTLPDx/okdl6RlPJHKnlJ2zx1Merr3ST2b1W9Q==
X-Received: by 2002:adf:ab03:0:b0:37c:d244:bdb1 with SMTP id ffacd0b85a97d-37ea218b670mr951843f8f.26.1729236394382;
        Fri, 18 Oct 2024 00:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvaVRF4BdxdGQJg5mJ4eGL2V0zr3UiN6OUikapqOUGeXVh6K8+uF/miAAjxbhmegwqcfyydQ==
X-Received: by 2002:adf:ab03:0:b0:37c:d244:bdb1 with SMTP id ffacd0b85a97d-37ea218b670mr951806f8f.26.1729236393888;
        Fri, 18 Oct 2024 00:26:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2400:68a3:92e0:906f:b69d? (p200300cbc707240068a392e0906fb69d.dip0.t-ipconnect.de. [2003:cb:c707:2400:68a3:92e0:906f:b69d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf1190dcsm1136745f8f.102.2024.10.18.00.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 00:26:32 -0700 (PDT)
Message-ID: <71bcbd3f-a8bd-4014-aabe-081006cc62f8@redhat.com>
Date: Fri, 18 Oct 2024 09:26:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 6/7] mm: do_swap_page() calls swapin_readahead()
 zswap load batching interface.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 usamaarif642@gmail.com, ryan.roberts@arm.com, ying.huang@intel.com,
 21cnbao@gmail.com, akpm@linux-foundation.org, hughd@google.com,
 willy@infradead.org, bfoster@redhat.com, dchinner@redhat.com,
 chrisl@kernel.org
Cc: wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
References: <20241018064805.336490-1-kanchana.p.sridhar@intel.com>
 <20241018064805.336490-7-kanchana.p.sridhar@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241018064805.336490-7-kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.10.24 08:48, Kanchana P Sridhar wrote:
> This patch invokes the swapin_readahead() based batching interface to
> prefetch a batch of 4K folios for zswap load with batch decompressions
> in parallel using IAA hardware. swapin_readahead() prefetches folios based
> on vm.page-cluster and the usefulness of prior prefetches to the
> workload. As folios are created in the swapcache and the readahead code
> calls swap_read_folio() with a "zswap_batch" and a "non_zswap_batch", the
> respective folio_batches get populated with the folios to be read.
> 
> Finally, the swapin_readahead() procedures will call the newly added
> process_ra_batch_of_same_type() which:
> 
>   1) Reads all the non_zswap_batch folios sequentially by calling
>      swap_read_folio().
>   2) Calls swap_read_zswap_batch_unplug() with the zswap_batch which calls
>      zswap_finish_load_batch() that finally decompresses each
>      SWAP_CRYPTO_SUB_BATCH_SIZE sub-batch (i.e. upto 8 pages in a prefetch
>      batch of say, 32 folios) in parallel with IAA.
> 
> Within do_swap_page(), we try to benefit from batch decompressions in both
> these scenarios:
> 
>   1) single-mapped, SWP_SYNCHRONOUS_IO:
>        We call swapin_readahead() with "single_mapped_path = true". This is
>        done only in the !zswap_never_enabled() case.
>   2) Shared and/or non-SWP_SYNCHRONOUS_IO folios:
>        We call swapin_readahead() with "single_mapped_path = false".
> 
> This will place folios in the swapcache: a design choice that handles cases
> where a folio that is "single-mapped" in process 1 could be prefetched in
> process 2; and handles highly contended server scenarios with stability.
> There are checks added at the end of do_swap_page(), after the folio has
> been successfully loaded, to detect if the single-mapped swapcache folio is
> still single-mapped, and if so, folio_free_swap() is called on the folio.
> 
> Within the swapin_readahead() functions, if single_mapped_path is true, and
> either the platform does not have IAA, or, if the platform has IAA and the
> user selects a software compressor for zswap (details of sysfs knob
> follow), readahead/batching are skipped and the folio is loaded using
> zswap_load().
> 
> A new swap parameter "singlemapped_ra_enabled" (false by default) is added
> for platforms that have IAA, zswap_load_batching_enabled() is true, and we
> want to give the user the option to run experiments with IAA and with
> software compressors for zswap (swap device is SWP_SYNCHRONOUS_IO):
> 
> For IAA:
>   echo true > /sys/kernel/mm/swap/singlemapped_ra_enabled
> 
> For software compressors:
>   echo false > /sys/kernel/mm/swap/singlemapped_ra_enabled
> 
> If "singlemapped_ra_enabled" is set to false, swapin_readahead() will skip
> prefetching folios in the "single-mapped SWP_SYNCHRONOUS_IO" do_swap_page()
> path.
> 
> Thanks Ying Huang for the really helpful brainstorming discussions on the
> swap_read_folio() plug design.
> 
> Suggested-by: Ying Huang <ying.huang@intel.com>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>   mm/memory.c     | 187 +++++++++++++++++++++++++++++++++++++-----------
>   mm/shmem.c      |   2 +-
>   mm/swap.h       |  12 ++--
>   mm/swap_state.c | 157 ++++++++++++++++++++++++++++++++++++----
>   mm/swapfile.c   |   2 +-
>   5 files changed, 299 insertions(+), 61 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index b5745b9ffdf7..9655b85fc243 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3924,6 +3924,42 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
>   	return 0;
>   }
>   
> +/*
> + * swapin readahead based batching interface for zswap batched loads using IAA:
> + *
> + * Should only be called for and if the faulting swap entry in do_swap_page
> + * is single-mapped and SWP_SYNCHRONOUS_IO.
> + *
> + * Detect if the folio is in the swapcache, is still mapped to only this
> + * process, and further, there are no additional references to this folio
> + * (for e.g. if another process simultaneously readahead this swap entry
> + * while this process was handling the page-fault, and got a pointer to the
> + * folio allocated by this process in the swapcache), besides the references
> + * that were obtained within __read_swap_cache_async() by this process that is
> + * faulting in this single-mapped swap entry.
> + */

How is this supposed to work for large folios?

> +static inline bool should_free_singlemap_swapcache(swp_entry_t entry,
> +						   struct folio *folio)
> +{
> +	if (!folio_test_swapcache(folio))
> +		return false;
> +
> +	if (__swap_count(entry) != 0)
> +		return false;
> +
> +	/*
> +	 * The folio ref count for a single-mapped folio that was allocated
> +	 * in __read_swap_cache_async(), can be a maximum of 3. These are the
> +	 * incrementors of the folio ref count in __read_swap_cache_async():
> +	 * folio_alloc_mpol(), add_to_swap_cache(), folio_add_lru().
> +	 */
> +
> +	if (folio_ref_count(folio) <= 3)
> +		return true;
> +
> +	return false;
> +}
> +
>   static inline bool should_try_to_free_swap(struct folio *folio,
>   					   struct vm_area_struct *vma,
>   					   unsigned int fault_flags)
> @@ -4215,6 +4251,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	swp_entry_t entry;
>   	pte_t pte;
>   	vm_fault_t ret = 0;
> +	bool single_mapped_swapcache = false;
>   	void *shadow = NULL;
>   	int nr_pages;
>   	unsigned long page_idx;
> @@ -4283,51 +4320,90 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	if (!folio) {
>   		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>   		    __swap_count(entry) == 1) {
> -			/* skip swapcache */
> -			folio = alloc_swap_folio(vmf);
> -			if (folio) {
> -				__folio_set_locked(folio);
> -				__folio_set_swapbacked(folio);
> -
> -				nr_pages = folio_nr_pages(folio);
> -				if (folio_test_large(folio))
> -					entry.val = ALIGN_DOWN(entry.val, nr_pages);
> -				/*
> -				 * Prevent parallel swapin from proceeding with
> -				 * the cache flag. Otherwise, another thread
> -				 * may finish swapin first, free the entry, and
> -				 * swapout reusing the same entry. It's
> -				 * undetectable as pte_same() returns true due
> -				 * to entry reuse.
> -				 */
> -				if (swapcache_prepare(entry, nr_pages)) {
> +			if (zswap_never_enabled()) {
> +				/* skip swapcache */
> +				folio = alloc_swap_folio(vmf);
> +				if (folio) {
> +					__folio_set_locked(folio);
> +					__folio_set_swapbacked(folio);
> +
> +					nr_pages = folio_nr_pages(folio);
> +					if (folio_test_large(folio))
> +						entry.val = ALIGN_DOWN(entry.val, nr_pages);
>   					/*
> -					 * Relax a bit to prevent rapid
> -					 * repeated page faults.
> +					 * Prevent parallel swapin from proceeding with
> +					 * the cache flag. Otherwise, another thread
> +					 * may finish swapin first, free the entry, and
> +					 * swapout reusing the same entry. It's
> +					 * undetectable as pte_same() returns true due
> +					 * to entry reuse.
>   					 */
> -					add_wait_queue(&swapcache_wq, &wait);
> -					schedule_timeout_uninterruptible(1);
> -					remove_wait_queue(&swapcache_wq, &wait);
> -					goto out_page;
> +					if (swapcache_prepare(entry, nr_pages)) {
> +						/*
> +						 * Relax a bit to prevent rapid
> +						 * repeated page faults.
> +						 */
> +						add_wait_queue(&swapcache_wq, &wait);
> +						schedule_timeout_uninterruptible(1);
> +						remove_wait_queue(&swapcache_wq, &wait);
> +						goto out_page;
> +					}
> +					need_clear_cache = true;
> +
> +					mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
> +
> +					shadow = get_shadow_from_swap_cache(entry);
> +					if (shadow)
> +						workingset_refault(folio, shadow);
> +
> +					folio_add_lru(folio);
> +
> +					/* To provide entry to swap_read_folio() */
> +					folio->swap = entry;
> +					swap_read_folio(folio, NULL, NULL, NULL);
> +					folio->private = NULL;
> +				}
> +			} else {
> +				/*
> +				 * zswap is enabled or was enabled at some point.
> +				 * Don't skip swapcache.
> +				 *
> +				 * swapin readahead based batching interface
> +				 * for zswap batched loads using IAA:
> +				 *
> +				 * Readahead is invoked in this path only if
> +				 * the sys swap "singlemapped_ra_enabled" swap
> +				 * parameter is set to true. By default,
> +				 * "singlemapped_ra_enabled" is set to false,
> +				 * the recommended setting for software compressors.
> +				 * For IAA, if "singlemapped_ra_enabled" is set
> +				 * to true, readahead will be deployed in this path
> +				 * as well.
> +				 *
> +				 * For single-mapped pages, the batching interface
> +				 * calls __read_swap_cache_async() to allocate and
> +				 * place the faulting page in the swapcache. This is
> +				 * to handle a scenario where the faulting page in
> +				 * this process happens to simultaneously be a
> +				 * readahead page in another process. By placing the
> +				 * single-mapped faulting page in the swapcache,
> +				 * we avoid race conditions and duplicate page
> +				 * allocations under these scenarios.
> +				 */
> +				folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> +							 vmf, true);
> +				if (!folio) {
> +					ret = VM_FAULT_OOM;
> +					goto out;
>   				}
> -				need_clear_cache = true;
> -
> -				mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
> -
> -				shadow = get_shadow_from_swap_cache(entry);
> -				if (shadow)
> -					workingset_refault(folio, shadow);
> -
> -				folio_add_lru(folio);
>   
> -				/* To provide entry to swap_read_folio() */
> -				folio->swap = entry;
> -				swap_read_folio(folio, NULL, NULL, NULL);
> -				folio->private = NULL;
> -			}
> +				single_mapped_swapcache = true;
> +				nr_pages = folio_nr_pages(folio);
> +				swapcache = folio;
> +			} /* swapin with zswap support. */
>   		} else {
>   			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> -						vmf);
> +						 vmf, false);
>   			swapcache = folio;

I'm sorry, but making this function ever more complicated and ugly is 
not going to fly. The zswap special casing is quite ugly here as well.

Is there a way forward that we can make this code actually readable and 
avoid zswap special casing?

-- 
Cheers,

David / dhildenb


