Return-Path: <linux-kernel+bounces-290903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4B4955B04
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB730B211A1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 05:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFC6BA49;
	Sun, 18 Aug 2024 05:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V8canM8Y"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B548F66
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 05:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723958188; cv=none; b=P1ig6mQaf6vEEGFZfkLtqUhKYRnC2+ain35CRKe8wF9POvSQ1HVUD/T2h1GqvcwihWcIH/ewuMxEBAJFXFyfZUONWg0yAx6AtmEOIeR/ANN3Top/1hjWUraOkj9yLYZysC99UWBoLlNOokHRZTaXjE1rj0ezoaGA02Vvs6CQ4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723958188; c=relaxed/simple;
	bh=MQtpP0UATon1FTiH9o/D+C4GGy4c9++hakrn4Mg+f2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edGMxvcuAACPVPqegHsVrHrMJNsi4ojRYIKOUFjP7Mcy+u/eR6zrmDHiLU1r3AuAkTGQGPEUngNw0ZMVZwzlpdICARmKV4519GRae3ST8GY1c7B59G+gW4JEV8JhpKw5gOZV0TnLq/+T16jIdkbHt4EkOBPHH2+00jnmfcqcQl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V8canM8Y; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4f920650c19so79494e0c.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 22:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723958183; x=1724562983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRP+YAVcIn7o5+i6cSAklFpWUlYjVNnuYUUj3njDkpU=;
        b=V8canM8Y691Kvkxr5lW5zbzESUqkQ3lG6FcsYBylh7kTEr3HFN+f9wwf5KTwvZnqkE
         9GdHh+nknd5v0/P14+mTfftiY0uvjRMwS4kn1G8KYv9Bo3yfyj3iOF1Z3tmIhDPneMHg
         ZXt+PvcDP6kPad65XfeZIu5pyye4fwMgsPU+BqdEJ+GoP21gO0urIdALqARiJgvUMLaj
         oWlGYdQ8VKJYWNkBAdzRZ3EbyHV+tHScnIUvg7+gLReqzqn+j4Mt6IQWYVzMmivkHVqa
         nB0EkPCHY/0B8RUwmKD2xh9ho78MqQ9gDz2ZuRLOyL7n4gJjHC41I5U1f/SPE8nbch7m
         WXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723958183; x=1724562983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRP+YAVcIn7o5+i6cSAklFpWUlYjVNnuYUUj3njDkpU=;
        b=d694k+dDJhPLJaj+hbcByFl5BuxbndJwPif/D8byyV9tDbkBceC0MGT+JJFY/REW40
         Ho+fhNaMSRqsOOZ7cZERBg00oh+CuowriF0yI+aW2bNy/9uoWx4P9YmRxAGKqgD5Xry3
         k+Iw736m9hG2QPnZKEjrRefwIBqaLX1jV2s+1pPGzDnmNFb2ukkgA7duaNiDDMKKyZ0w
         6CGRBu7oFuAsh+j3xpnyyz6aiNm78upIXLmNPENg017TXcShpImS/eNtz/H5qwcyIEqY
         9PZc66+deXy3zW4/iMItr7TlEceuZGMPfyjcQx79c9jJZ5Uz+OawvzXzwf80Au91TOVt
         +Ngg==
X-Forwarded-Encrypted: i=1; AJvYcCWQKbDP813GG+8AVwhieR6u617A4ZRv4hCKVnCAKa8TQrKp6ZMnbC7+7Y9O8C1ey52B/YY6gUA+AiwBEUfzR5TO7Hvtkbfd/AEcwHKH
X-Gm-Message-State: AOJu0YypxsO7Fi+VVUsfJz0CQg6i0LBuTDLNmpiNO3W/dBMtj+4+nna4
	gOlpXnm2olg8ugerPUiTeEgJJkUsuLa5O6MoslMlWKu6ab9X9P3K3xEkGxgrxm/7YLfSQL/ya4B
	rWQe3gCZ/0MWEbz/aRUUDh57YI2h3sGOxzhx+dQ==
X-Google-Smtp-Source: AGHT+IH8Y8XYQOgbiHvy8t2APVqq/eimyLY1DupeJNcoEM/ojLj51bVIXKuE2v4blOg2yem0vGA/hURdFsQLG4rl+IU=
X-Received: by 2002:a05:6102:f11:b0:491:1e5b:8a0a with SMTP id
 ada2fe7eead31-4977bf58f35mr3652699137.4.1723958183214; Sat, 17 Aug 2024
 22:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817144216.16569-1-aardelean@baylibre.com> <20240817155833.4dcc3004@jic23-huawei>
In-Reply-To: <20240817155833.4dcc3004@jic23-huawei>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Sun, 18 Aug 2024 08:16:12 +0300
Message-ID: <CA+GgBR8bUBjr2XKQVnOr1i+iPJadZAGAk8VKFTrjVH98hkfqug@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7606: split a 'ad7606_sw_mode_setup()' from probe
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael.Hennerich@analog.com, lars@metafoo.de, gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 5:58=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 17 Aug 2024 17:42:15 +0300
> Alexandru Ardelean <aardelean@baylibre.com> wrote:
>
> > This change moves the logic for setting up SW mode (during probe) into =
it's
> > own function.
> >
> > With the addition of some newer parts, the SW-mode part can get a littl=
e
> > more complicated.
> > So it's a bit better to have a separate function for this.
> This looks fine but put it on the start of the series that makes it more
> complex.  I may pick it off that series before the bulk of the code
> but if it's sent in such a series the link tags etc will let people
> see 'why' it is a good idea.

Sure.
Will spin-up the series.

>
> Jonathan
>
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> > ---
> >  drivers/iio/adc/ad7606.c | 43 ++++++++++++++++++++++++----------------
> >  1 file changed, 26 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > index 68481e97e50a..192b9cd56b45 100644
> > --- a/drivers/iio/adc/ad7606.c
> > +++ b/drivers/iio/adc/ad7606.c
> > @@ -545,6 +545,29 @@ static const struct iio_trigger_ops ad7606_trigger=
_ops =3D {
> >       .validate_device =3D iio_trigger_validate_own_device,
> >  };
> >
> > +static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
> > +{
> > +     struct ad7606_state *st =3D iio_priv(indio_dev);
> > +
> > +     if (!st->bops->sw_mode_config)
> > +             return 0;
> > +
> > +     st->sw_mode_en =3D device_property_present(st->dev, "adi,sw-mode"=
);
> > +     if (!st->sw_mode_en)
> > +             return 0;
> > +
> > +     indio_dev->info =3D &ad7606_info_os_range_and_debug;
> > +
> > +     /* Scale of 0.076293 is only available in sw mode */
> > +     st->scale_avail =3D ad7616_sw_scale_avail;
> > +     st->num_scales =3D ARRAY_SIZE(ad7616_sw_scale_avail);
> > +
> > +     /* After reset, in software mode, =C2=B110 V is set by default */
> > +     memset32(st->range, 2, ARRAY_SIZE(st->range));
> > +
> > +     return st->bops->sw_mode_config(indio_dev);
> > +}
> > +
> >  int ad7606_probe(struct device *dev, int irq, void __iomem *base_addre=
ss,
> >                const char *name, unsigned int id,
> >                const struct ad7606_bus_ops *bops)
> > @@ -617,23 +640,9 @@ int ad7606_probe(struct device *dev, int irq, void=
 __iomem *base_address,
> >       st->write_scale =3D ad7606_write_scale_hw;
> >       st->write_os =3D ad7606_write_os_hw;
> >
> > -     if (st->bops->sw_mode_config)
> > -             st->sw_mode_en =3D device_property_present(st->dev,
> > -                                                      "adi,sw-mode");
> > -
> > -     if (st->sw_mode_en) {
> > -             /* Scale of 0.076293 is only available in sw mode */
> > -             st->scale_avail =3D ad7616_sw_scale_avail;
> > -             st->num_scales =3D ARRAY_SIZE(ad7616_sw_scale_avail);
> > -
> > -             /* After reset, in software mode, =C2=B110 V is set by de=
fault */
> > -             memset32(st->range, 2, ARRAY_SIZE(st->range));
> > -             indio_dev->info =3D &ad7606_info_os_range_and_debug;
> > -
> > -             ret =3D st->bops->sw_mode_config(indio_dev);
> > -             if (ret < 0)
> > -                     return ret;
> > -     }
> > +     ret =3D ad7606_sw_mode_setup(indio_dev);
> > +     if (ret)
> > +             return ret;
> >
> >       st->trig =3D devm_iio_trigger_alloc(dev, "%s-dev%d",
> >                                         indio_dev->name,
>

