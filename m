Return-Path: <linux-kernel+bounces-241664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44DE927DBC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F529286FA8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE76B74BF5;
	Thu,  4 Jul 2024 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4uRWr2du"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B884130A7C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720120849; cv=none; b=fwCqQB9zu9crGozMaMJffxY9v5sI7/jDx2K+lwzGdsUREhQfk2aaZp3KhMSLcZDgw6sHjlzxoDq57aJZqpteCXxxzK/4bwjqvp1L4n07xf/sd8f0GQxfzDAYgKHl/rp8pNvsDYM+vASUwRXXju1l1ADY7N2fIZOcz8XTo87ui7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720120849; c=relaxed/simple;
	bh=pdQ92OMMTEq5PGIJkQVEUfXc8WTGjI5vKokjizORJEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAhnNxIQKTFJtUbh/sb65VEsXsgj/dMr3NSQDNmh2JA7ecnvtzYH0F0WRBBO9KtoSmd7MhmZ+AFoahOs+I7T6J7hhr6CDY1KBZxbcq3tvZ4GeL7nU9vva5CCCncJhsIrpCHnxcJ3L+aSlBtaD/XthV9ol8d1Smrh/ifeZ4+DBW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4uRWr2du; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58c2e5e8649so3072320a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 12:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720120845; x=1720725645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFVzqIP4AMw5JrIPrVfFN5P1f2wJA/ZHy4AxSravv60=;
        b=4uRWr2duBgYDRQ1DIF29Vis5bAU2T+3qq/xLa/i/MQvsuuQhmZzazMRUnIrB31OtSO
         wj2Hi7c5eKhP9KTBdw5WbQuOSQ58EmcS13Vt/sJN7Ot1Ua55miOE/umhgdh1poNVkAgH
         cArfskpTB5IVrS3MM8NOBed2z84XOP5jn6Vmzxr7/S9WGo7lafNhoopTnTYid82kvzMR
         X0kCXtyMqh2QlM/r8a2GF3l5/f9VdwvEMM8il+6aST08RnOPdwARqug2nI+0fUMnKFcA
         yb0aEhAxyFIgx+h/zge28xv3kN2vv8AMh8VVRHduF85ilvPnr9o5sfhwbi3bDRNw5NEe
         xDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720120845; x=1720725645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFVzqIP4AMw5JrIPrVfFN5P1f2wJA/ZHy4AxSravv60=;
        b=A1QjHfmet0m5A/aFgU1nS8A/IiwW6nOKaoOgOcI+i3gmENQNN+f8UQVH0R9Bj05kaT
         jM9HK+uKRc3Qv9xmVUQiaq9WD9P8tsHHSbeSULY1qcusbShImNpDVcCmTAx7aIIPvPGj
         3r5bnD+tMPkpQABLHZF8GtJBIm0Xwip8pwPeEPhK7mEyicO8vjuXF8WWGvtNNER1GQLH
         /7psuTl4+g2o2k9SUO2VE7S1YVLI+Vbg2gNaADmyVqwkha4xxjTkblun0WtpMGmZB/57
         9mghfnDkyCSr3LOoeQ+XtZ1wSJzD4qo3p5ls9CALtJNvaqMyvRq3RjZICRlVJVMRxEnt
         tyBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOAkgQCrni5MGnFL+81SNm6h8lVdeOj36f3aH5kPW3Kcl+VOfF3PmkQ2iZz1GdHFBLW6UNUKazTBSMJuubp9/DN5VX0zgnT3b3hlmx
X-Gm-Message-State: AOJu0YySlvrlgkbIrNlGfG5ennHFEu0CM8r7XLzRoDPTXwTvBXidU72O
	qNcjWzRMtTIZoR8VNip7If1DTT13NJLkwP/Imlyc+FIWMBqNpxn4Vf1B5VA00lXqTVUJlcKOo/c
	gzGGppiCuIMIYzIfaSpjgS572pz2+wJFJLZH7
X-Google-Smtp-Source: AGHT+IF582EidK8pknJt2i3nAI5dvJyeL9MiWxnnV1XpXpxgLcuvQLDkYFc9KQEBELNB9zP5yO0l+bOMhjmdP43kwiQ=
X-Received: by 2002:a17:906:16d0:b0:a77:ba2a:3c67 with SMTP id
 a640c23a62f3a-a77bdd94c28mr166843466b.38.1720120844472; Thu, 04 Jul 2024
 12:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190157.712590-1-zenghuchen@google.com>
In-Reply-To: <20240704190157.712590-1-zenghuchen@google.com>
From: Jack Chen <zenghuchen@google.com>
Date: Thu, 4 Jul 2024 15:20:33 -0400
Message-ID: <CALvyBcWJpmU51sDiPRFFMWx0Ongw8_2T0EbsTR6q7zsHcyhHAQ@mail.gmail.com>
Subject: Re: [PATCH] leds: lm3601x: Calculate max_brightness and brightness properly
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, but I mistakenly sent the wrong patch.

Please take a look at the v2 patch instead: [PATCH v2] leds: lm3601x:
Calculate max_brightness and brightness properly.

I apologize for the error and any confusion it may have caused.

On Thu, Jul 4, 2024 at 3:02=E2=80=AFPM Jack Chen <zenghuchen@google.com> wr=
ote:
>
> The torch_current_max should be checked not exceeding the upper bound.
> If it does, throw a warning message and set to LM3601X_MAX_TORCH_I_UA.
>
> LM3601x torch brigthness register (LM3601X_LED_TORCH_REG) takes 0 as the
> minimum output (2.4 mA). However, 0 of led_brightness means LED_OFF.
> Adding a -1 offset to brightness before writing to brightness
> register, so when users write minimum brightness (1), it sets lm3601x
> output the minimum.
>
> Signed-off-by: Jack Chen <zenghuchen@google.com>
> ---
>  drivers/leds/flash/leds-lm3601x.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/leds/flash/leds-lm3601x.c b/drivers/leds/flash/leds-=
lm3601x.c
> index 7e93c447fec5..fc4df904ea90 100644
> --- a/drivers/leds/flash/leds-lm3601x.c
> +++ b/drivers/leds/flash/leds-lm3601x.c
> @@ -190,7 +190,7 @@ static int lm3601x_brightness_set(struct led_classdev=
 *cdev,
>                 goto out;
>         }
>
> -       ret =3D regmap_write(led->regmap, LM3601X_LED_TORCH_REG, brightne=
ss);
> +       ret =3D regmap_write(led->regmap, LM3601X_LED_TORCH_REG, brightne=
ss - 1);
>         if (ret < 0)
>                 goto out;
>
> @@ -341,8 +341,9 @@ static int lm3601x_register_leds(struct lm3601x_led *=
led,
>
>         led_cdev =3D &led->fled_cdev.led_cdev;
>         led_cdev->brightness_set_blocking =3D lm3601x_brightness_set;
> -       led_cdev->max_brightness =3D DIV_ROUND_UP(led->torch_current_max,
> -                                               LM3601X_TORCH_REG_DIV);
> +       led_cdev->max_brightness =3D DIV_ROUND_UP(
> +                       led->torch_current_max - LM3601X_MIN_TORCH_I_UA +=
 1,
> +                       LM3601X_TORCH_REG_DIV);
>         led_cdev->flags |=3D LED_DEV_CAP_FLASH;
>
>         init_data.fwnode =3D fwnode;
> @@ -386,6 +387,14 @@ static int lm3601x_parse_node(struct lm3601x_led *le=
d,
>                 goto out_err;
>         }
>
> +       if (led->torch_current_max > LM3601X_MAX_TORCH_I_UA) {
> +               dev_warn(&led->client->dev,
> +                        "led-max-microamp cannot be higher than %d\n",
> +                        LM3601X_MAX_TORCH_I_UA);
> +               led->torch_current_max =3D LM3601X_MAX_TORCH_I_UA;
> +       }
> +
> +
>         ret =3D fwnode_property_read_u32(child, "flash-max-microamp",
>                                 &led->flash_current_max);
>         if (ret) {
> --
> 2.45.2.803.g4e1b14247a-goog
>

