Return-Path: <linux-kernel+bounces-179755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEF68C64DB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72BB284262
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116A75B5D6;
	Wed, 15 May 2024 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ln2EYHxh"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434B457CB5
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715768286; cv=none; b=Uac7q70NdJ+RtR9Ez3+tXmgR2QoedVa38IVWvyfDkIiMmcwb3n+MBgidXtB1RBfhDksHjCPxZg3/r3Zk1508W5kLzeVxYUsOn2E2MbP+OZ5ndu6R6mpkXkHOes5W3fN8PE2sXOfkEZBE7qiRBNbsXDudP4OXYJNwtKDCe0jVk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715768286; c=relaxed/simple;
	bh=HZmSbXyU3hpvHdoAzRPMgQxxbjAHbble9Zvbis0GGM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMkGTiOAe0nJb8D8vd8cW7OFio49uf96MemwNWLeIDJyDq2jF3pHJwcLeYNJN39gxrijfAxYiIUwBZu62r/IE7MTOWcs4KUSzzwCa7t4JDMUcL42tpIn3PUnMXO78+HvDVi5gG1nf9qwi7kq28x462MYqGS05Z13LNqpozsmzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ln2EYHxh; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cd81893c-ef0b-4906-8c9c-a98b1e4669e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715768281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4bPo+Qa7F8LO4Fc7UnSEAOeiesDvsWpSbzqmxMaNJ8=;
	b=Ln2EYHxhwFGpKwfS/XLNBsne9LO+m3A/HUSpX7uERE6RNJb3V677vVfWXfrPYTqe/EY4p/
	FuTIL18AKvEfPUoDiFODaJAg1U2iCBJXupbLIfWuy7bM8o9t4uzdALugjtu58AEn/Xpqbv
	+oya1XNUuClJTAKwGXIpUhvawy2OcYo=
Date: Wed, 15 May 2024 18:17:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] drm/bridge: Support finding bridge with struct device
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Maxime Ripard <mripard@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240514154045.309925-1-sui.jingfeng@linux.dev>
 <20240514154045.309925-2-sui.jingfeng@linux.dev> <87v83fct2e.fsf@intel.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <87v83fct2e.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 5/15/24 17:39, Jani Nikula wrote:
> On Tue, 14 May 2024, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>> The pointer of 'struct device' can also be used as a key to search drm
>> bridge instance from the global bridge list, traditionally, fwnode and
>> 'OF' based APIs requires the system has decent fwnode/OF Graph support.
>> While the drm_find_bridge_by_dev() function introduced in this series
>> don't has such a restriction. It only require you has a pointer to the
>> backing device. Hence, it may suitable for some small and/or limited
>> display subsystems.
>>
>> Also add the drm_bridge_add_with_dev() as a helper, which automatically
>> set the .of_node field of drm_bridge instances if you call it. But it
>> suitable for simple bridge drivers which one device backing one drm_bridge
>> instance.
>>
>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>> ---
>>   drivers/gpu/drm/drm_bridge.c | 39 ++++++++++++++++++++++++++++++++++++
>>   include/drm/drm_bridge.h     |  5 +++++
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
>> index 584d109330ab..1928d9d0dd3c 100644
>> --- a/drivers/gpu/drm/drm_bridge.c
>> +++ b/drivers/gpu/drm/drm_bridge.c
>> @@ -213,6 +213,23 @@ void drm_bridge_add(struct drm_bridge *bridge)
>>   }
>>   EXPORT_SYMBOL(drm_bridge_add);
>>   
>> +/**
>> + * drm_bridge_add_with_dev - add the given bridge to the global bridge list
>> + *
>> + * @bridge: bridge control structure
>> + * @dev: pointer to the kernel device that this bridge is backed.
>> + */
>> +void drm_bridge_add_with_dev(struct drm_bridge *bridge, struct device *dev)
>> +{
>> +	if (dev) {
>> +		bridge->kdev = dev;
>> +		bridge->of_node = dev->of_node;
>> +	}
>> +
>> +	drm_bridge_add(bridge);
>> +}
>> +EXPORT_SYMBOL_GPL(drm_bridge_add_with_dev);
> 
> I don't actually have an opinion on whether the dev parameter is useful
> or not.
> 
> But please don't add a drm_bridge_add_with_dev() and then convert more
> than half the drm_bridge_add() users to that. Please just add a struct
> device *dev parameter to drm_bridge_add(), and pass NULL if it's not
> relevant.
> 

To be honest, previously, I'm just do it exactly same as the way you
told me here. But I'm exhausted and finally give up.

Because this is again need me to modify *all* callers of 
drm_bridge_add(), not only those bridges in drm/bridge/, but also
bridge instances in various KMS drivers.

However, their some exceptions just don't fit!

For example, the imx/imx8qxp-pixel-combiner.c just don't fit our
simple model. Our helper function assume that one device backing
one drm_bridge instance (1 to 1). Yet, that driver backing two or
more bridges with one platform device (1 to 2, 1 to 3, ..., ).
Hence, the imx/imx8qxp-pixel-combiner.c just can't use 
drm_bridge_add_with_dev().

The aux_hpd_bridge.c is also bad, it store the of_node of struct device 
at the .platform_data member of the struct device.

> BR,
> Jani.
> 
> 
>> +
>>   static void drm_bridge_remove_void(void *bridge)
>>   {
>>   	drm_bridge_remove(bridge);
>> @@ -1334,6 +1351,27 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridge,
>>   }
>>   EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify);
>>   
>> +struct drm_bridge *drm_find_bridge_by_dev(struct device *kdev)
>> +{
>> +	struct drm_bridge *bridge;
>> +
>> +	if (!kdev)
>> +		return NULL;
>> +
>> +	mutex_lock(&bridge_lock);
>> +
>> +	list_for_each_entry(bridge, &bridge_list, list) {
>> +		if (bridge->kdev == kdev) {
>> +			mutex_unlock(&bridge_lock);
>> +			return bridge;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&bridge_lock);
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(drm_find_bridge_by_dev);
>> +
>>   #ifdef CONFIG_OF
>>   /**
>>    * of_drm_find_bridge - find the bridge corresponding to the device node in
>> @@ -1361,6 +1399,7 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
>>   	return NULL;
>>   }
>>   EXPORT_SYMBOL(of_drm_find_bridge);
>> +
>>   #endif
>>   
>>   MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>> index 4baca0d9107b..70d8393bbd9c 100644
>> --- a/include/drm/drm_bridge.h
>> +++ b/include/drm/drm_bridge.h
>> @@ -715,6 +715,8 @@ struct drm_bridge {
>>   	struct drm_private_obj base;
>>   	/** @dev: DRM device this bridge belongs to */
>>   	struct drm_device *dev;
>> +	/** @kdev: pointer to the kernel device backing this bridge */
>> +	struct device *kdev;
>>   	/** @encoder: encoder to which this bridge is connected */
>>   	struct drm_encoder *encoder;
>>   	/** @chain_node: used to form a bridge chain */
>> @@ -782,12 +784,15 @@ drm_priv_to_bridge(struct drm_private_obj *priv)
>>   }
>>   
>>   void drm_bridge_add(struct drm_bridge *bridge);
>> +void drm_bridge_add_with_dev(struct drm_bridge *bridge, struct device *dev);
>>   int devm_drm_bridge_add(struct device *dev, struct drm_bridge *bridge);
>>   void drm_bridge_remove(struct drm_bridge *bridge);
>>   int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>>   		      struct drm_bridge *previous,
>>   		      enum drm_bridge_attach_flags flags);
>>   
>> +struct drm_bridge *drm_find_bridge_by_dev(struct device *kdev);
>> +
>>   #ifdef CONFIG_OF
>>   struct drm_bridge *of_drm_find_bridge(struct device_node *np);
>>   #else
> 

-- 
Best regards
Sui

