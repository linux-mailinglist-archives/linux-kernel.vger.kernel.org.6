Return-Path: <linux-kernel+bounces-531078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22868A43BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3C617374D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2928265637;
	Tue, 25 Feb 2025 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mAUkYqqF"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484A8260A3D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479747; cv=none; b=mIh7NbvWD5CVwREQRMh5QCTsLDS1Zyc/uClRZMgA3l0LmoGDG3tkYgJ0Gyojwy6IBQHPzu82WvPu09keT2nbaxImVzPwpx2gg94V1as16bnk6EVx/GF2v3buDGgixJy3fNBlsqhZ7LPfUUBRSYWixDssVfJe8Kl0sVeg5LZSzMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479747; c=relaxed/simple;
	bh=mqeYPrC0Jbni8o2GPLE5Q5M3lXmezH0A/f1uj17SVkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3NE9/dKeo+mw5qWaSQselW/fY2nMmM2+NAHsXDmT/cHHEQwjeBhAuLOcpmUweF2eF+n49OCmHYPIPYfQ4mFFary8h9VYB4yLb3EXJBBYm7HdWXHj/IxlkbUQuwOEcZicDa0XGB8SH2mmASm7PoWHtw01BFVM5FB4oeYL5d3Ujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mAUkYqqF; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5461a485aa2so5021060e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740479743; x=1741084543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWkswUZMqfevVy0UXA4NMvw9eRHX0pnwJJJrYa4op+c=;
        b=mAUkYqqFDEa4bXqYNb1Z6+tjQCl95Oc1vObnHT0F6MYWSflG7eX/99ONYlMKEZWfIU
         ovhigruU5OZMhwI/m2JSPHuSDOS9ZK61bIpvS0UYQezA7BKu1YDN08ivb7/BI4xnk/gH
         R5juaQrDXR5kX5DjYTyMf7D329PeI3flBmeVKqLoDzTjxOBrSozln4E6qKeO2TeLrzjI
         HdrZ6HvgmIck0uVQKsIh9gGVie+KYyLVVNWhrpR1e6Um2cqEKyVkC+YX5myV4wyTIIv1
         Or3z1rmp7g1EHoF0FaS9X8i8IKhhN3cOP3qiGZFGzKiVDPaXU1OYvW/d6SlJoaW2U8pA
         DzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740479743; x=1741084543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWkswUZMqfevVy0UXA4NMvw9eRHX0pnwJJJrYa4op+c=;
        b=MSFN5UPHARlK3w5dEw+RoRyVUiHtNslfixS9oxD2peS4S/aumBuTFbj0YbwixSAvU7
         ZoL4WrywfI/jAeQtNFau3a8oSirqHvKMXzw0jFfTrmGTcuYSJnvuYhIev3wEr9keQ0m3
         9hNvvXS0etWD/jIpRXi7HvYoo4NTsypOs5I4nAPxB98z1EjjDiWh40v+kIus+SnB44ip
         9+JhzHd6p02fD4ONWo54LNKNb2sWO3aQLFAZs6/cNt1aCrgIqAqJmiz/UNSLmXw9BSxA
         UfRCBUGx2wlcPKFaePGDiSieh69Q0Wab3blrDeRYTIRUUVJSCNAWJpS3cwbXNhz8OgH1
         Vw5w==
X-Forwarded-Encrypted: i=1; AJvYcCXv/aoP4rdJAQ9q41kWGRCnyO3QGdVPuNzBnE4mHqEjV2fQx10Lm5ZaqN8FGuA14mEfQGmVw5DWfEjwne8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmaIaXIuxvVhdZPlaX5+3u6zGJYb/GhrHViIOCCyPdFcBoMa6
	u5t68Z1M6KCHdGyw6q4KlBoRJZso3ygbC1GJUWdQR1YiyIP/sV2/gYqY6oRPRZ8dmj6UYC3eSQB
	iqOw1cSs/TnUtvG9tp4+t0iB08uyqZ7Nw7qrrTg==
X-Gm-Gg: ASbGncsQpB4GwH1EX/MAfCgPDnMgeeDqDyIQsGejY0TmRf3Q+O3MFTIjLP+MVFeMy/I
	sZb0/AmUnXzM/pVx49SmHklA94l6u/DvjvZkT74AHObpta83MI5Bnvs3WK5pEyabPFnSPjmX+gh
	O+v6IhOIlaKAoIP8aKwGbouDAsLuwD+wcnDH64GFg=
X-Google-Smtp-Source: AGHT+IGVGBEo9wyLm1K/x9da5Fbed363zPzOoOAfJYzvu9T++3+EDILNDSJrlots2Z/U4bIECPAu75iCiDMiHdSjPWo=
X-Received: by 2002:a19:f61a:0:b0:548:de7f:b3be with SMTP id
 2adb3069b0e04-548de7fb4e5mr313788e87.21.1740479743336; Tue, 25 Feb 2025
 02:35:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-gpio-sanitize-retvals-v1-0-12ea88506cb2@linaro.org>
 <20250210-gpio-sanitize-retvals-v1-4-12ea88506cb2@linaro.org> <Z7yekJ8uRh8dphKn@black.fi.intel.com>
In-Reply-To: <Z7yekJ8uRh8dphKn@black.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Feb 2025 11:35:31 +0100
X-Gm-Features: AWEUYZnCp-KDYRM5tDKxLTZuy1OY-X2886HZx6-p_7y2wEThFHxE_ISRfreGXp4
Message-ID: <CAMRc=Mej-GHH3buisJLhRfqoWd9Bfcfy-jbHJM3Oe2Cw=Bk9Ew@mail.gmail.com>
Subject: Re: [PATCH 4/8] gpiolib: sanitize the return value of gpio_chip::get()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 5:30=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Feb 10, 2025 at 11:51:58AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > As per the API contract, the get() callback is only allowed to return 0=
,
> > 1 or a negative error number. Add a wrapper around the callback calls
> > that filters out anything else.
>
> ...
>
> > +static int gpiochip_get(struct gpio_chip *gc, unsigned int offset)
> > +{
> > +     int ret;
> > +
> > +     lockdep_assert_held(&gc->gpiodev->srcu);
> > +
> > +     if (!gc->get)
> > +             return -EIO;
> > +
> > +     ret =3D gc->get(gc, offset);
> > +     if (ret > 1)
>
> Perhaps use the respective GPIO macro instead? Otherwise it's not clear w=
hat
> the meaning of 1 is.
>

We don't have one for GPIO values.


> > +             ret =3D -EBADE;
> > +
> > +     return ret;
> > +}
> > +
> >  static int gpio_chip_get_value(struct gpio_chip *gc, const struct gpio=
_desc *desc)
> >  {
> > -     return gc->get ? gc->get(gc, gpio_chip_hwgpio(desc)) : -EIO;
> > +     return gpiochip_get(gc, gpio_chip_hwgpio(desc));
> >  }
>
> ...
>
> >               for_each_set_bit(i, mask, gc->ngpio) {
> > -                     value =3D gc->get(gc, i);
> > +                     value =3D gpiochip_get(gc, i);
>
> This will delay the function for checking every time if the get() exists.=
 Which
> must be here.
>
> >                       if (value < 0)
> >                               return value;
> >                       __assign_bit(i, bits, value);
>
> What I would expect here is something like this:
>
> static int gpio_chip_get_value_nocheck(struct gpio_chip *gc, unsigned int=
 offset)
> {
>         int ret;
>
>         lockdep_assert_held(&gc->gpiodev->srcu);
>
>         ret =3D gc->get(gc, offset);
>         if (ret > GPIO_LINE_DIRECTION_IN)
>                 ret =3D -EBADE;
>
>         return ret;
> }
>
> static int gpio_chip_get_value(struct gpio_chip *gc, const struct gpio_de=
sc *desc)
> {
>         return gc->get ? gpio_chip_get_value_nocheck(gc, gpio_chip_hwgpio=
(desc)) : -EIO;
> }
>
> But I see the downside of it as it might lurk without RCU lock if get is =
not
> defined. So, up to you.
>

Makes sense, gpiochip_get() is only called in gpio_chip_get_value()
and gpiochip_get_multiple() where gc->get is already checked.

Bart

