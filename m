Return-Path: <linux-kernel+bounces-375814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC1A9A9B26
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33341F2379F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9388D14F108;
	Tue, 22 Oct 2024 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki4oi0Je"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5B014B976;
	Tue, 22 Oct 2024 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582533; cv=none; b=LwtYF20WFn0MNNt3/+4rGE6KrmbLKKi3Yy2tGdYC6tlgvUN07LcPybF8rRpzwK/g/a6cgZ9WwOlZUjI7EHn3/FaL/jyB+dpmP1Pz4QJnoRMxb/qw9Q4qLr0UOomvZYrzx8sJL5WRvi4zGXPkXoFY3sWjN773B57NC5f34t9YXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582533; c=relaxed/simple;
	bh=Twx00RyOIpXvMPyzq3EdeMadUDtSTZ62O8y7SxMDp8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZmBdqrQPl/HX4waSw1vLoPq2RCtT/RAtp2faVWHKoTRljpFPdJnyB3NKou8PwQ3Q/SEbMRtmMkwt35pzmTpVZpQKECuywmOQJCZiKZu//eX7TfvusKPjcSY7mmCWp77l3Z2B9t/bLWgYnYK6/qY3YeKwsxvNOc60HJP0TNiXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ki4oi0Je; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a39cabb9faso18244305ab.3;
        Tue, 22 Oct 2024 00:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729582531; x=1730187331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=osMWLk+ypvOOH+0rFfZT3p7MHG34DQP80IdAbXVqVMc=;
        b=ki4oi0Jes9EjhvGBINx/Rq9zoi1sCcBn5Ux71RrvN+K//tRZFsp1/8ayfCGXM5zvF2
         Ntrh6nlKRfT0/HuNmSWho/JwVVyN9AMt90rrGrc7RREDsbYHr8tVvMeMqVi3PxsWe6hW
         vqzBpszKzdZeiKPa9Q+TvKbMhuREn9M/hY0NK/d6W5HEWIaXVXMT9SApHQVdZcbe0xyy
         CHFmHRPWC0hUjG0pM5Zt3zgZH/WZzW4/tgwEuvlvb0Bofq8TIzyASr42wXy9IT0SjV3/
         StlQFYtMU1uGn8mIFEjzw2AIuVc5GC4B3bizzEaTmphtOBV0zYApLj3MyGHZq/1ZDzYs
         RbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729582531; x=1730187331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osMWLk+ypvOOH+0rFfZT3p7MHG34DQP80IdAbXVqVMc=;
        b=wMgzi6+flY45g0B9fwHYcBBqyjxyq1ojxiCVilA6ptb2o0r7yJa+bdDwtqih0WSf++
         vOjzQx38lJm7Zkfqn3FtO0qTGkMsUeUyR/R4njD78BJqDQ/4LcXqJUbA0Suq2krFLt/w
         s7WyTMQJui1iZhiM6ixkSza7cQbZyGWLQ9URPhc+wOuhQq90YFw/kutthAb2O5Zpx/vK
         CnPhGNe74U2EeTUv598knDoQQ7a9n5vh6G09JWn3AJZo1HGx8KvRoZCDLXrrYXvJvNb3
         0QNR4v9vy4EzdaDJOmF1CkHU+Up+uoysPKFfpE6/YELzumXwSM1HuTpWdM+TzQlVuGcy
         AmMg==
X-Forwarded-Encrypted: i=1; AJvYcCVA056sjFggjvnnH451YD0ISSXAVPjf3HTR2zGxv8KoMAOMRq06sK3T4AdbkeAWalR07WtxvkeKahd63kQ//bK7IdZJSA==@vger.kernel.org, AJvYcCWbcTRYK8cAFlbfPPVuBM/xl1lCcDeMVjlME0A6JXc9OoqumAnoqWZg+OJ152c95MFDHe1TqNEHSiGeJws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9MvZWRwryu4WU9BW0eHRhqc8CQZAfCZmh9tKSKfoZJyD43bnq
	xOdVQ4ecsxqgikRke6ybKqod1OpmFHqy4VDUMDJnbn8VzSVLxDkUnK7TfXMO
X-Google-Smtp-Source: AGHT+IFGo/8lcFKuj9oPvDtT1f2qAHVyWKu47fh43o5K1lbZhE9NvusHJN52YcE7eLWY/JnURj961w==
X-Received: by 2002:a05:6e02:1908:b0:3a0:b384:219b with SMTP id e9e14a558f8ab-3a4cd81a173mr15828355ab.26.1729582530451;
        Tue, 22 Oct 2024 00:35:30 -0700 (PDT)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab48f7bsm4364631a12.39.2024.10.22.00.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 00:35:30 -0700 (PDT)
Date: Tue, 22 Oct 2024 04:35:27 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v6 3/5] alienware-wmi: added platform profile support
Message-ID: <4kf2dehri5vdjkkdxbaqrythrsjhmnbuc62zv4fj4zgv77myym@wyvone3nr7it>
References: <20241017081211.126214-2-kuurtb@gmail.com>
 <20241017081524.127072-2-kuurtb@gmail.com>
 <8f49e3a9-e9ce-44d4-8d9a-4447202f2b61@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f49e3a9-e9ce-44d4-8d9a-4447202f2b61@gmx.de>

On Sun, Oct 20, 2024 at 10:12:48PM +0200, Armin Wolf wrote:
> Am 17.10.24 um 10:15 schrieb Kurt Borja:
> 
> > Implements platform profile support for Dell laptops with new WMAX
> > thermal interface, present on some Alienware X-Series, Alienware
> > M-Series and Dell's G-Series laptops.
> > 
> > This implementation supports three sets of thermal tables declared in
> > enum WMAX_THERMAL_TABLE and gmode, using quirks *thermal* and *gmode*
> > respectively. These sets are found in most Dell's devices that support
> > WMAX's thermal interface.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > 
> > ---
> > v6:
> >   - Fixed alignment on some function definitions
> >   - Fixed braces on if statment
> >   - Removed quirk thermal_ustt
> >   - Now quirk thermal can take values defined in enum WMAX_THERMAL_TABLE.
> >   - Proper removal of thermal_profile
> > ---
> >   drivers/platform/x86/dell/Kconfig         |   1 +
> >   drivers/platform/x86/dell/alienware-wmi.c | 251 ++++++++++++++++++++++
> >   2 files changed, 252 insertions(+)
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
> > index b27f3b64c..37a898273 100644
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
> > @@ -49,11 +58,33 @@ enum WMAX_CONTROL_STATES {
> >   	WMAX_SUSPEND = 3,
> >   };
> > 
> > +enum WMAX_THERMAL_TABLE {
> > +	WMAX_THERMAL_TABLE_SIMPLE	= 1,
> > +	WMAX_THERMAL_TABLE_USTT		= 2,
> > +	WMAX_THERMAL_TABLE_USTT_COOL	= 3,
> > +};
> > +
> > +enum WMAX_THERMAL_PROFILE {
> > +	WMAX_THERMAL_QUIET			= 0x96,
> > +	WMAX_THERMAL_BALANCED			= 0x97,
> > +	WMAX_THERMAL_BALANCED_PERFORMANCE	= 0x98,
> > +	WMAX_THERMAL_PERFORMANCE		= 0x99,
> > +	WMAX_THERMAL_USTT_LOW_POWER		= 0xA5,
> > +	WMAX_THERMAL_USTT_COOL			= 0xA2,
> > +	WMAX_THERMAL_USTT_QUIET			= 0xA3,
> > +	WMAX_THERMAL_USTT_BALANCED		= 0xA0,
> > +	WMAX_THERMAL_USTT_BALANCED_PERFORMANCE	= 0xA1,
> > +	WMAX_THERMAL_USTT_PERFORMANCE		= 0xA4,
> > +	WMAX_THERMAL_GMODE			= 0xAB,
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
> > @@ -64,6 +95,8 @@ static struct quirk_entry quirk_inspiron5675 = {
> >   	.hdmi_mux = 0,
> >   	.amplifier = 0,
> >   	.deepslp = 0,
> > +	.thermal = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_unknown = {
> > @@ -71,6 +104,8 @@ static struct quirk_entry quirk_unknown = {
> >   	.hdmi_mux = 0,
> >   	.amplifier = 0,
> >   	.deepslp = 0,
> > +	.thermal = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_x51_r1_r2 = {
> > @@ -78,6 +113,8 @@ static struct quirk_entry quirk_x51_r1_r2 = {
> >   	.hdmi_mux = 0,
> >   	.amplifier = 0,
> >   	.deepslp = 0,
> > +	.thermal = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_x51_r3 = {
> > @@ -85,6 +122,8 @@ static struct quirk_entry quirk_x51_r3 = {
> >   	.hdmi_mux = 0,
> >   	.amplifier = 1,
> >   	.deepslp = 0,
> > +	.thermal = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_asm100 = {
> > @@ -92,6 +131,8 @@ static struct quirk_entry quirk_asm100 = {
> >   	.hdmi_mux = 1,
> >   	.amplifier = 0,
> >   	.deepslp = 0,
> > +	.thermal = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_asm200 = {
> > @@ -99,6 +140,8 @@ static struct quirk_entry quirk_asm200 = {
> >   	.hdmi_mux = 1,
> >   	.amplifier = 0,
> >   	.deepslp = 1,
> > +	.thermal = 0,
> > +	.gmode = 0,
> >   };
> > 
> >   static struct quirk_entry quirk_asm201 = {
> > @@ -106,6 +149,17 @@ static struct quirk_entry quirk_asm201 = {
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
> > +	.thermal = WMAX_THERMAL_TABLE_USTT,
> > +	.gmode = 0,
> >   };
> > 
> >   static int __init dmi_matched(const struct dmi_system_id *dmi)
> > @@ -169,6 +223,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
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
> > @@ -218,6 +281,7 @@ static struct platform_device *platform_device;
> >   static struct device_attribute *zone_dev_attrs;
> >   static struct attribute **zone_attrs;
> >   static struct platform_zone *zone_data;
> > +static struct platform_profile_handler pp_handler;
> > 
> >   static struct platform_driver platform_driver = {
> >   	.driver = {
> > @@ -761,6 +825,184 @@ static int create_deepsleep(struct platform_device *dev)
> >   	return ret;
> >   }
> > 
> > +/*
> > + * Thermal Profile control
> > + *  - Provides thermal profile control through the Platform Profile API
> > + */
> > +#define WMAX_ARGUMENT_MASK	GENMASK(15, 8)
> > +#define WMAX_PROFILE_ACTIVATE	0x01
> > +
> > +static u32 profile_to_wmax_arg(enum WMAX_THERMAL_PROFILE prof)
> > +{
> > +	return FIELD_PREP(WMAX_ARGUMENT_MASK, prof) | WMAX_PROFILE_ACTIVATE;
> > +}
> > +
> > +static int thermal_profile_get(struct platform_profile_handler *pprof,
> > +			       enum platform_profile_option *profile)
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
> > +	case WMAX_THERMAL_USTT_COOL:
> > +		*profile = PLATFORM_PROFILE_COOL;
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
> > +			       enum platform_profile_option profile)
> > +{
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
> > +	case PLATFORM_PROFILE_COOL:
> > +		in_args = profile_to_wmax_arg(WMAX_THERMAL_USTT_COOL);
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
> > +	switch (quirks->thermal) {
> > +	case WMAX_THERMAL_TABLE_SIMPLE:
> > +		pp_handler.profile_set = thermal_profile_set;
> > +		break;
> > +	case WMAX_THERMAL_TABLE_USTT:
> > +		pp_handler.profile_set = thermal_profile_set_ustt;
> > +		set_bit(PLATFORM_PROFILE_LOW_POWER, pp_handler.choices);
> > +		set_bit(PLATFORM_PROFILE_QUIET, pp_handler.choices);
> > +		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pp_handler.choices);
> > +		break;
> > +	case WMAX_THERMAL_TABLE_USTT_COOL:
> > +		pp_handler.profile_set = thermal_profile_set_ustt;
> > +		set_bit(PLATFORM_PROFILE_LOW_POWER, pp_handler.choices);
> > +		set_bit(PLATFORM_PROFILE_QUIET, pp_handler.choices);
> > +		set_bit(PLATFORM_PROFILE_COOL, pp_handler.choices);
> > +		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pp_handler.choices);
> > +		break;
> > +	}
> 
> Please add a default statement here to return -EINVAL just in case.

Noted.

> 
> Other than that:
> 
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Thank you so much for your reviews. I'll won't forget to add them on v7.

> 
> > +
> > +	set_bit(PLATFORM_PROFILE_BALANCED, pp_handler.choices);
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
> > @@ -808,6 +1050,12 @@ static int __init alienware_wmi_init(void)
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
> > @@ -816,6 +1064,8 @@ static int __init alienware_wmi_init(void)
> > 
> >   fail_prep_zones:
> >   	alienware_zone_exit(platform_device);
> > +	remove_thermal_profile();
> > +fail_prep_thermal_profile:
> >   fail_prep_deepsleep:
> >   fail_prep_amplifier:
> >   fail_prep_hdmi:
> > @@ -835,6 +1085,7 @@ static void __exit alienware_wmi_exit(void)
> >   	if (platform_device) {
> >   		alienware_zone_exit(platform_device);
> >   		remove_hdmi(platform_device);
> > +		remove_thermal_profile();
> >   		platform_device_unregister(platform_device);
> >   		platform_driver_unregister(&platform_driver);
> >   	}

