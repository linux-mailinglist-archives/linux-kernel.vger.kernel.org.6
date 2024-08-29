Return-Path: <linux-kernel+bounces-306003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 562D99637E0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7B81F220F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C831CA85;
	Thu, 29 Aug 2024 01:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lySeu7zN"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63678D51E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895437; cv=none; b=LpLsl68GSILMhzWH4Irm8gtqOLzT+66TagjBj8BztRVWwG2L3H0+NP0/zXUVqnpmT6Jc7fZgvypOuyiIBRxyNjFlCdBUdLDkk6Q3FIp4g5c/03OmSHHY02ls7eIATAuFePxKBxd8NxUBbM/QLHPHgefhyegTF6/ZIHPZqTVq5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895437; c=relaxed/simple;
	bh=NC5tIf8E2ZvgAno6JaP5ymxmMRDw0/7w9Cax9B7Kf20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHLPl7OHiJaNq+zltfWkwYVdTG0Nci8C42N9TVTQZ0Pz4VgD7rvL5XaM6utalla4XuBw2WSTvnyg5ZjXcfoHWoQO+tvE5O09D6r8uBpaVLiPZPE2PN9t2GYv/i2JOzKea0CRlHDIT6IBMfDzjO30APQGG1XlwGPpmzLdtc0HoZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lySeu7zN; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <17b227d7-431a-4970-aec5-a0bd986d662a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724895433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4srPWsO1pqoLHjBlzDmYgUcHbWP4pNO3PD4mEKxhxf4=;
	b=lySeu7zNSbE1XvS/GiBc92SSltD+sdmmcKAGU3YdCDeJocNwuUNXhMg/oVFl9jAM35/raq
	QWbkJ/bFtA3YoRL02YOLr5Xaw8hosiXeDxhyQGW/b/Hcm9tQlXYWYXctoPPXR7kway+hDG
	H5pFh3jlT1PhcaZ6o2vXqHByGD0PLhc=
Date: Thu, 29 Aug 2024 09:37:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] of/platform: Use dev_is_platform() to identify PCI
 devices
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: saravanak@google.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
References: <20240827094403.166238-1-kunwu.chan@linux.dev>
 <20240828150826.GA3803566-robh@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <20240828150826.GA3803566-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Thanks for the reply.
On 2024/8/28 23:08, Rob Herring wrote:
> On Tue, Aug 27, 2024 at 05:44:02PM +0800, Kunwu Chan wrote:
>> From: Kunwu Chan <chentao@kylinos.cn>
> Subject - For PCI devices?
My bad, i'll change it in v2.
>> Use dev_is_platform() instead of checking bus type directly.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   drivers/of/platform.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> index 86be4dfb9323..3696140bae9e 100644
>> --- a/drivers/of/platform.c
>> +++ b/drivers/of/platform.c
>> @@ -625,7 +625,7 @@ int of_platform_device_destroy(struct device *dev, void *data)
>>   	of_node_clear_flag(dev->of_node, OF_POPULATED);
>>   	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
>>   
>> -	if (dev->bus == &platform_bus_type)
>> +	if (dev_is_platform(dev))
>>   		platform_device_unregister(to_platform_device(dev));
>>   #ifdef CONFIG_ARM_AMBA
>>   	else if (dev->bus == &amba_bustype)
> Perhaps to keep things consistent, add a dev_is_amba() and use it here.
>
Sure, i'am doing this in [1], i'll send the v2 patch after change it in 
AMBA.

[1] https://lore.kernel.org/all/ZsiTPjtnZZIW-K4k@smile.fi.intel.com/

>> -- 
>> 2.41.0
>>
-- 
Thanks,
   Kunwu.Chan


