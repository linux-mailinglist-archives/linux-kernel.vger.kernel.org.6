Return-Path: <linux-kernel+bounces-544922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29079A4E6DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F80882509
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6117C28D0BE;
	Tue,  4 Mar 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCUli6cL"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E904228D0AB;
	Tue,  4 Mar 2025 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105124; cv=none; b=ZD+1Zy5DcDAjcoN58VhzETgfcZEOyYTqTvnNKCtthy2hgqpSpbyVoQS7S3lnKasjU/J+W79zsAf0Rv+zNnULNKatmBiT8zqdujhhDa7tsKk6DH5QAbjzfB6LJ1XGUGExoKkJYF6MHLVF1TF18Ww0s6R6eZhcH2HCEC0IOss6iCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105124; c=relaxed/simple;
	bh=wHZ2pHPAyPwyBvXAaqR59rdfgfckD4XrIkRu7inQJd4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Qg9eGrzUSVAirhfaC5vfRHIaHZggsYsN4aLZ+nDDXReHUarGBpVj/7ucwMeK4MLqiCLzlEBxpaLmuaZ2aZeGJtIJJ3l6Gjc2U8l3bsSRho1jFBBoTViEjnweewvL01GsA8/exNi/BWlpYHYFOR551ZalndkObNCHQ5aUiZlTuJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCUli6cL; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5238b366e2aso2322861e0c.2;
        Tue, 04 Mar 2025 08:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741105122; x=1741709922; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTJiCYPsXf93oxrewRZPPwDaKERjwNqtK3ty4apzmo8=;
        b=OCUli6cL/QpIJAlE422aKxaDojv051WhHzkRRwNv5SBhBrICrdBanAu/fjMORZyddO
         kFfpZ7eqIvOrm/im1jPRNSDFtidBwQAHcbZxPuNUcJsPeAjwhks6rakN2/W1ey0gP7EI
         +bl3y0IwUW813FsbrRy9lWmeaptdyIYwFGicju+gGzqYVzmuy0arhV3LZqXsepxllp55
         uGX/rS7VU9CUcpY5V+PY2FBPjRO2WLz1ELoxmrNsiyWmINm4Gb1K7ZfiVokz7cV1thwH
         NE2J9miQZwK3QzUWTmQ2j1DrfMLmb6Q/ERtoWJCzvXw/KGmoJpt0jqmHSHbZxWs1LP/i
         TvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105122; x=1741709922;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bTJiCYPsXf93oxrewRZPPwDaKERjwNqtK3ty4apzmo8=;
        b=CEFr1WzRnM5de5fIUWrh/QMcPDuNchdXhfxYZ3srhCkoUxcpwpAgE13d8cnE/JbSIq
         GsuJQjXGbkJtyWa5oZZhOU5Mohf4aRFwq3nplxbun9ZWGMbQQ+a7tVeDhud2w+E241mD
         cBKzApdV5qMFA2g5ZIhmEHniLXaFsqpVoz3xks3f3FCAQ2e4BeaPJgPf4O+gMZPk22Wl
         nxNzmZrKxyx3zeLj9AEw0LzLZVgxPhEQ5rIHZWjHZg+xAY3UnJf+ON3Sy49NsMSRlWeP
         /qf66/p3cJO4BLhYHxNHXV4k8CDLOhKlTH9C/aCPVax6EpuD/aTBKcDSLfezRmK7nROs
         Q7ng==
X-Forwarded-Encrypted: i=1; AJvYcCVyga/27nBmtS9EkW8wQHd6Qv/17JliFhHHkV9Bdu0LV9Qn47dmrQVxLF1Xp/i+6K5Cc7xhdiiz7vjepPA=@vger.kernel.org, AJvYcCW+vmBneINyVEQrTPX/8g1mobX93ZePTrDQ8qXbOTP/eikQvqYN4hLLpUGvvcfyLbsa37ZTuV1XncY+GA0dve/6HnCqlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHOYp/ZEirAfef/qUmMNaJMwRf6wkUPeTPZV42qNSTTCw9GwYS
	iWYkm+EO5NUnwqUOvSqFFdBxVWvg+wAo0CPP1B3SOu+vhmCPmqcV
X-Gm-Gg: ASbGncsRP+AVjW91sBBcF+OEqb1+Bb3AEkTJLGcliBC6OayZZdoGH80xoklvp9K5RRH
	JQWl98Slt6xB9n+S04eJKIM/cuRFX8p4R8ka4p7PRNjbR6DlBp/ttxhBzi/sDJNeK6u2qo1E5si
	o0KH3a7mrxLr3a8/ZtMhWbKVIUIZRDHoHi+jWfIpSiuKQHqoopzJrsCn9ASOZkPDpQ1fhMpKxya
	mKAih2yMFWmeEv5q6fguhcBUfSLnt8igGOV8YVp2FYeACfAhOsYK13I3SYNHgh8qGvqBdm12fZe
	Xtzhu9ncbbXBgyFz+TOuRMf6Jc9RroZZDDBd
X-Google-Smtp-Source: AGHT+IEXVyjgnzYR2TDGwCgMH8vb8tE9nPLFhDI2UoBT0qcIyhmhDPTfeJxWBjL52kqbuUm+MSPpWg==
X-Received: by 2002:a05:6122:c92:b0:520:61ee:c821 with SMTP id 71dfb90a1353d-5235b784e1bmr11972286e0c.3.1741105121711;
        Tue, 04 Mar 2025 08:18:41 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523598bdebesm1877538e0c.45.2025.03.04.08.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:18:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Mar 2025 11:18:37 -0500
Message-Id: <D87M952C1SMA.P1VX3N83R92R@gmail.com>
Subject: Re: [PATCH v2 02/10] platform/x86: alienware-wmi-wmax: Refactor
 is_awcc_thermal_mode()
From: "Kurt Borja" <kuurtb@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Armin Wolf" <W_Armin@gmx.de>, <platform-driver-x86@vger.kernel.org>,
 "Hans de Goede" <hdegoede@redhat.com>, <Dell.Client.Kernel@dell.com>,
 "LKML" <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250225222500.23535-1-kuurtb@gmail.com>
 <20250225222500.23535-3-kuurtb@gmail.com>
 <2f8f3818-f1ba-c7b8-f3e5-148436b930f6@linux.intel.com>
In-Reply-To: <2f8f3818-f1ba-c7b8-f3e5-148436b930f6@linux.intel.com>

Hi Ilpo,

On Tue Mar 4, 2025 at 10:02 AM -05, Ilpo J=C3=A4rvinen wrote:
> On Tue, 25 Feb 2025, Kurt Borja wrote:
>
>> Refactor is_awcc_thermal_mode() to use FIELD_GET() instead of bitwise
>> operations. Drop the check for BIT(8) sensor flag and rename it to
>> is_awcc_thermal_profile_id().
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>  .../platform/x86/dell/alienware-wmi-wmax.c    | 31 ++++++++++---------
>>  1 file changed, 16 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
>> index ed70e12d73d7..7f0aa88221d6 100644
>> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
>> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
>> @@ -34,7 +34,7 @@
>>  #define AWCC_FAILURE_CODE			0xFFFFFFFF
>>  #define AWCC_THERMAL_TABLE_MASK			GENMASK(7, 4)
>>  #define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
>> -#define AWCC_SENSOR_ID_MASK			BIT(8)
>> +#define AWCC_RESOURCE_ID_MASK			GENMASK(7, 0)
>> =20
>>  static bool force_platform_profile;
>>  module_param_unsafe(force_platform_profile, bool, 0);
>> @@ -168,8 +168,8 @@ enum AWCC_GAME_SHIFT_STATUS_OPERATIONS {
>>  };
>> =20
>>  enum AWCC_THERMAL_TABLES {
>> -	AWCC_THERMAL_TABLE_LEGACY		=3D 0x90,
>> -	AWCC_THERMAL_TABLE_USTT			=3D 0xA0,
>> +	AWCC_THERMAL_TABLE_LEGACY		=3D 0x9,
>> +	AWCC_THERMAL_TABLE_USTT			=3D 0xA,
>>  };
>> =20
>>  enum awcc_thermal_profile {
>> @@ -445,20 +445,18 @@ const struct attribute_group wmax_deepsleep_attrib=
ute_group =3D {
>>   * Thermal Profile control
>>   *  - Provides thermal profile control through the Platform Profile API
>>   */
>> -static bool is_awcc_thermal_mode(u32 code)
>> +static bool is_awcc_thermal_profile_id(u8 code)
>>  {
>> -	if (code & AWCC_SENSOR_ID_MASK)
>> -		return false;
>> +	u8 table =3D FIELD_GET(AWCC_THERMAL_TABLE_MASK, code);
>> +	u8 mode =3D FIELD_GET(AWCC_THERMAL_MODE_MASK, code);
>> =20
>> -	if ((code & AWCC_THERMAL_MODE_MASK) >=3D AWCC_PROFILE_LAST)
>> +	if (mode >=3D AWCC_PROFILE_LAST)
>>  		return false;
>> =20
>> -	if ((code & AWCC_THERMAL_TABLE_MASK) =3D=3D AWCC_THERMAL_TABLE_LEGACY =
&&
>> -	    (code & AWCC_THERMAL_MODE_MASK) >=3D AWCC_PROFILE_LEGACY_QUIET)
>> +	if (table =3D=3D AWCC_THERMAL_TABLE_LEGACY && mode >=3D AWCC_PROFILE_L=
EGACY_QUIET)
>>  		return true;
>> =20
>> -	if ((code & AWCC_THERMAL_TABLE_MASK) =3D=3D AWCC_THERMAL_TABLE_USTT &&
>> -	    (code & AWCC_THERMAL_MODE_MASK) <=3D AWCC_PROFILE_USTT_LOW_POWER)
>> +	if (table =3D=3D AWCC_THERMAL_TABLE_USTT && mode <=3D AWCC_PROFILE_UST=
T_LOW_POWER)
>>  		return true;
>> =20
>>  	return false;
>> @@ -548,7 +546,7 @@ static int awcc_platform_profile_get(struct device *=
dev,
>>  		return 0;
>>  	}
>> =20
>> -	if (!is_awcc_thermal_mode(out_data))
>> +	if (!is_awcc_thermal_profile_id(out_data))
>>  		return -ENODATA;
>> =20
>>  	out_data &=3D AWCC_THERMAL_MODE_MASK;
>> @@ -597,6 +595,7 @@ static int awcc_platform_profile_probe(void *drvdata=
, unsigned long *choices)
>>  	u32 first_mode;
>>  	u32 out_data;
>>  	int ret;
>> +	u8 id;
>> =20
>>  	ret =3D awcc_thermal_information(priv->wdev, AWCC_OP_GET_SYSTEM_DESCRI=
PTION,
>>  				       0, (u32 *) &sys_desc);
>> @@ -615,12 +614,14 @@ static int awcc_platform_profile_probe(void *drvda=
ta, unsigned long *choices)
>>  		if (ret =3D=3D -EBADRQC)
>>  			break;
>> =20
>> -		if (!is_awcc_thermal_mode(out_data))
>> +		/* Some IDs have a BIT(8) flag that should be ignored */
>
> I find the place of this comment odd. If you want to keep it, it should b=
e=20
> next to the GENMASK() as in this place I'm trying to find the code that=
=20
> implements what you commented but its nowhere near here.

I placed it here because the FIELD_GET bellow implicitly ignores the
flag. But I agree, I'll move it next to the GENMASK definition.

--=20
 ~ Kurt

>
>> +		id =3D FIELD_GET(AWCC_RESOURCE_ID_MASK, out_data);
>> +		if (!is_awcc_thermal_profile_id(id))
>>  			continue;
>> =20
>> -		mode =3D out_data & AWCC_THERMAL_MODE_MASK;
>> +		mode =3D FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
>>  		profile =3D awcc_mode_to_platform_profile[mode];
>> -		priv->supported_thermal_profiles[profile] =3D out_data;
>> +		priv->supported_thermal_profiles[profile] =3D id;
>> =20
>>  		set_bit(profile, choices);
>>  	}
>>=20


