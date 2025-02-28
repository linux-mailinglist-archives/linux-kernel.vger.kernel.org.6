Return-Path: <linux-kernel+bounces-538369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8F2A497B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0053AB0B7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AE225E441;
	Fri, 28 Feb 2025 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="x4jwfCXU"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920D17BA3
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739648; cv=none; b=BisBvWiPCppldHrlqf0oF7kJTCrioCxP3hE+X/JFOnK5h7TLEjmUPidHYIEoiFBWsXEmIYLu91bZ4fYeTGbN1II/+t+dUivkAqt2KBdk2NpF8vp9YFe3ch9CeNqNriATenuleagv5UvgPU0zqMH/uRQHCqjkrESY9yXPVhWZ6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739648; c=relaxed/simple;
	bh=adFr6LIh6Hc/Whhmuu/2vxEDLTlbpeP4eiUSQCRWTnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9rYuJN1VioMa5GU+WqB+R5v66FMdtSG7RyzLReplLxbQy15YiMkwU8xEwrRxbkwGBC4BjomF2HRUBCP5zS9ZYFyVnKkwXOs9QveVfO0x1bkCG1qFC0EGKaM8FEhWMB4ulQMZnLV07XUVMU4nKJpeBIlPB7ejJxiSbSCTz/9adI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=x4jwfCXU; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30a2dfcfd83so18701251fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740739644; x=1741344444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NU92PAxMuIwAbEifcOhSO2wdvjiG74/DYY2SKby5M8Q=;
        b=x4jwfCXU8qnhA/E7dxnO/3mzA5MbPlXrr06j8ZTEaYGIPYBgfqopACztAjJC+mSP+s
         jtPBoemAv+azun13ILcYnrCEH3f4+HJ+jMolgxUzURRFBAsRQhw1Sl54oi+9DokgkZ3E
         DjDW/rL8pIC388hzOPkhIUd7ix7MwHvuZjmFGgbzdQnqCnydfQ1GwEtldawdBJ7kNl6t
         HM9jSB1VfG61MGkAxWWvHGCFUCi/azQiN7F+70EYHCWiKS3nknL1KkpmO3whoo5D9YK0
         OvH9wklaiFPykyEslaqG2rJTylJ4mVRg1rHWfg2xc3BXfQXmA4XVUvcXOVl+6sUcrjTL
         TS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740739644; x=1741344444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NU92PAxMuIwAbEifcOhSO2wdvjiG74/DYY2SKby5M8Q=;
        b=F2u+TbtPvHIHsxnZiwDDsMIfdLeqJd0WqJyWNJhnG2Q8M8Y4GD820s4WeKiPH5JvHz
         hjnTLd8BfywvKDILZfguZmNzT9XwrHH/YqUYDK0ziCA2hGSrxIAPwAe11z+ShH5KOzYy
         uYZqAgV92AxeVyoPuBKM6m1InqNK+NBeoob2PCyVf1tbj5OgFqZjZRqKL5IJXtTUf+NO
         nDti0kiNMdLz0upHECUq2uK5qtD18mcvcuiAi+vHltJysCpCDf92DIo0wHv3wkqN6Rqj
         XXmUto+MtDwGZdjk9MmnoRqqyU8YH1GIl6sQpr3HiCIX7TIAH7EnN2BdhFO+f+sr4gBS
         tXgg==
X-Forwarded-Encrypted: i=1; AJvYcCWiFcWzLLqXbkRyc2BHvjolt60U4fcn7w63WCl0CBFkvn/aWfiD0qtyWmYnwoUz1DcPQc94/wI3UCQ3nuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOlcVc1x3MS0xvovU8LWqbkZkmqTnedlde/YZpi6Zi20xFxrSj
	BxhN/EYcMbdP6FeQaL3BCEzUGY8rq+Di0f10iw++Xkn+fz3z83Ak6dygMiXlhoN1FygMNbOu7qn
	axt0YPCxYy23v/VEb2807SE92qUKGKH94NH1Wyw==
X-Gm-Gg: ASbGncsxSnEejCO+xi43XOu/aZU3GdlhUtkc6fABxXf/v4EvYNK1SVshP+ys68BzFq3
	KhLjkEMj/A1Se79DylBdZwOxX5ZMVNmOQLdbQsNu0Pl+7bhm2wr1D3iGzhV7jTXBtQgIdRJBQIJ
	exLhhkIbebnrxki4SOLXrvmlxiamGcKoP+G7c6+LU=
X-Google-Smtp-Source: AGHT+IEffbnoGh/ZB0Av+vhJaJSeIcPXpBvqptVNxXGkyb3XMvwRwNUY07bvRzkN6KART5xjUd6SjTwMbagTMx4dBss=
X-Received: by 2002:a05:651c:1545:b0:308:e803:1175 with SMTP id
 38308e7fff4ca-30b930c7c11mr9231511fa.0.1740739644452; Fri, 28 Feb 2025
 02:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219102750.38519-1-brgl@bgdev.pl> <Z7XqSVfhPGI5J63B@finisterre.sirena.org.uk>
 <CAMRc=MdEcjFUp2OEutcnDqSHbbait3f25NEWbdp7mARyKZLvBw@mail.gmail.com> <CACRpkdbkcX5pEeikkDZAxSGp+M3kJH5SWimxQA6P35iiDAUNdA@mail.gmail.com>
In-Reply-To: <CACRpkdbkcX5pEeikkDZAxSGp+M3kJH5SWimxQA6P35iiDAUNdA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 28 Feb 2025 11:47:13 +0100
X-Gm-Features: AQ5f1Jq-ljcT0uOKj_SffP5eijOqNrKUyeoMU_8l6yP7Bn_KmF7NH0MYmjepHtY
Message-ID: <CAMRc=MfcyAxF6Q4XyCiJs-7jCDX5dyT5=1HPmcDGQGiJoXf5Sw@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] pinctrl: bcm2835: don't -EINVAL on alternate
 funcs from get_direction()
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Liao Chen <liaochen4@huawei.com>, Chen-Yu Tsai <wens@csie.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-gpio@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 11:53=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Wed, Feb 19, 2025 at 3:30=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> > On Wed, Feb 19, 2025 at 3:27=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
> > >
> > > On Wed, Feb 19, 2025 at 11:27:50AM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Since commit 9d846b1aebbe ("gpiolib: check the return value of
> > > > gpio_chip::get_direction()") we check the return value of the
> > > > get_direction() callback as per its API contract. This driver retur=
ns
> > > > -EINVAL if the pin in question is set to one of the alternative
> > > > (non-GPIO) functions. This isn't really an error that should be
> > > > communicated to GPIOLIB so default to returning the "safe" value of
> > > > INPUT in this case. The GPIO subsystem does not have the notion of
> > > > "unknown" direction.
> > >
> > > I see this was already tested for these specific boards.  I've also
> > > found that Avenger96 is failing with bisect pointing to the same comm=
it
> > > this is fixing:
> > >
> > >     https://lava.sirena.org.uk/scheduler/job/1126314
> > >
> > > as is the Libretech Potato:
> > >
> > >     https://lava.sirena.org.uk/scheduler/job/1126285
> > >
> > > neither of which produce any output before dying, they'll not be fixe=
d
> > > by this change.  Seems like an audit of the drivers might be in order=
?
> >
> > Right. I don't know if they return EINVAL or some other error so let
> > me prepare a change that will not bail-out but simply warn on
> > get_direction() errors in gpiochip_add_data() instead.
> >
> > This patch can still go upstream IMO.
>
> I'm fine to apply it, maybe as non-urgent fix at this point? (for -next)
>

Yes, the offending changes in gpiolib.c were dropped so this can go in
the non-urgent way.

> Do you want to send a non-RFC/RFT version or should I just apply it?
>

You can take it as is. It got tested and reviewed, so the tags served
their purpose. :)

Bart

