Return-Path: <linux-kernel+bounces-220258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F233190DE8B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981EC1F23A50
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DEE178386;
	Tue, 18 Jun 2024 21:38:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1D113DDD2;
	Tue, 18 Jun 2024 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746715; cv=none; b=ZPOA3DDpjnEgpukP7SZTr41RheMFMVXpvaCHrr1JEua3wNG03lCuXwuFCzv02RH6HwOBQzWJGpmM4I9jPvSZ2/G/0mkjjmrjhKpgvJXzIjrZ6H60uxU32iZBMB2lGEQk1dUjLJR7PKtTUuPjyp82UPd9GXYPVFGakjCBUqFIKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746715; c=relaxed/simple;
	bh=AYq7euI/XVOdUL29dkH24ZxEpRRBcB8uSdj9EW0Rmrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET/0u0Aw7YUHIKRVM1kVNuF7Ekz7CVfvb+sWxbW+C3ROSGrtVCAGBEw9UFEeLk6805Babvr8AllRXZ2Iana4v66T1kmoemJW03dY3IiWtem9FK8ixLBSyGnNcCKaL4L0/aCCd2NqhgTdB129mycp9tqCGj69yFpARwDWTwr5WR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1613BC3277B;
	Tue, 18 Jun 2024 21:38:31 +0000 (UTC)
Date: Tue, 18 Jun 2024 22:38:29 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH RFC v2 2/5] of: get dma area lower limit
Message-ID: <ZnH-VU2iz9Q2KLbr@arm.com>
References: <cover.1712642324.git.baruch@tkos.co.il>
 <230ea13ef8e9f576df849e1b03406184ca890ba8.1712642324.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230ea13ef8e9f576df849e1b03406184ca890ba8.1712642324.git.baruch@tkos.co.il>

On Tue, Apr 09, 2024 at 09:17:55AM +0300, Baruch Siach wrote:
> of_dma_get_max_cpu_address() returns the highest CPU address that
> devices can use for DMA. The implicit assumption is that all CPU
> addresses below that limit are suitable for DMA. However the
> 'dma-ranges' property this code uses also encodes a lower limit for DMA
> that is potentially non zero.
> 
> Rename to of_dma_get_cpu_limits(), and extend to retrieve also the lower
> limit for the same 'dma-ranges' property describing the high limit.

I don't understand the reason for the lower limit. The way the Linux
zones work is that ZONE_DMA always starts from the start of the RAM. It
doesn't matter whether it's 0 or not, you'd not allocate below the start
of RAM anyway. If you have a device that cannot use the bottom of the
RAM, it is pretty broken and not supported by Linux.

I think you added this limit before we tried to move away from
zone_dma_bits to a non-power-of-two limit (zone_dma_limit). With the
latter, we no longer need tricks with the lower limit,
of_dma_get_max_cpu_address() should capture the smallest upper CPU
address limit supported by all devices (and that's where ZONE_DMA should
end).

-- 
Catalin

