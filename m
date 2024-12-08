Return-Path: <linux-kernel+bounces-436566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47E49E87A7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 21:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E2A1885006
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 20:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2632158862;
	Sun,  8 Dec 2024 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0uOSY4f"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B9F22318;
	Sun,  8 Dec 2024 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733689264; cv=none; b=Z/9TChn2MPvAuxCpdGZcEyPAzmil8o0+Zxc5aUhEzkDIKDNWcHHKWFguz9usJHWi/DVPKY8+Q+R1oa8RCjwr7tS2KhV51yvcPVqWEpRjikua/XkCwWMakdEdWUQD+ksZn+g6KtVEKhFpjN4BD5hGmr4dJY0664LQYC7WJxem1z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733689264; c=relaxed/simple;
	bh=6+weYTzZFO5PrOVJocKEyFoX/3kxclVQvrhitCBmeIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOj1A/Zb/Yx6TH5CGVPs+9o7sG5KOKnphH/2JmsV8GQPyuwkQJvs0OeYYwyHqKesK5R4GOpnXSB/+9PD/xLKUyokjhrlhkYahrpFmqSqEN2xnirz1hWT7rjc21nZhP6Dj7yXobIlj+HLULxCslb9Nc8URGkP2v6V7/zVvqY1a6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0uOSY4f; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725dc290c00so559663b3a.0;
        Sun, 08 Dec 2024 12:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733689262; x=1734294062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PyWQDYrzgucy2d0hdPLEvLv6ZDOzOwggZgCVjV3Fb5Y=;
        b=I0uOSY4fRpIILAAQJrIXmjL9wqEIorGOwv+kh58lCcEpmvljJBJi1wMC1X8Ltn3up0
         sms1Dbb5bZ7O/Fapi87e0Pzoi3ie0IeBEmi9DmgbWOMVzj8MqTy3SZu2KZZRItraL4SA
         KeLJWjCVJKp66NlACR9E8llu21hcTEeGPsFX4Mbqs91S7ukbcmUxEMNvzenaLqiHBloe
         QlE2G44tA7lspSnqdOPE4MO8+hfJcMfG8qFSvgmKVZzZGdD/1OtxA2CDkXMheqv8nu8/
         js01GLGvtHX/rJM6CEuVhmJ+2fc7DrvNHNYTWOMGaW9+yTt7uLwAYzbQMd/8mxP/rTyE
         TCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733689262; x=1734294062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyWQDYrzgucy2d0hdPLEvLv6ZDOzOwggZgCVjV3Fb5Y=;
        b=EKnIXS4qLbBese3M2aJIiBsqemZFuxJ/0ijop07KSG+j4BCFlGtrsTYHCnMGEaExVJ
         F6g9oPFBg+bDzxdcbE/bOumq+xo6lM8fGKNekl3tzrY8T5zaVV7NMabKnGbs95+tkfdN
         9MGixMb/Be7g5NwfoG4FIRdiYxSdvmODc+OaKZlEYEjY6PmCO5W2uUpu5pcMVAlXea7M
         PSU8o1namlbPsSoDKOF30EOayv6ewkgoeAnq8QG6+kONapc2ZaPLd9nWIDFa6zH1Woix
         Coc7b2SB69tR2r6SjrqZR0mqICAiRTHrS1TIw3opW5LtZ7qsrFb6BQvMSYDufnbNqa6n
         oKEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG3Op7J3bVuyb3lUOxpgKHFjuwAx2RCEXS5ct5GbnxuCcw9L8MOONaNAyhbVNlJbSE1Bhtk0HtCe0xCTQ=@vger.kernel.org, AJvYcCXcXzfSXH7ZJ1otr9PCWE0YKtDpc719Vkg3XNpAO0vUeFN68m9XObk6lYRzvuxTeO4DsPWwXdovMf6kxl5o0PExQiKEnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg8OKWQCDUrEPxpzDN0kSrC9D4V+AOqalcV8ebxgfnEdfsG2An
	NTpkiTaaLdoaf0f3tpxKk3KEc5TUFljSvVT9tdQuGbKkzyBmIxqu
X-Gm-Gg: ASbGncuuiyQeSCK0DgDAXL2oCOBTU3MbqnZtOpJILogAQxTLWF8LpeHfhCiMSVt7jN1
	G3QWnwCMRgV1y0DONQBgfdyGmnqWzvLINIBv00fBF3QL13TaW1lUgcJ0emQ2jbEEyLG6NCeQqi7
	aC87KFcMH+3ZWl8NyacM4EoNk8KCx1sZFxcwSrxaahbm3gzob6uh0LMuA8qyRLRqyHSAsHKBreM
	pyDZCsGulWGMpgZ7szF4qIBGlykYvu4rDXu0APuNkGzPSkPFZARNv/x8GqfLcfk8BmaKqv2sNAi
	hGAtWCjs
X-Google-Smtp-Source: AGHT+IEChtiPq0iZQTtZh+IShcSO7OrfMhudwl21xtoA/Fwtmb/GvXJ6p7yZ98eKRGZoJkWV2V8CKA==
X-Received: by 2002:a05:6300:4044:b0:1e0:d5be:bf75 with SMTP id adf61e73a8af0-1e186c507acmr15073919637.17.1733689261642;
        Sun, 08 Dec 2024 12:21:01 -0800 (PST)
Received: from alphacentauri (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29ef4e1sm6175783b3a.77.2024.12.08.12.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 12:21:01 -0800 (PST)
Date: Sun, 8 Dec 2024 17:20:52 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: jlee@suse.com, farhan.anwar8@gmail.com, rayanmargham4@gmail.com, 
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] platform/x86: acer-wmi: Implement proper hwmon
 support
Message-ID: <la7mxoxn3rawxij4ybdzpf7xzbiidl66ejv6qxb4sh4n5ugsvu@64royvkee6kv>
References: <20241129193359.8392-1-W_Armin@gmx.de>
 <20241129193359.8392-5-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129193359.8392-5-W_Armin@gmx.de>

On Fri, Nov 29, 2024 at 08:33:58PM +0100, Armin Wolf wrote:
> After looking at the ACPI AML code, it seems that the command 0x0000
> used with ACER_WMID_GET_GAMING_SYS_INFO_METHODID returns a bitmap of
> all supported sensor indices available through the 0x0001 command.
> 
> Those sensor indices seem to include both temperature and fan speed
> sensors, with only the fan speed sensors being currently supported.
> 
> Use the output of this new command to implement reliable sensor
> detection. This fixes detection of fans which do not spin during
> probe, as fans are currently being ignored if their speed is 0.
> 
> Also add support for the new temperature sensor ids.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/acer-wmi.c | 114 ++++++++++++++++++++++----------
>  1 file changed, 80 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index ac4500f33b8c..2c1ea6155bd3 100644
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
> @@ -71,7 +72,10 @@ MODULE_LICENSE("GPL");
>  #define ACER_PREDATOR_V4_THERMAL_PROFILE_EC_OFFSET 0x54
> 
>  #define ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK GENMASK_ULL(7, 0)

Hi Armin!

This macro is defined twice.

> -#define ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK GENMASK(20, 8)
> +#define ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK GENMASK_ULL(7, 0)

Here ^.

~ Kurt

> +#define ACER_PREDATOR_V4_SENSOR_INDEX_BIT_MASK GENMASK_ULL(15, 8)
> +#define ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK GENMASK_ULL(23, 8)
> +#define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK_ULL(39, 24)
> 
>  /*
>   * Acer ACPI method GUIDs
> @@ -99,9 +103,17 @@ enum acer_wmi_event_ids {
>  };
> 
>  enum acer_wmi_predator_v4_sys_info_command {
> -	ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS = 0x02,
> -	ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED = 0x0201,
> -	ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED = 0x0601,
> +	ACER_WMID_CMD_GET_PREDATOR_V4_SUPPORTED_SENSORS = 0x0000,
> +	ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING	= 0x0001,
> +	ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS	= 0x0002,
> +};
> +
> +enum acer_wmi_predator_v4_sensor_id {
> +	ACER_WMID_SENSOR_CPU_TEMPERATURE	= 0x01,
> +	ACER_WMID_SENSOR_CPU_FAN_SPEED		= 0x02,
> +	ACER_WMID_SENSOR_EXTERNAL_TEMPERATURE_2 = 0x03,
> +	ACER_WMID_SENSOR_GPU_FAN_SPEED		= 0x06,
> +	ACER_WMID_SENSOR_GPU_TEMPERATURE	= 0x0A,
>  };
> 
>  static const struct key_entry acer_wmi_keymap[] __initconst = {
> @@ -272,6 +284,7 @@ static u16 commun_func_bitmap;
>  static u8 commun_fn_key_number;
>  static bool cycle_gaming_thermal_profile = true;
>  static bool predator_v4;
> +static u64 supported_sensors;
> 
>  module_param(mailled, int, 0444);
>  module_param(brightness, int, 0444);
> @@ -1779,27 +1792,6 @@ static int acer_gsensor_event(void)
>  	return 0;
>  }
> 
> -static int acer_get_fan_speed(int fan)
> -{
> -	u64 fanspeed;
> -	u32 command;
> -	int ret;
> -
> -	if (!quirks->predator_v4)
> -		return -EOPNOTSUPP;
> -
> -	if (fan == 0)
> -		command = ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED;
> -	else
> -		command = ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED;
> -
> -	ret = WMID_gaming_get_sys_info(command, &fanspeed);
> -	if (ret < 0)
> -		return ret;
> -
> -	return FIELD_GET(ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK, fanspeed);
> -}
> -
>  /*
>   *  Predator series turbo button
>   */
> @@ -2688,43 +2680,86 @@ static void __init create_debugfs(void)
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
> +	u64 command = ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING;
> +	u64 result;
>  	int ret;
> 
>  	switch (type) {
> +	case hwmon_temp:
> +		command |= FIELD_PREP(ACER_PREDATOR_V4_SENSOR_INDEX_BIT_MASK,
> +				      acer_wmi_temp_channel_to_sensor_id[channel]);
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
> +		command |= FIELD_PREP(ACER_PREDATOR_V4_SENSOR_INDEX_BIT_MASK,
> +				      acer_wmi_fan_channel_to_sensor_id[channel]);
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
> @@ -2741,9 +2776,20 @@ static int acer_wmi_hwmon_init(void)
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

