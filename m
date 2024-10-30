Return-Path: <linux-kernel+bounces-387938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D679B582C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41560B21568
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DE513FEE;
	Wed, 30 Oct 2024 00:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oh7C/C5B"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB21C8C07;
	Wed, 30 Oct 2024 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246555; cv=none; b=dyvPvKFWDqkHPG4mYRCR6nOuQtmF6gTPu5o8YdfDrPy/8mdA4XCJi5lj77rdz2oW49qtQk8/IqfvRLEC+SpnlKfAIF6hWenChn6kBskX2s7iqhvM9se5S6FpFo+xpL8XG6kSAxLG0B5127kHislYJvJQR0uF3YlOR3SA3QxsGc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246555; c=relaxed/simple;
	bh=22gitXClx+OX56EezG/mI72vUDRTVgZFs8w56tBH2HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRGeTJp6kjrqllSd5ZSlGwAtt1AaMnRdqrEib8LHhB3qHG/LaHCoeJRodt6gpnGWJTnPBQvz7HRu9I6FUBhuAvf49RPTBH+2zJ0pZm35CuFppGXu1jeXQdkvjIO6cMrZylqMKCScu0JybnNpwjCdNkB/jUdl8UNE/+2MId5s8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oh7C/C5B; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e3fca72a41so4897763a91.1;
        Tue, 29 Oct 2024 17:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730246552; x=1730851352; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OVUCNdB32X7yr9aqm8rAYtVOzZFlLQqgh7yW90gfLh0=;
        b=Oh7C/C5Bdnk5LroHn83kVZYe0T2BSgsK+nxRkU8Tuf7tdIZHrZZ3VhQ7RDXWcJVvG5
         JdnGjfOwZyuwg36vKkRgOvkNpFxdEoyZhIbQAJNj5g5qWjNOY9sHkFr90RKF5mYqcJS7
         EvUzniryTBNt2hDROIWF5Oun5ed+5oWk4Gm4n3VX0mgxBiKl8cHzV2ZrqfMvwmfGW0fm
         tAB2sF1y+f3/JikzNEphzNI5r0V024FSbCrdXQ82cK2GzgzzPxn9XXJg3NPghZG/ZOBM
         EYR+RaxSQ5SvcOPPqF8aQ4mtwFIuvkR02KLDvvu+nuEex7WJDgcCA2tMASRqdGVN5p9y
         vm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730246552; x=1730851352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVUCNdB32X7yr9aqm8rAYtVOzZFlLQqgh7yW90gfLh0=;
        b=KhhAIzwIhZ3gPquV6qrl2QGj/PeAb9nki8PTfUrgf91ZRjjGP7kXO9nG9E0CFOmtHJ
         Rk4c6VM2ovDk2mu8Nqlt6jhd/sHeunjstM6R9ZkvmaK5+kUoWCzwoiky5zm9D6XTQdY5
         AOa4dCt7V2hUB3lntEfJGHlZbGr0tB563dXB+8Nl3rF4cSOL0OAcL6Hk0Q9np0Gy1as/
         gnJ/ot68u4q+Xbvfc0JDi9UcY+Ki56H7gmH0xbd+qql5Bo8LfHUFE0YqkfIgpc7px0zM
         p/j5dVufiizP73kZjbdGezrKJsFDiua4gu0xl6sN5DQ6YxIm6IVca6XHioaaK0F9Ziam
         H0WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUovUHP7hwyH3JCe+D76m0eydy/z76EWTZGB3Pm2Ekp5HgBlPCaVVGSHC8+o3jLRUZp9CsKuwk1EhpiQTY=@vger.kernel.org, AJvYcCWfLvsTppex0b+Ne5xWsSpAnLSqyiJe9Wqp2yhwInsHIpHyIUfuwfTs2rTIF9il25tMrefcuqek0G6bhGtwcuFBvAXPeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4DDK9wpGk3+/3r+Yy8fNUZ/EzXibAHCnXiq2bzml5IajbIssU
	A81Pe5mOQlGWEjwCklhX/VlWGbTKbgd0lPdEIEjVEErJpSJU0z0t
X-Google-Smtp-Source: AGHT+IFIGmtJuhhSJGCgvLBjpqUmWe3qvoYhO/yQVK09kecLK8IJqY9vyS83hG2TAu/7XWAle02j8g==
X-Received: by 2002:a17:90a:5601:b0:2e2:e743:7501 with SMTP id 98e67ed59e1d1-2e8f0f533e7mr14413923a91.8.1730246551718;
        Tue, 29 Oct 2024 17:02:31 -0700 (PDT)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa20072sm279036a91.2.2024.10.29.17.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 17:02:31 -0700 (PDT)
Date: Tue, 29 Oct 2024 21:02:28 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v10 3/5] alienware-wmi: added platform profile support
Message-ID: <r3c2of4wx7kpaova47dqo23vsxv5p3kscw6rmxuxwi6opx2bua@dabdghtinnaz>
References: <20241029135107.5582-2-kuurtb@gmail.com>
 <20241029135341.5906-1-kuurtb@gmail.com>
 <9caaa4f1-9605-da2a-9afd-8f40ed33719f@linux.intel.com>
 <pvsp76cvdqp7irpa52mr3canryyzilgvyijhtqvxzhix3diavj@bcfuduinqlcb>
 <12f980ac-f1d3-a802-37a9-cb6e03b046de@linux.intel.com>
 <c780277a-cf52-42a4-803f-c29674a31715@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c780277a-cf52-42a4-803f-c29674a31715@gmx.de>

On Wed, Oct 30, 2024 at 12:11:51AM +0100, Armin Wolf wrote:
> Am 29.10.24 um 18:06 schrieb Ilpo Järvinen:
> 
> > On Tue, 29 Oct 2024, Kurt Borja wrote:
> > 
> > > On Tue, Oct 29, 2024 at 05:44:05PM +0200, Ilpo Järvinen wrote:
> > > > On Tue, 29 Oct 2024, Kurt Borja wrote:
> > > > 
> > > > > Implements platform profile support for Dell laptops with new WMAX thermal
> > > > > interface, present on some Alienware X-Series, Alienware M-Series and
> > > > > Dell's G-Series laptops. This interface is suspected to be used by
> > > > > Alienware Command Center (AWCC), which is not available for linux
> > > > > systems, to manage thermal profiles.
> > > > > 
> > > > > This implementation makes use of three WMI methods, namely
> > > > > THERMAL_CONTROL, THERMAL_INFORMATION and GAME_SHIFT_STATUS, which take
> > > > > u32 as input and output arguments. Each method has a set of supported
> > > > > operations specified in their respective enums.
> > > > > 
> > > > > Not all models with WMAX WMI interface support these methods. Because of
> > > > > this, models have to manually declare support through new quirks
> > > > > `thermal` for THERMAL_CONTROL and THERMAL_INFORMATION and `gmode` for
> > > > > GAME_SHIFT_STATUS.
> > > > > 
> > > > > Wrappers written for these methods support multiple operations.
> > > > > 
> > > > > THERMAL_CONTROL switches thermal modes through operation
> > > > > ACTIVATE_PROFILE. Available thermal codes are auto-detected at runtime
> > > > > and matched against a list of known thermal codes:
> > > > > 
> > > > > Thermal Table "User Selectable Thermal Tables" (USTT):
> > > > > 	BALANCED			0xA0
> > > > > 	BALANCED_PERFORMANCE		0xA1
> > > > > 	COOL				0xA2
> > > > > 	QUIET				0xA3
> > > > > 	PERFORMANCE			0xA4
> > > > > 	LOW_POWER			0xA5
> > > > > 
> > > > > Thermal Table Basic:
> > > > > 	QUIET				0x96
> > > > > 	BALANCED			0x97
> > > > > 	BALANCED_PERFORMANCE		0x98
> > > > > 	PERFORMANCE			0x99
> > > > > 
> > > > > Devices are known to implement only one of these tables without mixing
> > > > > their thermal codes.
> > > > > 
> > > > > The fact that the least significant digit of every thermal code is
> > > > > consecutive of one another is exploited to efficiently match codes
> > > > > through arrays.
> > > > > 
> > > > > Autodetection of available codes is done through operation LIST_IDS of
> > > > > method THERMAL_INFORMATION. This operation lists fan IDs, CPU sensor ID,
> > > > > GPU sensor ID and available thermal profile codes, *in that order*. As
> > > > > number of fans and thermal codes is very model dependent, almost every
> > > > > ID is scanned and matched based on conditions found on
> > > > > is_wmax_thermal_code(). The known upper bound for the number of IDs is
> > > > > 13, corresponding to a device that have 4 fans, 2 sensors and 7 thermal
> > > > > codes.
> > > > > 
> > > > > Additionally G-Series laptops have a key called G-key, which (with AWCC
> > > > > proprietary driver) switches the thermal mode to an special mode named
> > > > > GMODE with code 0xAB and changes Game Shift Status to 1. Game Shift is a
> > > > > mode the manufacturer claims, increases gaming performance.
> > > > > 
> > > > > GAME_SHIFT_STATUS method is used to mimic this behavior when selecting
> > > > > PLATFORM_PROFILE_PERFORMANCE option.
> > > > > 
> > > > > All of these profiles are known to only change fan speed profiles,
> > > > > although there are untested claims that some of them also change power
> > > > > profiles.
> > > > > 
> > > > > Activating a thermal mode with method THERMAL_CONTROL may cause short
> > > > > hangs. This is a known problem present on every platform.
> > > > > 
> > > > > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > > > > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > > ---
> > > > > v10:
> > > > >   - Corrected THERMAL_MODE_BASIC_BALANCED -> THERMAL_MODE_BASIC_QUIET in
> > > > >     is_wmax_thermal_code() logic
> > > > >   - `thermal` and `gmode` quirks now have to be manually selected,
> > > > >     because not all Dell devices posses the new WMI thermal methods.
> > > > >   - Because of the above reason, errors in create_thermal_profile are now
> > > > >     propagated
> > > > > v9:
> > > > >   - Bool comparisons are now coherent with their type
> > > > > v8:
> > > > >   - Fixed alignment in wmax_mode_to_platform_profile[]
> > > > >   - Quirk thermal and gmode changed from u8 -> bool
> > > > >   - Autodetected quirk entries are not initialized
> > > > >   - is_wmax_thermal_code refactored to increase readibility
> > > > >   - is_wmax_thermal_code now covers all possibilities
> > > > >   - Better commit message
> > > > > v7:
> > > > >   - Method operations are now clearly listed as separate enums
> > > > >   - wmax_thermal_modes are now listed without codes in order to support
> > > > >     autodetection, as well as getting and setting thermal profiles
> > > > >     cleanly through arrays
> > > > >   - Added wmax_mode_to_platform_profile[]
> > > > >   - Added struct wmax_u32_args to replace bit mask approach of
> > > > >     constructing arguments for wmax methods
> > > > >   - create_thermal_profile now autodetects available thermal codes
> > > > >     through operation 0x03 of THERMAL_INFORMATION method. These are
> > > > >     codes are stored in supported_thermal_profiles[]
> > > > >   - thermal_profile_get now uses wmax_mode_to_platform_profile[] instead of
> > > > >     switch-case approach
> > > > >   - thermal_profile_set now uses supported_thermal_profiles[] instead of
> > > > >     switch-case approach
> > > > >   - When gmode is autodetected, thermal_profile_set also sets Game Shift
> > > > >     status accordingly
> > > > > v6:
> > > > >   - Fixed alignment on some function definitions
> > > > >   - Fixed braces on if statment
> > > > >   - Removed quirk thermal_ustt
> > > > >   - Now quirk thermal can take values defined in enum WMAX_THERMAL_TABLE.
> > > > >   - Proper removal of thermal_profile
> > > > > ---
> > > > >   drivers/platform/x86/dell/Kconfig         |   1 +
> > > > >   drivers/platform/x86/dell/alienware-wmi.c | 306 ++++++++++++++++++++++
> > > > >   2 files changed, 307 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> > > > > index 68a49788a..b06d634cd 100644
> > > > > --- a/drivers/platform/x86/dell/Kconfig
> > > > > +++ b/drivers/platform/x86/dell/Kconfig
> > > > > @@ -21,6 +21,7 @@ config ALIENWARE_WMI
> > > > >   	depends on LEDS_CLASS
> > > > >   	depends on NEW_LEDS
> > > > >   	depends on ACPI_WMI
> > > > > +	select ACPI_PLATFORM_PROFILE
> > > > >   	help
> > > > >   	 This is a driver for controlling Alienware BIOS driven
> > > > >   	 features.  It exposes an interface for controlling the AlienFX
> > > > > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > > > > index b27f3b64c..1d62c2ce7 100644
> > > > > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > > > > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > > > > @@ -8,8 +8,11 @@
> > > > >   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > > > 
> > > > >   #include <linux/acpi.h>
> > > > > +#include <linux/bitfield.h>
> > > > > +#include <linux/bits.h>
> > > > >   #include <linux/module.h>
> > > > >   #include <linux/platform_device.h>
> > > > > +#include <linux/platform_profile.h>
> > > > >   #include <linux/dmi.h>
> > > > >   #include <linux/leds.h>
> > > > > 
> > > > > @@ -25,6 +28,13 @@
> > > > >   #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
> > > > >   #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
> > > > >   #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
> > > > > +#define WMAX_METHOD_THERMAL_INFORMATION	0x14
> > > > > +#define WMAX_METHOD_THERMAL_CONTROL	0x15
> > > > > +#define WMAX_METHOD_GAME_SHIFT_STATUS	0x25
> > > > > +
> > > > > +#define WMAX_THERMAL_MODE_GMODE		0xAB
> > > > > +
> > > > > +#define WMAX_FAILURE_CODE		0xFFFFFFFF
> > > > > 
> > > > >   MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
> > > > >   MODULE_DESCRIPTION("Alienware special feature control");
> > > > > @@ -49,11 +59,59 @@ enum WMAX_CONTROL_STATES {
> > > > >   	WMAX_SUSPEND = 3,
> > > > >   };
> > > > > 
> > > > > +enum WMAX_THERMAL_INFORMATION_OPERATIONS {
> > > > > +	WMAX_OPERATION_LIST_IDS			= 0x03,
> > > > > +	WMAX_OPERATION_CURRENT_PROFILE		= 0x0B,
> > > > > +};
> > > > > +
> > > > > +enum WMAX_THERMAL_CONTROL_OPERATIONS {
> > > > > +	WMAX_OPERATION_ACTIVATE_PROFILE		= 0x01,
> > > > > +};
> > > > > +
> > > > > +enum WMAX_GAME_SHIFT_STATUS_OPERATIONS {
> > > > > +	WMAX_OPERATION_TOGGLE_GAME_SHIFT	= 0x01,
> > > > > +	WMAX_OPERATION_GET_GAME_SHIFT_STATUS	= 0x02,
> > > > > +};
> > > > > +
> > > > > +enum WMAX_THERMAL_TABLES {
> > > > > +	WMAX_THERMAL_TABLE_BASIC		= 0x90,
> > > > > +	WMAX_THERMAL_TABLE_USTT			= 0xA0,
> > > > > +};
> > > > > +
> > > > > +enum wmax_thermal_mode {
> > > > > +	THERMAL_MODE_USTT_BALANCED,
> > > > > +	THERMAL_MODE_USTT_BALANCED_PERFORMANCE,
> > > > > +	THERMAL_MODE_USTT_COOL,
> > > > > +	THERMAL_MODE_USTT_QUIET,
> > > > > +	THERMAL_MODE_USTT_PERFORMANCE,
> > > > > +	THERMAL_MODE_USTT_LOW_POWER,
> > > > > +	THERMAL_MODE_BASIC_QUIET,
> > > > > +	THERMAL_MODE_BASIC_BALANCED,
> > > > > +	THERMAL_MODE_BASIC_BALANCED_PERFORMANCE,
> > > > > +	THERMAL_MODE_BASIC_PERFORMANCE,
> > > > > +	THERMAL_MODE_LAST,
> > > > > +};
> > > > > +
> > > > > +static const enum platform_profile_option wmax_mode_to_platform_profile[THERMAL_MODE_LAST] = {
> > > > > +	[THERMAL_MODE_USTT_BALANCED]			= PLATFORM_PROFILE_BALANCED,
> > > > > +	[THERMAL_MODE_USTT_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
> > > > > +	[THERMAL_MODE_USTT_COOL]			= PLATFORM_PROFILE_COOL,
> > > > > +	[THERMAL_MODE_USTT_QUIET]			= PLATFORM_PROFILE_QUIET,
> > > > > +	[THERMAL_MODE_USTT_PERFORMANCE]			= PLATFORM_PROFILE_PERFORMANCE,
> > > > > +	[THERMAL_MODE_USTT_LOW_POWER]			= PLATFORM_PROFILE_LOW_POWER,
> > > > > +	[THERMAL_MODE_BASIC_QUIET]			= PLATFORM_PROFILE_QUIET,
> > > > > +	[THERMAL_MODE_BASIC_BALANCED]			= PLATFORM_PROFILE_BALANCED,
> > > > > +	[THERMAL_MODE_BASIC_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
> > > > > +	[THERMAL_MODE_BASIC_PERFORMANCE]		= PLATFORM_PROFILE_PERFORMANCE,
> > > > > +};
> > > > > +
> > > > >   struct quirk_entry {
> > > > >   	u8 num_zones;
> > > > >   	u8 hdmi_mux;
> > > > >   	u8 amplifier;
> > > > >   	u8 deepslp;
> > > > > +	bool thermal;
> > > > > +	bool gmode;
> > > > >   };
> > > > > 
> > > > >   static struct quirk_entry *quirks;
> > > > > @@ -64,6 +122,8 @@ static struct quirk_entry quirk_inspiron5675 = {
> > > > >   	.hdmi_mux = 0,
> > > > >   	.amplifier = 0,
> > > > >   	.deepslp = 0,
> > > > > +	.thermal = false,
> > > > > +	.gmode = false,
> > > > >   };
> > > > > 
> > > > >   static struct quirk_entry quirk_unknown = {
> > > > > @@ -71,6 +131,8 @@ static struct quirk_entry quirk_unknown = {
> > > > >   	.hdmi_mux = 0,
> > > > >   	.amplifier = 0,
> > > > >   	.deepslp = 0,
> > > > > +	.thermal = false,
> > > > > +	.gmode = false,
> > > > >   };
> > > > > 
> > > > >   static struct quirk_entry quirk_x51_r1_r2 = {
> > > > > @@ -78,6 +140,8 @@ static struct quirk_entry quirk_x51_r1_r2 = {
> > > > >   	.hdmi_mux = 0,
> > > > >   	.amplifier = 0,
> > > > >   	.deepslp = 0,
> > > > > +	.thermal = false,
> > > > > +	.gmode = false,
> > > > >   };
> > > > > 
> > > > >   static struct quirk_entry quirk_x51_r3 = {
> > > > > @@ -85,6 +149,8 @@ static struct quirk_entry quirk_x51_r3 = {
> > > > >   	.hdmi_mux = 0,
> > > > >   	.amplifier = 1,
> > > > >   	.deepslp = 0,
> > > > > +	.thermal = false,
> > > > > +	.gmode = false,
> > > > >   };
> > > > > 
> > > > >   static struct quirk_entry quirk_asm100 = {
> > > > > @@ -92,6 +158,8 @@ static struct quirk_entry quirk_asm100 = {
> > > > >   	.hdmi_mux = 1,
> > > > >   	.amplifier = 0,
> > > > >   	.deepslp = 0,
> > > > > +	.thermal = false,
> > > > > +	.gmode = false,
> > > > >   };
> > > > > 
> > > > >   static struct quirk_entry quirk_asm200 = {
> > > > > @@ -99,6 +167,8 @@ static struct quirk_entry quirk_asm200 = {
> > > > >   	.hdmi_mux = 1,
> > > > >   	.amplifier = 0,
> > > > >   	.deepslp = 1,
> > > > > +	.thermal = false,
> > > > > +	.gmode = false,
> > > > >   };
> > > > > 
> > > > >   static struct quirk_entry quirk_asm201 = {
> > > > > @@ -106,6 +176,17 @@ static struct quirk_entry quirk_asm201 = {
> > > > >   	.hdmi_mux = 1,
> > > > >   	.amplifier = 1,
> > > > >   	.deepslp = 1,
> > > > > +	.thermal = false,
> > > > > +	.gmode = false,
> > > > > +};
> > > > > +
> > > > > +static struct quirk_entry quirk_x_series = {
> > > > > +	.num_zones = 2,
> > > > > +	.hdmi_mux = 0,
> > > > > +	.amplifier = 0,
> > > > > +	.deepslp = 0,
> > > > > +	.thermal = true,
> > > > > +	.gmode = false,
> > > > >   };
> > > > So now gmode is always false unless the module parameter from patch 4 is
> > > > given?
> > > G-Series laptops can also register a quirk_entry with gmode set in the
> > > future. I can do it ahead of time, but I don't have a G-Series laptop to
> > > test it.
> > Understood. I'm fine with this in the current form if it's fine for Armin
> > too.
> 
> I am fine with this, we can add the necessary quirks later should someone have access
> to the necessary hardware.

I'm glad to hear that! Thank you both. 

Kurt

> 
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> 
> > 

