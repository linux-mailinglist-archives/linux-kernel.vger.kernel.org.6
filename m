Return-Path: <linux-kernel+bounces-265282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A158E93EEE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3137A1F210E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4DF12C478;
	Mon, 29 Jul 2024 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L0uPoE5X"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A03584A2F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239297; cv=none; b=GWVnsdHSi+ofUvDu+ucR14SDhq7BvJ3D2AhKMicPLfuBYMDbHPcgXP1Lbgun/V7dRB4rcvftS0+2+wNtT1uJtMdjGWjYpGxa+KvEh+Om6+R2YS/T7ZEoe9iEGdArqDMjCDKoRooY+AYpd3lBTuyAIauox8hw7kK6vdZWdik9b60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239297; c=relaxed/simple;
	bh=PH0+fWM+UP1I1X6WuFMb0JdiqrUTkkT2MpPT1pvN6HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGhahgl6ecYAipc5RtXPQrclqybTIjj0J5K8PUJeiMKCDPqEXlSypNAmktKOZpeqA3EKevbRgxQBzOngh0J0ge6aa9n2iaPkLULV5Xq9YCKl+O9rEAFKSIPP9hjkAB8vQ/TRZAYioIy4nkGu6JKpgsU/7m3PVHOPxfpVpUw6ASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=L0uPoE5X; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc4e010efdso885785ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 00:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722239295; x=1722844095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=imL8KMm21BYmuGn+D1QBxeMgp1Tkuo5Lke200k4m+tI=;
        b=L0uPoE5XlAWlONRxfQbtK6tq3ff1feVZ9tyOw5nTTJwCsi4lwelI1jEbz10/riAzXp
         r329qVKeIOjc6d9VReNn6ICh2KajH28D9wuNbvcwU/alZJYkXAUfmH5mBTmS0W94MKpA
         1uo+8tkjkSGFOahTwXePRc3grfgm+HjNNLhzdoOguwvI7OpZ/eH1jBAoBjvEWcpWtOAv
         bvLwqZredKOohkZBF9U6ncbnmB85niWfQa586nq1LNi/47zjVdN6eYa8ewhX4eH1Cec4
         /eQOXl71UUtLNuUAv293dFIDQkih93RKXljzc6zVqoJCEFECwNibyowGZfTXhRz9Dp19
         uqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722239295; x=1722844095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=imL8KMm21BYmuGn+D1QBxeMgp1Tkuo5Lke200k4m+tI=;
        b=H9GV/K4tD0wQS0MOdrp9AOfVkuqWzlwZleUNkN8PhGmnVhxcVjlknKHSXnHbth2Vq2
         5GSlEK9+Dkv1ph0tDC1G6HxBpyriHZMQg/nnmM20Qs0WyeyhOR3/nC+GJFPL7cf4OAHQ
         /bfdgn/rOes8VRWCfEmo+4Wo5s2ksIF/sEijvGfz8yV79Na1Z6tDCAm/sPuRE5GxlAO8
         q2s5HuE2IY5zvP+BN1vk2Gc2zjiUt/Nd0er/yEOHBeQLVY0jtZ4TtYYPSH7Se4hnAPbL
         JdpQK/qsXBwe16ObHVnQwIYfWse7y/pCCQMCF/A4bopeLpStqXw+6Ll2rPpcXlZCrSsl
         3KwQ==
X-Gm-Message-State: AOJu0YxWKc1TCvDJQK0+5xS0TwHkeDCjA6jVHNmucvhSQeVCLUTmZZFm
	usyel/zvOQHMPovbjbuvxO9/gMv9THr98zk+coXs9a5ujmhTrN9ibumVsxV8tHY=
X-Google-Smtp-Source: AGHT+IHlXhDynmgBvWrpUd+RXS5BR/x336r+3XIBpChwiiIwqdd4uIDsdNa42LXdilE6g4UEd6InwA==
X-Received: by 2002:a17:902:6b0c:b0:1ff:1cf6:5b9b with SMTP id d9443c01a7336-1ff1cf666b3mr20937855ad.11.1722239295019;
        Mon, 29 Jul 2024 00:48:15 -0700 (PDT)
Received: from [10.255.168.175] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee1477sm76503735ad.169.2024.07.29.00.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 00:48:14 -0700 (PDT)
Message-ID: <100ecc66-c2ce-4dbb-8600-d782e75ab69c@bytedance.com>
Date: Mon, 29 Jul 2024 15:48:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>,
 Oscar Salvador <osalvador@suse.de>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-2-david@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20240725183955.2268884-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/26 02:39, David Hildenbrand wrote:
> pte_lockptr() is the only *_lockptr() function that doesn't consume
> what would be expected: it consumes a pmd_t pointer instead of a pte_t
> pointer.
> 
> Let's change that. The two callers in pgtable-generic.c are easily
> adjusted. Adjust khugepaged.c:retract_page_tables() to simply do a
> pte_offset_map_nolock() to obtain the lock, even though we won't actually
> be traversing the page table.
> 
> This makes the code more similar to the other variants and avoids other
> hacks to make the new pte_lockptr() version happy. pte_lockptr() users
> reside now only in  pgtable-generic.c.
> 
> Maybe, using pte_offset_map_nolock() is the right thing to do because
> the PTE table could have been removed in the meantime? At least it sounds
> more future proof if we ever have other means of page table reclaim.

Agree, this helps us recheck the pmd entry.

> 
> It's not quite clear if holding the PTE table lock is really required:
> what if someone else obtains the lock just after we unlock it? But we'll
> leave that as is for now, maybe there are good reasons.
> 
> This is a preparation for adapting hugetlb page table locking logic to
> take the same locks as core-mm page table walkers would.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/linux/mm.h   |  7 ++++---
>   mm/khugepaged.c      | 21 +++++++++++++++------
>   mm/pgtable-generic.c |  4 ++--
>   3 files changed, 21 insertions(+), 11 deletions(-)

Since pte_lockptr() no longer has a pmd parameter, it is best to modify
the comments above __pte_offset_map_lock() as well:

```
This helps the caller to avoid a later pte_lockptr(mm, *pmd), which 
might by that time act on a changed *pmd ...
```

Otherwise:
Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>

> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2c6ccf088c7be..0472a5090b180 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2873,9 +2873,10 @@ static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
>   }
>   #endif /* ALLOC_SPLIT_PTLOCKS */
>   
> -static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
> +static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pte_t *pte)
>   {
> -	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
> +	/* PTE page tables don't currently exceed a single page. */
> +	return ptlock_ptr(virt_to_ptdesc(pte));
>   }
>   
>   static inline bool ptlock_init(struct ptdesc *ptdesc)
> @@ -2898,7 +2899,7 @@ static inline bool ptlock_init(struct ptdesc *ptdesc)
>   /*
>    * We use mm->page_table_lock to guard all pagetable pages of the mm.
>    */
> -static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
> +static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pte_t *pte)
>   {
>   	return &mm->page_table_lock;
>   }
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index cdd1d8655a76b..f3b3db1046155 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1697,12 +1697,13 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>   	i_mmap_lock_read(mapping);
>   	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
>   		struct mmu_notifier_range range;
> +		bool retracted = false;
>   		struct mm_struct *mm;
>   		unsigned long addr;
>   		pmd_t *pmd, pgt_pmd;
>   		spinlock_t *pml;
>   		spinlock_t *ptl;
> -		bool skipped_uffd = false;
> +		pte_t *pte;
>   
>   		/*
>   		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
> @@ -1739,9 +1740,17 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>   		mmu_notifier_invalidate_range_start(&range);
>   
>   		pml = pmd_lock(mm, pmd);
> -		ptl = pte_lockptr(mm, pmd);
> +
> +		/*
> +		 * No need to check the PTE table content, but we'll grab the
> +		 * PTE table lock while we zap it.
> +		 */
> +		pte = pte_offset_map_nolock(mm, pmd, addr, &ptl);
> +		if (!pte)
> +			goto unlock_pmd;
>   		if (ptl != pml)
>   			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> +		pte_unmap(pte);
>   
>   		/*
>   		 * Huge page lock is still held, so normally the page table
> @@ -1752,20 +1761,20 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>   		 * repeating the anon_vma check protects from one category,
>   		 * and repeating the userfaultfd_wp() check from another.
>   		 */
> -		if (unlikely(vma->anon_vma || userfaultfd_wp(vma))) {
> -			skipped_uffd = true;
> -		} else {
> +		if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
>   			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
>   			pmdp_get_lockless_sync();
> +			retracted = true;
>   		}
>   
>   		if (ptl != pml)
>   			spin_unlock(ptl);
> +unlock_pmd:
>   		spin_unlock(pml);
>   
>   		mmu_notifier_invalidate_range_end(&range);
>   
> -		if (!skipped_uffd) {
> +		if (retracted) {
>   			mm_dec_nr_ptes(mm);
>   			page_table_check_pte_clear_range(mm, addr, pgt_pmd);
>   			pte_free_defer(mm, pmd_pgtable(pgt_pmd));
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index a78a4adf711ac..13a7705df3f87 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -313,7 +313,7 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
>   
>   	pte = __pte_offset_map(pmd, addr, &pmdval);
>   	if (likely(pte))
> -		*ptlp = pte_lockptr(mm, &pmdval);
> +		*ptlp = pte_lockptr(mm, pte);
>   	return pte;
>   }
>   
> @@ -371,7 +371,7 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
>   	pte = __pte_offset_map(pmd, addr, &pmdval);
>   	if (unlikely(!pte))
>   		return pte;
> -	ptl = pte_lockptr(mm, &pmdval);
> +	ptl = pte_lockptr(mm, pte);
>   	spin_lock(ptl);
>   	if (likely(pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
>   		*ptlp = ptl;

