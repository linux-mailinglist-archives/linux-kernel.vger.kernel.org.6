Return-Path: <linux-kernel+bounces-327723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D872E977A56
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EE7280E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A04A1BA894;
	Fri, 13 Sep 2024 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSbXOo+w"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E2929A2
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214160; cv=none; b=RTmqVwIAGvrLSGSPYPnIZ0kfVwMDQHoGv6MB+JVibkJcK6RYm5s6JZmcwDZ06baoap8bSOos7cW9gcu0KSq4z31vjvBBhgCXkGALsG4gnafCj7v4UexwvHO8k8gBSPG60cwJCTsYTDG/nGExZYBcpfU+WHDVDgV0j8p5sYYzkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214160; c=relaxed/simple;
	bh=P4RRzbVZqR+7RqVZ6cixGjJerxZq0gbufks+nCUHihU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fn4l66fKuwBBfEvKbPppE+d1cX3CuuoaY6vAUXaTCDAjCTmCHkx2c/R5ekJFsEXfjFrI5WF1nyIZZQ4UE6nIgtJKLTctj5aIYqIMsyjfBlTzjllPofVqOmrnSQu/fBXtZCOTk04ZGpEVlEcQnYId8cRBRHY3jfMwVPFLzx6YmNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YSbXOo+w; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso16552855e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 00:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726214157; x=1726818957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpTzSDvBYrkyHKuoj+wO5zn+z4Yh1FOYkc1VxdL7vAc=;
        b=YSbXOo+wTRy/pB4Ym2hB59NXJOI/EjxQu1/+l0t2gQ8Cms1DQKSilYCuaUdVIgz8hi
         CWOgjMmXo8d6yk5aLyWnW6q+XNLKgpFAlBAg4M4ZwjRKtC2Hhwv8+K//I7O+8hl1W2Bh
         lm9Hji0ybsQ9pY69+aFOcKul1c52HA2dtwtu97t+yOMtuH7+QwmtGL7imU3TcMOxvNj6
         Em34UZ2VhxnAR5yiAGWqqilMNBTHOhsENNSKsXoPqKpWbhQ0E45Ejfff1E4GhZ1fxGNx
         zIG/xosGfEhTJUaY1SGCtFA2Pwk8XR+N+lF8/fR1Jm/fB1XPi24QmTwVjMQUqfwkIFFy
         BBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726214157; x=1726818957;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qpTzSDvBYrkyHKuoj+wO5zn+z4Yh1FOYkc1VxdL7vAc=;
        b=sctFdykXE41/Opj5i4I3g27UnPXj94dl0bFUchkoUDjgW0jD4Lu9wGxJak44mUxfc9
         rwdKnBdDE7Jg3iF3haGnTWaeNZGr2GIq/M82+SWCQ0yugBJ/KQTsWv37vWNAdBBWGbBG
         JnxHAZwI3g9HsrwQl+26/pM8QEvonqr7PqzsXIUiP5GX4ulzhLN18OtNVTC4wqzrKp/Q
         fo3+MOkUrbu8wNeZ68MdCA3MDeAyGmGSaF8P/eshiFmt10AWwUpx4LpQAG3xEw99p3nC
         Rx3D4LZgNeiaNhJv4lIWec3LbsLYhl7Ywr7Q6c6oqm0JYFuAKGpO6f4m0xAbKbybFNB4
         xLgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6iWunAQeRRV8bcqxoGd3Yo5lBCJjrnWt53E1ii2jyAVjhdSvU/BKr/vO88/1Cg80PyCfhrSTC2CkGgKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOhpAVlKQ00+7PNn8XGxztcybSNxl0JIw5VDabANkbITPCeHCt
	IxBEhPl4WzGzRI3LK5gwfHXkL0JSb0DVodk7OdB9SQa73qyROqfnLnn94eeJ87I=
X-Google-Smtp-Source: AGHT+IEMJDCWhsJ1G+6tU9z1uEdB6hFH+MN3Eo32SqDktckuuO3ZulfwrdeZkxDnoTWA251Oe42UZQ==
X-Received: by 2002:a05:600c:2058:b0:42c:de9b:a1b5 with SMTP id 5b1f17b1804b1-42cde9ba226mr36532255e9.32.1726214157104;
        Fri, 13 Sep 2024 00:55:57 -0700 (PDT)
Received: from [192.168.7.202] ([212.114.21.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b054dd3sm15035345e9.5.2024.09.13.00.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 00:55:56 -0700 (PDT)
Message-ID: <ba9c9e9e-006e-40c8-b4cf-45dc08a5ea57@linaro.org>
Date: Fri, 13 Sep 2024 09:55:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: nwl-dsi: Use vsync/hsync polarity from
 display mode
To: Esben Haabendal <esben@geanix.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240814-nwl-dsi-sync-polarity-v1-1-ee198e369196@geanix.com>
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
In-Reply-To: <20240814-nwl-dsi-sync-polarity-v1-1-ee198e369196@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/08/2024 12:37, Esben Haabendal wrote:
> Using the correct bit helps. The documentation specifies bit 0 in both
> registers to be controlling polarity of dpi_vsync_input and
> dpi_hsync_input polarity. Bit 1 is reserved, and should therefore not be
> set.
> 
> Tested with panel that requires active high vsync and hsync.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>   drivers/gpu/drm/bridge/nwl-dsi.c | 8 ++++----
>   drivers/gpu/drm/bridge/nwl-dsi.h | 4 ++--
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index 8d54091ec66e..5f05647a3bea 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -289,13 +289,13 @@ static int nwl_dsi_config_dpi(struct nwl_dsi *dsi)
>   
>   	nwl_dsi_write(dsi, NWL_DSI_INTERFACE_COLOR_CODING, NWL_DSI_DPI_24_BIT);
>   	nwl_dsi_write(dsi, NWL_DSI_PIXEL_FORMAT, color_format);
> -	/*
> -	 * Adjusting input polarity based on the video mode results in
> -	 * a black screen so always pick active low:
> -	 */
>   	nwl_dsi_write(dsi, NWL_DSI_VSYNC_POLARITY,
> +		      dsi->mode.flags & DRM_MODE_FLAG_PVSYNC ?
> +		      NWL_DSI_VSYNC_POLARITY_ACTIVE_HIGH :
>   		      NWL_DSI_VSYNC_POLARITY_ACTIVE_LOW);
>   	nwl_dsi_write(dsi, NWL_DSI_HSYNC_POLARITY,
> +		      dsi->mode.flags & DRM_MODE_FLAG_PHSYNC ?
> +		      NWL_DSI_HSYNC_POLARITY_ACTIVE_HIGH :
>   		      NWL_DSI_HSYNC_POLARITY_ACTIVE_LOW);
>   
>   	burst_mode = (dsi->dsi_mode_flags & MIPI_DSI_MODE_VIDEO_BURST) &&
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.h b/drivers/gpu/drm/bridge/nwl-dsi.h
> index a247a8a11c7c..61e7d65cb1eb 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.h
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.h
> @@ -30,11 +30,11 @@
>   #define NWL_DSI_PIXEL_FORMAT			0x20c
>   #define NWL_DSI_VSYNC_POLARITY			0x210
>   #define NWL_DSI_VSYNC_POLARITY_ACTIVE_LOW	0
> -#define NWL_DSI_VSYNC_POLARITY_ACTIVE_HIGH	BIT(1)
> +#define NWL_DSI_VSYNC_POLARITY_ACTIVE_HIGH	BIT(0)
>   
>   #define NWL_DSI_HSYNC_POLARITY			0x214
>   #define NWL_DSI_HSYNC_POLARITY_ACTIVE_LOW	0
> -#define NWL_DSI_HSYNC_POLARITY_ACTIVE_HIGH	BIT(1)
> +#define NWL_DSI_HSYNC_POLARITY_ACTIVE_HIGH	BIT(0)
>   
>   #define NWL_DSI_VIDEO_MODE			0x218
>   #define NWL_DSI_HFP				0x21c
> 
> ---
> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
> change-id: 20240814-nwl-dsi-sync-polarity-ddc58435a4c4
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

