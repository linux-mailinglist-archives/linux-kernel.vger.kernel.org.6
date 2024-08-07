Return-Path: <linux-kernel+bounces-277130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AC8949D01
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0DB281797
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A3D3BB30;
	Wed,  7 Aug 2024 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/FQcNpF"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3539538DD1;
	Wed,  7 Aug 2024 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722990750; cv=none; b=oIGpNbIJMyky0feMTJTaJ5GZT25/mPRSa8x7tD575+zT+uKN8iV0+LUkTP1po6UoNCGnBluBF3aCPHxGx8QGoPxS6yaehMa876ELxdDK9xhPGUnWqEi0R/1pTT3h/dh7xT14zx9amgPYwTSq24DdBQfDejfyy2nvaQk9vGZHMD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722990750; c=relaxed/simple;
	bh=r/97gdk8eNdGGR27mQ3OWr83fmXlR9x2kpPVnHAgE7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbrbdIQB3NGtcJGqclVZuoAXnzDY1THqU7trWhN4KWFyRwMY0SbkhudAdp020l7ASpDscDoHlySa5LGJzvSuQ8Jcv4A4dBOWAP4gJJJvg968SDZeuWAdLMByPbSd7D8N0gnjLNqEERUugTvnEAJU3i24GGS8NHreGzDQBm569Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/FQcNpF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd66cddd4dso13391125ad.2;
        Tue, 06 Aug 2024 17:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722990747; x=1723595547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qSWzbfOfnejgOdnRcq7OyN245x/Sm4Euo+ivkL8eaKQ=;
        b=A/FQcNpFmGG/TjWLnWzlwtXbdoKVyCVEtkXCUEvZzDolduYF7GKk+1j8ZdcWCQ6Fqf
         SdsxPPS0fCKNoXRF/+LFYeZU3nc9Njr+ZrzlY+KXud6LaliP4VDCVodRMXXT6wY6a0gX
         KM9ybNXbi7UwOzwoEVM5DMgGQt2nPsHi2zVIjzvYG7CXMTxey/nJzNjFFDfprqVZDFAc
         7CaN/2+k+7/f8ZUIR6rdZuVgMJupsBvPPN++UOQYjT6xa6bmOcnZgYHORicGDH2d9hwC
         fkZR8aqxA1FD707JfCiuUZorl+yM/QopY/baftyHXH+JO30Qs1vENabwl2Ea4mm5HLPU
         P0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722990747; x=1723595547;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSWzbfOfnejgOdnRcq7OyN245x/Sm4Euo+ivkL8eaKQ=;
        b=Uy+3AWaH+C5EVDVp72coN5D6mTOv8+rEHM39RQvFygPaNCjr9T8LFwUfhqv10dc6V9
         rE8hDfQJgZnxmdT6C5zrzaFotEsWU1QOasjoHLflp4q2+hFfSkIJ9aOAvb187JIGbR3f
         93ZhPZsK+Rg3TM2TVZTMXkY8XlGBVvzfcJbhybq378+SMDrtA/mAlAZBx+KaDN8X/EgB
         jAd7a3V0Y5Hc2NC/QdPrN+j0VH3e05LXUjbRt7n5RJPdJXW4xnhiOsSQ6Ae2D59w8D7w
         TUKygfJ+Dvjc4T7wAhchbRztBzXLK/IN16gGA+GD3aZWK1fu06PL5ooXEsWMUFosO2n3
         BUeA==
X-Forwarded-Encrypted: i=1; AJvYcCUhay+IdJVq9If3sMUK7S51+v6sBeb1j8yN17N1RYPp5n5ZF3vBDpemGF1ZkwepJRlPtee8BylyivTGxg==@vger.kernel.org, AJvYcCWi2QDoC5IPLpme+kZzgSecQxJ7YuzSj5uKl23wliMWkUOT8iecvSimmZ8aysnDJwt5Q6slppDpX9zaOiK1@vger.kernel.org
X-Gm-Message-State: AOJu0YxmyMPAzA04fwEmd5I030+LLYbCgOOO3P63ImwHCvs7kfH/e0i2
	m2tVyn7Rvj2cfKBxcfMeIz4qKL9R4/59svSbSxOeDq298tjbJe6wnjxKvQ==
X-Google-Smtp-Source: AGHT+IH1RWfPJ0g7tI/3VHoAtYUmHLOaqPBS1z+BhB964q7ziD4EC374Xt/RXP3hLMVI3Pw6MbaD/Q==
X-Received: by 2002:a17:903:1251:b0:1fb:9b91:d7c9 with SMTP id d9443c01a7336-1ff5722d9aemr243214665ad.4.1722990747198;
        Tue, 06 Aug 2024 17:32:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19cb7sm93578575ad.33.2024.08.06.17.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 17:32:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2419e2ab-25e2-483b-a163-6b4fbfef6866@roeck-us.net>
Date: Tue, 6 Aug 2024 17:32:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Hans de Goede <hdegoede@redhat.com>,
 Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240804230832.247852-1-luzmaximilian@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240804230832.247852-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/4/24 16:08, Maximilian Luz wrote:
> Some of the newer Microsoft Surface devices (such as the Surface Book
> 3 and Pro 9) have thermal sensors connected via the Surface Aggregator
> Module (the embedded controller on those devices). Add a basic driver
> to read out the temperature values of those sensors.
> 
> The EC can have up to 16 thermal sensors connected via a single
> sub-device, each providing temperature readings and a label string.
> 
> Link: https://github.com/linux-surface/surface-aggregator-module/issues/59
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Co-developed-by: Ivor Wanders <ivor@iwanders.net>
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> 
> ---
> 
> Links:
>   - v1: https://lore.kernel.org/linux-kernel/ee8c39ab-d47a-481d-a19c-1d656519e66d@gmail.com
> 
> Changes in v2:
>   - Drop patch 0003 ("platform/surface: aggregator_registry: Add support
>     for thermal sensors on the Surface Pro 9") as it has already been
>     applied.
>   - Squash patches 0001 ("hwmon: Add thermal sensor driver for Surface
>     Aggregator Module") and 0002 ("hwmon: surface_temp: Add support for
>     sensor names") into a single patch.
>   - Replace usage of WARN_ON() with dev_err().
>   - Fix formatting and (strict) checkpatch complaints.
> 
> ---
>   MAINTAINERS                  |   6 +
>   drivers/hwmon/Kconfig        |  10 ++
>   drivers/hwmon/Makefile       |   1 +
>   drivers/hwmon/surface_temp.c | 235 +++++++++++++++++++++++++++++++++++
>   4 files changed, 252 insertions(+)
>   create mode 100644 drivers/hwmon/surface_temp.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42decde38320..39c61db0169c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15200,6 +15200,12 @@ S:	Maintained
>   F:	Documentation/hwmon/surface_fan.rst
>   F:	drivers/hwmon/surface_fan.c
>   
> +MICROSOFT SURFACE SENSOR THERMAL DRIVER
> +M:	Maximilian Luz <luzmaximilian@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hwmon/surface_temp.c
> +
>   MICROSOFT SURFACE GPE LID SUPPORT DRIVER
>   M:	Maximilian Luz <luzmaximilian@gmail.com>
>   L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index b60fe2e58ad6..70c6385f0ed6 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2080,6 +2080,16 @@ config SENSORS_SURFACE_FAN
>   
>   	  Select M or Y here, if you want to be able to read the fan's speed.
>   
> +config SENSORS_SURFACE_TEMP
> +	tristate "Microsoft Surface Thermal Sensor Driver"
> +	depends on SURFACE_AGGREGATOR

As the kernel test robot points out, this dependency is wrong.
__ssam_device_driver_register() is only available
if SURFACE_AGGREGATOR_BUS is enabled.

Guenter

> +	help
> +	  Driver for monitoring thermal sensors connected via the Surface
> +	  Aggregator Module (embedded controller) on Microsoft Surface devices.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called surface_temp.
> +
>   config SENSORS_ADC128D818
>   	tristate "Texas Instruments ADC128D818"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b1c7056c37db..3ce8d6a9202e 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -209,6 +209,7 @@ obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
>   obj-$(CONFIG_SENSORS_SPD5118)	+= spd5118.o
>   obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
>   obj-$(CONFIG_SENSORS_SURFACE_FAN)+= surface_fan.o
> +obj-$(CONFIG_SENSORS_SURFACE_TEMP)+= surface_temp.o
>   obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
>   obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
>   obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
> diff --git a/drivers/hwmon/surface_temp.c b/drivers/hwmon/surface_temp.c
> new file mode 100644
> index 000000000000..cd21f331f157
> --- /dev/null
> +++ b/drivers/hwmon/surface_temp.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Thermal sensor subsystem driver for Surface System Aggregator Module (SSAM).
> + *
> + * Copyright (C) 2022-2023 Maximilian Luz <luzmaximilian@gmail.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/hwmon.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +
> +#include <linux/surface_aggregator/controller.h>
> +#include <linux/surface_aggregator/device.h>
> +
> +/* -- SAM interface. -------------------------------------------------------- */
> +
> +/*
> + * Available sensors are indicated by a 16-bit bitfield, where a 1 marks the
> + * presence of a sensor. So we have at most 16 possible sensors/channels.
> + */
> +#define SSAM_TMP_SENSOR_MAX_COUNT	16
> +
> +/*
> + * All names observed so far are 6 characters long, but there's only
> + * zeros after the name, so perhaps they can be longer. This number reflects
> + * the maximum zero-padded space observed in the returned buffer.
> + */
> +#define SSAM_TMP_SENSOR_NAME_LENGTH	18
> +
> +struct ssam_tmp_get_name_rsp {
> +	__le16 unknown1;
> +	char unknown2;
> +	char name[SSAM_TMP_SENSOR_NAME_LENGTH];
> +} __packed;
> +
> +static_assert(sizeof(struct ssam_tmp_get_name_rsp) == 21);
> +
> +SSAM_DEFINE_SYNC_REQUEST_CL_R(__ssam_tmp_get_available_sensors, __le16, {
> +	.target_category = SSAM_SSH_TC_TMP,
> +	.command_id      = 0x04,
> +});
> +
> +SSAM_DEFINE_SYNC_REQUEST_MD_R(__ssam_tmp_get_temperature, __le16, {
> +	.target_category = SSAM_SSH_TC_TMP,
> +	.command_id      = 0x01,
> +});
> +
> +SSAM_DEFINE_SYNC_REQUEST_MD_R(__ssam_tmp_get_name, struct ssam_tmp_get_name_rsp, {
> +	.target_category = SSAM_SSH_TC_TMP,
> +	.command_id      = 0x0e,
> +});
> +
> +static int ssam_tmp_get_available_sensors(struct ssam_device *sdev, s16 *sensors)
> +{
> +	__le16 sensors_le;
> +	int status;
> +
> +	status = __ssam_tmp_get_available_sensors(sdev, &sensors_le);
> +	if (status)
> +		return status;
> +
> +	*sensors = le16_to_cpu(sensors_le);
> +	return 0;
> +}
> +
> +static int ssam_tmp_get_temperature(struct ssam_device *sdev, u8 iid, long *temperature)
> +{
> +	__le16 temp_le;
> +	int status;
> +
> +	status = __ssam_tmp_get_temperature(sdev->ctrl, sdev->uid.target, iid, &temp_le);
> +	if (status)
> +		return status;
> +
> +	/* Convert 1/10 °K to 1/1000 °C */
> +	*temperature = (le16_to_cpu(temp_le) - 2731) * 100L;
> +	return 0;
> +}
> +
> +static int ssam_tmp_get_name(struct ssam_device *sdev, u8 iid, char *buf, size_t buf_len)
> +{
> +	struct ssam_tmp_get_name_rsp name_rsp;
> +	int status;
> +
> +	status =  __ssam_tmp_get_name(sdev->ctrl, sdev->uid.target, iid, &name_rsp);
> +	if (status)
> +		return status;
> +
> +	/*
> +	 * This should not fail unless the name in the returned struct is not
> +	 * null-terminated or someone changed something in the struct
> +	 * definitions above, since our buffer and struct have the same
> +	 * capacity by design. So if this fails, log an error message. Since
> +	 * the more likely cause is that the returned string isn't
> +	 * null-terminated, we might have received garbage (as opposed to just
> +	 * an incomplete string), so also fail the function.
> +	 */
> +	status = strscpy(buf, name_rsp.name, buf_len);
> +	if (status < 0) {
> +		dev_err(&sdev->dev, "received non-null-terminated sensor name string\n");
> +		return status;
> +	}
> +
> +	return 0;
> +}
> +
> +/* -- Driver.---------------------------------------------------------------- */
> +
> +struct ssam_temp {
> +	struct ssam_device *sdev;
> +	s16 sensors;
> +	char names[SSAM_TMP_SENSOR_MAX_COUNT][SSAM_TMP_SENSOR_NAME_LENGTH];
> +};
> +
> +static umode_t ssam_temp_hwmon_is_visible(const void *data,
> +					  enum hwmon_sensor_types type,
> +					  u32 attr, int channel)
> +{
> +	const struct ssam_temp *ssam_temp = data;
> +
> +	if (!(ssam_temp->sensors & BIT(channel)))
> +		return 0;
> +
> +	return 0444;
> +}
> +
> +static int ssam_temp_hwmon_read(struct device *dev,
> +				enum hwmon_sensor_types type,
> +				u32 attr, int channel, long *value)
> +{
> +	const struct ssam_temp *ssam_temp = dev_get_drvdata(dev);
> +
> +	return ssam_tmp_get_temperature(ssam_temp->sdev, channel + 1, value);
> +}
> +
> +static int ssam_temp_hwmon_read_string(struct device *dev,
> +				       enum hwmon_sensor_types type,
> +				       u32 attr, int channel, const char **str)
> +{
> +	const struct ssam_temp *ssam_temp = dev_get_drvdata(dev);
> +
> +	*str = ssam_temp->names[channel];
> +	return 0;
> +}
> +
> +static const struct hwmon_channel_info * const ssam_temp_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(chip,
> +			   HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL),
> +	NULL
> +};
> +
> +static const struct hwmon_ops ssam_temp_hwmon_ops = {
> +	.is_visible = ssam_temp_hwmon_is_visible,
> +	.read = ssam_temp_hwmon_read,
> +	.read_string = ssam_temp_hwmon_read_string,
> +};
> +
> +static const struct hwmon_chip_info ssam_temp_hwmon_chip_info = {
> +	.ops = &ssam_temp_hwmon_ops,
> +	.info = ssam_temp_hwmon_info,
> +};
> +
> +static int ssam_temp_probe(struct ssam_device *sdev)
> +{
> +	struct ssam_temp *ssam_temp;
> +	struct device *hwmon_dev;
> +	s16 sensors;
> +	int channel;
> +	int status;
> +
> +	status = ssam_tmp_get_available_sensors(sdev, &sensors);
> +	if (status)
> +		return status;
> +
> +	ssam_temp = devm_kzalloc(&sdev->dev, sizeof(*ssam_temp), GFP_KERNEL);
> +	if (!ssam_temp)
> +		return -ENOMEM;
> +
> +	ssam_temp->sdev = sdev;
> +	ssam_temp->sensors = sensors;
> +
> +	/* Retrieve the name for each available sensor. */
> +	for (channel = 0; channel < SSAM_TMP_SENSOR_MAX_COUNT; channel++) {
> +		if (!(sensors & BIT(channel)))
> +			continue;
> +
> +		status = ssam_tmp_get_name(sdev, channel + 1, ssam_temp->names[channel],
> +					   SSAM_TMP_SENSOR_NAME_LENGTH);
> +		if (status)
> +			return status;
> +	}
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&sdev->dev, "surface_thermal", ssam_temp,
> +							 &ssam_temp_hwmon_chip_info, NULL);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct ssam_device_id ssam_temp_match[] = {
> +	{ SSAM_SDEV(TMP, SAM, 0x00, 0x02) },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(ssam, ssam_temp_match);
> +
> +static struct ssam_device_driver ssam_temp = {
> +	.probe = ssam_temp_probe,
> +	.match_table = ssam_temp_match,
> +	.driver = {
> +		.name = "surface_temp",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +module_ssam_device_driver(ssam_temp);
> +
> +MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
> +MODULE_DESCRIPTION("Thermal sensor subsystem driver for Surface System Aggregator Module");
> +MODULE_LICENSE("GPL");


