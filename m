Return-Path: <linux-kernel+bounces-382939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BE69B153E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 07:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DE42834CF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 05:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A78E1632C7;
	Sat, 26 Oct 2024 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bx0cYzVm"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F9633EA
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729922134; cv=none; b=BqRXEKTD6DkdU8UeE9PYGiAAUUi2I0QndzZpjZIpi7xqyTDayN95S96WDBq+WCYjqBDmVRarbP2rdFHtNl7XE0chRPen2TTtSvmDvImxgaPQ69QFwYRUR7Q6ykGrBtjatlDHaP89DKqwD2fhi/EbSK/xfXPy+L07Xp1i3HmeBMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729922134; c=relaxed/simple;
	bh=Z7dWDC0IctMheuYtFg6+xJdxxmkBuos71d3XAisj8/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLEOfL88EE/lC9ILY4HApr3d6030Q/CxFovftrp+BntQMTPazrlEhfUn6JKw9Kr7NavSwUUBfiu/l+G13TYxKppx9C87FDjdR41zOdT4tSoffzC17BtjB8tSp7kCrOmA+hkz4NOzb8ROs8oeW0d+RTEAR/mm0DJlb/mp1+i0WFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bx0cYzVm; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eb0da085-5672-4a6e-b2d7-df628542cfdf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729922130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/BnGth3qVS+yRRXcpYmVqCPs6VRyBTiCHU46Zrgryw=;
	b=Bx0cYzVmFGQ6sTpwDqh78AeWGOU0V9iskS2y8jBjslpBYmBPYe+whDrUW4cPn2r0llovq6
	0TRQ82XcVDEI8clYOGwx3hpVwOwpM09OgCG8T81NlsjFJBcaSSYDrmfzTnnxloeMMezCJX
	vcRMnIt/pkvhQvGZkYd+ykoN0tToEJE=
Date: Sat, 26 Oct 2024 13:55:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] drm/etnaviv: Map and unmap the GPU VA range with
 respect to its user size
To: Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241004194207.1013744-1-sui.jingfeng@linux.dev>
 <20241004194207.1013744-3-sui.jingfeng@linux.dev>
 <13b9c1bde7f0534f7f3c576126def206bdafd60c.camel@pengutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <13b9c1bde7f0534f7f3c576126def206bdafd60c.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2024/10/7 18:17, Lucas Stach wrote:
>>   
>> @@ -104,21 +108,7 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context, u32 iova,
>>   static void etnaviv_iommu_unmap(struct etnaviv_iommu_context *context, u32 iova,
>>   				struct sg_table *sgt, unsigned len)
>>   {
>> -	struct scatterlist *sg;
>> -	unsigned int da = iova;
>> -	int i;
>> -
>> -	for_each_sgtable_dma_sg(sgt, sg, i) {
>> -		size_t bytes = sg_dma_len(sg) + sg->offset;


Why the length of a single SG segment is `sg_dma_len(sg) + sg->offset` here?


>> -		etnaviv_context_unmap(context, da, bytes);
>> -
>> -		VERB("unmap[%d]: %08x(%zx)", i, iova, bytes);
>> -
>> -		BUG_ON(!PAGE_ALIGNED(bytes));
>> -
>> -		da += bytes;
>> -	}
>> +	etnaviv_context_unmap(context, iova, len);
> This drops some sanity checks, but I have only ever seen them fire when
> we had other kernel memory corruption issues, so I'm fine with the
> simplification you did here.


Isn't that 'sg_dma_len(sg)' itself is the length of its backing memory ?


> Regards,
> Lucas

-- 
Best regards,
Sui


