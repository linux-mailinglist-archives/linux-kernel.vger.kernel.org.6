Return-Path: <linux-kernel+bounces-393481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB469BA12B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 16:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06CDB21404
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA6219F461;
	Sat,  2 Nov 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lUKJqR7s"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874C3185936
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730561086; cv=none; b=bzN1OrZazE3BoeU7+zz44ZHNMDAZ+z0e5YvSOEmdqar0pzxRX//7rCVnU5Br0pJHqlFgNJGV9fLaK7iFNIZRiaYPsoi+su5mK3UfOegFlUJzPTUGKuuoXD2joGeT39Ej+XeyoiE7zA5uF57f0b4hqjDfkZku1XNbGNghcnCMOqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730561086; c=relaxed/simple;
	bh=naPVckIaIqRDTyQyjYm5TuyD2+k+aoNuQtkFc+UMH0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sx0J6llJTe/yRN4rsJqbyi6jTZOtZJGIByKriLzggqE+6Q+RQMi6YFWvGP+GHi3338ZpJOQ8OnzItOV2Sj0Wy3uF3Qei+II7sqR5721IeFhh25GJ+ndtEvumTaR6+626HaGjkaEMuexrXGdV+Pc17KoG3lWmRXZmuLwxxUJPt5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lUKJqR7s; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <06a4c8d0-a443-458b-82a5-ff90efc47ec0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730561080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScCswAKEEiXX1cjo9YHcQ9iy5zm0qIs66Se0a1qxy7A=;
	b=lUKJqR7sE9+ylNBln5t3yPqho3rAmrFNxWWqVqL4OZ4yy0YOv00SvgNOSeP34dC1oenVxD
	kVROxI4ABC1HHntX7rMrof5dTIEsiKX274OVIE8fR3P3V/9GbZ2qmE9nJ1nsNwnagsnogz
	AWAnpV9PCIyag35vXq/T8DsaYEQNMb8=
Date: Sat, 2 Nov 2024 23:24:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] drm/etnaviv: Request pages from DMA32 zone on
 addressing_limited
To: xiaolei wang <xiaolei.wang@windriver.com>,
 Lucas Stach <l.stach@pengutronix.de>, linux+etnaviv@armlinux.org.uk,
 christian.gmeiner@gmail.com, airlied@gmail.com, daniel@ffwll.ch
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240903020857.3250038-1-xiaolei.wang@windriver.com>
 <7a6ffbb773784dee0ea3ee87e563ac4e4f7c9c90.camel@pengutronix.de>
 <49288307-a98d-460d-88d5-e92f23a31a46@windriver.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <49288307-a98d-460d-88d5-e92f23a31a46@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

I forget to mention that  the commit title should be "on addressing limited devices",
the underscore between the last two words is not necessary. It's a typo when reply
email.


On 2024/10/1 20:32, xiaolei wang wrote:
>
>
> On 10/1/24 20:17, Lucas Stach wrote:
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>
>> Hi Xiaolei,
>>
>> Am Dienstag, dem 03.09.2024 um 10:08 +0800 schrieb Xiaolei Wang:
>>> Remove __GFP_HIGHMEM when requesting a page from DMA32 zone,
>>> and since all vivante GPUs in the system will share the same
>>> DMA constraints, move the check of whether to get a page from
>>> DMA32 to etnaviv_bind().
>>>
>>> Fixes: b72af445cd38 ("drm/etnaviv: request pages from DMA32 zone when needed")
>>> Suggested-by: Sui Jingfeng<sui.jingfeng@linux.dev>
>>> Signed-off-by: Xiaolei Wang<xiaolei.wang@windriver.com>
>>> ---
>>>
>>> change log
>>>
>>> v1:
>>>    https://patchwork.kernel.org/project/dri-devel/patch/20240806104733.2018783-1-xiaolei.wang@windriver.com/
>>>
>>> v2:
>>>    Modify the issue of not retaining GFP_USER in v1 and update the commit log.
>>>
>>> v3:
>>>    Use "priv->shm_gfp_mask = GFP_USER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;"
>>> instead of
>>>    "priv->shm_gfp_mask = GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;"
>> I don't understand this part of the changes in the new version. Why
>> should we drop the HIGHMEM bit always and not only in the case where
>> dma addressing is limited? This seems overly restrictive.
>
> Makes sense, thanks for your reminder, I will drop the HIGHMEM bit 
> when the next version has address limit
>
>     if (dma_addressing_limited(gpu->dev)) {
>         priv->shm_gfp_mask |= GFP_DMA32;
>         priv->shm_gfp_mask &= ~__GFP_HIGHMEM;
>     }
>
> thanks
>
> xiaolei
>
>> Regards,
>> Lucas
>>
>>> and move the check of whether to get a page from DMA32 to etnaviv_bind().
>>>
>>>   drivers/gpu/drm/etnaviv/etnaviv_drv.c | 10 +++++++++-
>>>   drivers/gpu/drm/etnaviv/etnaviv_gpu.c |  8 --------
>>>   2 files changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>>> index 6500f3999c5f..8cb2c3ec8e5d 100644
>>> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>>> @@ -536,7 +536,15 @@ static int etnaviv_bind(struct device *dev)
>>>        mutex_init(&priv->gem_lock);
>>>        INIT_LIST_HEAD(&priv->gem_list);
>>>        priv->num_gpus = 0;
>>> -     priv->shm_gfp_mask = GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
>>> +     priv->shm_gfp_mask = GFP_USER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
>>> +
>>> +     /*
>>> +      * If the GPU is part of a system with DMA addressing limitations,
>>> +      * request pages for our SHM backend buffers from the DMA32 zone to
>>> +      * hopefully avoid performance killing SWIOTLB bounce buffering.
>>> +      */
>>> +     if (dma_addressing_limited(dev))
>>> +             priv->shm_gfp_mask |= GFP_DMA32;
>>>
>>>        priv->cmdbuf_suballoc = etnaviv_cmdbuf_suballoc_new(drm->dev);
>>>        if (IS_ERR(priv->cmdbuf_suballoc)) {
>>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>>> index 7c7f97793ddd..5e753dd42f72 100644
>>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>>> @@ -839,14 +839,6 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
>>>        if (ret)
>>>                goto fail;
>>>
>>> -     /*
>>> -      * If the GPU is part of a system with DMA addressing limitations,
>>> -      * request pages for our SHM backend buffers from the DMA32 zone to
>>> -      * hopefully avoid performance killing SWIOTLB bounce buffering.
>>> -      */
>>> -     if (dma_addressing_limited(gpu->dev))
>>> -             priv->shm_gfp_mask |= GFP_DMA32;
>>> -
>>>        /* Create buffer: */
>>>        ret = etnaviv_cmdbuf_init(priv->cmdbuf_suballoc, &gpu->buffer,
>>>                                  PAGE_SIZE);

-- 
Best regards,
Sui


