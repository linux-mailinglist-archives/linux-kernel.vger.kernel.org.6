Return-Path: <linux-kernel+bounces-574835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ACFA6EA95
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBC83AB7A2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8B9204587;
	Tue, 25 Mar 2025 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4SGQ8OM"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1833F1A2C06
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888104; cv=none; b=YmsqqJvH+XAz641vMgVOX7KvEDriAzHo9Bv2mGrNRg35f7rECfVjDxis5lTVnKaRy3WkW41hVe6KNGqGV0AYZFrUkVK8TgahzhNNCTpzKjXQ0KGpbqnXWsTz90dOsehHbG7QGAE8g1y8aq43eQX2xcHBnSVCZcK23PwPVFX41Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888104; c=relaxed/simple;
	bh=TfrStGSa6hcc3UJ5AJZk4VEeYG+PDhwa9pXUw5YF9CE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fs56kCXCgMiz0xy5nSUK4ADNMrk3i4MLVxG9DUD+osEcky3zAp4hZxP4gmP1Z/DqMJKJruJ0XAh/SmaIFGLsERzfC60u7uGRqq4NJXwlhdHiQ1P4vtBMhSMrvKQOOKlnEY+D9tXriHIYfdqlsZrZsQodmLidGNueRHlJHfWxZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y4SGQ8OM; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-399676b7c41so2768543f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742888101; x=1743492901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsBuAVY5kbLtGjR0cZnVpfbHFHF4MARurAEfy4F4g/0=;
        b=Y4SGQ8OMBeDxODFnGGcTZhIcXCycLzOsSQytKNbACqdp3ctTANJvSZOiH+AoFOJB2h
         fW4sBrN7DgFdfcQ5kXdcL4+1lSI5PW4EYk87UXJj4rEO8ImF9w6d5SioMo1F0zAXGp67
         pENJ3U/XE6Yt+uTD4TKNfo7U0dz2qn3tWyFzNFLzVGXwq1QYTxD1vb9QIf6DvuznDtsw
         i555Cqz9z1VF7C5NbiWYeRBhQfTxXjXz7Zzh07sJ/HmUVptjtEyS0Lx5i0rKsc6HtK/P
         ln5c2x0vpYw808+zikEOcRmytt2IZm9EGsRrHKls+8iwou1YuDryy4ol1nhL25l9lvp2
         eL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742888101; x=1743492901;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nsBuAVY5kbLtGjR0cZnVpfbHFHF4MARurAEfy4F4g/0=;
        b=t/9r2t5QnrSg07pzbHDFjEu9b0a+jtdz6QOWp62T2CaKKDRL5S3W+4zlGm36hBvs0w
         LWdCD3kSbqgdbloFV8vwngp/g7MkKxFQ5VQkCwhxh0XT0yBncZxrIM1JFxrgQe/6oSdT
         GAxNyP+75WXe/lMQJsuk596wxQnV7DERqxem7jfNa6WrLYyFpb9a7f21ByXqbxe+x+6m
         jYRe+dYUreTvU53jH+asetfLCNUez/F8dvKACuF6sUW1DWEQjWRCLqgrGPB3dbT1UMo8
         QUS590uQFvpLrDblysaMFhoBF6d4ikES1YYGnal97m5whKBe7veRAccSmj5IzhnOJwO6
         ZDDg==
X-Forwarded-Encrypted: i=1; AJvYcCXipJPus+nczZ1SFq1tT47/VaLaO/id+2nkIi24QWFP1a55PdMbjXGsvXTIK0PUsG+bW9Hi3dJZSN0PKLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ExeCOfAIj0JM5gfqQ39CsZDAPFo1/K2B3YJ/txlMcEuwYo5k
	uSHvwo0Mq9rao7lAmVFjHJoeLBV6fu7vel/gnR4XbzGDulmrqBoOboSFg4KBd0Liksz84QK4H6L
	X
X-Gm-Gg: ASbGnctR1G+RqlJgukAtzYwUo2Pu8PTSQwUSj5wA6X/DuTHzoq4hiDWBiJRTpXrOZlp
	/Fzu36hO4guDLuJcKVbGyrGb1NYE75Bukdh+3chbgPLqDDQZHt33i7tFiKpiRInez55SQIdJaBT
	QywEX6XI2UvpBlfNOuqJxgtc+PuEqQ97UyA4lrfxbvWJI94yWQQePO/MYxPyeB8gN6hQExkJDf5
	vZbTcLWZehlTMqMaAlYAjMZV9o68bSS1pjYMVXGCbsGRW2xuyA8+9CieUz8PyuCM9MnV5PdpWnv
	oUST7M1Goug9UqwRppOFNmV7XgP9kHEKCsE/c6xjedWUbrZLL3qguauIO9TZ18VWg8dECJqFjSK
	7PdnIY/gVKyfsM/pJ
X-Google-Smtp-Source: AGHT+IHF2PL5nlHRaAy+vlhbkBYtTF0T7s6ZOWU4rgBP6VnqeSKDJmq+WAiMwII0SgzDwtXmOQ9xNg==
X-Received: by 2002:a05:6000:2808:b0:39a:ca0c:fb0c with SMTP id ffacd0b85a97d-39aca0cfb21mr350868f8f.28.1742888100838;
        Tue, 25 Mar 2025 00:35:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7a:6952:5850:1802? ([2a01:e0a:3d9:2080:7a:6952:5850:1802])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd18365sm142411785e9.13.2025.03.25.00.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 00:35:00 -0700 (PDT)
Message-ID: <0ca61f1e-ec51-4335-a74e-7337aad5219c@linaro.org>
Date: Tue, 25 Mar 2025 08:35:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/i2c: tda998x: select CONFIG_DRM_KMS_HELPER
To: Arnd Bergmann <arnd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Liu Ying <victor.liu@nxp.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250324210824.3094660-1-arnd@kernel.org>
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
In-Reply-To: <20250324210824.3094660-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/03/2025 22:08, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This fails to build without the KMS helper functions:
> 
> x86_64-linux-ld: drivers/gpu/drm/bridge/tda998x_drv.o: in function `tda998x_detect_work':
> tda998x_drv.c:(.text+0x4e6): undefined reference to `drm_kms_helper_hotplug_event'
> x86_64-linux-ld: drivers/gpu/drm/bridge/tda998x_drv.o: in function `tda998x_bind':
> tda998x_drv.c:(.text.unlikely+0x33): undefined reference to `drm_simple_encoder_init'
> x86_64-linux-ld: drivers/gpu/drm/bridge/tda998x_drv.o:(.rodata+0x584): undefined reference to `drm_atomic_helper_connector_reset'
> x86_64-linux-ld: drivers/gpu/drm/bridge/tda998x_drv.o:(.rodata+0x590): undefined reference to `drm_helper_probe_single_connector_modes'
> x86_64-linux-ld: drivers/gpu/drm/bridge/tda998x_drv.o:(.rodata+0x5a4): undefined reference to `drm_atomic_helper_connector_duplicate_state'
> x86_64-linux-ld: drivers/gpu/drm/bridge/tda998x_drv.o:(.rodata+0x5a8): undefined reference to `drm_atomic_helper_connector_destroy_state'
> 
> Select the missing symbol and fix up the broken whitespace.
> 
> Fixes: 325ba852d148 ("drm/i2c: move TDA998x driver under drivers/gpu/drm/bridge")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/bridge/Kconfig | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index d20f1646dac2..09a1be234f71 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -91,12 +91,13 @@ config DRM_FSL_LDB
>   	  Support for i.MX8MP DPI-to-LVDS on-SoC encoder.
>   
>   config DRM_I2C_NXP_TDA998X
> -       tristate "NXP Semiconductors TDA998X HDMI encoder"
> -       default m if DRM_TILCDC
> -       select CEC_CORE if CEC_NOTIFIER
> -       select SND_SOC_HDMI_CODEC if SND_SOC
> -       help
> -         Support for NXP Semiconductors TDA998X HDMI encoders.
> +	tristate "NXP Semiconductors TDA998X HDMI encoder"
> +	default m if DRM_TILCDC
> +	select CEC_CORE if CEC_NOTIFIER
> +	select DRM_KMS_HELPER
> +	select SND_SOC_HDMI_CODEC if SND_SOC
> +	help
> +	  Support for NXP Semiconductors TDA998X HDMI encoders.
>   
>   config DRM_ITE_IT6263
>   	tristate "ITE IT6263 LVDS/HDMI bridge"

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

