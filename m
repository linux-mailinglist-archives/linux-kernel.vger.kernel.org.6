Return-Path: <linux-kernel+bounces-342549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5751598902A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058D5282836
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272BA5381A;
	Sat, 28 Sep 2024 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cm1HRraE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E5418030
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727538833; cv=none; b=FIbjeMUa0iWDjvpsAqQvlieRR17fZ+RB0Px1s7LBNLenw+LdzotI36js90NgK/psqXGE8jbsg9MXKQXrsbDe+MSMFC86Gf3OhQxoeYKM7g1jJlusKsawD4prI8YaLGnI8pr6eaxMQwPgQ8MPwDG9SxRxKeVxIyslav5eyT3mwqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727538833; c=relaxed/simple;
	bh=tXMV+kcth9S1uhwYPiEx4F2bDHbBFHlTPwKqiYdgqDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWF2PWOA5T6NDL5OPFVK9WeZ9N42FQAYa1BucLFQBEDHncI1jTCTS4hy00fd/OwkMR2sEfzZ+dWpBkzCOZssebyh0ZUqcUeK0aqhJeN+yQTRfzbmXvYRPnb41WABmW3SvDuFwSPLA5EQ2Yj+Th3BwGvEvf27W3NwHRw6DfAK8gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cm1HRraE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727538830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qC+Sm4mkUVolcRSvJgkVeyvOVLgGLUcC4NfrjQb0DlI=;
	b=Cm1HRraE7srmGlVYEjMt7JE1JGruiyn8RmREzRAzLQMetrxNgzybMR/1dFcSEmHhhbYMYT
	0kZZVjDoX+rSSf4oqkPYOCCg40DfKlisVBWnpZoo+wDcKbf1pPuufaFEcdp3PHNFKVXtNk
	gSViWN6QjI7tqWwVsOiQnLuOI1EQLOw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-GnrICEt5PBmOVv3Ydaxx0A-1; Sat, 28 Sep 2024 11:53:48 -0400
X-MC-Unique: GnrICEt5PBmOVv3Ydaxx0A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c884bf0025so1311878a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 08:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727538827; x=1728143627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qC+Sm4mkUVolcRSvJgkVeyvOVLgGLUcC4NfrjQb0DlI=;
        b=XrErHbrvZyIdsM5uD8ni6uS/4LDS99bYnoWrRaB0KtGFTx+G2q9++Y16z+2Pjfyu5a
         X7pbFs27kAiNJQnGjvqdRmflGjiy58WCkyuuMh8a1uTEX3ciSA05KJbbCf1rGst953GO
         NBLiv+ybgScIyLR8LaM2CdNQ73xAC6lmD4YYvnWPfjytvzlVMZQSCu0QPCpSPpPqMhxi
         QN+0O3H85zOMmMs0CE71cDWZj9vQiWuAX6VQiIzC3KOF4w3X/uXLu0+BWPft9Py//Hqz
         ABHrlKtWZgsQUa9rJb8O6X0tkym6zWyXWv7INwufRwowzPiyg1PJUMVaRZWOfQeGZYB0
         SZDg==
X-Gm-Message-State: AOJu0YyNuG8BePosJZP3+RdtsB1uHl8JcW1WTr4tgohxulHIQjPncTnI
	Mu8g5rdi7vhNkv52n43klyaq+mL+3j+Pp1wb8W8I6z6hfkgE229r9V1bu6DP74LI2zcf4XIYqBq
	teLh936lasCXcwt3jXu9wfGnWL+0xuSLZbGGR5FnoaaTjNg3kaGsqd2lhWekbaDktvm2HFwMU
X-Received: by 2002:a05:6402:34c4:b0:5c8:8381:c1bf with SMTP id 4fb4d7f45d1cf-5c88381c226mr4451752a12.3.1727538826739;
        Sat, 28 Sep 2024 08:53:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSNjZ9qCHLQeYT8LsGYydz191FY7WU7Z/pAeiU9MqrEsu42CxkP64bl+ssdMOapnv9ijHwgA==
X-Received: by 2002:a05:6402:34c4:b0:5c8:8381:c1bf with SMTP id 4fb4d7f45d1cf-5c88381c226mr4451746a12.3.1727538826282;
        Sat, 28 Sep 2024 08:53:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c884e9bfd0sm1705587a12.37.2024.09.28.08.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2024 08:53:45 -0700 (PDT)
Message-ID: <4365cae6-33e2-4b86-aab9-0b9ad112e6b0@redhat.com>
Date: Sat, 28 Sep 2024 17:53:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] platform: arm64: Add driver for Lenovo Yoga Slim 7x's
 EC
To: Maya Matuszczyk <maccraft123mc@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240927185345.3680-1-maccraft123mc@gmail.com>
 <20240927185345.3680-2-maccraft123mc@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240927185345.3680-2-maccraft123mc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Maya,

Thank you for your patch. It is great to so people working on supporting
more ARM64 based laptop ECs.

Note not a full review just one remark from a quick scan of the driver.

On 27-Sep-24 8:53 PM, Maya Matuszczyk wrote:
> This patch adds a basic driver for the EC in Qualcomm Snapdragon X1
> Elite-based Lenovo Yoga Slim 7x.
> 
> For now it supports only reporting that the AP is going to suspend and
> the microphone mute button, however the EC seems to also support reading
> fan information, other key combinations and thermal data.
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  MAINTAINERS                                 |   1 +
>  drivers/platform/arm64/Kconfig              |  12 ++
>  drivers/platform/arm64/Makefile             |   1 +
>  drivers/platform/arm64/lenovo-yoga-slim7x.c | 202 ++++++++++++++++++++
>  4 files changed, 216 insertions(+)
>  create mode 100644 drivers/platform/arm64/lenovo-yoga-slim7x.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0d4bfdde166d..f689cba80fa3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12906,6 +12906,7 @@ LENOVO YOGA SLIM 7X EC DRIVER
>  M:	Maya Matuszczyk <maccraft123mc@gmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/platform/lenovo,yoga-slim7x-ec.yaml
> +F:	drivers/platform/arm64/lenovo-yoga-slim7x.c
>  
>  LETSKETCH HID TABLET DRIVER
>  M:	Hans de Goede <hdegoede@redhat.com>
> diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
> index f88395ea3376..9ceae50f8b4e 100644
> --- a/drivers/platform/arm64/Kconfig
> +++ b/drivers/platform/arm64/Kconfig
> @@ -49,4 +49,16 @@ config EC_LENOVO_YOGA_C630
>  
>  	  Say M or Y here to include this support.
>  
> +config EC_LENOVO_YOGA_SLIM7X
> +	tristate "Lenovo Yoga Slim 7x Embedded Controller driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on I2C
> +	help
> +	  Select this option to enable driver for the EC found in the Lenovo
> +	  Yoga Slim 7x.
> +
> +	  This driver currently supports reporting input event for microphone
> +	  mute button, and reporting device suspend to the EC so it can take
> +	  appropriate actions.
> +
>  endif # ARM64_PLATFORM_DEVICES
> diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64/Makefile
> index b2ae9114fdd8..70dfc1fb979d 100644
> --- a/drivers/platform/arm64/Makefile
> +++ b/drivers/platform/arm64/Makefile
> @@ -7,3 +7,4 @@
>  
>  obj-$(CONFIG_EC_ACER_ASPIRE1)	+= acer-aspire1-ec.o
>  obj-$(CONFIG_EC_LENOVO_YOGA_C630) += lenovo-yoga-c630.o
> +obj-$(CONFIG_EC_LENOVO_YOGA_SLIM7X) += lenovo-yoga-slim7x.o
> diff --git a/drivers/platform/arm64/lenovo-yoga-slim7x.c b/drivers/platform/arm64/lenovo-yoga-slim7x.c
> new file mode 100644
> index 000000000000..8f6d523395bc
> --- /dev/null
> +++ b/drivers/platform/arm64/lenovo-yoga-slim7x.c
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 Maya Matuszczyk <maya.matuszczyk@gmail.com>
> + */
> +#include <linux/auxiliary_bus.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/irqreturn.h>
> +#include <linux/lockdep.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/notifier.h>
> +#include <linux/slab.h>
> +#include <linux/input.h>
> +//#include <linux/platform_data/lenovo-yoga-slim7x.h>
> +
> +// These are the registers that i know about available from SMBUS
> +#define EC_IRQ_REASON_REG 0x05
> +#define EC_SUSPEND_RESUME_REG 0x23
> +#define EC_IRQ_ENABLE_REG 0x35
> +#define EC_BACKLIGHT_STATUS_REG 0x83
> +#define EC_MIC_MUTE_LED_REG 0x84
> +#define EC_AC_STATUS_REG 0x90
> +
> +// Valid values for EC_SUSPEND_RESUME_REG
> +#define EC_NOTIFY_SUSPEND_ENTER 0x01
> +#define EC_NOTIFY_SUSPEND_EXIT 0x00
> +#define EC_NOTIFY_SCREEN_OFF 0x03
> +#define EC_NOTIFY_SCREEN_ON 0x04
> +
> +// These are the values in EC_IRQ_REASON_REG that i could find in DSDT
> +#define EC_IRQ_MICMUTE_BUTTON 0x04
> +#define EC_IRQ_FAN1_STATUS_CHANGE 0x30
> +#define EC_IRQ_FAN2_STATUS_CHANGE 0x31
> +#define EC_IRQ_FAN1_SPEED_CHANGE 0x32
> +#define EC_IRQ_FAN2_SPEED_CHANGE 0x33
> +#define EC_IRQ_COMPLETED_LUT_UPDATE 0x34
> +#define EC_IRQ_COMPLETED_FAN_PROFILE_SWITCH 0x35
> +#define EC_IRQ_THERMISTOR_1_TEMP_THRESHOLD_CROSS 0x36
> +#define EC_IRQ_THERMISTOR_2_TEMP_THRESHOLD_CROSS 0x37
> +#define EC_IRQ_THERMISTOR_3_TEMP_THRESHOLD_CROSS 0x38
> +#define EC_IRQ_THERMISTOR_4_TEMP_THRESHOLD_CROSS 0x39
> +#define EC_IRQ_THERMISTOR_5_TEMP_THRESHOLD_CROSS 0x3a
> +#define EC_IRQ_THERMISTOR_6_TEMP_THRESHOLD_CROSS 0x3b
> +#define EC_IRQ_THERMISTOR_7_TEMP_THRESHOLD_CROSS 0x3c
> +#define EC_IRQ_RECOVERED_FROM_RESET 0x3d
> +#define EC_IRQ_LENOVO_SUPPORT_KEY 0x90
> +#define EC_IRQ_FN_Q 0x91
> +#define EC_IRQ_FN_M 0x92
> +#define EC_IRQ_FN_SPACE 0x93
> +#define EC_IRQ_FN_R 0x94
> +#define EC_IRQ_FNLOCK_ON 0x95
> +#define EC_IRQ_FNLOCK_OFF 0x96
> +#define EC_IRQ_FN_N 0x97
> +#define EC_IRQ_AI 0x9a
> +#define EC_IRQ_NPU 0x9b
> +
> +struct yoga_slim7x_ec {
> +	struct i2c_client *client;
> +	struct input_dev *idev;
> +	struct mutex lock;
> +};
> +
> +static irqreturn_t yoga_slim7x_ec_irq(int irq, void *data)
> +{
> +	struct yoga_slim7x_ec *ec = data;
> +	struct device *dev = &ec->client->dev;
> +	int val;
> +
> +	guard(mutex)(&ec->lock);
> +
> +	val = i2c_smbus_read_byte_data(ec->client, EC_IRQ_REASON_REG);
> +	if (val < 0) {
> +		dev_err(dev, "Failed to get EC IRQ reason: %d\n", val);
> +		return IRQ_HANDLED;
> +	}
> +
> +	switch (val) {
> +	case EC_IRQ_MICMUTE_BUTTON:
> +		input_report_key(ec->idev, KEY_MICMUTE, 1);
> +		input_sync(ec->idev);
> +		input_report_key(ec->idev, KEY_MICMUTE, 0);
> +		input_sync(ec->idev);
> +		break;
> +	default:
> +		dev_info(dev, "Unhandled EC IRQ reason: %d\n", val);
> +	}

I strongly suggest to use include/linux/input/sparse-keymap.h functionality
here. This will make adding new keys a lot easier and will allow re-mapping
codes from userspace.

E.g. replace the whole switch-case with:

	if (!sparse_keymap_report_event(ec->idev, val, 1, true))
		dev_info(dev, "Unhandled EC IRQ reason: %d\n", val);

This takes care of mapping val -> KEY_MICMUTE, and doing all
the reporting (after calling sparse_keymap_setup() with an appropriate
keymap from probe()).



> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int yoga_slim7x_ec_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct yoga_slim7x_ec *ec;
> +	int ret;
> +
> +	ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
> +	if (!ec)
> +		return -ENOMEM;
> +
> +	mutex_init(&ec->lock);
> +	ec->client = client;
> +
> +	ec->idev = devm_input_allocate_device(dev);
> +	if (!ec->idev)
> +		return -ENOMEM;
> +	ec->idev->name = "yoga-slim7x-ec";
> +	ec->idev->phys = "yoga-slim7x-ec/input0";
> +	input_set_capability(ec->idev, EV_KEY, KEY_MICMUTE);

Same here, please use sparse_keymap_setup() here to have it
setup capabilities for all keys in your (to be defined)

const struct key_entry yoga_slim7x_ec_keymap[]

This way you only need to add new mappings in the keymap
and then both the capability setting as well as the reporting
in the irq-handler will be taken care of by the sparse-keymap
helpers.

Other then that the overall structure of the driver looks good
(again this is not a full review, just a quick scan).

Regards,

Hans





> +
> +	ret = input_register_device(ec->idev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to register input device\n");
> +
> +	ret = devm_request_threaded_irq(dev, client->irq,
> +					NULL, yoga_slim7x_ec_irq,
> +					IRQF_ONESHOT, "yoga_slim7x_ec", ec);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Unable to request irq\n");
> +
> +	ret = i2c_smbus_write_byte_data(client, EC_IRQ_ENABLE_REG, 0x01);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to enable interrupts\n");
> +
> +	return 0;
> +}
> +
> +static void yoga_slim7x_ec_remove(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, EC_IRQ_ENABLE_REG, 0x00);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to disable interrupts: %d\n", ret);
> +}
> +
> +static int yoga_slim7x_ec_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, EC_SUSPEND_RESUME_REG, EC_NOTIFY_SCREEN_OFF);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, EC_SUSPEND_RESUME_REG, EC_NOTIFY_SUSPEND_ENTER);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int yoga_slim7x_ec_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, EC_SUSPEND_RESUME_REG, EC_NOTIFY_SUSPEND_EXIT);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, EC_SUSPEND_RESUME_REG, EC_NOTIFY_SCREEN_ON);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id yoga_slim7x_ec_of_match[] = {
> +	{ .compatible = "lenovo,yoga-slim7x-ec" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, yoga_slim7x_ec_of_match);
> +
> +static const struct i2c_device_id yoga_slim7x_ec_i2c_id_table[] = {
> +	{ "yoga-slim7x-ec", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, yoga_slim7x_ec_i2c_id_table);
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(yoga_slim7x_ec_pm_ops,
> +		yoga_slim7x_ec_suspend,
> +		yoga_slim7x_ec_resume);
> +
> +static struct i2c_driver yoga_slim7x_ec_i2c_driver = {
> +	.driver = {
> +		.name = "yoga-slim7x-ec",
> +		.of_match_table = yoga_slim7x_ec_of_match,
> +		.pm = &yoga_slim7x_ec_pm_ops
> +	},
> +	.probe = yoga_slim7x_ec_probe,
> +	.remove = yoga_slim7x_ec_remove,
> +	.id_table = yoga_slim7x_ec_i2c_id_table,
> +};
> +module_i2c_driver(yoga_slim7x_ec_i2c_driver);
> +
> +MODULE_DESCRIPTION("Lenovo Yoga Slim 7x Embedded Controller");
> +MODULE_LICENSE("GPL");


