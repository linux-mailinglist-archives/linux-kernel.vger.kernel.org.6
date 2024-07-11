Return-Path: <linux-kernel+bounces-249621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3FE92EDEE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65DA28171A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C6216D9BC;
	Thu, 11 Jul 2024 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXpXdmGr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95642AB5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719440; cv=none; b=BkvsttLY2NQo5MD+eCTYYpyCS/QkVvzm/ZUsEMz9A6lUeVcYL3EKdFudv8aQEUiJYrFDjV7wtxj0fzB419EZZbN9gPwL5SCYwaZKxkh6Rr+cbg0lp9m5lC40hddjCXRmv1f4XfgJoHiK4JsWBRV/P+4KuDO60CmmTSgyNd+bL0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719440; c=relaxed/simple;
	bh=TxCH2gIyixEgXHU40Xt6NLlR1D+1qFP3Oji/9pdzwVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lalM+kemWTAR1s5ZZ2lrfi7tzawTsYMy9CwyDzDvYmFiv4XsXFXzsJPknhE77V8DoqKm30k6SPQd5y7SfVi2nAMIGJ5efkYqX/IzCb9EtYv4+KidxgwaB/sa3Se2p9keTqGaJCfsl19DCUbwX1iqhdHUrwog5WAzfMy3sWit7/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXpXdmGr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720719437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eK0crMJCyH9BGAdXpCG3oh3BvCuMI0Va4aHOhL3u5dU=;
	b=LXpXdmGrEcB+wmnsnD0dFNqSaPZjr+5hw27vL0lBvQ2ewgfqIBx87PDWrZCclz+pbuxqcB
	cep4EgRkCWmANmujWNctL9klojE+WVkXU3P/jyRlHucL8OeClGnyv75+x7SlIfIpTtFC4y
	DQDIWoOhhWysofVGHbHbli3bREE3p84=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-VSoOSj9QOTOJAL11BQ2-2g-1; Thu, 11 Jul 2024 13:37:13 -0400
X-MC-Unique: VSoOSj9QOTOJAL11BQ2-2g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7535875ab7so279077966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720719432; x=1721324232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eK0crMJCyH9BGAdXpCG3oh3BvCuMI0Va4aHOhL3u5dU=;
        b=PqF7J760q4KNdq2mzWuJrd818DW8NqZbsFJkYrJXwJxb3+1FlDQPz0W8iJR5TY42ht
         1vk1ZZriFeyPju7RP0NYn/Bd5rZVVaFRbs9mUTh/OUgX51C0zIUdihAdtJFHUnUAsC3d
         9DjOb1ShWaZ+fS6SFLS/h2pm9dgI9IyFUEVQvHSfa5XrWoVbpQ1vQD+wumWWVMDqtqUV
         SpUC4uBibj+mYyhULMV9j1l3jeWjHlok7IZK3j6MaMxDki65aFy8wUeR+Ui67z2mlfG6
         ANUs9DnHSQjhAtrQ8sXKQp0XoD28T6CgrFjNHdT9pdCbJRhtTzuTRpLgp3ue0HYurr+i
         W62g==
X-Forwarded-Encrypted: i=1; AJvYcCWS7k7hXOYk6/OCurBRL+/GOUiQGAz8jfPXvJwkGPqdP0CRuaVi65tZKy66otXeJ0p+HsMltKa6M7bCAjvC+O/ItBVuDrhmdU0oF/bg
X-Gm-Message-State: AOJu0Yxo4kk1/dqH2/uqKyRHUw/agJxexYIwZeCK8uQvvdg0MnB3Ig9v
	sBPHzjFg7kNM7HlEO7kDj8OBCxwEXHt6wQgGCk3RnsblSF+dNwH4Blbz9kL98IdjFybydf25KqH
	fNWjV4zzdqPzgtPKX2HZyiM03VqKuTSOZ7p7p19OPJybYS9C+n1mB3N5EPxEkRM4Xv20058Rv
X-Received: by 2002:a17:907:846:b0:a77:f5fc:cb61 with SMTP id a640c23a62f3a-a799cd67784mr31769966b.0.1720719432212;
        Thu, 11 Jul 2024 10:37:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPqd8SAGunOtVTcd5K+8FOIWtOBN/SWBPztP4efqlrYFibDmCdqppEoTIsfKL8L7t5aIpVig==
X-Received: by 2002:a17:907:846:b0:a77:f5fc:cb61 with SMTP id a640c23a62f3a-a799cd67784mr31767566b.0.1720719431588;
        Thu, 11 Jul 2024 10:37:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bc701sm274340166b.34.2024.07.11.10.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 10:37:10 -0700 (PDT)
Message-ID: <acbdb469-f6a4-4180-9d68-9724b3ffe9e2@redhat.com>
Date: Thu, 11 Jul 2024 19:37:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] HP: wmi: added support for 4 zone keyboard rgb
To: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240707175613.27529-1-carlosmiguelferreira.2003@gmail.com>
 <20240707175613.27529-2-carlosmiguelferreira.2003@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240707175613.27529-2-carlosmiguelferreira.2003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Carlos,

On 7/7/24 7:54 PM, Carlos Ferreira wrote:
> This driver adds supports for 4 zone keyboard rgb on omen laptops
> and maps the wmi backlight toggle event to KEY_KBDILLUMTOGGLE.
> For the backlight, it uses the multicolor led api.
> 
> Tested on the HP Omen 15-en1001np.
> 
> Signed-off-by: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
> ---
> Changes in v3:
>  - Moved to the multicolor led api
>  - Mapped the wmi backlight toggle event to KEY_KBDILLUMTOGGLE
>  - Some other minor changes
> Changes in v2:
>  - Rearranged code to remove forward declarations
>  - Changed from sprintf() to sysfs_emit()
>  - Fixed some identation and coding style problems
>  - Switched from manual bit manipulation to GENMASK(x, y) + FIELD_PREP(XX, )
>  - #define'ed magic constants
> ---
>  drivers/platform/x86/hp/hp-wmi.c | 248 +++++++++++++++++++++++++++++--
>  1 file changed, 239 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 5fa553023842..5eae47961f76 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -14,6 +14,8 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/kernel.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/leds.h>

This means that you now also need to update Kconfig to depend on
LEDS_CLASS_MULTICOLOR, so add the following line to the existing
Kconfig entry for the HP WMI driver:

	depends on LEDS_CLASS_MULTICOLOR

Adding this should fix the following errors reported by
the kernel test robot:

ERROR: modpost: "devm_led_classdev_multicolor_unregister" [drivers/platform/x86/hp/hp-wmi.ko] undefined!
ERROR: modpost: "devm_led_classdev_multicolor_register_ext" [drivers/platform/x86/hp/hp-wmi.ko] undefined!



>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> @@ -24,6 +26,7 @@
>  #include <linux/platform_profile.h>
>  #include <linux/hwmon.h>
>  #include <linux/acpi.h>
> +#include <linux/bits.h>
>  #include <linux/rfkill.h>
>  #include <linux/string.h>
>  #include <linux/dmi.h>

As Ilpo mentioned you need to add a:

#include <linux/bitfield.h>

here.

> @@ -44,6 +47,14 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45E9-BE91-3D44E2C707E4");
>  
>  #define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use when zero insize is required
>  
> +#define FOURZONE_LIGHTING_SUPPORTED_BIT	0x01
> +#define FOURZONE_LIGHTING_ON		228
> +#define FOURZONE_LIGHTING_OFF		100
> +
> +#define FOURZONE_COLOR_R		GENMASK(23, 16)
> +#define FOURZONE_COLOR_G		GENMASK(15, 8)
> +#define FOURZONE_COLOR_B		GENMASK(7, 0)

I see here and below that you are encoding all 3 color components in
a single 24bit intensity / brightness value, that is not how you
are supposed to use the multi-color LED API. More about this below.

> +
>  /* DMI board names of devices that should use the omen specific path for
>   * thermal profiles.
>   * This was obtained by taking a look in the windows omen command center
> @@ -143,18 +154,36 @@ enum hp_wmi_commandtype {
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
> @@ -265,6 +294,7 @@ static struct platform_device *hp_wmi_platform_dev;
>  static struct platform_profile_handler platform_profile_handler;
>  static bool platform_profile_support;
>  static bool zero_insize_support;
> +static bool fourzone_lightning_support;
>  
>  static struct rfkill *wifi_rfkill;
>  static struct rfkill *bluetooth_rfkill;
> @@ -821,6 +851,40 @@ static struct attribute *hp_wmi_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(hp_wmi);
>  
> +static const char * const fourzone_zone_names[4] = {
> +	"hp:rgb:kbd_zoned_backlight-right",
> +	"hp:rgb:kbd_zoned_backlight-middle",
> +	"hp:rgb:kbd_zoned_backlight-left",
> +	"hp:rgb:kbd_zoned_backlight-wasd"
> +};
> +
> +struct hp_fourzone_leds {
> +	struct led_classdev_mc leds[4];
> +	struct mc_subled subleds[4];

The idea with the multi-color API and subleds is that
a RGB LED really are 3 seperate LEDs (R + G + B) in one.
This is alsohow they are actually phyiscally made.
So for 4 zones you need 12 subleds.

I think it would be best to to have a single struct per zone:

struct hp_fourzone_led {
	struct led_classdev_mc mc_led;
	struct mc_subled subleds[3];
	u32 cache; /* Not sure if you still want this */
};

And then declare an array of 4 of these:

static struct hp_fourzone_led hp_fourzone_leds[4];



> +	u32 color_cache[4];
> +};
> +static struct hp_fourzone_leds fourzone_leds;
> +
> +static enum led_brightness get_fourzone_brightness(struct led_classdev *led_cdev)
> +{
> +	u8 buff[4];
> +
> +	hp_wmi_perform_query(HPWMI_LED_BRIGHTNESS_GET, HPWMI_FOURZONE,
> +		&buff, sizeof(buff), sizeof(buff));
> +
> +	return buff[0] == FOURZONE_LIGHTING_ON ? LED_ON : LED_OFF;
> +}
> +
> +static void fourzone_update_brightness(void)
> +{
> +	unsigned int br;
> +
> +	/* synchronize the brightness level on all zones */
> +	br = get_fourzone_brightness(NULL);
> +	for (size_t i = 0; i < 4; i++)
> +		fourzone_leds.leds[i].led_cdev.brightness = br;
> +}
> +
>  static void hp_wmi_notify(u32 value, void *context)
>  {
>  	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
> @@ -932,6 +996,14 @@ static void hp_wmi_notify(u32 value, void *context)
>  	case HPWMI_PROXIMITY_SENSOR:
>  		break;
>  	case HPWMI_BACKLIT_KB_BRIGHTNESS:
> +		if (fourzone_lightning_support) {
> +			input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, true);
> +			input_sync(hp_wmi_input_dev);
> +			input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, false);
> +			input_sync(hp_wmi_input_dev);
> +
> +			fourzone_update_brightness();

Does you calling fourzone_update_brightness() here mean that the embedded
controller (EC) if the laptop toggles the kbd backlight on/off itself when
you press the Fn + key combo for this on the kbd ? In that case you
should not be sending a KEY_KBDILLUMTOGGLE key press event. That event
is telling userspace that it should toggle the brightness, which you
should only do if this is not done by the EC itself.

If the EC does indeed toggle the brightness on/off (or even cycles it
between various brightness levels) then the right thing to do is to
call led_classdev_notify_brightness_hw_changed() on mc_led.led_cdev for
each of the 4 zones when receiving this event.

> +		}
>  		break;
>  	case HPWMI_PEAKSHIFT_PERIOD:
>  		break;
> @@ -1505,6 +1577,154 @@ static int thermal_profile_setup(void)
>  	return 0;
>  }
>  
> +static int fourzone_set_colors(u32 color, size_t zone)
> +{
> +	u8 buff[128];
> +	int ret;
> +
> +	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
> +		&buff, sizeof(buff), sizeof(buff));
> +	if (ret != 0)
> +		return -EINVAL;

You are doing a read + modify + write of the kbd settings here.

This is fine, but to avoid racing against another r/m/w cycle
done at the same time if userspace writes 2 zones at the same
time you need to take a mutex here.

> +
> +	buff[25 + zone * 3]     = FIELD_GET(FOURZONE_COLOR_R, color);
> +	buff[25 + zone * 3 + 1] = FIELD_GET(FOURZONE_COLOR_G, color);
> +	buff[25 + zone * 3 + 2] = FIELD_GET(FOURZONE_COLOR_B, color);

As mentioned above this is wrong. You should have a separate mc_subled
struct for each color for each zone (so 3 mc_subled-s per zone,
one for each of R, G and B; and the you take subled.brightness field
from the 3 subleds for the 3 different values.

> +
> +	return hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_SET, HPWMI_FOURZONE,
> +		&buff, sizeof(buff), sizeof(buff));
> +}
> +
> +static int fourzone_get_colors(u32 *colors)
> +{
> +	u8 buff[128];
> +	int ret;
> +
> +	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
> +		&buff, sizeof(buff), sizeof(buff));
> +	if (ret != 0)
> +		return -EINVAL;
> +
> +	for (int i = 0; i < 4; i++) {
> +		colors[i] = FIELD_PREP(FOURZONE_COLOR_R, buff[25 + i * 3])
> +			  | FIELD_PREP(FOURZONE_COLOR_G, buff[25 + i * 3 + 1])
> +			  | FIELD_PREP(FOURZONE_COLOR_B, buff[25 + i * 3 + 2]);
> +	}

same here.

> +
> +	return 0;
> +}
> +
> +static void set_fourzone_brightness(struct led_classdev *led_cdev, enum led_brightness brightness)
> +{
> +	size_t zone;
> +
> +	for (size_t i = 0; i < 4; i++)
> +		if (strcmp(led_cdev->name, fourzone_zone_names[i]) == 0)
> +			zone = i;
> +

So the way how the multicolor LED class devices work is that they have 2
brightness controls:

/sys/class/leds/hp:rgb:kbd_zoned_backlight-right/brightness 
/sys/class/leds/hp:rgb:kbd_zoned_backlight-right/multi_intensity

Where brightness is a single integer value for overall brightness
control and multi_intensity is a per channel brightness control, also see
Documentation/leds/leds-class-multicolor.rst

Now most hw does not have a main/overall brightness control only
per channel controls (like this hp code) so there is a helper which
you pass the overall brightness value and which then calculates the
per channel brightnesses for you.

The LED core code caches the last multi_intensity values for you
and there is a helper you can call from the (this) brightness_set()
callback:

	led_mc_calc_color_components(&fourzone_leds[i].mc_led, brightness);

which will then update the fourzone_leds[i].subleds[0 - 2].brightness
values with the desired per channel brightness values and then you can
use those 3 brightness values in fourzone_set_colors() to send to
the keyboard.


> +	if (fourzone_leds.leds[zone].subled_info->intensity == fourzone_leds.color_cache[zone]) {
> +		u8 buff[4] = {
> +			brightness == LED_ON ? FOURZONE_LIGHTING_ON : FOURZONE_LIGHTING_OFF,
> +			0, 0, 0
> +		};
> +
> +		hp_wmi_perform_query(HPWMI_LED_BRIGHTNESS_SET, HPWMI_FOURZONE, &buff,
> +			sizeof(buff), 0);
> +
> +		fourzone_update_brightness();
> +	} else {
> +		fourzone_set_colors(fourzone_leds.leds[zone].subled_info->intensity, zone);
> +		fourzone_leds.color_cache[zone] = fourzone_leds.leds[zone].subled_info->intensity;
> +	}

And this weird cahce thing can be removed then too, just always send the newly calculated
3 brightness values to the kbd.


> +}
> +
> +static int __init fourzone_leds_init(struct platform_device *device)
> +{
> +	enum led_brightness brightness;
> +	u32 colors[4];
> +	int ret;
> +
> +	ret = fourzone_get_colors(colors);
> +	if (ret < 0)
> +		return ret;
> +
> +	memcpy(fourzone_leds.color_cache, colors, sizeof(colors));
> +
> +	brightness = get_fourzone_brightness(NULL);
> +
> +	for (size_t i = 0; i < 4; i++) {
> +		fourzone_leds.subleds[i] = (struct mc_subled) {
> +			.color_index = LED_COLOR_ID_RGB,
> +			.brightness = 1,
> +			.intensity = colors[i]
> +		};

So over here you need to have a nested for loop to initialize
all 3 subleds for each zone.


> +
> +		fourzone_leds.leds[i] = (struct led_classdev_mc) {
> +			.led_cdev = {
> +				.name = fourzone_zone_names[i],
> +				.brightness = brightness,
> +				.max_brightness = 1,

This should be 255 now.

> +				.brightness_set = set_fourzone_brightness,
> +			`	.brightness_get = get_fourzone_brightness,
> +				.color = LED_COLOR_ID_RGB,
> +				.flags = LED_BRIGHT_HW_CHANGED
> +			},
> +			.num_colors = 1,

This should be 3.

> +			.subled_info = &fourzone_leds.subleds[i]

And this points to fourzone_leds[i].subleds now.

> +		};
> +
> +		ret = devm_led_classdev_multicolor_register(&device->dev, &fourzone_leds.leds[i]);
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
> +	ret = hp_wmi_perform_query(HPWMI_GET_KEYBOARD_TYPE, HPWMI_GM,
> +		&buff, sizeof(buff), sizeof(buff));
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
> +	ret = hp_wmi_perform_query(HPWMI_SUPPORTS_LIGHTNING, HPWMI_FOURZONE,
> +		&buff, sizeof(buff), sizeof(buff));
> +	if (ret != 0)
> +		return false;
> +
> +	return buff[0] & FOURZONE_LIGHTING_SUPPORTED_BIT;
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
> +	/* register leds */
> +	if (fourzone_leds_init(device) < 0)
> +		return -ENODEV;
> +
> +	input_set_capability(hp_wmi_input_dev, KE_KEY, KEY_KBDILLUMTOGGLE);
> +
> +	return 0;
> +}
> +
>  static int hp_wmi_hwmon_init(void);
>  
>  static int __init hp_wmi_bios_setup(struct platform_device *device)
> @@ -1534,6 +1754,10 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
>  
>  	thermal_profile_setup();
>  
> +	/* setup 4 zone rgb */
> +	if (!fourzone_setup(device))
> +		fourzone_lightning_support = true;
> +
>  	return 0;
>  }
>  
> @@ -1561,6 +1785,12 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
>  
>  	if (platform_profile_support)
>  		platform_profile_remove();
> +
> +	if (fourzone_lightning_support)
> +		for (size_t i = 0; i < 4; i++) {
> +			devm_led_classdev_multicolor_unregister(&device->dev,
> +				&fourzone_leds.leds[i]);
> +		}

The whole idea behind devm_register_foo() functions is that they get automatically
removed when the driver is unbound from the device. So this code and
the fourzone_lightning_support flag are not necessary.

Regards,

Hans



>  }
>  
>  static int hp_wmi_resume_handler(struct device *device)


