Return-Path: <linux-kernel+bounces-568821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8AA69AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A183BC7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843922165E9;
	Wed, 19 Mar 2025 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iey2YFg6"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B243A20C47B;
	Wed, 19 Mar 2025 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419324; cv=none; b=EW60to/R+uELoI1x5tvMsOYNoWSc61unYmQ7McDnFGnLv91nDkP+DfENpErNwkE6g5FBRYN7BCi1vL0KhKEoEVy9U8ntbBAyfXdIacnqtWEKq/j39/zQsSRrj+iuAL7+FRAbgvywqaIC+0Hm3xB7BVYUWQ6jClL5jGmslGkyGpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419324; c=relaxed/simple;
	bh=8fw533LX3us9uq4fnVKecH9A/hjLxfTzEbEoQzevf2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzRNJHWFtn1pWS3qZTW+q4I9157bYgvgWmRR8R8hn0NbeHWf17iaW1Gh1Hgt7I573wDIlippz7t5HPG1DSfBX6JIRfWeEq34opqOEf48YfIsEhFVhGIWHEEF+rsBGYHlygidEvYVTBPD35LO/AL4G9Y/jT3pYMRE8BrOvp7+roA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iey2YFg6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22409077c06so658995ad.1;
        Wed, 19 Mar 2025 14:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742419321; x=1743024121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=INjxBY4NUU14lbJiLiuDMPDrJe530L26PzqgZvfD9z4=;
        b=Iey2YFg6QsVUl1nJ8RmHzrbOIuZXDRQDFKcGyMoN9mxQ3RMmt0oUw2ZBZanZghGG2X
         fePChQ8dLn56J2Ma17+Lht+F4UM1zKlarB2OYZe2rsClS/mDK5bgLepave78MTqUKrZj
         rnG4lwFUM225yyFBywk3mGy4JDXCcDTqOBfvwC34XvrLn1CkBsbqvWvyQtuG0A5QnOtl
         xHuPo/bNvcU17L2vnCA8aPOm3smSBAdVzDnylQXz2o3IBGiYnG5n9hxM2SGvMs9J9+7d
         3l2mLHguNKMYeWXpL5sAA6u1Xsez3HPbusTD02Lmxeccy7aKpYV3sVogQdCFXZcEjb/c
         1+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742419321; x=1743024121;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INjxBY4NUU14lbJiLiuDMPDrJe530L26PzqgZvfD9z4=;
        b=gX8n3TD+cANVd8EqWFBRf98Scxqaa4rl7eLdWhQK2cPo9dC4KiK/jLjBaG6GsWyyDI
         42XbwYnXmOh9tfgLH0pVmpU3r3S45WakRLdvhBYz5xmppvisCFpv7Eo/MTw0nJidDaPw
         BeQaUmZd2dovSagxdgtXXY797COL+3wfzYbYsznh5cK0c89EAtMsWQeHcBjCNbx9p3eR
         xxeNNL54hIOUN34FDDMdd9xk2tdyIL1nELUDfpKxRcRLRoewDvV4c+rwG4Rw5IyZeS9t
         OFf/aeiwmyXAYxaq6ecLjWxCuNCdZ9KtXo62/4k9muKseu4l91caOGaHdh148kz5e6a3
         TG1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMx9fwmCqJv2qbVQccXrk5HuLxmSZL0i/fl5Q1ILcbaBccjNWM9MD4bOApCtncvYRjdHZC1Ky34d5e@vger.kernel.org, AJvYcCVN8ee5vnsCcuYduvtJ1f2xfvx667fFaVzOhDFdQGxjDyhuxeIu95SbavqqqiAIAN24/ewTDR24QfFDiiUJ@vger.kernel.org, AJvYcCWGAQN8p1hzSEQ8bP7mLWEJP8vb39eBDT5aJm0ks6tF4ZuiBIqyzncEGKKZna4G2WHhc/UKT47MDcwn@vger.kernel.org, AJvYcCXZJyxoSwkL1r95wAmCK2vOKDVu30znwfeKq9OLIV6FK6+hCFiv4LzSRMxTfaTK2dLcqDoE1SccVxIMD/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2swWISeVr3JE7W/h/jHdv24Wy2I9Z4f6OIc2wV94Ti/mX580
	5l+ZOa2XCqHI9rVijnzqik6eCpXVZ7ppxcfhkgQWX3e6w3zjSVab
X-Gm-Gg: ASbGnct2QEi+GRZFXSYBOKTGsYkLF6PGDPwgoQmAwj+X6h5zUBEYnkPqYC/a1gcmhFD
	G1ctiWkDs4+rDl01O0Yb+qP2pplwaV5dPA4rSSEkK96YCXsZfn1S59TaHkBpVJ+LvZep7cWe9Pf
	efU3/UC01PTlqzisZ1h+v0QR0Xi1mQXKY7VgRC9IARWuWyiFEYDEuSdgYi9B9iRr1swGkQFYQ6U
	phFkqJFklJIQ0hnfDKNSqxP/JpbGzx+5QKN/p9W7HofzpUuL3yalMiE7cf/TmKbwfcg8+28xx9R
	PrUoaCvaNHdyvv4kze41ag4DQD9KKwXxOLxzt+d9M5rubXLSHLvutEBACYzUhh61lr/eKvX4UGG
	bsuZuXz1eUbSMRG+D+Q==
X-Google-Smtp-Source: AGHT+IGV7Pv090h51drctBEe4Wmlhq3Wsn3jsAdJuDNu4VJb6UUlfbVe9OdEXERbqnAVCAkPypUO2w==
X-Received: by 2002:a17:90b:3c4a:b0:2fa:137f:5c61 with SMTP id 98e67ed59e1d1-301d50b3be1mr1577062a91.12.1742419320461;
        Wed, 19 Mar 2025 14:22:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd53aasm119911755ad.247.2025.03.19.14.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 14:21:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <60ed83d9-c5e3-40c3-9004-6c44511e3a9c@roeck-us.net>
Date: Wed, 19 Mar 2025 14:21:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hwmon: Add support for TI TPS389008
To: Flaviu Nistor <flaviu.nistor@googlemail.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>, Jean Delvare
 <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250319170234.63723-1-flaviu.nistor@gmail.com>
 <20250319170234.63723-2-flaviu.nistor@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250319170234.63723-2-flaviu.nistor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/25 10:02, Flaviu Nistor wrote:
> TI TPS38900x are voltage monitor IC's.
> 
> All device variants offer an I2C interface and depending on the
> part number, x monitor inputs.
> 
> Support chips by the driver are TPS389008, TPS389006 and TPS389004.
> 
> The driver adds support for reading the 8-bit ADC value of any of

Use imperative mood.

> the VMON inputs. By default the inputs are disabled and have a scaling
> factor of 1x. They need to be enabled in the device tree, or using the
> sysfs attribute from user space.
> 
Default must be the current chip configuration.

> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>

You'll have to decide if you want to use flaviu.nistor@googlemail.com or
flaviu.nistor@gmail.com.

This is not a complete review.

General comments:

- The driver must support non-devicetree configurations and
   in that case just use defaults (i.e., use what the chip provides).

- Drop VMON. This is a driver for the chip, not just for its voltage monitoring
   capabilities.

- Voltage channel numbers start with 0. Yes, there are one or two drivers
   starting with 1 for historic reasons, but that is not an argument.
   Besides, just looking at the code should make it obvious that the 1->0 mapping
   is risky and error prone.

- checkpatch --strict says:

   total: 0 errors, 4 warnings, 13 checks, 566 lines checked

   I expect that to be addressed in the next version.

> ---
>   Documentation/hwmon/index.rst     |   1 +
>   Documentation/hwmon/tps389008.rst |  56 ++++
>   MAINTAINERS                       |   8 +
>   drivers/hwmon/Kconfig             |  10 +
>   drivers/hwmon/Makefile            |   1 +
>   drivers/hwmon/tps389008.c         | 466 ++++++++++++++++++++++++++++++
>   6 files changed, 542 insertions(+)
>   create mode 100644 Documentation/hwmon/tps389008.rst
>   create mode 100644 drivers/hwmon/tps389008.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 874f8fd26325..b04643d14972 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -239,6 +239,7 @@ Hardware Monitoring Kernel Drivers
>      tmp513
>      tps23861
>      tps25990
> +   tps389008
>      tps40422
>      tps53679
>      tps546d24
> diff --git a/Documentation/hwmon/tps389008.rst b/Documentation/hwmon/tps389008.rst
> new file mode 100644
> index 000000000000..6e1166165ac4
> --- /dev/null
> +++ b/Documentation/hwmon/tps389008.rst
> @@ -0,0 +1,56 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver tps389008
> +======================

Does that pass documentation builds ?

> +
> +Supported chips:
> +
> +  * TI TPS389008, TPS389006, TPS389004
> +
> +    Prefix: 'tps389008'
> +
> +    Addresses scanned: -
> + 
> +    Datasheet: https://www.ti.com/lit/ds/symlink/tps389006.pdf?ts=1741000787840&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FTPS389006
> +
> +Author:
> +
> +  - Flaviu Nistor <flaviu.nistor@gmail.com>
> +
> +Description
> +-----------
> +
> +This driver implements support for TI TPS389008, TPS389006 and TPS389004 voltage monitor chips.

Those are not voltage monitor chips, they are voltage supersisor and monitor chips.

> +The driver supports only the chips that have default values based on datasheet and not OTP NVM settings.

Why ? Given the normal use case for those chips (as voltage sequencer)
that doesn't make any sense. If anything, it should be the opposite.

> +Monitored voltages can be read out via an internal ADC with one register per input channel.
> +Measured voltage is expressed in mV per LSB.
> +The measurement voltage ranges depends on the scaling factor used as following:
> +
> +  - 1x scaling: 200 to 1475 mV (8-bit resolution)
> +  - 4x scaling: 800 to 5900 mV (8-bit resolution)
> +
> +The scaling factor is 1 by default for all channels.
> +
> +All input VMON channel are disabled by default, and they can be enabled via the dts (during probe)
> +or using the provided sysfs attribute from user space.

This is unacceptable. Default has to be what the chip is programmed to do
for a chip like this.

> +
> +The device communicates with the I2C protocol and uses the I2C address 0x30 by default.
> +
> +
> +Known Issues
> +------------
> +
> +The driver does not support usage of alarms and setting of thresholds (for the alarms).
> +

Curious: Why ? That would be the primary use case for a hardware monitoring driver.

> +sysfs-Interface
> +---------------
> +
> +The following list includes the sysfs attributes that the driver will provide for each added input channel:
> +
> +=============================== ======= ========================================
> +Name                            Perm    Description
> +=============================== ======= ========================================
> +in[12345678]_input:             RO      Voltage channel input
> +in[12345678]_label:             RO      Voltage channel label
> +in[12345678]_enable:            RW      Voltage channel enable controls

Make that [0-7]. Also indicate number of channels per chip.

> +=============================== ======= ========================================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 16f51eb6ebe8..fbf07f26d933 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23510,6 +23510,14 @@ F:	Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
>   F:	Documentation/hwmon/tps23861.rst
>   F:	drivers/hwmon/tps23861.c
>   
> +TEXAS INSTRUMENTS TPS389008 VMON DRIVER

Drop VMON here and elsewhere.

> +M:	Flaviu Nistor <flaviu.nistor@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/hwmon/ti,tps389008.yaml
> +F:	Documentation/hwmon/tps389008.rst
> +F:	drivers/hwmon/tps389008.c
> +
>   TEXAS INSTRUMENTS' DAC7612 DAC DRIVER
>   M:	Ricardo Ribalda <ribalda@kernel.org>
>   L:	linux-iio@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 4cbaba15d86e..5562eea4d0bb 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1340,6 +1340,16 @@ config SENSORS_TPS23861
>   	  This driver can also be built as a module. If so, the module
>   	  will be called tps23861.
>   
> +config SENSORS_TPS389008
> +	tristate "TI TPS389008 VMON Driver"
> +	depends on I2C
> +	help
> +	  This driver provides support for voltage monitoring for the Texas
> +	  Instruments TPS389008, TPS389006 and TPS389004 chips.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called tps389008.
> +
>   config SENSORS_MENF21BMC_HWMON
>   	tristate "MEN 14F021P00 BMC Hardware Monitoring"
>   	depends on MFD_MENF21BMC
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b7ef0f0562d3..6eb0b7696239 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -164,6 +164,7 @@ obj-$(CONFIG_SENSORS_MC34VR500)	+= mc34vr500.o
>   obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
>   obj-$(CONFIG_SENSORS_TC654)	+= tc654.o
>   obj-$(CONFIG_SENSORS_TPS23861)	+= tps23861.o
> +obj-$(CONFIG_SENSORS_TPS389008) += tps389008.o
>   obj-$(CONFIG_SENSORS_MLXREG_FAN) += mlxreg-fan.o
>   obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) += menf21bmc_hwmon.o
>   obj-$(CONFIG_SENSORS_MR75203)	+= mr75203.o
> diff --git a/drivers/hwmon/tps389008.c b/drivers/hwmon/tps389008.c
> new file mode 100644
> index 000000000000..6ee6c3b58747
> --- /dev/null
> +++ b/drivers/hwmon/tps389008.c
> @@ -0,0 +1,466 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * tps389008.c Support for the TI TPS389008 Voltage Monitor
> + *
> + * Part numbers supported:
> + * TPS389006, TPS389008
> + *

This does not match the rest of the code.

> + * Author: Flaviu Nistor <flaviu.nistor@gmail.com>
> + *
> + * Datasheet and application notes:
> + * https://www.ti.com/

Pretty pointless reference.

> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>

I do not se where completion.h and delay.h would be needed.

> +#include <linux/hwmon.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>

I do not see any interrupt support.

> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>

I do not see any regulator code.

Please only include files which are actually used.

Overall it seems like the template for this driver was either copied,
or the entire driver ws copied and scaled down. That is fine, but there
should be a reference to the origin.

> +
> +#define TPS389008_NUM_CHANNELS      8
> +#define TPS389008_1LSB              5
> +#define RANGE_OFFSET                200
> +#define BANK0                       0
> +#define BANK1                       1
> +/*BANK0 REGISTERS*/
> +#define MON_LVL			            0x40
> +#define BANK_SEL                    0xF0
> +/*BANK1 REGISTERS
> + * use 0x100 to signal that address is part of BANK1
> + */

/*
  * Please use proper multi-line comments, and add spaces after the beginning and before
  * the end of a comment.
  */

> +#define MON_CH_EN                   0x11E
> +
> +struct tps389008_input {
> +	const char *label;
> +	int vrange_mult_mv;
> +	bool enabled;
> +	bool disconnected;

There should only be one flag, for disconnected channels.
'enabled' is a local cache. Either use regmap for caching,
or get it from the chip.

> +};
> +
> +struct tps389008_data {
> +	struct device *hwmon;
> +	struct i2c_client *client;
> +	struct tps389008_input input[TPS389008_NUM_CHANNELS];
> +	struct mutex dev_access_lock; /* device access lock */
> +	const char *name;
> +	int current_bank;
> +};
> +
> +enum tps_chan_addr {
> +	TPS_CHANNEL_0 = 0,
> +	TPS_CHANNEL_1,
> +	TPS_CHANNEL_2,
> +	TPS_CHANNEL_3,
> +	TPS_CHANNEL_4,
> +	TPS_CHANNEL_5,
> +	TPS_CHANNEL_6,
> +	TPS_CHANNEL_7,
> +	TPS_CHANNEL_8

I do not see the point of these defines.

> +};
> +
> +static int tps389008_read_string(struct device *dev, enum hwmon_sensor_types type,
> +	u32 attr, int channel, const char **str)
> +{
> +	struct tps389008_data *tps = dev_get_drvdata(dev);
> +	int index;
> +
> +	index = channel - 1;

This is an absolute no-go. Channels start with 0. There must not be a
dummy channel.

> +	*str = tps->input[index].label;
> +
> +	return 0;
> +}
> +
> +static umode_t tps389008_is_visible(const void *data, enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	const struct tps389008_data *tps = data;
> +	const struct tps389008_input *input = NULL;

Unecessary assignment.

> +	int index;
> +
> +	/* channel numbering starts from 1, but index from 0*/
> +	index = channel - 1;
> +
> +	/* in0_ or disconnected channels should be ignored*/
> +	if (channel == 0 ||
> +		(tps->input[index].disconnected ||
> +		 tps->input[index].vrange_mult_mv == 0)) {

vrange_mult_mv should have a default and never be 0.

> +		return 0;
> +	}
> +	switch (attr) {
> +	case hwmon_in_input:
> +		return 0444;
> +	case hwmon_in_label:
> +		input = &tps->input[index];
> +		/* Hide label node if label is not provided */
> +		return (input && input->label) ? 0444 : 0;

"input" is never NULL.

> +	case hwmon_in_enable:
> +		return 0644;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int change_bank(struct tps389008_data *data, u8 bank)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, BANK_SEL, bank);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"change to bank%d failed with error code: %d\n", bank, ret);

Drop all those runtime error messages.

> +		return ret;
> +	}
> +
> +	return ret;
> +}

This function is only used to display an error message, which I am not going
to accept. All callers check if changing the bank is necessary, and save
the new bank number. This doesn't make sense. Please move the common code into
this function.

> +
> +static int tps389008_write_reg(struct tps389008_data *data, u16 reg, u8 val)
> +{
> +	int ret;
> +	u8 bank;
> +
> +	bank  = (reg & 0x100) >> 8;
> +
> +	if (bank != (u8)data->current_bank) {

Why the typecast and not just define current_bank as u8 ?

> +		change_bank(data, bank);

Add error checks here and everywhere else.

> +		data->current_bank = bank;
> +	}
> +
> +	ret = i2c_smbus_write_byte_data(data->client, reg, val);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +				"I2C write failed at address: 0x%X with error code: %d\n",
> +				reg, ret);

Drop all those log messages.

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tps389008_read_reg(struct tps389008_data *data, u16 reg, u16 *val)
> +{
> +	int read_byte;
> +	u8 bank;
> +
> +	bank  = (reg & 0x100) >> 8;
> +
> +	if (bank != (u8)data->current_bank) {
> +		change_bank(data, bank);
> +		data->current_bank = bank;
> +	}
> +
> +	read_byte = i2c_smbus_read_byte_data(data->client, reg);
> +	if (read_byte < 0) {
> +		dev_err(&data->client->dev,
> +			"I2C read failed at address: 0x%X with error code: %d\n", reg, read_byte);
> +		return read_byte;
> +	}
> +
> +	*val = read_byte;

What is the point of splitting return value and error code ?
It just adds a lot of unnecessary complexity to the code.

> +
> +	return 0;
> +}
> +
> +static int tps389008_get_in_val(struct tps389008_data *data, u16 reg, int channel, long *val)
> +{
> +	u16 reg_val;
> +	int ret;
> +	int index;
> +
> +	/* channel numbering starts from 1, but index from 0*/
> +	index = channel - 1;
> +
> +	ret = tps389008_read_reg(data, reg, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	*val = ((reg_val * TPS389008_1LSB + RANGE_OFFSET) * data->input[index].vrange_mult_mv);

Drop all unnecessary ( ).

> +
> +	return 0;
> +}
> +
> +static int disable_input(struct tps389008_data *data, u8 channel)
> +{
> +	u16 reg_val;
> +	int ret;
> +	int index;
> +
> +	index = channel - 1;
> +
> +	ret = tps389008_read_reg(data, MON_CH_EN, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	reg_val = reg_val & ~(1 << index);
> +
> +	ret = tps389008_write_reg(data, MON_CH_EN, reg_val);
> +
> +	return ret;
> +}
> +
> +static int enable_input(struct tps389008_data *data, u8 channel)
> +{
> +	u16 reg_val;
> +	int ret;
> +	int index;
> +
> +	index = channel - 1;
> +
> +	ret = tps389008_read_reg(data, MON_CH_EN, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	reg_val = reg_val | (1 << index);

This is what the BIT() macro is for. Same here and elsewhere.

> +
> +	ret = tps389008_write_reg(data, MON_CH_EN, reg_val);
> +
> +	return ret;
> +}
> +
> +static int tps389008_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +			int channel, long val)
> +{
> +	struct tps389008_data *data = dev_get_drvdata(dev);
> +	int index;
> +	int ret;
> +
> +	/* channel numbering starts from 1, but index from 0*/
> +	index = channel - 1;
> +
> +	guard(mutex)(&data->dev_access_lock);
> +
> +	if (attr == hwmon_in_input || attr == hwmon_in_label) {
> +		dev_warn(dev, "Write to READ ONLY resource\n");
> +		return -EOPNOTSUPP;
> +	}

The checked attributes are read-only. This won't happen.
Even if it was possible, the error message would be unacceptable.
Please drop this code.

> +	if (attr == hwmon_in_enable) {
> +		if (val == 0) {
> +			data->input[index].enabled = val;
> +			ret = disable_input(data, channel);
> +			return ret;
> +		} else if (val == 1) {
> +			data->input[index].enabled = val;
> +			ret = enable_input(data, channel);
> +			return ret;
> +		}
> +		dev_err(dev, "invalid value %ld\n", val);

This would create a lot of noise if someone keeps writing "2".
It is both unnecessary and unacceptable.

> +		return -EINVAL;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int tps389008_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +			int channel, long *val)
> +{
> +
> +	struct tps389008_data *data = dev_get_drvdata(dev);
> +	int ret;
> +	int index;
> +
> +	/* channel numbering starts from 1, but index from 0*/
> +	index = channel - 1;
> +
> +	guard(mutex)(&data->dev_access_lock);
> +
> +	switch (attr) {
> +	case hwmon_in_input:
> +		ret = tps389008_get_in_val(data, MON_LVL + index, channel, val);
> +		if (ret)
> +			dev_err(dev,
> +				"Reading the ADC value for channel %d failed with error code: %d\n",
> +				channel, ret);
> +		break;
> +	case hwmon_in_enable:
> +		*val = data->input[index].enabled;

ret is uninitialized. No idea why the compiler doesn't bail out here.

> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct hwmon_channel_info *tps389008_info[] = {
> +	HWMON_CHANNEL_INFO(in,
> +					/* 0: dummy, skipped in is_visible */
> +					HWMON_I_INPUT,
> +					/* 1-8: input voltage Channels */
> +					HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> +					HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> +					HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> +					HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> +					HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> +					HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> +					HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
> +					HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL),

Indentation is way to deep.

> +	NULL
> +};
> +
> +static const struct hwmon_ops tps389008_hwmon_ops = {
> +	.is_visible = tps389008_is_visible,
> +	.read_string = tps389008_read_string,
> +	.read = tps389008_read,
> +	.write = tps389008_write,
> +};
> +
> +static const struct hwmon_chip_info tps389008_chip_info = {
> +	.ops = &tps389008_hwmon_ops,
> +	.info = tps389008_info,
> +};
> +
> +

No double empty lines. checkpatch would tell you.

> +static int tps389008_probe_child_from_dt(struct device *dev,
> +	struct device_node *child,
> +	struct tps389008_data *tps)

Please no unnecessary continuation lines. On top of that,
continuation line assignment is wrong. Again, checkpatch would tell.

> +{
> +	struct tps389008_input *input;
> +	u32 val;
> +	int ret;
> +
> +	ret = of_property_read_u32(child, "reg", &val);
> +	if (ret) {
> +		dev_err(dev, "missing reg property of %pOFn\n", child);
> +		return ret;
> +	}
> +	if (val < 1 || val > TPS_CHANNEL_8) {

This should compare against the actual number of channels supported by the chip.

> +		dev_err(dev, "invalid reg %d of %pOFn\n", val, child);
> +		return -EINVAL;
> +	}
> +
> +	/* remember that children nodes starts from 1, but we have the input start index 0.*/
> +	input = &tps->input[val-1];
> +
> +	ret = (int)of_property_read_bool(child, "ti,vrange-mult-4x");

Unnecessary type cast and, for that matter, variable assignment.

	if (of_property_read_bool(child, "ti,vrange-mult-4x"))

would be just as good.

> +	if (ret)
> +		input->vrange_mult_mv = 4;
> +	else
> +		input->vrange_mult_mv = 1;
> +
> +	ret = (int)of_property_read_bool(child, "ti,vmon-enable");
> +	/* missing optional property. Default enable the channel*/
> +	if (ret)
> +		input->enabled = true;

	input->enabled = of_property_read_bool(child, "ti,vmon-enable");

> +
> +	/* Log the disconnected channel input */
> +	if (!of_device_is_available(child)) {
> +		input->disconnected = true;
> +		return 0;
> +	}
> +
> +	/* Save the connected input label if available */
> +	of_property_read_string(child, "label", &input->label);
> +
> +	return 0;
> +}
> +
> +static int tps389008_probe_from_dt(struct device *dev, struct tps389008_data *tps)
> +{
> +	const struct device_node *np = dev->of_node;
> +	struct device_node *child;
> +	int ret;
> +
> +	for_each_child_of_node(np, child) {

Use for_each_child_of_node_scoped().

> +		ret = tps389008_probe_child_from_dt(dev, child, tps);
> +		if (ret) {
> +			of_node_put(child);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int tps389008_probe(struct i2c_client *client)
> +{
> +	struct tps389008_data *data;
> +	struct device *dev = &client->dev;
> +	int ret, i;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -EOPNOTSUPP;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, data);
> +	mutex_init(&data->dev_access_lock);

Use devm_mutex_init() and drop the remove function.

> +	data->client = client;
> +
> +	ret = tps389008_probe_from_dt(dev, data);
> +	if (ret) {
> +		dev_err(dev, "Unable to probe from device tree\n");
> +		return ret;
> +	}
> +
> +	data->current_bank = 0;

This is just an assumption. Either read the current channel from
the chip, or set it to an nivalid value such as 0xff to ensure
that the channel is selected with the first access.

> +
> +	/* Enable channels if they are enabled */
> +	for (i = 0; i < TPS389008_NUM_CHANNELS; i++) {
> +		if (data->input[i].enabled) {
> +			enable_input(data, i+1);

Error check missing.

> +			dev_dbg(dev, "VMON input %d is enabled\n", (i+1));
> +		}
> +	}
> +
> +	data->hwmon = devm_hwmon_device_register_with_info(dev, client->name,
> +							   data, &tps389008_chip_info,
> +							   NULL);
> +
> +	if (IS_ERR(data->hwmon))
> +		return dev_err_probe(dev, PTR_ERR(data->hwmon),
> +					 "Failed to register hwmon device tps389008\n");
> +
> +	dev_info(dev, "hwmon device tps389008 probed successfully\n");
> +
Noise; please drop.

> +	return 0;
> +}
> +
> +static void tps389008_remove(struct i2c_client *client)
> +{
> +	struct tps389008_data *tps = dev_get_drvdata(&client->dev);
> +
> +	hwmon_device_unregister(tps->hwmon);
> +
> +	mutex_destroy(&tps->dev_access_lock);
> +}
> +
> +static const struct i2c_device_id tps389008_ids[] = {
> +	{ "tps389008" },
> +	{ "tps389006" },
> +	{ "tps389004" },

The number of channels should be listed here for each chip to support defaults.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tps389008_ids);
> +
> +static const struct of_device_id tps389008_of_match[] = {
> +	{ .compatible = "ti,tps389008", },
> +	{ .compatible = "ti,tps389006", },
> +	{ .compatible = "ti,tps389004", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, tps389008_of_match);
> +
> +static struct i2c_driver tps389008_i2c_driver = {
> +	.driver = {
> +		.name = "tps389008",
> +		.of_match_table = tps389008_of_match,
> +	},
> +	.probe = tps389008_probe,
> +	.remove = tps389008_remove,
> +	.id_table = tps389008_ids,
> +};
> +
> +module_i2c_driver(tps389008_i2c_driver);
> +
> +MODULE_AUTHOR("Flaviu Nistor <flaviu.nistor@gmail.com>");
> +MODULE_DESCRIPTION("TI TPS389008 voltage monitor driver");
> +MODULE_LICENSE("GPL");


