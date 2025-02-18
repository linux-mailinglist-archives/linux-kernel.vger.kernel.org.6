Return-Path: <linux-kernel+bounces-520599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B055AA3ABFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99162188DCA9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04EA1DA0E0;
	Tue, 18 Feb 2025 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wy4SffLT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D5D199EB2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918875; cv=none; b=HJAXtfLn1OPAxCV60aA5JSNPaaAqxpHCPupYQ8KKbiupywrxgzkE93tWhTZtkzcs9BkZQS2Ro6sQehAB0aeR9hd+LrzvBSjEyRAM4mWUu0x+vVawzMggYm5RupEedkmx4VZTllPe3f0iA15Vet+guXgffblz+VlgcwknvjDma1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918875; c=relaxed/simple;
	bh=h24HuYwNLSnt3tdVXGlp3ZLTwLBuyPAwn3ahyR1sqRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1rL5bjsPqqamtJJSoMCsLB6j8EO5c7B8q3RMBJqW8UWL19Hr8REouUNeJM9PyJg/vWLDGVf5JYp0Qg+6ligK9uT9WrTP74h3j3Sq8xbQVp8DlSYFSgV9Meai16vYDV/XIGzctiQkZg0/onqtAR3BgKiOdtEOuqj7FI46cipsHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wy4SffLT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739918872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nh9W0RmqBnUONSTMPcR74JdQUkTIr6YF89vCK3+sVCc=;
	b=Wy4SffLTy7Cf/P74fbrPiLvfaaWsnl3P2dLfbahs/hhXbJVcNz99CFm6Xv3S4qE0oZOz5l
	tnx+Li3yR56iEKHdG9KSVn/wD3ToVXixjr8cu+pVwkN3PlRjfhOsIk/4c7pUZz5PMMNvUJ
	i4YDGTKiLGbwLiwCBLVREy4fdmRGVes=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-opChtWLIObmstRJKfimsmA-1; Tue, 18 Feb 2025 17:47:51 -0500
X-MC-Unique: opChtWLIObmstRJKfimsmA-1
X-Mimecast-MFC-AGG-ID: opChtWLIObmstRJKfimsmA_1739918870
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0a79e6a7eso295038085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739918870; x=1740523670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh9W0RmqBnUONSTMPcR74JdQUkTIr6YF89vCK3+sVCc=;
        b=SBktJXhw8rqrTTokrdSWVWGw9cunO3IChB8wPecd+44vMycZGpDOtb3eY+h13ii9Nx
         s4kOX2w7Zv7mR43yIC2e6X2ezlxyH34CeMIyUaCWMDJfRh0dwo5RXQHUzsluF1frw9aY
         3Aww2n/mlFKrqFhHXp97MRWpxDx0EfNhEaZ+047aUHqIjmYGHkGdGehgGKY2vwNwxNcJ
         rr3ntGtW1YdeBt2l5WX6cGjD7vW1TYXAsSwjfRLzmA6u8EHpD/s39xK3y6H4tHsfifGU
         XGtYv1AmSjLYa7+hmAie9hHD59T0eupy6pGEUd3tAig7YNwxU4aeP+KBbDIBPyl0tkfU
         vzEw==
X-Forwarded-Encrypted: i=1; AJvYcCVyAzqmW7FeRTQ7k1kYX5I0274k2c21CnIdmquNzq8soP3P+Hmvo7QBYs2VWer8OnLbt/ufTLz9qJkNllc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFocON6nmYpWfX6I3AZZO60niOEU9LUOiEFOjdzGEzYDbAoFw
	qTnmhn2OLZV8qCnK7zBAkoNPq2FF9+bT5qWobVEWrivUP0CLB/3g5f4EA3g8dq/WRFqKRE6QwZ/
	42NNK7Mcen9fXbQn9WBziqx3wY1NtkZeAycsvHlcyLQ/AJvet6VYIkkZkpaRvLg==
X-Gm-Gg: ASbGncvf1f9MASmz6qAAmryFSZxlN1I1uCd27Bw7oHuDnvh4Ss0psJciR26u66ON7ry
	OEQgyQ/TIPoT0mt8c7j3XvWfP5mA0/HNZLnU+IUA4R2pHy0pjnQtjt/Otw7n91AT91ra5IYuGC0
	IXTb3kTmXjFUa1OGn0685MiHnG1PPvHBS/ENMpGIXZqaLTbENwxprpCK9lSsdptzaohg7MZVIno
	f9MhMsPuvy7Q3nC7wqizeMP6U4SneYdlkZBxG9PMAzre0o3WXWHSTFWKi8=
X-Received: by 2002:a05:620a:4506:b0:7c0:602c:e689 with SMTP id af79cd13be357-7c08a99c55cmr1632597585a.16.1739918869957;
        Tue, 18 Feb 2025 14:47:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGw3KGF4/VClTCVZ8SCaSR6gJ/c+MMRvvSXFAJ8E8v3FwIBWyA1S7XmW3ZiNnzr4iowAvPviw==
X-Received: by 2002:a05:620a:4506:b0:7c0:602c:e689 with SMTP id af79cd13be357-7c08a99c55cmr1632595385a.16.1739918869659;
        Tue, 18 Feb 2025 14:47:49 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a3dcda55sm229402985a.58.2025.02.18.14.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:47:48 -0800 (PST)
Date: Tue, 18 Feb 2025 17:47:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mitchell.augustin@canonical.com, clg@redhat.com, jgg@nvidia.com,
	willy@infradead.org
Subject: Re: [PATCH v2 6/6] vfio/type1: Use mapping page mask for pfnmaps
Message-ID: <Z7UOEpgH5pdTBcJP@x1.local>
References: <20250218222209.1382449-1-alex.williamson@redhat.com>
 <20250218222209.1382449-7-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218222209.1382449-7-alex.williamson@redhat.com>

On Tue, Feb 18, 2025 at 03:22:06PM -0700, Alex Williamson wrote:
> vfio-pci supports huge_fault for PCI MMIO BARs and will insert pud and
> pmd mappings for well aligned mappings.  follow_pfnmap_start() walks the
> page table and therefore knows the page mask of the level where the
> address is found and returns this through follow_pfnmap_args.pgmask.
> Subsequent pfns from this address until the end of the mapping page are
> necessarily consecutive.  Use this information to retrieve a range of
> pfnmap pfns in a single pass.
> 
> With optimal mappings and alignment on systems with 1GB pud and 4KB
> page size, this reduces iterations for DMA mapping PCI BARs by a
> factor of 256K.  In real world testing, the overhead of iterating
> pfns for a VM DMA mapping a 32GB PCI BAR is reduced from ~1s to
> sub-millisecond overhead.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index ce661f03f139..0ac56072af9f 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -520,7 +520,7 @@ static void vfio_batch_fini(struct vfio_batch *batch)
>  
>  static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
>  			    unsigned long vaddr, unsigned long *pfn,
> -			    bool write_fault)
> +			    unsigned long *addr_mask, bool write_fault)
>  {
>  	struct follow_pfnmap_args args = { .vma = vma, .address = vaddr };
>  	int ret;
> @@ -544,10 +544,12 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
>  			return ret;
>  	}
>  
> -	if (write_fault && !args.writable)
> +	if (write_fault && !args.writable) {
>  		ret = -EFAULT;
> -	else
> +	} else {
>  		*pfn = args.pfn;
> +		*addr_mask = args.addr_mask;
> +	}
>  
>  	follow_pfnmap_end(&args);
>  	return ret;
> @@ -590,15 +592,22 @@ static long vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
>  	vma = vma_lookup(mm, vaddr);
>  
>  	if (vma && vma->vm_flags & VM_PFNMAP) {
> -		ret = follow_fault_pfn(vma, mm, vaddr, pfn, prot & IOMMU_WRITE);
> +		unsigned long addr_mask;
> +
> +		ret = follow_fault_pfn(vma, mm, vaddr, pfn, &addr_mask,
> +				       prot & IOMMU_WRITE);
>  		if (ret == -EAGAIN)
>  			goto retry;
>  
>  		if (!ret) {
> -			if (is_invalid_reserved_pfn(*pfn))
> -				ret = 1;
> -			else
> +			if (is_invalid_reserved_pfn(*pfn)) {
> +				unsigned long epfn;
> +
> +				epfn = (*pfn | (~addr_mask >> PAGE_SHIFT)) + 1;
> +				ret = min_t(long, npages, epfn - *pfn);

s/long/unsigned long/?

Reviewed-by: Peter Xu <peterx@redhat.com>

> +			} else {
>  				ret = -EFAULT;
> +			}
>  		}
>  	}
>  done:
> -- 
> 2.48.1
> 

-- 
Peter Xu


