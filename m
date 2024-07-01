Return-Path: <linux-kernel+bounces-235593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6763C91D71C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE4E28522C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7344F1E2;
	Mon,  1 Jul 2024 04:36:23 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB94BAA6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719808582; cv=none; b=CcUwQiYgIDhsDq2UrO23FbsWOqQMwZognU1S2zBrVzfaJylSvl5FBKPK1Sgvze1HwIyW31aUwLBOc+PkGdxXHBVcI/S/+dvHnruon84crZh6CGWjJl5grZJgcGcki/gyT4t5MWHKBu/wwjxOO7KOOAe2qu4sCA31o1Fj1eUi1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719808582; c=relaxed/simple;
	bh=ZfUYzDsqoUu8iG+mT+GHdkAbo+c3ZwFl62Xdwl+Pt+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTs7E3vsD1jQKIyZ6w4SWWYHWo6R6R9ZgVyXuPQbJFgj590UOTSTUzGwL0KzM5evGVJ0SMqfbF/GiOw+IM4k68lF1hW6TTc/K33iRIE4SI8zkBgZZ1/T6YqTtwkc32GDkVPturV0/ceylzg3nrxf8nNeRrN5w3UO+5z10qXz3UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 86AF568BEB; Mon,  1 Jul 2024 06:36:15 +0200 (CEST)
Date: Mon, 1 Jul 2024 06:36:15 +0200
From: "hch@lst.de" <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "hch@lst.de" <hch@lst.de>,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"jgross@suse.com" <jgross@suse.com>,
	"sstabellini@kernel.org" <sstabellini@kernel.org>,
	"oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [RFC 1/1] swiotlb: Reduce calls to swiotlb_find_pool()
Message-ID: <20240701043615.GB26372@lst.de>
References: <20240627060251.GA15590@lst.de> <20240627085216.556744c1@meshulam.tesarici.cz> <SN6PR02MB4157E61B49C8435E38AC968DD4D72@SN6PR02MB4157.namprd02.prod.outlook.com> <20240627152513.GA23497@lst.de> <SN6PR02MB4157D9B1A64FF78461D6A7EDD4D72@SN6PR02MB4157.namprd02.prod.outlook.com> <20240628060129.GA26206@lst.de> <20240628094708.3a454619@meshulam.tesarici.cz> <SN6PR02MB415781789CBD6597142BEC68D4D12@SN6PR02MB4157.namprd02.prod.outlook.com> <20240630055542.GA5379@lst.de> <SN6PR02MB415735CA2F5487AE3FD74FFED4D22@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415735CA2F5487AE3FD74FFED4D22@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jun 30, 2024 at 02:02:52PM +0000, Michael Kelley wrote:
> 1) Rename is_swiotlb_buffer() to swiotlb_find_pool(), since it
> now returns a pool.  A NULL return value indicates that the
> paddr is not an swiotlb buffer.
> 
> 2) Similarly, rename is_xen_swiotlb_buffer() to
> xen_swiotlb_find_pool()
> 
> 3) The existing swiotlb_find_pool() has the same function signature,
> but it is used only where the paddr is known to be an swiotlb buffer
> and hence always succeeds. Rename it to __swiotlb_find_pool() as
> the "internal" version of swiotlb_find_pool().

Sounds good.

> 4) Do you still want is_swiotlb_buffer() as a trivial wrapper around
> the new swiotlb_find_pool(), for use solely in dma_direct_need_sync()
> where only a Boolean is needed and not the pool?

If there is really just a single caller left we can skip the wrapper,
otherwise it might be handy.


