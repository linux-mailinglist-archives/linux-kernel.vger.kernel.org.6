Return-Path: <linux-kernel+bounces-255405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F67F934066
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2950C282FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1EE181BBF;
	Wed, 17 Jul 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/ys6ile"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E5180048
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233686; cv=none; b=CXgx/VWSpRw8JtOWIMZEJwGBgbMazcCiWAduJi1k8MVc8X5pJfpDBZwXBLRMM1TfO6SXgqVAoGXVNRQIKqXGoKFC0oDwkT/mQxsAoESr0OZxISe/v/b5JacFTreWTGQl7F6ceb3iPD1JnsWbM0ORc1MMQPR8MN2MRfqzkVfpx9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233686; c=relaxed/simple;
	bh=rXY0MZIegnVqIspj735rbSLUkqAE4SHMpTkqPJ0Wzk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqiYLr0H6oFdwsfLOwCJUBKB43qkJpgNmcPlCSQo6+nkgycdGefue+CDAsWmNcqAToGvRBW+c8xKUF86pvHkLvb65w7gh6EsI27TCuvSqn/D7D2+uDA9D/NwcNJtRiobsKJM+MoBHZS9GE2gF1Fawya67mDjITGd68+LNpcUhbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/ys6ile; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721233683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YB4f8SasXDqNtVPmUsunHXMOq8aSlXp5xuiXoPvYr0Y=;
	b=B/ys6iletazlIFFgaWTserk8/+0zmHQyuofZ2aJHibMWCV0zL/386CWT2z6Fz7REyKN3U2
	9NMaf64hVmSvzwz1fQuzsIprnbp9scgcvMegMUv44myQslV8xiED+8OS7ogLNpKU/3wd5t
	5lNloblFUpjNEIknTd45qkQ4ioRb3kk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-q3nAcRzENSyUPx67kaZWZA-1; Wed, 17 Jul 2024 12:28:02 -0400
X-MC-Unique: q3nAcRzENSyUPx67kaZWZA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b7973ab9cbso1033126d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721233682; x=1721838482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YB4f8SasXDqNtVPmUsunHXMOq8aSlXp5xuiXoPvYr0Y=;
        b=X64d+s/h+uNQNxki3kM7bsuBj2SaQaEvAu2q5PSd3SVfvhNTra+2t/9C17M80FmfBH
         ZAEdOvAf/+YslJ5hPdoixjrEjabK3sg2fqGIV2rp1ZC5AU8ocMzxtLfFzybQzWA9gKQk
         OhteQ5AnRCD3QPM8zKm8pnR4F3ip48y8SxDqFQ26g8Ti+VNpZEtmbjBn4BcbyXzNME+i
         t0ocqAkC/wHD4aMzg9kb2tiPOwRszcT9iXHiDRfSFc7kyEy0r1B5v4Haz8QUii3BvjWI
         FGl+D/L5wVaErG8rMaPlYC/qUqtNWNFpH8oqHPxKXhyeTn47Gml4bJvtlUjCCUB6Vztt
         Z3Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUSAUXhTLaehnH5V1VmTI2+K2jXmdp64hVBbmKPYRGjE05UsmNPNJL1KeBSQEtbK9Kh0bdG6RtI/h/aBBww5OGb1DhF8p8nQEArP+kE
X-Gm-Message-State: AOJu0Ywyya1iKxq6EXfnyT5Z+YhdyTiZTnPEzhRnf++HrE1+XW6bojrk
	3oMJDORF/4akXquRNp8YNUnT12GjiMcqBhLx5oaNlwme2oI/ETAv4doTb1v/biVTyqdr7klLHZe
	ZfOP6kSwbq7T6X1oIaGTrGsSz342+y/1Evw1LZYYveW2Iwt4t98XQFO/GWsvL/w==
X-Received: by 2002:a05:6214:568e:b0:6b7:586c:6d9 with SMTP id 6a1803df08f44-6b78e322f0fmr15084866d6.7.1721233681830;
        Wed, 17 Jul 2024 09:28:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWxyf5RFu8Rjn8T9AXssYMuIEru67Ovs1oZIdo8ygxMvQfRj/UFq4h18+GIZYKo3P/BpOcVQ==
X-Received: by 2002:a05:6214:568e:b0:6b7:586c:6d9 with SMTP id 6a1803df08f44-6b78e322f0fmr15084656d6.7.1721233681410;
        Wed, 17 Jul 2024 09:28:01 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7619a724esm43454306d6.72.2024.07.17.09.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 09:28:00 -0700 (PDT)
Date: Wed, 17 Jul 2024 12:27:55 -0400
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
Message-ID: <ZpfxC7LSEMLjt2o4@x1n>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <1182a459.1e35.190b0e61754.Coremail.00107082@163.com>
 <8da2b3bf-b9bf-44e3-88ff-750dc91c2388@redhat.com>
 <ZpU6KsKuhzPqUpFF@x1n>
 <2c6ec60e-1eff-417e-aed2-4554ea9a86eb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c6ec60e-1eff-417e-aed2-4554ea9a86eb@redhat.com>

On Wed, Jul 17, 2024 at 04:14:15PM +0200, David Hildenbrand wrote:
> [catching up on mails]
> 
> > > indicates that file truncation seems to end up messing with a PFNMAP mapping
> > > that has PAT set. That is ... weird. I would have thought that PFNMAP would
> > > never really happen with file truncation.
> > > 
> > > Does this only happen with an OOT driver, that seems to do weird truncate
> > > stuff on files that have a PFNMAP mapping?
> > > 
> > > [1]
> > > https://lore.kernel.org/all/3879ee72-84de-4d2a-93a8-c0b3dc3f0a4c@redhat.com/
> > 
> > Ohhh.. I guess this will also stop working in VFIO, but I think it's fine
> > for now because as Yan pointed out VFIO PCI doesn't register those regions
> > now so VM_PAT is not yet set..
> 
> Interesting, I was assuming that VFIO might be relying on that.
> 
> > 
> > And one thing I said wrong in the previous reply to Yan is, obviously
> > memtype_check_insert() can work with >1 owners as long as the memtype
> > matches.. and that's how fork() works where VM_PAT needs to be duplicated.
> > But this whole thing is a bit confusing to me..  As I think it also means
> > when fork the track_pfn_copy() will call memtype_kernel_map_sync one more
> > time even if we're 100% sure the pgprot will be the same for the kernel
> > mappings..
> 
> I consider the VM_PAT code quite ugly and I wish we could just get rid of it
> (especially, the automatic "entire VMA covered" handling thingy).

Yep, I agree.

> 
> > 
> > I wonder whether there's some way that untrack pfn framework doesn't need
> > to rely on the pgtable to fetch the pfn, because VFIO MMIO region
> > protection will also do that in the near future, AFAICT.  The pgprot part
> > should be easy there to fetch: get_pat_info() should fallback to vma's
> > pgprot if no mapping found; the only outlier should be CoW pages in
> > reality.  The pfn is the real issue so far, so that either track_pfn_copy()
> > or untrack_pfn() may need to know the pfn to untrack, even if it only has
> > the vma information.
> 
> I had a prototype to store that information per VMA to avoid the page table
> lookup. VMA splitting was a bit "added complication", but I got it to work.
> (maybe I can still find it if there is demand)
> 
> The downside was having to consume more memory for all VMAs in the system
> simply (even if only 8 byte) because a handful of VMAs in the system could
> be VM_PAT. I decided that's not what we want. I managed to not consume
> memory in some configurations, but not in all, so I discarded that approach.
> 
> I did not explore storing that information in some auxiliary datastructure.

One idea to avoid that is to let driver opt-in for such information, e.g. a
hook in vm_operations_struct to fetch base pfn for a vma map.  But that
will involve any driver to provide that information, e.g. for David Wang's
case IIUC it's at least an OOT driver, so nothing to fix it from an
upstream patch with that solution (while it should work for VFIO).

> 
> IMHO the whole VM_PAT model is weird:
> 
> 1) mmap()
> 2) remap_pfn_range(): if it covers the whole VMA apply some magic
>    reservation.
> 3) munmap(): we unmap *all* PFNs and, therefore, clean up VM_PAT
> 
> (VMA splitting make the whole model weirder, but it works, because we never
> merge these VMAs)
> 
> This model cannot properly work if we get partial page table zapping via
> truncation/MADV_DONTNEED or similar things after 2). And likely we also
> shouldn't be doing it that way. We should forbid any partial unmappings in
> that model, just like we already disallow MADV_DONTNEED as you note.
> 
> As you mention in your other comment, maybe relevant/all? caller should just
> manage the PAT side independently. So maybe we can move to a different
> model.

Any elaboration of what's the new model you're describing?

Thanks,

-- 
Peter Xu


