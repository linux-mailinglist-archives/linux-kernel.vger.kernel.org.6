Return-Path: <linux-kernel+bounces-233402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427FE91B69C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DEB1C228B7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 06:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FB24D8C2;
	Fri, 28 Jun 2024 06:01:49 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B06F4D5BF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719554508; cv=none; b=l/HYZzOq3oCkaRDWSO67A0pb+kIECGlqWcwdd2PZgFdhJvAj0EM2jt9yKK2bma1Nt3RTPuJOgf9RedAUOsDFJADjV5DSqv7Eib6M7nAQLms46Tguzx2WsBvNXHya5/5C0eL+Twlcsa8kOujtlgS1K59ktAuIJFzYaOCxxow7MR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719554508; c=relaxed/simple;
	bh=zPf2b/JxbwDgnTb/kPy+Mmxdvp8oPoHuQGwsEJopq4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdhimTAncOHnJFrA8hx9E080HdiEcnEMmTkWFaLMoembtikIPtQmvLlWEbHTbdPl6XKp4tFC4Yw3UzJ9QCUzsqr1vslYCthklI2XM3IKJXPrHlVeiH3n6Vhi8kX2LqFFnsO3sBYpzx9EQEVim0zIHcvfChbGbZBsIipwxQR07pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C992B68D09; Fri, 28 Jun 2024 08:01:30 +0200 (CEST)
Date: Fri, 28 Jun 2024 08:01:29 +0200
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
Message-ID: <20240628060129.GA26206@lst.de>
References: <20240607031421.182589-1-mhklinux@outlook.com> <SN6PR02MB41577686D72E206DB0084E90D4D62@SN6PR02MB4157.namprd02.prod.outlook.com> <20240627060251.GA15590@lst.de> <20240627085216.556744c1@meshulam.tesarici.cz> <SN6PR02MB4157E61B49C8435E38AC968DD4D72@SN6PR02MB4157.namprd02.prod.outlook.com> <20240627152513.GA23497@lst.de> <SN6PR02MB4157D9B1A64FF78461D6A7EDD4D72@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157D9B1A64FF78461D6A7EDD4D72@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 27, 2024 at 04:02:59PM +0000, Michael Kelley wrote:
> > > Conceptually, it's still being used as a boolean function based on
> > > whether the return value is NULL.  Renaming it to swiotlb_get_pool()
> > > more accurately describes the return value, but obscures the
> > > intent of determining if it is a swiotlb buffer.  I'll think about it.
> > > Suggestions are welcome.
> > 
> > Just keep is_swiotlb_buffer as a trivial inline helper that returns
> > bool.
> 
> I don't understand what you are suggesting.  Could you elaborate a bit?
> is_swiotlb_buffer() can't be trivial when CONFIG_SWIOTLB_DYNAMIC
> is set.

Call the main function that finds and retuns the pool swiotlb_find_pool,
and then have a is_swiotlb_buffer wrapper that just returns bool.


