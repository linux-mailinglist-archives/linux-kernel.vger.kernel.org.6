Return-Path: <linux-kernel+bounces-392705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AD79B9745
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFB21C21D9E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF4014F132;
	Fri,  1 Nov 2024 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bYobjbXF"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6C11CB51D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485152; cv=none; b=PAVVznfW7wf2vrRBL7xuRlxEuipkMRbS938NVq+3eS1g9oC0anNoSXlQGEZ3/fl8WA3IvAPmIpF4XNONBo7A+A84Bw1ZvFMt+YBpsvUNVENVtJ6Vd0S1xngfN7hceiE8mkzGVdPFLVrD2R/InahV3iOOqVMZHOLJJc+uNhg90nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485152; c=relaxed/simple;
	bh=jOGNatYKO7LyfoMaEY3D4pl3e46xv0D7qv7HJZZbDO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B26eVn6O4C40eRBgNI7dHTimcRmz7aHD5gqSjUHr0EtB2ZEC1MwK6A5zHn6Thzzx8/+THvU+bGbCtzCKL0uy+Mt/43rdLuLv1w8GZ3PfFFJXx0SPuj03lHdekm5n4kuu/nlJFeU/JGjnRpuP6e/YGZkY2Bn4+ibcEa2ohGB/CVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bYobjbXF; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cb6b2b7127so2902071a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730485148; x=1731089948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCb0avfMfhqFRdPMe3Ycp6E7ngzUGoHw4RlfxTUvmP4=;
        b=bYobjbXFwsQvoB3St4LwIgP9ERXydeonQ6dEvnTxleS6OWEuTfvRor852qw8VtPaCH
         mNLNLTBzWcFDKDi3x/hoBwOBNEjtY3cUFTIAw2guRK9lBcKNVC9EvYTkafTzO4SBdhCa
         8vibo8mpkA8gwriFlBAy3NJAsYl/XOtXAYHYHsTWi+9aI644HUG+V+iZZrxqd2VJxLI7
         4O8akD6EwIaTUGaD7a0vIQYriM2s5/z6xnBx1hsraK+X9DtdDM6apIvr5PRihnTZJO9l
         SLlGrna6DUCHOVEqVGqofy7Fbm8O/DMRcef1wAx9rD8JzimEOlASyMrJqURobYS/V98/
         aKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730485148; x=1731089948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCb0avfMfhqFRdPMe3Ycp6E7ngzUGoHw4RlfxTUvmP4=;
        b=ayAyBxh1mzAZIkbazgPUHjk+hlIXdvvA6r1m5Ao95mPzP6fOx7knoxIO0a/+azQ0rl
         kTUwfRGo0OjIrFTGzC8noGwCDf1+afwjqEMtsdnGaGCj+RZZZG8JPfIc1G3hymIuNnUU
         e9B8QdPAvo75brLW1QDMqfa0Hfsqx+2Xuq9wwQuUsP7Iy7wsFq7489HzRxweVoX+U1I1
         /s6PWjvVQKS7vPSo5GzNWeTNg6hJjxg3RKTjxQ7ht0m4/qfwstjmv1B2GFzSAR3v/EYb
         4i+mfKsdI2GpkoF6QxllNpeeFPZhRvk/MEOYtU8brNqpHKCNtb2ZjGVmYqGQOoDfcwNM
         sYxw==
X-Forwarded-Encrypted: i=1; AJvYcCUUKslhpJikD8EEzJwUkIj6tCf+UghPiyksCgwNk1qGOjGi+0Vi1rxkSeqhQGjziICz7y+CQWS+x3CeVyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQjqvuSoC2ZgCNzeiollA1N/X3TnJJeA8Hmi9thRTbd0Q9UIkb
	UYo6VH7V7zFxOJ1KAXNhaza+SL4UseMip9JZB5gXRhTognNM/hn1+3BhgTeXUN2qHyZHFDgt8mP
	ViEB4j4LJXTeWM9lrnX/RPolYCThFXHdn4vSWQA==
X-Google-Smtp-Source: AGHT+IFcq0AMZn+pZ24DpM6HGZ4OavdIPRNi8d8rMXlbIsaq2gBK6JoQrQewB37SFhHsyDDEtF8jHre0Mg6mo5VxsRA=
X-Received: by 2002:a17:907:3da9:b0:a99:e98f:e73d with SMTP id
 a640c23a62f3a-a9e5097d255mr759902366b.37.1730485148179; Fri, 01 Nov 2024
 11:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
 <20241031-iio-fix-write-event-config-signature-v2-6-2bcacbb517a2@baylibre.com>
 <ef4fe230-b7fb-4f7e-9173-ae85d305e9ae@baylibre.com> <20241101154451.227defba@jic23-huawei>
In-Reply-To: <20241101154451.227defba@jic23-huawei>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 1 Nov 2024 19:18:48 +0100
Message-ID: <CAEHHSvZxgREMpA-kC7zarRZAp=bU6dcc2-3qjZU8o01BP3bSzA@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] iio: light: adux1020: write_event_config: use
 local variable for interrupt value
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Anshul Dalal <anshulusr@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Ramona Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Dan Robertson <dan@dlrobertson.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Matteo Martelli <matteomartelli3@gmail.com>, 
	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, Michal Simek <michal.simek@amd.com>, 
	Mariel Tinaco <Mariel.Tinaco@analog.com>, Jagath Jog J <jagathjog1996@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
	Kevin Tsai <ktsai@capellamicro.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 1 nov. 2024 =C3=A0 16:45, Jonathan Cameron <jic23@kernel.org> a =C3=
=A9crit :
>
> On Thu, 31 Oct 2024 11:27:45 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On 10/31/24 10:27 AM, Julien Stephan wrote:
> > > state parameter is currently an int, but it is actually a boolean.
> > > iio_ev_state_store is actually using kstrtobool to check user input,
> > > then gives the converted boolean value to write_event_config.  The co=
de
> > > in adux1020_write_event_config re-uses state parameter to store an
> > > integer value. To prepare for updating the write_event_config signatu=
re
> > > to use a boolean for state, introduce a new local int variable.
> > >
> > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > ---
> > >  drivers/iio/light/adux1020.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux102=
0.c
> > > index 2e0170be077aef9aa194fab51afbb33aec02e513..db57d84da616b91add8c5=
d1aba08a73ce18c367e 100644
> > > --- a/drivers/iio/light/adux1020.c
> > > +++ b/drivers/iio/light/adux1020.c
> > > @@ -505,7 +505,7 @@ static int adux1020_write_event_config(struct iio=
_dev *indio_dev,
> > >                                    enum iio_event_direction dir, int =
state)
> > >  {
> > >     struct adux1020_data *data =3D iio_priv(indio_dev);
> > > -   int ret, mask;
> > > +   int ret, mask, val;
> > >
> > >     mutex_lock(&data->lock);
> > >
> > > @@ -526,12 +526,12 @@ static int adux1020_write_event_config(struct i=
io_dev *indio_dev,
> > >                     mask =3D ADUX1020_PROX_OFF1_INT;
> > >
> > >             if (state)
> > > -                   state =3D 0;
> > > +                   val =3D 0;
> > >             else
> > > -                   state =3D mask;
> > > +                   val =3D mask;
> > >
> > >             ret =3D regmap_update_bits(data->regmap, ADUX1020_REG_INT=
_MASK,
> > > -                                    mask, state);
> > > +                                    mask, val);
> > >             if (ret < 0)
> > >                     goto fail;
> > >
> > >
> >
> > Instead of introducing `val`, I would rewrite this as:
> >
> >       if (state)
> >               ret =3D regmap_clear_bits(...);
> >       else
> >               ret =3D regmap_set_bits(...);
> >
> Good idea.  Rather than go around again and potentially stall the end of =
this series.
> I made that change whilst applying.  Shout if either of you doesn't
> like the result. Diff doesn't do a perfect job on readability (it does
> if I add a line break but then the code looks worse in the end!)
>

Hello Jonathan,

Looks fine to me. Thank you for doing the change yourself.

Cheers
Julien
> From 06a1ca816450d1b5524f6010581a83ab9935d51b Mon Sep 17 00:00:00 2001
> From: Julien Stephan <jstephan@baylibre.com>
> Date: Thu, 31 Oct 2024 16:27:01 +0100
> Subject: [PATCH] iio: light: adux1020: write_event_config: use local vari=
able
>  for interrupt value
>
> state parameter is currently an int, but it is actually a boolean.
> iio_ev_state_store is actually using kstrtobool to check user input,
> then gives the converted boolean value to write_event_config.  The code
> in adux1020_write_event_config re-uses state parameter to store an
> integer value. To prepare for updating the write_event_config signature
> to use a boolean for state, introduce a new local int variable.
>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> Link: https://patch.msgid.link/20241031-iio-fix-write-event-config-signat=
ure-v2-6-2bcacbb517a2@baylibre.com
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/light/adux1020.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
> index 2e0170be077a..06d5bc1d246c 100644
> --- a/drivers/iio/light/adux1020.c
> +++ b/drivers/iio/light/adux1020.c
> @@ -526,12 +526,11 @@ static int adux1020_write_event_config(struct iio_d=
ev *indio_dev,
>                         mask =3D ADUX1020_PROX_OFF1_INT;
>
>                 if (state)
> -                       state =3D 0;
> +                       ret =3D regmap_clear_bits(data->regmap,
> +                                               ADUX1020_REG_INT_MASK, ma=
sk);
>                 else
> -                       state =3D mask;
> -
> -               ret =3D regmap_update_bits(data->regmap, ADUX1020_REG_INT=
_MASK,
> -                                        mask, state);
> +                       ret =3D regmap_set_bits(data->regmap,
> +                                             ADUX1020_REG_INT_MASK, mask=
);
>                 if (ret < 0)
>                         goto fail;
>
> --
> 2.46.2
>
>
>
> >
> >
>

