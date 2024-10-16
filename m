Return-Path: <linux-kernel+bounces-367681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5399A054F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F988B223BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0371220514E;
	Wed, 16 Oct 2024 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MRtj/JLy"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731A1F76D2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070542; cv=none; b=g/5l5uaYVFvjbCipvTe1VT1ySU1dKAuQ3uE+/7F4v9fvTaKDU/VsChXiKIWuSf29V87L/5/YbUMYJxRyBGMrVqmp0UOlY3Hnip+ty2WVw9Be6+nbRaYEHa+7eayVgQ8sVOtyMfOKjjUgIaUsUqpJaRH1+KdWHp1Nsr28MX6Lwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070542; c=relaxed/simple;
	bh=vPZ3V/67OPU7N35O2pwJMLRy6rBaOz/gopD6nZkjBo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTfEI//mhq4/2c0wzTDBPQcXH0BIcowXN60F0XOHMnTRgE6B0t3QQv7GSjbDPYzeqbGTm2UzenhwqNY14IsHSkfQR0gNuR7eVI9kRNK3c4GD1PyTir5kxuULwICdDPOOPmEiATmW3LvwpTZkq3V5R94cJENwvqh4vdhAwp4Sjbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MRtj/JLy; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so30351311fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729070539; x=1729675339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ma9NOvqv7kKyn4q/G6b5iGcRWGIfTZsnGO66bhriv5U=;
        b=MRtj/JLyiDnVJSJrEwOevQpe6Z+CgvnX2UhCp/IgyPwkWsrV273W9CqSNxuuhh1xWM
         ImdJpcsrPkoB3HAiP0YRmPeDYoJt32DZ7qhVnaX8IucEFt0tig+qxjimXE6Wr8CvIIQ0
         p+HYgI+b5bz0rSIdOFU14YAWtzsCJi6uPn3ihT+T7litMvGZ96VDEaaYD20XGeZ90hsA
         pO8kDhiE5wKLRxs1sjhgcqXsF9LqVSMhIPCZbPbmRwNcGhoTAjDH1ulliKEEi3f5tPKP
         oSXmkcnhQ1HC2yKtQMcagC6xMemjwuRA280uo6eTonbo+fOEibFkGQ8vSjkQ5juipHfK
         +xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729070539; x=1729675339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ma9NOvqv7kKyn4q/G6b5iGcRWGIfTZsnGO66bhriv5U=;
        b=RDg3H/iJ9e/9/BaeTDQeVjM5WDLJfL3opSflGS4sIR23KAcN9zt4f+LYwJLWEihkcT
         TlnzpemnQTDad28ZRcmA6fKk7LI4mBvKk/ujJuo1CMU7uaeKw0JzVOzulta39gPQ4XdL
         dwglm7HL85FgTuQK8Vxd3+VQdlgVZuQJFA2fdoR7iP/NHgi4Uub/kE9ZZ/dNIpnH49j3
         v4qtseQX/SBstmdpPyurJ0upBLa/Fo6NzjvBJzeS2KfvPFHf4qXBl5ovL3is4Z+S/I2n
         sVz2oGMx8NteS0DfUccxizmxemOHlIPRm8hIh9b4LpYr4SIkYGNWbHPyqak4hGbJa5r3
         ffTw==
X-Forwarded-Encrypted: i=1; AJvYcCXqSLF14r+n3tx8nfu0QfOlTBdZ5KBnJ3nbrHT6U4C4yreX15HszPp0gymlF+YB+pPEnaTKdh/46zqudAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ILtgAUCP951+nzZNWC2+RgrpDorU8ldyjmJkGM9rU14zYsTx
	L/67nWfoaSsmgyU59OrroYGq7R1SrTSwjL6YPyIDlmYuPSch8EpR+w/4P9WiHg7kfvnNO1/emwh
	y9eOYeMVlFob1j+m8fnKq/h9Fu/nU+DMlSDoenw==
X-Google-Smtp-Source: AGHT+IGMMEnyI29C5v5K810/b7oacrWYpBu/tiMpgfFmyW0mDG28cgzSVR0r5ByJAFa+YzdhP02tcN4nTmLa0DLS1rE=
X-Received: by 2002:a2e:f12:0:b0:2fa:bb65:801a with SMTP id
 38308e7fff4ca-2fb61b7700cmr16355651fa.26.1729070538931; Wed, 16 Oct 2024
 02:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-gpio-notify-in-kernel-events-v3-0-9edf05802271@linaro.org>
 <20241015-gpio-notify-in-kernel-events-v3-6-9edf05802271@linaro.org>
 <20241016051944.GA42100@rigel> <20241016072730.GA120095@rigel>
 <20241016083747.GB120095@rigel> <CAMRc=McR_eMizF6r30NqbgK4mE5ErzR=wbkD4O-Czn=+Oj4AXQ@mail.gmail.com>
 <20241016091714.GA207325@rigel>
In-Reply-To: <20241016091714.GA207325@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 16 Oct 2024 11:22:07 +0200
Message-ID: <CAMRc=MdoeyXwKuLmrmJ8zRCtVDNzEd34zgZ5Autye0TNv_OLhg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] gpiolib: notify user-space about in-kernel line
 state changes
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 11:17=E2=80=AFAM Kent Gibson <warthog618@gmail.com>=
 wrote:
>
> >
> > Does the following help?
> >
> > @@ -2830,7 +2860,7 @@ int gpiod_direction_output(struct gpio_desc
> > *desc, int value)
> >                       goto set_output_value;
> >               /* Emulate open drain by not actively driving the line hi=
gh */
> >               if (value) {
> > -                     ret =3D gpiod_direction_input(desc);
> > +                     ret =3D gpiod_direction_input_nonotify(desc);
> >                       goto set_output_flag;
> >               }
> >       } else if (test_bit(FLAG_OPEN_SOURCE, &flags)) {
> > @@ -2839,7 +2869,7 @@ int gpiod_direction_output(struct gpio_desc
> > *desc, int value)
> >                       goto set_output_value;
> >               /* Emulate open source by not actively driving the line l=
ow */
> >               if (!value) {
> > -                     ret =3D gpiod_direction_input(desc);
> > +                     ret =3D gpiod_direction_input_nonotify(desc);
> >                       goto set_output_flag;
> >               }
> >       } else {
> >
>
> That fixes the drive problems.
>

Ok, thanks.

> > >> Still haven't tested any debounce changes...
> > >>
> > >
> > > Have now.
> > >
> > > input -> input|debounce
> > >
> > > does not report the debounce.  Only get the one event and it does not
> > > contain any debounce.
> > >
> >
> > You mean, you get a CHANGED_CONFIG event but the debounce value is not
> > in the associated line info?
> >
>
> Correct.
>

Ok, let me see.

Bart

