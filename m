Return-Path: <linux-kernel+bounces-520113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C99A3A5DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43FE18963F7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F7E1EB5C4;
	Tue, 18 Feb 2025 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMjf4+94"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BFD2356D6;
	Tue, 18 Feb 2025 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903959; cv=none; b=o6DzHMW/V/9jzvCNlpmBi9j4FDTgU1mhJrCRof10IZyb2CHbfeoRy+w6LTPQ/tUWdvAVOd+XM9a62UgcGpk1nPBivCfw7fsLlVWjwrPTqJCgsdW8oRtBLQPRWwUl1aOHHKgCOZGEYeF8WaVhtcydI3hTy1v5O43dCtKl6u5Jj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903959; c=relaxed/simple;
	bh=oEi8+DJ1Od9anjCSCDXHxWN91goXMv9PGcjFAatOkQw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IpdNs5w+gGfPKy8DBhOCwNQxlocDvqfBfhGMDAEk7EPZbCJhNYZK2pXkRTSSSxYx4KlUoeWMHlKm/YYCin+kKP1YY9i9DmatRUhah3B0K+EWoKqn+A/TvaIqCVumKZXVNG6ryDsqi3pH8IKg9cHpTyLi3j5FnBW0uwaazAVphd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMjf4+94; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e5dcc3b0c77so2866592276.0;
        Tue, 18 Feb 2025 10:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739903955; x=1740508755; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A602ukX61G8SHfGgV9Mfn3RDCkXOuF+pNpwRiPxAdqk=;
        b=RMjf4+94YQO9sV1NMSnJO6So3XEnUiJHICbP3k//rk+BKlGrEyBmVdjfUOaOKoP/40
         xfVLWd+75luQpFucA7jyzVUhuJ4K4fAuHI8Avf5tIxpQjBeqM4hAV1EG2H5myssJdpfS
         8rFztHjEG+tXpRNI8JZYpt/+vusd9fHrQ3tvberfOglVc4bEWaTJIwMPXcAWZ9gbomBF
         y4gdvPEQ+4T6ffyhBpP2KQu4yKWDk8H0nNHtqk4jA0MP6NDAh7gyrxeWc86pJ586D3mu
         5KYq1QioRuG6/I9GUmPiB9+VI8SAhtjiNEzgr/wenqSpF7Qrc0IQg0cBHvgK26X6a0xt
         3hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739903955; x=1740508755;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A602ukX61G8SHfGgV9Mfn3RDCkXOuF+pNpwRiPxAdqk=;
        b=PVYFC9qm26pIcq6BS54SGSH3Zm4Y0ONoX20J/MwGfRcpTzoh0GcFWggS/guDb3ATnB
         Qfeg89lrRr2ySHeiiWV2dWxrtKTIb07f/3azldBT+m7LjOR9E1Sh+KUFKgekAj7UcumA
         0FS7vaZSM1u7dYIS3Cc5ZNRGaI3E59ksW6cExUKf0aI9gSluM/1OdZrlGJjVPE2txFcS
         rcDMSHWxj0MkRPn9pMhQnTFlGKD8jBDqpNPFJdm3JJAStBUSmtNhGUiRWfGC8ORGCHfQ
         JvMtlL2ptGEh74AgZcNb4ZEES1D66+D2pioLaMupvNHLfsSMnuD5ESwD2eLuGalTNkEh
         1Edw==
X-Forwarded-Encrypted: i=1; AJvYcCU+PJYf0iMH+WPVKwDn7LnZDHUz/0CC1wc/4q/F2oRKr+BKP7P04T+729/PVpNJ0qUAQM8JoFdvV3iSNoKtCAf9N1breA==@vger.kernel.org, AJvYcCW88FE6JX1sfQFtfLSVNjZP021Qt6da+MJ87Zjzl8SuCxs9QK6Enmo2/wrvQ4QkW4jpSXXbfZVBCgeNA7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW8MLkK3oI9140PJyX0lKySoNKeMdUzNVtQedaZSNCXlk0sQfw
	V2yMD7P/jPhOVze3MyyoxhA/UT4X9Onbehfw7e3i2OXNn+pHVGfa
X-Gm-Gg: ASbGncu4FYbuKMObrqCySrzAd5gftRkpAPVQ10QEB7Za/i9x/3XE7+pnoK8rcGAiUT9
	gJxQDXUi+ml2LovGER2q3NH7NKHkriR39ygNU8E/U/MQ7GvcLLFRrRv3sYUy+Mu47Zq9aepgVZJ
	ADvdfoy8l31vc15jZmDblhkik3YkxnO4nuCTYrDgYr4QzAvUSQbA06o/CuoWttGlFiWNTG+zhI+
	v/IFEwk7Z6LLmtfZvKDr3PRS7NVBa40rFzT/GbewKkg4fJB5iR1i8bsK8SqNwSP5j0uqMSaPvFj
	XAjfYRk=
X-Google-Smtp-Source: AGHT+IF305OorZ6/B8Lr9PTjWCJ+kGoRs7RrVraUg+lZw/ZCLTQLJPtD1mmjf6z1EbXKxty6ICpHdg==
X-Received: by 2002:a05:6902:108e:b0:e5d:d6b8:2317 with SMTP id 3f1490d57ef6-e5e0a1400admr641263276.44.1739903954958;
        Tue, 18 Feb 2025 10:39:14 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dae0d9f25sm3289866276.36.2025.02.18.10.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 10:39:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Feb 2025 13:39:12 -0500
Message-Id: <D7VSH5I5ERDG.2QR7V6W3JX2LM@gmail.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>, "Henrique de Moraes Holschuh"
 <hmh@hmh.eng.br>, <ibm-acpi-devel@lists.sourceforge.net>,
 "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] platform/x86: thinkpad_acpi: Move HWMON
 initialization to tpacpi_hwmon_pdriver's probe
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Mark Pearson" <mpearson-lenovo@squebb.ca>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250215000302.19753-1-kuurtb@gmail.com>
 <20250215000302.19753-3-kuurtb@gmail.com>
 <9a98e10c-dd14-45a9-96ec-6ebca8b68616@app.fastmail.com>
In-Reply-To: <9a98e10c-dd14-45a9-96ec-6ebca8b68616@app.fastmail.com>

Hi Mark,

On Tue Feb 18, 2025 at 11:50 AM -05, Mark Pearson wrote:
> Hi Kurt,
>
> On Fri, Feb 14, 2025, at 7:03 PM, Kurt Borja wrote:
>> Let the driver core manage the lifetime of the HWMON device, by
>> registering it inside tpacpi_hwmon_pdriver's probe and using
>> devm_hwmon_device_register_with_groups().
>>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  drivers/platform/x86/thinkpad_acpi.c | 44 +++++++++++-----------------
>>  1 file changed, 17 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c=20
>> b/drivers/platform/x86/thinkpad_acpi.c
>> index ad9de48cc122..a7e82157bd67 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -367,7 +367,6 @@ static struct {
>>  	u32 beep_needs_two_args:1;
>>  	u32 mixer_no_level_control:1;
>>  	u32 battery_force_primary:1;
>> -	u32 sensors_pdrv_registered:1;
>>  	u32 hotkey_poll_active:1;
>>  	u32 has_adaptive_kbd:1;
>>  	u32 kbd_lang:1;
>> @@ -11815,12 +11814,10 @@ static void thinkpad_acpi_module_exit(void)
>>  {
>>  	tpacpi_lifecycle =3D TPACPI_LIFE_EXITING;
>>=20
>> -	if (tpacpi_hwmon)
>> -		hwmon_device_unregister(tpacpi_hwmon);
>> -	if (tp_features.sensors_pdrv_registered)
>> +	if (tpacpi_sensors_pdev) {
>>  		platform_driver_unregister(&tpacpi_hwmon_pdriver);
>> -	if (tpacpi_sensors_pdev)
>>  		platform_device_unregister(tpacpi_sensors_pdev);
>> +	}
>>=20
>>  	if (tpacpi_pdev) {
>>  		platform_driver_unregister(&tpacpi_pdriver);
>> @@ -11891,6 +11888,17 @@ static int __init tpacpi_pdriver_probe(struct=
=20
>> platform_device *pdev)
>>  	return ret;
>>  }
>>=20
>> +static int __init tpacpi_hwmon_pdriver_probe(struct platform_device *pd=
ev)
>> +{
>> +	tpacpi_hwmon =3D devm_hwmon_device_register_with_groups(
>> +		&tpacpi_sensors_pdev->dev, TPACPI_NAME, NULL, tpacpi_hwmon_groups);
>> +
>> +	if (IS_ERR(tpacpi_hwmon))
>> +		pr_err("unable to register hwmon device\n");
>> +
>> +	return PTR_ERR_OR_ZERO(tpacpi_hwmon);
>> +}
>> +
>>  static int __init thinkpad_acpi_module_init(void)
>>  {
>>  	const struct dmi_system_id *dmi_id;
>> @@ -11964,37 +11972,19 @@ static int __init thinkpad_acpi_module_init(vo=
id)
>>  		return ret;
>>  	}
>>=20
>> -	tpacpi_sensors_pdev =3D platform_device_register_simple(
>> -						TPACPI_HWMON_DRVR_NAME,
>> -						PLATFORM_DEVID_NONE, NULL, 0);
>> +	tpacpi_sensors_pdev =3D platform_create_bundle(&tpacpi_hwmon_pdriver,
>> +						     tpacpi_hwmon_pdriver_probe,
>> +						     NULL, 0, NULL, 0);
>>  	if (IS_ERR(tpacpi_sensors_pdev)) {
>>  		ret =3D PTR_ERR(tpacpi_sensors_pdev);
>>  		tpacpi_sensors_pdev =3D NULL;
>> -		pr_err("unable to register hwmon platform device\n");
>> +		pr_err("unable to register hwmon platform device/driver bundle\n");
>>  		thinkpad_acpi_module_exit();
>>  		return ret;
>>  	}
>>=20
>>  	tpacpi_lifecycle =3D TPACPI_LIFE_RUNNING;
>>=20
>> -	ret =3D platform_driver_register(&tpacpi_hwmon_pdriver);
>> -	if (ret) {
>> -		pr_err("unable to register hwmon platform driver\n");
>> -		thinkpad_acpi_module_exit();
>> -		return ret;
>> -	}
>> -	tp_features.sensors_pdrv_registered =3D 1;
>> -
>> -	tpacpi_hwmon =3D hwmon_device_register_with_groups(
>> -		&tpacpi_sensors_pdev->dev, TPACPI_NAME, NULL, tpacpi_hwmon_groups);
>> -	if (IS_ERR(tpacpi_hwmon)) {
>> -		ret =3D PTR_ERR(tpacpi_hwmon);
>> -		tpacpi_hwmon =3D NULL;
>> -		pr_err("unable to register hwmon device\n");
>> -		thinkpad_acpi_module_exit();
>> -		return ret;
>> -	}
>> -
>>  	return 0;
>>  }
>>=20
>> --=20
>> 2.48.1
>
> Thanks for doing this.

Glad to help :)

>
> For the series - all looks good and I tested on a X1 Carbon 12 and confir=
med the Thinkpad devices are there under /sys/devices/thinkpad_acpi and /sy=
s/class/hwmon. Didn't find any issues.
>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Thank you! Making changes to this driver is a bit scary.

--=20
 ~ Kurt

>
> Mark


