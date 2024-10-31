Return-Path: <linux-kernel+bounces-391138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80029B8327
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF622812F3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EF91CB331;
	Thu, 31 Oct 2024 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TonD/T6D"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28FC141987
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402112; cv=none; b=EOFyOsd4O/6Py7qzx9HPS8wD3JE7ELj6cPkv2NZB5aCl7NeMZFcTxBcYfNRECl0dSOkEmW8DjW5LgvAzwAiSST+8jCQgIJ8x9FShDLmIBavQimiZ4UVPBbqTK2XOyYRyId3TO4CxxH10RPk1lyICWfsfHprQaDeDCIJhhmYuxIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402112; c=relaxed/simple;
	bh=N1fYzkm6fzUz+e+vRiqxfL0N2wW6fQWiDTiPtOgJChY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzpoGakc5WvCyDEbY317hoSuU1mhOneQthIsiq6s4iOUlWLaNs/S1KR5R+aMXdHRWAi4jwsa+w24oXJMRGUSpBF0qHsSme5EQkqiObXa02Tu+IV4nA7s07Lqx+AbCPOuhaRDehTWqhyrn6wZBpXa8Cz2+f3LxCojNfkSvMQgOHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TonD/T6D; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53a007743e7so1477583e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730402108; x=1731006908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAwsPMZV145BtHwYn6jGE8nEqAn9J+nFJ3D93oIIBmw=;
        b=TonD/T6Dm0Rkag5OAc+Ynhdk8S5aQ7zu2hdfQ5IlEwXWc8WAjxk7wS7wHoKDxiPVOc
         R4lw+Cuizfx22Gf8ug1NfjEiPvoYutPaNI/iWtp91JZi/GT0KqURdzceHulwJYGkEsCb
         5iTFISI34A2K9JQ74Wpxin3zQBjSZKSmCzNX6MeN1Ogp836yeffykDkIaa70Ut+FHv0v
         8l2fyEQ11JtUmm5ybyzsLdRVdwg3j/bAxG5krBpo0z259CemcUDtcSDdlcZ3FeEz6lG2
         3MxXdW0snvpg8oUjnqreAzCjiMVvCBYerwEf5tXgnYTPtzrFWcAFdXKULiOnM3izjrRl
         3wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730402108; x=1731006908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAwsPMZV145BtHwYn6jGE8nEqAn9J+nFJ3D93oIIBmw=;
        b=s5KfYKcDqbjqroYempOQWjvt5fzvfjnyGz+xzCDuN43eGhcChKWY5L6X+lDYORnIvj
         YeAuHEhKbNMtryFtriUlLHkRJm5A8f5PnoKilWw7oXU4S9dgm6PycbtAN0UTX9E606sf
         Xg4VcnjtcK/rP1FEUtnzcxWipWsOVrnZh45D+/7UWwB7ZvvJ/Sb3LqRwWmxy2FCt/AIa
         xKbl9zBGnIbrvd2vNLmlCrHccixBIRbtj6xSI+okEQXUX8nt9Xhxft8u/d7/Yc+2dVmL
         HtcYaOb9xRiwzhNTbAHkq0Q9SfZqYR1GKWE9QsqrqtP1nAkqxeD5gvYz3RaGjQHqjvuy
         xCNw==
X-Forwarded-Encrypted: i=1; AJvYcCW0h6sFOt+xLB237YELemXeAhQvJf4a2g+97bdg6xfqzu5qZhs2O6OW+OdB5ofjTyYoMhvErM/Qrv24V50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLyma1UsrNXN9NgFqQYkTQSuMWK2UuN/F1VOYEjEYn+XcV8ce9
	LwCdbIfqJxT5bFNNko6JDvxaJt9O64Tk2r+4hoLTaGpkxoL5oj6cJAPV97nryloldWaYMi1dBsn
	7LQ31BTTyiQetoJN7fJ66IjsljruPRwkHn7YMHA==
X-Google-Smtp-Source: AGHT+IFhGKzyho6e6TzBRPsG2H6OQLFu8aDknW6VG5e0GIr5eAiCAh62PBm4LRyEsQlB9wiETJ4VA9Ni8RZte4XtyxE=
X-Received: by 2002:a05:6512:3a91:b0:52e:e3c3:643f with SMTP id
 2adb3069b0e04-53c79e158c3mr2531913e87.2.1730402107655; Thu, 31 Oct 2024
 12:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031092154.2244728-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241031092154.2244728-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 31 Oct 2024 20:14:56 +0100
Message-ID: <CAMRc=MeiZ_U0UoU1atWxyWxEhcKwUcCK_cbYu_p-DQar27Fw+A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Deduplicate gpiod_direction_input_nonotify()
 call
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 10:22=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Deduplicate gpiod_direction_input_nonotify() call in
> gpiod_direction_output_nonotify() when emulating open-drain
> or open-source behaviour. It also aligns the error check
> approaches in set_output_value and set_output_flag labels.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 5666c462248c..9376dd270344 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2877,19 +2877,15 @@ int gpiod_direction_output_nonotify(struct gpio_d=
esc *desc, int value)
>                 if (!ret)
>                         goto set_output_value;
>                 /* Emulate open drain by not actively driving the line hi=
gh */
> -               if (value) {
> -                       ret =3D gpiod_direction_input_nonotify(desc);
> +               if (value)
>                         goto set_output_flag;
> -               }
>         } else if (test_bit(FLAG_OPEN_SOURCE, &flags)) {
>                 ret =3D gpio_set_config(desc, PIN_CONFIG_DRIVE_OPEN_SOURC=
E);
>                 if (!ret)
>                         goto set_output_value;
>                 /* Emulate open source by not actively driving the line l=
ow */
> -               if (!value) {
> -                       ret =3D gpiod_direction_input_nonotify(desc);
> +               if (!value)
>                         goto set_output_flag;
> -               }
>         } else {
>                 gpio_set_config(desc, PIN_CONFIG_DRIVE_PUSH_PULL);
>         }
> @@ -2901,15 +2897,17 @@ int gpiod_direction_output_nonotify(struct gpio_d=
esc *desc, int value)
>         return gpiod_direction_output_raw_commit(desc, value);
>
>  set_output_flag:

Ok, I'll take it but please change this label to "emulate_output" or
something similar that's more indicative on what the goal here is.

Bart

> +       ret =3D gpiod_direction_input_nonotify(desc);
> +       if (ret)
> +               return ret;
>         /*
>          * When emulating open-source or open-drain functionalities by no=
t
>          * actively driving the line (setting mode to input) we still nee=
d to
>          * set the IS_OUT flag or otherwise we won't be able to set the l=
ine
>          * value anymore.
>          */
> -       if (ret =3D=3D 0)
> -               set_bit(FLAG_IS_OUT, &desc->flags);
> -       return ret;
> +       set_bit(FLAG_IS_OUT, &desc->flags);
> +       return 0;
>  }
>
>  /**
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>

