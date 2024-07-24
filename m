Return-Path: <linux-kernel+bounces-260725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B523193AD6F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD35283C35
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB3382486;
	Wed, 24 Jul 2024 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mx5LgtrD"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3F61FF0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807463; cv=none; b=tyEkJV7xw5XfplDHWzdbjAjCRBbvtRd0XPuiw6d21NTHOG0o18/T/V/5QKChmgd2GTZuQYC5hxC12Xav8Bv0SPNoQLgf9u1HsjCOZShpmP3QNvBlQpxS4tOpTCsdX2rSWfMopnmm4g8F+4SGdrsVFLFBr5UMJgmxsoiF4V9Dygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807463; c=relaxed/simple;
	bh=TP4ZjMBBwBAji/RiLkkXBhCKvliF01yzRSW4M8m/cQs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cEtmzJz2ykEAy9xzT+Z0qY3lpwmn4+1HVLji9Sv2k48zJN+tTsYoFOQVTlKnJuRntW7FZPP77q7LZky7LBXzDNkZ+w7YIXOy4rNCwwLeCvCzYSYKp8xB+mBRB+IeN62eoAmNBBXVhxYP72o980qXmjly9Dhrzw5i4SvMvZLLCrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mx5LgtrD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266fd39527so48492495e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 00:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721807460; x=1722412260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIbDCUVg/y+Dd0v0s+pinKcZZyekq4cbEc+kOZTJTwY=;
        b=mx5LgtrDItSFQ7dptrioSwAEyE026h/GfcmKATFrVT3k4GfTGBQ/TkDaepEYoamHBs
         nXIWahevrZWXdqZxcL+QBwlSiIXaciyiMaAo0IWI04UgTie74IroxxOuKwEx2GulSuhr
         cFAAv4fkT3NH0ACoI+lvw+x0dx8LJ/lNpB0+Ul/pGBN8nQO6vPg5PdZuNT8hlA4rgzUE
         KsObVcYYMqIZ3tU2/KpvQiesRP8MbcPlfqa3G4LRxhdAGCj83XsBqNOhpeveXCLCqDuy
         s6zHf0lTNb/95UAveZe6uPWLMwYJpQsKvgLrPtw8ydSFlFTXOHLw7XKGpDGYrTGOkVUv
         bvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721807460; x=1722412260;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MIbDCUVg/y+Dd0v0s+pinKcZZyekq4cbEc+kOZTJTwY=;
        b=towUz/qx4HEnwBWvJsk/h+3TUt+Vu2sUb8BjQsfeRA3Gr+UzYb8edd+W1jVAlBUWzL
         +lvjmWdHm6TGIJCMp83x08NJK7fbF3LU8ZrEKAhQLz3KlrY5vC2d5eF2VkKQjkKO1bAx
         MlEpN3RKKlGxxrJOzY2hDvko6KBcjJksF4koxSuMbfBNuhNys2bYZHt2VtiQM7kCkXuL
         m7qZhxE8J6u98hDZ1x3FUf/9SjTt1N57og1iyQUpYuACptBYFlJNAP+5NXe+3aQwQawv
         Vm32a5faDgymILYzio6uCNQXsUZJWE0J85o3TdLuVR1CXHuhk9q6wK4TpvR1GdMxNztx
         C6zg==
X-Forwarded-Encrypted: i=1; AJvYcCX5Jj22Rqm16sf0XsvBDwh9JjQSRs0LvS3lH+cC/7UGZtTYA2wAWp887CtYafAxvRqygUoInGoAyFykbT7eNy1VsKiGGmLjslZNkrIH
X-Gm-Message-State: AOJu0YxOaHHdGib4f7q+z6RiS6qUfnwUic5MAwNXCkWxZGuxbdNNym0d
	9agdDNNWxVSh6kVtISzXnWXVQ8nzH3GthPX5kYSpyVUA7r7l34kO968raJjQXWQ=
X-Google-Smtp-Source: AGHT+IGlDCWTscNUHohC4ARykVUJaA2f0+Ld2k15SDK7jdUyHKZhZKOug80wqXIWE9zzqUc+DRVNVg==
X-Received: by 2002:a05:600c:3b08:b0:426:59fe:ac2e with SMTP id 5b1f17b1804b1-427f95af28dmr8486985e9.29.1721807459477;
        Wed, 24 Jul 2024 00:50:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:deff:4fa8:5076:b4c7? ([2a01:e0a:982:cbb0:deff:4fa8:5076:b4c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93e6021sm16856135e9.35.2024.07.24.00.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 00:50:59 -0700 (PDT)
Message-ID: <dfb29dca-7110-4c11-b86e-9063f71a8ada@linaro.org>
Date: Wed, 24 Jul 2024 09:50:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] drm/panel: add BOE tv101wum-ll2 panel driver
To: Doug Anderson <dianders@chromium.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240709-topic-sdm450-upstream-tbx605f-panel-v1-0-af473397835d@linaro.org>
 <20240709-topic-sdm450-upstream-tbx605f-panel-v1-2-af473397835d@linaro.org>
 <CAD=FV=VL1Wxd0veW7N+0Hy=LdKMzNbBang9_EZ9Zo_d-wZOBfw@mail.gmail.com>
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
In-Reply-To: <CAD=FV=VL1Wxd0veW7N+0Hy=LdKMzNbBang9_EZ9Zo_d-wZOBfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/07/2024 21:17, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jul 9, 2024 at 6:06 AM Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
>> index 5581387707c6..79c90894b6a4 100644
>> --- a/drivers/gpu/drm/panel/Makefile
>> +++ b/drivers/gpu/drm/panel/Makefile
>> @@ -7,6 +7,7 @@ obj-$(CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0) += panel-boe-bf060y8m-aj0.o
>>   obj-$(CONFIG_DRM_PANEL_BOE_HIMAX8279D) += panel-boe-himax8279d.o
>>   obj-$(CONFIG_DRM_PANEL_BOE_TH101MB31UIG002_28A) += panel-boe-th101mb31ig002-28a.o
>>   obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_NL6) += panel-boe-tv101wum-nl6.o
>> +obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_LL2) += panel-boe-tv101wum-ll2.o
> 
> nit: please sort. L comes before N.

Good catch, thx

> 
> 
>>   obj-$(CONFIG_DRM_PANEL_DSI_CM) += panel-dsi-cm.o
>>   obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
>>   obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
>> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
>> new file mode 100644
>> index 000000000000..5513cb48d949
>> --- /dev/null
>> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
>> @@ -0,0 +1,240 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree:
>> +//   Copyright (c) 2013, The Linux Foundation. All rights reserved.
>> +//   Copyright (c) 2024, Neil Armstrong <neil.armstrong@linaro.org>
>> +
>> +#include <linux/delay.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
> 
> nit: sort header files?

Will do while I'm it, but I don't personally care of the include order..

> 
>> +static int boe_tv101wum_ll2_prepare(struct drm_panel *panel)
>> +{
>> +       struct boe_tv101wum_ll2 *ctx = to_boe_tv101wum_ll2(panel);
>> +       struct device *dev = &ctx->dsi->dev;
>> +       int ret;
>> +
>> +       ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies),
>> +                                   ctx->supplies);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       boe_tv101wum_ll2_reset(ctx);
>> +
>> +       ret = boe_tv101wum_ll2_on(ctx);
>> +       if (ret < 0) {
>> +               dev_err(dev, "Failed to initialize panel: %d\n", ret);
> 
> nit: Do you really need this error message? The "_multi" variants are
> all chatty and print the error message, so we don't really need this
> here...

Yeah you're right, it's a leftover of the linux-mdss-dsi-panel-driver-generator

> 
> 
>> +               gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>> +               return ret;
> 
> Shouldn't you turn off the regulators?

Indeed

> 
> 
>> +static int boe_tv101wum_ll2_unprepare(struct drm_panel *panel)
>> +{
>> +       struct boe_tv101wum_ll2 *ctx = to_boe_tv101wum_ll2(panel);
>> +       struct device *dev = &ctx->dsi->dev;
>> +       int ret;
>> +
>> +       ret = boe_tv101wum_ll2_off(ctx);
>> +       if (ret < 0)
>> +               dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
> 
> nit: Do you really need this error message? The "_multi" variants are
> all chatty and print the error message, so we don't really need this
> here...

Another leftover

> 
> 
>> +
>> +       gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>> +
>> +       regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>> +
>> +       return 0;
> 
> Maybe add a comment justifying why you don't return the error code
> that boe_tv101wum_ll2_off() returned?

Good point, as far as I remember I always avoided returning errors
when disabling things, I'll investigate

> 
> 
>> +static int boe_tv101wum_ll2_get_modes(struct drm_panel *panel,
>> +                                     struct drm_connector *connector)
>> +{
>> +       return drm_connector_helper_get_modes_fixed(connector, &boe_tv101wum_ll2_mode);
> 
> Random question for you: on panels that don't use the
> drm_connector_helper the "bpc" gets set here. Is there a reason why
> some panel drivers (like this one) don't set bpc?

Good question, I'll check

> 
> 
>> +static int boe_tv101wum_ll2_probe(struct mipi_dsi_device *dsi)
>> +{
>> +       struct device *dev = &dsi->dev;
>> +       struct boe_tv101wum_ll2 *ctx;
>> +       int ret;
>> +
>> +       ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>> +       if (!ctx)
>> +               return -ENOMEM;
>> +
>> +       ctx->supplies[0].supply = "vsp";
>> +       ctx->supplies[1].supply = "vsn";
>> +
>> +       ret = devm_regulator_bulk_get(&dsi->dev, ARRAY_SIZE(ctx->supplies),
>> +                                     ctx->supplies);
> 
> Any chance I can convince you to use devm_regulator_bulk_get_const()?
> Then you can list your supply structures as "static const" instead of
> having to initialize them via code.

You convinced me!

> 
> 
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>> +       if (IS_ERR(ctx->reset_gpio))
>> +               return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
>> +                                    "Failed to get reset-gpios\n");
>> +
>> +       ctx->dsi = dsi;
>> +       mipi_dsi_set_drvdata(dsi, ctx);
>> +
>> +       dsi->lanes = 4;
>> +       dsi->format = MIPI_DSI_FMT_RGB888;
>> +       dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
>> +                         MIPI_DSI_MODE_VIDEO_HSE;
>> +
>> +       drm_panel_init(&ctx->panel, dev, &boe_tv101wum_ll2_panel_funcs,
>> +                      DRM_MODE_CONNECTOR_DSI);
>> +       ctx->panel.prepare_prev_first = true;
>> +
>> +       ret = drm_panel_of_backlight(&ctx->panel);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "Failed to get backlight\n");
>> +
>> +       drm_panel_add(&ctx->panel);
> 
> Any chance you could add devm_drm_panel_add() and then use it? Then
> you can fully get rid of your remove and error handling since
> devm_mipi_dsi_attach() already exists. Note that this would not change
> object lifetimes at all since you're already calling
> drm_panel_remove() in your remove code--it would just clean up the
> code...

Yep I'll use it

> 
> 
>> +static struct mipi_dsi_driver boe_tv101wum_ll2_driver = {
>> +       .probe = boe_tv101wum_ll2_probe,
>> +       .remove = boe_tv101wum_ll2_remove,
>> +       .driver = {
>> +               .name = "panel-boe-tv101wum_ll2",
>> +               .of_match_table = boe_tv101wum_ll2_of_match,
>> +       },
>> +};
>> +module_mipi_dsi_driver(boe_tv101wum_ll2_driver);
>> +
>> +MODULE_DESCRIPTION("DRM driver for Boe TV101WUM-LL2 Panel");
> 
> Should "Boe" be "BOE" ?

Good point aswell!

Thanks for the review

Neil



