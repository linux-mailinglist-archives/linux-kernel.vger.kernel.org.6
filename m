Return-Path: <linux-kernel+bounces-177691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D019C8C4323
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7623B209C1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6DA153BC5;
	Mon, 13 May 2024 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHHQicjz"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B5153836;
	Mon, 13 May 2024 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715610028; cv=none; b=AiL7sFS9q1fj1voYWVCzi/DZHDV6thIQ7svm7ZeW+ftSQ7wYbCIRXhvlqCzLnN/+csjYt3A2PeKRv+YeqIVFmk09is0PHb/eubjZoiUOO7/CX6OCPgSiW65DhVSFEL0rYGXQczRSmwqCNo3SaKcdlIUHOk3j7FsU9W+txrP5UUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715610028; c=relaxed/simple;
	bh=zY7AxVtqHHkWgofesqGmlMb5/UqTct0b9VA3lDyEi14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+Is1p2RMtOdooBSFC90GgBBMS/xSoridEBwZXPoy0Vmb3XV0k5UA375buBkIyywaLaKdov5e+rXLYOhEvRqWyNS5UjTx6lAXQu8DzKAhlUiMck6pi4xBwPpsHJCn9waW+2n5N5RdeQ7vJB4LQiLfXfc5gqNryJlx62aYA9GBeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHHQicjz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ed835f3c3cso38819795ad.3;
        Mon, 13 May 2024 07:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715610025; x=1716214825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oIqRz9Dt793Wqr+IfC77AHPlKEyI0hDItJOOqiwYqy0=;
        b=dHHQicjzVusQbCpWYeTXxEoSMroBdnhsSNjRjj3OUn8Cb3X1WIomna/z7rcIyTz0vY
         sGdVO9+iiU9we5Br21kOfsF/iH4bg/OheOWMj3sUJrXRg7KXXGoW8y5VF5Apr5kXQk4B
         o/MSE5K5jXwv+1bC+HHZr1G22adYBNc92Qf3W4Ttwo+ivhNXfyBkIhJ/Y1Wo4WF3tjbJ
         KNWehpKfZqcGKOcmXBFipQHYD6ZONP7t2HFtfjwU70Gcpu1tp/cd3zIsXQXWRzSD17v/
         DwMsf19PXmaScq8oj444lcIfdDz0Ba7qvAH9lLvOMcvI97Rawd4rWbXDzt3UHXtiHuh6
         TCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715610025; x=1716214825;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIqRz9Dt793Wqr+IfC77AHPlKEyI0hDItJOOqiwYqy0=;
        b=pty4CeYnJX3zmxdx5u9pVfgnSTPO4Wx43bWWOjPxNscD4pxsiigeALhGsaP9vDixtx
         nZ4BR/xZWwSMm7uw6aTPN2O5xgHXxWGrcFgO8hMTxclPkd7IS8HkyfSc3asy/GC2CdwV
         YRoAxjJZeCcwC7kQZ754J13XJmAG4/8WssujuQxn4DgOILRyTKgxsscFgYnXgoTeTPs2
         waVtkpLeNV4BPd/QwLymYUA1Fwwx/C5q80QlYPOD6SBbH+EpN3N/DZt4ZZDo2fiRIJGo
         Gco8GF5S5+fZSlTR+HrJEkfhroXtbszoLpHOZ+tNE0TqIMHXfb7Rqx3SfmCv5b6n8ier
         C7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXASRihxdvmN4Mu9woBEgavS8htJYxk4QVtLjfaYVVK4r0O3DEB24mr9K3TCyIkAvLKHpWU0dWyAjs+OxGw8nXt1G5hNFo+CCfWjQLy
X-Gm-Message-State: AOJu0YzICwUKWHQ+mJFTnjbX1tcXZJ3xo9xA+ozyF6rHXn9iE/zMKEJy
	CT9ew9OdIzhW3hA3r3ltaX7lbnWmQwhe8d9XhXADe2NW02xnf4f9
X-Google-Smtp-Source: AGHT+IEicrZlX8JGcvdcxhr3xdvQRafzRLvtqMsIifFcm7v26K1J3WROxryy6aeA1hl0jxpWf7bwjQ==
X-Received: by 2002:a17:902:7c18:b0:1eb:6a67:47ea with SMTP id d9443c01a7336-1ef43e2843amr101424235ad.31.1715610025063;
        Mon, 13 May 2024 07:20:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c036d47sm79483045ad.182.2024.05.13.07.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 07:20:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9c69d114-909d-43a8-8229-bb55b5bcc4ac@roeck-us.net>
Date: Mon, 13 May 2024 07:20:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: add MP2891 driver
To: Noah Wang <noahwang.wang@outlook.com>, jdelvare@suse.com
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <SEYPR04MB64825A740FDE7282B2FECEE2FAE22@SEYPR04MB6482.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <SEYPR04MB64825A740FDE7282B2FECEE2FAE22@SEYPR04MB6482.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/24 22:52, Noah Wang wrote:
> This driver is designed for MPS VR controller mp2891. The input
> voltage, output voltage, input current, output current, input
> power, output power and temperature of per rail can be obtained
> from hwmon sysfs that the driver provided.
> 
> Signed-off-by: Noah Wang <noahwang.wang@outlook.com>
> ---
>   Documentation/hwmon/mp2891.rst |  95 +++++++++++++++

Needs to be added to index.rst.

>   drivers/hwmon/pmbus/Kconfig    |   9 ++
>   drivers/hwmon/pmbus/Makefile   |   1 +
>   drivers/hwmon/pmbus/mp2891.c   | 210 +++++++++++++++++++++++++++++++++
>   4 files changed, 315 insertions(+)
>   create mode 100644 Documentation/hwmon/mp2891.rst
>   create mode 100644 drivers/hwmon/pmbus/mp2891.c
> 
> diff --git a/Documentation/hwmon/mp2891.rst b/Documentation/hwmon/mp2891.rst
> new file mode 100644
> index 000000000..eaf73fe60
> --- /dev/null
> +++ b/Documentation/hwmon/mp2891.rst
> @@ -0,0 +1,95 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver mp2891
> +====================
> +
> +Supported chips:
> +
> +  * MPS mp2891
> +
> +    Prefix: 'mp2891'
> +
> +  * Datasheet
> +
> +    Publicly available at the MPS website : https://www.monolithicpower.com/en/mp2891.html

No, it isn't. It is not even accessible with an account (the provided "datasheet"
is a useless one-pager).

> +
> +Author:
> +
> +	Noah Wang <noahwang.wang@outlook.com>
> +
> +Description
> +-----------
> +
> +This driver implements support for Monolithic Power Systems, Inc. (MPS)
> +MP2891 Multi-phase Digital VR Controller.
> +
> +Device compliant with:
> +
> +- PMBus rev 1.3 interface.
> +
> +Device supports direct and linear format for reading input voltage,
> +output voltage, input currect, output current, input power, output
> +power, and temperature.
> +
> +The driver exports the following attributes via the 'sysfs' files
> +for input voltage:
> +
> +**in1_input**
> +
> +**in1_label**
> +
> +The driver provides the following attributes for output voltage:
> +
> +**in2_input**
> +
> +**in2_label**
> +
> +**in3_input**
> +
> +**in3_label**
> +
> +The driver provides the following attributes for input current:
> +
> +**curr1_input**
> +
> +**curr1_label**
> +
> +**curr2_input**
> +
> +**curr2_label**
> +
> +The driver provides the following attributes for output current:
> +
> +**curr3_input**
> +
> +**curr3_label**
> +
> +**curr4_input**
> +
> +**curr4_label**
> +
> +The driver provides the following attributes for input power:
> +
> +**power1_input**
> +
> +**power1_label**
> +
> +**power2_input**
> +
> +**power2_label**
> +
> +The driver provides the following attributes for output power:
> +
> +**power3_input**
> +
> +**power3_label**
> +
> +**power4_input**
> +
> +**power4_label**
> +
> +The driver provides the following attributes for temperature:
> +
> +**temp1_input**
> +
> +**temp2_input**
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 557ae0c41..b8b6c7724 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -361,6 +361,15 @@ config SENSORS_MP5990
>   	  This driver can also be built as a module. If so, the module will
>   	  be called mp5990.
> 
> +config SENSORS_MP2891
> +    tristate "MPS MP2891"
> +    help
> +      If you say yes here you get hardware monitoring support for MPS
> +      MP2891 Dual Loop Digital Multi-Phase Controller.
> +
> +      This driver can also be built as a module. If so, the module will
> +      be called mp2891.
> +
>   config SENSORS_MPQ7932_REGULATOR
>   	bool "Regulator support for MPQ7932"
>   	depends on SENSORS_MPQ7932 && REGULATOR
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index f14ecf03a..57b91c20e 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
>   obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
>   obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
>   obj-$(CONFIG_SENSORS_MP5990)	+= mp5990.o
> +obj-$(CONFIG_SENSORS_MP2891)   += mp2891.o
>   obj-$(CONFIG_SENSORS_MPQ7932)	+= mpq7932.o
>   obj-$(CONFIG_SENSORS_MPQ8785)	+= mpq8785.o
>   obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
> diff --git a/drivers/hwmon/pmbus/mp2891.c b/drivers/hwmon/pmbus/mp2891.c
> new file mode 100644
> index 000000000..c98d9ec6b
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/mp2891.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Hardware monitoring driver for MPS Multi-phase Digital VR Controllers(MP2891)
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include "pmbus.h"
> +
> +/* Vendor specific registers, the register READ_PIN_EST(0x94),

Please use standard multi-line comments.

> + * MFR_VOUT_LOOP_CTRL(0xBD) and READ_IIN_EST(0x95) redefine
> + * the standard PMBUS register.

That doesn't explain the reason for using the _EST registers
instead of the standard registers.

> + */
> +#define MFR_VOUT_LOOP_CTRL      0xBD
> +#define READ_PIN_EST            0x94
> +#define READ_IIN_EST            0x95
> +
> +#define MP2891_PAGE_NUM			2
> +
> +#define MP2891_RAIL1_FUNC	(PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | \
> +							PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP | \
> +							PMBUS_HAVE_POUT | PMBUS_HAVE_PIN | \
> +							PMBUS_HAVE_IIN | PMBUS_PHASE_VIRTUAL)
> +
> +#define MP2891_RAIL2_FUNC	(PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | \
> +							PMBUS_HAVE_TEMP | PMBUS_HAVE_POUT | \
> +							PMBUS_HAVE_IIN | PMBUS_PHASE_VIRTUAL)

What is the point of PMBUS_PHASE_VIRTUAL ?

> +
> +struct mp2891_data {
> +	struct pmbus_driver_info info;
> +};
> +
> +#define to_mp2891_data(x) container_of(x, struct mp2891_data, info)
> +
Unused.

> +static int mp2891_read_byte_data(struct i2c_client *client, int page, int reg)
> +{
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_VOUT_MODE:
> +		ret = PB_VOUT_MODE_DIRECT;

Needs explanation.

> +		break;
> +	default:
> +		ret = -EINVAL;

No status registers ? I do not believe this is correct.

> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mp2891_read_word_data(struct i2c_client *client, int page, int phase,
> +			      int reg)
> +{
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_READ_VIN:
> +	case PMBUS_READ_IOUT:
> +	case PMBUS_READ_POUT:
> +	case PMBUS_READ_VOUT:
> +	case PMBUS_READ_TEMPERATURE_1:
> +		ret = pmbus_read_word_data(client, page, phase, reg);

Use
		return -ENODATA;
instead.

> +		break;
> +	case PMBUS_READ_IIN:
> +		ret = pmbus_read_word_data(client, page, phase, READ_IIN_EST);
> +		break;
> +	case PMBUS_READ_PIN:
> +		ret = pmbus_read_word_data(client, page, phase, READ_PIN_EST);

This needs an explanation. Why not use standard READ_IIN and READ_PIN ?

> +		break;
> +	default:
> +		ret = -EINVAL;

No limit registers ? That seems extremely unlikely.


Given that you are essentially claiming that the chip would support
almost no standard registers, I'll need to see the datasheet to confirm.

> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int
> +mp2891_identify_vout_scale(struct i2c_client *client, struct mp2891_data *data,
> +							u32 reg, int page)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_word_data(client, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Obtain vout scale from the register MFR_VOUT_LOOP_CTRL, bits 15-14,bit 13.
> +	 * If MFR_VOUT_LOOP_CTRL[13] = 1, the vout scale is below:
> +	 * 2.5mV/LSB
> +	 * If MFR_VOUT_LOOP_CTRL[13] = 0, the vout scale is decided by
> +	 * MFR_VOUT_LOOP_CTRL[15:14]:
> +	 * 00b - 6.25mV/LSB, 01b - 5mV/LSB, 10b - 2mV/LSB, 11b - 1mV
> +	 */
> +	if (ret & GENMASK(13, 13)) {
> +		data->info.m[PSC_VOLTAGE_OUT] = 4;
> +		data->info.R[PSC_VOLTAGE_OUT] = -1;
> +		data->info.b[PSC_VOLTAGE_OUT] = 0;
> +	} else {
> +		ret = (ret & GENMASK(15, 14)) >> 14;

Why not FIELD_GET() ?

> +		if (ret == 0) {
> +			data->info.m[PSC_VOLTAGE_OUT] = 16;
> +			data->info.R[PSC_VOLTAGE_OUT] = -2;
> +			data->info.b[PSC_VOLTAGE_OUT] = 0;
> +		} else if (ret == 1) {
> +			data->info.m[PSC_VOLTAGE_OUT] = 2;
> +			data->info.R[PSC_VOLTAGE_OUT] = -1;
> +			data->info.b[PSC_VOLTAGE_OUT] = 0;
> +		} else if (ret == 2) {
> +			data->info.m[PSC_VOLTAGE_OUT] = 5;
> +			data->info.R[PSC_VOLTAGE_OUT] = -1;
> +			data->info.b[PSC_VOLTAGE_OUT] = 0;
> +		} else {
> +			data->info.m[PSC_VOLTAGE_OUT] = 1;
> +			data->info.R[PSC_VOLTAGE_OUT] = 0;
> +			data->info.b[PSC_VOLTAGE_OUT] = 0;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +mp2891_identify_rails_vout_scale(struct i2c_client *client, struct mp2891_data *data)
> +{
> +	int ret;
> +
> +	/* Identify vout scale from register  MFR_VOUT_LOOP_CTRL. */

Useless comment.

> +	/* Identify vout scale for rail 1. */
> +	ret = mp2891_identify_vout_scale(client, data, MFR_VOUT_LOOP_CTRL, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Identify vout scale for rail 2. */
> +	ret = mp2891_identify_vout_scale(client, data, MFR_VOUT_LOOP_CTRL, 1);

Passing the register to this function is useless. Just use the register directly
in mp2891_identify_vout_scale().

> +
> +	return ret;
> +}
> +
> +static struct pmbus_driver_info mp2891_info = {
> +	.pages = MP2891_PAGE_NUM,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +	.format[PSC_POWER] = linear,
> +	.format[PSC_VOLTAGE_OUT] = direct,
> +
> +	.func[0] = MP2891_RAIL1_FUNC,
> +	.func[1] = MP2891_RAIL2_FUNC,
> +	.read_word_data = mp2891_read_word_data,
> +	.read_byte_data = mp2891_read_byte_data,
> +};
> +
> +static int mp2891_probe(struct i2c_client *client)
> +{
> +	struct pmbus_driver_info *info;
> +	struct mp2891_data *data;
> +	int ret;
> +
> +	data = devm_kzalloc(&client->dev, sizeof(struct mp2891_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	memcpy(&data->info, &mp2891_info, sizeof(*info));
> +	info = &data->info;
> +
> +	/* Identify vout scale per rail. */
> +	ret = mp2891_identify_rails_vout_scale(client, data);
> +	if (ret < 0)
> +		return ret;
> +

Why not use the identify() callback instead ?

> +	return pmbus_do_probe(client, info);
> +}
> +
> +static const struct i2c_device_id mp2891_id[] = {
> +	{"mp2891", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, mp2891_id);
> +
> +static const struct of_device_id __maybe_unused mp2891_of_match[] = {
> +	{.compatible = "mps,mp2891"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mp2891_of_match);
> +
> +static struct i2c_driver mp2891_driver = {
> +	.driver = {
> +		.name = "mp2891",
> +		.of_match_table = mp2891_of_match,
> +	},
> +	.probe = mp2891_probe,
> +	.id_table = mp2891_id,
> +};
> +
> +module_i2c_driver(mp2891_driver);
> +
> +MODULE_AUTHOR("Noah Wang <noahwang.wang@outlook.com>");
> +MODULE_DESCRIPTION("PMBus driver for MPS MP2891 device");

drop "device"

> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);
> --
> 2.25.1
> 


