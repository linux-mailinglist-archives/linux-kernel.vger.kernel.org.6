Return-Path: <linux-kernel+bounces-327847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8DF977BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFFB81F25393
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81D21D67B6;
	Fri, 13 Sep 2024 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rOflMN53"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A91BFE12
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218502; cv=none; b=szXyA6xaIOzChkLOpw3N3NYxN3nGNRJzjAN5lBFniAwLS/cW4aE3VCfzaMbBedEKf4t8ohYMHPmsy/ohjXoTbS6u3wp5P0gP/56fowO9nmQGgSTN/57+oAV6m5HuZsyhgZXa0aQpJtSyLuSkDv7YdIdfyCC8awLnu1o29PUr3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218502; c=relaxed/simple;
	bh=ADmffFBlEMxTWSLPIGi37/nIJO0ggvUJmLWimGaW4Qo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KMrUN0OAbjd8wfKKVMjGPeWGNJ1Pj/lcOWSe6VsFqGFvRdF5icCocwdyGFIg7Q34c0B3fVnSljptZ1GlmfUoKbbCDXkhoA1s7G6HYTFusa+RGRojClSV6lFyAH30cPNgEzbwaTlS+O3WCLrEojIUzEe4F7rwNPqD53WRG/xpDUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rOflMN53; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso17273755e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726218499; x=1726823299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zXx0z+xH+ztolGxVZqnELYkWb3KijRHRTYHi+pwjgg=;
        b=rOflMN53H4RPfa1hjxPNzKuQvXmW/XnUbQWrbkbibduFjfjYq6KLIFbATRcp87E0bb
         vRltJjxEHlVR1bh155xeC337OCyvX4zSe7IOtqyJjtuLn+27WHNJ+tNN2+m8g+2ZvMy0
         5KcXJovwUgulhpW1eu49aGWMWOcVs8B4lkhGp2nYGec+5HZjTIVnX0vlYRXKg3QWCXzS
         lAQ8GzncdNRnvYv91To9lmBXqq9Yzg/zhwK9wgZ4OyOaSLCAgfmetmATW5B0hAC0fum0
         K5alJC2aLF8r8xW8C3wRp1mt/BB8UectytKfJxw66QRe2OYGjvPghuYCal3ApqL0SfW5
         J6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726218499; x=1726823299;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2zXx0z+xH+ztolGxVZqnELYkWb3KijRHRTYHi+pwjgg=;
        b=BPS5zcCjhSRpb/kavZqoEmTCYu71MNtyfMg2Rt/WJ7ENIPjnlSQpCNVzuVr5g7zkn4
         EB+flWkI+CNQpV8gUSoR9hch6VRWEXNMMijEgnnueEStB/ZLRKsiPlJF6FQC4oTvX5tt
         02s/mcO6MyputZPdnc7Ele9q9FLa29tv7Y75DDlFiLt/LI4xbMz+Ta6T7pPhE5vcd907
         3S4RpWcvwgfoBX82FrYjGRQ/rwfs8QV+b96eyJ80/3uAZCGL5BfaQIIvBGdDkXqgB+fu
         LzNCiNTR/lpc3KNrkkkw73aKpXlcMJSaP8SdlxUEARI4awnDUSPt7nsQja0fMEQoqioH
         cYVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOoc4SjDrDJPmPSkd1nHUauRobjCcw4Mmpv7uTNfAnxYlwckJsmpLct335WYrqryumF7wJDkFgMW/4nuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEgB5J/Zeq2os0bJSPFoUx+DLCnjrV7u8vbr/MXf5ZOrhxYIPL
	kh1e/PfKSqAR2LdgNTvh3YIGXXbPeAsAMY7sURfOhfhfBpTOJl+atsG6NkZLpkA=
X-Google-Smtp-Source: AGHT+IHzdj8Qdeqcflbe7N/Vxy3Vcy9D7hn8FJ/UrFypGxQko7JmlxIesFhGpEOKh4a8XIeaKuTKZw==
X-Received: by 2002:a05:600c:3108:b0:42c:be90:fa2f with SMTP id 5b1f17b1804b1-42cdb5662bfmr49050235e9.25.1726218498820;
        Fri, 13 Sep 2024 02:08:18 -0700 (PDT)
Received: from [192.168.7.202] ([212.114.21.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05d5dbsm17380175e9.13.2024.09.13.02.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 02:08:18 -0700 (PDT)
Message-ID: <d9ef7158-5cf9-49a2-96b3-c2b91b23e210@linaro.org>
Date: Fri, 13 Sep 2024 11:08:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: raydium-rm69380: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc: quic_jesszhan@quicinc.com, dianders@chromium.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240907140130.410349-1-tejasvipin76@gmail.com>
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
In-Reply-To: <20240907140130.410349-1-tejasvipin76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
On 07/09/2024 16:01, Tejas Vipin wrote:
> Changes the raydium-rm69380 panel to use multi style functions for
> improved error handling.
> 
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-raydium-rm69380.c | 95 ++++++-------------
>   1 file changed, 30 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm69380.c b/drivers/gpu/drm/panel/panel-raydium-rm69380.c
> index 4dca6802faef..bdab844dab55 100644
> --- a/drivers/gpu/drm/panel/panel-raydium-rm69380.c
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm69380.c
> @@ -46,108 +46,73 @@ static void rm69380_reset(struct rm69380_panel *ctx)
>   static int rm69380_on(struct rm69380_panel *ctx)
>   {
>   	struct mipi_dsi_device *dsi = ctx->dsi[0];
> -	struct device *dev = &dsi->dev;
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   
>   	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>   	if (ctx->dsi[1])
>   		ctx->dsi[1]->mode_flags |= MIPI_DSI_MODE_LPM;
>   
> -	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0xd4);
> -	mipi_dsi_dcs_write_seq(dsi, 0x00, 0x80);
> -	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0xd0);
> -	mipi_dsi_dcs_write_seq(dsi, 0x48, 0x00);
> -	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0x26);
> -	mipi_dsi_dcs_write_seq(dsi, 0x75, 0x3f);
> -	mipi_dsi_dcs_write_seq(dsi, 0x1d, 0x1a);
> -	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0x00);
> -	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x28);
> -	mipi_dsi_dcs_write_seq(dsi, 0xc2, 0x08);
> -
> -	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to set tear on: %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
> -		return ret;
> -	}
> -	msleep(20);
> -
> -	ret = mipi_dsi_dcs_set_display_on(dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to set display on: %d\n", ret);
> -		return ret;
> -	}
> -	msleep(36);
> -
> -	return 0;
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0xd4);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x80);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0xd0);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x26);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x3f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x1a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc2, 0x08);
> +
> +	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 36);
> +
> +	return dsi_ctx.accum_err;
>   }
>   
> -static int rm69380_off(struct rm69380_panel *ctx)
> +static void rm69380_off(struct rm69380_panel *ctx)
>   {
>   	struct mipi_dsi_device *dsi = ctx->dsi[0];
> -	struct device *dev = &dsi->dev;
> -	int ret;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   
>   	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>   	if (ctx->dsi[1])
>   		ctx->dsi[1]->mode_flags &= ~MIPI_DSI_MODE_LPM;
>   
> -	ret = mipi_dsi_dcs_set_display_off(dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to set display off: %d\n", ret);
> -		return ret;
> -	}
> -	msleep(35);
> -
> -	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
> -		return ret;
> -	}
> -	msleep(20);
> -
> -	return 0;
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 35);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 20);
>   }
>   
>   static int rm69380_prepare(struct drm_panel *panel)
>   {
>   	struct rm69380_panel *ctx = to_rm69380_panel(panel);
> -	struct device *dev = &ctx->dsi[0]->dev;
>   	int ret;
>   
>   	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return ret;	
>   
>   	rm69380_reset(ctx);
>   
>   	ret = rm69380_on(ctx);
>   	if (ret < 0) {
> -		dev_err(dev, "Failed to initialize panel: %d\n", ret);
>   		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>   		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> -		return ret;
>   	}
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int rm69380_unprepare(struct drm_panel *panel)
>   {
>   	struct rm69380_panel *ctx = to_rm69380_panel(panel);
> -	struct device *dev = &ctx->dsi[0]->dev;
> -	int ret;
>   
> -	ret = rm69380_off(ctx);
> -	if (ret < 0)
> -		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
> +	rm69380_off(ctx);
>   
>   	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>   	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);

I get:
-:129: ERROR:TRAILING_WHITESPACE: trailing whitespace
#129: FILE: drivers/gpu/drm/panel/panel-raydium-rm69380.c:97:
+^Iif (ret < 0) $

-:130: ERROR:TRAILING_WHITESPACE: trailing whitespace
#130: FILE: drivers/gpu/drm/panel/panel-raydium-rm69380.c:98:
+^I^Ireturn ret;^I$

could you fix those ?

Thanks,
Neil


