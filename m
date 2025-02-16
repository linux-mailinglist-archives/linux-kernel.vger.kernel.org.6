Return-Path: <linux-kernel+bounces-516814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABEAA377C8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE13116C408
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A79C1A3A8D;
	Sun, 16 Feb 2025 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmqIP0Uk"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873FF14A60A;
	Sun, 16 Feb 2025 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739741282; cv=none; b=baOqP2wSDzlUjsrRIfULQBFBPpZ52yzAdWtpEOcRVCnHOxu4ttlimIrZYpObNBAplc6MqfzbRFyM/G3a7Cr0a1xsxiGVjBbqqPPZ65ZkOUkvqHrIs4LxgXg2hpRKw+J5I+AA7WwwdFX/2x+EQV4IaxfM6AbfFcl/Q5ntOzGGPDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739741282; c=relaxed/simple;
	bh=ZlIP818OGYgmtE8krZgSMdArQUqOQyRPbKw9CW3S1Ug=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=roAmsmz1N0+5wrYbL1g/ExkVkllawhu0JM0jBqM+dPcb2Gwm4eLbhZu4xUo6ikG81FqJAh8CPC0zCbpNJLlIf6tMLCTtSWBRdcPeaZ4eUlHjp3JtA8UEYKKwY7Ohiv6+odyN2+pHwkqnPbW8KwXc08yogsKM1sFax1FHzUY5ghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmqIP0Uk; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f6ca9a3425so32333597b3.2;
        Sun, 16 Feb 2025 13:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739741279; x=1740346079; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkcH5qTX4vWblemvl4QCa64WEKZPw0I3Qp2iYEmubbg=;
        b=YmqIP0Ukc5ayWAcHubQMxuLdPRT4xjLZ5zFhpY7ZQZggGvXIHyoB7FwQNWkRYHyl4A
         Rz3+Zj5AUKJLNasVJAQHmY7cfqj1o2n+VTBNu546g2cYusMD38oWV3NvMjgXa/Wqv2tZ
         1jIlLjBrQnZYcfMK4DmuHnYC07yS5fBOW8QKkWz3tkwjn+O5L6tfXDBQngsv/9YTTcvq
         BDvnlBxIxIot9rw7IrP/u4Bh0VXphxXd5FYLufHY8wkP5/yN59Qm9PRXmL1vJau4hqh/
         3g8K8o/TzHaHMlTYLU15JnNROYGjjHyBH8Wm7xXBfiILvZ2jqBOFRdF8oPNQf4hQQLzf
         ouNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739741279; x=1740346079;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IkcH5qTX4vWblemvl4QCa64WEKZPw0I3Qp2iYEmubbg=;
        b=c4qpvsoIq6Op1M3xuLKvpK6rHpZeNdAp8UF9KNcy3DKllOG4C3pYf8n3yqHwA180qy
         2WDZhGleBmOUmRhBED0k33qnXqfrTQ70NueE9dfiV54vVk4K+LW8GcQvC37e2Xt1pZcZ
         dE39IYcyzFBoxRKggVNqg0Prt+AuHgkCfg0fDqNcGNnkP+zag+Nf7ynGzhP9RzIQRDYh
         ZZx1N6nJLNfWqnXBMuHzGMiIWp4z9U6t5n8zTsHmsF/6wze33hmuntXtFhTk6se6KcUb
         BWK+Q6bGFMDKevARJ4T/vhjnP/JYbS1nrngXJ7jMl2j8Gc6Wcqbg3kW9L0F5rrlSd494
         GZxw==
X-Forwarded-Encrypted: i=1; AJvYcCU7KZb2TJTpqIjAm5wW4lMzfasGCbznsOa6ZtdDbRR+8a4/QIlOV72rhzx+tzQZSIIkvB+fqZ3LKff+OVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfzaVEfjN3QkZ1bWSq5yAtyEE4bHuFut9IBdlCWUiGdlAdZtPW
	qN+LwtS+HrIxeBUjXs4KbSEk4oyDMz42P1xBdR8gL67OmVInphPa
X-Gm-Gg: ASbGncu/FK3O3PoLalc19scNuwLZChkant+vhrh2q3Ick83ud3YP2qce8FT3ijnIhoR
	xL0Qs1602bM4439ivDaoqaBj3Tx/O7yBFHvtQSCJoFp7uZM4+paOcorbkn3g3P68vjSevA/GFV6
	pNZc8Q2l0p6UIw8RTbQGhL31RPAHiBX3RB99IOEHbMjc3obzgJsnggwMSOnA0CgAKBn8o14qQBX
	fmsWrFx0tlClvRbKp16gNb5FdVixMaNwwlONFdLfdQDyfcZDi/h48u3RjpNfIYIehSDv1isWMDr
	fA10ihM=
X-Google-Smtp-Source: AGHT+IFeJtv3wIC5zs3GjEuALa8E/sFOCllVz5IFE8D3WLG9XBFR/tbBNKssAZP4xJ2m7tUMRSL1tQ==
X-Received: by 2002:a05:690c:6907:b0:6ef:827b:2442 with SMTP id 00721157ae682-6fb58360af6mr54845667b3.35.1739741279347;
        Sun, 16 Feb 2025 13:27:59 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb5e68f65asm7877607b3.21.2025.02.16.13.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 13:27:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Feb 2025 16:27:55 -0500
Message-Id: <D7U6T8P3M0Z8.2RBEJ9LYOYPU9@gmail.com>
Cc: <platform-driver-x86@vger.kernel.org>, "Hans de Goede"
 <hdegoede@redhat.com>, <Dell.Client.Kernel@dell.com>,
 <linux-kernel@vger.kernel.org>, "Guenter Roeck" <linux@roeck-us.net>
Subject: Re: [PATCH 07/10] platform/x86: alienware-wmi-wmax: Add HWMON
 support
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Armin Wolf" <W_Armin@gmx.de>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250208051614.10644-1-kuurtb@gmail.com>
 <20250208051614.10644-8-kuurtb@gmail.com>
 <c8120567-eb9b-49e1-aedd-cf1aed90e2d7@gmx.de>
In-Reply-To: <c8120567-eb9b-49e1-aedd-cf1aed90e2d7@gmx.de>

On Sun Feb 16, 2025 at 1:06 AM -05, Armin Wolf wrote:
> Am 08.02.25 um 06:16 schrieb Kurt Borja:
>
>> All models with the "AWCC" WMAX device support monitoring fan speed and
>> temperature sensors. Expose this feature through the HWMON interface.
>>
>> Sensor readings are cached for 1 second before refreshing them to
>> mitigate the performance cost of calling WMI methods.
>
> Since each fan can be accessed independently, i do not think that the cac=
hing is actually
> needed here.
>
> The dell-wmi-ddv driver only uses caching because it can only read all fa=
n sensors
> at the same time, which means each call is quite expensive. The AWCC inte=
rface however
> seems to allow access to each individual fan, so each call should be quit=
e cheap (for
> a WMI method call).
>
> Do you know of a device which has such slow WMI calls? If not then i sugg=
est you remove
> the caching.

I was under the impression that all WMI calls are a bit "expensive" in
the performance sense. Also the AWCC OEM windows app slows down your
computer a LOT, actually unusable while gaming and I figured this had
something to do with it.

I'm going to do some tests. If the performance cost is not noticeable I
will drop it.

--=20
 ~ Kurt

>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>   drivers/platform/x86/dell/Kconfig             |   1 +
>>   .../platform/x86/dell/alienware-wmi-wmax.c    | 341 ++++++++++++++++++
>>   2 files changed, 342 insertions(+)
>>
>> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/de=
ll/Kconfig
>> index f8a0dffcaab7..85a57c01aaad 100644
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
>> index 0d31156f43bb..5f02da7ff25f 100644
>> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
>> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
>> @@ -11,9 +11,13 @@
>>   #include <linux/bitfield.h>
>>   #include <linux/bits.h>
>>   #include <linux/dmi.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/jiffies.h>
>>   #include <linux/moduleparam.h>
>> +#include <linux/mutex.h>
>>   #include <linux/overflow.h>
>>   #include <linux/platform_profile.h>
>> +#include <linux/units.h>
>>   #include <linux/wmi.h>
>>   #include "alienware-wmi.h"
>>
>> @@ -26,6 +30,7 @@
>>   #define WMAX_METHOD_BRIGHTNESS			0x3
>>   #define WMAX_METHOD_ZONE_CONTROL		0x4
>>
>> +#define AWCC_METHOD_GET_FAN_SENSORS		0x13
>>   #define AWCC_METHOD_THERMAL_INFORMATION		0x14
>>   #define AWCC_METHOD_THERMAL_CONTROL		0x15
>>   #define AWCC_METHOD_GAME_SHIFT_STATUS		0x25
>> @@ -36,6 +41,10 @@
>>   #define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
>>   #define AWCC_RESOURCE_ID_MASK			GENMASK(7, 0)
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
>> @@ -45,16 +54,19 @@ module_param_unsafe(force_gmode, bool, 0);
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
>> @@ -152,9 +164,17 @@ static const struct dmi_system_id awcc_dmi_table[] =
__initconst =3D {
>>   	},
>>   };
>>
>> +enum AWCC_GET_FAN_SENSORS_OPERATIONS {
>> +	AWCC_OP_GET_TEMP_SENSOR_ID		=3D 0x02,
>> +};
>> +
>>   enum AWCC_THERMAL_INFORMATION_OPERATIONS {
>>   	AWCC_OP_GET_SYSTEM_DESCRIPTION		=3D 0x02,
>>   	AWCC_OP_GET_RESOURCE_ID			=3D 0x03,
>> +	AWCC_OP_GET_TEMPERATURE			=3D 0x04,
>> +	AWCC_OP_GET_CURRENT_RPM			=3D 0x05,
>> +	AWCC_OP_GET_MIN_RPM			=3D 0x08,
>> +	AWCC_OP_GET_MAX_RPM			=3D 0x09,
>>   	AWCC_OP_GET_CURRENT_PROFILE		=3D 0x0B,
>>   };
>>
>> @@ -177,6 +197,11 @@ enum AWCC_SPECIAL_THERMAL_CODES {
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
>> @@ -213,6 +238,23 @@ struct wmax_u32_args {
>>   	u8 arg3;
>>   } __packed;
>>
>> +struct awcc_fan_channel_data {
>> +	u8 id;
>> +	u32 state;
>> +	u32 min_rpm;
>> +	u32 max_rpm;
>> +	u8 temp_sensor;
>> +	u64 timestamp;
>> +	struct mutex lock; /* protects state and timestamp */
>> +};
>> +
>> +struct awcc_temp_channel_data {
>> +	u8 id;
>> +	u32 state;
>> +	u64 timestamp;
>> +	struct mutex lock; /* protects state and timestamp */
>> +};
>> +
>>   struct awcc_priv {
>>   	struct wmi_device *wdev;
>>   	union {
>> @@ -228,6 +270,10 @@ struct awcc_priv {
>>
>>   	struct device *ppdev;
>>   	u8 supported_profiles[PLATFORM_PROFILE_LAST];
>> +
>> +	struct device *hwdev;
>> +	struct awcc_temp_channel_data *temp_data;
>> +	struct awcc_fan_channel_data *fan_data;
>>   };
>>
>>   static const enum platform_profile_option awcc_mode_to_platform_profil=
e[AWCC_PROFILE_LAST] =3D {
>> @@ -492,6 +538,18 @@ static int __awcc_wmi_command(struct wmi_device *wd=
ev, u32 method_id,
>>   	return 0;
>>   }
>>
>> +static inline int awcc_get_fan_sensors(struct wmi_device *wdev, u8 fan_=
id, u32 *out)
>> +{
>> +	struct wmax_u32_args args =3D {
>> +		.operation =3D AWCC_OP_GET_TEMP_SENSOR_ID,
>> +		.arg1 =3D fan_id,
>> +		.arg2 =3D 0,
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
>> @@ -562,6 +620,276 @@ static inline int awcc_op_get_resource_id(struct w=
mi_device *wdev, u8 index, u32
>>   	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &arg=
s, out);
>>   }
>>
>> +/*
>> + * HWMON
>> + *  - Provides temperature and fan speed monitoring as well as manual f=
an
>> + *    control
>> + */
>> +static int awcc_hwmon_update_temp(struct wmi_device *wdev,
>> +				  struct awcc_temp_channel_data *data)
>> +{
>> +	u32 temp;
>> +	int ret;
>> +
>> +	lockdep_assert_held(data->lock);
>> +
>> +	if (time_is_after_jiffies64(data->timestamp + secs_to_jiffies(1)))
>> +		return 0;
>> +
>> +	ret =3D awcc_thermal_information(wdev, AWCC_OP_GET_TEMPERATURE, data->=
id,
>> +				       &temp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	data->state =3D temp * MILLIDEGREE_PER_DEGREE;
>> +	data->timestamp =3D get_jiffies_64();
>> +
>> +	return 0;
>> +}
>> +
>> +static int awcc_hwmon_update_fan(struct wmi_device *wdev,
>> +				 struct awcc_fan_channel_data *data)
>> +{
>> +	u32 rpm;
>> +	int ret;
>> +
>> +	lockdep_assert_held(data->lock);
>> +
>> +	if (time_is_after_jiffies64(data->timestamp + secs_to_jiffies(1)))
>> +		return 0;
>> +
>> +	ret =3D awcc_thermal_information(wdev, AWCC_OP_GET_CURRENT_RPM, data->=
id,
>> +				       &rpm);
>> +	if (ret)
>> +		return ret;
>> +
>> +	data->state =3D rpm;
>> +	data->timestamp =3D get_jiffies_64();
>> +
>> +	return 0;
>> +}
>> +
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
>> +	case hwmon_fan:
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
>> +	struct awcc_temp_channel_data *temp;
>> +	struct awcc_fan_channel_data *fan;
>> +	int ret;
>> +
>> +	switch (type) {
>> +	case hwmon_temp:
>> +		temp =3D &priv->temp_data[channel];
>> +
>> +		switch (attr) {
>> +		case hwmon_temp_input:
>> +			mutex_lock(&temp->lock);
>> +			ret =3D awcc_hwmon_update_temp(priv->wdev, temp);
>> +			mutex_unlock(&temp->lock);
>> +			if (ret)
>> +				return ret;
>> +
>> +			*val =3D temp->state;
>> +			break;
>> +		default:
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>> +		break;
>> +	case hwmon_fan:
>> +		fan =3D &priv->fan_data[channel];
>> +
>> +		switch (attr) {
>> +		case hwmon_fan_input:
>> +			mutex_lock(&fan->lock);
>> +			ret =3D awcc_hwmon_update_fan(priv->wdev, fan);
>> +			mutex_unlock(&fan->lock);
>> +			if (ret)
>> +				return ret;
>> +
>> +			*val =3D fan->state;
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
>> +	u8 temp_id;
>> +
>> +	switch (type) {
>> +	case hwmon_temp:
>> +		temp_id =3D priv->temp_data[channel].id;
>> +
>> +		switch (temp_id) {
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
>> +		temp_id =3D priv->fan_data[channel].temp_sensor;
>> +
>> +		switch (temp_id) {
>> +		case AWCC_TEMP_SENSOR_CPU:
>> +			*str =3D "Processor Fan";
>> +			break;
>> +		case AWCC_TEMP_SENSOR_GPU:
>> +			*str =3D "Video Fan";
>> +			break;
>> +		default:
>> +			*str =3D "Unknown Fan";
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
>> +			   HWMON_T_LABEL | HWMON_T_INPUT
>> +			   ),
>> +	HWMON_CHANNEL_INFO(fan,
>> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX
>> +			   ),
>> +	NULL
>> +};
>> +
>> +static const struct hwmon_chip_info awcc_hwmon_chip_info =3D {
>> +	.ops =3D &awcc_hwmon_ops,
>> +	.info =3D awcc_hwmon_info,
>> +};
>> +
>> +static int awcc_hwmon_init(struct wmi_device *wdev)
>> +{
>> +	struct awcc_priv *priv =3D dev_get_drvdata(&wdev->dev);
>> +	u32 id, temp_sensor, min_rpm, max_rpm;
>> +	int ret;
>> +
>> +	priv->fan_data =3D devm_kcalloc(&wdev->dev, priv->fan_count,
>> +				      sizeof(*priv->fan_data), GFP_KERNEL);
>> +	if (!priv->fan_data)
>> +		return -ENOMEM;
>> +
>> +	priv->temp_data =3D devm_kcalloc(&wdev->dev, priv->temp_count,
>> +				       sizeof(*priv->temp_data), GFP_KERNEL);
>> +	if (!priv->temp_data)
>> +		return -ENOMEM;
>> +
>> +	for (u32 i =3D 0; i < priv->fan_count; i++) {
>> +		/*
>> +		 * Fan IDs are listed first at offset 0
>> +		 */
>> +		ret =3D awcc_op_get_resource_id(wdev, i, &id);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret =3D awcc_thermal_information(wdev, AWCC_OP_GET_MIN_RPM, id,
>> +					       &min_rpm);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret =3D awcc_thermal_information(wdev, AWCC_OP_GET_MAX_RPM, id,
>> +					       &max_rpm);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret =3D awcc_get_fan_sensors(wdev, id, &temp_sensor);
>> +		if (ret)
>> +			return ret;
>> +
>> +		priv->fan_data[i].id =3D FIELD_GET(AWCC_RESOURCE_ID_MASK, id);
>> +		priv->fan_data[i].min_rpm =3D min_rpm;
>> +		priv->fan_data[i].max_rpm =3D max_rpm;
>> +		priv->fan_data[i].temp_sensor =3D temp_sensor;
>> +		ret =3D devm_mutex_init(&wdev->dev, &priv->fan_data[i].lock);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	for (u32 i =3D 0; i < priv->temp_count; i++) {
>> +		/*
>> +		 * Temperature sensors IDs are listed after the fan IDs at
>> +		 * offset `fan_count`
>> +		 */
>> +		ret =3D awcc_op_get_resource_id(wdev, i + priv->fan_count, &id);
>> +		if (ret)
>> +			return ret;
>> +
>> +		priv->temp_data[i].id =3D FIELD_GET(AWCC_RESOURCE_ID_MASK, id);
>> +		ret =3D devm_mutex_init(&wdev->dev, &priv->temp_data[i].lock);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	priv->hwdev =3D devm_hwmon_device_register_with_info(
>> +		&wdev->dev, "alienware_wmi", priv, &awcc_hwmon_chip_info, NULL);
>
> checkpatch says "CHECK: Lines should not end with a '('". Please fix this=
.
>
> Other than that the code looks promising.
>
> Thanks,
> Armin Wolf
>
>> +
>> +	return PTR_ERR_OR_ZERO(priv->hwdev);
>> +}
>> +
>>   /*
>>    * Thermal Profile control
>>    *  - Provides thermal profile control through the Platform Profile AP=
I
>> @@ -734,6 +1062,12 @@ static int alienware_awcc_setup(struct wmi_device =
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
>> @@ -814,6 +1148,13 @@ int __init alienware_wmax_wmi_init(void)
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


