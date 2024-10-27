Return-Path: <linux-kernel+bounces-383467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C319B1C30
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 05:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E411F21BFD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 04:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE202AEF1;
	Sun, 27 Oct 2024 04:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SJssK9NX"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C18217F3B
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 04:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730004526; cv=none; b=Lcc3CTQDsVzeoC1FEcCkRs/VEKhQ6xA9schsoNKrBexB88O6ZtJ0LSE45lcla6X9TdcATFq/on3gZ2k9pDTliR1zXCy85PFtt3fEPVor1QKEf5xg01//ychtumCvRUbw3jc+5C2rDFMLqRJMq6/06OWMXTTwd8gsoSrzYlimhjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730004526; c=relaxed/simple;
	bh=fDki5Wc0yOakngK0W6QXLIrERFLaO2I3WibCoccF7tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/UcJviqKp98N7TK2WigOu55LnpSJ0Pkbp9i91Kdyo1DDH6ehqeGVPqbxFrxJiyevW9q4zkoz9rC0qX9/rvyV+JCxEnp3lKaESqF2wfY9TP8uRm8kbAJ4l+PBLeK4pR2cRUQCLkU9XIprE2xf5WSLHhRb1bJA+BCd72c0TB6wZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SJssK9NX; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c86f224d-fdd3-4b91-a0d1-0a34e38236f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730004519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/LSorqQbck8YB4T0NmsqrtoTk57hv8mFuEl/XEJMvTs=;
	b=SJssK9NXel3SGm4jK3DxYAZvL9fP6n6z7iZY+8ah2HX8aDgsP/XlVPECPFMGeqsiiJ1R1x
	sc7Tz1xQGhfdSoG84+NYX4HPSWEi67IBuNinN0yrSyfn4qxcQwB+c/i9xwxaMTTv+KhjYY
	NcULPT/HRZXfAHQIhkIFlj/Pk7GXtos=
Date: Sun, 27 Oct 2024 12:48:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] drm/etnaviv: Track GPU VA size separately
To: Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241004194207.1013744-1-sui.jingfeng@linux.dev>
 <20241004194207.1013744-2-sui.jingfeng@linux.dev>
 <b93c08b0bab16c86190ca186f20d2cb036a4b8d0.camel@pengutronix.de>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <b93c08b0bab16c86190ca186f20d2cb036a4b8d0.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 10/7/24 18:12, Lucas Stach wrote:
> Am Samstag, dem 05.10.2024 um 03:42 +0800 schrieb Sui Jingfeng:
>> Etnaviv assumes that GPU page size is 4KiB, yet on some systems, the CPU
>> page size is 16KiB. The size of etnaviv buffer objects will be aligned
>> to CPU page size on kernel side, however, userspace still assumes the
>> page size is 4KiB and doing allocation with 4KiB page as unit. This
>> results in userspace allocated GPU virtual address range collision and
>> therefore unable to be inserted to the specified hole exactly.
>>
>> The root cause is that kernel side BO takes up bigger address space than
>> userspace assumes when the size of it is not CPU page size aligned. To
>> Preserve GPU VA continuous as much as possible, track the size that
>> userspace/GPU think of it is.
>>
>> Yes, we still need to overallocate to suit the CPU, but there is no need
>> to waste GPU VA space anymore.
>>
>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>> ---
>>   drivers/gpu/drm/etnaviv/etnaviv_gem.c | 8 +++++---
>>   drivers/gpu/drm/etnaviv/etnaviv_gem.h | 1 +
>>   drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 8 ++++----
>>   3 files changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
>> index 5c0c9d4e3be1..943fc20093e6 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
>> @@ -543,7 +543,7 @@ static const struct drm_gem_object_funcs etnaviv_gem_object_funcs = {
>>   	.vm_ops = &vm_ops,
>>   };
>>   
>> -static int etnaviv_gem_new_impl(struct drm_device *dev, u32 flags,
>> +static int etnaviv_gem_new_impl(struct drm_device *dev, u32 size, u32 flags,
>>   	const struct etnaviv_gem_ops *ops, struct drm_gem_object **obj)
>>   {
>>   	struct etnaviv_gem_object *etnaviv_obj;
>> @@ -570,6 +570,7 @@ static int etnaviv_gem_new_impl(struct drm_device *dev, u32 flags,
>>   	if (!etnaviv_obj)
>>   		return -ENOMEM;
>>   
>> +	etnaviv_obj->user_size = size;
>>   	etnaviv_obj->flags = flags;
>>   	etnaviv_obj->ops = ops;
>>   
>> @@ -588,11 +589,12 @@ int etnaviv_gem_new_handle(struct drm_device *dev, struct drm_file *file,
>>   {
>>   	struct etnaviv_drm_private *priv = dev->dev_private;
>>   	struct drm_gem_object *obj = NULL;
>> +	unsigned int user_size = size;
> 
> This still needs to be be aligned to 4K. 

Yes, extremely correct here, for the perspective of concept.

Have to be GPU page size aligned, because the GPU map 4KiB once a time.
GPU will access full range of a 4KiB page, and this is out of CPU's
control.

> Userspace may request unaligned buffer sizes 

User-space shall *NOT* request unaligned buffer, since user-space
*already* made the assumption GPU page is 4KiB. Then it's the user
space's responsibility that keeping requested buffer aligned.

- The kernel space actually can and *should* return aligned size
   to user-space though.

- Since softpin feature is landed, it becomes evident that kernel
   space need user-space *report* a correct length of GPUVA.

But I'm fine with the kernel pay some extra price for safe reasons.

Best regards,
Sui

> and we don't want to risk any confusion about
> which part is visible to the GPU, so better make sure this size is
> aligned to the GPU page size.
> Also, that more personal preference, but I would call this gpu_size or
> something like that, to avoid any confusion with the user_size in> etnaviv_cmdbuf, where user_size doesn't denote the GPU visible size.
>
> Regards,
> Lucas
> 
>>   	int ret;
>>   
>>   	size = PAGE_ALIGN(size);
>>   
>> -	ret = etnaviv_gem_new_impl(dev, flags, &etnaviv_gem_shmem_ops, &obj);
>> +	ret = etnaviv_gem_new_impl(dev, user_size, flags, &etnaviv_gem_shmem_ops, &obj);
>>   	if (ret)
>>   		goto fail;
>>   
>> @@ -627,7 +629,7 @@ int etnaviv_gem_new_private(struct drm_device *dev, size_t size, u32 flags,
>>   	struct drm_gem_object *obj;
>>   	int ret;
>>   
>> -	ret = etnaviv_gem_new_impl(dev, flags, ops, &obj);
>> +	ret = etnaviv_gem_new_impl(dev, size, flags, ops, &obj);
>>   	if (ret)
>>   		return ret;
>>   
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
>> index a42d260cac2c..c6e27b9abb0c 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
>> @@ -36,6 +36,7 @@ struct etnaviv_gem_object {
>>   	const struct etnaviv_gem_ops *ops;
>>   	struct mutex lock;
>>   
>> +	u32 user_size;
>>   	u32 flags;
>>   
>>   	struct list_head gem_node;
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
>> index 1661d589bf3e..6fbc62772d85 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
>> @@ -281,6 +281,7 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_context *context,
>>   {
>>   	struct sg_table *sgt = etnaviv_obj->sgt;
>>   	struct drm_mm_node *node;
>> +	unsigned int user_size;
>>   	int ret;
>>   
>>   	lockdep_assert_held(&etnaviv_obj->lock);
>> @@ -303,13 +304,12 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_context *context,
>>   	}
>>   
>>   	node = &mapping->vram_node;
>> +	user_size = etnaviv_obj->user_size;
>>   
>>   	if (va)
>> -		ret = etnaviv_iommu_insert_exact(context, node,
>> -						 etnaviv_obj->base.size, va);
>> +		ret = etnaviv_iommu_insert_exact(context, node, user_size, va);
>>   	else
>> -		ret = etnaviv_iommu_find_iova(context, node,
>> -					      etnaviv_obj->base.size);
>> +		ret = etnaviv_iommu_find_iova(context, node, user_size);
>>   	if (ret < 0)
>>   		goto unlock;
>>   
> 

-- 
Best regards
Sui


