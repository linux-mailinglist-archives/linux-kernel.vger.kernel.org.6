Return-Path: <linux-kernel+bounces-263458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB64893D637
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEFA2832A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD9B17BB2F;
	Fri, 26 Jul 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZvx9TJS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6A610A1C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008213; cv=none; b=rTTWxnIQWSVtZaxRFUsCdDwqjcUuTG30nxDPNnYpJStyIYFA0GK/KAbDTTnzRn51O/Od/MMXLDxt9VAWmXMu+3heS+/AQ6kF0vJ56g5CmzetL582F0RdTDxojUYcsg7NUVfe4fx89Vvkzb/sf0zQhvFZau+n9wRE197IsRoJbnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008213; c=relaxed/simple;
	bh=B6k/HbuSyIZzsB/1yH65Wtc85rwXagMs6JgyjDCqazc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP0AYdU1uhbGQeiq5m47AYoTzIdlWBQoxWwlXU97DMR8ovolE8q6bFYGMTRqny7OTgbK8vAL+L0+EuZnn2ATSdzEoUG5Rjs0aiYGdPezyRRlStDNWi44fQDJeMlZ7RxvAfjjjjq985D0tLSxtcro7BOi7UU+4LecupxCF5ptMPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZvx9TJS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722008210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QLm/qsKSuQtpspS0vF8FpFK8gPeNztN29mDRZKXEolM=;
	b=AZvx9TJS94dugqMCrxV307n/1hV7UMaqMqLjrEX2u0+aDfUgktQzQfdlixyGR9mqKFr//P
	+BWHWqvd5rTSM7D767zlPkrLJ5v81+BxbqCYhAd8tFn8pfTKkVWuhmxB7X6HfrSeK1Boar
	sMVKpu8k4OZ+QPiTS9Tqw+NYwmbvrcM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-RP3Evc5bN9m_flf787gm_Q-1; Fri, 26 Jul 2024 11:36:49 -0400
X-MC-Unique: RP3Evc5bN9m_flf787gm_Q-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b7678caf7dso2370326d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722008209; x=1722613009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLm/qsKSuQtpspS0vF8FpFK8gPeNztN29mDRZKXEolM=;
        b=dwp/SRCLmhMlyq7oqcQ9Q2tpCFK4QhCPa3eEHhG/MsHvWxIWpO6gLZbLKz14mcXJCJ
         QSUaoCgkunyx7IupWUYSV0pTOSosv1B+96WiolfHx5PzivlzHeedCrDUTAf3rsjz/TkU
         XVHBtzg0wdpotj9VDfWsybjfxvmKlTDHmxJHS8aptlG3G9U0DGLuDLLkDmth4f448T1t
         J+nR18x/R9B//fpsbAMvMT5yZN69FPtjYDHFCrxhgd8dNAcmrlpidiGjPk+6Woz9yVSU
         o5Ho2v4ZXCgOB49ogdOZ4AeModPJtOPZt0w+xmEvL8JenNktBidDpCvqvAqeyHOUkzVZ
         Scpw==
X-Gm-Message-State: AOJu0YxiraxHmRJR+lzuVEfYUtQMSecR3CWg17fzdq6+t+sSc5r3boG9
	OQCKaLuBesTFeK0XO6y40eRFnAup9vNcO65Goj++1aE7XxBg7UVACdGEp5Ed6wIYzFDhLIVA7dB
	czWjNrZA9kuNYtRPbi0ousMPMPXNg6Rp0MJVKEBkIml57G8SsaszIlTh5DmzofQ==
X-Received: by 2002:a05:620a:d96:b0:79f:84f:80b1 with SMTP id af79cd13be357-7a1d69ac9e2mr416724985a.7.1722008208796;
        Fri, 26 Jul 2024 08:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHby0Zf7xeNrsERVjSP+2iorPmfENAqa3QKQZu/PoiXRWD/Ql4rXBzNMgzPl0Vq6g21JDLeA==
X-Received: by 2002:a05:620a:d96:b0:79f:84f:80b1 with SMTP id af79cd13be357-7a1d69ac9e2mr416722885a.7.1722008208271;
        Fri, 26 Jul 2024 08:36:48 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7435577sm188127485a.96.2024.07.26.08.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:36:47 -0700 (PDT)
Date: Fri, 26 Jul 2024 11:36:45 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
Message-ID: <ZqPCjd35OdNRrcfl@x1n>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240725183955.2268884-2-david@redhat.com>

On Thu, Jul 25, 2024 at 08:39:54PM +0200, David Hildenbrand wrote:
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

I think it can't change, because anyone who wants to race against this
should try to take the pmd lock first (which was held already)?

I wonder an open coded "ptlock_ptr(page_ptdesc(pmd_page(*pmd)))" would be
nicer here, but only if my understanding is correct.

Thanks,

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
>  include/linux/mm.h   |  7 ++++---
>  mm/khugepaged.c      | 21 +++++++++++++++------
>  mm/pgtable-generic.c |  4 ++--
>  3 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2c6ccf088c7be..0472a5090b180 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2873,9 +2873,10 @@ static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
>  }
>  #endif /* ALLOC_SPLIT_PTLOCKS */
>  
> -static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
> +static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pte_t *pte)
>  {
> -	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
> +	/* PTE page tables don't currently exceed a single page. */
> +	return ptlock_ptr(virt_to_ptdesc(pte));
>  }
>  
>  static inline bool ptlock_init(struct ptdesc *ptdesc)
> @@ -2898,7 +2899,7 @@ static inline bool ptlock_init(struct ptdesc *ptdesc)
>  /*
>   * We use mm->page_table_lock to guard all pagetable pages of the mm.
>   */
> -static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
> +static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pte_t *pte)
>  {
>  	return &mm->page_table_lock;
>  }
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index cdd1d8655a76b..f3b3db1046155 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1697,12 +1697,13 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>  	i_mmap_lock_read(mapping);
>  	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
>  		struct mmu_notifier_range range;
> +		bool retracted = false;
>  		struct mm_struct *mm;
>  		unsigned long addr;
>  		pmd_t *pmd, pgt_pmd;
>  		spinlock_t *pml;
>  		spinlock_t *ptl;
> -		bool skipped_uffd = false;
> +		pte_t *pte;
>  
>  		/*
>  		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
> @@ -1739,9 +1740,17 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>  		mmu_notifier_invalidate_range_start(&range);
>  
>  		pml = pmd_lock(mm, pmd);
> -		ptl = pte_lockptr(mm, pmd);
> +
> +		/*
> +		 * No need to check the PTE table content, but we'll grab the
> +		 * PTE table lock while we zap it.
> +		 */
> +		pte = pte_offset_map_nolock(mm, pmd, addr, &ptl);
> +		if (!pte)
> +			goto unlock_pmd;
>  		if (ptl != pml)
>  			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> +		pte_unmap(pte);
>  
>  		/*
>  		 * Huge page lock is still held, so normally the page table
> @@ -1752,20 +1761,20 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>  		 * repeating the anon_vma check protects from one category,
>  		 * and repeating the userfaultfd_wp() check from another.
>  		 */
> -		if (unlikely(vma->anon_vma || userfaultfd_wp(vma))) {
> -			skipped_uffd = true;
> -		} else {
> +		if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
>  			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
>  			pmdp_get_lockless_sync();
> +			retracted = true;
>  		}
>  
>  		if (ptl != pml)
>  			spin_unlock(ptl);
> +unlock_pmd:
>  		spin_unlock(pml);
>  
>  		mmu_notifier_invalidate_range_end(&range);
>  
> -		if (!skipped_uffd) {
> +		if (retracted) {
>  			mm_dec_nr_ptes(mm);
>  			page_table_check_pte_clear_range(mm, addr, pgt_pmd);
>  			pte_free_defer(mm, pmd_pgtable(pgt_pmd));
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index a78a4adf711ac..13a7705df3f87 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -313,7 +313,7 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
>  
>  	pte = __pte_offset_map(pmd, addr, &pmdval);
>  	if (likely(pte))
> -		*ptlp = pte_lockptr(mm, &pmdval);
> +		*ptlp = pte_lockptr(mm, pte);
>  	return pte;
>  }
>  
> @@ -371,7 +371,7 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
>  	pte = __pte_offset_map(pmd, addr, &pmdval);
>  	if (unlikely(!pte))
>  		return pte;
> -	ptl = pte_lockptr(mm, &pmdval);
> +	ptl = pte_lockptr(mm, pte);
>  	spin_lock(ptl);
>  	if (likely(pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
>  		*ptlp = ptl;
> -- 
> 2.45.2
> 

-- 
Peter Xu


