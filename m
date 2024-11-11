Return-Path: <linux-kernel+bounces-404628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796279C45E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AB228423C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F421BB6BF;
	Mon, 11 Nov 2024 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SayCeDbO"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9141BB6BE;
	Mon, 11 Nov 2024 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731353479; cv=none; b=WlumgOwsqLmXi/aEiIBifwtI5GV3TgLrGuzEQenmIheLBjyO6CiWv+cXCAd4Tkppw9EXdlUzknmHIHtcS4jDLscUJsBgUdjV1c0jm/iIwaxnqTZGzaDKc0c+o+CcYf7VOFoYkEg2sjbpv/yEus7Ge35WIy+dSZpfRLp3MewEvpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731353479; c=relaxed/simple;
	bh=aWyLdd9/dmux+xmcpmgsuOlC7XGUqZCUd42vUE/kKn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ky0h1mEech69rVP4rv3aIzBxRcMYwxr2uKQ/ej1SPImVR8f2FOB3FQN26JiVVVY6+Zh1GKmORn4jKfCFOM/qZgxp1GunuHwyVO37WiCEs8XLADOMyXyvAOk6BIxYTLPnO9cPchTn4pd8Fi20K7OqOhEYm1cxWhbPVqkNCgeR+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SayCeDbO; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e52582cf8so3811697b3a.2;
        Mon, 11 Nov 2024 11:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731353477; x=1731958277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qbuqf46y5oFcvCYLEnKQhR4Sj2irKhfbrLFisV+GHII=;
        b=SayCeDbOg6T7VLrRZQNxp7l3Ikg5JbngFH+wrpiwNzGkhNEbbcbut/qHN8OwSWu2Xb
         n0CU59GW7bc+ACYF2kutYIuKuZ7MKNUmEgX+TWz3ZzuhCzcWcmjXGdLbeXlRTN/BeyIk
         LV7l03fyREE91FVvhd1Y/q7WfT8K3IvKPiXWCcVj/p0os9OyBrbHuzsNwqE5T7YgwMXN
         XetGCnekWPxm1HjgdrwxE6Nzxs/pGclHzwBMz9mu1ra1XtzGiaHEgtbdhqCIB+tcPyDK
         0UPw57H5DKAuEEEJH5GQaRYb5bs4O9EvgrWOdgDfVnbm3OHZkbEfpmThcxXhGZ5x1kZi
         VL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731353477; x=1731958277;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbuqf46y5oFcvCYLEnKQhR4Sj2irKhfbrLFisV+GHII=;
        b=KKzew/K+6C2vzUJg5rcC4m8csNkItNS0pgjJztecdhYWxuxiY9Vgk+cv9tcN6tXVUw
         NG1ZCbTsdeUc09Qv8mRPXETuA/ACGdfeDqnl741EEYu6ma1Iv54jgxtrzgI0icK51NjC
         mFoYVY7Ve37NtGTMAjLoy/5N0Ub4Jm52qrf8sY22Vgcz35MClgqVfFukNEpDyb/GC7ch
         ZiVrvfv34nFf5NlDMwXNwdQF8QwG/gjA12ggNf+mwx764UZnYpsi4AyS6M0aeaCMTZ7B
         oAZzI++a0CBiWS2UomP+PLZ0etEI9uXS+v3XuUCW44BJoj9chc0IaKQv1j3LuoRZRCkt
         mVWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhPHV6XcnLziSo4VKwnTme9mO/AcGQP+aqMiSUN7b5fZHsrUqhoDMGbEImTD0YPQZDrMdb/yfIQqEsuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRKJ4+9oMG56aVL7n6qxxkFziekUaMoVJEu4La1LdcQ64jb/OP
	moQwwpapmUFFdTHdu752yzrZ9vQcocc5VIRrKFc+l7OTKq870OuLbJOPxA==
X-Google-Smtp-Source: AGHT+IHXQ9lj6UmHroIsIc/NCYZ0o0U8SaJlnwJjy5kbifZJ8LkgNO/GUL/m6sM9Dk3H8IB0N/vY4g==
X-Received: by 2002:a05:6a20:840f:b0:1d9:18b7:496 with SMTP id adf61e73a8af0-1dc22b7551cmr18050882637.45.1731353476885;
        Mon, 11 Nov 2024 11:31:16 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a41cfsm9632638b3a.41.2024.11.11.11.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 11:31:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <609715ff-973a-484d-9267-ff80be7e36f3@roeck-us.net>
Date: Mon, 11 Nov 2024 11:31:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: Add Congatec Board Controller monitoring
 driver
To: Thomas Richard <thomas.richard@bootlin.com>,
 Jean Delvare <jdelvare@suse.com>, Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 thomas.petazzoni@bootlin.com, blake.vermeer@keysight.com
References: <20241108-congatec-board-controller-hwmon-v2-0-16e337398527@bootlin.com>
 <20241108-congatec-board-controller-hwmon-v2-1-16e337398527@bootlin.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241108-congatec-board-controller-hwmon-v2-1-16e337398527@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/24 07:08, Thomas Richard wrote:
> Add support for the Congatec Board Controller. This controller exposes
> temperature, voltage, current and fan sensors.
> 
> The available sensors list cannot be predicted. Some sensors can be
> present or not, depending the system.
> The driver has an internal list of all possible sensors, for all Congatec
> boards. The Board Controller gives to the driver its sensors list, and
> their status (active or not).
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>   MAINTAINERS                |   1 +
>   drivers/hwmon/Kconfig      |   9 ++
>   drivers/hwmon/Makefile     |   1 +
>   drivers/hwmon/cgbc-hwmon.c | 314 +++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 325 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3507df3381b1..5e96646593b1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5784,6 +5784,7 @@ CONGATEC BOARD CONTROLLER MFD DRIVER
>   M:	Thomas Richard <thomas.richard@bootlin.com>
>   S:	Maintained
>   F:	drivers/gpio/gpio-cgbc.c
> +F:	drivers/hwmon/cgbc-hwmon.c
>   F:	drivers/i2c/busses/i2c-cgbc.c
>   F:	drivers/mfd/cgbc-core.c
>   F:	drivers/watchdog/cgbc_wdt.c
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index cfb4e9314c62..c7b6e93aeb9b 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -463,6 +463,15 @@ config SENSORS_BT1_PVT_ALARMS
>   	  the data conversion will be periodically performed and the data will be
>   	  saved in the internal driver cache.
>   
> +config SENSORS_CGBC
> +	tristate "Congatec Board Controller Sensors"
> +	depends on MFD_CGBC
> +	help
> +	  Enables sensors support for the Congatec Board Controller.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called cgbc-hwmon.
> +
>   config SENSORS_CHIPCAP2
>   	tristate "Amphenol ChipCap 2 relative humidity and temperature sensor"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b827b92f2a78..318da6d8f752 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_SENSORS_ASUS_ROG_RYUJIN)	+= asus_rog_ryujin.o
>   obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
>   obj-$(CONFIG_SENSORS_AXI_FAN_CONTROL) += axi-fan-control.o
>   obj-$(CONFIG_SENSORS_BT1_PVT)	+= bt1-pvt.o
> +obj-$(CONFIG_SENSORS_CGBC)	+= cgbc-hwmon.o
>   obj-$(CONFIG_SENSORS_CHIPCAP2) += chipcap2.o
>   obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
>   obj-$(CONFIG_SENSORS_CORSAIR_CPRO) += corsair-cpro.o
> diff --git a/drivers/hwmon/cgbc-hwmon.c b/drivers/hwmon/cgbc-hwmon.c
> new file mode 100644
> index 000000000000..6352d3f38516
> --- /dev/null
> +++ b/drivers/hwmon/cgbc-hwmon.c
> @@ -0,0 +1,314 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * cgbc-hwmon - Congatec Board Controller hardware monitoring driver
> + *
> + * Copyright (C) 2024 Thomas Richard <thomas.richard@bootlin.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/hwmon.h>
> +#include <linux/mfd/cgbc.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define CGBC_HWMON_CMD_SENSOR		0x77
> +#define CGBC_HWMON_CMD_SENSOR_DATA_SIZE	0x05
> +
> +#define CGBC_HWMON_TYPE_MASK	GENMASK(6, 5)
> +#define CGBC_HWMON_ID_MASK	GENMASK(4, 0)
> +#define CGBC_HWMON_ACTIVE_BIT	BIT(7)
> +
> +struct cgbc_hwmon_sensor {
> +	enum hwmon_sensor_types type;
> +	bool active;
> +	unsigned int index;
> +	unsigned int channel;
> +	const char *label;
> +};
> +
> +struct cgbc_hwmon_data {
> +	struct cgbc_device_data *cgbc;
> +	unsigned int nb_sensors;
> +	struct cgbc_hwmon_sensor *sensors;
> +};
> +
> +enum cgbc_sensor_types {
> +	CGBC_HWMON_TYPE_TEMP = 1,
> +	CGBC_HWMON_TYPE_IN,
> +	CGBC_HWMON_TYPE_FAN
> +};
> +
> +static const char * const cgbc_hwmon_labels_temp[] = {
> +	"CPU Temperature",
> +	"Box Temperature",
> +	"Ambient Temperature",
> +	"Board Temperature",
> +	"Carrier Temperature",
> +	"Chipset Temperature",
> +	"Video Temperature",
> +	"Other Temperature",
> +	"TOPDIM Temperature",
> +	"BOTTOMDIM Temperature",
> +};
> +
> +static const struct {
> +	enum hwmon_sensor_types type;
> +	const char *label;
> +} cgbc_hwmon_labels_in[] = {
> +	{ hwmon_in, "CPU Voltage" },
> +	{ hwmon_in, "DC Runtime Voltage" },
> +	{ hwmon_in, "DC Standby Voltage" },
> +	{ hwmon_in, "CMOS Battery Voltage" },
> +	{ hwmon_in, "Battery Voltage" },
> +	{ hwmon_in, "AC Voltage" },
> +	{ hwmon_in, "Other Voltage" },
> +	{ hwmon_in, "5V Voltage" },
> +	{ hwmon_in, "5V Standby Voltage" },
> +	{ hwmon_in, "3V3 Voltage" },
> +	{ hwmon_in, "3V3 Standby Voltage" },
> +	{ hwmon_in, "VCore A Voltage" },
> +	{ hwmon_in, "VCore B Voltage" },
> +	{ hwmon_in, "12V Voltage" },
> +	{ hwmon_curr, "DC Current" },
> +	{ hwmon_curr, "5V Current" },
> +	{ hwmon_curr, "12V Current" },
> +};
> +
> +#define cgbc_hwmon_compute_curr_channel(channel)				\
> +	({									\
> +		int i, cnt = 0;							\
> +		for (i = 0; i < ARRAY_SIZE(cgbc_hwmon_labels_in); i++) {	\
> +			if (cgbc_hwmon_labels_in[i].type == hwmon_in)		\
> +				cnt++;						\
> +		}								\
> +		(channel) + cnt;						\
> +	 })
> +

 From Documentation/hwmon/submitting-patches.rst:

* Avoid calculations in macros and macro-generated functions. While such macros
   may save a line or so in the source, it obfuscates the code and makes code
   review more difficult. It may also result in code which is more complicated
   than necessary. Use inline functions or just regular functions instead.

I don't understand why this would be needed anyway. The current channel
index is well known, so adding or subtracting a constant should do it.

Guenter


