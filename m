Return-Path: <linux-kernel+bounces-427913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BABE9E09B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3632EB62EDC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB68A70826;
	Mon,  2 Dec 2024 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WlFaVTB7"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A8134AC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154325; cv=none; b=JdU5zmjRQqfXtAbmLglfTgfJlVMsvlgGFPC6yEiiBpiBKP7R6WSTtdw/Mf86PXZoUg/bcQcl5JpouU+xUgS6Xmy0ER7AjrlzRUjHwZjCBp/iQ9ClkZNe6Hn2sFoQG3kWuowCAHKoCR81KD96e9LNjgQcSRXKoO42HWLfAy6gesU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154325; c=relaxed/simple;
	bh=q5gg2z6gcwf5PuTmOWejngKLKMwsr4Rc+qpeN8wKwNk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HB5KMxEvy/4B9inSejTwNVB7i9miHLN+FlSvyQjuN7yPwC/KukRPN2Tds2vCyTn8kmlV+Jyx4xwkDjId+dif6Lzt8U2oLeQG6uJuPEfsQ+kCFfVWSW9CtX6XKqmE9vl3JkwtMCge6qdH9rVcERjchwWFtT+lYCfoJyOPV72AIzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WlFaVTB7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso2761102f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733154321; x=1733759121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsAlaAuDi0Tk+rbL8JjCncmrpcl4/d9qDg5WbOHlB9w=;
        b=WlFaVTB7S/98VvS7iChnOLW4YW1ch4BD0NOyhPpDxLnD2I23pWlpnWoG9j4BJhfJyM
         WVNxd0C8Tjok8GRAjTOVqjdhb+QBFfphoILkXq+Unh8x5B688RCMYZ2zY0PBjZqaAx2X
         zt0EWnXX94IrCTq53XFe0cs4L87qUJlTSwT7dv39ZizV9ZK629g0JfJEBCbed6cc+0Dn
         XfnGwxWCXhDnRMDIpytPOhjdXU+6IOYFml9bfGtWYbPpS9dIKvUhsD6KtMh3rYxxcyeC
         dVI5k53z2p6PkAnlzGAMvNaph6Gxalydgdpum1ihVdQ3E1PGgwpvzYBfx0ReqdPl28Ji
         a9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733154321; x=1733759121;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PsAlaAuDi0Tk+rbL8JjCncmrpcl4/d9qDg5WbOHlB9w=;
        b=Ylc+Y9Q3r128k+lvsH1pTCQ4yeg0LRejWip3/xiE+ehAmpocgo6JzhbgahPdsrRJsZ
         Rf6mtlPltWTOg/ySmLbaqEsEb3xOQK0bFePmsjyoUddp4DgZ+VdKU7h4jAVWQERbjbQe
         wA4CI6ynzxBiuzKjnpFOYSk+dOVTxHp76Sa9dvTBN5x7O0v+G49RUbt58ZpVijV6IkTK
         1plXJA7K/2C7+Ow4iW3100lTgASrb1a3Dw1xnTZZk+S236Vr84WPmHOiOmwyrQsbLf+E
         LpljCXEefg1fo13rkVjqTVWrZXFC00RTwb2bvb0Qc95mVbm9tm4nRRr/qid2S8CPg/h4
         hSUA==
X-Forwarded-Encrypted: i=1; AJvYcCWKJ11lNarHFvmonlhAenFrsE+5Aak+NCr/oY1PwIlxMgESqFJUASLIpqWWu0tDaS6EmR0+Abp9FxQYWJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxepZE0hxqo8N10H07Qr5GBTypvTL1w9WK5JnguAbaWZsko3Gs7
	ENK2qMEIO6+KOURY3wa4FBDvF43xwGlJTQHMjqc7MADoaB9fbp6A3pZQEbGP//s=
X-Gm-Gg: ASbGncvXy/8QOWot6e0pYmJW+87tWa1qYli2e0/woqIE6uKYk0rTDi8/KYdxr2OiLmM
	gDGSVMwtjR0idlSvhPxxcmFUS40lJAEFUXw4GoBesJTwGPGIFs7ZXWzOxPep4zN0g/74rhrEt4o
	HM5vLQ+6E3svMq3MCxrTJCP1ugc6CpPlfqmZLLzQrAiX9UzDke8y+7ek7a8DVPQ3pfLbzwmJiBI
	+incdHXvXSqpPmMkcpMgzu+2+t3HNEOmEShEopU4r7ovdT14gQmIM88b4e4NlzpGFYV16dEiQop
	3qz/mejeijZtKMGc5SSOT729HPI=
X-Google-Smtp-Source: AGHT+IHY/ZJesNDq8WcklgakuUkeQQ8aCpaHvI3UaYQnhebJTHXO8tn+nJwIo6alJ7oxVdeVNOzNMA==
X-Received: by 2002:a05:6000:18a5:b0:385:df87:28de with SMTP id ffacd0b85a97d-385df8729admr12349605f8f.56.1733154321520;
        Mon, 02 Dec 2024 07:45:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1485:2a78:787c:c669? ([2a01:e0a:982:cbb0:1485:2a78:787c:c669])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74edb1sm191473505e9.3.2024.12.02.07.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 07:45:20 -0800 (PST)
Message-ID: <5bbd44dc-cbe8-4906-afa2-6866f5d39341@linaro.org>
Date: Mon, 2 Dec 2024 16:45:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: dw-hdmi: Sync comments with actual bus
 formats order
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241130-dw-hdmi-bus-fmt-order-v1-1-510b5fb6b990@collabora.com>
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
In-Reply-To: <20241130-dw-hdmi-bus-fmt-order-v1-1-510b5fb6b990@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 30/11/2024 00:04, Cristian Ciocaltea wrote:
> Commit d3d6b1bf85ae ("drm: bridge: dw_hdmi: fix preference of RGB modes
> over YUV420") changed the order of the output bus formats, but missed to
> update accordingly the affected comment blocks related to
> dw_hdmi_bridge_atomic_get_output_bus_fmts().
> 
> Fix the misleading comments and a context related typo.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 996733ed2c004c83a989cb8da54d8b630d9f2c02..d76aede757175d7ad5873c5d7623abf2d12da73c 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2621,6 +2621,7 @@ static int dw_hdmi_connector_create(struct dw_hdmi *hdmi)
>    * - MEDIA_BUS_FMT_UYYVYY12_0_5X36,
>    * - MEDIA_BUS_FMT_UYYVYY10_0_5X30,
>    * - MEDIA_BUS_FMT_UYYVYY8_0_5X24,
> + * - MEDIA_BUS_FMT_RGB888_1X24,
>    * - MEDIA_BUS_FMT_YUV16_1X48,
>    * - MEDIA_BUS_FMT_RGB161616_1X48,
>    * - MEDIA_BUS_FMT_UYVY12_1X24,
> @@ -2631,7 +2632,6 @@ static int dw_hdmi_connector_create(struct dw_hdmi *hdmi)
>    * - MEDIA_BUS_FMT_RGB101010_1X30,
>    * - MEDIA_BUS_FMT_UYVY8_1X16,
>    * - MEDIA_BUS_FMT_YUV8_1X24,
> - * - MEDIA_BUS_FMT_RGB888_1X24,
>    */
>   
>   /* Can return a maximum of 11 possible output formats for a mode/connector */
> @@ -2669,7 +2669,7 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>   	}
>   
>   	/*
> -	 * If the current mode enforces 4:2:0, force the output but format
> +	 * If the current mode enforces 4:2:0, force the output bus format
>   	 * to 4:2:0 and do not add the YUV422/444/RGB formats
>   	 */
>   	if (conn->ycbcr_420_allowed &&
> @@ -2698,14 +2698,14 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>   		}
>   	}
>   
> +	/* Default 8bit RGB fallback */
> +	output_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;

Why did you move this ? the following comment mentions it

> +
>   	/*
>   	 * Order bus formats from 16bit to 8bit and from YUV422 to RGB
> -	 * if supported. In any case the default RGB888 format is added
> +	 * if supported.
>   	 */
>   
> -	/* Default 8bit RGB fallback */
> -	output_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
> -
>   	if (max_bpc >= 16 && info->bpc == 16) {
>   		if (info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
>   			output_fmts[i++] = MEDIA_BUS_FMT_YUV16_1X48;
> 
> ---
> base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
> change-id: 20241130-dw-hdmi-bus-fmt-order-7f6db5db2f0a
> 


