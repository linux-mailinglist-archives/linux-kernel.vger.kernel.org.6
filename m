Return-Path: <linux-kernel+bounces-410954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE4E9CF0CE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930801F2B7EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F151D516B;
	Fri, 15 Nov 2024 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXe73mN7"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939BA1D5157;
	Fri, 15 Nov 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686229; cv=none; b=s+BcceVqy0CGmo/zgAP/AwYr+64UQB0V0XiKAVC7i16iw00CnEsiuooWaMpNbF4MnNOsSMWCwHouMhtWFkKqrdny+y3bruzFcyQWylYcA0Jylv8YXwOLNd8sggMFm20Gf4flz/VKG8YoclR8iRD5IYyD90bKGCDPiXkNsNbGbEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686229; c=relaxed/simple;
	bh=T4IiyCHMkXFD37wFsOcQjZGj/BjmTl8W/ERkw0itaek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qw3tBX1Dyi8Mi7AVRqK10NxxHoIVkIBylbgsdEJOrETjcxqP8jr3laTS9d7EtOvySGO9+Kq2nx1a41NuoQ7GJtKFESeAdvgGib06CqAzYRK5oENuqVOLC1Nt049iQTFVX58IiRkQmsm+h5HBwQxyICsBN9zodjB691JZxKtFK30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXe73mN7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-723db2798caso1766609b3a.0;
        Fri, 15 Nov 2024 07:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731686227; x=1732291027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5p8l3DBX5cKAwWs/6FgQa7nvCaZSbIHgTp1ChTl02+Y=;
        b=mXe73mN7OwoL1p183NAkJdpIJn8hN1tsDFARVAjgPFgQLzP+e29PUZFWFBaZX1Zp/t
         gzaoVLcUKqFQX6TU5+Xlp/0pUqSFg3byArXJn3pQhmGED/eYz23c4iVC8RjNXMCjBiLG
         Wd+zQPIn9pofQYAs5FaIhExI309sPME0Z/5rFCCHa0HyYuuzPbBPoN7oY9Or189NS2QS
         Zdz9X5Ats4cbCie+eDnWLYE2+JwMq0GMkKnP1OFP1T6dtUsuKT1tRzMiUMkifoQNjvHf
         rJ8rtH38gvIB9dCDCRne9pp9xk+0WwKIMTXnQHCJMS61FBDlzDs6IoU+7HR0E5qAdpIF
         hTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686227; x=1732291027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5p8l3DBX5cKAwWs/6FgQa7nvCaZSbIHgTp1ChTl02+Y=;
        b=LGssIk9PARxa5PlhUVRBX4SZueX+FrEbJfO5EqD8GF+F0mml7KkPl4dw2HEwmZ9EJT
         3e6foMACdgX0wv6rOuRzu3VmR9kxuNejH0lAvNJp32kDqI4lIpy9dDi6HE9ohdYtlHZV
         UL2uhXY5Dl1C/YX5ParetVBItX+JhC+jMFW++J6BJnlIwsjxRdOzU3WQHqROd15LumSr
         R16gmNk6P70Pdid5jX5j+w1p3lRaArRu6PEZJuYQe8Vxh8C5uT60yuHEet6Luh4VJSZa
         Ftu3U5Mps2tpYIzp3zBP6M1tvDObGxp35ar9ELvLERQsdY6/kRQcOLYVHm+vuULAIbhW
         PutA==
X-Forwarded-Encrypted: i=1; AJvYcCWDowSNVIAtlSc5x9UqD3S7KZTkTDmMYNCvaW43atrxHFgi8zZzvg+JzNuaMEDROEXsecnM2peCHdBW0lI9@vger.kernel.org, AJvYcCWuRMQlKxFJC9YggrSdQCaBfKDrVNxJw+Py520u8JGbgjiLb6/0dmdQpw2HC6qu+IfuJ35M3pH6SscrRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+RU0ksKYwsTHzeQitq/79VoT9DwDLOKZ8is9Xuf2Tb/t5hqc
	Aif43stMLwjI+XiRRLiCC7xa4qnT8nrtbDOkkVVG12lJuOi8hVbF
X-Google-Smtp-Source: AGHT+IEW6huFBluZDoE1vUejBSvoqTwbAcMbEjS8t4U5EWQw9hgN0xwI/Mo2AcgzYKGe+zr/2XfIJg==
X-Received: by 2002:a05:6a00:4fcd:b0:724:67dd:2615 with SMTP id d2e1a72fcca58-72476d293acmr4155474b3a.22.1731686226713;
        Fri, 15 Nov 2024 07:57:06 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770ee767sm1550698b3a.29.2024.11.15.07.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:57:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 15 Nov 2024 07:57:04 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Jean Delvare <jdelvare@suse.com>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	thomas.petazzoni@bootlin.com, blake.vermeer@keysight.com
Subject: Re: [PATCH v3 1/2] hwmon: Add Congatec Board Controller monitoring
 driver
Message-ID: <e91a3c4a-6324-471a-a1eb-47eb329d2d6b@roeck-us.net>
References: <20241115-congatec-board-controller-hwmon-v3-0-1c45637c8266@bootlin.com>
 <20241115-congatec-board-controller-hwmon-v3-1-1c45637c8266@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-congatec-board-controller-hwmon-v3-1-1c45637c8266@bootlin.com>

On Fri, Nov 15, 2024 at 04:39:08PM +0100, Thomas Richard wrote:
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
>  MAINTAINERS                |   1 +
>  drivers/hwmon/Kconfig      |   9 ++
>  drivers/hwmon/Makefile     |   1 +
>  drivers/hwmon/cgbc-hwmon.c | 304 +++++++++++++++++++++++++++++++++++++++++++++

Two problems:
- Documentation/hwmon/cgbc-hwmon.rst is missing.
- "git am" fails due to a conflict in MAINTAINERS, meaning it is not based
  on the mainline kernel.

Another nitpick below.

>  4 files changed, 315 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3507df3381b1..5e96646593b1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5784,6 +5784,7 @@ CONGATEC BOARD CONTROLLER MFD DRIVER
>  M:	Thomas Richard <thomas.richard@bootlin.com>
>  S:	Maintained
>  F:	drivers/gpio/gpio-cgbc.c
> +F:	drivers/hwmon/cgbc-hwmon.c
>  F:	drivers/i2c/busses/i2c-cgbc.c
>  F:	drivers/mfd/cgbc-core.c
>  F:	drivers/watchdog/cgbc_wdt.c
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index cfb4e9314c62..c7b6e93aeb9b 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -463,6 +463,15 @@ config SENSORS_BT1_PVT_ALARMS
>  	  the data conversion will be periodically performed and the data will be
>  	  saved in the internal driver cache.
>  
> +config SENSORS_CGBC
> +	tristate "Congatec Board Controller Sensors"
> +	depends on MFD_CGBC
> +	help
> +	  Enables sensors support for the Congatec Board Controller.

s/Enables/Enable/

Checkpatch issues a warning because it does not like one-line descriptions.
Please expand, and please run checkpatch on your patches (or explain why
you ignored the warnings).

> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called cgbc-hwmon.
> +
>  config SENSORS_CHIPCAP2
>  	tristate "Amphenol ChipCap 2 relative humidity and temperature sensor"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b827b92f2a78..318da6d8f752 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_SENSORS_ASUS_ROG_RYUJIN)	+= asus_rog_ryujin.o
>  obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
>  obj-$(CONFIG_SENSORS_AXI_FAN_CONTROL) += axi-fan-control.o
>  obj-$(CONFIG_SENSORS_BT1_PVT)	+= bt1-pvt.o
> +obj-$(CONFIG_SENSORS_CGBC)	+= cgbc-hwmon.o
>  obj-$(CONFIG_SENSORS_CHIPCAP2) += chipcap2.o
>  obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
>  obj-$(CONFIG_SENSORS_CORSAIR_CPRO) += corsair-cpro.o
> diff --git a/drivers/hwmon/cgbc-hwmon.c b/drivers/hwmon/cgbc-hwmon.c
> new file mode 100644
> index 000000000000..772f44d56ccf
> --- /dev/null
> +++ b/drivers/hwmon/cgbc-hwmon.c
> @@ -0,0 +1,304 @@
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
> +#define CGBC_HWMON_NB_IN_SENSORS	14
> +
> +static const char * const cgbc_hwmon_labels_fan[] = {
> +	"CPU Fan",
> +	"Box Fan",
> +	"Ambient Fan",
> +	"Chipset Fan",
> +	"Video Fan",
> +	"Other Fan",
> +};
> +
> +static int cgbc_hwmon_cmd(struct cgbc_device_data *cgbc, u8 index, u8 *data)
> +{
> +	u8 cmd[2] = {CGBC_HWMON_CMD_SENSOR, index};
> +
> +	return cgbc_command(cgbc, cmd, sizeof(cmd), data, CGBC_HWMON_CMD_SENSOR_DATA_SIZE, NULL);
> +}
> +
> +static int cgbc_hwmon_probe_sensors(struct device *dev, struct cgbc_hwmon_data *hwmon)
> +{
> +	struct cgbc_device_data *cgbc = hwmon->cgbc;
> +	struct cgbc_hwmon_sensor *sensor = hwmon->sensors;
> +	u8 data[CGBC_HWMON_CMD_SENSOR_DATA_SIZE], nb_sensors, i;
> +	int ret;
> +
> +	ret = cgbc_hwmon_cmd(cgbc, 0, &data[0]);
> +	if (ret)
> +		return ret;
> +
> +	nb_sensors = data[0];
> +
> +	hwmon->sensors = devm_kzalloc(dev, sizeof(*hwmon->sensors) * nb_sensors, GFP_KERNEL);
> +	sensor = hwmon->sensors;
> +
> +	for (i = 0; i < nb_sensors; i++) {
> +		enum cgbc_sensor_types type;
> +		unsigned int channel;
> +
> +		/*
> +		 * No need to request data for the first sensor.
> +		 * We got data for the first sensor when we ask the number of sensors to the Board
> +		 * Controller.
> +		 */
> +		if (i) {
> +			ret = cgbc_hwmon_cmd(cgbc, i, &data[0]);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		type = FIELD_GET(CGBC_HWMON_TYPE_MASK, data[1]);
> +		channel = FIELD_GET(CGBC_HWMON_ID_MASK, data[1]) - 1;
> +
> +		if (type == CGBC_HWMON_TYPE_TEMP && channel < ARRAY_SIZE(cgbc_hwmon_labels_temp)) {
> +			sensor->type = hwmon_temp;
> +			sensor->label = cgbc_hwmon_labels_temp[channel];
> +		} else if (type == CGBC_HWMON_TYPE_IN &&
> +			   channel < ARRAY_SIZE(cgbc_hwmon_labels_in)) {
> +			/*
> +			 * The Board Controller doesn't differentiate current and voltage sensors.
> +			 * Get the sensor type from cgbc_hwmon_labels_in[channel].type instead.
> +			 */
> +			sensor->type = cgbc_hwmon_labels_in[channel].type;
> +			sensor->label = cgbc_hwmon_labels_in[channel].label;
> +		} else if (type == CGBC_HWMON_TYPE_FAN &&
> +			   channel < ARRAY_SIZE(cgbc_hwmon_labels_fan)) {
> +			sensor->type = hwmon_fan;
> +			sensor->label = cgbc_hwmon_labels_fan[channel];
> +		} else {
> +			dev_warn(dev, "Board Controller returned an unknown sensor (type=%d, channel=%d), ignore it",
> +				 type, channel);
> +			continue;
> +		}
> +
> +		sensor->active = FIELD_GET(CGBC_HWMON_ACTIVE_BIT, data[1]);
> +		sensor->channel = channel;
> +		sensor->index = i;
> +		sensor++;
> +		hwmon->nb_sensors++;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct cgbc_hwmon_sensor *cgbc_hwmon_find_sensor(struct cgbc_hwmon_data *hwmon,
> +							enum hwmon_sensor_types type, int channel)
> +{
> +	struct cgbc_hwmon_sensor *sensor = NULL;
> +	int i;
> +
> +	/*
> +	 * The Board Controller doesn't differentiate current and voltage sensors.
> +	 * The channel value (from the Board Controller point of view) shall be computed for current
> +	 * sensors.
> +	 */
> +	if (type == hwmon_curr)
> +		channel += CGBC_HWMON_NB_IN_SENSORS;
> +
> +	for (i = 0; i < hwmon->nb_sensors; i++) {
> +		if (hwmon->sensors[i].type == type && hwmon->sensors[i].channel == channel) {
> +			sensor = &hwmon->sensors[i];
> +			break;
> +		}
> +	}
> +
> +	return sensor;
> +}
> +
> +static int cgbc_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
> +			   long *val)
> +{
> +	struct cgbc_hwmon_data *hwmon = dev_get_drvdata(dev);
> +	struct cgbc_hwmon_sensor *sensor = cgbc_hwmon_find_sensor(hwmon, type, channel);
> +	struct cgbc_device_data *cgbc = hwmon->cgbc;
> +	u8 data[CGBC_HWMON_CMD_SENSOR_DATA_SIZE];
> +	int ret;
> +
> +	ret = cgbc_hwmon_cmd(cgbc, sensor->index, &data[0]);
> +	if (ret)
> +		return ret;
> +
> +	*val = (data[3] << 8) | data[2];
> +
> +	/*
> +	 * For the Board Controller 1lsb = 0.1 degree centigrade.
> +	 * Other units are as expected.
> +	 */
> +	if (sensor->type == hwmon_temp)
> +		*val *= 100;
> +
> +	return 0;
> +}
> +
> +static umode_t cgbc_hwmon_is_visible(const void *_data, enum hwmon_sensor_types type, u32 attr,
> +				     int channel)
> +{
> +	struct cgbc_hwmon_data *data = (struct cgbc_hwmon_data *)_data;
> +	struct cgbc_hwmon_sensor *sensor;
> +
> +	sensor = cgbc_hwmon_find_sensor(data, type, channel);
> +	if (!sensor)
> +		return 0;
> +
> +	return sensor->active ? 0444 : 0;
> +}
> +
> +static int cgbc_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +				  int channel, const char **str)
> +{
> +	struct cgbc_hwmon_data *hwmon = dev_get_drvdata(dev);
> +	struct cgbc_hwmon_sensor *sensor = cgbc_hwmon_find_sensor(hwmon, type, channel);
> +
> +	*str = sensor->label;
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_channel_info * const cgbc_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL),
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL),
> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_INPUT | HWMON_C_LABEL, HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL),
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_LABEL, HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL, HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL, HWMON_F_INPUT | HWMON_F_LABEL),
> +	NULL
> +};
> +
> +static const struct hwmon_ops cgbc_hwmon_ops = {
> +	.is_visible = cgbc_hwmon_is_visible,
> +	.read = cgbc_hwmon_read,
> +	.read_string = cgbc_hwmon_read_string,
> +};
> +
> +static const struct hwmon_chip_info cgbc_chip_info = {
> +	.ops = &cgbc_hwmon_ops,
> +	.info = cgbc_hwmon_info,
> +};
> +
> +static int cgbc_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct cgbc_device_data *cgbc = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	struct cgbc_hwmon_data *data;
> +	struct device *hwmon_dev;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->cgbc = cgbc;
> +
> +	ret = cgbc_hwmon_probe_sensors(dev, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to probe sensors");
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, "cgbc_hwmon", data, &cgbc_chip_info,
> +							 NULL);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static struct platform_driver cgbc_hwmon_driver = {
> +	.driver = {
> +		.name = "cgbc-hwmon",
> +	},
> +	.probe = cgbc_hwmon_probe,
> +};
> +
> +module_platform_driver(cgbc_hwmon_driver);
> +
> +MODULE_AUTHOR("Thomas Richard <thomas.richard@bootlin.com>");
> +MODULE_DESCRIPTION("Congatec Board Controller Hardware Monitoring Driver");
> +MODULE_LICENSE("GPL");

