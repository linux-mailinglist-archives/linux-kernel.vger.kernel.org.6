Return-Path: <linux-kernel+bounces-531018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F471A43B18
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D0B1885B95
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA75264A95;
	Tue, 25 Feb 2025 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpI/ExiQ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370122139A6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478400; cv=none; b=BcNvSHscYb9FrIYmbkLh9tMNwGtOz/5KSPtiqljK5HL3u657FmukRymGSC38zCMZxfGAF4U6n7OUXcHJfwbf2kf4LxRdSMZrXqwiRNlDU2junn0a4/Oav3tOlWeKCqb2XIdnT8qqNlvTnxcuZgNEbHeKGkNjvG4/B3nLUaonKlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478400; c=relaxed/simple;
	bh=dh+DdXrD41FoDCiywpl4Jl9pY722E2W/HNmKBDuQ+KQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D+N1YGSzig4lFRpqrbIu3bxpdtiLmU+28iC9s7g2qTzIVwbC2XEpGr4zEwKl6imLuGFoLHzGbcv4yWO+Pojt4BlmzsJJ7qpSODQMCRwcQwMGNPjY8X7PqH/THoJfDfOlXVmMjVo+5ZipMnOmejHTFBstMNwvifTbr+HG2YYQqWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bpI/ExiQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4399ee18a57so31873005e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740478395; x=1741083195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIEVpBfqzlAIj3t3+p9Xkb4HBEKJwXzTRtthqqzde8o=;
        b=bpI/ExiQEfbjr1ajIorqrAiG2xTl2IszTDwfIKhZ5MoR0F4yef9N5LUNZWZXRwuxmQ
         9oWsegbJ8CwRlHpwqff6hPLFA8N+JQVaN7JqeayROFhGCt2KvHviQvwtWyaBnS5PyB57
         m9RjPq7RJrM0WAdyJvhm/8UZB09HtzLXCo46gFApn1RZ2jurOJwcTATILixML1BYxkm8
         GjNAPjavVr+DSmSATjYbSYYugNRz+zB/5cKaL/jt9s4fylZs1iX7FlmI2O3Spnqbghu9
         cJO0yMzokz3XGC4nk3d1kD2igTKXmRD3CadER1qHIjAE38W8jOzWuGo14o3joV3bQOdC
         wT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478395; x=1741083195;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UIEVpBfqzlAIj3t3+p9Xkb4HBEKJwXzTRtthqqzde8o=;
        b=be/4+CLhpugxpHElitS534GfAGHfwalhadoWgfSPuFIKsuFH5HoL5SH4Kseu7j3wiv
         I8JsKp7dEGxUPsmTGyC5ZTho475xSg0b1Rlm3VJBr6fpSaeBTIwzTHK9Rj+phGFRhRSe
         Srq9DMj7AWgQsj14syGdtTr0WPZliX55k3bFJHK1AofcgdLEKFvuwgGfm/EQ5R8M0Vw2
         QYNaLPSqtyGTk72i3H01cFH6nZQB6e/glOZTZ88nB4NGikiAz87Az9GMWL/YZ6H7aSYn
         C9jLRXkZRho/k9wAF5HHP5tK2Wxw+DDdm2bQxdTr8YYYRQ+So9iPedemyCQ6NBie/o+U
         vPRg==
X-Forwarded-Encrypted: i=1; AJvYcCUytYZ0AYq+b3awDY3nMqaAjsJ+E1eUAgZSynFeqCCvrpoDIIoT3ExtZ88zFnVnx4nmJShhTM/J6VfpMYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY8vYkAwl4hH46+VUcFtqUB6PpM99w0kvxYQ8NqUP1sOrBEpQF
	F2QLZpmTq0jDRZSVA8IFpy3kXkavbBftHdLNNHkEXfWtDpZwUTHDtwUpsbgUlnM=
X-Gm-Gg: ASbGncvcH35loUOV6N6wsJw6g3ro1suedX1i2Hwe4a7F9JrbRqNvB+8eQgEPxnqZXm1
	otA1raeHQ8NpHMbLXaGXRRb4vuDyQ36dyObHKsCpoK3kW/aRefAX3JZu3G4Ct6A74994B3ZPKP3
	tmINZ/HdrX3+qIgAzOpwZhNJ7TJVjONZbH44HmUyemqh2ztOLxqNTKuDHMbjuozPxkcoP2IYlZa
	r+NJYnPF/9NiSFAVpk4GPu7gAwPsGossjWC9xUuJhN82qKWPzkFH9dX+vRDNXADSiMMoS77SCtp
	IPqQ8cNEthj6O0534CjQ7g1MKIJ8FxVB/J9/
X-Google-Smtp-Source: AGHT+IHuxrFve4RrQxTJm/qq5KQxrxMVsYCL+f8dws0ADcO/Z7yzKKpEwdKKdpFUHyiamvR4ZVYVPw==
X-Received: by 2002:a05:600c:46ca:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-439ae2d1f3fmr129669155e9.3.1740478395441;
        Tue, 25 Feb 2025 02:13:15 -0800 (PST)
Received: from [192.168.1.100] ([37.167.173.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce615sm135803455e9.5.2025.02.25.02.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:13:15 -0800 (PST)
Message-ID: <d4903cb5-f876-4229-b89c-c1fafd77fc3c@linaro.org>
Date: Tue, 25 Feb 2025 11:13:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 08/14] drm/panel: simple: Add BOE AV123Z7M-N17 panel
To: maudspierings@gocontroll.com, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
 <20250224-initial_display-v1-8-5ccbbf613543@gocontroll.com>
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
In-Reply-To: <20250224-initial_display-v1-8-5ccbbf613543@gocontroll.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/02/2025 14:50, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
> 
> Add support for the BOE AV123Z7M-N17 12.3" LVDS panel.
> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index a52977ab73dc2edab0d1954c702fd797d6a5b969..232b03c1a259eb15e423b9d452d28e2ff95c70f8 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1403,6 +1403,35 @@ static const struct panel_desc boe_av101hdt_a10 = {
>   	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>   };
>   
> +static const struct display_timing boe_av123z7m_n17_timing = {
> +	.pixelclock = { 86600000, 88000000, 90800000, },
> +	.hactive = { 1920, 1920, 1920, },
> +	.hfront_porch = { 10, 10, 10, },
> +	.hback_porch = { 10, 10, 10, },
> +	.hsync_len = { 9, 12, 25, },
> +	.vactive = { 720, 720, 720, },
> +	.vfront_porch = { 7, 10, 13, },
> +	.vback_porch = { 7, 10, 13, },
> +	.vsync_len = { 7, 11, 14, },
> +	.flags = DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW,
> +};
> +
> +static const struct panel_desc boe_av123z7m_n17 = {
> +	.timings = &boe_av123z7m_n17_timing,
> +	.bpc = 8,
> +	.num_timings = 1,
> +	.size = {
> +		.width = 292,
> +		.height = 110,
> +	},
> +	.delay = {
> +		.prepare = 50,
> +		.disable = 50,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
>   static const struct drm_display_mode boe_bp101wx1_100_mode = {
>   	.clock = 78945,
>   	.hdisplay = 1280,
> @@ -4845,6 +4874,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "boe,av101hdt-a10",
>   		.data = &boe_av101hdt_a10,
> +	}, {
> +		.compatible = "boe,av123z7m-n17",
> +		.data = &boe_av123z7m_n17,
>   	}, {
>   		.compatible = "boe,bp082wx1-100",
>   		.data = &boe_bp082wx1_100,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

