Return-Path: <linux-kernel+bounces-285877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A0C9513BE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36B51F245D6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE4A55C3E;
	Wed, 14 Aug 2024 05:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThC/MbOQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE4954720
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 05:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723612184; cv=none; b=mYuUMnwRl9Ym7b21o62Xf+SfYhSyeCKa7xaYFx1GS+GwQu4AbGC7d4Z9RZ/eaJFGWWoJzgxjngue1r2/OkPrbZXdHm/w9cCgcJeWNnQeiIpW7dj8och3aRe+3r1W3Xx0Mqnhy3yD3T+hLPaautC0sAkCPs/Q5Ca+KyQvC9ePN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723612184; c=relaxed/simple;
	bh=cIyfu/i2hay6YMg1pSt3z2/Uj13fsv8g6tpRe535x9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYpSGKTCzir/GpJhVJmBupkiBSd9twunGAgZv5MBsTQVyR32kh8ZqHjzrSfLLjXxlfTBPWR0ksdQWBSAxKFOUFnxbJrTFGg7mNmffEorhApUJdnw57gymfOdrGoOMnlJRkUp7H5zkhBELoXGCdj7xxG1xxdUXyvfm3nwLYLLvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThC/MbOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B24BC4AF0F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 05:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723612184;
	bh=cIyfu/i2hay6YMg1pSt3z2/Uj13fsv8g6tpRe535x9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ThC/MbOQ5wBaGgomBMA1SQHRt0VE6LlVrezSPmtGfFkTtEm9+FvfdJ5pbRbmf6+30
	 WNsqFoIDFh9RgAjCjs4fKz1MdAxkC3Oy4MrahAbpP+PTPZh7HUkq05+NSLDGSzrj6c
	 l6iSZ3wDPPxb4Itp8yBWnv4YO0LN2rtcF2PooYjEoUcawINJQZGS2TuMPVUBEWfTPP
	 9YINCVtFxKba1n+3033LYpTV7gT+VTOqkyCcmGVVhDNtT5k5CHmHQL9ybsEE00GLLu
	 KsZRbhsxHoXaB30tbe50ncOgc1HpjvAxJwlQpm1L2+ixr4ezAshp4PI2/29rdcLsir
	 sGC6GbXM5hoCA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso11429038e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:09:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwUD247i/aKTGgxE5hZnNubWK23VrtHoN1boNhhRblWfa3R/bxv5xP7u7x75ZPbBviqow/qGN88tXRzD20oirQTgMyDeXwRCDOJTAY
X-Gm-Message-State: AOJu0Yzn4VKHkB6XWQ//PACQN/7XZx+pdmRZLSFdGlCOb/qPpNs/Nd7F
	ynMj97OHq003fqWcJ7U6yJDE7XROMZYW3czdj5Eiw5ZBvM422gY5NonHMRkq8G7RS9+Yo3PXkKZ
	tJ6CNs6WAzdr5omFXMwTJkQTUO12KtkPGKQjdWw==
X-Google-Smtp-Source: AGHT+IFf0EyIjfKD9fPDxj1Lpip9rNClYJvmeUDfOg8NUMCQXUIIc1nd9eh6JxBCQ8ykYqIvZ8Zeeiwsf1zdxBranfg=
X-Received: by 2002:a05:6512:131b:b0:530:dab8:7dea with SMTP id
 2adb3069b0e04-532eda6725emr1203359e87.5.1723612182369; Tue, 13 Aug 2024
 22:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2211925.irdbgypaU6@rjwysocki.net> <7712228.EvYhyI6sBW@rjwysocki.net>
In-Reply-To: <7712228.EvYhyI6sBW@rjwysocki.net>
From: Amit Kucheria <amitk@kernel.org>
Date: Wed, 14 Aug 2024 10:39:23 +0530
X-Gmail-Original-Message-ID: <CAHLCerMF6T3FiDfxMrAT+GBPibfpudYkriZmfW0BsOLNHVa6vA@mail.gmail.com>
Message-ID: <CAHLCerMF6T3FiDfxMrAT+GBPibfpudYkriZmfW0BsOLNHVa6vA@mail.gmail.com>
Subject: Re: [RESEND][PATCH v1 3/8] thermal: qcom: Use thermal_zone_get_crit_temp()
 in qpnp_tm_init()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Thara Gopinath <thara.gopinath@gmail.com>, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 10:43=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.n=
et> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Modify qpnp_tm_init() to use thermal_zone_get_crit_temp() to get the
> critical trip temperature instead of iterating over trip indices and
> using thermal_zone_get_trip() to get a struct thermal_trip pointer
> from a trip index until it finds the critical one.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Makes sense.

Reviewed-by: Amit Kucheria <amitk@kernel.org>

> ---
>
> This patch does not depend on the previous patch(es) in the series.
>
> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c |   22 +++------------------=
-
>  1 file changed, 3 insertions(+), 19 deletions(-)
>
> Index: linux-pm/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ linux-pm/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -291,24 +291,6 @@ static irqreturn_t qpnp_tm_isr(int irq,
>         return IRQ_HANDLED;
>  }
>
> -static int qpnp_tm_get_critical_trip_temp(struct qpnp_tm_chip *chip)
> -{
> -       struct thermal_trip trip;
> -       int i, ret;
> -
> -       for (i =3D 0; i < thermal_zone_get_num_trips(chip->tz_dev); i++) =
{
> -
> -               ret =3D thermal_zone_get_trip(chip->tz_dev, i, &trip);
> -               if (ret)
> -                       continue;
> -
> -               if (trip.type =3D=3D THERMAL_TRIP_CRITICAL)
> -                       return trip.temperature;
> -       }
> -
> -       return THERMAL_TEMP_INVALID;
> -}
> -
>  /*
>   * This function initializes the internal temp value based on only the
>   * current thermal stage and threshold. Setup threshold control and
> @@ -343,7 +325,9 @@ static int qpnp_tm_init(struct qpnp_tm_c
>
>         mutex_unlock(&chip->lock);
>
> -       crit_temp =3D qpnp_tm_get_critical_trip_temp(chip);
> +       ret =3D thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
> +       if (ret)
> +               crit_temp =3D THERMAL_TEMP_INVALID;
>
>         mutex_lock(&chip->lock);
>
>
>
>

