Return-Path: <linux-kernel+bounces-380258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E23A9AEB18
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE91E1F218C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A6E1D63E5;
	Thu, 24 Oct 2024 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gNZDMCYG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487D5A4D5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785097; cv=none; b=Z2vxaDJtx+W/u/hS5YlHFMvrwKGUHlO06hzUZ8c8DHzmMF+nI3uouxdlHQD/Dcb6J3DtD45g4pmC73T8dvZRUNCgnMU+6A3bpXBbzUu0dMxOVa4JbIb/2qxji+JQh5NHalJXfZ0jJ6b+F0fyShKUmVZVU2az2M8arjEbFLYrOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785097; c=relaxed/simple;
	bh=HPIGXO+xkN0qQsdXWfvLy1DWxhrKK+4IPK7reQ92mM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrkxCp8HnPbcUnVHHvxcqrAZ7GUwVR3KB81x/zs/qjCUUlwttVKWfTKOfvT6OTxnqP1CjSdzJIhj1wO//We1PrQkMj8D+jlnIPK/D+FD9V6kmpwERPLgN7+EIJ67LH+0HXMb4WiWAOIA2DiiyAWAr9NrOZBY0g/mSQx/RjtIoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gNZDMCYG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729785093;
	bh=HPIGXO+xkN0qQsdXWfvLy1DWxhrKK+4IPK7reQ92mM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gNZDMCYGkiAgZhEO0w0dbTg4Vh/EkpA1U3ghzVR4dIqmMn3fRkMUs7fMOQ31RXEMr
	 o16VL0yxBa+YfFXuxP1j/4qQF0GKYh8OQajCD8Zny3z5wrq+d0/GZ1qSSOvbib2IZn
	 Vpv6KZfAl6BKfRxbvzlP9UErgO1TCOKu0yIRiu0ba5WchN49vH6jDRR2fXS23wavoQ
	 MePQA0u5CBTC9SVT1yq/fykIaocWFzXeBRqino4blJ9u1dQkpPheVuqw1V5tq3I/4H
	 fdiD1e5TioJ1XNDe7/mRa+eyu9X2fJoroo5ksauXI8y7A5ewvMVFP1TbHHANCQsPq5
	 sK7xCHOYB86hQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 38B9A17E120F;
	Thu, 24 Oct 2024 17:51:33 +0200 (CEST)
Date: Thu, 24 Oct 2024 17:51:27 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Akash Goel <akash.goel@arm.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mihail.atanassov@arm.com, ketil.johnsen@arm.com, florent.tomasin@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH 2/3] drm/panthor: Explicitly set the coherency mode
Message-ID: <20241024175127.6c3fcf88@collabora.com>
In-Reply-To: <20241024145432.934086-3-akash.goel@arm.com>
References: <20241024145432.934086-1-akash.goel@arm.com>
	<20241024145432.934086-3-akash.goel@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 15:54:31 +0100
Akash Goel <akash.goel@arm.com> wrote:

> This commit fixes the potential misalignment between the value of device
> tree property "dma-coherent" and default value of COHERENCY_ENABLE
> register.
> Panthor driver didn't explicitly program the COHERENCY_ENABLE register
> with the desired coherency mode. The default value of COHERENCY_ENABLE
> register is implementation defined, so it may not be always aligned with
> the "dma-coherent" property value.
> The commit also checks the COHERENCY_FEATURES register to confirm that
> the coherency protocol is actually supported or not.
> 
> Signed-off-by: Akash Goel <akash.goel@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 22 +++++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_gpu.c    |  9 +++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 4082c8f2951d..984615f4ed27 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -22,6 +22,24 @@
>  #include "panthor_regs.h"
>  #include "panthor_sched.h"
>  
> +static int panthor_gpu_coherency_init(struct panthor_device *ptdev)
> +{
> +	ptdev->coherent = device_get_dma_attr(ptdev->base.dev) == DEV_DMA_COHERENT;
> +
> +	if (!ptdev->coherent)
> +		return 0;
> +
> +	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
> +	 * ACE protocol has never been supported for command stream frontend GPUs.
> +	 */
> +	if ((gpu_read(ptdev, GPU_COHERENCY_FEATURES) &
> +		      GPU_COHERENCY_PROT_BIT(ACE_LITE)))
> +		return 0;
> +
> +	drm_err(&ptdev->base, "Coherency not supported by the device");
> +	return -ENOTSUPP;
> +}
> +
>  static int panthor_clk_init(struct panthor_device *ptdev)
>  {
>  	ptdev->clks.core = devm_clk_get(ptdev->base.dev, NULL);
> @@ -156,7 +174,9 @@ int panthor_device_init(struct panthor_device *ptdev)
>  	struct page *p;
>  	int ret;
>  
> -	ptdev->coherent = device_get_dma_attr(ptdev->base.dev) == DEV_DMA_COHERENT;
> +	ret = panthor_gpu_coherency_init(ptdev);
> +	if (ret)
> +		return ret;
>  
>  	init_completion(&ptdev->unplug.done);
>  	ret = drmm_mutex_init(&ptdev->base, &ptdev->unplug.lock);
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index 5251d8764e7d..1e24f08a519a 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -77,6 +77,12 @@ static const struct panthor_model gpu_models[] = {
>  	 GPU_IRQ_RESET_COMPLETED | \
>  	 GPU_IRQ_CLEAN_CACHES_COMPLETED)
>  
> +static void panthor_gpu_coherency_set(struct panthor_device *ptdev)
> +{
> +	gpu_write(ptdev, GPU_COHERENCY_PROTOCOL,
> +		ptdev->coherent ? GPU_COHERENCY_PROT_BIT(ACE_LITE) : GPU_COHERENCY_NONE);
> +}
> +
>  static void panthor_gpu_init_info(struct panthor_device *ptdev)
>  {
>  	const struct panthor_model *model;
> @@ -365,6 +371,9 @@ int panthor_gpu_l2_power_on(struct panthor_device *ptdev)
>  			      hweight64(ptdev->gpu_info.shader_present));
>  	}
>  
> +	/* Set the desired coherency mode before the power up of L2 */
> +	panthor_gpu_coherency_set(ptdev);
> +
>  	return panthor_gpu_power_on(ptdev, L2, 1, 20000);
>  }
>  


