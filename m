Return-Path: <linux-kernel+bounces-565694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E94A66D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899673A9F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD3D1EFF86;
	Tue, 18 Mar 2025 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b80RcFWL"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34E81EF36D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285556; cv=none; b=gNbeuCLgpohjf/uKERASlbf2LpJfeX2FT0YG3Ab+uvdfSMzT6XOxfIZB9k1ubR3MpQU1B+sGI1Kek+t5A/xA5Pdsuh1ivAIfVyHc/sKJldnbK+2RjnygvLucuU8HR+pHS2xdc5zFYpL0w7sTdWyfOccpuCoSAwAiea0Kh4domUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285556; c=relaxed/simple;
	bh=0toriMwAl0CDBgiEM/DdeLsHbi9lHVArG6qmpGUnNnM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IKUj/eWcAci6DhQ0VWEcrYtGx1l4C/EaPHyCn8/GAW2HpR52T2TeObPZ84g7JpaXeCZDg7hKkuOZukiDfvoDf0HrhJqRoeilWRBqxIOdlQDEnKnPThJ8nMxbwAkmcm/5fy/NRA0gQIHo6W6ae6wxXcbsQUxJREJEnMJNs+oySFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b80RcFWL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913cf69784so4433974f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742285552; x=1742890352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ekU0V/TxaNd7IwpxOyskUtDxhInPM+KcMXnEVWAgd0g=;
        b=b80RcFWL4/Csu7/EFKwyr6JtuBmhme2/XELTgB0sUNz7fqmJgyergYR/BBXKsRNqRd
         Ow/8IkbROV7jXUQQsjoQnThS5taOR1Wop5OZGWX6tZBIsTWSsFShnlawVKlyMozZeMb1
         kTbTbGJ6i6Azlnnb/Jt/XUkfQW9AqLtoQHasHP1FWAIlaYsGXL7X0G5lIGRGP6YGvSPd
         Xe3EsqqFxmKFBTjYkxtKQFdweMJAO1iEisHihDpXKSTvvKVWNJ+G/EXDfLU/9cwUbMnG
         JW6RB9fq/pyD0L7gFAOzYHExd6R0MYPhvQfD0bWxkq3jAg/P1NXg6BpFX3CnrGixCM4C
         G0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742285552; x=1742890352;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ekU0V/TxaNd7IwpxOyskUtDxhInPM+KcMXnEVWAgd0g=;
        b=JGTCHQBkuK1SlKb6FLo+pWPDjUIF0b3FjbaaM4gfY1igDPKtRKKfnuOGGnoxr4Hgr3
         VUw2ePVOLd9uOHotTmSh1MrQFORuM0ep8k9+0NN7J4Pxl6ko86NPAF52T1/L8Q4y5bnV
         TxxcDDsuhlbmdHIbu83MmWoefdkkc+9PDEKk7mFJkP1TEClhVxEJvtogfbORTeJxNgHL
         JR/7dskV7OyaXGSZdYf5PF+R6cqV2AoYRdPzutKT6uSb1o9QxPYhCulxEdMcQPYkJkR7
         g0BnZZN4VRD3Rso7YrlZf80uJrS8ZpO0Uxi/FblszSkH3yVXgN3iZ9gcyhasSH4eWZOX
         rGag==
X-Forwarded-Encrypted: i=1; AJvYcCWJyr88fHMl50ttzfnJnSiqtPL/e7bnLm0VkTIYii414cMCWZxk7aa5xLdDZj/X0k0eCdPrqxS2QQQnZ9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl6MIdfH19lDOvVTz22w82ClKsbyqxXL51QV+dMMk1yVJF/+To
	vlGqt5s1Y9B/Rl3ZYBCheoa1aqd/Q/F8o2T7x6hj0/p2MEG+brbQXjSc6TOz7jM=
X-Gm-Gg: ASbGncuVBe6rII2NegQcJVhy7Bh2v2SEC9ZDtcm6oi9jhP7Dyz+vGjs0ePNlh9i4PQq
	cEPKzgdQimgh8G5yPZv1nObrtyWBIe2pLIRLXlLKEHRvI1GDhdCyWq9LTGVDbF2wT9YcgAyFukK
	HoOSjQPpmH7O1pKoGaB8d5Of7+zDp2Oh3/aFi07KXgPO4/794J69HAqYQI0L8UVi2o9UU0uonql
	43D7vGuR2iJmVRuN1GwnI6Oruw2O8cWw2Bl+MeihQvXK2O5bMSZ3g3UHWpMOpVjb2d8XkxDLVAD
	NywHEhdEVROGMResvJTJYQiWizO7h6BpNSde7roGRy16AlVcNRyibLAQNSOnu+SZ9lZyFFBMzGM
	xq15Z8d483e2G3ZJTgMUKWA==
X-Google-Smtp-Source: AGHT+IHKV1aaXGeWrW0acEVO2zpsKeS9iOAKguINbKbDjBpEJdqSE+HZOWe+tVFPCJYy6aSPNPr9Zg==
X-Received: by 2002:a05:6000:156b:b0:397:3900:ef83 with SMTP id ffacd0b85a97d-3973900f0a4mr15899999f8f.32.1742285552144;
        Tue, 18 Mar 2025 01:12:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:eac1:f2d4:84a8:c5ff? ([2a01:e0a:3d9:2080:eac1:f2d4:84a8:c5ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318af0sm17456499f8f.73.2025.03.18.01.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 01:12:31 -0700 (PDT)
Message-ID: <74bf5ef4-3d55-417e-b365-94e234c5505f@linaro.org>
Date: Tue, 18 Mar 2025 09:12:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] drm/panel: simple: Add NLT NL13676BC25-03F panel
 entry
To: Antonin Godard <antonin.godard@bootlin.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250318-b4-add-nlt-nl13676bc25-03f-v1-0-67e0f8cf2e6f@bootlin.com>
 <20250318-b4-add-nlt-nl13676bc25-03f-v1-2-67e0f8cf2e6f@bootlin.com>
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
In-Reply-To: <20250318-b4-add-nlt-nl13676bc25-03f-v1-2-67e0f8cf2e6f@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/03/2025 08:58, Antonin Godard wrote:
> Add support for the NLT NL13676BC25-03F 15.6" LCD-TFT LVDS panel.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 9b2f128fd309..96e8569d97ca 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -3469,6 +3469,30 @@ static const struct panel_desc newhaven_nhd_43_480272ef_atxl = {
>   	.connector_type = DRM_MODE_CONNECTOR_DPI,
>   };
>   
> +static const struct drm_display_mode nlt_nl13676bc25_03f_mode = {
> +	.clock = 75400,
> +	.hdisplay = 1366,
> +	.hsync_start = 1366 + 14,
> +	.hsync_end = 1366 + 14 + 56,
> +	.htotal = 1366 + 14 + 56 + 64,
> +	.vdisplay = 768,
> +	.vsync_start = 768 + 1,
> +	.vsync_end = 768 + 1 + 3,
> +	.vtotal = 768 + 1 + 3 + 22,
> +};
> +
> +static const struct panel_desc nlt_nl13676bc25_03f = {
> +	.modes = &nlt_nl13676bc25_03f_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 363,
> +		.height = 215,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
>   static const struct display_timing nlt_nl192108ac18_02d_timing = {
>   	.pixelclock = { 130000000, 148350000, 163000000 },
>   	.hactive = { 1920, 1920, 1920 },
> @@ -5056,6 +5080,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "newhaven,nhd-4.3-480272ef-atxl",
>   		.data = &newhaven_nhd_43_480272ef_atxl,
> +	}, {
> +		.compatible = "nlt,nl13676bc25-03f",
> +		.data = &nlt_nl13676bc25_03f,
>   	}, {
>   		.compatible = "nlt,nl192108ac18-02d",
>   		.data = &nlt_nl192108ac18_02d,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

