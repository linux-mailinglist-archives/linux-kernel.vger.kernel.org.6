Return-Path: <linux-kernel+bounces-276321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 254B294920E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83921F25F9A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C6B1EA0C4;
	Tue,  6 Aug 2024 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cwDiuym1"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566281D6181
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952222; cv=none; b=Fgrk0jOz/K3+BqLrKy+rbQpRJwB4V3c+7gGLl+283QuE4TJXmevDCDWMZMRRzfNAZiZ4fA7ZtuZ/FWqe61RK0/ATM9bYvCMEzKraRBsCJ/iDW2YID0D5QknHk47PTbDi9HWJt3XUe4ol85pUeYeiRD4pCZjR/RYLhkRfDlogLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952222; c=relaxed/simple;
	bh=6LTC6KOfM2FqDhCDfpj0QbTSvrl9G+TDtoFrlfco60A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImeqfVGdFQkCqHvFTkZKe5YIYoVLHJvwOLMRMPY+C1RrrbMrSRr+7GJrmOZoYAdFZrpJylkRde7ofodYsAHL5zDiKUq9sGuVWH43X3eriRSYv8DYZWXMkF3vnzMyA3k+goqUoHfdWHenENV4KCFv5iH6K7wKPRnsDx74FD52e6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cwDiuym1; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79ef72bb8c8so15303785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722952219; x=1723557019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2kNYFdUzIZckzr3QKa/r5YhJFKngLkpH0UbHOtP19M=;
        b=cwDiuym1ZZnmuvflqrbcDAkGNBwfH1ZolwIvZlXyGEoxIi9Ao1MVsWiaWWstl0m6T+
         FWrM6rQv3h6OQyQ8XHfc4W97Vr6z7HZ/PaICNveZDYAlQ8j1iitaWDI9mHVcRK9lCTno
         qcnSyGC8tPLFmichWiCDCOXCVFItwCaZ4ZLycGJ0JboqmIs5ngclj+TJK3l7MKlv7XN3
         rLdvdMFaZMt07fLF2mY5kvjfxYRYsqKnQU2GrffRknIi/PMU3sSh9OBwC9ozdoyUwWzQ
         XSN2foxKwMfqH1toLNHB8Vwmm7A3Iis47iYHe42o9rnfxcHciy+8lYMu2ZM2MXROUXtX
         ZCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952219; x=1723557019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2kNYFdUzIZckzr3QKa/r5YhJFKngLkpH0UbHOtP19M=;
        b=FDWq1ZzeG7V8stNRuWYojDu0xJpw0Ra3mRs88R7sNAwoFpqVx2J/AxlbIp9Zi8H4Ir
         2zCpcBYxnCeH3p4vL/YBxosMzXniSL+gbJ3Yknru+PX/e3WFrjK85wAvCtvlWBEYTyMb
         MiexwNJE1Pd/ERtTDevsezqJSUbin85wRB7CIgeRy2dwkbqnEccva3WlT4W7woKKND5Y
         r7L6VYpU73lZejnDnEcc8l1t3kB6S5NEnESGqL4KW7Q/BKMEWFbrgXDA0mwaDix6FzUQ
         xK0UxB7VRZCeraQi8LdwNKhs5kUH7GJNkAHna1+BJEtEl1GZXXOdC0OTXqT/Cm6ZGGs6
         OroQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvYzkqKp/7AnPLrDekOxGcqUgGP9Z2yXQMB6wDcfB6XYTVtqCtGL+T1Z/1uIC+oVs1WZwcv8eTSlyzEfqIdkhVIrQfr+2WdN9yJO7J
X-Gm-Message-State: AOJu0YxTfun66z0/bV0Q1DJJrxsPH0gZ4HzZFrxcK5IRH8q8Kmp7n+Xo
	xQSnfCv1iDZ/84DMTruII45uzBjcistzL9MY9L8VLIxqjgRHtF2S4UDpAfjL/p4=
X-Google-Smtp-Source: AGHT+IHqC7IQzqpRtpOcSymyY4bbd60+LtteUtikK/WR3ibSVlPRK4KDS/XBqGxQqzXhSC6ZYtfu2Q==
X-Received: by 2002:a05:620a:4408:b0:7a2:a1d:d3f9 with SMTP id af79cd13be357-7a34eed1938mr1841795985a.6.1722952219216;
        Tue, 06 Aug 2024 06:50:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f772dc7sm457935385a.94.2024.08.06.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:50:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbKZt-00Ebl5-PA;
	Tue, 06 Aug 2024 10:50:17 -0300
Date: Tue, 6 Aug 2024 10:50:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Yonglong Liu <liuyonglong@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
	ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	"shenjian (K)" <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>, joro@8bytes.org,
	will@kernel.org, iommu@lists.linux.dev
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at
 iommu_get_dma_domain+0xc/0x20
Message-ID: <20240806135017.GG676757@ziepe.ca>
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
 <8743264a-9700-4227-a556-5f931c720211@huawei.com>
 <e980d20f-ea8a-43e3-8d3f-179a269b5956@kernel.org>
 <CAOBf=musxZcjYNHjdD+MGp0y6epnNO5ryC6JgeAJbP6YQ+sVUA@mail.gmail.com>
 <ad84acd2-36ba-433c-bdf7-c16c0d992e1c@huawei.com>
 <190d5a15-d6bf-47d6-be86-991853b7b51d@arm.com>
 <5b0415ff-9bbe-4553-89d6-17d12fd44b47@huawei.com>
 <ae995d55-daa9-4060-85fa-31b4f725a17d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae995d55-daa9-4060-85fa-31b4f725a17d@arm.com>

On Tue, Aug 06, 2024 at 01:50:08PM +0100, Robin Murphy wrote:
> On 06/08/2024 12:54 pm, Yunsheng Lin wrote:
> > On 2024/8/5 20:53, Robin Murphy wrote:
> > > > > > 
> > > > > > The page_pool bumps refcnt via get_device() + put_device() on the DMA
> > > > > > 'struct device', to avoid it going away, but I guess there is also some
> > > > > > IOMMU code that we need to make sure doesn't go away (until all inflight
> > > > > > pages are returned) ???
> > > > 
> > > > I guess the above is why thing went wrong here, the question is which
> > > > IOMMU code need to be called here to stop them from going away.
> > > 
> > > This looks like the wrong device is being passed to dma_unmap_page() - if a device had an IOMMU DMA domain at the point when the DMA mapping was create, then neither that domain nor its group can legitimately have disappeared while that device still had a driver bound. Or if it *was* the right device, but it's already had device_del() called on it, then you have a fundamental lifecycle problem - a device with no driver bound should not be passed to the DMA API, much less a dead device that's already been removed from its parent bus.
> > 
> > Yes, the device *was* the right device, And it's already had device_del()
> > called on it.
> > page_pool tries to call get_device() on the DMA 'struct device' to avoid the
> > above lifecycle problem, it seems get_device() does not stop device_del()
> > from being called, and that is where we have the problem here:
> > https://elixir.bootlin.com/linux/v6.11-rc2/source/net/core/page_pool.c#L269
> > 
> > The above happens because driver with page_pool support may hand over
> > page still with dma mapping to network stack and try to reuse that page
> > after network stack is done with it and passes it back to page_pool to avoid
> > the penalty of dma mapping/unmapping. With all the caching in the network
> > stack, some pages may be held in the network stack without returning to the
> > page_pool soon enough, and with VF disable causing the driver unbound, the
> > page_pool does not stop the driver from doing it's unbounding work, instead
> > page_pool uses workqueue to check if there is some pages coming back from the
> > network stack periodically, if there is any, it will do the dma unmmapping
> > related cleanup work.
> 
> OK, that sounds like a more insidious problem - it's not just IOMMU stuff,
> in general the page pool should not be holding and using the device pointer
> after the device has already been destroyed. Even without an IOMMU,
> attempting DMA unmaps after the driver has already unbound may leak
> resources or at worst corrupt memory. Fundamentally, the page pool code
> cannot allow DMA mappings to outlive the driver they belong to.

+1

There is more that gets broken here if these basic driver model rules
are not followed!

netdev must fix this by waiting during driver remove until all this DMA
activity is finished somehow.

Jason

