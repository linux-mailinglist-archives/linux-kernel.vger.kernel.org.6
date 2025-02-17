Return-Path: <linux-kernel+bounces-518388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFD1A38E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29EF67A2AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139421A5BB6;
	Mon, 17 Feb 2025 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HR+R4ZLu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417619CD19
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739829151; cv=none; b=pRvA+cZAXFtFsYgehq2aKyW85Jml0dPoFxreNWcTYbcOOhaqTE+h6GSRRwhd2j55mQms2CVYpVI3cGpq88AOGL3uAXzL3RtY87R9wHTW8cNR560VH7wMCkFvqLAEiy+z/pjznrE1u4+cSdmSh2veRc3pXukvX8ULQlnn6v52cLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739829151; c=relaxed/simple;
	bh=5A/eoP0FjR04mTWc33USNK/LsikyDThap9qxzPVPIDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2LNF+wQs9xQLuYVktJZfHDoskMGPpWhoBfZmWGP2wShMlvh1cCTVZgx6xTdCai2ZBbyJ/VSU9ovRXqPZ4ZI/3H4HTbp/SxwYGM+wn2zhoQ1B8wAzIp0w6VkXUVnBWpKCqGUpI8YAPMcXcrMoNSeRdwhw3yxfyFdVxvtuFySEKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HR+R4ZLu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739829148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SxDh0EJ+8MUCjnDi1tBCK0C6PrjOgADbhlB47WIcbEI=;
	b=HR+R4ZLuiop9hUXsdYJchr+A2Xx0pG/2tAZhkvHMZGEk5SXzPPQDA7HVCcZCxHiGQXDN8C
	A1GVdgcjjKDavlWUu5F7jCBvrxy5KM+YNFUUtJ+D6U8DdMnKX2b4C+xmcEo1IvnKf/vlmx
	N2C/8S2HeiXJ/++GGeRZ1OuirZnovMs=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-Rsh9LIkfNRuUwM4Mju-_2w-1; Mon, 17 Feb 2025 16:52:27 -0500
X-MC-Unique: Rsh9LIkfNRuUwM4Mju-_2w-1
X-Mimecast-MFC-AGG-ID: Rsh9LIkfNRuUwM4Mju-_2w_1739829146
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d18f59b9d0so3747545ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739829146; x=1740433946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxDh0EJ+8MUCjnDi1tBCK0C6PrjOgADbhlB47WIcbEI=;
        b=vMEEX351yI89Tex69Z4M7ihvF4kUdn+r/PunX+UA6ByG6nTXQz8cT02JhVE44SVN92
         FjRojc0Clyp1g3B/Ai1YrxrnNe9YP86I7Jzva8EvmWY+Jasa2EmlnnZUO9S2/IJloLK8
         z/4CuxgG36rbFGAl1xhgURqaHNRMUIVPxyPJ+PBXz+CR4Cf9W7yBd/NY5sKABOi6kHEk
         nME2W0qCBOpH9SD5HNYzqKYLrNI68IAiEBtPF+HC6h1DPAWuO7ozBOWJeru+/tQ44R9J
         j5NPfHsFNxQrjEBS8h1P73vhq6mQjxqlYE4HC8//ySW6yx+9gcShOitHJU9hfRZkGNQU
         yNGA==
X-Forwarded-Encrypted: i=1; AJvYcCWlSEdc5xHKTZlRw5iBMe0UEHS9I1apLfssqc+lYgqN5/BCDQfvHzPiBHiTRnpmPA9Io6A8ng0dumpWGXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNdBM1StYcs/hHg9BzhH5I4lWhaeLZNGMwEbgEaRoAzwiTC1Pf
	VfWFZWMHhtHDEQ+5F2CAEKaP71512b3MA9+G623zINeIu86SHbcs/2hukGzuCSjKVm5AcqvC+73
	OfMaXxedRrrgvH54tddb+aA+V3eUytz9y86l9NtPyexYIJsahg5S+hdlQtNXFiQ==
X-Gm-Gg: ASbGncuKmIZKz2kb0diOxnefS1p3Q9aL8HJfJyE3//BDGudVDVsA83qH4qHw7AOTTlA
	JNvMVQj6dvHvPWr3i1oN3CVojW6Ec/n1Z++UEzCr+nZbfGkJPN6uA9zM3Kc1I1BsHAOQS7UwEGN
	2m1zO6Cbv37uyRf/pwFfogi3OHntR4dr10R3sRf2ZfmdQ6Qy6g1caYNOTvPZ4iAAOa/eIGM7vg8
	5CRJjfqBOAfnpduYS344QhFyJx1iJZDi6VHriMyp0pbhNJpLs6cEeIhQRqUDSfJ1G9QFg0zUs1B
	sHb4Njnp
X-Received: by 2002:a05:6e02:8:b0:3d1:9236:ca49 with SMTP id e9e14a558f8ab-3d2796851eamr27424035ab.0.1739829146277;
        Mon, 17 Feb 2025 13:52:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFP4VXmbfSBjTKUdOsf+KSjwWeNwg2r4M9vtE2mjCOTGm7KPENFhTB2d63tVL9BSSKWgsj0lA==
X-Received: by 2002:a05:6e02:8:b0:3d1:9236:ca49 with SMTP id e9e14a558f8ab-3d2796851eamr27423965ab.0.1739829145936;
        Mon, 17 Feb 2025 13:52:25 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d28b060646sm10369835ab.16.2025.02.17.13.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 13:52:24 -0800 (PST)
Date: Mon, 17 Feb 2025 14:52:21 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterx@redhat.com,
 mitchell.augustin@canonical.com, clg@redhat.com, akpm@linux-foundation.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 5/5] vfio/type1: Use mapping page mask for pfnmaps
Message-ID: <20250217145221.20f17b7a.alex.williamson@redhat.com>
In-Reply-To: <20250214192704.GD3696814@ziepe.ca>
References: <20250205231728.2527186-1-alex.williamson@redhat.com>
	<20250205231728.2527186-6-alex.williamson@redhat.com>
	<20250214192704.GD3696814@ziepe.ca>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 15:27:04 -0400
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Feb 05, 2025 at 04:17:21PM -0700, Alex Williamson wrote:
> > @@ -590,15 +592,23 @@ static int vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
> >  	vma = vma_lookup(mm, vaddr);
> >  
> >  	if (vma && vma->vm_flags & VM_PFNMAP) {
> > -		ret = follow_fault_pfn(vma, mm, vaddr, pfn, prot & IOMMU_WRITE);
> > +		unsigned long pgmask;
> > +
> > +		ret = follow_fault_pfn(vma, mm, vaddr, pfn, &pgmask,
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
> > +				epfn = (((*pfn << PAGE_SHIFT) + ~pgmask + 1)
> > +					& pgmask) >> PAGE_SHIFT;  
> 
> That seems a bit indirect
> 
>  epfn = ((*pfn) | (~pgmask >> PAGE_SHIFT)) + 1;
> 
> ?

That is simpler, for sure.  Thanks!

> > +				ret = min_t(int, npages, epfn - *pfn);  
> 
> It is nitty but the int's here should be long, and npages should be
> unsigned long..

Added a new patch that uses unsigned long consistently for passed page
counts and long for returns.  Now we just need a system with a 16TiB
huge page size.  Thanks,

Alex


