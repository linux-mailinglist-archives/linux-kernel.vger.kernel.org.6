Return-Path: <linux-kernel+bounces-544934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF56CA4E67B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E3C87A1AF1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5233828153D;
	Tue,  4 Mar 2025 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOuFTp3O"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB368281518;
	Tue,  4 Mar 2025 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105328; cv=none; b=cVx02hQzOdoAR+ukdZi+i6GT7oZDyNe+3Y/S9chfPsu5kT5wHMSzbc1B78uPMewaIUiECPpLZokxyNV+zYZNDM/MRKNpdH2MI+hqKda3xQmOPIzU75DIY4QOATZV1ieceTSNOZ25WMoxTghElje5tEK7ynJffd4jUrHpBsdl7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105328; c=relaxed/simple;
	bh=dviPh+42KoycBzS0P0x0jxsFFo479CeZTs8Ts35taFI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=A5pnvxBtlMmNn4WAu+uTJpHHwAn4vjxzwZYm+iFiz9ecim5HRISjxrAt+B/onLhrxokUOedl+P/CAUYNoW7DMiznbQ5dMHkmo93ZjvDQh4yYvcuy3jEan5p04Ff7i5hw7hlfZVOqfMSyym6L0n3Fgez2Z3K0LkGI4padLHrHCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOuFTp3O; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-51eb1a6954cso2416934e0c.0;
        Tue, 04 Mar 2025 08:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741105326; x=1741710126; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/bhrzGwd5X29SdwMkugukVNon30coMwi2kUCBkMu54=;
        b=BOuFTp3OoP8mXYmrTge99lW1UGrBg7efaCz/NRQUWE48Zumoq9+7ZfiI1v1p07Liz3
         ML9ARGW5BKR1jgY/XG3GoEEcQXcurT+L5mq8QJQ1Jwmaq9AYwzC4SLPKtAuT5uGg/ZVG
         EcYK5Ds3UjzsX/Eumc68vldYmq8nj9qTjfkt1sJHZv01Mbv9aWlujwvIwZD2Ii5R98Va
         M4vFxELkGwDmLgVNp9QjTxLoMDLA6AGfYD96HhTNlMZgHOpuRycZoB+Tgkf/2AUaxZzb
         qw9HjOx3cM7X6cYKDV9LF6ZuxrjnERJdFPCF/9Tf4JJ+8pj86BPBZlMvD4RFnwRQS/9d
         F1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105326; x=1741710126;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H/bhrzGwd5X29SdwMkugukVNon30coMwi2kUCBkMu54=;
        b=KzXxwYcouILJRkz4yfbwp5bXYlZulJCAz5Yo1p+KFfcF1dolZtKB9REuYBfdSPHP6a
         E7dkOs2GGrAm+ifi7UHTKE/o1yiGallT/2ZADwplWzz1ub0OBe/RNC3xXZW7IyV3fKhk
         LHXWW9AQJ9VNMuipEor7L2TYJgFPGL+0a7K7g2Lcdg6x8TG9me88cwlXPQczCnPayHU6
         h88RI9eABAPDSIzbCzydKb1ZWDIZ5AUo0rb/M/i4rRE6TAOsmQQxDUGMUVNnxrmKLsBn
         DnDb2UC0HU/IM45upmC+jKH3gV3g5aeF7OBN9TZfE5+KQGyi+Bmij3mR1S6TdBVPQFyK
         rYKw==
X-Forwarded-Encrypted: i=1; AJvYcCWORPahlxemdBOPOjv+evzExwbYFNJao61bJ0ohMyBOHe9shTfqmlzrMp2O7dMrLGxzwPjohdqP2ezhf2RSxD/B3I7Mvg==@vger.kernel.org, AJvYcCWpk6h20+psi5HVO4o6KWki6I++mdAMRJganAtba50BsSm1XXa98kQeMOdYHemPfjEzTY03RZUlMnmc708=@vger.kernel.org
X-Gm-Message-State: AOJu0YziUuw4yn8sH3klKvY0F1NHaHbpwnZpLe+pfshf981SplJPmxmz
	rkjF4c7LL6LWpnpFRBZDQS+leXcTSw4CUE8lmTFHKBBHLbNeigZy
X-Gm-Gg: ASbGncvRZX2BtORqcrwokXZETmgigJu44kCgurJhUdeAhBqLWmCdwDbGJvw2Smn0va/
	8HpFyxtTBikg5UkDHoFhkn/W/YZ82VQ6X5kyjmsiemRI1ygNjHjsli3TXWmdOFZgeQt5ffSNuNK
	2R9KK3eBlKDkZtqHvna99+zVQl+6EcURJWEwKQCfL8lCq3u62XMnhzlu+kkGU+AnCHwL2NGoln2
	dzTwNqYcTmgKBj9XLZpaj48WQR/Q8zckotaA0cRF9sHT6B2DM+WnFxwFf16gay7E4R+Zi9WDU7n
	puixlnIUD9R8yAJzDd4wXYcSP6KiTtZpSZo7
X-Google-Smtp-Source: AGHT+IE51PVYwuWufjYOalEz7R/cxgRfitr4ISd0OVo95G1XYW9cdSzyvl5qGARQDcc9tUw5XpQoUg==
X-Received: by 2002:a05:6122:8293:b0:518:a261:adca with SMTP id 71dfb90a1353d-5235b8a9ec2mr9971861e0c.8.1741105325721;
        Tue, 04 Mar 2025 08:22:05 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5237ada4179sm1222349e0c.16.2025.03.04.08.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:22:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Mar 2025 11:22:02 -0500
Message-Id: <D87MBR4SSJWW.3KZ1U09AVISKR@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Armin Wolf" <W_Armin@gmx.de>, <platform-driver-x86@vger.kernel.org>,
 "Hans de Goede" <hdegoede@redhat.com>, <Dell.Client.Kernel@dell.com>,
 "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/10] platform/x86: alienware-wmi-wmax: Improve
 platform profile probe
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250225222500.23535-1-kuurtb@gmail.com>
 <20250225222500.23535-6-kuurtb@gmail.com>
 <6f61f7dc-d5b8-7d61-c200-9c2c1ff2be7c@linux.intel.com>
In-Reply-To: <6f61f7dc-d5b8-7d61-c200-9c2c1ff2be7c@linux.intel.com>

On Tue Mar 4, 2025 at 10:40 AM -05, Ilpo J=C3=A4rvinen wrote:
> On Tue, 25 Feb 2025, Kurt Borja wrote:
>
>> Get and store the AWCC system description in alienware_awcc_setup()
>> instead of awcc_platform_profile_probe() and add a check for integer
>> overflows to avoid misbehaviors.
>>=20
>> While at it, replace set_bit() with it's non-atomic version __set_bit()
>> because `choices` belong to this thread only.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>  .../platform/x86/dell/alienware-wmi-wmax.c    | 61 ++++++++++++++-----
>>  1 file changed, 46 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
>> index 4a8335d90b5d..965b427f8f0a 100644
>> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
>> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
>> @@ -37,6 +37,9 @@
>>  #define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
>>  #define AWCC_RESOURCE_ID_MASK			GENMASK(7, 0)
>> =20
>> +/* Arbitrary limit based on supported models */
>> +#define AWCC_MAX_RES_COUNT			16
>> +
>>  static bool force_platform_profile;
>>  module_param_unsafe(force_platform_profile, bool, 0);
>>  MODULE_PARM_DESC(force_platform_profile, "Forces auto-detecting thermal=
 profiles without checking if WMI thermal backend is available");
>> @@ -211,6 +214,17 @@ struct wmax_u32_args {
>> =20
>>  struct awcc_priv {
>>  	struct wmi_device *wdev;
>> +	union {
>> +		u32 system_description;
>> +		struct {
>> +			u8 fan_count;
>> +			u8 temp_count;
>> +			u8 unknown_count;
>> +			u8 profile_count;
>> +		} __packed;
>> +		u8 res_count[4];
>> +	} __packed;
>
> I don't like it how __packed is now creeping its way into priv structure=
=20
> too. It doesn't even seem useful in this case as all those are naturally=
=20
> aligned and take 4 bytes, AFAICT. Why did you add it?

You are right, I think alignment here is already guaranteed. Alignment
is still a bit confusing for me.

I'll drop it for v3.

--=20
 ~ Kurt

>
>> +
>>  	struct device *ppdev;
>>  	u8 supported_profiles[PLATFORM_PROFILE_LAST];
>>  };
>> @@ -614,38 +628,41 @@ static int awcc_platform_profile_probe(void *drvda=
ta, unsigned long *choices)
>>  	enum platform_profile_option profile;
>>  	struct awcc_priv *priv =3D drvdata;
>>  	enum awcc_thermal_profile mode;
>> -	u8 sys_desc[4];
>> -	u32 first_mode;
>> +	u8 id, offset =3D 0;
>>  	u32 out_data;
>>  	int ret;
>> -	u8 id;
>> =20
>> -	ret =3D awcc_thermal_information(priv->wdev, AWCC_OP_GET_SYSTEM_DESCRI=
PTION,
>> -				       0, (u32 *) &sys_desc);
>> -	if (ret < 0)
>> -		return ret;
>> -
>> -	first_mode =3D sys_desc[0] + sys_desc[1];
>> -
>> -	for (u32 i =3D 0; i < sys_desc[3]; i++) {
>> -		ret =3D awcc_op_get_resource_id(priv->wdev, i + first_mode, &out_data=
);
>> +	/*
>> +	 * Thermal profile IDs are listed last at offset
>> +	 *	fan_count + temp_count + unknown_count
>> +	 */
>> +	for (unsigned int i =3D 0; i < ARRAY_SIZE(priv->res_count) - 1; i++)
>> +		offset +=3D priv->res_count[i];
>> =20
>> +	for (unsigned int i =3D 0; i < priv->profile_count; i++) {
>> +		ret =3D awcc_op_get_resource_id(priv->wdev, i + offset, &out_data);
>>  		if (ret =3D=3D -EIO)
>>  			return ret;
>> =20
>> +		/*
>> +		 * Some devices report an incorrect number of thermal profiles
>> +		 * so the resource ID list may end prematurely
>> +		 */
>>  		if (ret =3D=3D -EBADRQC)
>>  			break;
>> =20
>>  		/* Some IDs have a BIT(8) flag that should be ignored */
>>  		id =3D FIELD_GET(AWCC_RESOURCE_ID_MASK, out_data);
>> -		if (!is_awcc_thermal_profile_id(id))
>> +		if (!is_awcc_thermal_profile_id(id)) {
>> +			dev_dbg(&priv->wdev->dev, "Unmapped thermal profile ID 0x%02x\n", id=
);
>>  			continue;
>> +		}
>> =20
>>  		mode =3D FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
>>  		profile =3D awcc_mode_to_platform_profile[mode];
>>  		priv->supported_profiles[profile] =3D id;
>> =20
>> -		set_bit(profile, choices);
>> +		__set_bit(profile, choices);
>>  	}
>> =20
>>  	if (bitmap_empty(choices, PLATFORM_PROFILE_LAST))
>> @@ -655,7 +672,7 @@ static int awcc_platform_profile_probe(void *drvdata=
, unsigned long *choices)
>>  		priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =3D
>>  			AWCC_THERMAL_MODE_GMODE;
>> =20
>> -		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>> +		__set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>>  	}
>> =20
>>  	return 0;
>> @@ -686,6 +703,20 @@ static int alienware_awcc_setup(struct wmi_device *=
wdev)
>>  	if (!priv)
>>  		return -ENOMEM;
>> =20
>> +	ret =3D awcc_thermal_information(wdev, AWCC_OP_GET_SYSTEM_DESCRIPTION,
>> +				       0, &priv->system_description);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Sanity check */
>> +	for (unsigned int i =3D 0; i < ARRAY_SIZE(priv->res_count); i++) {
>> +		if (priv->res_count[i] > AWCC_MAX_RES_COUNT) {
>> +			dev_err(&wdev->dev, "Malformed system description: 0x%08x\n",
>> +				priv->system_description);
>> +			return -ENXIO;
>> +		}
>> +	}
>> +
>>  	priv->wdev =3D wdev;
>>  	dev_set_drvdata(&wdev->dev, priv);
>> =20
>>=20


