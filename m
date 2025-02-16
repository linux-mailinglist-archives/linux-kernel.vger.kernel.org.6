Return-Path: <linux-kernel+bounces-516813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D10A377C5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CCD188C408
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731FA1A3A80;
	Sun, 16 Feb 2025 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am1Qd2XA"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F26F14A60A;
	Sun, 16 Feb 2025 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739741130; cv=none; b=o2PrwcF8k3u9O3/wscpx4CdCDS6o0QCvkpG46hdwh1SdT/bfW/q3O20CZ8e6fHVkTg33oZrubUvNcjJ/F4w1ZDnSp/nH0C9/0n5Q9tj7WakXmzZh6h4lpWwSH7MkX6UTBMvpTKlPnrZXzs7t0pQXEOMOJnR8OR1w/TelK5MDDxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739741130; c=relaxed/simple;
	bh=kjKQHnOKp8P6DVEUiW4y+wy3uzq9H21o1lUkxE2M5+A=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=LsNmtjwX68JHKshqFVqjyYXJ9AcpJKDQrafTN8okKhZ85zEawJWZ4MwaIYm2cdGZXJpT/Er4r2ZYv8msIgx4vvW44B7VZ3wKu8ZPzFGlRvnQQW5ByYV1HdVgpYomRBPNnxxzskkSQ/8C9T0tXuzEhBEuKZ2hvxprrDbYIMcZYeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Am1Qd2XA; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f4bc408e49so27897177b3.1;
        Sun, 16 Feb 2025 13:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739741128; x=1740345928; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1s8EqSnuvAyK02isEnuZwhDBIeSxMb3MP2VhyNyAbXM=;
        b=Am1Qd2XA0BimEVSU2DtJDM+ZjKeEVEQb0z3stjigMdsNqaqnnNTaCKJ/oZHGnvjbBV
         EFAqjouST+A9CMJguACs0SHvE9oycym6l21mVqHIUxs6aU/w//V7QtmTUCqcjxVx0Ue8
         Ej1pDXrNQpcLMwJ16DtyloL+BMxCQKi0a3oZLjzVo7Ta54zxZKMGVOC+wSslIcylegqz
         XjnpGecEfme+2ywEALpaYOdmX5F8zUv3RtWlmFzmREPjZvUYng8UZaDADsudgzPZ0FCb
         wLfWHScK7wRT7+SsgLMfRtyR/aV8bBu4aPf82qhTBZ/Y2Xv+OsA5ibGz+F/nTm8pmaMj
         C63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739741128; x=1740345928;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1s8EqSnuvAyK02isEnuZwhDBIeSxMb3MP2VhyNyAbXM=;
        b=dqEGA54Ae1nHNohD5FgvCAoVzDqG2jJXv293PvU3+gAGiCalWZHUT7kkalhPUVHTAH
         tkDBtXaMUQZc1jeFJzAb88iRFmbWwqH7HCSlKn807JfpFraH3yMTUnUbvt28p4a2Lq4P
         zZ30ncsZnBDsHaDY5DwjNHbgahLVfE7PJ33IK8nf+Qdtmp3JETXudCVm42Nx0Pdtxbz3
         Nj7ELbPIOS4fgVzcSQKu7bQ9wBGVziRJD/62wEhNDV20cSfGYQTXi20BrSKOfarU8CMU
         oDLwmltph6Z9fPaIIepGpktZR9krlQf97WuE80UkjwQkPCGnqxIc9vWTe3/JXP4SSyb3
         bU7g==
X-Forwarded-Encrypted: i=1; AJvYcCVWdxM/tAfj0/v4fX5rTUTdz7LahyZZxLYtkn/0ozo3XpzrSrxFLTu0db+TVYeOub1zPtgzLd1YjO724v0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2BxsvwUKbjwq/kz6WuaJTWM0pnW6J8uq2zhh1lYMVQIgCJjNJ
	lhONa13xdWtBT4TNKybgGO+7tk0w3WY/9ny5YImMTzR7lAov5kDw3lBj2w==
X-Gm-Gg: ASbGncvBMVXDVmCWKzbiFHR9+d9wfEc5YrE4TpSkp5cchYTiGDmdhDYIBC3A3F3DfnN
	0mF9dnn6sZ+NAcPzRRZ+wtDD3v+vXzZWbO615JEj2fnRjZZX6yhKhxV9h6svy67a9V4BPXFJPlG
	ubGpJ7DVVNV1OMP7WZmQjWCViSc8LFKq6pweX4VnxC6SATAfheGZquzUViWk4moD3kvQoJa3/gY
	rgMFZ6BTI4QtNxQPdAfYFMg/28LEWZFUEDVJdREpNx7qZgD6X7ioI1sdxVQ1cZFnDVzvEvuWB9K
	GBFFImY=
X-Google-Smtp-Source: AGHT+IG4TI7OgAmmhc6xFDwX/z+9oTg5SKI73DAr2qf4M9GY8D2eHcbazuxTC4f3BMtxGQXTaP24mw==
X-Received: by 2002:a05:690c:3687:b0:6f9:8605:ec98 with SMTP id 00721157ae682-6fb58377fdamr57088207b3.28.1739741127888;
        Sun, 16 Feb 2025 13:25:27 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb3619ca43sm17769247b3.70.2025.02.16.13.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 13:25:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Feb 2025 16:25:24 -0500
Message-Id: <D7U6RB4K0P69.241M4E5RQZCTL@gmail.com>
To: "Armin Wolf" <W_Armin@gmx.de>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: <platform-driver-x86@vger.kernel.org>, "Hans de Goede"
 <hdegoede@redhat.com>, <Dell.Client.Kernel@dell.com>,
 <linux-kernel@vger.kernel.org>, "Guenter Roeck" <linux@roeck-us.net>
Subject: Re: [PATCH 08/10] platform/x86: alienware-wmi-wmax: Add support for
 manual fan control
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250208051614.10644-1-kuurtb@gmail.com>
 <20250208051614.10644-9-kuurtb@gmail.com>
 <ee2a8428-0c37-408d-9ad2-a8975c1b3c23@gmx.de>
In-Reply-To: <ee2a8428-0c37-408d-9ad2-a8975c1b3c23@gmx.de>

On Sun Feb 16, 2025 at 1:12 AM -05, Armin Wolf wrote:
> Am 08.02.25 um 06:16 schrieb Kurt Borja:
>
>> All models with the "AWCC" WMAX device support a way of manually
>> controlling fans.
>>
>> The PWM duty cycle of a fan can't be controlled directly. Instead the
>> AWCC interface let's us tune a PWM `boost` value, which has the
>> following empirically discovered behavior over the PWM value:
>>
>> 	pwm =3D pwm_base + (pwm_boost / 255) * (pwm_max - pwm_base)
>>
>> Where the pwm_base is the locked PWM value controlled by the EC and
>> pwm_boost is a value between 0 and 255.
>>
>> This pwm_boost knob is exposed as a standard `pwm` attribute.
>
> I am not sure if exposing this over the standard "pwm" attribute is corre=
ct here,
> since userspace applications expect to have full access to the fan when u=
sing the
> "pwm" attribute.
>
> Maybe using a custom attribute like "fanX_boost" would make sense here? E=
ither way

Actually, in the first draft of this patch I actually did this. I
exposed it as pwmX_boost because it behaved like a "percentage" kind of
thing. I'm ok with fanX_boost tho, it's more explicit in it's intention.

> documenting this special behavior would be nice for future users, maybe y=
ou can write
> this down under Documentation/admin-guide/laptops?

Sure! I will. I also want to document the legacy driver features, just
like an historical archive, although some people still use these
features.

--=20
 ~ Kurt

>
> Thanks,
> Armin Wolf
>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>   .../platform/x86/dell/alienware-wmi-wmax.c    | 55 +++++++++++++++++--
>>   1 file changed, 49 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
>> index 5f02da7ff25f..06d6f88ea54b 100644
>> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
>> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/dmi.h>
>>   #include <linux/hwmon.h>
>>   #include <linux/jiffies.h>
>> +#include <linux/minmax.h>
>>   #include <linux/moduleparam.h>
>>   #include <linux/mutex.h>
>>   #include <linux/overflow.h>
>> @@ -176,10 +177,12 @@ enum AWCC_THERMAL_INFORMATION_OPERATIONS {
>>   	AWCC_OP_GET_MIN_RPM			=3D 0x08,
>>   	AWCC_OP_GET_MAX_RPM			=3D 0x09,
>>   	AWCC_OP_GET_CURRENT_PROFILE		=3D 0x0B,
>> +	AWCC_OP_GET_FAN_BOOST			=3D 0x0C,
>>   };
>>
>>   enum AWCC_THERMAL_CONTROL_OPERATIONS {
>>   	AWCC_OP_ACTIVATE_PROFILE		=3D 0x01,
>> +	AWCC_OP_SET_FAN_BOOST			=3D 0x02,
>>   };
>>
>>   enum AWCC_GAME_SHIFT_STATUS_OPERATIONS {
>> @@ -563,12 +566,13 @@ static inline int awcc_thermal_information(struct =
wmi_device *wdev, u8 operation
>>   	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &arg=
s, out);
>>   }
>>
>> -static inline int awcc_thermal_control(struct wmi_device *wdev, u8 prof=
ile)
>> +static inline int awcc_thermal_control(struct wmi_device *wdev, u8 oper=
ation,
>> +				       u8 arg1, u8 arg2)
>>   {
>>   	struct wmax_u32_args args =3D {
>> -		.operation =3D AWCC_OP_ACTIVATE_PROFILE,
>> -		.arg1 =3D profile,
>> -		.arg2 =3D 0,
>> +		.operation =3D operation,
>> +		.arg1 =3D arg1,
>> +		.arg2 =3D arg2,
>>   		.arg3 =3D 0,
>>   	};
>>   	u32 out;
>> @@ -684,6 +688,11 @@ static umode_t awcc_hwmon_is_visible(const void *dr=
vdata, enum hwmon_sensor_type
>>   		if (channel < priv->fan_count)
>>   			return 0444;
>>
>> +		break;
>> +	case hwmon_pwm:
>> +		if (channel < priv->fan_count)
>> +			return 0644;
>> +
>>   		break;
>>   	default:
>>   		break;
>> @@ -698,6 +707,7 @@ static int awcc_hwmon_read(struct device *dev, enum =
hwmon_sensor_types type,
>>   	struct awcc_priv *priv =3D dev_get_drvdata(dev);
>>   	struct awcc_temp_channel_data *temp;
>>   	struct awcc_fan_channel_data *fan;
>> +	u32 fan_boost;
>>   	int ret;
>>
>>   	switch (type) {
>> @@ -742,6 +752,16 @@ static int awcc_hwmon_read(struct device *dev, enum=
 hwmon_sensor_types type,
>>   			return -EOPNOTSUPP;
>>   		}
>>
>> +		break;
>> +	case hwmon_pwm:
>> +		fan =3D &priv->fan_data[channel];
>> +
>> +		ret =3D awcc_thermal_information(priv->wdev, AWCC_OP_GET_FAN_BOOST,
>> +					       fan->id, &fan_boost);
>> +		if (ret)
>> +			return ret;
>> +
>> +		*val =3D fan_boost;
>>   		break;
>>   	default:
>>   		return -EOPNOTSUPP;
>> @@ -796,10 +816,27 @@ static int awcc_hwmon_read_string(struct device *d=
ev, enum hwmon_sensor_types ty
>>   	return 0;
>>   }
>>
>> +
>> +static int awcc_hwmon_write(struct device *dev, enum hwmon_sensor_types=
 type,
>> +			    u32 attr, int channel, long val)
>> +{
>> +	struct awcc_priv *priv =3D dev_get_drvdata(dev);
>> +	u8 fan_id =3D priv->fan_data[channel].id;
>> +
>> +	switch (type) {
>> +	case hwmon_pwm:
>> +		return awcc_thermal_control(priv->wdev, AWCC_OP_SET_FAN_BOOST,
>> +					    fan_id, (u8)clamp_val(val, 0, 255));
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>>   static const struct hwmon_ops awcc_hwmon_ops =3D {
>>   	.is_visible =3D awcc_hwmon_is_visible,
>>   	.read =3D awcc_hwmon_read,
>>   	.read_string =3D awcc_hwmon_read_string,
>> +	.write =3D awcc_hwmon_write,
>>   };
>>
>>   static const struct hwmon_channel_info * const awcc_hwmon_info[] =3D {
>> @@ -814,6 +851,12 @@ static const struct hwmon_channel_info * const awcc=
_hwmon_info[] =3D {
>>   			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>>   			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX
>>   			   ),
>> +	HWMON_CHANNEL_INFO(pwm,
>> +			   HWMON_PWM_INPUT,
>> +			   HWMON_PWM_INPUT,
>> +			   HWMON_PWM_INPUT,
>> +			   HWMON_PWM_INPUT
>> +			   ),
>>   	NULL
>>   };
>>
>> @@ -954,8 +997,8 @@ static int awcc_platform_profile_set(struct device *=
dev,
>>   		}
>>   	}
>>
>> -	return awcc_thermal_control(priv->wdev,
>> -				    priv->supported_profiles[profile]);
>> +	return awcc_thermal_control(priv->wdev, AWCC_OP_ACTIVATE_PROFILE,
>> +				    priv->supported_profiles[profile], 0);
>>   }
>>
>>   static int awcc_platform_profile_probe(void *drvdata, unsigned long *c=
hoices)


