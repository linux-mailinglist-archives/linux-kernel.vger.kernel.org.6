Return-Path: <linux-kernel+bounces-346569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B3B98C602
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A291F23661
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3126B1CCEE1;
	Tue,  1 Oct 2024 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bBAVKu6z"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD451CCB41
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810821; cv=none; b=rywTQHjRke9Vsz1yJriGb/Sq3ednM4zhYib2BsFkXGNutZ7Z3SR3eWscWI8tlfUA/KM2MydeM9X6Jus/WcPAKqE5DGkl0kawXYB4GTkeDyYffLMhdurnu/5r763DoLldRqAEJFgxadl7sc4IZC8D0BbnIq3aMbhXBpnz8jOW/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810821; c=relaxed/simple;
	bh=O6pVsrBJNWu6ulLm86s71/ArJYB3f8hNWKesFggnUss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZgA7RKCUJA1vsNh4N19PDa5t5Pn/h3aQyezOfsWWSgssZWeE6Ao3CiTsLAi5suYIplHUckfxF5V6+we1gORcwNVsagA3iDLaRTCVXk7MtfQkzi1KFfsfGKPdqmltSixoAIUpd1hQXKh3wExKLMMmSodb/zv39Po5PgJdXQqjvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bBAVKu6z; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <46c64cf0-4cd5-4b6f-a224-ffe4bac5bb7a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727810816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0OsDS4gQjPi2gzEJxpMcxlJylzmmO17YMUNLvUo+5I=;
	b=bBAVKu6z9+t0XqnlCeRAKs1GFkTXKSrkakw4kTIlfb3eAH702sLg2knyD+RoygGayfIF+p
	HY1oKScnljKa+zGRexE79nuwbzI4aZ1DYc9XJR/Yf6qRsjpnPw88LfKe1U5APVvSvvBve2
	c+WDAPiZBBJdq2WNJoXANttigkHyCrE=
Date: Wed, 2 Oct 2024 03:26:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/etnaviv: Print error message if inserting IOVA
 address range fails
To: Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240930221706.399139-1-sui.jingfeng@linux.dev>
 <ca5e444a22bae0a834a673e41e8d5b93c08f2351.camel@pengutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <ca5e444a22bae0a834a673e41e8d5b93c08f2351.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2024/10/1 16:27, Lucas Stach wrote:
> Hi Sui,
>
> Am Dienstag, dem 01.10.2024 um 06:17 +0800 schrieb Sui Jingfeng:
>> Etnaviv assumes that GPU page size is 4KiB, yet on some systems, the CPU
>> page size is 16 KiB. The size of etnaviv buffer objects will be aligned
>> to CPU page size on kernel side, however, userspace still assumes the
>> page size is 4KiB and doing allocation with 4KiB page as unit. This
>> results in softpin(userspace managed per-process address spaces) fails.
>> Because kernel side BO takes up bigger address space than user space
>> assumes whenever the size of a BO is not CPU page size aligned.
>>
> Seems we need to track the GPU and CPU allocation sizes separately.


The idea is cool and fancy, I have been tried.

By adding a 'user_size' member into the struct etnaviv_gem_object,
and use this 'user_size'; to track the actual size that user-space
thing of. (or in other words, the actual size that potential user
allow to use)

Using 'user_size' is pin, this partly solve VA address space collision
under softpin fashion. This is partly works under my hasty test. But ...

> Userspace is correct in assuming that the GPU page size is 4K and
> buffers are aligned to this granule.


Vivante GPU support 4KB and 64KB GPU page size.


>   There should be no need to waste GPU VA space


We have nearly 4GBGPU VA space, As far as I can see it, we only use a few. So, is it true 
that we are wealthy about the VA space?


> just because the CPU page size is larger than that and we
> need to overallocate buffers to suit the CPU.


A single CPU page share the same caching property, therefore, I image that
asingle VA address  range at least should occupy entire room of a single CPU
page.

Otherwise, it possible that 4 GPUVA share a single CPU page.
if each GPUVA  mapped with a different caching property from others.
This get coherency requirements involved.


>> Insert an error message to help debug when such an issue happen.
>>
>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>> ---
>> For example, when running glmark2-drm:
>>
>> [kernel space debug log]
>>
>>   etnaviv 0000:03:00.0: Insert bo failed, va: fd38b000, size: 4000
>>   etnaviv 0000:03:00.0: Insert bo failed, va: fd38a000, size: 4000
>>
>> [user space debug log]
>>
>> bo->va = 0xfd48c000, bo->size=100000
>> bo->va = 0xfd38c000, bo->size=100000
>> bo->va = 0xfd38b000, bo->size=1000   <-- Insert IOVA fails started at here.
>> bo->va = 0xfd38a000, bo->size=1000
>> bo->va = 0xfd389000, bo->size=1000
>>
>> [texture] texture-filter=nearest:MESA: error: etna_cmd_stream_flush:238: submit failed: -28 (No space left on device)
>> ---
>>   drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
>> index 1661d589bf3e..682f27b27d59 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
>> @@ -310,8 +310,12 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_context *context,
>>   	else
>>   		ret = etnaviv_iommu_find_iova(context, node,
>>   					      etnaviv_obj->base.size);
>> -	if (ret < 0)
>> +	if (ret < 0) {
>> +		dev_err(context->global->dev,
>> +			"Insert iova failed, va: %llx, size: %zx\n",
>> +			va, etnaviv_obj->base.size);
> As this might happen for a lot of buffers in a single submit and
> userspace might be unimpressed by the submit failure and keep pushing
> new submits, this has a potential to spam the logs. Please use
> dev_err_ratelimited. Other than that, this patch looks good.
>
> Regards,
> Lucas
>
>>   		goto unlock;
>> +	}
>>   
>>   	mapping->iova = node->start;
>>   	ret = etnaviv_iommu_map(context, node->start, sgt,

-- 
Best regards,
Sui


