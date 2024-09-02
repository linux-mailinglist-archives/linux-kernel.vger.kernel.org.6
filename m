Return-Path: <linux-kernel+bounces-311268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A462A9686EB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D218A1C21E27
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89361D414D;
	Mon,  2 Sep 2024 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IdHhF3dm"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB29187335
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278585; cv=none; b=KfsdXa686/rsRMfDnMhJ6ChZAXOaDaetfLcKd7/IzsJyyTgTrIrSesXMlk49KWPhXlunXxPET6spTpZbmzmYMgRy9D/xvakfNTN3RqDwHmVUkeqccERcTUyAH3JgeyGStJpBL/Vu4aeOyw/LF9aJl0pULrL7FegoxyLEA39vQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278585; c=relaxed/simple;
	bh=cVP0IHO5A7awB5ibjG1zf8b/Yv6xVTa1CiYEtds9vmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PH2O8WCYdzEwg+hzEPTEm2IS2bWxFK4OqsExkUOZ+DQQvSebSZCxePdqOMJRR+hDL5tMpl4NbmihsU1VtrJmV54B9t0DxBk9IA/7FgfhEf2+SvU4FEYKUaHnHe+aDxz693gXrZYJHlvNdzfKqIxd8IkVuKW4sgagLiSkS3zRIr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IdHhF3dm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f3f0a31ab2so46990651fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725278582; x=1725883382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3iL8EEnDa+avOSvHi72DgRH7vkxFULL8PH6mFq0m2A=;
        b=IdHhF3dmv37GW1sY39VP5/GP6VZnpnVxnNTSoRQx2D4/dfMKl2IhLx0YlXUGYy0FVb
         fpv7dHf61+zh6dF2Entk6vMOnfLVvTeUzdDje2tEgmkCaH1DOdpifN87R3vjClZkC1fo
         Xdn73BMsSH4JUjA5Y+KsEV7Xs3d9+kLd/h4UCfEk097rotI+I8cqeZrly0B1u50RkF9E
         TIjTo9H1AAm+8d2UeMuBfZDD2IcjRYH3Yn5Gq822HyG1J9pI5IyzibTTS+g9mKBWrz3r
         Ekhq+8sKxBahr1jp4o8Cic95u/uYiqn1GWLuWynhue2+pObjtKAb7mXJwOYpjKRPu9UQ
         IAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725278582; x=1725883382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3iL8EEnDa+avOSvHi72DgRH7vkxFULL8PH6mFq0m2A=;
        b=htXGUS2/J9AzUAwTBy1Oko+S2LVofCBPlEb9MV77xTAtIDr/LkYMSoFeFKJjAD5uBB
         lQqVnYsnoyHqOBZ851/akaIcCqPR/sFts/lpa+vntQb+r5UI+pa78j64PAw1uYo7DBES
         4ur2iCdh9zbKIqC6GfzNrE7Z4xECoPH9KCDy/PMkNUoqIh72/cIu3jcR3Yul6MShhB0W
         60jMqmZVKewJmVAM2+jXgWwVtqfr/35P8E5vuMv/ksz+3UiG6RPABc6IyH6/xvHUSQQB
         nNu11b3MnQPGXxhNDK87yOzFNMfZNd60pot1owDzfEl5HP/f66HxmzvPzwuUbA+Hemq8
         jkvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHdJPx9wZUzwXBN0D2aZLd9rOOX6aW6JIHG5HyXY6hSkzwRiGw8wq4ig8IhWM0er48UZPoUfPGYCTSkRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRGEfOaNAhn5NKYREjnljF9kLCj7cmBHbtDzzo0s6vn/ZhYn0C
	IiQADqYf14UalF1Ig9SPsZlY4VzyzJZ0afdv/QRJwVLMRV6/+KBjlwvjKR4MbMmcsUo1KHg1oVl
	O56I5OSz9U2gdsVjzuDSQT0sVHjtQ18hJMbAydqlHvJExBVKF
X-Google-Smtp-Source: AGHT+IGIFfI2KYarIAoQ0rVdC31hvp0mhTH8JrhkPdhh37I8qz+0L5/vUvUxavKtdgPYRS8AmsnZxJnKlFMU81LujZY=
X-Received: by 2002:a05:651c:220b:b0:2ef:2bb4:2ea1 with SMTP id
 38308e7fff4ca-2f61038eec4mr100570511fa.4.1725278581079; Mon, 02 Sep 2024
 05:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826161850.74447-1-krzysztof.kozlowski@linaro.org>
 <Zsy6pZ9LYDk0LOHs@smile.fi.intel.com> <0187710f-73c1-4ee1-87f9-384101f0c32c@linaro.org>
 <CAHp75Vfq0kEN-VDd=aTycHH+oEkUHt260nH533UWnkoEnGRhjA@mail.gmail.com>
 <CAMRc=MdGUYQFJ6GnryL51AKPpXOW5FuV+SZxAtqt+moJpvLQ7w@mail.gmail.com> <CAHp75VfCi4x-h-E9b3kw3eoOTDaOae5b=dzBiXo+cn1Tyy-gQw@mail.gmail.com>
In-Reply-To: <CAHp75VfCi4x-h-E9b3kw3eoOTDaOae5b=dzBiXo+cn1Tyy-gQw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 14:02:49 +0200
Message-ID: <CAMRc=MdQRk-+jMVvpz8TrtTz1TKO29YSOaJchhKwrpioaWYSqA@mail.gmail.com>
Subject: Re: [PATCH] gpio: kerneldoc fixes for excess members
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 12:38=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Sep 2, 2024 at 1:09=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> > On Tue, Aug 27, 2024 at 4:02=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Aug 27, 2024 at 4:55=E2=80=AFPM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > On 26/08/2024 19:25, Andy Shevchenko wrote:
> > > > > On Mon, Aug 26, 2024 at 06:18:50PM +0200, Krzysztof Kozlowski wro=
te:
> > >
> > > > >> Drop kerneldoc descriptions of struct members which do not exist=
 to fix
> > > > >> W=3D1 warnings:
> > > > >>
> > > > >>   drivers/gpio/gpio-pch.c:101: warning: Excess struct member 'lo=
ck' description in 'pch_gpio'
> > > > >>   drivers/gpio/gpio-syscon.c:46: warning: Excess struct member '=
compatible' description in 'syscon_gpio_data'
> > > > >
> > > > > I prefer on per-driver basis, but since it's simple and I have no=
thing
> > > > > in my queue,
> > > >
> > > > These are so trivial without impact on the code, even if W=3D1 repo=
rts
> > > > them, that it would be quite a churn to handle multiple patches.
> > >
> > > Even trivial changes may lead to Git conflicts if managed separately.
> > > But as I said, there is nothing in my queue (at all) so there are no
> > > chances for conflicts.
> >
> > Is this an Ack for me to take these or do you want them to go through y=
our tree?
>
> I was under the impression that I had sent the Rb tag (there was an
> explanation about my preferences which do not prevent this from being
> applied). Should I resent it? (Yes, I have checked and it's there,
> `b4` should catch that.)
>

I don't have this message for some reason. :(

Bart

