Return-Path: <linux-kernel+bounces-327662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D09778FD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBC11C24FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53BF1B12E7;
	Fri, 13 Sep 2024 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T9rip408"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF93E143C40
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726210410; cv=none; b=rv4FvMS6G8c48z7QxodpQKGjMlMsD495BcujSLmKXiSm3V609L0g0yV0Xi0Djt+QY8D9uYO3nYK6AynhehrzoX/QPIYDvZKX8Mh+9LRSvvwK9nLGxOfU/77z7WAWk9uaEk4ah3K/MMvM7W8+LPAWtzwiowdNRm9GE9q+1h+tmKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726210410; c=relaxed/simple;
	bh=+kER8xitWJszH/a1OjrkxLTo9oWWQKr79yE3ek1aStw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZK/YrUMW7o07KlhLelgg8rhL9dr1rl/OslH9JrG6ljDPVGI4OD52aOjV7AidZ56qnJehCKETmH4VYxxG6oPCUEXv4dQcS4PJ2AYMsqDyBHm3ORKQ9sTduA6a1rHVBI4XXe827JYjbny+yOLLX5btxn3TCLpz4QtppJTKYjys3HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T9rip408; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5365aec6fc1so2054918e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726210404; x=1726815204; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/JVmumvAmhH4T2M2SYhr9R81Y5mg2XZZPfgi7X4P4s=;
        b=T9rip408P7+UozYJs5rQjf9iZG1thUe8raupKkABAcq0H6DKAqmYxC4N02wZyLiDV7
         DOHOStNacepM4lqFhF54EewQVN0atvfTJfVv08cA+wW93zr7xZUExJodKTiFS3FCUUKN
         iXuiD2wCFoKt5NwXNq+AVR4e6KhoGssV3GK4YYsGdZEHPYceKKWTJXZHWJ7kdnSbRTIs
         /YTQcz5i3XnkWSRON/6PId9P3BpH78chPEbcjMWqHXSbaDzBP0AjzgExW7AZVU32qv7B
         zfLdtN36Ui4yMl5UiY9Ra5BzPYZgxvhSIUdhlZXHflLb7YnBrS2QAavRbHSVOReILQDj
         ln0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726210404; x=1726815204;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/JVmumvAmhH4T2M2SYhr9R81Y5mg2XZZPfgi7X4P4s=;
        b=VYEsaHHgBzAtLIEZTVXz+qDNgzXUa1tAKxCyYolyOeWfoEs4kKwOLAD47/w/8ZEzeJ
         K0TMGkgu9svdt3jd7hLLtDSZf7DGhW3FErpr/zJNWKDdk0Ooj8fHp41nApH57aj11Muq
         YVVd5iol59Y1RJwVaWyvofFM1aEwIxx8NMEBXQfcCzsCxZGOzaaPFG2RHqj7aQjVT/jx
         ObiSTmkMHonajsYLsJn037Lwufqrq9kv1g02X7ZlBgqylroz3C0eNJ7UfO895DycAuoE
         dqHbHOVC/KfMC5PzzW0al4j0VSaXlhAbTcGX3elyjWupwQMEHpuPx5fPzOZ1sPld18Pq
         nxLw==
X-Forwarded-Encrypted: i=1; AJvYcCXvsyUxRbCWfUDpXGXIPEZ2QuZ/5OdqcO+YBOxD+fA4a+XyKXXwSYlM3+BTKWc/rRi7/3u8Doyed2IGV2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXTiwEgB0ccM9jng3Nuzu8UN3pCeqPuj7Tvw4wLh3D9ZXggKa
	PcHEX6ygPuzJEjbfIqCVJekiT9UVqs2NMKMqalfM2tgXJZ/1taUAKJDnpfDU+bY=
X-Google-Smtp-Source: AGHT+IHjjlfV76zJQFOUoO0v8dhF0Bl3CQ4RiUDYruhQ4SFj0zyKwm9aj2oXnuAxIJ6qQTQKV6bSlA==
X-Received: by 2002:a05:6512:6ce:b0:534:36bf:b622 with SMTP id 2adb3069b0e04-53678ffa374mr2717302e87.61.1726210402875;
        Thu, 12 Sep 2024 23:53:22 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:9766:a21e:6656:7a28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05d5dbsm13450095e9.13.2024.09.12.23.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 23:53:22 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,  Jiucheng Xu
 <jiucheng.xu@amlogic.com>,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 8/9] reset: amlogic: split the device core and
 platform probe
In-Reply-To: <8cb81058c8f45e378675e078e296336a2cf74308.camel@pengutronix.de>
	(Philipp Zabel's message of "Thu, 12 Sep 2024 10:12:14 +0200")
References: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
	<20240910-meson-rst-aux-v5-8-60be62635d3e@baylibre.com>
	<8cb81058c8f45e378675e078e296336a2cf74308.camel@pengutronix.de>
Date: Fri, 13 Sep 2024 08:53:21 +0200
Message-ID: <1jldzwkpsu.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 12 Sep 2024 at 10:12, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> On Di, 2024-09-10 at 18:32 +0200, Jerome Brunet wrote:
>> To prepare the addition of the auxiliary device support, split
>> out the device coomon functions from the probe of the platform device.
>> 
>> The device core function will be common to both the platform and auxiliary
>> driver.
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/reset/amlogic/Kconfig              |   7 +-
>>  drivers/reset/amlogic/Makefile             |   1 +
>>  drivers/reset/amlogic/reset-meson-common.c | 121 ++++++++++++++++++++++++++++
>>  drivers/reset/amlogic/reset-meson.c        | 122 ++++-------------------------
>>  drivers/reset/amlogic/reset-meson.h        |  24 ++++++
>>  5 files changed, 167 insertions(+), 108 deletions(-)
>> 
>> diff --git a/drivers/reset/amlogic/Kconfig b/drivers/reset/amlogic/Kconfig
>> index 532e6a4f7865..1d77987088f4 100644
>> --- a/drivers/reset/amlogic/Kconfig
>> +++ b/drivers/reset/amlogic/Kconfig
>> @@ -1,10 +1,15 @@
>> +config RESET_MESON_COMMON
>> +	tristate
>> +	select REGMAP
>> +
>>  config RESET_MESON
>>  	tristate "Meson Reset Driver"
>>  	depends on ARCH_MESON || COMPILE_TEST
>>  	default ARCH_MESON
>>  	select REGMAP_MMIO
>> +	select RESET_MESON_COMMON
>>  	help
>> -	  This enables the reset driver for Amlogic Meson SoCs.
>> +	  This enables the reset driver for Amlogic SoCs.
>>  
>>  config RESET_MESON_AUDIO_ARB
>>  	tristate "Meson Audio Memory Arbiter Reset Driver"
>> diff --git a/drivers/reset/amlogic/Makefile b/drivers/reset/amlogic/Makefile
>> index 55509fc78513..74aaa2fb5e13 100644
>> --- a/drivers/reset/amlogic/Makefile
>> +++ b/drivers/reset/amlogic/Makefile
>> @@ -1,2 +1,3 @@
>>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
>> +obj-$(CONFIG_RESET_MESON_COMMON) += reset-meson-common.o
>>  obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
>> diff --git a/drivers/reset/amlogic/reset-meson-common.c b/drivers/reset/amlogic/reset-meson-common.c
>> new file mode 100644
>> index 000000000000..d57544801ae9
>> --- /dev/null
>> +++ b/drivers/reset/amlogic/reset-meson-common.c
>> @@ -0,0 +1,121 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>> +/*
>> + * Amlogic Meson Reset core functions
>> + *
>> + * Copyright (c) 2016-2024 BayLibre, SAS.
>> + * Authors: Neil Armstrong <narmstrong@baylibre.com>
>> + *          Jerome Brunet <jbrunet@baylibre.com>
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset-controller.h>
>> +
>> +#include "reset-meson.h"
>> +
>> +struct meson_reset {
>> +	const struct meson_reset_param *param;
>> +	struct reset_controller_dev rcdev;
>> +	struct regmap *map;
>> +};
>> +
>> +static void meson_reset_offset_and_bit(struct meson_reset *data,
>> +				       unsigned long id,
>> +				       unsigned int *offset,
>> +				       unsigned int *bit)
>> +{
>> +	unsigned int stride = regmap_get_reg_stride(data->map);
>> +
>> +	*offset = (id / (stride * BITS_PER_BYTE)) * stride;
>> +	*bit = id % (stride * BITS_PER_BYTE);
>> +}
>> +
>> +static int meson_reset_reset(struct reset_controller_dev *rcdev,
>> +			     unsigned long id)
>
> checkpatch --strict complains about the alignment here.
> I'll fix this up when applying, no need to resend.

Thanks Philipp.

FYI, those mis-alignement were already present in the original code and
there has been comments when I re-indented code while moving it
around so I did not touch it.

>
> regards
> Philipp

-- 
Jerome

