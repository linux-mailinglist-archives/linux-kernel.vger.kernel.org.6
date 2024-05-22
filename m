Return-Path: <linux-kernel+bounces-186679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2738CC76B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECEA2820A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8599D145A11;
	Wed, 22 May 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpFzCOV1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431AB2D7B8
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406993; cv=none; b=Qugzpkm5alHke6TjANHBMxkJYDCrGzvgDHTHawlLrsVsoFcGjTOIq6ILlZkJTU+RTtT2EqBnRufcu5HNT8205HsIaZDUzAGznu27SZuL5dXBU/akuLzQTxNqk7tu8BONTjNbb6bfj8Ea6hSbJqoDzBX0DpTy6Q+HAfJEp7H2b1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406993; c=relaxed/simple;
	bh=3gnbJKlJ+lpkI6N28w+IG+DueXgPDUc6asyf6klnIPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJlkbFm7impte+JUr0zwUqqpv2JofW93krjxYIkKNQ5YBByiC7FydpJl59KHacVGtzE3EK4uGe9qphD+v9jGUWaFFiY6WYkLHxHBnTVcnMJPMJoPPz1jukW7mtrZsgs1KI6k7vcom0TtE56muhzLQZBzcf60055A/jq28GCbUb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpFzCOV1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716406991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BqtiRpqfQv73C5Zwn5wS3bvroEy21cCrfxMP439njVk=;
	b=GpFzCOV15m88sK4jMQVYlpHQQf1QrbStJZQ0M9n1rgmAEf6IuNvc6xKfju5LU8H5iAktgs
	UQIp0BZxsOFAVDnkDQs4tiC3JIeWsrnyCMmFq+YCwqGTjFBn7LFrLiUkZ/70zk9KzbKEnT
	nvYU6dxbmP3cn/5lbv4fSCCd88wB+aw=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-_mK1yto4MrOO8cHgEwZBow-1; Wed, 22 May 2024 15:43:09 -0400
X-MC-Unique: _mK1yto4MrOO8cHgEwZBow-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36c80ee383eso8650705ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716406989; x=1717011789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqtiRpqfQv73C5Zwn5wS3bvroEy21cCrfxMP439njVk=;
        b=Dd3jGt6hsgvlrZyKjJLYRLr+w4ulchao0R9Gjb5rJXwNKUawZONgX3y2NotAr3gb2e
         Nu+2AlFfRoYns58WSnpvxfnEKXaIRjPeCbwl2rRtRdmaA131SXPV+jKThDT6liTqby5U
         P6vU61RcVIDA0tXCs0naeH4ouSe9ORnIgvEhzrh+2FD2fVogp9G5yPuiTfgC1BXAc84/
         niKw1ICyvBLL+zDUSQd6amZ0ycBrJIGLvvobA3u513UAJZXFLKWhgumt4aQTX9bt2uCU
         7/qgByGrwE9jAF/LzZQoMa+wc9q4byXdXr0mCzz68RCylmdI/apDCGk85dK97WFgraqf
         speA==
X-Forwarded-Encrypted: i=1; AJvYcCWe85wXcJFQgFJwlSKDVA1GWsITWbYRIG/qnMwRr7hrwDJr3gIfg573x6KEoYbVyzK0OlRKp4KHXXRW6UMKdOGfuxJUz1BhWXMGD3dO
X-Gm-Message-State: AOJu0YwQgL8Pm+sE15f60U69oUTCImCLkTsQud/sUy0vlIWSP9VNIXBR
	buzvRIhxo9GEXvpTs9UgS3ayhEk+TklI6sslOH1cCHIdjCHJP6aG5PRU8sihOA6zTVkxEsTyUFv
	uxZ6aqAvV5UvSVSBdYyA4o0sIf8I9xqHIBx2zAk2qYqg8y96wCseVdivop86I6w==
X-Received: by 2002:a05:6e02:2145:b0:371:9d75:ac27 with SMTP id e9e14a558f8ab-371f664df6amr34301465ab.0.1716406988929;
        Wed, 22 May 2024 12:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtjLm3yGleRwm+mBJukESjCnsEgk5gm1vxnO69ba+V7MWwAirl7eW+fiWVXhmemQycDH2big==
X-Received: by 2002:a05:6e02:2145:b0:371:9d75:ac27 with SMTP id e9e14a558f8ab-371f664df6amr34301375ab.0.1716406988632;
        Wed, 22 May 2024 12:43:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9db0a02sm71839685ab.51.2024.05.22.12.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 12:43:07 -0700 (PDT)
Date: Wed, 22 May 2024 13:43:06 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, Yan Zhao <yan.y.zhao@intel.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.tian@intel.com,
 yishaih@nvidia.com, shameerali.kolothum.thodi@huawei.com, Peter Xu
 <peterx@redhat.com>
Subject: Re: [PATCH] vfio/pci: take mmap write lock for io_remap_pfn_range
Message-ID: <20240522134306.11350e13.alex.williamson@redhat.com>
In-Reply-To: <20240522183046.GG20229@nvidia.com>
References: <20230508125842.28193-1-yan.y.zhao@intel.com>
	<20240522-b1ef260c9d6944362c14c246@orel>
	<20240522115006.7746f8c8.alex.williamson@redhat.com>
	<20240522183046.GG20229@nvidia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 May 2024 15:30:46 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 22, 2024 at 11:50:06AM -0600, Alex Williamson wrote:
> > I'm not sure if there are any outstanding blockers on Peter's side, but
> > this seems like a good route from the vfio side.  If we're seeing this
> > now without lockdep, we might need to bite the bullet and take the hit
> > with vmf_insert_pfn() while the pmd/pud path learn about pfnmaps.  
> 
> There is another alternative...
> 
> Ideally we wouldn't use the fault handler.
> 
> Instead when the MMIO becomes available again we'd iterate over all
> the VMA's and do remap_pfn_range(). When the MMIO becomes unavailable
> we do unmap_mapping_range() and remove it. This whole thing is
> synchronous and the fault handler should simply trigger SIGBUS if
> userspace races things.
> 
> unmap_mapping_range() is easy, but the remap side doesn't have a
> helper today..
> 
> Something grotesque like this perhaps?
> 
> 	while (1) {
> 		struct mm_struct *cur_mm = NULL;
> 
> 		i_mmap_lock_read(mapping);
> 		vma_interval_tree_foreach(vma, mapping->i_mmap, 0, ULONG_MAX) {
> 			if (vma_populated(vma))
> 				continue;
> 
> 			cur_mm = vm->mm_struct;
> 			mmgrab(cur_mm);
> 		}
> 		i_mmap_unlock_read(mapping);
> 
> 		if (!cur_mm)
> 			return;
> 
> 		mmap_write_lock(cur_mm);
> 		i_mmap_lock_read(mapping);
> 		vma_interval_tree_foreach(vma, mapping->i_mmap, 0, ULONG_MAX) {
> 			if (vma->mm_struct == mm)
> 				vfio_remap_vma(vma);
> 		}
> 		i_mmap_unlock_read(mapping);
> 		mmap_write_unlock(cur_mm);
> 		mmdrop(cur_mm);
> 	}

Yes, I've played with similar it's a pretty ugly and painful path
versus lazily faulting.

> I'm pretty sure we need to hold the mmap_write lock to do the
> remap_pfn..
> 
> vma_populated() would have to do a RCU read of the page table to check
> if the page 0 is present.
> 
> Also there is a race in mmap if you call remap_pfn_range() from the
> mmap fops and also use unmap_mapping_range(). mmap_region() does
> call_mmap() before it does vma_link_file() which gives a window where
> the VMA is populated but invisible to unmap_mapping_range(). We'd need
> to add another fop to call after vma_link_file() to populate the mmap
> or rely exclusively on the fault handler to populate.

Thanks, the branch I linked added back remap_pfn_range() on mmap,
conditional on locking/enabled, but I've predominantly been testing
with that disabled to exercise the pmd/pud faults.  I would have missed
the gap vs unmap_mapping_range().

It's hard to beat the faulting mechanism from a simplicity standpoint,
so long as the mm folks don't balk at pfnmap faults.  I think the vma
address space walking ends up with tracking flags to avoid redundant
mappings that get complicated and add to the ugliness.  The mm handles
all that if we only use faulting and we get a simple test on fault to
proceed or trigger a SIGBUS.  Using pmd/pud faults should have some
efficiency benefits as well.  Thanks,

Alex


