Return-Path: <linux-kernel+bounces-426518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 923499DF456
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 02:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7DBB21255
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 01:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6F979C8;
	Sun,  1 Dec 2024 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWYUJW7W"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C0BEC4;
	Sun,  1 Dec 2024 01:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733015881; cv=none; b=klFgNy4ehYIFMbe3rLdz+snCH2mZf2DU4oTgEeNO1MGROwU4lEHJvQSq4G7obCPVm39sgVXk7J1XpqtVmNNuVWL6gZNxrp4QtLmG/6wvMHMALi6aPo9FAFKyjaW33helP7PD9fi9KPbjR0jag/mX/Xr6UHnhyq+qFaMcAv9F9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733015881; c=relaxed/simple;
	bh=1RKHU/9kjqCeYg2xFIGadgv8N23RTn9tJPmMdkrO/0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eddua8pWXF9YQUmuivke56N8NQSYCSJlrjGdgpFOyhebXUKTU7a4owuvJPb4dOb5ndvfMWn21F0bthtv2/hlz/jWDZR0fI14iFAgb5R4/3DotbN6S0VgeQ7Pwph9ZKWPdN+FfDHpJ7sg0F20N8EYRVKCQ0WmnjinGRSEk2vV9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWYUJW7W; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-21285c1b196so30131445ad.3;
        Sat, 30 Nov 2024 17:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733015879; x=1733620679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4TiJ+S3HHsOqNWSIm1djWyuj6jJoTd08hyt0pMQLz2U=;
        b=LWYUJW7WcVnUg9pWoQzCGI2tmvaH+FxSe1SxAM6/4qI104aIE67eYCiBL2PgZM0mOC
         +AHcCJevW7umGB/tkBUliA2e8/IffI8WjhVahanr99kTNxm4noWAC+U8e7P+ygTgOPTg
         BYNvSo3V3mIUUZbuF/+bK9ZSJF5n/U+pH//ElN/wqwYBpgCilLJxLqrkZAETyrwsyrv1
         MbtwxfGdeq7hVxSYVJ3QHinve/oiMKxUgPNR3h2syKgYCDoNut8fZ6WcBP7S4MyCWPIB
         WAIJOCaUCtKCB1VxLspG0i/PS8e9ZpFOSL6EIrDmvp/UFpTcT473unD1MtzXdMedKd13
         pneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733015879; x=1733620679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TiJ+S3HHsOqNWSIm1djWyuj6jJoTd08hyt0pMQLz2U=;
        b=LpZNOvQ3S435LqrVdJcaHI61X3m+TOIrqwjQEOqxv7CV3fyirNjLuBL9f2mk4heNvi
         kXgcpJfiYsHscCEfhlM1OJUI3L/nv1s3H3VP4/UXO2MlGZZHymVVrCnr+43SiQnFir4p
         2LXvHeTR6ycr8NWrxIsB2vTjCHkqqezhFhgz7kh/cfCWmp8s8Ca2l8nJqX8HXHKtKOHp
         +talILAE+NJ0RF7KWOdh7EpcEr3rltbyf9oX1z3TfyzSuqsQaEgTS5rjVNcNfWhd1cuZ
         UVb7wCakUA2V9RpdnE0xvq++l9Zkq5se6M8aJ2cBnoL5XcMnvSFBKdE0Fs2hugaJ51Kg
         wquA==
X-Forwarded-Encrypted: i=1; AJvYcCW6Cyxm7+DG7eM1BZY2dScN6R/acnYmWkEU7y8dcg9m1ZEdnAevkA6WTCNEKUOdPy2hkXw2FogJYERlxoA=@vger.kernel.org, AJvYcCWn7kYkIhTxaJAXvaCffLJDx3LIybzt06zpcrNcE8LtFbJ/ftsoLwsz6+xRKqRsFpxp/p0wzSVVPk4=@vger.kernel.org, AJvYcCXec2ugzvqHrqbZbQwhhs0YkRimHlphwHyjN2DJXxrGDWBWmVry9S9Edbnu2QdYPeLjfqSlgqP2+VbdeZu+@vger.kernel.org
X-Gm-Message-State: AOJu0YwAtnLAv19Q25WUO7PzVVtPpydH1KfNRDCLG/ox00zWwhj7rG6F
	MPQikz+3VCBTjPmukuMsFtG06tBpGSjGlw7lfb0L34y9dRWg/cV+
X-Gm-Gg: ASbGncu0WnpPNQIbkX1eCdrSuxhyC66Zdz9YMTpvHzUYXpTyZkbHkmrk2mRdTmvEnCN
	EHxlMM+rySibA3HNO/1+//KoamYVg+ngD7WXYbEOPmAfvHDVS+hpe5c7xyi27fcVt+TrSnk5rsi
	QEAgb3xYgXJqXJLO5NN1TSU/6GFnV2J+usD+fyWcf9+eIJlGideJaa1yXwl9rTf7VWICjorXufv
	bUmzpA8QfV2vfeN/vC8wwsX7qVv
X-Google-Smtp-Source: AGHT+IEuPwr29SpeQVTe35LfPTNpX0Np6MpDW5OHIFWHqTMCf7Fpy1t+qx78yR9adXTFxKuG+2/Udg==
X-Received: by 2002:a17:902:f601:b0:215:2f00:67b1 with SMTP id d9443c01a7336-2152f0069b2mr171362015ad.6.1733015879091;
        Sat, 30 Nov 2024 17:17:59 -0800 (PST)
Received: from gmail.com ([2a12:f8c1:50:4::4fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2152191dcc9sm51901105ad.112.2024.11.30.17.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 17:17:58 -0800 (PST)
Date: Sun, 1 Dec 2024 09:17:53 +0800
From: Li XingYang <yanhuoguifan@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: eugene.shalygin@gmail.com, corbet@lwn.net, jdelvare@suse.com,
	linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS
Message-ID: <Z0u5QWzWSXGUTUO0@gmail.com>
References: <CAB95QAROXwFPZB8gSkz0-thPtuzWkhAHmbqEy2QBg4fMmx7NKQ@mail.gmail.com>
 <20241130144733.51627-1-yanhuoguifan@gmail.com>
 <d8e00909-a946-4ce4-811d-ac968bc54c7b@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8e00909-a946-4ce4-811d-ac968bc54c7b@roeck-us.net>

On Sat, Nov 30, 2024 at 07:29:21AM -0800, Guenter Roeck wrote:


> > support these sensors:
> > SENSOR_TEMP_CPU, SENSOR_TEMP_CPU_PACKAGE, SENSOR_TEMP_MB
> > SENSOR_TEMP_VRM, SENSOR_TEMP_WATER_IN, SENSOR_TEMP_WATER_OUT
> > and SENSOR_FAN_CPU_OPT
> > 
> 
> The individual sensors supported by this board are irrelevant for the
> patch description.
>

My original intention was to describe the sensors supported by this new motherboard.
If you think it's irrelevant, I can delete the descriptions of these sensors.

> > Signed-off-by: Li XingYang <yanhuoguifan@gmail.com>
> 
> Please do not send new revisions of a patch as response of an older
> series, and please always provide a change log.
>
Sorry, I cannot fully understand this meaning.
Should I use the new version of the patch to reply to the old version of
the patch instead of responding to the questions raised
> > ---
> >   Documentation/hwmon/asus_ec_sensors.rst |  1 +
> >   drivers/hwmon/asus-ec-sensors.c         | 13 +++++++++++++
> >   2 files changed, 14 insertions(+)
> > 
> > diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
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
> 
> 
At first, I saw that the ROG CROSSHAIR X670E GENE was the
last motherboard in the x670e series on this list, 
so I placed the new x670e motherboard after it.
Now I realize that this list originally followed alphabetical order,
perhaps it would be better for me to put the new motherboard first,
as well as the source files first
> > diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> > index 9555366aeaf0..f02e4f5cc6db 100644
> > --- a/drivers/hwmon/asus-ec-sensors.c
> > +++ b/drivers/hwmon/asus-ec-sensors.c
> > @@ -250,6 +250,8 @@ static const struct ec_sensor_info sensors_family_amd_600[] = {
> >   		EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
> >   	[ec_sensor_temp_water_out] =
> >   		EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
> > +	[ec_sensor_fan_cpu_opt] =
> > +		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
> 
> This is an unrelated change. It affects other boards of the same family.
> It needs to be a separate patch, it needs to be explained, and it needs to
> get some confirmation that it works on the other boards of the same series.
> 
> Thanks,
> Guenter
I found that in the LibreHardwareMonitor project,
the registers used by Amd600 to operate FanCPUOpt are described:
https://github.com/LibreHardwareMonitor/LibreHardwareMonitor/blob/master/LibreHardwareMonitorLib/Hardware/Motherboard/Lpc/EC/EmbeddedController.cs
BoardFamily.Amd600, new Dictionary<ECSensor, EmbeddedControllerSource>
{
{ ECSensor.FanCPUOpt,  new EmbeddedControllerSource("CPU Optional Fan", SensorType.Fan, 0x00b0, 2) },
}

I think this is suitable for the AMD 600 motherboard, and it does work on my motherboard as well.
Of course, I cannot guarantee that all ASUS AMD600 motherboards can use this interface,
In fact, the ec_sensor_temp_t_sensor originally defined in sensors_family_amd_600
is also not applicable on my motherboard.
I think sensors_family_amd_600 only provides a common interface,
and the specific motherboard selection still needs to be tested.

I will dismantle this part into a separate patch.

