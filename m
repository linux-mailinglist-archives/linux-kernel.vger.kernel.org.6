Return-Path: <linux-kernel+bounces-283204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976CF94EE93
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D29E6B24101
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E98117C7B6;
	Mon, 12 Aug 2024 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CC+1j8v8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AB517F4EE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470291; cv=none; b=CW78XqqVAOa7EG/El6M20C0PjK4QM+pTPSEOismCQ2Z4d4n8doRme/QFD+M2ySbvf3g52qb/WIKdPBUmqz2MdSb7QT6cL9DAQDMwNp+Nr50cohjI6o0457WzkRkr2d+zLgXzPG6zcJYcM4WNcbpaWs1mlJztBuqMXxbfgvdLIsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470291; c=relaxed/simple;
	bh=HL0FtmisuuNqO7FqgUIGTWQsywczyKqjEsc+bCocJKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbq7isOPLq1/Tah5lAWkayu7ZnL4Z0h7MIadd1RUKyFVSStoBg0jjw5mzPFFPNhGW03LDZl1BroBU0VmdrIAmcpGZdL5rXAWOpQ4JGj6fPRba0/CHdll5akFCyTcJbzri99QQFSRI8uJzd1vMJuUekHWmkC40xavKKOsoUgzj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CC+1j8v8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723470287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8SW+Vfy0QQUZzQeqil/RhoKPfpFJfWCoCwnuswPcIk=;
	b=CC+1j8v8ikryZjoMgNhXZCS3nT75j+Bm++fdNo0rWN5tbMQD3zsspWbZnXoF9IQADPeZpg
	bCM12zvUULaRZDLgFxUnyyoX2Shbb3YQ0QG/SixDMaZxTN/FfZE7eBwaLHMzf/mrZRvd01
	xenahBYGPcexiGKqPzQs/Gq1FWmr+Jc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-wr1wBKEOODKgLqWZd5GUkQ-1; Mon, 12 Aug 2024 09:44:46 -0400
X-MC-Unique: wr1wBKEOODKgLqWZd5GUkQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52efe4c2372so4655721e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723470285; x=1724075085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8SW+Vfy0QQUZzQeqil/RhoKPfpFJfWCoCwnuswPcIk=;
        b=hNueDd6/bKKeJ2xmHtpf6aOT99qt/Fzr61TUJbU5n0E6zUs199dUfeWmyZYsIAVEDD
         zKKKq5/c308YXYBwC7ZHBB3V3jMF5mv87Fb68v75f/toJnsB1DDbFg4q0xeZG9JAJZA2
         tc5nz+iPorWgbT2XAhkDU/AjoNgWMPR4w56jNmzZZaFfwYKxq3Q2UTlg/2P6X7pxe4gg
         4Ssr77AX1yljYJfxVpa+TFl4omqX1xfM175Krkjngc6XsXXQ465+YxXgPrTrefMFNvJV
         QgzSu95MLra7Uw22T80JQ60VWMn3VdO/gixUnhYwEB3pgsJD4Vy9rU1sIh0vUDz3ufDf
         Spiw==
X-Forwarded-Encrypted: i=1; AJvYcCV6HRrQxC+brS61VVtNOA8+183h+wGNsgqQ3jjMxwcRvdTyVpEMCVthTq2kAwASxxMsrpCOke3GnxMcmjl4tUJCzAZ70F9tv8Oz3B3i
X-Gm-Message-State: AOJu0YyhWmpa45QmizTMa2LS0qBOp8n/zrdqFrFZZDF2ljSXymd6bS4h
	aREwhVjCheV6omqybzoLvK5Dy9C/WKIa8eTKlT6FHl54k4sCe9MHl/g+w5MP8IbmMzQAQDaltVt
	YSeSojMeQ+5VK7JMwSoKsSF377dUVh+kGnyskhGZJ7dVCA+mBrjyPrSoU5pHnaA==
X-Received: by 2002:a05:6512:3048:b0:530:ad8b:de11 with SMTP id 2adb3069b0e04-5321364855bmr151146e87.9.1723470284756;
        Mon, 12 Aug 2024 06:44:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZvATm9Prv58gDOdp97at6XlQKABiW/aCqqtFGHW8WOX3goLea6Ix+W70Pg/EmfB1jawSjrA==
X-Received: by 2002:a05:6512:3048:b0:530:ad8b:de11 with SMTP id 2adb3069b0e04-5321364855bmr151115e87.9.1723470284073;
        Mon, 12 Aug 2024 06:44:44 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb090aadsm234892566b.14.2024.08.12.06.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 06:44:43 -0700 (PDT)
Message-ID: <8e06b567-8471-4109-bab1-f44a8d9780da@redhat.com>
Date: Mon, 12 Aug 2024 15:44:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] HP: wmi: added support for 4 zone keyboard rgb
To: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>,
 ilpo.jarvinen@linux.intel.com
Cc: mustafa.eskieksi@gmail.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240719100011.16656-1-carlosmiguelferreira.2003@gmail.com>
 <20240719100011.16656-2-carlosmiguelferreira.2003@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240719100011.16656-2-carlosmiguelferreira.2003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Thank you for the new version, much better, almost there I would say.

On 7/19/24 11:59 AM, Carlos Ferreira wrote:
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

As pointed out by the kernel test robot, LEDS_COLOR_MULTICOLOR
is a symbol which for which you should use "depends on" not
select. Note that in general when adding new dependencies it
is a good idea to grep for them in the kernel tree and see
what other consumers of the dependency are doing.

Generally speaking either all existing consumers will all
use "depends on" (which is the case here), or they will all
use select and you should follow the example of the existing
consumers to avoid things like circular dependency issues.
Note sometimes exiting use unfortunately is inconsistent.

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
> +	HPWMI_FOURZONE = 0x20009,
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

As Ilpo also just mentioned please make this a regular "int"
since the LED subsystem is working towards replacing
"enum led_brightness" with plain int, see:

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
> +
> +	return buff[0] == FOURZONE_LIGHTING_ON ? LED_ON : LED_OFF;
> +}

Please make the return type a u8 and just return buff[0].

and then (continued below after the mutex remark) ...

> +
> +static int fourzone_set_colors(void)
> +{
> +	int ret, i, j;
> +	u8 buff[128];
> +
> +	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE, &buff,
> +				   sizeof(buff), sizeof(buff));
> +	if (ret != 0)
> +		return -EINVAL;
> +
> +	for (i = 0; i < KBD_ZONE_COUNT; i++)
> +		for (j = 0; j < 3; j++)
> +			buff[25 + i * 3 + j] = fourzone_leds[i].subleds[j].brightness;
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

Please add "#include <linux/cleanup.h>" to the includes and use

	guard(mutex)(&fourzone_mutex);

here instead. This will auto-unlock on leaving the function,
so you can then drop the mutex_unlock() below and if any error
exit (early return) paths get added later those cannot forget
to unlock the mutex since this is done automatically.


> +
> +	hw_brightness = fourzone_get_hw_brightness();
> +

Make the type of hw_brightness a u8 and replace this line:

> +	if (hw_brightness)

With:

	if (hw_brightness == FOURZONE_LIGHTING_ON)

this avoids the need to translate the hw specific values into
some other range first.

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

Replace this with:

	guard(mutex)(&fourzone_mutex);

as discussed above.

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

I think it would be cleaner to drop setting subled brightness here and instead
call led_mc_calc_color_components() below ... :

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
> +			.subled_info = fourzone_leds[i].subleds;
> +		};
> +

With this all setup, you can now call:

		led_mc_calc_color_components(&fourzone_leds[i].mc_led, fourzone_leds[i].mc_led.led_cdev.brightness);

here, this makes how the subled brightness is set here (on init) identical with
how it is done on set_brightness calls which is more consistent.

> +		fourzone_leds[i].brightness = 255;
> +
> +		ret = devm_led_classdev_multicolor_register(&device->dev, &fourzone_leds[i].mc_led);
> +		if (ret)
> +			return -ENODEV;
> +	}
> +
> +	return 0;
> +}

<snip>

Regards,

Hans

p.s.

Please also address all the comments from Ilpo's review for v5.



