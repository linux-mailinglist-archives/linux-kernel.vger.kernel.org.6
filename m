Return-Path: <linux-kernel+bounces-244337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 977A992A2D8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243331F21F36
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A6A78C9A;
	Mon,  8 Jul 2024 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Or0nAdNR"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182135B05E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442097; cv=none; b=Zi+FvjwhW1g2JJeEFZ1u4sS/Z0vAceA0JMhaDGA5oQaS7b95WfBvZi1YXosN0e/OElet0kPjIuCLd4zTQ99orl6vraaP0l587f2r8EYZ5aox+r/n7RleDGix3GisxAHUWjKfK5RvcpComjwUfalCfgbcOvnD9muifhEbnLUG2UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442097; c=relaxed/simple;
	bh=EbvTVbM11Q6J34g8M6AfHTrn0uFQ7xwrG8wkWiEV48A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iF0SK4ipDrPDOd11ZVZJul0XLnzUpCKbiE7HcL1LtwJCpbMDMx2m1cjb4cMhfv8kfnTizI192iimY7QRx6ZnD9/cEklZ4TGI9w3c8bKTnJW2LyJfdjaN17u65haaM1pivpUwJk4eew7uOcNNBa6rOfkJDfcPE7KmhYh/G/Kz7FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Or0nAdNR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42579b60af1so27745675e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 05:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720442094; x=1721046894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgjeWYgiGCxJ1tOnV/HT+93NbLmQDOhmuH//SMbzxXU=;
        b=Or0nAdNRJSZNwonIGQLChIiHJBgutJs+Gu3zpwiooJug2RlC73GT/gZa3UOfmUDe51
         WKAto7d90U4xcRqxjna4eDrl3HqzqFQx+wBqQjfaXd/9uKNBFNMlvi7PV4jA8yKVgjq1
         PIY/mhRXLningBG42fk+uqVCXfNOVfGTDNdMCj3UaP7qiJU0IRBV9aP2YM2QuEWFSCuq
         Hre9yXOooek/SmipUc79/arpAZRgLLOjLMepFuN0K0ETfUbHZt8/MZSLzV3k5z8FM+42
         sehoo6XAH3FHzsLkx5VbslNCHBLVwdrPim4xg+dfnJc/tMVCGDKkxNiy/9bp8HXlg0YV
         jZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720442094; x=1721046894;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BgjeWYgiGCxJ1tOnV/HT+93NbLmQDOhmuH//SMbzxXU=;
        b=bo/8gvZuCDJ2WONgyszjqmbfO8QUSHaSLeoVaqHSMgZY5roWUWApUToOWy+FCN1mlL
         ErCxAKqO6PCda4hBRRen7hA95HY2be23OuJrTlGyCmE7GjanBVirA2ce9KOOcL2qSX0k
         kpuyEA3jL/S3P+W1ZTmIa8pj3oxkFsAproasGuPw7gwWsVEYnUziB/6xmXzVeszI4fCv
         Cd+LqWbhAcoeEYoeZfZ0VrfEbRrHD4cdP6lqkMbPBw6qaNNzAIQxD/nHTmKnfpMCOiKK
         v0LTADORGcPGjqhp5bUu6E3Z/PZDBfu1uMtRru5gxVxmK76EcvxFpwSKp7NO5nDhIOKc
         r5Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVqF+6fdCCCwAQ9JzE4i+YOA+Duml4lD9jxyFbbChzdl+B3MegkH7i0ZpNoPF0SWG4EbeWuGmFvtTofL6e1HLosy5wMAMOHAc0qI9PZ
X-Gm-Message-State: AOJu0YyIsNDVPl6ziuawsYsw6/pbChPBWimqXHIJG5osLrJcPzRfXxMS
	dr4EecXuKdUXkO/dNsKMZDNoC8+UZWnmArmXXK7GXlHsKzoh/my78CAjTPVetzU=
X-Google-Smtp-Source: AGHT+IErLgh8R7kUYcr2wJEQ26Y6kVhRoQa2p4zO4Es+NlKn5V+X+U+MS9B9ajG68786iYXyoBM5gw==
X-Received: by 2002:a05:600c:4a96:b0:426:5269:982e with SMTP id 5b1f17b1804b1-42652699983mr54740075e9.5.1720442093908;
        Mon, 08 Jul 2024 05:34:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:f482:8fc6:e8d0:6d7c? ([2a01:e0a:cad:2140:f482:8fc6:e8d0:6d7c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42662657263sm76659105e9.47.2024.07.08.05.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 05:34:53 -0700 (PDT)
Message-ID: <0dd9c497-9d21-4d4e-8165-cab06b38f69a@linaro.org>
Date: Mon, 8 Jul 2024 14:34:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 1/5] drm/panel: boe-th101mb31ig002 : Make it compatible
 with other panel.
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 airlied@gmail.com, daniel@ffwll.ch, mripard@kernel.org, dianders@google.com,
 hsinyi@google.com, awarnecke002@hotmail.com, quic_jesszhan@quicinc.com,
 dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240704072958.27876-2-lvzhaoxiong@huaqin.corp-partner.google.com>
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
In-Reply-To: <20240704072958.27876-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/07/2024 09:29, Zhaoxiong Lv wrote:
> This driver currently only applies to one panel. Modify it to be
> compatible with other panels.
> 
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
>   .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 40 +++++++++++++++----
>   1 file changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
> index 763e9f8342d3..159e401ad0e6 100644
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
> +	const struct panel_init_cmd *init_cmds;
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
> +	ret = ctx->desc->init(ctx);
> +	if (ret)
> +		return ret;

There's no ->init in struct panel_desc

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
> +	.init_cmds = boe_th101mb31ig002_enable,
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

use device_get_match_data() instead, and check the return

> +	dsi->lanes = desc->lanes;
> +	dsi->format = desc->format;
> +	dsi->mode_flags = desc->mode_flags;
> +	ctx->desc = desc;
>   
>   	ctx->power = devm_regulator_get(&dsi->dev, "power");
>   	if (IS_ERR(ctx->power))
> @@ -302,7 +326,9 @@ static void boe_th101mb31ig002_dsi_remove(struct mipi_dsi_device *dsi)
>   }
>   
>   static const struct of_device_id boe_th101mb31ig002_of_match[] = {
> -	{ .compatible = "boe,th101mb31ig002-28a", },
> +	{ .compatible = "boe,th101mb31ig002-28a",
> +	  .data = &boe_th101mb31ig002_desc
> +	},

Weird indentation, please use :
	{
		.compatible = ..,
		.data = ...,
	},

>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, boe_th101mb31ig002_of_match);

Thanks,
Neil

