Return-Path: <linux-kernel+bounces-292392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F89956EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0673B1C22B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A385C62171;
	Mon, 19 Aug 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FpndBch7"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D09335BA
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081781; cv=none; b=WhSvT35uahu1KVGoASeXAd5yYcRpiFEKurIMIfaYNSXmzuVWgJIGBMM57emi7w+PdpFweSBocMsDWw4S4ihogyHLQO7XmdPRhZdOx1pQ4jQNPhLNLyQfD/PX+hDpppFDjD3tapS8cKUBJDilRitnqo/0e4sqj2cBcmS/f7hx29o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081781; c=relaxed/simple;
	bh=ApHpdw8Uh2ZeeKtv730Wg2a9SocEFpUss/Mh2UHGZ7o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ny+YCGFN6dDj47mYR4K7EauofssTkrT1+asNCRo3S95HMpbd/9n4ZyCg2a34X8DZf0hX3E90mSJ2gMn+RmWLkMy9MFuHlwQBe2NrT5FSJmN7vck9LMzgmDUu/GiaWAkJEKeIy/idoBFINgRnCJ79TzHq2H/iePSJ2HOW05y1t6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FpndBch7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so34661055e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724081778; x=1724686578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zaj59aKVrAtowXfAlcri02aQYdNUrJ98uxFca+ipLVk=;
        b=FpndBch70QQBptHBQzhLnhnDGz315kRnIL45ZmfxpbKvzQ/h1PDsDPo0rYznrwt/NM
         lAhalFrKhhmVgt6dLfBrwhgyF2V24T08li/24BD12F2bHELMVAzjbjwDBAFOr85SBryP
         gbCEnEq5XzaiOnjKR35Kl+bi1XJQdvEtIoYMotxP0ePtFUNINqp+OZIyTQaj4t65MVMs
         bakZe2GvEZoi6zZZBqavVve7cawCfjNQL1iiQ39whuxGzar1YLapmZJektvTKkQcZ6dZ
         Db7+hPEt/tHBPhDHfmBd0Yp446G237eIlxokmfZKagUtiH1nxq9LiwsOEkL9SznClek1
         KJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724081778; x=1724686578;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zaj59aKVrAtowXfAlcri02aQYdNUrJ98uxFca+ipLVk=;
        b=b7KTbnXU7BkS10/qajcjAV8ThWT8uRcsb+5F5RrXqARh9ZXk9LoeYRF2+X4ZyCtE5p
         sId+zM5OAGDKzRvwh5hf+97gGrAy9Z1L1o+gs3PtqyMkXlQFQP7gRREvoVwuf6HdPp0W
         iwd6Ak6hFXDmglhwAEmMzqODMktutV8t/SvXoqJgKFSH1i1QgMzYjmq0u84v6b4XBDOa
         MghSZmzrIxPN7Phxi0bQ/6p1B5mledd3D2Byl9624x1qE2UnRZjOn/nb131Fwhbp/p9N
         9H1TlIiZo6yMQgEf24g+U+IQH7BLW6adBFI2TPzTxK9YVZsMAPKzN1z1IAPgS6bmN1zt
         cOEA==
X-Forwarded-Encrypted: i=1; AJvYcCX4uzMTsG0PXiupUItHyG0tmR8UX95PxHQkpUxSQMlIg392xuzEtNY8YaAAHEjKOb1yEHQg14gt+cGtiCSxiE1VpDB1uneOdReceOH+
X-Gm-Message-State: AOJu0YyboPYnl1DFYqal1mC7C9ph881kC+ZYdJ4C9xH7bhJ1ekj4QyZz
	6Bzj+L+pFiyfaaSQK9X+BsaEtvsYX5QT7bgAZrBdWqQ86pvWqULeGZUnITi86c4=
X-Google-Smtp-Source: AGHT+IHIIiLXfwadBpfqfQEoziKcvHPzTsUe1RZgWRiLWLfv1Xy/IHTASLKF6VG4I94sfleVZcYjQA==
X-Received: by 2002:a05:600c:4f96:b0:426:686f:cb4c with SMTP id 5b1f17b1804b1-429ed7db8eemr70822855e9.32.1724081777634;
        Mon, 19 Aug 2024 08:36:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed79be15sm113319105e9.48.2024.08.19.08.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 08:36:17 -0700 (PDT)
Message-ID: <4be2f1d1-534c-4c99-a35e-f354c75c88b4@linaro.org>
Date: Mon, 19 Aug 2024 17:36:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: mantix-mlaf057we51: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>, agx@sigxcpu.org, kernel@puri.sm
Cc: dianders@chromium.org, quic_jesszhan@quicinc.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240818072356.870465-1-tejasvipin76@gmail.com>
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
In-Reply-To: <20240818072356.870465-1-tejasvipin76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 18/08/2024 09:23, Tejas Vipin wrote:
> Changes the mantix-mlaf057we51 panel to use multi style functions for
> improved error handling.
> 
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>   .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 79 +++++++------------
>   1 file changed, 27 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> index ea4a6bf6d35b..4db852ffb0f6 100644
> --- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> +++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> @@ -23,7 +23,7 @@
>   
>   /* Manufacturer specific Commands send via DSI */
>   #define MANTIX_CMD_OTP_STOP_RELOAD_MIPI 0x41
> -#define MANTIX_CMD_INT_CANCEL           0x4C
> +#define MANTIX_CMD_INT_CANCEL           0x4c

Please move cleanups to separate patches


Otherwise it looks good.

Neil

>   #define MANTIX_CMD_SPI_FINISH           0x90
>   
>   struct mantix {
> @@ -45,82 +45,57 @@ static inline struct mantix *panel_to_mantix(struct drm_panel *panel)
>   	return container_of(panel, struct mantix, panel);
>   }
>   
> -static int mantix_init_sequence(struct mantix *ctx)
> +static void mantix_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
>   {
> -	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> -	struct device *dev = ctx->dev;
> -
>   	/*
>   	 * Init sequence was supplied by the panel vendor.
>   	 */
> -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
> -
> -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_INT_CANCEL, 0x03);
> -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
> -	mipi_dsi_generic_write_seq(dsi, 0x80, 0xA9, 0x00);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5a);
>   
> -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
> -	mipi_dsi_generic_write_seq(dsi, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
> -	msleep(20);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_INT_CANCEL, 0x03);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5a, 0x03);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x80, 0xa9, 0x00);
>   
> -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_SPI_FINISH, 0xA5);
> -	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
> -	msleep(20);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5a, 0x09);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
> +	mipi_dsi_msleep(dsi_ctx, 20);
>   
> -	dev_dbg(dev, "Panel init sequence done\n");
> -	return 0;
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_SPI_FINISH, 0xa5);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2f);
> +	mipi_dsi_msleep(dsi_ctx, 20);
>   }
>   
>   static int mantix_enable(struct drm_panel *panel)
>   {
>   	struct mantix *ctx = panel_to_mantix(panel);
> -	struct device *dev = ctx->dev;
> -	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
> -	int ret;
> +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   
> -	ret = mantix_init_sequence(ctx);
> -	if (ret < 0) {
> -		dev_err(ctx->dev, "Panel init sequence failed: %d\n", ret);
> -		return ret;
> -	}
> +	mantix_init_sequence(&dsi_ctx);
> +	if (!dsi_ctx.accum_err)
> +		dev_dbg(ctx->dev, "Panel init sequence done\n");
>   
> -	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to exit sleep mode\n");
> -		return ret;
> -	}
> -	msleep(20);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 20);
>   
> -	ret = mipi_dsi_dcs_set_display_on(dsi);
> -	if (ret)
> -		return ret;
> -	usleep_range(10000, 12000);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	mipi_dsi_usleep_range(&dsi_ctx, 10000, 12000);
>   
> -	ret = mipi_dsi_turn_on_peripheral(dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to turn on peripheral\n");
> -		return ret;
> -	}
> +	mipi_dsi_turn_on_peripheral_multi(&dsi_ctx);
>   
> -	return 0;
> +	return dsi_ctx.accum_err;
>   }
>   
>   static int mantix_disable(struct drm_panel *panel)
>   {
>   	struct mantix *ctx = panel_to_mantix(panel);
>   	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> -	int ret;
> -
> -	ret = mipi_dsi_dcs_set_display_off(dsi);
> -	if (ret < 0)
> -		dev_err(ctx->dev, "Failed to turn off the display: %d\n", ret);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>   
> -	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
> -	if (ret < 0)
> -		dev_err(ctx->dev, "Failed to enter sleep mode: %d\n", ret);
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>   
> -
> -	return 0;
> +	return dsi_ctx.accum_err;
>   }
>   
>   static int mantix_unprepare(struct drm_panel *panel)


