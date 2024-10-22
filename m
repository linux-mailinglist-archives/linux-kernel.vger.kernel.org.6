Return-Path: <linux-kernel+bounces-375693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B523E9A9974
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1FA280577
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C655149E1A;
	Tue, 22 Oct 2024 06:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lGY53Q9h"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE681448E4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577398; cv=none; b=u/92o7qkTJtvbNcrwUW+ujkNbsZY/8uZQi0uCm2zxnKRbg8u0A41HH8rVzGowoIK4BTTurUsIVR5kepYAAkU5V0s2QtmJHARmMQ2HMlco+FN3serHU2p/crWxF9NooI1blyLBtgc783jaq5nTtvzKmjQ5uXhsH967giFTbfp5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577398; c=relaxed/simple;
	bh=RYNViOPjs0qfwljodNXQeGyiOsVETWKj6+tpPo0gw3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ef/7A8x0i7vKZ5EkZa87Kg85R+1LNxmYfjmUzHkrqbISUspcrM7Wmnu5JZSzI+4yPQ0E5+3VHr1Af50KM88IhoJvaHtpHWKdXE1vx7pPaZDmRLYKlyAznu83gusAWLOhb55dXuXGBDWS4NJnXvavPunZFrxedoqRfg4ejd84fR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lGY53Q9h; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50d46cfcbc1so1411050e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 23:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729577395; x=1730182195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oPA1++gLWQWFvzTYpeR6sYF2qQIZ9tBVu8CJKZGcRQ=;
        b=lGY53Q9haZmTB+kT7pjemn/Xkt6Lv8H+3aBzAHycjYEHUjQXXgzJIXtSKFkEKK+TGS
         TRvwxaddsmCnTVe9JjfxNzNep/iJUNn2Pnd9NSNlKFa52RKjiH3KN7OAfroOw+x74wlP
         ub1bi1+t9P7JtCCX705o7iKrDuTUu9/+fVPKdr4M4FnazksB4H7EmRibcFSHsDfRd5aB
         LxDNwwgcLGh9Oc6MfgJ2YOciZM3KqtGXWJBCDmvgalAbIQqfyLwSf30TeICIxm9hG5Ha
         EMB9ZmO7wKYbpkbRHti7kc3eXsireoj0OWjxcMamZ3Fbx+TQES+4NztvkvGkAbG9rYab
         zyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729577395; x=1730182195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oPA1++gLWQWFvzTYpeR6sYF2qQIZ9tBVu8CJKZGcRQ=;
        b=ZCjQyR8Rb4K9FoLV0ClbasO6gGv9THaKzwpXSB5GUDcbNlYMhwugqyO+V33L6Uzr0b
         bidqXgvtaD0MU9LeQXerkCFFGSvBAicxKUmVqM2YJjwm+wT1Sqrb+uD73uDdVthG/k8f
         bgBx9LbABDItvxnidGz+d6dnAVrodc3ptNYmO//JadsxfQrhQoLIJNVxecpy4fQAjzpl
         ZDnguIbUDcT5fIo+ji1pFduXE4Bt7nGKgkOr5X26C9Wxo8e/0EfMAp2H8stcbyqSJ2No
         xJG+AuiuBXeHl2EZ5742ab76PNQyn0Hjr5KKYuYGgdz5yMjZMK2KU8+hPs3GCm3GLy+B
         RiLw==
X-Forwarded-Encrypted: i=1; AJvYcCWXvRfKNUrTemB69HSG+1yTLOWYhfl2GRmt2lJFlsHDoEVzgGsJeHAtraEEfT9XAmZuwUp6RIusmYRmzw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRCijTpVSLdEJXarteyfOs1mSHPZ/UKJ8IEwCfoYPrdQwXkHsJ
	tkdTWtg4wOQv09HGDXmXFuIgvm8++4FJ9XTPGp3Y9uFOM8L5D7380lP22tKbobgtkwPbPreEa73
	/+Dnk7FIEHNE0NFzvZ0vQEtfDhfgefYjxbS3LiA==
X-Google-Smtp-Source: AGHT+IE3wc+LCKuHli2wuMbRdahOui7PqfSTzFfrH+tmjl9a3NTlUglV7xXSsSlrCqlm17xHnQ5uDRj+5ZkjFmjANCc=
X-Received: by 2002:a05:6122:169e:b0:50d:8d89:9f4 with SMTP id
 71dfb90a1353d-50fb2707490mr2701901e0c.3.1729577395133; Mon, 21 Oct 2024
 23:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021130221.1469099-1-aardelean@baylibre.com>
 <20241021130221.1469099-4-aardelean@baylibre.com> <f319c8bd-1edc-451b-aeb2-27ec529267a3@baylibre.com>
In-Reply-To: <f319c8bd-1edc-451b-aeb2-27ec529267a3@baylibre.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Tue, 22 Oct 2024 09:09:45 +0300
Message-ID: <CA+GgBR-eKUir7FGOfimv0rE2yP3P3awMZSG8=6t202GAthi=Mg@mail.gmail.com>
Subject: Re: [PATCH 3/6] iio: adc: ad7606: use realbits for sign-extending in scan_direct
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com, 
	gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:19=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 10/21/24 8:02 AM, Alexandru Ardelean wrote:
> > Currently the 'ad7606' driver supports parts with 18 and 16 bits
> > resolutions.
> > But when adding support for AD7607 (which has a 14-bit resolution) we
> > should check for the 'realbits' field, to be able to sign-extend correc=
tly.
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> > ---
> >  drivers/iio/adc/ad7606.c | 24 +++++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > index d0fe9fd65f3f..a1f0c2feb04a 100644
> > --- a/drivers/iio/adc/ad7606.c
> > +++ b/drivers/iio/adc/ad7606.c
> > @@ -568,7 +568,7 @@ static int ad7606_scan_direct(struct iio_dev *indio=
_dev, unsigned int ch,
> >                             int *val)
> >  {
> >       struct ad7606_state *st =3D iio_priv(indio_dev);
> > -     unsigned int storagebits =3D st->chip_info->channels[1].scan_type=
.storagebits;
> > +     unsigned int realbits =3D st->chip_info->channels[1].scan_type.re=
albits;
> >       const struct iio_chan_spec *chan;
> >       int ret;
> >
> > @@ -603,15 +603,29 @@ static int ad7606_scan_direct(struct iio_dev *ind=
io_dev, unsigned int ch,
> >
> >       chan =3D &indio_dev->channels[ch + 1];
> >       if (chan->scan_type.sign =3D=3D 'u') {
> > -             if (storagebits > 16)
>
> I think it would be simpler to keep this if statement for choosing
> which data.bufXX to use since there are only 2 choices.
>
>
> > +             switch (realbits) {
> > +             case 18:
> >                       *val =3D st->data.buf32[ch];
> > -             else
> > +                     break;
> > +             case 16:
> >                       *val =3D st->data.buf16[ch];
> > +                     break;
> > +             default:
> > +                     ret =3D -EINVAL;
> > +                     break;
> > +             }
> >       } else {
> > -             if (storagebits > 16)
> > +             switch (realbits) {
> > +             case 18:
> >                       *val =3D sign_extend32(st->data.buf32[ch], 17);
> > -             else
> > +                     break;
> > +             case 16:
> >                       *val =3D sign_extend32(st->data.buf16[ch], 15);
> > +                     break;
> > +             default:
> > +                     ret =3D -EINVAL;
> > +                     break;
> > +             }
>
> We can change this to:
>
>         *val =3D sign_extend32(st->data.buf16[ch], reablbits - 1);
>
> Then no additional changes should be needed to support 14-bit chips.
>
> And similarly, we could avoid the need to use the more verbose
> switch statement.

Ack.

>
> >       }
> >
> >  error_ret:
>
>

