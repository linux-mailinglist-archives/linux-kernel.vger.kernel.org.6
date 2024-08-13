Return-Path: <linux-kernel+bounces-284695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AF095042C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195EE1F218F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D615199391;
	Tue, 13 Aug 2024 11:50:17 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD0819923D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549817; cv=none; b=oQGGFo8v8MHVX5BJ5YHL/9D955nbWefH53YMYU5ZPXvsOvCGTlMRM6OIECwpFqpSThKQYsd/XIKM9GJl4dmLHgoBkEMysEC8JVj2p033/GzLnJTqWIHnr1Tuo30aSXms7LEfugb6+f1Z3deytbGS6NGmGceC+Gq2n+qW7eor23U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549817; c=relaxed/simple;
	bh=jqt54muLOVo9ftAomttUciUspyyZLMAhKp2YqEsQZKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7hwrLyzCzG3JD53xwdDvHnx9cF/cnqw6hHyOSbG3W9hfRRKxEygmfBD2e0BecKRzxloHM00YUxG9e1damtlRof/USdtcAaUSv0GM1sAySO76sreKWhdbV6xFwr3nEFKwVZ+dj2gkFLa+bO34VPMiBZlWrAYfZiFrOcnLhWc6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1611227A87; Tue, 13 Aug 2024 13:50:02 +0200 (CEST)
Date: Tue, 13 Aug 2024 13:50:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>, leonro@nvidia.com
Subject: Re: [PATCH v4 0/2] DMA IOMMU static calls
Message-ID: <20240813115002.GA2825@lst.de>
References: <cover.1721818168.git.leon@kernel.org> <20240805122050.GA480973@unreal> <2024081330-dismiss-unsealed-0f21@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024081330-dismiss-unsealed-0f21@gregkh>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 13, 2024 at 11:58:51AM +0200, Greg Kroah-Hartman wrote:
> I thought we were trying to get away from adding iommu stuff to struct
> device, but oh well :(

Strictly speaking this is DMA-API stuff, despite being related to
dma-iommu.  And yes, I'd like to eventually move this out of
struct device into a separate dma_device, but that's pretty big
lift and for now this uses one of many spare bits without growing the
structure.


