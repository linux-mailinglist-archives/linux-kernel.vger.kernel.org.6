Return-Path: <linux-kernel+bounces-292546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 518C79570E9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C92B24726
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908171779B1;
	Mon, 19 Aug 2024 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XcYdq1ys"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B017837D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086163; cv=none; b=ZcTVJqktE/NLktmpqAobIHxiC2SPWlIvUQp+Bg9U9An2uDrxaLqGTNoP8uil0DOAA5d7hxB7KeXzeW8LA2nAJcJGqCOZxd1rAqxz4tqzWK0xJVS6cNYxcJII5E16sI18n/aqLQO5Kg7E0ATGyyRYSOZ1pmDOPjRKIaoA9zgo29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086163; c=relaxed/simple;
	bh=n0tibAdi3rRW2l9oArRrL5e7od0H83vW3GZq20Mfkss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a7qptjvNWShdJ2C7R5MBUotlb6KGLbPcz+EeCcv7QPAOoCO9xElBfLc4yFY4Y4Vuvz7wDrN7zpu8uoDIPLVlaARV9KmCwQ5n3X4k0m/YJuz5DeQ+n6tnz1Va44aKAMD5lT++OUkJta6fgqFnDJkbWGLw82ya7xXdhNFdTQ0P+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XcYdq1ys; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371b015572cso1726202f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724086159; x=1724690959; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sio7EcZBvhMrVmurBCEshWjdi1VcJUT2ygK9dXaZ6/0=;
        b=XcYdq1ys3xgm0Y0wEFiJAeceZAFMQsTsW3m5B/AUF5/vCS3fMQFGOIRYndFZbnQuVE
         B2v3BIhvL/ewr/HRYvBuKOT5Oz8GZuryyprFjSY26T+A2qB5U6bnmhKGNCZzPm0h91aZ
         f0zH5i/NH8Uh3B02e5HPZnHHPLGnK+5zDyJ9njLpPE0lkZjjAS5MuLVz2mmwsgdLKupr
         BMdIee2/L9YcTbJ6SYWlzQKX0FfAUeZfWxUFjiNg4Jbd6sdvjX0BJ1gsmzYjST4zcPNk
         SnoN5hbNRxvaIdN7kQLgsQ2zyhFMTjxJtQi81dgZbbmbCRL+vaRryZL7shKcrDkhnB1/
         TvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086159; x=1724690959;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sio7EcZBvhMrVmurBCEshWjdi1VcJUT2ygK9dXaZ6/0=;
        b=KTbHL1eC/kRGBGmbm3xdHLeXG7FPmdtEmr0a3yI/kBGzVxMOC3VzkR9M269d7/eNq5
         /QhbVHlTGRvIik0bKjINocBkgPh2JIS6N2J+BC30KcMPb1KGUgZZST3h9ihkINmlAroQ
         wr73Ar96x75ohTj3VutDz/6fDIkPkSjA0KUzBTwQuKXW9wh72VsPDy59bRvBMPfnPZMo
         3ouElMHb4jd2fgeboAPH68AJkHp5Whxf8cWosCGyHC6/Scip/ZxTRMrRZjCFDXcwY7bE
         a3xz2vwmcrYdTJkY0ysT2suvwBqlTzdS6RtCEPQ7PrBm6uD+LOt6+R9NH6fU6Lxy2PAw
         FVWw==
X-Forwarded-Encrypted: i=1; AJvYcCXkWr/n4XmBNnWtcSC7vEPyXmpo9+kiFuh7+IAru8f5DRZhTymMhAm4RUQbEBjnEeE08fzjI1K1Hv0lX1OMMoBQJ23o9OzqCJH154D/
X-Gm-Message-State: AOJu0YytIq7+VSC7SQ6qwC4j+bvRkgY37culGfQaccNxmx4c9kIkXpsj
	xnM1TOTZFgShC0wVfegPLsYni+jALrDTTD4Xk/At7Alz2H7xpnNbx5Ep50x6p9Y=
X-Google-Smtp-Source: AGHT+IG9SCmqztz/GPkBbt+X9itkCSqB56ynsjcfSAB2JT0ZUQq+946cPo0gChjft5vwSw7Zfk9k5A==
X-Received: by 2002:a5d:4532:0:b0:36b:c305:5902 with SMTP id ffacd0b85a97d-3719432b55dmr9795462f8f.17.1724086158655;
        Mon, 19 Aug 2024 09:49:18 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:db8f:43f4:9b2e:fb1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37195650163sm8911596f8f.98.2024.08.19.09.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:49:18 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,  Stephen Boyd
 <sboyd@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 8/9] reset: amlogic: split the device core and
 platform probe
In-Reply-To: <812c6ddc-1929-46c4-bac7-4bd0f5ccc213@linaro.org> (Neil
	Armstrong's message of "Mon, 19 Aug 2024 18:33:58 +0200")
References: <20240808102742.4095904-1-jbrunet@baylibre.com>
	<20240808102742.4095904-9-jbrunet@baylibre.com>
	<812c6ddc-1929-46c4-bac7-4bd0f5ccc213@linaro.org>
Date: Mon, 19 Aug 2024 18:49:17 +0200
Message-ID: <1jsev0wj8y.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 19 Aug 2024 at 18:33, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 08/08/2024 12:27, Jerome Brunet wrote:
>> To prepare the addition of the auxiliary device support, split
>> out the device core function from the probe of the platform device.
>> The device core function will be common to both the platform and
>> auxiliary
>> driver.
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>   drivers/reset/amlogic/Kconfig                 |  10 +-
>>   drivers/reset/amlogic/Makefile                |   3 +-
>>   .../{reset-meson.c => reset-meson-core.c}     | 101 +++---------------
>>   drivers/reset/amlogic/reset-meson-pltf.c      |  92 ++++++++++++++++
>
> Are we still in 1983 ?

I don't quite get that remark or how it is helping the review.

> please use reset-meson-platform and drop pltf completely

You are requesting auxiliary -> aux on the patch.
So which one will it be ?

>
>>   drivers/reset/amlogic/reset-meson.h           |  24 +++++
>>   5 files changed, 143 insertions(+), 87 deletions(-)
>>   rename drivers/reset/amlogic/{reset-meson.c => reset-meson-core.c} (51%)
>>   create mode 100644 drivers/reset/amlogic/reset-meson-pltf.c
>>   create mode 100644 drivers/reset/amlogic/reset-meson.h
>> diff --git a/drivers/reset/amlogic/Kconfig
>> b/drivers/reset/amlogic/Kconfig
>> index 7ed9cf50f038..04c7be0f3165 100644
>> --- a/drivers/reset/amlogic/Kconfig
>> +++ b/drivers/reset/amlogic/Kconfig
>> @@ -1,9 +1,15 @@
>> +config RESET_MESON_CORE
>> +	tristate
>> +	select REGMAP
>> +
>>   config RESET_MESON
>> -	tristate "Meson Reset Driver"
>> +	tristate "Meson Reset Platform Driver"
>>   	depends on ARCH_MESON || COMPILE_TEST
>>   	default ARCH_MESON
>> +	select REGMAP_MMIO
>> +	select RESET_MESON_CORE
>>   	help
>> -	  This enables the reset driver for Amlogic Meson SoCs.
>> +	  This enables the reset platform driver for Amlogic SoCs.
>>     config RESET_MESON_AUDIO_ARB
>>   	tristate "Meson Audio Memory Arbiter Reset Driver"
>> diff --git a/drivers/reset/amlogic/Makefile b/drivers/reset/amlogic/Makefile
>> index 55509fc78513..0f8f9121b566 100644
>> --- a/drivers/reset/amlogic/Makefile
>> +++ b/drivers/reset/amlogic/Makefile
>> @@ -1,2 +1,3 @@
>> -obj-$(CONFIG_RESET_MESON) += reset-meson.o
>> +obj-$(CONFIG_RESET_MESON) += reset-meson-pltf.o
>> +obj-$(CONFIG_RESET_MESON_CORE) += reset-meson-core.o
>>   obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
>> diff --git a/drivers/reset/amlogic/reset-meson.c b/drivers/reset/amlogic/reset-meson-core.c
>> similarity index 51%
>> rename from drivers/reset/amlogic/reset-meson.c
>> rename to drivers/reset/amlogic/reset-meson-core.c
>> index b16d9c32adb1..ea4fc562f7e6 100644
>> --- a/drivers/reset/amlogic/reset-meson.c
>> +++ b/drivers/reset/amlogic/reset-meson-core.c
>> @@ -1,27 +1,17 @@
>>   // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>>   /*
>> - * Amlogic Meson Reset Controller driver
>> + * Amlogic Meson Reset core functions
>>    *
>> - * Copyright (c) 2016 BayLibre, SAS.
>> - * Author: Neil Armstrong <narmstrong@baylibre.com>
>
> Hmmm no, I'm still an author
>
>> + * Copyright (c) 2024 BayLibre, SAS.
>
> And Baylibre's Copyright is still from 2016, so use 2016-2024 in this case
>
>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>>    */
>> -#include <linux/err.h>
>> -#include <linux/init.h>
>> -#include <linux/io.h>
>> -#include <linux/of.h>
>> +
>> +#include <linux/device.h>
>>   #include <linux/module.h>
>> -#include <linux/platform_device.h>
>>   #include <linux/regmap.h>
>>   #include <linux/reset-controller.h>
>> -#include <linux/slab.h>
>> -#include <linux/types.h>
>> -
>> -struct meson_reset_param {
>> -	unsigned int reset_num;
>> -	unsigned int reset_offset;
>> -	unsigned int level_offset;
>> -	bool level_low_reset;
>> -};
>> +
>> +#include "reset-meson.h"
>>     struct meson_reset {
>>   	const struct meson_reset_param *param;
>> @@ -102,84 +92,27 @@ static const struct reset_control_ops meson_reset_ops = {
>>   	.status		= meson_reset_status,
>>   };
>>   -static const struct meson_reset_param meson8b_param = {
>> -	.reset_num	= 256,
>> -	.reset_offset	= 0x0,
>> -	.level_offset	= 0x7c,
>> -	.level_low_reset = true,
>> -};
>> -
>> -static const struct meson_reset_param meson_a1_param = {
>> -	.reset_num	= 96,
>> -	.reset_offset	= 0x0,
>> -	.level_offset	= 0x40,
>> -	.level_low_reset = true,
>> -};
>> -
>> -static const struct meson_reset_param meson_s4_param = {
>> -	.reset_num	= 192,
>> -	.reset_offset	= 0x0,
>> -	.level_offset	= 0x40,
>> -	.level_low_reset = true,
>> -};
>> -
>> -static const struct of_device_id meson_reset_dt_ids[] = {
>> -	 { .compatible = "amlogic,meson8b-reset",    .data = &meson8b_param},
>> -	 { .compatible = "amlogic,meson-gxbb-reset", .data = &meson8b_param},
>> -	 { .compatible = "amlogic,meson-axg-reset",  .data = &meson8b_param},
>> -	 { .compatible = "amlogic,meson-a1-reset",   .data = &meson_a1_param},
>> -	 { .compatible = "amlogic,meson-s4-reset",   .data = &meson_s4_param},
>> -	 { .compatible = "amlogic,c3-reset",   .data = &meson_s4_param},
>> -	 { /* sentinel */ },
>> -};
>> -MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
>> -
>> -static const struct regmap_config regmap_config = {
>> -	.reg_bits   = 32,
>> -	.val_bits   = 32,
>> -	.reg_stride = 4,
>> -};
>> -
>> -static int meson_reset_probe(struct platform_device *pdev)
>> +int meson_reset_probe(struct device *dev, struct regmap *map,
>> +		      const struct meson_reset_param *param)
>>   {
>> -	struct device *dev = &pdev->dev;
>>   	struct meson_reset *data;
>> -	void __iomem *base;
>>     	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>   	if (!data)
>>   		return -ENOMEM;
>>   -	base = devm_platform_ioremap_resource(pdev, 0);
>> -	if (IS_ERR(base))
>> -		return PTR_ERR(base);
>> -
>> -	data->param = device_get_match_data(dev);
>> -	if (!data->param)
>> -		return -ENODEV;
>> -
>> -	data->map = devm_regmap_init_mmio(dev, base, &regmap_config);
>> -	if (IS_ERR(data->map))
>> -		return dev_err_probe(dev, PTR_ERR(data->map),
>> -				     "can't init regmap mmio region\n");
>> -
>> -	data->rcdev.owner = THIS_MODULE;
>> -	data->rcdev.nr_resets = data->param->reset_num;
>> +	data->param = param;
>> +	data->map = map;
>> +	data->rcdev.owner = dev->driver->owner;
>> +	data->rcdev.nr_resets = param->reset_num;
>>   	data->rcdev.ops = &meson_reset_ops;
>>   	data->rcdev.of_node = dev->of_node;
>>     	return devm_reset_controller_register(dev, &data->rcdev);
>>   }
>> +EXPORT_SYMBOL_NS_GPL(meson_reset_probe, MESON_RESET);
>>   -static struct platform_driver meson_reset_driver = {
>> -	.probe	= meson_reset_probe,
>> -	.driver = {
>> -		.name		= "meson_reset",
>> -		.of_match_table	= meson_reset_dt_ids,
>> -	},
>> -};
>> -module_platform_driver(meson_reset_driver);
>> -
>> -MODULE_DESCRIPTION("Amlogic Meson Reset Controller driver");
>> +MODULE_DESCRIPTION("Amlogic Meson Reset Core function");
>>   MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>> -MODULE_LICENSE("Dual BSD/GPL");
>> +MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
>> +MODULE_IMPORT_NS(MESON_RESET);
>> diff --git a/drivers/reset/amlogic/reset-meson-pltf.c b/drivers/reset/amlogic/reset-meson-pltf.c
>> new file mode 100644
>> index 000000000000..97e933b4aa34
>> --- /dev/null
>> +++ b/drivers/reset/amlogic/reset-meson-pltf.c
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>> +/*
>> + * Amlogic Meson Reset platform driver
>> + *
>> + * Copyright (c) 2016 BayLibre, SAS.
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset-controller.h>
>> +
>> +#include "reset-meson.h"
>> +
>> +static const struct meson_reset_param meson8b_param = {
>> +	.reset_num	= 256,
>> +	.reset_offset	= 0x0,
>> +	.level_offset	= 0x7c,
>> +	.level_low_reset = true,
>> +};
>> +
>> +static const struct meson_reset_param meson_a1_param = {
>> +	.reset_num	= 96,
>> +	.reset_offset	= 0x0,
>> +	.level_offset	= 0x40,
>> +	.level_low_reset = true,
>> +};
>> +
>> +static const struct meson_reset_param meson_s4_param = {
>> +	.reset_num	= 192,
>> +	.reset_offset	= 0x0,
>> +	.level_offset	= 0x40,
>> +	.level_low_reset = true,
>> +};
>> +
>> +static const struct of_device_id meson_reset_dt_ids[] = {
>> +	 { .compatible = "amlogic,meson8b-reset",    .data = &meson8b_param},
>> +	 { .compatible = "amlogic,meson-gxbb-reset", .data = &meson8b_param},
>> +	 { .compatible = "amlogic,meson-axg-reset",  .data = &meson8b_param},
>> +	 { .compatible = "amlogic,meson-a1-reset",   .data = &meson_a1_param},
>> +	 { .compatible = "amlogic,meson-s4-reset",   .data = &meson_s4_param},
>> +	 { .compatible = "amlogic,c3-reset",   .data = &meson_s4_param},
>> +	 { /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
>> +
>> +static const struct regmap_config regmap_config = {
>> +	.reg_bits   = 32,
>> +	.val_bits   = 32,
>> +	.reg_stride = 4,
>> +};
>> +
>> +static int meson_reset_pltf_probe(struct platform_device *pdev)
>> +{
>> +	const struct meson_reset_param *param;
>> +	struct device *dev = &pdev->dev;
>> +	struct regmap *map;
>> +	void __iomem *base;
>> +
>> +	base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	param = device_get_match_data(dev);
>> +	if (!param)
>> +		return -ENODEV;
>> +
>> +	map = devm_regmap_init_mmio(dev, base, &regmap_config);
>> +	if (IS_ERR(map))
>> +		return dev_err_probe(dev, PTR_ERR(map),
>> +				     "can't init regmap mmio region\n");
>> +
>> +	return meson_reset_probe(dev, map, param);
>> +}
>> +
>> +static struct platform_driver meson_reset_pltf_driver = {
>> +	.probe	= meson_reset_pltf_probe,
>> +	.driver = {
>> +		.name		= "meson_reset",
>> +		.of_match_table	= meson_reset_dt_ids,
>> +	},
>> +};
>> +module_platform_driver(meson_reset_pltf_driver);
>> +
>> +MODULE_DESCRIPTION("Amlogic Meson Reset Platform Controller driver");
>> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>> +MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
>> +MODULE_LICENSE("Dual BSD/GPL");
>> +MODULE_IMPORT_NS(MESON_RESET);
>> diff --git a/drivers/reset/amlogic/reset-meson.h b/drivers/reset/amlogic/reset-meson.h
>> new file mode 100644
>> index 000000000000..c2e8a5cf2e46
>> --- /dev/null
>> +++ b/drivers/reset/amlogic/reset-meson.h
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
>> +/*
>> + * Copyright (c) 2024 BayLibre, SAS.
>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>> + */
>> +
>> +#ifndef __MESON_RESET_CORE_H
>> +#define __MESON_RESET_CORE_H
>> +
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset-controller.h>
>> +
>> +struct meson_reset_param {
>> +	unsigned int reset_num;
>> +	unsigned int reset_offset;
>> +	unsigned int level_offset;
>> +	bool level_low_reset;
>> +};
>> +
>> +int meson_reset_probe(struct device *dev, struct regmap *map,
>> +		      const struct meson_reset_param *param);
>> +
>> +#endif /* __MESON_RESET_CORE_H */

-- 
Jerome

