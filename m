Return-Path: <linux-kernel+bounces-367498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CF69A0315
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8091A288A10
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E692B1C4A3B;
	Wed, 16 Oct 2024 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ps750OQo"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463141C175C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065074; cv=none; b=dP/eCpZkAY2ujRopff+Iate/VWy43uch59iQlLybVH2Xzp2YNZCnGJ/ufzEcxB2XbPp8NX8fbm+iH7DRJGnORGxA9O0+14XMkCYTQi3PWgJQysrk2D1/JGMH8ANmWIp6GT4LsyglZ7mtSLcACC6iU5Ypr/C2H/a5moiYhu62U4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065074; c=relaxed/simple;
	bh=CX55jp38yfgiJKr7PEViU8B6zkCbH0ptnSEPA/hqHOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAWHlkF2ymd1CwmJqvlPptzKXJhz0F4D1Z7N2s9zm4EW2F6OrO0S1B/NT3M7+Yk6xfPBW5Ge0MSMX8g0JqeKJqBZKeCC23Nxy3FY+YtDSxsDhMbm0Iq2fhyz6WtmpCrj/FgzQlnsvVmG+Y8IzzhdOjnxOzv/AxPgbDCzBZ11CrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ps750OQo; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb3debdc09so32140541fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729065070; x=1729669870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKOecBDxA7R7ooyejGQiOrpnacbKGU17iQZ2JMHiXgA=;
        b=Ps750OQoShuQFEFIqXDUxpcUDZ7UC2DYW4igmY8byHdT4K+CUVxw6hPLmBluH2Dg54
         KTCY277H43mkvkZJlz75k//tKsYoeG9ezI74Gr+H++h1WIgWslf1mQ403I7cT8tCqs13
         TG7deBU8B35jPTEu/CHQUlIV+ECCT88ig9t5mWrME0HVUrfr8V6xDlqAImmJggQJIwW/
         avJX/McuUGzFOY9JqfDhDsQt0gJQ+v2H/LW+GzffTYK3tNE73Hh4ivVvqHQRKOzU/MAc
         t0yul8NK4EBbwGCZiltP9yEHHPKBWljrqLdXSQ++liTc/0MAKaVDyF5eCiP0+VuuRXpr
         mYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729065070; x=1729669870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKOecBDxA7R7ooyejGQiOrpnacbKGU17iQZ2JMHiXgA=;
        b=Z8nbj6HWbeKRXWx4qg8F/L/AW9f/lB3C7GXRwe+npNKiHZb2R21pGRW3gZtv2/xe8S
         t6gGx/QM3ZvMEakVvv69uIhuuOMUN0mTjInGi2wc/82RNX1QJivlUAGIuAaTQupjEvAI
         GFWl3Jk3+sw3c3Yw+tOiu/bKWbkqTEQJfXkXLloADora/BKjvwqZcEqKwpDqUyUimI+x
         LsSZQTbteTxec8GuckCQQcUuJtViqWYe46DusGQHq1ODLdFUn43psGTweU+bi994+Lg1
         Y1WpoiBS203Yr/pvN4yFYlX8O6msTpfWsgcuHZPAKma/i7eM4M9xh6x2VKWVmULtHSaI
         zfWg==
X-Forwarded-Encrypted: i=1; AJvYcCUYOuZPo2dG+5BAvboIfVLSJSPVUfBvk4orJEY7+ZpPsypY4roq71wH9jXPMQrYynP2AI9CVEjA5uaulmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwilzM+lYtUvA7VtTLhQ00KaISMNOp3Po6DixksAou9kmWoc9v2
	Nu3utLg3iucdeUeZTZ1J0/0PYlsjFLhfRfROEk/QoOrPK9iNZlU0VOTwIiJw8tgzIoa9hANJp/j
	zASgTXkfQzNk0F/NITp5Do5gn2fpCBfOvSKKVDQ==
X-Google-Smtp-Source: AGHT+IHyG9D2npkBCRGka0dVdATtnJvCOeazTrlR/QpCwLkD5hlTvCka/gqxC6UMfWoYnBuBjKG5yIB3fAAr0mZv6WY=
X-Received: by 2002:a2e:bc24:0:b0:2fb:51e0:951 with SMTP id
 38308e7fff4ca-2fb51e00cd9mr45796831fa.7.1729065070248; Wed, 16 Oct 2024
 00:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-gpio-notify-in-kernel-events-v3-0-9edf05802271@linaro.org>
 <20241015-gpio-notify-in-kernel-events-v3-6-9edf05802271@linaro.org>
 <20241016051944.GA42100@rigel> <20241016072730.GA120095@rigel>
In-Reply-To: <20241016072730.GA120095@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 16 Oct 2024 09:50:58 +0200
Message-ID: <CAMRc=MeAfuObBodQu24yUnDbYVd7bFQAeimF5U75chcAK69r6Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] gpiolib: notify user-space about in-kernel line
 state changes
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 9:27=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Wed, Oct 16, 2024 at 01:19:44PM +0800, Kent Gibson wrote:
> > On Tue, Oct 15, 2024 at 12:56:18PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > -   return gpio_do_set_config(guard.gc, gpio_chip_hwgpio(desc), confi=
g);
> > > +   ret =3D gpio_do_set_config(guard.gc, gpio_chip_hwgpio(desc), conf=
ig);
> > > +   if (ret =3D=3D 0) {
> > > +           /* These are the only options we notify the userspace abo=
ut. */
> > > +           switch (pinconf_to_config_param(config)) {
> > > +           case PIN_CONFIG_BIAS_DISABLE:
> > > +           case PIN_CONFIG_BIAS_PULL_DOWN:
> > > +           case PIN_CONFIG_BIAS_PULL_UP:
> > > +           case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> > > +           case PIN_CONFIG_DRIVE_OPEN_SOURCE:
> > > +           case PIN_CONFIG_DRIVE_PUSH_PULL:
> > > +           case PIN_CONFIG_INPUT_DEBOUNCE:
> > > +                   gpiod_line_state_notify(desc,
> > > +                                           GPIO_V2_LINE_CHANGED_CONF=
IG);
> > > +                   break;
> > > +           default:
> > > +                   break;
> > > +           }
> > > +   }
> > > +
> > > +   return ret;
> > >  }
> >
> > Ah, the debounce - I forgot about that, and other features that cdev
> > might emulate.
> >
> > What happens if userspace requests a line with debounce that is
> > supported by hardware?  Seems to me we'll see both a LINE_REQUESTED and=
 a
> > LINE_CONFIG_CHANGED when the line is requested.
> >
>
> This is problematic for me to test at the moment, as gpiosim doesn't supp=
ort
> debounce. Any chance we could make that configurable?  Similarly drive.
>
> > Conversely, what if a config change impacts features that don't result =
in a
> > notification from gpiod_set_config(), like active low, or emulated
> > drive or debounce?
> >
>
> Bah, drive is emulated in gpiolib itself, so that should be fine.
>
> When changing config cdev always calls gpiod_direction_input/output(), so=
 I
> think that covers the active low case.
>
> But I have a test taking a line from input to output|open_drain and I
> get two change events.  The first is the most interesting as it reports
> input|open_drain, the second then reports output|open_drain.
> That is due to gpiod_direction_output() calling gpiod_set_config() to

No, it never calls gpiod_set_config() but gpio_set_config() which
never emits an event.

> set the drive, and later to set the direction, in that order.
> Given it will be setting the direction, it should inhibit the event from
> the drive setting?

I think you're really hitting this:
https://github.com/brgl/linux/blob/b4/gpio-notify-in-kernel-events/drivers/=
gpio/gpiolib.c#L2863

These should be changed to nonotify variants too. Would you mind confirming=
?

Bart

>
> Still haven't tested any debounce changes...
>
> Cheers,
> Kent.

