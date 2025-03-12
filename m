Return-Path: <linux-kernel+bounces-557219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E794A5D546
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44D7189747F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243101DE2BF;
	Wed, 12 Mar 2025 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3Dqm50o"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100F11C32;
	Wed, 12 Mar 2025 05:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741755968; cv=none; b=UbN2fxYpVmbrKSIaSLv3eIFkuCohAZyGArd2IoTvYMtSCqqljFLaCWhG4wYGYM/Ds+2ZKdDX3yvYGxeokIpnn9TA3H+vzb2r66M26E/S/CnqqR4CSoi3jIeqV2rNh9owMcjU14yGUJUMizfUEAg+6Y+dxTTnJjjDupxLgAq38p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741755968; c=relaxed/simple;
	bh=xzqVMiIHHTRfNBiBV1V+lbTN1JllU3MJgvqABIrl5/I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LE5NqZ8rCHhbTkhxJdXPvMD8uUKEOrTjkhXMwKS29942rCFIkAASlPeqAbUo4TUBnY0+tqi7W0xmhrjd19MEZILwL9M0oCvpMEVgXxrXN8V3YinIkgfjnuVQRNjLtftj5AzIAcNj4S2r5FHqucFCuLaxGyPZx7t0n+0IIVqTu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3Dqm50o; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86718c2c3b9so2577649241.2;
        Tue, 11 Mar 2025 22:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741755965; x=1742360765; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnmbOvnAbWO5fgp0WervlnC5X2234cIGF1h3UHn9IX0=;
        b=J3Dqm50ou8i+JdI8gEICYvQCqGjAW2jSo1AEEM9yljoEA4AvpdmrNxFgukKso2Ghd6
         L6ngK0eXmYf2UK0yiAa7sz0m0RKYlG/c7HBEKqwneLpI6zh3FC7dpmjYZ3HvN1BlVb+N
         svtndUPMfxZAD3A7yr/V2TWlXMRCUWTImZePwFp0qNuIM5hrDVSYxljVJm1f/agz6vce
         qXmFzguD9SqIsGka4sLAQ6NYKIc2yOY7NmEsQyKjaXC5m5ZfaD6iDE9pmPJ55jRrXVtQ
         6B44RVR36hMu9XzuBlQDDpPs10drf4gXHXyITZOnU7hVsn7VyEJp7f7YIH/JdpYY86PW
         3WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741755965; x=1742360765;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TnmbOvnAbWO5fgp0WervlnC5X2234cIGF1h3UHn9IX0=;
        b=v/fvrkctoAM6Pc9xAY4ET7QzW9hJD1caOpvUtU6/rRnrLXNKRgGVsMlitT2NutXOeh
         N57kCV6sbLxiKUc+3YnJnpca9thmiPSZ9yMJXnP3pkYRR2kO6RxljxDxiEBxdiqJRVOi
         rEsSsnE1wWUbXspRCB5K2vLMuhBFT2oZnd4GNP6DsgF+VMVSmPKVXtkZfe08VKnXGEkF
         KaF23imEeeI/lwxE4lpXOfy9u4pMLeK3tj//WD0hJpc8oamShCjyA+9Uh3j2ofCEeL/8
         PhgxluatAnHBKO2x5P2ybvptFn53wwTjLOLRZ13XGE/X7HzF04blnf211EeLPnOs3wk5
         Q0Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUPflzRpYiUHxEzgd7BRjza+BUsI1YgB/hFxFiARtsPkykDsu6z9M9QKoM2caVD2/RiPL0I/jb+03TXcQ==@vger.kernel.org, AJvYcCWgOjIQTl7GfAiQN3SU6zY6TlAIv/qaSITVtQmP+tp09s12b5GVFdUi2CKNBto4lEUhHcuuA4lcAWoTwblGLfn4/6D9ig==@vger.kernel.org, AJvYcCXDYkjmOil+TfRVA8LbhY/+Nsxb1UqCYAeXtcC0Vft4si/2mpO/LM0f+3jaUL1eEzLOk5TOyxeSS8DVIHX7@vger.kernel.org
X-Gm-Message-State: AOJu0YxunviTOaOpucgr0TXotuV9kS7VxuyRoCQpESo5nrPL9tui/D+j
	tlQNsY9iHdamnimZ2JQPkolTrck2H7lWeC0UNY56PQ4Z75ITSKOO3KKM7/2F
X-Gm-Gg: ASbGnctyoWLSytEqWWVsVk2YzbfbsH9nVck0Lsex3qWlKCswKuqLKIFMpdomHBjqgLq
	uFxOftxne/80lp/IlkJKzwdOfJcYyd5PJJAHE/MrqVeIta/B4G5PYhq2Hn/NMapbvAM3X0KpPsG
	x+KzSFHpVtuM0foGcwURzc88ePb1PQHhGkMBHUT5E6UBmTgGW35+cKPfBv1jXcgDf5dlBjUt9bw
	uGXbd7WBU0txFl4COeMaiHXnuA4K8dYXSN907/hbbbSwzHSCQh/eAIxRxISQZMPwdKUhSOSS0gv
	uIH5z/LH7AGXXK9zbi9tj+zAwIvKqwxn7ARX
X-Google-Smtp-Source: AGHT+IEL6O5qD3/f+JR0CDcCofGrKRDd4BmPISl/4ZxEok/tyIRJYtSTdRQVHMQBW5bzbBkO8w/HvA==
X-Received: by 2002:a05:6102:374e:b0:4c1:b0ad:a0bd with SMTP id ada2fe7eead31-4c34d376e61mr5366309137.23.1741755964790;
        Tue, 11 Mar 2025 22:06:04 -0700 (PDT)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb27df57sm2721657137.0.2025.03.11.22.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 22:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Mar 2025 00:06:01 -0500
Message-Id: <D8E0YIGL8OB5.1LCMBZ0T595Q1@gmail.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 <platform-driver-x86@vger.kernel.org>, <Dell.Client.Kernel@dell.com>,
 <linux-kernel@vger.kernel.org>, "Guenter Roeck" <linux@roeck-us.net>, "Jean
 Delvare" <jdelvare@suse.com>, <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v4 07/12] platform/x86: alienware-wmi-wmax: Add HWMON
 support
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Armin Wolf" <W_Armin@gmx.de>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
 <20250308-hwm-v4-7-afa1342828f5@gmail.com>
 <f48154cb-c282-4783-94b9-b5378b146f4a@gmx.de>
In-Reply-To: <f48154cb-c282-4783-94b9-b5378b146f4a@gmx.de>

On Tue Mar 11, 2025 at 1:55 PM -05, Armin Wolf wrote:
> Am 08.03.25 um 21:23 schrieb Kurt Borja:
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
>>   drivers/platform/x86/dell/alienware-wmi-wmax.c | 396 +++++++++++++++++=
++++++++
>>   2 files changed, 397 insertions(+)
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
>> index 3b37e4456482bc284b8e867c1c5b6255fc6c8ef2..f1f20db206d47f644e8cd58a=
6d169c850606e75b 100644
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
>> @@ -38,6 +42,12 @@
>>
>>   /* Arbitrary limit based on supported models */
>>   #define AWCC_MAX_RES_COUNT			16
>> +#define AWCC_ID_BITMAP_SIZE			(U8_MAX + 1)
>> +#define AWCC_ID_BITMAP_LONGS			BITS_TO_LONGS(AWCC_ID_BITMAP_SIZE)
>> +
>> +static bool force_hwmon;
>> +module_param_unsafe(force_hwmon, bool, 0);
>> +MODULE_PARM_DESC(force_hwmon, "Force probing for HWMON support without =
checking if the WMI backend is available");
>>
>>   static bool force_platform_profile;
>>   module_param_unsafe(force_platform_profile, bool, 0);
>> @@ -48,16 +58,19 @@ module_param_unsafe(force_gmode, bool, 0);
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
>> @@ -155,9 +168,18 @@ static const struct dmi_system_id awcc_dmi_table[] =
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
>> @@ -180,6 +202,11 @@ enum AWCC_SPECIAL_THERMAL_CODES {
>>   	AWCC_SPECIAL_PROFILE_GMODE		=3D 0xAB,
>>   };
>>
>> +enum AWCC_TEMP_SENSOR_TYPES {
>> +	AWCC_TEMP_SENSOR_CPU			=3D 0x01,
>> +	AWCC_TEMP_SENSOR_GPU			=3D 0x06,
>> +};
>> +
>>   enum awcc_thermal_profile {
>>   	AWCC_PROFILE_USTT_BALANCED,
>>   	AWCC_PROFILE_USTT_BALANCED_PERFORMANCE,
>> @@ -216,6 +243,14 @@ struct wmax_u32_args {
>>   	u8 arg3;
>>   };
>>
>> +struct awcc_fan_data {
>> +	unsigned long auto_channels_temp;
>> +	const char *label;
>> +	u32 min_rpm;
>> +	u32 max_rpm;
>> +	u8 id;
>> +};
>> +
>>   struct awcc_priv {
>>   	struct wmi_device *wdev;
>>   	union {
>> @@ -231,6 +266,10 @@ struct awcc_priv {
>>
>>   	struct device *ppdev;
>>   	u8 supported_profiles[PLATFORM_PROFILE_LAST];
>> +
>> +	struct device *hwdev;
>> +	struct awcc_fan_data **fan_data;
>> +	unsigned long temp_sensors[AWCC_ID_BITMAP_LONGS];
>>   };
>>
>>   static const enum platform_profile_option awcc_mode_to_platform_profil=
e[AWCC_PROFILE_LAST] =3D {
>> @@ -495,6 +534,19 @@ static int __awcc_wmi_command(struct wmi_device *wd=
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
>> @@ -552,6 +604,30 @@ static inline int awcc_op_get_resource_id(struct wm=
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
>> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args=
, out);
>> +}
>> +
>>   static inline int awcc_op_get_current_profile(struct wmi_device *wdev,=
 u32 *out)
>>   {
>>   	struct wmax_u32_args args =3D {
>> @@ -577,6 +653,313 @@ static inline int awcc_op_activate_profile(struct =
wmi_device *wdev, u8 profile)
>>   	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &=
out);
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
>> +		temp_count =3D bitmap_weight(priv->temp_sensors, AWCC_ID_BITMAP_SIZE)=
;
>> +
>> +		return channel < temp_count ? 0444 : 0;
>> +	case hwmon_fan:
>> +		return channel < priv->fan_count ? 0444 : 0;
>> +	case hwmon_pwm:
>> +		return channel < priv->fan_count ? 0444 : 0;
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
>> +	const struct awcc_fan_data *fan;
>> +	u32 state;
>> +	int ret;
>> +	u8 temp;
>> +
>> +	switch (type) {
>> +	case hwmon_temp:
>> +		temp =3D find_nth_bit(priv->temp_sensors, AWCC_ID_BITMAP_SIZE, channe=
l);
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
>> +			*val =3D fan->auto_channels_temp;
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
>> +	u8 temp;
>> +
>> +	switch (type) {
>> +	case hwmon_temp:
>> +		temp =3D find_nth_bit(priv->temp_sensors, AWCC_ID_BITMAP_SIZE, channe=
l);
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
>> +		*str =3D priv->fan_data[channel]->label;
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
>> +	unsigned int i;
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
>> +		__set_bit(FIELD_GET(AWCC_RESOURCE_ID_MASK, id), priv->temp_sensors);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static char *awcc_alloc_fan_label(struct device *dev, u32 temp_count, u=
8 temp_id)
>> +{
>> +	char *label;
>> +
>> +	switch (temp_count) {
>> +	case 0:
>> +		label =3D devm_kstrdup(dev, "Independent Fan", GFP_KERNEL);
>> +		break;
>> +	case 1:
>> +		switch (temp_id) {
>> +		case AWCC_TEMP_SENSOR_CPU:
>> +			label =3D devm_kstrdup(dev, "Processor Fan", GFP_KERNEL);
>> +			break;
>> +		case AWCC_TEMP_SENSOR_GPU:
>> +			label =3D devm_kstrdup(dev, "Video Fan", GFP_KERNEL);
>> +			break;
>> +		default:
>> +			label =3D devm_kstrdup(dev, "Unknown Fan", GFP_KERNEL);
>> +			break;
>> +		}
>> +
>> +		break;
>> +	default:
>> +		label =3D devm_kstrdup(dev, "Shared Fan", GFP_KERNEL);
>
> All of those strings are static, please drop the usage of devm_kstrdup() =
here.

Right! They are string literals.

>
> With those issues being addressed:
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>
>> +		break;
>> +	}
>> +
>> +	return label;
>> +}
>> +
>> +static int awcc_hwmon_fans_init(struct wmi_device *wdev)
>> +{
>> +	struct awcc_priv *priv =3D dev_get_drvdata(&wdev->dev);
>> +	u32 id, min_rpm, max_rpm, temp_count, temp_id;
>> +	unsigned long fan_temps[AWCC_ID_BITMAP_LONGS];
>> +	unsigned long gather[AWCC_ID_BITMAP_LONGS];
>> +	struct awcc_fan_data *fan_data;
>> +	unsigned int i, j;
>> +	char *label;
>> +	int ret;
>> +
>> +	for (i =3D 0; i < priv->fan_count; i++) {
>> +		fan_data =3D devm_kzalloc(&wdev->dev, sizeof(*fan_data), GFP_KERNEL);
>> +		if (!fan_data)
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
>> +			__set_bit(temp_id, fan_temps);
>> +		}
>> +
>> +		label =3D awcc_alloc_fan_label(&wdev->dev, temp_count, temp_id);
>> +		if (!label)
>> +			return -ENOMEM;
>> +
>> +		fan_data->id =3D id;
>> +		fan_data->min_rpm =3D min_rpm;
>> +		fan_data->max_rpm =3D max_rpm;
>> +		fan_data->label =3D label;
>> +		bitmap_gather(gather, fan_temps, priv->temp_sensors, AWCC_ID_BITMAP_S=
IZE);
>> +		bitmap_copy(&fan_data->auto_channels_temp, gather, priv->temp_count);
>
> Please check that the bitmap can fit into the long variable before using =
bitmap_copy().

priv->temp_count is bounded by AWCC_MAX_RES_COUNT which is 16.

I don't think it will ever be bigger than 64, but I will replace it with
BITS_PER_LONG just to be extra careful.

Thank you very much for reviewing the whole series!

--=20
 ~ Kurt

