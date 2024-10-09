Return-Path: <linux-kernel+bounces-357257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3526C996E95
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A06B24B34
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAAC19DF4B;
	Wed,  9 Oct 2024 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC9HsLxz"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70919C54B;
	Wed,  9 Oct 2024 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485301; cv=none; b=pzEd2ZUcY6PlNYcp28RyFxZ9n9K4hZKxK8Y9VftQLXVARrOpOng4Z+4YiDkia8V01G0ew1t3kQkpVYBp/e3l114qilh2cF3R41zJ4xlEFyO1gvSaaiA5cvhSupvuAVzMzE9jPIbRiveG6WNCs4sGpMLPLSN4jg1/AbGYVnNTkIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485301; c=relaxed/simple;
	bh=ZSG9ByE2xzvL++dkasDlimZmJ9O2CwMuJIo/gpXCgnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gz90CzbSwIw4idizVdE5drUEp5hARUjt8UGikpyer50DgnhHfU6GVfm2cXj7Q/6VObl3WZEApJ4beU9CvqX8UfzlB6Na/CIxUuRnnK0D5sotFDb6d1dqScpMqp6IfS9nqfbZZuToDe82HT/qU6hoJaHIGw12VnfG7Is3xyWXhyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LC9HsLxz; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-835393376e1so67570639f.1;
        Wed, 09 Oct 2024 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728485298; x=1729090098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj14TtaWX9/4jSk79lQYbV7XCkSlo4wxoHEuaz/zC8Q=;
        b=LC9HsLxzaNhzeuMSZXiJHdsWjKHFQFPHRq4NaKc5oNKGi8AW/DdIFSgazHSwiDIpTB
         8lVjB51uQEy+bSfD3l8f7jLiGNd54IE10pRy8jP6ogkZ9q7ajg5NFxqrN7itdZ+ETq5M
         l0Ypk9ygXYdVvzqIpCis7CaQOOCvdGuaYe/qYqB/jXRQFPhDHGJ/2DFivkFbo7zwlAtV
         rpxzEPqBeP6uXSVAbWgrSQ5uUmenzKPncit/C7I505qnSiF5E/4+hR46EwwIuI8JiU0u
         IdIPtuXbO6FjmY6AMmQgLT7L3yWb9coZj9jicO+3o3MSch0PnTjndETKW4thBVQfyhh9
         PpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728485298; x=1729090098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj14TtaWX9/4jSk79lQYbV7XCkSlo4wxoHEuaz/zC8Q=;
        b=OpG5ZtGgUg2FhFBTYjs0MvNFKwEMRobR42PCDIj3FiA0QLRC5XGbjcyJcyIIlXXIFA
         HR8pdYzqC63YAWNDmYHkS31UjlROWJy2OitrW+a+V37OIJFUM+nMh3XZNipFh/syiycg
         Kfng56BWKHFslQsLdWYw3os2OiZBpXN5ey7OXKC/sJ5c/7kHXdSCdCmCnC8zMUVNSBbn
         4XiNpQq9nS9mFgLjEKIOBEpglnoFFlCVM4tByFjVWRGuHCPraDbGtgvZFavp58plTAi1
         /aJwE6p1DNe0SBDYDj+jaPHnbYn8YfxJUD+7w3UfeSiAiejNh1WhR4yiEEeTEE5MK/yb
         vClg==
X-Forwarded-Encrypted: i=1; AJvYcCUvxoezv2A0C6syl9FG0A6yllAnN7qhg3V8xgPKmN7+lyMcKSdA6kfjsTu2cmtqAJ023aVSIx99Nu6gAv0=@vger.kernel.org, AJvYcCVkJBSkJ+pW3l1dwEel5QPVtJQKrbm9np52JJytYHYGy4vc8yGe1/xV5sUC4EUwSu3khHbMMYFmOcD/JrzAxX7dEQwgkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmbDgs8DxQT4J4wmlweMTj8Gpe+6q2ec+Ia5RaoYsgCk6W6X4Y
	J3LhUpuc6H2gSWkXVeBrIunP+11IyIQfF8Aw6L8Wzw9XMJ0XzRPq
X-Google-Smtp-Source: AGHT+IHCO4kqefZoJh4pL3c4El4bZ4z/HbTR5edG0zm3LP0fKRgGjvW4xTM+Wg4p020zA/AATInxLA==
X-Received: by 2002:a05:6602:48d:b0:82c:f8fb:2c23 with SMTP id ca18e2360f4ac-8353d50fb6fmr307632339f.15.1728485298169;
        Wed, 09 Oct 2024 07:48:18 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d65225sm7868491b3a.158.2024.10.09.07.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:48:17 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: w_armin@gmx.de
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	kuurtb@gmail.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] alienware-wmi: Dell AWCC platform_profile support
Date: Wed,  9 Oct 2024 11:48:13 -0300
Message-ID: <20241009144813.7704-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <d7ecb190-285a-4229-a8c8-3105b1f31d5d@gmx.de>
References: <d7ecb190-285a-4229-a8c8-3105b1f31d5d@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yes, of course.

> > This driver was heavily inspired on inspur_platform_profile, special
> > thanks.
> > 
> > Notes:
> >   - Performance (FullSpeed) profile is a special profile which has it's own
> >     entry in the Firmware Settings of the Alienware x15 R1. It also changes
> >     the color of the F1 key. I suspect this behavior would be replicated in
> >     other X-Series or M-Series laptops.
> >   - G-Mode is a profile documented on [1] which mimics the behavior of
> >     FullSpeed mode but it does not have an entry on the Firmware Settings of
> >     the Alienware x15 R1, this may correspond to the G-Mode functionality on
> >     G-Series laptops (activated by a special button) but I cannot test it. I
> >     did not include this code in the driver as G-Mode causes unexpected
> >     behavior on X-Series laptops.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > 
> > ---
> > v3:
> >   - Removed extra empty line
> >   - 0x0B named WMAX_ARG_GET_CURRENT_PROF
> >   - Removed casts to the same type on functions added in this patch
> >   - Thermal profile to WMAX argument is now an static function and makes
> >     use of in-built kernel macros
> >   - Platform profile is now removed only if it was created first
> >   - create_platform_profile is now create_thermal_profile to avoid
> >     confusion
> >   - profile_get and profile_set functions renamed too to match the above
> > v2:
> >   - Moved functionality to alienware-wmi driver
> >   - Added thermal and gmode quirks to add support based on dmi match
> >   - Performance profile is now GMODE for devices that support it
> >   - alienware_wmax_command now is insize agnostic to support new thermal
> >     methods
> > ---
> >   drivers/platform/x86/dell/Kconfig         |   1 +
> >   drivers/platform/x86/dell/alienware-wmi.c | 238 ++++++++++++++++++++--
> >   2 files changed, 226 insertions(+), 13 deletions(-)
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
> > index f5ee62ce1..e3ef4b10b 100644
> > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > @@ -10,6 +10,7 @@
> >   #include <linux/acpi.h>
> >   #include <linux/module.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/platform_profile.h>
> >   #include <linux/dmi.h>
> >   #include <linux/leds.h>
> > 
> > @@ -25,6 +26,10 @@
> >   #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
> >   #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
> >   #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
> > +#define WMAX_METHOD_THERMAL_INFORMATION	0x14
> > +#define WMAX_METHOD_THERMAL_CONTROL	0x15
> > +
> > +#define WMAX_ARG_GET_CURRENT_PROF	0x0B
> > 
> >   MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
> >   MODULE_DESCRIPTION("Alienware special feature control");
> > @@ -49,11 +54,22 @@ enum WMAX_CONTROL_STATES {
> >   	WMAX_SUSPEND = 3,
> >   };
> > 
> > +enum WMAX_THERMAL_PROFILE {
> > +	WMAX_THERMAL_QUIET = 0xA3,
> > +	WMAX_THERMAL_BALANCED = 0xA0,
> > +	WMAX_THERMAL_BALANCED_PERFORMANCE = 0xA1,
> > +	WMAX_THERMAL_PERFORMANCE = 0xA4,
> > +	WMAX_THERMAL_GMODE = 0xAB,
> > +	WMAX_THERMAL_LOW_POWER	= 0xA5,
> > +};
> > +
> >   struct quirk_entry {
> >   	u8 num_zones;
> >   	u8 hdmi_mux;
> >   	u8 amplifier;
> >   	u8 deepslp;
> > +	u8 thermal;
> > +	u8 gmode;
> >   };
> > 
> >   static struct quirk_entry *quirks;
> > @@ -64,6 +80,8 @@ static struct quirk_entry quirk_inspiron5675 = {
> >   	.hdmi_mux = 0,
> >   	.amplifier = 0,
> >   	.deepslp = 0,
> > +	.thermal = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_unknown = {
> > @@ -71,6 +89,8 @@ static struct quirk_entry quirk_unknown = {
> >   	.hdmi_mux = 0,
> >   	.amplifier = 0,
> >   	.deepslp = 0,
> > +	.thermal = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_x51_r1_r2 = {
> > @@ -78,6 +98,8 @@ static struct quirk_entry quirk_x51_r1_r2 = {
> >   	.hdmi_mux = 0,
> >   	.amplifier = 0,
> >   	.deepslp = 0,
> > +	.thermal = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_x51_r3 = {
> > @@ -85,6 +107,8 @@ static struct quirk_entry quirk_x51_r3 = {
> >   	.hdmi_mux = 0,
> >   	.amplifier = 1,
> >   	.deepslp = 0,
> > +	.thermal = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_asm100 = {
> > @@ -92,6 +116,8 @@ static struct quirk_entry quirk_asm100 = {
> >   	.hdmi_mux = 1,
> >   	.amplifier = 0,
> >   	.deepslp = 0,
> > +	.thermal = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_asm200 = {
> > @@ -99,6 +125,8 @@ static struct quirk_entry quirk_asm200 = {
> >   	.hdmi_mux = 1,
> >   	.amplifier = 0,
> >   	.deepslp = 1,
> > +	.thermal = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_asm201 = {
> > @@ -106,6 +134,17 @@ static struct quirk_entry quirk_asm201 = {
> >   	.hdmi_mux = 1,
> >   	.amplifier = 1,
> >   	.deepslp = 1,
> > +	.thermal = 0,
> > +	.gmode = 0,
> > +};
> > +
> > +static struct quirk_entry quirk_x15_r1 = {
> > +	.num_zones = 2,
> > +	.hdmi_mux = 0,
> > +	.amplifier = 0,
> > +	.deepslp = 0,
> > +	.thermal = 1,
> > +	.gmode = 0,
> >   };
> > 
> >   static int __init dmi_matched(const struct dmi_system_id *dmi)
> > @@ -169,6 +208,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
> >   		     },
> >   	 .driver_data = &quirk_asm201,
> >   	 },
> > +	 {
> > +	 .callback = dmi_matched,
> > +	 .ident = "Alienware x15 R1",
> > +	 .matches = {
> > +		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> > +		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R1")
> > +		    },
> > +	 .driver_data = &quirk_x15_r1,
> > +	},
> >   	 {
> >   	 .callback = dmi_matched,
> >   	 .ident = "Dell Inc. Inspiron 5675",
> > @@ -218,6 +266,7 @@ static struct platform_device *platform_device;
> >   static struct device_attribute *zone_dev_attrs;
> >   static struct attribute **zone_attrs;
> >   static struct platform_zone *zone_data;
> > +static struct platform_profile_handler pp_handler;
> > 
> >   static struct platform_driver platform_driver = {
> >   	.driver = {
> > @@ -500,7 +549,7 @@ static void alienware_zone_exit(struct platform_device *dev)
> >   	kfree(zone_attrs);
> >   }
> > 
> > -static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
> > +static acpi_status alienware_wmax_command(void *in_args, size_t insize,
> >   					  u32 command, int *out_data)
> >   {
> 
> Can you split this change into a separate patch? This would make review a bit easier.
> 

Yes, sure. In that case should I mention this patch depends on that one
in v4?


> >   	acpi_status status;
> > @@ -508,7 +557,7 @@ static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
> >   	struct acpi_buffer input;
> >   	struct acpi_buffer output;
> > 
> > -	input.length = (acpi_size) sizeof(*in_args);
> > +	input.length = (acpi_size) insize;
> 
> Please drop the cast to acpi_size.
> 

Ok.

> >   	input.pointer = in_args;
> >   	if (out_data) {
> >   		output.length = ACPI_ALLOCATE_BUFFER;
> > @@ -541,8 +590,8 @@ static ssize_t show_hdmi_cable(struct device *dev,
> >   		.arg = 0,
> >   	};
> >   	status =
> > -	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
> > -				   (u32 *) &out_data);
> > +	    alienware_wmax_command(&in_args, sizeof(in_args),
> > +				   WMAX_METHOD_HDMI_CABLE, (u32 *) &out_data);
> >   	if (ACPI_SUCCESS(status)) {
> >   		if (out_data == 0)
> >   			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> > @@ -562,8 +611,8 @@ static ssize_t show_hdmi_source(struct device *dev,
> >   		.arg = 0,
> >   	};
> >   	status =
> > -	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
> > -				   (u32 *) &out_data);
> > +	    alienware_wmax_command(&in_args, sizeof(in_args),
> > +				   WMAX_METHOD_HDMI_STATUS, (u32 *) &out_data);
> > 
> >   	if (ACPI_SUCCESS(status)) {
> >   		if (out_data == 1)
> > @@ -589,7 +638,8 @@ static ssize_t toggle_hdmi_source(struct device *dev,
> >   		args.arg = 3;
> >   	pr_debug("alienware-wmi: setting hdmi to %d : %s", args.arg, buf);
> > 
> > -	status = alienware_wmax_command(&args, WMAX_METHOD_HDMI_SOURCE, NULL);
> > +	status = alienware_wmax_command(&args, sizeof(args),
> > +					WMAX_METHOD_HDMI_SOURCE, NULL);
> > 
> >   	if (ACPI_FAILURE(status))
> >   		pr_err("alienware-wmi: HDMI toggle failed: results: %u\n",
> > @@ -642,8 +692,8 @@ static ssize_t show_amplifier_status(struct device *dev,
> >   		.arg = 0,
> >   	};
> >   	status =
> > -	    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
> > -				   (u32 *) &out_data);
> > +	    alienware_wmax_command(&in_args, sizeof(in_args),
> > +				   WMAX_METHOD_AMPLIFIER_CABLE, (u32 *) &out_data);
> >   	if (ACPI_SUCCESS(status)) {
> >   		if (out_data == 0)
> >   			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> > @@ -694,8 +744,8 @@ static ssize_t show_deepsleep_status(struct device *dev,
> >   	struct wmax_basic_args in_args = {
> >   		.arg = 0,
> >   	};
> > -	status = alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_STATUS,
> > -					(u32 *) &out_data);
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_DEEP_SLEEP_STATUS, (u32 *) &out_data);
> >   	if (ACPI_SUCCESS(status)) {
> >   		if (out_data == 0)
> >   			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
> > @@ -723,8 +773,8 @@ static ssize_t toggle_deepsleep(struct device *dev,
> >   		args.arg = 2;
> >   	pr_debug("alienware-wmi: setting deep sleep to %d : %s", args.arg, buf);
> > 
> > -	status = alienware_wmax_command(&args, WMAX_METHOD_DEEP_SLEEP_CONTROL,
> > -					NULL);
> > +	status = alienware_wmax_command(&args, sizeof(args),
> > +					WMAX_METHOD_DEEP_SLEEP_CONTROL, NULL);
> > 
> >   	if (ACPI_FAILURE(status))
> >   		pr_err("alienware-wmi: deep sleep control failed: results: %u\n",
> > @@ -760,6 +810,160 @@ static int create_deepsleep(struct platform_device *dev)
> >   	return ret;
> >   }
> > 
> > +/*
> > + * Thermal Profile control
> > + *  - Provides thermal profile control through the Platform Profile API
> > + */
> > +#define PROFILE_MASK		GENMASK(15,8)
> > +#define PROFILE_ACTIVATE	BIT(0)
> > +
> > +static u32 profile_to_wmax_arg(enum WMAX_THERMAL_PROFILE prof)
> > +{
> > +	return FIELD_PREP(PROFILE_MASK, prof) | PROFILE_ACTIVATE;
> > +}
> > +
> > +static int thermal_profile_get(struct platform_profile_handler *pprof,
> > +				enum platform_profile_option *profile)
> > +{
> > +	acpi_status status;
> > +	u32 in_args = WMAX_ARG_GET_CURRENT_PROF;
> > +	u32 out_data;
> > +
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_THERMAL_INFORMATION, &out_data);
> > +
> > +	if (ACPI_FAILURE(status))
> > +		return -EOPNOTSUPP;
> 
> Please return -EIO.
> 

Ok.

> > +
> > +	if (out_data == 0xFFFFFFFF)
> > +		return -EBADRQC;
> > +
> > +	switch (out_data) {
> > +	case WMAX_THERMAL_LOW_POWER:
> > +		*profile = PLATFORM_PROFILE_LOW_POWER;
> > +		break;
> > +	case WMAX_THERMAL_QUIET:
> > +		*profile = PLATFORM_PROFILE_QUIET;
> > +		break;
> > +	case WMAX_THERMAL_BALANCED:
> > +		*profile = PLATFORM_PROFILE_BALANCED;
> > +		break;
> > +	case WMAX_THERMAL_BALANCED_PERFORMANCE:
> > +		*profile = PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> > +		break;
> > +	case WMAX_THERMAL_PERFORMANCE:
> > +	case WMAX_THERMAL_GMODE:
> > +		*profile = PLATFORM_PROFILE_PERFORMANCE;
> > +		break;
> > +	default:
> > +		return -ENODATA;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int thermal_profile_set(struct platform_profile_handler *pprof,
> > +				enum platform_profile_option profile)
> > +{
> > +	acpi_status status;
> > +	u32 in_args;
> > +	u32 out_data;
> > +
> > +	switch (profile) {
> > +	case PLATFORM_PROFILE_LOW_POWER:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_LOW_POWER);
> > +		break;
> > +	case PLATFORM_PROFILE_QUIET:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_QUIET);
> > +		break;
> > +	case PLATFORM_PROFILE_BALANCED:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED);
> > +		break;
> > +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED_PERFORMANCE);
> > +		break;
> > +	case PLATFORM_PROFILE_PERFORMANCE:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_PERFORMANCE);
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_THERMAL_CONTROL, &out_data);
> > +
> > +	if (ACPI_FAILURE(status))
> > +		return -EOPNOTSUPP;
> 
> Return -EIO.
> 
> > +
> > +	if (out_data == 0xFFFFFFFF)
> > +		return -EBADRQC;
> > +
> > +	return 0;
> > +}
> > +
> > +static int gmode_thermal_profile_set(struct platform_profile_handler *pprof,
> > +				     enum platform_profile_option profile)
> > +{
> > +	acpi_status status;
> > +	u32 in_args;
> > +	u32 out_data;
> > +
> > +	switch (profile) {
> > +	case PLATFORM_PROFILE_LOW_POWER:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_LOW_POWER);
> > +		break;
> > +	case PLATFORM_PROFILE_QUIET:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_QUIET);
> > +		break;
> > +	case PLATFORM_PROFILE_BALANCED:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED);
> > +		break;
> > +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_BALANCED_PERFORMANCE);
> > +		break;
> > +	case PLATFORM_PROFILE_PERFORMANCE:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_GMODE);
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_THERMAL_CONTROL, &out_data);
> > +
> > +	if (ACPI_FAILURE(status))
> > +		return -EOPNOTSUPP;
> 
> Return -EIO.
> 
> Otherwise the patch looks quite good.
> 

Thank you! It's my first time working on the kernel.

> Thanks,
> Armin Wolf

Your feedback is appreciated.

Kurt

> > +
> > +	if (out_data == 0xFFFFFFFF)
> > +		return -EBADRQC;
> > +
> > +	return 0;
> > +}
> > +
> > +static int create_thermal_profile(void)
> > +{
> > +	pp_handler.profile_get = thermal_profile_get;
> > +
> > +	if (quirks->gmode > 0)
> > +		pp_handler.profile_set = gmode_thermal_profile_set;
> > +	else
> > +		pp_handler.profile_set = thermal_profile_set;
> > +
> > +	set_bit(PLATFORM_PROFILE_LOW_POWER, pp_handler.choices);
> > +	set_bit(PLATFORM_PROFILE_QUIET, pp_handler.choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED, pp_handler.choices);
> > +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pp_handler.choices);
> > +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
> > +
> > +	return platform_profile_register(&pp_handler);
> > +}
> > +
> > +static void remove_thermal_profile(void)
> > +{
> > +	if (quirks->thermal > 0)
> > +		platform_profile_remove();
> > +}
> > +
> >   static int __init alienware_wmi_init(void)
> >   {
> >   	int ret;
> > @@ -807,6 +1011,12 @@ static int __init alienware_wmi_init(void)
> >   			goto fail_prep_deepsleep;
> >   	}
> > 
> > +	if (quirks->thermal > 0) {
> > +		ret = create_thermal_profile();
> > +		if (ret)
> > +			goto fail_prep_thermal_profile;
> > +	}
> > +
> >   	ret = alienware_zone_init(platform_device);
> >   	if (ret)
> >   		goto fail_prep_zones;
> > @@ -817,6 +1027,7 @@ static int __init alienware_wmi_init(void)
> >   	alienware_zone_exit(platform_device);
> >   fail_prep_deepsleep:
> >   fail_prep_amplifier:
> > +fail_prep_thermal_profile:
> >   fail_prep_hdmi:
> >   	platform_device_del(platform_device);
> >   fail_platform_device2:
> > @@ -834,6 +1045,7 @@ static void __exit alienware_wmi_exit(void)
> >   	if (platform_device) {
> >   		alienware_zone_exit(platform_device);
> >   		remove_hdmi(platform_device);
> > +		remove_thermal_profile();
> >   		platform_device_unregister(platform_device);
> >   		platform_driver_unregister(&platform_driver);
> >   	}

