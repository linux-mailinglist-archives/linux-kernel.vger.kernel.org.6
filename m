Return-Path: <linux-kernel+bounces-420887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351289D83FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B404163917
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BF1194AD1;
	Mon, 25 Nov 2024 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEgjRShr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF3187849
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732532520; cv=none; b=s3Y36/WbsBWri97MpIVzAdFnMWVkzuc8ViLDUNtVXRX61+zfVjK4lIynz9prumI83XgWmxupmF4YYzGnctkUz08ywjkriuz+TpDZKySg/sjYASDXx8j9d5QGH7MjMxmBaBrELj73b7g9eKmw+WUx3WjeOmMWgbQ7RJa7nBedtdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732532520; c=relaxed/simple;
	bh=CP3zKWwbrslisE/UbWI1G3xhio1GOyNDf3EQtEW9i0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neydlamVbMmWTma/CKC/NusJ3aTwao9RdD9UqoVOX1m9kLp/l/ci3Sq8HakgPReoY/p2qsDmLTrXjJFkAyHLXSvdrN1sJAGhnF8GstugnCdEDGdeucmRGDv140NbqFWhyRO7wPLFBlS3E2pTkC9FCfYZvTmBU232X3xmTGw0hro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEgjRShr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A394AC4CECE;
	Mon, 25 Nov 2024 11:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732532520;
	bh=CP3zKWwbrslisE/UbWI1G3xhio1GOyNDf3EQtEW9i0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEgjRShrCLRpFY9hOj2srl0D/Jz353RVz93aun0r7PdnqHBRuDAimkumEss5nwiJU
	 1qFx/oGTtOmRtE4FJlS3pcbe8toQds8KePvjNprSVP2UFWnR4twt3E8YrPLc0qR5xb
	 5MHCM0iB+rPFCW9t9W9bEu0F3LwObYti3kBNGgJNYDfBU+AloYVuq+qaBq6qgnzSf5
	 z7hCFWxglFAU0iy/v9aGIgB4PtFVIqR8D9M/LmuniceIVDp2unUjngTPZwDtSKOr8H
	 beL7uOCloKR5KxjsYSGP4TjQI5D4DT48xWvnS0u934OhljTg2EHmQNRcVEao5bY3S/
	 paFrpzJ0uydQA==
Date: Mon, 25 Nov 2024 12:01:20 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bob Beckett <bob.beckett@collabora.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	kernel@collabora.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <Z0RZAKgUA7jS1U_m@ryzen>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112195053.3939762-1-bob.beckett@collabora.com>

On Tue, Nov 12, 2024 at 07:50:00PM +0000, Bob Beckett wrote:
> From: Robert Beckett <bob.beckett@collabora.com>
> 
> We initially put in a quick fix of limiting the queue depth to 1
> as experimentation showed that it fixed data corruption on 64GB
> steamdecks.
> 
> After further experimentation, it appears that the corruption
> is fixed by aligning the small dma pool segments to 512 bytes.
> Testing via desync image verification shows that it now passes
> thousands of verification loops, where previously
> it never managed above 7.
> 
> Currently it is not known why this fixes the corruption.
> Perhaps it is doing something nasty like using an mmc page
> as a cache for the prp lists (mmc min. page size is 512 bytes)
> and not invalidating properly, so that the dma pool change to
> treats segment list as a stack ends up giving a previous
> segment in the same cached page.
> 
> This fixes the previous queue depth limitation as it fixes
> the corruption without incurring a 37% tested performance
> degredation.
> 
> Fixes: 83bdfcbdbe5d ("nvme-pci: qdepth 1 quirk")
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> ---
>  drivers/nvme/host/nvme.h | 5 +++++
>  drivers/nvme/host/pci.c  | 6 +++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 093cb423f536..61bba5513de0 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -173,6 +173,11 @@ enum nvme_quirks {
>  	 * MSI (but not MSI-X) interrupts are broken and never fire.
>  	 */
>  	NVME_QUIRK_BROKEN_MSI			= (1 << 21),
> +
> +	/*
> +	 * Align dma pool segment size to 512 bytes
> +	 */
> +	NVME_QUIRK_DMAPOOL_ALIGN_512		= (1 << 22),
>  };
>  
>  /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 4b9fda0b1d9a..6fcd3bb413c4 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2700,8 +2700,8 @@ static int nvme_setup_prp_pools(struct nvme_dev *dev)
>  		return -ENOMEM;
>  
>  	/* Optimisation for I/Os between 4k and 128k */
> -	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
> -						256, 256, 0);
> +	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,256,
> +				       dev->ctrl.quirks & NVME_QUIRK_DMAPOOL_ALIGN_512 ? 512 : 256, 0);
>  	if (!dev->prp_small_pool) {
>  		dma_pool_destroy(dev->prp_page_pool);
>  		return -ENOMEM;
> @@ -3449,7 +3449,7 @@ static const struct pci_device_id nvme_id_table[] = {
>  	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
>  		.driver_data = NVME_QUIRK_BOGUS_NID, },
>  	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
> -		.driver_data = NVME_QUIRK_QDEPTH_ONE },
> +		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
>  	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
>  		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
>  				NVME_QUIRK_BOGUS_NID, },
> -- 
> 2.45.2
> 
> 

+CC: Gwendal

Since he sent out a patch to revert the original QD=1 quirk,
claiming that the quirk wasn't needed when using the same
NVMe to eMMC bridge with another eMMC device.

If the quirk is really per eMMC device (from reading about this
problem, it sure sounds like a controller issue...), but if this
problem is really eMMC device related, then probably the quirk
should be applied only for certain eMMC devices instead.


Kind regards,
Niklas

