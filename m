Return-Path: <linux-kernel+bounces-520623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDEBA3AC69
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EFA37A547D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ED21DDC11;
	Tue, 18 Feb 2025 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkwfLZ+m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353D1C7019
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 23:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739920457; cv=none; b=muY9fkkCPr+45u2fbKkaomXLd5tOQHIQoVYBNiUAakYKqqI6G1C5Esd4B6tgDb92mP3o4r4+t2hfVIX6TMhBsUDECMyAUUmHdj/uxzSb2aJhI/GDPlbr3iTq0GLA16eooiWbTkejDZzqR0vXIZkstuquOOtHfRNgPZ1ctfA5v40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739920457; c=relaxed/simple;
	bh=jjzWBHJVFkuw2OOwhCBhesEY1Q7PqUCIlWTyVfPg5rc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIQyizOyjnoaqXkBLLcz+NLkSRdaANxIdSY/hJM7GwE7m4zWJDyCC84qR9BPnpt8uc58nq9SPk11CTfTShj05Vb64otO5gIKYO/bfgkxm885hvLCzfvafwS92ifb7qR7UoAGQkHjZwKzo5YZgmy4eBeC8AhB+XwZs/VwR999acM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NkwfLZ+m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739920454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DHjLr0rLrhNcbSiUqbGgnbUKfct/I7UxqmG8LtAAQkU=;
	b=NkwfLZ+mT2MpvzofIrRHaXW17XVJ1Q23RhMnkPclEZ35HItApqAbUun01cwXSA1wW1DG1L
	Floj8fIA0fdhpKzd0gQJshOXpBpWXVNhVion6rgm6nc6S2MI4Ony9D8bKX8mbEsu2u1wwI
	8FmFmcqwfK3nefgMgpjT5ZeWc6o3uIs=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-2iKOcpwgNcigBJNZxQj2Gw-1; Tue, 18 Feb 2025 18:14:13 -0500
X-MC-Unique: 2iKOcpwgNcigBJNZxQj2Gw-1
X-Mimecast-MFC-AGG-ID: 2iKOcpwgNcigBJNZxQj2Gw_1739920452
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d18977ad27so5550325ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739920452; x=1740525252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHjLr0rLrhNcbSiUqbGgnbUKfct/I7UxqmG8LtAAQkU=;
        b=MYswx7pFO94bNIvLVVtXDWZhlYYEJo1J46g5leJ7ySnwgao8K2RvHnpO2uaWzYkkuQ
         7ZMXVaTl1CTUoxgor+ctApum8FGmaYei+t+zw03BUcQb5q5mwgMtnYftO3AFon0qF/mH
         r0YvpLTwi/KRpLHdGXkpSy/6CmqLJZ2pNuhSrj9oY6rFH4a9s56z0684axrlt1ND6MoZ
         NeyYmxq7u3bwK8QrhuKCEwUbnlb/okv0WGO6Oo2gmCRqZiWrvkjgZM0FcioCfKAVgK1+
         w+95x/n+ew6F+9u519TbtwC+bVFsbQG0w+BErXAgHPU8HDDGFLjWuAVJeazJllQ/YJbQ
         mm/A==
X-Forwarded-Encrypted: i=1; AJvYcCXvQ+FPUOO8I6UGXKMbpOq8C7MYeSiSCoKCfggKPjNa2o8DZz8NMJUFVxLZM6weavgd/Bza7cNGreInjEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLf52MFO3B0RdnxpcvBn+n+kKBc28UQJdIBdylhcnc3qH+A6nW
	oavvPR9PqQhzUNCgtIvSD/9hlQn+tsWxeWrVXMb3D5IvVNVNCmOSELiGoRY9oKMkeqfaB/EpxQd
	RmP6F+oDHc0Y1sCxHnbpQ9APeBh629MyRqIS0vIyUe8Xye3eU22XKEBre8AASnA==
X-Gm-Gg: ASbGnctu3XQc96tMwQ/NUMXA9b3s8ZpLJuQssasgxP69xk1dW8SPmbceQuJE6PraeHJ
	YlMiL6VMCArWvN2iw0TxridymQ4V2Gu+U/bMzI1i8hNGb0rCT/LLRqJJLboaI1JNaO63lqzNHwL
	75N2JBF+mjzxp4kyFSdMBwrAsP34rOMNoHvY1lEuFrQZO3tA7X44c/GkI+KqWi4iReRZB0VODTH
	j2yMUyVlKkdcJZK9fi4dQxodTayCfOVVN8WHOSZWgbHqA3kGFg74aSZ80BUGlDrN8z+4kP0JNkQ
	jcm+Wy+B
X-Received: by 2002:a05:6e02:1805:b0:3d1:3d56:d15d with SMTP id e9e14a558f8ab-3d280935057mr39369645ab.5.1739920452245;
        Tue, 18 Feb 2025 15:14:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAH7M7t38v508EoBeSUQTl2IBXKA3WOU5bkl7flcWpH68hMGeBPmER9kP9YUKvYlBW9PFl7A==
X-Received: by 2002:a05:6e02:1805:b0:3d1:3d56:d15d with SMTP id e9e14a558f8ab-3d280935057mr39369555ab.5.1739920451911;
        Tue, 18 Feb 2025 15:14:11 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d282233d9dsm18041285ab.40.2025.02.18.15.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 15:14:09 -0800 (PST)
Date: Tue, 18 Feb 2025 16:14:07 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 mitchell.augustin@canonical.com, clg@redhat.com, jgg@nvidia.com,
 willy@infradead.org
Subject: Re: [PATCH v2 6/6] vfio/type1: Use mapping page mask for pfnmaps
Message-ID: <20250218161407.6ae2b082.alex.williamson@redhat.com>
In-Reply-To: <Z7UOEpgH5pdTBcJP@x1.local>
References: <20250218222209.1382449-1-alex.williamson@redhat.com>
	<20250218222209.1382449-7-alex.williamson@redhat.com>
	<Z7UOEpgH5pdTBcJP@x1.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 17:47:46 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Tue, Feb 18, 2025 at 03:22:06PM -0700, Alex Williamson wrote:
> > vfio-pci supports huge_fault for PCI MMIO BARs and will insert pud and
> > pmd mappings for well aligned mappings.  follow_pfnmap_start() walks the
> > page table and therefore knows the page mask of the level where the
> > address is found and returns this through follow_pfnmap_args.pgmask.
> > Subsequent pfns from this address until the end of the mapping page are
> > necessarily consecutive.  Use this information to retrieve a range of
> > pfnmap pfns in a single pass.
> > 
> > With optimal mappings and alignment on systems with 1GB pud and 4KB
> > page size, this reduces iterations for DMA mapping PCI BARs by a
> > factor of 256K.  In real world testing, the overhead of iterating
> > pfns for a VM DMA mapping a 32GB PCI BAR is reduced from ~1s to
> > sub-millisecond overhead.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index ce661f03f139..0ac56072af9f 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -520,7 +520,7 @@ static void vfio_batch_fini(struct vfio_batch *batch)
> >  
> >  static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
> >  			    unsigned long vaddr, unsigned long *pfn,
> > -			    bool write_fault)
> > +			    unsigned long *addr_mask, bool write_fault)
> >  {
> >  	struct follow_pfnmap_args args = { .vma = vma, .address = vaddr };
> >  	int ret;
> > @@ -544,10 +544,12 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
> >  			return ret;
> >  	}
> >  
> > -	if (write_fault && !args.writable)
> > +	if (write_fault && !args.writable) {
> >  		ret = -EFAULT;
> > -	else
> > +	} else {
> >  		*pfn = args.pfn;
> > +		*addr_mask = args.addr_mask;
> > +	}
> >  
> >  	follow_pfnmap_end(&args);
> >  	return ret;
> > @@ -590,15 +592,22 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
> >  	vma = vma_lookup(mm, vaddr);
> >  
> >  	if (vma && vma->vm_flags & VM_PFNMAP) {
> > -		ret = follow_fault_pfn(vma, mm, vaddr, pfn, prot & IOMMU_WRITE);
> > +		unsigned long addr_mask;
> > +
> > +		ret = follow_fault_pfn(vma, mm, vaddr, pfn, &addr_mask,
> > +				       prot & IOMMU_WRITE);
> >  		if (ret == -EAGAIN)
> >  			goto retry;
> >  
> >  		if (!ret) {
> > -			if (is_invalid_reserved_pfn(*pfn))
> > -				ret = 1;
> > -			else
> > +			if (is_invalid_reserved_pfn(*pfn)) {
> > +				unsigned long epfn;
> > +
> > +				epfn = (*pfn | (~addr_mask >> PAGE_SHIFT)) + 1;
> > +				ret = min_t(long, npages, epfn - *pfn);  
> 
> s/long/unsigned long/?

ret is signed long since it's the function return and needs to be able
to return -errno, so long was the intention here.  Thanks,

Alex
 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> > +			} else {
> >  				ret = -EFAULT;
> > +			}
> >  		}
> >  	}
> >  done:
> > -- 
> > 2.48.1
> >   
> 


