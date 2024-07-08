Return-Path: <linux-kernel+bounces-243987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B61929D69
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32A61C21A72
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6AE2C684;
	Mon,  8 Jul 2024 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hkWyLGf3"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2974E23774
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424679; cv=none; b=F4mVK934ZH57aTmYIu3iJbrwXROd0va3aGFVQ83fqTTCXp+YtdHbhl7UcT2gelBRzTMLoIhzp47R/4XZum6r4wN35u2W3nFTaneHZDXceX2LMzXFUswusyh5Sx6j0AocK1F0OHT7R/txFiD2TUdMXKXI5NDsHj76C7WRaD+trxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424679; c=relaxed/simple;
	bh=LVlUNbqjLVmHTdr0uoEQF08puOdKcY/oV4eAWglQAfM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AH6MrziFbfNWuExITcbOwj2uFWKIXS6C3InGtWQjn2JwSiNjyjk8KCgf5iuevc0NgDK0b1J+ifVJ9PmsPcXFIypwurVx5zwiGMpVbTLc2IdJGF6ZHpKTNUmBFmuNBLUb1Cg/ybW0UWJF9VKRH4BRk7tX9ewHnb7HYuDYl+2z8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hkWyLGf3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42665be6916so5326805e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720424676; x=1721029476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKc/6b8SzfBj7M2nYp8kBK/g6YH6J6CYddIrh37bRLc=;
        b=hkWyLGf3KvwXIvzuJSlg4ZiScrp/syM3SLcvm1tebctQ3RTo+p6ZTohfQMLYHgEouC
         +1ESSr0PHlOvl4D71ohEC9PKnEqcCy28cqx4xJFNSzzTtbVP0a+B1XFTFjPwKX/B8Uwt
         604H3yIYtzW8a/OAhQvTDnuCp4C86awES4CR7WcKQoi/TpfP090wSyAkaS4l85DOTMK8
         XJyojJSqsth0esC4KwIGygzNKeSGLzz4D/AuAo+aYNpeRq3bTL7HdiJWwfzGE3aI8hti
         3ZdJBC1cUmgHTDCp2obqUteukfMBeRWAC4B0J4rPfd2aXaFz4sXTbK0MzXQLgMW7+HN2
         LGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424676; x=1721029476;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PKc/6b8SzfBj7M2nYp8kBK/g6YH6J6CYddIrh37bRLc=;
        b=e/DQlBb7H2psoFvqIRFoY8/Emf/PD6oNnS1qIcTJpFwjKQoSMeh4wKN2A4o5uZ2PC7
         glOA9EKZT9q6KlBuI652UurYpRMsAQUlVJyVfgytsP0g83CiVUc7tZWQtNU1AK3Ql69N
         trpGokscOsu6NagskMzg7xLYn5QgfI2V/W31Z+F0o5tIn8WSux1TzUcwPIDV3Xvap97G
         MfdykjII12JTKJi8SsO3Zxspt/e/mNAD+xbTZj5PLQtnkgm0t/odvqt2n8DkYSZH4jkl
         M2Z4Xc09XBO9zhdHJZMae78LGYnaVUdTEXEpYipfUG3RSRZceNUnI1rC8kfofG5jdxUw
         s1RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaWC9Mjncd169dYHkzxd69YqaFYnOnBffYbxkrscHvVJShHykGleoMAG1XvhzjH+3zvSsXH1c6lBK7a5YzLUUMfUhMhdVJ4mYdjrG2
X-Gm-Message-State: AOJu0YwsqM0MpjD+xwUKKRXcUic99RIPdpjjaNSog35F1SZiCfM7+tGX
	2kjMq1R5L8go8YaJMfCBFWipzWc9KysHsewWhgfszDktGZTPWds/PnfOxOyrKUo=
X-Google-Smtp-Source: AGHT+IFi1UJrpS7oW1nzOg6c48MFbp0L4M8yB6ww5kHrzgS7QC/RcwAaxZOQdCBl4dSZKgy7bT1lyA==
X-Received: by 2002:a05:600c:2d16:b0:426:5b52:84fb with SMTP id 5b1f17b1804b1-4265b528599mr57698455e9.7.1720424676295;
        Mon, 08 Jul 2024 00:44:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:f482:8fc6:e8d0:6d7c? ([2a01:e0a:cad:2140:f482:8fc6:e8d0:6d7c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc9desm155494565e9.45.2024.07.08.00.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 00:44:35 -0700 (PDT)
Message-ID: <c6a911c9-64e4-46aa-a6da-3311907b1c8b@linaro.org>
Date: Mon, 8 Jul 2024 09:44:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/5] drm/panel: st7701: Decouple DSI and DRM parts
To: Hironori KIKUCHI <kikuchan98@gmail.com>, linux-kernel@vger.kernel.org
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20240706102338.99231-1-kikuchan98@gmail.com>
 <20240706102338.99231-3-kikuchan98@gmail.com>
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
In-Reply-To: <20240706102338.99231-3-kikuchan98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/07/2024 12:23, Hironori KIKUCHI wrote:
> Split into a DSI-specific part and a DRM-specific part.
> 
> Additionally, use devm_add_action_or_reset() to simplify the flow,
> and disable and unprepare the panel on cleanup.
> 
> Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-sitronix-st7701.c | 72 ++++++++++++-------
>   1 file changed, 45 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> index a9a8fd85057..a0644f7a4c8 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> @@ -539,7 +539,7 @@ static int st7701_get_modes(struct drm_panel *panel,
>   
>   	mode = drm_mode_duplicate(connector->dev, desc_mode);
>   	if (!mode) {
> -		dev_err(&st7701->dsi->dev, "failed to add mode %ux%u@%u\n",
> +		dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
>   			desc_mode->hdisplay, desc_mode->vdisplay,
>   			drm_mode_vrefresh(desc_mode));
>   		return -ENOMEM;
> @@ -974,42 +974,48 @@ static const struct st7701_panel_desc rg_arc_desc = {
>   	.gip_sequence = rg_arc_gip_sequence,
>   };
>   
> -static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
> +static void st7701_cleanup(void *data)
> +{
> +	struct st7701 *st7701 = (struct st7701 *)data;
> +
> +	drm_panel_remove(&st7701->panel);
> +	drm_panel_disable(&st7701->panel);
> +	drm_panel_unprepare(&st7701->panel);
> +}
> +
> +static int st7701_probe(struct device *dev, int connector_type)
>   {
>   	const struct st7701_panel_desc *desc;
>   	struct st7701 *st7701;
>   	int ret;
>   
> -	st7701 = devm_kzalloc(&dsi->dev, sizeof(*st7701), GFP_KERNEL);
> +	st7701 = devm_kzalloc(dev, sizeof(*st7701), GFP_KERNEL);
>   	if (!st7701)
>   		return -ENOMEM;
>   
> -	desc = of_device_get_match_data(&dsi->dev);
> -	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> -			  MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS;
> -	dsi->format = desc->format;
> -	dsi->lanes = desc->lanes;
> +	desc = of_device_get_match_data(dev);
> +	if (!desc)
> +		return -ENODEV;
>   
>   	st7701->supplies[0].supply = "VCC";
>   	st7701->supplies[1].supply = "IOVCC";
>   
> -	ret = devm_regulator_bulk_get(&dsi->dev, ARRAY_SIZE(st7701->supplies),
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st7701->supplies),
>   				      st7701->supplies);
>   	if (ret < 0)
>   		return ret;
>   
> -	st7701->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
> +	st7701->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>   	if (IS_ERR(st7701->reset)) {
> -		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
> +		dev_err(dev, "Couldn't get our reset GPIO\n");
>   		return PTR_ERR(st7701->reset);
>   	}
>   
> -	ret = of_drm_get_panel_orientation(dsi->dev.of_node, &st7701->orientation);
> +	ret = of_drm_get_panel_orientation(dev->of_node, &st7701->orientation);
>   	if (ret < 0)
> -		return dev_err_probe(&dsi->dev, ret, "Failed to get orientation\n");
> +		return dev_err_probe(dev, ret, "Failed to get orientation\n");
>   
> -	drm_panel_init(&st7701->panel, &dsi->dev, &st7701_funcs,
> -		       DRM_MODE_CONNECTOR_DSI);
> +	drm_panel_init(&st7701->panel, dev, &st7701_funcs, connector_type);
>   
>   	/**
>   	 * Once sleep out has been issued, ST7701 IC required to wait 120ms
> @@ -1028,27 +1034,39 @@ static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
>   
>   	drm_panel_add(&st7701->panel);
>   
> -	mipi_dsi_set_drvdata(dsi, st7701);
> -	st7701->dsi = dsi;
> +	dev_set_drvdata(dev, st7701);
>   	st7701->desc = desc;
>   
> -	ret = mipi_dsi_attach(dsi);
> -	if (ret)
> -		goto err_attach;
> +	return devm_add_action_or_reset(dev, st7701_cleanup, st7701);
> +}
> +
> +static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct st7701 *st7701;
> +	int err;
> +
> +	err = st7701_probe(&dsi->dev, DRM_MODE_CONNECTOR_DSI);
> +	if (err)
> +		return err;
> +
> +	st7701 = dev_get_drvdata(&dsi->dev);
> +	st7701->dsi = dsi;
> +
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> +			  MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +	dsi->format = st7701->desc->format;
> +	dsi->lanes = st7701->desc->lanes;
> +
> +	err = mipi_dsi_attach(dsi);
> +	if (err)
> +		return dev_err_probe(&dsi->dev, err, "Failed to init MIPI DSI\n");
>   
>   	return 0;
> -
> -err_attach:
> -	drm_panel_remove(&st7701->panel);
> -	return ret;
>   }
>   
>   static void st7701_dsi_remove(struct mipi_dsi_device *dsi)
>   {
> -	struct st7701 *st7701 = mipi_dsi_get_drvdata(dsi);
> -
>   	mipi_dsi_detach(dsi);
> -	drm_panel_remove(&st7701->panel);
>   }
>   
>   static const struct of_device_id st7701_of_match[] = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

