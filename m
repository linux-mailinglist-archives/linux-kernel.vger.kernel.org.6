Return-Path: <linux-kernel+bounces-231224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 763879187D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0610C1F2424B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF6A18FDB6;
	Wed, 26 Jun 2024 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UoHKy0Xc"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E7C18FDA0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420429; cv=none; b=pjG9/FRlT2ztlZnBQXQcEdHKGBFAzsZJyq7KL0t9gea0EJS0bmI769GsczYkotIBqrEyg/Alir4yUJnja6SkZmrzSPPiYuvGBy+rKopuSbcut61BJOVO3XUoydGbRRlA2xmTtJ7H1ZbqOhKP2VAk4jLOv3bb4aSw9F/YZtu9m98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420429; c=relaxed/simple;
	bh=PtRln3VNEbo/QVYCyG7L0nga+BUAFV7KcVhAmv8taAU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ljascTJwkb4uwNkZV/lVSBSxSMiJEKVRsJFqPJYIF1qs9/DKjeJA3KyLp1w5KgG394OLXYaY2aZx0M/2rorGjwYUd6nss603y2GTvQc3BcbscWaRqe1LjR94AUA5NY0sO2Rl/yn79ePjo6u5us46fISoWZBGWbWtggfqO7XKZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UoHKy0Xc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42138eadf64so58516955e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719420426; x=1720025226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQ47MbuUx0dEKfjEl8GDLGs6KgvQiYQD2Cb7FQPs7PE=;
        b=UoHKy0Xcs/PKGXCsfKggL1qOrDj7tPgqiOSWT+uAp6u3/3VfsVEsG/jBOb89Va+OST
         WvcHvmT+px8kO0PtAuSppoDVvbo7Yw3b2ltshKk+qJlEbNfIzYUN76RbYdCLcr/FKpLW
         LASOTzupm1d6N6tPph0FAk1JopWUtYTw4Y6oWtnemdsALNMb3cK/K6ZMrY/gFhyWUTE3
         MqA2c9TUAfMHGeaqecW9YNTHNR/pO44hII6+uRjZgI0blZ+MBbO4dSzBCFzI83Gewseu
         /W92dzqizpqbPPCmgv2fGgsnS4ePC+wOSXh5EyzHV0DuKeZBBT6D0y5eD9soHirla23q
         blWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719420426; x=1720025226;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PQ47MbuUx0dEKfjEl8GDLGs6KgvQiYQD2Cb7FQPs7PE=;
        b=ONkKNAoEblGJVFJo3grRkRDpT6QTbAk3X0A65cUFesAXIxHUwAkgdOTefjRP8ivlkY
         RXE5uMozxRrDHoHQUnPmp5B9FRPB2t0+V3eyScuhvVgDnYykJqb9XrRg9RZFLt52YU5E
         XrHFyMksAgfdpSsknb0/mEzSSn8xYkrKpUENZ44JYxFN6/taLkiFgc9lcvHvHcdsW9Y8
         AhQqFPQ71FIxZs2NW+QI9AsnOIJgI6oLh5MI/TTQDrtaZXqQdOe5J/xuqYTt6cIXn0bP
         cLWZeiquDWFzTAUOdGF7rbdw2JX7tdhvwX1RTnkZxGsWD8cuujZ+wCtzuTQDPf1NKFgL
         10RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlQcO5ROApd3yIp4b92gZcT+1R36M5eJucTMVI6t+6WzRayyR4RgRpKqioLLtFZdgOCyW9eVzH/GMtVkoOQ29mcrZuAjClgJa879Xr
X-Gm-Message-State: AOJu0Ywl0L+u4H4RNcY3x0Un8aZ1StXGC2DrEE5Cb031OocXjJGMMlha
	4ENw3eQc4ysUeCqB3Tk9ysl9B0zxgVtT8N/Jv81GTd7z32HSVBmfNW+Zp8eaEvw=
X-Google-Smtp-Source: AGHT+IF1G4ppNAwlIQGAbXhmDWVW7CfOSZ2zvCiAO6m8fif6znqmr/9U1Pxwmn3KziI0rWrginGV3Q==
X-Received: by 2002:a05:600c:450d:b0:421:7198:3d76 with SMTP id 5b1f17b1804b1-4248cc58b99mr70054445e9.28.1719420425262;
        Wed, 26 Jun 2024 09:47:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:afc0:84d8:433a:2d67? ([2a01:e0a:982:cbb0:afc0:84d8:433a:2d67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424a2abc265sm40329445e9.1.2024.06.26.09.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 09:47:04 -0700 (PDT)
Message-ID: <0d9666a6-df2d-401c-91c3-a939af1119ab@linaro.org>
Date: Wed, 26 Jun 2024 18:47:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] drm/panel: simple: Add AUO G104STN01 panel entry
To: Paul Gerber <paul.gerber@ew.tq-group.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240626044727.2330191-1-paul.gerber@ew.tq-group.com>
 <20240626044727.2330191-3-paul.gerber@ew.tq-group.com>
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
In-Reply-To: <20240626044727.2330191-3-paul.gerber@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/06/2024 06:36, Paul Gerber wrote:
> Add support for the AUO G104STN01 10.4" (800x600) LCD-TFT panel.
> 
> Signed-off-by: Paul Gerber <paul.gerber@ew.tq-group.com>
> ---
> Tested on TQ MBa8MPxL with TQMa8MPxL.
> 
>   drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index dcb6d0b6ced0..5eacd2085a53 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1081,6 +1081,30 @@ static const struct panel_desc auo_g104sn02 = {
>   	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>   };
>   
> +static const struct drm_display_mode auo_g104stn01_mode = {
> +	.clock = 40000,
> +	.hdisplay = 800,
> +	.hsync_start = 800 + 40,
> +	.hsync_end = 800 + 40 + 88,
> +	.htotal = 800 + 40 + 88 + 128,
> +	.vdisplay = 600,
> +	.vsync_start = 600 + 1,
> +	.vsync_end = 600 + 1 + 23,
> +	.vtotal = 600 + 1 + 23 + 4,
> +};
> +
> +static const struct panel_desc auo_g104stn01 = {
> +	.modes = &auo_g104stn01_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 211,
> +		.height = 158,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
>   static const struct display_timing auo_g121ean01_timing = {
>   	.pixelclock = { 60000000, 74400000, 90000000 },
>   	.hactive = { 1280, 1280, 1280 },
> @@ -4434,6 +4458,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "auo,g104sn02",
>   		.data = &auo_g104sn02,
> +	}, {
> +		.compatible = "auo,g104stn01",
> +		.data = &auo_g104stn01,
>   	}, {
>   		.compatible = "auo,g121ean01",
>   		.data = &auo_g121ean01,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

