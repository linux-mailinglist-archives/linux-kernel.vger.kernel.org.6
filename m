Return-Path: <linux-kernel+bounces-550164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0BFA55C16
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 976027A443B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57818F64;
	Fri,  7 Mar 2025 00:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjZVGvfJ"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31F8748D;
	Fri,  7 Mar 2025 00:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307972; cv=none; b=SGAhr25kbCxySnjODWZ7i1rqbqMwyhfvwOFCDynGPlMQpz4etylUSeFLzE5oKR2kEmbr019NCvgGefVJYg9qK378dpIy0uzbLRTHrUXVwQhzxDY1wHS2zsp4iyRaY20sF1OZ0OjjXbtYT3oRVhDlkoPfzZRCK+M/t0tS1V+79Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307972; c=relaxed/simple;
	bh=p8pLmYRH3QRENrV5uzU4VjQ8Ik66mjTkUL2Jhz9EipM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=e1c8NX4hP9lsTS3KpkY+G5Vpq/RXWVIcPvdpBdO/8X3jyiR+CaF0qW5RjkQWPHzRihR/DZMLWYMLq2P/uIPUwjWVtUV3oFUtO8P/D7l+J0uY41sPz5Mp0ScWliIK6kvNxj6lEVowPzWXadzgmpEN1X4IgGMjlCho/gAaKBbFaqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjZVGvfJ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6fead015247so10840027b3.2;
        Thu, 06 Mar 2025 16:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741307969; x=1741912769; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSDziELdvtQ27y+VafNRWI3jTpSjPxkg2gREvREo14g=;
        b=HjZVGvfJGWAD/cwvw6pEmKqxRKLmmRMBRSBpeXV2TJf2P4+SE8OO5UR2TkPZU/9aWr
         oD43uMSdTLVnQjos8jBI1QsSXe12VyjzBfqqAt7SA3aU7tX9RDRKwE+RsatD0XzgA+yM
         FuchS8K0D8ltAS8b1FqEMFffV8jpMDmpkMrbCIbPKRHc/f7kDrKlcDyL0EA47eG4n5mE
         ZsdiVWHL4onkVFzZeDW5p9BdWLpsJz1c8roJQSzd7mqWZMS8aaG+/EdhWLz3MXXch1sc
         KlHZAsRjj/6B6gTCCWHDrfPdNJQ5jjejCLgmByxQH1crHE5oUIhE3bYFlO/tgyhMLO7R
         0XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741307969; x=1741912769;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RSDziELdvtQ27y+VafNRWI3jTpSjPxkg2gREvREo14g=;
        b=Pzj1rMprgfssZuK3+8YsseKldUoNEW4XzIXbLSY5GKbIGpJLuR3HWknjrVKIKcJeEM
         PbhroGqUGrjUKG8SeIVIvmI6z+lCukZGaMobYhH7yCC23SQ7s5H4mivRi/wIYOSKhk7j
         1t8ZZiznyDET4PQxEZ+OMrHZriQc/93EGQHpyGfjp919rXDDL5XDn0i5di2FoLNAQGKZ
         lCHQOos0MEa8/BkPO0AmExpdMXUm4M6CJAkPpo14vcl7cH7CJnH/7Xckg4bPYQKy7Ndh
         WBt09oD94uA/ThEmnVs5UbYhzLMPIUW8vl2fsAt+DuPsiaduY63tjdjvA7vX75Dlz4LA
         EmOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO8YIrSxsF+6swHkFsspdxDDdVdcrjoq4L/PYi2kGsot/nyDGcmlu4mfoHK7jmxyKQEE3m5Slevp7kvGA=@vger.kernel.org, AJvYcCWpiJosBjE744rWSaSkoGvd3vO+lm5Gl1VKOQiCqav3Gl03nXdaEoD+3S7ir/iEGv0nAKHSaMJCy92YyfZyvWoixYJtVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZvXBE9xqCHgNgTR8l3Y5B9lIfVhDfxgOmaK+8DDFu1DPXhD/
	aBpP5KHZkdrmY0QaC8PtkVk1TQmITK0vJhq84y5HjlC6J56sa+DW
X-Gm-Gg: ASbGncstpVFEE92S7WPQqNRs1RPON9KkelWcX8R+tl2S8YmCqh//i+SselbNHIiQfrf
	xhQQCnGctHE9ExEmAeTV6Y7aD8NmzvA9AiCEgABoukmtKft3WdWgRoFZk1WqNOAGJg0W3L4nYiv
	bH9Q19XCesBtvQX6ePvy+yUy2joKshRrMZzqjjaxtLWagycJH3SYKBtLorxvvl6Dym3RMa1N+Yp
	6pr8YyIgnhHxMcbGcCr8S3pGFujnDETqs0M9ZTsIrAzBq1On2lJKjvsGHGqLAiyMhpugvdelgWD
	G+4RHHIhMz4rnWVWP2+8gfGv4JAWXGDjd40MwA==
X-Google-Smtp-Source: AGHT+IF0j+astwI4KfbJDOrSPGg03R5SkZe95lx4P+jxNBk1jRq8vvWitku4D2pDqnbZzlFixhd0ag==
X-Received: by 2002:a05:690c:6381:b0:6f5:393f:cf48 with SMTP id 00721157ae682-6febf309569mr21809137b3.21.1741307969365;
        Thu, 06 Mar 2025 16:39:29 -0800 (PST)
Received: from localhost ([2800:bf0:61:1288:2be8:bc29:ad13:842f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c64035sm5050517b3.120.2025.03.06.16.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 16:39:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Mar 2025 19:39:26 -0500
Message-Id: <D89M5OKBDI0B.23OXT5IF5Q91S@gmail.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 <platform-driver-x86@vger.kernel.org>, <Dell.Client.Kernel@dell.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 10/10] Documentation: wmi: Improve and update
 alienware-wmi documentation
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Bagas Sanjaya" <bagasdotme@gmail.com>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Armin Wolf" <W_Armin@gmx.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
 <20250305-hwm-v3-10-395e7a1407e2@gmail.com> <Z8o2ZkQmdHkdf13m@archie.me>
In-Reply-To: <Z8o2ZkQmdHkdf13m@archie.me>

On Thu Mar 6, 2025 at 6:57 PM -05, Bagas Sanjaya wrote:
> On Wed, Mar 05, 2025 at 07:57:01PM -0500, Kurt Borja wrote:
>> diff --git a/Documentation/wmi/devices/alienware-wmi.rst b/Documentation=
/wmi/devices/alienware-wmi.rst
>> index ddc5e561960e05fc7cffe700d7d278e32ff2e7b2..79238051b18bc5de9b502325=
017cd5c5fcf41748 100644
>> --- a/Documentation/wmi/devices/alienware-wmi.rst
>> +++ b/Documentation/wmi/devices/alienware-wmi.rst
>> @@ -11,7 +11,7 @@ The WMI device WMAX has been implemented for many Alie=
nware and Dell's G-Series
>>  models. Throughout these models, two implementations have been identifi=
ed. The
>>  first one, used by older systems, deals with HDMI, brightness, RGB, amp=
lifier
>>  and deep sleep control. The second one used by newer systems deals prim=
arily
>> -with thermal, overclocking, and GPIO control.
>> +with thermal control and overclocking.
>> =20
>>  It is suspected that the latter is used by Alienware Command Center (AW=
CC) to
>>  manage manufacturer predefined thermal profiles. The alienware-wmi driv=
er
>> @@ -69,9 +69,6 @@ data using the `bmfdec <https://github.com/pali/bmfdec=
>`_ utility:
>>     [WmiMethodId(164), Implemented, read, write, Description("Tobii Came=
ra Power Off.")] void TobiiCameraPowerOff([out] uint32 argr);
>>   };
>> =20
>> -Some of these methods get quite intricate so we will describe them usin=
g
>> -pseudo-code that vaguely resembles the original ASL code.
>> -
>>  Methods not described in the following document have unknown behavior.
>> =20
>>  Argument Structure
>> @@ -87,175 +84,133 @@ ID 0xA0, the argument you would pass to the method=
 is 0xA001.
>>  Thermal Methods
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =20
>> +WMI method GetFanSensors([in] uint32 arg2, [out] uint32 argr)
>> +-------------------------------------------------------------
>> +
>> ++--------------------+------------------------------------+------------=
--------+
>> +| Operation (Byte 0) | Description                        | Arguments  =
        |
>> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
>> +| 0x01               | Get the number of temperature      | - Byte 1: F=
an ID   |
>> +|                    | sensors related with a fan ID      |            =
        |
>> ++--------------------+------------------------------------+------------=
--------+
>> +| 0x02               | Get the temperature sensor IDs     | - Byte 1: F=
an ID   |
>> +|                    | related to a fan sensor ID         | - Byte 2: I=
ndex    |
>> ++--------------------+------------------------------------+------------=
--------+
>> +
>>  WMI method Thermal_Information([in] uint32 arg2, [out] uint32 argr)
>>  -------------------------------------------------------------------
>> =20
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
>> -
>> -Operation 0x03 list all available fan IDs, sensor IDs and thermal profi=
le
>> -codes in order, but different models may have different number of fans =
and
>> -thermal profiles. These are the known ranges:
>> -
>> -* Fan IDs: from 2 up to 4
>> -* Sensor IDs: 2
>> -* Thermal profile codes: from 1 up to 7
>> -
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
>> =20
>>  WMI method Thermal_Control([in] uint32 arg2, [out] uint32 argr)
>>  ---------------------------------------------------------------
>> =20
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
>> =20
>>  These are the known thermal profile codes:
>> =20
>> -::
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
>> =20
>> - CUSTOM                         0x00
>> +If a model supports the User Selectable Thermal Tables (USTT) profiles,=
 it will
>> +not support the Legacy profiles and vice-versa.
>> =20
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
>> +Every model supports the CUSTOM (0x00) thermal profile. GMODE replaces
>> +PERFORMANCE in G-Series laptops.
>> =20
>>  WMI method GameShiftStatus([in] uint32 arg2, [out] uint32 argr)
>>  ---------------------------------------------------------------
>> =20
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
>> =20
>>  Game Shift Status does not change the fan speed profile but it could be=
 some
>>  sort of CPU/GPU power profile. Benchmarks have not been done.
>> @@ -267,131 +222,27 @@ Thermal_Information does not list it.
>>  G-key on Dell's G-Series laptops also changes Game Shift status, so bot=
h are
>>  directly related.
>> =20
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
>>  Overclocking Methods
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =20
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
>>  WMI method MemoryOCControl([in] uint32 arg2, [out] uint32 argr)
>>  ---------------------------------------------------------------
>> =20
>>  AWCC supports memory overclocking, but this method is very intricate an=
d has
>>  not been deciphered yet.
>> =20
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
>>  Other information Methods
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> =20
>>  WMI method ReadChassisColor([out] uint32 argr)
>>  ----------------------------------------------
>> =20
>> -::
>> -
>> - argr =3D CHASSIS_COLOR_ID
>> +Returns the chassis color internal ID.
>> =20
>>  Acknowledgements
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =20
>> -Kudos to `AlexIII <https://github.com/AlexIII/tcc-g15>`_ for documentin=
g
>> -and testing available thermal profile codes.
>> +Kudos to `AlexIII <https://github.com/AlexIII/tcc-g15>`_ and
>> +`T-Troll <https://github.com/T-Troll/alienfx-tools/>`_ for documenting =
and
>> +testing some of this device's functionality, making it possible to gene=
ralize
>> +this driver.
>>=20
>
> Looks good, thanks!
>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thank you for taking a look!

--=20
 ~ Kurt


