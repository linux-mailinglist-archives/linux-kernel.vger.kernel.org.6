Return-Path: <linux-kernel+bounces-188547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CCD8CE346
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538061C21F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBD784FB0;
	Fri, 24 May 2024 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I+g0mjhl"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C31A84E07
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542494; cv=none; b=P5QM0hI7+R8roOVRQ4Fk5X6vJFe57Yymy9ynHc1/EejD2n24SJUrX2AgUz1mjcyTaegZ+gbk62hlJJ6mvOW2owNPeuLbQK/NV6wtNn6bwzOK1mFuyYt+e7TGpAQC6M8rZE9Gi0GHC3gMW0ELli7amhyGIXNzvvCGvFVEhmgeVeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542494; c=relaxed/simple;
	bh=493YyYNAt34zY9+wCw+vzraAA49WoXc6FaYbUn31VLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AM8so2uTYA5YilRrejFZ2xX3md9W+t2Zh65PFpzMZNySMklZZBFzZ6RkhrRqu00aMGfS50DPYwwXVeIQGrn9SsZDbr3RkoyAKJI/smkh0SVwBMJWc5IpAjiN5x3R6drZnZ2NlSTSCfsOqEqRPiDs5oPfhm2pAQmZAqn9+hiEeH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I+g0mjhl; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O9L9Ga035918;
	Fri, 24 May 2024 04:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716542469;
	bh=9VqLXE+M4Ctnqzc9Y53bENjNOA1O/XSeTL4zdOP7UAI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=I+g0mjhlTv4elitGkb1VXIeuQ3/kJDCrThpt7PZl4luKQ5qDv7Qdy407GdUCwvman
	 ZFPnsKgbZLRwTqD5/hJPQQsNmyjbrp+FHCVzItkJbfDXFcTvFBx71K8qja8c1SiIG8
	 EANAxb7A45wy5b61UGPstSKK6FAda13ojjRzVCdA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O9L9EP045284
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 04:21:09 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 04:21:09 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 04:21:09 -0500
Received: from [172.24.227.102] (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.102] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O9L46u039745;
	Fri, 24 May 2024 04:21:05 -0500
Message-ID: <442d1323-b6d3-4a50-aaea-ef32dfc08741@ti.com>
Date: Fri, 24 May 2024 14:51:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/bridge: sii902x: Fix mode_valid hook
To: Sam Ravnborg <sam@ravnborg.org>
CC: <linux-kernel@vger.kernel.org>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <mripard@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <a-bhatia1@ti.com>
References: <20240524073305.107293-1-j-choudhary@ti.com>
 <20240524073305.107293-2-j-choudhary@ti.com>
 <20240524081824.GA615138@ravnborg.org>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20240524081824.GA615138@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Sam,

On 24/05/24 13:48, Sam Ravnborg wrote:
> Hi Jayesh,
> 
> On Fri, May 24, 2024 at 01:03:04PM +0530, Jayesh Choudhary wrote:
>> Currently, mode_valid hook returns all mode as valid and it is
>> defined only in drm_connector_helper_funcs. With the introduction of
>> 'DRM_BRIDGE_ATTACH_NO_CONNECTOR', connector is not initialized in
>> bridge_attach call for cases when the encoder has this flag enabled.
>> So add the mode_valid hook in drm_bridge_funcs as well with proper
>> clock checks for maximum and minimum pixel clock supported by the
>> bridge.
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   drivers/gpu/drm/bridge/sii902x.c | 38 ++++++++++++++++++++++++++++++--
>>   1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
>> index 2fbeda9025bf..ef7c3ab3386c 100644
>> --- a/drivers/gpu/drm/bridge/sii902x.c
>> +++ b/drivers/gpu/drm/bridge/sii902x.c
>> @@ -163,6 +163,14 @@
>>   
>>   #define SII902X_AUDIO_PORT_INDEX		3
>>   
>> +/*
>> + * The maximum resolution supported by the HDMI bridge is 1080p@60Hz
>> + * and 1920x1200 requiring a pixel clock of 165MHz and the minimum
>> + * resolution supported is 480p@60Hz requiring a pixel clock of 25MHz
>> + */
>> +#define SII902X_MIN_PIXEL_CLOCK_KHZ		25000
>> +#define SII902X_MAX_PIXEL_CLOCK_KHZ		165000
>> +
>>   struct sii902x {
>>   	struct i2c_client *i2c;
>>   	struct regmap *regmap;
>> @@ -310,12 +318,26 @@ static int sii902x_get_modes(struct drm_connector *connector)
>>   	return num;
>>   }
>>   
>> +static enum
>> +drm_mode_status sii902x_validate(struct sii902x *sii902x,
>> +				 const struct drm_display_mode *mode)
>> +{
>> +	if (mode->clock < SII902X_MIN_PIXEL_CLOCK_KHZ)
>> +		return MODE_CLOCK_LOW;
>> +
>> +	if (mode->clock > SII902X_MAX_PIXEL_CLOCK_KHZ)
>> +		return MODE_CLOCK_HIGH;
>> +
>> +	return MODE_OK;
>> +}
>> +
>>   static enum drm_mode_status sii902x_mode_valid(struct drm_connector *connector,
>>   					       struct drm_display_mode *mode)
>>   {
>> -	/* TODO: check mode */
>> +	struct sii902x *sii902x = connector_to_sii902x(connector);
>> +	const struct drm_display_mode *mod = mode;
>>   
>> -	return MODE_OK;
>> +	return sii902x_validate(sii902x, mod);
>>   }
>>   
>>   static const struct drm_connector_helper_funcs sii902x_connector_helper_funcs = {
>> @@ -499,11 +521,22 @@ static int sii902x_bridge_atomic_check(struct drm_bridge *bridge,
>>   	 * There might be flags negotiation supported in future but
>>   	 * set the bus flags in atomic_check statically for now.
>>   	 */
>> +
>>   	bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;
> 
> If you spin a v2 then drop the above change as you delete the line again
> in the next patch.
> 
> 	Sam

While splitting the patches, I must have messed up.
I will quickly send v3 with this fixed.

Thanks,
Jayesh

