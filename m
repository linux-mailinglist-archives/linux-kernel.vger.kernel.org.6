Return-Path: <linux-kernel+bounces-241130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CF792775F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9089B22D66
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02521AED4D;
	Thu,  4 Jul 2024 13:44:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF61AED39
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100668; cv=none; b=UHuWVnPyB9k/IiqkByB/MFjaJmyCI95HAdZOeQYUTlI6n/BuLbnipwQY/NSxI5qm5rrJ4j9yyz/+KKRdzSQkRw0dfp5FbTyJPA/ztLYEa6bRDSMOpw/Nh8jHhlf5y6uhh8oo2JRaesbWOmZJfVqypSSPYAvfn6kvTxVZNItRJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100668; c=relaxed/simple;
	bh=IOLw4Ke9P2gvCmPtKCvxwi5KAeia0MwABdV2lhg5nsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSpXPs/0gNBj/Fly22N2NzDs6UNsEbVPGFSSmwDKARP4w97Ng0U/BL/QwuCgtGukLnu1r7sGNmrnFDKCO48YPZvUy1wlzj6Kj4F9+cBgpLWBiC+zINfopQTL5HTDLbLL5OgYlEUFHFK1Ayil7nXpWvnsOw9r63ov40IPelLAJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5024DC3277B;
	Thu,  4 Jul 2024 13:44:26 +0000 (UTC)
Date: Thu, 4 Jul 2024 14:44:23 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: muchun.song@linux.dev, will@kernel.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlbfs: add MTE support
Message-ID: <ZoanN7hkWDBjCTu3@arm.com>
References: <20240625233717.2769975-1-yang@os.amperecomputing.com>
 <ZoPz14fYSqVyvRTw@arm.com>
 <7a4a60af-e471-484b-a4a3-ed31daaca30b@os.amperecomputing.com>
 <546bf8d4-3680-4af3-8d4d-af2d7c192d04@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <546bf8d4-3680-4af3-8d4d-af2d7c192d04@os.amperecomputing.com>

On Tue, Jul 02, 2024 at 05:15:12PM -0700, Yang Shi wrote:
> On 7/2/24 5:04 PM, Yang Shi wrote:
> > On 7/2/24 5:34 AM, Catalin Marinas wrote:
> > > Last time I checked, about a year ago, this was not sufficient. One
> > > issue is that there's no arch_clear_hugetlb_flags() implemented by your
> > > patch, leaving PG_arch_{2,3} set on a page. The other issue was that I
> > > initially tried to do this only on the head page but this did not go
> > > well with the folio_copy() -> copy_highpage() which expects the
> > > PG_arch_* flags on each individual page. The alternative was for
> > > arch_clear_hugetlb_flags() to iterate over all the pages in a folio.
> > 
> > Thanks for pointing this out. I did miss this point. I took a quick look
> > at when the PG_ flags are set. IIUC, it is set by post_alloc_hook() for
> > order-0 anonymous folio (clearing page and tags) and set_ptes() for
> > others (just clear tags), for example, THP and hugetlb.
> > 
> > I can see THP does set the PG_mte_tagged flag for each sub pages. But it
> > seems it does not do it for hugetlb if I read the code correctly. The
> > call path is:
> > 
> > hugetlb_fault() ->
> >   hugetlb_no_page->
> >     set_huge_pte_at ->
> >       __set_ptes() ->
> >         __sync_cache_and_tags() ->
> > 
> > 
> > The __set_ptes() is called in a loop:
> > 
> > if (!pte_present(pte)) {
> >         for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
> >             __set_ptes(mm, addr, ptep, pte, 1);
> >         return;
> >     }
> > 
> > The ncontig and pgsize are returned by num_contig_ptes(). For example,
> > 2M hugetlb, ncontig is 1 and pgsize is 2M IIUC. So it means actually
> > just the head page has PG_mte_tagged set. If so the copy_highpage() will
> > just copy the old head page's flag to the new head page, and the tag.
> > All the sub pages don't have PG_mte_tagged set.
> > 
> > Is it expected behavior? I'm supposed we need tags for every sub pages
> > too, right?
> 
> We should need something like the below to have tags and page flag set up
> for each sub page:
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 3f09ac73cce3..528164deef27 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -228,9 +228,12 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned
> long addr,
>         int ncontig;
>         unsigned long pfn, dpfn;
>         pgprot_t hugeprot;
> +       unsigned long nr = sz >> PAGE_SHIFT;
> 
>         ncontig = num_contig_ptes(sz, &pgsize);
> 
> +       __sync_cache_and_tags(pte, nr);
> +
>         if (!pte_present(pte)) {
>                 for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
>                         __set_ptes(mm, addr, ptep, pte, 1);

We only need this for the last loop when we have a present pte. I'd also
avoid calling __set_ptes(...., 1) if we call the __sync_cache_and_tags()
here already. Basically just unroll __set_ptes() in set_huge_pte_at()
and call __set_pte() directly.

It might be better to convert those page flag checks to only happen on
the head page. My stashed changes from over a year ago (before we had
more folio conversions) below. However, as I mentioned, I got stuck on
folio_copy() which also does a cond_resched() between copy_highpage().

---------8<--------------------------------
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index f5bcb0dc6267..a84ad0e46f12 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -49,7 +49,9 @@ static void mte_sync_page_tags(struct page *page, pte_t old_pte,
 		return;
 
 	if (try_page_mte_tagging(page)) {
-		mte_clear_page_tags(page_address(page));
+		unsigned long i, nr_pages = compound_nr(page);
+		for (i = 0; i < nr_pages; i++)
+			mte_clear_page_tags(page_address(page + i));
 		set_page_mte_tagged(page);
 	}
 }
@@ -57,22 +59,23 @@ static void mte_sync_page_tags(struct page *page, pte_t old_pte,
 void mte_sync_tags(pte_t old_pte, pte_t pte)
 {
 	struct page *page = pte_page(pte);
-	long i, nr_pages = compound_nr(page);
-	bool check_swap = nr_pages == 1;
+	bool check_swap = !PageCompound(page);
 	bool pte_is_tagged = pte_tagged(pte);
 
 	/* Early out if there's nothing to do */
 	if (!check_swap && !pte_is_tagged)
 		return;
 
+	/*
+	 * HugeTLB pages are always fully mapped, so only setting head page's
+	 * PG_mte_* flags is enough.
+	 */
+	if (PageHuge(page))
+		page = compound_head(page);
+
 	/* if PG_mte_tagged is set, tags have already been initialised */
-	for (i = 0; i < nr_pages; i++, page++) {
-		if (!page_mte_tagged(page)) {
-			mte_sync_page_tags(page, old_pte, check_swap,
-					   pte_is_tagged);
-			set_page_mte_tagged(page);
-		}
-	}
+	if (!page_mte_tagged(page))
+		mte_sync_page_tags(page, old_pte, check_swap, pte_is_tagged);
 
 	/* ensure the tags are visible before the PTE is set */
 	smp_wmb();
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 5626ddb540ce..692198d8c0d2 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -1079,7 +1079,7 @@ long kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 
 			/* uaccess failed, don't leave stale tags */
 			if (num_tags != MTE_GRANULES_PER_PAGE)
-				mte_clear_page_tags(page);
+				mte_clear_page_tags(page_address(page));
 			set_page_mte_tagged(page);
 
 			kvm_release_pfn_dirty(pfn);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 31d7fa4c7c14..b531b1d75cda 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1173,11 +1173,10 @@ static void sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
 	if (!kvm_has_mte(kvm))
 		return;
 
-	for (i = 0; i < nr_pages; i++, page++) {
-		if (try_page_mte_tagging(page)) {
-			mte_clear_page_tags(page_address(page));
-			set_page_mte_tagged(page);
-		}
+	if (try_page_mte_tagging(page)) {
+		for (i = 0; i < nr_pages; i++)
+			mte_clear_page_tags(page_address(page + i));
+		set_page_mte_tagged(page);
 	}
 }
 

-- 
Catalin

