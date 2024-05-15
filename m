Return-Path: <linux-kernel+bounces-180121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 050778C6A56
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FE91C21A27
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36B215624D;
	Wed, 15 May 2024 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jhkzwcKF"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AD1155A26
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789602; cv=none; b=af4J0UHHOrVYNAL3h120ls9w682oqhzPqhQwqEuwF5ji7fy1udPyvJiILnpdOb+Zy1WmBkGWTsvSdx8mYK72TvyZOhq2f/eS5Ig4pKkktg7sQUTPutRzT1eEQI2CHcaOD/J2zdtxURLvbDa9HAChVB7Hn+gTQIAdhGWWqL4dyJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789602; c=relaxed/simple;
	bh=LPWYGZi2qu4grv+vKX4R0WYcKLAEh5q7hotDBiOim2Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cdI6sDFQttbYVkWaHbT5WPjgYYiAPPngcXpTQV1LJFXNh8tG4mC78HY0pwO3UWkMlkBKGfuIb86v9xHIPrNe4zrf9hihXMrFDKxXFhrwt7tWyUTBiEnrm8IQXHgNY2Q6Ml6iUNkUc+Vt8qZuTsMRPqbswHjfb1hWgyC3OumOvJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jhkzwcKF; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <83f4289d-3e73-49fb-9be4-93961d3e051b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715789594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XazfpVPfcDOApsPFU0sOqvvodW8BpouJZj2Cr99EhUI=;
	b=jhkzwcKFIoDNq5ipKNVZPeC0TfQReLUhzU23hRg63kZIH0HsR2VPpBTKKlBfxJWpOJ03UP
	bv52oBlESxVQk5BYsFFQ1iQAC1F0aIOY558XgXy4HfqonZ0rpRyfhLHThQIj/MOg3P9o06
	lgvuaCZcfnVZjJdC9qlQ2iipWx4hdv0=
Date: Thu, 16 May 2024 00:13:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: drm/bridge: adv7511: Attach next bridge without creating
 connector
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dmitry.baryshkov@linaro.org, biju.das.jz@bp.renesas.com, aford173@gmail.com,
 bli@bang-olufsen.dk, robh@kernel.org, jani.nikula@intel.com
References: <20240513080243.3952292-1-victor.liu@nxp.com>
 <4b6e49ee-d2fd-4e54-88d5-ab06d8ebf644@bosc.ac.cn>
 <20240514151211.GG32013@pendragon.ideasonboard.com>
Content-Language: en-US, en-AU
In-Reply-To: <20240514151211.GG32013@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 5/14/24 23:12, Laurent Pinchart wrote:
> Hello,
> 
> On Tue, May 14, 2024 at 12:26:15AM +0800, Sui Jingfeng wrote:
>> On 5/13/24 16:02, Liu Ying wrote:
>>> The connector is created by either this ADV7511 bridge driver or
>>> any DRM device driver/previous bridge driver, so this ADV7511
>>> bridge driver should not let the next bridge driver create connector.
>>>
>>> If the next bridge is a HDMI connector, the next bridge driver
>>> would fail to attach bridge from display_connector_attach() without
>>> the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
> 
> In theory we could have another HDMI-to-something bridge connected to
> the ADV7511 output, and that bridge could create a connector. However,
> before commit 14b3cdbd0e5b the adv7511 driver didn't try to attach to
> the next bridge, so it's clear that no platform support in mainline had
> such a setup. It should be safe to set DRM_BRIDGE_ATTACH_NO_CONNECTOR
> unconditionally here.


But what if there is a drm bridge prior to adv7511 but after the KMS
engine? Even though we are still safe if it doesn't create connector
by obeying modern rule.


> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
>>>
>>> Add that flag to drm_bridge_attach() function call in
>>> adv7511_bridge_attach() to fix the issue.
>>>
>>> This fixes the issue where the HDMI connector bridge fails to attach
>>> to the previous ADV7535 bridge on i.MX8MP EVK platform:
>>>
>>> [    2.216442] [drm:drm_bridge_attach] *ERROR* failed to attach bridge /hdmi-connector to encoder None-37: -22
>>> [    2.220675] mmc1: SDHCI controller on 30b50000.mmc [30b50000.mmc] using ADMA
>>> [    2.226262] [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@30800000/i2c@30a30000/hdmi@3d to encoder None-37: -22
>>> [    2.245204] [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@32c00000/dsi@32e60000 to encoder None-37: -22
>>> [    2.256445] imx-lcdif 32e80000.display-controller: error -EINVAL: Failed to attach bridge for endpoint0
>>> [    2.265850] imx-lcdif 32e80000.display-controller: error -EINVAL: Cannot connect bridge
>>> [    2.274009] imx-lcdif 32e80000.display-controller: probe with driver imx-lcdif failed with error -22
>>>
>>> Fixes: 14b3cdbd0e5b ("drm/bridge: adv7511: make it honour next bridge in DT")
>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>>> ---
>>>    drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
>>> index dd21b81bd28f..66ccb61e2a66 100644
>>> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
>>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
>>> @@ -953,7 +953,8 @@ static int adv7511_bridge_attach(struct drm_bridge *bridge,
>>>    	int ret = 0;
>>>    
>>>    	if (adv->next_bridge) {
>>> -		ret = drm_bridge_attach(bridge->encoder, adv->next_bridge, bridge, flags);
>>> +		ret = drm_bridge_attach(bridge->encoder, adv->next_bridge, bridge,
>>> +					flags | DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>>
>> As a side note, I think, maybe you could do better in the future.
>>
>> If we know that the KMS display driver side has the HDMI connector
>> already created for us, we should pass DRM_BRIDGE_ATTACH_NO_CONNECTOR
>> from the root KMS driver side. Which is to forbidden all potential
>> drm bridge drivers to create a connector in the middle.
> 
> That's the recommended way for new drivers. Using the
> drm_bridge_connector helper handles all this for you.
> 
>> The KMS display driver side could parse the DT to know if there is
>> a hdmi connector, or merely just hdmi connector device node, or
>> something else.
> 
> No, that would violate the basic principle of not peeking into the DT of
> devices you know nothing about. The display engine driver can't walk the
> pipeline in DT and expect to understand all the DT nodes on the path,
> and what their properties mean.
> 

The (next) bridge at the remote port is not necessary a display bridge.
Or it is a bridge from the perspective of hardware viewpoint, but under
controlled by a more complex foreign driver which generic drm bridge
driver has no authority to attach.

> What KMS drivers should do is to use the drm_bridge_connector helper.
> Calling drm_bridge_connector_init() will create a connector for a chain
> of bridges. The KMS driver should then attach to the first bridge with
> DRM_BRIDGE_ATTACH_NO_CONNECTOR, unconditionally.
>

OK, thanks for teaching us the modern way to use drm_bridge_connector
helper, also thanks Ying for providing the patch.


>> However, other maintainer and/or reviewer's opinion are of cause
>> more valuable. I send a A-b because I thought the bug is urgency
>> and it's probably more important to solve this bug first. And
>> maybe you can Cc: <stable@vger.kernel.org> if you like.
>>
>>>    		if (ret)
>>>    			return ret;
>>>    	}
>

-- 
Best regards
Sui

