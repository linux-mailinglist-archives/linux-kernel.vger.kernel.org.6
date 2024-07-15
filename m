Return-Path: <linux-kernel+bounces-252687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979839316CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C421F22EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE3618EFD6;
	Mon, 15 Jul 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X77QxZ/m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7418EFD4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053808; cv=none; b=hUSMlXdM88nhDqMJMt9D67swOy4zrsldOwt/f6ny7JgJxhYS4oMIODczlEMXYYIyYE6TEHD1YRMaWbEAoRuEErVnazVicIvbpGu6u+DvJ+F2mV15C5QCaKU8RW/CGGNTFXS4615pPKySMu/q2XBsAlPmRdUa1HGBDmp2E69vNLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053808; c=relaxed/simple;
	bh=vRDeQBPl2HWhJ2vQpqTPJ2TiX9RuozeXWLNsZa8aj4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N++rNfJIebW5uKlYIpGMi4P3UoM7KTnyvJkZua+fSW01YPEOcn3S9sZrLXubJH8I/7ICQHOM1meCrWw2WiWweebF1llwjox0d+dLWblnhdXDhBN5gmv5l19MXMDiO+oPE7aVL9NwuCZJ3v5E7imNb1OB2GRGLD2sWPhwo4W0dts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X77QxZ/m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721053805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hE27kCNNoTECqXxKQzCfQDUL6DEdnR6uNqGY9T0xVUs=;
	b=X77QxZ/mRvgiXra2nLuCg+P3v10qN6j8Zknjnf+mP7asIfdPor1Y/fiMXK8n1E3nXL55Ko
	wm4OttNKkOAVHStxeqRzPf8cJt7AcWL4YeoFipFxluWbtMotf5I/WVahsTSU960x6PGoL8
	JwrwdFqwVfrqOqOZiKAdM4ce15o5g7A=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-YAKIjczZPFuxTi2uPmTZWQ-1; Mon, 15 Jul 2024 10:30:03 -0400
X-MC-Unique: YAKIjczZPFuxTi2uPmTZWQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-65c66c8540aso834307b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053803; x=1721658603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hE27kCNNoTECqXxKQzCfQDUL6DEdnR6uNqGY9T0xVUs=;
        b=Ifg2R9RKN+RaBrvWLKHNdv2oltZo4f6GsInPkHDuxBqq56+OA4TQ2FzBiNRORKjsdl
         GUIWDzRywQO/fEIH5hcWOntMXVMBez6TWf1JYLLq3E6HfZ10Pr9ORPkdcE9dxTJOLfjd
         Y66aHynP/5FCB2EiC5DCygiiK7qxkOKLf93H2Y/14FVv1R3qTSUnQMBVUG5H1MTioMOB
         8EQvp1r4aiSPhOxyP5ZX6LPFioS1Uc4YYxb1Tt4j7FGFNFRx/5YyyvngI00PvqLQISYq
         RrNvNqVIt4wAUTaAVzgeka8YXeSe9ETuhQxC1YlpTCWcBWn/v/YMptIqaDApPOmJtUit
         YtFg==
X-Gm-Message-State: AOJu0Ywuq2skmufmFmuzbx7Wjq9p2czF+XVrOSLVUk/z2lv2atmnz8UF
	Gn3pUlxHlL3LZ7Oiy3SaXLt5Zv1hrzVRvZ6YRi8f5Aan4JQZO8qA+OM0BznP7EW+EY8xRtiwoF4
	YkJqA/mpYDu/D1smbqC+0R1F4USpRyGO7WyeIomfLW+YMmGIYtqzAhWXYooxNOg==
X-Received: by 2002:a05:690c:7241:b0:627:a1d9:9665 with SMTP id 00721157ae682-65ca8a12551mr84674387b3.2.1721053803142;
        Mon, 15 Jul 2024 07:30:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlhG26ohilGxMChNc+yj/ht5zjp6PEFzHfGUqFvb9KcgwWhYLqCMlM1mktr4cE+OGMtER5gw==
X-Received: by 2002:a05:690c:7241:b0:627:a1d9:9665 with SMTP id 00721157ae682-65ca8a12551mr84673867b3.2.1721053802527;
        Mon, 15 Jul 2024 07:30:02 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160c6418dsm204018485a.92.2024.07.15.07.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:30:02 -0700 (PDT)
Date: Mon, 15 Jul 2024 10:29:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"Kirill A . Shutemov" <kirill@shutemov.name>, x86@kernel.org,
	Kevin Tian <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>,
	David Hildenbrand <david@redhat.com>, David Wang <00107082@163.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <ZpUyZ9bH1-f5y5XG@x1n>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <ZpTLCscCFGtsrEjC@yzhao56-desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZpTLCscCFGtsrEjC@yzhao56-desk>

On Mon, Jul 15, 2024 at 03:08:58PM +0800, Yan Zhao wrote:
> On Fri, Jul 12, 2024 at 10:42:44AM -0400, Peter Xu wrote:
> > This patch is one patch of an old series [1] that got reposted standalone
> > here, with the hope to fix some reported untrack_pfn() issues reported
> > recently [2,3], where there used to be other fix [4] but unfortunately
> > which looks like to cause other issues.  The hope is this patch can fix it
> > the right way.
> > 
> > X86 uses pfn tracking to do pfnmaps.  AFAICT, the tracking should normally
> > start at mmap() of device drivers, then untracked when munmap().  However
> > in the current code the untrack is done in unmap_single_vma().  This might
> > be problematic.
> > 
> > For example, unmap_single_vma() can be used nowadays even for zapping a
> > single page rather than the whole vmas.  It's very confusing to do whole
> > vma untracking in this function even if a caller would like to zap one
> > page.  It could simply be wrong.
> > 
> > Such issue won't be exposed by things like MADV_DONTNEED won't ever work
> > for pfnmaps and it'll fail the madvise() already before reaching here.
> > However looks like it can be triggered like what was reported where invoked
> > from an unmap request from a file vma.
> > 
> > There's also work [5] on VFIO (merged now) to allow tearing down MMIO
> > pgtables before an munmap(), in which case we may not want to untrack the
> > pfns if we're only tearing down the pgtables.  IOW, we may want to keep the
> > pfn tracking information as those pfn mappings can be restored later with
> > the same vma object.  Currently it's not an immediate problem for VFIO, as
> > VFIO uses UC- by default, but it looks like there's plan to extend that in
> > the near future.
> > 
> > IIUC, this was overlooked when zap_page_range_single() was introduced,
> > while in the past it was only used in the munmap() path which wants to
> > always unmap the region completely.  E.g., commit f5cc4eef9987 ("VM: make
> > zap_page_range() callers that act on a single VMA use separate helper") is
> > the initial commit that introduced unmap_single_vma(), in which the chunk
> > of untrack_pfn() was moved over from unmap_vmas().
> > 
> > Recover that behavior to untrack pfnmap only when unmap regions.
> > 
> > [1] https://lore.kernel.org/r/20240523223745.395337-1-peterx@redhat.com
> > [2] https://groups.google.com/g/syzkaller-bugs/c/FeQZvSbqWbQ/m/tHFmoZthAAAJ
> > [3] https://lore.kernel.org/r/20240712131931.20207-1-00107082@163.com
> > [4] https://lore.kernel.org/all/20240710-bug12-v1-1-0e5440f9b8d3@gmail.com/
> > [5] https://lore.kernel.org/r/20240523195629.218043-1-alex.williamson@redhat.com
> > 
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Kirill A. Shutemov <kirill@shutemov.name>
> > Cc: x86@kernel.org
> > Cc: Yan Zhao <yan.y.zhao@intel.com>
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Cc: Pei Li <peili.dev@gmail.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: David Wang <00107082@163.com>
> > Cc: Bert Karwatzki <spasswolf@web.de>
> > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > 
> > NOTE: I massaged the commit message comparing to the rfc post [1], the
> > patch itself is untouched.  Also removed rfc tag, and added more people
> > into the loop. Please kindly help test this patch if you have a reproducer,
> > as I can't reproduce it myself even with the syzbot reproducer on top of
> > mm-unstable.  Instead of further check on the reproducer, I decided to send
> > this out first as we have a bunch of reproducers on the list now..
> > ---
> >  mm/memory.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 4bcd79619574..f57cc304b318 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1827,9 +1827,6 @@ static void unmap_single_vma(struct mmu_gather *tlb,
> >  	if (vma->vm_file)
> >  		uprobe_munmap(vma, start, end);
> >  
> > -	if (unlikely(vma->vm_flags & VM_PFNMAP))
> > -		untrack_pfn(vma, 0, 0, mm_wr_locked);
> > -
> Specifically to VFIO's case, looks it doesn't matter if untrack_pfn() is
> called here, since remap_pfn_range() is not called in mmap() and fault
> handler, and therefore (vma->vm_flags & VM_PAT) is always 0.

Right when with current repo, but I'm thinking maybe we should have VM_PAT
there..

See what reserve_pfn_range() does right now: it'll make sure only one owner
reserve this area, e.g. memtype_reserve() will fail if it has already been
reserved.  Then when succeeded as the first one to reserve the region,
it'll make sure this mem type to also be synchronized to the kernel map
(memtype_kernel_map_sync).

So I feel like when MMIO disabled for a VFIO card, we may need to call
reserve_pfn_range(), telling the kernel the mem type VFIO uses, even if the
pgtable will be empty, and even if currently it's always UC- for now:

vfio_pci_core_mmap():
	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

Then the memtype will be reserved even if it cannot be used.  Otherwise I
don't know whether there's side effects of kernel identity mapping where it
mismatch later with what's mapped in the userspace via the vma, when MMIO
got enabled again: pgtable started to be injected with a different memtype
that specified only in the vma's pgprot.

> 
> >  	if (start != end) {
> >  		if (unlikely(is_vm_hugetlb_page(vma))) {
> >  			/*
> > @@ -1894,6 +1891,8 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
> >  		unsigned long start = start_addr;
> >  		unsigned long end = end_addr;
> >  		hugetlb_zap_begin(vma, &start, &end);
> > +		if (unlikely(vma->vm_flags & VM_PFNMAP))
> > +			untrack_pfn(vma, 0, 0, mm_wr_locked);
> Same here.
> 
> >  		unmap_single_vma(tlb, vma, start, end, &details,
> >  				 mm_wr_locked);
> >  		hugetlb_zap_end(vma, &details);
> > -- 
> > 2.45.0
> > 
> 

-- 
Peter Xu


