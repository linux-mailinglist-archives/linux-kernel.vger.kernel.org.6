Return-Path: <linux-kernel+bounces-379382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADF99ADDE4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924E7282747
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E92F1A76B0;
	Thu, 24 Oct 2024 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABsni9eE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45E6156228;
	Thu, 24 Oct 2024 07:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755604; cv=none; b=uAVVfnLFhf4vvom0jUzHmQ5ZYQep3CFfq5qfng18NWiwrMIpNArvBaQb9JCGtvq6oOdHgPXMYaA4cFOEE2vIGbNUrZrhdJGYrHjUqfFGJnP/85OthkjEtOBBsq45rg++7z8arvjUgTS3LaiJw8TyuGWFGwc3lQx6dIWtE/M5pvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755604; c=relaxed/simple;
	bh=XSX43Jho1CceKtlRtCdG8OKpUV000cQZ8A7C88MZG5E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eeT64cXlSbQsFmBeALcoFVdZF2+h4vlbi+7sROMkbHrRbyo2LTT3MOiOVRocMrMnGDGk0Co7qZCMGV0mjHTH6Vh/PsSmPb5bwu+9FH/d8UUcJY8KMYGq8eeysY2J6AyIWOIBGiPs5OhZa5MR/VDYME/cd9U9+K2EJ6pPGmI1jTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABsni9eE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729755601; x=1761291601;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XSX43Jho1CceKtlRtCdG8OKpUV000cQZ8A7C88MZG5E=;
  b=ABsni9eEfT2D+VW+F5FiryIm8IIT42UIGtrmmzssWfKAfTykpB4ycnR3
   Ti6+2yhEbtTkX5pd0b1P0My5J2mim3vSgyg8TwNdJaaKq80Ens+BafBEg
   POTOPtHPZsr4oI70GxxBVB8zB+pVQeQgFC9+TAShOrGE4VjhMZZLlwj7s
   wePncgzNNdfD3jYaoK4CP3N+KVOh9aZCsJZwm754XlLfcj0lRYzj+Krl/
   DfqsDSbRojTpUONVKUfctSe21Qr//sq/dICfuEXP5Czfx33X8qmBxv9aG
   MceKBQAv+KIbxHkaAxzVQ4WDiCaltytbobD2fsX8uYS+zvfeyffaY+DoG
   w==;
X-CSE-ConnectionGUID: 3cKyTKM+S2iepivkurJ5NA==
X-CSE-MsgGUID: qzVnwj/kS7q/ofzCKc4OWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51913141"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51913141"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 00:40:00 -0700
X-CSE-ConnectionGUID: zrdSNpGTRHi4x8BkT1x0Fg==
X-CSE-MsgGUID: Axcd/hf9RFOL/VqMXq5Z8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="111358484"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.193])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 00:39:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 24 Oct 2024 10:39:55 +0300 (EEST)
To: Kurt Borja <kuurtb@gmail.com>
cc: W_Armin@gmx.de, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v7 3/4] alienware-wmi: added platform profile support
In-Reply-To: <20241024061901.34793-3-kuurtb@gmail.com>
Message-ID: <bb9bf46a-aaa4-1aef-7601-0e410a6e167b@linux.intel.com>
References: <20241024061547.33918-2-kuurtb@gmail.com> <20241024061901.34793-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 24 Oct 2024, Kurt Borja wrote:

> Implements platform profile support for Dell laptops with new WMAX thermal
> interface, present on some Alienware X-Series, Alienware M-Series and
> Dell's G-Series laptops. 
> 
> This implementation automatically detects available thermal profiles and
> GMODE + Game Shift availability, which is a feature of G-Series laptops.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> v7:
>  - Method operations are now clearly listed as separate enums
>  - wmax_thermal_modes are now listed without codes in order to support
>    autodetection, as well as getting and setting thermal profiles
>    cleanly through arrays
>  - Added wmax_mode_to_platform_profile[]
>  - Added struct wmax_u32_args to replace bit mask approach of
>    constructing arguments for wmax methods
>  - create_thermal_profile now autodetects available thermal codes
>    through operation 0x03 of THERMAL_INFORMATION method. These are
>    codes are stored in supported_thermal_profiles[]
>  - thermal_profile_get now uses wmax_mode_to_platform_profile[] instead of
>    switch-case approach
>  - thermal_profile_set now uses supported_thermal_profiles[] instead of
>    switch-case approach
>  - When gmode is autodetected, thermal_profile_set also sets Game Shift
>    status accordingly
> v6:
>  - Fixed alignment on some function definitions
>  - Fixed braces on if statment
>  - Removed quirk thermal_ustt
>  - Now quirk thermal can take values defined in enum WMAX_THERMAL_TABLE.
>  - Proper removal of thermal_profile
> ---
> This refactor was done in order to autodetect available thermal modes
> efficently through operation 0x03.
> 
> This new array approach exploits the fact that the first 4 bits of every
> thermal code are consecutive from 0 to 9, however next 4 bits are not
> consecutive (available thermal codes are documented in patch 4/4) so full
> codes are dynamically probed based on rules found in is_wmax_thermal_code().

IMO, both of these paragraphs contain information would be useful in the 
commit message (with minor rephrasing).

> ---
>  drivers/platform/x86/dell/Kconfig         |   1 +
>  drivers/platform/x86/dell/alienware-wmi.c | 282 ++++++++++++++++++++++
>  2 files changed, 283 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> index 68a49788a..b06d634cd 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -21,6 +21,7 @@ config ALIENWARE_WMI
>  	depends on LEDS_CLASS
>  	depends on NEW_LEDS
>  	depends on ACPI_WMI
> +	select ACPI_PLATFORM_PROFILE
>  	help
>  	 This is a driver for controlling Alienware BIOS driven
>  	 features.  It exposes an interface for controlling the AlienFX
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index b27f3b64c..9ce6e794a 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -8,8 +8,11 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/platform_profile.h>
>  #include <linux/dmi.h>
>  #include <linux/leds.h>
>  
> @@ -25,6 +28,13 @@
>  #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
>  #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
>  #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
> +#define WMAX_METHOD_THERMAL_INFORMATION	0x14
> +#define WMAX_METHOD_THERMAL_CONTROL	0x15
> +#define WMAX_METHOD_GAME_SHIFT_STATUS	0x25
> +
> +#define WMAX_THERMAL_MODE_GMODE		0xAB
> +
> +#define WMAX_FAILURE_CODE		0xFFFFFFFF
>  
>  MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
>  MODULE_DESCRIPTION("Alienware special feature control");
> @@ -49,11 +59,59 @@ enum WMAX_CONTROL_STATES {
>  	WMAX_SUSPEND = 3,
>  };
>  
> +enum WMAX_THERMAL_INFORMATION_OPERATIONS {
> +	WMAX_OPERATION_LIST_IDS		= 0x03,
> +	WMAX_OPERATION_CURRENT_PROFILE	= 0x0B,
> +};
> +
> +enum WMAX_THERMAL_CONTROL_OPERATIONS {
> +	WMAX_OPERATION_ACTIVATE_PROFILE	= 0x01,
> +};
> +
> +enum WMAX_GAMESHIFT_STATUS_OPERATIONS {
> +	WMAX_OPERATION_TOGGLE_GAME_SHIFT	= 0x01,
> +	WMAX_OPERATION_GET_GAME_SHIFT_STATUS	= 0x02,
> +};
> +
> +enum WMAX_THERMAL_TABLES {
> +	WMAX_THERMAL_TABLE_BASIC	= 0x90,
> +	WMAX_THERMAL_TABLE_USTT		= 0xA0,
> +};
> +
> +enum wmax_thermal_mode {
> +	THERMAL_MODE_USTT_BALANCED,
> +	THERMAL_MODE_USTT_BALANCED_PERFORMANCE,
> +	THERMAL_MODE_USTT_COOL,
> +	THERMAL_MODE_USTT_QUIET,
> +	THERMAL_MODE_USTT_PERFORMANCE,
> +	THERMAL_MODE_USTT_LOW_POWER,
> +	THERMAL_MODE_BASIC_QUIET,
> +	THERMAL_MODE_BASIC_BALANCED,
> +	THERMAL_MODE_BASIC_BALANCED_PERFORMANCE,
> +	THERMAL_MODE_BASIC_PERFORMANCE,
> +	THERMAL_MODE_LAST,
> +};
> +
> +static const enum platform_profile_option wmax_mode_to_platform_profile[THERMAL_MODE_LAST] = {
> +	[THERMAL_MODE_USTT_BALANCED] = PLATFORM_PROFILE_BALANCED,
> +	[THERMAL_MODE_USTT_BALANCED_PERFORMANCE] = PLATFORM_PROFILE_BALANCED_PERFORMANCE,
> +	[THERMAL_MODE_USTT_COOL] = PLATFORM_PROFILE_COOL,
> +	[THERMAL_MODE_USTT_QUIET] = PLATFORM_PROFILE_QUIET,
> +	[THERMAL_MODE_USTT_PERFORMANCE] = PLATFORM_PROFILE_PERFORMANCE,
> +	[THERMAL_MODE_USTT_LOW_POWER] = PLATFORM_PROFILE_LOW_POWER,
> +	[THERMAL_MODE_BASIC_QUIET] = PLATFORM_PROFILE_QUIET,
> +	[THERMAL_MODE_BASIC_BALANCED] = PLATFORM_PROFILE_BALANCED,
> +	[THERMAL_MODE_BASIC_BALANCED_PERFORMANCE] = PLATFORM_PROFILE_BALANCED_PERFORMANCE,
> +	[THERMAL_MODE_BASIC_PERFORMANCE] = PLATFORM_PROFILE_PERFORMANCE,

Please align the values.

I know they are a bit long so if you don't like how far they end up, align 
at least all except the PLATFORM_PROFILE_BALANCED_PERFORMANCE lines which 
already is a major improvement over the current layout.

> +};
> +
>  struct quirk_entry {
>  	u8 num_zones;
>  	u8 hdmi_mux;
>  	u8 amplifier;
>  	u8 deepslp;
> +	u8 thermal;
> +	u8 gmode;

I wonder what is the benefit of setting these to zeros down below? It's 
the default they initialize anyway. It's also a bit misleading to 
indicate they're 0.

IMO it would be better to just add a comment to these two entries here 
that they're autodetected and not initialized them explicitly at all.

Also, both of these behave like booleans so if there's no plan to use more 
than 0/1 (false/true), just make them bool (and adapt the related code 
accordingly).

>  };
>  
>  static struct quirk_entry *quirks;
> @@ -64,6 +122,8 @@ static struct quirk_entry quirk_inspiron5675 = {
>  	.hdmi_mux = 0,
>  	.amplifier = 0,
>  	.deepslp = 0,
> +	.thermal = 0,
> +	.gmode = 0,
>  };
>  
>  static struct quirk_entry quirk_unknown = {
> @@ -71,6 +131,8 @@ static struct quirk_entry quirk_unknown = {
>  	.hdmi_mux = 0,
>  	.amplifier = 0,
>  	.deepslp = 0,
> +	.thermal = 0,
> +	.gmode = 0,
>  };
>  
>  static struct quirk_entry quirk_x51_r1_r2 = {
> @@ -78,6 +140,8 @@ static struct quirk_entry quirk_x51_r1_r2 = {
>  	.hdmi_mux = 0,
>  	.amplifier = 0,
>  	.deepslp = 0,
> +	.thermal = 0,
> +	.gmode = 0,
>  };
>  
>  static struct quirk_entry quirk_x51_r3 = {
> @@ -85,6 +149,8 @@ static struct quirk_entry quirk_x51_r3 = {
>  	.hdmi_mux = 0,
>  	.amplifier = 1,
>  	.deepslp = 0,
> +	.thermal = 0,
> +	.gmode = 0,
>  };
>  
>  static struct quirk_entry quirk_asm100 = {
> @@ -92,6 +158,8 @@ static struct quirk_entry quirk_asm100 = {
>  	.hdmi_mux = 1,
>  	.amplifier = 0,
>  	.deepslp = 0,
> +	.thermal = 0,
> +	.gmode = 0,
>  };
>  
>  static struct quirk_entry quirk_asm200 = {
> @@ -99,6 +167,8 @@ static struct quirk_entry quirk_asm200 = {
>  	.hdmi_mux = 1,
>  	.amplifier = 0,
>  	.deepslp = 1,
> +	.thermal = 0,
> +	.gmode = 0,
>  };
>  
>  static struct quirk_entry quirk_asm201 = {
> @@ -106,6 +176,8 @@ static struct quirk_entry quirk_asm201 = {
>  	.hdmi_mux = 1,
>  	.amplifier = 1,
>  	.deepslp = 1,
> +	.thermal = 0,
> +	.gmode = 0,
>  };
>  
>  static int __init dmi_matched(const struct dmi_system_id *dmi)
> @@ -214,10 +286,19 @@ struct wmax_led_args {
>  	u8 state;
>  } __packed;
>  
> +struct wmax_u32_args {
> +	u8 operation;
> +	u8 arg1;
> +	u8 arg2;
> +	u8 arg3;
> +};
> +
>  static struct platform_device *platform_device;
>  static struct device_attribute *zone_dev_attrs;
>  static struct attribute **zone_attrs;
>  static struct platform_zone *zone_data;
> +static struct platform_profile_handler pp_handler;
> +static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
>  
>  static struct platform_driver platform_driver = {
>  	.driver = {
> @@ -761,6 +842,198 @@ static int create_deepsleep(struct platform_device *dev)
>  	return ret;
>  }
>  
> +/*
> + * Thermal Profile control
> + *  - Provides thermal profile control through the Platform Profile API
> + */
> +#define WMAX_THERMAL_TABLE_MASK		GENMASK(7, 4)
> +#define WMAX_THERMAL_MODE_MASK		GENMASK(3, 0)
> +
> +static bool is_wmax_thermal_code(u32 code)
> +{
> +	return ((code & WMAX_THERMAL_TABLE_MASK) == WMAX_THERMAL_TABLE_BASIC ||
> +	       (code & WMAX_THERMAL_TABLE_MASK) == WMAX_THERMAL_TABLE_USTT) &&

This line is misindented...

> +	       (code & WMAX_THERMAL_MODE_MASK) < THERMAL_MODE_LAST;

...But I think this would be cleaner/easier to follow if less is attempted 
inside a single statement:

	if ((code & WMAX_THERMAL_MODE_MASK) >= THERMAL_MODE_LAST)
		return false;

	return ...the rest of the logic...;

Or in the opposite order if you want to do the table check before the mode 
check.

> +}
> +
> +static int wmax_thermal_information(u8 operation, u8 arg, u32 *out_data)

Can this 'arg' parameter be named 

> +{
> +	acpi_status status;
> +	struct wmax_u32_args in_args = {
> +		.operation = operation,
> +		.arg1 = arg,
> +		.arg2 = 0,
> +		.arg3 = 0,
> +	};
> +
> +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_THERMAL_INFORMATION,
> +					out_data);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	if (*out_data == WMAX_FAILURE_CODE)
> +		return -EBADRQC;
> +
> +	return 0;
> +}
> +
> +static int wmax_thermal_control(u8 operation, u8 arg)
> +{
> +	acpi_status status;
> +	struct wmax_u32_args in_args = {
> +		.operation = operation,
> +		.arg1 = arg,
> +		.arg2 = 0,
> +		.arg3 = 0,
> +	};
> +	u32 out_data;
> +
> +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_THERMAL_CONTROL,
> +					&out_data);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	if (out_data == WMAX_FAILURE_CODE)
> +		return -EBADRQC;
> +
> +	return 0;
> +}
> +
> +static int wmax_gameshift_status(u8 operation, u32 *out_data)
> +{
> +	acpi_status status;
> +	struct wmax_u32_args in_args = {
> +		.operation = operation,
> +		.arg1 = 0,
> +		.arg2 = 0,
> +		.arg3 = 0,
> +	};
> +
> +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_GAME_SHIFT_STATUS,
> +					out_data);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	if (*out_data == WMAX_FAILURE_CODE)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
> +static int thermal_profile_get(struct platform_profile_handler *pprof,
> +			       enum platform_profile_option *profile)
> +{
> +	u32 out_data;
> +	int ret;
> +
> +	ret = wmax_thermal_information(WMAX_OPERATION_CURRENT_PROFILE,
> +				       0, &out_data);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!is_wmax_thermal_code(out_data))
> +		return -ENODATA;
> +
> +	out_data &= WMAX_THERMAL_MODE_MASK;
> +	*profile = wmax_mode_to_platform_profile[out_data];
> +
> +	return 0;
> +}
> +
> +static int thermal_profile_set(struct platform_profile_handler *pprof,
> +			       enum platform_profile_option profile)
> +{
> +	if (quirks->gmode == 1) {
> +		u32 gmode_status;
> +		int ret;
> +
> +		ret = wmax_gameshift_status(WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
> +					    &gmode_status);
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		if ((profile == PLATFORM_PROFILE_PERFORMANCE && !gmode_status) ||
> +		    (profile != PLATFORM_PROFILE_PERFORMANCE && gmode_status)) {
> +			ret = wmax_gameshift_status(WMAX_OPERATION_TOGGLE_GAME_SHIFT,
> +						&gmode_status);
> +
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	return wmax_thermal_control(WMAX_OPERATION_ACTIVATE_PROFILE,
> +				    supported_thermal_profiles[profile]);

If somebody has to look at this change from changelog history some years 
from now, it would be beneficial for the commit message to contain a few 
words to explain how this "game shift" thing relates to anything what is 
being done here. It's not exactly obvious from the naming alone and 
marketting may have already moved to the next term making it eventually 
hard to find some information about the term.

You have some material in the docs change and the most relevant 
fragment(s) could perhaps be used in the commit message as well 
(especially as it seems to be based on some guesswork on its actual 
effect).

If you reorder the patches 3 and 4, the commit message of this change 
could also ref to the doc for further information (but I'd prefer to have 
the relevant parts also in the commit message so the reasoning is 
communicated as per today's understanding, the doc files may get 
rewritten/changed over time).


In any case, thanks a lot for working on this!

-- 
 i.

> +}
> +
> +static int create_thermal_profile(void)
> +{
> +	u32 out_data;
> +	u32 gmode_status;
> +	enum wmax_thermal_mode mode;
> +	enum platform_profile_option profile;
> +	int ret;
> +
> +	for (u8 i = 0x2; i <= 0xD; i++) {
> +		ret = wmax_thermal_information(WMAX_OPERATION_LIST_IDS,
> +					       i, &out_data);
> +
> +		if (ret == -EIO)
> +			return 0;
> +
> +		if (ret == -EBADRQC)
> +			break;
> +
> +		if (!is_wmax_thermal_code(out_data))
> +			continue;
> +
> +		mode = out_data & WMAX_THERMAL_MODE_MASK;
> +		profile = wmax_mode_to_platform_profile[mode];
> +		supported_thermal_profiles[profile] = out_data;
> +
> +		set_bit(profile, pp_handler.choices);
> +	}
> +
> +	if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
> +		return 0;
> +
> +	ret = wmax_gameshift_status(WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
> +				    &gmode_status);
> +
> +	if (!ret) {
> +		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
> +			WMAX_THERMAL_MODE_GMODE;
> +
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
> +		quirks->gmode = 1;
> +	}
> +
> +	pp_handler.profile_get = thermal_profile_get;
> +	pp_handler.profile_set = thermal_profile_set;
> +
> +	ret = platform_profile_register(&pp_handler);
> +	if (ret < 0)
> +		return ret;
> +
> +	quirks->thermal = 1;
> +
> +	return 0;
> +}
> +
> +static void remove_thermal_profile(void)
> +{
> +	if (quirks->thermal > 0)
> +		platform_profile_remove();
> +}
> +
>  static int __init alienware_wmi_init(void)
>  {
>  	int ret;
> @@ -808,6 +1081,12 @@ static int __init alienware_wmi_init(void)
>  			goto fail_prep_deepsleep;
>  	}
>  
> +	if (interface == WMAX && quirks == &quirk_unknown) {
> +		ret = create_thermal_profile();
> +		if (ret)
> +			goto fail_prep_thermal_profile;
> +	}
> +
>  	ret = alienware_zone_init(platform_device);
>  	if (ret)
>  		goto fail_prep_zones;
> @@ -816,6 +1095,8 @@ static int __init alienware_wmi_init(void)
>  
>  fail_prep_zones:
>  	alienware_zone_exit(platform_device);
> +	remove_thermal_profile();
> +fail_prep_thermal_profile:
>  fail_prep_deepsleep:
>  fail_prep_amplifier:
>  fail_prep_hdmi:
> @@ -835,6 +1116,7 @@ static void __exit alienware_wmi_exit(void)
>  	if (platform_device) {
>  		alienware_zone_exit(platform_device);
>  		remove_hdmi(platform_device);
> +		remove_thermal_profile();
>  		platform_device_unregister(platform_device);
>  		platform_driver_unregister(&platform_driver);
>  	}
> 

