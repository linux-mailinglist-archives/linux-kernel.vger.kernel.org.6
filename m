Return-Path: <linux-kernel+bounces-346541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A30098C5B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECC31C22846
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF8A1CC176;
	Tue,  1 Oct 2024 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G8e9+EFU"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4E91C242E
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808745; cv=none; b=pvUSuEL8NSqcTGWHKWZMjKBaHOqcx96C5utp9Zqekz53ZvBnUP+eYhf8DmJgCBLM90UOBB/FXz/LmO9oaZrbc4ED00oVyonbuoFCDpVjUTrilvDfAP5jXdHLqA5UvLzut+1I3BAO4htQ42hahUZrPJ2rQr9eDOISCnDdNNCUe5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808745; c=relaxed/simple;
	bh=Lozrga7FvxJL7ZcTbkR7Z6KapyidZX3mtMMyRULtvl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAxKDfYh2HCXWkrDxag67qiB9T/YJo8FGTYNve9dYgGfDc/cjVyKCMgRJP2AtbhrmMiB/4eVAbDiFpPUYFAdcDNaaZHJJOgai0AJNETZj6O3eornSfLioHNtb85rFqGPCR53SqH8i7Fx1rp/IqEk3ts+3ReQ08M3wMvlq5pAl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G8e9+EFU; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <abaf2911-8312-48db-9fe1-c9ee2c504c12@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727808740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uknnqffaMAXkaWSb+ZKDtQjaxOO4Fpx7xtRqM5uVvNU=;
	b=G8e9+EFUGm2c7v1PGQnpW6e6NdwEcQJ2rY8GjRZ1HWIPOLvq6eAEIQTb4THQs2fsBmMA+I
	6c0NSyMK3J6DlSkLKu1M2NmiSKP7VZjg/siVhTg8orGZeD3AhX0LlmhNjK09UHoTXflKx3
	ooa7G4P/t5Ht8Cb8ZmIYC4vpYrMbpPQ=
Date: Wed, 2 Oct 2024 02:52:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v15 16/19] drm/etnaviv: Call etnaviv_gem_obj_add() in
 ernaviv_gem_new_private()
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240908094357.291862-1-sui.jingfeng@linux.dev>
 <20240908094357.291862-17-sui.jingfeng@linux.dev>
 <67cce03c96f5e4d08d837b77c723fdaf214f7c0d.camel@pengutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <67cce03c96f5e4d08d837b77c723fdaf214f7c0d.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2024/10/1 22:39, Lucas Stach wrote:
> Am Sonntag, dem 08.09.2024 um 17:43 +0800 schrieb Sui Jingfeng:
>> The etnaviv_gem_obj_add() a common operation, the 'etnaviv_drm_private::
>> gem_list' is being used to record(track) all of the etnaviv GEM buffer
>> object created in this driver.
>>
>> Once a etnaviv GEM buffer object has been allocated successfully, we
>> should add it into the global etnaviv_drm_private::gem_list'. Because
>> we need to free it and remove it free the list if the invoke of the
>> subsequent functions fail.
>>
>> The only way that destroy etnaviv GEM buffer object is the implementation
>> of etnaviv_gem_free_object() function. The etnaviv_gem_free_object() first
>> remove the etnaviv GEM object from the list, then destroy its mapping and
>> finally free its memory footprint. Therefore, in order to corresponding
>> this, we add the freshly created etnaviv GEM buffer object immediately
>> after it was successfully created.
>>
>> A benifit is that we only need to call etnaviv_gem_obj_add() once now,
>> since the ernaviv_gem_new_private() has been unified. Make the
>> etnaviv_gem_obj_add() static is a next nature thing.
>>
> Seeing this patch, I would really ask you to drop patch 11 from this
> series and go the other way around: remove etnaviv_gem_obj_add() here
> altogether and simply inline the few lines of code into
> etnaviv_gem_new_private().


The 'etnaviv_drm_private::gem_list' is being used to manage the buffer
object itself, not the backing memory of a specific buffer object.

Therefore, once a etnaviv GEM buffer object is successfully created,
we want to add it into the global etnaviv_drm_private::gem_list'.
To prevent the cases which removing an entry that is not in the list.

Both etnaviv_gem_obj_add() and etnaviv_gem_obj_remove() touches driver
private but shared data members. Which has nothing to do with the GEM
core functionality itself.

The unction pair is for tracking, recording, listing and showing
purpose. Which is clearly separated functionality. Split them from
the BO construction is a untangled fashion and is a good thing.


> Regards,
> Lucas
>
>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>> ---
>>   drivers/gpu/drm/etnaviv/etnaviv_gem.c       | 8 +++-----
>>   drivers/gpu/drm/etnaviv/etnaviv_gem.h       | 1 -
>>   drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 2 --
>>   3 files changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
>> index 27e4a93c981c..ee799c02d0aa 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
>> @@ -584,7 +584,7 @@ void etnaviv_gem_free_object(struct drm_gem_object *obj)
>>   	kfree(etnaviv_obj);
>>   }
>>   
>> -void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *obj)
>> +static void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *obj)
>>   {
>>   	struct etnaviv_drm_private *priv = to_etnaviv_priv(dev);
>>   	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
>> @@ -719,8 +719,6 @@ int etnaviv_gem_new_handle(struct drm_device *dev, struct drm_file *file,
>>   	 */
>>   	mapping_set_gfp_mask(obj->filp->f_mapping, priv->shm_gfp_mask);
>>   
>> -	etnaviv_gem_obj_add(dev, obj);
>> -
>>   	ret = drm_gem_handle_create(file, obj, handle);
>>   
>>   	/* drop reference from allocate - handle holds it now */
>> @@ -751,6 +749,8 @@ int etnaviv_gem_new_private(struct drm_device *dev, size_t size, u32 flags,
>>   		drm_gem_private_object_init(dev, obj, size);
>>   	}
>>   
>> +	etnaviv_gem_obj_add(dev, obj);
>> +
>>   	*res = to_etnaviv_bo(obj);
>>   
>>   	return 0;
>> @@ -849,8 +849,6 @@ int etnaviv_gem_new_userptr(struct drm_device *dev, struct drm_file *file,
>>   	etnaviv_obj->userptr.mm = current->mm;
>>   	etnaviv_obj->userptr.ro = !(flags & ETNA_USERPTR_WRITE);
>>   
>> -	etnaviv_gem_obj_add(dev, &etnaviv_obj->base);
>> -
>>   	ret = drm_gem_handle_create(file, &etnaviv_obj->base, handle);
>>   
>>   	/* drop reference from allocate - handle holds it now */
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
>> index b174a9e4cc48..8d8fc5b3a541 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
>> @@ -121,7 +121,6 @@ int etnaviv_gem_new_private(struct drm_device *dev, size_t size, u32 flags,
>>   			    bool shmem, const struct etnaviv_gem_ops *ops,
>>   			    struct etnaviv_gem_object **res);
>>   
>> -void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *obj);
>>   struct page **etnaviv_gem_get_pages(struct etnaviv_gem_object *obj);
>>   void etnaviv_gem_put_pages(struct etnaviv_gem_object *obj);
>>   
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>> index 64a858a0b0cf..04ee31461b8c 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>> @@ -127,8 +127,6 @@ struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
>>   	if (ret)
>>   		goto fail;
>>   
>> -	etnaviv_gem_obj_add(dev, &etnaviv_obj->base);
>> -
>>   	return &etnaviv_obj->base;
>>   
>>   fail:

-- 
Best regards,
Sui


