Return-Path: <linux-kernel+bounces-344242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A3F98A761
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20DD71C222C0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F751917E7;
	Mon, 30 Sep 2024 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IBfuJy1d"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF4E23D2
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707100; cv=none; b=uRWwRJCRhOzT9q+ghMZyQyr4pNmlmlwgUk05cktUc9ruStXYEnJQG/z+DEuA4z+N/cHq3xPKUu0lNbf3Ywc83w+3PT2H8ejWKUFgxsjmc74IzL+pi0DW8k8t4CUuxtsfKo9nw0GJdLNWAVNYL+3Rvwh+a69lsQx1l72FZNAtRGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707100; c=relaxed/simple;
	bh=lErkgam4Jv9RcnTAV5+5kTCnVvVpam3Gx8B70UhRyEI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L+pXtVQ3kkKCTDEtxoZQcbLz8HBqeR1gLdv3T/J1oubqoBERWD/ERfx15+b6GCBEkHroWkgDo+JnvazmUEIdikS/3R/raC6NcUInbIJUi3miLoyCpdBXzfkIrdFlv9R/1J01uT48nLosaybb4PMyEoc96DV2xMnx1omtxY6gH1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IBfuJy1d; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cba8340beso32507045e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727707096; x=1728311896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3mI5dB75SO68Jn6asF4H/I2WXinZvmksU+fwa/IMDg=;
        b=IBfuJy1dM6nFI4gLqKTlnC0HFervw3KhMHMKDsmpHYDWVFsAgyPFEFygN4Q8TBaTGr
         Bjo16sGPxUaEFiewmZp6IymsQ5TkIbNBiQSWlj1SLzzLMNyB/9qiSuXFyUnF4x0GKsfe
         YU6mhvo96/Renzx7UEfRMv3XtKbpfijUkiLk4hpNeRnEpEnQJoGev1eea41x3U58dmZD
         JmHE/y3e/4zQofEYq86iluYSuScROT0IqyUBbKyyN4CyIdm2x2ZpuaWHykdpz0wE9fh4
         iSU44IU8d/rBoJo9rK83DVo/je+sNLDkl184tNTsKbbTx9t+W83SQI9GEDL3gGciFOWk
         JVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727707096; x=1728311896;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H3mI5dB75SO68Jn6asF4H/I2WXinZvmksU+fwa/IMDg=;
        b=Ibda4OOPHjJp2jA+C4Di4KZV1wJEYfUAxzKee0KTzxNaAr85mVJH+LXR/aZ5vDBedG
         XISk8C3FsbzdnXJ1LShKJ1hoL6C+YPrL8TSm5u4UaglM2MRplMJu9UFiohlpZuY04mP3
         jqPApEXJ6U1wQls/vJej/Y3AqWG2J72JrwmJSnAHp0JZrNn/+ONucWlT2GqlQz7g4P0q
         5hBk1VUgozPwJN8qF8pltA+0Jcs6M7M5zr5/bvQOeKELH3QoJ4heR3v2vKK6/HuHqWp+
         Ont8gSw6QkHshXqvCTxrdKQ/QkcRWKodcTWhSKWJScbG9SUILolErmyRBPCgXz4/VyxZ
         hwFA==
X-Forwarded-Encrypted: i=1; AJvYcCUAY5K5femSZqayCmaTT2sW47MfezCvrTe5ukF2CPkZc3JuYO7vMdwjqJpn+v5XLeQM4V3Y8wbPIxleI/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV5mqSiwIPcARmrEmYMouXAsUlYgSPJcLa4lZhKWrtkoQAY/uV
	qjxk5AANNylHeOql8Zd7MBnA2FLgzwO0ap35ENXuy4hdqEqvVe5FXjc6tixbYjM=
X-Google-Smtp-Source: AGHT+IEQejxm2lOjD94nZqskrcmlhUy/oMikZQ2iiyMaR7X17z5UywH9YLDg3WoiRnHVVWTlE/aKiA==
X-Received: by 2002:a5d:5b91:0:b0:374:c7cd:8818 with SMTP id ffacd0b85a97d-37ccdb576e8mr8822405f8f.22.1727707096496;
        Mon, 30 Sep 2024 07:38:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:bdc6:abc9:5047:7828? ([2a01:e0a:982:cbb0:bdc6:abc9:5047:7828])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969a48fasm152590745e9.0.2024.09.30.07.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 07:38:16 -0700 (PDT)
Message-ID: <f9b0cc53-00ae-4390-9ff9-1dac0c0804ba@linaro.org>
Date: Mon, 30 Sep 2024 16:38:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm: panel: jd9365da-h3: fix reset signal polarity
To: Hugo Villeneuve <hugo@hugovil.com>, Jagan Teki <jagan@edgeble.ai>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240927135306.857617-1-hugo@hugovil.com>
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
In-Reply-To: <20240927135306.857617-1-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 27/09/2024 15:53, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> In jadard_prepare() a reset pulse is generated with the following
> statements (delays ommited for clarity):
> 
>      gpiod_set_value(jadard->reset, 1); --> Deassert reset
>      gpiod_set_value(jadard->reset, 0); --> Assert reset for 10ms
>      gpiod_set_value(jadard->reset, 1); --> Deassert reset
> 
> However, specifying second argument of "0" to gpiod_set_value() means to
> deassert the GPIO, and "1" means to assert it. If the reset signal is
> defined as GPIO_ACTIVE_LOW in the DTS, the above statements will
> incorrectly generate the reset pulse (inverted) and leave it asserted
> (LOW) at the end of jadard_prepare().

Did you check the polarity in DTS of _all_ users of this driver ?

Neil

> 
> Fix reset behavior by inverting gpiod_set_value() second argument
> in jadard_prepare(). Also modify second argument to devm_gpiod_get()
> in jadard_dsi_probe() to assert the reset when probing.
> 
> Do not modify it in jadard_unprepare() as it is already properly
> asserted with "1", which seems to be the intended behavior.
> 
> Fixes: 6b818c533dd8 ("drm: panel: Add Jadard JD9365DA-H3 DSI panel")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>   drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index 44897e5218a69..6fec99cf4d935 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -110,13 +110,13 @@ static int jadard_prepare(struct drm_panel *panel)
>   	if (jadard->desc->lp11_to_reset_delay_ms)
>   		msleep(jadard->desc->lp11_to_reset_delay_ms);
>   
> -	gpiod_set_value(jadard->reset, 1);
> +	gpiod_set_value(jadard->reset, 0);
>   	msleep(5);
>   
> -	gpiod_set_value(jadard->reset, 0);
> +	gpiod_set_value(jadard->reset, 1);
>   	msleep(10);
>   
> -	gpiod_set_value(jadard->reset, 1);
> +	gpiod_set_value(jadard->reset, 0);
>   	msleep(130);
>   
>   	ret = jadard->desc->init(jadard);
> @@ -1131,7 +1131,7 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
>   	dsi->format = desc->format;
>   	dsi->lanes = desc->lanes;
>   
> -	jadard->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	jadard->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>   	if (IS_ERR(jadard->reset)) {
>   		DRM_DEV_ERROR(&dsi->dev, "failed to get our reset GPIO\n");
>   		return PTR_ERR(jadard->reset);
> 
> base-commit: 18ba6034468e7949a9e2c2cf28e2e123b4fe7a50


