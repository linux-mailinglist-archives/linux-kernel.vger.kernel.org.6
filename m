Return-Path: <linux-kernel+bounces-292395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A09E956EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A162865C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA7785956;
	Mon, 19 Aug 2024 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EehRyEkf"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FCC1EB3D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081865; cv=none; b=spIKit2BVUSbXBHzHSsnDWwGiMWM+h/zNfE6myRSdCFQWzE70nI/y/m6xkrWL/4BLbcy6Rukks6awsc8XMjLE/ZbS25UOl9YUhsAnyBps2Wlk4LjPNw/e3sjkX87IdjpcZdW6DynsGzSAp18MKxdNLeoRbcT1b69ZW11LzzF1Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081865; c=relaxed/simple;
	bh=4n8U2xWGmoHFdeCbsX2e1kAeOfQZROOpzwJ5lIlC7qM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=f9CBcWCvPLfyg3okLTxm7LEMUIxXmgpUocu1/BDIGQaJmyN+PO7vbXADeZd2S8cO/shUG9WMYJSrWoU7g+CZylb7xHNNEK74TY6tru0OkDr/HR+WZer1/N3XKqdhejbm/XAWnj6pLNPiQlR8jnwtOHISNM8X87maPgRxy0v+tAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EehRyEkf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso49233615e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724081862; x=1724686662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gk/aI2kxKmkDRsiAKaWtwtbGzvvh1/Raj/5lOKvnf68=;
        b=EehRyEkfSYKomaD1wErzgeMzy+tHdbEiLi+uTss3nQMMmUrnQaNCMWi8wFAlAFc2Hy
         PrhbQguauaqPoesizfExee0u3pvpzHniMMlJQpZwAo1q9IqAlT7lh+KwiK+096FcVzzF
         3+yuk0xvBbTER8UoAiWd64UY16VJhoWNtzaF7gD+B887SDgDL4sMZXW46IwKelrR7D/A
         pNdUUh9Weci/+0A+LGjLzyIOrmC5+xMotKdAkJmrYGjyJig56ZXmquL39xDZ97WbIz8u
         wpsNVhVXpCUG0uxjtNgTMvXtzoa3Y8osmUYwq0xXm9SdIBs49AsGvGzzTSfMYaySZDxH
         ASKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724081862; x=1724686662;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gk/aI2kxKmkDRsiAKaWtwtbGzvvh1/Raj/5lOKvnf68=;
        b=pQYc4bj53zXFQ5FewiC2W7I72qFLWmC/6jUeOM0B+yZC7J37khyFHP+MT3kUNET49Y
         tx/lxx7zF0N4F6Q+uaNScHf406RPwTYKqldvGFCB8h+BhdvVG0bZHemnVe7AVGZoXc6W
         poJdqhpdIWWbv2Qvyc2q23h/gerDUAZ4/cZfG7hkS/HN9gmjhKSprDDhfzaPbLjfJs7q
         Qxcp7q0pD6XdZGc+g8mpP6WNHcTVG5dV/Ck1Z2A3Dnj//ZCBq9g8VQcprkDbRTRpQuXf
         u/x2Baf5YzSvS8m4WfWqbihrHbnR63yQUZa4/YECQeBv4e0SeR9xypY7b1fuAOzTqXct
         OnsA==
X-Forwarded-Encrypted: i=1; AJvYcCVlMPd0k/qDVMtgxK3V5YQPdHGAVuD1kwR54QNYuduFOL6XD1lP3vaT6PQYo1gI+MUmLgFuHhnSFKIFocOawm0UkpMLTWTC+6IvUipu
X-Gm-Message-State: AOJu0YwE6NarDvXqx01IvKSrmiW7fWrOCicmkoHpfQMpIwiUokYIl9vd
	L0tgLyv/04MmSMRj64ojHNPCGmHjFxxNWRZviTq7ZSY2bKefKEQAJBolk7ldzqM=
X-Google-Smtp-Source: AGHT+IEtBMpFzGovTSbnyr1xNX0cNQOcqOR29mxr34rfwLVAio2zTzxR5KH9Pf51ZSP8cxK3YtubPw==
X-Received: by 2002:a5d:4fd1:0:b0:368:420c:74ab with SMTP id ffacd0b85a97d-3719464c2eemr9937656f8f.28.1724081861387;
        Mon, 19 Aug 2024 08:37:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a7d3sm10803548f8f.61.2024.08.19.08.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 08:37:41 -0700 (PDT)
Message-ID: <556b7957-802b-4792-a04b-427409807902@linaro.org>
Date: Mon, 19 Aug 2024 17:37:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] drm/panel: simple: Add ON Tat Industrial Company
 KD50G21-40NT-A1 panel
To: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, sam@ravnborg.org
References: <20240816085004.491494-1-victor.liu@nxp.com>
 <20240816085004.491494-3-victor.liu@nxp.com>
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
In-Reply-To: <20240816085004.491494-3-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2024 10:50, Liu Ying wrote:
> ON Tat Industrial Company KD50G21-40NT-A1 is a 5" WVGA LCD panel with DPI
> interface.
> 
> The LCD module specification can be found at:
> https://cdn-shop.adafruit.com/datasheets/KD50G21-40NT-A1.pdf
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 36 ++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index bf40057c5cf3..89963df80917 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -3478,6 +3478,39 @@ static const struct panel_desc olimex_lcd_olinuxino_43ts = {
>   	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
>   };
>   
> +static const struct display_timing ontat_kd50g21_40nt_a1_timing = {
> +	.pixelclock = { 30000000, 30000000, 50000000 },
> +	.hactive = { 800, 800, 800 },
> +	.hfront_porch = { 1, 40, 255 },
> +	.hback_porch = { 1, 40, 87 },
> +	.hsync_len = { 1, 48, 87 },
> +	.vactive = { 480, 480, 480 },
> +	.vfront_porch = { 1, 13, 255 },
> +	.vback_porch = { 1, 29, 29 },
> +	.vsync_len = { 3, 3, 31 },
> +	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
> +		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE,
> +};
> +
> +static const struct panel_desc ontat_kd50g21_40nt_a1 = {
> +	.timings = &ontat_kd50g21_40nt_a1_timing,
> +	.num_timings = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 108,
> +		.height = 65,
> +	},
> +	.delay = {
> +		.prepare = 147,		/* 5 VSDs */
> +		.enable = 147,		/* 5 VSDs */
> +		.disable = 88,		/* 3 VSDs */
> +		.unprepare = 117,	/* 4 VSDs */
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
> +	.connector_type = DRM_MODE_CONNECTOR_DPI,
> +};
> +
>   /*
>    * 800x480 CVT. The panel appears to be quite accepting, at least as far as
>    * pixel clocks, but this is the timing that was being used in the Adafruit
> @@ -4837,6 +4870,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "olimex,lcd-olinuxino-43-ts",
>   		.data = &olimex_lcd_olinuxino_43ts,
> +	}, {
> +		.compatible = "ontat,kd50g21-40nt-a1",
> +		.data = &ontat_kd50g21_40nt_a1,
>   	}, {
>   		.compatible = "ontat,yx700wv03",
>   		.data = &ontat_yx700wv03,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

