Return-Path: <linux-kernel+bounces-172868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1298BF7DD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E80285F6E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19613B1AA;
	Wed,  8 May 2024 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Db9QyBqI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B6F4F5EC
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155113; cv=none; b=Bg3wo2unvmc8BT+4xeHZkstNjfLzlUWlCAHmxd6zZ3fdJL5C/aQtVROL5xAcZ4GQtD1Tz+FSbd8Df/GHaWiubbiiyIyn7Eo9dDM5xLzDLTuCn5Es3wGogyk7CLsUdOfP20AlYUVw8T4vSTRoIev6nTfEwT+yEsi3FSrd051c6SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155113; c=relaxed/simple;
	bh=Fa2QY8AI8kZwKmuiAdXq3Ue0Y4fhmNoKToMjBsJCviQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q+OTWH9I7/Co6N9SK9Q92QhUculNCJWbSVZ/Pd4sPh5jkhCiaDZ5B2gisPEzDrTorE+X7WX4H00kPJiTq+ggEcTl+Fjp1AE5677MQnSNaxwchFKemEmrv2FW+edMDf6z8/2ff6GSQX/7SCkNb/bkCdJ+HwEnilM4sQU0zGCaeNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Db9QyBqI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715155112; x=1746691112;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Fa2QY8AI8kZwKmuiAdXq3Ue0Y4fhmNoKToMjBsJCviQ=;
  b=Db9QyBqIFRfi+bXyVqaH6h39ocpgYR8OaYwgRL7LM0eISXPOClLZTZC/
   OXiGpm52acujUAMzaAyKh3/Yd0tyjOsE/JKtgdg3Pl1s2OvMu6xZwk3B7
   5W7wS1h3kc3DovLh/75VdVrLZdb5POkP3IrwMjsEJSbubqWbHDkDjizmS
   Crg20/s4yeYrNoSGeGQqu/UtPlSHH0sofx8GKC8HAaGddC8qFEwKBU/I9
   CtQMHqN68aCQ47U+2Lkus1Ftv0FgxfNJVwIEbK7bpqTukzzVsn11Ytjq0
   yet+MPAxKOemtgR9SZ5T/AR6Mq3ZkgXV+/jfYYjRSa0Jh1LMhzpK+iIE5
   w==;
X-CSE-ConnectionGUID: el1rQbK7QhyXhYq4gWFX8Q==
X-CSE-MsgGUID: m5VFR+itQDaSNTzxsejA2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10843320"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="10843320"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 00:58:31 -0700
X-CSE-ConnectionGUID: c7cTUE2ZTAi0beMvidRWHg==
X-CSE-MsgGUID: PBtu3ly/SwmI4oqNvfrNPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33609267"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 00:58:25 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>
Cc: <akpm@linux-foundation.org>,  <linux-mm@kvack.org>,
  <baolin.wang@linux.alibaba.com>,  <chrisl@kernel.org>,
  <david@redhat.com>,  <hanchuanhua@oppo.com>,  <hannes@cmpxchg.org>,
  <hughd@google.com>,  <kasong@tencent.com>,
  <linux-kernel@vger.kernel.org>,  <surenb@google.com>,
  <v-songbaohua@oppo.com>,  <willy@infradead.org>,  <xiang@kernel.org>,
  <yosryahmed@google.com>,  <yuzhao@google.com>,  <ziy@nvidia.com>,
  "Rafael J. Wysocki" <rafael@kernel.org>,  Pavel Machek <pavel@ucw.cz>,
  Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v3 2/6] mm: remove swap_free() and always use
 swap_free_nr()
In-Reply-To: <e0c1cbb2-da06-4658-a23a-962496e83557@arm.com> (Ryan Roberts's
	message of "Fri, 3 May 2024 10:31:11 +0100")
References: <20240503005023.174597-1-21cnbao@gmail.com>
	<20240503005023.174597-3-21cnbao@gmail.com>
	<e0c1cbb2-da06-4658-a23a-962496e83557@arm.com>
Date: Wed, 08 May 2024 15:56:33 +0800
Message-ID: <87y18kivny.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 03/05/2024 01:50, Barry Song wrote:
>> From: Barry Song <v-songbaohua@oppo.com>
>> 
>> To streamline maintenance efforts, we propose discontinuing the use of
>> swap_free(). Instead, we can simply invoke swap_free_nr() with nr set
>> to 1. This adjustment offers the advantage of enabling batch processing
>> within kernel/power/swap.c. Furthermore, swap_free_nr() is designed with
>> a bitmap consisting of only one long, resulting in overhead that can be
>> ignored for cases where nr equals 1.
>> 
>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Len Brown <len.brown@intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> ---
>>  include/linux/swap.h |  5 -----
>>  kernel/power/swap.c  |  7 +++----
>>  mm/memory.c          |  2 +-
>>  mm/rmap.c            |  4 ++--
>>  mm/shmem.c           |  4 ++--
>>  mm/swapfile.c        | 19 +++++--------------
>>  6 files changed, 13 insertions(+), 28 deletions(-)
>> 
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index d1d35e92d7e9..f03cb446124e 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -482,7 +482,6 @@ extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>>  extern void swap_shmem_alloc(swp_entry_t);
>>  extern int swap_duplicate(swp_entry_t);
>>  extern int swapcache_prepare(swp_entry_t);
>> -extern void swap_free(swp_entry_t);
>
> I wonder if it would be cleaner to:
>
> #define swap_free(entry) swap_free_nr((entry), 1)
>
> To save all the churn for the callsites that just want to pass a single entry?

I prefer this way.  Although I prefer inline functions.

Otherwise, LGTM.  Feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

in the future version.

>>  extern void swap_free_nr(swp_entry_t entry, int nr_pages);
>>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
>>  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
>> @@ -561,10 +560,6 @@ static inline int swapcache_prepare(swp_entry_t swp)
>>  	return 0;
>>  }
>>  
>> -static inline void swap_free(swp_entry_t swp)
>> -{
>> -}
>> -
>>  static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
>>  {
>>  }
>> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
>> index 5bc04bfe2db1..6befaa88a342 100644
>> --- a/kernel/power/swap.c
>> +++ b/kernel/power/swap.c
>> @@ -181,7 +181,7 @@ sector_t alloc_swapdev_block(int swap)
>>  	offset = swp_offset(get_swap_page_of_type(swap));
>>  	if (offset) {
>>  		if (swsusp_extents_insert(offset))
>> -			swap_free(swp_entry(swap, offset));
>> +			swap_free_nr(swp_entry(swap, offset), 1);
>>  		else
>>  			return swapdev_block(swap, offset);
>>  	}
>> @@ -200,12 +200,11 @@ void free_all_swap_pages(int swap)
>>  
>>  	while ((node = swsusp_extents.rb_node)) {
>>  		struct swsusp_extent *ext;
>> -		unsigned long offset;
>>  
>>  		ext = rb_entry(node, struct swsusp_extent, node);
>>  		rb_erase(node, &swsusp_extents);
>> -		for (offset = ext->start; offset <= ext->end; offset++)
>> -			swap_free(swp_entry(swap, offset));
>> +		swap_free_nr(swp_entry(swap, ext->start),
>> +			     ext->end - ext->start + 1);
>>  
>>  		kfree(ext);
>>  	}
>> diff --git a/mm/memory.c b/mm/memory.c
>> index eea6e4984eae..f033eb3528ba 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4225,7 +4225,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>  	 * We're already holding a reference on the page but haven't mapped it
>>  	 * yet.
>>  	 */
>> -	swap_free(entry);
>> +	swap_free_nr(entry, 1);
>>  	if (should_try_to_free_swap(folio, vma, vmf->flags))
>>  		folio_free_swap(folio);
>>  
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 087a79f1f611..39ec7742acec 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1865,7 +1865,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>  				goto walk_done_err;
>>  			}
>>  			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
>> -				swap_free(entry);
>> +				swap_free_nr(entry, 1);
>>  				set_pte_at(mm, address, pvmw.pte, pteval);
>>  				goto walk_done_err;
>>  			}
>> @@ -1873,7 +1873,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>  			/* See folio_try_share_anon_rmap(): clear PTE first. */
>>  			if (anon_exclusive &&
>>  			    folio_try_share_anon_rmap_pte(folio, subpage)) {
>> -				swap_free(entry);
>> +				swap_free_nr(entry, 1);
>>  				set_pte_at(mm, address, pvmw.pte, pteval);
>>  				goto walk_done_err;
>>  			}
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index fa2a0ed97507..bfc8a2beb24f 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1836,7 +1836,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>>  	 * in shmem_evict_inode().
>>  	 */
>>  	shmem_recalc_inode(inode, -1, -1);
>> -	swap_free(swap);
>> +	swap_free_nr(swap, 1);
>>  }
>>  
>>  /*
>> @@ -1927,7 +1927,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>  
>>  	delete_from_swap_cache(folio);
>>  	folio_mark_dirty(folio);
>> -	swap_free(swap);
>> +	swap_free_nr(swap, 1);
>>  	put_swap_device(si);
>>  
>>  	*foliop = folio;
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index ec12f2b9d229..ddcd0f24b9a1 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1343,19 +1343,6 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
>>  	swap_range_free(p, offset, 1);
>>  }
>>  
>> -/*
>> - * Caller has made sure that the swap device corresponding to entry
>> - * is still around or has not been recycled.
>> - */
>> -void swap_free(swp_entry_t entry)
>> -{
>> -	struct swap_info_struct *p;
>> -
>> -	p = _swap_info_get(entry);
>> -	if (p)
>> -		__swap_entry_free(p, entry);
>> -}
>> -
>>  static void cluster_swap_free_nr(struct swap_info_struct *sis,
>>  		unsigned long offset, int nr_pages)
>>  {
>> @@ -1385,6 +1372,10 @@ static void cluster_swap_free_nr(struct swap_info_struct *sis,
>>  	unlock_cluster_or_swap_info(sis, ci);
>>  }
>>  
>> +/*
>> + * Caller has made sure that the swap device corresponding to entry
>> + * is still around or has not been recycled.
>> + */
>>  void swap_free_nr(swp_entry_t entry, int nr_pages)
>>  {
>>  	int nr;
>> @@ -1930,7 +1921,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>>  		new_pte = pte_mkuffd_wp(new_pte);
>>  setpte:
>>  	set_pte_at(vma->vm_mm, addr, pte, new_pte);
>> -	swap_free(entry);
>> +	swap_free_nr(entry, 1);
>>  out:
>>  	if (pte)
>>  		pte_unmap_unlock(pte, ptl);

--
Best Regards,
Huang, Ying

