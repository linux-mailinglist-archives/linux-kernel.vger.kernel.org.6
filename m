Return-Path: <linux-kernel+bounces-259027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0E2939029
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041881C2146A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7361816D9C6;
	Mon, 22 Jul 2024 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSsz0Ml1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052D16C865
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721656336; cv=none; b=Wnp8sasaTdW2pUSt8cySGM9ixqBOcGkwK0tdnib44uNAmUenZBCPYDRaYw+X+cHedK0HHqSZN/NDVxF+yMIe1XHSCNE3o15tLyYk9cEStFjcUcMbyobMEcxwpPx98Zg0fKCLr396im0gWtTl2toI+n8V25NNg2rS1eyOQXS3ZZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721656336; c=relaxed/simple;
	bh=LJwtEK+2GBe6DokKe74qwGP1kY2Pe1Tsf76JFYP6/Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyOpRqDoHQTSckIlXrlW53ewVzlz/PELFh2UyHoFnhsCSE8Zk5XM4TBNjOTc7MqKBKvRAYtL6L0zSheMK4B/CO8Up79LcWdAOTC2OntOKPcFQj2GAmife5rfANu50ZcHpwoU670UCRpn/QvBddgJDEtZ3M2WG7z6ehyKs8FWLNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SSsz0Ml1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721656333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CqewATc2Z5Y0oifjk9JwNW+cFpf4TyaY2cbgESbwaag=;
	b=SSsz0Ml1dp35Krlu/xm3r1SL9Jo8gVAgVekDtC3bMBGeo4wI2wfWOe/WDLW/VVdviHeNMp
	V3+2cw5QeHFIl51c55LZeKoSPSEvh8KzPKXP2NHHv9MJBMPliFrh3Vratea3B4ouAGz8Ez
	VmK0uKBwpKkGU5YOQL6w6qmICG5LF2k=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-jkTgzOqiNDCIm_6WkfndQw-1; Mon, 22 Jul 2024 09:52:12 -0400
X-MC-Unique: jkTgzOqiNDCIm_6WkfndQw-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4f51750bf08so43406e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721656331; x=1722261131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqewATc2Z5Y0oifjk9JwNW+cFpf4TyaY2cbgESbwaag=;
        b=jQC/zJg0vgKUqqxEkbU+cAziIOcG4Rw3pShIUQPdHTMk+BEWOg0ZFbBkGCZIQzPDrd
         606NF6dsxrZPdxlDaWGznmq+cvXyLbX+zEu3klNa0q9CXiuBYWFsBXt7Py90wWidkl/1
         7lI3jzYdv0RPPuqJZqR5aJd2p6W5MvHYDyseT5DSPVB4jlA+86Jn4jlgolQmdXKLcd+l
         0i/vyjUllU+2vU9+0HBzuwjZc2AaGnFAgChWCLyVZcIaQLKCNursNMsqo3R5VVeAigu8
         DHQNJ2lu1JXEUhP33l891MrzDwoziVk5UIVl+/jOM57oKR43w3leInfOd/hifPaoqDYX
         uong==
X-Forwarded-Encrypted: i=1; AJvYcCX7hO9wpCzWUsW7U1Rufp0TJVP7QJFMmMQLbrEVvwJ+iyKZjAdIWKTBCBpfdfThUoIs4knZVVZz6sVOUV2vDyWc44xfz/5lE8ZATuO5
X-Gm-Message-State: AOJu0YzYLH5V7dXx8ShbpzLHHWhiZGWrFKXqjlkuYzFa+48gBnlZDHp9
	BA8zmOEbHwfN0w3mWS2H+4GW33mthMd2ybnnJucPuvaTH2lPdH0zEWi8a6irN9VlTDdjNpSGtGG
	MrKl0HchpQnDkSwkMQE1SaEdhfAe9wL0WEQv51+FSXwO90/w1oreODMSJZBHDKQ==
X-Received: by 2002:a05:6122:3389:b0:4f5:19d0:17a9 with SMTP id 71dfb90a1353d-4f519d018efmr1890353e0c.1.1721656331406;
        Mon, 22 Jul 2024 06:52:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYJ6qAtUvIlmu+E8dfSAtWy9mWi+MkTv/N/grUnBegwQBmHFkWvDlpjnrosFZ11UuiwLaucQ==
X-Received: by 2002:a05:6122:3389:b0:4f5:19d0:17a9 with SMTP id 71dfb90a1353d-4f519d018efmr1890326e0c.1.1721656330946;
        Mon, 22 Jul 2024 06:52:10 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1990136f1sm362390085a.71.2024.07.22.06.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 06:52:10 -0700 (PDT)
Date: Mon, 22 Jul 2024 09:52:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: David Hildenbrand <david@redhat.com>,
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
Message-ID: <Zp5kCF1-cWrcnMrg@x1n>
References: <ZpY5uU2NyOoMVu5A@yzhao56-desk>
 <ZpbDnoQxGubegtu-@x1n>
 <Zpcgmk6wexTKVv2E@yzhao56-desk>
 <ZpfR_L9wtuXhtSGk@x1n>
 <Zph051h5BsSFMpR6@yzhao56-desk.sh.intel.com>
 <ZpkglfpbHH7lQSft@x1n>
 <Zpmi2JWirNDiJz+7@yzhao56-desk.sh.intel.com>
 <1a0884cb-39ed-455e-a505-7c1b2a0e5225@redhat.com>
 <Zpp0jX_x2awQk6Nj@x1n>
 <Zp4A6HNhamaNQJOL@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zp4A6HNhamaNQJOL@yzhao56-desk.sh.intel.com>

On Mon, Jul 22, 2024 at 02:49:12PM +0800, Yan Zhao wrote:
> On Fri, Jul 19, 2024 at 10:13:33AM -0400, Peter Xu wrote:
> > On Fri, Jul 19, 2024 at 10:28:09AM +0200, David Hildenbrand wrote:
> > > On 19.07.24 01:18, Yan Zhao wrote:
> > > > On Thu, Jul 18, 2024 at 10:03:01AM -0400, Peter Xu wrote:
> > > > > On Thu, Jul 18, 2024 at 09:50:31AM +0800, Yan Zhao wrote:
> > > > > > Ok. Then if we have two sets of pfns, then we can
> > > > > > 1. Call remap_pfn_range() in mmap() for pfn set 1.
> > > > > 
> > > > > I don't think this will work..  At least from the current implementation,
> > > > > remap_pfn_range() will only reserve the memtype if the range covers the
> > > > > whole vma.
> > > > Hmm, by referring to pfn set 1 and pfn set 2, I mean that they're both
> > > > covering the entire vma, but at different times.
> > > > 
> > > > To make it more accurately:
> > > > 
> > > > Consider this hypothetical scenario (not the same as what's implemented in
> > > > vfio-pci, but seems plausible):
> > > > 
> > > > Suppose we have a vma covering only one page, then
> > > > (1) Initially, the vma is mapped to pfn1, with remap_pfn_range().
> > > > (2) Subsequently, unmap_single_vma() is invoked to unmap the entire VMA.
> > > > (3) The driver then maps the entire vma to pfn2 in fault handler
> > > > 
> > > > Given this context, my questions are:
> > > > 1. How can we reserve the memory type for pfn2? Should we call
> > > >     track_pfn_remap() in mmap() in advance?
> > > > 2. How do we untrack the memory type for pfn1 and pfn2, considering they
> > > >     belong to the same VMA but mutual exclusively and not concurrently?
> > > 
> > > Do we really have to support such changing PFNs in a VMA? Are there existing
> > > use cases that would rely on that?
> > 
> > I share the same question with David.  I don't think we support that, and I
> > don't know whether we should, either.
> > 
> > Such flexibility already will break with current PAT design.  See:
> Previously with remap_pfn_range() being able to be called in fault handlers,
> this flexibility is doable. i.e. reserve in the fault handler and untrack
> in unmap_single_vma().

AFAICT, remap_pfn_range() should never be allowed to be called in a fault
handler..  So IMO it's not "it was allowed before", but we did it wrong
from when we used it in fault path: remap_pfn_range() changes VMA flags
since the 1st day, and that requires a writable lock, while fault paths
only hold it read..

I think it's just that the per-vma lock was added a few years ago (then
some lock attestations on vma lock v.s. vma flag changes), and until then
we found this issue.

-- 
Peter Xu


