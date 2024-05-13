Return-Path: <linux-kernel+bounces-177782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DAE8C4492
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79942B22FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1121F15443F;
	Mon, 13 May 2024 15:50:39 +0000 (UTC)
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC23148853
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615438; cv=none; b=PRVWBHR3piBq2bNrwbYUqmRjzbyygriEWpe6M5CNolVMmMUqX9HKxOxnisHXx2KzsiDD/TfcwhSBwEApKPXao7LmeEf7sNefRNT5h9jWcjhc6zFigGDUIZ+Q2cJgp1zH76fHwZkv1qR3fp2h/xjfJfLplon5o3aCRQwmDT/rxic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615438; c=relaxed/simple;
	bh=bBVoPLGr8a0x1yaryn/1qdny0qg7RjQQcfczbivQHqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+WRQitlcLelzL+khLTbElTrCItflr6U2elaCrh09JdTDycgyqBKSWsz1HL1YcLBkiXe+Razfr1UyI5Obqr9d3I19rP8W3GvDf/Lv1wAA3j1Tq9RUUPxnnKyaLLjZMh1Sw/X8y7HtpVM+68glvV1reaUVDhcmXhZBRp1zUn3mZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from [172.38.8.164] (unknown [219.141.235.82])
	by mail (Coremail) with SMTP id AQAAfwAHudmGNkJmiep3AA--.42400S3;
	Mon, 13 May 2024 23:49:28 +0800 (CST)
Message-ID: <ae8b7a4c-0d08-429d-9be7-e39260462e4e@bosc.ac.cn>
Date: Mon, 13 May 2024 23:49:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/bridge: adv7511: Attach next bridge without creating
 connector
To: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dmitry.baryshkov@linaro.org, biju.das.jz@bp.renesas.com, aford173@gmail.com,
 bli@bang-olufsen.dk, robh@kernel.org, jani.nikula@intel.com
References: <20240513080243.3952292-1-victor.liu@nxp.com>
Content-Language: en-US, en-AU
From: Sui Jingfeng <suijingfeng@bosc.ac.cn>
Organization: bosc
In-Reply-To: <20240513080243.3952292-1-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAfwAHudmGNkJmiep3AA--.42400S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr15WrW5uF13XF13tw1DKFg_yoW5JF1kpF
	W2qa90yryrXF13KayDAr1UGas8Z39rJFWrAFZF93yFva4IgF1DZrWDCw1rAry7JFyUXa1Y
	yF4UJFy0gF1UCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c2xSY4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU8uMKtUUUUU==
X-CM-SenderInfo: xvxlyxpqjiv03j6e02nfoduhdfq/

Hi,


On 5/13/24 16:02, Liu Ying wrote:
> The connector is created by either this ADV7511 bridge driver or
> any DRM device driver/previous bridge driver, so this ADV7511
> bridge driver should not let the next bridge driver create connector.
> 
> If the next bridge is a HDMI connector, the next bridge driver
> would fail to attach bridge from display_connector_attach() without
> the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
> 
> Add that flag to drm_bridge_attach() function call in
> adv7511_bridge_attach() to fix the issue.
> 
> This fixes the issue where the HDMI connector bridge fails to attach
> to the previous ADV7535 bridge on i.MX8MP EVK platform:
> 
> [    2.216442] [drm:drm_bridge_attach] *ERROR* failed to attach bridge /hdmi-connector to encoder None-37: -22
> [    2.220675] mmc1: SDHCI controller on 30b50000.mmc [30b50000.mmc] using ADMA
> [    2.226262] [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@30800000/i2c@30a30000/hdmi@3d to encoder None-37: -22
> [    2.245204] [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@32c00000/dsi@32e60000 to encoder None-37: -22
> [    2.256445] imx-lcdif 32e80000.display-controller: error -EINVAL: Failed to attach bridge for endpoint0
> [    2.265850] imx-lcdif 32e80000.display-controller: error -EINVAL: Cannot connect bridge
> [    2.274009] imx-lcdif 32e80000.display-controller: probe with driver imx-lcdif failed with error -22
> 

Indeed, looks safer finally.

> Fixes: 14b3cdbd0e5b ("drm/bridge: adv7511: make it honour next bridge in DT")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>


Acked-by: Sui Jingfeng <suijingfeng@bosc.ac.cn>


> ---
>   drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index dd21b81bd28f..66ccb61e2a66 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -953,7 +953,8 @@ static int adv7511_bridge_attach(struct drm_bridge *bridge,
>   	int ret = 0;
>   
>   	if (adv->next_bridge) {
> -		ret = drm_bridge_attach(bridge->encoder, adv->next_bridge, bridge, flags);
> +		ret = drm_bridge_attach(bridge->encoder, adv->next_bridge, bridge,
> +					flags | DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>   		if (ret)
>   			return ret;
>   	}

-- 
Best regards
Sui Jingfeng


