Return-Path: <linux-kernel+bounces-212121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2234B905B79
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4F91C229D4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C005674B;
	Wed, 12 Jun 2024 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AZISgCzh"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E9629E4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218236; cv=none; b=ja+c7vYoRpbM55+5F6OoIXYlVtQDLZufWEo8SmBabNDTcHwCdQtL4Y+G01ecAg6oiWRSWmHN8u0mu5Yc0GYbUy3DTLe6Bq72Auk/csIqxOCQxNrRVWUakZT3QvXyZfu5Sfx50ovV5DyvNWsY4AZegvzBt5DEYHn2qNYw5SePg+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218236; c=relaxed/simple;
	bh=04J8z3Ji+/a4DiOzfeQOCFUFl/QSp0R7BgM1OMz/6sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CabrVyX9MBE2iEKF8m2IWZ+hNQyE/jL6mpbZpa/c1eCcXuPPFjakZ+tp2ROBVpSM7/GbYccUzFQ9Keo6w+qFnZWfccNBn1nTm2NBWRxY58/8sKDNLmUti4CaJXJFFz+RqPZsbZNL1ngWJExWc2ivP2kYUUtAvgo3SH5kDGS2Pe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AZISgCzh; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ae259b1c87so11456806d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718218233; x=1718823033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiQQ23KIjo8vJtcLEZAdNg1+OGV+c+w6Qzig7BQEQig=;
        b=AZISgCzh4xez7/i5U9u90TA5BMIomTDeUD+72cWRcg09WoerX/YzWjGn597WM+mj6H
         2rkUBxGoKztnUAK2aNi7Q7K9ToZtS36iLFLCMt31/NhrE7raIx4ZMPIbaKVeiSLU8Db8
         uNJwCOh/vxejSU8H6B9wodvYEzO8nhBoagM0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718218233; x=1718823033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiQQ23KIjo8vJtcLEZAdNg1+OGV+c+w6Qzig7BQEQig=;
        b=CJ1rySCl7/9d/M1rM3VPVr4gPRY+s37VFMvWPW1XJpvmHTHDAnbeIGr0KZ17mjU2gU
         AjNdpm/eMGm+F39lAUNSVrlx3v3R5etlhdnTbrUBwBxL9uVG4ToqsZL8OTgy223jl3fy
         ou+vdUMpMRo/i6Q0ixn05puH3FFrMU4x1PVxjGu/z7kt6cdWpFItK1EovMXs6ZoAkoX5
         CxBzGpfZPwUV7i87r/kaMWLb9NxG9mFvseo+yt0D50R1B5MN85a7mErnkPNfYcUFLOq4
         aZZ3I+5K5G31dJ45REU8WCVrnqd49IKHuKhNegN/ce2X/c4rs79OU93gY/4pQEjnI+yW
         JnEw==
X-Forwarded-Encrypted: i=1; AJvYcCWvQI5oAjq37hL2dnCKXky9Pti/YcSoVZHcBnVmt6FUMa/nWhYO7dCuHzZU6ZVyj5Al9RhfSvqOswfxuAgaAPHTKweb+FfC+CXS5SYF
X-Gm-Message-State: AOJu0YzHsXvQ1PrBkivEaJTMDU7bTkilBOBB/ngWb5csGB+xN6R+nUlt
	sqIFxbERqI53QlAD+3q4FBOBbfjtXjwsClpO9wjk/lJ8rI4sctfAVzIesudqSDpo3+Hu9XyRzpw
	=
X-Google-Smtp-Source: AGHT+IETWOVLHCEkbx9AOcFCluBNgnzm4FbQIgeY6T0bLn3v8pEnYSnuQBFnf+lINUjt6S5SO6Z1DQ==
X-Received: by 2002:ad4:5fcb:0:b0:6ad:764d:bf39 with SMTP id 6a1803df08f44-6b2a33ce408mr10223566d6.11.1718218233514;
        Wed, 12 Jun 2024 11:50:33 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b06ae2266bsm48994806d6.3.2024.06.12.11.50.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 11:50:33 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4405dffca81so29001cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:50:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbA0/Mwxrt77RvhvUMj45oqi3CBTPtoHWjKJxJPfujvV5gOKi6jkhB0OZ+E6LtY0qeZHrlCh0xb0h/OrLnr3muHBTtC3QC/uq6Q8rv
X-Received: by 2002:a05:622a:5a8c:b0:43e:3833:c5e3 with SMTP id
 d75a77b69052e-441a163ac33mr295191cf.11.1718217917336; Wed, 12 Jun 2024
 11:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610222515.3023730-1-dianders@chromium.org>
 <20240610152420.v4.2.I65a6430ab75f74d20c28b5c5f819dd5b8455933d@changeid> <0bb414fa-851b-40cf-ede9-fc6252c6b173@linux.intel.com>
In-Reply-To: <0bb414fa-851b-40cf-ede9-fc6252c6b173@linux.intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Jun 2024 11:45:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WWrTHRdwrbOFBrZ94HpWQo6v6FkLTxa1vgN31SC6GqDA@mail.gmail.com>
Message-ID: <CAD=FV=WWrTHRdwrbOFBrZ94HpWQo6v6FkLTxa1vgN31SC6GqDA@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] tty: serial: Add uart_fifo_timeout_ms()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Johan Hovold <johan+linaro@kernel.org>, 
	John Ogness <john.ogness@linutronix.de>, linux-arm-msm@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Stephen Boyd <swboyd@chromium.org>, linux-serial <linux-serial@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 12, 2024 at 12:38=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 10 Jun 2024, Douglas Anderson wrote:
>
> > The current uart_fifo_timeout() returns jiffies, which is not always
> > the most convenient for callers. Add a variant uart_fifo_timeout_ms()
> > that returns the timeout in milliseconds.
> >
> > NOTES:
> > - msecs_to_jiffies() rounds up, unlike nsecs_to_jiffies(). This is
> >   because msecs_to_jiffies() is actually intended for device drivers
> >   to calculate timeout value. This means we don't need to take the max
> >   of the timeout and "1" since the timeout will always be > 0 ms (we
> >   add 20 ms of slop).
> > - uart_fifo_timeout_ms() returns "unsigned int" but we leave
> >   uart_fifo_timeout() returning "unsigned long". This matches the
> >   types of msecs_to_jiffies().
> >
> > Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v4:
> > - New
> >
> >  include/linux/serial_core.h | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > index 8cb65f50e830..97968acfd564 100644
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -889,14 +889,21 @@ unsigned int uart_get_divisor(struct uart_port *p=
ort, unsigned int baud);
> >  /*
> >   * Calculates FIFO drain time.
> >   */
> > -static inline unsigned long uart_fifo_timeout(struct uart_port *port)
> > +static inline unsigned int uart_fifo_timeout_ms(struct uart_port *port=
)
> >  {
> >       u64 fifo_timeout =3D (u64)READ_ONCE(port->frame_time) * port->fif=
osize;
> > +     unsigned int fifo_timeout_ms =3D div_u64(fifo_timeout, NSEC_PER_M=
SEC);
> >
> > -     /* Add .02 seconds of slop */
> > -     fifo_timeout +=3D 20 * NSEC_PER_MSEC;
> > +     /*
> > +      * Add .02 seconds of slop. This also helps account for the fact =
that
> > +      * when we converted from ns to ms that we didn't round up.
> > +      */
> > +     return fifo_timeout_ms + 20;
> > +}
> >
> > -     return max(nsecs_to_jiffies(fifo_timeout), 1UL);
> > +static inline unsigned long uart_fifo_timeout(struct uart_port *port)
> > +{
> > +     return msecs_to_jiffies(uart_fifo_timeout_ms(port));
> >  }
>
> Hi,
>
> This is definitely towards the right direction! However, it now does
> double conversion, first div_u64() and then msecs_to_jiffies(). Perhaps i=
t
> would be better to retain the nsecs version (maybe rename it to _ns for
> consistency) and add _ms variant that does the nsec -> msec conversion.

I spent a bit of time thinking about it and I don't agree. If you feel
very strongly about it or someone else wants to jump in and break the
tie then I can look again, but:

1. The comment before nsecs_to_jiffies() specifically states that it's
not supposed to be used for this purpose. Specifically, it says:

 * Unlike {m,u}secs_to_jiffies, type of input is not unsigned int but u64.
 * And this doesn't return MAX_JIFFY_OFFSET since this function is designed
 * for scheduler, not for use in device drivers to calculate timeout value.

...so switching away from nsecs_to_jiffies() to msecs_to_jiffies() is
arguably a "bugfix", or at least avoids using the API in a way that's
against the documentation.

2. As mentioned in the commit message, nsecs_to_jiffies() truncates
where msecs_to_jiffies() rounds up. Presumably this difference is
related to the comment above where the "ns" version is intended for
the scheduler. Using the "ms" version allows us to get rid of the
extra call to "max()" which is a benefit. Technically since the
timeout is at least 20 ms the minimum HZ is 100 I guess we didn't need
the max anyway, but I guess someone thought it was cleaner and now we
can definitely get rid of it.

3. These functions are inline anyway, so I don't think it's causing a
huge bloat of instructions. In fact, moving from 64-bit math to 32-bit
math sooner could make the code smaller.

4. I don't feel like it hurts the readability to convert down to ms
and then to jiffies. In fact, IMO it helps since it makes it more
obvious that we're working with ms.

