Return-Path: <linux-kernel+bounces-203886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EDD8FE1A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F43E28807A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817A91422AA;
	Thu,  6 Jun 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HjjamAc7"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C2A13FD9F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663872; cv=none; b=NWNEi74XUZo2CoemK1CfvOVyM1f77Nap8VmYoAhxe3PKcte52ys5dqt1CANFn2lgr81WqrIFXXYKnW7et8+GAxH8qgQq7tcIA18y4dwjvDShuRVc5rJMP0PasjMQgjEbPUCve8nsAG8g1FP/vS8gM2ooG3A+OUwRro6nyAypf+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663872; c=relaxed/simple;
	bh=qVFJC1If1D6uv3pLst+yrXqJjI6YjN+U64oD0mcE4jA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=crP6YMuDCWuBo9OLoktDEm56NnzVJDCtmC7cejdBbPMNmvy74926F4wKa2ZFhbyi9IbD1L2J0SJZAptIq5Dn9GLUmq6yP5gAgsas76ts5WJ0iWlMW/zUAUTjNDySMr9mhqUnKigO7NXBBeRlRlX0UB8pftDWMcim6hJUMp26Vbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HjjamAc7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4215b0c4b7dso8286915e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717663869; x=1718268669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZI5zO681dIZ5q8bqEnHAbUgRlM/vYadx+NmJdrvw+DY=;
        b=HjjamAc7otO1worU4UhGl8o+pinIbBWSUA3xhDpo7ahmxN1uH6hxGQmNDKkZBznMh9
         /lb6tgaowzPIVMAkABi7VhAOK9USW6J6zaeWt3YZoLt20mvTxode1ni3MA7jypyo1WON
         LuFgCJZdELOHjlmji5GExpTPPs7A7/l63kCasy3N3GFQLRYGa+fweqWW6kBiidjlwZNY
         P1lDAaQnBTw+V08eKSGg4U0fWRNWn026KudloCePxnBTJVWr/r6eucFkDRMf5w0SiavY
         195YmFbWpjUnbkdZg6ZuimaqgCsoAazGr2ZDRca2dY8JazZ62K/08eLbEfN0o7gIOr17
         nHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663869; x=1718268669;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZI5zO681dIZ5q8bqEnHAbUgRlM/vYadx+NmJdrvw+DY=;
        b=J8mJgPtyZXQscEXXeYIqcOqndHc5+11xMEghyNZoIqlmKcbM3Q9BgwXoRouxH+8E2j
         s//vh9m/uAd8Ffg3exI/cof8TF2l8/ZgQQ4Hqi5dcdoB+8yhksFdJyNAHPtwRKThyMYc
         e4vqQbRhnNciIAnzL+69Kyd8kFpcr1Ipoi0//FwSdXHM6HYUMRkRHfL9npchTzps6VuV
         LfakbXS/zgxIc49uJlJZxduT7vecGcri5sm4BEufHR4/OvrQA2rq7I385l/Vll8wYjL6
         MQJK0lQkt4sKXZH5VdTciIzl34E2x06fzxoK2uzC9qZMxctHVFiT2rZWLdNhi/755QiP
         7X9g==
X-Forwarded-Encrypted: i=1; AJvYcCWkk4M6BxuKEpCwIddlpjn9HlZTscYknJfhBhUScAIB6TAVFQe573ZLGxh64LGPJMEFuP5T7bv+v42hkETWCLnsPWhZ+Fs2d3nO951z
X-Gm-Message-State: AOJu0YyxlPn//s9o806QvopaDZI8CeeXCn3N4a6c+FlRrSyxTnsabDQq
	w6CgT4txGHAjLG2bVzKZWTh9Y9Japt6+LOXQMWYVtF8jpK8o55t2g9VLzrwFxpY=
X-Google-Smtp-Source: AGHT+IESxvRQoF/gagRjviYpc/SnR8a0ifFLan5H7+GDdNM95jrQIk7lkTGWJoL2Z9fRMGQKoi/Rxg==
X-Received: by 2002:a05:600c:1f8e:b0:421:29e1:998 with SMTP id 5b1f17b1804b1-421563392dbmr36961795e9.39.1717663869196;
        Thu, 06 Jun 2024 01:51:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:22fd:4ae6:287f:17f2? ([2a01:e0a:982:cbb0:22fd:4ae6:287f:17f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4214bf59f60sm67973595e9.1.2024.06.06.01.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 01:51:08 -0700 (PDT)
Message-ID: <a5f7c9bc-49fb-4b20-bfed-0f65606c5e3b@linaro.org>
Date: Thu, 6 Jun 2024 10:51:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/3] drm/panel: simple: Add PrimeView PM070WL4 support
To: Primoz Fiser <primoz.fiser@norik.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Chris Morgan <macromorgan@hotmail.com>,
 Sebastian Reichel <sre@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: upstream@lists.phytec.de
References: <20240606080104.3663355-1-primoz.fiser@norik.com>
 <20240606080104.3663355-3-primoz.fiser@norik.com>
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
In-Reply-To: <20240606080104.3663355-3-primoz.fiser@norik.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/06/2024 10:01, Primoz Fiser wrote:
> Add support for PrimeView PM070WL4 7.0" (800x480) TFT-LCD panel.
> Datasheet can be found at [1].
> 
> [1] https://www.beyondinfinite.com/lcd/Library/Pvi/PM070WL4-V1.0.pdf
> 
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
> Changes in v2:
> - sort alphabetically
> 
>   drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index dcb6d0b6ced0..80cca841db15 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -3567,6 +3567,32 @@ static const struct panel_desc powertip_ph800480t013_idf02  = {
>   	.connector_type = DRM_MODE_CONNECTOR_DPI,
>   };
>   
> +static const struct drm_display_mode primeview_pm070wl4_mode = {
> +	.clock = 32000,
> +	.hdisplay = 800,
> +	.hsync_start = 800 + 42,
> +	.hsync_end = 800 + 42 + 128,
> +	.htotal = 800 + 42 + 128 + 86,
> +	.vdisplay = 480,
> +	.vsync_start = 480 + 10,
> +	.vsync_end = 480 + 10 + 2,
> +	.vtotal = 480 + 10 + 2 + 33,
> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +};
> +
> +static const struct panel_desc primeview_pm070wl4 = {
> +	.modes = &primeview_pm070wl4_mode,
> +	.num_modes = 1,
> +	.bpc = 6,
> +	.size = {
> +		.width = 152,
> +		.height = 91,
> +	},
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE,
> +	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> +};
> +
>   static const struct drm_display_mode qd43003c0_40_mode = {
>   	.clock = 9000,
>   	.hdisplay = 480,
> @@ -4725,6 +4751,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "powertip,ph800480t013-idf02",
>   		.data = &powertip_ph800480t013_idf02,
> +	}, {
> +		.compatible = "primeview,pm070wl4",
> +		.data = &primeview_pm070wl4,
>   	}, {
>   		.compatible = "qiaodian,qd43003c0-40",
>   		.data = &qd43003c0_40,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

