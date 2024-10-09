Return-Path: <linux-kernel+bounces-356621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F811996444
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB75283656
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B4718B46B;
	Wed,  9 Oct 2024 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLVpRIaH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4C41885BE;
	Wed,  9 Oct 2024 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464218; cv=none; b=XEXAc+uIAfL5OdXKa77IOmk58cZGnal2yqe7/e4BY0hpAtlOAi9ZEanadqcyOOz77atjrxcSOlV4zYn5k6BJhjoPtXGiHcFCu13OZ1r0SUToiOm4R9a0UonvN7eSIvSxKCkIXqgWjUBBWGAZeFeRZeZrRlYoEmGWrPq552jraEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464218; c=relaxed/simple;
	bh=nGysODQnF3rD5Hk25IIzer0H47MtCKI+h8RyFuo8Y1o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DZwHsdF9/0dP54Z8RgbG/fnP6hOLz8cS/Gq8gjTdhIPi9AMsDXIacqvlPAEagJLZzWmxO1mTssBw6rNPjVMxR73pPo0TNMeCOe2YycBgSSeUelBRmrweyKLz/Omnq//4yEVUpaKzsolYpA79cZ9RTj22FCA1OsEtUsl/bTlWcmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLVpRIaH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728464215; x=1760000215;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nGysODQnF3rD5Hk25IIzer0H47MtCKI+h8RyFuo8Y1o=;
  b=LLVpRIaHSZ4HzS4L0KJ5v5EFVilGTBsjFj10dV0O8jMx+AWBUSQ7WNBw
   yUZa2B0lCcSE0l69AiDqD+82GkWLedBZEToRdW9n6xRoa7p2dITOYyK06
   kvRxm2ZRK4jMxg5udJGxMgreTuRSWU7KfgLuyR8Gq53Ofn0yGX5lfE/eb
   IJstalEX7BXSQ36zyeMsdAlYO82hDuj440XF3wPImUHD6KDmcgWv59TmL
   c3F+rbvjMCSikV8s138aHemR4Tbo4vzhDj2CTzn9/2vDLSfsYWzw5b9dR
   ZOSewmLLc5ayX2gpLExDoOVFVE10j+agSJQVfiNsH5evOH0xCobzXgE2T
   g==;
X-CSE-ConnectionGUID: qKdSP3n+TK6nWdtca9Jbvg==
X-CSE-MsgGUID: l0tbvz8uSRGzDLQwR0591Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="15370854"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="15370854"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 01:56:55 -0700
X-CSE-ConnectionGUID: 1yvo2s/XRMC+91Xw9QJCdg==
X-CSE-MsgGUID: 5SAMD454R7iHqncL2anWNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76998580"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 01:56:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 9 Oct 2024 11:56:49 +0300 (EEST)
To: Kurt Borja <kuurtb@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v3] alienware-wmi: Dell AWCC platform_profile support
In-Reply-To: <20241008195642.36677-2-kuurtb@gmail.com>
Message-ID: <0b74d43f-ef23-cd6e-19e5-212432f8b95e@linux.intel.com>
References: <20241007093324.49631-3-kuurtb@gmail.com> <20241008195642.36677-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 8 Oct 2024, Kurt Borja wrote:

> This patch adds platform_profile support for Dell devices which implement
> User Selectable Thermal Tables (USTT) that are meant to be controlled by
> Alienware Command Center (AWCC). These devices may include newer Alienware
> M-Series, Alienware X-Series and Dell's G-Series. This patch, was tested
> by me on an Alienware x15 R1.
> 
> It is suspected that Alienware Command Center manages thermal profiles
> through the WMI interface, specifically through a device with identifier
> \_SB_.AMW1.WMAX. This device was reverse engineered and the relevant
> functionality is documented here [1]. This driver interacts with this
> WMI device and thus is able to mimic AWCC's thermal profiles functionality
> through the platform_profile API. In consequence the user would be able
> to set and retrieve thermal profiles, which are just fan speed profiles.
> 
> This driver was heavily inspired on inspur_platform_profile, special
> thanks.
> 
> Notes:
>  - Performance (FullSpeed) profile is a special profile which has it's own
>    entry in the Firmware Settings of the Alienware x15 R1. It also changes
>    the color of the F1 key. I suspect this behavior would be replicated in
>    other X-Series or M-Series laptops.
>  - G-Mode is a profile documented on [1] which mimics the behavior of
>    FullSpeed mode but it does not have an entry on the Firmware Settings of
>    the Alienware x15 R1, this may correspond to the G-Mode functionality on
>    G-Series laptops (activated by a special button) but I cannot test it. I
>    did not include this code in the driver as G-Mode causes unexpected
>    behavior on X-Series laptops.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> 
> ---
> v3:
>  - Removed extra empty line
>  - 0x0B named WMAX_ARG_GET_CURRENT_PROF
>  - Removed casts to the same type on functions added in this patch
>  - Thermal profile to WMAX argument is now an static function and makes
>    use of in-built kernel macros
>  - Platform profile is now removed only if it was created first
>  - create_platform_profile is now create_thermal_profile to avoid
>    confusion
>  - profile_get and profile_set functions renamed too to match the above
> v2:
>  - Moved functionality to alienware-wmi driver
>  - Added thermal and gmode quirks to add support based on dmi match
>  - Performance profile is now GMODE for devices that support it
>  - alienware_wmax_command now is insize agnostic to support new thermal
>    methods
> ---
>  drivers/platform/x86/dell/Kconfig         |   1 +
>  drivers/platform/x86/dell/alienware-wmi.c | 238 ++++++++++++++++++++--
>  2 files changed, 226 insertions(+), 13 deletions(-)
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
> index f5ee62ce1..e3ef4b10b 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -10,6 +10,7 @@
>  #include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/platform_profile.h>
>  #include <linux/dmi.h>
>  #include <linux/leds.h>
>  
> @@ -25,6 +26,10 @@
>  #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
>  #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
>  #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
> +#define WMAX_METHOD_THERMAL_INFORMATION	0x14
> +#define WMAX_METHOD_THERMAL_CONTROL	0x15
> +
> +#define WMAX_ARG_GET_CURRENT_PROF	0x0B
>  
>  MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
>  MODULE_DESCRIPTION("Alienware special feature control");
> @@ -49,11 +54,22 @@ enum WMAX_CONTROL_STATES {
>  	WMAX_SUSPEND = 3,
>  };
>  
> +enum WMAX_THERMAL_PROFILE {
> +	WMAX_THERMAL_QUIET = 0xA3,
> +	WMAX_THERMAL_BALANCED = 0xA0,
> +	WMAX_THERMAL_BALANCED_PERFORMANCE = 0xA1,
> +	WMAX_THERMAL_PERFORMANCE = 0xA4,
> +	WMAX_THERMAL_GMODE = 0xAB,
> +	WMAX_THERMAL_LOW_POWER	= 0xA5,
> +};
> +
>  struct quirk_entry {
>  	u8 num_zones;
>  	u8 hdmi_mux;
>  	u8 amplifier;
>  	u8 deepslp;
> +	u8 thermal;
> +	u8 gmode;
>  };
>  
>  static struct quirk_entry *quirks;
> @@ -64,6 +80,8 @@ static struct quirk_entry quirk_inspiron5675 = {
>  	.hdmi_mux = 0,
>  	.amplifier = 0,
>  	.deepslp = 0,
> +	.thermal = 0,
> +	.gmode = 0,
>  };
>  
>  static struct quirk_entry quirk_unknown = {
> @@ -71,6 +89,8 @@ static struct quirk_entry quirk_unknown = {
>  	.hdmi_mux = 0,
>  	.amplifier = 0,
>  	.deepslp = 0,
> +	.thermal = 0,
> +	.gmode = 0,
>  };
>  
>  static struct quirk_entry quirk_x51_r1_r2 = {
> @@ -78,6 +98,8 @@ static struct quirk_entry quirk_x51_r1_r2 = {
>  	.hdmi_mux = 0,
>  	.amplifier = 0,
>  	.deepslp = 0,
> +	.thermal = 0,
> +	.gmode = 0,
>  };
>  
>  static struct quirk_entry quirk_x51_r3 = {
> @@ -85,6 +107,8 @@ static struct quirk_entry quirk_x51_r3 = {
>  	.hdmi_mux = 0,
>  	.amplifier = 1,
>  	.deepslp = 0,
> +	.thermal = 0,
> +	.gmode = 0,
>  };
>  
>  static struct quirk_entry quirk_asm100 = {
> @@ -92,6 +116,8 @@ static struct quirk_entry quirk_asm100 = {
>  	.hdmi_mux = 1,
>  	.amplifier = 0,
>  	.deepslp = 0,
> +	.thermal = 0,
> +	.gmode = 0,
>  };
>  
>  static struct quirk_entry quirk_asm200 = {
> @@ -99,6 +125,8 @@ static struct quirk_entry quirk_asm200 = {
>  	.hdmi_mux = 1,
>  	.amplifier = 0,
>  	.deepslp = 1,
> +	.thermal = 0,
> +	.gmode = 0,
>  };
>  
>  static struct quirk_entry quirk_asm201 = {
> @@ -106,6 +134,17 @@ static struct quirk_entry quirk_asm201 = {
>  	.hdmi_mux = 1,
>  	.amplifier = 1,
>  	.deepslp = 1,
> +	.thermal = 0,
> +	.gmode = 0,
> +};
> +
> +static struct quirk_entry quirk_x15_r1 = {
> +	.num_zones = 2,
> +	.hdmi_mux = 0,
> +	.amplifier = 0,
> +	.deepslp = 0,
> +	.thermal = 1,
> +	.gmode = 0,
>  };
>  
>  static int __init dmi_matched(const struct dmi_system_id *dmi)
> @@ -169,6 +208,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
>  		     },
>  	 .driver_data = &quirk_asm201,
>  	 },
> +	 {
> +	 .callback = dmi_matched,
> +	 .ident = "Alienware x15 R1",
> +	 .matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R1")
> +		    },
> +	 .driver_data = &quirk_x15_r1,
> +	},
>  	 {
>  	 .callback = dmi_matched,
>  	 .ident = "Dell Inc. Inspiron 5675",
> @@ -218,6 +266,7 @@ static struct platform_device *platform_device;
>  static struct device_attribute *zone_dev_attrs;
>  static struct attribute **zone_attrs;
>  static struct platform_zone *zone_data;
> +static struct platform_profile_handler pp_handler;
>  
>  static struct platform_driver platform_driver = {
>  	.driver = {
> @@ -500,7 +549,7 @@ static void alienware_zone_exit(struct platform_device *dev)
>  	kfree(zone_attrs);
>  }
>  
> -static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
> +static acpi_status alienware_wmax_command(void *in_args, size_t insize,
>  					  u32 command, int *out_data)
>  {
>  	acpi_status status;
> @@ -508,7 +557,7 @@ static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
>  	struct acpi_buffer input;
>  	struct acpi_buffer output;
>  
> -	input.length = (acpi_size) sizeof(*in_args);
> +	input.length = (acpi_size) insize;
>  	input.pointer = in_args;
>  	if (out_data) {
>  		output.length = ACPI_ALLOCATE_BUFFER;
> @@ -541,8 +590,8 @@ static ssize_t show_hdmi_cable(struct device *dev,
>  		.arg = 0,
>  	};
>  	status =
> -	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
> -				   (u32 *) &out_data);
> +	    alienware_wmax_command(&in_args, sizeof(in_args),
> +				   WMAX_METHOD_HDMI_CABLE, (u32 *) &out_data);
>  	if (ACPI_SUCCESS(status)) {
>  		if (out_data == 0)
>  			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -562,8 +611,8 @@ static ssize_t show_hdmi_source(struct device *dev,
>  		.arg = 0,
>  	};
>  	status =
> -	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
> -				   (u32 *) &out_data);
> +	    alienware_wmax_command(&in_args, sizeof(in_args),
> +				   WMAX_METHOD_HDMI_STATUS, (u32 *) &out_data);
>  
>  	if (ACPI_SUCCESS(status)) {
>  		if (out_data == 1)
> @@ -589,7 +638,8 @@ static ssize_t toggle_hdmi_source(struct device *dev,
>  		args.arg = 3;
>  	pr_debug("alienware-wmi: setting hdmi to %d : %s", args.arg, buf);
>  
> -	status = alienware_wmax_command(&args, WMAX_METHOD_HDMI_SOURCE, NULL);
> +	status = alienware_wmax_command(&args, sizeof(args),
> +					WMAX_METHOD_HDMI_SOURCE, NULL);
>  
>  	if (ACPI_FAILURE(status))
>  		pr_err("alienware-wmi: HDMI toggle failed: results: %u\n",
> @@ -642,8 +692,8 @@ static ssize_t show_amplifier_status(struct device *dev,
>  		.arg = 0,
>  	};
>  	status =
> -	    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
> -				   (u32 *) &out_data);
> +	    alienware_wmax_command(&in_args, sizeof(in_args),
> +				   WMAX_METHOD_AMPLIFIER_CABLE, (u32 *) &out_data);
>  	if (ACPI_SUCCESS(status)) {
>  		if (out_data == 0)
>  			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -694,8 +744,8 @@ static ssize_t show_deepsleep_status(struct device *dev,
>  	struct wmax_basic_args in_args = {
>  		.arg = 0,
>  	};
> -	status = alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_STATUS,
> -					(u32 *) &out_data);
> +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_DEEP_SLEEP_STATUS, (u32 *) &out_data);
>  	if (ACPI_SUCCESS(status)) {
>  		if (out_data == 0)
>  			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
> @@ -723,8 +773,8 @@ static ssize_t toggle_deepsleep(struct device *dev,
>  		args.arg = 2;
>  	pr_debug("alienware-wmi: setting deep sleep to %d : %s", args.arg, buf);
>  
> -	status = alienware_wmax_command(&args, WMAX_METHOD_DEEP_SLEEP_CONTROL,
> -					NULL);
> +	status = alienware_wmax_command(&args, sizeof(args),
> +					WMAX_METHOD_DEEP_SLEEP_CONTROL, NULL);
>  
>  	if (ACPI_FAILURE(status))
>  		pr_err("alienware-wmi: deep sleep control failed: results: %u\n",
> @@ -760,6 +810,160 @@ static int create_deepsleep(struct platform_device *dev)
>  	return ret;
>  }
>  
> +/*
> + * Thermal Profile control
> + *  - Provides thermal profile control through the Platform Profile API
> + */
> +#define PROFILE_MASK		GENMASK(15,8)

Space after comma.

> +#define PROFILE_ACTIVATE	BIT(0)

Add driver specific prefix to the defines please.

> +
> +static u32 profile_to_wmax_arg(enum WMAX_THERMAL_PROFILE prof)
> +{
> +	return FIELD_PREP(PROFILE_MASK, prof) | PROFILE_ACTIVATE;
> +}
> +
> +static int thermal_profile_get(struct platform_profile_handler *pprof,
> +				enum platform_profile_option *profile)
> +{
> +	acpi_status status;
> +	u32 in_args = WMAX_ARG_GET_CURRENT_PROF;
> +	u32 out_data;
> +
> +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_THERMAL_INFORMATION, &out_data);

Are you sure you want to keep out_data as u32? I'm not very happy how
alienware_wmax_command() takes int * but all callers seem to prefer u32 *
(or pass NULL). Should the out_data parameter for alienware_wmax_command() 
be u32 * or int *?

In general, if you find something that doesn't make sense, it often just
is an indication that some cleanup is in order. We're more than happy to
consider such patches along with the feature patches as then things are
moving into the correct direction even if the progress would be slow.

> +	if (ACPI_FAILURE(status))
> +		return -EOPNOTSUPP;
> +
> +	if (out_data == 0xFFFFFFFF)

This constant too should be named if the data really is u32 and not a 
negative error code in which case I'd be fine with < 0 (without naming
the error code) like in the original but it would need int as the type for 
the compare to work.

> +		return -EBADRQC;
> +
> +	switch (out_data) {
> +	case WMAX_THERMAL_LOW_POWER:
> +		*profile = PLATFORM_PROFILE_LOW_POWER;
> +		break;
> +	case WMAX_THERMAL_QUIET:
> +		*profile = PLATFORM_PROFILE_QUIET;
> +		break;
> +	case WMAX_THERMAL_BALANCED:
> +		*profile = PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case WMAX_THERMAL_BALANCED_PERFORMANCE:
> +		*profile = PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> +		break;
> +	case WMAX_THERMAL_PERFORMANCE:
> +	case WMAX_THERMAL_GMODE:
> +		*profile = PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	default:
> +		return -ENODATA;
> +	}
> +
> +	return 0;
> +}
> +
> +static int thermal_profile_set(struct platform_profile_handler *pprof,
> +				enum platform_profile_option profile)
> +{
> +	acpi_status status;
> +	u32 in_args;
> +	u32 out_data;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_LOW_POWER);
> +		break;
> +	case PLATFORM_PROFILE_QUIET:
> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_QUIET);
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED);
> +		break;
> +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED_PERFORMANCE);
> +		break;
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_PERFORMANCE);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_THERMAL_CONTROL, &out_data);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EOPNOTSUPP;
> +
> +	if (out_data == 0xFFFFFFFF)

Ditto.

> +		return -EBADRQC;
> +
> +	return 0;
> +}
> +
> +static int gmode_thermal_profile_set(struct platform_profile_handler *pprof,
> +				     enum platform_profile_option profile)
> +{
> +	acpi_status status;
> +	u32 in_args;
> +	u32 out_data;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_LOW_POWER);
> +		break;
> +	case PLATFORM_PROFILE_QUIET:
> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_QUIET);
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED);
> +		break;
> +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED_PERFORMANCE);
> +		break;
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		in_args = profile_to_wmax_arg(WMAX_THERMAL_GMODE);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_THERMAL_CONTROL, &out_data);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EOPNOTSUPP;
> +
> +	if (out_data == 0xFFFFFFFF)

Ditto.

-- 
 i.

> +		return -EBADRQC;
> +
> +	return 0;
> +}
> +
> +static int create_thermal_profile(void)
> +{
> +	pp_handler.profile_get = thermal_profile_get;
> +
> +	if (quirks->gmode > 0)
> +		pp_handler.profile_set = gmode_thermal_profile_set;
> +	else
> +		pp_handler.profile_set = thermal_profile_set;
> +
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, pp_handler.choices);
> +	set_bit(PLATFORM_PROFILE_QUIET, pp_handler.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, pp_handler.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pp_handler.choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
> +
> +	return platform_profile_register(&pp_handler);
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
> @@ -807,6 +1011,12 @@ static int __init alienware_wmi_init(void)
>  			goto fail_prep_deepsleep;
>  	}
>  
> +	if (quirks->thermal > 0) {
> +		ret = create_thermal_profile();
> +		if (ret)
> +			goto fail_prep_thermal_profile;
> +	}
> +
>  	ret = alienware_zone_init(platform_device);
>  	if (ret)
>  		goto fail_prep_zones;
> @@ -817,6 +1027,7 @@ static int __init alienware_wmi_init(void)
>  	alienware_zone_exit(platform_device);
>  fail_prep_deepsleep:
>  fail_prep_amplifier:
> +fail_prep_thermal_profile:
>  fail_prep_hdmi:
>  	platform_device_del(platform_device);
>  fail_platform_device2:
> @@ -834,6 +1045,7 @@ static void __exit alienware_wmi_exit(void)
>  	if (platform_device) {
>  		alienware_zone_exit(platform_device);
>  		remove_hdmi(platform_device);
> +		remove_thermal_profile();
>  		platform_device_unregister(platform_device);
>  		platform_driver_unregister(&platform_driver);
>  	}
> 

