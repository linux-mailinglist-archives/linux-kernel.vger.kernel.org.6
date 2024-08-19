Return-Path: <linux-kernel+bounces-292527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01480957077
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267231C22D73
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A67188004;
	Mon, 19 Aug 2024 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYzEy6Cn"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B84187873
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085328; cv=none; b=sumyVpA7xhgyuFgiCZ57BETWy1HcEtpIyDiZDWN/+UI45WTkqPYyakV0T1tSW1u4mZ5nvUCHAE1Lhq4l5JijXHfgHPRP8TKTQyVJfSVbxQ4fLsAf3iZWe21Jn3Y3QMHfgKpKAMiZGFHL2i7CMwXuXjguQm+W2/qiZCtB6M2qk7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085328; c=relaxed/simple;
	bh=G3LhukvQJ70S/cwrf/VezAIzmWQ6wlYfds4mY7Exoic=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YN0JNBX4wXi1zomktnmaQ2WJQRe4P54zklTpE+Op/6laianTHWOAEMbjaOTXJHj238Yi1Fg/X4bX6iUN0E7J1UzCsgpaDXz5sdDryF+eQ+7JPa0zzD+Se+79IPJwLspQu808Aakcsel6DIBS6Qmhx7Y8qHgi0v+FCINtajJFj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IYzEy6Cn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso49981555e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724085325; x=1724690125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6Nbbj1SYfTWqHpeI7O7/R2lL4Y9KrfFBJkmRlY5CfI=;
        b=IYzEy6CnuvcP3Qej/Wc9/lcPcHOkhRxXcc1ly/4c63fURisoKHp7AYIZutf+4njp3H
         r8APArAvjgz2/KYhyoiIIX8kdIkZ59DkW8kEKZ6Tr8ybImyEk+7+NFlOxulqREBAHQUM
         rI/uWdsRQoazZOcIizYXSrZrdGmmcvE+BOdixi37mSuATqkI0ip0NWKtiqLwYzHVdFYP
         ZnYUqd46uxSentwqGx07OkZmGkENVAItcgBJX/8Tu+IFbqmlRxHy773wOvGyJ6/OkXV3
         BY3nmYrNAvVpWUQ0uGok+sRYrCUwaW6pAm5tj2qwLSp3Zi0XR+fdsChT9y8lFX68QXqv
         lR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724085325; x=1724690125;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O6Nbbj1SYfTWqHpeI7O7/R2lL4Y9KrfFBJkmRlY5CfI=;
        b=C2jKHD9tbXVu2NnqijkwP8lfaHDNHKjStHfAGQvwFut1tz96vUaVeR+sIiN7nIWprC
         oT2StmCO5QOlYjX8xP8gvKeZXivT13u1APNKRyqfoS/vtUF0MXWW1txiendT4IDcj0dZ
         Mgv1dHSt+SOs04EVmus8lJVIHIK1i1qJh+4dvwmiEAnwKFmfRMS5DPUJ/pZUCxoSGlLx
         4z8lVhLlSKmVOEdGq3v2A22m17S66VbxF1L4uFTFTt1Mf+5jhWTJuxwfNHwEPl98F+8s
         2Fdnr5V3XHJvFyKVFcAadPxLyTeOF2Uia2dk7ZU3n+lOQD4z9GV9fMRtZXAvxY7IZHL+
         LAPg==
X-Gm-Message-State: AOJu0YxeR6AVHmH0kENjAVbBSpO8St073TdG3QgKoEHvNnMfB69DnHTx
	GIqsC81DwSEWyE6MHjfGD+xGno34ECwSfHW9sKsLk+ANaOZZvYl6ui7WUmx6YUU=
X-Google-Smtp-Source: AGHT+IHAMBV0nzkFPsRwb6z0/rrDf5MXyOVF+NZ8xcj/72OevSo9SgRorPDm9UEtaQMfuESAmpA//A==
X-Received: by 2002:a05:600c:3b26:b0:426:6f87:65fc with SMTP id 5b1f17b1804b1-429ed7b6a3dmr92728535e9.17.1724085324681;
        Mon, 19 Aug 2024 09:35:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898b8ad6sm10935461f8f.114.2024.08.19.09.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:35:24 -0700 (PDT)
Message-ID: <161bd6fe-825a-434d-bbef-0a9e449fec5f@linaro.org>
Date: Mon, 19 Aug 2024 18:35:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 9/9] reset: amlogic: add auxiliary reset driver support
To: Jerome Brunet <jbrunet@baylibre.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240808102742.4095904-1-jbrunet@baylibre.com>
 <20240808102742.4095904-10-jbrunet@baylibre.com>
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
In-Reply-To: <20240808102742.4095904-10-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/08/2024 12:27, Jerome Brunet wrote:
> Add support for the reset controller present in the audio clock
> controller of the g12 and sm1 SoC families, using the auxiliary bus.
> 
> This is expected to replace the driver currently present directly
> within the related clock driver.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/reset/amlogic/Kconfig               |   8 ++
>   drivers/reset/amlogic/Makefile              |   1 +
>   drivers/reset/amlogic/reset-meson-aux.c     | 136 ++++++++++++++++++++
>   drivers/reset/amlogic/reset-meson-core.c    |  25 +++-
>   drivers/reset/amlogic/reset-meson-pltf.c    |   3 +
>   drivers/reset/amlogic/reset-meson.h         |   4 +
>   include/soc/amlogic/meson-auxiliary-reset.h |  23 ++++
>   7 files changed, 198 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/reset/amlogic/reset-meson-aux.c
>   create mode 100644 include/soc/amlogic/meson-auxiliary-reset.h


I thing the header name should be include/soc/amlogic/reset-meson-aux.h

> 
> diff --git a/drivers/reset/amlogic/Kconfig b/drivers/reset/amlogic/Kconfig
> index 04c7be0f3165..ee1c7620a2b1 100644
> --- a/drivers/reset/amlogic/Kconfig
> +++ b/drivers/reset/amlogic/Kconfig
> @@ -11,6 +11,14 @@ config RESET_MESON
>   	help
>   	  This enables the reset platform driver for Amlogic SoCs.
>   
> +config RESET_MESON_AUX
> +	tristate "Meson Reset Platform Driver"
> +	depends on ARCH_MESON || COMPILE_TEST
> +	select AUXILIARY_BUS
> +	select RESET_MESON_CORE
> +	help
> +	  This enables the reset auxiliary driver for Amlogic SoCs.
> +
>   config RESET_MESON_AUDIO_ARB
>   	tristate "Meson Audio Memory Arbiter Reset Driver"
>   	depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/reset/amlogic/Makefile b/drivers/reset/amlogic/Makefile
> index 0f8f9121b566..5d53a4b11ed9 100644
> --- a/drivers/reset/amlogic/Makefile
> +++ b/drivers/reset/amlogic/Makefile
> @@ -1,3 +1,4 @@
>   obj-$(CONFIG_RESET_MESON) += reset-meson-pltf.o
> +obj-$(CONFIG_RESET_MESON_AUX) += reset-meson-aux.o
>   obj-$(CONFIG_RESET_MESON_CORE) += reset-meson-core.o
>   obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
> diff --git a/drivers/reset/amlogic/reset-meson-aux.c b/drivers/reset/amlogic/reset-meson-aux.c
> new file mode 100644
> index 000000000000..caf26eb67c14
> --- /dev/null
> +++ b/drivers/reset/amlogic/reset-meson-aux.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/*
> + * Amlogic Meson Reset Auxiliary driver
> + *
> + * Copyright (c) 2024 BayLibre, SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +
> +#include "reset-meson.h"
> +#include <soc/amlogic/meson-auxiliary-reset.h>
> +
> +static DEFINE_IDA(meson_rst_aux_ida);
> +
> +struct meson_reset_adev {
> +	struct auxiliary_device adev;
> +	struct regmap *map;
> +};
> +
> +#define to_meson_reset_adev(_adev) \
> +	container_of((_adev), struct meson_reset_adev, adev)
> +
> +static const struct meson_reset_param meson_g12a_audio_param = {
> +	.reset_ops	= &meson_reset_toggle_ops,
> +	.reset_num	= 26,
> +	.level_offset	= 0x24,
> +};
> +
> +static const struct meson_reset_param meson_sm1_audio_param = {
> +	.reset_ops	= &meson_reset_toggle_ops,
> +	.reset_num	= 39,
> +	.level_offset	= 0x28,
> +};
> +
> +static const struct auxiliary_device_id meson_reset_aux_ids[] = {
> +	{
> +		.name = "axg-audio-clkc.rst-g12a",
> +		.driver_data = (kernel_ulong_t)&meson_g12a_audio_param,
> +	}, {
> +		.name = "axg-audio-clkc.rst-sm1",
> +		.driver_data = (kernel_ulong_t)&meson_sm1_audio_param,
> +	}, {}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, meson_reset_aux_ids);
> +
> +static int meson_reset_aux_probe(struct auxiliary_device *adev,
> +				 const struct auxiliary_device_id *id)
> +{
> +	const struct meson_reset_param *param =
> +		(const struct meson_reset_param *)(id->driver_data);
> +	struct meson_reset_adev *raux =
> +		to_meson_reset_adev(adev);
> +
> +	return meson_reset_probe(&adev->dev, raux->map, param);
> +}
> +
> +static struct auxiliary_driver meson_reset_aux_driver = {
> +	.probe		= meson_reset_aux_probe,
> +	.id_table	= meson_reset_aux_ids,
> +};
> +module_auxiliary_driver(meson_reset_aux_driver);
> +
> +static void meson_rst_aux_release(struct device *dev)
> +{
> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> +	struct meson_reset_adev *raux =
> +		to_meson_reset_adev(adev);
> +
> +	ida_free(&meson_rst_aux_ida, adev->id);
> +	kfree(raux);
> +}
> +
> +static void meson_rst_aux_unregister_adev(void *_adev)
> +{
> +	struct auxiliary_device *adev = _adev;
> +
> +	auxiliary_device_delete(adev);
> +	auxiliary_device_uninit(adev);
> +}
> +
> +int devm_meson_rst_aux_register(struct device *dev,
> +				struct regmap *map,
> +				const char *adev_name)
> +{
> +	struct meson_reset_adev *raux;
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	raux = kzalloc(sizeof(*raux), GFP_KERNEL);
> +	if (!raux)
> +		return -ENOMEM;
> +
> +	ret = ida_alloc(&meson_rst_aux_ida, GFP_KERNEL);
> +	if (ret < 0)
> +		goto raux_free;
> +
> +	raux->map = map;
> +
> +	adev = &raux->adev;
> +	adev->id = ret;
> +	adev->name = adev_name;
> +	adev->dev.parent = dev;
> +	adev->dev.release = meson_rst_aux_release;
> +	device_set_of_node_from_dev(&adev->dev, dev);
> +
> +	ret = auxiliary_device_init(adev);
> +	if (ret)
> +		goto ida_free;
> +
> +	ret = __auxiliary_device_add(adev, dev->driver->name);
> +	if (ret) {
> +		auxiliary_device_uninit(adev);
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(dev, meson_rst_aux_unregister_adev,
> +					adev);
> +
> +ida_free:
> +	ida_free(&meson_rst_aux_ida, adev->id);
> +raux_free:
> +	kfree(raux);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_meson_rst_aux_register);
> +
> +MODULE_DESCRIPTION("Amlogic Meson Reset Auxiliary driver");
> +MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_IMPORT_NS(MESON_RESET);
> diff --git a/drivers/reset/amlogic/reset-meson-core.c b/drivers/reset/amlogic/reset-meson-core.c
> index ea4fc562f7e6..774902527d17 100644
> --- a/drivers/reset/amlogic/reset-meson-core.c
> +++ b/drivers/reset/amlogic/reset-meson-core.c
> @@ -85,12 +85,33 @@ static int meson_reset_deassert(struct reset_controller_dev *rcdev,
>   	return meson_reset_level(rcdev, id, false);
>   }
>   
> -static const struct reset_control_ops meson_reset_ops = {
> +static int meson_reset_level_toggle(struct reset_controller_dev *rcdev,
> +				    unsigned long id)
> +{
> +	int ret;
> +
> +	ret = meson_reset_assert(rcdev, id);
> +	if (ret)
> +		return ret;
> +
> +	return meson_reset_deassert(rcdev, id);
> +}
> +
> +const struct reset_control_ops meson_reset_ops = {
>   	.reset		= meson_reset_reset,
>   	.assert		= meson_reset_assert,
>   	.deassert	= meson_reset_deassert,
>   	.status		= meson_reset_status,
>   };
> +EXPORT_SYMBOL_NS_GPL(meson_reset_ops, MESON_RESET);
> +
> +const struct reset_control_ops meson_reset_toggle_ops = {
> +	.reset		= meson_reset_level_toggle,
> +	.assert		= meson_reset_assert,
> +	.deassert	= meson_reset_deassert,
> +	.status		= meson_reset_status,
> +};
> +EXPORT_SYMBOL_NS_GPL(meson_reset_toggle_ops, MESON_RESET);
>   
>   int meson_reset_probe(struct device *dev, struct regmap *map,
>   		      const struct meson_reset_param *param)
> @@ -105,7 +126,7 @@ int meson_reset_probe(struct device *dev, struct regmap *map,
>   	data->map = map;
>   	data->rcdev.owner = dev->driver->owner;
>   	data->rcdev.nr_resets = param->reset_num;
> -	data->rcdev.ops = &meson_reset_ops;
> +	data->rcdev.ops = data->param->reset_ops;
>   	data->rcdev.of_node = dev->of_node;
>   
>   	return devm_reset_controller_register(dev, &data->rcdev);
> diff --git a/drivers/reset/amlogic/reset-meson-pltf.c b/drivers/reset/amlogic/reset-meson-pltf.c
> index 97e933b4aa34..2bc3ea42c6ec 100644
> --- a/drivers/reset/amlogic/reset-meson-pltf.c
> +++ b/drivers/reset/amlogic/reset-meson-pltf.c
> @@ -16,6 +16,7 @@
>   #include "reset-meson.h"
>   
>   static const struct meson_reset_param meson8b_param = {
> +	.reset_ops	= &meson_reset_ops,
>   	.reset_num	= 256,
>   	.reset_offset	= 0x0,
>   	.level_offset	= 0x7c,
> @@ -23,6 +24,7 @@ static const struct meson_reset_param meson8b_param = {
>   };
>   
>   static const struct meson_reset_param meson_a1_param = {
> +	.reset_ops	= &meson_reset_ops,
>   	.reset_num	= 96,
>   	.reset_offset	= 0x0,
>   	.level_offset	= 0x40,
> @@ -30,6 +32,7 @@ static const struct meson_reset_param meson_a1_param = {
>   };
>   
>   static const struct meson_reset_param meson_s4_param = {
> +	.reset_ops	= &meson_reset_ops,
>   	.reset_num	= 192,
>   	.reset_offset	= 0x0,
>   	.level_offset	= 0x40,
> diff --git a/drivers/reset/amlogic/reset-meson.h b/drivers/reset/amlogic/reset-meson.h
> index c2e8a5cf2e46..5ab2ac9ab2e5 100644
> --- a/drivers/reset/amlogic/reset-meson.h
> +++ b/drivers/reset/amlogic/reset-meson.h
> @@ -12,6 +12,7 @@
>   #include <linux/reset-controller.h>
>   
>   struct meson_reset_param {
> +	const struct reset_control_ops *reset_ops;
>   	unsigned int reset_num;
>   	unsigned int reset_offset;
>   	unsigned int level_offset;
> @@ -21,4 +22,7 @@ struct meson_reset_param {
>   int meson_reset_probe(struct device *dev, struct regmap *map,
>   		      const struct meson_reset_param *param);
>   
> +extern const struct reset_control_ops meson_reset_ops;
> +extern const struct reset_control_ops meson_reset_toggle_ops;
> +
>   #endif /* __MESON_RESET_CORE_H */
> diff --git a/include/soc/amlogic/meson-auxiliary-reset.h b/include/soc/amlogic/meson-auxiliary-reset.h
> new file mode 100644
> index 000000000000..f70dd864ef6a
> --- /dev/null
> +++ b/include/soc/amlogic/meson-auxiliary-reset.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SOC_AMLOGIC_MESON_AUX_RESET_H
> +#define __SOC_AMLOGIC_MESON_AUX_RESET_H
> +
> +#include <linux/err.h>
> +
> +struct device;
> +struct regmap;
> +
> +#if IS_ENABLED(CONFIG_RESET_MESON_AUX)
> +int devm_meson_rst_aux_register(struct device *dev,
> +				struct regmap *map,
> +				const char *adev_name);
> +#else
> +static inline int devm_meson_rst_aux_register(struct device *dev,
> +					      struct regmap *map,
> +					      const char *adev_name)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#endif /* __SOC_AMLOGIC_MESON_AUX_RESET_H */


