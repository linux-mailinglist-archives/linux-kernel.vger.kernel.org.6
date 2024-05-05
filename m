Return-Path: <linux-kernel+bounces-168968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BBF8BC05B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 14:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72EDCB20FFD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 12:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236BF1BC39;
	Sun,  5 May 2024 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="C4rEVt+b"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A7C17556
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714911914; cv=none; b=nydk3Upowsy5UpXgQPLjKmg0bDCnpC8NuUg3p8+zR0PKhR81peUUW5zfUxv2ImsRe0vsEfBZ3RTJYd5cXuCmsjIC1kFi5qEzOAcHwPyO1qX8Hm7qpBZ0eSeH9447nKtaq2Vzff6Za6qsIUJYtlFUhGFbQ5b+Fia3+fAxTKkXUdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714911914; c=relaxed/simple;
	bh=yrQqbN5qDXhsCWhv8edlKrikJt0tdGrh2rwpISyK1Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBwpzsvwRWWb2SD9TrvZWouwAzqDVEM04rcAZqJqfJBEnJ29xWGe3ssRm/mpFGsxyuGIFLJDpIlZx4L7OFMx6F02miURkxzPMqnS314fQYZ6Vuy7Uu2QlSVTCK3Q/Qpqxs05scGaWIeZXaHvgmnGcCiIJwukcAF59qcOskJt73M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=C4rEVt+b; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e1fa1f1d9bso20354061fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 05:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1714911911; x=1715516711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6d8pltQnbe1BNul8TKdyylJH57jCMCGH7OFNBm5Jck=;
        b=C4rEVt+b13HI8XC3SCWwlaVD4zD2doCRm2g4yQsdhiE5iO35klgZphT3h/u/RpisiH
         7yoHa2nHdEOY3AM9QPMEfwjhBcWkuohBcDXBmjZRy7WMQFknyy+Tq2iX3k0lYdMRCzni
         MlICsHei+6dF5hDf5vV8bz42G7ba8bx1+a5q+Jv5bjl8lPYmxLjzBeORfJBhwxGpcnXU
         ZAWIWIBYpuH+7RQ1oeEnZlm2xfWwU8467OEwzhv8rgeHCJ6Um7AYVyVcLeMPjVXVAvIP
         zXbkJHdqTIPNIN+JyGI5pfnir260CgZMod9PnvVN3ZJs/uXFGqpe6BwlVDQkVOeEvqei
         paig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714911911; x=1715516711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6d8pltQnbe1BNul8TKdyylJH57jCMCGH7OFNBm5Jck=;
        b=G06x68zlxqLZSkEMfcY3SFu+EDDFzOU5xElGQatm9JcyO6ZQrNc4G5nNwKqnZUC+Ts
         FobANSt1E2JHeoweJOJynqT7zV9mIFjxhXi+Ct9F36Tt8lvJ+9U3Crlkk8Lc7+m4D2tc
         4mUpguQTCnm16heFIsnXPkR5khgDhbool7qG1CosaiT3x1AoHJKFtlOpIl5v1tRwUlzC
         FX2Qp6dUkBCqXjeYPQVjRDI88F/DD+2rHTP086hAKZIZBUgqbs1nANTm3BGsrEfdjwjC
         siuVDKWKDBMvam6Rkui8FdMWUXcFX73qAkoRic0KYllRB7fpd4JInvoiho0zT88Kxdi0
         O5Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWtRWQ7Jq4h2hK5htP7Ve6/9+6B97PuhcOhDM05HEj4q5ImkosPtYgf4/2xw/JLU0U4Ghi5wVaFvyuht2u9fv/fXGWVXQaotM3HKL4O
X-Gm-Message-State: AOJu0YyzI+Hfta/lWvonIbEjneoQNCW9+jo/mc2iflZhzqfjMMbBR8Wk
	bc0b+SXFazJEcWID42tNlW95iZWdB7HlbkjLpIaCVwHs0Hdt7VHc+rGd5nOBWNaVEeFxk+nb9p1
	Z4CpF3eyqc5ePnhM59IA01ajje/8Oh84tNHsXzg==
X-Google-Smtp-Source: AGHT+IGHC8sNZwgMzoG3QPzD5Yufu5CNex3JNhg27cIEDBNo3bkezg4pBrhViAS/E/M0FeLM7mdMlT2yKEfcduH5taI=
X-Received: by 2002:a05:6512:4027:b0:51d:d630:365c with SMTP id
 br39-20020a056512402700b0051dd630365cmr8601279lfb.4.1714911910873; Sun, 05
 May 2024 05:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424185039.1707812-1-opendmb@gmail.com> <20240424185039.1707812-3-opendmb@gmail.com>
 <CACRpkda4v6Nu8V3MVamDpfs4qnc89e8Vd8fSyaNsqJQ40GQqZg@mail.gmail.com> <45b7742c-9cde-4238-9c2c-c75dfbe9d8f3@gmail.com>
In-Reply-To: <45b7742c-9cde-4238-9c2c-c75dfbe9d8f3@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sun, 5 May 2024 14:25:00 +0200
Message-ID: <CAMRc=MfEVCDf8sn7C-cO_Y1xa4RehQj1tvRSRtC5aj0dF6uJWA@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: of: support gpio-ranges for multiple gpiochip devices
To: Doug Berger <opendmb@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Phil Elwell <phil@raspberrypi.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 10:21=E2=80=AFPM Doug Berger <opendmb@gmail.com> wro=
te:
>
> On 5/3/2024 1:25 AM, Linus Walleij wrote:
> > Hi Dough,
> >
> > thanks for your patch!
> Thanks for your review!
>
> >
> > I'm a bit confused here:
> "Communication is hard" and I may be confused about your confusion, but
> hopefully we can work it out.
>
> >
> > On Wed, Apr 24, 2024 at 8:51=E2=80=AFPM Doug Berger <opendmb@gmail.com>=
 wrote:
> >
> >
> >> +               /* Ignore ranges outside of this GPIO chip */
> >> +               if (pinspec.args[0] >=3D (chip->offset + chip->ngpio))
> >> +                       continue;
> >> +               if (pinspec.args[0] + pinspec.args[2] <=3D chip->offse=
t)
> >> +                       continue;
> >
> > Here pinspec.args[0] and [2] comes directly from the device tree.
> >
> > The documentation in Documentation/devicetree/bindings/gpio/gpio.txt
> > says:
> >
> >> 2.2) Ordinary (numerical) GPIO ranges
> >> -------------------------------------
> >>
> >> It is useful to represent which GPIOs correspond to which pins on whic=
h pin
> >> controllers. The gpio-ranges property described below represents this =
with
> >> a discrete set of ranges mapping pins from the pin controller local nu=
mber space
> >> to pins in the GPIO controller local number space.
> >>
> >> The format is: <[pin controller phandle], [GPIO controller offset],
> >>                  [pin controller offset], [number of pins]>;
> >>
> >> The GPIO controller offset pertains to the GPIO controller node contai=
ning the
> >> range definition.
> I think we are in agreement here. For extra clarity, I will add that in
> my understanding pinspec.args[0] corresponds to [GPIO controller offset]
> and pinspec.args[2] corresponds to [number of pins].
>
> >
> > So I do not understand how pinspec[0] and [2] can ever be compared
> > to something involving chip->offset which is a Linux-specific offset.
> >
> > It rather looks like you are trying to accomodate the Linux numberspace
> > in the ranges, which it was explicitly designed to avoid.
> The struct gpio_chip documentation in include/linux/gpio/driver.h says:
>
>  > * @offset: when multiple gpio chips belong to the same device this
>  > *    can be used as offset within the device so friendly names can
>  > *    be properly assigned.
>
> It is my understanding that this value represents the offset of a
> gpiochip relative to the GPIO controller device defined by the GPIO
> controller node in device tree. This puts it in the same number space as
> [GPIO controller offset]. I believe it was introduced for the specific
> purpose of translating [GPIO controller offset] values into
> Linux-specific offsets, which is why it is being reused for that purpose
> in this patch.
>
> For GPIO Controllers that contain a single gpiochip the 'offset' member
> is 0 and the device tree node offsets can be applied directly to the
> gpiochip. However, when a GPIO Controller contains multiple gpiochips,
> the device tree node offsets must be translated to each individual gpioch=
ip.
>
> >
> > I just don't get it.
> >
> > So NACK until I understand what is going on here.
> >
> > Yours,
> > Linus Walleij
> I hope it makes sense now, but if not please help me understand what I
> may be missing.
>
> Thanks,
>      Doug
>

Linus,

Please let me know if this is still a NAK, if so, I'll drop this
series from my tree at least for this release.

Bart

