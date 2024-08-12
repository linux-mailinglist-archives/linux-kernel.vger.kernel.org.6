Return-Path: <linux-kernel+bounces-283148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0876E94EDE4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9841C20C12
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A298D17C20F;
	Mon, 12 Aug 2024 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cghbKK0r"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEC014EC53;
	Mon, 12 Aug 2024 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468628; cv=none; b=svudrz7ERR6p7tQCfEKq3EcinLYsnluU548TVBtXb3fwS5FUvaKUhzvpgU1XyHo90S1vCQppxG7z/6BNXyuugRbXcuSJL9HQbZqDtVxEhqDHCLiT5LAUCaU1LhxTYs6tIW1GMIBkYCutdbiKNED8L/AKXRjxuoETd++N7GAQMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468628; c=relaxed/simple;
	bh=QO9G0Wi9Z1CvTq7obEN6hpsKhmSoOzerLq2uZMDj5PI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Tavaw62lGqHkxLjuwcch1xsQe+9+18xrvMjhd6x205/XaYZzI27B+1XYLtgqAMz0/nzINVx4flTySnMsk/CPYZ0Kj8joeGoE8ZVa/zQytGxqc/RnzHPXaiF2SFvrRdLrQ47xBF4+T1P4bfnl6/SY0LXYrb2rcdm0YNA93RWmbXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cghbKK0r; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723468626; x=1755004626;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QO9G0Wi9Z1CvTq7obEN6hpsKhmSoOzerLq2uZMDj5PI=;
  b=cghbKK0rCisjiQA1aBVr1obEWGewM+v7qnf5o1+t3tpu5vQhc3wujeuG
   GnXcTk69Nzs5m3weXXcKILRmJJcclvQiyXhHlGURZ6oylRoIrSUiI4zRA
   Gj4Q7vKDcQgegHgs+GzEuGWD6eIOE3PNT1MqJwUf9yeBwnEzEOIDhvdiA
   udTFkcgF5yfpCwH98lxZkXyXY0+mHUYstf9mRi1RlYICCLhvUlCkOK8YS
   vbL9Ey9RBgbX664rKh2kTPLyIh1isx0gMuHhBM3UZ+KTf+7pRJLhn8jgc
   T3cJgsCl+ijSOLxDgoULGASA8bdRT1YoRbeDVUAr2ddt244zxhV+64cO+
   A==;
X-CSE-ConnectionGUID: a6YIPqo0RjGXAT4eFjc9Vg==
X-CSE-MsgGUID: LV1y2nvxTsil4ymf2/XSPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="24484223"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="24484223"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 06:17:06 -0700
X-CSE-ConnectionGUID: hlrp8ZcpRuGMQhpes0UbUA==
X-CSE-MsgGUID: 6wpMmYX2QYG/q6YfERP9dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="58150089"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 06:17:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 12 Aug 2024 16:17:00 +0300 (EEST)
To: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, mustafa.eskieksi@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] HP: wmi: added support for 4 zone keyboard rgb
In-Reply-To: <20240719100011.16656-2-carlosmiguelferreira.2003@gmail.com>
Message-ID: <5f206a6e-3daf-ca19-47bc-2dc40ca723cb@linux.intel.com>
References: <20240719100011.16656-1-carlosmiguelferreira.2003@gmail.com> <20240719100011.16656-2-carlosmiguelferreira.2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 19 Jul 2024, Carlos Ferreira wrote:

> This driver adds supports for 4 zone keyboard rgb on omen laptops
> using the multicolor led api.
> 
> Tested on the HP Omen 15-en1001np.
> 
> Signed-off-by: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
> ---
>  drivers/platform/x86/hp/Kconfig  |   1 +
>  drivers/platform/x86/hp/hp-wmi.c | 282 ++++++++++++++++++++++++++++++-
>  2 files changed, 274 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/Kconfig b/drivers/platform/x86/hp/Kconfig
> index 7fef4f12e498..6ce6d862ad05 100644
> --- a/drivers/platform/x86/hp/Kconfig
> +++ b/drivers/platform/x86/hp/Kconfig
> @@ -40,6 +40,7 @@ config HP_WMI
>  	depends on ACPI_WMI
>  	depends on INPUT
>  	depends on RFKILL || RFKILL = n
> +	select LEDS_CLASS_MULTICOLOR

Instead of select, use:

	depends on LEDS_CLASS_MULTICOLOR

It solves the build issue LKP found (dependencies of a selected CONFIG 
entry are not propagated which makes select tricky to use).

>  	select INPUT_SPARSEKMAP
>  	select ACPI_PLATFORM_PROFILE
>  	select HWMON
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 5fa553023842..b349f8325b93 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -14,7 +14,11 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/kernel.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/leds.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/mutex_types.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> @@ -24,6 +28,8 @@
>  #include <linux/platform_profile.h>
>  #include <linux/hwmon.h>
>  #include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/rfkill.h>
>  #include <linux/string.h>
>  #include <linux/dmi.h>
> @@ -44,6 +50,13 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45E9-BE91-3D44E2C707E4");
>  
>  #define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use when zero insize is required
>  
> +#define FOURZONE_LIGHTING_SUPPORTED_BIT	0x01
> +#define FOURZONE_LIGHTING_ON		228
> +#define FOURZONE_LIGHTING_OFF		100
> +
> +#define FOURZONE_COLOR	GENMASK(7, 0)
> +#define KBD_ZONE_COUNT	4
> +
>  /* DMI board names of devices that should use the omen specific path for
>   * thermal profiles.
>   * This was obtained by taking a look in the windows omen command center
> @@ -143,18 +156,36 @@ enum hp_wmi_commandtype {
>  };
>  
>  enum hp_wmi_gm_commandtype {
> -	HPWMI_FAN_SPEED_GET_QUERY = 0x11,
> -	HPWMI_SET_PERFORMANCE_MODE = 0x1A,
> -	HPWMI_FAN_SPEED_MAX_GET_QUERY = 0x26,
> -	HPWMI_FAN_SPEED_MAX_SET_QUERY = 0x27,
> -	HPWMI_GET_SYSTEM_DESIGN_DATA = 0x28,
> +	HPWMI_FAN_SPEED_GET_QUERY	= 0x11,
> +	HPWMI_SET_PERFORMANCE_MODE	= 0x1A,
> +	HPWMI_FAN_SPEED_MAX_GET_QUERY	= 0x26,
> +	HPWMI_FAN_SPEED_MAX_SET_QUERY	= 0x27,
> +	HPWMI_GET_SYSTEM_DESIGN_DATA	= 0x28,
> +	HPWMI_GET_KEYBOARD_TYPE		= 0x2B,
> +};
> +
> +enum hp_wmi_fourzone_commandtype {
> +	HPWMI_SUPPORTS_LIGHTNING	= 0x01,
> +	HPWMI_FOURZONE_COLOR_GET	= 0x02,
> +	HPWMI_FOURZONE_COLOR_SET	= 0x03,
> +	HPWMI_LED_BRIGHTNESS_GET	= 0x04,
> +	HPWMI_LED_BRIGHTNESS_SET	= 0x05,
> +};
> +
> +enum hp_wmi_keyboardtype {
> +	HPWMI_KEYBOARD_INVALID        = 0x00,
> +	HPWMI_KEYBOARD_NORMAL         = 0x01,
> +	HPWMI_KEYBOARD_WITH_NUMPAD    = 0x02,
> +	HPWMI_KEYBOARD_WITHOUT_NUMPAD = 0x03,
> +	HPWMI_KEYBOARD_RGB	      = 0x04,

Align with plain tabs, not with spaces after tabs.

>  };
>  
>  enum hp_wmi_command {
> -	HPWMI_READ	= 0x01,
> -	HPWMI_WRITE	= 0x02,
> -	HPWMI_ODM	= 0x03,
> -	HPWMI_GM	= 0x20008,
> +	HPWMI_READ     = 0x01,
> +	HPWMI_WRITE    = 0x02,
> +	HPWMI_ODM      = 0x03,
> +	HPWMI_GM       = 0x20008,

Why did you change these from tabs to spaces? I shouldn't need to touch 
these lines at all.

> +	HPWMI_FOURZONE = 0x20009,

Align with tabs

>  };
>  
>  enum hp_wmi_hardware_mask {
> @@ -821,6 +852,86 @@ static struct attribute *hp_wmi_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(hp_wmi);
>  
> +static const char * const fourzone_zone_names[KBD_ZONE_COUNT] = {
> +	"hp:rgb:kbd_zoned_backlight-right",
> +	"hp:rgb:kbd_zoned_backlight-middle",
> +	"hp:rgb:kbd_zoned_backlight-left",
> +	"hp:rgb:kbd_zoned_backlight-wasd"

Add comma to all non-terminating array entries.

> +};
> +
> +struct hp_fourzone_led {
> +	struct led_classdev_mc mc_led;
> +	struct mc_subled subleds[3];
> +	/*
> +	 * This stores the last set brightness level to restore it on off->on toggle
> +	 * by the FN-key combo.
> +	 */
> +	enum led_brightness brightness;

Noting that there's a parallel effort on (removing) led_brightness and 
turning it into an integer range (if I understood things correctly):

https://lore.kernel.org/all/CAM_RzfbuYYf7P2YK7H0BpUJut8hFvxa-Sm6hP1BKJe-jVFa62w@mail.gmail.com/

> +};
> +static struct hp_fourzone_led fourzone_leds[KBD_ZONE_COUNT];
> +static struct mutex fourzone_mutex;
> +
> +static enum led_brightness fourzone_get_hw_brightness(void)
> +{
> +	u8 buff[4];
> +
> +	hp_wmi_perform_query(HPWMI_LED_BRIGHTNESS_GET, HPWMI_FOURZONE, &buff,
> +			     sizeof(buff), sizeof(buff));

Error handling?

> +
> +	return buff[0] == FOURZONE_LIGHTING_ON ? LED_ON : LED_OFF;
> +}
> +
> +static int fourzone_set_colors(void)

This returns int but neither caller cares to check it?

> +{
> +	int ret, i, j;
> +	u8 buff[128];

Where does this 128 come from? Perhaps it should be named with a define?

> +
> +	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE, &buff,
> +				   sizeof(buff), sizeof(buff));
> +	if (ret != 0)
> +		return -EINVAL;

This is not a problem with input values (AFAICT) so it shouldn't return 
-EINVAL or something else. Perhaps -EIO?

> +
> +	for (i = 0; i < KBD_ZONE_COUNT; i++)
> +		for (j = 0; j < 3; j++)
> +			buff[25 + i * 3 + j] = fourzone_leds[i].subleds[j].brightness;

25 looks something that should be named with a define.

Also, there's lots of literal 3 in the code which would be nice to name 
properly.

> +
> +	return hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_SET, HPWMI_FOURZONE, &buff,
> +				    sizeof(buff), sizeof(buff));
> +}
> +
> +static void fourzone_set_state(void)
> +{
> +	enum led_brightness hw_brightness;
> +	int i;
> +
> +	mutex_lock(&fourzone_mutex);
> +
> +	hw_brightness = fourzone_get_hw_brightness();
> +
> +	if (hw_brightness)
> +		/* restore old brightness values */
> +		for (i = 0; i < KBD_ZONE_COUNT; i++) {
> +			fourzone_leds[i].mc_led.led_cdev.brightness = fourzone_leds[i].brightness;
> +			led_mc_calc_color_components(&fourzone_leds[i].mc_led,
> +						     fourzone_leds[i].brightness);
> +		}
> +	else
> +		for (i = 0; i < KBD_ZONE_COUNT; i++) {
> +			fourzone_leds[i].brightness = fourzone_leds[i].mc_led.led_cdev.brightness;
> +			fourzone_leds[i].mc_led.led_cdev.brightness = LED_OFF;
> +			led_mc_calc_color_components(&fourzone_leds[i].mc_led, LED_OFF);
> +		}

Please add the braces around these multiline if & else blocks as per the 
coding style.

> +
> +	fourzone_set_colors();
> +
> +	/* notify userspace about the change */
> +	for (i = 0; i < KBD_ZONE_COUNT; i++)
> +		led_classdev_notify_brightness_hw_changed(&fourzone_leds[i].mc_led.led_cdev,
> +							  hw_brightness);
> +
> +	mutex_unlock(&fourzone_mutex);
> +}
> +
>  static void hp_wmi_notify(u32 value, void *context)
>  {
>  	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
> @@ -932,6 +1043,7 @@ static void hp_wmi_notify(u32 value, void *context)
>  	case HPWMI_PROXIMITY_SENSOR:
>  		break;
>  	case HPWMI_BACKLIT_KB_BRIGHTNESS:
> +		fourzone_set_state();
>  		break;
>  	case HPWMI_PEAKSHIFT_PERIOD:
>  		break;
> @@ -1505,6 +1617,155 @@ static int thermal_profile_setup(void)
>  	return 0;
>  }
>  
> +static void fourzone_set_brightness(struct led_classdev *led_cdev, enum led_brightness brightness)
> +{
> +	u8 buff[4] = { };
> +	int i, zone = 0;
> +	bool on = false;
> +
> +	for (i = 0; i < KBD_ZONE_COUNT; i++)
> +		if (!strcmp(led_cdev->name, fourzone_zone_names[i]))
> +			zone = i;
> +
> +	mutex_lock(&fourzone_mutex);
> +
> +	/* always update main and per color brightness values even when the backlight is off */
> +	fourzone_leds[zone].mc_led.led_cdev.brightness = brightness;
> +	led_mc_calc_color_components(&fourzone_leds[zone].mc_led, brightness);
> +	fourzone_set_colors();
> +
> +	for (i = 0; i < KBD_ZONE_COUNT; i++)
> +		if (fourzone_leds[i].mc_led.led_cdev.brightness)
> +			on = true;
> +
> +	/*
> +	 * This makes sure that when turning the kbd off with sw and back on with hw, there is a
> +	 * zone with brightness != 0 to go back to
> +	 */
> +	if (on)
> +		fourzone_leds[zone].brightness = brightness;
> +
> +	/* change the keyboard mode to off if all brightness values are set to 0 */
> +	buff[0] = on ? FOURZONE_LIGHTING_ON : FOURZONE_LIGHTING_OFF;
> +	hp_wmi_perform_query(HPWMI_LED_BRIGHTNESS_SET, HPWMI_FOURZONE, &buff, sizeof(buff), 0);
> +
> +	mutex_unlock(&fourzone_mutex);
> +}
> +
> +static int fourzone_get_hw_colors(u32 *colors)
> +{
> +	u8 buff[128];
> +	int ret, i;
> +
> +	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE, &buff,
> +				   sizeof(buff), sizeof(buff));
> +	if (ret != 0)
> +		return -EINVAL;
> +
> +	for (i = 0; i < KBD_ZONE_COUNT; i++) {
> +		colors[i * 3]     = FIELD_GET(FOURZONE_COLOR, buff[25 + i * 3]);
> +		colors[i * 3 + 1] = FIELD_GET(FOURZONE_COLOR, buff[25 + i * 3 + 1]);
> +		colors[i * 3 + 2] = FIELD_GET(FOURZONE_COLOR, buff[25 + i * 3 + 2]);

Use the named define for 25.

Why not use inner loop here like was used in the other place?

> +	}
> +
> +	return 0;
> +}
> +
> +static int __init fourzone_leds_init(struct platform_device *device)
> +{
> +	enum led_brightness hw_brightness;
> +	u32 colors[KBD_ZONE_COUNT * 3];
> +	int ret, i, j;
> +
> +	ret = fourzone_get_hw_colors(colors);
> +	if (ret < 0)
> +		return ret;
> +
> +	hw_brightness = fourzone_get_hw_brightness();
> +
> +	for (i = 0; i < KBD_ZONE_COUNT; i++) {
> +		for (j = 0; j < 3; j++)
> +			fourzone_leds[i].subleds[j] = (struct mc_subled) {
> +				.color_index = j + 1,
> +				.brightness = hw_brightness ? colors[i * 3 + j] : 0,
> +				.intensity = colors[i * 3 + j],
> +			};
> +
> +		fourzone_leds[i].mc_led = (struct led_classdev_mc) {
> +			.led_cdev = {
> +				.name = fourzone_zone_names[i],
> +				.brightness = hw_brightness ? 255 : 0,
> +				.max_brightness = 255,
> +				.brightness_set = fourzone_set_brightness,
> +				.color = LED_COLOR_ID_RGB,
> +				.flags = LED_BRIGHT_HW_CHANGED | LED_RETAIN_AT_SHUTDOWN,
> +			},
> +			.num_colors = 3,
> +			.subled_info = fourzone_leds[i].subleds,
> +		};
> +
> +		fourzone_leds[i].brightness = 255;
> +
> +		ret = devm_led_classdev_multicolor_register(&device->dev, &fourzone_leds[i].mc_led);
> +		if (ret)
> +			return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static enum hp_wmi_keyboardtype fourzone_get_keyboard_type(void)
> +{
> +	u8 buff[128];
> +	int ret;
> +
> +	ret = hp_wmi_perform_query(HPWMI_GET_KEYBOARD_TYPE, HPWMI_GM, &buff,
> +				   sizeof(buff), sizeof(buff));
> +	if (ret != 0)
> +		return HPWMI_KEYBOARD_INVALID;
> +
> +	/* the first byte in the response represents the keyboard type */
> +	return (enum hp_wmi_keyboardtype)(buff[0] + 1);
> +}
> +
> +static bool fourzone_supports_lighting(void)
> +{
> +	u8 buff[128];
> +	int ret;
> +
> +	ret = hp_wmi_perform_query(HPWMI_SUPPORTS_LIGHTNING, HPWMI_FOURZONE, &buff,
> +				   sizeof(buff), sizeof(buff));
> +	if (ret != 0)
> +		return false;
> +
> +	return buff[0] & FOURZONE_LIGHTING_SUPPORTED_BIT;
> +}
> +
> +static void fourzone_mutex_destroy(void *data)
> +{
> +	mutex_destroy((struct mutex *)data);
> +}
> +
> +static int fourzone_setup(struct platform_device *device)
> +{
> +	if (!fourzone_supports_lighting())
> +		return -ENODEV;
> +
> +	if (fourzone_get_keyboard_type() != HPWMI_KEYBOARD_WITHOUT_NUMPAD)
> +		return -ENODEV;
> +
> +	mutex_init(&fourzone_mutex);
> +	if (devm_add_action_or_reset(&hp_wmi_platform_dev->dev, fourzone_mutex_destroy,
> +				     &fourzone_mutex))

devm_mutex_init() should alleviate the need to define custom action for 
its destruction.

> +		return -ENODEV;
> +
> +	/* register leds */
> +	if (fourzone_leds_init(device) < 0)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
>  static int hp_wmi_hwmon_init(void);
>  
>  static int __init hp_wmi_bios_setup(struct platform_device *device)
> @@ -1534,6 +1795,9 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
>  
>  	thermal_profile_setup();
>  
> +	/* setup 4 zone rgb, no problem on error */
> +	fourzone_setup(device);
> +
>  	return 0;
>  }
>  
> 

-- 
 i.


