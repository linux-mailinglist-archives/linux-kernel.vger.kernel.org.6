Return-Path: <linux-kernel+bounces-523783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10908A3DB39
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D1E3B98E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167601F8BAA;
	Thu, 20 Feb 2025 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="h5N36oqk"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABA71A8F6D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057763; cv=none; b=bz1UxeQYH7TrOvdCHjM3Ct5r8rZ18/9eh7/tR2O+o4nxwAJocMEhnf6d9X8z0/i1U1t12iNVzzEUlWnyBtTr7jOpK4hT1x5Y+kRBBHz12FJCd++yuswl22EsDSff7uR3m1jItC0yqwDgEFerP0Bh82fzp/uBZpkPBWdWk78TbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057763; c=relaxed/simple;
	bh=JzQiNVvV4zMev0T902/x3OTikJwmI6nULChGTq+hLSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I32AACnhtUaiGvZUDa/Txox/WFv5ZsPw0g0I1h7Llws5IUTKHyJh392sfgCQJZr/PSia4EogULZDWnHxgjUS5RwsRYtt5s5LMRs7K8r8JXKFr4Lsua6sr5QourjY9OMWrU/O7WVtJ0FZMh/UkqkXjexV1XFGWUeZgpbjafzr+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=h5N36oqk; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3072f8dc069so9136261fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740057760; x=1740662560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81NHAekLbrbLB+xKun/x9cs+4C5eRavXG+rDgduC8Kk=;
        b=h5N36oqksKb+70VZtsDepr3D8Bd3lECJg10X6qA63xamR8HWVbhmRNzQGek9JDUlvE
         H6SH9OewCuLIlVTCaObjnkTTRxxaRd2GHDkSPgiIbgyG0rLKO5QiIsRDvYVxz2Ktoquh
         mTZ8f5VrBCe7VzMQDVasr0aqg9MxIv4k6b+4QxwPeCqx8Ausn2GEdrnbLLFLg+1xL0zw
         WXQF1nbBsBh4bFyi6un70s6geXuvCysClgNXUtpee8gzkHV7lJW9h+hMSfxz5kvsx5Ol
         JQHKuXur1DNCLfHL5Go4UA4Kz0/UbxtJHU5LBOaa1iQ8sUgtj9gSGR6s4IVcoDWGAZuu
         YlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740057760; x=1740662560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81NHAekLbrbLB+xKun/x9cs+4C5eRavXG+rDgduC8Kk=;
        b=Gh9OeS3E8WsM/Og5ftPHwVPu7mEtwOTwUmLgAwH8MLUX1e8EcgTkg2r/cQPoZb3KLS
         ezqKlS0zoBFQwMgnKuTUI8qR/RmsuFOmilbh0rRRIY7Zg0ukilcKW6TBfu7pPQpfh55t
         pHjdf6kH/gQrX3+rQmD5hmN/X3ZoxfAXfvOrBbk7kdkhtfl2nhen1wh/FrTLLx2FDtgH
         hk20U0Cvyq+4j51/RHADHpLq4f/Xe0wo43gzN8gOvm807pRUvHAIY0of1qUa942NDLMy
         J3RqNQ1wMUKtVVDPkjMDlhWf/M2SBKzRdll+n/L6qU0FzTscrMNOKcXMPZIqN786Q0IL
         tcag==
X-Forwarded-Encrypted: i=1; AJvYcCV3fd2r9m6BVmXDtNhRUMAocbdwQe1BbP1UlIrRyI42D69EN4jxsMma4feSlpQArMG9OEGDxAGSTyZ8jkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlaYYDhYZvJ8e2nUXMrNhWnYvOsmOHgpRePgwFdVRHsEUcFvYz
	UFcYltXTCZylLC1MKuz90oKSpckC0IZDe7ZfAa7yuMz/eTIQ3t1FKA2tEoXt8JNT4xKBxqn3HWf
	5rs5deBjkA2YrzaZa0n+qHv/x5LrU9snY41nSaQ==
X-Gm-Gg: ASbGncsTF1ZpFyhpH3mbhtgXJC+PPzoLMAyTEzApGZU8sw5RVVWaoIodqquQUxJU9TK
	x7OHPlEW0I197b48EImLTPYpUpR+03w1Pf6pIC9T3V4yqv8/CfbQX+Q2sIah27qeBIT7aVt90xX
	YCTRFQmOWTZqATqqzN62lzuRsgmLA=
X-Google-Smtp-Source: AGHT+IHKNRo+xD6raRrQyVm06fJdUaq7DfnTTvIjAICA+x4pmb58EVNK92fTJ5xj8CY6e6DOHrDuRmgSFAEVTcy0alw=
X-Received: by 2002:a05:6512:e93:b0:545:5de:f46d with SMTP id
 2adb3069b0e04-5462ef1c46bmr3439159e87.39.1740057760074; Thu, 20 Feb 2025
 05:22:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213195621.3133406-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdao27pu+9qFH2LBYNwYkBbWq1B-hE9nZGfTTCnQxhTiAQ@mail.gmail.com> <Z7crrgl2iFn34gck@smile.fi.intel.com>
In-Reply-To: <Z7crrgl2iFn34gck@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 14:22:29 +0100
X-Gm-Features: AWEUYZmSG9-uENecbLAqUVmmI5xz_5_7MNUpKQdGtyxzhzePhefDmuzle6BOdhQ
Message-ID: <CAMRc=MfSn6xB4eNkFG7E2gQPiF+AmnaidO5=FbvPtvW0N4iDjQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] gpio: regmap: Make use of 'ngpios' property
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael Walle <mwalle@kernel.org>, 
	athieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 2:18=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Feb 14, 2025 at 11:50:53AM +0100, Linus Walleij wrote:
> > On Thu, Feb 13, 2025 at 8:56=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > It appears that regmap GPIO doesn't take into account 'ngpios' proper=
ty
> > > and requires hard coded values or duplication of the parsing the same
> > > outside of GPIO library. This miniseries addresses that.
> > >
> > > For the record, I have checked all bgpio_init() users and haven't see=
n
> > > the suspicious code that this series might break, e.g., an equivalent=
 of
> > > something like this:
> > >
> > > static int foo_probe(struct device *dev)
> > > {
> > >         struct gpio_chip *gc =3D devm_kzalloc(...);
> > >         struct fwnode_handle *fwnode =3D ...; // NOT dev_fwnode(dev)!
> > >
> > >         ...
> > >         gc->parent =3D dev;
> > >         gc->fwnode =3D fwnode;
> > >
> > >         ret =3D bgpio_init(gc, dev, ...);
> > >         ...
> > > }
> > >
> > > Reported-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com=
>
> >
> > Thanks for fixing this Andy!
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thank you for the review!
>
> Bart, do you think it can be applied?
>

Andy,

I really rarely lose track of patches. It's been just under a week
since this was posted. Please don't ping me to pick things up unless
I'm not reacting for at least two weeks. I typically leave patches on
the list for some time to give bots some time to react.

Bartosz

