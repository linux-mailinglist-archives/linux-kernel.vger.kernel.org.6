Return-Path: <linux-kernel+bounces-174584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCB58C1126
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B301F22BE9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA31115F302;
	Thu,  9 May 2024 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xe/5+FUO"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CD915ECDA
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715264608; cv=none; b=GoAG4Kmpij/7q79QMOCv2R/e8vBJf+NEu+pXu9A2HnHNhYnfUxB63j1LUglnImCp7FK/LNIVJAXy+r9hoxBP9f0UasR8W7UAf4Nvy1tDI7PgYEkUxL3R/kJSk55Huoed26gsKfOYWKZpQed4qqiH8ykSgofo55IFiE6xA78fEdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715264608; c=relaxed/simple;
	bh=x8YbEvJ5Rrjoz438wp7iJllu4zawNPBe8f8Blg9DA5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9VuQGbQWY7wVyXatqcjysiOXBDNb89JzZc7acROo20FOQza09ks++O3YgMuvX5bVv4wzUfz1R6yvmdBbFfC/7iWYeB6eK34x8oEUETmbwoq64mZQgszTvtKKDQFnBuHJSzcUI+Mc58OJyk8cY1oJTqoVo9eQB0XA4nMkwo/E/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xe/5+FUO; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e428242a38so13231221fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1715264598; x=1715869398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVjc1LjrqmSxdG//sxnlz0JVmp1Vm2I+bz3GC1JYLVg=;
        b=xe/5+FUO1TYcu0T2LUugFQZe2dIigZv9T/eHqjfhQCZx4aOdgpp2lKIL960mgn+Q44
         0RYhb4pJcEV2BHiy9BuMN4r3Q+/jKzHIb/M5WmDWtGKnOX1fCRkCCZoh1AHSAHmV9Ern
         DwbcKRZ+g4OB6JkI3+CRjzEMn4t2T8XX4+sdhealOsKmphmnsPBop40/TG4vQyusp0Qp
         +F64nECrYdutcBzu61RF29NFF+CYpY2blfoPw+7xWepCjrEwi0VbFAwu5eb3r44fbgqk
         cj4Y5yDtSdvew0GqF5sFyfhgNkBS/lCedYTU07JzCS1Bo7GM+gHsvWc65FXsea12tK9e
         VwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715264598; x=1715869398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVjc1LjrqmSxdG//sxnlz0JVmp1Vm2I+bz3GC1JYLVg=;
        b=J4rePPHJRzZn8SF9zyfPmYhu9jsagzvCZFGl6LaK83/ILsQ3memHalGrxhbWURaaNG
         M5mpeJEIk+0KM6H19GCOPGl8sDrW9SQEWQ2NocCaA4jW6j351B03vw0Q5oR5DJkwkGJy
         UKVrsYhuHXs6hrO1xN/h3UilqITdX+OsOBN/Ve+ERmrbTFtxQVHhRQZxKvoUab/fPGF2
         5I9EKXyLkiP3ZY5xFvmoiWbs6r3RIgOkr7vEwqM31MWDffhhtJHM9/gQHilUZWNwxNU4
         3WzzkEXAR9lzjYLS0WrKgEjjqxxsJ0zbJi8hnHay7VkxLGH3hM1kpVnaY6j28o3jcPRp
         wQvg==
X-Forwarded-Encrypted: i=1; AJvYcCXs8dwHmLUnYp6ecVX9zt0QsOTYS0z1dXqhdtvyxcQZYJUetIz67exsENyqwCkokmoX735Nh45Ugk8eaf8NkEktOmnxhEvHPD/KbvhQ
X-Gm-Message-State: AOJu0YyLquvkbhj/FOpVb9E09L6Z68Uu9rxF0P+mel45Td3AtLkBMXY7
	k4NKCPIUSTNnohvcQRh/Z443xjJkTNnXDMSRHXefyJnmaowMrVBLV0g6LV3NYN2Zeyij36kak2W
	kIdVsohNVzHqgSY9+zNNwq+pc4/jK4NJ7bbvLQQ==
X-Google-Smtp-Source: AGHT+IGX6/N3LlaCiHP0N1FQCU92d8rxIA1spFAp+CcWnfaynpiH3WCoUzbuAETcuxcjhLgGErA/HmCKRZxrF6Zk7Vw=
X-Received: by 2002:a19:e012:0:b0:51f:5d1a:b320 with SMTP id
 2adb3069b0e04-5217cf3cbf8mr4685787e87.68.1715264598280; Thu, 09 May 2024
 07:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508144741.1270912-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Me3XOy6HfqjxDQBwnSW9pOCtK_Ry7keJ2LiXGFB88t4nA@mail.gmail.com> <ZjzWlNdDVVBRD-Ma@surfacebook.localdomain>
In-Reply-To: <ZjzWlNdDVVBRD-Ma@surfacebook.localdomain>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 9 May 2024 16:23:07 +0200
Message-ID: <CAMRc=MeuAQgos+=GmYr0X+5Pi+foJaRNwuNM0D3b4-FwxoD2mg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Return label, if set, for IRQ only line
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 3:58=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Thu, May 09, 2024 at 03:15:05PM +0200, Bartosz Golaszewski kirjoitti:
> > On Wed, May 8, 2024 at 4:47=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > If line has been locked as IRQ without requesting,
> > > still check its label and return it, if not NULL.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/gpio/gpiolib.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > index db536ec9734d..1f1673552767 100644
> > > --- a/drivers/gpio/gpiolib.c
> > > +++ b/drivers/gpio/gpiolib.c
> > > @@ -105,16 +105,16 @@ const char *gpiod_get_label(struct gpio_desc *d=
esc)
> > >         unsigned long flags;
> > >
> > >         flags =3D READ_ONCE(desc->flags);
> > > -       if (test_bit(FLAG_USED_AS_IRQ, &flags) &&
> > > -           !test_bit(FLAG_REQUESTED, &flags))
> > > -               return "interrupt";
> > > -
> > > -       if (!test_bit(FLAG_REQUESTED, &flags))
> > > -               return NULL;
> > >
> > >         label =3D srcu_dereference_check(desc->label, &desc->srcu,
> > >                                        srcu_read_lock_held(&desc->src=
u));
> > >
> > > +       if (test_bit(FLAG_USED_AS_IRQ, &flags))
> > > +               return label->str ?: "interrupt";
> > > +
> > > +       if (!test_bit(FLAG_REQUESTED, &flags))
> > > +               return NULL;
> > > +
> > >         return label->str;
> > >  }
> >
> > What good would it be if gpiochip_dup_line_label() returns NULL for
> > unrequested lines anyway?
>
> Then it should be handled differently in those cases. So, consider it as
> a preparatory patch which doesn't change current behaviour.
>
> (Yes, I have some hack patches locally which do something useful, but the=
y are
> not ready. In any case this one looks to me as a good cleanup on its own =
for
> the sake of readability of the code and reduced amount of checks.)
>

Fair enough but I would like to know what your bigger plan is before
picking this up.

Bart

