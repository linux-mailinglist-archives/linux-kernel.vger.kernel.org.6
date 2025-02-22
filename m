Return-Path: <linux-kernel+bounces-527221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6047A40899
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24B607ACA76
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F36E207DE5;
	Sat, 22 Feb 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gTKOoqjo"
Received: from mail-m3278.qiye.163.com (mail-m3278.qiye.163.com [220.197.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348CC1B2182;
	Sat, 22 Feb 2025 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740229989; cv=none; b=V0ZEhMdoFOR24OcrAEBUq8PYBQeucXon7mVjQgIXGuVPcbbwIpdNoPcW/plztGBKyiQXFVyJrH5hSXi1FAcG06nFcZcHnUKliDnYMg8b55ZGjL3hwY5i0hIf4EgtZVHGAdfchKMOjHzBOZdRdagBeBl64g0LHOASE8zMLLYFdCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740229989; c=relaxed/simple;
	bh=Rx/6+HUXxBmrnqVvIGBM2Tk5eSZ0r/3y2PGuz6akjn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iw9j5wV4n2Rx1WQ9dyTi83HneUbU6t9X4zVLsUmcLfgrG4fhqnj2UGxKyT/ucWHRH75ApQje4mmzD918u+XUZqEynszqa9mu4BCIRxn1Z6h5tJODZz03iU1Xr37/GLqDQm1LB/580PHURAgpt/0XBpVRX7SrLzhTTJuZ+JrEbtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gTKOoqjo; arc=none smtp.client-ip=220.197.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id bdb96d2d;
	Sat, 22 Feb 2025 19:57:15 +0800 (GMT+08:00)
Message-ID: <eb46b2d8-a170-4813-963d-8509089f72fa@rock-chips.com>
Date: Sat, 22 Feb 2025 19:57:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/14] drm/rockchip: analogix_dp: Add support to get
 panel from the DP AUX bus
To: Lucas Stach <l.stach@pengutronix.de>, heiko@sntech.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 rfoss@kernel.org, vkoul@kernel.org, sebastian.reichel@collabora.com,
 cristian.ciocaltea@collabora.com, dmitry.baryshkov@linaro.org,
 andy.yan@rock-chips.com, hjc@rock-chips.com, algea.cao@rock-chips.com,
 kever.yang@rock-chips.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <20250123100747.1841357-1-damon.ding@rock-chips.com>
 <20250123100747.1841357-9-damon.ding@rock-chips.com>
 <cfc5b39e21fb214c53fda3276847b8e235af818f.camel@pengutronix.de>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <cfc5b39e21fb214c53fda3276847b8e235af818f.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0odQ1ZCQ09CGEhCQ0tMTklWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a952d84d7db03a3kunmbdb96d2d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Njo6HDo6IzISGR8CThJLNRoh
	GU8aCwhVSlVKTE9LSUlOT0hMSUlKVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSk5JNwY+
DKIM-Signature:a=rsa-sha256;
	b=gTKOoqjoAKeFhXf1a8vmXg379vWYpEnKYnWD8KI0jK15KYdeKWwgwvp3kY0GK0x79LyCoTpcw+VSZq059SK53WSlCuP5TJKbYlTRYmQRY19EDQdLxuTeMVNBb+bqPTib5svQpS9eeXAMEptvdCAFFK74gn2utyUTVoD/0KO+uqw=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=wGmhqrAjYzagqI94aWqLld2LAsNs8E1/VGtS52n0S4U=;
	h=date:mime-version:subject:message-id:from;

Hi Lucas,

On 2025/2/8 3:42, Lucas Stach wrote:
> Hi Damon,
> 
> Am Donnerstag, dem 23.01.2025 um 18:07 +0800 schrieb Damon Ding:
>> Move drm_of_find_panel_or_bridge() a little later and combine it with
>> component_add() into a new function rockchip_dp_link_panel(). The function
>> will serve as done_probing() callback of devm_of_dp_aux_populate_bus(),
>> aiding to support for obtaining the eDP panel via the DP AUX bus.
>>
>> If failed to get the panel from the DP AUX bus, it will then try the other
>> way to get panel information through the platform bus.
>>
> The changes in this patch effectively revert 86caee745e45
> ("drm/rockchip: analogix_dp: allow to work without panel"). Please
> correct this in the next revision of this patchset.
> 
> Regards,
> Lucas
> 

Oh, I see. I will fix it in the next version.

>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>>
>> ---
>>
>> Changes in v4:
>> - Use done_probing() to call drm_of_find_panel_or_bridge() and
>>    component_add() when getting panel from the DP AUX bus
>>
>> Changes in v5:
>> - Use the functions exported by the Analogix side to get the pointers of
>>    struct analogix_dp_plat_data and struct drm_dp_aux.
>> - Use dev_err() instead of drm_err() in rockchip_dp_poweron().
>>
>> Changes in v6:
>> - Keep drm_err() in rockchip_dp_poweron()
>> - Pass 'dp' in drm_...() rather than 'dp->drm_dev'
>> ---
>>   .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 37 ++++++++++++++-----
>>   1 file changed, 28 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>> index 13f32aeea7ca..004b1b68d1cf 100644
>> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>> @@ -393,11 +393,27 @@ static const struct component_ops rockchip_dp_component_ops = {
>>   	.unbind = rockchip_dp_unbind,
>>   };
>>   
>> +static int rockchip_dp_link_panel(struct drm_dp_aux *aux)
>> +{
>> +	struct analogix_dp_plat_data *plat_data = analogix_dp_aux_to_plat_data(aux);
>> +	struct rockchip_dp_device *dp = pdata_encoder_to_dp(plat_data);
>> +	int ret;
>> +
>> +	ret = drm_of_find_panel_or_bridge(dp->dev->of_node, 1, 0, &plat_data->panel, NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = component_add(dp->dev, &rockchip_dp_component_ops);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return ret;
>> +}
>> +
>>   static int rockchip_dp_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>>   	const struct rockchip_dp_chip_data *dp_data;
>> -	struct drm_panel *panel = NULL;
>>   	struct rockchip_dp_device *dp;
>>   	struct resource *res;
>>   	int i;
>> @@ -407,10 +423,6 @@ static int rockchip_dp_probe(struct platform_device *pdev)
>>   	if (!dp_data)
>>   		return -ENODEV;
>>   
>> -	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &panel, NULL);
>> -	if (ret < 0 && ret != -ENODEV)
>> -		return ret;
>> -
>>   	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
>>   	if (!dp)
>>   		return -ENOMEM;
>> @@ -434,7 +446,6 @@ static int rockchip_dp_probe(struct platform_device *pdev)
>>   
>>   	dp->dev = dev;
>>   	dp->adp = ERR_PTR(-ENODEV);
>> -	dp->plat_data.panel = panel;
>>   	dp->plat_data.dev_type = dp->data->chip_type;
>>   	dp->plat_data.power_on = rockchip_dp_poweron;
>>   	dp->plat_data.power_off = rockchip_dp_powerdown;
>> @@ -450,9 +461,17 @@ static int rockchip_dp_probe(struct platform_device *pdev)
>>   	if (IS_ERR(dp->adp))
>>   		return PTR_ERR(dp->adp);
>>   
>> -	ret = component_add(dev, &rockchip_dp_component_ops);
>> -	if (ret)
>> -		return ret;
>> +	ret = devm_of_dp_aux_populate_bus(analogix_dp_get_aux(dp->adp), rockchip_dp_link_panel);
>> +	if (ret) {
>> +		if (ret != -ENODEV) {
>> +			drm_err(dp, "failed to populate aux bus : %d\n", ret);
>> +			return ret;
>> +		}
>> +
>> +		ret = rockchip_dp_link_panel(analogix_dp_get_aux(dp->adp));
>> +		if (ret)
>> +			return ret;
>> +	}
>>   
>>   	return 0;
>>   }
> 
> 
> 

Best regards
Damon


