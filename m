Return-Path: <linux-kernel+bounces-309404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DA09669F7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CFC2813C8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56591BCA1E;
	Fri, 30 Aug 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ku6SQfVc"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DD133CD1
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046830; cv=none; b=QS+lz1INRzXZEL9e7X9+bOWRJEqGNHdTvk6OX5a7zsSjguL33tb/AiinLmwJCOfBgoXwg3LuB5VUASjR98LCmVQnytyUhiC+Jn7E8lZBetGUj0soulCpBIdi2HOKfrmhzbp2V4oxZkH2tW/4cgKSynP4uinu+7Y7s2lLZolIxwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046830; c=relaxed/simple;
	bh=Uq22PjTwuKDZqezS2o6pKqU0faLiwSgaVD8tjT0+Gyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=od7XvRJNvZI0t8UIvS5mvMFnBKa/pBlIp+V4H8Hd9lKK6v9K0Jm+FiQae5VYQh94jXxoE1DqQ+tpZ6sDhDT6t+7DbfNTSjXH110/4WeSu4h3nMZaoIxC3iZBXJsrhIxXP0iR6ao8VweWMry8cOnybFHJ04ZRLUrDxihqVXho0D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ku6SQfVc; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <761c07a9-a507-44a6-94e5-69655881c137@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725046824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P23hzakT4iTBeTQQZIxqORb4IwFukzfuhRAvyZU6U08=;
	b=ku6SQfVc3QfWZJGgEvQbT0ayyu3NFuPKSTJ5kiD1Vo1ZCqFOPC0+mk243x+a2dS2qz/2VI
	sFqqa1ANZBkQgaQtJq8jrE+xFSbT4c9B71Wn17Y+rMJGK/Dg5MgDevRbpmpzci3T6rD3Di
	9E0F7HgDi7P26Eak0vEoBDPmH0KYgqE=
Date: Sat, 31 Aug 2024 03:40:11 +0800
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


On 2024/8/16 09:55, Wang, Xiaolei wrote:
> Ping ...

I think, the more proper fix that Lucas hint
is to modify the 'priv->shm_gfp_mask' variable
in the|etnaviv_bind() function|. Say:
|Use "priv->shm_gfp_mask = GFP_USER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;"|

instead of

|"priv->shm_gfp_mask = ||GFP_HIGHUSER||| __GFP_RETRY_MAYFAIL | __GFP_NOWARN;|"


Right?

> thanks
> xiaolei
>
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
>
>           /* Create buffer: */
>           ret = etnaviv_cmdbuf_init(priv->cmdbuf_suballoc, &gpu->buffer,

-- 
Best regards,
Sui


