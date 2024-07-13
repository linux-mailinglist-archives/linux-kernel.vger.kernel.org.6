Return-Path: <linux-kernel+bounces-251486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D059593056A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 13:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39FBDB21D4B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 11:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DFF7E59A;
	Sat, 13 Jul 2024 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKjREVIX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E85130498
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720870189; cv=none; b=PRYAnapCWXLm4McHXmy45LEkrn9WjplT/oCZGWd2Xd1luqugZtd1UTrn+pw2BfNAM4IkCsR7unh6QkPRjL0IxRvccl3WKnXgt5NplTWMmFURqc5xxdEQBzkEUH5fIm2YotYSUScdJnJDbsugEkwOPR+5p33GsXhWxp07k75kZcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720870189; c=relaxed/simple;
	bh=Mn3qJbQPL9dd1sHwbA9CRPqSESBnsjJt+n+fRUIV5Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6ChljBPrAJjSnYBPaJHi97xFwC2xa1n6y8JLSqGCpP42lxlW24WABYQSwBrwqz0Jg/UHpg/r9RSN+bcxPSmimuPAH56FX7LwbvqoD8vTWDTcrJ/nujD9CvkeuWRry4Cp0Ed3jNLG1Izz/KRjCA6gVbRVPkkbsZXXMY6SnR0yiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LKjREVIX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720870186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCd4ndfnPt3do0tha6bLBWRXNlPUV2gAKUZurSJ6loQ=;
	b=LKjREVIXw0XS06e5O4aBsqWhz/ky8Rl9vXb0Jwr3nSVW1L8Awh0apQT589otVH5pCkraIt
	Ed93gH4bSQ6JG+zPNIRSIK5Uhj/iWc9I1D2NBdk00h7EKI7zrC9lu/t2aJcphBfrF7vmRC
	YBeneJQkK2x9yHnEQZFrcSi86eMAO84=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-W_cZL3OdNfO06J_o4i5qCQ-1; Sat, 13 Jul 2024 07:29:40 -0400
X-MC-Unique: W_cZL3OdNfO06J_o4i5qCQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5992e9859f5so1116644a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 04:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720870179; x=1721474979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCd4ndfnPt3do0tha6bLBWRXNlPUV2gAKUZurSJ6loQ=;
        b=VKX31YR9SvLcMOymmYvtGk1sKWSkTSeFZEzmy9eL1lYgFjfktTlS5TqGmiGqUOdrzj
         C3mviWUBIXKDEOobLNVAQW9GYooUFcGdPCoiEofuHBsOCrjejzUcmA7UMqY2Jmm4gnez
         QvRXojqRLZ2quv2heQOL9wY5Y0z1Ar4JSLsxIlIw7bEJhNmUEf8Gl4pBGGdafaoBsJdh
         3wSCfnIlvuG+JdHL/eMMQyQwON3mSigfVLKtzeu7h8kEL+Ofh4EQ7+tqVKm4KSDAPkl7
         +t9cs3IyYh/Ck5X3dP190n21MSAfNC3Fj1u4GQcLRNnbfZ1vDhIGRJioyVcoDHY1zo4N
         6bqw==
X-Gm-Message-State: AOJu0YzXKXqatTq7txuC/nhoFGMGsia+eXiKng4NcWCaUNrcRe43Ez8b
	GzWxrJXMWxdNScTPWQIfmcO22UdciRZS0yPmavFYj3AxClnGBu+pb6MeurgZ1PvMYIeevHq0xZF
	SZpYRGFkqF77L6g+7UA88l2ruDEwOrO8mXpxM3fPSWgb1XyXmshUu9SmdfXQMfg==
X-Received: by 2002:aa7:ca59:0:b0:57c:5874:4f5c with SMTP id 4fb4d7f45d1cf-594bc7caba9mr11438088a12.32.1720870178870;
        Sat, 13 Jul 2024 04:29:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdcRG/5I2N/m8T4l0yRCuOZoCvGyxCBw+32Tylb2HXBlpOFE+uhoJPhKXkioTL27FrVHoGOw==
X-Received: by 2002:aa7:ca59:0:b0:57c:5874:4f5c with SMTP id 4fb4d7f45d1cf-594bc7caba9mr11438065a12.32.1720870177415;
        Sat, 13 Jul 2024 04:29:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b268a2705sm648498a12.60.2024.07.13.04.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 04:29:37 -0700 (PDT)
Message-ID: <ff005a72-06ec-4dc6-99c8-6b89d8a80cf6@redhat.com>
Date: Sat, 13 Jul 2024 13:29:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] HP: wmi: added support for 4 zone keyboard rgb
To: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <acbdb469-f6a4-4180-9d68-9724b3ffe9e2@redhat.com>
 <20240712163925.15381-1-carlosmiguelferreira.2003@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240712163925.15381-1-carlosmiguelferreira.2003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Carlos,

On 7/12/24 6:39 PM, Carlos Ferreira wrote:
>>>  drivers/platform/x86/hp/hp-wmi.c | 248 +++++++++++++++++++++++++++++--
>>>  1 file changed, 239 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
>>> index 5fa553023842..5eae47961f76 100644
>>> --- a/drivers/platform/x86/hp/hp-wmi.c
>>> +++ b/drivers/platform/x86/hp/hp-wmi.c
>>> @@ -14,6 +14,8 @@
>>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>>  
>>>  #include <linux/kernel.h>
>>> +#include <linux/led-class-multicolor.h>
>>> +#include <linux/leds.h>
>>
>> This means that you now also need to update Kconfig to depend on
>> LEDS_CLASS_MULTICOLOR, so add the following line to the existing
>> Kconfig entry for the HP WMI driver:
>>
>> 	depends on LEDS_CLASS_MULTICOLOR
>>
>> Adding this should fix the following errors reported by
>> the kernel test robot:
>>
>> ERROR: modpost: "devm_led_classdev_multicolor_unregister" [drivers/platform/x86/hp/hp-wmi.ko] undefined!
>> ERROR: modpost: "devm_led_classdev_multicolor_register_ext" [drivers/platform/x86/hp/hp-wmi.ko] undefined!
> 
> Yes, i completely forgot that. Thank you.
> 
>>> +static const char * const fourzone_zone_names[4] = {
>>> +	"hp:rgb:kbd_zoned_backlight-right",
>>> +	"hp:rgb:kbd_zoned_backlight-middle",
>>> +	"hp:rgb:kbd_zoned_backlight-left",
>>> +	"hp:rgb:kbd_zoned_backlight-wasd"
>>> +};
>>> +
>>> +struct hp_fourzone_leds {
>>> +	struct led_classdev_mc leds[4];
>>> +	struct mc_subled subleds[4];
>>
>> The idea with the multi-color API and subleds is that
>> a RGB LED really are 3 seperate LEDs (R + G + B) in one.
>> This is alsohow they are actually phyiscally made.
>> So for 4 zones you need 12 subleds.
>>
>> I think it would be best to to have a single struct per zone:
>>
>> struct hp_fourzone_led {
>> 	struct led_classdev_mc mc_led;
>> 	struct mc_subled subleds[3];
>> 	u32 cache; /* Not sure if you still want this */
>> };
>>
>> And then declare an array of 4 of these:
>>
>> static struct hp_fourzone_led hp_fourzone_leds[4];
> 
> That makes sense, i will do it like that.
> 
>>> +	u32 color_cache[4];
>>> +};
>>> +static struct hp_fourzone_leds fourzone_leds;
>>> +
>>> +static enum led_brightness get_fourzone_brightness(struct led_classdev *led_cdev)
>>> +{
>>> +	u8 buff[4];
>>> +
>>> +	hp_wmi_perform_query(HPWMI_LED_BRIGHTNESS_GET, HPWMI_FOURZONE,
>>> +		&buff, sizeof(buff), sizeof(buff));
>>> +
>>> +	return buff[0] == FOURZONE_LIGHTING_ON ? LED_ON : LED_OFF;
>>> +}
>>> +
>>> +static void fourzone_update_brightness(void)
>>> +{
>>> +	unsigned int br;
>>> +
>>> +	/* synchronize the brightness level on all zones */
>>> +	br = get_fourzone_brightness(NULL);
>>> +	for (size_t i = 0; i < 4; i++)
>>> +		fourzone_leds.leds[i].led_cdev.brightness = br;
>>> +}
>>> +
>>>  static void hp_wmi_notify(u32 value, void *context)
>>>  {
>>>  	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
>>> @@ -932,6 +996,14 @@ static void hp_wmi_notify(u32 value, void *context)
>>>  	case HPWMI_PROXIMITY_SENSOR:
>>>  		break;
>>>  	case HPWMI_BACKLIT_KB_BRIGHTNESS:
>>> +		if (fourzone_lightning_support) {
>>> +			input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, true);
>>> +			input_sync(hp_wmi_input_dev);
>>> +			input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, false);
>>> +			input_sync(hp_wmi_input_dev);
>>> +
>>> +			fourzone_update_brightness();
>>
>> Does you calling fourzone_update_brightness() here mean that the embedded
>> controller (EC) if the laptop toggles the kbd backlight on/off itself when
>> you press the Fn + key combo for this on the kbd ? In that case you
> 
> It switches between the on/off modes.
> More about this below.
> 
>> should not be sending a KEY_KBDILLUMTOGGLE key press event. That event
>> is telling userspace that it should toggle the brightness, which you
>> should only do if this is not done by the EC itself.
> 
> Is there a way i could do this that i still get this nice indication on the
> screen that the key was pressed?

Yes, led_classdev_notify_brightness_hw_changed() will also inform userspace
about the brightness being changed by the hw itself and at least upower
and GNOME support this. One problem is that upower does not know that the
new /sys/class/leds/hp:rgb:kbd_zoned_backlight-<zone> devices are for
a backlit keyboard. So for testing what you could do is name one of the
zones in the driver "hp:rgb:kbd_backlight". Then GNOME should show
the nice on screen notification when you toggle the brightness with the key,
if you call led_classdev_notify_brightness_hw_changed() on all 4 led_classdev-s
when this happens.

> For me it would make sense to tell the user that the brightness key was pressed.

Right and that is what led_classdev_notify_brightness_hw_changed() does.

The difference is led_classdev_notify_brightness_hw_changed() is for notifying
of the hw changing the brightness itself, where as KEY_KBDILLUMTOGGLE key press
events ask of userspace to toggle the brightness itself. You are not seeing
userspace toggling the brightness itself with your testing because upower
does not support /sys/class/leds/<foo>:rgb:kbd_zoned_backlight-<zone> devices
yet. But once it does support those then sending KEY_KBDILLUMTOGGLE will not
only show the on screen notification it will also cause GNOME to toggle
the brightness (a second time) basically undoing the hw toggle.

>> If the EC does indeed toggle the brightness on/off (or even cycles it
>> between various brightness levels) then the right thing to do is to
>> call led_classdev_notify_brightness_hw_changed() on mc_led.led_cdev for
>> each of the 4 zones when receiving this event.
> 
> For this to work properly, it would depend on how we manage the brightness.
> More about this below.
> 
>>> +		}
>>>  		break;
>>>  	case HPWMI_PEAKSHIFT_PERIOD:
>>>  		break;
>>> @@ -1505,6 +1577,154 @@ static int thermal_profile_setup(void)
>>>  	return 0;
>>>  }
>>>  
>>> +static int fourzone_set_colors(u32 color, size_t zone)
>>> +{
>>> +	u8 buff[128];
>>> +	int ret;
>>> +
>>> +	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
>>> +		&buff, sizeof(buff), sizeof(buff));
>>> +	if (ret != 0)
>>> +		return -EINVAL;
>>
>> You are doing a read + modify + write of the kbd settings here.
>>
>> This is fine, but to avoid racing against another r/m/w cycle
>> done at the same time if userspace writes 2 zones at the same
>> time you need to take a mutex here.
> 
> I agree with you and Ilpo, this should have a mutex.
> 
>>> +
>>> +	buff[25 + zone * 3]     = FIELD_GET(FOURZONE_COLOR_R, color);
>>> +	buff[25 + zone * 3 + 1] = FIELD_GET(FOURZONE_COLOR_G, color);
>>> +	buff[25 + zone * 3 + 2] = FIELD_GET(FOURZONE_COLOR_B, color);
>>
>> As mentioned above this is wrong. You should have a separate mc_subled
>> struct for each color for each zone (so 3 mc_subled-s per zone,
>> one for each of R, G and B; and the you take subled.brightness field
>> from the 3 subleds for the 3 different values.
>>
>>> +
>>> +	return hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_SET, HPWMI_FOURZONE,
>>> +		&buff, sizeof(buff), sizeof(buff));
>>> +}
>>> +
>>> +static int fourzone_get_colors(u32 *colors)
>>> +{
>>> +	u8 buff[128];
>>> +	int ret;
>>> +
>>> +	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
>>> +		&buff, sizeof(buff), sizeof(buff));
>>> +	if (ret != 0)
>>> +		return -EINVAL;
>>> +
>>> +	for (int i = 0; i < 4; i++) {
>>> +		colors[i] = FIELD_PREP(FOURZONE_COLOR_R, buff[25 + i * 3])
>>> +			  | FIELD_PREP(FOURZONE_COLOR_G, buff[25 + i * 3 + 1])
>>> +			  | FIELD_PREP(FOURZONE_COLOR_B, buff[25 + i * 3 + 2]);
>>> +	}
>>
>> same here.
>>
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void set_fourzone_brightness(struct led_classdev *led_cdev, enum led_brightness brightness)
>>> +{
>>> +	size_t zone;
>>> +
>>> +	for (size_t i = 0; i < 4; i++)
>>> +		if (strcmp(led_cdev->name, fourzone_zone_names[i]) == 0)
>>> +			zone = i;
>>> +
>>
>> So the way how the multicolor LED class devices work is that they have 2
>> brightness controls:
>>
>> /sys/class/leds/hp:rgb:kbd_zoned_backlight-right/brightness 
>> /sys/class/leds/hp:rgb:kbd_zoned_backlight-right/multi_intensity
>>
>> Where brightness is a single integer value for overall brightness
>> control and multi_intensity is a per channel brightness control, also see
>> Documentation/leds/leds-class-multicolor.rst
>>
>> Now most hw does not have a main/overall brightness control only
>> per channel controls (like this hp code) so there is a helper which
>> you pass the overall brightness value and which then calculates the
>> per channel brightnesses for you.
> 
> This keyboard uses the Fn + key combo more like a mode switcher where it puts
> the kbd backligh in on/off mode.
> 
> What i was doing was taking the overall brightness and using it as a mode controller
> where it would take only 2 value 1/0 for on/off respectively and propagate the values
> to the other zones to avoid some edge case problems.
> 
> If i start using the overall brightness control to control the brightness of each
> channel (like it should probably be) then i loose the ability to control the modes
> and we would need to find a way to control them.
> 
> But i would definitely agree that having mode control and brightness control at the same
> time would be better.
> 
> Please note that brightness/color control is completely independent from mode control in
> this keyboard. I can set any brightness/color to it even if the backligh is off (it will not
> turn the backlight on) and when turned on, the new color will be there.
> 
> Perhaps we can create a sysfs entry to control the mode and use the main/overall brightness
> control the way it was intended?

So basically we have 1 on/off toggle for the entire keyboard and 12 rgb channels
as controls.

So my suggestion would be to do as I proposed previously which is to use
the standard multi-color LED model / helpers with an overall brightness value
per zone and multi_intensity with 3 values for the R / G / B ratio and then
set the global on/off toggle to off if all 4 main brightness values are
set to off (to zero).

So then the brightness_set() callback function should do something like this:

#define KBD_ZONE_COUNT 4

struct hp_fourzone_led {
 	struct led_classdev_mc mc_led;
 	struct mc_subled subleds[3];
	/*
	 * This stores the last set brightness level to restore it on off->on toggle
	 * by the FN-key combo.
	 */
 	enum led_brightness brightness;
};

static void set_fourzone_brightness(struct led_classdev *led_cdev, enum led_brightness brightness)
{
	u8 buff[4] = { };
	int i, zone = 0;
	bool on = false;

	for (i = 0; i < KBD_ZONE_COUNT; i++)
		if (strcmp(led_cdev->name, fourzone_zone_names[i]) == 0)
			zone = i;

	/* Always update main and per color brightness values even when the backlight is off */
	fourzone_leds[zone].brightness = brightness;
	fourzone_leds[zone].mc_led.led_cdev.brightness = brightness;
	led_mc_calc_color_components(&fourzone_leds[zone].mc_led, brightness);

	/* Update the RGB channels for the current zone */
	/* This should use a new version of fourzone_set_colors() which sends
           the fourzone_leds[zone].subleds[0 - 2].brightness to the kbd */
	fourzone_set_colors(zone);

	for (i = 0; i < KBD_ZONE_COUNT; i++)
		if (fourzone_leds[i].mc_led.led_cdev.brightness)
			on = true;

	buff[0] = on ? FOURZONE_LIGHTING_ON : FOURZONE_LIGHTING_OFF;	
	hp_wmi_perform_query(HPWMI_LED_BRIGHTNESS_SET, HPWMI_FOURZONE, &buff, sizeof(buff), 0);
}

Admittedly this is the easier part. The harder part is what to do on
brightness_get() I would not implement a brightness_get() callback, since
that then will be called every time userspace reads the brightness. Since
there is an event when the brightness is changed underneath us by the hw
we don't need to poll the hw. By leaving out the brightness_get() callback
we get to control when we read back the info from the hw.

So instead of implementing a brightness_get() callback, there should be
a helper to get the state of the global on/off toggle and use this in
probe() to set initial brightness values.

Also the actual brightness level (without the on/off toggle taking into
account) should now become an extra member of struct hp_fourzone_led
replacing the old cache this should always represent the latest brightness
value set by either probe() or userspace calling set_brightness() even if
the toggle is off (I already added this above).

And then on events that the Fn-key combo is used, call the helper to get
the new state.

If the new state is off, set fourzone_leds[0-3].mc_led.led_cdev.brightness
to 0 for all 4 zones *before* calling
led_classdev_notify_brightness_hw_changed(), so that when userspace reads
/sys/class/leds/hp:rgb:kbd_zoned_backlight-<zone>/brightness it will read 0.

If the new state is on, restore the old brightness levels saved in
fourzone_leds[i].brightness to fourzone_leds[i].mc_led.led_cdev.brightness
*before* calling led_classdev_notify_brightness_hw_changed().

This way we correctly reflect the on/off toggle state to userspace, making
/sys/class/leds/hp:rgb:kbd_zoned_backlight-<zone>/brightness read 0 when
it is off, while otherwise making things behave as standard multi-color
LED class devices.

> Now that i think about it, what i made was kinda of a mess :/

No worries, that is what the review process is for :)

Regards,

Hans


