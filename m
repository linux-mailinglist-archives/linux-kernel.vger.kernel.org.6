Return-Path: <linux-kernel+bounces-426334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 837819DF1D7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497312818FB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC031A0AFE;
	Sat, 30 Nov 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNcK/LAw"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1153433BC;
	Sat, 30 Nov 2024 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732981658; cv=none; b=eKSTt+k6UmDEb3UsRm9sW6MDo/otD//i7hexFzJq1+ZQFA5HTbt3dYNolGK/AtbnplS3CDEzakaO71nKc7lVj/yDpU6q/GrPSIGoYmTLtOxH5ybZ3KRNlvLHukri6JKYc2UvFH1mtumXVnGqJUhKeQYrzhDlV3sv4jw+Pt/Abpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732981658; c=relaxed/simple;
	bh=1PTGhRyjIsm7QAHdu0cXr1QWFjEZVZBsyohXvUoURU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yf+wzdRSJQcnShZZX3+h1O8/TEj+CoQaR+yervsqjUC1whXs3jjG7m10xDH1vNqANwOmDptgLUqQ3z4gjXgikJDCXiSgW8xkkgqOT43AqtcDrm5McoGIMhSvdpwFbilONBaDg04lqRL5Ll+jPlS99MgmDAiAT4tHp0wueRONLDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNcK/LAw; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a75cad5eddso10055675ab.3;
        Sat, 30 Nov 2024 07:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732981656; x=1733586456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2gu9jQw3HbQ16UbphazRXckspOvL+0inOOjzZzc/yw=;
        b=MNcK/LAwGrXJIiTFGHhnquV1cnYDJF56JX2wOR/59R0U/JNLL5GaIbncktRxsFmJ66
         7973y/as3IbXeVFIH8ogZfakvHdtfLjo2yKdQ3QqV0fz+2bIys9tIPGZj8vPPrZuK1Xi
         5QQ40p/L5ZMnzZFwWmvq5mqzYEmzcMZYGmx+2XMzUSf2UC6Xfi69X9rRZuWt1o8bW1tu
         BD7w7e/0/BeBOjQynUl+TS0kQs88ttQIrreTxkkwuqUI8ZbVzKnknNk8IvcRETpq83fU
         DgIG6ybazZtACQt/etECt0aPTC2DGuWbKqaBVx2bAap28yJ76eyGQa7GFZrctCmgnR25
         jrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732981656; x=1733586456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2gu9jQw3HbQ16UbphazRXckspOvL+0inOOjzZzc/yw=;
        b=dal4QSRFiH8deZ2qQWPKxTym9KVjloKqk1L94AYMv3gL92k5nlfsyuKak0PKdT15we
         92i7TS8dyQ4RjPJ4nsNODKN1MGT+BLea7oRCypQLf2hTmVnMXnEIFAcz4rp1nSeeFvgz
         uGaNhyrVrqWUxWM17A+NFl5sgla5E7p7c2kbKw0PSNwgbhpHsQgTSMoyPRH5WmaRdPFn
         EWrueFkypZxXnv1Uk5dP02uRK0px6u1fsXa8kcNzre5OSTaLkJN1c6P0NE1Yxb2lzjTH
         xTRxvFlzR9uvZc1Avn9F+wwwcFQlMf8Yc3yrdqMaX7QSvOZz+zXfFFQu+x7gCJWBqAcX
         P7+A==
X-Forwarded-Encrypted: i=1; AJvYcCUuH5cW8HmqIccHmkiZ9v7Ghnbk7wAC43rtfvrS9Hympqu8XARYqHQu6/3vrQVfqA/TIkg4k0EqEK8=@vger.kernel.org, AJvYcCVwbGzlfeG1Zdl1l7eyn0fiszImGs0JVNLaOEsbO1MsygMHDa9/yk1PkJVOUp6JOVwEbQjnpXf3xFG1FN93@vger.kernel.org, AJvYcCWjlPvDdSlCdHJHdG4NgevONreV/IQA2ukWGTUl+XHmiOmcxRwDipbhRNSg5gp/G1D4rFMS4LHhszQHJBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyq2GR6S9tH39pV8SsFnm1hXFnjZTBPOZI+EaWQU1JEXCt1/6E
	qSt4kjSn/++0uGfrazU6EBCm+3ew12rHtf2U8OMZxNKNVX2s8SH3QFWC+ZCuWWFgPCF6wrZM/Ut
	xOFI6CvStXRXt3j7zmK5ZOerAU4k=
X-Gm-Gg: ASbGncv/JOzoUnpIxBTICSe3HJiZrGljCucAMTluW0+ZJn/U2ps7ZcudEelUIt43e6K
	iGmXwhUZLqeC0oW1naDwnZXTPpYcPic4GtRgxp6OophT9Rq2YkufgF6hhYwohgMQ=
X-Google-Smtp-Source: AGHT+IEO4+JdYtmV/84bIpy4ugipz6EYeX2s8ToGjwlW2k1F3Wg3+V3kTanZ/qHxMkZhC+lLzUYQ+gwOfyihbvPszdE=
X-Received: by 2002:a05:6e02:164d:b0:3a7:e592:55cd with SMTP id
 e9e14a558f8ab-3a7e59258d4mr13106515ab.14.1732981655375; Sat, 30 Nov 2024
 07:47:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB95QAROXwFPZB8gSkz0-thPtuzWkhAHmbqEy2QBg4fMmx7NKQ@mail.gmail.com>
 <20241130144733.51627-1-yanhuoguifan@gmail.com> <d8e00909-a946-4ce4-811d-ac968bc54c7b@roeck-us.net>
In-Reply-To: <d8e00909-a946-4ce4-811d-ac968bc54c7b@roeck-us.net>
From: Eugene Shalygin <eugene.shalygin@gmail.com>
Date: Sat, 30 Nov 2024 16:47:24 +0100
Message-ID: <CAB95QATeOynGJ=MMJrsMXatMms0u9ec+qJbh6QfAEUTnjNmZdA@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS
To: Guenter Roeck <linux@roeck-us.net>
Cc: Li XingYang <yanhuoguifan@gmail.com>, corbet@lwn.net, jdelvare@suse.com, 
	linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi G=C3=BCnter,

> > diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hw=
mon/asus_ec_sensors.rst
> > index ca38922f4ec5..d049a62719b0 100644
> > --- a/Documentation/hwmon/asus_ec_sensors.rst
> > +++ b/Documentation/hwmon/asus_ec_sensors.rst
> > @@ -17,6 +17,7 @@ Supported boards:
> >    * ROG CROSSHAIR VIII IMPACT
> >    * ROG CROSSHAIR X670E HERO
> >    * ROG CROSSHAIR X670E GENE
> > + * TUF GAMING X670E PLUS
> >    * ROG MAXIMUS XI HERO
> >    * ROG MAXIMUS XI HERO (WI-FI)
> >    * ROG STRIX B550-E GAMING
>
> I don't understand how this is "sorted". What is the sorting criteria ?

I believe the list in  static const struct dmi_system_id dmi_table[]
and the list in the .rst file are in the same order, and I want the
board declarations to follow that.

> > diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-se=
nsors.c
> > index 9555366aeaf0..f02e4f5cc6db 100644
> > --- a/drivers/hwmon/asus-ec-sensors.c
> > +++ b/drivers/hwmon/asus-ec-sensors.c
> > @@ -250,6 +250,8 @@ static const struct ec_sensor_info sensors_family_a=
md_600[] =3D {
> >               EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
> >       [ec_sensor_temp_water_out] =3D
> >               EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
> > +     [ec_sensor_fan_cpu_opt] =3D
> > +             EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
>
> This is an unrelated change. It affects other boards of the same family.
> It needs to be a separate patch, it needs to be explained, and it needs t=
o
> get some confirmation that it works on the other boards of the same serie=
s.

Well, it is the same register as in the previous generation, and while
it would be nice to confirm that it works in other models of the 600th
family, I can't see how XingYang can do that. I can check with the AMD
800th series though...

Kind regards,
Eugene

