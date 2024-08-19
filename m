Return-Path: <linux-kernel+bounces-292561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF801957168
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18A7BB28C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB5218757F;
	Mon, 19 Aug 2024 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7SvZSC/"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681EEEA5
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086660; cv=none; b=N1jbxDr5/iTYW72ndYHa4Lr17rbkHUOZEa8AejDa+23tWoJivLR+ozVBSri0VuAYQ1i3j+HUVHMofDRXr6F/CMYWAkr6RTWMJ8Gug1Eh2qqklHIWZDCYt/1flmrh2uAMgiCqeBNMjGgBJePX9S0Q9sAmfw3xs9SOgkmL5i3v/mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086660; c=relaxed/simple;
	bh=YhM3rf1sYlO7HYRnFwR044QkL6GfZRvsQU1G83aVnis=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fKk2rz64gYvXAeNY8gZOtzO8E/VQ/9Zu0m5ouSY6jRGwoJTC3M3UPMEaowc64zhwn+mKTQGy0bGNpV7q/RlLbYLsQpvqmtOdkm1G+m8ANZf91oDWrUyppIC1+xJuVJ/AG3Ew1gWDBG7phGQuGc1QHIDe/6Kx8XIBpzOeLaYANPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z7SvZSC/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42816ca797fso37248905e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724086656; x=1724691456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkmWx1T/xFbdg/+QOVqmltW5IRqzDfOQZPULXW+vOEg=;
        b=Z7SvZSC/wIfzEaz+ds04fBwzXcujflNtyIAF0RjG1wI7/73JvEP4zqF/hxnMbQPhYj
         D0gFdnzBtrFs668VHJtiZQPYlinv0hk2ElkhPCiN5JvDPFOXNB2AgSHFUyb3kK1uYN5L
         +F1p/PyajTRq5ml+MHbRLKRNkfsY5r5vO58DcuQoyDfJ0uEYALgUVinT+ykAFB6QAtJc
         y16OAAHEqNX76jT3Nm14H8qEfzLwU5zyf3uJvQaCoYyz2cyhJmN+gBeElpKJgiEOArIW
         sRoRnXXtJKMv6TW1KSmWUTx7/1aciWF9Ojuwl+O72pUm/YWag0DeyD68BOb7AQBf3h3T
         O0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086656; x=1724691456;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xkmWx1T/xFbdg/+QOVqmltW5IRqzDfOQZPULXW+vOEg=;
        b=jOW4wHSzfo54EXVuHDfvHceBKfR0ye75jIaBn6pw78R17a3bxsxiHYdE0KY9094vUy
         2iyIO408uAaa7K7J5MRBxFktp0kEs6pgpwDBeqXGtSBmFro1szaRipZsFPPizCYAtp6z
         iKdSdQo/SN7dGjZnIjt5unas1x+W2GnBl6y9dxZWDb6QBh1/Spl8K0WifF3jjY6xqcI5
         Ms8CXe37DrYnducLv3k33YJ+1TmX6Kef/h/TxTT3LvfkiziO3XZ0CtdXA5FfbPuTmVDy
         LfrzU5KmNdNE/E4RcXmnsRPAf4MRH9/npo1pjpHEnw/uAdsfUqEaI2nDk1SJIm6Tjwz/
         oqAA==
X-Forwarded-Encrypted: i=1; AJvYcCW5EKGz2HndETpHdvwJYpf/zQNVDGsuRuPpxkMaD3XWu6aUMsCm4qECLvN7ry9qGQqhUbIwIL6W81qcCn51YcKEswrSQFIHihxSdV18
X-Gm-Message-State: AOJu0YyEJiFafXFPa0+/+46NjYFjrzMIisMkIzPMC8ctK9T0Sz6VBSFD
	CDmVS6Zv2w8gIbGN5P6WCjelQWBvBe2Z7tfzaH8Gle7uhTG/XHGEQChWokru3LM=
X-Google-Smtp-Source: AGHT+IE3RR57TzBHmEjVdpp4iE/dZ1uPxTb/l/TwrLt0MCtG5O1We0DRWoicY0j/tgNhWs6aCbC2eA==
X-Received: by 2002:a5d:5e0c:0:b0:371:a844:d332 with SMTP id ffacd0b85a97d-371a844d589mr4303689f8f.46.1724086655383;
        Mon, 19 Aug 2024 09:57:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aabdesm10975263f8f.99.2024.08.19.09.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:57:34 -0700 (PDT)
Message-ID: <a0a06241-537d-4ffe-9921-4c79c4080044@linaro.org>
Date: Mon, 19 Aug 2024 18:57:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 8/9] reset: amlogic: split the device core and platform
 probe
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240808102742.4095904-1-jbrunet@baylibre.com>
 <20240808102742.4095904-9-jbrunet@baylibre.com>
 <812c6ddc-1929-46c4-bac7-4bd0f5ccc213@linaro.org>
 <1jsev0wj8y.fsf@starbuckisacylon.baylibre.com>
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
In-Reply-To: <1jsev0wj8y.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2024 18:49, Jerome Brunet wrote:
> On Mon 19 Aug 2024 at 18:33, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> On 08/08/2024 12:27, Jerome Brunet wrote:
>>> To prepare the addition of the auxiliary device support, split
>>> out the device core function from the probe of the platform device.
>>> The device core function will be common to both the platform and
>>> auxiliary
>>> driver.
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>> ---
>>>    drivers/reset/amlogic/Kconfig                 |  10 +-
>>>    drivers/reset/amlogic/Makefile                |   3 +-
>>>    .../{reset-meson.c => reset-meson-core.c}     | 101 +++---------------
>>>    drivers/reset/amlogic/reset-meson-pltf.c      |  92 ++++++++++++++++
>>
>> Are we still in 1983 ?
> 
> I don't quite get that remark or how it is helping the review.
> 
>> please use reset-meson-platform and drop pltf completely
> 
> You are requesting auxiliary -> aux on the patch.
> So which one will it be ?

`aux` is easy to read and understandable because written on all multimedia appliances
over the world for the last 40years, plft is not

> 
>>
>>>    drivers/reset/amlogic/reset-meson.h           |  24 +++++
>>>    5 files changed, 143 insertions(+), 87 deletions(-)
>>>    rename drivers/reset/amlogic/{reset-meson.c => reset-meson-core.c} (51%)
>>>    create mode 100644 drivers/reset/amlogic/reset-meson-pltf.c
>>>    create mode 100644 drivers/reset/amlogic/reset-meson.h
>>> diff --git a/drivers/reset/amlogic/Kconfig
>>> b/drivers/reset/amlogic/Kconfig
>>> index 7ed9cf50f038..04c7be0f3165 100644
>>> --- a/drivers/reset/amlogic/Kconfig
>>> +++ b/drivers/reset/amlogic/Kconfig
>>> @@ -1,9 +1,15 @@
>>> +config RESET_MESON_CORE
>>> +	tristate
>>> +	select REGMAP
>>> +
>>>    config RESET_MESON
>>> -	tristate "Meson Reset Driver"
>>> +	tristate "Meson Reset Platform Driver"
>>>    	depends on ARCH_MESON || COMPILE_TEST
>>>    	default ARCH_MESON
>>> +	select REGMAP_MMIO
>>> +	select RESET_MESON_CORE
>>>    	help
>>> -	  This enables the reset driver for Amlogic Meson SoCs.
>>> +	  This enables the reset platform driver for Amlogic SoCs.
>>>      config RESET_MESON_AUDIO_ARB
>>>    	tristate "Meson Audio Memory Arbiter Reset Driver"
>>> diff --git a/drivers/reset/amlogic/Makefile b/drivers/reset/amlogic/Makefile
>>> index 55509fc78513..0f8f9121b566 100644
>>> --- a/drivers/reset/amlogic/Makefile
>>> +++ b/drivers/reset/amlogic/Makefile
>>> @@ -1,2 +1,3 @@
>>> -obj-$(CONFIG_RESET_MESON) += reset-meson.o
>>> +obj-$(CONFIG_RESET_MESON) += reset-meson-pltf.o
>>> +obj-$(CONFIG_RESET_MESON_CORE) += reset-meson-core.o
>>>    obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
>>> diff --git a/drivers/reset/amlogic/reset-meson.c b/drivers/reset/amlogic/reset-meson-core.c
>>> similarity index 51%
>>> rename from drivers/reset/amlogic/reset-meson.c
>>> rename to drivers/reset/amlogic/reset-meson-core.c
>>> index b16d9c32adb1..ea4fc562f7e6 100644
>>> --- a/drivers/reset/amlogic/reset-meson.c
>>> +++ b/drivers/reset/amlogic/reset-meson-core.c
>>> @@ -1,27 +1,17 @@
>>>    // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>>>    /*
>>> - * Amlogic Meson Reset Controller driver
>>> + * Amlogic Meson Reset core functions
>>>     *
>>> - * Copyright (c) 2016 BayLibre, SAS.
>>> - * Author: Neil Armstrong <narmstrong@baylibre.com>
>>
>> Hmmm no, I'm still an author
>>
>>> + * Copyright (c) 2024 BayLibre, SAS.
>>
>> And Baylibre's Copyright is still from 2016, so use 2016-2024 in this case
>>
>>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>>>     */
>>> -#include <linux/err.h>
>>> -#include <linux/init.h>
>>> -#include <linux/io.h>
>>> -#include <linux/of.h>
>>> +
>>> +#include <linux/device.h>
>>>    #include <linux/module.h>
>>> -#include <linux/platform_device.h>
>>>    #include <linux/regmap.h>
>>>    #include <linux/reset-controller.h>
>>> -#include <linux/slab.h>
>>> -#include <linux/types.h>
>>> -
>>> -struct meson_reset_param {
>>> -	unsigned int reset_num;
>>> -	unsigned int reset_offset;
>>> -	unsigned int level_offset;
>>> -	bool level_low_reset;
>>> -};
>>> +
>>> +#include "reset-meson.h"
>>>      struct meson_reset {
>>>    	const struct meson_reset_param *param;
>>> @@ -102,84 +92,27 @@ static const struct reset_control_ops meson_reset_ops = {
>>>    	.status		= meson_reset_status,
>>>    };
>>>    -static const struct meson_reset_param meson8b_param = {
>>> -	.reset_num	= 256,
>>> -	.reset_offset	= 0x0,
>>> -	.level_offset	= 0x7c,
>>> -	.level_low_reset = true,
>>> -};
>>> -
>>> -static const struct meson_reset_param meson_a1_param = {
>>> -	.reset_num	= 96,
>>> -	.reset_offset	= 0x0,
>>> -	.level_offset	= 0x40,
>>> -	.level_low_reset = true,
>>> -};
>>> -
>>> -static const struct meson_reset_param meson_s4_param = {
>>> -	.reset_num	= 192,
>>> -	.reset_offset	= 0x0,
>>> -	.level_offset	= 0x40,
>>> -	.level_low_reset = true,
>>> -};
>>> -
>>> -static const struct of_device_id meson_reset_dt_ids[] = {
>>> -	 { .compatible = "amlogic,meson8b-reset",    .data = &meson8b_param},
>>> -	 { .compatible = "amlogic,meson-gxbb-reset", .data = &meson8b_param},
>>> -	 { .compatible = "amlogic,meson-axg-reset",  .data = &meson8b_param},
>>> -	 { .compatible = "amlogic,meson-a1-reset",   .data = &meson_a1_param},
>>> -	 { .compatible = "amlogic,meson-s4-reset",   .data = &meson_s4_param},
>>> -	 { .compatible = "amlogic,c3-reset",   .data = &meson_s4_param},
>>> -	 { /* sentinel */ },
>>> -};
>>> -MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
>>> -
>>> -static const struct regmap_config regmap_config = {
>>> -	.reg_bits   = 32,
>>> -	.val_bits   = 32,
>>> -	.reg_stride = 4,
>>> -};
>>> -
>>> -static int meson_reset_probe(struct platform_device *pdev)
>>> +int meson_reset_probe(struct device *dev, struct regmap *map,
>>> +		      const struct meson_reset_param *param)
>>>    {
>>> -	struct device *dev = &pdev->dev;
>>>    	struct meson_reset *data;
>>> -	void __iomem *base;
>>>      	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>>    	if (!data)
>>>    		return -ENOMEM;
>>>    -	base = devm_platform_ioremap_resource(pdev, 0);
>>> -	if (IS_ERR(base))
>>> -		return PTR_ERR(base);
>>> -
>>> -	data->param = device_get_match_data(dev);
>>> -	if (!data->param)
>>> -		return -ENODEV;
>>> -
>>> -	data->map = devm_regmap_init_mmio(dev, base, &regmap_config);
>>> -	if (IS_ERR(data->map))
>>> -		return dev_err_probe(dev, PTR_ERR(data->map),
>>> -				     "can't init regmap mmio region\n");
>>> -
>>> -	data->rcdev.owner = THIS_MODULE;
>>> -	data->rcdev.nr_resets = data->param->reset_num;
>>> +	data->param = param;
>>> +	data->map = map;
>>> +	data->rcdev.owner = dev->driver->owner;
>>> +	data->rcdev.nr_resets = param->reset_num;
>>>    	data->rcdev.ops = &meson_reset_ops;
>>>    	data->rcdev.of_node = dev->of_node;
>>>      	return devm_reset_controller_register(dev, &data->rcdev);
>>>    }
>>> +EXPORT_SYMBOL_NS_GPL(meson_reset_probe, MESON_RESET);
>>>    -static struct platform_driver meson_reset_driver = {
>>> -	.probe	= meson_reset_probe,
>>> -	.driver = {
>>> -		.name		= "meson_reset",
>>> -		.of_match_table	= meson_reset_dt_ids,
>>> -	},
>>> -};
>>> -module_platform_driver(meson_reset_driver);
>>> -
>>> -MODULE_DESCRIPTION("Amlogic Meson Reset Controller driver");
>>> +MODULE_DESCRIPTION("Amlogic Meson Reset Core function");
>>>    MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>>> -MODULE_LICENSE("Dual BSD/GPL");
>>> +MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
>>> +MODULE_IMPORT_NS(MESON_RESET);
>>> diff --git a/drivers/reset/amlogic/reset-meson-pltf.c b/drivers/reset/amlogic/reset-meson-pltf.c
>>> new file mode 100644
>>> index 000000000000..97e933b4aa34
>>> --- /dev/null
>>> +++ b/drivers/reset/amlogic/reset-meson-pltf.c
>>> @@ -0,0 +1,92 @@
>>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>>> +/*
>>> + * Amlogic Meson Reset platform driver
>>> + *
>>> + * Copyright (c) 2016 BayLibre, SAS.
>>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>>> + */
>>> +#include <linux/err.h>
>>> +#include <linux/io.h>
>>> +#include <linux/of.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/reset-controller.h>
>>> +
>>> +#include "reset-meson.h"
>>> +
>>> +static const struct meson_reset_param meson8b_param = {
>>> +	.reset_num	= 256,
>>> +	.reset_offset	= 0x0,
>>> +	.level_offset	= 0x7c,
>>> +	.level_low_reset = true,
>>> +};
>>> +
>>> +static const struct meson_reset_param meson_a1_param = {
>>> +	.reset_num	= 96,
>>> +	.reset_offset	= 0x0,
>>> +	.level_offset	= 0x40,
>>> +	.level_low_reset = true,
>>> +};
>>> +
>>> +static const struct meson_reset_param meson_s4_param = {
>>> +	.reset_num	= 192,
>>> +	.reset_offset	= 0x0,
>>> +	.level_offset	= 0x40,
>>> +	.level_low_reset = true,
>>> +};
>>> +
>>> +static const struct of_device_id meson_reset_dt_ids[] = {
>>> +	 { .compatible = "amlogic,meson8b-reset",    .data = &meson8b_param},
>>> +	 { .compatible = "amlogic,meson-gxbb-reset", .data = &meson8b_param},
>>> +	 { .compatible = "amlogic,meson-axg-reset",  .data = &meson8b_param},
>>> +	 { .compatible = "amlogic,meson-a1-reset",   .data = &meson_a1_param},
>>> +	 { .compatible = "amlogic,meson-s4-reset",   .data = &meson_s4_param},
>>> +	 { .compatible = "amlogic,c3-reset",   .data = &meson_s4_param},
>>> +	 { /* sentinel */ },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
>>> +
>>> +static const struct regmap_config regmap_config = {
>>> +	.reg_bits   = 32,
>>> +	.val_bits   = 32,
>>> +	.reg_stride = 4,
>>> +};
>>> +
>>> +static int meson_reset_pltf_probe(struct platform_device *pdev)
>>> +{
>>> +	const struct meson_reset_param *param;
>>> +	struct device *dev = &pdev->dev;
>>> +	struct regmap *map;
>>> +	void __iomem *base;
>>> +
>>> +	base = devm_platform_ioremap_resource(pdev, 0);
>>> +	if (IS_ERR(base))
>>> +		return PTR_ERR(base);
>>> +
>>> +	param = device_get_match_data(dev);
>>> +	if (!param)
>>> +		return -ENODEV;
>>> +
>>> +	map = devm_regmap_init_mmio(dev, base, &regmap_config);
>>> +	if (IS_ERR(map))
>>> +		return dev_err_probe(dev, PTR_ERR(map),
>>> +				     "can't init regmap mmio region\n");
>>> +
>>> +	return meson_reset_probe(dev, map, param);
>>> +}
>>> +
>>> +static struct platform_driver meson_reset_pltf_driver = {
>>> +	.probe	= meson_reset_pltf_probe,
>>> +	.driver = {
>>> +		.name		= "meson_reset",
>>> +		.of_match_table	= meson_reset_dt_ids,
>>> +	},
>>> +};
>>> +module_platform_driver(meson_reset_pltf_driver);
>>> +
>>> +MODULE_DESCRIPTION("Amlogic Meson Reset Platform Controller driver");
>>> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>>> +MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
>>> +MODULE_LICENSE("Dual BSD/GPL");
>>> +MODULE_IMPORT_NS(MESON_RESET);
>>> diff --git a/drivers/reset/amlogic/reset-meson.h b/drivers/reset/amlogic/reset-meson.h
>>> new file mode 100644
>>> index 000000000000..c2e8a5cf2e46
>>> --- /dev/null
>>> +++ b/drivers/reset/amlogic/reset-meson.h
>>> @@ -0,0 +1,24 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
>>> +/*
>>> + * Copyright (c) 2024 BayLibre, SAS.
>>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>>> + */
>>> +
>>> +#ifndef __MESON_RESET_CORE_H
>>> +#define __MESON_RESET_CORE_H
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/reset-controller.h>
>>> +
>>> +struct meson_reset_param {
>>> +	unsigned int reset_num;
>>> +	unsigned int reset_offset;
>>> +	unsigned int level_offset;
>>> +	bool level_low_reset;
>>> +};
>>> +
>>> +int meson_reset_probe(struct device *dev, struct regmap *map,
>>> +		      const struct meson_reset_param *param);
>>> +
>>> +#endif /* __MESON_RESET_CORE_H */
> 


