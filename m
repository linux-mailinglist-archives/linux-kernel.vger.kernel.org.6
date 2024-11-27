Return-Path: <linux-kernel+bounces-423333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D6B9DA603
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96964B2B3F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB22D198825;
	Wed, 27 Nov 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcbbwxGk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD6C155389;
	Wed, 27 Nov 2024 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703750; cv=none; b=Bai9/DwDgDLfI4rrtiUpvlGovfJuHegzZQTUvXmpVEwSeoPn9UC80f8hyUGqOVtJuQETKKMyjPjgcKKvDbZwf4hJ8WMgokd74RE+4hmQpZCg5pONpqNzIc3xDqzqQQPSO1CQM7pT5fVnGxc+nnYRyaNvHxInf4L3Wn3gYGSTWdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703750; c=relaxed/simple;
	bh=xSsoAwz5YdjoQs8Ugsh0qhSOY15rRs6wgiZNNTBrzj8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O0PDEzW5xOqJKaRXdZwkHg4gDuKZgotLH7Y/jUngEpiBe/JSQof8XmEj8/3Umr2hx+tntti3u/pirxnTZ7SkqQJd4yUeT6Y5uV7wwyuVrJ87oW8cuj2uLnTt4ImfOkfCHVNA52WTmus/eSUnaB4KpbplNoVsSucmfcUsvEYa3bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcbbwxGk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732703749; x=1764239749;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xSsoAwz5YdjoQs8Ugsh0qhSOY15rRs6wgiZNNTBrzj8=;
  b=bcbbwxGkezcIwbBmhJOjWuNbhzKevsNmtJ93YcZGTqmrhHl3EiApcZod
   zEAvJNxqZYhCR6utFTN0u9uGKQ445cwCD5gzXP+vT9BDXp14Z+a2TPQVH
   82kXg2UC+9Fwpw6c1u7GIyOeRUcwE85j9zEp2Ci2e/MHvNIwk1SW4OWCF
   7VF6kZymVz1BzeuIgqePpbkNsOIXX7gDNCV+BTIlmNxFhmglVPKOdcC9Y
   +59O6OPwzALab1Ql6ZLbj7+n5qIuJ3bzQYFP/JHrc94cjDVhQCmtstAsr
   cVgAbxw7Zjt6XW0KdvIY1EXvR0I+sW0zkTKHHVzcKSX/dUpXiuXgFkMXV
   A==;
X-CSE-ConnectionGUID: ZKSBnNOpQMa6u7mVTUn5tg==
X-CSE-MsgGUID: ez5uGwbFR6GRimYDLkGt4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="36567242"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="36567242"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 02:35:48 -0800
X-CSE-ConnectionGUID: zO98KXhOR724kgcvtsCh/Q==
X-CSE-MsgGUID: ujRGJs99RO2Ca4avrTbUFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="92222869"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 02:35:45 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 27 Nov 2024 12:35:42 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: jlee@suse.com, farhan.anwar8@gmail.com, rayanmargham4@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/5] platform/x86: acer-wmi: Add support for temperature
 sensors
In-Reply-To: <20241124171426.29203-4-W_Armin@gmx.de>
Message-ID: <de215c4c-4356-a3e2-7ed3-c1f12c30635c@linux.intel.com>
References: <20241124171426.29203-1-W_Armin@gmx.de> <20241124171426.29203-4-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 24 Nov 2024, Armin Wolf wrote:

> After looking at the ACPI AML code, it seems that the command 0x0000
> used with ACER_WMID_GET_GAMING_SYS_INFO_METHODID returns a bitmap of
> all supported sensors available through the 0x0001 command.
> 
> Add support for this command and the additional temperature sensors.

I had to read quite a bit of code before understanding how this changed
what was a few hard-coded sensor IDs embedded inside the old wmi commands 
into a more generalized approach using what turned out to be a field of 
sensors. Perhaps you could explain more here.

> This also fixed detection of fan sensors should the fan not spin
> during device initialization.

This too comes out of the woods because the old way of doing things is 
entirely overlooked by this commit message.

> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/acer-wmi.c | 129 ++++++++++++++++++++++++--------
>  1 file changed, 96 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index dd57787466b9..7b549920eba7 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -30,6 +30,7 @@
>  #include <linux/input/sparse-keymap.h>
>  #include <acpi/video.h>
>  #include <linux/hwmon.h>
> +#include <linux/units.h>
>  #include <linux/bitfield.h>
> 
>  MODULE_AUTHOR("Carlos Corbacho");
> @@ -70,7 +71,8 @@ MODULE_LICENSE("GPL");
> 
>  #define ACER_PREDATOR_V4_THERMAL_PROFILE_EC_OFFSET 0x54
> 
> -#define ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK GENMASK(20, 8)
> +#define ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK GENMASK(24, 8)
> +#define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK(40, 24)
> 
>  /*
>   * Acer ACPI method GUIDs
> @@ -98,9 +100,17 @@ enum acer_wmi_event_ids {
>  };
> 
>  enum acer_wmi_predator_v4_sys_info_command {
> -	ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS = 0x02,
> -	ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED = 0x0201,
> -	ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED = 0x0601,
> +	ACER_WMID_CMD_GET_PREDATOR_V4_SUPPORTED_SENSORS = 0x0000,
> +	ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING = 0x0001,
> +	ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS = 0x0002,
> +};
> +
> +enum acer_wmi_predator_v4_sensor_id {
> +	ACER_WMID_SENSOR_CPU_TEMPERATURE = 0x01,
> +	ACER_WMID_SENSOR_CPU_FAN_SPEED = 0x02,
> +	ACER_WMID_SENSOR_EXTERNAL_TEMPERATURE_2 = 0x03,
> +	ACER_WMID_SENSOR_GPU_FAN_SPEED = 0x06,
> +	ACER_WMID_SENSOR_GPU_TEMPERATURE = 0x0A,

Please align values in both enums.

>  };
> 
>  static const struct key_entry acer_wmi_keymap[] __initconst = {
> @@ -271,6 +281,7 @@ static u16 commun_func_bitmap;
>  static u8 commun_fn_key_number;
>  static bool cycle_gaming_thermal_profile = true;
>  static bool predator_v4;
> +static u64 supported_sensors;
> 
>  module_param(mailled, int, 0444);
>  module_param(brightness, int, 0444);
> @@ -1513,6 +1524,24 @@ static acpi_status WMID_gaming_get_u64(u64 *value, u32 cap)
>  	return status;
>  }
> 
> +static int WMID_gaming_get_sys_info(u32 command, u64 *out)
> +{
> +	acpi_status status;
> +	u64 result;
> +
> +	status = WMI_gaming_execute_u64(ACER_WMID_GET_GAMING_SYS_INFO_METHODID, command, &result);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	/* The lower 8 bits must be zero for the operation to have succeeded */
> +	if (result & 0xff)

Could we name this field and use FIELD_GET()?

> +		return -EIO;
> +
> +	*out = result;
> +
> +	return 0;
> +}
> +
>  static void WMID_gaming_set_fan_mode(u8 fan_mode)
>  {
>  	/* fan_mode = 1 is used for auto, fan_mode = 2 used for turbo*/
> @@ -1760,26 +1789,6 @@ static int acer_gsensor_event(void)
>  	return 0;
>  }
> 
> -static int acer_get_fan_speed(int fan)
> -{
> -	if (quirks->predator_v4) {
> -		acpi_status status;
> -		u64 fanspeed;
> -
> -		status = WMI_gaming_execute_u64(
> -			ACER_WMID_GET_GAMING_SYS_INFO_METHODID,
> -			fan == 0 ? ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED :
> -				   ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED,
> -			&fanspeed);
> -
> -		if (ACPI_FAILURE(status))
> -			return -EIO;
> -
> -		return FIELD_GET(ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK, fanspeed);
> -	}
> -	return -EOPNOTSUPP;
> -}
> -
>  /*
>   *  Predator series turbo button
>   */
> @@ -2671,43 +2680,86 @@ static void __init create_debugfs(void)
>  			   &interface->debug.wmid_devices);
>  }
> 
> +static const enum acer_wmi_predator_v4_sensor_id acer_wmi_temp_channel_to_sensor_id[] = {
> +	[0] = ACER_WMID_SENSOR_CPU_TEMPERATURE,
> +	[1] = ACER_WMID_SENSOR_GPU_TEMPERATURE,
> +	[2] = ACER_WMID_SENSOR_EXTERNAL_TEMPERATURE_2,
> +};
> +
> +static const enum acer_wmi_predator_v4_sensor_id acer_wmi_fan_channel_to_sensor_id[] = {
> +	[0] = ACER_WMID_SENSOR_CPU_FAN_SPEED,
> +	[1] = ACER_WMID_SENSOR_GPU_FAN_SPEED,
> +};
> +
>  static umode_t acer_wmi_hwmon_is_visible(const void *data,
>  					 enum hwmon_sensor_types type, u32 attr,
>  					 int channel)
>  {
> +	enum acer_wmi_predator_v4_sensor_id sensor_id;
> +	const u64 *supported_sensors = data;
> +
>  	switch (type) {
> +	case hwmon_temp:
> +		sensor_id = acer_wmi_temp_channel_to_sensor_id[channel];
> +		break;
>  	case hwmon_fan:
> -		if (acer_get_fan_speed(channel) >= 0)
> -			return 0444;
> +		sensor_id = acer_wmi_fan_channel_to_sensor_id[channel];
>  		break;
>  	default:
>  		return 0;
>  	}
> 
> +	if (*supported_sensors & BIT(sensor_id - 1))
> +		return 0444;
> +
>  	return 0;
>  }
> 
>  static int acer_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  			       u32 attr, int channel, long *val)
>  {
> +	enum acer_wmi_predator_v4_sensor_id sensor_id;
> +	u64 command, result;
>  	int ret;
> 
>  	switch (type) {
> +	case hwmon_temp:
> +		sensor_id = acer_wmi_temp_channel_to_sensor_id[channel];
> +		command = ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING | (sensor_id << 8);

Please use FIELD_PREP() and a named define.

> +
> +		ret = WMID_gaming_get_sys_info(command, &result);
> +		if (ret < 0)
> +			return ret;
> +
> +		result = FIELD_GET(ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK, result);
> +		*val = result * MILLIDEGREE_PER_DEGREE;
> +		return 0;
>  	case hwmon_fan:
> -		ret = acer_get_fan_speed(channel);
> +		sensor_id = acer_wmi_fan_channel_to_sensor_id[channel];
> +		command = ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING | (sensor_id << 8);

Ditto.

-- 
 i.

> +
> +		ret = WMID_gaming_get_sys_info(command, &result);
>  		if (ret < 0)
>  			return ret;
> -		*val = ret;
> -		break;
> +
> +		*val = FIELD_GET(ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK, result);
> +		return 0;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> -
> -	return 0;
>  }
> 
>  static const struct hwmon_channel_info *const acer_wmi_hwmon_info[] = {
> -	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT, HWMON_F_INPUT), NULL
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT,
> +			   HWMON_T_INPUT,
> +			   HWMON_T_INPUT
> +			   ),
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT
> +			   ),
> +	NULL
>  };
> 
>  static const struct hwmon_ops acer_wmi_hwmon_ops = {
> @@ -2724,9 +2776,20 @@ static int acer_wmi_hwmon_init(void)
>  {
>  	struct device *dev = &acer_platform_device->dev;
>  	struct device *hwmon;
> +	u64 result;
> +	int ret;
> +
> +	ret = WMID_gaming_get_sys_info(ACER_WMID_CMD_GET_PREDATOR_V4_SUPPORTED_SENSORS, &result);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Return early if no sensors are available */
> +	supported_sensors = FIELD_GET(ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK, result);
> +	if (!supported_sensors)
> +		return 0;
> 
>  	hwmon = devm_hwmon_device_register_with_info(dev, "acer",
> -						     &acer_platform_driver,
> +						     &supported_sensors,
>  						     &acer_wmi_hwmon_chip_info,
>  						     NULL);
> 
> --
> 2.39.5
> 

