Return-Path: <linux-kernel+bounces-259121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A9C939187
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B1B1F210A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A472616DEB1;
	Mon, 22 Jul 2024 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBpOrc+c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2308F16C6BC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661319; cv=none; b=SDJqGjQpKkI2xnVvdKuNeDXI0qPHjY04ieiJh9i9DPj+v8iGuO3iKaGnb5qZ0qzMeg0NSiTlfoZ9UXtYSRxEISqHTKE2K8aVv4OKSGup6q6qIBUwNqUYTwOL86EUf2tx/86rnhU6YJg5AXviK7oFZLC7XO1+/AztfiARRh3qSvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661319; c=relaxed/simple;
	bh=UYmeIquhizpn8t7nOrz83qbxhBYzKN30mJ443o0XW/o=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uE/6LCFy4rzDv3J6yr4vPVOdPhBecw8FA9QiMbsPmmA7DcP18hrORHLBEFDvSNKg8+JreZ5X7UbFAHlJrmfyS7Z1OeSxa1P3ZMm+ZUwsWNdobPpArMa578HvCnX0i1yKHlPRMEgz9qgq25gTjDMR73cIfBPVPqw17J+l/2+2sHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBpOrc+c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721661317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwV4EVwTFVUmCfewLq5KTWokf+/tzGEG2FIyhpLUO5s=;
	b=HBpOrc+cNoVMEKZ0obyAOEpNI6FWaNgYwRP7dGij82+0cAWVfsPheytzdTA6F4BDIwU8yI
	PWH2XtPbgVBr5N+ly1pM+XZ4pUbZakouON9OnQgodXtrIFP4UF3QXmua8IW24OZ3q4GTrD
	LtoPn6CVYxd3/GNFLMTKR2i7f8Ag7q4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-hyazeQDwPU-E7vE-pL9uwQ-1; Mon, 22 Jul 2024 11:15:14 -0400
X-MC-Unique: hyazeQDwPU-E7vE-pL9uwQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b797b6b4aeso14967226d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721661314; x=1722266114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwV4EVwTFVUmCfewLq5KTWokf+/tzGEG2FIyhpLUO5s=;
        b=ku9eV9f2h2NV3PP0JXpjwXZPfbfk83sLP/eSO77vlPrPzGRDVHffcDnYFvZ973NE5P
         kpTOi3JPIVTMZx/LycG9famDY3KTfjTkpESbmubFessBcNuugtXOnY8+SiT5b4GN9XsC
         rJZhWeTcX+NM8Bz6vfUAWVaH+VjjlcRIMldA1esVpkqpZikowAvmK4gtlQAVbX4VmFxR
         F9UtxlQ9ckdcWPkIH5KJ72CfPbWWXmfWAf9LPFtRRuYbYG1CHeYgeAbtX9cPlPfgpN7Z
         IFmW1rsQrLT4zQiSX/a+zl7L5ix+n7m5xQOxUO8YcVHeYIPF20+d8sSze29S8hgw1YwK
         ngpw==
X-Forwarded-Encrypted: i=1; AJvYcCU8Tco4IsmOfCOWd02QruE2+T1y/9EdIswLSFJTq1Q6kacyTBMCN2RqVqR5NzzhiVTs74mRSPapAkkd7cxgtmkIMC8umWtMkyMkr5ox
X-Gm-Message-State: AOJu0YzwCuf38Dm4MaTUZI9ELboRhxud2wlO4I4JtjW2QHbmSZQ3zU+L
	5JYiBb2uCAFN/MErXvo0kumt2/wVTZ8TvsvSMHToy2FxpeoyYVqUssHBP3Zr7NNyR1SUCB6sC57
	lJJEFh//j1Eg8ezoo203P2ANoGvdtxR7dGhc+fjZ4l8lda+tMt0/rVicLxAkHwQ==
X-Received: by 2002:a05:620a:4686:b0:79f:1556:37c9 with SMTP id af79cd13be357-7a1a122ffa7mr583607985a.0.1721661314102;
        Mon, 22 Jul 2024 08:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoPhA2XpD7vdd+w+1X6Fpe4UnduSzjJakKLgwmnDYed+val5xuaIYc5nVZBz4YRXeYP8zHSw==
X-Received: by 2002:a05:620a:4686:b0:79f:1556:37c9 with SMTP id af79cd13be357-7a1a122ffa7mr583605685a.0.1721661313577;
        Mon, 22 Jul 2024 08:15:13 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cda34c4sm33648931cf.63.2024.07.22.08.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 08:15:12 -0700 (PDT)
Date: Mon, 22 Jul 2024 11:15:10 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"Kirill A . Shutemov" <kirill@shutemov.name>, x86@kernel.org,
	Yan Zhao <yan.y.zhao@intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Pei Li <peili.dev@gmail.com>, David Hildenbrand <david@redhat.com>,
	David Wang <00107082@163.com>, Bert Karwatzki <spasswolf@web.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <Zp53fnlsJGOmWSRQ@x1n>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <t7q4s4rktcjkrtmr7l2zffpthxis5bmafhae7aaxxekyyp75ev@x4dshxdx3jpo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <t7q4s4rktcjkrtmr7l2zffpthxis5bmafhae7aaxxekyyp75ev@x4dshxdx3jpo>

On Fri, Jul 19, 2024 at 10:18:12PM -0400, Liam R. Howlett wrote:
> * Peter Xu <peterx@redhat.com> [240712 10:43]:
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
> >  	if (start != end) {
> >  		if (unlikely(is_vm_hugetlb_page(vma))) {
> >  			/*
> > @@ -1894,6 +1891,8 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
> >  		unsigned long start = start_addr;
> >  		unsigned long end = end_addr;
> >  		hugetlb_zap_begin(vma, &start, &end);
> > +		if (unlikely(vma->vm_flags & VM_PFNMAP))
> > +			untrack_pfn(vma, 0, 0, mm_wr_locked);
> >  		unmap_single_vma(tlb, vma, start, end, &details,
> >  				 mm_wr_locked);
> >  		hugetlb_zap_end(vma, &details);
> > -- 
> > 2.45.0
> 
> 
> ...Trying to follow this discussion across several threads and bug
> reports.   I was looped in when syzbot found that the [4] fix was a
> deadlock.
> 
> How are we reaching unmap_vmas() without the mmap lock held in any mode?
> We must be holding the read or write lock - otherwise the vma pointer is
> unsafe...?

The report was not calling unmap_vmas() but unmap_single_vma(), and this
patch proposed to move the untrack operation there.  We should always hold
write lock for unmap_vmas(), afaiu.

> 
> In any case, since this will just keep calling unmap_single_vma() it has
> to be an incomplete fix?

I think there's indeed some issue to settle besides this patch, however I
didn't quickly get why this patch is incomplete from this specific "untrack
pfn within unmap_single_vma()" problem.  I thought it was complete from
that regard, or could you elaborate otherwise?

For example, I think it's pretty common to use unmap_single_vma() in a
truncation path.

Thanks,

-- 
Peter Xu


