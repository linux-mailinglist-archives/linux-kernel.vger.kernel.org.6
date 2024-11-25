Return-Path: <linux-kernel+bounces-420606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0209D7D25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4672827D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6903218C930;
	Mon, 25 Nov 2024 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWtVj3Pf"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2F918CBF2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524312; cv=none; b=m8vf/myyGmhifvVuPKdn7JmEUw1SM8sxO1tjJeaj3J/cgmPnj2Hecv9WgwJ0Xj3VWxaqMDN2ROA6x0T5oyAh/T5MaSkZQQXpp68EoGJRJ/oo/+zBGEm9+hIhP6Gky6sft1MeA3yveSwPhD4NLIm+SdN7qHnR9EIf5OwaJnE0n6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524312; c=relaxed/simple;
	bh=pdoF1bJIxWzA7EiXkU3sjqlhShv/0u+F5JoQOJYzzOc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FJnDLsS2jANRzDc1SRM+PGA4b12a1MVIy/r5pPgQajE0m97Uw6Y42JYfEcJz7TZWoWgx6x80yUM1SD3bucGjuYumvJ2VnFUy2VqC2y7vSvKgDdUVFx4MCTBoznh1Peni2EKhMMIdv2/fmyz/1hXhgX/xiSsAsrbJlPvX6hi3kPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DWtVj3Pf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so38581345e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732524309; x=1733129109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XGB9+sw6OIOChWIiAo8iO+Vdi73C9rgZ6nQSylkr0c=;
        b=DWtVj3PfZETXx5x3LhyqKTTn81NWTCW4ofbps5EJh/YesD96YdbEP17RrQ3XS97jTF
         gklhYqSm9ElZdbxN5jw/66wIl9GeLJEVuBXKzCwFVT5PTgMJcSRw7HAQEijBXh1iTFT3
         yx8Crpnb0qhVcri53Pr0hk37i0uIn4AR+Dju29fVG1SboRRKhyHuQjCzhXdwEBr5foqf
         XDNRTyLzPdlUfxq54uHQc3U5XL7zVNc887AloJoiEo1ZU97OH+kTLmF01pGGkm+E4it4
         wLGVoLuy+QbqhOtIu6y0t/Hk36TokmoPa3kmILFOfh14OQbuEGkiF2U+c+iw3CDe+eX5
         ScWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732524309; x=1733129109;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+XGB9+sw6OIOChWIiAo8iO+Vdi73C9rgZ6nQSylkr0c=;
        b=InMMkWNaHSNFO4mmoUlgNg16To4Zi+Flk0+Bz16xpd8I9KIcdzdswwaHoYLDdh9zfg
         JgP6zppL9yIumenT3ncd4IBEGLgRPhKfHdPhrkHMYzRmgY3RbGsyt9De49fV3kTzdvbz
         nnRDiqA1zIsHsLgm9+QjRQwjl254rMSJpjxfQBACtgiQSvVJdyiUdFyq7OrbmfV1qbpD
         WgA2y3oDfeZe6SMy35mOuXtG2tZlZq0dGzfFZd25KyhUO7DSOGco8C9R/w3D51SnRfJK
         d0o6Vm6MWvb0z9q00jMvVcAFZgC33AoQty8znEMHa1W3GPo0eDYbXE0LUQW2lxZ7425Q
         yAwg==
X-Forwarded-Encrypted: i=1; AJvYcCU0vaEsSH7/nPQY8jwMaRASzFyRckMVyqT9pDyGJvVc7aBzaWAKkNvonRuhAeHscs93ImEc1SsD8CsMcWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mQNpYyTjqDaaDhnp1kh7jlGIFYJziM3xVFEramErM9pUW9Xv
	JrKtSixRKZwlkB7E4FCZSseYY/DAhbqvz9s8kFDEbAQwW9X1PPL5Yv9VUlRrpzI=
X-Gm-Gg: ASbGncun86en7gaynJOL2YAQ1RM91ER8s0tGo6huTvWNRHa9lOPVf/4zZW+8IsXu+Tb
	4ruvQJH4O4A2k3yn5OIoJxh+cJse8k+JZo+OLv5LuSKj4eRI6jOC6wvbmJ2JcyjvMOuLsGHvzka
	PluCevfdonsynoRsmuupKtxX15ewKSdth6Meobl1sxUuAJ6xWL6JbZfFXYIFifTJscDUTWobWzC
	Rowlcp/uNl1fYM/DkZDj8rzCmMv88KTJ5TrnH4tVOqaujNuWOZVt7OQ2gYrRZOxu1FSCd2UDTMy
	VDgp35DZ+ln1QA9T6q+iii3T5aA=
X-Google-Smtp-Source: AGHT+IH3nnS9lv2OrHPa7UzXVP/Pzo4LcGgWclg0dKbnKj5nL+O4oRZUuLf50pEuMQSrE0T4y1sWig==
X-Received: by 2002:a05:600c:511f:b0:430:5654:45d0 with SMTP id 5b1f17b1804b1-433ce4250camr103403735e9.14.1732524309108;
        Mon, 25 Nov 2024 00:45:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9dc0:6c46:415c:5f8b? ([2a01:e0a:982:cbb0:9dc0:6c46:415c:5f8b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825faf9829sm9756935f8f.31.2024.11.25.00.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 00:45:08 -0800 (PST)
Message-ID: <3bac31fc-57aa-4234-b10b-d48d3bbfa344@linaro.org>
Date: Mon, 25 Nov 2024 09:45:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/5] gpu: drm: adp: Add a backlight driver for the Summit
 LCD
To: fnkl.kernel@gmail.com, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nick Chan <towinchenmi@gmail.com>
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
 <20241124-adpdrm-v1-3-3191d8e6e49a@gmail.com>
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
In-Reply-To: <20241124-adpdrm-v1-3-3191d8e6e49a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 24/11/2024 23:29, Sasha Finkelstein via B4 Relay wrote:
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
> 
> This is the display panel used for the touchbar on laptops that have it.
> 
> Co-developed-by: Nick Chan <towinchenmi@gmail.com>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>   drivers/gpu/drm/adp/panel-summit.c | 108 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 108 insertions(+)
> 
> diff --git a/drivers/gpu/drm/adp/panel-summit.c b/drivers/gpu/drm/adp/panel-summit.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2dcbddd925ce3863742aa60164369ba9db0bbfff
> --- /dev/null
> +++ b/drivers/gpu/drm/adp/panel-summit.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/backlight.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <video/mipi_display.h>
> +
> +struct summit_data {
> +	struct mipi_dsi_device *dsi;
> +	struct backlight_device *bl;
> +};
> +
> +static int summit_set_brightness(struct device *dev)
> +{
> +	struct summit_data *panel = dev_get_drvdata(dev);
> +	int level = backlight_get_brightness(panel->bl);
> +	int err = mipi_dsi_dcs_set_display_brightness(panel->dsi, level);
> +
> +	if (err < 0)
> +		return err;
> +	return 0;

Just return err here.

> +}
> +
> +static int summit_bl_update_status(struct backlight_device *dev)
> +{
> +	return summit_set_brightness(&dev->dev);
> +}
> +
> +static int summit_bl_get_brightness(struct backlight_device *dev)
> +{
> +	return backlight_get_brightness(dev);
> +}
> +
> +static const struct backlight_ops summit_bl_ops = {
> +	.get_brightness = summit_bl_get_brightness,
> +	.update_status	= summit_bl_update_status,
> +};
> +
> +static int summit_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct backlight_properties props = { 0 };
> +	struct device *dev = &dsi->dev;
> +	struct summit_data *panel;
> +
> +	panel = devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);
> +	if (!panel)
> +		return -ENOMEM;
> +
> +	mipi_dsi_set_drvdata(dsi, panel);
> +	panel->dsi = dsi;
> +
> +	int ret = device_property_read_u32(dev, "max-brightness", &props.max_brightness);
> +
> +	if (ret)
> +		props.max_brightness = 255;
> +	props.type = BACKLIGHT_RAW;
> +
> +	panel->bl = devm_backlight_device_register(dev, dev_name(dev),
> +						   dev, panel, &summit_bl_ops, &props);
> +	if (IS_ERR(panel->bl))
> +		return PTR_ERR(panel->bl);
> +
> +	return mipi_dsi_attach(dsi);
> +}
> +
> +static void summit_remove(struct mipi_dsi_device *dsi)
> +{
> +	mipi_dsi_detach(dsi);
> +}
> +
> +static int summit_resume(struct device *dev)
> +{
> +	return summit_set_brightness(dev);
> +}
> +
> +static int summit_suspend(struct device *dev)
> +{
> +	struct summit_data *panel = dev_get_drvdata(dev);
> +
> +	int err = mipi_dsi_dcs_set_display_brightness(panel->dsi, 0);
> +
> +	if (err < 0)
> +		return err;
> +	return 0;

Just return err here, add a common function to set a brighness value and
avoid duplicate code like here.

Neil


> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(summit_pm_ops, summit_suspend,
> +				summit_resume);
> +
> +static const struct of_device_id summit_of_match[] = {
> +	{ .compatible = "apple,summit" },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, summit_of_match);
> +
> +static struct mipi_dsi_driver summit_driver = {
> +	.probe = summit_probe,
> +	.remove = summit_remove,
> +	.driver = {
> +		.name = "panel-summit",
> +		.of_match_table = summit_of_match,
> +		.pm = pm_sleep_ptr(&summit_pm_ops),
> +	},
> +};
> +module_mipi_dsi_driver(summit_driver);
> +
> +MODULE_DESCRIPTION("Summit Display Panel Driver");
> +MODULE_LICENSE("GPL");
> 

Please move the driver into drivers/gpu/drm/panels

Thanks,
Neil

