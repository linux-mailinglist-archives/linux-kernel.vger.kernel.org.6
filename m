Return-Path: <linux-kernel+bounces-516800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CF5A3778B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0DA16D6FF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B341A23BB;
	Sun, 16 Feb 2025 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy3gVKEo"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD7154C05;
	Sun, 16 Feb 2025 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739739114; cv=none; b=Y9C8wJxkmKt9U5eblaUj9ZzR0n49WkQ9prpNOQNmsYWcgsBNDqiv9dWszMWpgnghayPbssCyav/aiEFzIAx1dMbIU2q+sFRiDb5sVJwd0Ps7azBA//rjnGGi6DurffCxEANF8KQBEN06pYaUa+lCEz2ngY+VzFA0FIFPU+h51Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739739114; c=relaxed/simple;
	bh=BrpA3l+2n6Nq/uGQE4gTPKuOF0Pai2nC7rXu5IBvn9c=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=O82wIrhlaqkIVGlXN4eUMiU8vkUIujO7gavaZL/h85B6ZIlTwcvCuUQyuF1YR5mIrXN+EiYv2bAu4+2dUNFv5Foq/qDcy7c4POxpHwn6R6UPAL+X0btyV+ApdUSnToxbzsJr/DZqYFinZ9I5Cb2qRGMaH+kJfK/+8Q0EBAkiOdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy3gVKEo; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-51f22008544so861966e0c.1;
        Sun, 16 Feb 2025 12:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739739111; x=1740343911; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NFk5d1V9EeWf3Xb+FFc2lzAJ9ZowlqP/3v41O4FTus=;
        b=Cy3gVKEoSSW/DdjViU33u1BR1kPkfI1YYlbqctqlyC3ilAQIEFDHgzNqvouMJN6fM0
         bibV0g/QqKjGp35RlEJeFmittONy5OxzHgje70uyia+1XFdKWNAXdKy3So13X/TZpSdn
         U8ZQmtwehf1JDiAg2noEOWRHkZOcNGH/LtK2cKT3Pme2A7e5Ij0Jz5lJjIhDrcKsO9i8
         9oo1F7yNLyvXHZGdJK1BKXx+HQYePLqZDmYsL0sHSwxm3ETBgUkOjQrBtXizNYCMOi0r
         bfHCJRbInQKbtrR0GmR+Oyp12zyXXVIh1TNJenDJV4mMvpsidvB3DiIX8RjcvwQjada1
         WQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739739111; x=1740343911;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5NFk5d1V9EeWf3Xb+FFc2lzAJ9ZowlqP/3v41O4FTus=;
        b=Dtj5AyE6RJL3lp4VZBKhZz+5IH+jfO4fWw0ejRGGSQ6ASw4/kMEK4EWIfIkrBf2zmg
         Yx8//FS0XXCDVqRRs6Q7Xo4bU2VS5LpP5HDyT0F/T8/HtcdTbANU+4lcaULrke+pz/aD
         f3+Luj65X7FUsgGQ4CcrDKFGaBUCzIjTQFYY1qBdHAsSFaTgjUYQf51XSQAuannXKueZ
         r96Cb5QCBWHQrcEt3sTgMOPGBgvBKHclj0kM3GDYZVsvDOLHhjQTJ06jXe9PO2P7AYEb
         sMVVZpWh1MaAVsAiZI7z22MdLbu4ZKy6AJzuoV3xQZ9sirpXrBVP4/CAyTZO8Z07P7Vc
         nSfg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3PTs1L/afYBx3vUpLUa5dHRHpBqlWBounHDMYShw4chScvrLYLImJj9UalBU95BN/Un3G+eR6S2UMaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY4rr/wvQDIckZx8CMkEZeec05VQQAs4gIUWotHdtyll6c3Loo
	GA6cwWRFXrifptMvNkg0/686KOrKmSG4YrWZJoOpHAejswDBtxbq
X-Gm-Gg: ASbGncsmg/GIAakTGpJCuxlHYl02Ry1RIcukL70+fvJ38zPdPRKVrnbPqZpmwME9EEs
	h0Zj9wXWJeKOhee69Wo6jChQVM1NOzbMexBokp0zNKQnTK6xqV/TwmFMjRoBrg537NEX8XePk9S
	+Gm0CW81kZvpcKdcjkTwAZcYx/R1n+rdEq2hVKIKRMHgIrTE1UAok9cV3jDD7JGR2dikTu98ytk
	UoI+gwLhtE7pFjkLaVvFr++Sks9MB6gb5cTcN/uQAE/2jfXJM4HWl5etJYUWdPvziXX62kR1hjq
	ZQwDLlc=
X-Google-Smtp-Source: AGHT+IG2N78cW4YGg4rxaPygnbkkTAECRHXPQG2ZyjiuN21wiml8PThQ7nD3F1zsGXpTtaZVFZFp5Q==
X-Received: by 2002:a05:6122:20a3:b0:520:6773:e5c5 with SMTP id 71dfb90a1353d-5209dbffe19mr2785335e0c.7.1739739110766;
        Sun, 16 Feb 2025 12:51:50 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-520bcb307f6sm146552e0c.25.2025.02.16.12.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 12:51:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Feb 2025 15:51:47 -0500
Message-Id: <D7U61KGOZE98.1M14RIIPBVFNC@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Armin Wolf" <W_Armin@gmx.de>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: <platform-driver-x86@vger.kernel.org>, "Hans de Goede"
 <hdegoede@redhat.com>, <Dell.Client.Kernel@dell.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/10] platform/x86: alienware-wmi: Improve and update
 documentation
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250208051614.10644-1-kuurtb@gmail.com>
 <20250208051614.10644-11-kuurtb@gmail.com>
 <b65ffe38-78a3-4d37-b1d1-366bc6870665@gmx.de>
In-Reply-To: <b65ffe38-78a3-4d37-b1d1-366bc6870665@gmx.de>

On Sun Feb 16, 2025 at 1:22 AM -05, Armin Wolf wrote:
> Am 08.02.25 um 06:16 schrieb Kurt Borja:
>
>> Use tables to describe method operations instead of using pseudo-code.
>> Drop unknown method descriptions to avoid redundancy. Drop GPIO section
>> as it is currently irrelevant to this driver. Update Thermal_Information
>> method documentation. Add one more helpful developer to the kudos sectio=
n.
>>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>   Documentation/wmi/devices/alienware-wmi.rst | 390 ++++++--------------
>>   1 file changed, 122 insertions(+), 268 deletions(-)
>>
>> diff --git a/Documentation/wmi/devices/alienware-wmi.rst b/Documentation=
/wmi/devices/alienware-wmi.rst
>> index ddc5e561960e..2bb3abfd9cd7 100644
>> --- a/Documentation/wmi/devices/alienware-wmi.rst
>> +++ b/Documentation/wmi/devices/alienware-wmi.rst
>> @@ -11,7 +11,7 @@ The WMI device WMAX has been implemented for many Alie=
nware and Dell's G-Series
>>   models. Throughout these models, two implementations have been identif=
ied. The
>>   first one, used by older systems, deals with HDMI, brightness, RGB, am=
plifier
>>   and deep sleep control. The second one used by newer systems deals pri=
marily
>> -with thermal, overclocking, and GPIO control.
>> +with thermal control and overclocking.
>>
>>   It is suspected that the latter is used by Alienware Command Center (A=
WCC) to
>>   manage manufacturer predefined thermal profiles. The alienware-wmi dri=
ver
>> @@ -69,9 +69,6 @@ data using the `bmfdec <https://github.com/pali/bmfdec=
>`_ utility:
>>      [WmiMethodId(164), Implemented, read, write, Description("Tobii Cam=
era Power Off.")] void TobiiCameraPowerOff([out] uint32 argr);
>>    };
>>
>> -Some of these methods get quite intricate so we will describe them usin=
g
>> -pseudo-code that vaguely resembles the original ASL code.
>> -
>>   Methods not described in the following document have unknown behavior.
>>
>>   Argument Structure
>> @@ -87,175 +84,136 @@ ID 0xA0, the argument you would pass to the method=
 is 0xA001.
>>   Thermal Methods
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> -WMI method Thermal_Information([in] uint32 arg2, [out] uint32 argr)
>> --------------------------------------------------------------------
>> -
>> -::
>> -
>> - if BYTE_0(arg2) =3D=3D 0x01:
>> -         argr =3D 1
>> -
>> - if BYTE_0(arg2) =3D=3D 0x02:
>> -         argr =3D SYSTEM_DESCRIPTION
>> -
>> - if BYTE_0(arg2) =3D=3D 0x03:
>> -         if BYTE_1(arg2) =3D=3D 0x00:
>> -                 argr =3D FAN_ID_0
>> -
>> -         if BYTE_1(arg2) =3D=3D 0x01:
>> -                 argr =3D FAN_ID_1
>> -
>> -         if BYTE_1(arg2) =3D=3D 0x02:
>> -                 argr =3D FAN_ID_2
>> -
>> -         if BYTE_1(arg2) =3D=3D 0x03:
>> -                 argr =3D FAN_ID_3
>> -
>> -         if BYTE_1(arg2) =3D=3D 0x04:
>> -                 argr =3D SENSOR_ID_CPU | 0x0100
>> -
>> -         if BYTE_1(arg2) =3D=3D 0x05:
>> -                 argr =3D SENSOR_ID_GPU | 0x0100
>> -
>> -         if BYTE_1(arg2) =3D=3D 0x06:
>> -                 argr =3D THERMAL_MODE_QUIET_ID
>> -
>> -         if BYTE_1(arg2) =3D=3D 0x07:
>> -                 argr =3D THERMAL_MODE_BALANCED_ID
>> -
>> -         if BYTE_1(arg2) =3D=3D 0x08:
>> -                 argr =3D THERMAL_MODE_BALANCED_PERFORMANCE_ID
>> -
>> -         if BYTE_1(arg2) =3D=3D 0x09:
>> -                 argr =3D THERMAL_MODE_PERFORMANCE_ID
>> -
>> -         if BYTE_1(arg2) =3D=3D 0x0A:
>> -                 argr =3D THERMAL_MODE_LOW_POWER_ID
>> -
>> -         if BYTE_1(arg2) =3D=3D 0x0B:
>> -                 argr =3D THERMAL_MODE_GMODE_ID
>> -
>> -         else:
>> -                 argr =3D 0xFFFFFFFF
>> -
>> - if BYTE_0(arg2) =3D=3D 0x04:
>> -         if is_valid_sensor(BYTE_1(arg2)):
>> -                 argr =3D SENSOR_TEMP_C
>> -         else:
>> -                 argr =3D 0xFFFFFFFF
>> -
>> - if BYTE_0(arg2) =3D=3D 0x05:
>> -         if is_valid_fan(BYTE_1(arg2)):
>> -                 argr =3D FAN_RPM()
>> -
>> - if BYTE_0(arg2) =3D=3D 0x06:
>> -         skip
>> -
>> - if BYTE_0(arg2) =3D=3D 0x07:
>> -         argr =3D 0
>> -
>> - If BYTE_0(arg2) =3D=3D 0x08:
>> -         if is_valid_fan(BYTE_1(arg2)):
>> -                 argr =3D 0
>> -         else:
>> -                 argr =3D 0xFFFFFFFF
>> -
>> - if BYTE_0(arg2) =3D=3D 0x09:
>> -         if is_valid_fan(BYTE_1(arg2)):
>> -                 argr =3D FAN_UNKNOWN_STAT_0()
>> -
>> -         else:
>> -                 argr =3D 0xFFFFFFFF
>> -
>> - if BYTE_0(arg2) =3D=3D 0x0A:
>> -         argr =3D THERMAL_MODE_BALANCED_ID
>> -
>> - if BYTE_0(arg2) =3D=3D 0x0B:
>> -         argr =3D CURRENT_THERMAL_MODE()
>> -
>> - if BYTE_0(arg2) =3D=3D 0x0C:
>> -         if is_valid_fan(BYTE_1(arg2)):
>> -                 argr =3D FAN_UNKNOWN_STAT_1()
>> -         else:
>> -                 argr =3D 0xFFFFFFFF
>> -
>> -Operation 0x02 returns a *system description* buffer with the following
>> -structure:
>> -
>> -::
>> -
>> - out[0] -> Number of fans
>> - out[1] -> Number of sensors
>> - out[2] -> 0x00
>> - out[3] -> Number of thermal modes
>> +WMI method GetFanSensors([in] uint32 arg2, [out] uint32 argr)
>> +-------------------------------------------------------------
>>
>> -Operation 0x03 list all available fan IDs, sensor IDs and thermal profi=
le
>> -codes in order, but different models may have different number of fans =
and
>> -thermal profiles. These are the known ranges:
>> ++--------------------+------------------------------------+------------=
--------+
>> +| Operation (Byte 0) | Description                        | Arguments  =
        |
>> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
>> +| 0x01               | Get the number of fans for a given | - Byte 1: F=
an ID   |
>> +|                    | fan ID.                            |            =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>> +| 0x02               | Get the temperature sensor ID      | - Byte 1: F=
an ID   |
>> +|                    | related to a fan sensor ID         |            =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>
> After looking at a acpidump from a alienware machine i discovered that op=
eration 0x02
> takes a second argument which acts like an index.
>
> Could it be that operation 0x01 actually returns the number of temperatur=
e sensors
> associated with a given fan which can then be queried using operation 0x0=
2?

After reading a couple of acpidumps, I think you might be right.

It's hard to know because in all laptops I've seen, operation 0x01
returns 1 for all fans. The only exception is the Alienware Aurora
series, where it seems your hypothesis holds true. However even in this
model, op 0x02 list all sensors for almost all fans so I don't know how
to interpret that.

Anyway, I'm going with your hypothesis because 0x01 does give the
correct upper bound for op 0x02 index. I'll think how to reconcile this
with my approach for fan labels.

Btw, what is the model of the acpidump you mentioned? Can you please
send it to me? I keep a private stash of acpidumps for alienware
devices.

>
>>
>> -* Fan IDs: from 2 up to 4
>> -* Sensor IDs: 2
>> -* Thermal profile codes: from 1 up to 7
>> +WMI method Thermal_Information([in] uint32 arg2, [out] uint32 argr)
>> +-------------------------------------------------------------------
>>
>> -In total BYTE_1(ARG2) may range from 0x5 up to 0xD depending on the mod=
el.
>> ++--------------------+------------------------------------+------------=
--------+
>> +| Operation (Byte 0) | Description                        | Arguments  =
        |
>> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
>> +| 0x01               | Unknown.                           | - None     =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>> +| 0x02               | Get system description number with | - None     =
        |
>> +|                    | the following structure:           |            =
        |
>> +|                    |                                    |            =
        |
>> +|                    | - Byte 0: Number of fans           |            =
        |
>> +|                    | - Byte 1: Number of temperature    |            =
        |
>> +|                    |   sensors                          |            =
        |
>> +|                    | - Byte 2: Unknown                  |            =
        |
>> +|                    | - Byte 3: Number of thermal        |            =
        |
>> +|                    |   profiles                         |            =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>> +| 0x03               | List an ID or resource at a given  | - Byte 1: I=
ndex    |
>> +|                    | index. Fan IDs, temperature IDs,   |            =
        |
>> +|                    | unknown IDs and thermal profile    |            =
        |
>> +|                    | IDs are listed in that exact       |            =
        |
>> +|                    | order.                             |            =
        |
>> +|                    |                                    |            =
        |
>> +|                    | Operation 0x02 is used to know     |            =
        |
>> +|                    | which indexes map to which         |            =
        |
>> +|                    | resources.                         |            =
        |
>> +|                    |                                    |            =
        |
>> +|                    | **Returns:** ID at a given index   |            =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>> +| 0x04               | Get the current temperature for a  | - Byte 1: S=
ensor   |
>> +|                    | given temperature sensor.          |   ID       =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>> +| 0x05               | Get the current RPM for a given    | - Byte 1: F=
an ID   |
>> +|                    | fan.                               |            =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>> +| 0x06               | Get fan speed percentage. (not     | - Byte 1: F=
an ID   |
>> +|                    | implemented in every model)        |            =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>> +| 0x07               | Unknown.                           | - Unknown  =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>> +| 0x08               | Get minimum RPM for a given FAN    | - Byte 1: F=
an ID   |
>> +|                    | ID.                                |            =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>> +| 0x09               | Get maximum RPM for a given FAN    | - Byte 1: F=
an ID   |
>> +|                    | ID.                                |            =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>> +| 0x09               | Get maximum RPM for a given FAN    | - Byte 1: F=
an ID   |
>> +|                    | ID.                                |            =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>
> Duplicated entry here.

Thanks!

>
> Other than that the new documentation looks quite good.

The old one was quite ugly so I'm happy with this too :p

--=20
 ~ Kurt

>
> Thanks,
> Armin Wolf
>
>> +| 0x0A               | Get balanced thermal profile ID.   | - None     =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>> +| 0x0B               | Get current thermal profile ID.    | - None     =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>> +| 0x0C               | Get current `boost` value for a    | - Byte 1: F=
an ID   |
>> +|                    | given fan ID.                      |            =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>>
>>   WMI method Thermal_Control([in] uint32 arg2, [out] uint32 argr)
>>   ---------------------------------------------------------------
>>
>> -::
>> -
>> - if BYTE_0(arg2) =3D=3D 0x01:
>> -         if is_valid_thermal_profile(BYTE_1(arg2)):
>> -                 SET_THERMAL_PROFILE(BYTE_1(arg2))
>> -                 argr =3D 0
>> -
>> - if BYTE_0(arg2) =3D=3D 0x02:
>> -         if is_valid_fan(BYTE_1(arg2)):
>> -                 SET_FAN_SPEED_MULTIPLIER(BYTE_2(arg2))
>> -                 argr =3D 0
>> -         else:
>> -                 argr =3D 0xFFFFFFFF
>> -
>> -.. note::
>> -   While you can manually change the fan speed multiplier with this met=
hod,
>> -   Dell's BIOS tends to overwrite this changes anyway.
>> ++--------------------+------------------------------------+------------=
--------+
>> +| Operation (Byte 0) | Description                        | Arguments  =
        |
>> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
>> +| 0x01               | Activate a given thermal profile.  | - Byte 1: T=
hermal  |
>> +|                    |                                    |   profile I=
D       |
>> ++--------------------+------------------------------------+------------=
--------+
>> +| 0x02               | Set a `boost` value for a given    | - Byte 1: F=
an ID   |
>> +|                    | fan ID.                            | - Byte 2: B=
oost    |
>> ++--------------------+------------------------------------+------------=
--------+
>>
>>   These are the known thermal profile codes:
>>
>> -::
>> -
>> - CUSTOM                         0x00
>> -
>> - BALANCED_USTT                  0xA0
>> - BALANCED_PERFORMANCE_USTT      0xA1
>> - COOL_USTT                      0xA2
>> - QUIET_USTT                     0xA3
>> - PERFORMANCE_USTT               0xA4
>> - LOW_POWER_USTT                 0xA5
>> -
>> - QUIET                          0x96
>> - BALANCED                       0x97
>> - BALANCED_PERFORMANCE           0x98
>> - PERFORMANCE                    0x99
>> -
>> - GMODE                          0xAB
>> -
>> -Usually if a model doesn't support the first four profiles they will su=
pport
>> -the User Selectable Thermal Tables (USTT) profiles and vice-versa.
>> -
>> -GMODE replaces PERFORMANCE in G-Series laptops.
>> ++------------------------------+----------+------+
>> +| Thermal Profile              | Type     | ID   |
>> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D+
>> +| Custom                       | Special  | 0x00 |
>> ++------------------------------+----------+------+
>> +| G-Mode                       | Special  | 0xAB |
>> ++------------------------------+----------+------+
>> +| Quiet                        | Legacy   | 0x96 |
>> ++------------------------------+----------+------+
>> +| Balanced                     | Legacy   | 0x97 |
>> ++------------------------------+----------+------+
>> +| Balanced Performance         | Legacy   | 0x98 |
>> ++------------------------------+----------+------+
>> +| Performance                  | Legacy   | 0x99 |
>> ++------------------------------+----------+------+
>> +| Balanced                     | USTT     | 0xA0 |
>> ++------------------------------+----------+------+
>> +| Balanced Performance         | USTT     | 0xA1 |
>> ++------------------------------+----------+------+
>> +| Cool                         | USTT     | 0xA2 |
>> ++------------------------------+----------+------+
>> +| Quiet                        | USTT     | 0xA3 |
>> ++------------------------------+----------+------+
>> +| Performance                  | USTT     | 0xA4 |
>> ++------------------------------+----------+------+
>> +| Low Power                    | USTT     | 0xA5 |
>> ++------------------------------+----------+------+
>> +
>> +If a model supports the User Selectable Thermal Tables (USTT) profiles,=
 it will
>> +not support the Legacy profiles and vice-versa.
>> +
>> +Every model supports the CUSTOM (0x00) thermal profile. GMODE replaces
>> +PERFORMANCE in G-Series laptops.
>>
>>   WMI method GameShiftStatus([in] uint32 arg2, [out] uint32 argr)
>>   ---------------------------------------------------------------
>>
>> -::
>> -
>> - if BYTE_0(arg2) =3D=3D 0x1:
>> -         TOGGLE_GAME_SHIFT()
>> -         argr =3D GET_GAME_SHIFT_STATUS()
>> -
>> - if BYTE_0(arg2) =3D=3D 0x2:
>> -         argr =3D GET_GAME_SHIFT_STATUS()
>> ++--------------------+------------------------------------+------------=
--------+
>> +| Operation (Byte 0) | Description                        | Arguments  =
        |
>> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
>> +| 0x01               | Toggle *Game Shift*.               | - None     =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>> +| 0x02               | Get *Game Shift* status.           | - None     =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>>
>>   Game Shift Status does not change the fan speed profile but it could b=
e some
>>   sort of CPU/GPU power profile. Benchmarks have not been done.
>> @@ -267,131 +225,27 @@ Thermal_Information does not list it.
>>   G-key on Dell's G-Series laptops also changes Game Shift status, so bo=
th are
>>   directly related.
>>
>> -WMI method GetFanSensors([in] uint32 arg2, [out] uint32 argr)
>> --------------------------------------------------------------
>> -
>> -::
>> -
>> - if BYTE_0(arg2) =3D=3D 0x1:
>> -        if is_valid_fan(BYTE_1(arg2)):
>> -                argr =3D 1
>> -        else:
>> -                argr =3D 0
>> -
>> - if BYTE_0(arg2) =3D=3D 0x2:
>> -        if is_valid_fan(BYTE_1(arg2)):
>> -                if BYTE_2(arg2) =3D=3D 0:
>> -                        argr =3D=3D SENSOR_ID
>> -                else
>> -                        argr =3D=3D 0xFFFFFFFF
>> -        else:
>> -                argr =3D 0
>> -
>>   Overclocking Methods
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> -.. warning::
>> -   These methods have not been tested and are only partially reverse
>> -   engineered.
>> -
>> -WMI method Return_OverclockingReport([out] uint32 argr)
>> --------------------------------------------------------
>> -
>> -::
>> -
>> - CSMI (0xE3, 0x99)
>> - argr =3D 0
>> -
>> -CSMI is an unknown operation.
>> -
>> -WMI method Set_OCUIBIOSControl([in] uint32 arg2, [out] uint32 argr)
>> --------------------------------------------------------------------
>> -
>> -::
>> -
>> - CSMI (0xE3, 0x99)
>> - argr =3D 0
>> -
>> -CSMI is an unknown operation.
>> -
>> -WMI method Clear_OCFailSafeFlag([out] uint32 argr)
>> ---------------------------------------------------
>> -
>> -::
>> -
>> - CSMI (0xE3, 0x99)
>> - argr =3D 0
>> -
>> -CSMI is an unknown operation.
>> -
>> -
>>   WMI method MemoryOCControl([in] uint32 arg2, [out] uint32 argr)
>>   ---------------------------------------------------------------
>>
>>   AWCC supports memory overclocking, but this method is very intricate a=
nd has
>>   not been deciphered yet.
>>
>> -GPIO methods
>> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> -
>> -These methods are probably related to some kind of firmware update syst=
em,
>> -through a GPIO device.
>> -
>> -.. warning::
>> -   These methods have not been tested and are only partially reverse
>> -   engineered.
>> -
>> -WMI method FWUpdateGPIOtoggle([in] uint32 arg2, [out] uint32 argr)
>> -------------------------------------------------------------------
>> -
>> -::
>> -
>> - if BYTE_0(arg2) =3D=3D 0:
>> -         if BYTE_1(arg2) =3D=3D 1:
>> -                 SET_PIN_A_HIGH()
>> -         else:
>> -                 SET_PIN_A_LOW()
>> -
>> - if BYTE_0(arg2) =3D=3D 1:
>> -         if BYTE_1(arg2) =3D=3D 1:
>> -                 SET_PIN_B_HIGH()
>> -
>> -         else:
>> -                 SET_PIN_B_LOW()
>> -
>> - else:
>> -         argr =3D 1
>> -
>> -WMI method ReadTotalofGPIOs([out] uint32 argr)
>> -----------------------------------------------
>> -
>> -::
>> -
>> - argr =3D 0x02
>> -
>> -WMI method ReadGPIOpPinStatus([in] uint32 arg2, [out] uint32 argr)
>> -------------------------------------------------------------------
>> -
>> -::
>> -
>> - if BYTE_0(arg2) =3D=3D 0:
>> -         argr =3D PIN_A_STATUS
>> -
>> - if BYTE_0(arg2) =3D=3D 1:
>> -         argr =3D PIN_B_STATUS
>> -
>>   Other information Methods
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>>
>>   WMI method ReadChassisColor([out] uint32 argr)
>>   ----------------------------------------------
>>
>> -::
>> -
>> - argr =3D CHASSIS_COLOR_ID
>> +Returns the chassis color internal ID.
>>
>>   Acknowledgements
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> -Kudos to `AlexIII <https://github.com/AlexIII/tcc-g15>`_ for documentin=
g
>> -and testing available thermal profile codes.
>> +Kudos to `AlexIII <https://github.com/AlexIII/tcc-g15>`_ and
>> +`T-Troll <https://github.com/T-Troll/alienfx-tools/>`_ for documenting =
and
>> +testing some of this device's functionality, making it possible to gene=
ralize
>> +this driver.


