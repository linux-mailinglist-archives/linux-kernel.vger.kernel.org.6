Return-Path: <linux-kernel+bounces-361005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7295599A24A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D5D1F25ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF82141C8;
	Fri, 11 Oct 2024 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YSqlhJqA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898DF212D05;
	Fri, 11 Oct 2024 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644706; cv=none; b=p0B3ryOpaNZyof44ueNsEHVHL7qcRF+j7SAW6+eXJSyfaziVmZHMBObf5kXGHuz9bpuvLVB4fnZuyFYBXXWZcCg+mf00pugifLJSYe5KQoARPo51Q5z9ncv6oezMF0als1FJIyUntIq5W+CdUx4MZHIPSqKytTvhHDMeILeBH4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644706; c=relaxed/simple;
	bh=R3nWTPNlPs1+CDCMutvHH8vuIeo/nChWUOhR5LmNvlA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u4zN2XZi9MnAn8W9cWHFAKZPCiK6AGTnMF/7k6oESC3DDTyiXyDUUXfHD6MlXRVF5VGvW/UU1z9Y3MrJBfnXnNoRnazlqiTgMLz9SMgvjzt9GTfWZrGzRf+LRIKXGqo9JWIX4QzjrTW8cAjJ8haQUuNAcaqsRT1u5tuhLfCiX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YSqlhJqA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728644704; x=1760180704;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=R3nWTPNlPs1+CDCMutvHH8vuIeo/nChWUOhR5LmNvlA=;
  b=YSqlhJqAxY3WHH3TLviNdrGakMrMC5iVllWAuZPyfkO4in8/oXiK7YB9
   rFzwRlgkJEgLpE1mtOOW9IdJeang/KP2w0S2uelROQJd5yUNWadh7fRwP
   FkHNTsK76b7XhYnsZMuRCP341dDE6Vb8GUrmq8KH5NDWUK2/Rk28YFCcl
   bJGPFosg3oGpEn/ayxe/uz3Z1N/5ER6UynmkHPd9EK/czRNGScjdseOSG
   TyU7PwR6aOggk4jmaq8JvSI0XVzf2S4WAX98KFpgAoZUAqVWkth/fwpIi
   7XMwb6KSCG+mZ0YXh058B/wtivdjjBPLdh6uZ/0Obq3gDO1xYQ5jZ0+KB
   w==;
X-CSE-ConnectionGUID: SSXiQCdbRHKgFjSgb/N+9g==
X-CSE-MsgGUID: ice/o/HaRamI1ATYbV8bAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="39434327"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="39434327"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:05:04 -0700
X-CSE-ConnectionGUID: 0Add7EMqTk6Q+BWKIaUjKw==
X-CSE-MsgGUID: xjkxwM4yTOaEj1BLcdV/LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="114340594"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:05:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Oct 2024 14:04:58 +0300 (EEST)
To: Kurt Borja <kuurtb@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, W_Armin@gmx.de, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 1/4] alienware-wmi: fixed indentation and clean up
In-Reply-To: <20241011064634.306236-2-kuurtb@gmail.com>
Message-ID: <1cf8cd09-aeba-be32-164b-514d65b635b4@linux.intel.com>
References: <20241011064336.305795-2-kuurtb@gmail.com> <20241011064634.306236-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 11 Oct 2024, Kurt Borja wrote:

All patches should provide a description of the change in the commit 
message body here (the shortlog in the subject is not enough). So please 
resubmit with the descriptions added to all patches.

The code changes themselves looked very good, thanks for doing this.

--
 i.

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/platform/x86/dell/alienware-wmi.c | 134 +++++++++++-----------
>  1 file changed, 67 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index f5ee62ce1..16a3fe9ac 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -116,68 +116,68 @@ static int __init dmi_matched(const struct dmi_system_id *dmi)
>  
>  static const struct dmi_system_id alienware_quirks[] __initconst = {
>  	{
> -	 .callback = dmi_matched,
> -	 .ident = "Alienware X51 R3",
> -	 .matches = {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R3"),
> -		     },
> -	 .driver_data = &quirk_x51_r3,
> -	 },
> +		.callback = dmi_matched,
> +		.ident = "Alienware X51 R3",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R3"),
> +		},
> +		.driver_data = &quirk_x51_r3,
> +	},
>  	{
> -	 .callback = dmi_matched,
> -	 .ident = "Alienware X51 R2",
> -	 .matches = {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R2"),
> -		     },
> -	 .driver_data = &quirk_x51_r1_r2,
> -	 },
> +		.callback = dmi_matched,
> +		.ident = "Alienware X51 R2",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R2"),
> +		},
> +		.driver_data = &quirk_x51_r1_r2,
> +	},
>  	{
> -	 .callback = dmi_matched,
> -	 .ident = "Alienware X51 R1",
> -	 .matches = {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51"),
> -		     },
> -	 .driver_data = &quirk_x51_r1_r2,
> -	 },
> +		.callback = dmi_matched,
> +		.ident = "Alienware X51 R1",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51"),
> +		},
> +		.driver_data = &quirk_x51_r1_r2,
> +	},
>  	{
> -	 .callback = dmi_matched,
> -	 .ident = "Alienware ASM100",
> -	 .matches = {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -		     DMI_MATCH(DMI_PRODUCT_NAME, "ASM100"),
> -		     },
> -	 .driver_data = &quirk_asm100,
> -	 },
> +		.callback = dmi_matched,
> +		.ident = "Alienware ASM100",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ASM100"),
> +		},
> +		.driver_data = &quirk_asm100,
> +	},
>  	{
> -	 .callback = dmi_matched,
> -	 .ident = "Alienware ASM200",
> -	 .matches = {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -		     DMI_MATCH(DMI_PRODUCT_NAME, "ASM200"),
> -		     },
> -	 .driver_data = &quirk_asm200,
> -	 },
> +		.callback = dmi_matched,
> +		.ident = "Alienware ASM200",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ASM200"),
> +		},
> +		.driver_data = &quirk_asm200,
> +	},
>  	{
> -	 .callback = dmi_matched,
> -	 .ident = "Alienware ASM201",
> -	 .matches = {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -		     DMI_MATCH(DMI_PRODUCT_NAME, "ASM201"),
> -		     },
> -	 .driver_data = &quirk_asm201,
> -	 },
> -	 {
> -	 .callback = dmi_matched,
> -	 .ident = "Dell Inc. Inspiron 5675",
> -	 .matches = {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -		     DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5675"),
> -		     },
> -	 .driver_data = &quirk_inspiron5675,
> -	 },
> +		.callback = dmi_matched,
> +		.ident = "Alienware ASM201",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ASM201"),
> +		},
> +		.driver_data = &quirk_asm201,
> +	},
> +	{
> +		.callback = dmi_matched,
> +		.ident = "Dell Inc. Inspiron 5675",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5675"),
> +		},
> +		.driver_data = &quirk_inspiron5675,
> +	},
>  	{}
>  };
>  
> @@ -221,8 +221,8 @@ static struct platform_zone *zone_data;
>  
>  static struct platform_driver platform_driver = {
>  	.driver = {
> -		   .name = "alienware-wmi",
> -		   }
> +		.name = "alienware-wmi",
> +	}
>  };
>  
>  static struct attribute_group zone_attribute_group = {
> @@ -292,7 +292,7 @@ static int alienware_update_led(struct platform_zone *zone)
>  		guid = WMAX_CONTROL_GUID;
>  		method_id = WMAX_METHOD_ZONE_CONTROL;
>  
> -		input.length = (acpi_size) sizeof(wmax_basic_args);
> +		input.length = sizeof(wmax_basic_args);
>  		input.pointer = &wmax_basic_args;
>  	} else {
>  		legacy_args.colors = zone->colors;
> @@ -306,7 +306,7 @@ static int alienware_update_led(struct platform_zone *zone)
>  			guid = LEGACY_CONTROL_GUID;
>  		method_id = zone->location + 1;
>  
> -		input.length = (acpi_size) sizeof(legacy_args);
> +		input.length = sizeof(legacy_args);
>  		input.pointer = &legacy_args;
>  	}
>  	pr_debug("alienware-wmi: guid %s method %d\n", guid, method_id);
> @@ -358,7 +358,7 @@ static int wmax_brightness(int brightness)
>  		.led_mask = 0xFF,
>  		.percentage = brightness,
>  	};
> -	input.length = (acpi_size) sizeof(args);
> +	input.length = sizeof(args);
>  	input.pointer = &args;
>  	status = wmi_evaluate_method(WMAX_CONTROL_GUID, 0,
>  				     WMAX_METHOD_BRIGHTNESS, &input, NULL);
> @@ -508,7 +508,7 @@ static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
>  	struct acpi_buffer input;
>  	struct acpi_buffer output;
>  
> -	input.length = (acpi_size) sizeof(*in_args);
> +	input.length = sizeof(*in_args);
>  	input.pointer = in_args;
>  	if (out_data) {
>  		output.length = ACPI_ALLOCATE_BUFFER;
> @@ -542,7 +542,7 @@ static ssize_t show_hdmi_cable(struct device *dev,
>  	};
>  	status =
>  	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
> -				   (u32 *) &out_data);
> +				   &out_data);
>  	if (ACPI_SUCCESS(status)) {
>  		if (out_data == 0)
>  			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -563,7 +563,7 @@ static ssize_t show_hdmi_source(struct device *dev,
>  	};
>  	status =
>  	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
> -				   (u32 *) &out_data);
> +				   &out_data);
>  
>  	if (ACPI_SUCCESS(status)) {
>  		if (out_data == 1)
> @@ -643,7 +643,7 @@ static ssize_t show_amplifier_status(struct device *dev,
>  	};
>  	status =
>  	    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
> -				   (u32 *) &out_data);
> +				   &out_data);
>  	if (ACPI_SUCCESS(status)) {
>  		if (out_data == 0)
>  			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -695,7 +695,7 @@ static ssize_t show_deepsleep_status(struct device *dev,
>  		.arg = 0,
>  	};
>  	status = alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_STATUS,
> -					(u32 *) &out_data);
> +					&out_data);
>  	if (ACPI_SUCCESS(status)) {
>  		if (out_data == 0)
>  			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
> 

