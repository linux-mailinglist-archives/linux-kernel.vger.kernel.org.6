Return-Path: <linux-kernel+bounces-577352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE64A71BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E9897A8038
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56E31F7075;
	Wed, 26 Mar 2025 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="NjYjsUML"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B191F63EA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007028; cv=none; b=bZVoehIcNBAsFzMSCWZ2eSNbv8rTvb3386UIY5/8Xq2pzq9m1jYSHntbwP5Ha5QZwpBsijq/qh3nHJc3RfdxrkYzy6IcWf/V0daW2mojPSXTYrBZaJ5X9gYp/V2JExzAUxJ2BQmDI5X2OW/V0GtGvzXrB+tpMYdy+A4xWURlYRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007028; c=relaxed/simple;
	bh=IQq6enMTG+6ROhzOBexSTgmY6GuXBcunbOF41yLY31s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q59k2wbo1VMzC7uktYIGMYrAxDgYs+hz91+/JT8dvxRRudSvf4pOvpQKx/Gt6HLE6WqYzh6giO2PL92515LgYdXzezVpNfT+V6a+FBWBnFUdhFKpvSfo+0WiI6od/psYp2I6Xth1Msa0Rkzr6R/uhHo0cwQc6iXdSbLrstPCVHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=NjYjsUML; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224341bbc1dso1562465ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1743007025; x=1743611825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F91AnXnLokiKJ1KvPD1kpvGF5dxInp9ewGKQcQQqyqc=;
        b=NjYjsUMLWgLzf28ZFILvAcDIbuqUb6LGool1t3D/01CGSC7bgtMHPrEPIN5RZoI1Ls
         AN0kzJ7LO9+fxcn++d+PtD4alaHyK0nfOwmufiwsZMC4VrzuvIVFwzKiZoACDVW1n3k5
         TUDsF58pMH5aTgHJnKnTRe/F50+DR3zspPM1Cq29Qeyi6HEjKdKYPYhkrM9hd0OLK7PF
         4zadNF3HGXAMq/oFAN3twjanbI0ZBAjHjfBU0tyGySwLXev0fCGAGUwqd9BTL9RC+6c9
         WyaHoj528S3MdOGCyR7KrRiBbwS6nMbiSd7i9Htz0VE9vdoPa4aowIu7eLXRJatwOA/c
         qLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007025; x=1743611825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F91AnXnLokiKJ1KvPD1kpvGF5dxInp9ewGKQcQQqyqc=;
        b=hCE5p4kIquEOZpCVb6H0BAP9qyNd2GSdkn/GY1TMvezb43uKI+qzWlELxwpdxqNGLH
         MxuG8D69mrL7GJ/9cIGxThCq/HKD1/XZS1cNwxdsDwetcwxOlN5WF4FK40jrCf9prLqU
         WCkFS75gdVjx/UprUl0UZZTFFoUzUiV9bgX8SqD+2kdjN4nsOC53VWPUBSRmR+giVN9Q
         ZCsxQWuzVTuCFdmVTtA/QsIndyw/AYecaOJ82Vv00ibJ5AALq2FoBR4QQYR3ND4l6AsK
         VnAK9Vcu9LYDTqZDZlgK3+SXVT0GUwRz1XPTnzoNbOoAfRWGHnw+irnqpb2rIkEf25A0
         vDQg==
X-Forwarded-Encrypted: i=1; AJvYcCVvczvkLreZpRBScxUaChTb5Uqsbf0jAa5alI6NhiY7RJy2Lyw4ejF6JgZgPfPWP+EPtunTFr8l35Ed1X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU6WwkC6eH2OJ16NmmA68kEV0kLcIR1y+itcnWdy4ypp5Ut2+p
	+Y3osW8yqL/B59ZRbMalu5m87ZRLdMwstcVJUxl9ZTO/TAhIvbIzcewgl6VAgvh4t59fR2qEQCW
	QZ3TusY2lb/9eOZyfUf6b5xKn4qfFxbQeATSAhA==
X-Gm-Gg: ASbGnctn7zYgpT8c/67cZEtsyN7LAP4AEI6vvecf2bno2Aq6yl9+RoHly9PQEYkXbJU
	BB4BnL4BpHpL5HIxj1MtuD7bxcCHdEGz9FWfRPDuCpiPW25+Y1Ok34u91kHUihs7BaYapUiB12w
	gSWnd7rpqXIPuAwYjsohTGFGtAqc4=
X-Google-Smtp-Source: AGHT+IGAO5DJ1GpXnTQ+m2CNdWahsXytfna0ljOHok84BCyI0sxWBMxOJcSBUojWT9rV9QGXKmf8vt4g7Fx08Hr1EMk=
X-Received: by 2002:a17:90b:1f81:b0:2ff:784b:ffe with SMTP id
 98e67ed59e1d1-303a7d6a9b4mr550673a91.11.1743007025141; Wed, 26 Mar 2025
 09:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324185744.2421462-1-you@example.com> <b6668968-897f-4864-913c-d4d557f1d7cc@roeck-us.net>
In-Reply-To: <b6668968-897f-4864-913c-d4d557f1d7cc@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Wed, 26 Mar 2025 22:06:53 +0530
X-Gm-Features: AQ5f1Jo7E8SdVYgDTlKTQFzVY9tNtZ40o22pq5kpX8djeafj-PpX-f5_zPtBc8s
Message-ID: <CABqG17h8cpnFkdD-nnqyr+UnwADU9XWK6TGBxj_FCH37Y3Q1Lw@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (max6639) : Allow setting target RPM
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

On Tue, 25 Mar 2025 at 05:00, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/24/25 11:57, Your Name wrote:
> > From: Naresh Solanki <naresh.solanki@9elements.com>
> >
> > Currently, during startup, the fan is set to its maximum RPM by default,
> > which may not be suitable for all use cases.
> > This patch introduces support for specifying a target RPM via the Device
> > Tree property "target-rpm".
> >
> > Changes:
> > - Added `target_rpm` field to `max6639_data` structure to store the
> >    target RPM for each fan channel.
> > - Modified `max6639_probe_child_from_dt()` to read the `"target-rpm"`
> >    property from the Device Tree and set `target_rpm` accordingly.
> > - Updated `max6639_init_client()` to use `target_rpm` to compute the
> >    initial PWM duty cycle instead of defaulting to full speed (120/120).
> >
> > Behavior:
> > - If `"target-rpm"` is specified, the fan speed is set accordingly.
> > - If `"target-rpm"` is not specified, the previous behavior (full speed
> >    at startup) is retained.
> >
>
> Unless I am missing something, that is not really correct. See below.
>
> > This allows better control over fan speed during system initialization.
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >   drivers/hwmon/max6639.c | 15 ++++++++++++---
> >   1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> > index 32b4d54b2076..ca8a8f58d133 100644
> > --- a/drivers/hwmon/max6639.c
> > +++ b/drivers/hwmon/max6639.c
> > @@ -80,6 +80,7 @@ struct max6639_data {
> >       /* Register values initialized only once */
> >       u8 ppr[MAX6639_NUM_CHANNELS];   /* Pulses per rotation 0..3 for 1..4 ppr */
> >       u8 rpm_range[MAX6639_NUM_CHANNELS]; /* Index in above rpm_ranges table */
> > +     u32 target_rpm[MAX6639_NUM_CHANNELS];
> >
> >       /* Optional regulator for FAN supply */
> >       struct regulator *reg;
> > @@ -560,8 +561,14 @@ static int max6639_probe_child_from_dt(struct i2c_client *client,
> >       }
> >
>
> target_rpm[] is 0 here.
>
> >       err = of_property_read_u32(child, "max-rpm", &val);
> > -     if (!err)
> > +     if (!err) {
> >               data->rpm_range[i] = rpm_range_to_reg(val);
> > +             data->target_rpm[i] = val;
> > +     }
>
> If there is no max-rpm property, or if there is no devicetree support,
> target_rpm[i] is still 0.
>
> > +
> > +     err = of_property_read_u32(child, "target-rpm", &val);
> > +     if (!err)
> > +             data->target_rpm[i] = val;
>
> If there is neither max-rpm nor target-rpm, target_rpm[i] is still 0.
>
> >
> >       return 0;
> >   }
> > @@ -573,6 +580,7 @@ static int max6639_init_client(struct i2c_client *client,
> >       const struct device_node *np = dev->of_node;
> >       struct device_node *child;
> >       int i, err;
> > +     u8 target_duty;
> >
> >       /* Reset chip to default values, see below for GCONFIG setup */
> >       err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
> > @@ -639,8 +647,9 @@ static int max6639_init_client(struct i2c_client *client,
> >               if (err)
> >                       return err;
> >
> > -             /* PWM 120/120 (i.e. 100%) */
> > -             err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), 120);
> > +             /* Set PWM based on target RPM if specified */
> > +             target_duty = 120 * data->target_rpm[i] / rpm_ranges[data->rpm_range[i]];
>
> If there is no devicetree support, or if neither max-rpm nor target-rpm are
> provided, target_duty will be 0, and the fans will stop.
>
> Maybe my interpretation is wrong, but I think both target_rpm[] and rpm_range[]
> will need to be initialized. Also, it seems to me that there will need to be an
> upper bound for target_rpm[]; without it, it is possible that target_duty > 120,
> which would probably not be a good idea.
Yes you're right. I missed it in my analysis.

Here is the logic that would address:
                target_rpm = 120;
                /* Set PWM based on target RPM if specified */
                if (data->target_rpm[i] != 0 &&
                    data->target_rpm[i]  <= rpm_ranges[data->rpm_range[i]]) {

                        target_duty = 120 * data->target_rpm[i] /
rpm_ranges[data->rpm_range[i]];
                }

Please let me know your thoughts & suggestions.

Regards,
Naresh
>
> Guenter
>
> > +             err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), target_duty);
> >               if (err)
> >                       return err;
> >       }
> >
> > base-commit: 2115cbeec8a3ccc69e3b7ecdf97b4472b0829cfc
>

