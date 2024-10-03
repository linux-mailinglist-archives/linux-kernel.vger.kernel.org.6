Return-Path: <linux-kernel+bounces-349202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D0B98F26F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B329283997
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A49C1A0BEE;
	Thu,  3 Oct 2024 15:21:20 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0419CD0B;
	Thu,  3 Oct 2024 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968879; cv=none; b=aHuTywd7EYgtzyNg6//Ae/aSPLGvhHv/bUJWd+q7E+neWzAnpoAbSbkxklV+CA0piXL4CtyHtje7OogmQlY0opP+EXUNV9MVRxVILnyEtBfrwnwSjcdszaMxoJaGzDpLcKeCsEEx2ySusjQuWSjf6njWgW72N49KCoKoTY7b4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968879; c=relaxed/simple;
	bh=DDQ+PSlc/KTYGIbHad+/LM11N1DWg4popkbpIAz8l/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xg8JBd80Jagvvdulh1UqoBz/FiQMFiKkSgYKbJ77KRStsu2QNqBfl/mbYB/5BiFN2aI2kqR9yvncxI5QVDArlQzbKh6TWXghwNVYrCfCyqvuFRcYjMbEdpmcXY3oBIJOqDAfWNMIOYk0t5m9PmuN9rfkMuE3DyjLrAgKwGIlF3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539908f238fso1331476e87.2;
        Thu, 03 Oct 2024 08:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727968874; x=1728573674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PS0oK8lHaTH+dL4v+mceS/ll5BSP4UtwYbCaVuDE/9E=;
        b=LkFNvgGQoCQ79f1UaSUZX7AkbM0b4ucOdO4ZF0b2vmRwFAj6Opb2kLUj9MfsoqIYVe
         OfofUoN0vgCmFSQ2XlfqdSJ3BDJLNHq5wt9aUgDC3w61tBOtMANzBYk2vhNSWLCtxdnH
         k4lgsrdbB+684LEhvUwb3LBv9PY/QlXl51PIwhrR0E2+WVxFsd/9h+dWJVUwyjBP4Pja
         GQ94ZmFJ8AUmLuUzqR0rbnM0aWTvpN4c0Iu762ltZ1/tV6nR33CsYyjjiKmgFvMSNjVc
         lhbs9Kwsp/BOYejOlnhSNbdaCTej/tZ9CUX0IVau7/UeEuJ6EwLVjEpBKcy34WV9Ge/F
         hKZA==
X-Forwarded-Encrypted: i=1; AJvYcCU5yGagjgEj0cNZBJhE9Qn2FvWz5SyZufpn6GJgV/JbvGUSVeAdEG63YAeiHWu866Urx+5RCv9RN0pysp6Q@vger.kernel.org, AJvYcCVjb3IwUEMDC86uIm0FzlC1F6V4DaK25mugFhMz86HcYJsoNAzn8N5aVBFSfQ1hjA5NE5jfcD8sRZg6@vger.kernel.org
X-Gm-Message-State: AOJu0YyAxDfiG/MKDOHbhAmhz9WtWbnHC6d8auSURHUCSmY3IEQ7saKF
	h8xpqt+xiN6QlRXXcDMYjElktDlHolQsEOgt3g7BdKg4zyqgKOYXgO9t3etnvzA=
X-Google-Smtp-Source: AGHT+IFwosWHDVDQPaNJXu6SqgIW2hc97AIds79XDtrlPuXSsndWi4516qEoetwy2UNDg23syC0iPQ==
X-Received: by 2002:a05:6512:33c8:b0:539:964c:16d4 with SMTP id 2adb3069b0e04-539a0685066mr4627881e87.36.1727968873506;
        Thu, 03 Oct 2024 08:21:13 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a82974e7sm197636e87.163.2024.10.03.08.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 08:21:13 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fabd2c4ac0so13852971fa.1;
        Thu, 03 Oct 2024 08:21:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUH4Xh0TE1F8VbU89Zuv8ehOqqoRZ3KXB5x7pCD4plXGgb7NUJI0197AZwlorkK4mBJVDKC+OLTGrc9@vger.kernel.org, AJvYcCWuITCC0S14Vy0sCclg0B40QOHQ/CmCDw9O+c/LQgcyiLzAizq8MkuUk18jElYzMMEuteuGq3dfyEcyglTn@vger.kernel.org
X-Received: by 2002:a05:651c:2225:b0:2fa:d723:efba with SMTP id
 38308e7fff4ca-2fae1024579mr48127331fa.8.1727968872256; Thu, 03 Oct 2024
 08:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003111444.543964-1-andre.przywara@arm.com> <20241003111444.543964-5-andre.przywara@arm.com>
In-Reply-To: <20241003111444.543964-5-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 3 Oct 2024 23:20:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v64jPk64Y-Aef1YPWkjCfp0eq6EasE2xszu8+WoX+Epv-A@mail.gmail.com>
Message-ID: <CAGb2v64jPk64Y-Aef1YPWkjCfp0eq6EasE2xszu8+WoX+Epv-A@mail.gmail.com>
Subject: Re: [PATCH 4/5] mfd: axp20x: Add support for AXP323
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Martin Botka <martin.botka@somainline.org>, Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 7:15=E2=80=AFPM Andre Przywara <andre.przywara@arm.c=
om> wrote:
>
> The X-Powers AXP323 is a very close sibling of the AXP313A. The only
> difference seems to be the ability to dual-phase the first two DC/DC
> converter, which adds another register.
>
> Add the required boilerplate to introduce a new PMIC to the AXP MFD
> driver. Where possible, this just maps into the existing structs defined
> for the AXP313A, only deviating where needed.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/mfd/axp20x-i2c.c   |  1 +
>  drivers/mfd/axp20x.c       | 26 ++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h |  2 ++
>  3 files changed, 29 insertions(+)
>
> diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> index 791a0b4cb64b..5c93136f977e 100644
> --- a/drivers/mfd/axp20x-i2c.c
> +++ b/drivers/mfd/axp20x-i2c.c
> @@ -65,6 +65,7 @@ static const struct of_device_id axp20x_i2c_of_match[] =
=3D {
>         { .compatible =3D "x-powers,axp221", .data =3D (void *)AXP221_ID =
},
>         { .compatible =3D "x-powers,axp223", .data =3D (void *)AXP223_ID =
},
>         { .compatible =3D "x-powers,axp313a", .data =3D (void *)AXP313A_I=
D },
> +       { .compatible =3D "x-powers,axp323", .data =3D (void *)AXP323_ID =
},
>         { .compatible =3D "x-powers,axp717", .data =3D (void *)AXP717_ID =
},
>         { .compatible =3D "x-powers,axp803", .data =3D (void *)AXP803_ID =
},
>         { .compatible =3D "x-powers,axp806", .data =3D (void *)AXP806_ID =
},
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index bc08ae433260..8d90962b56d9 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -42,6 +42,7 @@ static const char * const axp20x_model_names[] =3D {
>         [AXP223_ID] =3D "AXP223",
>         [AXP288_ID] =3D "AXP288",
>         [AXP313A_ID] =3D "AXP313a",
> +       [AXP323_ID] =3D "AXP323",
>         [AXP717_ID] =3D "AXP717",
>         [AXP803_ID] =3D "AXP803",
>         [AXP806_ID] =3D "AXP806",
> @@ -193,6 +194,10 @@ static const struct regmap_range axp313a_writeable_r=
anges[] =3D {
>         regmap_reg_range(AXP313A_ON_INDICATE, AXP313A_IRQ_STATE),
>  };
>
> +static const struct regmap_range axp323_writeable_ranges[] =3D {
> +       regmap_reg_range(AXP313A_ON_INDICATE, AXP323_DCDC_MODE_CTRL2),
> +};
> +
>  static const struct regmap_range axp313a_volatile_ranges[] =3D {
>         regmap_reg_range(AXP313A_SHUTDOWN_CTRL, AXP313A_SHUTDOWN_CTRL),
>         regmap_reg_range(AXP313A_IRQ_STATE, AXP313A_IRQ_STATE),
> @@ -203,6 +208,11 @@ static const struct regmap_access_table axp313a_writ=
eable_table =3D {
>         .n_yes_ranges =3D ARRAY_SIZE(axp313a_writeable_ranges),
>  };
>
> +static const struct regmap_access_table axp323_writeable_table =3D {
> +       .yes_ranges =3D axp323_writeable_ranges,
> +       .n_yes_ranges =3D ARRAY_SIZE(axp323_writeable_ranges),
> +};
> +
>  static const struct regmap_access_table axp313a_volatile_table =3D {
>         .yes_ranges =3D axp313a_volatile_ranges,
>         .n_yes_ranges =3D ARRAY_SIZE(axp313a_volatile_ranges),
> @@ -433,6 +443,15 @@ static const struct regmap_config axp313a_regmap_con=
fig =3D {
>         .cache_type =3D REGCACHE_MAPLE,
>  };
>
> +static const struct regmap_config axp323_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +       .wr_table =3D &axp323_writeable_table,
> +       .volatile_table =3D &axp313a_volatile_table,
> +       .max_register =3D AXP323_DCDC_MODE_CTRL2,
> +       .cache_type =3D REGCACHE_RBTREE,

Maple tree instead?

The rest looks fine, so once fixed,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> +};
> +
>  static const struct regmap_config axp717_regmap_config =3D {
>         .reg_bits =3D 8,
>         .val_bits =3D 8,
> @@ -1221,6 +1240,7 @@ static int axp20x_power_off(struct sys_off_data *da=
ta)
>         unsigned int shutdown_reg;
>
>         switch (axp20x->variant) {
> +       case AXP323_ID:
>         case AXP313A_ID:
>                 shutdown_reg =3D AXP313A_SHUTDOWN_CTRL;
>                 break;
> @@ -1289,6 +1309,12 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
>                 axp20x->regmap_cfg =3D &axp313a_regmap_config;
>                 axp20x->regmap_irq_chip =3D &axp313a_regmap_irq_chip;
>                 break;
> +       case AXP323_ID:
> +               axp20x->nr_cells =3D ARRAY_SIZE(axp313a_cells);
> +               axp20x->cells =3D axp313a_cells;
> +               axp20x->regmap_cfg =3D &axp323_regmap_config;
> +               axp20x->regmap_irq_chip =3D &axp313a_regmap_irq_chip;
> +               break;
>         case AXP717_ID:
>                 axp20x->nr_cells =3D ARRAY_SIZE(axp717_cells);
>                 axp20x->cells =3D axp717_cells;
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 79ecaaaa2070..c3df0e615fbf 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -19,6 +19,7 @@ enum axp20x_variants {
>         AXP223_ID,
>         AXP288_ID,
>         AXP313A_ID,
> +       AXP323_ID,
>         AXP717_ID,
>         AXP803_ID,
>         AXP806_ID,
> @@ -113,6 +114,7 @@ enum axp20x_variants {
>  #define AXP313A_SHUTDOWN_CTRL          0x1a
>  #define AXP313A_IRQ_EN                 0x20
>  #define AXP313A_IRQ_STATE              0x21
> +#define AXP323_DCDC_MODE_CTRL2         0x22
>
>  #define AXP717_ON_INDICATE             0x00
>  #define AXP717_PMU_STATUS_2            0x01
> --
> 2.25.1
>

