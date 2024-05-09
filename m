Return-Path: <linux-kernel+bounces-174526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827ED8C101B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47CA1C2039C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06E114EC71;
	Thu,  9 May 2024 13:07:06 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CE513B590
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260026; cv=none; b=qQy2raYILvgAVkFNjOzoQVDoC8P36WOg6JKbAczI4NwZqnamoRfE0s9AAs/O18dVxYazh60YSyFir4p3KnTlMBfLgd7HZCMFpWoPScrpOjz15n/3IH1AcCQgBpI3QjiSONayBzibJ63vCtjzUu6/C4Vg2DTcIRbE8yJf5cpJzCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260026; c=relaxed/simple;
	bh=haMixcEcAs3HRy/qL9tRsAFgidrplGeqcru9vIKYGS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpEmy2mZ/G7834KnOT+2LIfY2Y5cvfl7nw9Pjtbv9P0FQXGTiyqInmdCNcE08Dve3l/VkDB3F/yO4Y2L7shKp3NmRaXaM1O+75JXBYPq3L8/IWtsMHTCT3D9UHSKUwOmNqrKt0vSRbsCEbNYoZlPGxeJrckEXwmgjAkgfh0OTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 14E8568C7B; Thu,  9 May 2024 15:07:00 +0200 (CEST)
Date: Thu, 9 May 2024 15:06:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, isaacmanjarres@google.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
Message-ID: <20240509130659.GA12345@lst.de>
References: <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com> <20240506160244.GA16248@lst.de> <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com> <20240506161906.GA17237@lst.de> <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com> <20240507054314.GA31814@lst.de> <CABdmKX3PgcXaRUH3L7OV+POMiMd5L6pEF4fLXYPgfmQUNu_trg@mail.gmail.com> <Zju0JOx_ij1qH-34@arm.com> <CABdmKX3LANk-0ThrQ86ay5EnToM38gVH3oddBUnXq=9cmS0gCQ@mail.gmail.com> <ZjyAFE4Fk_r7KnDA@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjyAFE4Fk_r7KnDA@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 09, 2024 at 08:49:40AM +0100, Catalin Marinas wrote:
> I see the swiotlb use as some internal detail of the DMA API
> implementation that should not leak outside this framework.

And that's what it is.

> I think we should prevent bouncing if DMA_ATTR_SKIP_CPU_SYNC is passed.
> However, this is not sufficient with a proper use of the DMA API since
> the first dma_map_*() without this attribute can still do the bouncing.
> IMHO what we need is a DMA_ATTR_NO_BOUNCE or DMA_ATTR_SHARED that will
> be used on the first map and potentially on subsequent calls in
> combination with DMA_ATTR_SKIP_CPU_SYNC (though we could use the latter
> to imply "shared"). The downside is that mapping may fail if the
> coherent mask is too narrow.

We have two big problems here that kinda interact:

 1) DMA_ATTR_SKIP_CPU_SYNC is just a horrible API.  It exposes an
    implementation detail instead of dealing with use cases.
    The original one IIRC was to deal with networking receive
    buffers that are often only partially filled and the networking
    folks wanted to avoid the overhead for doing the cache operations
    for the rest.  It kinda works for that but already gets iffy
    when swiotlb is involved.  The other abuses of the flag just
    went downhill form there.

 2) the model of dma mapping a single chunk of memory to multiple
    devices is not really well accounted for in the DMA API.

So for two we need a memory allocator that can take the constraints
of multiple devices into account, and probably a way to fail a
dma-buf attach when the importer can't address the memory.
We also then need to come up with a memory ownership / cache
maintenance protocol that works for this use case.

