Return-Path: <linux-kernel+bounces-383368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8219B1AAB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 22:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58405B21565
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 20:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49331D5ACF;
	Sat, 26 Oct 2024 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI2DPUDF"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27C21E4A6;
	Sat, 26 Oct 2024 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729973021; cv=none; b=jGVDc5F2/we9P1UYzGBxJhqf10yePwxyGPbCFuzYRFgbiOTgsd1fD7SSXajix2nl1++mhwqiMUVR3EgmFYXyU0GFTFHvJ7Vtz2P/uxs4nqYytECyBpPyapTEOL0WUOgjB/jVB8xRDN6OtUvXzrMxD9i/C8EV8fBM5mlsUYswwh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729973021; c=relaxed/simple;
	bh=AG9LYFEhXcO7VtMUOZcJKU/JwbuRRdFI3sU3StKHjS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FodExrkYJQzIHdQQNASY0nvL3JuwLkfvLuvkJiTn5JZMSvQ+3SWexL/LCLCbDRA/vHKCMCLqtn37YEBJF7Lj30p8Gcx1wEY3GNY0Il7vmcrZ9Bf3y0XTYMDCw25sXewA9oDwCM6+tvLSf9bSSO0wVy0BvBIpUGPjfL9Up3FDbL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI2DPUDF; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ede82dbb63so92640a12.2;
        Sat, 26 Oct 2024 13:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729973018; x=1730577818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gL+2zHkRFWmGCBf349X/UQMQGMmr3UvaeOzW61xRoQE=;
        b=DI2DPUDFoeoSD0ZHHlr56UGM599zEAfdbk3CdpuT4TET0SiBPDXsQ28NV8MMTq+jDt
         ygCjK4vNw+IuoqqpmPJezB6Pmn6p+WWYFEuSufY9cAH+yITRvb0Cb280FFpr56G6XUNl
         xMw2OMTyXZ8w2QtK6wwOzi9LlpuBLh5KuVq2+I0ZtDSlw1O1JJMQ+ozH+r9UUEnUewlz
         QvuFKKZXO9n/HmWkEu3Fp1ax1Z0XNy60xUSyhAFOJSyE8KPPCzdf0Sr5YsjbaRiwmB2/
         OQ4EggwbtcKlRPy8OVwlJyRcsUJ1XtyVqEHWelOEc0/z/uoDUt/U8Hf0N5yP5TanM97z
         PkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729973018; x=1730577818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL+2zHkRFWmGCBf349X/UQMQGMmr3UvaeOzW61xRoQE=;
        b=rXdiaXZL2Aerf3ZpMQAhUFlJKJV44Qh8Wn5/JnRSosizNtJhoFf3I8up3/kqc0Ihdo
         f3EtAc9i11G6l03YPU/RMeFuoarOvfYc3O/Zcz2Rra1is4kS1fNZ9IAWYUfsVM7zSvrE
         dBt0MPPjcjgx3QENfPpfyw1d3AqGpYZ+I4aNa4jiOW2kGFaNYK+llGK8XKAC4u2C8HhN
         0aLRstJ7AANXgptFqD+6ep62dYEUkLR48FOmA6OkEw46gYO9Li3U4as/9KHNauGfBe6H
         wBRrE3u5+LexoacuDpj5+vHS5GrXYqkAy4JHoYmeTOXSMG4GDsVZlizqOWkKuhzluYSd
         yUHw==
X-Forwarded-Encrypted: i=1; AJvYcCXaWRduyg2SMHdimNQr43N/OrHlRIMlGylbfOuaB8h0oZUn52fYxGqD6HeVdkq60AGqOl5M7VKkX1PX2kVsboN8XLnSxQ==@vger.kernel.org, AJvYcCXyo4Y24WsO8+UM3oIRD73sEN9EFgmcZRVE5a1H05W9k96g24jl3HucnhZ6jgxX1o6v7Vg8tnvXtDicKV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPAlhdZjcrWFovQxD18rGC94LeBttftXxAOju8iTySf2OiPgeD
	/DBOVe3yURWr3SKsfnjpaM6mtHs8EWvIQ70DDBQK3wishFYf7I1Q
X-Google-Smtp-Source: AGHT+IE21/fc8nmHRa//9983IGJODWrW1Q3FcYdDWQRT7DSVpT9bBK/dpNfbdbpnripOaarhTIJ5mQ==
X-Received: by 2002:a05:6a20:d806:b0:1d9:3456:b75f with SMTP id adf61e73a8af0-1d9a83c1ff1mr4292205637.15.1729973017852;
        Sat, 26 Oct 2024 13:03:37 -0700 (PDT)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1fe82sm3047243b3a.164.2024.10.26.13.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 13:03:37 -0700 (PDT)
Date: Sat, 26 Oct 2024 17:03:34 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v9 3/4] alienware-wmi: added platform profile support
Message-ID: <w4cd7yqqy5imtx23n7kcachs6quqmmdpjzuvgly2lyrwhwt6v6@o5hdxbtuoeao>
References: <20241025150916.3618-2-kuurtb@gmail.com>
 <20241025151601.4382-3-kuurtb@gmail.com>
 <08590c9b-5446-4a6a-912b-ebe2f45f25d4@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08590c9b-5446-4a6a-912b-ebe2f45f25d4@gmx.de>

On Fri, Oct 25, 2024 at 09:01:43PM +0200, Armin Wolf wrote:
> Am 25.10.24 um 17:16 schrieb Kurt Borja:
> 
> > Implements platform profile support for Dell laptops with new WMAX thermal
> > interface, present on some Alienware X-Series, Alienware M-Series and
> > Dell's G-Series laptops. This interface is suspected to be used by
> > Alienware Command Center (AWCC), which is not available for linux
> > systems, to manage thermal profiles.
> > 
> > This implementation makes use of three WMI methods, namely
> > THERMAL_CONTROL, THERMAL_INFORMATION and GAME_SHIFT_STATUS, which take
> > u32 as input and output arguments. Each method has a set of supported
> > operations specified in their respective enums.
> > 
> > Wrappers written for these methods support multiple operations.
> > 
> > THERMAL_CONTROL switches thermal modes through operation
> > ACTIVATE_PROFILE. Available thermal codes are auto-detected at runtime
> > and matched against a list of known thermal codes:
> > 
> > Thermal Table "User Selectable Thermal Tables" (USTT):
> > 	BALANCED			0xA0
> > 	BALANCED_PERFORMANCE		0xA1
> > 	COOL				0xA2
> > 	QUIET				0xA3
> > 	PERFORMANCE			0xA4
> > 	LOW_POWER			0xA5
> > 
> > Thermal Table Basic:
> > 	QUIET				0x96
> > 	BALANCED			0x97
> > 	BALANCED_PERFORMANCE		0x98
> > 	PERFORMANCE			0x99
> > 
> > Devices are known to implement only one of these tables without mixing
> > their thermal codes.
> > 
> > The fact that the least significant digit of every thermal code is
> > consecutive of one another is exploited to efficiently match codes
> > through arrays.
> > 
> > Autodetection of available codes is done through operation LIST_IDS of
> > method THERMAL_INFORMATION. This operation lists fan IDs, CPU sensor ID,
> > GPU sensor ID and available thermal profile codes, *in that order*. As
> > number of fans and thermal codes is very model dependent, almost every
> > ID is scanned and matched based on conditions found on
> > is_wmax_thermal_code(). The known upper bound for the number of IDs is
> > 13, corresponding to a device that have 4 fans, 2 sensors and 7 thermal
> > codes.
> > 
> > Additionally G-Series laptops have a key called G-key, which (with AWCC
> > proprietary driver) switches the thermal mode to an special mode named
> > GMODE with code 0xAB and changes Game Shift Status to 1. Game Shift is a
> > mode the manufacturer claims, increases gaming performance.
> > 
> > GAME_SHIFT_STATUS method is used to mimic this behavior when selecting
> > PLATFORM_PROFILE_PERFORMANCE option.
> > 
> > All of these profiles are known to only change fan speed profiles,
> > although there are untested claims that some of them also change power
> > profiles.
> > 
> > Activating a thermal mode with method THERMAL_CONTROL may cause short
> > hangs. This is a known problem present on every platform.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > Reviewed-by: Ilpo J??rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> > v9:
> >   - Bool comparisons are now coherent with their type
> > v8:
> >   - Fixed alignment in wmax_mode_to_platform_profile[]
> >   - Quirk thermal and gmode changed from u8 -> bool
> >   - Autodetected quirk entries are not initialized
> >   - is_wmax_thermal_code refactored to increase readibility
> >   - is_wmax_thermal_code now covers all possibilities
> >   - Better commit message
> > v7:
> >   - Method operations are now clearly listed as separate enums
> >   - wmax_thermal_modes are now listed without codes in order to support
> >     autodetection, as well as getting and setting thermal profiles
> >     cleanly through arrays
> >   - Added wmax_mode_to_platform_profile[]
> >   - Added struct wmax_u32_args to replace bit mask approach of
> >     constructing arguments for wmax methods
> >   - create_thermal_profile now autodetects available thermal codes
> >     through operation 0x03 of THERMAL_INFORMATION method. These are
> >     codes are stored in supported_thermal_profiles[]
> >   - thermal_profile_get now uses wmax_mode_to_platform_profile[] instead of
> >     switch-case approach
> >   - thermal_profile_set now uses supported_thermal_profiles[] instead of
> >     switch-case approach
> >   - When gmode is autodetected, thermal_profile_set also sets Game Shift
> >     status accordingly
> > v6:
> >   - Fixed alignment on some function definitions
> >   - Fixed braces on if statment
> >   - Removed quirk thermal_ustt
> >   - Now quirk thermal can take values defined in enum WMAX_THERMAL_TABLE.
> >   - Proper removal of thermal_profile
> > ---
> >   drivers/platform/x86/dell/Kconfig         |   1 +
> >   drivers/platform/x86/dell/alienware-wmi.c | 280 ++++++++++++++++++++++
> >   2 files changed, 281 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> > index 68a49788a..b06d634cd 100644
> > --- a/drivers/platform/x86/dell/Kconfig
> > +++ b/drivers/platform/x86/dell/Kconfig
> > @@ -21,6 +21,7 @@ config ALIENWARE_WMI
> >   	depends on LEDS_CLASS
> >   	depends on NEW_LEDS
> >   	depends on ACPI_WMI
> > +	select ACPI_PLATFORM_PROFILE
> >   	help
> >   	 This is a driver for controlling Alienware BIOS driven
> >   	 features.  It exposes an interface for controlling the AlienFX
> > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > index b27f3b64c..da9ba422d 100644
> > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > @@ -8,8 +8,11 @@
> >   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > 
> >   #include <linux/acpi.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> >   #include <linux/module.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/platform_profile.h>
> >   #include <linux/dmi.h>
> >   #include <linux/leds.h>
> > 
> > @@ -25,6 +28,13 @@
> >   #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
> >   #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
> >   #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
> > +#define WMAX_METHOD_THERMAL_INFORMATION	0x14
> > +#define WMAX_METHOD_THERMAL_CONTROL	0x15
> > +#define WMAX_METHOD_GAME_SHIFT_STATUS	0x25
> > +
> > +#define WMAX_THERMAL_MODE_GMODE		0xAB
> > +
> > +#define WMAX_FAILURE_CODE		0xFFFFFFFF
> > 
> >   MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
> >   MODULE_DESCRIPTION("Alienware special feature control");
> > @@ -49,11 +59,59 @@ enum WMAX_CONTROL_STATES {
> >   	WMAX_SUSPEND = 3,
> >   };
> > 
> > +enum WMAX_THERMAL_INFORMATION_OPERATIONS {
> > +	WMAX_OPERATION_LIST_IDS			= 0x03,
> > +	WMAX_OPERATION_CURRENT_PROFILE		= 0x0B,
> > +};
> > +
> > +enum WMAX_THERMAL_CONTROL_OPERATIONS {
> > +	WMAX_OPERATION_ACTIVATE_PROFILE		= 0x01,
> > +};
> > +
> > +enum WMAX_GAME_SHIFT_STATUS_OPERATIONS {
> > +	WMAX_OPERATION_TOGGLE_GAME_SHIFT	= 0x01,
> > +	WMAX_OPERATION_GET_GAME_SHIFT_STATUS	= 0x02,
> > +};
> > +
> > +enum WMAX_THERMAL_TABLES {
> > +	WMAX_THERMAL_TABLE_BASIC		= 0x90,
> > +	WMAX_THERMAL_TABLE_USTT			= 0xA0,
> > +};
> > +
> > +enum wmax_thermal_mode {
> > +	THERMAL_MODE_USTT_BALANCED,
> > +	THERMAL_MODE_USTT_BALANCED_PERFORMANCE,
> > +	THERMAL_MODE_USTT_COOL,
> > +	THERMAL_MODE_USTT_QUIET,
> > +	THERMAL_MODE_USTT_PERFORMANCE,
> > +	THERMAL_MODE_USTT_LOW_POWER,
> > +	THERMAL_MODE_BASIC_QUIET,
> > +	THERMAL_MODE_BASIC_BALANCED,
> > +	THERMAL_MODE_BASIC_BALANCED_PERFORMANCE,
> > +	THERMAL_MODE_BASIC_PERFORMANCE,
> > +	THERMAL_MODE_LAST,
> > +};
> > +
> > +static const enum platform_profile_option wmax_mode_to_platform_profile[THERMAL_MODE_LAST] = {
> > +	[THERMAL_MODE_USTT_BALANCED]			= PLATFORM_PROFILE_BALANCED,
> > +	[THERMAL_MODE_USTT_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
> > +	[THERMAL_MODE_USTT_COOL]			= PLATFORM_PROFILE_COOL,
> > +	[THERMAL_MODE_USTT_QUIET]			= PLATFORM_PROFILE_QUIET,
> > +	[THERMAL_MODE_USTT_PERFORMANCE]			= PLATFORM_PROFILE_PERFORMANCE,
> > +	[THERMAL_MODE_USTT_LOW_POWER]			= PLATFORM_PROFILE_LOW_POWER,
> > +	[THERMAL_MODE_BASIC_QUIET]			= PLATFORM_PROFILE_QUIET,
> > +	[THERMAL_MODE_BASIC_BALANCED]			= PLATFORM_PROFILE_BALANCED,
> > +	[THERMAL_MODE_BASIC_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
> > +	[THERMAL_MODE_BASIC_PERFORMANCE]		= PLATFORM_PROFILE_PERFORMANCE,
> > +};
> > +
> >   struct quirk_entry {
> >   	u8 num_zones;
> >   	u8 hdmi_mux;
> >   	u8 amplifier;
> >   	u8 deepslp;
> > +	bool thermal;	/* Autodetected. Do not initialize explicitly. */
> > +	bool gmode;	/* Autodetected. Do not initialize explicitly. */
> 
> Hi,
> 
> is the WMI method to control the thermal profile available on all Alienware devices?
> If no, then the thermal quirk still needs to be enabled manually.

Yes it's not available in all Alienware devices, but wouldn't that get
catched by an ACPI_FAILURE or WMAX_FAILURE? is it not ok not rely on
this? If that's the case I can change it.

> 
> >   };
> > 
> >   static struct quirk_entry *quirks;
> > @@ -214,10 +272,19 @@ struct wmax_led_args {
> >   	u8 state;
> >   } __packed;
> > 
> > +struct wmax_u32_args {
> > +	u8 operation;
> > +	u8 arg1;
> > +	u8 arg2;
> > +	u8 arg3;
> > +};
> > +
> >   static struct platform_device *platform_device;
> >   static struct device_attribute *zone_dev_attrs;
> >   static struct attribute **zone_attrs;
> >   static struct platform_zone *zone_data;
> > +static struct platform_profile_handler pp_handler;
> > +static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
> > 
> >   static struct platform_driver platform_driver = {
> >   	.driver = {
> > @@ -761,6 +828,210 @@ static int create_deepsleep(struct platform_device *dev)
> >   	return ret;
> >   }
> > 
> > +/*
> > + * Thermal Profile control
> > + *  - Provides thermal profile control through the Platform Profile API
> > + */
> > +#define WMAX_THERMAL_TABLE_MASK		GENMASK(7, 4)
> > +#define WMAX_THERMAL_MODE_MASK		GENMASK(3, 0)
> > +#define WMAX_SENSOR_ID_MASK		BIT(8)
> > +
> > +static bool is_wmax_thermal_code(u32 code)
> > +{
> > +	if (code & WMAX_SENSOR_ID_MASK)
> > +		return false;
> > +
> > +	if ((code & WMAX_THERMAL_MODE_MASK) >= THERMAL_MODE_LAST)
> > +		return false;
> > +
> > +	if ((code & WMAX_THERMAL_TABLE_MASK) == WMAX_THERMAL_TABLE_BASIC &&
> > +	    (code & WMAX_THERMAL_MODE_MASK) >= THERMAL_MODE_BASIC_BALANCED)
> > +		return true;
> 
> Please correct me if i am wrong, but i think THERMAL_MODE_BASIC_BALANCED should be
> THERMAL_MODE_BASIC_QUIET.

Yes it should! Thank you for catching it.

> 
> > +
> > +	if ((code & WMAX_THERMAL_TABLE_MASK) == WMAX_THERMAL_TABLE_USTT &&
> > +	    (code & WMAX_THERMAL_MODE_MASK) <= THERMAL_MODE_USTT_LOW_POWER)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static int wmax_thermal_information(u8 operation, u8 arg, u32 *out_data)
> > +{
> > +	acpi_status status;
> > +	struct wmax_u32_args in_args = {
> > +		.operation = operation,
> > +		.arg1 = arg,
> > +		.arg2 = 0,
> > +		.arg3 = 0,
> > +	};
> > +
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_THERMAL_INFORMATION,
> > +					out_data);
> > +
> > +	if (ACPI_FAILURE(status))
> > +		return -EIO;
> > +
> > +	if (*out_data == WMAX_FAILURE_CODE)
> > +		return -EBADRQC;
> > +
> > +	return 0;
> > +}
> > +
> > +static int wmax_thermal_control(u8 profile)
> > +{
> > +	acpi_status status;
> > +	struct wmax_u32_args in_args = {
> > +		.operation = WMAX_OPERATION_ACTIVATE_PROFILE,
> > +		.arg1 = profile,
> > +		.arg2 = 0,
> > +		.arg3 = 0,
> > +	};
> > +	u32 out_data;
> > +
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_THERMAL_CONTROL,
> > +					&out_data);
> > +
> > +	if (ACPI_FAILURE(status))
> > +		return -EIO;
> > +
> > +	if (out_data == WMAX_FAILURE_CODE)
> > +		return -EBADRQC;
> > +
> > +	return 0;
> > +}
> > +
> > +static int wmax_game_shift_status(u8 operation, u32 *out_data)
> > +{
> > +	acpi_status status;
> > +	struct wmax_u32_args in_args = {
> > +		.operation = operation,
> > +		.arg1 = 0,
> > +		.arg2 = 0,
> > +		.arg3 = 0,
> > +	};
> > +
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_GAME_SHIFT_STATUS,
> > +					out_data);
> > +
> > +	if (ACPI_FAILURE(status))
> > +		return -EIO;
> > +
> > +	if (*out_data == WMAX_FAILURE_CODE)
> > +		return -EOPNOTSUPP;
> > +
> > +	return 0;
> > +}
> > +
> > +static int thermal_profile_get(struct platform_profile_handler *pprof,
> > +			       enum platform_profile_option *profile)
> > +{
> > +	u32 out_data;
> > +	int ret;
> > +
> > +	ret = wmax_thermal_information(WMAX_OPERATION_CURRENT_PROFILE,
> > +				       0, &out_data);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (!is_wmax_thermal_code(out_data))
> > +		return -ENODATA;
> > +
> > +	out_data &= WMAX_THERMAL_MODE_MASK;
> > +	*profile = wmax_mode_to_platform_profile[out_data];
> 
> Please check that out_data is smaller than THERMAL_MODE_LAST, otherwise
> an out-of-bounds access can occur.

is_wmax_thermal_code checks if out_data is in bounds.

> 
> Nice work overall.

Thank you very much for your feedback!

Kurt

> 
> Thanks,
> Armin Wolf
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int thermal_profile_set(struct platform_profile_handler *pprof,
> > +			       enum platform_profile_option profile)
> > +{
> > +	if (quirks->gmode) {
> > +		u32 gmode_status;
> > +		int ret;
> > +
> > +		ret = wmax_game_shift_status(WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
> > +					     &gmode_status);
> > +
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		if ((profile == PLATFORM_PROFILE_PERFORMANCE && !gmode_status) ||
> > +		    (profile != PLATFORM_PROFILE_PERFORMANCE && gmode_status)) {
> > +			ret = wmax_game_shift_status(WMAX_OPERATION_TOGGLE_GAME_SHIFT,
> > +						     &gmode_status);
> > +
> > +			if (ret < 0)
> > +				return ret;
> > +		}
> > +	}
> > +
> > +	return wmax_thermal_control(supported_thermal_profiles[profile]);
> > +}
> > +
> > +static int create_thermal_profile(void)
> > +{
> > +	u32 out_data;
> > +	u32 gmode_status;
> > +	enum wmax_thermal_mode mode;
> > +	enum platform_profile_option profile;
> > +	int ret;
> > +
> > +	for (u8 i = 0x2; i <= 0xD; i++) {
> > +		ret = wmax_thermal_information(WMAX_OPERATION_LIST_IDS,
> > +					       i, &out_data);
> > +
> > +		if (ret == -EIO)
> > +			return 0;
> > +
> > +		if (ret == -EBADRQC)
> > +			break;
> > +
> > +		if (!is_wmax_thermal_code(out_data))
> > +			continue;
> > +
> > +		mode = out_data & WMAX_THERMAL_MODE_MASK;
> > +		profile = wmax_mode_to_platform_profile[mode];
> > +		supported_thermal_profiles[profile] = out_data;
> > +
> > +		set_bit(profile, pp_handler.choices);
> > +	}
> > +
> > +	if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
> > +		return 0;
> > +
> > +	ret = wmax_game_shift_status(WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
> > +				     &gmode_status);
> > +
> > +	if (!ret) {
> > +		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
> > +			WMAX_THERMAL_MODE_GMODE;
> > +
> > +		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
> > +		quirks->gmode = true;
> > +	}
> > +
> > +	pp_handler.profile_get = thermal_profile_get;
> > +	pp_handler.profile_set = thermal_profile_set;
> > +
> > +	ret = platform_profile_register(&pp_handler);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	quirks->thermal = true;
> > +
> > +	return 0;
> > +}
> > +
> > +static void remove_thermal_profile(void)
> > +{
> > +	if (quirks->thermal)
> > +		platform_profile_remove();
> > +}
> > +
> >   static int __init alienware_wmi_init(void)
> >   {
> >   	int ret;
> > @@ -808,6 +1079,12 @@ static int __init alienware_wmi_init(void)
> >   			goto fail_prep_deepsleep;
> >   	}
> > 
> > +	if (interface == WMAX && quirks == &quirk_unknown) {
> > +		ret = create_thermal_profile();
> > +		if (ret)
> > +			goto fail_prep_thermal_profile;
> > +	}
> > +
> >   	ret = alienware_zone_init(platform_device);
> >   	if (ret)
> >   		goto fail_prep_zones;
> > @@ -816,6 +1093,8 @@ static int __init alienware_wmi_init(void)
> > 
> >   fail_prep_zones:
> >   	alienware_zone_exit(platform_device);
> > +	remove_thermal_profile();
> > +fail_prep_thermal_profile:
> >   fail_prep_deepsleep:
> >   fail_prep_amplifier:
> >   fail_prep_hdmi:
> > @@ -835,6 +1114,7 @@ static void __exit alienware_wmi_exit(void)
> >   	if (platform_device) {
> >   		alienware_zone_exit(platform_device);
> >   		remove_hdmi(platform_device);
> > +		remove_thermal_profile();
> >   		platform_device_unregister(platform_device);
> >   		platform_driver_unregister(&platform_driver);
> >   	}

