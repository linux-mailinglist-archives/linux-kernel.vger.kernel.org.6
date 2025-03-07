Return-Path: <linux-kernel+bounces-550163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B916A55C0D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C6E3B3E90
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEDE847B;
	Fri,  7 Mar 2025 00:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgGQ1pBM"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B520A4C96;
	Fri,  7 Mar 2025 00:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307761; cv=none; b=pU6g0hQd1vm4u+w/eoniWaYCpYgh0f+UwnxQ1N9a5LKZeflcm/I3+9mqwEQu4s518ZC2GSfmV6hQ/DfQQhGDw5M5GprAdbovKIMFU8nJ1zAroQLCnwBSWzVRFK9kJ2VyeLPxV3WIRu5n/MNcqU8GcWUGB+48Cr+Z3MUfy+f/PwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307761; c=relaxed/simple;
	bh=AXos1AlNZniVOqZrL/1OcU4mQG9qSVbEhtJAtY5tg5o=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=qqoJC+K/Jxo4xqEXCuzbU8zQZyw8/n5+cr6rWZfnXH0HV+5PwujJBv0P6LUNH2m16Fq/jPY+bdXxvEM5+ICBafm2EGaffjbkTC7nBtBi6a6AveYMiRb9HUKjd8QNhS0VKR2ATaWT40Htc1kUikyQ/0pi3+pydXLjTEAUm1vcUNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgGQ1pBM; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f74b78df93so13872337b3.0;
        Thu, 06 Mar 2025 16:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741307758; x=1741912558; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUxHPv2GTm+3dxs4P3WOFWhKn+KKweyyrgScbgE6QLM=;
        b=fgGQ1pBM5KwNc627l3thZketD4kXWgxoC5aL79sghk+6HEQHn8oICgoePtVsM8pFRH
         NyyiqXg+K0Ihju7tJeXjW5OLD1A/Rh53Eq0XbvidSOyuhjomhWdayXcaC1Yid92XX+vY
         HbT9gzlxW63QOecxfJmyWS9m+OKwLClAzmg1i2Q/RV3o2DCY1gMA4mzK9D/aKxh8hehC
         Bi2Wk/a2FBH8U/mjeohH2aPDpQWgtz6WDM8p6UGNQ85WrtmwC1/abU+FxG552xEDB+gI
         gpk1djecNLRO/NqRffJRBecny0eo9FiTfEj7zv9S7gTZuDGJfrnWN91Bt3gl9PGUFllR
         18bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741307758; x=1741912558;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BUxHPv2GTm+3dxs4P3WOFWhKn+KKweyyrgScbgE6QLM=;
        b=VVTfPH2ZUYv0kFhkfst2HqwP5VN5dwCcnrwTtcUCdinWfDmRiwKfy6QjtbOTiuu4bu
         J1YGzpdL7xhzpGZoRDJfwTlAnaOuQMkzG+MAN3MwKx/IUKtrWdI+lsFJIrZrmqi1kkae
         9BccscyDMT149ucjo7K5IZqh03ykhMQsDeaoC1m4szAenMp6y/AUxV+uQJm56+DhmH6j
         XIEH60nB9eaTdb0JQdKoxE148Poi79Nef3CZBEjT3P3AdQiliWFz+E15nqjqY/1ltmLj
         1XtJyI6T3WHupVenbAV2NHuQi5NKbmCy170FmVYqbW26i3iqO2OfSLGuYOWE2pXt0ilh
         DfQA==
X-Forwarded-Encrypted: i=1; AJvYcCUvq5MuXjT2nvZaqMur+23WSrkl3TpDHI9mPsWz5NRsdUP0Sqs1aiViFC2TihKZerG019CdxBZlB124w3Nh@vger.kernel.org, AJvYcCWR1AcGcP5d+f76TjnS1Bez/Chz5XLBPD3g/PdXTn6fkR/07zS5V8puLJvM8HXQZUWwBSl9iRhL+UoVOlgKicVRB7kXyg==@vger.kernel.org, AJvYcCXYtz4myinLtceiYvdaVY64b2e8rqF8bh9f0tnLy8OQx8tg+l8S1YrfXK6H1bymmNArW7LPBymICXubTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1otXrkiEPR94xvrIWV8wrcZthhgt6EUWMx3KAlg2s1cTYjXJg
	wtHE8WqVXgIMQkWNyYwt4B0J4tM45Uugr8rtDxZ2uqEJXw3B5ZQb
X-Gm-Gg: ASbGncujG77Z7egJD7e7dhZarmbI6iMQihR5l6XIqQ61bLOOe1HSOebTePZ76T7IvNY
	bwBhMOYi65QLeo4vBiquqOW+mRPPq79jvxn/+kOl1gGHXcdOQN5Z9LSN93uwixkw/TVjDYDLVT4
	aRWFfgTjci4DJjPcPwbYE3D+TA5EUSoRtJKYAxfHGbvPhHnajcdLF2TL23xItpN9abi4AyYi4QR
	GD8hziduLzqvt0eXkpS1eDskQSMckv8sIhHdTGv+sP6EuddCtTtn7s7nlg2kMXpwjxYLPlQrdWl
	Hxq0th2LA9uywUtsdWgGEuKAo906JConvlq4OQ==
X-Google-Smtp-Source: AGHT+IEbIro/S0ElKJZyxGcXh68AXZ1Ng9rhcTcXe20Ln6ZAPHZMLI/TYTst7Qd9fkLVKaR4xS1erw==
X-Received: by 2002:a05:690c:690d:b0:6fb:33e1:2e66 with SMTP id 00721157ae682-6febf2c8ab4mr24763187b3.14.1741307758538;
        Thu, 06 Mar 2025 16:35:58 -0800 (PST)
Received: from localhost ([2800:bf0:61:1288:2be8:bc29:ad13:842f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c31ec6sm5001317b3.83.2025.03.06.16.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 16:35:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Mar 2025 19:35:56 -0500
Message-Id: <D89M2ZQJEH45.1HKFFX5ESXRSJ@gmail.com>
To: "Armin Wolf" <W_Armin@gmx.de>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 <platform-driver-x86@vger.kernel.org>, <Dell.Client.Kernel@dell.com>,
 <linux-kernel@vger.kernel.org>, "Guenter Roeck" <linux@roeck-us.net>, "Jean
 Delvare" <jdelvare@suse.com>, <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v3 07/10] platform/x86: alienware-wmi-wmax: Add HWMON
 support
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
 <20250305-hwm-v3-7-395e7a1407e2@gmail.com>
 <a375d474-5349-4662-8ce8-4f8f55349901@gmx.de>
In-Reply-To: <a375d474-5349-4662-8ce8-4f8f55349901@gmx.de>

On Thu Mar 6, 2025 at 5:19 PM -05, Armin Wolf wrote:
> Am 06.03.25 um 01:56 schrieb Kurt Borja:
>
>> All models with the "AWCC" WMAX device support monitoring fan speed and
>> temperature sensors. Expose this feature through the HWMON interface.
>>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Jean Delvare <jdelvare@suse.com>
>> Cc: linux-hwmon@vger.kernel.org
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>   drivers/platform/x86/dell/Kconfig              |   1 +
>>   drivers/platform/x86/dell/alienware-wmi-wmax.c | 431 +++++++++++++++++=
++++++++
>>   2 files changed, 432 insertions(+)
>>
>> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/de=
ll/Kconfig
>> index f8a0dffcaab7c3b423472c5b9093011334a698c8..85a57c01aaada5d899cd8252=
e77ed6043da5cbdf 100644
>> --- a/drivers/platform/x86/dell/Kconfig
>> +++ b/drivers/platform/x86/dell/Kconfig
>> @@ -43,6 +43,7 @@ config ALIENWARE_WMI_WMAX
>>   	bool "Alienware WMAX WMI device driver"
>>   	default y
>>   	depends on ALIENWARE_WMI
>> +	depends on HWMON
>>   	select ACPI_PLATFORM_PROFILE
>>   	help
>>   	 Alienware WMI driver with AlienFX LED, HDMI, amplifier, deep sleep a=
nd
>> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
>> index 71fc17e8d103146b8edf53a552ae5ba64414e873..20cf3371ee3c0e1ea038b3ca=
517e831f3b30dc29 100644
>> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
>> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
>> @@ -9,10 +9,13 @@
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>
>>   #include <linux/bitfield.h>
>> +#include <linux/bitmap.h>
>>   #include <linux/bits.h>
>>   #include <linux/dmi.h>
>> +#include <linux/hwmon.h>
>>   #include <linux/moduleparam.h>
>>   #include <linux/platform_profile.h>
>> +#include <linux/units.h>
>>   #include <linux/wmi.h>
>>   #include "alienware-wmi.h"
>>
>> @@ -25,6 +28,7 @@
>>   #define WMAX_METHOD_BRIGHTNESS			0x3
>>   #define WMAX_METHOD_ZONE_CONTROL		0x4
>>
>> +#define AWCC_METHOD_GET_FAN_SENSORS		0x13
>>   #define AWCC_METHOD_THERMAL_INFORMATION		0x14
>>   #define AWCC_METHOD_THERMAL_CONTROL		0x15
>>   #define AWCC_METHOD_GAME_SHIFT_STATUS		0x25
>> @@ -39,6 +43,10 @@
>>   /* Arbitrary limit based on supported models */
>>   #define AWCC_MAX_RES_COUNT			16
>>
>> +static bool force_hwmon;
>> +module_param_unsafe(force_hwmon, bool, 0);
>> +MODULE_PARM_DESC(force_hwmon, "Force probing for HWMON support without =
checking if the WMI backend is available");
>> +
>>   static bool force_platform_profile;
>>   module_param_unsafe(force_platform_profile, bool, 0);
>>   MODULE_PARM_DESC(force_platform_profile, "Forces auto-detecting therma=
l profiles without checking if WMI thermal backend is available");
>> @@ -48,16 +56,19 @@ module_param_unsafe(force_gmode, bool, 0);
>>   MODULE_PARM_DESC(force_gmode, "Forces G-Mode when performance profile =
is selected");
>>
>>   struct awcc_quirks {
>> +	bool hwmon;
>>   	bool pprof;
>>   	bool gmode;
>>   };
>>
>>   static struct awcc_quirks g_series_quirks =3D {
>> +	.hwmon =3D true,
>>   	.pprof =3D true,
>>   	.gmode =3D true,
>>   };
>>
>>   static struct awcc_quirks generic_quirks =3D {
>> +	.hwmon =3D true,
>>   	.pprof =3D true,
>>   	.gmode =3D false,
>>   };
>> @@ -155,9 +166,18 @@ static const struct dmi_system_id awcc_dmi_table[] =
__initconst =3D {
>>   	},
>>   };
>>
>> +enum AWCC_GET_FAN_SENSORS_OPERATIONS {
>> +	AWCC_OP_GET_TOTAL_FAN_TEMPS		=3D 0x01,
>> +	AWCC_OP_GET_FAN_TEMP_ID			=3D 0x02,
>> +};
>> +
>>   enum AWCC_THERMAL_INFORMATION_OPERATIONS {
>>   	AWCC_OP_GET_SYSTEM_DESCRIPTION		=3D 0x02,
>>   	AWCC_OP_GET_RESOURCE_ID			=3D 0x03,
>> +	AWCC_OP_GET_TEMPERATURE			=3D 0x04,
>> +	AWCC_OP_GET_FAN_RPM			=3D 0x05,
>> +	AWCC_OP_GET_FAN_MIN_RPM			=3D 0x08,
>> +	AWCC_OP_GET_FAN_MAX_RPM			=3D 0x09,
>>   	AWCC_OP_GET_CURRENT_PROFILE		=3D 0x0B,
>>   };
>>
>> @@ -180,6 +200,12 @@ enum AWCC_SPECIAL_THERMAL_CODES {
>>   	AWCC_SPECIAL_PROFILE_GMODE		=3D 0xAB,
>>   };
>>
>> +enum AWCC_TEMP_SENSOR_TYPES {
>> +	AWCC_TEMP_SENSOR_CPU			=3D 0x01,
>> +	AWCC_TEMP_SENSOR_GPU			=3D 0x06,
>> +	AWCC_TEMP_SENSOR_LAST
>> +};
>> +
>>   enum awcc_thermal_profile {
>>   	AWCC_PROFILE_USTT_BALANCED,
>>   	AWCC_PROFILE_USTT_BALANCED_PERFORMANCE,
>> @@ -216,6 +242,15 @@ struct wmax_u32_args {
>>   	u8 arg3;
>>   };
>>
>> +struct awcc_fan_data {
>> +	unsigned long *related_temps;
>> +	unsigned long *auto_channels_temp;
>> +	u32 total_temps;
>> +	u32 min_rpm;
>> +	u32 max_rpm;
>> +	u8 id;
>> +};
>> +
>>   struct awcc_priv {
>>   	struct wmi_device *wdev;
>>   	union {
>> @@ -231,6 +266,11 @@ struct awcc_priv {
>>
>>   	struct device *ppdev;
>>   	u8 supported_profiles[PLATFORM_PROFILE_LAST];
>> +
>> +	struct device *hwdev;
>> +	struct awcc_fan_data **fan_data;
>> +	unsigned int temp_sensors_size;
>> +	unsigned long *temp_sensors;
>>   };
>>
>>   static const enum platform_profile_option awcc_mode_to_platform_profil=
e[AWCC_PROFILE_LAST] =3D {
>> @@ -495,6 +535,19 @@ static int __awcc_wmi_command(struct wmi_device *wd=
ev, u32 method_id,
>>   	return 0;
>>   }
>>
>> +static inline int awcc_get_fan_sensors(struct wmi_device *wdev, u8 oper=
ation,
>> +				       u8 fan_id, u8 index, u32 *out)
>> +{
>> +	struct wmax_u32_args args =3D {
>> +		.operation =3D operation,
>> +		.arg1 =3D fan_id,
>> +		.arg2 =3D index,
>> +		.arg3 =3D 0,
>> +	};
>> +
>> +	return __awcc_wmi_command(wdev, AWCC_METHOD_GET_FAN_SENSORS, &args, ou=
t);
>> +}
>> +
>>   static inline int awcc_thermal_information(struct wmi_device *wdev, u8=
 operation,
>>   					   u8 arg, u32 *out)
>>   {
>> @@ -552,6 +605,32 @@ static inline int awcc_op_get_resource_id(struct wm=
i_device *wdev, u8 index, u32
>>   	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &arg=
s, out);
>>   }
>>
>> +static inline int awcc_op_get_fan_rpm(struct wmi_device *wdev, u8 fan_i=
d, u32 *out)
>> +{
>> +	struct wmax_u32_args args =3D {
>> +		.operation =3D AWCC_OP_GET_FAN_RPM,
>> +		.arg1 =3D fan_id,
>> +		.arg2 =3D 0,
>> +		.arg3 =3D 0,
>> +	};
>> +
>> +
>> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args=
, out);
>> +}
>> +
>> +static inline int awcc_op_get_temperature(struct wmi_device *wdev, u8 t=
emp_id, u32 *out)
>> +{
>> +	struct wmax_u32_args args =3D {
>> +		.operation =3D AWCC_OP_GET_TEMPERATURE,
>> +		.arg1 =3D temp_id,
>> +		.arg2 =3D 0,
>> +		.arg3 =3D 0,
>> +	};
>> +
>> +
>> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args=
, out);
>> +}
>> +
>>   static inline int awcc_op_get_current_profile(struct wmi_device *wdev,=
 u32 *out)
>>   {
>>   	struct wmax_u32_args args =3D {
>> @@ -599,6 +678,345 @@ static int awcc_profile_id_to_pprof(u32 id, enum p=
latform_profile_option *profil
>>   	return 0;
>>   }
>>
>> +/*
>> + * HWMON
>> + *  - Provides temperature and fan speed monitoring as well as manual f=
an
>> + *    control
>> + */
>> +static umode_t awcc_hwmon_is_visible(const void *drvdata, enum hwmon_se=
nsor_types type,
>> +				     u32 attr, int channel)
>> +{
>> +	const struct awcc_priv *priv =3D drvdata;
>> +	unsigned int temp_count;
>> +
>> +	switch (type) {
>> +	case hwmon_temp:
>> +		temp_count =3D bitmap_weight(priv->temp_sensors, priv->temp_sensors_s=
ize);
>> +
>> +		return channel < temp_count ? 0444 : 0;
>> +	case hwmon_fan:
>> +		return channel < priv->fan_count ? 0444 : 0;
>> +	case hwmon_pwm:
>> +		if (channel >=3D priv->fan_count)
>> +			return 0;
>> +
>> +		switch (attr) {
>> +		case hwmon_pwm_enable:
>
> Please drop pwm_enable here and only introduce it inside the proper patch=
.

Thanks, mb.

>
>> +			return 0644;
>> +		case hwmon_pwm_auto_channels_temp:
>> +			return 0444;
>> +		default:
>> +			return 0;
>> +		}
>> +	default:
>> +		return 0;
>> +	}
>> +}
>> +
>> +static int awcc_hwmon_read(struct device *dev, enum hwmon_sensor_types =
type,
>> +			   u32 attr, int channel, long *val)
>> +{
>> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
>> +	struct awcc_fan_data *fan;
>> +	u32 state;
>> +	int ret;
>> +	u8 temp;
>> +
>> +	switch (type) {
>> +	case hwmon_temp:
>> +		temp =3D find_nth_bit(priv->temp_sensors, priv->temp_sensors_size, ch=
annel);
>> +
>> +		switch (attr) {
>> +		case hwmon_temp_input:
>> +			ret =3D awcc_op_get_temperature(priv->wdev, temp, &state);
>> +			if (ret)
>> +				return ret;
>> +
>> +			*val =3D state * MILLIDEGREE_PER_DEGREE;
>> +			break;
>> +		default:
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>> +		break;
>> +	case hwmon_fan:
>> +		fan =3D priv->fan_data[channel];
>> +
>> +		switch (attr) {
>> +		case hwmon_fan_input:
>> +			ret =3D awcc_op_get_fan_rpm(priv->wdev, fan->id, &state);
>> +			if (ret)
>> +				return ret;
>> +
>> +			*val =3D state;
>> +			break;
>> +		case hwmon_fan_min:
>> +			*val =3D fan->min_rpm;
>> +			break;
>> +		case hwmon_fan_max:
>> +			*val =3D fan->max_rpm;
>> +			break;
>> +		default:
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>> +		break;
>> +	case hwmon_pwm:
>> +		fan =3D priv->fan_data[channel];
>> +
>> +		switch (attr) {
>> +		case hwmon_pwm_auto_channels_temp:
>> +			bitmap_copy(val, fan->auto_channels_temp, BITS_PER_LONG);
>> +			break;
>> +		default:
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>> +		break;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int awcc_hwmon_read_string(struct device *dev, enum hwmon_sensor=
_types type,
>> +				  u32 attr, int channel, const char **str)
>> +{
>> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
>> +	struct awcc_fan_data *fan;
>> +	u8 temp;
>> +
>> +	switch (type) {
>> +	case hwmon_temp:
>> +		temp =3D find_nth_bit(priv->temp_sensors, priv->temp_sensors_size, ch=
annel);
>> +
>> +		switch (temp) {
>> +		case AWCC_TEMP_SENSOR_CPU:
>> +			*str =3D "CPU";
>> +			break;
>> +		case AWCC_TEMP_SENSOR_GPU:
>> +			*str =3D "GPU";
>> +			break;
>> +		default:
>> +			*str =3D "Unknown";
>> +			break;
>> +		}
>> +
>> +		break;
>> +	case hwmon_fan:
>> +		fan =3D priv->fan_data[channel];
>> +
>> +		switch (fan->total_temps) {
>> +		case 0:
>> +			*str =3D "Independent Fan";
>> +			break;
>> +		case 1:
>> +			temp =3D find_first_bit(fan->related_temps, priv->temp_sensors_size)=
;
>> +
>> +			switch (temp) {
>> +			case AWCC_TEMP_SENSOR_CPU:
>> +				*str =3D "Processor Fan";
>> +				break;
>> +			case AWCC_TEMP_SENSOR_GPU:
>> +				*str =3D "Video Fan";
>> +				break;
>> +			default:
>> +				*str =3D "Unknown Fan";
>> +				break;
>> +			}
>> +
>> +			break;
>> +		default:
>> +			*str =3D "Shared Fan";
>> +			break;
>> +		}
>> +
>> +		break;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct hwmon_ops awcc_hwmon_ops =3D {
>> +	.is_visible =3D awcc_hwmon_is_visible,
>> +	.read =3D awcc_hwmon_read,
>> +	.read_string =3D awcc_hwmon_read_string,
>> +};
>> +
>> +static const struct hwmon_channel_info * const awcc_hwmon_info[] =3D {
>> +	HWMON_CHANNEL_INFO(temp,
>> +			   HWMON_T_LABEL | HWMON_T_INPUT,
>> +			   HWMON_T_LABEL | HWMON_T_INPUT,
>> +			   HWMON_T_LABEL | HWMON_T_INPUT,
>> +			   HWMON_T_LABEL | HWMON_T_INPUT,
>> +			   HWMON_T_LABEL | HWMON_T_INPUT,
>> +			   HWMON_T_LABEL | HWMON_T_INPUT
>> +			   ),
>> +	HWMON_CHANNEL_INFO(fan,
>> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX
>> +			   ),
>> +	HWMON_CHANNEL_INFO(pwm,
>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP
>> +			   ),
>
> Since the number of fans and temperature sensors is only known at runtime=
 creating awcc_hwmon_info
> would make sense.

IIRC Guenter asked another dev to add more CHANNEL_INFO entries instead
of doing that? I might be wrong tho.

I'm fine either way.

>
>> +	NULL
>> +};
>> +
>> +static const struct hwmon_chip_info awcc_hwmon_chip_info =3D {
>> +	.ops =3D &awcc_hwmon_ops,
>> +	.info =3D awcc_hwmon_info,
>> +};
>> +
>> +static int awcc_hwmon_temps_init(struct wmi_device *wdev)
>> +{
>> +	struct awcc_priv *priv =3D dev_get_drvdata(&wdev->dev);
>> +	unsigned long temp_sensors[BITS_TO_LONGS(U8_MAX)];
>> +	unsigned int i, max_sensor_id =3D 0;
>> +	int ret;
>> +	u32 id;
>> +
>> +	for (i =3D 0; i < priv->temp_count; i++) {
>> +		/*
>> +		 * Temperature sensors IDs are listed after the fan IDs at
>> +		 * offset `fan_count`
>> +		 */
>> +		ret =3D awcc_op_get_resource_id(wdev, i + priv->fan_count, &id);
>> +		if (ret)
>> +			return ret;
>> +
>> +		id =3D FIELD_GET(AWCC_RESOURCE_ID_MASK, id);
>> +		if (id > max_sensor_id)
>> +			max_sensor_id =3D id;
>> +
>> +		__set_bit(id, temp_sensors);
>> +	}
>> +
>> +	/*
>> +	 * We prefer to allocate the bitmap dynamically because usually temp I=
Ds
>> +	 * are small (< 0x30) and only one UL is needed to store it, but there
>> +	 * may be unknown devices that break this rule
>> +	 */
>
> Hi,
>
> as far as i know the memory allocator inside the kernel at least allocate=
s 32 bytes, so you are

bytes? bits maybe?

> not saving any memory with this. I suggest you allocate the bitmaps stati=
cally.

The thing is - We don't know before hand how big an ID can be.

Technically the upper limit is U8_MAX which would require 4 ULs to
store, which is a lot. However I haven't seen temp IDs bigger than 0x6,
so this way only one UL is allocated for most devices.

I would be very grateful if Dell could help us on this one :')

>
>> +	priv->temp_sensors_size =3D max_sensor_id + 1;
>> +	priv->temp_sensors =3D devm_bitmap_zalloc(&wdev->dev, priv->temp_senso=
rs_size,
>> +						GFP_KERNEL);
>> +	if (!priv->temp_sensors)
>> +		return -ENOMEM;
>> +
>> +	bitmap_copy(priv->temp_sensors, temp_sensors, priv->temp_sensors_size)=
;
>> +
>> +	return 0;
>> +}
>> +
>> +static int awcc_hwmon_fans_init(struct wmi_device *wdev)
>> +{
>> +	struct awcc_priv *priv =3D dev_get_drvdata(&wdev->dev);
>> +	u32 id, min_rpm, max_rpm, temp_count, temp_id;
>> +	unsigned long gather[BITS_TO_LONGS(U8_MAX)];
>> +	struct awcc_fan_data *fan_data;
>> +	unsigned int i, j;
>> +	int ret;
>> +
>> +	for (i =3D 0; i < priv->fan_count; i++) {
>> +		fan_data =3D devm_kzalloc(&wdev->dev, sizeof(*fan_data), GFP_KERNEL);
>> +		if (!fan_data)
>> +			return -ENOMEM;
>> +
>> +		fan_data->related_temps =3D devm_bitmap_zalloc(&wdev->dev,
>> +							     priv->temp_sensors_size,
>> +							     GFP_KERNEL);
>
> Same as above
>
>> +		if (!priv->temp_sensors)
>> +			return -ENOMEM;
>> +
>> +		fan_data->auto_channels_temp =3D devm_bitmap_zalloc(&wdev->dev,
>> +								  priv->temp_count,
>> +								  GFP_KERNEL);
>
> We already know that we only ever use the first sizeof(long) bytes from t=
his bitmap,
> please do a static allocation here.

Right, ofc! I forgot about the limit I imposed.

>
>> +		if (!priv->temp_sensors)
>> +			return -ENOMEM;
>> +
>> +		/*
>> +		 * Fan IDs are listed first at offset 0
>> +		 */
>> +		ret =3D awcc_op_get_resource_id(wdev, i, &id);
>> +		if (ret)
>> +			return ret;
>> +		id =3D FIELD_GET(AWCC_RESOURCE_ID_MASK, id);
>> +
>> +		ret =3D awcc_thermal_information(wdev, AWCC_OP_GET_FAN_MIN_RPM, id,
>> +					       &min_rpm);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret =3D awcc_thermal_information(wdev, AWCC_OP_GET_FAN_MAX_RPM, id,
>> +					       &max_rpm);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret =3D awcc_get_fan_sensors(wdev, AWCC_OP_GET_TOTAL_FAN_TEMPS, id,
>> +					   0, &temp_count);
>> +		if (ret)
>> +			return ret;
>> +
>> +		for (j =3D 0; j < temp_count; j++) {
>> +			ret =3D awcc_get_fan_sensors(wdev, AWCC_OP_GET_FAN_TEMP_ID,
>> +						   id, j, &temp_id);
>> +			if (ret)
>> +				break;
>> +
>> +			temp_id =3D FIELD_GET(AWCC_RESOURCE_ID_MASK, temp_id);
>> +			if (temp_id < priv->temp_sensors_size)
>> +				__set_bit(temp_id, fan_data->related_temps);
>> +		}
>> +
>> +		fan_data->id =3D id;
>> +		fan_data->min_rpm =3D min_rpm;
>> +		fan_data->max_rpm =3D max_rpm;
>> +		fan_data->total_temps =3D bitmap_weight(fan_data->related_temps,
>> +						      priv->temp_sensors_size);
>> +		bitmap_gather(gather, fan_data->related_temps, priv->temp_sensors,
>> +			      priv->temp_sensors_size);
>
> Since fan_data->related_temps is only used for determining the fan label =
after this it would
> make sense to determine the fan label here and turn fan_data->related_tem=
ps into a local
> variable on the stack.

Ack.

>
> Thanks,
> Armin Wolf

Thank you very much! Very helpful feedback :)

>
>> +		bitmap_copy(fan_data->auto_channels_temp, gather, priv->temp_count);
>> +		priv->fan_data[i] =3D fan_data;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int awcc_hwmon_init(struct wmi_device *wdev)
>> +{
>> +	struct awcc_priv *priv =3D dev_get_drvdata(&wdev->dev);
>> +	int ret;
>> +
>> +	priv->fan_data =3D devm_kcalloc(&wdev->dev, priv->fan_count,
>> +				      sizeof(*priv->fan_data), GFP_KERNEL);
>> +	if (!priv->fan_data)
>> +		return -ENOMEM;
>> +
>> +	ret =3D awcc_hwmon_temps_init(wdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D awcc_hwmon_fans_init(wdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	priv->hwdev =3D devm_hwmon_device_register_with_info(&wdev->dev, "alie=
nware_wmi", priv,
>> +							   &awcc_hwmon_chip_info, NULL);
>> +
>> +	return PTR_ERR_OR_ZERO(priv->hwdev);
>> +}
>> +
>>   /*
>>    * Thermal Profile control
>>    *  - Provides thermal profile control through the Platform Profile AP=
I
>> @@ -753,6 +1171,12 @@ static int alienware_awcc_setup(struct wmi_device =
*wdev)
>>   	priv->wdev =3D wdev;
>>   	dev_set_drvdata(&wdev->dev, priv);
>>
>> +	if (awcc->hwmon) {
>> +		ret =3D awcc_hwmon_init(wdev);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	if (awcc->pprof) {
>>   		ret =3D awcc_platform_profile_init(wdev);
>>   		if (ret)
>> @@ -833,6 +1257,13 @@ int __init alienware_wmax_wmi_init(void)
>>   	if (id)
>>   		awcc =3D id->driver_data;
>>
>> +	if (force_hwmon) {
>> +		if (!awcc)
>> +			awcc =3D &empty_quirks;
>> +
>> +		awcc->hwmon =3D true;
>> +	}
>> +
>>   	if (force_platform_profile) {
>>   		if (!awcc)
>>   			awcc =3D &empty_quirks;
>>


--=20
 ~ Kurt


