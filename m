Return-Path: <linux-kernel+bounces-544825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B24A4E5B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBB619C20FB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8741F284B22;
	Tue,  4 Mar 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9uVmiJu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AEC27D773;
	Tue,  4 Mar 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103591; cv=none; b=WAktdjpxjvNhSYcqAytHdPkmABLGS6xhvu4ypT4+0gwYYIPWF2PTIBMOMkVWxM+8MESgW6MYKTKaAT/Z40UYUAl2ybcVy8KDMBYBbd3HWYLHeoF20TIXs0uHFNqCIAeB3ULRxHDG+vJYv1QfODLsoBTk/zvhAjd6WE4jSDAHjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103591; c=relaxed/simple;
	bh=IWVHK7brqH+F31MSftGaVK0Otp9zxu8kw3jotDbhL4s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sJAVJNEi0xUxxKpfW+5hbQeNyWy7M0k5C28CU/Na+deWC2+930mGTK3XzbtMXEAIel0SExtL1OAYJB2IEq1bgdt/boOat01WBs6ffDjkmKrgeiDijVuMX151RjLD2nACzQuq/M1k8u66s7Lf2ZaQu6skivshJbZVptIrbHXnmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9uVmiJu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741103589; x=1772639589;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IWVHK7brqH+F31MSftGaVK0Otp9zxu8kw3jotDbhL4s=;
  b=n9uVmiJujjyhgKDvK+16nEJVsdNpIGCkwpRmsWrdGLcSwazFAfN5SVUf
   CXsYYARzltxul9vY9DVFnVrTUwE5OPlJju1wOi9YgvyJ+vCOHkdNqh2aU
   0dk/c+DHuN9qjPfOaZAfynNHDOeAqzPc4Rb+zZuIsaSguWkelcS0s3Jy6
   ourMLBJLJ2V+m5IlF1Npg9xUb0s3x7kLG3Gja8UvdPKIcx5elS1bmfE+0
   aWyae+d72qphzqDqKXkXhlU0s+mnH7SoiS7JmwEayEvigM1DswlQLiigg
   Ligz9MIGOPVP0OgspSaiXlW+cOEqONTxKAlLoIG9Ot/2Vyz96RWiM82q1
   w==;
X-CSE-ConnectionGUID: BrQ2M4xwRkStakc3QeD7zA==
X-CSE-MsgGUID: DO6KrXUCQpy35Px7vjhWbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41276548"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="41276548"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:53:08 -0800
X-CSE-ConnectionGUID: LpnK4NlwSjOx6JrdNR3wnQ==
X-CSE-MsgGUID: u8xB5+TPQUKLU9+nbfeHjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="118405612"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.220])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:53:05 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 4 Mar 2025 17:53:01 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Armin Wolf <W_Armin@gmx.de>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, Dell.Client.Kernel@dell.com, 
    LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 07/10] platform/x86: alienware-wmi-wmax: Add HWMON
 support
In-Reply-To: <20250225222500.23535-8-kuurtb@gmail.com>
Message-ID: <a85825d5-7718-93f4-e837-849323ef4387@linux.intel.com>
References: <20250225222500.23535-1-kuurtb@gmail.com> <20250225222500.23535-8-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Feb 2025, Kurt Borja wrote:

> All models with the "AWCC" WMAX device support monitoring fan speed and
> temperature sensors. Expose this feature through the HWMON interface.
> 
> Sensor readings are cached for 1 second before refreshing them to
> mitigate the performance cost of calling WMI methods.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/platform/x86/dell/Kconfig             |   1 +
>  .../platform/x86/dell/alienware-wmi-wmax.c    | 403 ++++++++++++++++++
>  2 files changed, 404 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> index f8a0dffcaab7..85a57c01aaad 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -43,6 +43,7 @@ config ALIENWARE_WMI_WMAX
>  	bool "Alienware WMAX WMI device driver"
>  	default y
>  	depends on ALIENWARE_WMI
> +	depends on HWMON
>  	select ACPI_PLATFORM_PROFILE
>  	help
>  	 Alienware WMI driver with AlienFX LED, HDMI, amplifier, deep sleep and
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> index bbe87f91fcb6..818023a5b205 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -9,10 +9,13 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/bitfield.h>
> +#include <linux/bitmap.h>
>  #include <linux/bits.h>
>  #include <linux/dmi.h>
> +#include <linux/hwmon.h>
>  #include <linux/moduleparam.h>
>  #include <linux/platform_profile.h>
> +#include <linux/units.h>
>  #include <linux/wmi.h>
>  #include "alienware-wmi.h"
>  
> @@ -25,6 +28,7 @@
>  #define WMAX_METHOD_BRIGHTNESS			0x3
>  #define WMAX_METHOD_ZONE_CONTROL		0x4
>  
> +#define AWCC_METHOD_GET_FAN_SENSORS		0x13
>  #define AWCC_METHOD_THERMAL_INFORMATION		0x14
>  #define AWCC_METHOD_THERMAL_CONTROL		0x15
>  #define AWCC_METHOD_GAME_SHIFT_STATUS		0x25
> @@ -38,6 +42,10 @@
>  /* Arbitrary limit based on supported models */
>  #define AWCC_MAX_RES_COUNT			16
>  
> +static bool force_hwmon;
> +module_param_unsafe(force_hwmon, bool, 0);
> +MODULE_PARM_DESC(force_hwmon, "Force probing for HWMON support without checking if the WMI backend is available");
> +
>  static bool force_platform_profile;
>  module_param_unsafe(force_platform_profile, bool, 0);
>  MODULE_PARM_DESC(force_platform_profile, "Forces auto-detecting thermal profiles without checking if WMI thermal backend is available");
> @@ -47,16 +55,19 @@ module_param_unsafe(force_gmode, bool, 0);
>  MODULE_PARM_DESC(force_gmode, "Forces G-Mode when performance profile is selected");
>  
>  struct awcc_quirks {
> +	bool hwmon;
>  	bool pprof;
>  	bool gmode;
>  };
>  
>  static struct awcc_quirks g_series_quirks = {
> +	.hwmon = true,
>  	.pprof = true,
>  	.gmode = true,
>  };
>  
>  static struct awcc_quirks generic_quirks = {
> +	.hwmon = true,
>  	.pprof = true,
>  	.gmode = false,
>  };
> @@ -154,9 +165,18 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
>  	},
>  };
>  
> +enum AWCC_GET_FAN_SENSORS_OPERATIONS {
> +	AWCC_OP_GET_TOTAL_FAN_TEMPS		= 0x01,
> +	AWCC_OP_GET_FAN_TEMP_ID			= 0x02,
> +};
> +
>  enum AWCC_THERMAL_INFORMATION_OPERATIONS {
>  	AWCC_OP_GET_SYSTEM_DESCRIPTION		= 0x02,
>  	AWCC_OP_GET_RESOURCE_ID			= 0x03,
> +	AWCC_OP_GET_TEMPERATURE			= 0x04,
> +	AWCC_OP_GET_FAN_RPM			= 0x05,
> +	AWCC_OP_GET_FAN_MIN_RPM			= 0x08,
> +	AWCC_OP_GET_FAN_MAX_RPM			= 0x09,
>  	AWCC_OP_GET_CURRENT_PROFILE		= 0x0B,
>  };
>  
> @@ -179,6 +199,12 @@ enum AWCC_SPECIAL_THERMAL_CODES {
>  	AWCC_SPECIAL_PROFILE_GMODE		= 0xAB,
>  };
>  
> +enum AWCC_TEMP_SENSOR_TYPES {
> +	AWCC_TEMP_SENSOR_CPU			= 0x01,
> +	AWCC_TEMP_SENSOR_GPU			= 0x06,
> +	AWCC_TEMP_SENSOR_LAST
> +};
> +
>  enum awcc_thermal_profile {
>  	AWCC_PROFILE_USTT_BALANCED,
>  	AWCC_PROFILE_USTT_BALANCED_PERFORMANCE,
> @@ -215,6 +241,15 @@ struct wmax_u32_args {
>  	u8 arg3;
>  } __packed;
>  
> +struct awcc_fan_data {
> +	unsigned long *related_temps;
> +	unsigned long *auto_channels_temp;
> +	u32 total_temps;
> +	u32 min_rpm;
> +	u32 max_rpm;
> +	u8 id;
> +};
> +
>  struct awcc_priv {
>  	struct wmi_device *wdev;
>  	union {
> @@ -230,6 +265,11 @@ struct awcc_priv {
>  
>  	struct device *ppdev;
>  	u8 supported_profiles[PLATFORM_PROFILE_LAST];
> +
> +	struct device *hwdev;
> +	struct awcc_fan_data **fan_data;
> +	unsigned int temp_sensors_size;
> +	unsigned long *temp_sensors;
>  };
>  
>  static const enum platform_profile_option awcc_mode_to_platform_profile[AWCC_PROFILE_LAST] = {
> @@ -494,6 +534,19 @@ static int __awcc_wmi_command(struct wmi_device *wdev, u32 method_id,
>  	return 0;
>  }
>  
> +static inline int awcc_get_fan_sensors(struct wmi_device *wdev, u8 operation,
> +				       u8 fan_id, u8 index, u32 *out)
> +{
> +	struct wmax_u32_args args = {
> +		.operation = operation,
> +		.arg1 = fan_id,
> +		.arg2 = index,
> +		.arg3 = 0,
> +	};
> +
> +	return __awcc_wmi_command(wdev, AWCC_METHOD_GET_FAN_SENSORS, &args, out);
> +}
> +
>  static inline int awcc_thermal_information(struct wmi_device *wdev, u8 operation,
>  					   u8 arg, u32 *out)
>  {
> @@ -564,6 +617,343 @@ static inline int awcc_op_get_resource_id(struct wmi_device *wdev, u8 index, u32
>  	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
>  }
>  
> +/*
> + * HWMON
> + *  - Provides temperature and fan speed monitoring as well as manual fan
> + *    control
> + */
> +static umode_t awcc_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_types type,
> +				     u32 attr, int channel)
> +{
> +	const struct awcc_priv *priv = drvdata;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		if (channel < priv->temp_count)
> +			return 0444;
> +
> +		break;

IMO, these could be written as:
		return channel < priv->temp_count ? 0444 : 0;

> +	case hwmon_fan:
> +		if (channel < priv->fan_count)
> +			return 0444;
> +
> +		break;
> +	case hwmon_pwm:
> +		if (channel < priv->fan_count)
> +			return 0444;
> +
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int awcc_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			   u32 attr, int channel, long *val)
> +{
> +	struct awcc_priv *priv = dev_get_drvdata(dev);
> +	struct awcc_fan_data *fan;
> +	u32 state;
> +	int ret;
> +	u8 temp;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		temp = find_nth_bit(priv->temp_sensors, U8_MAX, channel);
> +		if (temp >= U8_MAX)

It cannot be larger than as its type is u8??

> +			return -ENXIO;
> +
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_TEMPERATURE,
> +						       temp, &state);
> +			if (ret)
> +				return ret;
> +
> +			*val = state * MILLIDEGREE_PER_DEGREE;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +
> +		break;
> +	case hwmon_fan:
> +		fan = priv->fan_data[channel];
> +
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_FAN_RPM,
> +						       fan->id, &state);
> +			if (ret)
> +				return ret;
> +
> +			*val = state;
> +			break;
> +		case hwmon_fan_min:
> +			*val = fan->min_rpm;
> +			break;
> +		case hwmon_fan_max:
> +			*val = fan->max_rpm;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +
> +		break;
> +	case hwmon_pwm:
> +		fan = priv->fan_data[channel];
> +
> +		bitmap_copy(val, fan->auto_channels_temp, BITS_PER_LONG);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int awcc_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
> +				  u32 attr, int channel, const char **str)
> +{
> +	struct awcc_priv *priv = dev_get_drvdata(dev);
> +	struct awcc_fan_data *fan;
> +	u8 temp;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		temp = find_nth_bit(priv->temp_sensors, U8_MAX, channel);
> +		if (temp >= U8_MAX)
> +			return -ENXIO;
> +
> +		switch (temp) {
> +		case AWCC_TEMP_SENSOR_CPU:
> +			*str = "CPU";
> +			break;
> +		case AWCC_TEMP_SENSOR_GPU:
> +			*str = "GPU";
> +			break;
> +		default:
> +			*str = "Unknown";
> +			break;
> +		}
> +
> +		break;
> +	case hwmon_fan:
> +		fan = priv->fan_data[channel];
> +
> +		switch (fan->total_temps) {
> +		case 0:
> +			*str = "Independent Fan";
> +			break;
> +		case 1:
> +			temp = find_first_bit(fan->related_temps, U8_MAX);
> +
> +			switch (temp) {
> +			case AWCC_TEMP_SENSOR_CPU:
> +				*str = "Processor Fan";
> +				break;
> +			case AWCC_TEMP_SENSOR_GPU:
> +				*str = "Video Fan";
> +				break;
> +			default:
> +				*str = "Unknown Fan";
> +				break;
> +			}
> +
> +			break;
> +		default:
> +			*str = "Shared Fan";
> +			break;
> +		}
> +
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops awcc_hwmon_ops = {
> +	.is_visible = awcc_hwmon_is_visible,
> +	.read = awcc_hwmon_read,
> +	.read_string = awcc_hwmon_read_string,
> +};
> +
> +static const struct hwmon_channel_info * const awcc_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_LABEL | HWMON_T_INPUT,
> +			   HWMON_T_LABEL | HWMON_T_INPUT,
> +			   HWMON_T_LABEL | HWMON_T_INPUT,
> +			   HWMON_T_LABEL | HWMON_T_INPUT,
> +			   HWMON_T_LABEL | HWMON_T_INPUT,
> +			   HWMON_T_LABEL | HWMON_T_INPUT
> +			   ),
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
> +			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX
> +			   ),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
> +			   HWMON_PWM_AUTO_CHANNELS_TEMP
> +			   ),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info awcc_hwmon_chip_info = {
> +	.ops = &awcc_hwmon_ops,
> +	.info = awcc_hwmon_info,
> +};
> +
> +static int awcc_hwmon_temps_init(struct wmi_device *wdev)
> +{
> +	struct awcc_priv *priv = dev_get_drvdata(&wdev->dev);
> +	unsigned long temp_sensors[BITS_TO_LONGS(U8_MAX)];
> +	unsigned int i, max_sensor_id = 0;
> +	int ret;
> +	u32 id;
> +
> +	for (i = 0; i < priv->temp_count; i++) {
> +		/*
> +		 * Temperature sensors IDs are listed after the fan IDs at
> +		 * offset `fan_count`
> +		 */
> +		ret = awcc_op_get_resource_id(wdev, i + priv->fan_count, &id);
> +		if (ret)
> +			return ret;
> +
> +		id = FIELD_GET(AWCC_RESOURCE_ID_MASK, id);
> +		if (id > max_sensor_id)
> +			max_sensor_id = id;
> +
> +		ret = __test_and_set_bit(id, temp_sensors);
> +		if (ret)
> +			dev_warn(&wdev->dev, "Sensor ID at index %u is duplicated\n", i);
> +	}
> +
> +	/*
> +	 * We prefer to allocate the bitmap dynamically because usually temp IDs
> +	 * are small (< 0x30) and only one UL is needed to store it, but there
> +	 * may be unknown devices that break this rule
> +	 */
> +	priv->temp_sensors_size = max_sensor_id + 1;
> +	priv->temp_sensors = devm_bitmap_zalloc(&wdev->dev, priv->temp_sensors_size,
> +						GFP_KERNEL);
> +	if (!priv->temp_sensors)
> +		return -ENOMEM;
> +
> +	bitmap_copy(priv->temp_sensors, temp_sensors, priv->temp_sensors_size);
> +
> +	return 0;
> +}
> +
> +static int awcc_hwmon_fans_init(struct wmi_device *wdev)
> +{
> +	struct awcc_priv *priv = dev_get_drvdata(&wdev->dev);
> +	u32 id, min_rpm, max_rpm, total_fan_temps, temp_id;
> +	unsigned long gather[BITS_TO_LONGS(U8_MAX)];
> +	struct awcc_fan_data *fan_data;
> +	unsigned int i, j;
> +	int ret;
> +
> +	for (i = 0; i < priv->fan_count; i++) {
> +		fan_data = devm_kzalloc(&wdev->dev, sizeof(*fan_data), GFP_KERNEL);
> +		if (!fan_data)
> +			return -ENOMEM;
> +
> +		fan_data->related_temps = devm_bitmap_zalloc(&wdev->dev,
> +							     priv->temp_sensors_size,
> +							     GFP_KERNEL);
> +		if (!priv->temp_sensors)
> +			return -ENOMEM;
> +
> +		fan_data->auto_channels_temp = devm_bitmap_zalloc(&wdev->dev,
> +								  priv->temp_count,
> +								  GFP_KERNEL);
> +		if (!priv->temp_sensors)
> +			return -ENOMEM;
> +
> +		/*
> +		 * Fan IDs are listed first at offset 0
> +		 */
> +		ret = awcc_op_get_resource_id(wdev, i, &id);
> +		if (ret)
> +			return ret;
> +		id = FIELD_GET(AWCC_RESOURCE_ID_MASK, id);
> +
> +		ret = awcc_thermal_information(wdev, AWCC_OP_GET_FAN_MIN_RPM, id,
> +					       &min_rpm);
> +		if (ret)
> +			return ret;
> +
> +		ret = awcc_thermal_information(wdev, AWCC_OP_GET_FAN_MAX_RPM, id,
> +					       &max_rpm);
> +		if (ret)
> +			return ret;
> +
> +		ret = awcc_get_fan_sensors(wdev, AWCC_OP_GET_TOTAL_FAN_TEMPS, id,
> +					   0, &total_fan_temps);
> +		if (ret)
> +			return ret;
> +
> +		for (j = 0; j < total_fan_temps; j++) {
> +			ret = awcc_get_fan_sensors(wdev, AWCC_OP_GET_FAN_TEMP_ID,
> +						   id, j, &temp_id);
> +			if (ret)
> +				break;
> +
> +			temp_id = FIELD_GET(AWCC_RESOURCE_ID_MASK, temp_id);
> +			if (temp_id < priv->temp_sensors_size)
> +				__set_bit(temp_id, fan_data->related_temps);
> +		}
> +
> +		fan_data->id = id;
> +		fan_data->min_rpm = min_rpm;
> +		fan_data->max_rpm = max_rpm;
> +		fan_data->total_temps = total_fan_temps;
> +		bitmap_gather(gather, fan_data->related_temps, priv->temp_sensors,
> +			      priv->temp_sensors_size);
> +		bitmap_copy(fan_data->auto_channels_temp, gather, priv->temp_count);
> +		priv->fan_data[i] = fan_data;
> +	}
> +
> +	return 0;
> +}
> +
> +static int awcc_hwmon_init(struct wmi_device *wdev)
> +{
> +	struct awcc_priv *priv = dev_get_drvdata(&wdev->dev);
> +	int ret;
> +
> +	priv->fan_data = devm_kcalloc(&wdev->dev, priv->fan_count,
> +				      sizeof(*priv->fan_data), GFP_KERNEL);
> +	if (!priv->fan_data)
> +		return -ENOMEM;
> +
> +	ret = awcc_hwmon_temps_init(wdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = awcc_hwmon_fans_init(wdev);
> +	if (ret)
> +		return ret;
> +
> +	priv->hwdev = devm_hwmon_device_register_with_info(&wdev->dev, "alienware_wmi", priv,
> +							   &awcc_hwmon_chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(priv->hwdev);
> +}
> +
>  /*
>   * Thermal Profile control
>   *  - Provides thermal profile control through the Platform Profile API
> @@ -735,6 +1125,12 @@ static int alienware_awcc_setup(struct wmi_device *wdev)
>  	priv->wdev = wdev;
>  	dev_set_drvdata(&wdev->dev, priv);
>  
> +	if (awcc->hwmon) {
> +		ret = awcc_hwmon_init(wdev);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (awcc->pprof) {
>  		ret = awcc_platform_profile_init(wdev);
>  		if (ret)
> @@ -815,6 +1211,13 @@ int __init alienware_wmax_wmi_init(void)
>  	if (id)
>  		awcc = id->driver_data;
>  
> +	if (force_hwmon) {
> +		if (!awcc)
> +			awcc = &empty_quirks;
> +
> +		awcc->hwmon = true;
> +	}
> +
>  	if (force_platform_profile) {
>  		if (!awcc)
>  			awcc = &empty_quirks;
> 

-- 
 i.


