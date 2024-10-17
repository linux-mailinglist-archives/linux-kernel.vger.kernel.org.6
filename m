Return-Path: <linux-kernel+bounces-370022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADFD9A260B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B5D289E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F3F1DED75;
	Thu, 17 Oct 2024 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Iudt4riY"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FFC1DED78
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177472; cv=none; b=SCxJIjwKoWv3uk0n9V0YTB162YBrBCoKkgKRL4IXNhl81cWVKJszEZ3VFF6mfnlt7KCduWSZDxoZV38mD5rgtYqYbERyZQdDmF50Bn4UV+Ip/1dzoKbLZ0ELEqLw/FSpDyRudxPvgZ2GyGte80DaIx8Os2uUxSrUGZN1w8VWfwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177472; c=relaxed/simple;
	bh=NimLuERWylPqAXvl0dwiOCWjt1QGcd90XtVIcwNsoCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4l4q6Hz+ahUsXDwTL7z4c2IEyU25edPaLYmQs5X8Ixylxoyqs1+FCKeoTen68jEu+RLf7PW+kMTpXx6lu/xn7wDpk1mqRcA2/dneeD0ltuezT7tL/McZ67p6k64RKQP/EJFKdGfSwgsJuQiPE7Dgtr6xnvo5oko49uFqLYQd3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Iudt4riY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f2b95775so1362544e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729177465; x=1729782265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KgNrYXm59wIWB+byMXzs81/O0sXcasv5NodDfSq758=;
        b=Iudt4riYdYzQpazffRYNrDlfrmjUbVeWWVniF54Pzj3FKrdL/AXxgRNxJm/m6iUgTe
         E6nNSnY3fkgjnmjK5aZatRK28vLl0wAMWAR3yh2MNU8m58l6tRCEabA5K8aLDOH5UxVq
         /bgRgxUCDS+Wj0bdN3ngGkeQV61aNMNcQFPclWditdu79Q5FoSR0euVjY9OVQFstoWE/
         bvD2qQ/TjdDWFOHpl3IvIKc6BcNOOhE3jhaxL3AjNQpVROrBR1qNzGuHtoYJxMMnJ40d
         /qIdOce5I9VdUSlFR/NmaCX00F7vX/9X4HL8kQOQM3bJgF1nj/x/0SH3N+k3xKmRt9tl
         Gz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729177465; x=1729782265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KgNrYXm59wIWB+byMXzs81/O0sXcasv5NodDfSq758=;
        b=ZoOrqQlwQUcSDXWDgzfacq5QJ+9whB3x1SrkF23FK87M8rYOm5+fNdwPx/wmlwDPAP
         JU1oPNvEB6fsfrcxUQpSg+/TsLgLKMs3Amnn5Lvy4Xte3U+nmBCGvhqNY2HBAvh3m+X1
         t3i0w2vNtqdw3uAIrTU1KkCAuCY7G2cVeyJLsREaWmrknestoZrAmEI6cPCiwp6qBrCo
         8Gm7I0Z4HULx8nwmoDb7x7HRVWzP3ECdueGmDc65vWGqgXY6YATEnNPMhQbD1QL8mXVb
         8NeI8KMrYneZdCYrVRL763xoKxQDibQVtIlTjS83BfGUzUa2fyqNEqFX8Crgn8jpaf3/
         /04g==
X-Forwarded-Encrypted: i=1; AJvYcCUaMyAaeufF4v5dzCox9JQ8XldN4GRaYrtG8sdIoftDWJJjqWJSJ1KtYuC0Aq6oux9P3iuqAvcssayITUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxPm8x2ONQlBdCWLCXUwMR2phe02z2bxhhe7kDg54Mq7JuKs5P
	Smpn9wKFJ+ZY7OuGvousl+HaVvvbnB/gY0UZALZsMW1rSm6tICD1BatzjCoqkF9H6c3jBveAJ6i
	ufNtKqBso3/FewvWlZ5XOtmTTrZuopkRiCB9gHQ==
X-Google-Smtp-Source: AGHT+IGkMNySHQnzTWrbGekJSSvGZUrHMmKLOVrS8ARAwf7u76Zq1k0891I6rnsuLp55iiTG/mC7nT+aLp8rMUbps30=
X-Received: by 2002:a05:6512:3083:b0:535:6951:9e1c with SMTP id
 2adb3069b0e04-539e54e7122mr14031673e87.15.1729177464738; Thu, 17 Oct 2024
 08:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-gpio-notify-in-kernel-events-v4-0-64bc05f3be0c@linaro.org>
 <20241017-gpio-notify-in-kernel-events-v4-8-64bc05f3be0c@linaro.org>
 <20241017125349.GB221864@rigel> <CAMRc=McjCinBEFNoHSTyFH7zU=JuyRfu1cfrOxkq=OjciKQkvQ@mail.gmail.com>
 <20241017142053.GB242458@rigel> <CAMRc=MeXe2XE_PEJm7iu1K7M=Tv0cWs2wd9pNzJk87dTyqGzeQ@mail.gmail.com>
 <20241017150217.GA262603@rigel>
In-Reply-To: <20241017150217.GA262603@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 17 Oct 2024 17:04:13 +0200
Message-ID: <CAMRc=MfrGynY0J6ozG0B9GiPJgqLJywaT-Fw0_O3zZNKrsALAA@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] gpiolib: notify user-space about in-kernel line
 state changes
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 5:02=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Thu, Oct 17, 2024 at 04:59:46PM +0200, Bartosz Golaszewski wrote:
> > On Thu, Oct 17, 2024 at 4:20=E2=80=AFPM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > >
> > > On Thu, Oct 17, 2024 at 04:14:24PM +0200, Bartosz Golaszewski wrote:
> > > > On Thu, Oct 17, 2024 at 2:53=E2=80=AFPM Kent Gibson <warthog618@gma=
il.com> wrote:
> > > > >
> > > > > On Thu, Oct 17, 2024 at 10:14:16AM +0200, Bartosz Golaszewski wro=
te:
> > > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > > >
> > > > > > @@ -1447,8 +1450,6 @@ static long linereq_set_config(struct lin=
ereq *lr, void __user *ip)
> > > > > >               }
> > > > > >
> > > > > >               WRITE_ONCE(line->edflags, edflags);
> > > > > > -
> > > > > > -             gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGE=
D_CONFIG);
> > > > > >       }
> > > > > >       return 0;
> > > > > >  }
> > > > >
> > > > > I still get errors from this when reconfiguring lines with deboun=
ce.
> > > > > You should leave this notify in place and use _nonotify when sett=
ing the
> > > > > direction.
> > > > > i.e.
> > > > >
> > > > > @@ -1436,11 +1432,11 @@ static long linereq_set_config(struct lin=
ereq *lr, void __user *ip)
> > > > >                         int val =3D gpio_v2_line_config_output_va=
lue(&lc, i);
> > > > >
> > > > >                         edge_detector_stop(line);
> > > > > -                       ret =3D gpiod_direction_output(desc, val)=
;
> > > > > +                       ret =3D gpiod_direction_output_nonotify(d=
esc, val);
> > > > >                         if (ret)
> > > > >                                 return ret;
> > > > >                 } else {
> > > > > -                       ret =3D gpiod_direction_input(desc);
> > > > > +                       ret =3D gpiod_direction_input_nonotify(de=
sc);
> > > > >                         if (ret)
> > > > >                                 return ret;
> > > > >
> > > > > @@ -1450,6 +1446,8 @@ static long linereq_set_config(struct liner=
eq *lr, void __user *ip)
> > > > >                 }
> > > > >
> > > > >                 WRITE_ONCE(line->edflags, edflags);
> > > > > +
> > > > > +               gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGE=
D_CONFIG);
> > > > >         }
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > Given that, all my current tests are passing.
> > > > >
> > > >
> > > > That looks good - after all we no longer notify from any place in
> > > > gpiolib-cdev.c anymore - but I'd like to learn what's wrong exactly=
.
> > > > Are you getting more events with debounce? Are you not getting any?
> > > >
> > >
> > > In linereq_set_config(), the notify comes from the gpiod_direction_in=
put() -
> > > before the edge_detector_setup() is called (not visible in the patch)=
 and that
> > > sets the debounce value in the desc.
> > > So you get an event without the debounce set, or with a stale value.
> > > Keeping the gpiod_line_state_notify() and using the _nonotify()
> > > functions means the notify comes after the debounce has been set.
> > >
> >
> > I see. I guess I should do the same both for linehandle_set_config()
> > and linereq_set_config()?
> >
>
> linehandles don't support debounce, so it's good as is.
>

Right, but I'm wondering if it isn't better for consistency.
Otherwise, someone may ask themselves why there's no event being
emitted if they're not familiar with the gpiod_direction_*()
internals.

Bart

