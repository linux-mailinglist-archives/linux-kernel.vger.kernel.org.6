Return-Path: <linux-kernel+bounces-250926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3301992FEB1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D0C2817EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B84176251;
	Fri, 12 Jul 2024 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7zeoddQ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7681DFD2;
	Fri, 12 Jul 2024 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802380; cv=none; b=s0Z2ykR986PEK6cCBGw9wP8OH21FVJ4gQwjIdz3Elqby6BDQrFTkLiiIbUij5WA4H8gkJqpK+moNWCaKkYOBu3GgBrGuBwDS3wzGXjB/qiw4Zvcoc94Stx12tcXDTsV7xF0a1NYQNTku4Nc0HG4w5bYoMHVVchU9kN5p7UnFpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802380; c=relaxed/simple;
	bh=G5puJuKuRaJm2D1cB+ael30lvU8A5OpCylqhYYnq37U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCqPPqynr4ZpbMi6n3ABhsaME4FPqFv5tLFv5zvXNNTSiFLvKL7xtKppyXBuk0pJ4NaTW2sOhIry9lD21Q4ik3kldKx4FHb3b/ddWt/HftPBT6w0908c+4vDuUhoIIfJOwRgH3PpC/A2yO6JnOydvCb5b46vNd96XbaOKmszoX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7zeoddQ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e976208f8so2496416e87.2;
        Fri, 12 Jul 2024 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720802376; x=1721407176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOpbGyVLqaGq8jhBGgoO8+NnEF+xpfqQWpQfuyFQz2c=;
        b=I7zeoddQ0UZFMJ9TSnP/KjEyqn0ilIYo6letGkQ4ExWp7wLHAVJ3bgnQv5XoNN7Pu+
         5Ktx1RZoMPFoLnZORrfD2G5EefJHpYdVycJ/ud1u5VWzfGxSnEr1Owbm+KDZYCdnoQWt
         hB2EyHf2sKCdSlFp6z3F5HlwY7UaP7jspydCBDPYArHaP5aqqK4Vr0hKLTjaZ4uQgN/S
         5njpEvDl9RPcBCzUQYG+TxGxXFljVEZCKMEJ4+j+RIOh9t54I890DuHZHAVbYCp2dAQE
         RKtH+3KoLMyaCmKhTUBDCeGPZqXiEXdFDbiNbWGrz9UF8raXvBQ+xpQi5+h2GSzUPSF+
         MUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720802376; x=1721407176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOpbGyVLqaGq8jhBGgoO8+NnEF+xpfqQWpQfuyFQz2c=;
        b=Avkf1wivMrAKJiNB+cT/p0m89CMUOmj4rX5ShJeaxMpHIXka/jZNk+7CQIMpOxI6d0
         v+4iaBei9yRnk2gkYo3bowjeQDoV/5a//Qv8ukPekb2W6U1/kPlYFpMGwpKdcxTGz/ux
         UqamnHSZBgqaRUPvPc2TqhETpo+Zt4pvgsDube258WzrrJnI1CnXnAhZJIhruQWJa+cm
         HXZeXDt4a3bufl/cOokH6mBPiMYEYs3yohLWePfFlteoIqZDnNqZeB6DWWES9oVrny1X
         BS3iZGlgX8zTtUkcxBW2J5dK5p6S9xIQkvHi6BZF5i8VJhtCaxfEI20Nv+0YnAaoGmw7
         WbNg==
X-Forwarded-Encrypted: i=1; AJvYcCVFmLER64yV02GqElwZN9sXSsnSI7iiflLT/XWlNQJGT8W2oZjCfJLfQy1XXw/dwhjvwYaj/Wd8pnItNsxTcIv+Ohjm2iNBmjdpCMj5BB+Og1qICVUx9VZqobGCBvCtUaT+Gt471AmKt20J7Z+r2h5Czg==
X-Gm-Message-State: AOJu0YxS3N0cPRVSg58ItrJsMYpJ36YQvUAj6kuvHKf5S6lfy5m39Cb/
	oo9jDpKqjBnbpWyxA4YXpPwWvyE9R3zFwfE4c9H7805PjBZoqRZn
X-Google-Smtp-Source: AGHT+IEC1m6sWSxrD79zBY6SufhDi2GfdklN8a+z/UzjFaddYthz+9cQBg3G8rohZ1DFqsWPKaCRYg==
X-Received: by 2002:a05:6512:402a:b0:52e:91ff:4709 with SMTP id 2adb3069b0e04-52eb9994adfmr9796199e87.21.1720802376095;
        Fri, 12 Jul 2024 09:39:36 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:ed72:2800:17de:b512:9f9e:464b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2d7c9csm28345275e9.48.2024.07.12.09.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:39:35 -0700 (PDT)
From: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
To: hdegoede@redhat.com
Cc: carlosmiguelferreira.2003@gmail.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 1/1] HP: wmi: added support for 4 zone keyboard rgb
Date: Fri, 12 Jul 2024 17:39:25 +0100
Message-ID: <20240712163925.15381-1-carlosmiguelferreira.2003@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <acbdb469-f6a4-4180-9d68-9724b3ffe9e2@redhat.com>
References: <acbdb469-f6a4-4180-9d68-9724b3ffe9e2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> >  drivers/platform/x86/hp/hp-wmi.c | 248 +++++++++++++++++++++++++++++--
> >  1 file changed, 239 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> > index 5fa553023842..5eae47961f76 100644
> > --- a/drivers/platform/x86/hp/hp-wmi.c
> > +++ b/drivers/platform/x86/hp/hp-wmi.c
> > @@ -14,6 +14,8 @@
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >  
> >  #include <linux/kernel.h>
> > +#include <linux/led-class-multicolor.h>
> > +#include <linux/leds.h>
> 
> This means that you now also need to update Kconfig to depend on
> LEDS_CLASS_MULTICOLOR, so add the following line to the existing
> Kconfig entry for the HP WMI driver:
> 
> 	depends on LEDS_CLASS_MULTICOLOR
> 
> Adding this should fix the following errors reported by
> the kernel test robot:
> 
> ERROR: modpost: "devm_led_classdev_multicolor_unregister" [drivers/platform/x86/hp/hp-wmi.ko] undefined!
> ERROR: modpost: "devm_led_classdev_multicolor_register_ext" [drivers/platform/x86/hp/hp-wmi.ko] undefined!

Yes, i completely forgot that. Thank you.

> > +static const char * const fourzone_zone_names[4] = {
> > +	"hp:rgb:kbd_zoned_backlight-right",
> > +	"hp:rgb:kbd_zoned_backlight-middle",
> > +	"hp:rgb:kbd_zoned_backlight-left",
> > +	"hp:rgb:kbd_zoned_backlight-wasd"
> > +};
> > +
> > +struct hp_fourzone_leds {
> > +	struct led_classdev_mc leds[4];
> > +	struct mc_subled subleds[4];
> 
> The idea with the multi-color API and subleds is that
> a RGB LED really are 3 seperate LEDs (R + G + B) in one.
> This is alsohow they are actually phyiscally made.
> So for 4 zones you need 12 subleds.
> 
> I think it would be best to to have a single struct per zone:
> 
> struct hp_fourzone_led {
> 	struct led_classdev_mc mc_led;
> 	struct mc_subled subleds[3];
> 	u32 cache; /* Not sure if you still want this */
> };
> 
> And then declare an array of 4 of these:
> 
> static struct hp_fourzone_led hp_fourzone_leds[4];

That makes sense, i will do it like that.

> > +	u32 color_cache[4];
> > +};
> > +static struct hp_fourzone_leds fourzone_leds;
> > +
> > +static enum led_brightness get_fourzone_brightness(struct led_classdev *led_cdev)
> > +{
> > +	u8 buff[4];
> > +
> > +	hp_wmi_perform_query(HPWMI_LED_BRIGHTNESS_GET, HPWMI_FOURZONE,
> > +		&buff, sizeof(buff), sizeof(buff));
> > +
> > +	return buff[0] == FOURZONE_LIGHTING_ON ? LED_ON : LED_OFF;
> > +}
> > +
> > +static void fourzone_update_brightness(void)
> > +{
> > +	unsigned int br;
> > +
> > +	/* synchronize the brightness level on all zones */
> > +	br = get_fourzone_brightness(NULL);
> > +	for (size_t i = 0; i < 4; i++)
> > +		fourzone_leds.leds[i].led_cdev.brightness = br;
> > +}
> > +
> >  static void hp_wmi_notify(u32 value, void *context)
> >  {
> >  	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
> > @@ -932,6 +996,14 @@ static void hp_wmi_notify(u32 value, void *context)
> >  	case HPWMI_PROXIMITY_SENSOR:
> >  		break;
> >  	case HPWMI_BACKLIT_KB_BRIGHTNESS:
> > +		if (fourzone_lightning_support) {
> > +			input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, true);
> > +			input_sync(hp_wmi_input_dev);
> > +			input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, false);
> > +			input_sync(hp_wmi_input_dev);
> > +
> > +			fourzone_update_brightness();
> 
> Does you calling fourzone_update_brightness() here mean that the embedded
> controller (EC) if the laptop toggles the kbd backlight on/off itself when
> you press the Fn + key combo for this on the kbd ? In that case you

It switches between the on/off modes.
More about this below.

> should not be sending a KEY_KBDILLUMTOGGLE key press event. That event
> is telling userspace that it should toggle the brightness, which you
> should only do if this is not done by the EC itself.

Is there a way i could do this that i still get this nice indication on the
screen that the key was pressed?

For me it would make sense to tell the user that the brightness key was pressed.

> If the EC does indeed toggle the brightness on/off (or even cycles it
> between various brightness levels) then the right thing to do is to
> call led_classdev_notify_brightness_hw_changed() on mc_led.led_cdev for
> each of the 4 zones when receiving this event.

For this to work properly, it would depend on how we manage the brightness.
More about this below.

> > +		}
> >  		break;
> >  	case HPWMI_PEAKSHIFT_PERIOD:
> >  		break;
> > @@ -1505,6 +1577,154 @@ static int thermal_profile_setup(void)
> >  	return 0;
> >  }
> >  
> > +static int fourzone_set_colors(u32 color, size_t zone)
> > +{
> > +	u8 buff[128];
> > +	int ret;
> > +
> > +	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
> > +		&buff, sizeof(buff), sizeof(buff));
> > +	if (ret != 0)
> > +		return -EINVAL;
> 
> You are doing a read + modify + write of the kbd settings here.
> 
> This is fine, but to avoid racing against another r/m/w cycle
> done at the same time if userspace writes 2 zones at the same
> time you need to take a mutex here.

I agree with you and Ilpo, this should have a mutex.

> > +
> > +	buff[25 + zone * 3]     = FIELD_GET(FOURZONE_COLOR_R, color);
> > +	buff[25 + zone * 3 + 1] = FIELD_GET(FOURZONE_COLOR_G, color);
> > +	buff[25 + zone * 3 + 2] = FIELD_GET(FOURZONE_COLOR_B, color);
> 
> As mentioned above this is wrong. You should have a separate mc_subled
> struct for each color for each zone (so 3 mc_subled-s per zone,
> one for each of R, G and B; and the you take subled.brightness field
> from the 3 subleds for the 3 different values.
> 
> > +
> > +	return hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_SET, HPWMI_FOURZONE,
> > +		&buff, sizeof(buff), sizeof(buff));
> > +}
> > +
> > +static int fourzone_get_colors(u32 *colors)
> > +{
> > +	u8 buff[128];
> > +	int ret;
> > +
> > +	ret = hp_wmi_perform_query(HPWMI_FOURZONE_COLOR_GET, HPWMI_FOURZONE,
> > +		&buff, sizeof(buff), sizeof(buff));
> > +	if (ret != 0)
> > +		return -EINVAL;
> > +
> > +	for (int i = 0; i < 4; i++) {
> > +		colors[i] = FIELD_PREP(FOURZONE_COLOR_R, buff[25 + i * 3])
> > +			  | FIELD_PREP(FOURZONE_COLOR_G, buff[25 + i * 3 + 1])
> > +			  | FIELD_PREP(FOURZONE_COLOR_B, buff[25 + i * 3 + 2]);
> > +	}
> 
> same here.
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static void set_fourzone_brightness(struct led_classdev *led_cdev, enum led_brightness brightness)
> > +{
> > +	size_t zone;
> > +
> > +	for (size_t i = 0; i < 4; i++)
> > +		if (strcmp(led_cdev->name, fourzone_zone_names[i]) == 0)
> > +			zone = i;
> > +
> 
> So the way how the multicolor LED class devices work is that they have 2
> brightness controls:
> 
> /sys/class/leds/hp:rgb:kbd_zoned_backlight-right/brightness 
> /sys/class/leds/hp:rgb:kbd_zoned_backlight-right/multi_intensity
> 
> Where brightness is a single integer value for overall brightness
> control and multi_intensity is a per channel brightness control, also see
> Documentation/leds/leds-class-multicolor.rst
> 
> Now most hw does not have a main/overall brightness control only
> per channel controls (like this hp code) so there is a helper which
> you pass the overall brightness value and which then calculates the
> per channel brightnesses for you.

This keyboard uses the Fn + key combo more like a mode switcher where it puts
the kbd backligh in on/off mode.

What i was doing was taking the overall brightness and using it as a mode controller
where it would take only 2 value 1/0 for on/off respectively and propagate the values
to the other zones to avoid some edge case problems.

If i start using the overall brightness control to control the brightness of each
channel (like it should probably be) then i loose the ability to control the modes
and we would need to find a way to control them.

But i would definitely agree that having mode control and brightness control at the same
time would be better.

Please note that brightness/color control is completely independent from mode control in
this keyboard. I can set any brightness/color to it even if the backligh is off (it will not
turn the backligh on) and when turned on, the new color will be there.

Perhaps we can create a sysfs entry to control the mode and use the main/overall brightness
control the way it was intended?

Now that i think about it, what i made was kinda of a mess :/

> The LED core code caches the last multi_intensity values for you
> and there is a helper you can call from the (this) brightness_set()
> callback:
> 
> 	led_mc_calc_color_components(&fourzone_leds[i].mc_led, brightness);
> 
> which will then update the fourzone_leds[i].subleds[0 - 2].brightness
> values with the desired per channel brightness values and then you can
> use those 3 brightness values in fourzone_set_colors() to send to
> the keyboard.

Again, this would depend on how we make brightness and mode control.

> > +	if (fourzone_leds.leds[zone].subled_info->intensity == fourzone_leds.color_cache[zone]) {
> > +		u8 buff[4] = {
> > +			brightness == LED_ON ? FOURZONE_LIGHTING_ON : FOURZONE_LIGHTING_OFF,
> > +			0, 0, 0
> > +		};
> > +
> > +		hp_wmi_perform_query(HPWMI_LED_BRIGHTNESS_SET, HPWMI_FOURZONE, &buff,
> > +			sizeof(buff), 0);
> > +
> > +		fourzone_update_brightness();
> > +	} else {
> > +		fourzone_set_colors(fourzone_leds.leds[zone].subled_info->intensity, zone);
> > +		fourzone_leds.color_cache[zone] = fourzone_leds.leds[zone].subled_info->intensity;
> > +	}
> 
> And this weird cahce thing can be removed then too, just always send the newly calculated
> 3 brightness values to the kbd.

It is weird indeed but it was used to know if i should change the color or the keyboard mode.

So when the color didn't change between calls, i would take the overall brightness and
change the mode from it. Obviously, this means loosing brightness control but the way
i see it, mode control is more important.

> > @@ -1561,6 +1785,12 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
> >  
> >  	if (platform_profile_support)
> >  		platform_profile_remove();
> > +
> > +	if (fourzone_lightning_support)
> > +		for (size_t i = 0; i < 4; i++) {
> > +			devm_led_classdev_multicolor_unregister(&device->dev,
> > +				&fourzone_leds.leds[i]);
> > +		}
> 
> The whole idea behind devm_register_foo() functions is that they get automatically
> removed when the driver is unbound from the device. So this code and
> the fourzone_lightning_support flag are not necessary.

That is good to know. I will remove it.

