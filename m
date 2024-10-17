Return-Path: <linux-kernel+bounces-370010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373E59A25D5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59E251C206AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6081DE8A8;
	Thu, 17 Oct 2024 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bGlWVFW8"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DB45FDA7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177205; cv=none; b=ICLBB7Ymnj7Rp4hPHx3Wz5WWOcd8lpkXmLhbyMkbW9lVI5repngcbKxTOb5H2jlqLF+hX7ikVqWP7u8T5+bJBozOIOJGazr7fZRj1pdDaT5Osv+m8EwIbRYMhlBSNvicZql9oJ0kIw8cOLHmAFwJpg4BJijpWaCXcDeFGxXzaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177205; c=relaxed/simple;
	bh=8bl76Cbdk7v92iFjJLaTjrrZUnPOxoM+6e7b4I8HpUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtFSG+okL3pOBZH8QsLvr/e7hM6Vq51EvDfdR6m08V6ltGYaZgzLp7dcONhzQ4xnWDAUHZ716vuijIVX/XKYMLl6d/+Hk6HIa6lnhsiPqrGChf1aIKraFq7os8rF/g2O1F/lXmvf3Lo3lYv4xTXhBugJcTPMrNARXa7f0eHMzaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bGlWVFW8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso1131356e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729177198; x=1729781998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uzx7qfIz0kRxcE9elryjH1UH5Qyu345xRMphESNfnsQ=;
        b=bGlWVFW8G0bK4IC/uXqEpmArxmU5cg+vXr2ojel+WnRzo7hvYrerp8BDkXgFj3eZRd
         o8s/eWmSAv1ZVNLYHDUG+vYu+ONfNl1s0UVvWBC+esotO9U8rIqXpFYYor4ycT2lKgcb
         LFuON289VwBe3KDWhSuh5katOys7B27CvXov82Cn9aNvfTGK1b08yltqQFmvpzftmlZF
         8Q0OEo6IHX5H11nrKO3ZduqhirK2a4v9SLuwxU3ZP3uoVvt8Q4PFl1Tcj3bPrmNiquGG
         cCLfFKeJF58kMe9X2yygJYFNyexz08nnEUehXSgfVBpHMfZmSUd3dSKd6kO155WE5jHQ
         9yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729177198; x=1729781998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uzx7qfIz0kRxcE9elryjH1UH5Qyu345xRMphESNfnsQ=;
        b=RIOkQKjxnSePp/7BSu+nMnMRYGN7AZXZ1xAAXud1bZGkmE2KSY6aZHuW5sv8I96ZJe
         7MUJOVO+6KjRi9dJzqr/IA6wLzAf7vdsYmRAEaWrdN8zntYNIECaO1lT8M97IQESpYhX
         bVIMSpU7yVcToLqBtQQ630CpNBekvfNCFu9CE8SkCRVJWBglV+d8b08GPtcJcZL4WAn1
         ppExF+305fW7OER0l1zI3JkOwONpxDtbdSgrDQPpPc/+KjHCYtPc2QziiYaSiPpKtj2u
         1XsVRcD0U/6EbaL/X34Z+vEyseaEG2+wMtm0NPAhJfVZmCx5T9RXsQvtlMZ2VdR2rBI9
         CL2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWP1gavxW5w2Xel7WBl0RSd1hVNmw4P+GlJ/AmmbMPFFAYo6bMzFYOK0wQLOwW6rI2aHFDDMP8T6ZOiiKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ/GJEOb7RWaqA+2dvf6L8MluWe+5TUZJ3FI97P43YEP7SrtaJ
	5KjgGugd/g6KehyQw5b+tpw9RPzmo/AtcwRB/3KAMq4yfUfjZV5xu0QoL6DOU5AdcwETZ4ATVU0
	L3jeEJVU6s83VJTQAPDZ/zWenQNvQeoPt7vBh/w==
X-Google-Smtp-Source: AGHT+IG42f0uo6blRru8QKUwoD42fET81PUjEQAxbmQrj/FLP+S6LSR4nfbBJng2ar6TA3d5TDqbZ69v2Avb3uxhzqQ=
X-Received: by 2002:ac2:4c46:0:b0:539:968a:91a8 with SMTP id
 2adb3069b0e04-539e571da42mr11738101e87.47.1729177197999; Thu, 17 Oct 2024
 07:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-gpio-notify-in-kernel-events-v4-0-64bc05f3be0c@linaro.org>
 <20241017-gpio-notify-in-kernel-events-v4-8-64bc05f3be0c@linaro.org>
 <20241017125349.GB221864@rigel> <CAMRc=McjCinBEFNoHSTyFH7zU=JuyRfu1cfrOxkq=OjciKQkvQ@mail.gmail.com>
 <20241017142053.GB242458@rigel>
In-Reply-To: <20241017142053.GB242458@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 17 Oct 2024 16:59:46 +0200
Message-ID: <CAMRc=MeXe2XE_PEJm7iu1K7M=Tv0cWs2wd9pNzJk87dTyqGzeQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] gpiolib: notify user-space about in-kernel line
 state changes
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 4:20=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Thu, Oct 17, 2024 at 04:14:24PM +0200, Bartosz Golaszewski wrote:
> > On Thu, Oct 17, 2024 at 2:53=E2=80=AFPM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > >
> > > On Thu, Oct 17, 2024 at 10:14:16AM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > @@ -1447,8 +1450,6 @@ static long linereq_set_config(struct linereq=
 *lr, void __user *ip)
> > > >               }
> > > >
> > > >               WRITE_ONCE(line->edflags, edflags);
> > > > -
> > > > -             gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CO=
NFIG);
> > > >       }
> > > >       return 0;
> > > >  }
> > >
> > > I still get errors from this when reconfiguring lines with debounce.
> > > You should leave this notify in place and use _nonotify when setting =
the
> > > direction.
> > > i.e.
> > >
> > > @@ -1436,11 +1432,11 @@ static long linereq_set_config(struct linereq=
 *lr, void __user *ip)
> > >                         int val =3D gpio_v2_line_config_output_value(=
&lc, i);
> > >
> > >                         edge_detector_stop(line);
> > > -                       ret =3D gpiod_direction_output(desc, val);
> > > +                       ret =3D gpiod_direction_output_nonotify(desc,=
 val);
> > >                         if (ret)
> > >                                 return ret;
> > >                 } else {
> > > -                       ret =3D gpiod_direction_input(desc);
> > > +                       ret =3D gpiod_direction_input_nonotify(desc);
> > >                         if (ret)
> > >                                 return ret;
> > >
> > > @@ -1450,6 +1446,8 @@ static long linereq_set_config(struct linereq *=
lr, void __user *ip)
> > >                 }
> > >
> > >                 WRITE_ONCE(line->edflags, edflags);
> > > +
> > > +               gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CO=
NFIG);
> > >         }
> > >         return 0;
> > >  }
> > >
> > > Given that, all my current tests are passing.
> > >
> >
> > That looks good - after all we no longer notify from any place in
> > gpiolib-cdev.c anymore - but I'd like to learn what's wrong exactly.
> > Are you getting more events with debounce? Are you not getting any?
> >
>
> In linereq_set_config(), the notify comes from the gpiod_direction_input(=
) -
> before the edge_detector_setup() is called (not visible in the patch) and=
 that
> sets the debounce value in the desc.
> So you get an event without the debounce set, or with a stale value.
> Keeping the gpiod_line_state_notify() and using the _nonotify()
> functions means the notify comes after the debounce has been set.
>

I see. I guess I should do the same both for linehandle_set_config()
and linereq_set_config()?

Bart

