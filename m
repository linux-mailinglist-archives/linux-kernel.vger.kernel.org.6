Return-Path: <linux-kernel+bounces-280101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E941394C5B0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5776B25E20
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1478F15665D;
	Thu,  8 Aug 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSVAdMha"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86113D8A2
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148718; cv=none; b=jl8eV/xMAC7VYAI4Gs7tKbYED10r4Chce3SoXHFpBA/C+pKKs38y3gY7uWYO3QymzfGnuqI7aH0YiWK0LekiYZ5sOcKCk//D/pwusccxHuKBO4HbIbGTOvwaEohgHslKeS2nlHcZ7zM0EwznBE4yWD5nOW+PMFza1rEy9gsHgfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148718; c=relaxed/simple;
	bh=sgJW47eKUkWXSYjIjN6cpPP36Nnbt7V4f1NXngKzhr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXkkuBcpZ2RuN4Jl4eoXsWQSdlG6Ix1hdhhGSKFNmiQSoRXSZUu9WeRW2FmvA/EMWvEVO9c76bt0/bjtOrIL1r1kSZ6SZCJy+gdML72Zv1TJnA//PVv/CHqw9CoZ8//kvbDRntJpTwoiA32Cov/ODjVDt0yYl/59im57yM8y98U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSVAdMha; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723148715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8daUpyfTZqUQFCrzGvmeyWvUDYOhXzl0ULKyt5g2PCM=;
	b=YSVAdMhaM5ZasfukU2HOCj10Tet3tMInAMsku/0CLAK/HeM4tYzIuIRWSL5OgcxhGw7YLY
	694GCFrHC6RZvkUbNpPDAWrJSf8CpKp8ItNbJFBkzXc+9TvqKnwhLd7rRxrx/+a5L6n4uY
	0L/0ooiJrwp0TRC+5dDqgOd04NMiB6s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-00x9EP9ANWa1HEbQs-v77g-1; Thu, 08 Aug 2024 16:25:14 -0400
X-MC-Unique: 00x9EP9ANWa1HEbQs-v77g-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b7b1d79bacso3243446d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 13:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723148713; x=1723753513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8daUpyfTZqUQFCrzGvmeyWvUDYOhXzl0ULKyt5g2PCM=;
        b=Q/FgDaBOdR/TnHAPCY6HaC49X146wRU/aPVgvMmPASXDOAVw4bf5MwjmQJMQhcBx0O
         32NX6yJaWZ/qpYLUlnbK84WLgqAkZfK+YENbyTgAvFm3D4dXjIBXcDLIdhtQcPWUsZ6o
         u7jxg/ouHKqAQ56z4KbZbX73+uO4dI/7pWIgMLsXi714SENObLXngFVAQWpKML3OjFvx
         juOa61N+uiGrRuzBqIbpyR7vrrU0Hf5ysthAZUaEIyMNXMfbr88ZO1G13IQFkXHDjyiy
         KRdHAqpBRMuBiZ3RCMP8B0KbH2wckWphN8kGSfWm73IfkkqH/3AijOI8z+UxKJFM/PXx
         XJUw==
X-Gm-Message-State: AOJu0YzJq4kNSjINd7QF6+NpKVzUPi9YFfySw9ar7fwg443/WsFMPvsC
	Gzqxh+fcRMx0HdwkmzljcyvWv4U/SdXnHHAKwshJxmzm3n7n0qwQ2qNuRuy2s4UQM7haGteUGPQ
	3zDk1sBw6i7Fq4bIX8eigGhwQ1p2xmd8JYFdJ8woCnpFmSYWqKXqUVerEeUjvKQ==
X-Received: by 2002:ad4:4c4b:0:b0:6bd:738c:844b with SMTP id 6a1803df08f44-6bd738c86cbmr7125906d6.7.1723148713386;
        Thu, 08 Aug 2024 13:25:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHxHRY0hgUe0eqPdegGemg/UeFvqIQDH8YpIiffoYytwmP645+Qp3cG/ROktBrvTKfdRkxUA==
X-Received: by 2002:ad4:4c4b:0:b0:6bd:738c:844b with SMTP id 6a1803df08f44-6bd738c86cbmr7125696d6.7.1723148712878;
        Thu, 08 Aug 2024 13:25:12 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c78ae4asm70451386d6.33.2024.08.08.13.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 13:25:12 -0700 (PDT)
Date: Thu, 8 Aug 2024 16:25:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Oscar Salvador <osalvador@suse.de>,
	Dan Williams <dan.j.williams@intel.com>,
	James Houghton <jthoughton@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Rik van Riel <riel@surriel.com>, Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	linuxppc-dev@lists.ozlabs.org,
	Mel Gorman <mgorman@techsingularity.net>,
	Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v4 6/7] mm/x86: Add missing pud helpers
Message-ID: <ZrUpowkgPHIub4el@x1n>
References: <20240807194812.819412-1-peterx@redhat.com>
 <20240807194812.819412-7-peterx@redhat.com>
 <875xsc0xjy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xsc0xjy.ffs@tglx>

On Thu, Aug 08, 2024 at 12:37:21AM +0200, Thomas Gleixner wrote:
> On Wed, Aug 07 2024 at 15:48, Peter Xu wrote:
> > These new helpers will be needed for pud entry updates soon.  Introduce
> > these helpers by referencing the pmd ones.  Namely:
> >
> > - pudp_invalidate()
> > - pud_modify()
> 
> Zero content about what these helpers do and why they are needed. That's
> not how it works, really.

I hope what Dave suggested to add "by referencing the pmd ones" would be
helpful, because they are exactly referencing those.

But sure.. I rewrote the commit message as following:

    mm/x86: Add missing pud helpers

    Some new helpers will be needed for pud entry updates soon.  Introduce
    these helpers by referencing the pmd ones.  Namely:

      - pudp_invalidate(): this helper invalidates a huge pud before a split
      happens, so that the invalidated pud entry will make sure no race will
      happen (either with software, like a concurrent zap, or hardware, like
      a/d bit lost).

      - pud_modify(): this helper applies a new pgprot to an existing huge pud
      mapping.

    For more information on why we need these two helpers, please refer to the
    corresponding pmd helpers in the mprotect() code path.

    When at it, simplify the pud_modify()/pmd_modify() comments on shadow stack
    pgtable entries to reference pte_modify() to avoid duplicating the whole
    paragraph three times.

Please let me know if this works for you.

> 
>   
> > +static inline pud_t pud_mkinvalid(pud_t pud)
> > +{
> > +	return pfn_pud(pud_pfn(pud),
> > +		       __pgprot(pud_flags(pud) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
> 
> 100 characters...

Waiting for an answer on this one, so I'll ignore "100 char" comments for
now, and will address them when I get a clue on what is happening..

> 
> > +}
> > +
> >  static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
> >  
> >  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> > @@ -834,14 +840,8 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
> >  	pmd_result = __pmd(val);
> >  
> >  	/*
> > -	 * To avoid creating Write=0,Dirty=1 PMDs, pte_modify() needs to avoid:
> > -	 *  1. Marking Write=0 PMDs Dirty=1
> > -	 *  2. Marking Dirty=1 PMDs Write=0
> > -	 *
> > -	 * The first case cannot happen because the _PAGE_CHG_MASK will filter
> > -	 * out any Dirty bit passed in newprot. Handle the second case by
> > -	 * going through the mksaveddirty exercise. Only do this if the old
> > -	 * value was Write=1 to avoid doing this on Shadow Stack PTEs.
> > +	 * Avoid creating shadow stack PMD by accident.  See comment in
> > +	 * pte_modify().
> 
> The changelog is utterly silent about this comment update.

Updated my commit message altogether above; I hope it works.

> 
> >  	 */
> >  	if (oldval & _PAGE_RW)
> >  		pmd_result = pmd_mksaveddirty(pmd_result);
> > @@ -851,6 +851,29 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
> >  	return pmd_result;
> >  }
> >  
> > +static inline pud_t pud_modify(pud_t pud, pgprot_t newprot)
> > +{
> > +	pudval_t val = pud_val(pud), oldval = val;
> > +	pud_t pud_result;
> > +
> > +	val &= _HPAGE_CHG_MASK;
> > +	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
> > +	val = flip_protnone_guard(oldval, val, PHYSICAL_PUD_PAGE_MASK);
> > +
> > +	pud_result = __pud(val);
> > +
> > +	/*
> > +	 * Avoid creating shadow stack PUD by accident.  See comment in
> > +	 * pte_modify().
> > +	 */
> > +	if (oldval & _PAGE_RW)
> > +		pud_result = pud_mksaveddirty(pud_result);
> > +	else
> > +		pud_result = pud_clear_saveddirty(pud_result);
> > +
> > +	return pud_result;
> > +}
> > +
> >  /*
> >   * mprotect needs to preserve PAT and encryption bits when updating
> >   * vm_page_prot
> > @@ -1389,10 +1412,26 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
> >  }
> >  #endif
> >  
> > +static inline pud_t pudp_establish(struct vm_area_struct *vma,
> > +		unsigned long address, pud_t *pudp, pud_t pud)
> 
> Random line break alignment.... See documentation.

This is exactly what we do with pmdp_establish() right above.

Would you be fine I keep this just to make pmd/pud look the same?

> 
> > +{
> > +	page_table_check_pud_set(vma->vm_mm, pudp, pud);
> > +	if (IS_ENABLED(CONFIG_SMP)) {
> > +		return xchg(pudp, pud);
> > +	} else {
> > +		pud_t old = *pudp;
> > +		WRITE_ONCE(*pudp, pud);
> 
> Lacks a newline between variable declaration and code.
> 
> But seriously, why optimizing for !SMP? That's a pointless exercise and
> a guarantee for bitrot.

So far it looks still reasonable to me if it is there in pmd.  If I remove
it, people can complain again on "hey, we have this /optimization/ in pmd,
why you removed it in pud?".  No end..

So again.. it's the same to pmd ones.  Either we change nothing, or we
change both.  I don't want to expand this series to more than it wants to
do.. would you mind I keep it until someone justifies the change to modify
both?

> 
> > +		return old;
> > +	}
> > +}
> > +
> >  #define __HAVE_ARCH_PMDP_INVALIDATE_AD
> >  extern pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma,
> >  				unsigned long address, pmd_t *pmdp);
> >  
> > +pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
> > +		      pud_t *pudp);
> 
> While 'extern' is not required, please keep the file style consistent
> and use the 100 characters...
> 
> > --- a/arch/x86/mm/pgtable.c
> > +++ b/arch/x86/mm/pgtable.c
> > @@ -641,6 +641,18 @@ pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
> >  }
> >  #endif
> >  
> > +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && \
> > +	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
> > +pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
> > +		     pud_t *pudp)
> > +{
> > +	VM_WARN_ON_ONCE(!pud_present(*pudp));
> > +	pud_t old = pudp_establish(vma, address, pudp, pud_mkinvalid(*pudp));
> > +	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
> > +	return old;
> 
> Your keyboard clearly lacks a newline key ...

This is also the same, that pmdp_invalidate() coded it like exactly that.

In general, I prefer keeping the pmd/pud helpers look the same if you won't
disagree as of now, all over the places.

I know that it might even be better to clean up everything, get everything
reviewed first on pmd changes, then clone that to pud.  That might be
cleaner indeed.  But it adds much fuss all over the places, and even with
this series I got stuck for months.. and so far I haven't yet post what I
really wanted to post (huge pfnmaps).  I sincerely hope we can move forward
with this and then clean things up later (none of them are major issues;
all trivial details so far, IMHO, so nothing I see go severely wrong yet),
and then the cleanup will need to be justified one by one on each spot.

Thanks,

-- 
Peter Xu


