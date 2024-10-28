Return-Path: <linux-kernel+bounces-385477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394E29B37A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3096282253
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE941DF267;
	Mon, 28 Oct 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vdWtJHnL"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54451DD533
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136478; cv=none; b=Kz/O/q6JAGoyF2YR6HusoAMp4MrDo3bKwgxlDYSNt8GG6SpLjoPUsHGDs5qwtjUG791S1RLOLi2HyV9oDBtgYF30Yz+FShRnd+E0SQ4/TBSd2ft2zvprOdLxCKlM5WY/EjthZWHseJXsDt8DYS+r93cPSyckRUMGkH0Sayifl84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136478; c=relaxed/simple;
	bh=JETVFkqseSW35jkmk4eAxy3+f2DQ3BBPLGHta6CbYuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtdzCQRAJA4ikxWVc43nozFqtBXITJmiZNuEF4QOp4ptp5xQjVwqujQTgCboOoYx+q/JzbturqYyJiu3kbjVUsfyem/wzqkn4MQDL7JLSuQocsv1eupejkb/JN/TqcaAV3RHtRZkH9zaMf2ZD0xq3rREtceKxo8fV4sh9IQQ/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vdWtJHnL; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4823fcb2-09a0-4668-86fd-f345a900c4e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730136473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBDzbhX/4JRNYtY1tJljv+6aFQjq5c0O+TlEFUm+jCY=;
	b=vdWtJHnLWYx1ivD4zdmhr/oyaiYTeHE30atLrZZnKNDc8A4YydU5lsh0T5pllWj4c9e4+2
	+Qk6nm7UFrnbiZN5XkgZIwB2BmvJSR8jdpQ3rYkth1LY1PedCdiynTzcAjw4CGrStMTjDB
	i2v8nDew/If/faqbLjd5y8X05WY3M1w=
Date: Tue, 29 Oct 2024 01:27:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] drm/etnaviv: Fix misunderstanding about the
 scatterlist structure
To: Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241028160555.1006559-1-sui.jingfeng@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20241028160555.1006559-1-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/10/29 00:05, Sui Jingfeng wrote:
> The 'offset' data member of the 'struct scatterlist' denotes the offset
> into a SG entry in bytes. The sg_dma_len() macro could be used to get
> lengths of SG entries, those lengths are expected to be CPU page size
> aligned. Since, at least for now, we call drm_prime_pages_to_sg() to
> convert our various page array into an SG list. We pass the number of
> CPU page as the third argoument, to tell the size of the backing memory
> of GEM buffer object.
>
> drm_prime_pages_to_sg() call sg_alloc_table_from_pages_segment() do the
> work, sg_alloc_table_from_pages_segment() always hardcode the Offset to
> ZERO. The sizes of *all* SG enties will be a multiple of CPU page size,
> that is multiple of PAGE_SIZE.
>
> If the GPU want to map/unmap a bigger page partially, we should use
> 'sg_dma_address(sg) + sg->offset' to calculate the destination DMA
> address, and the size to be map/unmap is 'sg_dma_len(sg) - sg->offset'.
>
> While the current implement is wrong, but since the 'sg->offset' is
> alway equal to 0, drm/etnaviv works in practice by good luck. Fix this,
> to make it looks right at least from the perspective of concept.
>
> while at it, always fix the absue types:
>
> - sg_dma_address returns DMA address, the type is dma_addr_t, not
>    the phys_addr_t, for VRAM there may have another translation between
>    the bus address and the final physical address of VRAM or carved out
>    RAM.
>
> - The type of sg_dma_len(sg) return is unsigned int, not the size_t.
>    Avoid hint the compiler to do unnecessary integer promotion.
>
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>   drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> index 1661d589bf3e..4ee9ed96b1d8 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> @@ -80,10 +80,10 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context, u32 iova,
>   		return -EINVAL;
>   
>   	for_each_sgtable_dma_sg(sgt, sg, i) {
> -		phys_addr_t pa = sg_dma_address(sg) - sg->offset;
> -		size_t bytes = sg_dma_len(sg) + sg->offset;


Wow, I know what's want here now.

What's you want here is to let the GPU map the entire page, not partially mapping just implemented.

But the area doesn't belong to us isn't right? Could lead to GPU out-of-bound access?


 From the perfect mapping perspective, we should just map from where the
sg_dma_address(sg) tell us, just use the sg_dma_len(sg) as length.


> +		dma_addr_t pa = sg_dma_address(sg) + sg->offset;
> +		unsigned int bytes = sg_dma_len(sg) - sg->offset;

Neither 'sg_dma_len(sg) + sg->offset' nor 'sg_dma_len(sg) - sg->offset' is correct.

Considering that when we are PRIME sharing buffer with another driver or
sharing buffer with the CPU.

If CPU stores the data at the middle position(say 2KiB of 4KiB),
then we have to tell the GPU fetch the data from the 2KiB of 4KiB,
not the 0 KiB of 4KiB. Seems quite difficult.
  
It could lead to concurrency problem of CPU put data at
'sg_dma_address(sg) + sg->offset', and GPU fetch the data
from sg_dma_address(sg) if 'sg->offset != 0'

So have the 'sg->offset != 0' is a bad idea. So, let's ignore
this and force 'sg->offset = 0' everywhere.

Thanks.

>   
> -		VERB("map[%d]: %08x %pap(%zx)", i, iova, &pa, bytes);
> +		VERB("map[%d]: %08x %pap(%x)", i, iova, &pa, bytes);
>   
>   		ret = etnaviv_context_map(context, da, pa, bytes, prot);
>   		if (ret)
> @@ -109,11 +109,11 @@ static void etnaviv_iommu_unmap(struct etnaviv_iommu_context *context, u32 iova,
>   	int i;
>   
>   	for_each_sgtable_dma_sg(sgt, sg, i) {
> -		size_t bytes = sg_dma_len(sg) + sg->offset;
> +		unsigned int bytes = sg_dma_len(sg) - sg->offset;
>   
>   		etnaviv_context_unmap(context, da, bytes);
>   
> -		VERB("unmap[%d]: %08x(%zx)", i, iova, bytes);
> +		VERB("unmap[%d]: %08x(%x)", i, iova, bytes);
>   
>   		BUG_ON(!PAGE_ALIGNED(bytes));
>   

-- 
Best regards,
Sui


