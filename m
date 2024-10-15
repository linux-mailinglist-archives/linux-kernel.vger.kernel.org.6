Return-Path: <linux-kernel+bounces-365013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAE399DC31
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 875DFB2173D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141A3166F07;
	Tue, 15 Oct 2024 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJd7CcPp"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4C028EC;
	Tue, 15 Oct 2024 02:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728958977; cv=none; b=tU6MvWC2dSf8u2fRheVCWDt6A5kNHhD/be6cpR7eiBx69/9aOZmZD7neOBGg0pibKleRPjfund39MlEIZ6QMi5MUw5MWxsEbuk6XVLFacfzyZQkN9noZYS9DbCLLQsCLtqBx2TE7r1IaRzuLhfQmBUpCJyHQcw/uQQWW2Bx/ASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728958977; c=relaxed/simple;
	bh=/zEDeLBnCp/ki2987VsRH3CDtPBjEMAekta5lZZPlcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdgxDvfXLVN7Lbu2OEMV9osjgWowRoixvXtOGVxrWcTDBL3s3Vs2g+Aj9JeiiTojuYtfYTeeabqgA6ReIy+pVNWTjGkOoXGohDr+sPBqRG3jVHkY1WmYfZ7B3b78VlTmvqBzOMvGO57BQf7HTjYAARlKXHEj1sGzZFCOol3jIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJd7CcPp; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8323b555a6aso302864839f.3;
        Mon, 14 Oct 2024 19:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728958974; x=1729563774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=quU/f0S6mEAVV/V3Jv4JQpO6HxcSzxSA6L4MRtQ3o+o=;
        b=KJd7CcPphQ2CmtMnTFVyavAllPYoVwqf63C3hSk+OPQgMXApncFkjUQ0NeWClD0d5e
         RVLjSOADsJKnvVtW7zsWg12dJu9bX5TupA6VIt5VEU/66ERK350/CXiBNlc9Gc0COojg
         P2jD5o6/sICyp3r47a4WzQ1K3JUPeRLewKIMHiUBpKwSCJxg1zllsgpBOcq/jFqc6Gdc
         W46GHupsBa5/BfW0PIrcTUJJuLENw/Jfr9bKD3Nvked772NtZMRsSwNR/SVNXg/2zSB9
         QOFuCtdhIm4u/1uv00TMI/DSaiZg1bbglOFAvEliNu812f0QqhvJC6yYVVOUMyDAYzsK
         jJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728958974; x=1729563774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quU/f0S6mEAVV/V3Jv4JQpO6HxcSzxSA6L4MRtQ3o+o=;
        b=edZYEq5GqsiVZNEC/nHIgU3FfXWI4Ty8LLr/b75nk3SOhrsRkmdJgr1J8lAN3URHCJ
         rWA5ropoVwZp8xNbJZ5iTsUHqd3VE16WVRZe48OkSJg8+uRrh1IFDZSHhsXNwZST/Hda
         Tpps7t2BkWgBhWZTHfIdXn2FHOqQWsvZcM2zdmcWZql3R5QlgBY7hsCnxBg6T5udId+d
         tiLO0swyArD5EH4k9Le36KUaDJAhqbo3w6mWhFqxIFcrKcT4QY2e2/hezXV5dCxp+4BW
         E/xLcelumO9ckmihVs/Wm34I6Qxn5y9at22L6dmgW/VLJHfW4LcnkSghpT5KWY4Gdvzj
         kn9A==
X-Forwarded-Encrypted: i=1; AJvYcCU04UQIduYIeAV3Y+egBhVd4QGwAeO0LVrjyTLbV9b2bqH+zjaCjyQ1MdZrforKOjDqfccTr/oI6mOHWjn06wSAjvaGbQ==@vger.kernel.org, AJvYcCVZmxT11eYuvg5z8H9jkqT61fmsaTBsfdnP6dbHKkd9w3MQLdxgGsDCGCA7ZDKsOFG/3Kr+jrHyQnM196U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA64F+J41AZPxQnvhkcy2WobEb8vzknYR1PMpzJelpHwldKas8
	XaGOpMBL1j++huSyntL+u+5iAfp+u5pygegs9zh8EuXj6jEo9DMW
X-Google-Smtp-Source: AGHT+IFZZVo5JMB+1P7e+IGup6kZ7e8RR+zFwUhLjuds8ChKEwIjHq9FkQISijeT8ckbOKWub4H5Fw==
X-Received: by 2002:a05:6602:6403:b0:837:7f69:eac2 with SMTP id ca18e2360f4ac-8379241ac0emr1187562839f.1.1728958974088;
        Mon, 14 Oct 2024 19:22:54 -0700 (PDT)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6c11f2sm243372a12.23.2024.10.14.19.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 19:22:53 -0700 (PDT)
Date: Mon, 14 Oct 2024 23:22:50 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 3/4] alienware-wmi: added platform profile support
Message-ID: <wuezi3qo55vgjdeg2f5hdgoh4kwhzvz6w4rmd2bv2fiikn4ytt@vy3ay7l7rw5g>
References: <20241012015849.19036-3-kuurtb@gmail.com>
 <20241012020237.20057-2-kuurtb@gmail.com>
 <4541ab16-254b-425d-8224-faae4669235e@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4541ab16-254b-425d-8224-faae4669235e@gmx.de>

On Mon, Oct 14, 2024 at 06:40:49PM +0200, Armin Wolf wrote:
> Am 12.10.24 um 04:02 schrieb Kurt Borja:
> 
> > Implements platform profile support for Dell laptops with new WMAX
> > thermal interface, present on some Alienware X-Series, Alienware
> > M-Series and Dell's G-Series laptops. This implementation supports two
> > sets of thermal profile codes, namely *thermal* and *thermal_ustt*, plus
> > additional quirk *gmode* for Dell's G-Series laptops.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >   drivers/platform/x86/dell/Kconfig         |   1 +
> >   drivers/platform/x86/dell/alienware-wmi.c | 236 ++++++++++++++++++++++
> >   2 files changed, 237 insertions(+)
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
> > index b27f3b64c..6e30e9376 100644
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
> > @@ -25,6 +28,12 @@
> >   #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
> >   #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
> >   #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
> > +#define WMAX_METHOD_THERMAL_INFORMATION	0x14
> > +#define WMAX_METHOD_THERMAL_CONTROL	0x15
> > +
> > +#define WMAX_ARG_GET_CURRENT_PROF	0x0B
> > +
> > +#define WMAX_FAILURE_CODE		0xFFFFFFFF
> > 
> >   MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
> >   MODULE_DESCRIPTION("Alienware special feature control");
> > @@ -49,11 +58,27 @@ enum WMAX_CONTROL_STATES {
> >   	WMAX_SUSPEND = 3,
> >   };
> > 
> > +enum WMAX_THERMAL_PROFILE {
> > +	WMAX_THERMAL_QUIET = 0x96,
> > +	WMAX_THERMAL_BALANCED = 0x97,
> > +	WMAX_THERMAL_BALANCED_PERFORMANCE = 0x98,
> > +	WMAX_THERMAL_PERFORMANCE = 0x99,
> > +	WMAX_THERMAL_USTT_LOW_POWER = 0xA5,
> > +	WMAX_THERMAL_USTT_QUIET = 0xA3,
> > +	WMAX_THERMAL_USTT_BALANCED = 0xA0,
> > +	WMAX_THERMAL_USTT_BALANCED_PERFORMANCE = 0xA1,
> > +	WMAX_THERMAL_USTT_PERFORMANCE = 0xA4,
> > +	WMAX_THERMAL_GMODE = 0xAB,
> > +};
> > +
> >   struct quirk_entry {
> >   	u8 num_zones;
> >   	u8 hdmi_mux;
> >   	u8 amplifier;
> >   	u8 deepslp;
> > +	u8 thermal;
> > +	u8 thermal_ustt;
> > +	u8 gmode;
> >   };
> > 
> >   static struct quirk_entry *quirks;
> > @@ -64,6 +89,9 @@ static struct quirk_entry quirk_inspiron5675 = {
> >   	.hdmi_mux = 0,
> >   	.amplifier = 0,
> >   	.deepslp = 0,
> > +	.thermal = 0,
> > +	.thermal_ustt = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_unknown = {
> > @@ -71,6 +99,9 @@ static struct quirk_entry quirk_unknown = {
> >   	.hdmi_mux = 0,
> >   	.amplifier = 0,
> >   	.deepslp = 0,
> > +	.thermal = 0,
> > +	.thermal_ustt = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_x51_r1_r2 = {
> > @@ -78,6 +109,9 @@ static struct quirk_entry quirk_x51_r1_r2 = {
> >   	.hdmi_mux = 0,
> >   	.amplifier = 0,
> >   	.deepslp = 0,
> > +	.thermal = 0,
> > +	.thermal_ustt = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_x51_r3 = {
> > @@ -85,6 +119,9 @@ static struct quirk_entry quirk_x51_r3 = {
> >   	.hdmi_mux = 0,
> >   	.amplifier = 1,
> >   	.deepslp = 0,
> > +	.thermal = 0,
> > +	.thermal_ustt = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_asm100 = {
> > @@ -92,6 +129,9 @@ static struct quirk_entry quirk_asm100 = {
> >   	.hdmi_mux = 1,
> >   	.amplifier = 0,
> >   	.deepslp = 0,
> > +	.thermal = 0,
> > +	.thermal_ustt = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_asm200 = {
> > @@ -99,6 +139,9 @@ static struct quirk_entry quirk_asm200 = {
> >   	.hdmi_mux = 1,
> >   	.amplifier = 0,
> >   	.deepslp = 1,
> > +	.thermal = 0,
> > +	.thermal_ustt = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_asm201 = {
> > @@ -106,6 +149,19 @@ static struct quirk_entry quirk_asm201 = {
> >   	.hdmi_mux = 1,
> >   	.amplifier = 1,
> >   	.deepslp = 1,
> > +	.thermal = 0,
> > +	.thermal_ustt = 0,
> > +	.gmode = 0,
> > +};
> > +
> > +static struct quirk_entry quirk_x15_r1 = {
> > +	.num_zones = 2,
> > +	.hdmi_mux = 0,
> > +	.amplifier = 0,
> > +	.deepslp = 0,
> > +	.thermal = 0,
> > +	.thermal_ustt = 1,
> > +	.gmode = 0,
> >   };
> > 
> >   static int __init dmi_matched(const struct dmi_system_id *dmi)
> > @@ -169,6 +225,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
> >   		},
> >   		.driver_data = &quirk_asm201,
> >   	},
> > +	{
> > +		.callback = dmi_matched,
> > +		.ident = "Alienware x15 R1",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R1")
> > +		},
> > +		.driver_data = &quirk_x15_r1,
> > +	},
> >   	{
> >   		.callback = dmi_matched,
> >   		.ident = "Dell Inc. Inspiron 5675",
> > @@ -218,6 +283,7 @@ static struct platform_device *platform_device;
> >   static struct device_attribute *zone_dev_attrs;
> >   static struct attribute **zone_attrs;
> >   static struct platform_zone *zone_data;
> > +static struct platform_profile_handler pp_handler;
> > 
> >   static struct platform_driver platform_driver = {
> >   	.driver = {
> > @@ -761,6 +827,168 @@ static int create_deepsleep(struct platform_device *dev)
> >   	return ret;
> >   }
> > 
> > +/*
> > + * Thermal Profile control
> > + *  - Provides thermal profile control through the Platform Profile API
> > + */
> > +#define WMAX_PROFILE_MASK	GENMASK(15, 8)
> > +#define WMAX_PROFILE_ACTIVATE	BIT(0)
> > +
> > +static u32 profile_to_wmax_arg(enum WMAX_THERMAL_PROFILE prof)
> > +{
> > +	return FIELD_PREP(WMAX_PROFILE_MASK, prof) | WMAX_PROFILE_ACTIVATE;
> > +}
> > +
> > +static int thermal_profile_get(struct platform_profile_handler *pprof,
> > +				enum platform_profile_option *profile)
> 
> Alignment should match open parenthesis.

I will fix it.

>
> > +{
> > +	acpi_status status;
> > +	u32 in_args = WMAX_ARG_GET_CURRENT_PROF;
> > +	u32 out_data;
> > +
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_THERMAL_INFORMATION, &out_data);
> > +
> > +	if (ACPI_FAILURE(status))
> > +		return -EIO;
> > +
> > +	if (out_data == WMAX_FAILURE_CODE)
> > +		return -EBADRQC;
> > +
> > +	switch (out_data) {
> > +	case WMAX_THERMAL_USTT_LOW_POWER:
> > +		*profile = PLATFORM_PROFILE_LOW_POWER;
> > +		break;
> > +	case WMAX_THERMAL_QUIET:
> > +	case WMAX_THERMAL_USTT_QUIET:
> > +		*profile = PLATFORM_PROFILE_QUIET;
> > +		break;
> > +	case WMAX_THERMAL_BALANCED:
> > +	case WMAX_THERMAL_USTT_BALANCED:
> > +		*profile = PLATFORM_PROFILE_BALANCED;
> > +		break;
> > +	case WMAX_THERMAL_BALANCED_PERFORMANCE:
> > +	case WMAX_THERMAL_USTT_BALANCED_PERFORMANCE:
> > +		*profile = PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> > +		break;
> > +	case WMAX_THERMAL_GMODE:
> > +	case WMAX_THERMAL_PERFORMANCE:
> > +	case WMAX_THERMAL_USTT_PERFORMANCE:
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
> 
> Alignment should match open parenthesis.
> 
> > +	acpi_status status;
> > +	u32 in_args;
> > +	u32 out_data;
> > +
> > +	switch (profile) {
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
> > +		if (quirks->gmode > 0)
> > +			in_args = profile_to_wmax_arg(WMAX_THERMAL_GMODE);
> > +		else
> > +			in_args = profile_to_wmax_arg(WMAX_THERMAL_PERFORMANCE);
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_THERMAL_CONTROL, &out_data);
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
> > +static int thermal_profile_set_ustt(struct platform_profile_handler *pprof,
> > +				    enum platform_profile_option profile)
> > +{
> > +	acpi_status status;
> > +	u32 in_args;
> > +	u32 out_data;
> > +
> > +	switch (profile) {
> > +	case PLATFORM_PROFILE_LOW_POWER:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_USTT_LOW_POWER);
> > +		break;
> > +	case PLATFORM_PROFILE_QUIET:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_USTT_QUIET);
> > +		break;
> > +	case PLATFORM_PROFILE_BALANCED:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_USTT_BALANCED);
> > +		break;
> > +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_USTT_BALANCED_PERFORMANCE);
> > +		break;
> > +	case PLATFORM_PROFILE_PERFORMANCE:
> > +		if (quirks->gmode > 0)
> > +			in_args = profile_to_wmax_arg(WMAX_THERMAL_GMODE);
> > +		else
> > +			in_args = profile_to_wmax_arg(WMAX_THERMAL_USTT_PERFORMANCE);
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > +					WMAX_METHOD_THERMAL_CONTROL, &out_data);
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
> > +static int create_thermal_profile(void)
> > +{
> > +	pp_handler.profile_get = thermal_profile_get;
> > +
> > +	if (quirks->thermal > 0)
> > +		pp_handler.profile_set = thermal_profile_set;
> 
> Braces {} should be used on all arms of this statement.

Ok.

>
> > +	else {
> > +		pp_handler.profile_set = thermal_profile_set_ustt;
> > +		set_bit(PLATFORM_PROFILE_LOW_POWER, pp_handler.choices);
> > +	}
> > +
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
> 
> platform_profile_remove() should also be called when quirks->thermal_ustt is set.

Thank you for catching it.

>
> > +}
> > +
> >   static int __init alienware_wmi_init(void)
> >   {
> >   	int ret;
> > @@ -808,6 +1036,12 @@ static int __init alienware_wmi_init(void)
> >   			goto fail_prep_deepsleep;
> >   	}
> > 
> > +	if (quirks->thermal > 0 || quirks->thermal_ustt > 0) {
> > +		ret = create_thermal_profile();
> > +		if (ret)
> > +			goto fail_prep_thermal_profile;
> > +	}
> > +
> >   	ret = alienware_zone_init(platform_device);
> >   	if (ret)
> >   		goto fail_prep_zones;
> > @@ -818,6 +1052,7 @@ static int __init alienware_wmi_init(void)
> >   	alienware_zone_exit(platform_device);
> >   fail_prep_deepsleep:
> >   fail_prep_amplifier:
> > +fail_prep_thermal_profile:
> 
> fail_prep_thermal_profile should come before fail_prep_deepsleep for proper rollback in case of an error.
> Also fail_prep_zones should call remove_thermal_profile().

Ok.

>
> >   fail_prep_hdmi:
> >   	platform_device_del(platform_device);
> >   fail_platform_device2:
> > @@ -835,6 +1070,7 @@ static void __exit alienware_wmi_exit(void)
> >   	if (platform_device) {
> >   		alienware_zone_exit(platform_device);
> >   		remove_hdmi(platform_device);
> > +		remove_thermal_profile();
> 
> Please move remove_thermal_profile() above remove_hdmi().

Ok.

> 
> Otherwise, the patch look good.
> 
> Thanks,
> Armin Wolf
> 

Thank you.

Kurt

> >   		platform_device_unregister(platform_device);
> >   		platform_driver_unregister(&platform_driver);
> >   	}

