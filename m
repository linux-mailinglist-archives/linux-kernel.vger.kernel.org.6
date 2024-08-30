Return-Path: <linux-kernel+bounces-309409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF7A966A11
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DBC1C21893
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7E91BE24D;
	Fri, 30 Aug 2024 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UVUQhKxz"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496E11917E2
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725047354; cv=none; b=ZAuS1hj88lp91q1hDP8jWqdDcZatABD7Sn7OeE4pWgxmgKZ/vquFMqOSnd0gdHGmOKrrGvZycqAC9sgPyKcBnttAp54nq3iDfLKt3Fzilg/wFimto9E3Q8eJk9gcKOISKdyPImmndS6hV4boVmBPwMSPydh3Xc9iG1meQHT3jWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725047354; c=relaxed/simple;
	bh=54rlFx/3c2EOQha/7eX/V/SYQcDAjq7KmBH/sJ9P/uY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=I84ceAyeW6NelgXY3e9P/0YovbvNkV0TEoR3hFCM4hOtWzUZKQZyFAtXADbR09leVkGPSzQniP/9dBJ0rGQeXzOgGUa2riPuTxFOcs96uZ3nHSFdWWoyB0UXojMm1iH0opokB+z8miTHveb8Y5/02U6+6Zi8+y09iSSVFWFALvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UVUQhKxz; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ee484db3-48e5-434f-8f41-21535c1bf069@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725047350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jlo7JXcZy13WFGclfaaL1pYp+Vqeb6IGWRjH5IJWAM8=;
	b=UVUQhKxzPkbU6KYHPDeNVPypYrkPwtMT9wxRxMe3vaHiVR6pTwY2ikE7u8Vsy2KBMCHza7
	qpat9lOCHFyBqpERh7nv3Rt50e9fyuP/pt3NXejBp3NC/vwTzEiRDV+QW8AujIlywr7s65
	unHj1N2lBjwdEZVdKaPmXV6yuns67fc=
Date: Sat, 31 Aug 2024 03:48:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v2] drm/etnaviv: Clear the __GFP_HIGHMEM bit in GFP_HIGHUSER
 with 32 address
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "linux+etnaviv@armlinux.org.uk" <linux+etnaviv@armlinux.org.uk>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>
Cc: "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <MW5PR11MB57648F441CEDD36E614E31EA95812@MW5PR11MB5764.namprd11.prod.outlook.com>
 <761c07a9-a507-44a6-94e5-69655881c137@linux.dev>
Content-Language: en-US
In-Reply-To: <761c07a9-a507-44a6-94e5-69655881c137@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/8/31 03:40, Sui Jingfeng wrote:
> Hi, Xiaolei
>
>
> On 2024/8/16 09:55, Wang, Xiaolei wrote:
>> Ping ...
>
> I think, the more proper fix that Lucas hint
> is to modify the 'priv->shm_gfp_mask' variable
> in the|etnaviv_bind() function|. Say:
> |Use "priv->shm_gfp_mask = GFP_USER | __GFP_RETRY_MAYFAIL | 
> __GFP_NOWARN;"|
>
> instead of
>
> |"priv->shm_gfp_mask = ||GFP_HIGHUSER||| __GFP_RETRY_MAYFAIL | 
> __GFP_NOWARN;|"
>
>

Oops, please ignore the irrelevant(superfluous) "|" characters in my
reply, my Thunderbird mail client has some problem, generate them unreasonably.

Should be:

priv->shm_gfp_mask = GFP_USER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;



> Right?
>
>> thanks
>> xiaolei
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c 
>> b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>> index 7c7f97793ddd..0e6bdf2d028b 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>> @@ -844,8 +844,10 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
>>            * request pages for our SHM backend buffers from the DMA32 
>> zone to
>>            * hopefully avoid performance killing SWIOTLB bounce 
>> buffering.
>>            */
>> -       if (dma_addressing_limited(gpu->dev))
>> +       if (dma_addressing_limited(gpu->dev)) {
>>                   priv->shm_gfp_mask |= GFP_DMA32;
>> +               priv->shm_gfp_mask &= ~__GFP_HIGHMEM;
>> +       }
>>
>>           /* Create buffer: */
>>           ret = etnaviv_cmdbuf_init(priv->cmdbuf_suballoc, &gpu->buffer,
>
-- 
Best regards,
Sui


