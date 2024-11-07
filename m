Return-Path: <linux-kernel+bounces-400379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824369C0CB2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CB01F22E9A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6591215F41;
	Thu,  7 Nov 2024 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO4aapRu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2003C212EF0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730999975; cv=none; b=QFz9URbYTfhdMl1pXrNV/2Hd4qYUFa/bheA4hDz8BjrQTrr3V8mStmPUzh3h60ShFqV1qr8Qn4maVM6qjj/R6GDFgp7JOGRvvtu2NfkSZXg2lI+QWT3NMiJHq0atP06jx7F7eQxi1rNJBbGBdpy+HwEr/CCqHWi3Za7LvH5gDNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730999975; c=relaxed/simple;
	bh=oqZnj3nucJM60cIfyc8kf3ErFRrH9f1YRFHIGBlSDro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdpmmZwgJqvJ/Tw9lBrR43VMCHNzrWnfkOfk/KigtbnBBVzqt1HN/+7/tchRVF+3TLiPM1GKCz33zf7+un7/hqbNiw40JXMXh2JueliCSrQbI77d7nttKVxi62jODOAaHb0QprazkGTSch9F3KVsZG6KZDHz8W92mbHfe4TwZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZO4aapRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AE5C4CECC;
	Thu,  7 Nov 2024 17:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730999973;
	bh=oqZnj3nucJM60cIfyc8kf3ErFRrH9f1YRFHIGBlSDro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZO4aapRuNnHDr8oE2VhQbb6eD/aCiUzQ0QCwJtmx5kq9fLA/RKhVj2VZH1BQ+A2Pc
	 C7cJhTNV9krDdMGUU5BU10lPglIhzNPQ3Z4YqMt+ukpnYUOXU5LWjxdTUtI4opsGR2
	 cSZg0l1/JDjMcj2Gm4cnAfptdozTrTX8sgEGa4FlnMd4UYjpqtfpTJFb2LVwkFx4xU
	 Be8FrrN/yIeL2iCExkraxkZZTMeVyl/6Cz4Yjm1iy4OC0cMII4QN5i2691DAWECwjh
	 q6moo3TENq9iASogpJF+4J9XcMY4JxPcO0JC593P4qOonQYRsccYI75Of1EWGDYqh+
	 RLVMJz3G26sog==
Date: Thu, 7 Nov 2024 10:19:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bob Beckett <bob.beckett@collabora.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, kernel@collabora.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: 512 byte dma pool segment quirk
Message-ID: <Zyz2oiQ2pco15HHT@kbusch-mbp>
References: <ZyE0kYvRZbek7H_g@kbusch-mbp.dhcp.thefacebook.com>
 <20241107165131.3462171-1-bob.beckett@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107165131.3462171-1-bob.beckett@collabora.com>

On Thu, Nov 07, 2024 at 04:50:46PM +0000, Bob Beckett wrote:
> @@ -611,7 +612,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
>  	}
>  
>  	nprps = DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
> -	if (nprps <= (256 / 8)) {
> +	if (nprps <= (dev->small_dmapool_seg_size / 8)) {
>  		pool = dev->prp_small_pool;
>  		iod->nr_allocations = 0;
>  	} else {

We have a constant expression currently, and this is changing it a full
division in the IO path. :(

Could we leave the pool selection check size as-is and just say the cost
of the quirk is additional memory overhead?

> @@ -2700,8 +2701,9 @@ static int nvme_setup_prp_pools(struct nvme_dev *dev)
>  		return -ENOMEM;
>  
>  	/* Optimisation for I/Os between 4k and 128k */
> -	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
> -						256, 256, 0);
> +	dev->prp_small_pool = dma_pool_create("prp list small", dev->dev,
> +						dev->small_dmapool_seg_size,
> +						dev->small_dmapool_seg_size, 0);

I think it should work if we only change the alignment property of the
pool. Something like this:

	if (dev->ctrl.quirks & NVME_QUIRK_SMALL_DMAPOOL_512)
		dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
						      256, 512, 0);
	else
		dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
						      256, 256, 0);

