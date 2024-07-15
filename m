Return-Path: <linux-kernel+bounces-252723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F057E931750
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36252818BB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B93618F2C5;
	Mon, 15 Jul 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8/ZZjN3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C493A1A0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721055794; cv=none; b=KpbHl13aDHKRTzWPt0VicP/aB+1g0faogBht19AcwESxWGs9jHUskPAsYnSsh88rCe6BracRdWk5uzekIRIKxWgAYFWE5dNyxk7BZ++tjRQc/vNtbN2uzqJzYsFW+alzwKOhv1Y9KbvyINbGOORfXUwaq/SdqRJQG2aE4XkfVOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721055794; c=relaxed/simple;
	bh=owC7FJjs1l9pLWV6rfVljc4xZ1WBLyzhuHQ/uLBqJj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ8uRHDHKio2uu14039qTKVvG7sTA6drtiZhhQpGmzhxWHtFd5T7jnBMkuC8hnW2BXjUxGXkGmI+ZAamy4fyJlE1PcyGZPrz/CK4XaDYbg6sJizXHs2TVSO7L/F8gFdkzKKyGDhTnV+GoYgl9H8Fq/ountiRncCnZ2Jfu4z/THY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i8/ZZjN3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721055792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2yTZb7+mQJZXBK7qYXVgXHJq3MdxWsgEZ9xe9sXqDfQ=;
	b=i8/ZZjN3V50/qZ7Of0umagYSWvtNTsbTJ1iDLLCY0KMcqer4OSk/tBXlWmDQTpY0/+Gh8Y
	9NX5ccEbzK5vBDSkbhoxJWNY17jxdvksnD+F7+yGjndgN7akhviCDXKEipplwl4ja+HWG0
	D+19tHlPwgh5hDBTx7SVSHdctIBm8Mk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-Zwa92RyZNaubslNeYj3vRQ-1; Mon, 15 Jul 2024 11:03:10 -0400
X-MC-Unique: Zwa92RyZNaubslNeYj3vRQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-447dfad3387so11125811cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721055790; x=1721660590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yTZb7+mQJZXBK7qYXVgXHJq3MdxWsgEZ9xe9sXqDfQ=;
        b=DtXyHyxxPubgiJTIndeu3RYLuRVNdpACK92MfufN2P5CMoSVOfGkhxq8yDo299u5yR
         plqZZwdLWZOozw7oKgChjQ02pW69NOsExDzJpWQB914zG2YBebi0LWOTVhKZHB1GS03a
         HeIk04OzeTCW3KYexGIlqKTw5YfZ9KsgY3XF6guNpLWr9ReNHt2ih4WcMyMFEDSTY9Wy
         WLvJ300U3DvA4HufdfIZujWQR1G/BqOCsV+CusaUWomzPeyj1EVozgBxpbeIXhWustSC
         eaY9prm8/plViIqjz94TWV+j++0XGJad8AHJgS3UO0WG+KsHHCCXbSJuYTK6bSIOO6g0
         QYHg==
X-Forwarded-Encrypted: i=1; AJvYcCUj+fkwWSaNTxbEjb4/hVXDU/iK0I5xMXaR03tuLlK6i5xYAUxqJRt3XovLaWuTWtSvbYgiwh2YS7nAk8VoMRoBYvDxv9YMcvEgtoY/
X-Gm-Message-State: AOJu0YxPPu4m1DAu30aZL6UfhUrF8cWsD/QKFJ3wz8jB6sWmjFTelaX3
	qpnwUcZOp1125zJsD0dq2o9B87Y+Nscq/vbDx3f+m1tzGDEhbQppCbpLskW3t+uAFEqxOpym+2Q
	ua+88MHRhUrrGVmFW/b/rTQeKgGeOpH3YQwNCUJBQY29kYVKRxV9rsgSpxMpi7w==
X-Received: by 2002:a05:622a:15c4:b0:44e:cff7:3742 with SMTP id d75a77b69052e-44f792aaa18mr14911cf.8.1721055789774;
        Mon, 15 Jul 2024 08:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcMbJqOp8VyQ0MieqpADYPl+M4EHhZD2Cg/JwSuiTWevBLnSOp3kocJixEawjgtgw4Glmx1w==
X-Received: by 2002:a05:622a:15c4:b0:44e:cff7:3742 with SMTP id d75a77b69052e-44f792aaa18mr14551cf.8.1721055789286;
        Mon, 15 Jul 2024 08:03:09 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7c4108sm25210541cf.9.2024.07.15.08.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 08:03:08 -0700 (PDT)
Date: Mon, 15 Jul 2024 11:03:06 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: David Wang <00107082@163.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"Kirill A . Shutemov" <kirill@shutemov.name>, x86@kernel.org,
	Yan Zhao <yan.y.zhao@intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Pei Li <peili.dev@gmail.com>, Bert Karwatzki <spasswolf@web.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <ZpU6KsKuhzPqUpFF@x1n>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <1182a459.1e35.190b0e61754.Coremail.00107082@163.com>
 <8da2b3bf-b9bf-44e3-88ff-750dc91c2388@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8da2b3bf-b9bf-44e3-88ff-750dc91c2388@redhat.com>

On Sun, Jul 14, 2024 at 08:27:25PM +0200, David Hildenbrand wrote:
> On 14.07.24 12:59, David Wang wrote:
> > 
> > At 2024-07-12 22:42:44, "Peter Xu" <peterx@redhat.com> wrote:
> > > NOTE: I massaged the commit message comparing to the rfc post [1], the
> > > patch itself is untouched.  Also removed rfc tag, and added more people
> > > into the loop. Please kindly help test this patch if you have a reproducer,
> > > as I can't reproduce it myself even with the syzbot reproducer on top of
> > > mm-unstable.  Instead of further check on the reproducer, I decided to send
> > > this out first as we have a bunch of reproducers on the list now..
> > > ---
> > > mm/memory.c | 5 ++---
> > > 1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 4bcd79619574..f57cc304b318 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -1827,9 +1827,6 @@ static void unmap_single_vma(struct mmu_gather *tlb,
> > > 	if (vma->vm_file)
> > > 		uprobe_munmap(vma, start, end);
> > > 
> > > -	if (unlikely(vma->vm_flags & VM_PFNMAP))
> > > -		untrack_pfn(vma, 0, 0, mm_wr_locked);
> > > -
> > > 	if (start != end) {
> > > 		if (unlikely(is_vm_hugetlb_page(vma))) {
> > > 			/*
> > > @@ -1894,6 +1891,8 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
> > > 		unsigned long start = start_addr;
> > > 		unsigned long end = end_addr;
> > > 		hugetlb_zap_begin(vma, &start, &end);
> > > +		if (unlikely(vma->vm_flags & VM_PFNMAP))
> > > +			untrack_pfn(vma, 0, 0, mm_wr_locked);
> > > 		unmap_single_vma(tlb, vma, start, end, &details,
> > > 				 mm_wr_locked);
> > > 		hugetlb_zap_end(vma, &details);
> > > -- 
> > > 2.45.0
> > 
> > Hi,
> > 
> > Today, I notice a kernel warning with this patch.
> > 
> > 
> > [Sun Jul 14 16:51:38 2024] OOM killer enabled.
> > [Sun Jul 14 16:51:38 2024] Restarting tasks ... done.
> > [Sun Jul 14 16:51:38 2024] random: crng reseeded on system resumption
> > [Sun Jul 14 16:51:38 2024] PM: suspend exit
> > [Sun Jul 14 16:51:38 2024] ------------[ cut here ]------------
> > [Sun Jul 14 16:51:38 2024] WARNING: CPU: 1 PID: 2484 at arch/x86/mm/pat/memtype.c:1002 untrack_pfn+0x10c/0x120
> 
> We fail to find what we need in the page tables, indicating that the page
> tables might have been modified / torn down in the meantime.
> 
> Likely we have a previous call to unmap_single_vma() that modifies the page
> tables, and unmaps present PFNs.
> 
> PAT is incompatible to that, it relies on information from the page tables
> to know what it has to undo during munmap(), or what it has to do during
> fork().
> 
> The splat from the previous discussion [1]:
> 
>   follow_phys arch/x86/mm/pat/memtype.c:957 [inline]
>   get_pat_info+0xf2/0x510 arch/x86/mm/pat/memtype.c:991
>   untrack_pfn+0xf7/0x4d0 arch/x86/mm/pat/memtype.c:1104
>   unmap_single_vma+0x1bd/0x2b0 mm/memory.c:1819
>   zap_page_range_single+0x326/0x560 mm/memory.c:1920
>   unmap_mapping_range_vma mm/memory.c:3684 [inline]
>   unmap_mapping_range_tree mm/memory.c:3701 [inline]
>   unmap_mapping_pages mm/memory.c:3767 [inline]
>   unmap_mapping_range+0x1ee/0x280 mm/memory.c:3804
>   truncate_pagecache+0x53/0x90 mm/truncate.c:731
>   simple_setattr+0xf2/0x120 fs/libfs.c:886
>   notify_change+0xec6/0x11f0 fs/attr.c:499
>   do_truncate+0x15c/0x220 fs/open.c:65
>   handle_truncate fs/namei.c:3308 [inline]
> 
> indicates that file truncation seems to end up messing with a PFNMAP mapping
> that has PAT set. That is ... weird. I would have thought that PFNMAP would
> never really happen with file truncation.
> 
> Does this only happen with an OOT driver, that seems to do weird truncate
> stuff on files that have a PFNMAP mapping?
> 
> [1]
> https://lore.kernel.org/all/3879ee72-84de-4d2a-93a8-c0b3dc3f0a4c@redhat.com/

Ohhh.. I guess this will also stop working in VFIO, but I think it's fine
for now because as Yan pointed out VFIO PCI doesn't register those regions
now so VM_PAT is not yet set..

And one thing I said wrong in the previous reply to Yan is, obviously
memtype_check_insert() can work with >1 owners as long as the memtype
matches.. and that's how fork() works where VM_PAT needs to be duplicated.
But this whole thing is a bit confusing to me..  As I think it also means
when fork the track_pfn_copy() will call memtype_kernel_map_sync one more
time even if we're 100% sure the pgprot will be the same for the kernel
mappings..

I wonder whether there's some way that untrack pfn framework doesn't need
to rely on the pgtable to fetch the pfn, because VFIO MMIO region
protection will also do that in the near future, AFAICT.  The pgprot part
should be easy there to fetch: get_pat_info() should fallback to vma's
pgprot if no mapping found; the only outlier should be CoW pages in
reality.  The pfn is the real issue so far, so that either track_pfn_copy()
or untrack_pfn() may need to know the pfn to untrack, even if it only has
the vma information.

Thanks,

-- 
Peter Xu


