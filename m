Return-Path: <linux-kernel+bounces-377565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A03C9AC09E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD491F25068
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3AF15533B;
	Wed, 23 Oct 2024 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OGOphGwd"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D9D14B942
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669655; cv=none; b=tYX5pkFoTGRJiito79cnDAgTZuRgLz9pvtoLDzwIJXGqHa9i+ofjsUGGZmQsVzP6yA+GHC2I1UAS8RzhkpJ+Ye4e1K8BKd0kJseRSxosJwVBkpyjS4FoomNT5VJ1fBa97XAfAnsE0RVvb+QBomknUCRMkgm8ytE8oGowhee70lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669655; c=relaxed/simple;
	bh=OPrpcQJDgs8gdfYvAvpq6/72ypK5w3kzZcbsYHZW0pc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tX1hxpoPSdN6VvPpcwNCRTr1EOA+tTFneL6kVyxzIEUUkRPZkyRczM1oBupgZxnMAqdgJZLr80fR9PTi6KDPD2zYi95UwM2CxdLz/FQExgSOKX1gNpu8RP5+A3wd46zVfOkOuDg2yawJfTf8TUh9GmTkgoqzfUeZh11AHcdur2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OGOphGwd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so4859527f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 00:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729669651; x=1730274451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8XhAOWkTQF179xXl3+TzBgUaXsW8j7rP9CkGj8YxbY=;
        b=OGOphGwdgTNyz2Pj9UxHW//hy/kKzVk7wdLr96TKzxvVuVVvbClsJgK3BHMXeE1KB+
         U1WY/76rM+BzSfKUmdBHuy8TZUyNmX7hB3eofGH2bq26stGX5+/gOgnBbptue2ZxRNZF
         f5j903eU/ymZBTgX0yN0fvM89SjZxV6h5/F2zMKMFZ5eDazZ9vDPJk/KdgaU1GQ3gESI
         e9TQNiy+ZPPgas8TX+4ugIV3NMINsIcRdExAWoky7xcbEeX4i8g9zRE9dgnl37Jao8uz
         J1CK/otZgTx5EHLV0qkp3qnsOl51s8B98POUTK0nX3AsyevvZO4XhNh6LTaW/y5WNyGl
         bNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729669651; x=1730274451;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K8XhAOWkTQF179xXl3+TzBgUaXsW8j7rP9CkGj8YxbY=;
        b=w1rh6NtMHjuzcaefmSMAleUK6709C9XHniWioT8UwYdGUmzulf82HhXoWqAVhrBX0m
         /GCEGFSz5j1doZxFVqstnJC7U0GYow1rqmtKzPFHQDt2clqYQazI+ihmoufS3rooPyH7
         FmkzAk0v/jTci3p166G9/KNoAnwu5oINjjyzdRZkotyh2oc1deU/00KsSxB+Ch0EoL5E
         6ysoEjPHD5PGJelOOcq2EUW5y5DWSh/KodOxTOXx8ak/xAdpKLTvkOoDskKDZ+xVZocX
         uIXq8WAPQAvDCpKeaLXbytW/GBWXZWDCrDoy2zPCQnAFwuyojuj3V92rUo1uI1bdh6qC
         GiWw==
X-Forwarded-Encrypted: i=1; AJvYcCUvmv38nO7whUAdjU0jFx8Ko9AKU37gMjc8BLFqAOf1jvecVwOp5GUf8Oh+qW2tDaGBPHVSYhCtb5/T6no=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDM/NpQycXsETN15HVIVJzBxaWjv/1bI6DgvHlVaSv+csJU5tx
	ppEE3fHy567f2Kd3NVi7WVJ9makfs+cQBs40PTXQPn/mreZiF3B950ytEPgrQnkKEdixmJTkFf3
	nKgg=
X-Google-Smtp-Source: AGHT+IHrNfw9ADOpxGliLZ7C+mOsswL0VnI/CNGntnXyg5z6Klcj4ICG0tqO2d6isSu/7Zxp24Ql1g==
X-Received: by 2002:a5d:4b50:0:b0:37d:4d31:e86c with SMTP id ffacd0b85a97d-37efcf794f6mr1102055f8f.44.1729669651254;
        Wed, 23 Oct 2024 00:47:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:f9e2:19d:5b22:8044? ([2a01:e0a:cad:2140:f9e2:19d:5b22:8044])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b943e4sm8313368f8f.75.2024.10.23.00.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 00:47:30 -0700 (PDT)
Message-ID: <631d3d25-84ee-4b52-9429-eda6f489ba00@linaro.org>
Date: Wed, 23 Oct 2024 09:47:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 5/5] drm/panel: samsung-s6e88a0-ams427ap24: Add flip
 option
To: Jakob Hauser <jahau@rocketmail.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1729630039.git.jahau@rocketmail.com>
 <57a8498440695218d095cb037a5dc818d6fe7355.1729630039.git.jahau@rocketmail.com>
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
In-Reply-To: <57a8498440695218d095cb037a5dc818d6fe7355.1729630039.git.jahau@rocketmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/10/2024 23:33, Jakob Hauser wrote:
> The way of implementing a flip option follows the existing
> panel-samsung-s6e8aa0.c [1][2][3].
> 
> The value to flip the screen is taken from a downstream kernel file of
> a similar but older panel [4]. The mipi clock [5] for the new panel
> samsung-s6e88a0-ams427ap24 matches 461 MHz and a hardware read-out of the
> 0xcb values corresponds to revision R01 of that older panel [6]. Although
> for samsung-s6e88a0-ams427ap24 that's in non-flipped state while in this
> older driver it seems to be the other way around. Further up there is a
> hint [7] basically saying for revision R01 to change the first word of the
> 0xcb command from 0x06 to 0x0e, which is actually setting BIT(3) of that
> word. This causes a horizontal flip.
> 
> [1] https://github.com/torvalds/linux/blob/v6.11/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c#L103
> [2] https://github.com/torvalds/linux/blob/v6.11/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c#L207-L211
> [3] https://github.com/torvalds/linux/blob/v6.11/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c#L954-L974
> [4] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/blob/lineage-15.1/drivers/video/msm/mipi_samsung_oled_video_qhd_pt-8930.c
> [5] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/blob/lineage-15.1/drivers/video/msm/mipi_samsung_oled_video_qhd_pt-8930.c#L2027-L2028
> [6] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/blob/lineage-15.1/drivers/video/msm/mipi_samsung_oled_video_qhd_pt-8930.c#L137-L151
> [7] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/blob/lineage-15.1/drivers/video/msm/mipi_samsung_oled_video_qhd_pt-8930.c#L66-L74
> 
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>   .../drm/panel/panel-samsung-s6e88a0-ams427ap24.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
> index 6e02b881434d..8372d0d307c8 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
> @@ -32,6 +32,7 @@ struct s6e88a0_ams427ap24 {
>   	struct mipi_dsi_device *dsi;
>   	struct regulator_bulk_data *supplies;
>   	struct gpio_desc *reset_gpio;
> +	bool flip_horizontal;
>   };
>   
>   const struct regulator_bulk_data s6e88a0_ams427ap24_supplies[] = {
> @@ -538,6 +539,10 @@ static int s6e88a0_ams427ap24_on(struct s6e88a0_ams427ap24 *ctx)
>   	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcc, 0x4c);
>   	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf2, 0x03, 0x0d);
>   	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf1, 0xa5, 0xa5);
> +
> +	if (ctx->flip_horizontal)
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcb, 0x0e);
> +
>   	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0xa5, 0xa5);
>   	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfc, 0xa5, 0xa5);
>   
> @@ -672,6 +677,15 @@ static int s6e88a0_ams427ap24_register_backlight(struct s6e88a0_ams427ap24 *ctx)
>   	return ret;
>   }
>   
> +static void s6e88a0_ams427ap24_parse_dt(struct s6e88a0_ams427ap24 *ctx)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	struct device *dev = &dsi->dev;
> +	struct device_node *np = dev->of_node;
> +
> +	ctx->flip_horizontal = of_property_read_bool(np, "flip-horizontal");


Please use device_property_read_bool() instead

> +}
> +
>   static int s6e88a0_ams427ap24_probe(struct mipi_dsi_device *dsi)
>   {
>   	struct device *dev = &dsi->dev;
> @@ -706,6 +720,8 @@ static int s6e88a0_ams427ap24_probe(struct mipi_dsi_device *dsi)
>   		       DRM_MODE_CONNECTOR_DSI);
>   	ctx->panel.prepare_prev_first = true;
>   
> +	s6e88a0_ams427ap24_parse_dt(ctx);

I don't think this deserves a separate function, just move it probe.

> +
>   	ret = s6e88a0_ams427ap24_register_backlight(ctx);
>   	if (ret < 0)
>   		return ret;

With that changed:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

