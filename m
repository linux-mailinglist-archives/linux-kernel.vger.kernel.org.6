Return-Path: <linux-kernel+bounces-248867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D743D92E2F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5A5283622
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1D81552E1;
	Thu, 11 Jul 2024 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IprCWz9x"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638DB54916
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688481; cv=none; b=KdCotEW+d6pkQB9gPJ6yHPnDLhBx7PJcq5ULvAgtX8rvjdRMvs+ypjZqy9iRgS/dIgXSMCvcuk+4GJuR2V/OLoNNZ7fq5eoQxK4Jc38ugD9Xogn4IiYfJvwuhR4lg4+0C4HY3Wv4rGy6HjjLxDRAmF3LJu8sjrfJO5ZyDbvD7Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688481; c=relaxed/simple;
	bh=py/S5YhDTfUOlw/+tXf9jV6Hv7YWRbSfk7va1FaCeWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UUq0moVq4w1HTMRyXpNpCMMuS0le8714pMi9ZU6r2cAm9ZdPIby5aWLTyklLN1VDL5uzq/w5d7Xb9BSulgfimsoCsL/BA241PZ5jrg8rH8sjGUue+C8/BAl7GnvExAbNcg/WN4zLF2eQkwHYKOTLYkAKx/L3GnVho6Ca93puM3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IprCWz9x; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42793fc0a6dso4234325e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720688478; x=1721293278; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O76Wd1xdw6NT3rqbN+Mq89J6tI9yqcUKeCRTu1LWxmk=;
        b=IprCWz9xcgirnEPFCwyAbA3nriCVul6nNQni0MtRqkWJkhflYVvIwrdXTtGsDO0JjH
         PZkdR92h2+ynAusM8WkdTSz3gn02lQ2cawGv0rLBvtDuMk0MpE1u3kbpiRNyy9dERwbT
         fSJfsHMjrSb4wjvhJ/mx5IkGQWENo4m7yeMh2TqM9UeHwVwvRGj+mSzCsvaNfnRJ9tQZ
         CdBpXboC8ZCCNQba5L5+Y+helrwmJCGBXZwRyXRIzM+HY7wc+JMpGPKkcXtQQDHgm93s
         Riy/2xRxPgGQx7CFHiTYae+apOPUilA6WBxc8wW34+F5UUEAWFmg2cC1YjJ/hNUB1l6D
         1Mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720688478; x=1721293278;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O76Wd1xdw6NT3rqbN+Mq89J6tI9yqcUKeCRTu1LWxmk=;
        b=UXjV6DzC9jlQIWIpJF1XZ0cyMxR2og0blUnBq6W0gxcXT5Ldee2inBp0dd/E18rVi+
         rT1u4VF7JRF2q8hwQsHw0yZ7YAqEu0wP2TKbZ39e6/OPZ8ivRfSJ05aMdmJsjCUy541m
         bbr3yp+kwdDeQ1Kd/HCBHXtfgCNDmIlG78DSmxbsG/NqK6tho7/9RL7Eh/Xf7Bzxb0kV
         JFEfg77/E6t7dJNGjGMGfQmXCnIVN7YI1JJm6Ylj1m1UW0/b9lePmL0XJ9gjK1IY/DtR
         XWnURv2WLr0+yskQkPKB35anzRJY/DRqB+pPqXmz+qHiFrH4hl+N0hxmTP6At10uWd84
         CUlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWekrJ5LrNzHLLF3KtOXVRpWVqriJUymX+m2cGK5vYlAnytpyFlX1fEsD3G8tRduVfsdbBim37Y6W1J10zvoeD1nbAGJDdvg8ryzycJ
X-Gm-Message-State: AOJu0YyoqLX7Z19MUojlQjTbw2/SQ3+DWZIdCwPOBZjcdBmzAR40oFw2
	bTcaSYpUxbCLa7r8iiFFfarP2GdC5S227NhEjhCE+gVcmsTQ2vIcUk8WNr180Ss=
X-Google-Smtp-Source: AGHT+IF8lHe9Es5HF0Ko8Tr5R/zHyd6BopakSB0f7nBr2KdNcKTrn7lbuxyBJzEVMvldK1lXJtcgrA==
X-Received: by 2002:a05:600c:358f:b0:426:8ee5:5d24 with SMTP id 5b1f17b1804b1-4268ef4a0b6mr39316115e9.20.1720688477752;
        Thu, 11 Jul 2024 02:01:17 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:a9e9:c71a:10d8:7f63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e9666sm108670895e9.9.2024.07.11.02.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 02:01:17 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Philipp Zabel
 <p.zabel@pengutronix.de>,  Jan Dakinevich
 <jan.dakinevich@salutedevices.com>,  linux-kernel@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org
Subject: Re: [PATCH 7/8] reset: amlogic: add auxiliary reset driver support
In-Reply-To: <88d1dbd92e922ad002367d8dac67d0eb.sboyd@kernel.org> (Stephen
	Boyd's message of "Wed, 10 Jul 2024 15:49:38 -0700")
References: <20240710162526.2341399-1-jbrunet@baylibre.com>
	<20240710162526.2341399-8-jbrunet@baylibre.com>
	<88d1dbd92e922ad002367d8dac67d0eb.sboyd@kernel.org>
Date: Thu, 11 Jul 2024 11:01:16 +0200
Message-ID: <1jv81cgv4z.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 10 Jul 2024 at 15:49, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Jerome Brunet (2024-07-10 09:25:16)
>> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
>> index e34a10b15593..5cc767d50e8f 100644
>> --- a/drivers/reset/reset-meson.c
>> +++ b/drivers/reset/reset-meson.c
> [...]
>> +
>> +int devm_meson_rst_aux_register(struct device *dev,
>> +                               struct regmap *map,
>> +                               const char *adev_name)
>> +{
>> +       struct meson_reset_adev *raux;
>> +       struct auxiliary_device *adev;
>> +       int ret;
>> +
>> +       raux = kzalloc(sizeof(*raux), GFP_KERNEL);
>> +       if (!raux)
>> +               return -ENOMEM;
>> +
>> +       ret = ida_alloc(&meson_rst_aux_ida, GFP_KERNEL);
>
> Do we expect more than one device with the same name? I wonder if the
> IDA can be skipped.

I've wondered about that too.

I don't think it is the case right now but I'm not 100% sure.
Since I spent time thinking about it, I thought it would just be safer (and
relatively cheap) to put in and enough annoying debugging the
expectation does not hold true.

I don't have a strong opinion on this. What do you prefer ?

>
>> +       if (ret < 0)
>> +               goto raux_free;
>> +
>> +       raux->map = map;
>> +
>> +       adev = &raux->adev;
>> +       adev->id = ret;
>> +       adev->name = adev_name;
>> +       adev->dev.parent = dev;
>> +       adev->dev.release = meson_rst_aux_release;
>> +       device_set_of_node_from_dev(&adev->dev, dev);
>> +
>> +       ret = auxiliary_device_init(adev);
>> +       if (ret)
>> +               goto ida_free;
>> +
>> +       ret = __auxiliary_device_add(adev, dev->driver->name);
>> +       if (ret) {
>> +               auxiliary_device_uninit(adev);
>> +               return ret;
>> +       }
>> +
>> +       return devm_add_action_or_reset(dev, meson_rst_aux_unregister_adev,
>> +                                       adev);
>> +
>> +ida_free:
>> +       ida_free(&meson_rst_aux_ida, adev->id);
>> +raux_free:
>> +       kfree(raux);
>> +       return ret;
>> +
>
> Nitpick: Drop extra newline?
>
>> +}
>> +EXPORT_SYMBOL_GPL(devm_meson_rst_aux_register);
>> +
>> +MODULE_DESCRIPTION("Amlogic Meson Reset driver");
>>  MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>> +MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
>>  MODULE_LICENSE("Dual BSD/GPL");
>> diff --git a/include/soc/amlogic/meson-auxiliary-reset.h b/include/soc/amlogic/meson-auxiliary-reset.h
>> new file mode 100644
>> index 000000000000..8fdb02b18d8c
>> --- /dev/null
>> +++ b/include/soc/amlogic/meson-auxiliary-reset.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __SOC_AMLOGIC_MESON_AUX_RESET_H
>> +#define __SOC_AMLOGIC_MESON_AUX_RESET_H
>> +
>> +#include <linux/err.h>
>> +
>> +struct device;
>> +struct regmap;
>> +
>> +#ifdef CONFIG_RESET_MESON
>> +int devm_meson_rst_aux_register(struct device *dev,
>> +                               struct regmap *map,
>> +                               const char *adev_name);
>> +#else
>> +static inline int devm_meson_rst_aux_register(struct device *dev,
>> +                                             struct regmap *map,
>> +                                             const char *adev_name)
>> +{
>> +       return -EOPNOTSUPP;
>
> Shouldn't this be 'return 0' so that the clk driver doesn't have to care
> about the config?

I don't think the system (in general) would be able function without the reset
driver, so the question is rather phylosophical.

Let's say it could, if this returns 0, consumers of the reset controller
will defer indefinitely ... which is always a bit more difficult to sort
out.

If it returns an error, the problem is pretty obvious, helping people
solve it quickly.

Also the actual device we trying to register provides clocks and reset.
It is not like the reset is an optional part we don't care about.

On this instance it starts from clock, but it could have been the other
way around. Both are equally important.

I'd prefer if it returns an error when the registration can't even start.

-- 
Jerome

