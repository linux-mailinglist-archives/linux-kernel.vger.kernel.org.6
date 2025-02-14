Return-Path: <linux-kernel+bounces-515146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94874A360D1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DED4170972
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A5B266591;
	Fri, 14 Feb 2025 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThF/w5xv"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C0265CA9;
	Fri, 14 Feb 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544878; cv=none; b=ccspdRMpchkuORcCoNWpsUogKO8hIHwFE+UMNq8/mC9y/3LP4nivlWuEwmRSdJmX8T4Qc+sAZtTckQtWFAfLeoFbBRnS7+wDErnteMTzZAkYOaO8KQeAwVnQTMIcm0xU2/SXM75gLVdHCzuIKi+YU02L2mf80NquOD50xQXNERg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544878; c=relaxed/simple;
	bh=xZxFa7pZnLUcJyFStP+cWBQiBzawOpO5AEUW3Tl7WoE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=d/66NY73uRbPbSR0hxLrhCECFrngKtEBwyYDPaeolo5gFzY5ASVCOfSNA4qj3bQHvY2NTTG02S/FpN5o2myKJDMLF+OOC7ysFAdQ25OX5j9YunYRNzRNuYH8GDKWwi0jZUvfLjxwAgAPDqDYlfquCtMnt9KRZcsXMjhEuy9wa8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThF/w5xv; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-868f169bb56so443161241.0;
        Fri, 14 Feb 2025 06:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739544875; x=1740149675; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rq8X9MAntZz1RhQJ7CuFZv/VcSSTdLbUSwJJNVBynkk=;
        b=ThF/w5xvWmTmbRpv8SitemEFwLBWtRRiRwD5PAc3z9oLlsBrcV1iOhBisXN44AXNu8
         2K31WRF9I7DruH0AsvbssBPWuasnDmsMXev1QRdUFTkvzZqdrf0r7fEHyXbDhkl3ljt1
         nTVz6FRi8y/JzecoDEyaPPUUQpYNwVw09wUwce62jJ+/HsWkEjqzvlC4daY6E0i3xQxq
         9B7EqS5m7w83fTz7KXcBMz9l8Y9s+F/1vcJ3ct76tntLdemebJTEM5iRPfNJnpL//HCd
         AzlxzvdxiWj9VS8yfGFuFGY2D6TbOXP3Jd0podcKjSWokFYA7BngAh0UugtUGpyEZIEV
         4xGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739544875; x=1740149675;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rq8X9MAntZz1RhQJ7CuFZv/VcSSTdLbUSwJJNVBynkk=;
        b=eDL1KkF1eBdLYndSm0+uKzkWJ13S6ydvOIe+lVnpTSLbL7olQORvcb6tujyfm+JqxB
         NzqtS/aXTZd9Wace+Aj3PviVRctZrBJn81xv7mNMXUHMgvLF664294oWxHUJ2hyUm4tw
         dEGj5VBDv6ZRr889CeOZHInSj5fS1Xoac73vaJRYpGIzSI6SC1QAdaf72EdaiYMZcCJw
         k+PDVQaVtNaLFTF7rL4IkTzZ/a/X44ZmxBsdW3p371Qnm6sPIrE05NoCYw864iCsEML7
         DLF4g9qlDCjgZsV9O4znK+PLY39Msls9L2lceu37nzBxv4ThyHZekR3vNH1J3PHUY3I/
         +1hA==
X-Forwarded-Encrypted: i=1; AJvYcCWfx+0m3qG+go5FS41rsfdTXO7jIuDUQp9+1hTr6JZ1tXZQh6nLZH4Uw+dd8zaANI/UccE/tO/JPmCNEInDT15g/QLZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywis3hEOgJuUlrmoNuK1k1Xj6hbUXreXDJHsJ6gyUaXES08NUFo
	XVaWYGMikvKsJidme8psGVaEhJthPNhXrxgfPvZKJKSA/loF7rOl
X-Gm-Gg: ASbGncuiKO0sRmmfkdPbiQBUn1FnDJpWK729L7wLcoigbvu7JDEIaOTWIq9D5bSIKY7
	MfU3h+KPte+OujwY4Am+Jrrkoc11BvdQ5hbza+k6FDt5b2fncNkq+5wmGik+ualJCwKEte64sQj
	nCF/4EG4qnpK3UDM6LjQWlBPTrJJ9oKHYxBP1L4AfTUpBGKWz2xggaW4kkMU1ugtbEETXZKAOKj
	4E4QsmG0hspsi5lAkURJt0VpunpyUsGmrWGnqjFk8cO9xEW/Hth03VO/RhF7PKvheew8jpAJDXP
	TO7yYk4=
X-Google-Smtp-Source: AGHT+IHCzybq2pm2L5m3p98y4bXwexxkZNLMA8HsPUUh5Nolg43qBqP31x4Vok4isu9hrX3xwN+qug==
X-Received: by 2002:a05:6102:b14:b0:4b6:d108:cac1 with SMTP id ada2fe7eead31-4bbf21c82bamr10204241137.9.1739544875281;
        Fri, 14 Feb 2025 06:54:35 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e8582628sm626172241.12.2025.02.14.06.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 06:54:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Feb 2025 09:54:32 -0500
Message-Id: <D7S96Y9MGJIY.2ULAIX8G4KNPF@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <W_Armin@gmx.de>, <dongeg1@lenovo.com>, "Mark Pearson"
 <mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH v6] platform/x86:lenovo-wmi-hotkey-utilities
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jackie Dong" <xy-jackie@139.com>, <hdegoede@redhat.com>,
 <ilpo.jarvinen@linux.intel.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250214072347.4297-1-xy-jackie@139.com>
In-Reply-To: <20250214072347.4297-1-xy-jackie@139.com>

Hi Jackie,

On Fri Feb 14, 2025 at 2:23 AM -05, Jackie Dong wrote:
> Implement Lenovo utility data WMI calls needed to make LEDs
> work on Ideapads that support this GUID.
> This enables the mic and audio LEDs to be updated correctly.
>
> Tested on below samples.
> ThinkBook 13X Gen4 IMH
> ThinkBook 14 G6 ABP
> ThinkBook 16p Gen4-21J8
> ThinkBook 16 G8 IRL
> ThinkBook 16 G7+ ASP
>
> Signed-off-by: Jackie Dong <xy-jackie@139.com>
> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>

I noticed this driver lacks a MAINTAINERS entry, could you add one
please?

After addressing that and some last nitpicks bellow:

Reviewed-by: Kurt Borja <kuurtb@gmail.com>

> ---
> Changes in v6:
>  - Rename lenovo-super-hotkey-wmi.c to lenovo-wmi-hotkey-utilities
>  - Update LENOVO_WMI_HOTKEY_UTILITIES item description and add select
>    NEW_LEDS, LEDS_CLASS based on reviewer's suggestion.
>  - Align items in enum hotkey_set_feature=20
>  - Drop some brances and return error message directly
>  - Check return value of lenovo_super_hotkey_wmi_led_init() in=20
>    lenovo_super_hotkey_wmi_leds_setup
>
> Changes in v5:
>  - Take out union acpi_object *obj __free(kfree) =3D output.pointer from
>    if-else block
>  - Remove lsk_wmi_context_lud_keys related source code
>
> Changes in v4:
>  - Add related head files include cleanup.h, dev_printk.h, device.h,
>    module.h
>  - Replaced kfree() by __free()
>  - Remove double free for obj
>  - Remove wpriv->cdev[led_type].dev =3D dev
>  - Remove *wpriv =3D *(const struct lenovo_super_hotkey_wmi_private *)con=
text
>  - Remove wpriv->event =3D=3D LSH_WMI_EVENT_LUD_KEYS
>  - Remove lenovo_super_hotkey_wmi_remove() for unnecessary
> Changes in v3:
>  - Changed the name of the Kconfig entry to LENOVO_SUPER_HOTKEY_WMI
>  - Renamed everything in this driver which contains the name "ideapad"
>    to instead contain the name of this driver.
>  - Moved struct wmi_device *led_wdev in lenovo_super_hotkey_wmi_private,
>    and use container_of() to the led_wdev pointer.
>  - Replaced sizeof(struct wmi_led_args) by sizeof(led_arg)
>  - Added condtions checking for obj && obj->type =3D=3D ACPI_TYPE_INTEGER
>    and free the ACPI object after get the required value.
>  - Removed led_classdev_unregister() after led_reg_failed label, but
>    add lenovo_super_hotkey_wmi_remove(struct wmi_device *wdev) to free
>    resource.
>  - Removed IDEAPAD_WMI_EVENT_FN_KEYS/IDEAPAD_WMI_EVENT_LUD_KEYS related
>    source codes and only keep LUD_WMI_METHOD_GUID.
>
> Changes in v2:
>  - Update code layout and formatting as recommended in review
>  - Improved error handling in ideapad_wmi_led_init
>  - Separated a WMI driver named lenovo-super-hotkey-wmi.c from
>    ideapad-lap.c, it's only for Lenovo Super Hotkey WMI devices.
>
>  drivers/platform/x86/Kconfig                  |  11 +
>  drivers/platform/x86/Makefile                 |   1 +
>  .../x86/lenovo-wmi-hotkey-utilities.c         | 227 ++++++++++++++++++
>  3 files changed, 239 insertions(+)
>  create mode 100644 drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879d64..715bcfbe992f 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -475,6 +475,17 @@ config IDEAPAD_LAPTOP
>  	  This is a driver for Lenovo IdeaPad netbooks contains drivers for
>  	  rfkill switch, hotkey, fan control and backlight control.
> =20
> +config LENOVO_WMI_HOTKEY_UTILITIES
> +	tristate "Lenovo Hotkey Utility WMI extras driver"
> +	depends on ACPI_WMI
> +	depends on IDEAPAD_LAPTOP
> +	select NEW_LEDS
> +	select LEDS_CLASS
> +	help
> +	  This driver provides WMI support for Lenovo customized hotkeys functi=
on,
> +	  such as LED control for audio/mic mute event for Ideapad, YOGA, XiaoX=
in,
> +	  Gaming, ThinkBook and so on.
> +
>  config LENOVO_YMC
>  	tristate "Lenovo Yoga Tablet Mode Control"
>  	depends on ACPI_WMI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index e1b142947067..131fcf974477 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_UV_SYSFS)       +=3D uv_sysfs.o
>  # IBM Thinkpad and Lenovo
>  obj-$(CONFIG_IBM_RTL)		+=3D ibm_rtl.o
>  obj-$(CONFIG_IDEAPAD_LAPTOP)	+=3D ideapad-laptop.o
> +obj-$(CONFIG_LENOVO_WMI_HOTKEY_UTILITIES)	+=3D lenovo-wmi-hotkey-utiliti=
es.o
>  obj-$(CONFIG_LENOVO_YMC)	+=3D lenovo-ymc.o
>  obj-$(CONFIG_SENSORS_HDAPS)	+=3D hdaps.o
>  obj-$(CONFIG_THINKPAD_ACPI)	+=3D thinkpad_acpi.o
> diff --git a/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c b/drivers=
/platform/x86/lenovo-wmi-hotkey-utilities.c
> new file mode 100644
> index 000000000000..e50914a76970
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Lenovo Super Hotkey Utility WMI extras driver for Ideapad laptop
> + *
> + *  Copyright (C) 2025	Lenovo
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +
> +/* Lenovo Super Hotkey WMI GUIDs */
> +#define LUD_WMI_METHOD_GUID	"CE6C0974-0407-4F50-88BA-4FC3B6559AD8"
> +
> +/* Lenovo Utility Data WMI method_id */
> +#define WMI_LUD_GET_SUPPORT 1
> +#define WMI_LUD_SET_FEATURE 2
> +
> +#define WMI_LUD_GET_MICMUTE_LED_VER   20
> +#define WMI_LUD_GET_AUDIOMUTE_LED_VER 26
> +
> +#define WMI_LUD_SUPPORT_MICMUTE_LED_VER   25
> +#define WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER 27
> +
> +/* Input parameters to mute/unmute audio LED and Mic LED */
> +struct wmi_led_args {
> +	u8 id;
> +	u8 subid;
> +	u16 value;
> +};
> +
> +/* Values of input parameters to SetFeature of audio LED and Mic LED */
> +enum hotkey_set_feature {
> +	MIC_MUTE_LED_ON	   =3D 1,
> +	MIC_MUTE_LED_OFF   =3D 2,
> +	AUDIO_MUTE_LED_ON  =3D 4,
> +	AUDIO_MUTE_LED_OFF =3D 5,

We usually align these with tabs like this:

<tab>MIC_MUTE_LED_ON<tab><tab>=3D 1,
...

For each line, without adding spaces before tabs.

> +};
> +
> +#define LSH_ACPI_LED_MAX 2
> +
> +struct lenovo_super_hotkey_wmi_private {
> +	struct led_classdev cdev[LSH_ACPI_LED_MAX];
> +	struct wmi_device *led_wdev;
> +};
> +
> +enum mute_led_type {
> +	MIC_MUTE,
> +	AUDIO_MUTE,
> +};
> +
> +static int lsh_wmi_mute_led_set(enum mute_led_type led_type, struct led_=
classdev *led_cdev,
> +				enum led_brightness brightness)
> +
> +{
> +	struct lenovo_super_hotkey_wmi_private *wpriv =3D container_of(led_cdev=
,
> +			struct lenovo_super_hotkey_wmi_private, cdev[led_type]);
> +	struct wmi_led_args led_arg =3D {0, 0, 0};
> +	struct acpi_buffer input;
> +	acpi_status status;
> +
> +	switch (led_type) {
> +	case MIC_MUTE:
> +		led_arg.id =3D brightness =3D=3D LED_ON ? MIC_MUTE_LED_ON : MIC_MUTE_L=
ED_OFF;
> +		break;
> +	case AUDIO_MUTE:
> +		led_arg.id =3D brightness =3D=3D LED_ON ? AUDIO_MUTE_LED_ON : AUDIO_MU=
TE_LED_OFF;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	input.length =3D sizeof(led_arg);
> +	input.pointer =3D &led_arg;
> +	status =3D wmidev_evaluate_method(wpriv->led_wdev, 0, WMI_LUD_SET_FEATU=
RE, &input, NULL);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int lsh_wmi_audiomute_led_set(struct led_classdev *led_cdev,
> +				     enum led_brightness brightness)
> +
> +{
> +	return lsh_wmi_mute_led_set(AUDIO_MUTE, led_cdev, brightness);
> +}
> +
> +static int lsh_wmi_micmute_led_set(struct led_classdev *led_cdev,
> +				   enum led_brightness brightness)
> +{
> +	return lsh_wmi_mute_led_set(MIC_MUTE, led_cdev, brightness);
> +}
> +
> +static int lenovo_super_hotkey_wmi_led_init(enum mute_led_type led_type,=
 struct device *dev)
> +{
> +	struct lenovo_super_hotkey_wmi_private *wpriv =3D dev_get_drvdata(dev);
> +	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct acpi_buffer input;
> +	int led_version, err =3D 0;
> +	unsigned int wmiarg;
> +	acpi_status status;
> +
> +	switch (led_type) {
> +	case MIC_MUTE:
> +		wmiarg =3D WMI_LUD_GET_MICMUTE_LED_VER;
> +		break;
> +	case AUDIO_MUTE:
> +		wmiarg =3D WMI_LUD_GET_AUDIOMUTE_LED_VER;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	input.length =3D sizeof(wmiarg);
> +	input.pointer =3D &wmiarg;
> +	status =3D wmidev_evaluate_method(wpriv->led_wdev, 0, WMI_LUD_GET_SUPPO=
RT, &input, &output);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	union acpi_object *obj __free(kfree) =3D output.pointer;
> +	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER)
> +		led_version =3D obj->integer.value;
> +	else
> +		return -EIO;
> +
> +	wpriv->cdev[led_type].max_brightness =3D LED_ON;
> +	wpriv->cdev[led_type].flags =3D LED_CORE_SUSPENDRESUME;
> +
> +	switch (led_type) {
> +	case MIC_MUTE:
> +		if (led_version !=3D WMI_LUD_SUPPORT_MICMUTE_LED_VER)
> +			return -EIO;
> +
> +		wpriv->cdev[led_type].name =3D "platform::micmute";
> +		wpriv->cdev[led_type].brightness_set_blocking =3D &lsh_wmi_micmute_led=
_set;
> +		wpriv->cdev[led_type].default_trigger =3D "audio-micmute";
> +
> +		err =3D devm_led_classdev_register(dev, &wpriv->cdev[led_type]);
> +		if (err < 0)
> +			goto led_reg_failed;
> +
> +		break;
> +	case AUDIO_MUTE:
> +		if (led_version !=3D WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER)
> +			return -EIO;
> +
> +		wpriv->cdev[led_type].name =3D "platform::mute";
> +		wpriv->cdev[led_type].brightness_set_blocking =3D &lsh_wmi_audiomute_l=
ed_set;
> +		wpriv->cdev[led_type].default_trigger =3D "audio-mute";
> +
> +		err =3D devm_led_classdev_register(dev, &wpriv->cdev[led_type]);
> +		if (err < 0)
> +			goto led_reg_failed;
> +
> +		break;
> +	default:
> +		dev_err(dev, "Unknown LED type %d\n", led_type);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +
> +led_reg_failed:
> +	dev_err(dev, "Could not register mute LED %d : %d\n", led_type, err);
> +	return err;
> +}
> +
> +static int lenovo_super_hotkey_wmi_leds_setup(struct device *dev)
> +{
> +	int err;
> +
> +	err =3D lenovo_super_hotkey_wmi_led_init(MIC_MUTE, dev);
> +	if (err)
> +		return err;
> +
> +	err =3D lenovo_super_hotkey_wmi_led_init(AUDIO_MUTE, dev);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int lenovo_super_hotkey_wmi_probe(struct wmi_device *wdev, const =
void *context)
> +{
> +	struct lenovo_super_hotkey_wmi_private *wpriv;
> +	int err;
> +
> +	wpriv =3D devm_kzalloc(&wdev->dev, sizeof(*wpriv), GFP_KERNEL);
> +	if (!wpriv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&wdev->dev, wpriv);
> +	wpriv->led_wdev =3D wdev;
> +	err =3D lenovo_super_hotkey_wmi_leds_setup(&wdev->dev);

return lenovo_super_hotkey_wmi_leds_setup(&wdev->dev);

Other than that this looks good to me :)

--=20
 ~ Kurt

> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static const struct wmi_device_id lenovo_super_hotkey_wmi_id_table[] =3D=
 {
> +	{ LUD_WMI_METHOD_GUID, NULL }, /* Utility data */
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(wmi, lenovo_super_hotkey_wmi_id_table);
> +
> +static struct wmi_driver lenovo_super_hotkey_wmi_driver =3D {
> +	 .driver =3D {
> +		 .name =3D "lenovo_super_hotkey_wmi",
> +		 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS
> +	 },
> +	 .id_table =3D lenovo_super_hotkey_wmi_id_table,
> +	 .probe =3D lenovo_super_hotkey_wmi_probe,
> +	 .no_singleton =3D true,
> +};
> +
> +module_wmi_driver(lenovo_super_hotkey_wmi_driver);
> +
> +MODULE_INFO(depends, "wmi,ideapad-laptop");
> +MODULE_AUTHOR("Jackie Dong <dongeg1@lenovo.com>");
> +MODULE_DESCRIPTION("Lenovo Super Hotkey Utility WMI extras driver");
> +MODULE_LICENSE("GPL");


