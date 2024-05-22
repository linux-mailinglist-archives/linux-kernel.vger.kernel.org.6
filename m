Return-Path: <linux-kernel+bounces-186574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411ED8CC5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643EE1C210B3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C12B1419BA;
	Wed, 22 May 2024 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZA7WQxyc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E7E1411FF
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400215; cv=none; b=spDBb+HDMHylBWUYL8O1cz3QN8RrsnnNqLDuVJDlz1N6h6Gd1wveUVlPpiMCXzUUx62WjhmD5FKopKSIwsPhyB1M/XV30TUHzQowNbXHhMy4Y1X9/ggLeMk3pxsygtMtdTWrs2JnnV+Hm9/LSh47OssOMjtc2W7VuxDjUr73LxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400215; c=relaxed/simple;
	bh=QfISmEkAy2UikSDxMwxpFJ3XyRJv0rSWJAgpnmIP9Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ut/o4pF1OQBTaY4gB0ZldCNhds7uw7kue05CvrzV9/fahn12c71lKAsvHG5QY2ksULwUBMc4wfHbywb5PrtVAenbo97n1rJe53XIIOLC75c2PeVGvogzdxZ9WGe+ugaWiyJVtGyJueaiTHcFh1P1Lt9zhAthRzYIsCLWVZad7mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZA7WQxyc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716400212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ilubpRsLuYr8UKrq5eND7D3nU7JKeM0zywpTQB+SWd0=;
	b=ZA7WQxyc5nUh/KZSHu66vCDWxoKzSmz/rkvbbSjdhpyhDWCN7lm2kCUIWwbeGMRVR9C5f0
	lNAmX8z4GJTeameekHaTEMHjbuIOVE4365KAfAkSnLtqEg5/jzNKqjFykxEVVqXLbZy2ww
	Of5KKUStutm3ZJfB2qn+iCkK+GCyNaU=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-Vz3tgq9jPPuArQ3GT6T_1g-1; Wed, 22 May 2024 13:50:10 -0400
X-MC-Unique: Vz3tgq9jPPuArQ3GT6T_1g-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-37128f4b7f9so10482545ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716400210; x=1717005010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilubpRsLuYr8UKrq5eND7D3nU7JKeM0zywpTQB+SWd0=;
        b=sSmodq4e3/+XWhfwcC0Y/Up9PrCrTTVYOOZCUkGuUVY4ru3nGhCRDgVm+K67StPaX1
         JArCzHB4xIcvlM10nAuVl1n9FnSqFdouy+Rpks69DrXDqhN3hwFmuQlK6R14Cri6Wk8f
         seb28VodSWwY9LrkyqKrmSZ4P9oB8PPQU2pAxQTX0jzH2waQbjcmwuV6DrzhNXx/Ja6P
         +hJFampi4AHk9CaP1i/dScH3jrpxF4nQ72pe4ABebKtKKZ73Ml4IFQWDr5+1u9EaI7bf
         N149cdlWMt4sfqi6VK9VytYYhapyndKYK7iCubWUXl0fKptnXqOyVqO9PJxiPzhZQY+p
         KPTg==
X-Forwarded-Encrypted: i=1; AJvYcCWYaJMaD3/Arjdu8qXnk0JCmbBprb2Vc1rDWAitFFcqb9mZcJNEmG4QdLTwfQaF5hqYpJspJgoS0i1wuCYyS1ErEg7pTen/yrJo56Sc
X-Gm-Message-State: AOJu0Yw5IwNKFl/6KYnO+ezAln4+wPwiPvu9zrVEHOjcUSIK1MPqptUq
	QMJT/PGL2X2J9xz+9WsZBya649peTgcgpOcDis0NBiolVyorkXYWij+ETy2fipkHbBiGrFxevBf
	F5bm6OeRU9r5zaYSdcWcIK2RZ+4mxYmaZt+mCiDQj/pVTTsBMhLA/gTF4qN0arRgunmKeMw==
X-Received: by 2002:a05:6e02:1486:b0:36c:4c10:dc7a with SMTP id e9e14a558f8ab-371fa87e4demr29589795ab.17.1716400209124;
        Wed, 22 May 2024 10:50:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO+onMVdyztjpr4/wGLfPQtx+lVEcSNXWuRgpWs1ZeH4h9AxTzdY5RVM/INjlUGv+knRs70g==
X-Received: by 2002:a05:6e02:1486:b0:36c:4c10:dc7a with SMTP id e9e14a558f8ab-371fa87e4demr29589615ab.17.1716400208811;
        Wed, 22 May 2024 10:50:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-48a2d42c8cesm4578870173.50.2024.05.22.10.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 10:50:08 -0700 (PDT)
Date: Wed, 22 May 2024 11:50:06 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kevin.tian@intel.com, jgg@nvidia.com,
 yishaih@nvidia.com, shameerali.kolothum.thodi@huawei.com, Peter Xu
 <peterx@redhat.com>
Subject: Re: [PATCH] vfio/pci: take mmap write lock for io_remap_pfn_range
Message-ID: <20240522115006.7746f8c8.alex.williamson@redhat.com>
In-Reply-To: <20240522-b1ef260c9d6944362c14c246@orel>
References: <20230508125842.28193-1-yan.y.zhao@intel.com>
	<20240522-b1ef260c9d6944362c14c246@orel>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hey Drew,

On Wed, 22 May 2024 18:56:29 +0200
Andrew Jones <ajones@ventanamicro.com> wrote:

> On Mon, May 08, 2023 at 08:58:42PM GMT, Yan Zhao wrote:
> > In VFIO type1, vaddr_get_pfns() will try fault in MMIO PFNs after
> > pin_user_pages_remote() returns -EFAULT.
> > 
> > follow_fault_pfn
> >  fixup_user_fault
> >   handle_mm_fault
> >    handle_mm_fault
> >     do_fault
> >      do_shared_fault
> >       do_fault
> >        __do_fault
> >         vfio_pci_mmap_fault
> >          io_remap_pfn_range
> >           remap_pfn_range
> >            track_pfn_remap
> >             vm_flags_set         ==> mmap_assert_write_locked(vma->vm_mm)
> >            remap_pfn_range_notrack
> >             vm_flags_set         ==> mmap_assert_write_locked(vma->vm_mm)
> > 
> > As io_remap_pfn_range() will call vm_flags_set() to update vm_flags [1],
> > holding of mmap write lock is required.
> > So, update vfio_pci_mmap_fault() to drop mmap read lock and take mmap
> > write lock.
> > 
> > [1] https://lkml.kernel.org/r/20230126193752.297968-3-surenb@google.com
> > commit bc292ab00f6c ("mm: introduce vma->vm_flags wrapper functions")
> > commit 1c71222e5f23
> > ("mm: replace vma->vm_flags direct modifications with modifier calls")
> >  
> 
> With linux-next I started noticing traces similar to the above without
> lockdep, since it has ba168b52bf8e ("mm: use rwsem assertion macros for
> mmap_lock"). Were there any follow ups to this? Sorry if my quick
> searching missed it.

We've been working on it in the background, but we're not there yet.  I
have a branch[1] that converts to an address space on the vfio device,
making unmap_mapping_range() available to easily zap mappings to the
BARs without all the ugly vma tracking, but that still leaves us with
the problem that the remap_pfn_range() shouldn't be called from the
fault handler resulting in this lockdep warning.  We can switch to
vmf_insert_pfn() in the fault handler, but that's a noticeable
performance penalty.

The angle I've been working recently is to try taking advantage of
huge_fault support because we do have vmf_insert_pfn_{pmd,pud}, but
these don't currently support pfnmap pfns.  I've been working with
Peter Xu as this aligns with some other work of his.  It's working and
resolves the performance issue, especially with a little alignment
tweaking in userspace to take advantage of pud mappings.

I'm not sure if there are any outstanding blockers on Peter's side, but
this seems like a good route from the vfio side.  If we're seeing this
now without lockdep, we might need to bite the bullet and take the hit
with vmf_insert_pfn() while the pmd/pud path learn about pfnmaps.
Thanks,

Alex

[1]https://github.com/awilliam/linux-vfio/commits/vfio-address-space/


