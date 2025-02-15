Return-Path: <linux-kernel+bounces-516357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06540A37013
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 19:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945B71891C42
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968941EDA34;
	Sat, 15 Feb 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtCNTvE0"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206EA1519A7;
	Sat, 15 Feb 2025 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739642876; cv=none; b=gsspS5t9vBcXeVpyDSusIOkg6BDxqdMRjSoU3+XO5HljkgIic5atUpxw0xCMH+5Ww8BId7KJl2T1lUzK1FDhpXfwgWr9coK9Ft6k0KOVjMqsckZKDjYzZRjKodtEQS+PIfkhOAFsRjBs7eeXeyR2XwwT8HwkbWncBUIvGrON1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739642876; c=relaxed/simple;
	bh=dW4Uegw/mUFZt2w5HHOM3Nn05DWe/c3zYY5FPJZtXZg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Yf5ITKwFYROGJ3q9Y0kFQHAzNN+7kgy42EVdPCpaI9RGNaXvZHkf+xF0E7zE1Nn11nVgpMlSf7JQ7ie90wt3kIatb5uvEMZE2kiLTRZxQVKWQFo1S56VmVdYokIISE0T/vUp7uoEKkh1KrMlP+G7rQuhcLWd3xq9F5ar+sbuONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtCNTvE0; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4bd3989f027so808897137.1;
        Sat, 15 Feb 2025 10:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739642873; x=1740247673; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtvcV3K69dhkgwAFiQ/4ZsXpglqzKr0Q8XTSofHALXI=;
        b=EtCNTvE0JCdPwcloVaAqAVPw0BnKMjloplPLWLRFw3bxC0h5JB8/mCdaay2E26nqrE
         +oq+LMKfx1Txpjx+74qU39Tdz1arwnT0kP4KNhfuufWaWNCLu7HNDBrGkb3GIQG1ZCAq
         SzJv28BKqckEofEcMBtuJYPp1Qs/tFORepUEc1oiCnF6fmAfIl2XZ0dvx24fYApTiwVY
         T0DviU7U7mAyiVYLbmVCKQEk/22cUocS/tEcT6I7ZOUDNSrCbd7cXhtnxeYMnMBhlmNl
         3P0OHgiCB3H64Ws5lHlqhK6U6YMv/fLvBID95JPHiT6lstK0iD4WTmEKXyQDFhHSW8dN
         biPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739642873; x=1740247673;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CtvcV3K69dhkgwAFiQ/4ZsXpglqzKr0Q8XTSofHALXI=;
        b=AUcLOplSKMwxOq3N3m1GWflWXBCl1y5BzgK9nvRDn4KnBuu3UXX2C7HNqhL0HOV2aj
         TnisyXuxh7lutYFK8ax/cl5W50kW0cLFvMIh6bVZdfIgpTqkDg355nLee1ywPYwo1RXJ
         yeZWXjoVUhNEALEaZ9Y8GVGB3ClCD02b/qiqenaCdu8bffgOL+Og1UpCwiLIpIWy4sPk
         2s7fRsbpoUMFaf7BCE67Cquymg5WbA4hps2pXjVV/uLBeEBIYNXfWsAt+p79Ln9FGLM0
         UeOZ9/zJ1hQEk2bD0M75TXvaYWJ6s7i/84t/sqI1Q32m2fDimIP7+6vSLANWuCfhCekL
         K5Ag==
X-Forwarded-Encrypted: i=1; AJvYcCU2jrnMI7D8NABDrdUBrqlA7VjLl5dWLTdZv7XwqILS2XFsC6tMa9UHUJTP1KFKnUTP6fN8pFxjutwFNQQ=@vger.kernel.org, AJvYcCWeqL+R11hA5iqnCVgX2CY+993G5I4C9OMGMm7+xjhjdZYiwCQa3RgA9efDGBTNAzjABcwjgk47gIPXOZ8oqLUx98zldw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwprsUfH48vxKmKG+dpA5R4ssGVg4dmESEbyQm9SnjgSZzjO8yT
	Rcrz1BDu86kCyv5WGhMASY4Z20pHEncktk5Mw9ubVqU/EqwMyOc1
X-Gm-Gg: ASbGncvpaZHutjfWiTixlyF5vmEEux83YS41sDdc4fo6pPOVmXzTcaqjXIA3OQHef/I
	kvT+bYO22zDbX+JUL7ufW/R4l/b4CJTmtVtP78dysGm8J6NGGnHNmU4gt/kZR0n0l2eVQYD9VaT
	Fah9SnU8smsQqowsGsOhJXflu0u8C5RhMu7MUaXL16rsRor9Kax8WHKGc6F5WwHQZ5UzILQvLaQ
	FbiLNzC21DHdasXX+RcnIln60AwrwZ4e5Z5wdk3CokkZYP22rk4llcmwoeMi2bZSAhhd0nQc85E
	AKtzIPCT6A==
X-Google-Smtp-Source: AGHT+IHqsTlfI0bz0IAInOY2DnooUDhMiuHXWzAMJ+ZtHpAJRXFi0G2IbyCsc2+WQQ7gAmOhJYJ1zg==
X-Received: by 2002:a05:6102:510f:b0:4bb:dd1c:dcff with SMTP id ada2fe7eead31-4bd5045eb8bmr1760086137.2.1739642872678;
        Sat, 15 Feb 2025 10:07:52 -0800 (PST)
Received: from localhost ([2800:bf0:179:113e:cafc:c7f7:3156:ba62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bc13d53651sm946033137.17.2025.02.15.10.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 10:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 15 Feb 2025 13:07:50 -0500
Message-Id: <D7T7XHTX1SS2.NTHM4WBUN8EC@gmail.com>
Subject: Re: [RFC PATCH 1/3] platform/x86: acer-wmi: Fix setting of fan
 behavior
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Armin Wolf" <W_Armin@gmx.de>, <jlee@suse.com>,
 <basak.sb2006@gmail.com>, <rayanmargham4@gmail.com>
Cc: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250214221322.47298-1-W_Armin@gmx.de>
 <20250214221322.47298-2-W_Armin@gmx.de>
 <D7SMPVK7KM8E.3VYTBGLEVS109@gmail.com>
 <9170b163-9eeb-4710-add2-6cefaef1eaaf@gmx.de>
In-Reply-To: <9170b163-9eeb-4710-add2-6cefaef1eaaf@gmx.de>

On Sat Feb 15, 2025 at 12:40 PM -05, Armin Wolf wrote:
> Am 15.02.25 um 02:30 schrieb Kurt Borja:
>
>> Hi Armin,
>>
>> On Fri Feb 14, 2025 at 5:13 PM -05, Armin Wolf wrote:
>>> After studying the linuwu_sense driver
>>> (https://github.com/0x7375646F/Linuwu-Sense) i was able to understand
>>> the meaning of the SetGamingFanBehavior() WMI method:
>>>
>>> - the first 16-bit are a bitmap of all fans affected by a fan behavior
>>>    change request.
>>>
>>> - the next 8 bits contain four fan mode fields (2-bit), each being
>>>    associated with a bit inside the fan bitmap.
>>>
>>> There are three fan modes: auto, turbo and custom.
>>>
>>> Use this newfound knowledge to fix the turbo fan handling by setting
>>> the correct bits before calling SetGamingFanBehavior(). Also check
>>> the result of the WMI method call and return an error should the ACPI
>>> firmware signal failure.
>>>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>>   drivers/platform/x86/acer-wmi.c | 75 +++++++++++++++++++++++---------=
-
>>>   1 file changed, 52 insertions(+), 23 deletions(-)
>>>
>>> --
>>> 2.39.5
>>>
>>> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/ace=
r-wmi.c
>>> index 69336bd778ee..f20a882e3650 100644
>>> --- a/drivers/platform/x86/acer-wmi.c
>>> +++ b/drivers/platform/x86/acer-wmi.c
>>> @@ -68,10 +68,19 @@ MODULE_LICENSE("GPL");
>>>   #define ACER_WMID_SET_GAMING_LED_METHODID 2
>>>   #define ACER_WMID_GET_GAMING_LED_METHODID 4
>>>   #define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
>>> -#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR 14
>>> +#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID 14
>>>   #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
>>>   #define ACER_WMID_GET_GAMING_MISC_SETTING_METHODID 23
>>>
>>> +#define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
>>> +#define ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK GENMASK_ULL(23, 16)
>>> +
>>> +#define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
>>> +#define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
>>> +
>>> +#define ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK GENMASK(1, 0)
>>> +#define ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK GENMASK(7, 6)
>>> +
>>>   #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
>>>   #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
>>>   #define ACER_GAMING_MISC_SETTING_VALUE_MASK GENMASK_ULL(15, 8)
>>> @@ -121,6 +130,12 @@ enum acer_wmi_predator_v4_sensor_id {
>>>   	ACER_WMID_SENSOR_GPU_TEMPERATURE	=3D 0x0A,
>>>   };
>>>
>>> +enum acer_wmi_gaming_fan_mode {
>>> +	ACER_WMID_FAN_MODE_AUTO		=3D 0x01,
>>> +	ACER_WMID_FAN_MODE_TURBO	=3D 0x02,
>>> +	ACER_WMID_FAN_MODE_CUSTOM	=3D 0x03,
>>> +};
>>> +
>>>   enum acer_wmi_predator_v4_oc {
>>>   	ACER_WMID_OC_NORMAL			=3D 0x0000,
>>>   	ACER_WMID_OC_TURBO			=3D 0x0002,
>>> @@ -1565,9 +1580,6 @@ static acpi_status WMID_gaming_set_u64(u64 value,=
 u32 cap)
>>>   	case ACER_CAP_TURBO_LED:
>>>   		method_id =3D ACER_WMID_SET_GAMING_LED_METHODID;
>>>   		break;
>>> -	case ACER_CAP_TURBO_FAN:
>>> -		method_id =3D ACER_WMID_SET_GAMING_FAN_BEHAVIOR;
>>> -		break;
>>>   	default:
>>>   		return AE_BAD_PARAMETER;
>>>   	}
>>> @@ -1618,25 +1630,42 @@ static int WMID_gaming_get_sys_info(u32 command=
, u64 *out)
>>>   	return 0;
>>>   }
>>>
>>> +static int WMID_gaming_set_fan_behavior(u16 fan_bitmap, u8 mode_bitmap=
)
>>> +{
>>> +	acpi_status status;
>>> +	u64 input =3D 0;
>>> +	u64 result;
>>> +
>>> +	input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_ID_MASK, fan_bitmap);
>>> +	input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK, mode_bi=
tmap);
>>> +
>>> +	status =3D WMI_gaming_execute_u64(ACER_WMID_SET_GAMING_FAN_BEHAVIOR_M=
ETHODID, input,
>>> +					&result);
>>> +	if (ACPI_FAILURE(status))
>>> +		return -EIO;
>>> +
>>> +	/* TODO: Proper error handling */
>>> +	pr_notice("Fan behavior return status: %llu\n", result);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   static void WMID_gaming_set_fan_mode(u8 fan_mode)
>>>   {
>>> -	/* fan_mode =3D 1 is used for auto, fan_mode =3D 2 used for turbo*/
>>> -	u64 gpu_fan_config1 =3D 0, gpu_fan_config2 =3D 0;
>>> -	int i;
>>> -
>>> -	if (quirks->cpu_fans > 0)
>>> -		gpu_fan_config2 |=3D 1;
>>> -	for (i =3D 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
>>> -		gpu_fan_config2 |=3D 1 << (i + 1);
>> This was not replicated bellow. Just to be sure, are there no fans at
>> BIT(1) and BIT(2)?
>
> AFAIK the Acer OEM software support the following fans:
>
> - CPU (BIT(0))
> - GPU 1 (BIT(3))
> - GPU 2 (BIT(4), but untested)
>
> The other bits seem to be unused.

Interesting.

I ask because quirks->cpu_fans + quirks->gpu_fans is currently always 2,
so the line two `-` lines I referenced make the following equivalent
operation:

fan_bitmap |=3D BIT(1);
mode_bitmap |=3D FIELD_PREP(GENMASK(3, 2), fan_mode);

fan_bitmap |=3D BIT(2);
mode_bitmap |=3D FIELD_PREP(GENMASK(5, 4), fan_mode);

So if any model has fans at BIT(1), BIT(2) this may cause regressions if
the behavior is not mimicked.

Am I missing something?

Anyway, your explaination for how this method works makes a lot of
sense, so it is weird that the original author of this is summing the
number of fans and setting this bits in the first place.

--=20
 ~ Kurt

>
> Thanks,
> Armin Wolf
>
>>> -	for (i =3D 0; i < quirks->gpu_fans; ++i)
>>> -		gpu_fan_config2 |=3D 1 << (i + 3);
>>> -	if (quirks->cpu_fans > 0)
>>> -		gpu_fan_config1 |=3D fan_mode;
>>> -	for (i =3D 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
>>> -		gpu_fan_config1 |=3D fan_mode << (2 * i + 2);
>> Same as above.
>>


