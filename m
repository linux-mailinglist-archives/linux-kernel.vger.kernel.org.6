Return-Path: <linux-kernel+bounces-309477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F1F966B12
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0E61F25D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359D91BF7FD;
	Fri, 30 Aug 2024 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qqgxawc3"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EAE14C585
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051795; cv=none; b=ShW2fcsGH/SQW5xZ5Drw31P8yJhfP1Pgfr6zu1ALgAboTSqpdIN1s5aC1ebZGd+bE146iOU/oHr/xjb3m+8xborolJ6BZNMcWI32hPUAlV7/hz3rEv1acRkLztOruWYQNr+oGnlkgpF9xt2YSsCtLX/huauZjDwGRvnK8g8M5pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051795; c=relaxed/simple;
	bh=GM2DasHGqCYJLkfNS5cdCpPdhI//xS+swpIq2EhE22c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDuT+AyBXETQrfrvxhTJgPwzYD4QiTu/te9le1i/BlWUutyFagvmaELJyeTyo5U7hTw4Uq7Ro7SGpsbVy3YHItMpga2r9+aS5DX/qoXX2cl6G/54F03APmFDJrUCzBcnx3uhZOfFGSOg05V3IyGrxz4vBRdvb9unlvdQvE1l4Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qqgxawc3; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e0d206be-7ad1-4b80-9f58-88eb0cf1ce74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725051790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4OEWcEhfJSfSlYo07oIFQ/4ZIDOB0tVXO3csQokwug=;
	b=Qqgxawc3kIVrVt+sccZg/wjFrWmXtPLJB3tMu6J+z1+015puL9Pan0j99RMTXSWBvb8t3J
	2xBeYejFXk7YEnJ9xZtPodwURTbitUqYubrYi/Vi1o5+3a4S86gq7i3ZXHzieksdOJFPCY
	fTQARNgfb7S2AV4nmLqeckDGc7QtFwY=
Date: Sat, 31 Aug 2024 05:03:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v2] drm/etnaviv: Clear the __GFP_HIGHMEM bit in GFP_HIGHUSER
 with 32 address
To: "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "linux+etnaviv@armlinux.org.uk" <linux+etnaviv@armlinux.org.uk>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>
Cc: "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <MW5PR11MB57648F441CEDD36E614E31EA95812@MW5PR11MB5764.namprd11.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <MW5PR11MB57648F441CEDD36E614E31EA95812@MW5PR11MB5764.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi, Xiaolei


Thanks for your nice catch! I have more to say.

On 2024/8/16 09:55, Wang, Xiaolei wrote:
> Ping ...

32 address -> 32-bit address,

Perhaps, we could improve the commit title a little bit
by writing a more accurate sentence if possible, say:

drm/etnaviv: Properly request pages from DMA32 zone when needed

or

drm/etnaviv: Request pages from DMA32 zone on addressing_limited


> thanks
> xiaolei

Vivante GPU is a 32-bit GPU, it do can access 40-bit physical address via its MMU(IOMMU).
But this is only possible *after* the MMU has been setup(initialized). Before GPU page
table is setup(and flush-ed into the GPU's TLB), the device can only access 32-bit
physical addresses and the addresses has to be physical continues in ranges.

The GPU page tables (GART) and command buffer has to reside in low 4GB address.

> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 7c7f97793ddd..0e6bdf2d028b 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -844,8 +844,10 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
>            * request pages for our SHM backend buffers from the DMA32 zone to
>            * hopefully avoid performance killing SWIOTLB bounce buffering.
>            */
> -       if (dma_addressing_limited(gpu->dev))
> +       if (dma_addressing_limited(gpu->dev)) {
>                   priv->shm_gfp_mask |= GFP_DMA32;
> +               priv->shm_gfp_mask &= ~__GFP_HIGHMEM;
> +       }

The code here  still looks itchy and risky,
because for a i.MX8 SoC with multiple vivante GPU core.
We will modify priv->shm_gfp_mask *multiple* time.

For the 2D core and the 3D core have different DMA addressing constraint.
Then, only the last(latest) modify will be effective. This lead to the
probe order dependent.

However this may not be a problem in practice, as usually, all vivante
GPUs in the system will share the same DMA constraints. And the driver
assume that.

But then, we probably still should not modify the global shared GFP
mask multiple time.

Now that we do assume that all vivante GPUs in the system share the
same DMA constraints. And the DMA constraints information has been
assigned to the virtual master. The right time to modify the
`priv->shm_gfp_mask` should be in the etnaviv_bind() function. as
this can eliminate overlap(repeat) stores.


Please consider move the entire if() {} to etnaviv_bind(), just below
where the 'priv->shm_gfp_mask' was initially initialized.

or alternatively we can just hard-code to use low 4GM memmory only:

priv->shm_gfp_mask = GFP_USER | GFP_DMA32 | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;


Best regards,
Sui

>           /* Create buffer: */
>           ret = etnaviv_cmdbuf_init(priv->cmdbuf_suballoc, &gpu->buffer,

