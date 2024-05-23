Return-Path: <linux-kernel+bounces-187778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D8D8CD843
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E57B2227C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BD9179AD;
	Thu, 23 May 2024 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTW74/Cm"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A437D2033E;
	Thu, 23 May 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716481078; cv=none; b=V2uQE8TzBXLJ/3X4Vt2PUwaRQrlkyd8vZC6Z6iA9SiSk+e+aLhSHPKTaxXtqdff2tqZFuLYvL1mS9ZJ88HAMiqeN1k1fVu5TggvPIWJNEslnXhRhH+XBh2p+iZVn3Pg0UN1geDIn9bAfiHATHNBoq4dpqPDImnZ5eeuNoHwgffY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716481078; c=relaxed/simple;
	bh=5KYGvAf6DinbwJIYHCpmsyImifO0nbcg/VPkD1gul0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncGs2mf3TxTcJ200dBilvjA/fEhgZ4dB8jM4r5BxQV7tIHgFOQXgVJ3Cc6XkExS3gLSsxT+kX0M95un3yiLj9XJBqNu/37iGkT6mqoDdgb0uXhFYot+k7L+9GmaPOfkbECmg/zgguk1We35NYQrdAJ/yc40Sl20uFqfwE0dscKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTW74/Cm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ec92e355bfso25385345ad.3;
        Thu, 23 May 2024 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716481076; x=1717085876; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s192CxPszJPt6Daxk1v1LOaVl5tcCYNMsLpR507X9S4=;
        b=gTW74/CmvxxK7oHu9RNqWer1akhyybs+9BCMlj6ptwVL6pjOxQqNwP/yJZjayNZd0p
         gXY32G5J+wYhSAv28F7jmnC15NyAVl7CY4iZfUPG6Tr+mLlvik1C6J+pOLJm1xBfrfL8
         GuWnrIMFOelJDtQyNKh10rLKpfYaAznlBbNUzlcn+THfVR5m+Hexx6uXllEm8znodA0r
         jUdL/8Y8k9XQRRXgQfbplOzcbC77kvndm9a9MiGGwjxsykx+CbKgzW11stk82/BYd/D3
         jXO2nXDxGaaRd8Xe+0PjiQgYTbYL9pfXku2A1YVJO6K7wmXlkA+WcG2DloFT0QIriyNf
         fJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716481076; x=1717085876;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s192CxPszJPt6Daxk1v1LOaVl5tcCYNMsLpR507X9S4=;
        b=vqrxNU3mCsh9tD7vlv5Ii6bPnFGQAcbRF2UWGOpQdrArr6VpgjE9P/d9OCFZCnR2py
         Q9LY8O2oszY+p7ZfZgtTz4DNgzUB06T3KfAv27MCXDKNnJlYkuc2f3oW+n18SS92Ut9L
         BCF725gDsWpCFTrYrt/NHRHRNOV1BBIyTGzYk/7KUL7Wb4B1KiZG/KWLQ7gOTWKJvaoE
         F9nSqIhcHyBgLBXKUPSZ0exfAkYwSdVRaxUNbQSs/sFRDtlCWg4dZvutDQWxLIKiSsy4
         sT3FkQz8BcI2O0Kfk1SEr4KsY0UjcNp1T5UGFT44WGHuHAZtBq6adviw1d0Rsut4K2kk
         8r7g==
X-Forwarded-Encrypted: i=1; AJvYcCVSzIBdjvdlkk36hwZWT4bFoekzQ+UW5nX0KtuWeQ5aoDZ8s7TsyZaEwVDu0x1Mje85JCoXv29PKpEsFSOYx5tttFR86uAgPiH1m0GfY7KznyBveO0EL77E/tUXD8u+lAnjEejCPv/VTY8=
X-Gm-Message-State: AOJu0Yxj/ol2JCmdvW6r0LFDHqrZOr9Bsh2qUavgjbe8FZO2qjSg3oE4
	GdswRoR0ueeyCLUmtbf4OHIIP7EJYbzrMujO6upzp2Z8lKOM0ob6jO6Saw==
X-Google-Smtp-Source: AGHT+IGoSN38WL3Hp3IP4B9A0k3o8npIpjxVbk0rBMQDkUVVBa6iU8fGBLYCu+3HSTB3RQnQHxjRIA==
X-Received: by 2002:a17:902:f78f:b0:1f3:2f8c:8f7b with SMTP id d9443c01a7336-1f32f8c9677mr45226705ad.15.1716481075470;
        Thu, 23 May 2024 09:17:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fbf8ea89sm78925195ad.23.2024.05.23.09.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 09:17:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 23 May 2024 09:17:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Noah Wang <noahwang.wang@outlook.com>
Cc: jdelvare@suse.com, robh@kernel.org, conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 2/2] hwmon: add MP2891 driver
Message-ID: <6fde589b-5344-4ae9-83f7-aacfab9de4ec@roeck-us.net>
References: <20240523093348.171024-1-noahwang.wang@outlook.com>
 <SEYPR04MB6482956A833D60133EE47765FAF42@SEYPR04MB6482.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEYPR04MB6482956A833D60133EE47765FAF42@SEYPR04MB6482.apcprd04.prod.outlook.com>

On Thu, May 23, 2024 at 05:33:48PM +0800, Noah Wang wrote:
> This driver is designed for MPS VR controller mp2891. This driver
> exposes telemetry and limit value readings.
> 
> Signed-off-by: Noah Wang <noahwang.wang@outlook.com>
> 
> V1 -> V2:
>     1. add limit register readings
>     2. add status register readings
>     3. change PSC_CURRENT_OUT format from linear to direct
>     4. add more detailed explanation for special processing
>     5. remove useless code
>     6. move identify vout_scale, iout_scale function to
>         identify() callback
>     7. update MP2891 datasheet

Couple of general comments:

It looks like the chip isn't really using linear11 format (at least not
for the most part); while some of the values have an exponent, the scale
always seems to be the same. I wonder if it would make sense to convert
all values into direct format and use r/m/b scale, or in other words
drop the exponent bits where needed.

There are no write functions for limit registers/commands, meaning
that values would be written directly into registers. I can only
imagine that this would cause a lot of trouble if anyone ever tries
to write a limit, especially for those registers where the upper bits
are not values but configuration (?) bits such as VOUT_UV_FAULT_LIMIT.

Checkpatch reports several "CHECK: Alignment should match open
parenthesis". Please fix.

Additional comments inline.

> ---
>  Documentation/hwmon/index.rst  |   1 +
>  Documentation/hwmon/mp2891.rst | 179 +++++++++++++
>  drivers/hwmon/pmbus/Kconfig    |   9 +
>  drivers/hwmon/pmbus/Makefile   |   1 +
>  drivers/hwmon/pmbus/mp2891.c   | 462 +++++++++++++++++++++++++++++++++
>  5 files changed, 652 insertions(+)
>  create mode 100644 Documentation/hwmon/mp2891.rst
>  create mode 100644 drivers/hwmon/pmbus/mp2891.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 03d313af4..88f70ef60 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -168,6 +168,7 @@ Hardware Monitoring Kernel Drivers
>     mp2975
>     mp5023
>     mp5990
> +   mp2891
>     mpq8785
>     nct6683
>     nct6775
> diff --git a/Documentation/hwmon/mp2891.rst b/Documentation/hwmon/mp2891.rst
> new file mode 100644
> index 000000000..a487d5ee8
> --- /dev/null
> +++ b/Documentation/hwmon/mp2891.rst
> @@ -0,0 +1,179 @@
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
> +
The datasheet is not "publically available". It is only available
if one has an account.

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
> +**in1_crit**
> +
> +**in1_crit_alarm**
> +
> +**in1_lcrit**
> +
> +**in1_lcrit_alarm**
> +
> +**in1_min**
> +
> +**in1_min_alarm**
> +
> +The driver provides the following attributes for output voltage:
> +
> +**in2_input**
> +
> +**in2_label**
> +
> +**in2_crit**
> +
> +**in2_crit_alarm**
> +
> +**in2_lcrit**
> +
> +**in2_lcrit_alarm**
> +
> +**in2_min**
> +
> +**in2_min_alarm**
> +
> +**in3_input**
> +
> +**in3_label**
> +
> +**in3_crit**
> +
> +**in3_crit_alarm**
> +
> +**in3_lcrit**
> +
> +**in3_lcrit_alarm**
> +
> +**in3_min**
> +
> +**in3_min_alarm**
> +
> +The driver provides the following attributes for input current:
> +
> +**curr1_input**
> +
> +**curr1_label**
> +
> +**curr1_max**
> +
> +**curr1_max_alarm**
> +
> +**curr2_input**
> +
> +**curr2_label**
> +
> +**curr2_max**
> +
> +**curr2_max_alarm**
> +
> +The driver provides the following attributes for output current:
> +
> +**curr3_input**
> +
> +**curr3_label**
> +
> +**curr3_crit**
> +
> +**curr3_crit_alarm**
> +
> +**curr3_max**
> +
> +**curr3_max_alarm**
> +
> +**curr4_input**
> +
> +**curr4_label**
> +
> +**curr4_crit**
> +
> +**curr4_crit_alarm**
> +
> +**curr4_max**
> +
> +**curr4_max_alarm**
> +
> +The driver provides the following attributes for input power:
> +
> +**power1_input**
> +
> +**power1_label**
> +
> +**power1_max**
> +
> +**power1_alarm**
> +
> +**power2_input**
> +
> +**power2_label**
> +
> +**power2_max**
> +
> +**power2_alarm**
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
> +**temp1_crit**
> +
> +**temp1_crit_alarm**
> +
> +**temp1_max**
> +
> +**temp1_max_alarm**
> +
> +**temp2_input**
> +
> +**temp2_crit**
> +
> +**temp2_crit_alarm**
> +
> +**temp2_max**
> +
> +**temp2_max_alarm**
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 08e82c457..c0cc673a6 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -371,6 +371,15 @@ config SENSORS_MP5990
>  	  This driver can also be built as a module. If so, the module will
>  	  be called mp5990.
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
>  config SENSORS_MPQ7932_REGULATOR
>  	bool "Regulator support for MPQ7932"
>  	depends on SENSORS_MPQ7932 && REGULATOR
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 2279b3327..4f680bf06 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
>  obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
>  obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
>  obj-$(CONFIG_SENSORS_MP5990)	+= mp5990.o
> +obj-$(CONFIG_SENSORS_MP2891)	+= mp2891.o
>  obj-$(CONFIG_SENSORS_MPQ7932)	+= mpq7932.o
>  obj-$(CONFIG_SENSORS_MPQ8785)	+= mpq8785.o
>  obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
> diff --git a/drivers/hwmon/pmbus/mp2891.c b/drivers/hwmon/pmbus/mp2891.c
> new file mode 100644
> index 000000000..afe49fcb3
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/mp2891.c
> @@ -0,0 +1,462 @@
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
> +/*
> + * Vender specific registers, the register MFR_SVI3_IOUT_PRT(0x65),
> + * MFR_VOUT_LOOP_CTRL(0xBD), READ_PIN_EST(0x94)and READ_IIN_EST(0x95)
> + * redefine the standard PMBUS register. The MFR_SVI3_IOUT_PRT(0x65)
> + * is used to identify the iout scale and the MFR_VOUT_LOOP_CTRL(0xBD)
> + * is used to identify the vout scale. The READ_PIN_EST(0x94) is used
> + * to read input power of per rail. The MP2891 does not have standard
> + * READ_IIN register(0x89), the iin telemetry can be obtained through
> + * the vendor redefined register READ_IIN_EST(0x95).
> + */
> +#define MFR_VOUT_LOOP_CTRL      0xBD
> +#define READ_PIN_EST            0x94
> +#define READ_IIN_EST            0x95
> +#define MFR_SVI3_IOUT_PRT	    0x65
> +
> +#define MP2891_TEMP_LIMIT_OFFSET	40
> +#define MP2891_PIN_LIMIT_UINT		2
> +#define MP2891_IOUT_LIMIT_UINT	    8
> +#define MP2891_IOUT_SCALE_DIV       32
> +#define MP2891_VOUT_SCALE_DIV       100
> +#define MP2891_OVUV_DELTA_SCALE     50
> +#define MP2891_OV_LIMIT_SCALE       20
> +#define MP2891_UV_LIMIT_SCALE       5
> +
> +#define MP2891_PAGE_NUM			2
> +

Please watch out for tab alignment. Defines should be 

#define<space>NAME<tab>value

> +#define MP2891_RAIL1_FUNC	(PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | \
> +							PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP | \
> +							PMBUS_HAVE_POUT | PMBUS_HAVE_PIN | \
> +							PMBUS_HAVE_IIN | PMBUS_HAVE_STATUS_VOUT | \
> +							PMBUS_HAVE_STATUS_IOUT | \
> +							PMBUS_HAVE_STATUS_INPUT | \
> +							PMBUS_HAVE_STATUS_TEMP)
> +
> +#define MP2891_RAIL2_FUNC	(PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | \
> +							PMBUS_HAVE_TEMP | PMBUS_HAVE_POUT | \
> +							PMBUS_HAVE_PIN | PMBUS_HAVE_IIN | \
> +							PMBUS_HAVE_STATUS_VOUT | \
> +							PMBUS_HAVE_STATUS_IOUT | \
> +							PMBUS_HAVE_STATUS_INPUT | \
> +							PMBUS_HAVE_STATUS_TEMP)
> +
> +struct mp2891_data {
> +	struct pmbus_driver_info info;
> +	int vout_scale[MP2891_PAGE_NUM];
> +	int iout_scale[MP2891_PAGE_NUM];
> +};
> +
> +#define to_mp2891_data(x) container_of(x, struct mp2891_data, info)
> +
> +#define MAX_LIN_MANTISSA	(1023 * 1000)
> +#define MIN_LIN_MANTISSA	(511 * 1000)
> +
> +/* Converts a milli-unit DIRECT value to LINEAR11 format */
> +static u16 mp2891_data2reg_linear11(s64 val)
> +{
> +	s16 exponent = 0, mantissa;
> +	bool negative = false;
> +
> +	/* simple case */
> +	if (val == 0)
> +		return 0;
> +
> +	/* Reduce large mantissa until it fits into 10 bit */
> +	while (val >= MAX_LIN_MANTISSA && exponent < 15) {
> +		exponent++;
> +		val >>= 1;
> +	}

I don't think any of the data registers provides more than 10 bits
of range, so most of this complexity is unnecessary.

> +	/* Increase small mantissa to improve precision */
> +	while (val < MIN_LIN_MANTISSA && exponent > -15) {
> +		exponent--;
> +		val <<= 1;
> +	}
> +
> +	/* Convert mantissa from milli-units to units */
> +	mantissa = clamp_val(DIV_ROUND_CLOSEST_ULL(val, 1000), 0, 0x3ff);
> +
> +	/* restore sign */
> +	if (negative)
> +		mantissa = -mantissa;
> +
> +	/* Convert to 5 bit exponent, 11 bit mantissa */
> +	return (mantissa & 0x7ff) | ((exponent << 11) & 0xf800);
> +}
> +
> +static int
> +mp2891_identify_vout_scale(struct i2c_client *client, struct pmbus_driver_info *info,
> +										int page)
> +{
> +	struct mp2891_data *data = to_mp2891_data(info);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_word_data(client, MFR_VOUT_LOOP_CTRL);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * The output voltage is equal to the READ_VOUT(0x8B) register value multiply
> +	 * by vout_scale.
> +	 * Obtain vout scale from the register MFR_VOUT_LOOP_CTRL, bits 15-14,bit 13.
> +	 * If MFR_VOUT_LOOP_CTRL[13] = 1, the vout scale is below:
> +	 * 2.5mV/LSB
> +	 * If MFR_VOUT_LOOP_CTRL[13] = 0, the vout scale is decided by
> +	 * MFR_VOUT_LOOP_CTRL[15:14]:
> +	 * 00b - 6.25mV/LSB, 01b - 5mV/LSB, 10b - 2mV/LSB, 11b - 1mV
> +	 */
> +	if (ret & GENMASK(13, 13)) {
> +		data->vout_scale[page] = 250;
> +	} else {
> +		ret = FIELD_GET(GENMASK(15, 14), ret);
> +		if (ret == 0)
> +			data->vout_scale[page] = 625;
> +		else if (ret == 1)
> +			data->vout_scale[page] = 500;
> +		else if (ret == 2)
> +			data->vout_scale[page] = 200;
> +		else
> +			data->vout_scale[page] = 100;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +mp2891_identify_iout_scale(struct i2c_client *client, struct pmbus_driver_info *info,
> +										int page)
> +{
> +	struct mp2891_data *data = to_mp2891_data(info);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_word_data(client, MFR_SVI3_IOUT_PRT);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * The output current is equal to the READ_IOUT(0x8C) register value
> +	 * multiply by iout_scale.
> +	 * Obtain iout_scale from the register MFR_SVI3_IOUT_PRT[2:0].
> +	 * The value is selected as below:
> +	 * 000b - 1A/LSB, 001b - (1/32)A/LSB, 010b - (1/16)A/LSB,
> +	 * 011b - (1/8)A/LSB, 100b - (1/4)A/LSB, 101b - (1/2)A/LSB
> +	 * 110b - 1A/LSB, 111b - 2A/LSB
> +	 */
> +	switch (ret & GENMASK(2, 0)) {
> +	case 0:
> +	case 6:
> +		data->iout_scale[page] = 32;
> +		break;
> +	case 1:
> +		data->iout_scale[page] = 1;
> +		break;
> +	case 2:
> +		data->iout_scale[page] = 2;
> +		break;
> +	case 3:
> +		data->iout_scale[page] = 4;
> +		break;
> +	case 4:
> +		data->iout_scale[page] = 8;
> +		break;
> +	case 5:
> +		data->iout_scale[page] = 16;
> +		break;
> +	default:
> +		data->iout_scale[page] = 64;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mp2891_identify(struct i2c_client *client, struct pmbus_driver_info *info)
> +{
> +	int ret;
> +
> +	/* Identify vout scale for rail 1. */
> +	ret = mp2891_identify_vout_scale(client, info, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Identify vout scale for rail 2. */
> +	ret = mp2891_identify_vout_scale(client, info, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Identify iout scale for rail 1. */
> +	ret = mp2891_identify_iout_scale(client, info, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Identify iout scale for rail 2. */
> +	ret = mp2891_identify_iout_scale(client, info, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ret;
> +}
> +
> +static int mp2891_read_byte_data(struct i2c_client *client, int page, int reg)
> +{
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_VOUT_MODE:
> +		/*
> +		 * The MP2891 does not follow standard PMBus protocol completely, the
> +		 * PMBUS_VOUT_MODE(0x20) in MP2891 is reserved and 0x00 is always be
> +		 * returned when the register is read. But the calculation of vout in
> +		 * this driver is based on direct format. As a result, the format of
> +		 * vout is enforced to direct.
> +		 */
> +		ret = PB_VOUT_MODE_DIRECT;
> +		break;
> +	default:
> +		ret = -ENODATA;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mp2891_read_word_data(struct i2c_client *client, int page,
> +				 int phase, int reg)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct mp2891_data *data = to_mp2891_data(info);
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_READ_IIN:
> +		/*
> +		 * The MP2891 does not have standard PMBUS_READ_IIN register(0x89),
> +		 * the iin telemetry can be obtained through the vender redefined
> +		 * register READ_IIN_EST(0x95).
> +		 */
> +		ret = pmbus_read_word_data(client, page, phase, READ_IIN_EST);
> +		break;
> +	case PMBUS_READ_PIN:
> +		/*
> +		 * The MP2891 has standard PMBUS_READ_PIN register(0x97), but this
> +		 * is not used to read the input power of per rail. The input power
> +		 * of per rail is read through the vender redefined register
> +		 * READ_PIN_EST(0x94).
> +		 */
> +		ret = pmbus_read_word_data(client, page, phase, READ_PIN_EST);
> +		break;
> +	case PMBUS_READ_VOUT:
> +	case PMBUS_VOUT_UV_WARN_LIMIT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = DIV_ROUND_CLOSEST(ret * data->vout_scale[page], MP2891_VOUT_SCALE_DIV);
> +		break;
> +	case PMBUS_READ_IOUT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = DIV_ROUND_CLOSEST((ret & GENMASK(10, 0)) * data->iout_scale[page],
> +								MP2891_IOUT_SCALE_DIV);
> +		break;
> +	case PMBUS_OT_FAULT_LIMIT:
> +	case PMBUS_OT_WARN_LIMIT:
> +		/*
> +		 * The MP2891 PMBUS_OT_FAULT_LIMIT and PMBUS_OT_WARN_LIMIT are not
> +		 * linear11 format, the scale is 1°C/LSB and they have 40°C offset.
> +		 * As a result, the limit value is calculated to m°C first, then
> +		 * it is converted to linear11 format.
> +		 */
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = mp2891_data2reg_linear11(((ret & GENMASK(7, 0)) -
> +								MP2891_TEMP_LIMIT_OFFSET) * 1000);
> +		break;
> +	case PMBUS_VIN_UV_FAULT_LIMIT:
> +	case PMBUS_VIN_UV_WARN_LIMIT:
> +		/*
> +		 * The MP2891 PMBUS_VIN_UV_FAULT_LIMIT and PMBUS_VIN_UV_WARN_LIMIT
> +		 * are not linear11 format, the scale is 31.25mV/LSB. As a result,
> +		 * the limit value is calculated to mV first, then it is converted
> +		 * to linear11 format.
> +		 */
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = mp2891_data2reg_linear11(DIV_ROUND_CLOSEST((ret & GENMASK(9, 0)) * 3125,
> +										100));
> +		break;
> +	case PMBUS_VIN_OV_FAULT_LIMIT:
> +		/*
> +		 * The MP2891 PMBUS_VIN_OV_FAULT_LIMIT are not linear11 format,
> +		 * the scale is 125mV/LSB. As a result, the limit value is
> +		 * calculated to mV first, then it is converted to linear11
> +		 * format.
> +		 */
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = mp2891_data2reg_linear11((ret & GENMASK(7, 0)) * 125);
> +		break;
> +	case PMBUS_VOUT_UV_FAULT_LIMIT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (FIELD_GET(GENMASK(11, 8), ret))
> +			ret = FIELD_GET(GENMASK(7, 0), ret) * MP2891_UV_LIMIT_SCALE -
> +				(FIELD_GET(GENMASK(11, 8), ret) + 1) * MP2891_OVUV_DELTA_SCALE;
> +		else
> +			ret = FIELD_GET(GENMASK(7, 0), ret) * MP2891_UV_LIMIT_SCALE;
> +
> +		ret = ret < 0 ? 0 : ret;
> +		break;
> +	case PMBUS_VOUT_OV_FAULT_LIMIT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (FIELD_GET(GENMASK(11, 8), ret))
> +			ret = FIELD_GET(GENMASK(7, 0), ret) * MP2891_OV_LIMIT_SCALE +
> +				(FIELD_GET(GENMASK(11, 8), ret) + 1) * MP2891_OVUV_DELTA_SCALE;
> +		else
> +			ret = FIELD_GET(GENMASK(7, 0), ret) * MP2891_OV_LIMIT_SCALE;
> +		break;
> +	case PMBUS_IOUT_OC_WARN_LIMIT:
> +	case PMBUS_IOUT_OC_FAULT_LIMIT:
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = DIV_ROUND_CLOSEST((ret & GENMASK(7, 0)) * data->iout_scale[page] *
> +						MP2891_IOUT_LIMIT_UINT, MP2891_IOUT_SCALE_DIV);
> +		break;
> +	case PMBUS_IIN_OC_WARN_LIMIT:
> +		/*
> +		 * The MP2891 PMBUS_IIN_OC_WARN_LIMIT are not linear11 format, the
> +		 * scale is 0.5V/LSB. As a result, the limit value is calculated to
> +		 * mA first, then it is converted to linear11 format.
> +		 */
> +		ret = pmbus_read_word_data(client, 0, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = mp2891_data2reg_linear11((ret & GENMASK(9, 0)) * 1000 / 2);
> +		break;
> +	case PMBUS_PIN_OP_WARN_LIMIT:
> +		/*
> +		 * The MP2891 PMBUS_PIN_OP_WARN_LIMIT are not linear11 format, the
> +		 * scale is 2W/LSB. As a result, the limit value is calculated to
> +		 * mW first, then it is converted to linear11 format.
> +		 */
> +		ret = pmbus_read_word_data(client, 0, phase, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = mp2891_data2reg_linear11((ret & GENMASK(9, 0)) * MP2891_PIN_LIMIT_UINT *
> +										1000);
> +		break;
> +	case PMBUS_READ_VIN:
> +	case PMBUS_READ_POUT:
> +	case PMBUS_READ_TEMPERATURE_1:
> +		ret = -ENODATA;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static struct pmbus_driver_info mp2891_info = {
> +	.pages = MP2891_PAGE_NUM,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_CURRENT_OUT] = direct,
> +	.format[PSC_TEMPERATURE] = linear,
> +	.format[PSC_POWER] = linear,
> +	.format[PSC_VOLTAGE_OUT] = direct,
> +
> +	.m[PSC_VOLTAGE_OUT] = 1,
> +	.R[PSC_VOLTAGE_OUT] = 3,
> +	.b[PSC_VOLTAGE_OUT] = 0,
> +
> +	.m[PSC_CURRENT_OUT] = 1,
> +	.R[PSC_CURRENT_OUT] = 0,
> +	.b[PSC_CURRENT_OUT] = 0,
> +
> +	.func[0] = MP2891_RAIL1_FUNC,
> +	.func[1] = MP2891_RAIL2_FUNC,
> +	.read_word_data = mp2891_read_word_data,
> +	.read_byte_data = mp2891_read_byte_data,
> +	.identify = mp2891_identify,
> +};
> +
> +static int mp2891_probe(struct i2c_client *client)
> +{
> +	struct pmbus_driver_info *info;
> +	struct mp2891_data *data;
> +
> +	data = devm_kzalloc(&client->dev, sizeof(struct mp2891_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	memcpy(&data->info, &mp2891_info, sizeof(*info));
> +	info = &data->info;
> +
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
> +MODULE_DESCRIPTION("PMBus driver for MPS MP2891");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);
> -- 
> 2.25.1
> 

