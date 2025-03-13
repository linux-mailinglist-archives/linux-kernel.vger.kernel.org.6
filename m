Return-Path: <linux-kernel+bounces-560406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189FAA603B5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD03E7A9E33
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAC61F5830;
	Thu, 13 Mar 2025 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="Ux6Ibz0a"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF521EA7C9;
	Thu, 13 Mar 2025 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741902786; cv=none; b=ldHoYFPewkRQnaCTKUJB4vgA8Q/ntEXAG+YOTVOMn9en4DT8aIdrdcKFuyabj6eQL9UA2ZsdHVGGOuBmy/aTGXWZ9YUoehaEI12Va4MrNOKnzS8qi+ORPsxu8DE+fiorbijnlnnBiV4xqzSn3LN28C8hz90vkj/v+Sna6UsxOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741902786; c=relaxed/simple;
	bh=Ytsz+eb/V2e3IFloeeFyzf/rS0Opend8bNj7Uv9CZZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7KHJjupsuxDyfR+hWQKwSz7UQbJ7OP7SWZmLb+cHATh0hM+JiuaXh3bNZsKy4/f4NtX1yGHy5+8w85kIU2RUvcLKmGBCra1GmkG/gJx6IQps0ljIY/iqMGYqG1dPOpjexvU5JQgOaLaKmH2/ntN045ZTpMjqSJMgDMzhSTeJ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=Ux6Ibz0a; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (p5b164989.dip0.t-ipconnect.de [91.22.73.137])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 344E12FC0189;
	Thu, 13 Mar 2025 22:52:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1741902773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SejSD+YTwnCmoBSo6r27lIcgsx3S7MG2E9N2kdc8cto=;
	b=Ux6Ibz0aveKI+bfpnymg5PAZA0NrcNPgA+5YzNg3BldjL8ktM+Zb2EyJXjDXHpfcT6EcWs
	eF70IYPIar0fBlD2M62y9XZtkpm8Q2aPT7U1Ltgo9UzrmRGY21f9zWuMbzEhhwRVD8w25e
	Nif/jB084TINlQdraVZfhY8U2HirfD8=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <75556900-5fe3-4083-b81b-240994e4f8e0@tuxedocomputers.com>
Date: Thu, 13 Mar 2025 22:52:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86/tuxedo: Implement TUXEDO TUXI ACPI TFAN
 via hwmon
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, LKML <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20250306132639.642369-1-wse@tuxedocomputers.com>
 <70633701-31d2-c2ab-f4f4-043dd186f485@linux.intel.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <70633701-31d2-c2ab-f4f4-043dd186f485@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ilpo,

Am 13.03.25 um 14:47 schrieb Ilpo Järvinen:
> On Thu, 6 Mar 2025, Werner Sembach wrote:
>
>> The TUXEDO Sirius 16 Gen1 & Gen2 have the custom TUXEDO Interface (TUXI)
>> ACPI interface which currently consists of the TFAN device. This has ACPI
>> functions to control the built in fans and monitor fan speeds and CPU and
>> GPU temprature.
> temperature
thx for spotting
>
>> This driver implements this TFAN device via the hwmon subsystem with an
>> added temprature check that ensure a minimum fanspeed at certain
> temperature
thx for spotting
>
>> temperatures. This allows userspace controlled, but hardware safe, custom
>> fan curves.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> ---
>>   MAINTAINERS                                  |   6 +
>>   drivers/platform/x86/Kconfig                 |   2 +
>>   drivers/platform/x86/Makefile                |   3 +
>>   drivers/platform/x86/tuxedo/Kbuild           |   6 +
>>   drivers/platform/x86/tuxedo/Kconfig          |   6 +
>>   drivers/platform/x86/tuxedo/nbxx/Kbuild      |   7 +
>>   drivers/platform/x86/tuxedo/nbxx/Kconfig     |  13 +
>>   drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c | 578 +++++++++++++++++++
>>   8 files changed, 621 insertions(+)
>>   create mode 100644 drivers/platform/x86/tuxedo/Kbuild
>>   create mode 100644 drivers/platform/x86/tuxedo/Kconfig
>>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kbuild
>>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kconfig
>>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8e0736dc2ee0e..7139c32e96dc7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -24190,6 +24190,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
>>   F:	tools/power/x86/turbostat/
>>   F:	tools/testing/selftests/turbostat/
>>   
>> +TUXEDO DRIVERS
>> +M:	Werner Sembach <wse@tuxedocomputers.com>
>> +L:	platform-driver-x86@vger.kernel.org
>> +S:	Supported
>> +F:	drivers/platform/x86/tuxedo/
>> +
>>   TW5864 VIDEO4LINUX DRIVER
>>   M:	Bluecherry Maintainers <maintainers@bluecherrydvr.com>
>>   M:	Andrey Utkin <andrey.utkin@corp.bluecherry.net>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index 0258dd879d64b..58b258cde4fdb 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -1186,6 +1186,8 @@ config SEL3350_PLATFORM
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called sel3350-platform.
>>   
>> +source "drivers/platform/x86/tuxedo/Kconfig"
>> +
>>   endif # X86_PLATFORM_DEVICES
>>   
>>   config P2SB
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>> index e1b1429470674..1562dcd7ad9a5 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
>>   
>>   # SEL
>>   obj-$(CONFIG_SEL3350_PLATFORM)		+= sel3350-platform.o
>> +
>> +# TUXEDO
>> +obj-y					+= tuxedo/
>> diff --git a/drivers/platform/x86/tuxedo/Kbuild b/drivers/platform/x86/tuxedo/Kbuild
>> new file mode 100644
>> index 0000000000000..0de6c7871db95
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/Kbuild
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# TUXEDO X86 Platform Specific Drivers
>> +#
>> +
>> +obj-y	+= nbxx/
>> diff --git a/drivers/platform/x86/tuxedo/Kconfig b/drivers/platform/x86/tuxedo/Kconfig
>> new file mode 100644
>> index 0000000000000..34aa2e89f00ba
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/Kconfig
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# TUXEDO X86 Platform Specific Drivers
>> +#
>> +
>> +source "drivers/platform/x86/tuxedo/nbxx/Kconfig"
>> diff --git a/drivers/platform/x86/tuxedo/nbxx/Kbuild b/drivers/platform/x86/tuxedo/nbxx/Kbuild
>> new file mode 100644
>> index 0000000000000..10ddef3564d84
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nbxx/Kbuild
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# TUXEDO X86 Platform Specific Drivers
>> +#
>> +
>> +tuxedo_nbxx_acpi_tuxi-y			:= acpi_tuxi.o
>> +obj-$(CONFIG_TUXEDO_NBXX_ACPI_TUXI)	+= tuxedo_nbxx_acpi_tuxi.o
>> diff --git a/drivers/platform/x86/tuxedo/nbxx/Kconfig b/drivers/platform/x86/tuxedo/nbxx/Kconfig
>> new file mode 100644
>> index 0000000000000..827c65c410fb2
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nbxx/Kconfig
>> @@ -0,0 +1,13 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# TUXEDO X86 Platform Specific Drivers
>> +#
>> +
>> +config TUXEDO_NBXX_ACPI_TUXI
>> +	tristate "TUXEDO NBxx ACPI TUXI Platform Driver"
>> +	help
>> +	  This driver implements the ACPI TUXI device found on some TUXEDO
>> +	  Notebooks. Currently this consists only of the TFAN subdevice which is
>> +	  implemented via hwmon.
>> +
>> +	  When compiled as a module it will be called tuxedo_nbxx_acpi_tuxi
>> diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
>> new file mode 100644
>> index 0000000000000..f42311f119956
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
>> @@ -0,0 +1,578 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/device.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/units.h>
>> +#include <linux/workqueue.h>
>> +
>> +#define TUXI_SAFEGUARD_PERIOD 1000      // 1s
>> +#define TUXI_PWM_FAN_ON_MIN_SPEED 0x40  // ~25%
>> +#define TUXI_TEMP_LEVEL_HYSTERESIS 1500 // 1.5°C
>> +#define TUXI_FW_TEMP_OFFSET 2730        // Kelvin to Celsius
>> +#define TUXI_MAX_FAN_COUNT 16           /* If this is increased, new lines must
>> +					 * be added to hwmcinfo below.
>> +					 */
> Please use static_assert() to actually enforce what the comment says.

I actually struggle to come up with how to do this for the array length because 
of the macro and the pointer

`static_assert(TUXI_MAX_FAN_COUNT <= ARRAY_SIZE(hwmcinfo[0]->config));` doesn't work

>
>> +
>> +static const struct acpi_device_id acpi_device_ids[] = {
>> +	{"TUXI0000", 0},
>> +	{"", 0}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, acpi_device_ids);
>> +
>> +struct tuxi_driver_data_t {
>> +	acpi_handle tfan_handle;
>> +	struct device *hwmdev;
>> +};
>> +
>> +struct tuxi_hwmon_driver_data_t {
>> +	struct delayed_work work;
>> +	struct device *hwmdev;
>> +	u8 fan_count;
>> +	const char *fan_types[TUXI_MAX_FAN_COUNT];
>> +	u8 temp_level[TUXI_MAX_FAN_COUNT];
>> +	u8 curr_speed[TUXI_MAX_FAN_COUNT];
>> +	u8 want_speed[TUXI_MAX_FAN_COUNT];
>> +	u8 pwm_enabled;
>> +};
>> +
>> +struct tuxi_temp_high_config_t {
>> +	long temp;
>> +	u8 min_speed;
>> +};
>> +
>> +/* Speed values in this table must be >= TUXI_PWM_FAN_ON_MIN_SPEED to avoid
>> + * undefined behaviour.
>> + */
>> +static const struct tuxi_temp_high_config_t temp_levels[] = {
>> +	{  80000, 0x4d }, // ~30%
>> +	{  90000, 0x66 }, // ~40%
>> +	{ 100000, 0xff }, // 100%
>> +	{ }
>> +};
>> +
>> +/*
>> + * Set fan speed target
>> + *
>> + * Set a specific fan speed (needs manual mode)
>> + *
>> + * Arg0: Fan index
>> + * Arg1: Fan speed as a fraction of maximum speed (0-255)
>> + */
>> +#define TUXI_TFAN_METHOD_SET_FAN_SPEED		"SSPD"
>> +
>> +/*
>> + * Get fan speed target
>> + *
>> + * Arg0: Fan index
>> + * Returns: Current fan speed target a fraction of maximum speed (0-255)
>> + */
>> +#define TUXI_TFAN_METHOD_GET_FAN_SPEED		"GSPD"
>> +
>> +/*
>> + * Get fans count
>> + *
>> + * Returns: Number of individually controllable fans
>> + */
>> +#define TUXI_TFAN_METHOD_GET_FAN_COUNT		"GCNT"
>> +
>> +/*
>> + * Set fans mode
>> + *
>> + * Arg0: 0 = auto, 1 = manual
>> + */
>> +#define TUXI_TFAN_METHOD_SET_FAN_MODE		"SMOD"
>> +
>> +/*
>> + * Get fans mode
>> + *
>> + * Returns: 0 = auto, 1 = manual
>> + */
>> +#define TUXI_TFAN_METHOD_GET_FAN_MODE		"GMOD"
>> +
>> +/*
>> + * Get fan type/what the fan is pointed at
>> + *
>> + * Arg0: Fan index
>> + * Returns: 0 = general, 1 = CPU, 2 = GPU
>> + */
>> +#define TUXI_TFAN_METHOD_GET_FAN_TYPE		"GTYP"
>> +
>> +static const char * const tuxi_fan_type_labels[] = {
>> +	"general",
>> +	"cpu",
>> +	"gpu"
>> +};
>> +
>> +/*
>> + * Get fan temperature/temperature of what the fan is pointed at
>> + *
>> + * Arg0: Fan index
>> + * Returns: Temperature sensor value in 10ths of degrees kelvin
>> + */
>> +#define TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE	"GTMP"
>> +
>> +/*
>> + * Get actual fan speed in RPM
>> + *
>> + * Arg0: Fan index
>> + * Returns: Speed sensor value in revolutions per minute
>> + */
>> +#define TUXI_TFAN_METHOD_GET_FAN_RPM		"GRPM"
>> +
>> +static int tuxi_tfan_method(struct acpi_device *device, acpi_string method,
>> +			    unsigned long long *params, u32 pcount,
>> +			    unsigned long long *retval)
>> +{
>> +	struct tuxi_driver_data_t *driver_data = dev_get_drvdata(&device->dev);
>> +	acpi_handle handle = driver_data->tfan_handle;
>> +	union acpi_object *obj __free(kfree) = NULL;
> Please add linux/cleanup.h include.
ack
>
>> +	struct acpi_object_list arguments;
>> +	unsigned long long data;
>> +	acpi_status status;
>> +	unsigned int i;
>> +
>> +	if (pcount > 0) {
>> +		obj = kcalloc(pcount, sizeof(*arguments.pointer), GFP_KERNEL);
>> +
>> +		arguments.count = pcount;
>> +		arguments.pointer = obj;
>> +		for (i = 0; i < pcount; ++i) {
>> +			arguments.pointer[i].type = ACPI_TYPE_INTEGER;
>> +			arguments.pointer[i].integer.value = params[i];
>> +		}
>> +	}
>> +	status = acpi_evaluate_integer(handle, method,
>> +				       pcount ? &arguments : NULL, &data);
>> +	if (ACPI_FAILURE(status))
>> +		return_ACPI_STATUS(status);
>> +
>> +	if (retval)
>> +		*retval = data;
>> +
>> +	return 0;
>> +}
>> +
>> +static umode_t hwm_is_visible(const void *data, enum hwmon_sensor_types type,
>> +			      u32 __always_unused attr, int channel)
>> +{
>> +	struct tuxi_hwmon_driver_data_t const *driver_data = data;
>> +
>> +	if (channel >= driver_data->fan_count)
>> +		return 0;
>> +
>> +	switch (type) {
>> +	case hwmon_fan:
>> +		return 0444;
>> +	case hwmon_pwm:
>> +		return 0644;
>> +	case hwmon_temp:
>> +		return 0444;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int hwm_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>> +		    int channel, long *val)
>> +{
>> +	struct tuxi_hwmon_driver_data_t *driver_data = dev_get_drvdata(dev);
>> +	struct acpi_device *pdev = to_acpi_device(dev->parent);
>> +	unsigned long long params[2], retval;
>> +	int ret;
>> +
>> +	switch (type) {
>> +	case hwmon_fan:
>> +		params[0] = channel;
>> +		ret = tuxi_tfan_method(pdev,
>> +				       TUXI_TFAN_METHOD_GET_FAN_RPM,
> These fit to same line.
ack
>
>> +				       params, 1, &retval);
>> +		*val = retval > S32_MAX ? S32_MAX : retval;
>> +		return ret;
>> +	case hwmon_pwm:
>> +		switch (attr) {
>> +		case hwmon_pwm_input:
>> +			if (driver_data->pwm_enabled) {
>> +				*val = driver_data->curr_speed[channel];
>> +				return 0;
>> +			}
>> +			params[0] = channel;
>> +			ret = tuxi_tfan_method(pdev,
>> +					       TUXI_TFAN_METHOD_GET_FAN_SPEED,
>> +					       params, 1, &retval);
>> +			*val = retval > S32_MAX ? S32_MAX : retval;
>> +			return ret;
>> +		case hwmon_pwm_enable:
>> +			*val = driver_data->pwm_enabled;
>> +			return ret;
>> +		}
>> +		break;
>> +	case hwmon_temp:
>> +		params[0] = channel;
>> +		ret = tuxi_tfan_method(pdev,
>> +				       TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
>> +				       params, 1, &retval);
>> +		*val = retval > S32_MAX / 100 ?
> Add linux/limits.h include.

ack

It is included in kernel.h, so I read from this that kernel.h should not be used 
but the parts of it directly?

>
>> +			S32_MAX : (retval - TUXI_FW_TEMP_OFFSET) * 100;
> Is the math wrong, as you do retval - TUXI_FW_TEMP_OFFSET before
> multiplying?
No, retval is in 10th of °K (but the last number is always 0) so is 
TUXI_FW_TEMP_OFFSET which is there to convert it to 10th of °C, the * 100 is 
then to bring it in line with hwmon wanting to output milli degrees
> Shouldn't it be like this:
>
> 		retval -= TUXI_FW_TEMP_OFFSET;
> 		*val = min(retval * 100, (unsigned long long)S32_MAX);
As retval is unsigned this would not work with (theoretical) negative °C.
>
> + add include for min().

And for max() used elsewere in the code -> ack

>
>> +		return ret;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int hwm_read_string(struct device *dev,
>> +			   enum hwmon_sensor_types __always_unused type,
>> +			   u32 __always_unused attr, int channel,
>> +			   const char **str)
>> +{
>> +	struct tuxi_hwmon_driver_data_t *driver_data = dev_get_drvdata(dev);
>> +
>> +	*str = driver_data->fan_types[channel];
>> +
>> +	return 0;
>> +}
>> +
>> +static int write_speed(struct device *dev, int channel, u8 val, bool force)
>> +{
>> +	struct tuxi_hwmon_driver_data_t *driver_data = dev_get_drvdata(dev);
>> +	struct acpi_device *pdev = to_acpi_device(dev->parent);
>> +	unsigned long long params[2];
>> +	u8 temp_level;
>> +	int ret;
>> +
>> +	params[0] = channel;
>> +
>> +	/* The heatpipe across the DRMs is shared between both fans and the DRMs
> In multi-line comments:
>
> 	/*
> 	 * Text starts here...
Ack
>
> What are DRMs? I guess it's neither Digital Rights Managements nor Direct
> Rendering Managers :-).
Sorry brainfail, wanted to write VRMs. Good that I failed twice xD.
>
>> +	 * are the most likely to go up in smoke. So it's better to apply the
>> +	 * minimum fan speed to all fans if either CPU or GPU is working hard.
>> +	 */
>> +	temp_level = max_array(driver_data->temp_level, driver_data->fan_count);
>> +	if (temp_level)
>> +		params[1] = max_t(u8, val,
>> +				  temp_levels[temp_level - 1].min_speed);
> Both are already u8 so why you need max_t(), max() should be sufficient
> when types are already right.
>
> Include is missing.
>
>> +	else if (val < TUXI_PWM_FAN_ON_MIN_SPEED / 2)
>> +		params[1] = 0;
>> +	else if (val < TUXI_PWM_FAN_ON_MIN_SPEED)
>> +		params[1] = TUXI_PWM_FAN_ON_MIN_SPEED;
>> +	else
>> +		params[1] = val;
>> +
>> +	if (force || params[1] != driver_data->curr_speed[channel])
>> +		ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_SPEED,
>> +				       params, 2, NULL);
>> +	if (ret)
>> +		return ret;
> Please indent this to the correct level.
ack
>
>> +
>> +	driver_data->curr_speed[channel] = params[1];
> The use of params[1] obfuscates meaning, please use local variable with a
> proper name and only assign it into params[1] for the tuxi_tfan_method call.
ack
>
>> +
>> +	return 0;
>> +}
>> +
>> +static int hwm_write(struct device *dev,
>> +		     enum hwmon_sensor_types __always_unused type, u32 attr,
>> +		     int channel, long val)
>> +{
>> +	struct tuxi_hwmon_driver_data_t *driver_data = dev_get_drvdata(dev);
>> +	struct acpi_device *pdev = to_acpi_device(dev->parent);
>> +	unsigned long long params[2];
>> +	unsigned int i;
>> +	int ret;
>> +
>> +	switch (attr) {
>> +	case hwmon_pwm_input:
>> +		if (val > U8_MAX || val < 0)
>> +			return -EINVAL;
>> +
>> +		if (driver_data->pwm_enabled) {
>> +			driver_data->want_speed[channel] = val;
>> +			return write_speed(dev, channel, val, false);
>> +		}
>> +
>> +		return 0;
>> +	case hwmon_pwm_enable:
>> +		params[0] = val ? 1 : 0;
> Can those two literals be named with defines?
ack
>
>> +		ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_MODE,
>> +				       params, 1, NULL);
>> +		if (ret)
>> +			return ret;
>> +
>> +		driver_data->pwm_enabled = val;
>> +
>> +		/* Activating PWM sets speed to 0. Alternative design decision
>> +		 * could be to keep the current value. This would require proper
>> +		 * setting of driver_data->curr_speed for example.
>> +		 */
>> +		if (val)
> Consider:
> 		if (!val)
> 			return 0;
>
> So you can deindent the loop by one level.
Imho it makes the logic harder to follow and considering the only short code 
lines following after, I don't really see the benefit.
>
>> +			for (i = 0; i < driver_data->fan_count; ++i) {
>> +				ret = write_speed(dev, i, 0, true);
>> +				if (ret)
>> +					return ret;
>> +			}
>> +
>> +		return 0;
>> +	}
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static const struct hwmon_ops hwmops = {
>> +	.is_visible = hwm_is_visible,
>> +	.read = hwm_read,
>> +	.read_string = hwm_read_string,
>> +	.write = hwm_write,
>> +};
>> +
>> +static const struct hwmon_channel_info * const hwmcinfo[] = {
>> +	HWMON_CHANNEL_INFO(fan,
>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>> +			   HWMON_F_INPUT | HWMON_F_LABEL),
>> +	HWMON_CHANNEL_INFO(pwm,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
>> +	HWMON_CHANNEL_INFO(temp,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL),
>> +	NULL
>> +};
>> +
>> +static const struct hwmon_chip_info hwminfo = {
>> +	.ops = &hwmops,
>> +	.info = hwmcinfo
>> +};
>> +
>> +static u8 tuxi_get_temp_level(struct tuxi_hwmon_driver_data_t *driver_data,
>> +			      u8 fan_id, long temp)
>> +{
>> +	long temp_low, temp_high;
>> +	unsigned int i;
>> +	int ret;
>> +
>> +	ret = driver_data->temp_level[fan_id];
>> +
>> +	for (i = 0; temp_levels[i].temp; ++i) {
>> +		temp_low = i == 0 ? S32_MIN : temp_levels[i - 1].temp;
>> +		temp_high = temp_levels[i].temp;
>> +		if (ret > i)
>> +			temp_high -= TUXI_TEMP_LEVEL_HYSTERESIS;
>> +
>> +		if (temp >= temp_low && temp < temp_high)
>> +			ret = i;
> Why you cannot return i; immediately here?

leftover from when the loop wasn't it's own function

ack

>
>> +	}
>> +	if (temp >= temp_high)
>> +		ret = i;
>> +
>> +	return ret;
>> +}
>> +
>> +static void tuxi_periodic_hw_safeguard(struct work_struct *work)
>> +{
>> +	struct tuxi_hwmon_driver_data_t *driver_data = container_of(work,
>> +								    struct tuxi_hwmon_driver_data_t,
>> +								    work.work);
>> +	struct device *dev = driver_data->hwmdev;
>> +	struct acpi_device *pdev = to_acpi_device(dev->parent);
>> +	unsigned long long params[2], retval;
>> +	unsigned int i;
>> +	long temp;
>> +	int ret;
>> +
>> +	for (i = 0; i < driver_data->fan_count; ++i) {
>> +		params[0] = i;
>> +		ret = tuxi_tfan_method(pdev,
>> +				       TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
>> +				       params, 1, &retval);
>> +		/* If reading the temprature fails, default to a high value to
> temperature
thx for spotting
>
>> +		 * be on the safe side in the worst case.
>> +		 */
>> +		if (ret)
>> +			retval = 2720 + 1200;
> TUXI_FW_TEMP_OFFSET + 1200 ?
>
> Why it doesn't match to that define??
Typo and from before the define existed, fixed.
>
>> +
>> +		temp = retval > S32_MAX / 100 ?
>> +			S32_MAX : (retval - TUXI_FW_TEMP_OFFSET) * 100;
> Same math issue comment as above.
>
> Why is the read+conversion code duplicated into two places?
because here it is with special error handling and didn't thought about an own 
function for a defacto 2 liner
>
>> +
>> +		driver_data->temp_level[i] = tuxi_get_temp_level(driver_data, i,
>> +								 temp);
>> +	}
>> +
>> +	// Reapply want_speeds to respect eventual new temp_levels
>> +	for (i = 0; i < driver_data->fan_count; ++i)
>> +		write_speed(dev, i, driver_data->want_speed[i], false);
>> +
>> +	schedule_delayed_work(&driver_data->work, TUXI_SAFEGUARD_PERIOD);
>> +}
>> +
>> +static int tuxi_hwmon_add_devices(struct acpi_device *pdev, struct device **hwmdev)
>> +{
>> +	struct tuxi_hwmon_driver_data_t *driver_data;
>> +	unsigned long long params[2], retval;
>> +	unsigned int i;
>> +	int ret;
>> +
>> +	/* The first version of TUXI TFAN didn't have the Get Fan Temperature
>> +	 * method which is integral to this driver. So probe for existence and
>> +	 * abort otherwise.
>> +	 *
>> +	 * The Get Fan Speed method is also missing in that version, but was
>> +	 * added in the same version so it doesn't have to be probe separately.
>> +	 */
>> +	params[0] = 0;
>> +	ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
>> +			       params, 1, &retval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	driver_data = devm_kzalloc(&pdev->dev, sizeof(*driver_data), GFP_KERNEL);
>> +	if (!driver_data)
>> +		return -ENOMEM;
>> +
>> +	/* Loading this module sets the fan mode to auto. Alternative design
>> +	 * decision could be to keep the current value. This would require
>> +	 * proper initialization of driver_data->curr_speed for example.
>> +	 */
>> +	params[0] = 0;
> Is this 0 ..._MODE_AUTO? Please use a named define if that's the case.
ack
>
>> +	ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_MODE, params, 1,
>> +			       NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_COUNT, NULL, 0,
>> +			       &retval);
>> +	if (ret)
>> +		return ret;
>> +	if (retval > TUXI_MAX_FAN_COUNT)
>> +		return -EINVAL;
>> +	driver_data->fan_count = retval;
>> +
>> +	for (i = 0; i < driver_data->fan_count; ++i) {
>> +		params[0] = i;
>> +		ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_TYPE,
>> +				       params, 1, &retval);
>> +		if (ret)
>> +			return ret;
>> +		else if (retval >= ARRAY_SIZE(tuxi_fan_type_labels))
> No need for else as there's return.
ack
>
>> +			return -EOPNOTSUPP;
>> +		driver_data->fan_types[i] = tuxi_fan_type_labels[retval];
>> +	}
>> +
>> +	*hwmdev = devm_hwmon_device_register_with_info(&pdev->dev,
>> +						       "tuxedo_nbxx_acpi_tuxi",
>> +						       driver_data, &hwminfo,
>> +						       NULL);
>> +	ret = PTR_ERR_OR_ZERO(*hwmdev);
>> +	if (ret)
> This obfuscates what you're doing here as you do not actually use 0 at
> all. Please use this instead:
>
> 	if (IS_ERR(*hwmdev))
> 		return PTR_ERR(*hwmdev);
ack
>
>> +		return ret;
>> +
>> +	driver_data->hwmdev = *hwmdev;
>> +
>> +	INIT_DELAYED_WORK(&driver_data->work, tuxi_periodic_hw_safeguard);
>> +	schedule_delayed_work(&driver_data->work, TUXI_SAFEGUARD_PERIOD);
>> +
>> +	return 0;
>> +}
>> +
>> +static void tuxi_hwmon_remove_devices(struct device *hwmdev)
>> +{
>> +	struct tuxi_hwmon_driver_data_t *driver_data = dev_get_drvdata(hwmdev);
>> +	struct acpi_device *pdev = to_acpi_device(hwmdev->parent);
>> +	unsigned long long params[2];
>> +
>> +	cancel_delayed_work_sync(&driver_data->work);
>> +
>> +	params[0] = 0;
> Use a named define?
ack
>
>> +	tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_MODE, params, 1, NULL);
>> +}
>> +
>> +static int tuxi_add(struct acpi_device *device)
>> +{
>> +	struct tuxi_driver_data_t *driver_data;
>> +	acpi_status status;
>> +
>> +	driver_data = devm_kzalloc(&device->dev, sizeof(*driver_data),
>> +				   GFP_KERNEL);
>> +	if (!driver_data)
>> +		return -ENOMEM;
>> +
>> +	// Find subdevices
>> +	status = acpi_get_handle(device->handle, "TFAN",
>> +				 &driver_data->tfan_handle);
>> +	if (ACPI_FAILURE(status))
>> +		return_ACPI_STATUS(status);
>> +
>> +	dev_set_drvdata(&device->dev, driver_data);
>> +
>> +	return tuxi_hwmon_add_devices(device, &driver_data->hwmdev);
>> +}
>> +
>> +static void tuxi_remove(struct acpi_device *device)
>> +{
>> +	struct tuxi_driver_data_t *driver_data = dev_get_drvdata(&device->dev);
>> +
>> +	tuxi_hwmon_remove_devices(driver_data->hwmdev);
>> +}
>> +
>> +static struct acpi_driver acpi_driver = {
>> +	.name = "tuxedo_nbxx_acpi_tuxi",
>> +	.ids = acpi_device_ids,
>> +	.ops = {
>> +		.add = tuxi_add,
>> +		.remove = tuxi_remove,
>> +	},
>> +};
>> +
>> +module_acpi_driver(acpi_driver);
>> +
>> +MODULE_DESCRIPTION("TUXEDO TUXI");
> Perhaps this could be made a more specific to the actual functionality?
yes overlooked this, was still a placeholder from the very beginning of writing 
this code.
>
>> +MODULE_AUTHOR("Werner Sembach <wse@tuxedocomputers.com>");
>> +MODULE_LICENSE("GPL");
>>
v3 incomming

Best regards,

Werner


