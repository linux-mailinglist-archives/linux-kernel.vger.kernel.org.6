Return-Path: <linux-kernel+bounces-255271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5119B933E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4EBB2159F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B5F17F37E;
	Wed, 17 Jul 2024 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghhwTmoh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19F17F36E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721225733; cv=none; b=X641Ry+7oLkQWhko70/LE5EFtUrsiPln6wSDBv7TihMMd52Ks1ZzIPBKK7EUQ8StXJGS8eyQHUrbc6HvewZVmPYGmWd0becZUUrPTkNMDByeKVpYmCpq7/MvJAOtR4MyOgaEZ5dMF/Vj78tgedXjAWP4GsvW1sMX6eUsCBwc2NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721225733; c=relaxed/simple;
	bh=ZIEMY0Mzi9eGNd9FzSGdcCcGtzqwKdjIo+90o2UkayI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOaEGTnBOMtVgyW/OK+G5NUKs8f47zeBrsQOFmePKQpJYSBSoiaeF8K7anTomFBy7jCrFXCicFD7A07myhvTGZT552nj6f/07vXyrRvCK4QXhV9ehYdW4LlIO86z0MenUwTUi2y5WueHDXnw+gkh4Vzai4GjW2CqpgSkRtI6fB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghhwTmoh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721225730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXQeX8Qk8lUZnYDevLFdRtA6b9n0o4qNfnEDKf/jSVY=;
	b=ghhwTmohSESUBvpAzoj9+tJDUscIfSxRnbrnwYmRHw8WIZiDTdTsrXM+bt2eQsYopwWMQz
	Q7FsoSx6sZILeQwT1tQfTxmZHiNkOw45p77OoL+jg3DHbVyH52v7QekwmlpbYnNudpfqiB
	7HjkxvhLVIGZmVZIlS5s/ApNDKA9qrc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-WpJp4Tm6PNG8yyvyA6XjCg-1; Wed, 17 Jul 2024 10:15:28 -0400
X-MC-Unique: WpJp4Tm6PNG8yyvyA6XjCg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a1437d5afeso18706685a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721225728; x=1721830528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXQeX8Qk8lUZnYDevLFdRtA6b9n0o4qNfnEDKf/jSVY=;
        b=IRObB8+4cjvV4T9aD+P3Jvcf65C83LopHnErRszpPLUydFeyDEqnt4cSOv7a+OZpXS
         CrvunwEAzRoWRC9f+JekvVUbUu8xQgRY1tVps1oDmWjSOegawJPiYi/oGgskw1vamyJk
         thVksPp5Yjqax8MT6dvVPHof+SL5AbTCZPzpbPko8tb0fk7urPNqj+UxrJHR11t/O0NQ
         vPxtLL6ibF2XmnOrfBQr5DKjxSSO4BzQwL/lv5DrJD9btVsfJanheLolNlsuFJA9/EOb
         T9FOvDI8wJQZMIKP3K/en4Z0hFsXJzF4NPp+0cFdvIxbMPoC/wVn+gKpQzaElVqhR3dQ
         lPsw==
X-Gm-Message-State: AOJu0YyMPNXalI1bbehXl0JLHkWC46U/Ds4jRkBaafLys4wxrtMOo0XT
	I2Yv5t235A0WxMKhCL+wFLdCWd9bNYdI6YQyMs/LidPVf2MNIlHu8KsI3SivIsmSRlc/STIU/kM
	/txmuLHPN1rOR7RUAAP4oqbfKaRup3pgUBkVN41dSp4sdjhkYcUQg8EUCPR33MQ==
X-Received: by 2002:a05:620a:4151:b0:79e:fc87:b4fe with SMTP id af79cd13be357-7a187421448mr117806885a.1.1721225728029;
        Wed, 17 Jul 2024 07:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0HAnXSRTkAEbuW2uSdlrcmqCuOQ25HGgYGVOppwIg94eSab5lmYdAjiorePj+Oy6WT7B5AA==
X-Received: by 2002:a05:620a:4151:b0:79e:fc87:b4fe with SMTP id af79cd13be357-7a187421448mr117803685a.1.1721225727455;
        Wed, 17 Jul 2024 07:15:27 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160be34a2sm400369885a.59.2024.07.17.07.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 07:15:26 -0700 (PDT)
Date: Wed, 17 Jul 2024 10:15:24 -0400
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
Message-ID: <ZpfR_L9wtuXhtSGk@x1n>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <ZpTLCscCFGtsrEjC@yzhao56-desk>
 <ZpUyZ9bH1-f5y5XG@x1n>
 <ZpY5uU2NyOoMVu5A@yzhao56-desk>
 <ZpbDnoQxGubegtu-@x1n>
 <Zpcgmk6wexTKVv2E@yzhao56-desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zpcgmk6wexTKVv2E@yzhao56-desk>

On Wed, Jul 17, 2024 at 09:38:34AM +0800, Yan Zhao wrote:
> On Tue, Jul 16, 2024 at 03:01:50PM -0400, Peter Xu wrote:
> > On Tue, Jul 16, 2024 at 05:13:29PM +0800, Yan Zhao wrote:
> > > On Mon, Jul 15, 2024 at 10:29:59PM +0800, Peter Xu wrote:
> > > > On Mon, Jul 15, 2024 at 03:08:58PM +0800, Yan Zhao wrote:
> > > > > On Fri, Jul 12, 2024 at 10:42:44AM -0400, Peter Xu wrote:
> > > > > > This patch is one patch of an old series [1] that got reposted standalone
> > > > > > here, with the hope to fix some reported untrack_pfn() issues reported
> > > > > > recently [2,3], where there used to be other fix [4] but unfortunately
> > > > > > which looks like to cause other issues.  The hope is this patch can fix it
> > > > > > the right way.
> > > > > > 
> > > > > > X86 uses pfn tracking to do pfnmaps.  AFAICT, the tracking should normally
> > > > > > start at mmap() of device drivers, then untracked when munmap().  However
> > > > > > in the current code the untrack is done in unmap_single_vma().  This might
> > > > > > be problematic.
> > > > > > 
> > > > > > For example, unmap_single_vma() can be used nowadays even for zapping a
> > > > > > single page rather than the whole vmas.  It's very confusing to do whole
> > > > > > vma untracking in this function even if a caller would like to zap one
> > > > > > page.  It could simply be wrong.
> > > > > > 
> > > > > > Such issue won't be exposed by things like MADV_DONTNEED won't ever work
> > > > > > for pfnmaps and it'll fail the madvise() already before reaching here.
> > > > > > However looks like it can be triggered like what was reported where invoked
> > > > > > from an unmap request from a file vma.
> > > > > > 
> > > > > > There's also work [5] on VFIO (merged now) to allow tearing down MMIO
> > > > > > pgtables before an munmap(), in which case we may not want to untrack the
> > > > > > pfns if we're only tearing down the pgtables.  IOW, we may want to keep the
> > > > > > pfn tracking information as those pfn mappings can be restored later with
> > > > > > the same vma object.  Currently it's not an immediate problem for VFIO, as
> > > > > > VFIO uses UC- by default, but it looks like there's plan to extend that in
> > > > > > the near future.
> > > > > > 
> > > > > > IIUC, this was overlooked when zap_page_range_single() was introduced,
> > > > > > while in the past it was only used in the munmap() path which wants to
> > > > > > always unmap the region completely.  E.g., commit f5cc4eef9987 ("VM: make
> > > > > > zap_page_range() callers that act on a single VMA use separate helper") is
> > > > > > the initial commit that introduced unmap_single_vma(), in which the chunk
> > > > > > of untrack_pfn() was moved over from unmap_vmas().
> > > > > > 
> > > > > > Recover that behavior to untrack pfnmap only when unmap regions.
> > > > > > 
> > > > > > [1] https://lore.kernel.org/r/20240523223745.395337-1-peterx@redhat.com
> > > > > > [2] https://groups.google.com/g/syzkaller-bugs/c/FeQZvSbqWbQ/m/tHFmoZthAAAJ
> > > > > > [3] https://lore.kernel.org/r/20240712131931.20207-1-00107082@163.com
> > > > > > [4] https://lore.kernel.org/all/20240710-bug12-v1-1-0e5440f9b8d3@gmail.com/
> > > > > > [5] https://lore.kernel.org/r/20240523195629.218043-1-alex.williamson@redhat.com
> > > > > > 
> > > > > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > > > > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > > > > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > > > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > > > Cc: Kirill A. Shutemov <kirill@shutemov.name>
> > > > > > Cc: x86@kernel.org
> > > > > > Cc: Yan Zhao <yan.y.zhao@intel.com>
> > > > > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > > > > Cc: Pei Li <peili.dev@gmail.com>
> > > > > > Cc: David Hildenbrand <david@redhat.com>
> > > > > > Cc: David Wang <00107082@163.com>
> > > > > > Cc: Bert Karwatzki <spasswolf@web.de>
> > > > > > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > > ---
> > > > > > 
> > > > > > NOTE: I massaged the commit message comparing to the rfc post [1], the
> > > > > > patch itself is untouched.  Also removed rfc tag, and added more people
> > > > > > into the loop. Please kindly help test this patch if you have a reproducer,
> > > > > > as I can't reproduce it myself even with the syzbot reproducer on top of
> > > > > > mm-unstable.  Instead of further check on the reproducer, I decided to send
> > > > > > this out first as we have a bunch of reproducers on the list now..
> > > > > > ---
> > > > > >  mm/memory.c | 5 ++---
> > > > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > > index 4bcd79619574..f57cc304b318 100644
> > > > > > --- a/mm/memory.c
> > > > > > +++ b/mm/memory.c
> > > > > > @@ -1827,9 +1827,6 @@ static void unmap_single_vma(struct mmu_gather *tlb,
> > > > > >  	if (vma->vm_file)
> > > > > >  		uprobe_munmap(vma, start, end);
> > > > > >  
> > > > > > -	if (unlikely(vma->vm_flags & VM_PFNMAP))
> > > > > > -		untrack_pfn(vma, 0, 0, mm_wr_locked);
> > > > > > -
> > > > > Specifically to VFIO's case, looks it doesn't matter if untrack_pfn() is
> > > > > called here, since remap_pfn_range() is not called in mmap() and fault
> > > > > handler, and therefore (vma->vm_flags & VM_PAT) is always 0.
> > > > 
> > > > Right when with current repo, but I'm thinking maybe we should have VM_PAT
> > > > there..
> > > Yes, I agree.
> > > 
> > > But, currently for VFIO, it cannot call io_remap_pfn_range() in the fault
> > > handler since vm_flags_set() requires mmap lock held for write while
> > > the fault handler can only hold mmap lock for read.
> > > So, it relies on ioremap()/iounmap() to reserve/de-reserve memtypes,
> > > without VM_PAT being set in vma.
> > 
> > Right, neither vm_flags_set() nor io_remap_pfn_range() should be called in
> > a fault handler.  They should only be called in mmap() phase.
> > 
> > When you mentioned ioremap(), it's only for the VGA device, right?  I don't
> > see it's used in the vfio-pci's fault handler.
> Oh, it's pci_iomap() in the vfio-pci's fault handler, another version of
> ioremap() :)

Right. If to be explicit, I think it's in mmap(), and looks like Alex has a
comment for that:

	/*
	 * Even though we don't make use of the barmap for the mmap,
	 * we need to request the region and the barmap tracks that.
	 */

Maybe in 2012 that's a must?  PS: when looking, that looks like a proper
place to reuse vfio_pci_core_setup_barmap() also in the mmap() function.

> 
> > > 
> > > > 
> > > > See what reserve_pfn_range() does right now: it'll make sure only one owner
> > > > reserve this area, e.g. memtype_reserve() will fail if it has already been
> > > > reserved.  Then when succeeded as the first one to reserve the region,
> > > > it'll make sure this mem type to also be synchronized to the kernel map
> > > > (memtype_kernel_map_sync).
> > > > 
> > > > So I feel like when MMIO disabled for a VFIO card, we may need to call
> > > > reserve_pfn_range(), telling the kernel the mem type VFIO uses, even if the
> > > > pgtable will be empty, and even if currently it's always UC- for now:
> > > > 
> > > > vfio_pci_core_mmap():
> > > > 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > > > 
> > > > Then the memtype will be reserved even if it cannot be used.  Otherwise I
> > > > don't know whether there's side effects of kernel identity mapping where it
> > > > mismatch later with what's mapped in the userspace via the vma, when MMIO
> > > > got enabled again: pgtable started to be injected with a different memtype
> > > > that specified only in the vma's pgprot.
> > > Current VFIO relies on pci_iomap() to reserve MMIO pfns as UC-, thus
> > > no VM_PAT in vmas.
> > >  
> > > Calling remap_pfn_range() in the mmap() will cause problem to support
> > > dynamic faulting. Looks there's still a window even with an immediate
> > > unmap after mmap().
> > 
> > It can be conditionally injected.  See Alex's commit (not yet posted
> > anywhere, only used in our internal testing so far):
> > 
> > https://github.com/xzpeter/linux/commit/f432e0e46c34e493943034be4cb9d6eb638f57d1
> >
> I'm a bit confused by the code.
> It looks that it will do the remap_pfn_range() in mmap() if hardware is ready,
> and will just set vma flags if hardware is not ready.
> 
> But if the hardware is not ready in mmap(), which code in the fault handler
> will reserve pfn memtypes?

I thought I answered that below.. :)  I think we should use track_pfn_remap().

> 
> > > 
> > > Also, calling remap_pfn_range() in mmap() may not meet the requirement of
> > > drivers to dynamic switch backend resources, e.g. as what's in
> > > cxl_mmap_fault(), since one remap_pfn_range() cannot reserve memtypes for
> > > all backend resources at once.
> > > 
> > > So, is there any way for the driver to reserve memtypes and set VM_PAT in
> > > fault handler?
> > 
> > I must confess I'm not familiar with memtype stuff, and just started
> > looking recently.
> > 
> > Per my reading so far, we have these multiple ways of doing memtype
> > reservations, and no matter which API we use (ioremap / track_pfn_remap /
> > pci_iomap), the same memtype needs to be used otherwise the reservation
> > will fail.  Here ioremap / pci_iomap will involve one more vmap so that the
> > virtual mapping will present already after the API returns.
> Right, I understand in the same way :)
> 
> > 
> > Then here IMHO track_pfn_remap() is the one that we should still use in
> > page-level mmap() controls, because so far we don't want to map any MMIO
> > range yet, however we want to say "hey this VMA maps something special", by
> > reserving these memtype and set VM_PAT.  We want the virtual mapping only
> > later during a fault().
> > 
> > In short, it looks to me the right thing we should do is to manually invoke
> > track_pfn_remap() in vfio-pci's mmap() hook.
> > 
> > 	if (!vdev->pm_runtime_engaged && __vfio_pci_memory_enabled(vdev))
> > 		ret = remap_pfn_range(vma, vma->vm_start, pfn,
> > 				      req_len, vma->vm_page_prot);
> > 	else
> >                 // TODO: manually invoke track_pfn_remap() here
> > 		vm_flags_set(vma, VM_IO | VM_PFNMAP |
> > 				  VM_DONTEXPAND | VM_DONTDUMP);
> What if we have to remap another set of pfns in the "else" case?

Use vmf_insert_pfn*(): these helpers do not reserve memtype but looks them
up only.

> 
> > 
> > Then the vma is registered, and untrack_pfn() should be automatically done
> > when vma unmaps (and that relies on this patch to not do that too early).
> Well, I'm concerned by one use case.
> 
> 1. The driver calls remap_pfn_range() to reserve memtype for pfn1 + add
>    VM_PAT flag.
> 2. Then unmap_single_vma() is called. With this patch, the pfn1 memtype is
>    still reserved.
> 3. The fault handler calls vmf_insert_pfn() for another pfn2.
> 4. unmap_vmas() is called. However, untrack_pfn() will only find pfn2
>    instead of prevous pfn1.

It depends on what's your exact question, if it's about pgtable: I don't
think munmap() requires PFNMAP pgtables to always exist, and it'll simply
skip none entries.

And if it's about PAT tracking: that is exactly what I'm talking about
below..  where I think untracking shouldn't rely on pgtables.

I'll copy you too if I'll prepare some patches for the latter.  With that
patchset (plus this patch) it should fix David Wang's issue and similar,
AFAICT.

Thanks,

> 
> 
> > From that POV, I still think this patch does the right thing and should be
> > merged, even if we probably have one more issue to fix as David Wang
> > reported..
> > 
> > I'll need to think about how to do that right, as I think that'll be needed
> > as long as pfnmaps will support fault()s: it means when munmap() the
> > pgtable may not present, and PAT cannot rely on walking the pgtable to know
> > the base PFN anymore.
> > 
> > Thanks,
> > 
> > -- 
> > Peter Xu
> > 
> 

-- 
Peter Xu


