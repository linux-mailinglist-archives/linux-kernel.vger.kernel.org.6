Return-Path: <linux-kernel+bounces-556947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008E1A5D144
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241531756F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBEB264A88;
	Tue, 11 Mar 2025 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvGZFBaT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F01D23F378
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741726683; cv=none; b=DRHFGmIWS6lR62Hbhh8w7PUQQOBd511p5TB4/Uyso9J0ISAnV4ePFmoEjJ4J0X3Zbgk6v9UFCBjjD1vdT8L7F7K8SEwf0RUHT4sdp6yA4a2EcSYiKoIjbdCXWp1aFN04xf/kiR/KtR14/ZjiqwfVVWb8dt6ywbQFMRBgoeQONgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741726683; c=relaxed/simple;
	bh=SK+SYOnBQrPOlVqhunMya7xbfpWHCq0YSwjPq1HLipw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q2gqC65AH8WYM/k6qpFiWW0FIccsWCGxVDjUNyy+UJT78A6/jwrKPAQDKsI2g6pI/W2Im8UP9aKNJZtARCK2bIxdJI9yBKFB9QEDEv2VDK96cSmJCj45c7Cacieo0JNXj5+EzcJW53deNnriSoTB6Llz2kOo0JSSQq620dXBIUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvGZFBaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512ECC4CEE9;
	Tue, 11 Mar 2025 20:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741726683;
	bh=SK+SYOnBQrPOlVqhunMya7xbfpWHCq0YSwjPq1HLipw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LvGZFBaTDTAuVlILLegfdTgXxbCAYYWcB18xC7bc6lZaEze4BXtwxenTVwWWhdLDG
	 xZMEADH2TzQWEj4fygROIVKZDzbWmbnbiFkAXSYlPg7nLnm/s+PYeM8VhFmlCXzXT/
	 jVGcVNn/gHx1oth9nlIj5CSTbrNs5zT3bCUtPkUk2WKcEUByUbsSiQoygf3M0gjkT8
	 t+6oxdJVZQmkZNqmsOQ2KhYViohwpNTzhPSMYmAXRKFgB4l8ebklaFCLdMWeGB61hw
	 +0OmztfrFMCZxYt8lO4tAx83F4sUnlQtjsDFvBaBVCM51TzS3Rfy+6Pih10ZrbXJrF
	 8kVGjKzfdNvfQ==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 6/9] mm/memory: split non-tlb flushing part from zap_page_range_single()
Date: Tue, 11 Mar 2025 13:58:01 -0700
Message-Id: <20250311205801.85356-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <6250fc68-2ce8-43a8-a064-e24877033ce1@lucifer.local>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Mar 2025 12:45:44 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Mon, Mar 10, 2025 at 10:23:15AM -0700, SeongJae Park wrote:
> > Some of zap_page_range_single() callers such as [process_]madvise() with
> > MADV_DONEED[_LOCKED] cannot batch tlb flushes because
> > zap_page_range_single() does tlb flushing for each invocation.  Split
> > out the body of zap_page_range_single() except mmu_gather object
> > initialization and gathered tlb entries flushing parts for such batched
> > tlb flushing usage.
> >
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/memory.c | 36 ++++++++++++++++++++++--------------
> >  1 file changed, 22 insertions(+), 14 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 78c7ee62795e..88c478e2ed1a 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1995,38 +1995,46 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
> >  	mmu_notifier_invalidate_range_end(&range);
> >  }
> >
> > -/**
> > - * zap_page_range_single - remove user pages in a given range
> > - * @vma: vm_area_struct holding the applicable pages
> > - * @address: starting address of pages to zap
> > - * @size: number of bytes to zap
> > - * @details: details of shared cache invalidation
> > - *
> > - * The range must fit into one VMA.
> > - */
> > -void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> > +static void unmap_vma_single(struct mmu_gather *tlb,
> > +		struct vm_area_struct *vma, unsigned long address,
> >  		unsigned long size, struct zap_details *details)
> >  {
> >  	const unsigned long end = address + size;
> >  	struct mmu_notifier_range range;
> > -	struct mmu_gather tlb;
> >
> >  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
> >  				address, end);
> >  	hugetlb_zap_begin(vma, &range.start, &range.end);
> > -	tlb_gather_mmu(&tlb, vma->vm_mm);
> >  	update_hiwater_rss(vma->vm_mm);
> >  	mmu_notifier_invalidate_range_start(&range);
> >  	/*
> >  	 * unmap 'address-end' not 'range.start-range.end' as range
> >  	 * could have been expanded for hugetlb pmd sharing.
> >  	 */
> > -	unmap_single_vma(&tlb, vma, address, end, details, false);
> > +	unmap_single_vma(tlb, vma, address, end, details, false);
> >  	mmu_notifier_invalidate_range_end(&range);
> > -	tlb_finish_mmu(&tlb);
> >  	hugetlb_zap_end(vma, details);
> 
> Previously hugetlb_zap_end() would happen after tlb_finish_mmu(), now it happens
> before?
> 
> This seems like a major problem with this change.

Oh, you're right.  This could re-introduce the racy hugetlb allocation failure
problem that fixed by commit 2820b0f09be9 ("hugetlbfs: close race between
MADV_DONTNEED and page fault").  That is, this patch can make hugetlb
allocation failures increase while MADV_DONTNEED is going on.

Maybe a straightforward fix of the problem is doing hugetlb_zap_end() for all
vmas in a batched manner, similar to that for tlb flush.  For example, add a
list or an array for the vmas in 'struct madvise_behavior', let
'unmap_vma_single()' adds each vma in there, and call hugetlb_zap_end() for
gathered vmas at vector_madvise() or do_madvise().  Does that make sense?

Also Cc-ing Rik, who is the author of the commit 2820b0f09be9 ("hugetlbfs:
close race between MADV_DONTNEED and page fault") for a case that I'm missing
something important.

> If not you need to explain why
> not in the commit message.

I now think it is a problem.  If it turns out I'm wrong, I will of course add
the reason on the commit message.


Thanks,
SJ

[...]

