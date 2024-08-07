Return-Path: <linux-kernel+bounces-278653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AE294B326
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303591C216F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7082014EC50;
	Wed,  7 Aug 2024 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2guZOYZ9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IB5N8gDs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19197811E2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723070247; cv=none; b=YrB4w1+U59P2MxNlO7MfcAIQ1jQwR7tznGJBrGrIx6HI9YRlcoCMSz/Mgd9SjqHVUMrAcN01FlBT71fwnkz47bZj4Umn7t9ashvX/U1y63gELR5PVl+ZeHaOAStVeNqRk9bc029kydoQUampt1w9UeZSvZSeRIZeoehbAEgHsUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723070247; c=relaxed/simple;
	bh=I+nh1RcrayyOe4E6ICcgBqkW0+LUwAubE2kU08fGfRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NOm9Xj1s//xzxEAsSme3uq1rywnJEYrCyVEsBX5hE83+ggx583ipSw9ISKHapISoMncaBTpjxaiquWQspUNeI2CtiC7/H6+jLnuMAT9SU+29hN1dwGhMCZMOHGsVqaijd6Tn3SGrOtqyEQe3QyMgqGWbO6tLDS7nZsBo1jsoijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2guZOYZ9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IB5N8gDs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723070242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijzboojuY5XpUno0lk+35UbNznLU2ucd6kpR6qcMWxg=;
	b=2guZOYZ99eyTcewCEP8xSZxwsHPHCJoQsL15+KAEcO68JB85EE+Hd6SCbExGA8OqLINdLh
	mX32IGFpl1TmhRwBqJ+dF0jiQHcEBoZBV+AltYSVcbizerrFhRVdNW9OkKsHUlLl/RpVL9
	iyJoFp1hsL/2Izml40cfR4Bgi2fluswxwsvarN4ZmHFECUAurABZ5b6xRyopii7S45bIcd
	FEtgLFzszmtb4INfqVZrUIR9w6gSju9DqSiPuZF37VxavgThej1oJKme+a1nQ2rLwmKD82
	RoYUBkCzU/T/WzNZWB+ndNEBkuWHKIi+tMWb5a+GNDneBs2LwmGEj77sWmPIfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723070242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijzboojuY5XpUno0lk+35UbNznLU2ucd6kpR6qcMWxg=;
	b=IB5N8gDs6FBpyO8gAD9i3Vzt37QlGsQG8iqeySMgtnjM8GKUrJWBMjTtXMeWMZFSrrqVIv
	yXjA4dOnrV6rqPBg==
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Oscar Salvador <osalvador@suse.de>, Dan Williams
 <dan.j.williams@intel.com>, James Houghton <jthoughton@google.com>,
 Matthew Wilcox <willy@infradead.org>, Nicholas Piggin <npiggin@gmail.com>,
 Rik van Riel <riel@surriel.com>, Dave Jiang <dave.jiang@intel.com>, Andrew
 Morton <akpm@linux-foundation.org>, x86@kernel.org, Ingo Molnar
 <mingo@redhat.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, "Kirill
 A . Shutemov" <kirill@shutemov.name>, peterx@redhat.com,
 linuxppc-dev@lists.ozlabs.org, Mel Gorman <mgorman@techsingularity.net>,
 Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>, David
 Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Dave
 Hansen <dave.hansen@linux.intel.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v4 6/7] mm/x86: Add missing pud helpers
In-Reply-To: <20240807194812.819412-7-peterx@redhat.com>
References: <20240807194812.819412-1-peterx@redhat.com>
 <20240807194812.819412-7-peterx@redhat.com>
Date: Thu, 08 Aug 2024 00:37:21 +0200
Message-ID: <875xsc0xjy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 07 2024 at 15:48, Peter Xu wrote:
> These new helpers will be needed for pud entry updates soon.  Introduce
> these helpers by referencing the pmd ones.  Namely:
>
> - pudp_invalidate()
> - pud_modify()

Zero content about what these helpers do and why they are needed. That's
not how it works, really.

  
> +static inline pud_t pud_mkinvalid(pud_t pud)
> +{
> +	return pfn_pud(pud_pfn(pud),
> +		       __pgprot(pud_flags(pud) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));

100 characters...

> +}
> +
>  static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
>  
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> @@ -834,14 +840,8 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>  	pmd_result = __pmd(val);
>  
>  	/*
> -	 * To avoid creating Write=0,Dirty=1 PMDs, pte_modify() needs to avoid:
> -	 *  1. Marking Write=0 PMDs Dirty=1
> -	 *  2. Marking Dirty=1 PMDs Write=0
> -	 *
> -	 * The first case cannot happen because the _PAGE_CHG_MASK will filter
> -	 * out any Dirty bit passed in newprot. Handle the second case by
> -	 * going through the mksaveddirty exercise. Only do this if the old
> -	 * value was Write=1 to avoid doing this on Shadow Stack PTEs.
> +	 * Avoid creating shadow stack PMD by accident.  See comment in
> +	 * pte_modify().

The changelog is utterly silent about this comment update.

>  	 */
>  	if (oldval & _PAGE_RW)
>  		pmd_result = pmd_mksaveddirty(pmd_result);
> @@ -851,6 +851,29 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>  	return pmd_result;
>  }
>  
> +static inline pud_t pud_modify(pud_t pud, pgprot_t newprot)
> +{
> +	pudval_t val = pud_val(pud), oldval = val;
> +	pud_t pud_result;
> +
> +	val &= _HPAGE_CHG_MASK;
> +	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
> +	val = flip_protnone_guard(oldval, val, PHYSICAL_PUD_PAGE_MASK);
> +
> +	pud_result = __pud(val);
> +
> +	/*
> +	 * Avoid creating shadow stack PUD by accident.  See comment in
> +	 * pte_modify().
> +	 */
> +	if (oldval & _PAGE_RW)
> +		pud_result = pud_mksaveddirty(pud_result);
> +	else
> +		pud_result = pud_clear_saveddirty(pud_result);
> +
> +	return pud_result;
> +}
> +
>  /*
>   * mprotect needs to preserve PAT and encryption bits when updating
>   * vm_page_prot
> @@ -1389,10 +1412,26 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  }
>  #endif
>  
> +static inline pud_t pudp_establish(struct vm_area_struct *vma,
> +		unsigned long address, pud_t *pudp, pud_t pud)

Random line break alignment.... See documentation.

> +{
> +	page_table_check_pud_set(vma->vm_mm, pudp, pud);
> +	if (IS_ENABLED(CONFIG_SMP)) {
> +		return xchg(pudp, pud);
> +	} else {
> +		pud_t old = *pudp;
> +		WRITE_ONCE(*pudp, pud);

Lacks a newline between variable declaration and code.

But seriously, why optimizing for !SMP? That's a pointless exercise and
a guarantee for bitrot.

> +		return old;
> +	}
> +}
> +
>  #define __HAVE_ARCH_PMDP_INVALIDATE_AD
>  extern pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma,
>  				unsigned long address, pmd_t *pmdp);
>  
> +pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
> +		      pud_t *pudp);

While 'extern' is not required, please keep the file style consistent
and use the 100 characters...

> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -641,6 +641,18 @@ pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
>  }
>  #endif
>  
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
> +	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
> +pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
> +		     pud_t *pudp)
> +{
> +	VM_WARN_ON_ONCE(!pud_present(*pudp));
> +	pud_t old = pudp_establish(vma, address, pudp, pud_mkinvalid(*pudp));
> +	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
> +	return old;

Your keyboard clearly lacks a newline key ...

Thanks,

        tglx

