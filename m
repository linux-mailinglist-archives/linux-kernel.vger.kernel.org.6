Return-Path: <linux-kernel+bounces-572398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF47A6C9F6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD8F88114D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 11:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EAD20C47F;
	Sat, 22 Mar 2025 11:46:59 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8821E3762;
	Sat, 22 Mar 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742644017; cv=none; b=XlPMzLPz00LQzz+kkF3CX3efb2qHSIVHz3ZpDI4kTIrv5sIp+q6ESNgQmdKx1bK+1CMnJXjeOSOKfFEfJiSV5iC8F0/BWfkgSYhjmSYHVJTXo9xBXSYOua1Sr0IlG5w0tDJzc2tIh+K1oXdQOSDE411OZXP9YPl9lr5iHzmGtq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742644017; c=relaxed/simple;
	bh=v/VKWboQSgECTNGUqpN6QbxCVKrQuA/6k0I/OyQw6Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5gx15dLH8u7thGJW+N/am3rOhvsbGpDfBImpyHfvq3t17JfviO68K7GlLmzXUwHMMlG7TL6UoTbxcmL47s9LXWsqgzLdmrv9g6BsNwqsZGq0n73i5J8GBt0qvKkIqx7Kudex22170bLlV7rJVSAqwDzq9casDuaBBJJPGFF76I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-549b12ad16eso3006826e87.0;
        Sat, 22 Mar 2025 04:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742644013; x=1743248813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7XeQ6USymaI2q/xYtRRk+uoQ2z4TI9mguyqCPAIV0U=;
        b=F4cCkc4cDBjVgYG0Zx42E+NOxSZpUeyAiXoMhN97dWBjjJJPxD0OsDzsZoxtSXxNsD
         57Z6+EiaA9nFkjbcZQUVwiyeOkADiO+H6qxcLCh2fsZgIc3UxpvVzIYTTr1Ufu9I07iA
         4eJ1JYK7SjJrHWYVmo62seplvljqVAXSyDxn+R8MQUTAOEeQb5yCTUdpQBvHpC44CHod
         +WPGCzKnWGNwq3G7TtoEuRjlW1ZYm7v8KDpYmEbx130FN8SwQJ6tJJoN0S74maZ2hTkn
         G2dw3FSQ7xHUgrbW/fUSz+FZii9dSoAPE++G8WL826fESveuY85ZCaXBnNX2LPyB9ltf
         bhdw==
X-Forwarded-Encrypted: i=1; AJvYcCW1ypkxU1/Uymm9xJe+E+Tb+h/R1YWAo28Kgw4rCBpzeRQW7KS4sMU2s5zGYyHGuzad/eEzRHoV2vO1UA==@vger.kernel.org, AJvYcCWV3i8jzsNTZU7/pBbIDbV1njUKuTYLlA3ajgH+eNZSjstW7/dXcmgtzXDgny1GWliyXEIyuDUNh75Ua79vOYlsS7oFvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYC8s7fr38Qc+XS3fbd1HJ1T/9cS8TJRIzTWnSJIFe4hws8FV
	voRRl7eIT3BU1/8az9i4UsrKWmwVlUqvDajgt2gFaJT0G2E5qDec
X-Gm-Gg: ASbGncv9OuhZwxKJONDwALBOiaQMIzkObD2xcBSaoREHkRADRc+ZertW3P92SeKgtsj
	pC24iwaE8CcEAkobQ5AcYyfIe6XeLTsxxPsgEjbhp0qiaY1KSrn2BdlxWv4SHWdMZqRmlaBJaVb
	9FUdPBNUYbm0Z0zpHpGQb2dEC1E6fWKmDUgsHMgaphHX1mz+HLZSiUlDziD3X+EOsyOItiHAeIf
	as1pcWNJBNLzQaZLmuPyISI4lCyP3iLT7cKVTEBwCdp5fYq6FldqPj1BJDOMN4hz/TJJr1EKye4
	DeI7ZzQdWsYE/sN1cqyxJMp2pnfSC4WJ8Vh44bUiyb7k2eeASlc+pRi4nfGt9syVkBUbSllyB6E
	P4HUu1M+/
X-Google-Smtp-Source: AGHT+IGd2I5Jf8hWdCpUbOvyyn4WtE4SLK2y2exaFmC9gVQkfrc6pWoZ6JXKuFuEhlbHntxjoqp1Ow==
X-Received: by 2002:a05:6512:1593:b0:545:2c40:ec1d with SMTP id 2adb3069b0e04-54ad650d0f4mr2321315e87.44.1742644012232;
        Sat, 22 Mar 2025 04:46:52 -0700 (PDT)
Received: from [192.168.1.184] (82-183-24-76.customers.ownit.se. [82.183.24.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64fbaf4sm439511e87.137.2025.03.22.04.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 04:46:50 -0700 (PDT)
Message-ID: <397e7f25-f07c-4f3c-ad40-2611cb24d63a@joshuagrisham.com>
Date: Sat, 22 Mar 2025 12:46:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] platform/x86/tuxedo: Implement TUXEDO TUXI ACPI
 TFAN via hwmon
To: Kurt Borja <kuurtb@gmail.com>, Werner Sembach <wse@tuxedocomputers.com>,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
 linux@roeck-us.net
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20250313221407.644349-1-wse@tuxedocomputers.com>
 <20250313221407.644349-2-wse@tuxedocomputers.com>
 <D8J5A68UDQOD.3UN0OMYNV0ZAZ@gmail.com>
 <a572db08-9667-4925-aed3-663831f14977@tuxedocomputers.com>
 <D8JGDXSAXU6C.39P8V5E3YQR8Q@gmail.com>
Content-Language: en-US
From: Joshua Grisham <josh@joshuagrisham.com>
In-Reply-To: <D8JGDXSAXU6C.39P8V5E3YQR8Q@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/18/25 15:14, Kurt Borja wrote:
> On Tue Mar 18, 2025 at 8:08 AM -05, Werner Sembach wrote:
>> Hi Kurt,
>>
>> Am 18.03.25 um 06:32 schrieb Kurt Borja:
>>> Hi Werner,
>>>
>>> On Thu Mar 13, 2025 at 5:09 PM -05, Werner Sembach wrote:
>>>> The TUXEDO Sirius 16 Gen1 & Gen2 have the custom TUXEDO Interface (TUXI)
>>>> ACPI interface which currently consists of the TFAN device. This has ACPI
>>>> functions to control the built in fans and monitor fan speeds and CPU and
>>>> GPU temperature.
>>>>
>>>> This driver implements this TFAN device via the hwmon subsystem with an
>>>> added temperature check that ensure a minimum fanspeed at certain
>>>> temperatures. This allows userspace controlled, but hardware safe, custom
>>>> fan curves.
>>>>
>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>>> ---
>>>>   MAINTAINERS                                  |   6 +
>>>>   drivers/platform/x86/Kconfig                 |   2 +
>>>>   drivers/platform/x86/Makefile                |   3 +
>>>>   drivers/platform/x86/tuxedo/Kbuild           |   8 +
>>>>   drivers/platform/x86/tuxedo/Kconfig          |   8 +
>>>>   drivers/platform/x86/tuxedo/nbxx/Kbuild      |   9 +
>>>>   drivers/platform/x86/tuxedo/nbxx/Kconfig     |  15 +
>>>>   drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c | 591 +++++++++++++++++++
>>>>   8 files changed, 642 insertions(+)
>>>>   create mode 100644 drivers/platform/x86/tuxedo/Kbuild
>>>>   create mode 100644 drivers/platform/x86/tuxedo/Kconfig
>>>>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kbuild
>>>>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kconfig
>>>>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 8e0736dc2ee0e..7139c32e96dc7 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -24190,6 +24190,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
>>>>   F:	tools/power/x86/turbostat/
>>>>   F:	tools/testing/selftests/turbostat/
>>>>   
>>>> +TUXEDO DRIVERS
>>>> +M:	Werner Sembach <wse@tuxedocomputers.com>
>>>> +L:	platform-driver-x86@vger.kernel.org
>>>> +S:	Supported
>>>> +F:	drivers/platform/x86/tuxedo/
>>>> +
>>>>   TW5864 VIDEO4LINUX DRIVER
>>>>   M:	Bluecherry Maintainers <maintainers@bluecherrydvr.com>
>>>>   M:	Andrey Utkin <andrey.utkin@corp.bluecherry.net>
>>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>>>> index 0258dd879d64b..58b258cde4fdb 100644
>>>> --- a/drivers/platform/x86/Kconfig
>>>> +++ b/drivers/platform/x86/Kconfig
>>>> @@ -1186,6 +1186,8 @@ config SEL3350_PLATFORM
>>>>   	  To compile this driver as a module, choose M here: the module
>>>>   	  will be called sel3350-platform.
>>>>   
>>>> +source "drivers/platform/x86/tuxedo/Kconfig"
>>>> +
>>>>   endif # X86_PLATFORM_DEVICES
>>>>   
>>>>   config P2SB
>>>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>>>> index e1b1429470674..1562dcd7ad9a5 100644
>>>> --- a/drivers/platform/x86/Makefile
>>>> +++ b/drivers/platform/x86/Makefile
>>>> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
>>>>   
>>>>   # SEL
>>>>   obj-$(CONFIG_SEL3350_PLATFORM)		+= sel3350-platform.o
>>>> +
>>>> +# TUXEDO
>>>> +obj-y					+= tuxedo/
>>>> diff --git a/drivers/platform/x86/tuxedo/Kbuild b/drivers/platform/x86/tuxedo/Kbuild
>>> I think this should be named Makefile instead of Kbuild.
>>
>> Ack
>>
>> I thought since I did not use anything that is makefile syntax I should use 
>> Kbuild, but I looked it up and found this: 
>> https://www.kernel.org/doc/html/v6.14-rc7/kbuild/makefiles.html#the-kbuild-files
>>
>>>
>>>> new file mode 100644
>>>> index 0000000000000..dc55b403f201d
>>>> --- /dev/null
>>>> +++ b/drivers/platform/x86/tuxedo/Kbuild
>>>> @@ -0,0 +1,8 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>> +#
>>>> +# Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
>>>> +#
>>>> +# TUXEDO X86 Platform Specific Drivers
>>>> +#
>>>> +
>>>> +obj-y	+= nbxx/
>>>> diff --git a/drivers/platform/x86/tuxedo/Kconfig b/drivers/platform/x86/tuxedo/Kconfig
>>>> new file mode 100644
>>>> index 0000000000000..1b22a0b29460a
>>>> --- /dev/null
>>>> +++ b/drivers/platform/x86/tuxedo/Kconfig
>>>> @@ -0,0 +1,8 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>> +#
>>>> +# Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
>>>> +#
>>>> +# TUXEDO X86 Platform Specific Drivers
>>>> +#
>>>> +
>>>> +source "drivers/platform/x86/tuxedo/nbxx/Kconfig"
>>>> diff --git a/drivers/platform/x86/tuxedo/nbxx/Kbuild b/drivers/platform/x86/tuxedo/nbxx/Kbuild
>>> Same as above.
>> Ack
>>>
>>>> new file mode 100644
>>>> index 0000000000000..256b03921c732
>>>> --- /dev/null
>>>> +++ b/drivers/platform/x86/tuxedo/nbxx/Kbuild
>>>> @@ -0,0 +1,9 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>> +#
>>>> +# Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
>>>> +#
>>>> +# TUXEDO X86 Platform Specific Drivers
>>>> +#
>>>> +
>>>> +tuxedo_nbxx_acpi_tuxi-y			:= acpi_tuxi.o
>>>> +obj-$(CONFIG_TUXEDO_NBXX_ACPI_TUXI)	+= tuxedo_nbxx_acpi_tuxi.o
>>>> diff --git a/drivers/platform/x86/tuxedo/nbxx/Kconfig b/drivers/platform/x86/tuxedo/nbxx/Kconfig
>>>> new file mode 100644
>>>> index 0000000000000..0d011c0c715a5
>>>> --- /dev/null
>>>> +++ b/drivers/platform/x86/tuxedo/nbxx/Kconfig
>>>> @@ -0,0 +1,15 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>> +#
>>>> +# Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
>>>> +#
>>>> +# TUXEDO X86 Platform Specific Drivers
>>>> +#
>>>> +
>>>> +config TUXEDO_NBXX_ACPI_TUXI
>>>> +	tristate "TUXEDO NBxx ACPI TUXI Platform Driver"
>>>> +	help
>>>> +	  This driver implements the ACPI TUXI device found on some TUXEDO
>>>> +	  Notebooks. Currently this consists only of the TFAN subdevice which is
>>>> +	  implemented via hwmon.
>>>> +
>>>> +	  When compiled as a module it will be called tuxedo_nbxx_acpi_tuxi
>>>> diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
>>>> new file mode 100644
>>>> index 0000000000000..bb452cc33568a
>>>> --- /dev/null
>>>> +++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
>>>> @@ -0,0 +1,591 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +/*
>>>> + * Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
>>>> + */
>>>> +
>>>> +#include <linux/acpi.h>
>>>> +#include <linux/cleanup.h>
>>>> +#include <linux/device.h>
>>>> +#include <linux/hwmon.h>
>>>> +#include <linux/limits.h>
>>>> +#include <linux/minmax.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/units.h>
>>>> +#include <linux/workqueue.h>
>>>> +
>>>> +#define TUXI_SAFEGUARD_PERIOD 1000      // 1s
>>>> +#define TUXI_PWM_FAN_ON_MIN_SPEED 0x40  // ~25%
>>>> +#define TUXI_TEMP_LEVEL_HYSTERESIS 1500 // 1.5°C
>>>> +#define TUXI_FW_TEMP_OFFSET 2730        // Kelvin to Celsius
>>>> +#define TUXI_MAX_FAN_COUNT 16           /*
>>>> +					 * If this is increased, new lines must
>>>> +					 * be added to hwmcinfo below.
>>>> +					 */
>>> The style of these macros could be better.
>>>
>>> I suggest using an enum instead. Something like:
>>>
>>> 	enum TUXI_SAFEGUARD_LIMITS {
>>> 		...
>>> 	}
>> Since these values are all on very different scales an enum feels somehow wrong 
>> for me here.
> 
> I agree.
> 
>>>
>>> with it's values aligned and the comment on top.
>> Ack
>>>
>>>> +
>>>> +static const struct acpi_device_id acpi_device_ids[] = {
>>>> +	{"TUXI0000", 0},
>>>> +	{"", 0}
>>>> +};
>>>> +MODULE_DEVICE_TABLE(acpi, acpi_device_ids);
>>>> +
>>>> +struct tuxi_driver_data_t {
>>>> +	acpi_handle tfan_handle;
>>>> +	struct device *hwmdev;
>>>> +};
>>>> +
>>>> +struct tuxi_hwmon_driver_data_t {
>>>> +	struct delayed_work work;
>>>> +	struct device *hwmdev;
>>>> +	u8 fan_count;
>>>> +	const char *fan_types[TUXI_MAX_FAN_COUNT];
>>>> +	u8 temp_level[TUXI_MAX_FAN_COUNT];
>>>> +	u8 curr_speed[TUXI_MAX_FAN_COUNT];
>>>> +	u8 want_speed[TUXI_MAX_FAN_COUNT];
>>>> +	u8 pwm_enabled;
>>>> +};
>>>> +
>>>> +struct tuxi_temp_high_config_t {
>>>> +	long temp;
>>>> +	u8 min_speed;
>>>> +};
>>>> +
>>>> +/*
>>>> + * Speed values in this table must be >= TUXI_PWM_FAN_ON_MIN_SPEED to avoid
>>>> + * undefined behaviour.
>>>> + */
>>>> +static const struct tuxi_temp_high_config_t temp_levels[] = {
>>>> +	{  80000, 0x4d }, // ~30%
>>>> +	{  90000, 0x66 }, // ~40%
>>>> +	{ 100000, 0xff }, // 100%
>>>> +	{ }
>>>> +};
>>>> +
>>>> +/*
>>>> + * Set fan speed target
>>>> + *
>>>> + * Set a specific fan speed (needs manual mode)
>>>> + *
>>>> + * Arg0: Fan index
>>>> + * Arg1: Fan speed as a fraction of maximum speed (0-255)
>>>> + */
>>>> +#define TUXI_TFAN_METHOD_SET_FAN_SPEED		"SSPD"
>>>> +
>>>> +/*
>>>> + * Get fan speed target
>>>> + *
>>>> + * Arg0: Fan index
>>>> + * Returns: Current fan speed target a fraction of maximum speed (0-255)
>>>> + */
>>>> +#define TUXI_TFAN_METHOD_GET_FAN_SPEED		"GSPD"
>>>> +
>>>> +/*
>>>> + * Get fans count
>>>> + *
>>>> + * Returns: Number of individually controllable fans
>>>> + */
>>>> +#define TUXI_TFAN_METHOD_GET_FAN_COUNT		"GCNT"
>>>> +
>>>> +/*
>>>> + * Set fans mode
>>>> + *
>>>> + * Arg0: 0 = auto, 1 = manual
>>>> + */
>>>> +#define TUXI_TFAN_METHOD_SET_FAN_MODE		"SMOD"
>>>> +
>>>> +/*
>>>> + * Get fans mode
>>>> + *
>>>> + * Returns: 0 = auto, 1 = manual
>>>> + */
>>>> +#define TUXI_TFAN_METHOD_GET_FAN_MODE		"GMOD"
>>>> +
>>>> +#define TUXI_TFAN_FAN_MODE_AUTO 0
>>>> +#define TUXI_TFAN_FAN_MODE_MANUAL 1
>>>> +
>>>> +/*
>>>> + * Get fan type/what the fan is pointed at
>>>> + *
>>>> + * Arg0: Fan index
>>>> + * Returns: 0 = general, 1 = CPU, 2 = GPU
>>>> + */
>>>> +#define TUXI_TFAN_METHOD_GET_FAN_TYPE		"GTYP"
>>>> +
>>>> +static const char * const tuxi_fan_type_labels[] = {
>>>> +	"general",
>>>> +	"cpu",
>>>> +	"gpu"
>>>> +};
>>>> +
>>>> +/*
>>>> + * Get fan temperature/temperature of what the fan is pointed at
>>>> + *
>>>> + * Arg0: Fan index
>>>> + * Returns: Temperature sensor value in 10ths of degrees kelvin
>>>> + */
>>>> +#define TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE	"GTMP"
>>>> +
>>>> +/*
>>>> + * Get actual fan speed in RPM
>>>> + *
>>>> + * Arg0: Fan index
>>>> + * Returns: Speed sensor value in revolutions per minute
>>>> + */
>>>> +#define TUXI_TFAN_METHOD_GET_FAN_RPM		"GRPM"
>>>> +
>>>> +static int tuxi_tfan_method(struct acpi_device *device, acpi_string method,
>>>> +			    unsigned long long *params, u32 pcount,
>>>> +			    unsigned long long *retval)
>>>> +{
>>>> +	struct tuxi_driver_data_t *driver_data = dev_get_drvdata(&device->dev);
>>>> +	acpi_handle handle = driver_data->tfan_handle;
>>>> +	union acpi_object *obj __free(kfree) = NULL;
>>>> +	struct acpi_object_list arguments;
>>>> +	unsigned long long data;
>>>> +	acpi_status status;
>>>> +	unsigned int i;
>>>> +
>>>> +	if (pcount > 0) {
>>>> +		obj = kcalloc(pcount, sizeof(*arguments.pointer), GFP_KERNEL);
>>>> +
>>>> +		arguments.count = pcount;
>>>> +		arguments.pointer = obj;
>>>> +		for (i = 0; i < pcount; ++i) {
>>>> +			arguments.pointer[i].type = ACPI_TYPE_INTEGER;
>>>> +			arguments.pointer[i].integer.value = params[i];
>>>> +		}
>>>> +	}
>>>> +	status = acpi_evaluate_integer(handle, method,
>>>> +				       pcount ? &arguments : NULL, &data);
>>>> +	if (ACPI_FAILURE(status))
>>>> +		return_ACPI_STATUS(status);
>>>> +
>>>> +	if (retval)
>>>> +		*retval = data;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static umode_t hwm_is_visible(const void *data, enum hwmon_sensor_types type,
>>> All of these callbacks should be prefixed with "tuxi_".
>> Ack.
>>>
>>>> +			      u32 __always_unused attr, int channel)
>>>> +{
>>>> +	struct tuxi_hwmon_driver_data_t const *driver_data = data;
>>>> +
>>>> +	if (channel >= driver_data->fan_count)
>>>> +		return 0;
>>>> +
>>>> +	switch (type) {
>>>> +	case hwmon_fan:
>>>> +		return 0444;
>>>> +	case hwmon_pwm:
>>>> +		return 0644;
>>>> +	case hwmon_temp:
>>>> +		return 0444;
>>>> +	default:
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>> +static int hwm_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>>>> +		    int channel, long *val)
>>>> +{
>>>> +	struct tuxi_hwmon_driver_data_t *driver_data = dev_get_drvdata(dev);
>>>> +	struct acpi_device *pdev = to_acpi_device(dev->parent);
>>>> +	unsigned long long params[2], retval;
>>>> +	int ret;
>>>> +
>>>> +	switch (type) {
>>>> +	case hwmon_fan:
>>>> +		params[0] = channel;
>>>> +		ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_RPM,
>>>> +				       params, 1, &retval);
>>>> +		*val = retval > S32_MAX ? S32_MAX : retval;
>>> Use clamp_val().
>> Thanks for the tip
>>>
>>> Also, is an RPM >S32_MAX a bogus value? Should it be treated as an
>>> error instead?
>> Yeah sounds good, will do.
>>>
>>>> +		return ret;
>>>> +	case hwmon_pwm:
>>>> +		switch (attr) {
>>>> +		case hwmon_pwm_input:
>>>> +			if (driver_data->pwm_enabled) {
>>> I think this needs locking.
>> Since this was only meant as a small performance optimization if wonder if I 
>> shouldn't just skip the if-case and just ask the wmi every time instead?
> 
> IMO, yes. I don't think it's necessary to cache the value either, as you
> could just retrieve it every time. That way you avoid having to provide
> locking.
> 
>>>
>>>> +				*val = driver_data->curr_speed[channel];
>>>> +				return 0;
>>>> +			}
>>>> +			params[0] = channel;
>>>> +			ret = tuxi_tfan_method(pdev,
>>>> +					       TUXI_TFAN_METHOD_GET_FAN_SPEED,
>>>> +					       params, 1, &retval);
>>>> +			*val = retval > S32_MAX ? S32_MAX : retval;
>>> HWMON ABI specifies that the `pwm` attribute range is 0-255. Are values
>>> above this, bogus values?
>> Didn't know, but ofc I can change the check here.
>>>
>>>> +			return ret;
>>>> +		case hwmon_pwm_enable:
>>>> +			*val = driver_data->pwm_enabled;
>>>> +			return ret;
>>> `ret` is uninitialized when used here!
>> Sorry, will fix.
>>>
>>>> +		}
>>>> +		break;
>>>> +	case hwmon_temp:
>>>> +		params[0] = channel;
>>>> +		ret = tuxi_tfan_method(pdev,
>>>> +				       TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
>>>> +				       params, 1, &retval);
>>>> +		*val = retval > S32_MAX / 100 ?
>>>> +			S32_MAX : (retval - TUXI_FW_TEMP_OFFSET) * 100;
>>> Same comment as the clamped values above.
>>>
>>> Additionally, please use deci_kelvin_to_millicelsius() from
>>> <linux/units.h> and IMO this should be an standard if-else block.
>>
>> Because of firmware weirdness I can't use deci_kelvin_to_millicelsius: While the 
>> firmware claims to output 10th kelvin it actually outputs only full degrees with 
>> the last number always being 0, that's why I defined the custom 
>> TUXI_FW_TEMP_OFFSET as 2730 instead of 2731.
> 
> Then you can use deci_kelvin_to_millicelsius_with_offset() and provide
> your own offset.
> 
>>
>> I could use deci_kelvin_to_celsius()*MILLIDEGREE_PER_DEGREE, but this would 
> 
> deci_kelvin_to_millicelsius() avoids rounding and makes that
> multiplication unnecessary.
> 
>> introduce an unnecessary rounding step.
>>
>>>
>>>> +		return ret;
>>>> +	default:
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>> +static int hwm_read_string(struct device *dev,
>>>> +			   enum hwmon_sensor_types __always_unused type,
>>>> +			   u32 __always_unused attr, int channel,
>>>> +			   const char **str)
>>>> +{
>>>> +	struct tuxi_hwmon_driver_data_t *driver_data = dev_get_drvdata(dev);
>>>> +
>>>> +	*str = driver_data->fan_types[channel];
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int write_speed(struct device *dev, int channel, u8 val, bool force)
>>>> +{
>>>> +	struct tuxi_hwmon_driver_data_t *driver_data = dev_get_drvdata(dev);
>>>> +	struct acpi_device *pdev = to_acpi_device(dev->parent);
>>>> +	unsigned long long new_speed, params[2];
>>>> +	u8 temp_level;
>>>> +	int ret;
>>>> +
>>>> +	params[0] = channel;
>>>> +
>>>> +	/*
>>>> +	 * The heatpipe across the VRMs is shared between both fans and the VRMs
>>>> +	 * are the most likely to go up in smoke. So it's better to apply the
>>>> +	 * minimum fan speed to all fans if either CPU or GPU is working hard.
>>>> +	 */
>>>> +	temp_level = max_array(driver_data->temp_level, driver_data->fan_count);
>>>> +	if (temp_level)
>>>> +		new_speed = max(val, temp_levels[temp_level - 1].min_speed);
>>>> +	else if (val < TUXI_PWM_FAN_ON_MIN_SPEED / 2)
>>>> +		new_speed = 0;
>>>> +	else if (val < TUXI_PWM_FAN_ON_MIN_SPEED)
>>>> +		new_speed = TUXI_PWM_FAN_ON_MIN_SPEED;
>>>> +	else
>>>> +		new_speed = val;
>>>> +
>>>> +	if (force || new_speed != driver_data->curr_speed[channel]) {
>>>> +		params[0] = channel;
>>>> +		params[1] = new_speed;
>>>> +		ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_SPEED,
>>>> +				       params, 2, NULL);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	}
>>>> +
>>>> +	driver_data->curr_speed[channel] = new_speed;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int hwm_write(struct device *dev,
>>>> +		     enum hwmon_sensor_types __always_unused type, u32 attr,
>>>> +		     int channel, long val)
>>>> +{
>>>> +	struct tuxi_hwmon_driver_data_t *driver_data = dev_get_drvdata(dev);
>>>> +	struct acpi_device *pdev = to_acpi_device(dev->parent);
>>>> +	unsigned long long params[2];
>>>> +	unsigned int i;
>>>> +	int ret;
>>>> +
>>>> +	switch (attr) {
>>>> +	case hwmon_pwm_input:
>>>> +		if (val > U8_MAX || val < 0)
>>>> +			return -EINVAL;
>>> Please, clamp_val() instead.
>> ack
>>>
>>>> +
>>>> +		if (driver_data->pwm_enabled) {
>>> I believe this needs locking to ensure pwm_enabled hasn't changed.
>> ok
>>>
>>>> +			driver_data->want_speed[channel] = val;
>>>> +			return write_speed(dev, channel, val, false);
>>>> +		}
>>>> +
>>>> +		return 0;
>>>> +	case hwmon_pwm_enable:
>>>> +		params[0] = val ? TUXI_TFAN_FAN_MODE_MANUAL :
>>>> +				  TUXI_TFAN_FAN_MODE_AUTO;
>>> Per ABI specification, a value of 0 corresponds to fans at full speed,
>>> not "auto". A value of 2+ corresponds to auto.
>>>
>>> Please, refer to:
>>>
>>> 	https://docs.kernel.org/admin-guide/abi-testing.html#abi-sys-class-hwmon-hwmonx-pwmy-enable
>>>
>>> for more details.
>> Thanks for the link, will fix
>>>
>>>> +		ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_MODE,
>>>> +				       params, 1, NULL);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		driver_data->pwm_enabled = val;
>>>> +
>>>> +		/*
>>>> +		 * Activating PWM sets speed to 0. Alternative design decision
>>>> +		 * could be to keep the current value. This would require proper
>>>> +		 * setting of driver_data->curr_speed for example.
>>>> +		 */
>>>> +		if (val)
>>>> +			for (i = 0; i < driver_data->fan_count; ++i) {
>>>> +				ret = write_speed(dev, i, 0, true);
>>>> +				if (ret)
>>>> +					return ret;
>>>> +			}
>>>> +
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>> +static const struct hwmon_ops hwmops = {
>>> Prefix this struct with "tuxi_"
>> ok
>>>
>>>> +	.is_visible = hwm_is_visible,
>>>> +	.read = hwm_read,
>>>> +	.read_string = hwm_read_string,
>>>> +	.write = hwm_write,
>>>> +};
>>>> +
>>>> +static const struct hwmon_channel_info * const hwmcinfo[] = {
>>> Same as above.
>> ok
>>>
>>>> +	HWMON_CHANNEL_INFO(fan,
>>>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>>>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>>>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>>>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>>>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>>>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>>>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>>>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>>>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>>>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>>>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>>>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>>>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>>>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>>>> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>>>> +			   HWMON_F_INPUT | HWMON_F_LABEL),
>>>> +	HWMON_CHANNEL_INFO(pwm,
>>>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>>>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>>>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>>>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>>>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>>>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>>>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>>>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>>>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>>>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>>>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>>>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>>>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>>>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>>>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>>>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
>>>> +	HWMON_CHANNEL_INFO(temp,
>>>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>>>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>>>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>>>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>>>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>>>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>>>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>>>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>>>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>>>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>>>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>>>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>>>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>>>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>>>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>>>> +			   HWMON_T_INPUT | HWMON_T_LABEL),
>>>> +	NULL
>>>> +};
>>>> +
>>>> +static const struct hwmon_chip_info hwminfo = {
>>> Same as above.
>> ok
>>>
>>>> +	.ops = &hwmops,
>>>> +	.info = hwmcinfo
>>>> +};
>>>> +
>>>> +static u8 tuxi_get_temp_level(struct tuxi_hwmon_driver_data_t *driver_data,
>>>> +			      u8 fan_id, long temp)
>>>> +{
>>>> +	long temp_low, temp_high;
>>>> +	unsigned int i;
>>>> +	int ret;
>>>> +
>>>> +	ret = driver_data->temp_level[fan_id];
>>>> +
>>>> +	for (i = 0; temp_levels[i].temp; ++i) {
>>>> +		temp_low = i == 0 ? S32_MIN : temp_levels[i - 1].temp;
>>>> +		temp_high = temp_levels[i].temp;
>>>> +		if (ret > i)
>>>> +			temp_high -= TUXI_TEMP_LEVEL_HYSTERESIS;
>>>> +
>>>> +		if (temp >= temp_low && temp < temp_high)
>>>> +			return i;
>>>> +	}
>>>> +	if (temp >= temp_high)
>>>> +		ret = i;
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static void tuxi_periodic_hw_safeguard(struct work_struct *work)
>>> I wonder if all of this convoluted logic is really necessary. Why can't
>>> you just force TUXI_TFAN_FAN_MODE_AUTO if a certain limit is surpassed?
>> The auto mode, aka the built in fan curve is way more aggressive than this, and 
>> reaching 80°C is very easy on this device.
> 
> If it's more aggresive, isn't it safer? IMO we should trust FW instead
> of hardcoded values.
> 
>>>
>>> That would mean fewer CPU instructions that are constantly running.
>>>
>>>> +{
>>>> +	struct tuxi_hwmon_driver_data_t *driver_data = container_of(work,
>>>> +								    struct tuxi_hwmon_driver_data_t,
>>>> +								    work.work);
>>>> +	struct device *dev = driver_data->hwmdev;
>>>> +	struct acpi_device *pdev = to_acpi_device(dev->parent);
>>>> +	unsigned long long params[2], retval;
>>>> +	unsigned int i;
>>>> +	long temp;
>>>> +	int ret;
>>>> +
>>>> +	for (i = 0; i < driver_data->fan_count; ++i) {
>>>> +		params[0] = i;
>>>> +		ret = tuxi_tfan_method(pdev,
>>>> +				       TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
>>>> +				       params, 1, &retval);
>>>> +		/*
>>>> +		 * If reading the temperature fails, default to a high value to
>>>> +		 * be on the safe side in the worst case.
>>>> +		 */
>>>> +		if (ret)
>>>> +			retval = TUXI_FW_TEMP_OFFSET + 1200;
>>>> +
>>>> +		temp = retval > S32_MAX / 100 ?
>>>> +			S32_MAX : (retval - TUXI_FW_TEMP_OFFSET) * 100;
>>>> +
>>>> +		driver_data->temp_level[i] = tuxi_get_temp_level(driver_data, i,
>>>> +								 temp);
>>>> +	}
>>>> +
>>>> +	// Reapply want_speeds to respect eventual new temp_levels
>>>> +	for (i = 0; i < driver_data->fan_count; ++i)
>>>> +		write_speed(dev, i, driver_data->want_speed[i], false);
>>>> +
>>>> +	schedule_delayed_work(&driver_data->work, TUXI_SAFEGUARD_PERIOD);
>>>> +}
>>>> +
>>>> +static int tuxi_hwmon_add_devices(struct acpi_device *pdev, struct device **hwmdev)
>>>> +{
>>>> +	struct tuxi_hwmon_driver_data_t *driver_data;
>>>> +	unsigned long long params[2], retval;
>>>> +	unsigned int i;
>>>> +	int ret;
>>>> +
>>>> +	/*
>>>> +	 * The first version of TUXI TFAN didn't have the Get Fan Temperature
>>>> +	 * method which is integral to this driver. So probe for existence and
>>>> +	 * abort otherwise.
>>>> +	 *
>>>> +	 * The Get Fan Speed method is also missing in that version, but was
>>>> +	 * added in the same version so it doesn't have to be probe separately.
>>>> +	 */
>>>> +	params[0] = 0;
>>>> +	ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
>>>> +			       params, 1, &retval);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	driver_data = devm_kzalloc(&pdev->dev, sizeof(*driver_data), GFP_KERNEL);
>>>> +	if (!driver_data)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	/*
>>>> +	 * Loading this module sets the fan mode to auto. Alternative design
>>>> +	 * decision could be to keep the current value. This would require
>>>> +	 * proper initialization of driver_data->curr_speed for example.
>>>> +	 */
>>>> +	params[0] = TUXI_TFAN_FAN_MODE_AUTO;
>>>> +	ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_MODE, params, 1,
>>>> +			       NULL);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_COUNT, NULL, 0,
>>>> +			       &retval);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +	if (retval > TUXI_MAX_FAN_COUNT)
>>>> +		return -EINVAL;
>>>> +	driver_data->fan_count = retval;
>>>> +
>>>> +	for (i = 0; i < driver_data->fan_count; ++i) {
>>>> +		params[0] = i;
>>>> +		ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_TYPE,
>>>> +				       params, 1, &retval);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +		if (retval >= ARRAY_SIZE(tuxi_fan_type_labels))
>>>> +			return -EOPNOTSUPP;
>>>> +		driver_data->fan_types[i] = tuxi_fan_type_labels[retval];
>>>> +	}
>>>> +
>>>> +	*hwmdev = devm_hwmon_device_register_with_info(&pdev->dev,
>>>> +						       "tuxedo_nbxx_acpi_tuxi",
>>>> +						       driver_data, &hwminfo,
>>>> +						       NULL);
>>>> +	if (IS_ERR(*hwmdev))
>>>> +		return PTR_ERR(*hwmdev);
>>>> +
>>>> +	driver_data->hwmdev = *hwmdev;
>>>> +
>>>> +	INIT_DELAYED_WORK(&driver_data->work, tuxi_periodic_hw_safeguard);
>>>> +	schedule_delayed_work(&driver_data->work, TUXI_SAFEGUARD_PERIOD);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void tuxi_hwmon_remove_devices(struct device *hwmdev)
>>>> +{
>>>> +	struct tuxi_hwmon_driver_data_t *driver_data = dev_get_drvdata(hwmdev);
>>>> +	struct acpi_device *pdev = to_acpi_device(hwmdev->parent);
>>>> +	unsigned long long params[2];
>>>> +
>>>> +	cancel_delayed_work_sync(&driver_data->work);
>>>> +
>>>> +	params[0] = TUXI_TFAN_FAN_MODE_AUTO;
>>>> +	tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_MODE, params, 1, NULL);
>>>> +}
>>>> +
>>>> +static int tuxi_add(struct acpi_device *device)
>>>> +{
>>>> +	struct tuxi_driver_data_t *driver_data;
>>>> +	acpi_status status;
>>>> +
>>>> +	driver_data = devm_kzalloc(&device->dev, sizeof(*driver_data),
>>>> +				   GFP_KERNEL);
>>>> +	if (!driver_data)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	// Find subdevices
>>>> +	status = acpi_get_handle(device->handle, "TFAN",
>>>> +				 &driver_data->tfan_handle);
>>>> +	if (ACPI_FAILURE(status))
>>>> +		return_ACPI_STATUS(status);
>>>> +
>>>> +	dev_set_drvdata(&device->dev, driver_data);
>>>> +
>>>> +	return tuxi_hwmon_add_devices(device, &driver_data->hwmdev);
>>>> +}
>>>> +
>>>> +static void tuxi_remove(struct acpi_device *device)
>>>> +{
>>>> +	struct tuxi_driver_data_t *driver_data = dev_get_drvdata(&device->dev);
>>>> +
>>>> +	tuxi_hwmon_remove_devices(driver_data->hwmdev);
>>>> +}
>>>> +
>>>> +static struct acpi_driver acpi_driver = {
>>> AFAIK platform drivers are *strongly* preferred over acpi drivers. You
>>> should use that instead.
>>
>> Sorry, first time reading this. Can change it ofc, but is there a specific reason?
> 
> I'm not really sure. But while samsung-galaxybook was in review, I
> believe this was requested by Hans and Armin.
> 
> Hopefully they can elaborate on this.
> 

Hi! In case it helps I think most of the rationale behind this can be found in
the docs:

https://docs.kernel.org/firmware-guide/acpi/enumeration.html#acpi-device-objects

In the case of samsung-galaxybook the issue was that I was originally creating
new devices in the driver which were not necessary; both the ACPI device and its
corresponding platform device had already been created by the ACPI Core as per
the documentation referenced above, it is just a matter of matching and fetching
them in the right way.

I do think in general if the idea is that this Tuxedo platform driver would
eventually include more "platform stuff" that it feels more natural to hang    
everything from a platform device instead of a specific ACPI device (on top of/
presumably some of what the rationale in the documentation is based on).

If it is currently and only will ever be a hwmon device then I suppose one
could even argue that this driver belongs under drivers/hwmon instead :) But it
seems as though the intention is that there will or could be other things added?

Just out of curiosity what is the significance of "NBxx"? Is it something that
will add value (and should remain in the path as well as various descriptions) 
or would it make sense that anything falling under drivers/platform/x86/tuxedo   
will always be "NBxx" without needing to state it again (e.g. will there be      
other Tuxedo x86 Platform Drivers that are not "NBxx")?

Hope this helps!

Best regards,
Joshua


