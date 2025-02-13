Return-Path: <linux-kernel+bounces-513020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A40EA340A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD647A3489
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6530424BBEC;
	Thu, 13 Feb 2025 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2Cro1OI"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AD224BBE3;
	Thu, 13 Feb 2025 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454230; cv=none; b=lHtwvUGUoGyCGoTqB36rJPtgnrP+qGWxhcBtOv26IDfuUkcyJwt5ThaGHoBRvqms6M1m5ULKCKJD+NHCskHWx7yLmlmM2jQgl7w5pZAtWgvrydGjYf309WqBUFb9lDNhwGd+QDyleMjyckQMAzq5pTFSS5RUJ6gkJfVE40ggQhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454230; c=relaxed/simple;
	bh=Itr9Cv1Wx+DacER/nA23ie9jPZ9z5sxaPl6z3h35JKs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Nd/B23UlGRk6rHPRliqdORkmm1KJS6QtttwbxGa9yJhN+WPm1Shx/YlvsonRSir/PIf8fDWKq2LzdXCmVPzPnEevaXEq+pFjb6SlWGE5r2GvWmsL54uNn+A2nPLwcZIATlfwTpkMPwpqLB+M5tFS+jeaUO8hp0rMAqZ0D/BseD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2Cro1OI; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4bbbaa03b0aso236059137.3;
        Thu, 13 Feb 2025 05:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739454227; x=1740059027; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnCnjlmh9rMDpdshMugXtmbaL4Nr6ccJIHH1ZAQX+vw=;
        b=c2Cro1OIxy0D0P1gUnhXYKeAKk459gPg5nQu/WQlZYWeXMOsnECWwpBPfn7nins8+6
         VZ9lIFoehiaLse9XufkSbuSlB5mCGmHXyyr9s//KW1UhVRBdXO+VNz2DfTQmaw8dXcsn
         FMlnRMoQ4+YZN15EDe8qYW8QzCd5tyIUO3VkZ6RbacYCv/ZO+rtra2y02A3P1D1s5va6
         GaBAgZRURVHLkLJ3DASrtOtYwJQh4lBQSrUw1FW1CgYLFIC5NpQ8PAldaeZbFAn3yl/t
         +jnajDIftFbsYcvJh/PNnmRTKoN4ATFyyJ10nVZqijzjr5LURIVzhkG2ZuxigCTGe266
         1Oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739454227; x=1740059027;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WnCnjlmh9rMDpdshMugXtmbaL4Nr6ccJIHH1ZAQX+vw=;
        b=eQ3+iyJEDcaa5BJCEVvQTNjmwVDwUX2kSw9euL2U5q8BrzehixaUlhjUbVwFIMAsUs
         Y3xETTcl4smB0PbVBi7n8YNbzij2BbSQDvKNkFMMV9otXlyJEt/bX+V02xMs+INd+vdU
         RHGCTORv9+A2iaHL4kRnYpTT8JCq5r1/5NzmK5sv1Je1ESmFcNIOxI1QWqiIECew1D+Z
         ZYPupAurdpjJCms3yYwgJoBep2NuYYksunWS6kMSPryl6txlhL1+6W4rWPcCQHfdMCzc
         wBF1HJTnj6hmzGxvHj7CDpz6NU1qgSBwty/32vZUiODHglRZJZlX8toRB2axqGEpgCg3
         MVZA==
X-Forwarded-Encrypted: i=1; AJvYcCWzCpTg/Dds+uXNky+tzRySEUjPE7bjNL7Z6jusv7STfGgBcZ0ZuPySGrizRbCuTA6K4FgCZcCQUzDzQE5qG/oSsOjn@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4SEEhkLBs5sSivSBhNHmN5SDZeeybLZCxy9JAuPwaM32qkaY
	BVvx+Jtjhd3dN7WF5p68JkjD7w1FQwK+64VjAObnytEpunCde+E8
X-Gm-Gg: ASbGncuCWWUP42RKZb0W6Y50EEBhNhnfEEJCg1X9zGehD0X4Mpm3vISzw5tjTBI/OI0
	YvehXKbWyQwXWzLI3UdicTyLBcyeQpU/zFSguBSs12kCEDOoHxfzSSuwoomtnlzCKyhsmH2Hd37
	zZ/n7dA0943FSBhvYonuDA7wsho+hFSpyR9l6MipIiq9U4dH48Kl9bqezKkhuXBboNrMipOVclH
	Tq1mavrwhyDaNP5mHEdAuq7b8dLbcmWFDLTAbIycrcv4lQlayrZxevyYrNyPiU8GRJUr3V2mQfH
	1zkX/J8=
X-Google-Smtp-Source: AGHT+IGK71Hg7kYLwWRMUP5IKBLJLcZ4KjVo2RvsYIIedt/e/ARAz327F3GkSIemy4M3Vb4dn8rmTg==
X-Received: by 2002:a05:6102:304c:b0:4af:fca2:1b7 with SMTP id ada2fe7eead31-4bbf223d5e1mr5505752137.14.1739454226540;
        Thu, 13 Feb 2025 05:43:46 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:4207:a956:ebad:2a64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e8546cd0sm192298241.6.2025.02.13.05.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 05:43:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Feb 2025 08:43:43 -0500
Message-Id: <D7RD26POOF0C.1P0CGJQ7YSQJT@gmail.com>
To: "Jackie Dong" <xy-jackie@139.com>, <hdegoede@redhat.com>,
 <ilpo.jarvinen@linux.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <dongeg1@lenovo.com>, "Mark Pearson" <mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH v5] platform/x86: lenovo-super-hotkey-wmi.c: Support
 formic and audio mute LEDs
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250212070154.5333-1-xy-jackie@139.com>
 <D7QNJ79F513X.FYQCGSC9M3KG@gmail.com>
 <edc9efc7-e96b-44cc-98c6-48eabb53b83c@139.com>
In-Reply-To: <edc9efc7-e96b-44cc-98c6-48eabb53b83c@139.com>

On Thu Feb 13, 2025 at 4:32 AM -05, Jackie Dong wrote:
> Hi Kurt,
>     Thanks for your careful review and new comments which are helpful=20
> for me to understand maintainers ideas, pls review my comments as below.
>     I'll submit a new revison of the patch after get your feedback.
> On 2/13/25 01:43, Kurt Borja wrote:
>> Hi Jackie,
>>=20
>> I left some style recommendations below and a couple questions. I
>> apologize for not including this in the last review.
>>=20
>> On Wed Feb 12, 2025 at 2:01 AM -05, Jackie Dong wrote:
>>> Implement Lenovo utility data WMI calls needed to make LEDs
>>> work on Ideapads that support this GUID.
>>> This enables the mic and audio LEDs to be updated correctly.
>>>
>>> Tested on below samples.
>>> ThinkBook 13X Gen4 IMH
>>> ThinkBook 14 G6 ABP
>>> ThinkBook 16p Gen4-21J8
>>> ThinkBook 16 G8 IRL
>>> ThinkBook 16 G7+ ASP
>>>
>>> Signed-off-by: Jackie Dong <xy-jackie@139.com>
>>> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> ---
>>> Changes in v5:
>>>   - Take out union acpi_object *obj __free(kfree) =3D output.pointer fr=
om
>>>     if-else block
>>>   - Remove lsk_wmi_context_lud_keys related source code
>>>
>>> Changes in v4:
>>>   - Add related head files include cleanup.h, dev_printk.h, device.h,
>>>     module.h
>>>   - Replaced kfree() by __free()
>>>   - Remove double free for obj
>>>   - Remove wpriv->cdev[led_type].dev =3D dev
>>>   - Remove *wpriv =3D *(const struct lenovo_super_hotkey_wmi_private *)=
context
>>>   - Remove wpriv->event =3D=3D LSH_WMI_EVENT_LUD_KEYS
>>>   - Remove lenovo_super_hotkey_wmi_remove() for unnecessary
>>>
>>> Changes in v3:
>>>   - Changed the name of the Kconfig entry to LENOVO_SUPER_HOTKEY_WMI
>>>   - Renamed everything in this driver which contains the name "ideapad"
>>>     to instead contain the name of this driver.
>>>   - Moved struct wmi_device *led_wdev in lenovo_super_hotkey_wmi_privat=
e,
>>>     and use container_of() to the led_wdev pointer.
>>>   - Replaced sizeof(struct wmi_led_args) by sizeof(led_arg)
>>>   - Added condtions checking for obj && obj->type =3D=3D ACPI_TYPE_INTE=
GER
>>>     and free the ACPI object after get the required value.
>>>   - Removed led_classdev_unregister() after led_reg_failed label, but
>>>     add lenovo_super_hotkey_wmi_remove(struct wmi_device *wdev) to free
>>>     resource.
>>>   - Removed IDEAPAD_WMI_EVENT_FN_KEYS/IDEAPAD_WMI_EVENT_LUD_KEYS relate=
d
>>>     source codes and only keep LUD_WMI_METHOD_GUID.
>>>
>>> Changes in v2:
>>>   - Update code layout and formatting as recommended in review
>>>   - Improved error handling in ideapad_wmi_led_init
>>>   - Separated a WMI driver named lenovo-super-hotkey-wmi.c from
>>>     ideapad-lap.c, it's only for Lenovo Super Hotkey WMI devices.
>>>
>>>   drivers/platform/x86/Kconfig                  |   9 +
>>>   drivers/platform/x86/Makefile                 |   1 +
>>>   .../platform/x86/lenovo-super-hotkey-wmi.c    | 222 +++++++++++++++++=
+
>>>   3 files changed, 232 insertions(+)
>>>   create mode 100644 drivers/platform/x86/lenovo-super-hotkey-wmi.c
>>>
>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
>>> index 0258dd879d64..c1792e8f04e1 100644
>>> --- a/drivers/platform/x86/Kconfig
>>> +++ b/drivers/platform/x86/Kconfig
>>> @@ -475,6 +475,15 @@ config IDEAPAD_LAPTOP
>>>   	  This is a driver for Lenovo IdeaPad netbooks contains drivers for
>>>   	  rfkill switch, hotkey, fan control and backlight control.
>>>  =20
>>> +config LENOVO_SUPER_HOTKEY_WMI
>>> +	tristate "Lenovo Super Hotkey Utility WMI extras driver"
>>> +	depends on ACPI_WMI
>>> +	depends on IDEAPAD_LAPTOP
>>=20
>> Does this still depend on IDEAPAD_LAPTOP? Also add:
>> 	select NEW_LEDS
>> 	select LEDS_CLASS
>>=20
> In my view, keep depend on IDEAPAD, because that mic-mute LED function=20
> doesn't work without ideapad_laptop.ko. Due to KEY_MICMUTE event is=20
> handled in ideapad_laptop. And this file only turn on/off MIC mute LED=20
> after the KEY_MICMUTE pressed. For Audio mute LED, audio mute key is=20
> common handled by keyboard driver, but MIC mute key is special and=20
> handled in ideapad_laptop.ko for Lenovo non-ThinkPad products. Audio=20
> mute and MIC mute function can work when user press related hotkey in=20
> past, only it's mute LED doesn't turn on/off.
> For ThinkPad products, MIC mute key is handled in thinkpad_acpi.

Oh - Thanks, this is important information.

>
> { KE_KEY,       0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } }, in=20
> ideapad_keymap[].
>
> This LENOVO_SUPER_HOTKEY_WMI depends on IDEAPAD_LAPTOP which included=20
> led moudles(NEW_LEDS/LEDS_CLASS) as below. Maybe it shoud be enough.

I'd add them anyway, to be explicit about what this module needs.

>
> config IDEAPAD_LAPTOP
>          tristate "Lenovo IdeaPad Laptop Extras"
>          depends on ACPI
>          depends on RFKILL && INPUT
>          depends on SERIO_I8042
>          depends on BACKLIGHT_CLASS_DEVICE
>          depends on ACPI_VIDEO || ACPI_VIDEO =3D n
>          depends on ACPI_WMI || ACPI_WMI =3D n
>          select ACPI_PLATFORM_PROFILE
>          select INPUT_SPARSEKMAP
>          select NEW_LEDS
>          select LEDS_CLASS
>          help
>            This is a driver for Lenovo IdeaPad netbooks contains drivers =
for
>            rfkill switch, hotkey, fan control and backlight control.
>
>>> +	help
>>> +	  This driver provides WMI support for Lenovo customized hotkeys func=
tion
>>> +	  of Lenovo NoteBooks which are for Consumer and SMB customers, such =
as
>>> +	  Ideapad/YOGA/XiaoXin/Gaming/ThinkBook and so on.
>>=20
>> This driver deals with mute key leds. Is this description right?
> In fact, this driver should handle all lenovo super hotkey functions=20
> which are implemeteled by wmi. Audio mute LED and Mic mute LED are just=
=20
> the two functions of them. The driver will be extented for all lenovo=20
> super hotkey in future. I have to say that different products are with=20
> different hotkey, not all products support all hotkeys function, such as=
=20
> many ThinkBook products without MIC mute LED. Currently,

Interesting.

As this driver doesn't handle the hotkeys directly, may I suggest some
slight rewording? Something like:

"This driver provides WMI support for Lenovo hotkey utilities, such as
LED control for audio/mic mute events for IdeaPad, etc..."

Remember this can be edited as new features are implemented.

>
> Some links are FYR.
> How to use Lenovo Hotkeys on keyboard?
> https://tt-hardware.com/en/pc/how-to-use-lenovo-hotkeys-on-keyboard/
> Lenovo Hotkeys
> https://apps.microsoft.com/detail/9pcmmnb260tx?hl=3Den-us&gl=3DUS
>
> For these Lenovo Hotkeys, ThinkPad series are impelemented by acpi, but=
=20
> some hotkeys of non-ThinkPad products are impelemented by wmi, special=20
> for latest non-ThinkPad products. This is why I write this driver.
>>=20
>>> +
>>>   config LENOVO_YMC
>>>   	tristate "Lenovo Yoga Tablet Mode Control"
>>>   	depends on ACPI_WMI
>>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
>>> index e1b142947067..598335da9f55 100644
>>> --- a/drivers/platform/x86/Makefile
>>> +++ b/drivers/platform/x86/Makefile
>>> @@ -61,6 +61,7 @@ obj-$(CONFIG_UV_SYSFS)       +=3D uv_sysfs.o
>>>   # IBM Thinkpad and Lenovo
>>>   obj-$(CONFIG_IBM_RTL)		+=3D ibm_rtl.o
>>>   obj-$(CONFIG_IDEAPAD_LAPTOP)	+=3D ideapad-laptop.o
>>> +obj-$(CONFIG_LENOVO_SUPER_HOTKEY_WMI)	+=3D lenovo-super-hotkey-wmi.o
>>>   obj-$(CONFIG_LENOVO_YMC)	+=3D lenovo-ymc.o
>>>   obj-$(CONFIG_SENSORS_HDAPS)	+=3D hdaps.o
>>>   obj-$(CONFIG_THINKPAD_ACPI)	+=3D thinkpad_acpi.o
>>> diff --git a/drivers/platform/x86/lenovo-super-hotkey-wmi.c b/drivers/p=
latform/x86/lenovo-super-hotkey-wmi.c
>>=20
>> This name doesn't tell me a lot about the features of this driver. Is
>> this the internal name of the WMI device?
> Reference previous comment.
> If you have a better proposal, let me know.

I propose lenovo-wmi-hotkey-utilities.c.

Let me know what you think about the description and name proposals.

>>=20
>>> new file mode 100644
>>> index 000000000000..86c3dc2009b8
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/lenovo-super-hotkey-wmi.c
>>> @@ -0,0 +1,222 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + *  Lenovo Super Hotkey Utility WMI extras driver for Ideapad laptop
>>> + *
>>> + *  Copyright (C) 2025	Lenovo
>>> + */
>>> +
>>> +#include <linux/cleanup.h>
>>> +#include <linux/dev_printk.h>
>>> +#include <linux/device.h>
>>> +#include <linux/leds.h>
>>> +#include <linux/module.h>
>>> +#include <linux/wmi.h>
>>> +
>>> +/* Lenovo Super Hotkey WMI GUIDs */
>>> +#define LUD_WMI_METHOD_GUID	"CE6C0974-0407-4F50-88BA-4FC3B6559AD8"
>>> +
>>> +/* Lenovo Utility Data WMI method_id */
>>> +#define WMI_LUD_GET_SUPPORT 1
>>> +#define WMI_LUD_SET_FEATURE 2
>>> +
>>> +#define WMI_LUD_GET_MICMUTE_LED_VER   20
>>> +#define WMI_LUD_GET_AUDIOMUTE_LED_VER 26
>>> +
>>> +#define WMI_LUD_SUPPORT_MICMUTE_LED_VER   25
>>> +#define WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER 27
>>> +
>>> +/* Input parameters to mute/unmute audio LED and Mic LED */
>>> +struct wmi_led_args {
>>> +	u8 id;
>>> +	u8 subid;
>>> +	u16 value;
>>> +};
>>> +
>>> +/* Values of input parameters to SetFeature of audio LED and Mic LED *=
/
>>> +enum hotkey_set_feature {
>>> +	MIC_MUTE_LED_ON =3D 1,
>>> +	MIC_MUTE_LED_OFF,
>>> +	AUDIO_MUTE_LED_ON =3D 4,
>>=20
>> Please align this values.
> For this comment, I understand it should be as below. If my=20
> understanding is insufficient,pls give me a sample to update it.
>
> +enum hotkey_set_feature {
> +       MIC_MUTE_LED_ON   =3D 1,
> +       MIC_MUTE_LED_OFF,
> +       AUDIO_MUTE_LED_ON =3D 4,
> +       AUDIO_MUTE_LED_OFF,

I'd go for:

	MIC_MUTE_LED_ON		=3D 1,
	MIC_MUTE_LED_ON		=3D 2,
	AUDIO_MUTE_LED_ON	=3D 4,
	AUDIO_MUTE_LED_OFF	=3D 5,

To be more explicit.

>
>
>>=20
>>> +	AUDIO_MUTE_LED_OFF,
>>> +};
>>> +
>>> +#define LSH_ACPI_LED_MAX 2
>>> +
>>> +struct lenovo_super_hotkey_wmi_private {
>>> +	struct led_classdev cdev[LSH_ACPI_LED_MAX];
>>> +	struct wmi_device *led_wdev;
>>> +};
>>> +
>>> +enum mute_led_type {
>>> +	MIC_MUTE,
>>> +	AUDIO_MUTE,
>>> +};
>>> +
>>> +static int lsh_wmi_mute_led_set(enum mute_led_type led_type, struct le=
d_classdev *led_cdev,
>>> +				enum led_brightness brightness)
>>> +
>>> +{
>>> +	struct lenovo_super_hotkey_wmi_private *wpriv =3D container_of(led_cd=
ev,
>>> +			struct lenovo_super_hotkey_wmi_private, cdev[led_type]);
>>> +	struct wmi_led_args led_arg =3D {0, 0, 0};
>>> +	struct acpi_buffer input;
>>> +	acpi_status status;
>>> +
>>> +	switch (led_type) {
>>> +	case MIC_MUTE:
>>> +		led_arg.id =3D brightness =3D=3D LED_ON ? MIC_MUTE_LED_ON : MIC_MUTE=
_LED_OFF;
>>> +		break;
>>> +	case AUDIO_MUTE:
>>> +		led_arg.id =3D brightness =3D=3D LED_ON ? AUDIO_MUTE_LED_ON : AUDIO_=
MUTE_LED_OFF;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	input.length =3D sizeof(led_arg);
>>> +	input.pointer =3D &led_arg;
>>> +	status =3D wmidev_evaluate_method(wpriv->led_wdev, 0, WMI_LUD_SET_FEA=
TURE, &input, NULL);
>>> +	if (ACPI_FAILURE(status))
>>> +		return -EIO;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int lsh_wmi_audiomute_led_set(struct led_classdev *led_cdev,
>>> +				     enum led_brightness brightness)
>>> +
>>> +{
>>> +	return lsh_wmi_mute_led_set(AUDIO_MUTE, led_cdev, brightness);
>>> +}
>>> +
>>> +static int lsh_wmi_micmute_led_set(struct led_classdev *led_cdev,
>>> +				   enum led_brightness brightness)
>>> +{
>>> +	return lsh_wmi_mute_led_set(MIC_MUTE, led_cdev, brightness);
>>> +}
>>> +
>>> +static int lenovo_super_hotkey_wmi_led_init(enum mute_led_type led_typ=
e, struct device *dev)
>>> +{
>>> +	struct lenovo_super_hotkey_wmi_private *wpriv =3D dev_get_drvdata(dev=
);
>>> +	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
>>> +	struct acpi_buffer input;
>>> +	int led_version, err =3D 0;
>>> +	unsigned int wmiarg;
>>> +	acpi_status status;
>>> +
>>> +	switch (led_type) {
>>> +	case MIC_MUTE:
>>> +		wmiarg =3D WMI_LUD_GET_MICMUTE_LED_VER;
>>> +		break;
>>> +	case AUDIO_MUTE:
>>> +		wmiarg =3D WMI_LUD_GET_AUDIOMUTE_LED_VER;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	input.length =3D sizeof(wmiarg);
>>> +	input.pointer =3D &wmiarg;
>>> +	status =3D wmidev_evaluate_method(wpriv->led_wdev, 0, WMI_LUD_GET_SUP=
PORT, &input, &output);
>>> +	if (ACPI_FAILURE(status))
>>> +		return -EIO;
>>> +
>>> +	union acpi_object *obj __free(kfree) =3D output.pointer;
>>> +	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
>>> +		led_version =3D obj->integer.value;
>>> +	} else {
>>> +		err =3D -EIO;
>>> +		return err;
>>=20
>> Return -EIO directly here and drop the braces on both branches.
>>=20
> OK, will update it next revision.
>>> +	}
>>> +
>>> +	wpriv->cdev[led_type].max_brightness =3D LED_ON;
>>> +	wpriv->cdev[led_type].flags =3D LED_CORE_SUSPENDRESUME;
>>> +
>>> +	switch (led_type) {
>>> +	case MIC_MUTE:
>>> +		if (led_version !=3D WMI_LUD_SUPPORT_MICMUTE_LED_VER) {
>>> +			err =3D -EIO;
>>> +			goto led_error;
>>=20
>> Return -EIO and drop brances.
>>=20
> OK, will update it next revision.
>>> +		}
>>> +		wpriv->cdev[led_type].name =3D "platform::micmute";
>>> +		wpriv->cdev[led_type].brightness_set_blocking =3D &lsh_wmi_micmute_l=
ed_set;
>>> +		wpriv->cdev[led_type].default_trigger =3D "audio-micmute";
>>> +
>>> +		err =3D devm_led_classdev_register(dev, &wpriv->cdev[led_type]);
>>> +		if (err < 0)
>>> +			goto led_reg_failed;
>>> +
>>> +		break;
>>> +	case AUDIO_MUTE:
>>> +		if (led_version !=3D WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER) {
>>> +			err =3D -EIO;
>>> +			goto led_error;
>>=20
>> Return -EIO and drop brances.
>>=20
> OK, will update it next revision.
>>> +		}
>>> +		wpriv->cdev[led_type].name =3D "platform::mute";
>>> +		wpriv->cdev[led_type].brightness_set_blocking =3D &lsh_wmi_audiomute=
_led_set;
>>> +		wpriv->cdev[led_type].default_trigger =3D "audio-mute";
>>> +
>>> +		err =3D devm_led_classdev_register(dev, &wpriv->cdev[led_type]);
>>> +		if (err < 0)
>>> +			goto led_reg_failed;
>>> +
>>> +		break;
>>> +	default:
>>> +		err =3D -EINVAL;
>>> +		dev_err(dev, "Unknown LED type %d\n", led_type);
>>> +		goto led_error;
>>=20
>> Return -EINVAL directly.
>>=20
> OK, will update it next revision.
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +led_reg_failed:
>>> +	dev_err(dev, "Could not register mute LED %d : %d\n", led_type, err);
>>> +
>>> +led_error:
>>> +	return err;
>>> +}
>>> +
>>> +static void lenovo_super_hotkey_wmi_leds_setup(struct device *dev)
>>> +{
>>> +	lenovo_super_hotkey_wmi_led_init(MIC_MUTE, dev);
>>> +	lenovo_super_hotkey_wmi_led_init(AUDIO_MUTE, dev);
>>=20
>> I wonder why you decided not to propagate errors of this calls. Maybe
>> you are expecting one to fail but not the other?
>>=20
>> If this both fail this module would remain loaded for no reason, so
>> maybe propagate some error in that case.
>>=20
> Oh, it's my fault. I'll update related source code as below.
>
> static int lenovo_super_hotkey_wmi_leds_setup(struct device *dev)
> {
>          int err;
>          err =3D lenovo_super_hotkey_wmi_led_init(MIC_MUTE, dev);
>          if (err)
>                  return err;
>
>          err =3D lenovo_super_hotkey_wmi_led_init(AUDIO_MUTE, dev);
>          if (err)
>                  return err;
>
>          return 0;
> }
>
>>> +}
>>> +
>>> +static int lenovo_super_hotkey_wmi_probe(struct wmi_device *wdev, cons=
t void *context)
>>> +{
>>> +	struct lenovo_super_hotkey_wmi_private *wpriv;
>>> +
>>> +	wpriv =3D devm_kzalloc(&wdev->dev, sizeof(*wpriv), GFP_KERNEL);
>>> +	if (!wpriv)
>>> +		return -ENOMEM;
>>> +
>>> +	dev_set_drvdata(&wdev->dev, wpriv);
>>> +	wpriv->led_wdev =3D wdev;
>>> +	lenovo_super_hotkey_wmi_leds_setup(&wdev->dev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct wmi_device_id lenovo_super_hotkey_wmi_id_table[] =
=3D {
>>> +	{ LUD_WMI_METHOD_GUID, NULL }, /* Utility data */
>>=20
>> Maybe drop this comment.
>>=20
>  From Lenovo Keyboard WMI Specification V3.6, there're 3 WMI GUIDs at=20
> least now. I hope to keep the comment which should be helpful for new=20
> developer of this driver.

Then it's fine IMO.

--=20
 ~ Kurt

>
> [WMI,
> Dynamic,
> Provider("WmiProv"),
> Locale("MS\\0x409"),
> Description("Lenovo Utility Key Press Event"),
> guid("{8fc0de0c-b4e4-43fd-b0f3-8871711c1294}")
> ]
> class LENOVO_UTILITY_EVENT: WMIEvent
> ...
> [WMI,
> Dynamic,
> Provider("WmiProv"),
> Locale("MS\\0x409"),
> Description("LENOVO_UTILITY_DATA class"),
> guid("{ce6c0974-0407-4f50-88ba-4fc3b6559ad8}")
> ]
> class LENOVO_UTILITY_DATA
> ...
> LENOVO_INTERNAL_PANEL_REFRESH_RATE_DATA can
> get panel refresh rate)
> Namespace:L"root\\wmi"
> Class LENOVO_INTERNAL_PANEL_REFRESH_RATE_DATA
> GUID guid("{6260ecad-0d7d-4201-a8bd-2552e812501f}"
>
>> Additionally, please CC me and previous reviewers the next revision.
>>=20
> OK, will do next revision.
>> --
>>   ~ Kurt
>>
>>> +	{ }
>>> +};
>>> +
>>> +MODULE_DEVICE_TABLE(wmi, lenovo_super_hotkey_wmi_id_table);
>>> +
>>> +static struct wmi_driver lenovo_super_hotkey_wmi_driver =3D {
>>> +	 .driver =3D {
>>> +		 .name =3D "lenovo_super_hotkey_wmi",
>>> +		 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS
>>> +	 },
>>> +	 .id_table =3D lenovo_super_hotkey_wmi_id_table,
>>> +	 .probe =3D lenovo_super_hotkey_wmi_probe,
>>> +	 .no_singleton =3D true,
>>> +};
>>> +
>>> +module_wmi_driver(lenovo_super_hotkey_wmi_driver);
>>> +
>>> +MODULE_INFO(depends, "wmi,ideapad-laptop"); MODULE_AUTHOR("Jackie
>>> +Dong <dongeg1@lenovo.com>"); MODULE_DESCRIPTION("Lenovo Super Hotkey
>>> +Utility WMI extras driver"); MODULE_LICENSE("GPL");
>>


