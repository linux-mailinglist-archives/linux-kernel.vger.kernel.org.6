Return-Path: <linux-kernel+bounces-435253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 221C29E7521
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFDC12897D5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665E220CCFC;
	Fri,  6 Dec 2024 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="vWb4fPEy"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC40BA20
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501306; cv=none; b=tJG9HdRD5nnBDIK1qdq2i5RmXbyyy+fmlkA728/k8Yy212wDgCSLicUpEYKaSxG7deBjdverx0UhgVurAzb3QSuB6OyAk3AdNAF9gnpOr7Ve7BB93jC7ZkPRB5A7h1H7syw9ZZLlGcbn0uPiWbD3z6RxXuTjzJoTXD30sYAJCF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501306; c=relaxed/simple;
	bh=zQ6WAj7IZof03Q7biW/5/1bT0OdS1alMtD5K8UfvwH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQtkmqcWWlX3VIxyET0QXF4UFqkvGmCeOLsaqb4mS1FK+jXWRoN1Oh0h/PYWzKnd17fuePttT8cuB1UPeWGBu00nCtYkMQCEii2Xj+xyOyVnpCW1+wXjI2AZZRqJZLJDJtRmgmB61rX35ris0nIi8AlWfcossgUv/gWQL+Pj/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=vWb4fPEy; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 311352003EF;
	Fri,  6 Dec 2024 17:08:14 +0100 (CET)
Authentication-Results: smtp2-g21.free.fr;
	dkim=pass (1024-bit key; unprotected) header.d=morinfr.org header.i=@morinfr.org header.a=rsa-sha256 header.s=20170427 header.b=vWb4fPEy;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NSaDf9G/Xwl7b+3XUHvNR5VSpgYRF37voCO22C3bBPY=; b=vWb4fPEyE/fV5PmHvEnwxKfQls
	m2ULZ2rYvzhb66+wTq0qPYQ4PPWnRPXH2ycsW094pifv4jKynV4v9x9nLg04pdsR6DYWPLBAdWMRe
	Nuf6eDeeZL1OFGoXWSEM0QkMDejUCIRNkzBgeq14glxbBGkcvQGjZ1xEunxulSOdidlA=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1tJasH-002MXC-22;
	Fri, 06 Dec 2024 17:08:13 +0100
Date: Fri, 6 Dec 2024 17:08:13 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: David Hildenbrand <david@redhat.com>
Cc: Guillaume Morin <guillaume@morinfr.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Eric Hagberg <ehagberg@janestreet.com>
Subject: Re: [PATCH v4] mm/hugetlb: support FOLL_FORCE|FOLL_WRITE
Message-ID: <Z1MhbeS9TxWKOuPX@bender.morinfr.org>
References: <Z1MO5slZh8uWl8LH@bender.morinfr.org>
 <8395af7d-328a-425c-84a7-517e78a602b1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8395af7d-328a-425c-84a7-517e78a602b1@redhat.com>

On 06 Dec 17:03, David Hildenbrand wrote:
>
> On 06.12.24 15:49, Guillaume Morin wrote:
> > Eric reported that PTRACE_POKETEXT fails when applications use hugetlb
> > for mapping text using huge pages. Before commit 1d8d14641fd9
> > ("mm/hugetlb: support write-faults in shared mappings"), PTRACE_POKETEXT
> > worked by accident, but it was buggy and silently ended up mapping pages
> > writable into the page tables even though VM_WRITE was not set.
> > 
> > In general, FOLL_FORCE|FOLL_WRITE does currently not work with hugetlb.
> > Let's implement FOLL_FORCE|FOLL_WRITE properly for hugetlb, such that
> > what used to work in the past by accident now properly works, allowing
> > applications using hugetlb for text etc. to get properly debugged.
> > 
> > This change might also be required to implement uprobes support for
> > hugetlb [1].
> > 
> > [1] https://lore.kernel.org/lkml/ZiK50qob9yl5e0Xz@bender.morinfr.org/
> > 
> > Cc: Muchun Song <muchun.song@linux.dev>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Eric Hagberg <ehagberg@janestreet.com>
> > Signed-off-by: Guillaume Morin <guillaume@morinfr.org>
> > ---
> > Changes in v2:
> >   - Improved commit message
> > Changes in v3:
> >   - Fix potential unitialized mem access in follow_huge_pud
> >   - define pud_soft_dirty when soft dirty is not enabled
> > Changes in v4:
> >   - Remove the soft dirty pud check
> >   - Remove the pud_soft_dirty added in v3
> > 
> >   mm/gup.c     | 95 +++++++++++++++++++++++++---------------------------
> >   mm/hugetlb.c | 20 ++++++-----
> >   2 files changed, 57 insertions(+), 58 deletions(-)
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 746070a1d8bf..63c705ff4162 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -587,6 +587,33 @@ static struct folio *try_grab_folio_fast(struct page *page, int refs,
> >   }
> >   #endif	/* CONFIG_HAVE_GUP_FAST */
> > +/* Common code for can_follow_write_* */
> > +static inline bool can_follow_write_common(struct page *page,
> > +		struct vm_area_struct *vma, unsigned int flags)
> > +{
> > +	/* Maybe FOLL_FORCE is set to override it? */
> > +	if (!(flags & FOLL_FORCE))
> > +		return false;
> > +
> > +	/* But FOLL_FORCE has no effect on shared mappings */
> > +	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
> > +		return false;
> > +
> > +	/* ... or read-only private ones */
> > +	if (!(vma->vm_flags & VM_MAYWRITE))
> > +		return false;
> > +
> > +	/* ... or already writable ones that just need to take a write fault */
> > +	if (vma->vm_flags & VM_WRITE)
> > +		return false;
> > +
> > +	/*
> > +	 * See can_change_pte_writable(): we broke COW and could map the page
> > +	 * writable if we have an exclusive anonymous page ...
> > +	 */
> > +	return page && PageAnon(page) && PageAnonExclusive(page);
> > +}
> > +
> >   static struct page *no_page_table(struct vm_area_struct *vma,
> >   				  unsigned int flags, unsigned long address)
> >   {
> > @@ -613,6 +640,18 @@ static struct page *no_page_table(struct vm_area_struct *vma,
> >   }
> >   #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
> > +/* FOLL_FORCE can write to even unwritable PUDs in COW mappings. */
> > +static inline bool can_follow_write_pud(pud_t pud, struct page *page,
> > +					struct vm_area_struct *vma,
> > +					unsigned int flags)
> > +{
> > +	/* If the pud is writable, we can write to the page. */
> > +	if (pud_write(pud))
> > +		return true;
> > +
> > +	return can_follow_write_common(page, vma, flags);
> > +}
> > +
> >   static struct page *follow_huge_pud(struct vm_area_struct *vma,
> >   				    unsigned long addr, pud_t *pudp,
> >   				    int flags, struct follow_page_context *ctx)
> > @@ -625,13 +664,16 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
> >   	assert_spin_locked(pud_lockptr(mm, pudp));
> > -	if ((flags & FOLL_WRITE) && !pud_write(pud))
> > +	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
> > +	page = pfn_to_page(pfn);
> > +
> > +	if ((flags & FOLL_WRITE) &&
> > +	    !can_follow_write_pud(pud, page, vma, flags))
> >   		return NULL;
> >   	if (!pud_present(pud))
> >   		return NULL;
> > -	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
> 
> That looks wrong. See follow_huge_pmd() for reference
> 
> (1) You must not do a pfn_to_page() before we verified that we have a
>     present PUD.
> 
> (2) can_follow_write_pud() must be called with the first mapped page. It
>     would currently with hugetlb not be strictly required, but is not
>     future proof.
> 
> 
> 
> It must be likely be something like:
> 
> 
> if (!pud_present(pud))
> 	return NULL;
> 
> if ((flags & FOLL_WRITE) &&
>     !can_follow_write_pud(pud, pfn_to_page(pfn), vma, flags))
> 	return NULL;
> 
> pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
> page = pfn_to_page(pfn);
> 
 

Ok, let me fix that.

> >   		delayacct_wpcopy_end();
> >   		return 0;
> > @@ -5943,7 +5944,8 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
> >   	spin_lock(vmf->ptl);
> >   	vmf->pte = hugetlb_walk(vma, vmf->address, huge_page_size(h));
> >   	if (likely(vmf->pte && pte_same(huge_ptep_get(mm, vmf->address, vmf->pte), pte))) {
> > -		pte_t newpte = make_huge_pte(vma, &new_folio->page, !unshare);
> > +		const bool writable = !unshare && (vma->vm_flags & VM_WRITE);
> > +		pte_t newpte = make_huge_pte(vma, &new_folio->page, writable);
> );
> 
> You probably missed my earlier comment. After the recent changes to
> make_huge_pte() that are already in mm/mm-unstable, this hunk can be dropped
> and left unchanged. make_huge_pte() will perform the VM_WRITE check.

Ok, will fix as well

-- 
Guillaume Morin <guillaume@morinfr.org>

