Return-Path: <linux-kernel+bounces-391089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9959B828A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DE91F224A0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC031C9DC9;
	Thu, 31 Oct 2024 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hHn6OlSe"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB41C8FD7
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730399019; cv=none; b=fXh4UykPaGrU0QRQ39YEy9tXgx91kRcfmbxa+GiT6N6BpWS2nW+2Xr5Ln4YEf70z1qrTve9Cjp2b6+y3UbGEhEE9wE7JFBV939dVq5g3FGzPH6xM3M8PUR6xw+/ERCPsl/aFq/3Q9PjZNOqMoQdRXj6RZJP3pYorUnvdEss/5pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730399019; c=relaxed/simple;
	bh=VoxdWZfmcdWJRPW/HaB7XAAfa3I/K4iIPdRUGHgWLJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIrY4LQr4bFXIfQ+qrEhd5tbW5UhHITn5PqOdaeGL4ee5+twemB0MlYcrhqN3SoSf+zZC9YU7+dWn/vci5YXKZtqICW2nprid47iSOiHTCb5ALz8D2KlPfeIgoHiDgKra+YWCFv0iESuF1VIcX5vqaVn5aTdmfwJh7lisKqK+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hHn6OlSe; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e4e481692so1045274b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 11:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730399017; x=1731003817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NK89StELe6wDblT1ZyaO2kIyMs8gywtAduCxYOkkg4=;
        b=hHn6OlSeN0IjQbYnAcZfFncePtklenElESeQyaWA9XvwmtQFjT1q4SOWcj8J16c5Jx
         Ji6pyxiR3lm3H6tEp8PiiYnfuU6Tp9AbiI5ftq7kuZct4IiR4VAlJwoODVrs5k57rdfO
         gsVcGTjSrKL+UwS2lcPxr8Bn/VMzwEd1+J7spdpTEGFZ1jMTD4D34JLdrutRJl6RO6q+
         2Hh6Kr5Jd/PKwdegxfmlAZAK6Kh/UmDptyLsSv0MzVEKoSsMBsXLbmIpVXS/lZLNllnU
         3o7L5dMj3p4TmIPT0Lhr8j3VjHzkwxRlqjZJBOype2uVQWt2LLwAwufcPsYlXBS3MSY8
         NlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730399017; x=1731003817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NK89StELe6wDblT1ZyaO2kIyMs8gywtAduCxYOkkg4=;
        b=hEIK5Zy4WeR4gm42FTdac6EjdnWfhfJwSogtbioVBw2o8topsEY3g4Mw3wjGmCuAze
         f8lOPynkS+u0SHUNkXAyd+w2NA5H7fcc3dWAoN717LGIwbxDuZy7406mdAAn7oXUapNG
         aFm0QUib9TQ7tBdKegY8MBNGET2IG0ZdA3J940e6wD8LdyoPi69+mREZkluiJfcYBduF
         yOJtZ8o5i0uPJOhRi6c8JzdJKEnN68Qc2kx6wT8P7JPgsnXGGPyKjINQhQ7O6Qb9ryiy
         KW/rtpTZ/RlYgJAwRjWfNjFMTLi1pUmfjKOqjGcUVKi9fqTOT+cykC1Xj1iW9s/Dzmtx
         78rw==
X-Forwarded-Encrypted: i=1; AJvYcCXvmx3l0V09YNjnJpjFX4/4mLOcDkaWdbc0kvZ0PQb6xGUycI7DVJdVl2e7ax5eYoH8QoQ/hA4+ex7MaoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnylsOc6yBGMFFIjqsMhnsXO/uifRQ7IznagRjgMSesR/xvcae
	NJGDEzxGm3bKwY1NLse38U9p42EGFOPKXzzf+mdpUal2CJ0CzirvLJHthJ/tnLNnwR7OTmmJIRl
	sJjyafph0C5xtAllbPoD7RdMYsZIbwprTl6/B8Q==
X-Google-Smtp-Source: AGHT+IGHdF1FDbKzl7xn2p86hGefifqg+94+EcOjf8eJcethgiXYB5ygNrIb37oNGBM4vNGhYMgBUUFkMZmjtCgKq/Q=
X-Received: by 2002:a05:6a20:d74d:b0:1d9:2894:a6bb with SMTP id
 adf61e73a8af0-1dba556fb98mr582112637.46.1730399017106; Thu, 31 Oct 2024
 11:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028134454.1156852-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mc_PW32jNO+C5AEQK6ej_CsCSV-HY76aJoQ6bjZ=JPOtg@mail.gmail.com> <ZyNKpC_3E3GFsyXL@smile.fi.intel.com>
In-Reply-To: <ZyNKpC_3E3GFsyXL@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 31 Oct 2024 19:23:23 +0100
Message-ID: <CAMRc=MfJqqBvSj_RmRMfMRwkfz80iF1fA2Rvu+vBm4wSineufQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Use traditional pattern when checking error codes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 10:15=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Oct 30, 2024 at 09:20:45PM +0100, Bartosz Golaszewski wrote:
> > On Mon, Oct 28, 2024 at 2:44=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Instead of 'if (ret =3D=3D 0)' switch to "check for the error first" =
rule.
> >
> > Well there's much more to this patch than that and I have some issues w=
ith it.
> >
> > > While it gives a "+" (plus) statistics it makes the code easier to re=
ad
> >
> > Not only does it increase the footprint but it also adds completely
> > unnecessary goto labels.
>
> These pieces can be dropped.
>
> ...
>
> > > and maintain (when, e.g., want to add somethning in between touched l=
ines).
> >
> > The single line calls to the notifier chain are unlikely to be
> > extended anytime soon but even then I think we should cross that
> > bridge when we get there.
>
> Okay.
>
> ...
>
> > > -       if (!ret)
> > > -               gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CO=
NFIG);
> > > +       if (ret)
> > > +               return ret;
> > >
> > > -       return ret;
> > > +       gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
> > > +       return 0;
> > >  }
> >
> > I really don't see how this makes it better. The logic here is: if the
> > underlying set config worked fine - emit the event. Otherwise continue
> > with the function (even if there's nothing there now). If anything
> > you're making it more difficult to modify later because logically the
> > notification is just an optional step on the way to returning from the
> > function.
>
> Optional steps are covered by flags, and not by checking the previous cal=
l for
> failure. So, I barely see the "optionality" of the notifications in these=
 calls.
>
> ...
>
> > >         ret =3D gpiod_direction_input_nonotify(desc);
> > > -       if (ret =3D=3D 0)
> > > -               gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CO=
NFIG);
> > > +       if (ret)
> > > +               return ret;
> >
> > Ok, for consistency I could take it but please put this into a
> > separate commit doing just that (here and elsewhere).
>
> Based on the other comments from you in this email I'm not sure I underst=
ood
> this correctly. Do you want to reject the complete patch, or do you agree=
 on
> some pieces out of it.
>

I want to reject most of the patch in this form. s/(ret =3D=3D 0)/(!ret)/
is fine as a standalone change.

> > > -       return ret;
> > > +       gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
> > > +       return 0;
>
> ...
>
> > >         ret =3D gpio_do_set_config(desc, config);
> > > -       if (!ret) {
> > > -               /* These are the only options we notify the userspace=
 about. */
> > > -               switch (pinconf_to_config_param(config)) {
> > > -               case PIN_CONFIG_BIAS_DISABLE:
> > > -               case PIN_CONFIG_BIAS_PULL_DOWN:
> > > -               case PIN_CONFIG_BIAS_PULL_UP:
> > > -               case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> > > -               case PIN_CONFIG_DRIVE_OPEN_SOURCE:
> > > -               case PIN_CONFIG_DRIVE_PUSH_PULL:
> > > -               case PIN_CONFIG_INPUT_DEBOUNCE:
> > > -                       gpiod_line_state_notify(desc,
> > > -                                               GPIO_V2_LINE_CHANGED_=
CONFIG);
> > > -                       break;
> > > -               default:
> > > -                       break;
> > > -               }
> >
> > If you really want to get rid of one level of indentation here,
> > I suggest moving it into a separate function.
>
> Perhaps you suggested a separate change for that?
>

This doesn't really bother me but if it triggers you then feel free to
change it like:

if (!ret)
    gpio_set_config_line_state_notify(desc);

Bart

> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       /* These are the only options we notify the userspace about *=
/
> > > +       switch (pinconf_to_config_param(config)) {
> > > +       case PIN_CONFIG_BIAS_DISABLE:
> > > +       case PIN_CONFIG_BIAS_PULL_DOWN:
> > > +       case PIN_CONFIG_BIAS_PULL_UP:
> > > +       case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> > > +       case PIN_CONFIG_DRIVE_OPEN_SOURCE:
> > > +       case PIN_CONFIG_DRIVE_PUSH_PULL:
> > > +       case PIN_CONFIG_INPUT_DEBOUNCE:
> > > +               gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CO=
NFIG);
> > > +               break;
> > > +       default:
> > > +               break;
> > >         }
> > >
> > > -       return ret;
> > > +       return 0;
>
> ...
>
> > Most of this is IMO pointless churn. You typically do a lot of great
> > cleanups but this just doesn't make sense. Sorry but NAK.
>
> OK, I do one change out of that with deduplication of the direction input=
 call,
> the rest is up to you, let's it be less readable.
>

