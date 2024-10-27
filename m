Return-Path: <linux-kernel+bounces-383610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FA19B1DFE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78070B20FA4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882D815FD01;
	Sun, 27 Oct 2024 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhcoSNQi"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2B566A;
	Sun, 27 Oct 2024 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730037884; cv=none; b=UsdHTiVIhA+nax8tB0si3plJiHUPklCRLZ3L9BDa3rOg2nWFMPipV29m94bfrm6psT+O9SaKh0boIXmmYx6vvO7BRWjgpVCVTt5WbPYXzTTxNbKekwVZ/EUdZmZfP2MxNsbCrjWuF7Ft7HVSydCeaDPwMgqXW0U4rnzVPdpq/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730037884; c=relaxed/simple;
	bh=rg21WKZ9NuLF0vxjl331dJyM+cpteEXbPy/V99+qfU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKKFGI9tS1l5wRj68clmpHL05BlR73e5y70EP8QEwPjxsb164+zhbU1Ru+kOIrt3RdPQxeRbIQoCicbBQ+LBM5cv1eQVhRO051U0Yhggdj/S/QfX2Qw3L55ZeJ74JGORuZQz7FOgWzOv3StsRgo9VWIX7Ut4NsWehtPhQbNFsOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhcoSNQi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cceb8d8b4so19154655ad.1;
        Sun, 27 Oct 2024 07:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730037880; x=1730642680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bw40PAqiFISgmXboaJ2RZgjqbjy7zk19aKYN+/qtDu8=;
        b=YhcoSNQi6fV05J2lq0/rZNc/ix1iquKrjUwfKYZYFIE8Lkw7qj+q0QG3NfDK0yRcr6
         5y6QGS8mbmBqj/CGqwvOHDRBAU5JETd5uq6G19dQaDb8w/F2+PggWoV4nhF61KKepyN9
         eECnCc4+7XByOzCD56B8rmcx0uBXd1MTKiG2lDMjSzyLEHQpBjwjeyfVSg+Z3VHqdwE3
         dLvJapr3jqQd9kLxKWAQ7wHeAsZqMRnMrNBL4FnhtnqpR5vGN9EuvyNDvdJuWkeTzT4m
         KYBH4hHsT2nEuA2DxF7LKVFQkzdKTFv7LX/u9WPBURqqxwFTusyKEhnQfiJuPXUiLzqv
         RsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730037880; x=1730642680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bw40PAqiFISgmXboaJ2RZgjqbjy7zk19aKYN+/qtDu8=;
        b=wkfrVqej/KOy1yoasJuJma1rBxAF51UlxIOA2qwaPJ6+0z7hXMLfUTT1EpICFqOr+/
         LX8KGqCMlHBJCb59+33T8OUd4/RLHJJcOmoBg4Ikg/yDG+GwN9r2rWZKukdLaJhAM7JT
         bZbIgfcv6G+bGhEfYPYmhX3ewUi2E2F/+V6yka5c88CkzJi950w5zy15uuBSCLmpKYAc
         5dBJKw3x1O0BF26v1vc40gc8jA5QoGYD893g9zk83RPlPM9abNBqGt8p6bZROJrxIbu+
         tarx1bCf381eIaiM5ntnuG2RoUIo5fcvzslignfSc9TCWOLCdK2uFEYc9jZzlPbVfa/q
         5Rhw==
X-Forwarded-Encrypted: i=1; AJvYcCVSNImG/VT9afo2IWXH8t2C2hBVtsPxREU+QIf3U6aOppzHo8eb8IBg/hUFg4EwS5H0JvvFsxs0YNznw0U=@vger.kernel.org, AJvYcCX34icoVOr2NLhG6QuXKOls7OCEAIL+MibxU8aTVt7cEtarg2pf1KMxh1KKfAZpIITPusFh50uPRL3Et+gEOL5Dbtd/aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUNz1ogYBx25AFMQ4ulwl64d4mkvitnlAcQO/CncbXudgL5Nmm
	HIy30ZLRF0bkqSEERAI7ryz59ZGzIZnT1ZBHCX6dKzK2icoYJewKPMpMXw==
X-Google-Smtp-Source: AGHT+IHDBHF2vHb0BOswcyZvFvMeV93WkOOH83IB8U3a8pN/jlt02Z4HaTUmUAl8bT7BY6VL9dlV9g==
X-Received: by 2002:a17:902:f681:b0:20c:e898:c88a with SMTP id d9443c01a7336-20fb85b9e57mr155508505ad.0.1730037880156;
        Sun, 27 Oct 2024 07:04:40 -0700 (PDT)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6d6c7sm36390855ad.97.2024.10.27.07.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:04:39 -0700 (PDT)
Date: Sun, 27 Oct 2024 11:04:36 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v9 3/4] alienware-wmi: added platform profile support
Message-ID: <vaf2epga4aqg62aok6pf6kmth6fci7perfljve6fgujdn5vopz@3siil5oalmen>
References: <20241025150916.3618-2-kuurtb@gmail.com>
 <20241025151601.4382-3-kuurtb@gmail.com>
 <08590c9b-5446-4a6a-912b-ebe2f45f25d4@gmx.de>
 <w4cd7yqqy5imtx23n7kcachs6quqmmdpjzuvgly2lyrwhwt6v6@o5hdxbtuoeao>
 <fd33c6dd-19a9-41bb-95a8-8e4f36e838cb@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd33c6dd-19a9-41bb-95a8-8e4f36e838cb@gmx.de>

On Sun, Oct 27, 2024 at 12:34:17PM +0100, Armin Wolf wrote:
> Am 26.10.24 um 22:03 schrieb Kurt Borja:
> 
> > On Fri, Oct 25, 2024 at 09:01:43PM +0200, Armin Wolf wrote:
> > > Am 25.10.24 um 17:16 schrieb Kurt Borja:
> > > 
> > > > Implements platform profile support for Dell laptops with new WMAX thermal
> > > > interface, present on some Alienware X-Series, Alienware M-Series and
> > > > Dell's G-Series laptops. This interface is suspected to be used by
> > > > Alienware Command Center (AWCC), which is not available for linux
> > > > systems, to manage thermal profiles.
> > > > 
> > > > This implementation makes use of three WMI methods, namely
> > > > THERMAL_CONTROL, THERMAL_INFORMATION and GAME_SHIFT_STATUS, which take
> > > > u32 as input and output arguments. Each method has a set of supported
> > > > operations specified in their respective enums.
> > > > 
> > > > Wrappers written for these methods support multiple operations.
> > > > 
> > > > THERMAL_CONTROL switches thermal modes through operation
> > > > ACTIVATE_PROFILE. Available thermal codes are auto-detected at runtime
> > > > and matched against a list of known thermal codes:
> > > > 
> > > > Thermal Table "User Selectable Thermal Tables" (USTT):
> > > > 	BALANCED			0xA0
> > > > 	BALANCED_PERFORMANCE		0xA1
> > > > 	COOL				0xA2
> > > > 	QUIET				0xA3
> > > > 	PERFORMANCE			0xA4
> > > > 	LOW_POWER			0xA5
> > > > 
> > > > Thermal Table Basic:
> > > > 	QUIET				0x96
> > > > 	BALANCED			0x97
> > > > 	BALANCED_PERFORMANCE		0x98
> > > > 	PERFORMANCE			0x99
> > > > 
> > > > Devices are known to implement only one of these tables without mixing
> > > > their thermal codes.
> > > > 
> > > > The fact that the least significant digit of every thermal code is
> > > > consecutive of one another is exploited to efficiently match codes
> > > > through arrays.
> > > > 
> > > > Autodetection of available codes is done through operation LIST_IDS of
> > > > method THERMAL_INFORMATION. This operation lists fan IDs, CPU sensor ID,
> > > > GPU sensor ID and available thermal profile codes, *in that order*. As
> > > > number of fans and thermal codes is very model dependent, almost every
> > > > ID is scanned and matched based on conditions found on
> > > > is_wmax_thermal_code(). The known upper bound for the number of IDs is
> > > > 13, corresponding to a device that have 4 fans, 2 sensors and 7 thermal
> > > > codes.
> > > > 
> > > > Additionally G-Series laptops have a key called G-key, which (with AWCC
> > > > proprietary driver) switches the thermal mode to an special mode named
> > > > GMODE with code 0xAB and changes Game Shift Status to 1. Game Shift is a
> > > > mode the manufacturer claims, increases gaming performance.
> > > > 
> > > > GAME_SHIFT_STATUS method is used to mimic this behavior when selecting
> > > > PLATFORM_PROFILE_PERFORMANCE option.
> > > > 
> > > > All of these profiles are known to only change fan speed profiles,
> > > > although there are untested claims that some of them also change power
> > > > profiles.
> > > > 
> > > > Activating a thermal mode with method THERMAL_CONTROL may cause short
> > > > hangs. This is a known problem present on every platform.
> > > > 
> > > > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > > > Reviewed-by: Ilpo J??rvinen <ilpo.jarvinen@linux.intel.com>
> > > > ---
> > > > v9:
> > > >    - Bool comparisons are now coherent with their type
> > > > v8:
> > > >    - Fixed alignment in wmax_mode_to_platform_profile[]
> > > >    - Quirk thermal and gmode changed from u8 -> bool
> > > >    - Autodetected quirk entries are not initialized
> > > >    - is_wmax_thermal_code refactored to increase readibility
> > > >    - is_wmax_thermal_code now covers all possibilities
> > > >    - Better commit message
> > > > v7:
> > > >    - Method operations are now clearly listed as separate enums
> > > >    - wmax_thermal_modes are now listed without codes in order to support
> > > >      autodetection, as well as getting and setting thermal profiles
> > > >      cleanly through arrays
> > > >    - Added wmax_mode_to_platform_profile[]
> > > >    - Added struct wmax_u32_args to replace bit mask approach of
> > > >      constructing arguments for wmax methods
> > > >    - create_thermal_profile now autodetects available thermal codes
> > > >      through operation 0x03 of THERMAL_INFORMATION method. These are
> > > >      codes are stored in supported_thermal_profiles[]
> > > >    - thermal_profile_get now uses wmax_mode_to_platform_profile[] instead of
> > > >      switch-case approach
> > > >    - thermal_profile_set now uses supported_thermal_profiles[] instead of
> > > >      switch-case approach
> > > >    - When gmode is autodetected, thermal_profile_set also sets Game Shift
> > > >      status accordingly
> > > > v6:
> > > >    - Fixed alignment on some function definitions
> > > >    - Fixed braces on if statment
> > > >    - Removed quirk thermal_ustt
> > > >    - Now quirk thermal can take values defined in enum WMAX_THERMAL_TABLE.
> > > >    - Proper removal of thermal_profile
> > > > ---
> > > >    drivers/platform/x86/dell/Kconfig         |   1 +
> > > >    drivers/platform/x86/dell/alienware-wmi.c | 280 ++++++++++++++++++++++
> > > >    2 files changed, 281 insertions(+)
> > > > 
> > > > diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> > > > index 68a49788a..b06d634cd 100644
> > > > --- a/drivers/platform/x86/dell/Kconfig
> > > > +++ b/drivers/platform/x86/dell/Kconfig
> > > > @@ -21,6 +21,7 @@ config ALIENWARE_WMI
> > > >    	depends on LEDS_CLASS
> > > >    	depends on NEW_LEDS
> > > >    	depends on ACPI_WMI
> > > > +	select ACPI_PLATFORM_PROFILE
> > > >    	help
> > > >    	 This is a driver for controlling Alienware BIOS driven
> > > >    	 features.  It exposes an interface for controlling the AlienFX
> > > > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > > > index b27f3b64c..da9ba422d 100644
> > > > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > > > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > > > @@ -8,8 +8,11 @@
> > > >    #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > > 
> > > >    #include <linux/acpi.h>
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/bits.h>
> > > >    #include <linux/module.h>
> > > >    #include <linux/platform_device.h>
> > > > +#include <linux/platform_profile.h>
> > > >    #include <linux/dmi.h>
> > > >    #include <linux/leds.h>
> > > > 
> > > > @@ -25,6 +28,13 @@
> > > >    #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
> > > >    #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
> > > >    #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
> > > > +#define WMAX_METHOD_THERMAL_INFORMATION	0x14
> > > > +#define WMAX_METHOD_THERMAL_CONTROL	0x15
> > > > +#define WMAX_METHOD_GAME_SHIFT_STATUS	0x25
> > > > +
> > > > +#define WMAX_THERMAL_MODE_GMODE		0xAB
> > > > +
> > > > +#define WMAX_FAILURE_CODE		0xFFFFFFFF
> > > > 
> > > >    MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
> > > >    MODULE_DESCRIPTION("Alienware special feature control");
> > > > @@ -49,11 +59,59 @@ enum WMAX_CONTROL_STATES {
> > > >    	WMAX_SUSPEND = 3,
> > > >    };
> > > > 
> > > > +enum WMAX_THERMAL_INFORMATION_OPERATIONS {
> > > > +	WMAX_OPERATION_LIST_IDS			= 0x03,
> > > > +	WMAX_OPERATION_CURRENT_PROFILE		= 0x0B,
> > > > +};
> > > > +
> > > > +enum WMAX_THERMAL_CONTROL_OPERATIONS {
> > > > +	WMAX_OPERATION_ACTIVATE_PROFILE		= 0x01,
> > > > +};
> > > > +
> > > > +enum WMAX_GAME_SHIFT_STATUS_OPERATIONS {
> > > > +	WMAX_OPERATION_TOGGLE_GAME_SHIFT	= 0x01,
> > > > +	WMAX_OPERATION_GET_GAME_SHIFT_STATUS	= 0x02,
> > > > +};
> > > > +
> > > > +enum WMAX_THERMAL_TABLES {
> > > > +	WMAX_THERMAL_TABLE_BASIC		= 0x90,
> > > > +	WMAX_THERMAL_TABLE_USTT			= 0xA0,
> > > > +};
> > > > +
> > > > +enum wmax_thermal_mode {
> > > > +	THERMAL_MODE_USTT_BALANCED,
> > > > +	THERMAL_MODE_USTT_BALANCED_PERFORMANCE,
> > > > +	THERMAL_MODE_USTT_COOL,
> > > > +	THERMAL_MODE_USTT_QUIET,
> > > > +	THERMAL_MODE_USTT_PERFORMANCE,
> > > > +	THERMAL_MODE_USTT_LOW_POWER,
> > > > +	THERMAL_MODE_BASIC_QUIET,
> > > > +	THERMAL_MODE_BASIC_BALANCED,
> > > > +	THERMAL_MODE_BASIC_BALANCED_PERFORMANCE,
> > > > +	THERMAL_MODE_BASIC_PERFORMANCE,
> > > > +	THERMAL_MODE_LAST,
> > > > +};
> > > > +
> > > > +static const enum platform_profile_option wmax_mode_to_platform_profile[THERMAL_MODE_LAST] = {
> > > > +	[THERMAL_MODE_USTT_BALANCED]			= PLATFORM_PROFILE_BALANCED,
> > > > +	[THERMAL_MODE_USTT_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
> > > > +	[THERMAL_MODE_USTT_COOL]			= PLATFORM_PROFILE_COOL,
> > > > +	[THERMAL_MODE_USTT_QUIET]			= PLATFORM_PROFILE_QUIET,
> > > > +	[THERMAL_MODE_USTT_PERFORMANCE]			= PLATFORM_PROFILE_PERFORMANCE,
> > > > +	[THERMAL_MODE_USTT_LOW_POWER]			= PLATFORM_PROFILE_LOW_POWER,
> > > > +	[THERMAL_MODE_BASIC_QUIET]			= PLATFORM_PROFILE_QUIET,
> > > > +	[THERMAL_MODE_BASIC_BALANCED]			= PLATFORM_PROFILE_BALANCED,
> > > > +	[THERMAL_MODE_BASIC_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
> > > > +	[THERMAL_MODE_BASIC_PERFORMANCE]		= PLATFORM_PROFILE_PERFORMANCE,
> > > > +};
> > > > +
> > > >    struct quirk_entry {
> > > >    	u8 num_zones;
> > > >    	u8 hdmi_mux;
> > > >    	u8 amplifier;
> > > >    	u8 deepslp;
> > > > +	bool thermal;	/* Autodetected. Do not initialize explicitly. */
> > > > +	bool gmode;	/* Autodetected. Do not initialize explicitly. */
> > > Hi,
> > > 
> > > is the WMI method to control the thermal profile available on all Alienware devices?
> > > If no, then the thermal quirk still needs to be enabled manually.
> > Yes it's not available in all Alienware devices, but wouldn't that get
> > catched by an ACPI_FAILURE or WMAX_FAILURE? is it not ok not rely on
> > this? If that's the case I can change it.
> 
> Sadly we cannot rely on the ACPI firmware to catch invalid method calls. Usually the firmware
> expects no invalid method calls, so the behavior in this case is undefined.

Unfortunate. After reading how WMAX is implemented again, I can see why
that's the case.

> 
> Please change the thermal quirk so that is has to be enabled manually.

Will do! 

In that case maybe an unsafe module param is appropriate, like you did
on dell-wmi-ddv.

>
> > > >    };
> > > > 
> > > >    static struct quirk_entry *quirks;
> > > > @@ -214,10 +272,19 @@ struct wmax_led_args {
> > > >    	u8 state;
> > > >    } __packed;
> > > > 
> > > > +struct wmax_u32_args {
> > > > +	u8 operation;
> > > > +	u8 arg1;
> > > > +	u8 arg2;
> > > > +	u8 arg3;
> > > > +};
> > > > +
> > > >    static struct platform_device *platform_device;
> > > >    static struct device_attribute *zone_dev_attrs;
> > > >    static struct attribute **zone_attrs;
> > > >    static struct platform_zone *zone_data;
> > > > +static struct platform_profile_handler pp_handler;
> > > > +static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
> > > > 
> > > >    static struct platform_driver platform_driver = {
> > > >    	.driver = {
> > > > @@ -761,6 +828,210 @@ static int create_deepsleep(struct platform_device *dev)
> > > >    	return ret;
> > > >    }
> > > > 
> > > > +/*
> > > > + * Thermal Profile control
> > > > + *  - Provides thermal profile control through the Platform Profile API
> > > > + */
> > > > +#define WMAX_THERMAL_TABLE_MASK		GENMASK(7, 4)
> > > > +#define WMAX_THERMAL_MODE_MASK		GENMASK(3, 0)
> > > > +#define WMAX_SENSOR_ID_MASK		BIT(8)
> > > > +
> > > > +static bool is_wmax_thermal_code(u32 code)
> > > > +{
> > > > +	if (code & WMAX_SENSOR_ID_MASK)
> > > > +		return false;
> > > > +
> > > > +	if ((code & WMAX_THERMAL_MODE_MASK) >= THERMAL_MODE_LAST)
> > > > +		return false;
> > > > +
> > > > +	if ((code & WMAX_THERMAL_TABLE_MASK) == WMAX_THERMAL_TABLE_BASIC &&
> > > > +	    (code & WMAX_THERMAL_MODE_MASK) >= THERMAL_MODE_BASIC_BALANCED)
> > > > +		return true;
> > > Please correct me if i am wrong, but i think THERMAL_MODE_BASIC_BALANCED should be
> > > THERMAL_MODE_BASIC_QUIET.
> > Yes it should! Thank you for catching it.
> > 
> > > > +
> > > > +	if ((code & WMAX_THERMAL_TABLE_MASK) == WMAX_THERMAL_TABLE_USTT &&
> > > > +	    (code & WMAX_THERMAL_MODE_MASK) <= THERMAL_MODE_USTT_LOW_POWER)
> > > > +		return true;
> > > > +
> > > > +	return false;
> > > > +}
> > > > +
> > > > +static int wmax_thermal_information(u8 operation, u8 arg, u32 *out_data)
> > > > +{
> > > > +	acpi_status status;
> > > > +	struct wmax_u32_args in_args = {
> > > > +		.operation = operation,
> > > > +		.arg1 = arg,
> > > > +		.arg2 = 0,
> > > > +		.arg3 = 0,
> > > > +	};
> > > > +
> > > > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > > > +					WMAX_METHOD_THERMAL_INFORMATION,
> > > > +					out_data);
> > > > +
> > > > +	if (ACPI_FAILURE(status))
> > > > +		return -EIO;
> > > > +
> > > > +	if (*out_data == WMAX_FAILURE_CODE)
> > > > +		return -EBADRQC;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int wmax_thermal_control(u8 profile)
> > > > +{
> > > > +	acpi_status status;
> > > > +	struct wmax_u32_args in_args = {
> > > > +		.operation = WMAX_OPERATION_ACTIVATE_PROFILE,
> > > > +		.arg1 = profile,
> > > > +		.arg2 = 0,
> > > > +		.arg3 = 0,
> > > > +	};
> > > > +	u32 out_data;
> > > > +
> > > > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > > > +					WMAX_METHOD_THERMAL_CONTROL,
> > > > +					&out_data);
> > > > +
> > > > +	if (ACPI_FAILURE(status))
> > > > +		return -EIO;
> > > > +
> > > > +	if (out_data == WMAX_FAILURE_CODE)
> > > > +		return -EBADRQC;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int wmax_game_shift_status(u8 operation, u32 *out_data)
> > > > +{
> > > > +	acpi_status status;
> > > > +	struct wmax_u32_args in_args = {
> > > > +		.operation = operation,
> > > > +		.arg1 = 0,
> > > > +		.arg2 = 0,
> > > > +		.arg3 = 0,
> > > > +	};
> > > > +
> > > > +	status = alienware_wmax_command(&in_args, sizeof(in_args),
> > > > +					WMAX_METHOD_GAME_SHIFT_STATUS,
> > > > +					out_data);
> > > > +
> > > > +	if (ACPI_FAILURE(status))
> > > > +		return -EIO;
> > > > +
> > > > +	if (*out_data == WMAX_FAILURE_CODE)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int thermal_profile_get(struct platform_profile_handler *pprof,
> > > > +			       enum platform_profile_option *profile)
> > > > +{
> > > > +	u32 out_data;
> > > > +	int ret;
> > > > +
> > > > +	ret = wmax_thermal_information(WMAX_OPERATION_CURRENT_PROFILE,
> > > > +				       0, &out_data);
> > > > +
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	if (!is_wmax_thermal_code(out_data))
> > > > +		return -ENODATA;
> > > > +
> > > > +	out_data &= WMAX_THERMAL_MODE_MASK;
> > > > +	*profile = wmax_mode_to_platform_profile[out_data];
> > > Please check that out_data is smaller than THERMAL_MODE_LAST, otherwise
> > > an out-of-bounds access can occur.
> > is_wmax_thermal_code checks if out_data is in bounds.
> 
> Indeed, good catch. In this case you can just ignore my comment.
> 
> > > Nice work overall.
> > Thank you very much for your feedback!
> > 
> > Kurt
> 
> Happy to review the (hopefully final) revision of this series :).

Hopefully so! Thanks for your help :). 

Kurt

> 
> Thanks,
> Armin Wolf
> 
> > > Thanks,
> > > Armin Wolf
> > > 
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int thermal_profile_set(struct platform_profile_handler *pprof,
> > > > +			       enum platform_profile_option profile)
> > > > +{
> > > > +	if (quirks->gmode) {
> > > > +		u32 gmode_status;
> > > > +		int ret;
> > > > +
> > > > +		ret = wmax_game_shift_status(WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
> > > > +					     &gmode_status);
> > > > +
> > > > +		if (ret < 0)
> > > > +			return ret;
> > > > +
> > > > +		if ((profile == PLATFORM_PROFILE_PERFORMANCE && !gmode_status) ||
> > > > +		    (profile != PLATFORM_PROFILE_PERFORMANCE && gmode_status)) {
> > > > +			ret = wmax_game_shift_status(WMAX_OPERATION_TOGGLE_GAME_SHIFT,
> > > > +						     &gmode_status);
> > > > +
> > > > +			if (ret < 0)
> > > > +				return ret;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return wmax_thermal_control(supported_thermal_profiles[profile]);
> > > > +}
> > > > +
> > > > +static int create_thermal_profile(void)
> > > > +{
> > > > +	u32 out_data;
> > > > +	u32 gmode_status;
> > > > +	enum wmax_thermal_mode mode;
> > > > +	enum platform_profile_option profile;
> > > > +	int ret;
> > > > +
> > > > +	for (u8 i = 0x2; i <= 0xD; i++) {
> > > > +		ret = wmax_thermal_information(WMAX_OPERATION_LIST_IDS,
> > > > +					       i, &out_data);
> > > > +
> > > > +		if (ret == -EIO)
> > > > +			return 0;
> > > > +
> > > > +		if (ret == -EBADRQC)
> > > > +			break;
> > > > +
> > > > +		if (!is_wmax_thermal_code(out_data))
> > > > +			continue;
> > > > +
> > > > +		mode = out_data & WMAX_THERMAL_MODE_MASK;
> > > > +		profile = wmax_mode_to_platform_profile[mode];
> > > > +		supported_thermal_profiles[profile] = out_data;
> > > > +
> > > > +		set_bit(profile, pp_handler.choices);
> > > > +	}
> > > > +
> > > > +	if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
> > > > +		return 0;
> > > > +
> > > > +	ret = wmax_game_shift_status(WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
> > > > +				     &gmode_status);
> > > > +
> > > > +	if (!ret) {
> > > > +		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
> > > > +			WMAX_THERMAL_MODE_GMODE;
> > > > +
> > > > +		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
> > > > +		quirks->gmode = true;
> > > > +	}
> > > > +
> > > > +	pp_handler.profile_get = thermal_profile_get;
> > > > +	pp_handler.profile_set = thermal_profile_set;
> > > > +
> > > > +	ret = platform_profile_register(&pp_handler);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	quirks->thermal = true;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void remove_thermal_profile(void)
> > > > +{
> > > > +	if (quirks->thermal)
> > > > +		platform_profile_remove();
> > > > +}
> > > > +
> > > >    static int __init alienware_wmi_init(void)
> > > >    {
> > > >    	int ret;
> > > > @@ -808,6 +1079,12 @@ static int __init alienware_wmi_init(void)
> > > >    			goto fail_prep_deepsleep;
> > > >    	}
> > > > 
> > > > +	if (interface == WMAX && quirks == &quirk_unknown) {
> > > > +		ret = create_thermal_profile();
> > > > +		if (ret)
> > > > +			goto fail_prep_thermal_profile;
> > > > +	}
> > > > +
> > > >    	ret = alienware_zone_init(platform_device);
> > > >    	if (ret)
> > > >    		goto fail_prep_zones;
> > > > @@ -816,6 +1093,8 @@ static int __init alienware_wmi_init(void)
> > > > 
> > > >    fail_prep_zones:
> > > >    	alienware_zone_exit(platform_device);
> > > > +	remove_thermal_profile();
> > > > +fail_prep_thermal_profile:
> > > >    fail_prep_deepsleep:
> > > >    fail_prep_amplifier:
> > > >    fail_prep_hdmi:
> > > > @@ -835,6 +1114,7 @@ static void __exit alienware_wmi_exit(void)
> > > >    	if (platform_device) {
> > > >    		alienware_zone_exit(platform_device);
> > > >    		remove_hdmi(platform_device);
> > > > +		remove_thermal_profile();
> > > >    		platform_device_unregister(platform_device);
> > > >    		platform_driver_unregister(&platform_driver);
> > > >    	}

