Return-Path: <linux-kernel+bounces-389476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA0C9B6D87
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B331F2218F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9525E1D2B23;
	Wed, 30 Oct 2024 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FJqNFXy1"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC66A1D1E7C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319661; cv=none; b=q8DPbUq/Y5D5hnt/2zolxF7gmBD61Vkr4hivh5HPmxHHe9YfrcM1BoiO6+AC1SZWXVDeYx+NdlP+J0OydgMYJDxoU0BEwRWR/dKnio7q256uzMMfM9cEmqOsO7zTlUOZxNysW05fGrx9G1aNDKpdrs1RNWz7lpphtA8RJDgf5VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319661; c=relaxed/simple;
	bh=QQRhXpuiMT+Kilj5Hw1Rx6l+gTjEZ68hhbyrFkDjkvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1Yc0EHwNFFgZ+VVL9parxHm8BylukDRIkUeLQ0AQ5P2JUEaEx1JHUCQXN4YlOELW3La/WqnVMPVdhoAGQbhC1UOdOD6+LzshXtdcEOqx6zcmDqAoCivtkS7KvXlulmTPuNW8ZOmJdVSE4fuRlfKz+0DFqof7g7RZ+2QbC2F+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FJqNFXy1; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53a007743e7so305870e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730319657; x=1730924457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UdUJ1HarHJn1WZ7E/yY6PE6GpxT0s81fgwEBhh+BH4=;
        b=FJqNFXy15qwmv9Mrr8w1X4exeh4c27rEzQvfjQSf6XhHlkOrSbn1LQ4h6AOlP7Zu7Q
         hz/PVy4Rek9t/ErhsP0dAxo/Pw8UPHtrzByKyYDuNU0ndE+ut5h9j8yJohjPUFrp5No4
         CY/vneC5Djj7w5A6oMMAjKthD26bX2Y8gudZxeKkr8a8s6alPfcVc+AIAYPawJbHQ/0P
         JU3gx1arSzQZVa7n6aArU1RGxoPDBAxoJHprnh0OdaytPk6WekCXdskKjwhS9X6LjZr1
         HsokWkUkSEqv3qUoMvyjFz4GYo3kxH2ARoV9XvgbXwA4+A4GWWSgzsgApfl2FEQZtn5e
         zHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730319657; x=1730924457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UdUJ1HarHJn1WZ7E/yY6PE6GpxT0s81fgwEBhh+BH4=;
        b=wkHkZQqi9NYcNQKxodmpsI9AXJb0VDPy0Vw4D1NnS/T2bpKjvsTAEXZ3CjRkWqh53O
         ZZVFMGgwR6CDdktn/kdpkliFrCc7nHbZ4GcTGB2YYNFJdNCOuuSnL18YBB1oV6NRmLbz
         HzN/8GiBeJmfWLWnBU0Hnt26jvUQxetx6yDYL3Cd0b06Ll+ZAndw9OXO/Ru6PNSGneZU
         fkGhds8MXavGfKEt5aTertSGuwqBjT1Ngda3nrQNh/bQ3zaiSnwuNOvLLM2+me3aqb5c
         KCaaoSPmCLLh79aoXbX7h0R0Kc5sv9tXGwkE7RGv0RbEPXCvghyVuF0d9RLOs3dtLiDr
         hz4w==
X-Forwarded-Encrypted: i=1; AJvYcCXccGveQNy3e/TMCY+0/Hb5F15IbRLH/FTSX2oCSvPMx4wTn65VkRgkXzkx6Gv2A262IOLlfmbgoSjLMhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpTy9DfE5uUKymQkouiQpLwMabjy0gCCcYAs3Z6Uv43b08wT8v
	9V7+wSPlSun2WTvH885YxYTKByytFF1phPh0zVn90oC6OThq/ykKC6/RlAT+hjKjSwZl8+m83Zl
	wYur/556rIjLT8wjr4DhNpOlexykyzQwksk8wbw==
X-Google-Smtp-Source: AGHT+IHE5t34lQ/TJfFSkZ4O2EczePoP9pYLm0/rR3+rIL3etHSyZdnUbpS95AHX3qmTney8e/DDfhne2K7wS8xuqsI=
X-Received: by 2002:a05:6512:ac3:b0:536:56d8:24b4 with SMTP id
 2adb3069b0e04-53c79e15746mr525773e87.5.1730319657020; Wed, 30 Oct 2024
 13:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028134454.1156852-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241028134454.1156852-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 30 Oct 2024 21:20:45 +0100
Message-ID: <CAMRc=Mc_PW32jNO+C5AEQK6ej_CsCSV-HY76aJoQ6bjZ=JPOtg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Use traditional pattern when checking error codes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 2:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Instead of 'if (ret =3D=3D 0)' switch to "check for the error first" rule=
.

Well there's much more to this patch than that and I have some issues with =
it.

>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> While it gives a "+" (plus) statistics it makes the code easier to read

Not only does it increase the footprint but it also adds completely
unnecessary goto labels.

> and maintain (when, e.g., want to add somethning in between touched lines=
).
>

The single line calls to the notifier chain are unlikely to be
extended anytime soon but even then I think we should cross that
bridge when we get there.

>  drivers/gpio/gpiolib.c | 104 ++++++++++++++++++++++-------------------
>  1 file changed, 56 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 5666c462248c..a9a3e032ed5b 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2674,10 +2674,11 @@ int gpio_set_debounce_timeout(struct gpio_desc *d=
esc, unsigned int debounce)
>         ret =3D gpio_set_config_with_argument_optional(desc,
>                                                      PIN_CONFIG_INPUT_DEB=
OUNCE,
>                                                      debounce);
> -       if (!ret)
> -               gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG=
);
> +       if (ret)
> +               return ret;
>
> -       return ret;
> +       gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
> +       return 0;
>  }

I really don't see how this makes it better. The logic here is: if the
underlying set config worked fine - emit the event. Otherwise continue
with the function (even if there's nothing there now). If anything
you're making it more difficult to modify later because logically the
notification is just an optional step on the way to returning from the
function.

>
>  /**
> @@ -2697,16 +2698,17 @@ int gpiod_direction_input(struct gpio_desc *desc)
>         VALIDATE_DESC(desc);
>
>         ret =3D gpiod_direction_input_nonotify(desc);
> -       if (ret =3D=3D 0)
> -               gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG=
);
> +       if (ret)
> +               return ret;
>

Ok, for consistency I could take it but please put this into a
separate commit doing just that (here and elsewhere).

> -       return ret;
> +       gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(gpiod_direction_input);
>
>  int gpiod_direction_input_nonotify(struct gpio_desc *desc)
>  {
> -       int ret =3D 0;
> +       int ret;
>
>         CLASS(gpio_chip_guard, guard)(desc);
>         if (!guard.gc)
> @@ -2733,6 +2735,8 @@ int gpiod_direction_input_nonotify(struct gpio_desc=
 *desc)
>         if (guard.gc->direction_input) {
>                 ret =3D guard.gc->direction_input(guard.gc,
>                                                 gpio_chip_hwgpio(desc));
> +               if (ret)
> +                       goto out_trace_direction;
>         } else if (guard.gc->get_direction &&
>                   (guard.gc->get_direction(guard.gc,
>                                            gpio_chip_hwgpio(desc)) !=3D 1=
)) {
> @@ -2741,11 +2745,11 @@ int gpiod_direction_input_nonotify(struct gpio_de=
sc *desc)
>                            __func__);
>                 return -EIO;
>         }
> -       if (ret =3D=3D 0) {
> -               clear_bit(FLAG_IS_OUT, &desc->flags);
> -               ret =3D gpio_set_bias(desc);
> -       }
>
> +       clear_bit(FLAG_IS_OUT, &desc->flags);
> +       ret =3D gpio_set_bias(desc);
> +
> +out_trace_direction:

This makes it worse! We can't just apply the "return fast" rule
indiscriminately. Sometimes it does make sense to go "if the previous
step worked, do this, otherwise keep going".

Also: adding more labels for no reason?

>         trace_gpio_direction(desc_to_gpio(desc), 1, ret);
>
>         return ret;
> @@ -2774,6 +2778,8 @@ static int gpiod_direction_output_raw_commit(struct=
 gpio_desc *desc, int value)
>         if (guard.gc->direction_output) {
>                 ret =3D guard.gc->direction_output(guard.gc,
>                                                  gpio_chip_hwgpio(desc), =
val);
> +               if (ret)
> +                       goto out_trace_value_and_direction;
>         } else {
>                 /* Check that we are in output mode if we can */
>                 if (guard.gc->get_direction &&
> @@ -2790,8 +2796,9 @@ static int gpiod_direction_output_raw_commit(struct=
 gpio_desc *desc, int value)
>                 guard.gc->set(guard.gc, gpio_chip_hwgpio(desc), val);
>         }
>
> -       if (!ret)
> -               set_bit(FLAG_IS_OUT, &desc->flags);
> +       set_bit(FLAG_IS_OUT, &desc->flags);
> +
> +out_trace_value_and_direction:
>         trace_gpio_value(desc_to_gpio(desc), 0, val);
>         trace_gpio_direction(desc_to_gpio(desc), 0, ret);
>         return ret;
> @@ -2816,10 +2823,11 @@ int gpiod_direction_output_raw(struct gpio_desc *=
desc, int value)
>         VALIDATE_DESC(desc);
>
>         ret =3D gpiod_direction_output_raw_commit(desc, value);
> -       if (ret =3D=3D 0)
> -               gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG=
);
> +       if (ret)
> +               return ret;
>
> -       return ret;
> +       gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(gpiod_direction_output_raw);
>
> @@ -2843,10 +2851,11 @@ int gpiod_direction_output(struct gpio_desc *desc=
, int value)
>         VALIDATE_DESC(desc);
>
>         ret =3D gpiod_direction_output_nonotify(desc, value);
> -       if (ret =3D=3D 0)
> -               gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG=
);
> +       if (ret)
> +               return ret;
>
> -       return ret;
> +       gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(gpiod_direction_output);
>
> @@ -2877,19 +2886,15 @@ int gpiod_direction_output_nonotify(struct gpio_d=
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
> @@ -2901,15 +2906,17 @@ int gpiod_direction_output_nonotify(struct gpio_d=
esc *desc, int value)
>         return gpiod_direction_output_raw_commit(desc, value);
>
>  set_output_flag:
> +       ret =3D gpiod_direction_input_nonotify(desc);

This can't be right. Or am I just not getting it? In any case it's
completely unreadable now. Go set output flag but start by setting
direction to input first?

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
> @@ -2994,25 +3001,25 @@ int gpiod_set_config(struct gpio_desc *desc, unsi=
gned long config)
>         VALIDATE_DESC(desc);
>
>         ret =3D gpio_do_set_config(desc, config);
> -       if (!ret) {
> -               /* These are the only options we notify the userspace abo=
ut. */
> -               switch (pinconf_to_config_param(config)) {
> -               case PIN_CONFIG_BIAS_DISABLE:
> -               case PIN_CONFIG_BIAS_PULL_DOWN:
> -               case PIN_CONFIG_BIAS_PULL_UP:
> -               case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> -               case PIN_CONFIG_DRIVE_OPEN_SOURCE:
> -               case PIN_CONFIG_DRIVE_PUSH_PULL:
> -               case PIN_CONFIG_INPUT_DEBOUNCE:
> -                       gpiod_line_state_notify(desc,
> -                                               GPIO_V2_LINE_CHANGED_CONF=
IG);
> -                       break;
> -               default:
> -                       break;
> -               }

If you really want to get rid of one level of indentation here, I
suggest moving it into a separate function.

> +       if (ret)
> +               return ret;
> +
> +       /* These are the only options we notify the userspace about */
> +       switch (pinconf_to_config_param(config)) {
> +       case PIN_CONFIG_BIAS_DISABLE:
> +       case PIN_CONFIG_BIAS_PULL_DOWN:
> +       case PIN_CONFIG_BIAS_PULL_UP:
> +       case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +       case PIN_CONFIG_DRIVE_OPEN_SOURCE:
> +       case PIN_CONFIG_DRIVE_PUSH_PULL:
> +       case PIN_CONFIG_INPUT_DEBOUNCE:
> +               gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG=
);
> +               break;
> +       default:
> +               break;
>         }
>
> -       return ret;
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(gpiod_set_config);
>
> @@ -3730,10 +3737,11 @@ int gpiod_set_consumer_name(struct gpio_desc *des=
c, const char *name)
>         VALIDATE_DESC(desc);
>
>         ret =3D desc_set_label(desc, name);
> -       if (ret =3D=3D 0)
> -               gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG=
);
> +       if (ret)
> +               return ret;
>
> -       return ret;
> +       gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(gpiod_set_consumer_name);
>
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>

Most of this is IMO pointless churn. You typically do a lot of great
cleanups but this just doesn't make sense. Sorry but NAK.

Bart

