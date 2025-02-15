Return-Path: <linux-kernel+bounces-515956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28379A36B07
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76AD63B1150
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945C46BB5B;
	Sat, 15 Feb 2025 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh230XCs"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F8E56C;
	Sat, 15 Feb 2025 01:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739583190; cv=none; b=acp+YmyaJiK0lairCEi1dwi7oIY6J9P8qh7YCGGcZDu5eH88sfxKNPHPeW+yA9GoJfIGcD0ex1C5LHBN6UFBubowzNtpOiV4hragPr6Se3cS7A4p3h2POVTGWuX8TGpiN7AYTed6qO6P4FnVWxlrrqFf4Wdp1SIlZrFmNNSTAYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739583190; c=relaxed/simple;
	bh=JzsPmN3F5scipZaMMv/gsP6sFBI17ZFPoIipxeKUh+A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JdqC+RkNlGZIHIOScyQ5u8MiLj/7znoIY2j0x1SU5lHNQxFbZYVgTBlqFVGSFkBbQeOhFR1DRLhJnN39UOzbOHDd/lVlW96K38vdmB5hjxCKilmjRG8GhrZcfxT7FhQ4bbXItq1Rjtt01hp5yD2tyUsCIXmCOabIADFt7VkKSFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kh230XCs; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f679788fd1so19327467b3.2;
        Fri, 14 Feb 2025 17:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739583188; x=1740187988; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAmctQ9UHMDdeyKyVmGIYjtPir5lUG2huyqQIrmN8G4=;
        b=Kh230XCsYKOnx5VxbQ7bNLo0VvMpDAb//u0JytsPljJvA9WOAaY7AhFX74I2Ey3xtn
         SjagEDLvx5BBicJnzGwWyY80hDHU9CcE95e8gtpXgKoQ2KURyeA4X7bmJCsEtwtR3bgy
         FULZ3UciLxtWxFU5jB/Why8OSO9aVPPiUAsmalFStbXoZTaTcH4zQiObDreWEoiuSKYk
         Csamg5tAJug0wzjximbFWz2g5CKYHwKMvjduR0SVZYtRkuVC0wfdHx+SsZymIjX7Jj3Q
         fp0qGAuIpkndzEPmnICNz0Cz5pOOwUX36o77jIdcNclQLTM5ywQhgn3ZpFf4GviQfq6O
         qPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739583188; x=1740187988;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IAmctQ9UHMDdeyKyVmGIYjtPir5lUG2huyqQIrmN8G4=;
        b=LTmGqmCkMaWrNEK4kz1gfItQN6RCMG/pGAIFLUSpfjlTmXYTnflSLIyNU1dVa3zZ3/
         hwNYxmk7M83mQd2Lv2h/lfSR3W3dn541JXkPEMiLUExJT2FQJvwGAcMk7dI6Itk9LcbT
         zEGOFRx9ZBAoZx8v7BU+vXc5pAf4RsKGyFWM7rnopucqfBiWpI9qQYOEsysBgyxgypxr
         EbZmjcSUuxAINxz/En7LhDceIR9fcJOGS5duvZwzanNkHa5QQ7ynFAaLOa8wbnKlRwhL
         7CcCF1BlnXgaC03uObDB9W0Dq0pSyayJ5xCbIB+Cw4UUKAlIZGCU7+ozbo8FbnSYpkVg
         viog==
X-Forwarded-Encrypted: i=1; AJvYcCU+8OSvG4u7QUPcC9xpPzCbkA5gfYxUTco7hkqzA1BGC4xmwW5oSoE8zq4KqTOHhappOPcOxCZGxcHz4H0=@vger.kernel.org, AJvYcCWDZrVZxxDq/pY06pxluGROLj/gCahkxZEeZg/zDGfK0avGuql0i3bOt+IoiXRhCnbUAX6B2s58oD8Pl+9ccU6ajNE27Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFLlWSFu8bhDsu/y1NaagF63cPDMgoaW1R3CnQo7GDn6QIMEh5
	hoOXdetOcUdtAr23tzdRTHnb2bnNetraKBGntUbRjyD/ElGpPMrv
X-Gm-Gg: ASbGncuLNrr3yIms+DkLcC6IUOSItWO7/UGtV6Am1Oyj/lHtm5Un5jVz7wA4XMWUUn9
	U7f9g6z0RhiHTBMHPEgPR+ZOWOAQ6u9ATpLJYChSUjqsLsoH0udVTvptWmAynM5auiXOQ9O2gCm
	BmUCMVYoCj9lJpaz2eyQrcYeU045/KkWYRY+V41DuwNN4aoTbejAB7+3gYHm4lkMCeKX3HW//I8
	stBSyksEuNz93t9HuQhGnyv0CYEAFPFjjbJjlHLRsYUNVvITatF8ofet08vr8vhb3KLBWTBR5DZ
	6Ia2FaA=
X-Google-Smtp-Source: AGHT+IEdtYJlMSJnIZsP1yCo8MrmbwRtwpuLZvr/Xe6oGFHY2Uh/ZIVa8YkvxGTU+LmKGP4thSuw7Q==
X-Received: by 2002:a05:690c:4c07:b0:6f7:5605:c62b with SMTP id 00721157ae682-6fb58374b68mr18439797b3.27.1739583188223;
        Fri, 14 Feb 2025 17:33:08 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb360acfd7sm10199617b3.65.2025.02.14.17.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 17:33:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Feb 2025 20:33:05 -0500
Message-Id: <D7SMRUYV3VHN.3P7MDOALEAS4P@gmail.com>
Cc: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] platform/x86: acer-wmi: Add fan control support
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Armin Wolf" <W_Armin@gmx.de>, <jlee@suse.com>,
 <basak.sb2006@gmail.com>, <rayanmargham4@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250214221322.47298-1-W_Armin@gmx.de>
 <20250214221322.47298-3-W_Armin@gmx.de>
In-Reply-To: <20250214221322.47298-3-W_Armin@gmx.de>

On Fri Feb 14, 2025 at 5:13 PM -05, Armin Wolf wrote:
> Add support for controlling the fan speed using the
> SetGamingFanSpeed() and GetGamingFanSpeed() WMI methods.
>
> This feature is only enabled if the machine has ACER_CAP_PWM enabled
> and depend on ACER_CAP_HWMON for detecting the number of available
> fans.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/acer-wmi.c | 222 +++++++++++++++++++++++++++++++-
>  1 file changed, 220 insertions(+), 2 deletions(-)
>
> --
> 2.39.5
>
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-=
wmi.c
> index f20a882e3650..e24f5a323f95 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -12,10 +12,12 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
>  #include <linux/kernel.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/dmi.h>
> +#include <linux/fixp-arith.h>

I didn't know about this, thanks!

>  #include <linux/backlight.h>
>  #include <linux/leds.h>
>  #include <linux/platform_device.h>
> @@ -30,6 +32,7 @@
>  #include <linux/input/sparse-keymap.h>
>  #include <acpi/video.h>
>  #include <linux/hwmon.h>
> +#include <linux/unaligned.h>

Duplicated include.

>  #include <linux/units.h>
>  #include <linux/unaligned.h>
>  #include <linux/bitfield.h>
...
> @@ -2867,8 +2978,10 @@ static int acer_wmi_hwmon_read(struct device *dev,=
 enum hwmon_sensor_types type,
>  			       u32 attr, int channel, long *val)
>  {
>  	u64 command =3D ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING;
> +	u8 fan, speed, mode_bitmap;
> +	u16 fan_bitmap;
> +	int mode, ret;
>  	u64 result;
> -	int ret;
>
>  	switch (type) {
>  	case hwmon_temp:
> @@ -2892,6 +3005,106 @@ static int acer_wmi_hwmon_read(struct device *dev=
, enum hwmon_sensor_types type,
>
>  		*val =3D FIELD_GET(ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK, result);
>  		return 0;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			fan =3D acer_wmi_fan_channel_to_fan_id[channel];
> +			ret =3D WMID_gaming_get_gaming_fan_speed(fan, &speed);
> +			if (ret < 0)
> +				return ret;
> +
> +			*val =3D fixp_linear_interpolate(0, 0, 100, U8_MAX, speed);
> +			return 0;
> +		case hwmon_pwm_enable:
> +			fan_bitmap =3D acer_wmi_fan_channel_to_fan_bitmap[channel];
> +			ret =3D WMID_gaming_get_fan_behavior(fan_bitmap, &mode_bitmap);
> +			if (ret < 0)
> +				return ret;
> +
> +			switch (channel) {
> +			case 0:
> +				mode =3D FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK,
> +						 mode_bitmap);
> +				break;
> +			case 1:
> +				mode =3D FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK,
> +						 mode_bitmap);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +
> +			switch (mode) {
> +			case ACER_WMID_FAN_MODE_AUTO:
> +				*val =3D 2;
> +				return 0;
> +			case ACER_WMID_FAN_MODE_TURBO:
> +				*val =3D 0;
> +				return 0;
> +			case ACER_WMID_FAN_MODE_CUSTOM:
> +				*val =3D 1;
> +				return 0;
> +			default:
> +				return -ENXIO;
> +			}
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int acer_wmi_hwmon_write(struct device *dev, enum hwmon_sensor_ty=
pes type,
> +				u32 attr, int channel, long val)
> +{
> +	u8 fan, speed, mode_bitmap;
> +	u16 fan_bitmap;
> +	int mode;
> +
> +	switch (type) {
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			fan =3D acer_wmi_fan_channel_to_fan_id[channel];
> +			speed =3D fixp_linear_interpolate(0, 0, U8_MAX, 100,
> +							clamp_val(val, 0, U8_MAX));
> +
> +			return WMID_gaming_set_gaming_fan_speed(fan, speed);
> +		case hwmon_pwm_mode:

hwmon_pwm_enable?

Other than that:

Reviewed-by: Kurt Borja <kuurtb@gmail.com>

> <snip>


