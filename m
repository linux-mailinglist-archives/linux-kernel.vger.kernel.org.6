Return-Path: <linux-kernel+bounces-234888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E6791CC12
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 12:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304581C21287
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 10:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2343FBB3;
	Sat, 29 Jun 2024 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7WbSjO3"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F2D23767;
	Sat, 29 Jun 2024 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719656300; cv=none; b=mzKiAEK73+8HAKoirzR1Aqd4tsaa7OHUQIJtAkFER67wCoPnOUWlKUmIqbf+S47+VTHw88jctFGg7C2YXsbp9v5Ty/SxlwRASPlfAYsrHSikEMEnVRBR+9n2lWFaj1Lr6UXiK4x+Gy5dbC23Qzo/O7ipw1idIV1emjiykcMy+fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719656300; c=relaxed/simple;
	bh=zNUije4Rf1fu7rha7favpYddd5zkpBg5u37yMsb+L/c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PRNo9sI0+Jo5kz0fWg7PHSr9/AshDoahEmnvoBYRRj5P2V1p2devw+yJlLBEU4rcqEptq++O4xjbCkEdk9yaYylywOFQy4Z9Bl5mbL7O5JRJYRqDQc4WKurFFGqgYOujVDnSP+kiwEeXOHuvDnV3voK4wYZAO2KdRQYoUUYqYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7WbSjO3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7245453319so229573966b.1;
        Sat, 29 Jun 2024 03:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719656297; x=1720261097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QlwoXKISijQ0DRcF+GZnJmixbJReAkQz34nOTF0Vuxk=;
        b=e7WbSjO3ZuAjbv1KvmjiFwQg7vpKYbXBDGygUBzcXTp77mAfrCeXmUssaajhpTB/HH
         X1aCLlQ5ZXAOIx2fSKozBEcNPncMnP8UR1MDtW0BbXzZaRq2jfqsWLIqYXwirpambVOR
         0fZ20ueny0hnl5dL8Tu3tqq7PWMePKKstEo9zzLNPzBXwYz8Odjqee0PbShyZf5//YsJ
         NCfan5zCW4tmGjyjDIx9mqeDlNQGE7nt5GdBVOw9oaRBeipNXEiu5DzxQrsXyKEvC93E
         u7l06f06q1YDLvoocUeECO0UiJnxAtZ8UaOoYm5GYYMASwEOpe+LAIkmGyL4sEpFfXfN
         IGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719656297; x=1720261097;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlwoXKISijQ0DRcF+GZnJmixbJReAkQz34nOTF0Vuxk=;
        b=nJ2EWJK49ZjyxbaRVW27LgomVPG9guy19xg6c2UIqYslWGx1Bj9AvWVumAjiRn3NTj
         gnUHTw340Ro47USfXwwnzMLxnsRJulqeK18bvARhgV/xbd9X4W7JebZe7j1UdqFzcnv+
         IcMAU4r5cLgXe5EWH9yDtl0VtwwsjZ6EjYnafFwl700nR44Jz0M00Hwa0lBcmvDcH8Qe
         uVgqbrLc78N5o444Ux/+eVbNvCWV2/BiFzFQDXli58jkPSB8hKRP8MwsG9Tdh3N80aAL
         3iDktU55YIKQgJslZYsd6eDQuBoJrSf/rJru6FC3v0wEwY4W2aIU3OnhV3doEgu9c845
         DJyw==
X-Forwarded-Encrypted: i=1; AJvYcCXN2Y8Belu8EMBNrIgtK5tof7eqWmnz0qRzepbLylZLUQ3UVaX+1XSGcnpAiIX1QNbtvFysXLTYWvBSVzqf8YPaCPpC0B8IPkyVmFp8xCu/IUuyO9iwOE0dHtvMr/hOlX/K9EdmpS5gj7g=
X-Gm-Message-State: AOJu0YwI4BiSdJB9wWaJyY+Sj/8rFbpggaHLhAte9LPKnwWyUdMkAy41
	Z9WnMyT3n9FTaMYlsljGzdw3TYLaDInqfLtGgqfH/7Ppe++9+Sv0
X-Google-Smtp-Source: AGHT+IF/MBEiMijU8GjgEXLJuB9PxQWKYMlbEYZlv/UgCvP3oFNMsmcWz1PuXDww6RQR6rVaR2ksVQ==
X-Received: by 2002:a17:907:2d86:b0:a72:5760:1424 with SMTP id a640c23a62f3a-a7513773b0dmr91562566b.0.1719656296728;
        Sat, 29 Jun 2024 03:18:16 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? (2a02-a449-4071-1-32d0-42ff-fe10-6983.fixed6.kpn.net. [2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06565csm151609666b.103.2024.06.29.03.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 03:18:16 -0700 (PDT)
Message-ID: <a3a1ed17-17f7-480a-8faf-b493918956f0@gmail.com>
Date: Sat, 29 Jun 2024 12:18:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v7] drm/rockchip: rk3066_hdmi: add sound support
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, lgirdwood@gmail.com, broonie@kernel.org,
 linux-sound@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <5c651b3f-fe30-4874-98ed-044f7c62dd97@gmail.com>
 <7c53f7d.bb08.1905ef690ef.Coremail.andyshrk@163.com>
Content-Language: en-US
In-Reply-To: <7c53f7d.bb08.1905ef690ef.Coremail.andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy, thanks.

On 6/28/24 15:08, Andy Yan wrote:
> 
> Hi Johan,
> 
> At 2024-06-28 17:23:39, "Johan Jonker" <jbx6244@gmail.com> wrote:
>> Add sound support to the RK3066 HDMI driver.
>> The HDMI TX audio source is connected to I2S_8CH.
>>
>> Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>
>> Changed V7:
>>  rebase
>> ---
>> drivers/gpu/drm/rockchip/Kconfig       |   2 +
>> drivers/gpu/drm/rockchip/rk3066_hdmi.c | 274 ++++++++++++++++++++++++-
>> 2 files changed, 275 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
>> index 1bf3e2829cd0..a32ee558408c 100644
>> --- a/drivers/gpu/drm/rockchip/Kconfig
>> +++ b/drivers/gpu/drm/rockchip/Kconfig
>> @@ -102,6 +102,8 @@ config ROCKCHIP_RGB
>> config ROCKCHIP_RK3066_HDMI
>> 	bool "Rockchip specific extensions for RK3066 HDMI"
>> 	depends on DRM_ROCKCHIP
>> +	select SND_SOC_HDMI_CODEC if SND_SOC
>> +	select SND_SOC_ROCKCHIP_I2S if SND_SOC
>> 	help
>> 	  This selects support for Rockchip SoC specific extensions
>> 	  for the RK3066 HDMI driver. If you want to enable
>> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
>> index 784de990da1b..d3128b787629 100644
>> --- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
>> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
>> @@ -15,12 +15,20 @@
>> #include <linux/platform_device.h>
>> #include <linux/regmap.h>
>>
>> +#include <sound/hdmi-codec.h>
>> +
>> #include "rk3066_hdmi.h"
>>
>> #include "rockchip_drm_drv.h"
>>
>> #define DEFAULT_PLLA_RATE 30000000
>>
>> +struct audio_info {
>> +	int channels;
>> +	int sample_rate;
>> +	int sample_width;
>> +};
>> +
>> struct hdmi_data_info {
>> 	int vic; /* The CEA Video ID (VIC) of the current drm display mode. */
>> 	unsigned int enc_out_format;
>> @@ -54,9 +62,16 @@ struct rk3066_hdmi {
>>
>> 	unsigned int tmdsclk;
>>
>> +	struct platform_device *audio_pdev;
>> +	stru
> 
> ......
> 
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct hdmi_codec_ops audio_codec_ops = {
>> +	.hw_params = rk3066_hdmi_audio_hw_params,
>> +	.audio_shutdown = rk3066_hdmi_audio_shutdown,
>> +	.mute_stream = rk3066_hdmi_audio_mute_stream,
>> +	.get_eld = rk3066_hdmi_audio_get_eld,
>> +	.no_capture_mute = 1,
>> +};
>> +
>> +static int rk3066_hdmi_audio_codec_init(struct rk3066_hdmi *hdmi,
>> +					struct device *dev)
>> +{
>> +	struct hdmi_codec_pdata codec_data = {
>> +		.i2s = 1,
>> +		.ops = &audio_codec_ops,
>> +		.max_i2s_channels = 8,
>> +	};
>> +
>> +	hdmi->audio.channels = 2;
>> +	hdmi->audio.sample_rate = 48000;
>> +	hdmi->audio.sample_width = 16;
>> +	hdmi->audio_enable = false;
>> +	hdmi->audio_pdev =
>> +		platform_device_register_data(dev,
>> +					      HDMI_CODEC_DRV_NAME,
>> +					      PLATFORM_DEVID_NONE,
>> +					      &codec_data,
>> +					      sizeof(codec_data));
>> +
>> +	return PTR_ERR_OR_ZERO(hdmi->audio_pdev);
>> +}
>> +
>> static int
>> rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
>> {
>> @@ -566,6 +834,8 @@ rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
>>
>> 	drm_connector_attach_encoder(&hdmi->connector, encoder);
>>
>> +	rk3066_hdmi_audio_codec_init(hdmi, dev);
> 
> 
> According to Documentation/driver-api/driver-model/driver.rst,
> 

> It is best not to register at the bind callback：

Question for the DRM experts:
What would be the correct location/level for the rk3066_hdmi_audio_codec_init() function?
Is that at the rk3066_hdmi_encoder_enable() function?
Are there other functions/examples for sound in the DRM toolbox?

Johan
> 
> .. warning::
>       -EPROBE_DEFER must not be returned if probe() has already created
>       child devices, even if those child devices are removed again
>       in a cleanup path. If -EPROBE_DEFER is returned after a child
>       device has been registered, it may result in an infinite loop of
>       .probe() calls to the same driver.
> 
> For example：
> vop_probe --》component_add--》rk3066_hdmi_bind--》rk3066_hdmi_audio_codec_init--》hdmi_codec_probe--》rockchip_rgb_init（DEFER when panel not ready）
> 
> This  may result in an infinite loop of probe
> 
> 
>> +
>> 	return 0;
>> }
>>
>> @@ -813,6 +1083,7 @@ static int rk3066_hdmi_bind(struct device *dev, struct device *master,
>> 	return 0;
>>
>> err_cleanup_hdmi:
>> +	platform_device_unregister(hdmi->audio_pdev);
>> 	hdmi->connector.funcs->destroy(&hdmi->connector);
>> 	hdmi->encoder.encoder.funcs->destroy(&hdmi->encoder.encoder);
>> err_disable_i2c:
>> @@ -828,6 +1099,7 @@ static void rk3066_hdmi_unbind(struct device *dev, struct device *master,
>> {
>> 	struct rk3066_hdmi *hdmi = dev_get_drvdata(dev);
>>
>> +	platform_device_unregister(hdmi->audio_pdev);
>> 	hdmi->connector.funcs->destroy(&hdmi->connector);
>> 	hdmi->encoder.encoder.funcs->destroy(&hdmi->encoder.encoder);
>>
>> --
>> 2.39.2
>>

