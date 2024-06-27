Return-Path: <linux-kernel+bounces-232506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 246FA91A9DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471EB1C21AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEBF198E80;
	Thu, 27 Jun 2024 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="T3CRgEJt"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D405197A9D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499888; cv=none; b=HtZwfqiQy5eLVXqAUr6TszhQa2IrDyYoDBdSIouFaPIUIry4oFOkRiN8EXELLCeINPHL3Iqr2+4Z1+wg5F8Fm4RBpHh0nanVzGLkvoz9NqfuCIoZ8Z7/ByO3UZCfR09PlQwlUXDnG+yrCAw6BBd08DGFKy933QZLH77G2YZ3V5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499888; c=relaxed/simple;
	bh=0fopCr/CyJ7FvrrWj/WLPLCaCi/MGXtybK6oUrJcJ0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUuKutyWcGgvdNTkCxKnDIJ3qRGV2dhWLJwKqaVmjsZXsBLl/p4SQqDMpQhVurilQiyZNG3i9aX3XuccgKb7+n5vaRsVUaknC9EVomHfC1EMeXSiemHeAZq8Nw0RcMt64Tj81aAGlHbko7HTW8f8vNfld3LereZNEfXyuphEP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=T3CRgEJt; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so107377181fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719499884; x=1720104684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrKJq/FyVpXc3AnOoC5AqbTGlStFANjMAFnxr8zwwAQ=;
        b=T3CRgEJteRvwqfkUidAF7YmFgCr1htJCVhAP881/1wdTySzahc26/Y5PSK5tgXGyGD
         hu7wSd5eIL8WdyNNaNvOC/wk69tG7f0OBIG5aUF9BmXhQ/zW+3iWCf/fc3HUl61pme9x
         7yHUlvgmIuNBahYoutvaqFGNF3JtdQMPM3BJdJpxJbcnsxldMOK9cd6ar7KoRUSjyyeN
         NaqiD5YgjL7Z//gzr/HTkQXtZzs5hCAdHcFpKe1ebw1vOSfmFWShZucdXmP9NxvWyEkt
         5ZBxXbt72+d2fetf2n1H9x7nJqnZJH9TeV7F8K7RsMGQ99YKIm6foXbwGNAjGyMgz3U5
         nqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719499884; x=1720104684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrKJq/FyVpXc3AnOoC5AqbTGlStFANjMAFnxr8zwwAQ=;
        b=IjuegfEnQjxvSDtLRxgU67dpn7VPHZi0yCTWAPzG8Pryk08abj0dulC3cffZ3XS9al
         CDPZ0BlFp7FJ6j4rPKV8/7IL9AECT9nI4DzJtn9Z9c/0G08gp+xARr3/Bkl6lEU7Uu+K
         JBHH606UqeVTPpAAYd5n/ksQEJ2Rp+naYI+SB3DcJ5kar8HrTgcsXy0MXm/xriXAoaZi
         4ewR9YetiJ8RYNYLA+AnwdiR2CoZ83QyP2Ec4Rt6pVjLupBXeYIvX8ZPIPAxZcDts5u5
         7t3GLU0k9wsyFo0XGqVCxOBbtVtUP91oUY/Fa5KOn2NCdDj+nPxHROrH3jM8DOgjtyzI
         coBg==
X-Gm-Message-State: AOJu0Yyc0LopKvA0XWXFly5PW/SnzKZoPzs6J4xwWDCW2geP/TV/LK/5
	/GESi/OqdxQqHwA54ERx5d1gaqVLxkyjwF9SHdEVFcGpmQozJZ3OeKSbirP65t/+8doGwlFhibu
	uVWXk3/JntU03578tVLeMLOofEo5hCugTSS3esMTfLSnc4nkT
X-Google-Smtp-Source: AGHT+IHP1PFQQrHwJ2M1I8ky6i8lOqFpGCrRYAqqkWyVkOsLFSIv+WhVVxpQbzzNQln4BLJ/KWZ17M2WiImcH8WZfzs=
X-Received: by 2002:a2e:9dc6:0:b0:2ec:52da:6070 with SMTP id
 38308e7fff4ca-2ec5b357a22mr102770551fa.42.1719499884510; Thu, 27 Jun 2024
 07:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626052925.174272-1-warthog618@gmail.com> <20240626052925.174272-3-warthog618@gmail.com>
 <CAMRc=Me1_4xjbt51j+gFVzR71VUwMSAm+dT=UtgOY-1xYoAF5g@mail.gmail.com>
 <20240627142248.GA414403@rigel> <CAMRc=McA2rY=-k83Pkz-P5yu=bT2nE8JhNMiEAP2zFbf95SQqw@mail.gmail.com>
 <20240627144952.GA433043@rigel>
In-Reply-To: <20240627144952.GA433043@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 27 Jun 2024 16:51:13 +0200
Message-ID: <CAMRc=Md9eGjfytYbnMunbda_wQiaon2AwbGrRMW4WP8NhF6z4Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] gpiolib: cdev: Ignore reconfiguration without direction
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 4:49=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Thu, Jun 27, 2024 at 04:44:02PM +0200, Bartosz Golaszewski wrote:
> > On Thu, Jun 27, 2024 at 4:22=E2=80=AFPM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > >
> > > On Thu, Jun 27, 2024 at 04:06:21PM +0200, Bartosz Golaszewski wrote:
> > > > On Wed, Jun 26, 2024 at 7:29=E2=80=AFAM Kent Gibson <warthog618@gma=
il.com> wrote:
> > > > >
> > > > > linereq_set_config() behaves badly when direction is not set.
> > > > > The configuration validation is borrowed from linereq_create(), w=
here,
> > > > > to verify the intent of the user, the direction must be set to in=
 order to
> > > > > effect a change to the electrical configuration of a line. But, w=
hen
> > > > > applied to reconfiguration, that validation does not allow for th=
e unset
> > > > > direction case, making it possible to clear flags set previously =
without
> > > > > specifying the line direction.
> > > > >
> > > > > Adding to the inconsistency, those changes are not immediately ap=
plied by
> > > > > linereq_set_config(), but will take effect when the line value is=
 next get
> > > > > or set.
> > > > >
> > > > > For example, by requesting a configuration with no flags set, an =
output
> > > > > line with GPIO_V2_LINE_FLAG_ACTIVE_LOW and GPIO_V2_LINE_FLAG_OPEN=
_DRAIN
> > > > > set could have those flags cleared, inverting the sense of the li=
ne and
> > > > > changing the line drive to push-pull on the next line value set.
> > > > >
> > > > > Skip the reconfiguration of lines for which the direction is not =
set, and
> > > > > only reconfigure the lines for which direction is set.
> > > > >
> > > > > Fixes: a54756cb24ea ("gpiolib: cdev: support GPIO_V2_LINE_SET_CON=
FIG_IOCTL")
> > > > > Signed-off-by: Kent Gibson <warthog618@gmail.com>
> > > > > ---
> > > > >  drivers/gpio/gpiolib-cdev.c | 12 +++++++-----
> > > > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-c=
dev.c
> > > > > index f7a129d67b7d..ef08b23a56e2 100644
> > > > > --- a/drivers/gpio/gpiolib-cdev.c
> > > > > +++ b/drivers/gpio/gpiolib-cdev.c
> > > > > @@ -1534,12 +1534,14 @@ static long linereq_set_config(struct lin=
ereq *lr, void __user *ip)
> > > > >                 line =3D &lr->lines[i];
> > > > >                 desc =3D lr->lines[i].desc;
> > > > >                 flags =3D gpio_v2_line_config_flags(&lc, i);
> > > > > +               /*
> > > > > +                * Lines not explicitly reconfigured as input or =
output
> > > > > +                * are left unchanged.
> > > > > +                */
> > > > > +               if (!(flags & GPIO_V2_LINE_DIRECTION_FLAGS))
> > > > > +                       continue;
> > > >
> > > > Series looks good, thanks. I'd say that this bit here calls for at
> > > > least a debug-level message since we don't return an error unlike v=
1.
> > > > What do you think?
> > > >
> > >
> > > The change to the libgpiod Python bindings makes use of this to suppo=
rt
> > > reconfiguration of subsets, so on its own it isn't an abnormal path a=
nd
> > > I'm not sure it warrants even a debug.
> > >
> > > OTOH, I did consider if there should be a check that at least one lin=
e
> > > in the reconfig has a direction, returning an error if there are none=
, but
> > > was on the fence about it and left it out as it added complexity.
> > >
> > > Would that make more sense?
> > > Or do you have a problem with reconfiguring subsets?
> > >
> > > Cheers,
> > > Kent.
> >
> > I see. Ok, I'll take it as is interpreting it as a feature.
> >
>
> I'm totally ok with adding a check that direction is set at least once,
> if you would like that. Can be done with a reasonably minor change to
> gpio_v2_line_config_validate().  Though that would probably still double
> the size of this patch.
>
> Cheers,
> Kent.
>

No, it's fine. Docs are quite explicit about the behavior and there's
a comment in place.

Bart

