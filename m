Return-Path: <linux-kernel+bounces-306109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B08496394D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A36D1C21919
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D52B6088F;
	Thu, 29 Aug 2024 04:19:18 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4A42AAB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724905158; cv=none; b=D+BtNyVZyou886dD2dSTm0U2a8Nqph2eR2n9Ivt8nvDGjqeqf0DMchH0WWfyPhqDDnT1l8QUN7ud2k5VzekyAwyrHU7taKIAggoXMB7hC/Oto5W7pazM2+QRmWM4gaQ6CDwiluXmqk89kwacP4ijaCpmrr1DAwFs4xaa6TZpxH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724905158; c=relaxed/simple;
	bh=RBDBVusewDGRLSs5t/KGYCnpMkkB9AXqptRnmV4l8Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/BJD3Zd/In/ChRB7N4jM/PrjWr6fL53qMk7YlqWMmP/LXpskxqfhLGA5RC8M7YxC8MV/15hz+teopGhPRYq+Pu4TXKKN+/K+kqkh1JdiaS3B0fFHoojI3fo2m5+qvG5lB/SpHOh4zscPvgZmOGLU8jvvPdUmHew9/g+IMKq6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9ECFB68AA6; Thu, 29 Aug 2024 06:19:12 +0200 (CEST)
Date: Thu, 29 Aug 2024 06:19:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dma: Trace API
Message-ID: <20240829041912.GB4408@lst.de>
References: <20240826203240.2234615-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826203240.2234615-1-sean.anderson@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

I'd change the subject to

dma-mapping: add tracing for dma-mapping API calls

On Mon, Aug 26, 2024 at 04:32:40PM -0400, Sean Anderson wrote:
> When debugging drivers, it can often be useful to trace when memory gets
> (un)mapped for DMA (and can be accessed by the device). Add some
> tracepoints for this purpose.
> 
> We use unsigned long long instead of phys_addr_t and dma_addr_t (and
> similarly %llx instead of %pa) because libtraceevent can't handle
> typedefs.

and a __u64 would seem like the better type here.

otherwise this looks fine to me.  I can do the tweaks as I'll apply
the patch if needed.


