Return-Path: <linux-kernel+bounces-544958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B6FA4E75A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB24420240
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D937284B47;
	Tue,  4 Mar 2025 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTRawOH0"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482DA294EED;
	Tue,  4 Mar 2025 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105666; cv=none; b=uEomrFy2gxYFXhOpLuJOtw7fWKX3xY+zFXtEjD06dl9Y1o43Ilkn1qmtgndrYPFH3lGkssUIbLls/Zk7eQOTdgjpGO5+tZy/YaH2R9VxfX9qh158W+g9Sr53ZFgoHnKwFiCMENurLXad1pXQ42HHzd4vaXnQ6cCDswmdR3OYutI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105666; c=relaxed/simple;
	bh=n+rN8prc3Y/iIj7I6bRUUwjuV662NGtcMdxCGytfoAY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Pr+BNmW22VCPVtu8Bnl2VmpnP7raATvFR1mUaXpEuL7ixtsG2/Rap49AQ7JUXvWujImzv1aFND92b+ZniL+vC4urhaABEstfAq/Kil/I78D8dVfJ7Zr0HfJsgfWowSEeQAhVJMhF9cmW7W+nwBkyu6VVHrAWMZFyPTJNb3/9CBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTRawOH0; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-523bf140eccso503722e0c.0;
        Tue, 04 Mar 2025 08:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741105663; x=1741710463; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOyLOv3rnIyUAOPL1cwTTiZGDaFNi4X+eRhrOiQz5q0=;
        b=cTRawOH0qeBpblaopI3GpjgZfmIG2I1d8Eoi3ePp18QPbZY1hcJzdW57x3CShLUjBZ
         jpHVkHoydJK6zIH7ybeP+LAQ3p8hKoJdoOFLYgBSflCLrhkIEyriAKncvi7Jxmhggkux
         GutcbWziqz83Iqz6q77GeTu6xcChQ17zPYcHp90EZnpDHwV80jwXQ7WzplBYTWUEebC0
         kYC3cpBQFJn95NB7jVDtSH9wxFaPJ4R2sfuj20eRWUjKBcHixQ6GJ8dpNvUdM/T1cVWs
         6ykkXA0/xFHTXKFyD80F2F82088ehjIyxcUyL9RXe/DyoAZA4QXw+x3PHoNyO8LE3c/8
         gROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105663; x=1741710463;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LOyLOv3rnIyUAOPL1cwTTiZGDaFNi4X+eRhrOiQz5q0=;
        b=UInSaQK5WfPSzN0Pq62uRAK1QtprG3V9/JUb6NJ1UJiCNKx7xFxjJbTHLRQtyAnGRV
         jczzwAJI2dYYCvaLTFzzm1Ibb2xEk4Wvf//zK0Xt4XTjM1b+Z3dBugtzUPb5M2OQ8S8t
         f6mnLdyFHxMCS/p+B0HQtkEHrHG7a7DM9OWCahE3h8CKkjQueeVmpm4K+mD/qKMEnPn/
         W9ZNEkiCwxr9XfwxJaAMRH6lnQhoV1/mmZP/q60UFv33Ng6wUaQXa1biY5m897hi+/Mq
         GGHnn+JN0LkOwGmniFTg+QeujxqQ75cjj1udIJ/NMokh3QPoILpsGxS2dosZy1EPE0MX
         emTA==
X-Forwarded-Encrypted: i=1; AJvYcCXAmlsynEsPvNvwJIWEhqRA+faw62Pike8d8kUWzz9YINwpNKkqpjCYSp7CcusYyOzdHUUU7UZk/WLbJddXpy2A2UhVpg==@vger.kernel.org, AJvYcCXxgXUOM1TdqVDx/XkFh2nklKshsMGfKFpNy6/7AzO4wqvc5bvbgZjzIrjP0TQNbLlwRJKb9G5r/woK7yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdRnFup8L1JPbLutFKaUylwaJgZCtTLZEUqG0ztKKXRNnmJQcM
	HzEerYwdVnAFxJXT/LTcFCst49DmFmgMzVvu4/VlwTmmL1ZlFPoO
X-Gm-Gg: ASbGncvPRsXauQiMuzEQ509D5Wl78hA3pqXYuwkIcE0Ok5OA2Ht3tELEyFZyP/aNmvj
	lEsNKzXyW6GJlaafh2zzGbTd2A/fG/frHzRsz1IztGgUfGp8Et5vfpCYcmqqQ3Sa/3Txbun1pgl
	ye48jI8TztiMM8n42KYLUxS1I1dBh7ELLzryOlTmpxXRVPKod6NaoAX2tg55Ku6/6k/3ovDkQzg
	olbOORseYMNNbuTV9eanQFMZOsIxVicHe7n4cALCG0Hdv4qq9817niAaZPBdFCovZD6zpusWwzU
	LnEq0KMeNpHkKH9cGrh/lGxQdJDYycRoabxP
X-Google-Smtp-Source: AGHT+IFKU0v71qXDVzv541fv7zKWvq/xNKaFvoCPNjGs2upJs3yELPQ4Yt0TLZGE2f5Bq7RzK0KR1g==
X-Received: by 2002:a05:6122:4894:b0:523:792e:e9c3 with SMTP id 71dfb90a1353d-523aba9945emr2791347e0c.0.1741105663024;
        Tue, 04 Mar 2025 08:27:43 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5237ada4179sm1224556e0c.16.2025.03.04.08.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Mar 2025 11:27:39 -0500
Message-Id: <D87MG1SMP0WA.1EXT0WKP65DQR@gmail.com>
Cc: "Armin Wolf" <W_Armin@gmx.de>, <platform-driver-x86@vger.kernel.org>,
 "Hans de Goede" <hdegoede@redhat.com>, <Dell.Client.Kernel@dell.com>,
 "LKML" <linux-kernel@vger.kernel.org>, "Guenter Roeck" <linux@roeck-us.net>
Subject: Re: [PATCH v2 07/10] platform/x86: alienware-wmi-wmax: Add HWMON
 support
From: "Kurt Borja" <kuurtb@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250225222500.23535-1-kuurtb@gmail.com>
 <20250225222500.23535-8-kuurtb@gmail.com>
 <a85825d5-7718-93f4-e837-849323ef4387@linux.intel.com>
In-Reply-To: <a85825d5-7718-93f4-e837-849323ef4387@linux.intel.com>

On Tue Mar 4, 2025 at 10:53 AM -05, Ilpo J=C3=A4rvinen wrote:
> On Tue, 25 Feb 2025, Kurt Borja wrote:
>
>> All models with the "AWCC" WMAX device support monitoring fan speed and
>> temperature sensors. Expose this feature through the HWMON interface.
>>=20
>> Sensor readings are cached for 1 second before refreshing them to
>> mitigate the performance cost of calling WMI methods.
>>=20
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  drivers/platform/x86/dell/Kconfig             |   1 +
>>  .../platform/x86/dell/alienware-wmi-wmax.c    | 403 ++++++++++++++++++
>>  2 files changed, 404 insertions(+)
>>=20
>> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/de=
ll/Kconfig
>> index f8a0dffcaab7..85a57c01aaad 100644
>> --- a/drivers/platform/x86/dell/Kconfig
>> +++ b/drivers/platform/x86/dell/Kconfig
>> @@ -43,6 +43,7 @@ config ALIENWARE_WMI_WMAX
>>  	bool "Alienware WMAX WMI device driver"
>>  	default y
>>  	depends on ALIENWARE_WMI
>> +	depends on HWMON
>>  	select ACPI_PLATFORM_PROFILE
>>  	help
>>  	 Alienware WMI driver with AlienFX LED, HDMI, amplifier, deep sleep an=
d
>> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
>> index bbe87f91fcb6..818023a5b205 100644
>> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
>> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
>> @@ -9,10 +9,13 @@
>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> =20
>>  #include <linux/bitfield.h>
>> +#include <linux/bitmap.h>
>>  #include <linux/bits.h>
>>  #include <linux/dmi.h>
>> +#include <linux/hwmon.h>
>>  #include <linux/moduleparam.h>
>>  #include <linux/platform_profile.h>
>> +#include <linux/units.h>
>>  #include <linux/wmi.h>
>>  #include "alienware-wmi.h"
>> =20
>> @@ -25,6 +28,7 @@
>>  #define WMAX_METHOD_BRIGHTNESS			0x3
>>  #define WMAX_METHOD_ZONE_CONTROL		0x4
>> =20
>> +#define AWCC_METHOD_GET_FAN_SENSORS		0x13
>>  #define AWCC_METHOD_THERMAL_INFORMATION		0x14
>>  #define AWCC_METHOD_THERMAL_CONTROL		0x15
>>  #define AWCC_METHOD_GAME_SHIFT_STATUS		0x25
>> @@ -38,6 +42,10 @@
>>  /* Arbitrary limit based on supported models */
>>  #define AWCC_MAX_RES_COUNT			16
>> =20
>> +static bool force_hwmon;
>> +module_param_unsafe(force_hwmon, bool, 0);
>> +MODULE_PARM_DESC(force_hwmon, "Force probing for HWMON support without =
checking if the WMI backend is available");
>> +
>>  static bool force_platform_profile;
>>  module_param_unsafe(force_platform_profile, bool, 0);
>>  MODULE_PARM_DESC(force_platform_profile, "Forces auto-detecting thermal=
 profiles without checking if WMI thermal backend is available");
>> @@ -47,16 +55,19 @@ module_param_unsafe(force_gmode, bool, 0);
>>  MODULE_PARM_DESC(force_gmode, "Forces G-Mode when performance profile i=
s selected");
>> =20
>>  struct awcc_quirks {
>> +	bool hwmon;
>>  	bool pprof;
>>  	bool gmode;
>>  };
>> =20
>>  static struct awcc_quirks g_series_quirks =3D {
>> +	.hwmon =3D true,
>>  	.pprof =3D true,
>>  	.gmode =3D true,
>>  };
>> =20
>>  static struct awcc_quirks generic_quirks =3D {
>> +	.hwmon =3D true,
>>  	.pprof =3D true,
>>  	.gmode =3D false,
>>  };
>> @@ -154,9 +165,18 @@ static const struct dmi_system_id awcc_dmi_table[] =
__initconst =3D {
>>  	},
>>  };
>> =20
>> +enum AWCC_GET_FAN_SENSORS_OPERATIONS {
>> +	AWCC_OP_GET_TOTAL_FAN_TEMPS		=3D 0x01,
>> +	AWCC_OP_GET_FAN_TEMP_ID			=3D 0x02,
>> +};
>> +
>>  enum AWCC_THERMAL_INFORMATION_OPERATIONS {
>>  	AWCC_OP_GET_SYSTEM_DESCRIPTION		=3D 0x02,
>>  	AWCC_OP_GET_RESOURCE_ID			=3D 0x03,
>> +	AWCC_OP_GET_TEMPERATURE			=3D 0x04,
>> +	AWCC_OP_GET_FAN_RPM			=3D 0x05,
>> +	AWCC_OP_GET_FAN_MIN_RPM			=3D 0x08,
>> +	AWCC_OP_GET_FAN_MAX_RPM			=3D 0x09,
>>  	AWCC_OP_GET_CURRENT_PROFILE		=3D 0x0B,
>>  };
>> =20
>> @@ -179,6 +199,12 @@ enum AWCC_SPECIAL_THERMAL_CODES {
>>  	AWCC_SPECIAL_PROFILE_GMODE		=3D 0xAB,
>>  };
>> =20
>> +enum AWCC_TEMP_SENSOR_TYPES {
>> +	AWCC_TEMP_SENSOR_CPU			=3D 0x01,
>> +	AWCC_TEMP_SENSOR_GPU			=3D 0x06,
>> +	AWCC_TEMP_SENSOR_LAST
>> +};
>> +
>>  enum awcc_thermal_profile {
>>  	AWCC_PROFILE_USTT_BALANCED,
>>  	AWCC_PROFILE_USTT_BALANCED_PERFORMANCE,
>> @@ -215,6 +241,15 @@ struct wmax_u32_args {
>>  	u8 arg3;
>>  } __packed;
>> =20
>> +struct awcc_fan_data {
>> +	unsigned long *related_temps;
>> +	unsigned long *auto_channels_temp;
>> +	u32 total_temps;
>> +	u32 min_rpm;
>> +	u32 max_rpm;
>> +	u8 id;
>> +};
>> +
>>  struct awcc_priv {
>>  	struct wmi_device *wdev;
>>  	union {
>> @@ -230,6 +265,11 @@ struct awcc_priv {
>> =20
>>  	struct device *ppdev;
>>  	u8 supported_profiles[PLATFORM_PROFILE_LAST];
>> +
>> +	struct device *hwdev;
>> +	struct awcc_fan_data **fan_data;
>> +	unsigned int temp_sensors_size;
>> +	unsigned long *temp_sensors;
>>  };
>> =20
>>  static const enum platform_profile_option awcc_mode_to_platform_profile=
[AWCC_PROFILE_LAST] =3D {
>> @@ -494,6 +534,19 @@ static int __awcc_wmi_command(struct wmi_device *wd=
ev, u32 method_id,
>>  	return 0;
>>  }
>> =20
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
>>  static inline int awcc_thermal_information(struct wmi_device *wdev, u8 =
operation,
>>  					   u8 arg, u32 *out)
>>  {
>> @@ -564,6 +617,343 @@ static inline int awcc_op_get_resource_id(struct w=
mi_device *wdev, u8 index, u32
>>  	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args=
, out);
>>  }
>> =20
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
>> +
>> +	switch (type) {
>> +	case hwmon_temp:
>> +		if (channel < priv->temp_count)
>> +			return 0444;
>> +
>> +		break;
>
> IMO, these could be written as:
> 		return channel < priv->temp_count ? 0444 : 0;

Ack.

>
>> +	case hwmon_fan:
>> +		if (channel < priv->fan_count)
>> +			return 0444;
>> +
>> +		break;
>> +	case hwmon_pwm:
>> +		if (channel < priv->fan_count)
>> +			return 0444;
>> +
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return 0;
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
>> +		temp =3D find_nth_bit(priv->temp_sensors, U8_MAX, channel);
>> +		if (temp >=3D U8_MAX)
>
> It cannot be larger than as its type is u8??

Thanks, I forgot to change this! U8_MAX should be replaced with
priv->temp_sensors_size.

Thank you for reviewing this set! :)

--=20
 ~ Kurt

>
>> +			return -ENXIO;
>> +
>> +		switch (attr) {
>> +		case hwmon_temp_input:
>> +			ret =3D awcc_thermal_information(priv->wdev, AWCC_OP_GET_TEMPERATURE=
,
>> +						       temp, &state);
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
>> +			ret =3D awcc_thermal_information(priv->wdev, AWCC_OP_GET_FAN_RPM,
>> +						       fan->id, &state);
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
>> +		bitmap_copy(val, fan->auto_channels_temp, BITS_PER_LONG);
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
>> +		temp =3D find_nth_bit(priv->temp_sensors, U8_MAX, channel);
>> +		if (temp >=3D U8_MAX)
>> +			return -ENXIO;
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
>> +			temp =3D find_first_bit(fan->related_temps, U8_MAX);
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
>> +		ret =3D __test_and_set_bit(id, temp_sensors);
>> +		if (ret)
>> +			dev_warn(&wdev->dev, "Sensor ID at index %u is duplicated\n", i);
>> +	}
>> +
>> +	/*
>> +	 * We prefer to allocate the bitmap dynamically because usually temp I=
Ds
>> +	 * are small (< 0x30) and only one UL is needed to store it, but there
>> +	 * may be unknown devices that break this rule
>> +	 */
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
>> +	u32 id, min_rpm, max_rpm, total_fan_temps, temp_id;
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
>> +		if (!priv->temp_sensors)
>> +			return -ENOMEM;
>> +
>> +		fan_data->auto_channels_temp =3D devm_bitmap_zalloc(&wdev->dev,
>> +								  priv->temp_count,
>> +								  GFP_KERNEL);
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
>> +					   0, &total_fan_temps);
>> +		if (ret)
>> +			return ret;
>> +
>> +		for (j =3D 0; j < total_fan_temps; j++) {
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
>> +		fan_data->total_temps =3D total_fan_temps;
>> +		bitmap_gather(gather, fan_data->related_temps, priv->temp_sensors,
>> +			      priv->temp_sensors_size);
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
>>  /*
>>   * Thermal Profile control
>>   *  - Provides thermal profile control through the Platform Profile API
>> @@ -735,6 +1125,12 @@ static int alienware_awcc_setup(struct wmi_device =
*wdev)
>>  	priv->wdev =3D wdev;
>>  	dev_set_drvdata(&wdev->dev, priv);
>> =20
>> +	if (awcc->hwmon) {
>> +		ret =3D awcc_hwmon_init(wdev);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>  	if (awcc->pprof) {
>>  		ret =3D awcc_platform_profile_init(wdev);
>>  		if (ret)
>> @@ -815,6 +1211,13 @@ int __init alienware_wmax_wmi_init(void)
>>  	if (id)
>>  		awcc =3D id->driver_data;
>> =20
>> +	if (force_hwmon) {
>> +		if (!awcc)
>> +			awcc =3D &empty_quirks;
>> +
>> +		awcc->hwmon =3D true;
>> +	}
>> +
>>  	if (force_platform_profile) {
>>  		if (!awcc)
>>  			awcc =3D &empty_quirks;
>>=20


