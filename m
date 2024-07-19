Return-Path: <linux-kernel+bounces-257357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD05D937901
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D837B22172
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9630D144D16;
	Fri, 19 Jul 2024 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdHkaoHH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1AE13C9A9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398420; cv=none; b=FcK1AO7EfqEbEB7x+CKFo88jshn5e1b8/6DyjwgobnB8Xp/h4+cNPzcEtU01l4bS6WxtjfQMjknRqV+S4Z3y0yPzxpxRgz5dE2wMoAfYMWcdbOW0PN93Z4I1L303YiJ4Tzh9l2vgG9b+2bL4Y5/TiX5g0mvzMswVfgGO7jV0OIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398420; c=relaxed/simple;
	bh=jxh+wvoUXJ/ykkWvN7twaD6sPLilg1Q1+5fTrjKrvbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZ5nvKHALtcYypgsiTJQ/jmcSOeHYuyMLqb/1EPhWhrUDdS0carBPqG6KFkEH3f46Nr86AGr+asQBJY/IslBu5mwYtEXORNVNILYDDWLSp0HGTYloB2Q0OCF0U9wC1Xn97Lrq41CKu1GMFtfjLK2d2vB+R26WIsg3Sv42Pa6k9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdHkaoHH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721398418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1FfwdGjf16WY/zV4TrA4eif3sm5aZVbLqK1u6/4CsU=;
	b=YdHkaoHHhM1PyliDf2Uh6r5nZwc87ZR8veDfRn6crHoan9PeA6XQFOadKGpda2dL/YhG4Q
	IuKZa4CXEUUzoTiR15EiBu2mW7hoUCtx8BgdrDP+kN4atMhN4kJWv6fxP0+MqmsPVQUSIv
	WkNwhyKR9sYyManYTjPBGAia1SQly20=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-lrPZITZOMBCOR004xjWXew-1; Fri, 19 Jul 2024 10:13:36 -0400
X-MC-Unique: lrPZITZOMBCOR004xjWXew-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e03a4bd9aa1so358659276.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721398416; x=1722003216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1FfwdGjf16WY/zV4TrA4eif3sm5aZVbLqK1u6/4CsU=;
        b=edOWn44e51OzJw4NVUmWsT10AwiuBYES44MFrztlFGRpBwGz4rz6t/5ROcY5fWaJ+b
         ERX27dvxTGZKXEzSPzZ0RhoznEZOOkioJgq89/1nyhUUgRcmHediBrjMBbsvOlR2HHqE
         urBqej3TnqJRnHYjbNyXaT0LUuJxtUAR6FOaNC9v2JgzCC29kV5fapya2ec93apZX+se
         vFeEXVRA2CwOBlNrVyJDFbqjRiSly5IvMgYoMQhLyAmLGmcKXXNMQo+cYzcKSFaAcalX
         mlOHgYKIRei37BjuBMXE03dT9cZj8WcpAbdS1/BaUb8NXESy+xuwSL6wpVOagdfYLi6e
         YK5g==
X-Forwarded-Encrypted: i=1; AJvYcCV79DeydJzrj3PETSyHuinCOuGZ20i+gNnDrePnEaCB7+ztMqF6VY0zq+iYEF8AB25jHsRK9FJSC0rZEpFLFW5d3PyRfxfoOMBA9rgl
X-Gm-Message-State: AOJu0Yw4j4kbUDxaImetDPjtnlEeZm3B5GRw/ghUtDEe2bmR+jst26Fr
	5a1p89j+vE+xsfa2/XL9qHKjoYNAvEdJeDGbICqNp9vKAMgjwE3xcvgfPmbD4t4TEC0lx9Zv6F5
	0xkRuZdvzsb0h+enwVd1cIcIHSncVDRocGgMTbmzmoma9lnc+oCY+UA95d14ofw==
X-Received: by 2002:a05:6902:2488:b0:e05:900d:fd0 with SMTP id 3f1490d57ef6-e085eb77f95mr1256636276.7.1721398416263;
        Fri, 19 Jul 2024 07:13:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqRQqZhbEi7fVfXy/c4++jqj17huWfx4L8tNoYGCaGB3uCWrspRd8fVFYNS1OuD4m6+W7Trg==
X-Received: by 2002:a05:6902:2488:b0:e05:900d:fd0 with SMTP id 3f1490d57ef6-e085eb77f95mr1256603276.7.1721398415823;
        Fri, 19 Jul 2024 07:13:35 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cdc3004sm7393421cf.80.2024.07.19.07.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 07:13:35 -0700 (PDT)
Date: Fri, 19 Jul 2024 10:13:33 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
	David Wang <00107082@163.com>, Bert Karwatzki <spasswolf@web.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <Zpp0jX_x2awQk6Nj@x1n>
References: <ZpTLCscCFGtsrEjC@yzhao56-desk>
 <ZpUyZ9bH1-f5y5XG@x1n>
 <ZpY5uU2NyOoMVu5A@yzhao56-desk>
 <ZpbDnoQxGubegtu-@x1n>
 <Zpcgmk6wexTKVv2E@yzhao56-desk>
 <ZpfR_L9wtuXhtSGk@x1n>
 <Zph051h5BsSFMpR6@yzhao56-desk.sh.intel.com>
 <ZpkglfpbHH7lQSft@x1n>
 <Zpmi2JWirNDiJz+7@yzhao56-desk.sh.intel.com>
 <1a0884cb-39ed-455e-a505-7c1b2a0e5225@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a0884cb-39ed-455e-a505-7c1b2a0e5225@redhat.com>

On Fri, Jul 19, 2024 at 10:28:09AM +0200, David Hildenbrand wrote:
> On 19.07.24 01:18, Yan Zhao wrote:
> > On Thu, Jul 18, 2024 at 10:03:01AM -0400, Peter Xu wrote:
> > > On Thu, Jul 18, 2024 at 09:50:31AM +0800, Yan Zhao wrote:
> > > > Ok. Then if we have two sets of pfns, then we can
> > > > 1. Call remap_pfn_range() in mmap() for pfn set 1.
> > > 
> > > I don't think this will work..  At least from the current implementation,
> > > remap_pfn_range() will only reserve the memtype if the range covers the
> > > whole vma.
> > Hmm, by referring to pfn set 1 and pfn set 2, I mean that they're both
> > covering the entire vma, but at different times.
> > 
> > To make it more accurately:
> > 
> > Consider this hypothetical scenario (not the same as what's implemented in
> > vfio-pci, but seems plausible):
> > 
> > Suppose we have a vma covering only one page, then
> > (1) Initially, the vma is mapped to pfn1, with remap_pfn_range().
> > (2) Subsequently, unmap_single_vma() is invoked to unmap the entire VMA.
> > (3) The driver then maps the entire vma to pfn2 in fault handler
> > 
> > Given this context, my questions are:
> > 1. How can we reserve the memory type for pfn2? Should we call
> >     track_pfn_remap() in mmap() in advance?
> > 2. How do we untrack the memory type for pfn1 and pfn2, considering they
> >     belong to the same VMA but mutual exclusively and not concurrently?
> 
> Do we really have to support such changing PFNs in a VMA? Are there existing
> use cases that would rely on that?

I share the same question with David.  I don't think we support that, and I
don't know whether we should, either.

Such flexibility already will break with current PAT design.  See:

untrack_pfn:
	if (!paddr && !size) {
		if (get_pat_info(vma, &paddr, NULL))
			return;
		size = vma->vm_end - vma->vm_start;
	}
	free_pfn_range(paddr, size);  <---- assumes PFNs to be continuous

So untrack_pfn() already assumed the pfn being continuous.  I think it
means pfns cannot be randomly faulted in, but determined when mmap().

Thanks,

-- 
Peter Xu


