Return-Path: <linux-kernel+bounces-254312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AF19331A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3352836EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B771A072D;
	Tue, 16 Jul 2024 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0INCD+B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051D319E83D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156520; cv=none; b=GYRPaRvtZTJXYZMIQhrpRqgpMb4BY0bd1ojx68x35kF9GN26O1YPcSWqtD2OTyR/H25rNHD/alaiMp4xBMjc+O4+lJ9vGAo1Yv47Lgip1phDbNRdKh3hb0ToH9m/wjPYWG+M9Nnf+0GVOQm4pEZxqAMJhpjD4TECWVH4AGmh4sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156520; c=relaxed/simple;
	bh=p7rkuuVnIEuo4Q778VnpFaf5w84b/7By9V6tfDrGWjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXwDOdqJ2leW2WJ3HL28wlTexctWx9X0mF7IAASVfGgGwo9+K2ZB5KdA06ayboleWxFf5S00bFKZpnyBCVmXmUq+qfE/vGhKXIFnQh+NXFZb+O9ceEPJk/gjGHtM2r6YblL6Ho9vekvQccyBcFB0Mru7o8ULgyuehR5H0eigpdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0INCD+B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721156516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcYHHlg5fx3Cb0ytsohRRyGcvg4CjT5/itwmV+qR6D0=;
	b=L0INCD+B5vVi2xRFmq6Fy7W+T5BNxJdx7XuPOvWgsULQ0IvK9caONI6ap7BHD1H4ht4nOj
	rKeZA7k4fPO7fYzvFctvnxPTgT/764MZTnbk+jdcvbLBW9lIFF5TJMP7vIqW5glf/qLmgr
	3dKYdc2cBmrB0wwKkZ8iX2sDIEGBdI0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634--1n7Up4_NOuNxlEXY_tMpg-1; Tue, 16 Jul 2024 15:01:55 -0400
X-MC-Unique: -1n7Up4_NOuNxlEXY_tMpg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-44945f42a7fso11059731cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156515; x=1721761315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcYHHlg5fx3Cb0ytsohRRyGcvg4CjT5/itwmV+qR6D0=;
        b=YCZ/8KKYOMY81KzqtP9Vhi2YgdmcV/BBGs0JDnYJYFBJiWPnNsdHC6+1oqVwh7i42R
         cMqV2L7LF+Vzmj3NP86g/ncmPtxy2I9uhWJIWsHqMDYCLQebgRNPjALXnIVFvz0Png0O
         hs+jCdOSgGQpx+0inSu9H12x26Os1lQ4uoRTR5XALjhNixnhpldvsoY6f6D2Mwzz/JbW
         R1vzNyQiBS8IB9aHmBINNppqFbn7gE9uoNtMinF+UQB3JexdhB5cAY64oWUT2GICc7RZ
         yKRv3APON71FKTj7qRKvMPGjFeBueykA1JPZV+6vdQ+/bYDUFNcwLMwGfgMT7rC9bhsX
         v4iQ==
X-Gm-Message-State: AOJu0Yx1GcrRpxHjNXHblAsDzMd7ay0Xgb9ZfHwLcIh8On9j8jlbixxT
	bkl/EMgBvvMa6S6GRULVkOXTtaX6zfc9bcz6vXmdtAly5OpSN5oHXUZCMU06UoALHr3DBATuufL
	1C51cwnE5fQ18ZHjBo/CvK2Hnyij2fYXoIZdBHhDkfXDySPEtD3t19LChybhgCQ==
X-Received: by 2002:a05:620a:46a7:b0:79d:595b:d4ea with SMTP id af79cd13be357-7a179f15aa8mr307764785a.2.1721156514744;
        Tue, 16 Jul 2024 12:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOzvMR5tbj+oFC3kdKi/Z+6CGo9jm2FxkGsW2GFU+DmGvAarOMuuX7Ftf95fm/up+VVG8a3A==
X-Received: by 2002:a05:620a:46a7:b0:79d:595b:d4ea with SMTP id af79cd13be357-7a179f15aa8mr307761785a.2.1721156514279;
        Tue, 16 Jul 2024 12:01:54 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160b92a4asm320843085a.12.2024.07.16.12.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 12:01:53 -0700 (PDT)
Date: Tue, 16 Jul 2024 15:01:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"x86@kernel.org" <x86@kernel.org>,
	"Tian, Kevin" <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>,
	David Hildenbrand <david@redhat.com>, David Wang <00107082@163.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <ZpbDnoQxGubegtu-@x1n>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <ZpTLCscCFGtsrEjC@yzhao56-desk>
 <ZpUyZ9bH1-f5y5XG@x1n>
 <ZpY5uU2NyOoMVu5A@yzhao56-desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZpY5uU2NyOoMVu5A@yzhao56-desk>

On Tue, Jul 16, 2024 at 05:13:29PM +0800, Yan Zhao wrote:
> On Mon, Jul 15, 2024 at 10:29:59PM +0800, Peter Xu wrote:
> > On Mon, Jul 15, 2024 at 03:08:58PM +0800, Yan Zhao wrote:
> > > On Fri, Jul 12, 2024 at 10:42:44AM -0400, Peter Xu wrote:
> > > > This patch is one patch of an old series [1] that got reposted standalone
> > > > here, with the hope to fix some reported untrack_pfn() issues reported
> > > > recently [2,3], where there used to be other fix [4] but unfortunately
> > > > which looks like to cause other issues.  The hope is this patch can fix it
> > > > the right way.
> > > > 
> > > > X86 uses pfn tracking to do pfnmaps.  AFAICT, the tracking should normally
> > > > start at mmap() of device drivers, then untracked when munmap().  However
> > > > in the current code the untrack is done in unmap_single_vma().  This might
> > > > be problematic.
> > > > 
> > > > For example, unmap_single_vma() can be used nowadays even for zapping a
> > > > single page rather than the whole vmas.  It's very confusing to do whole
> > > > vma untracking in this function even if a caller would like to zap one
> > > > page.  It could simply be wrong.
> > > > 
> > > > Such issue won't be exposed by things like MADV_DONTNEED won't ever work
> > > > for pfnmaps and it'll fail the madvise() already before reaching here.
> > > > However looks like it can be triggered like what was reported where invoked
> > > > from an unmap request from a file vma.
> > > > 
> > > > There's also work [5] on VFIO (merged now) to allow tearing down MMIO
> > > > pgtables before an munmap(), in which case we may not want to untrack the
> > > > pfns if we're only tearing down the pgtables.  IOW, we may want to keep the
> > > > pfn tracking information as those pfn mappings can be restored later with
> > > > the same vma object.  Currently it's not an immediate problem for VFIO, as
> > > > VFIO uses UC- by default, but it looks like there's plan to extend that in
> > > > the near future.
> > > > 
> > > > IIUC, this was overlooked when zap_page_range_single() was introduced,
> > > > while in the past it was only used in the munmap() path which wants to
> > > > always unmap the region completely.  E.g., commit f5cc4eef9987 ("VM: make
> > > > zap_page_range() callers that act on a single VMA use separate helper") is
> > > > the initial commit that introduced unmap_single_vma(), in which the chunk
> > > > of untrack_pfn() was moved over from unmap_vmas().
> > > > 
> > > > Recover that behavior to untrack pfnmap only when unmap regions.
> > > > 
> > > > [1] https://lore.kernel.org/r/20240523223745.395337-1-peterx@redhat.com
> > > > [2] https://groups.google.com/g/syzkaller-bugs/c/FeQZvSbqWbQ/m/tHFmoZthAAAJ
> > > > [3] https://lore.kernel.org/r/20240712131931.20207-1-00107082@163.com
> > > > [4] https://lore.kernel.org/all/20240710-bug12-v1-1-0e5440f9b8d3@gmail.com/
> > > > [5] https://lore.kernel.org/r/20240523195629.218043-1-alex.williamson@redhat.com
> > > > 
> > > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > Cc: Kirill A. Shutemov <kirill@shutemov.name>
> > > > Cc: x86@kernel.org
> > > > Cc: Yan Zhao <yan.y.zhao@intel.com>
> > > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > > Cc: Pei Li <peili.dev@gmail.com>
> > > > Cc: David Hildenbrand <david@redhat.com>
> > > > Cc: David Wang <00107082@163.com>
> > > > Cc: Bert Karwatzki <spasswolf@web.de>
> > > > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > > 
> > > > NOTE: I massaged the commit message comparing to the rfc post [1], the
> > > > patch itself is untouched.  Also removed rfc tag, and added more people
> > > > into the loop. Please kindly help test this patch if you have a reproducer,
> > > > as I can't reproduce it myself even with the syzbot reproducer on top of
> > > > mm-unstable.  Instead of further check on the reproducer, I decided to send
> > > > this out first as we have a bunch of reproducers on the list now..
> > > > ---
> > > >  mm/memory.c | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > index 4bcd79619574..f57cc304b318 100644
> > > > --- a/mm/memory.c
> > > > +++ b/mm/memory.c
> > > > @@ -1827,9 +1827,6 @@ static void unmap_single_vma(struct mmu_gather *tlb,
> > > >  	if (vma->vm_file)
> > > >  		uprobe_munmap(vma, start, end);
> > > >  
> > > > -	if (unlikely(vma->vm_flags & VM_PFNMAP))
> > > > -		untrack_pfn(vma, 0, 0, mm_wr_locked);
> > > > -
> > > Specifically to VFIO's case, looks it doesn't matter if untrack_pfn() is
> > > called here, since remap_pfn_range() is not called in mmap() and fault
> > > handler, and therefore (vma->vm_flags & VM_PAT) is always 0.
> > 
> > Right when with current repo, but I'm thinking maybe we should have VM_PAT
> > there..
> Yes, I agree.
> 
> But, currently for VFIO, it cannot call io_remap_pfn_range() in the fault
> handler since vm_flags_set() requires mmap lock held for write while
> the fault handler can only hold mmap lock for read.
> So, it relies on ioremap()/iounmap() to reserve/de-reserve memtypes,
> without VM_PAT being set in vma.

Right, neither vm_flags_set() nor io_remap_pfn_range() should be called in
a fault handler.  They should only be called in mmap() phase.

When you mentioned ioremap(), it's only for the VGA device, right?  I don't
see it's used in the vfio-pci's fault handler.

> 
> > 
> > See what reserve_pfn_range() does right now: it'll make sure only one owner
> > reserve this area, e.g. memtype_reserve() will fail if it has already been
> > reserved.  Then when succeeded as the first one to reserve the region,
> > it'll make sure this mem type to also be synchronized to the kernel map
> > (memtype_kernel_map_sync).
> > 
> > So I feel like when MMIO disabled for a VFIO card, we may need to call
> > reserve_pfn_range(), telling the kernel the mem type VFIO uses, even if the
> > pgtable will be empty, and even if currently it's always UC- for now:
> > 
> > vfio_pci_core_mmap():
> > 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > 
> > Then the memtype will be reserved even if it cannot be used.  Otherwise I
> > don't know whether there's side effects of kernel identity mapping where it
> > mismatch later with what's mapped in the userspace via the vma, when MMIO
> > got enabled again: pgtable started to be injected with a different memtype
> > that specified only in the vma's pgprot.
> Current VFIO relies on pci_iomap() to reserve MMIO pfns as UC-, thus
> no VM_PAT in vmas.
>  
> Calling remap_pfn_range() in the mmap() will cause problem to support
> dynamic faulting. Looks there's still a window even with an immediate
> unmap after mmap().

It can be conditionally injected.  See Alex's commit (not yet posted
anywhere, only used in our internal testing so far):

https://github.com/xzpeter/linux/commit/f432e0e46c34e493943034be4cb9d6eb638f57d1

> 
> Also, calling remap_pfn_range() in mmap() may not meet the requirement of
> drivers to dynamic switch backend resources, e.g. as what's in
> cxl_mmap_fault(), since one remap_pfn_range() cannot reserve memtypes for
> all backend resources at once.
> 
> So, is there any way for the driver to reserve memtypes and set VM_PAT in
> fault handler?

I must confess I'm not familiar with memtype stuff, and just started
looking recently.

Per my reading so far, we have these multiple ways of doing memtype
reservations, and no matter which API we use (ioremap / track_pfn_remap /
pci_iomap), the same memtype needs to be used otherwise the reservation
will fail.  Here ioremap / pci_iomap will involve one more vmap so that the
virtual mapping will present already after the API returns.

Then here IMHO track_pfn_remap() is the one that we should still use in
page-level mmap() controls, because so far we don't want to map any MMIO
range yet, however we want to say "hey this VMA maps something special", by
reserving these memtype and set VM_PAT.  We want the virtual mapping only
later during a fault().

In short, it looks to me the right thing we should do is to manually invoke
track_pfn_remap() in vfio-pci's mmap() hook.

	if (!vdev->pm_runtime_engaged && __vfio_pci_memory_enabled(vdev))
		ret = remap_pfn_range(vma, vma->vm_start, pfn,
				      req_len, vma->vm_page_prot);
	else
                // TODO: manually invoke track_pfn_remap() here
		vm_flags_set(vma, VM_IO | VM_PFNMAP |
				  VM_DONTEXPAND | VM_DONTDUMP);

Then the vma is registered, and untrack_pfn() should be automatically done
when vma unmaps (and that relies on this patch to not do that too early).
From that POV, I still think this patch does the right thing and should be
merged, even if we probably have one more issue to fix as David Wang
reported..

I'll need to think about how to do that right, as I think that'll be needed
as long as pfnmaps will support fault()s: it means when munmap() the
pgtable may not present, and PAT cannot rely on walking the pgtable to know
the base PFN anymore.

Thanks,

-- 
Peter Xu


