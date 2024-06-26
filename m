Return-Path: <linux-kernel+bounces-231222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 241089187D6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28DD1F241BE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A102518FC84;
	Wed, 26 Jun 2024 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="avhbWxDV"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF9518F2EE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420401; cv=none; b=pGkfQrWhvNRh1rFzFbSR7xZpMQusPHPoete3CWfOKehPB+jJM20zqVbI0tiIJZFGm7ROxcGBJqcW+V6QFaWc4z4CVgf9FSBeAglg4E7osdtlRAhDXmMvc7EiCgSnQF6D+jZ2bjUFoj/Fdpr9Ac8dilU5UljbCpu/XJMEMhYGXHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420401; c=relaxed/simple;
	bh=kgpJTKip2wpEAhmcAYkNSJdmjj5LgiWzo8XTk2jsiHg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hMALpn3wzZc64kmlvaJOGMkSjiSvj27ycSaUq08mf5awQkbYWv5ujiPDZTeXJocNtDw/ig96Vn4venhkqRuYnOeuVEOFBVaYX09rVmbi2PHbW15rn80LRRoA3QWUd8Soa6fMV2vpSILn9LG+koGaetEnLQRwXFvjXL3zOW5keKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=avhbWxDV; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36703b0f914so601879f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719420398; x=1720025198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NyIf4mhOtD0ihzTCPAbib9y8RhFKPDpSF2/QLgvzCs=;
        b=avhbWxDVy3acKlg5C0XYFIORwUWLvOjqgYHYrYsXxTln/cWm6MP9IKm20jL5DN2O3y
         TVTatyFpUydwAUA5UqK1gnJWWKA8xKJoHUCfiwP14QkRYawdM6pDl2ds245xvgkibsa9
         VWxjgfuaPIh2ePv0+qm/pIUMdJ09DdAoQb0x4MzeGnOyFICZBjp5zTYHUIQU1uJoTP9Q
         j5kfmMPtk+Who0LVKVh0v6CscbK1VT51z72DGPcDTDise9bgys/JMaSeLI84qDyqFCUR
         jlPXQ5ZrpW4X078nJ9ckIyMhkNG2wr5fU9HELt0J4+u6NzD6CfL+7vkDfOZ3RXumEPEN
         QXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719420398; x=1720025198;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/NyIf4mhOtD0ihzTCPAbib9y8RhFKPDpSF2/QLgvzCs=;
        b=LNo5seSr8sEoSVWdarv4ha/TAgFz0dxCAriqnvdk+KpcEn+zViVTduCtw5c4q7VtML
         SFEpw1cXmCafkS4XNz/aRuNhv/7Ai4xkx2Br1jtb9bOaGjNswIuMS/nyNDwOeao5jGJo
         Ob29IbQ0jugqSVeX0Kk3HmAM12HDpipJyewikFV+kBEopfn6Kbwe73APBS0W3FgrTZEs
         J9TGQRXIczghZnuyKw1zaXUqyeI5WVUo+Qql7S76g5QAbD/wdKaqFAahCt+II4caBG16
         X+MdalYwJPgVICDvJpSpNGpQvzy6zstFMbGFHVlJ/Loub5ipdH5tqXZOGSX+Dtn25h6n
         TMhA==
X-Forwarded-Encrypted: i=1; AJvYcCUMuhO+lMd3qhzjDOer86GC9HFWkKwOCZZZNfts7r9+beh9oeYZzdTvW3wOpukqnxIsSF1zNwOY/PNyeJQji0SbNmAu2IotaAWixK72
X-Gm-Message-State: AOJu0YzmHkXUf+Gj9x7SpAtuM46XU9M260kZnvmfiGcD2oqx+hHUtHZH
	AIIu5PIgTyApcoHON21xA0Uvb5lo9PhLZyQm1qRVR2vCpUU+Gjta7XvjQNHuNTY=
X-Google-Smtp-Source: AGHT+IEh3tYhenlXtPWnbe5L29q8hoinsLFd1OsHxhNPLpJhls/HfvQ8+Cd8CnIRbFZnWiiKrTrzDA==
X-Received: by 2002:adf:f74e:0:b0:366:ed80:d054 with SMTP id ffacd0b85a97d-3673cc52f9fmr159939f8f.10.1719420397890;
        Wed, 26 Jun 2024 09:46:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:afc0:84d8:433a:2d67? ([2a01:e0a:982:cbb0:afc0:84d8:433a:2d67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366f7406f4dsm8140739f8f.114.2024.06.26.09.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 09:46:37 -0700 (PDT)
Message-ID: <a6a5ced9-c0dc-4f1d-9eb4-ce14e3db3178@linaro.org>
Date: Wed, 26 Jun 2024 18:46:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] drm/panel: simple: Add Jiangsu Smartwin
 SMMT043480272A-A19 panel
To: Marco Felsch <m.felsch@pengutronix.de>, quic_jesszhan@quicinc.com,
 sam@ravnborg.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc: kernel@pengutronix.de, Rouven Czerwinski <r.czerwinski@pengutronix.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240626161714.4057983-1-m.felsch@pengutronix.de>
 <20240626161714.4057983-2-m.felsch@pengutronix.de>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240626161714.4057983-2-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/06/2024 18:17, Marco Felsch wrote:
> From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> 
> Add support for the Jiangsu Smartwin SMMT043480272A-A19 4.3" 480x272
> TFT-LCD panel. The timings are based on the ILI6485 controller IC
> datasheet.
> 
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 32 ++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index dcb6d0b6ced0..a06ad2cd76f0 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2719,6 +2719,35 @@ static const struct panel_desc innolux_zj070na_01p = {
>   	},
>   };
>   
> +static const struct display_timing jiangsu_smartwin_smmt043480272a_a19_timing = {
> +	.pixelclock = { 8000000, 9000000, 12000000 },
> +	.hactive = { 480, 480, 480 },
> +	.hback_porch = { 1, 43, 43 },
> +	.hfront_porch = { 4, 8, 75 },
> +	.hsync_len = { 2, 4, 75 },
> +	.vactive = { 272, 272, 272 },
> +	.vback_porch = { 2, 12, 12 },
> +	.vfront_porch = { 2, 8, 37 },
> +	.vsync_len = { 2, 4, 37 },
> +	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
> +		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE |
> +		 DISPLAY_FLAGS_SYNC_POSEDGE,
> +};
> +
> +static const struct panel_desc jiangsu_smartwin_smmt043480272a_a19 = {
> +	.timings = &jiangsu_smartwin_smmt043480272a_a19_timing,
> +	.num_timings = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 95,
> +		.height = 54,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH |
> +		     DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
> +		     DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE,
> +};
> +
>   static const struct display_timing koe_tx14d24vm1bpa_timing = {
>   	.pixelclock = { 5580000, 5850000, 6200000 },
>   	.hactive = { 320, 320, 320 },
> @@ -4626,6 +4655,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "innolux,zj070na-01p",
>   		.data = &innolux_zj070na_01p,
> +	}, {
> +		.compatible = "jianda,smmt043480272a-a19",
> +		.data = &jiangsu_smartwin_smmt043480272a_a19,
>   	}, {
>   		.compatible = "koe,tx14d24vm1bpa",
>   		.data = &koe_tx14d24vm1bpa,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

