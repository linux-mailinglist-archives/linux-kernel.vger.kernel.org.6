Return-Path: <linux-kernel+bounces-511645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1D5A32DB3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2651886191
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E88825B69A;
	Wed, 12 Feb 2025 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi9IPAcv"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C862586C6;
	Wed, 12 Feb 2025 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382213; cv=none; b=lbbRM77CiMP7TGOG/Ane0PFXhVX9vNor+/0g/MYcv5d1eSzACOEtGA3CxrdZy+94BJUyKEe3mCeIlPOfQMCazxervWYzK9lrpTB+kmrW+VY4wJ3EQyuQScXCFFUlpKmao4873CHF8a9IcTa71NwC9tLGl0ig6DtTmEY4p8NV23E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382213; c=relaxed/simple;
	bh=L4kfXCzpw3LHzhnMct3EQoXu61cLC7vGM9jRNWN86dU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GQLjFWsbtDZdgU8BSEZWHAMdECRSCw5YvsIHsGGc0ibQHu2J84WozvspX9V3OmDiWTDyD4qVGpMNUSpPt3PtdevLYtPK24vw+F/CPyGFGSajqkj90vVHoYVWCFOd0SjHzSQxPIdoWYvEpopN7k7OBSqMy54qZig2exzZLdWGIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mi9IPAcv; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6f9b1bc594dso246297b3.0;
        Wed, 12 Feb 2025 09:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739382210; x=1739987010; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTKo4knAvjUALZFhvPfgqttFum7ZaL5Xtp/4/l9yBkg=;
        b=mi9IPAcvJIIf01kW8+H9Wv+vdKPVgN0duAI5ecDpJ9yhKFDd4PKXjZNyHj2ykO10YV
         XlvhqMMluyNNLAYhgQn3pa4K8kMIQq5Dd9qe/Ub3Pk4uRG1N9N2gp0t1gMGWf/O9DIb0
         5LDrnhURGo3yuRvqQUPEOPVAprC+ikOx4PCTEU+y0wp1M7rwMokUZxObrFKqdO/p2rn+
         GtXv9nNuzfb16K5p6OdxxGzgjwllse3bH+7655di0nG8LNrHaBxezaXW9P2Ob1ST/kBr
         OZRTVa1f4WwZ1gNjL49Ls80ZT826gaw/ScMfdSMD+FYPtKfS/HgJ/QR5J1KORT1+t0c5
         vmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382210; x=1739987010;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XTKo4knAvjUALZFhvPfgqttFum7ZaL5Xtp/4/l9yBkg=;
        b=BkfuDEhrcteiihBJhZek2GQ+6y1afAOfSOgUbwN1lFyC9FjBCn+AZSkvXyMWSerYaO
         sRNThMPNdHyw4A3mDjKVsaYBwx78GZP3zXjgseJ8pdxyKczjtDhOA36T1NO4rWah4uSN
         EnBHKRaddrhszNxL10SohaQ+R5tkTkSh9Ip1HJH3IPiuQRR6/WOWF2/00oH7lQGF3Tlg
         AaxlEnxEbtKZkkM6tRgGsG1rIT3GMyKZaxhSKaDn27drY+pMGdMk3P3WRxPPGLuN336Z
         1iVpNdIgMBdQG1nVlZqoCoMPQlQqykAEeIQaB/nEpTLEi37uJCol2M3Q5ZMl9Z1krNlf
         sACg==
X-Forwarded-Encrypted: i=1; AJvYcCX05Dp7OrmIRW/ICucXcuE9ijdlBdZKGgru+jM/f4kq17Us5e8F1GoZiw9Ipe6C0aS2gzPKiCE1RI8xXQD9x6i7ZY+9@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLy3F4LUfUtvzW5DQ1o9MFW5B9PBrbQO+VD/ezDWtJHuxiPit
	feU0ivNYC1vLH0E3ljxpZoQQJ1UvEqSuTVwhjBZXMyhjT2fdmNym
X-Gm-Gg: ASbGncu01Cl4aY9lmyss11cu8tECHmbft4fNz/WtSr8R8hRtX2KnibrlOKoDyShoCaq
	52GxNQzQrkHajGJlVRaDzQFEOJQpJWr7PDktrNxwR1d+Vfgktwa8UqoZPVdGp5nk9I195v3R72H
	z0A349+sLQywRCmoVzCZfc6ztzalw2P67LKDCsEtRGtxTOtpRK+u28gUiLra79e2BGY/jVyWIpC
	FF6QqgMVW7Kmj6nayjYKzitrxrP0AXNnsBSXQ9LAy2rBrHzsn2WugAoDVytIxGBM/vpnsT8FS0q
	8/uSkrQ0dg==
X-Google-Smtp-Source: AGHT+IEvwYgyghlf7mm+lt3t8FIrhHIAsmys1to2z4kKG0slr1wUdYul/TbiYK8H1iErznuG3Oj25Q==
X-Received: by 2002:a05:690c:4903:b0:6f5:4304:fb8 with SMTP id 00721157ae682-6fb1f1c7654mr49294507b3.18.1739382209988;
        Wed, 12 Feb 2025 09:43:29 -0800 (PST)
Received: from localhost ([2800:bf0:179:113e:f067:4e25:4298:6451])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99fd56916sm27754827b3.62.2025.02.12.09.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 09:43:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 12:43:28 -0500
Message-Id: <D7QNJ79F513X.FYQCGSC9M3KG@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <dongeg1@lenovo.com>, "Mark Pearson" <mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH v5] platform/x86: lenovo-super-hotkey-wmi.c: Support for
 mic and audio mute LEDs
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jackie Dong" <xy-jackie@139.com>, <hdegoede@redhat.com>,
 <ilpo.jarvinen@linux.intel.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250212070154.5333-1-xy-jackie@139.com>
In-Reply-To: <20250212070154.5333-1-xy-jackie@139.com>

Hi Jackie,

I left some style recommendations below and a couple questions. I
apologize for not including this in the last review.

On Wed Feb 12, 2025 at 2:01 AM -05, Jackie Dong wrote:
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
> ---
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
>
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
>  drivers/platform/x86/Kconfig                  |   9 +
>  drivers/platform/x86/Makefile                 |   1 +
>  .../platform/x86/lenovo-super-hotkey-wmi.c    | 222 ++++++++++++++++++
>  3 files changed, 232 insertions(+)
>  create mode 100644 drivers/platform/x86/lenovo-super-hotkey-wmi.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879d64..c1792e8f04e1 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -475,6 +475,15 @@ config IDEAPAD_LAPTOP
>  	  This is a driver for Lenovo IdeaPad netbooks contains drivers for
>  	  rfkill switch, hotkey, fan control and backlight control.
> =20
> +config LENOVO_SUPER_HOTKEY_WMI
> +	tristate "Lenovo Super Hotkey Utility WMI extras driver"
> +	depends on ACPI_WMI
> +	depends on IDEAPAD_LAPTOP

Does this still depend on IDEAPAD_LAPTOP? Also add:
	select NEW_LEDS
	select LEDS_CLASS

> +	help
> +	  This driver provides WMI support for Lenovo customized hotkeys functi=
on
> +	  of Lenovo NoteBooks which are for Consumer and SMB customers, such as
> +	  Ideapad/YOGA/XiaoXin/Gaming/ThinkBook and so on.

This driver deals with mute key leds. Is this description right?

> +
>  config LENOVO_YMC
>  	tristate "Lenovo Yoga Tablet Mode Control"
>  	depends on ACPI_WMI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index e1b142947067..598335da9f55 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_UV_SYSFS)       +=3D uv_sysfs.o
>  # IBM Thinkpad and Lenovo
>  obj-$(CONFIG_IBM_RTL)		+=3D ibm_rtl.o
>  obj-$(CONFIG_IDEAPAD_LAPTOP)	+=3D ideapad-laptop.o
> +obj-$(CONFIG_LENOVO_SUPER_HOTKEY_WMI)	+=3D lenovo-super-hotkey-wmi.o
>  obj-$(CONFIG_LENOVO_YMC)	+=3D lenovo-ymc.o
>  obj-$(CONFIG_SENSORS_HDAPS)	+=3D hdaps.o
>  obj-$(CONFIG_THINKPAD_ACPI)	+=3D thinkpad_acpi.o
> diff --git a/drivers/platform/x86/lenovo-super-hotkey-wmi.c b/drivers/pla=
tform/x86/lenovo-super-hotkey-wmi.c

This name doesn't tell me a lot about the features of this driver. Is
this the internal name of the WMI device?

> new file mode 100644
> index 000000000000..86c3dc2009b8
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-super-hotkey-wmi.c
> @@ -0,0 +1,222 @@
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
> +	MIC_MUTE_LED_ON =3D 1,
> +	MIC_MUTE_LED_OFF,
> +	AUDIO_MUTE_LED_ON =3D 4,

Please align this values.

> +	AUDIO_MUTE_LED_OFF,
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
> +	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
> +		led_version =3D obj->integer.value;
> +	} else {
> +		err =3D -EIO;
> +		return err;

Return -EIO directly here and drop the braces on both branches.

> +	}
> +
> +	wpriv->cdev[led_type].max_brightness =3D LED_ON;
> +	wpriv->cdev[led_type].flags =3D LED_CORE_SUSPENDRESUME;
> +
> +	switch (led_type) {
> +	case MIC_MUTE:
> +		if (led_version !=3D WMI_LUD_SUPPORT_MICMUTE_LED_VER) {
> +			err =3D -EIO;
> +			goto led_error;

Return -EIO and drop brances.

> +		}
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
> +		if (led_version !=3D WMI_LUD_SUPPORT_AUDIOMUTE_LED_VER) {
> +			err =3D -EIO;
> +			goto led_error;

Return -EIO and drop brances.

> +		}
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
> +		err =3D -EINVAL;
> +		dev_err(dev, "Unknown LED type %d\n", led_type);
> +		goto led_error;

Return -EINVAL directly.

> +	}
> +
> +	return 0;
> +
> +led_reg_failed:
> +	dev_err(dev, "Could not register mute LED %d : %d\n", led_type, err);
> +
> +led_error:
> +	return err;
> +}
> +
> +static void lenovo_super_hotkey_wmi_leds_setup(struct device *dev)
> +{
> +	lenovo_super_hotkey_wmi_led_init(MIC_MUTE, dev);
> +	lenovo_super_hotkey_wmi_led_init(AUDIO_MUTE, dev);

I wonder why you decided not to propagate errors of this calls. Maybe
you are expecting one to fail but not the other?

If this both fail this module would remain loaded for no reason, so
maybe propagate some error in that case.

> +}
> +
> +static int lenovo_super_hotkey_wmi_probe(struct wmi_device *wdev, const =
void *context)
> +{
> +	struct lenovo_super_hotkey_wmi_private *wpriv;
> +
> +	wpriv =3D devm_kzalloc(&wdev->dev, sizeof(*wpriv), GFP_KERNEL);
> +	if (!wpriv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&wdev->dev, wpriv);
> +	wpriv->led_wdev =3D wdev;
> +	lenovo_super_hotkey_wmi_leds_setup(&wdev->dev);
> +
> +	return 0;
> +}
> +
> +static const struct wmi_device_id lenovo_super_hotkey_wmi_id_table[] =3D=
 {
> +	{ LUD_WMI_METHOD_GUID, NULL }, /* Utility data */

Maybe drop this comment.

Additionally, please CC me and previous reviewers the next revision.

--=20
 ~ Kurt

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


