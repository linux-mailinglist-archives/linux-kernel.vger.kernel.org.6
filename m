Return-Path: <linux-kernel+bounces-254160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B02F932FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729551F21EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E131A01B3;
	Tue, 16 Jul 2024 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga34Jj+f"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671721F171;
	Tue, 16 Jul 2024 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153073; cv=none; b=PWh7EoeD30HzPD2pMKviViZRKwqjaHPPqHf/rnYM9cCkCZQPfPUGaM/4qmahGeg0ujEyCaK4ggziSWORBc1UB4wosvir8pX9phdM5eD4T0TQMe9zFV/aih9eY5E9/Q72peV8okZqHyQ3UP2dAEMkUyQpxZhkkxk86p7pCZCqIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153073; c=relaxed/simple;
	bh=XiDqPMMWrzAW46UdbMc+48s32/Q+r9dM0WbAu12jQrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJMEJu+43WJXG923PolDm/pWlFH1vDKK5SGycWvxOfGPQZyBfqogJYqhIgj04u81h/VKbVIMUTbCbyGj2S4MDH7Z9+3nPVKCE3GHAK5j5x/jfYKs8+ElQkoIAFPc7BfcIvgKNMu7JjZloxeyEna1dqvSoHncBq3uq9PB6ZdN060=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ga34Jj+f; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7163489149eso4250831a12.1;
        Tue, 16 Jul 2024 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721153070; x=1721757870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GBCFaWSR+M/5B7KKasC61AI4aXYtOQpHAQShz3FGaMs=;
        b=Ga34Jj+fAgLrVK3C4wjiGotCXVSnIB/CFF0FCb4qy3q38rn8eO8vwoHmaSvOe+980U
         XfsVN3jsCFIMJ6iaV0tWMB+CylU0PiReo6EbLE2sPDOrb/SQtneikY+M1Lp/2qwpEWQU
         4rrd8d9HhRNgBKfbZQgB57RxeNs25Eg4Rg1IPaqFvcEhXIHKBdCeMeXKlEUJwwpLt9tI
         XIbr5jLFzGmYIb0SuAe02tm1usrKimcC3xAANBrtEx22CKr/W5QBV4ILYIggmfEg3Zxd
         46YO49bkinC/YCUvBfQMeuyHuEmLzFphYtoTYkEvWAHvuRTW8bIJae//Sh8vYAcRqzxI
         H0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721153070; x=1721757870;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBCFaWSR+M/5B7KKasC61AI4aXYtOQpHAQShz3FGaMs=;
        b=PrN60yo5uUmIJHf9dhEEcsHl+yZG/dI3RnYfYWt7u0JAV0M+AzmAIaShbjvzEUg5+6
         f3de900oV53UbT7NAxZWIhXtgMXHhRZfEt0fYs6J/bNyDY3sM2l1uvxyobZME/i5ECfG
         1Ymc73SaeOCbFawP3LtrTxe/AXLeoDaSgQ+R7Dg0PX5WhngBjHIZZwz3Qv+9hyLdHSve
         ySBkn74A7Mf4S3hmJLAaXcgDQ3/aR6q0Opm3/ieACP4PsTdoiKw2R6I85RedYjcK/9AJ
         vUCCJog+C5Dg3CGn3kj3qiVGHmskuA8CTiVQ0kStXfxRHc8y+4P899Zlp+pav/xFS/tB
         fnag==
X-Forwarded-Encrypted: i=1; AJvYcCUWW32giyjOHh/GMYgwin9ukwJ3V6gWmuU5o+9La9aCOfpsxZu+ZFlMESS2WZcjeKHhBX4dIUIuF+AzIuJ8aZoIDBL/7jeYhpyK6/preZzwJhw+OIiOv2Q6T6fRE1VnoGwINeHfbmM=
X-Gm-Message-State: AOJu0Yx8RYN6cb91xaj/dPafil8aPzCLAWuXRRwTQJSD4Hz2GMw8Etz6
	MFYITaEgw3NfyqfLTSuF7m8cqx3MLuaI5dQg6w8D5fZwx7Ua7fGR
X-Google-Smtp-Source: AGHT+IEeqziO5e7McP/+kPWsWSaU4gPW7jNLjA3aZnIxlQ6tr6iYK/4/IfGUJZkq+54MyCfVMKHJSQ==
X-Received: by 2002:a05:6a21:30cc:b0:1c2:8cc4:9084 with SMTP id adf61e73a8af0-1c3f1256e65mr2853209637.34.1721153069348;
        Tue, 16 Jul 2024 11:04:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7e103sm6623358b3a.132.2024.07.16.11.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 11:04:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <deca2345-0961-4d3a-9ab4-8d11c7d240f2@roeck-us.net>
Date: Tue, 16 Jul 2024 11:04:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: add GPD devices sensor driver
To: Cryolitia@gmail.com, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 =?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>
References: <20240717-gpd_fan-v2-0-f7b7e6b9f21b@gmail.com>
 <20240717-gpd_fan-v2-1-f7b7e6b9f21b@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240717-gpd_fan-v2-1-f7b7e6b9f21b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/16/24 09:58, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <Cryolitia@gmail.com>
> 
> Sensors driver for GPD Handhelds that expose fan reading and control via
> hwmon sysfs.
> 
> Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
> devices. This driver implements these functions through x86 port-mapped IO.
> I have tested it on my device.
> 
> Tested-by: Marcin Strągowski <marcin@stragowski.com>
> Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
> ---
>   MAINTAINERS             |   6 +
>   drivers/hwmon/Kconfig   |  10 +
>   drivers/hwmon/Makefile  |   1 +
>   drivers/hwmon/gpd-fan.c | 759 ++++++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 776 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af4b4c271342..9ced72cec42b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9372,6 +9372,12 @@ F:	drivers/phy/samsung/phy-gs101-ufs.c
>   F:	include/dt-bindings/clock/google,gs101.h
>   K:	[gG]oogle.?[tT]ensor
>   
> +GPD FAN DRIVER
> +M:	Cryolitia PukNgae <Cryolitia@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hwmon/gpd-fan.c
> +
>   GPD POCKET FAN DRIVER
>   M:	Hans de Goede <hdegoede@redhat.com>
>   L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index b60fe2e58ad6..368165a25979 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -727,6 +727,16 @@ config SENSORS_GL520SM
>   	  This driver can also be built as a module. If so, the module
>   	  will be called gl520sm.
>   
> +config SENSORS_GPD
> +	tristate "GPD EC fan control"
> +	depends on X86
> +	help
> +	  If you say yes here you get support for fan readings and
> +	  control over GPD handheld devices.
> +
> +	  Can also be built as a module. In that case it will be
> +	  called gpd-fan.
> +
>   config SENSORS_G760A
>   	tristate "GMT G760A"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b1c7056c37db..91c288451290 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_SENSORS_GIGABYTE_WATERFORCE) += gigabyte_waterforce.o
>   obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
>   obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
>   obj-$(CONFIG_SENSORS_GSC)	+= gsc-hwmon.o
> +obj-$(CONFIG_SENSORS_GPD)	+= gpd-fan.o
>   obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
>   obj-$(CONFIG_SENSORS_GXP_FAN_CTRL) += gxp-fan-ctrl.o
>   obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
> diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
> new file mode 100644
> index 000000000000..b7e7e73528af
> --- /dev/null
> +++ b/drivers/hwmon/gpd-fan.c
> @@ -0,0 +1,759 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/acpi.h>
> +#include <linux/debugfs.h>
> +#include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>

I do not see why this include would be necessary.

> +#include <linux/ioport.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define DRIVER_NAME "gpdfan"
> +
> +static char *gpd_fan_model = "";
> +module_param(gpd_fan_model, charp, 0444);
> +
> +static DEFINE_MUTEX(gpd_fan_locker);
> +
> +enum FUN_PWM_ENABLE {
> +	DISABLE = 0,
> +	MANUAL = 1,
> +	AUTOMATIC = 2,
> +};
> +
> +struct driver_private_data {
> +	enum FUN_PWM_ENABLE pwm_enable;
> +	u8 pwm_value;
> +
> +	u16 fan_speed_cached;
> +	u8 read_pwm_cached;
> +
> +	// minimum 1000 mill seconds
> +	u32 update_interval_per_second;

The update_interval sysfs attribte is expected to be passed to and handled by the chip.
It is not intended to provide a cache timeout to the driver. As used,
this attribute is unacceptable. I would suggest to either drop caching in the driver,
or, if the chip needs a timeout between accesses, to use a constant.

> +
> +	unsigned long fan_speed_last_update;
> +	unsigned long read_pwm_last_update;
> +
> +	const struct model_quirk *const quirk;
> +};
> +
> +struct model_ec_address {
> +	const u8 addr_port;
> +	const u8 data_port;
> +	const u16 manual_control_enable;
> +	const u16 rpm_read;
> +	const u16 pwm_write;
> +	const u16 pwm_max;
> +};
> +
> +struct model_quirk {
> +	const char *model_name;
> +
> +	bool tested;
> +
> +	const struct model_ec_address address;
> +
> +	int (*const read_rpm)(struct driver_private_data *, u16 *);
> +
> +	int (*const set_pwm_enable)(struct driver_private_data *,
> +				    enum FUN_PWM_ENABLE);
> +
> +	int (*const read_pwm)(struct driver_private_data *, u8 *);
> +
> +	int (*const write_pwm)(const struct driver_private_data *, u8);
> +};
> +
> +static int gpd_ecram_read(const struct model_ec_address *const address,
> +			  const u16 offset, u8 *const val)
> +{
> +	int ret = mutex_lock_interruptible(&gpd_fan_locker);
> +
> +	if (ret)
> +		return ret;
> +
> +	u16 addr_port = address->addr_port;
> +	u16 data_port = address->data_port;
> +
> +	outb(0x2E, addr_port);
> +	outb(0x11, data_port);
> +	outb(0x2F, addr_port);
> +	outb((u8)((offset >> 8) & 0xFF), data_port);
> +
> +	outb(0x2E, addr_port);
> +	outb(0x10, data_port);
> +	outb(0x2F, addr_port);
> +	outb((u8)(offset & 0xFF), data_port);
> +
> +	outb(0x2E, addr_port);
> +	outb(0x12, data_port);
> +	outb(0x2F, addr_port);
> +	*val = inb(data_port);
> +
> +	mutex_unlock(&gpd_fan_locker);
> +	return 0;
> +}
> +
> +static int gpd_ecram_write(const struct model_ec_address *const address,
> +			   const u16 offset, const u8 value)
> +{
> +	int ret = mutex_lock_interruptible(&gpd_fan_locker);
> +
> +	if (ret)
> +		return ret;
> +
> +	u16 addr_port = address->addr_port;
> +	u16 data_port = address->data_port;
> +
> +	outb(0x2E, addr_port);
> +	outb(0x11, data_port);
> +	outb(0x2F, addr_port);
> +	outb((u8)((offset >> 8) & 0xFF), data_port);
> +
> +	outb(0x2E, addr_port);
> +	outb(0x10, data_port);
> +	outb(0x2F, addr_port);
> +	outb((u8)(offset & 0xFF), data_port);
> +
> +	outb(0x2E, addr_port);
> +	outb(0x12, data_port);
> +	outb(0x2F, addr_port);
> +	outb(value, data_port);
> +
> +	mutex_unlock(&gpd_fan_locker);
> +	return 0;
> +}
> +
> +#define DEFINE_GPD_READ_CACHED(name, type)                                    \
> +	static int gpd_read_cached_##name(                                    \
> +		struct driver_private_data *const data,                       \
> +		int (*read_uncached)(const struct driver_private_data *,      \
> +				     type *))                                 \
> +	{                                                                     \
> +		if (time_after(                                               \
> +			    jiffies,                                          \
> +			    data->name##_last_update +                        \
> +				    HZ * data->update_interval_per_second)) { \
> +			type var;                                             \
> +			int ret = read_uncached(data, &var);                  \
> +			if (ret)                                              \
> +				return ret;                                   \
> +			data->name##_cached = var;                            \
> +			data->name##_last_update = jiffies;                   \
> +		}                                                             \
> +		return 0;                                                     \
> +	}
> +

The use of a function macro, combined with passing yet another function to it.
makes it all but impossible to review this driver. I would strongly suggest to rewrite
it to avoid this macro.

> +DEFINE_GPD_READ_CACHED(fan_speed, u16);
> +DEFINE_GPD_READ_CACHED(read_pwm, u8);
> +
> +static int gpd_read_rpm_uncached(const struct driver_private_data *const data,
> +				 u16 *const val)
> +{
> +	u8 high, low;
> +	int ret;
> +	const struct model_ec_address *const address = &data->quirk->address;
> +
> +	ret = gpd_ecram_read(address, address->rpm_read, &high);
> +	if (ret)
> +		return ret;
> +	ret = gpd_ecram_read(address, address->rpm_read + 1, &low);
> +	if (ret)
> +		return ret;
> +
> +	*val = high << 8 | low;
> +	return 0;
> +}
> +
> +static int gpd_read_rpm(struct driver_private_data *const data, u16 *const val)
> +{
> +	int ret = gpd_read_cached_fan_speed(data, gpd_read_rpm_uncached);
> +	*val = data->fan_speed_cached;
> +	return ret;
> +}
> +
> +static int gpd_read_pwm(struct driver_private_data *const data, u8 *const val)
> +{
> +	*val = data->pwm_value;
> +	return 0;
> +}
> +
> +static int gpd_write_pwm(const struct driver_private_data *const data,
> +			 const u8 val)
> +{
> +	const struct model_ec_address *const address = &data->quirk->address;
> +
> +	u8 actual = val * (address->pwm_max - 1) / 255 + 1;
> +
> +	return gpd_ecram_write(address, address->pwm_write, actual);
> +}
> +
> +static int gpd_win_mini_set_pwm_enable(struct driver_private_data *const data,
> +				       const enum FUN_PWM_ENABLE pwm_enable)
> +{
> +	switch (pwm_enable) {
> +	case DISABLE:
> +		return gpd_write_pwm(data, 255);
> +	case MANUAL:
> +		return gpd_write_pwm(data, data->pwm_value);
> +	case AUTOMATIC:
> +		return gpd_write_pwm(data, 0);
> +	}
> +	return 0;
> +}
> +
> +static int gpd_win_mini_write_pwm(const struct driver_private_data *const data,
> +				  const u8 val)
> +{
> +	if (data->pwm_enable == MANUAL)
> +		return gpd_write_pwm(data, val);
> +	return 0;
> +}
> +
> +static const struct model_quirk gpd_win_mini_quirk = {
> +	.model_name = "win_mini",
> +	.tested = false,
> +	.address = {
> +		.addr_port = 0x4E,
> +		.data_port = 0x4F,
> +		.manual_control_enable = 0x047A,
> +		.rpm_read = 0x0478,
> +		.pwm_write = 0x047A,
> +		.pwm_max = 244,
> +	},
> +	.read_rpm = gpd_read_rpm,
> +	.set_pwm_enable = gpd_win_mini_set_pwm_enable,
> +	.read_pwm = gpd_read_pwm,
> +	.write_pwm = gpd_win_mini_write_pwm,
> +};
> +
> +static int
> +gpd_win4_read_rpm_uncached(const struct driver_private_data *const data,
> +			   u16 *const val)
> +{
> +	const struct model_ec_address *const address = &data->quirk->address;
> +	u8 PWMCTR;
> +
> +	gpd_ecram_read(address, 0x1841, &PWMCTR);
> +	if (PWMCTR != 0x7F)
> +		gpd_ecram_write(address, 0x1841, 0x7F);
> +
> +	int ret = gpd_read_rpm_uncached(data, val);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (*val == 0) {
> +		//re-init EC
> +		u8 chip_id;
> +
> +		gpd_ecram_read(address, 0x2000, &chip_id);
> +		if (chip_id == 0x55) {
> +			u8 chip_ver;
> +
> +			if (gpd_ecram_read(address, 0x1060, &chip_ver)) {
> +				gpd_ecram_write(address, 0x1060,
> +						chip_ver | 0x80);
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int gpd_win4_read_rpm(struct driver_private_data *const data,
> +			     u16 *const val)
> +{
> +	int ret = gpd_read_cached_fan_speed(data, gpd_win4_read_rpm_uncached);
> +
> +	*val = data->fan_speed_cached;
> +	return ret;
> +}
> +
> +static const struct model_quirk gpd_win4_quirk = {
> +	.model_name = "win4",
> +	.tested = false,
> +	.address = {
> +		.addr_port = 0x2E,
> +		.data_port = 0x2F,
> +		.manual_control_enable = 0xC311,
> +		.rpm_read = 0xC880,
> +		.pwm_write = 0xC311,
> +		.pwm_max = 127,
> +	},
> +	.read_rpm = gpd_win4_read_rpm,
> +	// same as GPD Win Mini
> +	.set_pwm_enable = gpd_win_mini_set_pwm_enable,
> +	.read_pwm = gpd_read_pwm,
> +	// same as GPD Win Mini
> +	.write_pwm = gpd_win_mini_write_pwm,
> +};
> +
> +static int
> +gpd_wm2_read_rpm_uncached(const struct driver_private_data *const data,
> +			  u16 *const val)
> +{
> +	const struct model_ec_address *const address = &data->quirk->address;
> +
> +	for (u16 pwm_ctr_offset = 0x1841; pwm_ctr_offset <= 0x1843;
> +		 pwm_ctr_offset++) {
> +		u8 PWMCTR;
> +
> +		gpd_ecram_read(address, pwm_ctr_offset, &PWMCTR);
> +		if (PWMCTR != 0xB8)
> +			gpd_ecram_write(address, pwm_ctr_offset, 0xB8);
> +	}
> +	return gpd_read_rpm_uncached(data, val);
> +}
> +
> +static int gpd_wm2_read_rpm(struct driver_private_data *const data,
> +			    u16 *const val)
> +{
> +	int ret = gpd_read_cached_fan_speed(data, gpd_wm2_read_rpm_uncached);
> +	*val = data->fan_speed_cached;
> +	return ret;
> +}
> +
> +static int
> +gpd_wm2_read_pwm_uncached(const struct driver_private_data *const data,
> +			  u8 *const val)
> +{
> +	const struct model_ec_address *const address = &data->quirk->address;
> +	u8 var;
> +
> +	int ret = gpd_ecram_read(address, address->pwm_write, &var);
> +
> +	*val = var * 255 / address->pwm_max;
> +
> +	return ret;
> +}
> +
> +static int gpd_wm2_read_pwm(struct driver_private_data *const data,
> +			    u8 *const val)
> +{
> +	int ret = gpd_read_cached_read_pwm(data, gpd_wm2_read_pwm_uncached);
> +	*val = data->read_pwm_cached;
> +	return ret;
> +}
> +
> +static int gpd_wm2_set_pwm_enable(struct driver_private_data *const data,
> +				  const enum FUN_PWM_ENABLE enable)
> +{
> +	const struct model_ec_address *const address = &data->quirk->address;
> +
> +	switch (enable) {
> +	case DISABLE: {
> +		int ret = gpd_write_pwm(data, 255);
> +
> +		if (ret)
> +			return ret;
> +
> +		return gpd_ecram_write(address, address->manual_control_enable,
> +				       1);
> +	}
> +	case MANUAL: {
> +		int ret = gpd_write_pwm(data, data->pwm_value);
> +
> +		if (ret)
> +			return ret;
> +
> +		return gpd_ecram_write(address, address->manual_control_enable,
> +				       1);
> +	}
> +	case AUTOMATIC: {
> +		int ret = gpd_ecram_write(address,
> +					  address->manual_control_enable, 0);
> +
> +		// Immediately refresh the PWM value
> +		gpd_read_cached_read_pwm(data, gpd_wm2_read_pwm_uncached);
> +
> +		return ret;
> +	}
> +	}
> +	return 0;
> +}
> +
> +static int gpd_wm2_write_pwm(const struct driver_private_data *const data,
> +			     const u8 val)
> +{
> +	if (data->pwm_enable != DISABLE)
> +		return gpd_write_pwm(data, val);
> +
> +	return 0;
> +}
> +
> +static const struct model_quirk gpd_wm2_quirk = {
> +	.model_name = "wm2",
> +	.tested = true,
> +	.address = {
> +		.addr_port = 0x4E,
> +		.data_port = 0x4F,
> +		.manual_control_enable = 0x0275,
> +		.rpm_read = 0x0218,
> +		.pwm_write = 0x1809,
> +		.pwm_max = 184,
> +	},
> +	.read_rpm = gpd_wm2_read_rpm,
> +	.set_pwm_enable = gpd_wm2_set_pwm_enable,
> +	.read_pwm = gpd_wm2_read_pwm,
> +	.write_pwm = gpd_wm2_write_pwm,
> +};
> +
> +static const struct dmi_system_id gpd_devices[] = {
> +	{
> +		// GPD Win Mini
> +		// GPD Win Mini with AMD Ryzen 8840U
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "G1617-01")
> +		},
> +		.driver_data = (void *) &gpd_win_mini_quirk,

A typecast of a pointer to a void * is unnecessary.

> +	},
> +	{
> +		// GPD Win 4 with AMD Ryzen 6800U
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "G1618-04"),
> +			DMI_MATCH(DMI_BOARD_VERSION, "Default string"),
> +		},
> +		.driver_data = (void *) &gpd_win4_quirk,
> +	},
> +	{
> +		// GPD Win 4 with Ryzen 7840U
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "G1618-04"),
> +			DMI_MATCH(DMI_BOARD_VERSION, "Ver. 1.0"),
> +		},
> +		.driver_data = (void *) &gpd_wm2_quirk,
> +	},
> +	{
> +		// GPD Win Max 2 with Ryzen 6800U
> +		// GPD Win Max 2 2023 with Ryzen 7840U
> +		// GPD Win Max 2 2024 with Ryzen 8840U
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "G1619-04"),
> +		},
> +		.driver_data = (void *) &gpd_wm2_quirk,


> +	},
> +	{}
> +};
> +
> +static const struct model_quirk *gpd_module_quirks[] = { &gpd_win_mini_quirk,
> +							 &gpd_win4_quirk,
> +							 &gpd_wm2_quirk, NULL };
> +
> +static umode_t gpd_fan_hwmon_is_visible(__always_unused
> +					const void *drvdata,
> +					enum hwmon_sensor_types type, u32 attr,
> +					__always_unused int channel)
> +{
> +	if (type == hwmon_fan && attr == hwmon_fan_input) {
> +		return 0444;
> +	} else if (type == hwmon_pwm) {
> +		switch (attr) {
> +		case hwmon_pwm_mode:
> +			return 0444;
> +		case hwmon_pwm_enable:
> +		case hwmon_pwm_input:
> +			return 0644;

Just like elsewhere, default: is missing.

> +		}
> +	} else if (type == hwmon_chip && attr == hwmon_chip_update_interval) {
> +		return 0644;
> +	}
> +	return 0;
> +}
> +
> +static int gpd_fan_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			      u32 attr, __always_unused int channel,
> +			      long *val)
> +{
> +	struct driver_private_data *data = dev_get_drvdata(dev);
> +
> +	if (type == hwmon_fan) {
> +		switch (attr) {
> +		case hwmon_fan_input: {
> +			u16 var;
> +			int ret = data->quirk->read_rpm(data, &var);
> +
> +			*val = var;
> +			return ret;
> +		}
> +		}
> +	} else if (type == hwmon_pwm) {
> +		switch (attr) {
> +		case hwmon_pwm_mode:
> +			*val = 1;
> +			return 0;

Unnecessary attribute. If the mode is always 1 there is no need for it.

Please do not provide any attributes with fixed values (and, no,
other drivers doing that is not an argument).

> +		case hwmon_pwm_enable:
> +			*val = data->pwm_enable;
> +			return 0;
> +		case hwmon_pwm_input: {
> +			u8 var;
> +			int ret = data->quirk->read_pwm(data, &var);

I don't know why this was dropped in checkpatch, but please keep an empty line
between variable declarations and their use.

> +			*val = var;

Do not assign (random) return values if the function returned
an error. This needs to be something like

			if (ret)
				return ret;
			*val = var;
			return 0;

On a side note, separating the return value from the actual data value is unnecessary.
Something like
			ret = data->quirk->read_pwm(daat);
			if (ret < 0)
				return ret;
			*val = ret;
would generate more efficient code and would be easier to read.

> +			return ret;
> +		}
> +		}

Those double { } just to keep variable declarations local make the
code more difficult to read and review and serve no other real purpose.

> +	} else if (type == hwmon_chip) {
> +		switch (attr) {
> +		case hwmon_chip_update_interval:
> +			*val = 1000 * data->update_interval_per_second;
> +			return 0;

default: missing, which will be a field case for static analyzers.

> +		}
> +	}
> +	return -EINVAL;

EINVAL = Invalid Argument. This is appropriate if an invalid argument was provided,
not if for whatever reason the driver has an internal bug and requests a write which
is not supported. This should be -EOPNOTSUPP.

> +}
> +
> +static int gpd_fan_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
> +			       u32 attr, __always_unused int channel,
> +			       long val)
> +{
> +	struct driver_private_data *data = dev_get_drvdata(dev);
> +
> +	if (type == hwmon_pwm) {
> +		switch (attr) {
> +		case hwmon_pwm_enable:
> +			if (!in_range(val, 0, 3))
> +				return -EINVAL;
> +			data->pwm_enable = val;
> +			return data->quirk->set_pwm_enable(data,
> +							   data->pwm_enable);
> +		case hwmon_pwm_input: {
> +			u8 var = clamp_val(val, 0, 255);
> +
> +			data->pwm_value = var;
> +			return data->quirk->write_pwm(data, var);
> +		}
> +		}
> +	} else if (type == hwmon_chip) {
> +		if (attr == hwmon_chip_update_interval) {
> +			int interval = val / 1000;
> +
> +			if (interval < 1)
> +				interval = 1;
> +			data->update_interval_per_second = interval;
> +			return 0;
> +		}
> +	}
> +	return -EINVAL;

This is a read function. They can not have an invalid argument.
Use -EOPNOTSUPP.

> +}
> +
> +static const struct hwmon_ops gpd_fan_ops = {
> +	.is_visible = gpd_fan_hwmon_is_visible,
> +	.read = gpd_fan_hwmon_read,
> +	.write = gpd_fan_hwmon_write,
> +};
> +
> +static const struct hwmon_channel_info *gpd_fan_hwmon_channel_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_MODE),
> +	NULL
> +};
> +
> +static struct hwmon_chip_info gpd_fan_chip_info = {
> +	.ops = &gpd_fan_ops,
> +	.info = gpd_fan_hwmon_channel_info
> +};
> +
> +struct dentry *DEBUG_FS_ENTRY;
> +

static, and please do not use CAPITAL letters for variable names.

> +static int debugfs_manual_control_get(void *data, u64 *val)
> +{
> +	struct model_ec_address *address = data;
> +	u8 u8_val;
> +
> +	int ret = gpd_ecram_read(address, address->manual_control_enable,
> +				 &u8_val);
> +	*val = (u64)u8_val;
> +	return ret;
> +}
> +
> +static int debugfs_manual_control_set(void *data, u64 val)
> +{
> +	struct model_ec_address *address = data;
> +
> +	return gpd_ecram_write(address, address->manual_control_enable,
> +			       clamp_val(val, 0, 255));
> +}
> +
> +static int debugfs_pwm_get(void *data, u64 *val)
> +{
> +	struct model_ec_address *address = data;
> +	u8 u8_val;
> +	int ret = gpd_ecram_read(address, address->pwm_write, &u8_val);
> +
> +	*val = (u64)u8_val;
> +	return ret;
> +}
> +
> +static int debugfs_pwm_set(void *data, u64 val)
> +{
> +	struct model_ec_address *address = data;
> +
> +	return gpd_ecram_write(address, address->pwm_write,
> +			       clamp_val(val, 0, 255));
> +}
> +
Those debugfs attributes are undocumented and unacceptable.
Besides, there is already a standard attribute for the pwm value,
and duplicating it with debugfs does not even make sense.


> +DEFINE_DEBUGFS_ATTRIBUTE(debugfs_manual_control_fops,
> +			 debugfs_manual_control_get, debugfs_manual_control_set,
> +			 "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(debugfs_pwm_fops, debugfs_pwm_get, debugfs_pwm_set,
> +			 "%llu\n");
> +
> +static int gpd_fan_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct driver_private_data *data;
> +
> +	data = dev_get_platdata(&pdev->dev);
> +	if (IS_ERR_OR_NULL(data))
> +		return -ENODEV;
> +
> +	const struct resource *plat_res =
> +		platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (IS_ERR_OR_NULL(plat_res)) {
> +		pr_warn("Failed to get platform resource\n");
> +		return -ENODEV;
> +	}
> +
> +	const struct resource *region_res = devm_request_region(
> +		dev, plat_res->start, resource_size(plat_res), DRIVER_NAME);
> +	if (IS_ERR_OR_NULL(region_res)) {
> +		pr_warn("Failed to request region\n");
> +		return -EBUSY;
> +	}
> +
> +	const struct device *dev_reg = devm_hwmon_device_register_with_info(
> +		dev, DRIVER_NAME, data, &gpd_fan_chip_info, NULL);
> +	if (IS_ERR_OR_NULL(dev_reg)) {
> +		pr_warn("Failed to register hwmon device\n");
> +		return -EBUSY;
> +	}
> +
> +	struct dentry *debug_fs_entry = debugfs_create_dir(DRIVER_NAME, NULL);
> +
> +	if (!IS_ERR(debug_fs_entry)) {

This error check is unnecessary, as is the local variable.

> +		DEBUG_FS_ENTRY = debug_fs_entry;
> +		debugfs_create_file_size("manual_control_reg",
> +					 0600, DEBUG_FS_ENTRY,
> +					 (void *)&data->quirk->address,

Unnecessary typecast.

Why use debugfs_create_file_size() instead of debugfs_create_file() ?

> +					 &debugfs_manual_control_fops,
> +					 sizeof(u8));
> +		debugfs_create_file_size("pwm_reg", 0600,
> +					 DEBUG_FS_ENTRY,
> +					 (void *)&data->quirk->address,

unnecessary typecast

> +					 &debugfs_pwm_fops, sizeof(u8));
> +	}
> +
> +	pr_debug("GPD Devices fan driver probed\n");
> +	return 0;
> +}
> +
> +static int gpd_fan_remove(__always_unused struct platform_device *pdev)
> +{
> +	struct driver_private_data *data = dev_get_platdata(&pdev->dev);
> +
> +	data->pwm_enable = AUTOMATIC;
> +	data->quirk->set_pwm_enable(data, AUTOMATIC);
> +
> +	if (!IS_ERR_OR_NULL(DEBUG_FS_ENTRY)) {
> +		debugfs_remove_recursive(DEBUG_FS_ENTRY);
> +		DEBUG_FS_ENTRY = NULL;
> +	}
> +
> +	pr_debug("GPD Devices fan driver removed\n");
> +	return 0;
> +}
> +
> +static struct platform_driver gpd_fan_driver = {
> +	.probe = gpd_fan_probe,
> +	.remove = gpd_fan_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +	},
> +};
> +
> +static struct platform_device *gpd_fan_platform_device;
> +
> +static int __init gpd_fan_init(void)
> +{
> +	const struct model_quirk *match = NULL;
> +
> +	for (const struct model_quirk **p = gpd_module_quirks; *p != NULL;
> +		 p++) {
> +		if (strcmp(gpd_fan_model, (*p)->model_name) == 0) {
> +			match = *p;
> +			break;
> +		}
> +	}
> +
> +	if (match == NULL) {

	!match

Pleae run checkpatch --strict on this patch and fix what it reports.

> +		match = dmi_first_match(gpd_devices)->driver_data;
> +		if (!IS_ERR_OR_NULL(match) && !match->tested) {

dmi_first_match() never returns an ERR_PTR.

> +			pr_warn("GPD Fan Driver do have the quirk for your device, but it's not tested. Please tested carefully by model parameter gpd_fan_model=%s and report.\n",
> +				match->model_name);
> +			match = NULL;
> +		}
> +	}
> +
> +	if (IS_ERR_OR_NULL(match)) {

match is never an ERR_PTR.

> +		pr_debug("GPD Devices not supported\n");
> +		return -ENODEV;
> +	}
> +
> +	pr_info("Loading GPD fan model quirk: %s\n", match->model_name);
> +
> +	struct driver_private_data data = {
> +		.pwm_enable = AUTOMATIC,
> +		.pwm_value = 255,
> +		.fan_speed_cached = 0,
> +		.read_pwm_cached = 0,
> +		.update_interval_per_second = 1,
> +		.fan_speed_last_update = jiffies,
> +		.read_pwm_last_update = jiffies,
> +		.quirk = match,
> +	};
> +
> +	struct resource gpd_fan_resources[] = {
> +		{
> +			.start = data.quirk->address.addr_port,
> +			.end = data.quirk->address.data_port,
> +			.flags = IORESOURCE_IO,
> +		},
> +	};
> +
> +	gpd_fan_platform_device = platform_create_bundle(
> +		&gpd_fan_driver, gpd_fan_probe, gpd_fan_resources, 1, &data,
> +		sizeof(struct driver_private_data));
> +
> +	if (IS_ERR(gpd_fan_platform_device)) {
> +		pr_warn("Failed to create platform device\n");
> +		return PTR_ERR(gpd_fan_platform_device);
> +	}
> +
> +	pr_debug("GPD Devices fan driver loaded\n");
> +	return 0;
> +}
> +
> +static void __exit gpd_fan_exit(void)
> +{
> +	platform_device_unregister(gpd_fan_platform_device);
> +	platform_driver_unregister(&gpd_fan_driver);
> +	pr_debug("GPD Devices fan driver unloaded\n");
> +}
> +
> +module_init(gpd_fan_init)
> +
> +	module_exit(gpd_fan_exit)
> +
> +		MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Cryolitia <Cryolitia@gmail.com>");
> +MODULE_DESCRIPTION("GPD Devices fan control driver");
> +MODULE_ALIAS("dmi:*:svnGPD:pnG1617-01:*");
> +MODULE_ALIAS("dmi:*:svnGPD:pnG1618-04:*");
> +MODULE_ALIAS("dmi:*:svnGPD:pnG1619-04:*");
> 


