Return-Path: <linux-kernel+bounces-245981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF1E92BC47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35AC41F21467
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D518A920;
	Tue,  9 Jul 2024 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mr/fJN+B"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A491891D4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533523; cv=none; b=N/9GKzrt2EZmHaNm2AX7Js4TfCTofcxCjD70Edc1lZ0ZOE23voQ3HyA4645PrJrwl7tsJ4sJbOvi/SfycLKmNl/k+EGb4G5KxbZ2vh1Lz0/4/DMejI6HAOcx6mxeg+h4/HzLDbbqOmCAUk0GJaKFW2yIPVbYojWbiXo0VinHWos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533523; c=relaxed/simple;
	bh=p9juMapk/QWgrmjmfAore46BaTdoCfxFIuht+7d18c4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QSFDo7KIM2VN5TjM9plW4bbEvn5tpDTDFKs9ZFjgATYnTVm6oMNaNAKijrmJSEikiYEejXhcTtrjGXEm6JYsOjmmm6jKzk1LhU6na6fPuj2P43rfY9IeF+Eg+Tt3lr08qbceLJJU6Kf2FIl9NJuelxJRqP3xAYfF+AuBRFOgij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mr/fJN+B; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so8674995e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720533519; x=1721138319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ed/fh1E3VNO+q88LbS9wR2hkBk1Z8PAuK1Ldw5laCyM=;
        b=mr/fJN+BOOtECTz6O3s9oxZfsuRQw2z+qD3xvihAqxGF9CUKkyWM8FN70FqkU6474i
         qfPVOr3hJxdvRJ3kEJFWS3E9pnBQUpvMMh+L+LfPC+4xTFVuyKjtDhQQWVnJovcVgJv2
         ogKlxD3qxLhgjvPKbseQPHHDv95RHWfom/QHv374yeDeL5jbe1M5n2i2n3kOoiH45mny
         FhjoT6aIbv61Rqgx75nP6nZVK3ikzXCVIWg9wpY90SMEnt2/Wb7SaF79PlXq0qliAHS9
         yabKzqKMJ57YLASAVtLrSWjXmz/ZyXUlRxHGielEKSMup9V7QMj33GkDKriJ5NGXPu1U
         0omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720533519; x=1721138319;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ed/fh1E3VNO+q88LbS9wR2hkBk1Z8PAuK1Ldw5laCyM=;
        b=jkwoMA4pdaMsD2IuOSKynhqeh5gDgIqk3MhzaNx/1xzUEG8qnS+HNJS5CF4iYs3jEp
         eAm6c6q5zQEUHwNXxNVgYq6SkkxaXlW8J00Gmd5xSKQoXdgmbTOBa82Cuamwl5LTp/hz
         dXVsBSPtkDf0Q4vh2i2VaUy3i3a6VHYJpv0F/Fk6w3HNyIrm2dlSGCBNSDYwu3xgS0Jh
         65XeVXn/FVXMY1buhTF2T9D4v8Y2kTSY7+/9EgANypGJka030c2PJJdDqa8VjroqpsTg
         GVYY4G7IAhOvau3H0I2bFO94aF++o9V/b8RmK2FY9LEXIv8M4zR86HIjMnDDPTNRln+m
         4StQ==
X-Forwarded-Encrypted: i=1; AJvYcCXimDcdE7bw+mkFbxHcBuV6jq2f5x07wIIbwovRtvw4VJDtViqLcuM82+2eW4RlLbSL0mAyaMuRZHcAzlCyjbCt4I2t+huOT9IZ185Z
X-Gm-Message-State: AOJu0YyRS3Mwxw2laIrwohX7XsBR3hGpHTaFt+dDsHspO11J47BnjkJz
	ktR+9ncSR4E6wlRUYrsnWgxINE+s86JDRLUAouB4bMsSZpiZ4o8BA/jQBs7UKCE=
X-Google-Smtp-Source: AGHT+IEn6g0kQaJutWy2n9A0W7aMDfy+AgDiqyTj7OLL+GtMxCyqRqGNLxWyS0FDgFjJCkRzk2cHjg==
X-Received: by 2002:a05:600c:434a:b0:426:64f4:7793 with SMTP id 5b1f17b1804b1-426707e1f71mr18526535e9.22.1720533519105;
        Tue, 09 Jul 2024 06:58:39 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:133f:fb1b:7fc5:f63a:ac6f:62c6? ([2a0d:e487:133f:fb1b:7fc5:f63a:ac6f:62c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f7362d9sm41347955e9.30.2024.07.09.06.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 06:58:38 -0700 (PDT)
Message-ID: <3820811a-f931-4bb7-a707-74405efd86ad@linaro.org>
Date: Tue, 9 Jul 2024 15:58:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v6 1/5] drm/panel: boe-th101mb31ig002 : Make it compatible
 with other panel.
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 airlied@gmail.com, mripard@kernel.org, dianders@google.com,
 hsinyi@google.com, awarnecke002@hotmail.com, quic_jesszhan@quicinc.com,
 dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240709134754.28013-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240709134754.28013-2-lvzhaoxiong@huaqin.corp-partner.google.com>
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
In-Reply-To: <20240709134754.28013-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2024 15:47, Zhaoxiong Lv wrote:
> This driver currently only applies to one panel. Modify it to be
> compatible with other panels.
> 
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
> Changes between V6 and V5:
> -  1. Corrected the use of "->init" in struct panel_desc,
> -  2. Modify indentation in "boe_th101mb31ig002_of_match[]"
> v5: https://lore.kernel.org/all/20240704072958.27876-2-lvzhaoxiong@huaqin.corp-partner.google.com/
> ---
>   .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 41 +++++++++++++++----
>   1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> index 763e9f8342d3..8f03920e3503 100644
> --- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> +++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> @@ -17,11 +17,21 @@
>   #include <drm/drm_modes.h>
>   #include <drm/drm_panel.h>
>   
> +struct panel_desc {
> +	const struct drm_display_mode *modes;
> +	unsigned long mode_flags;
> +	enum mipi_dsi_pixel_format format;
> +	int (*init)(struct drm_panel *panel);
> +	unsigned int lanes;
> +};
> +
>   struct boe_th101mb31ig002 {
>   	struct drm_panel panel;
>   
>   	struct mipi_dsi_device *dsi;
>   
> +	const struct panel_desc *desc;
> +
>   	struct regulator *power;
>   	struct gpio_desc *enable;
>   	struct gpio_desc *reset;
> @@ -161,7 +171,10 @@ static int boe_th101mb31ig002_prepare(struct drm_panel *panel)
>   	gpiod_set_value_cansleep(ctx->enable, 1);
>   	msleep(50);
>   	boe_th101mb31ig002_reset(ctx);
> -	boe_th101mb31ig002_enable(panel);
> +
> +	ret = ctx->desc->init(panel);
> +	if (ret)
> +		return ret;
>   
>   	return 0;
>   }
> @@ -181,6 +194,16 @@ static const struct drm_display_mode boe_th101mb31ig002_default_mode = {
>   	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
>   };
>   
> +static const struct panel_desc boe_th101mb31ig002_desc = {
> +	.modes = &boe_th101mb31ig002_default_mode,
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_BURST |
> +			  MIPI_DSI_MODE_NO_EOT_PACKET |
> +			  MIPI_DSI_MODE_LPM,
> +	.init = boe_th101mb31ig002_enable,
> +};
> +
>   static int boe_th101mb31ig002_get_modes(struct drm_panel *panel,
>   					struct drm_connector *connector)
>   {
> @@ -237,6 +260,7 @@ static const struct drm_panel_funcs boe_th101mb31ig002_funcs = {
>   static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
>   {
>   	struct boe_th101mb31ig002 *ctx;
> +	const struct panel_desc *desc;
>   	int ret;
>   
>   	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
> @@ -246,11 +270,11 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
>   	mipi_dsi_set_drvdata(dsi, ctx);
>   	ctx->dsi = dsi;
>   
> -	dsi->lanes = 4;
> -	dsi->format = MIPI_DSI_FMT_RGB888;
> -	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST |
> -			  MIPI_DSI_MODE_NO_EOT_PACKET |
> -			  MIPI_DSI_MODE_LPM;
> +	desc = of_device_get_match_data(&dsi->dev);
> +	dsi->lanes = desc->lanes;
> +	dsi->format = desc->format;
> +	dsi->mode_flags = desc->mode_flags;
> +	ctx->desc = desc;
>   
>   	ctx->power = devm_regulator_get(&dsi->dev, "power");
>   	if (IS_ERR(ctx->power))
> @@ -302,7 +326,10 @@ static void boe_th101mb31ig002_dsi_remove(struct mipi_dsi_device *dsi)
>   }
>   
>   static const struct of_device_id boe_th101mb31ig002_of_match[] = {
> -	{ .compatible = "boe,th101mb31ig002-28a", },
> +	{
> +		.compatible = "boe,th101mb31ig002-28a",
> +		.data = &boe_th101mb31ig002_desc
> +	},
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, boe_th101mb31ig002_of_match);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

