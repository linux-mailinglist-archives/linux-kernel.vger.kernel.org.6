Return-Path: <linux-kernel+bounces-436374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2159E8519
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 13:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7FA281731
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94FE1482F3;
	Sun,  8 Dec 2024 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbtsWhaw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF576145FE0
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662200; cv=none; b=X4gbLcjFFt4Rb875KQlww0fGyZ6yBEQIQ7MhCVkPpwEm6yHVnqbHo0wA6LeH79msQ6bRvCiptRAyZeJmVKN6wi5syxqmb4sgs6qD64BzT/13DLLciD+HnawfW5rpZeqrxfD6T4mKduBy7gYraNYQ49Ox8I8GAauVCUVRMNNWInA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662200; c=relaxed/simple;
	bh=CN2X+9pkicfQp7HSgL0eKKftjm6PnSqsyu+tXoHm8c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/G5CrF9W8uR09rAnimKqubsAr3fCL4l5T6Tn46TfoYAuNbOHOGIqqyx6v31uNXlwloi3pczlkd62/jaQAxv+vf24NzdSCcvWDKFMandZaFpsL4mUCh7ZvxKBaIXlH/is6XyKsC9BmmbTSBOS9GfDr32eLmmnJr1LnviavAdkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbtsWhaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7648DC4CED2
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733662199;
	bh=CN2X+9pkicfQp7HSgL0eKKftjm6PnSqsyu+tXoHm8c8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mbtsWhawDeyg2QCAqTOyp5m4xwulrzhT9Nz4luWfTZjncmP9zgLUm9xO/q/XorQfQ
	 BEHtnKhyE3SNSBzPVN4IxJM8e77rKB7ZLfA1YNN68cfLmelsMcKYipQRYyL68oAjqo
	 9fM7TFueszc9CC7FusTSd3HHh5GeT29cBgeW66Psvhm7THwf1Nz8lRTEErZM0Rd2HS
	 5J5I8KGlRJd2z6zuxnin4zQf3H3Mb2U6vhzwJj701PpnlL+QMmeMfSlcZDt78OY8Yk
	 MoF+yzRp3bbPl2T3Y5EO6FBWQTROjOXuEO3VHKtlon1VyLFAHASJXipdVV0nk3SNuU
	 YaHUl2OhBNxiQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d2726c0d45so5042953a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 04:49:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVd7rniDqrSZ40skESEVKOSqkQo5YWNnyeZOyL778ZyZID6QsCESEE3sW9ghOGgfhNYtmM0/4KAB7nky7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/wSCdKaNCYd503zr7S+P3/vi0T3rTd6Iw2QiqXMRT2ug+Iw9d
	/pHhlsr9ADflfOSMhPJK/sijTLezTElhEBmHbP8XSHsF9bXMMR1cdwv9mhjPt4okaDDGmyfCwle
	3VTL1XAXrsnepMcJ3GqWBtU2dnLU=
X-Google-Smtp-Source: AGHT+IE3Ql6yANc2m9iOBtynT86gMk4gS0j0goAd+difa6EqQgJSzh4L8cPu2UMNgIXPxrQZjWidJElJdZuBPwuTS1Q=
X-Received: by 2002:a05:6402:3209:b0:5d3:fb9d:3f69 with SMTP id
 4fb4d7f45d1cf-5d3fb9d429bmr1205972a12.21.1733662198314; Sun, 08 Dec 2024
 04:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127091036.444330-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241127091036.444330-2-u.kleine-koenig@baylibre.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sun, 8 Dec 2024 21:49:16 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3Lv1Cn7dNgA7GL6f4OW=ENXS9mG+p03NAUbbNMg05DtQ@mail.gmail.com>
Message-ID: <CAGTfZH3Lv1Cn7dNgA7GL6f4OW=ENXS9mG+p03NAUbbNMg05DtQ@mail.gmail.com>
Subject: Re: [PATCH] extcon: Switch back to struct platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 6:30=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> From: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
>
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
>
> Convert all platform drivers below drivers/extcon to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
>
> En passant make the alignment of the struct initializer in
> extcon-usbc-cros-ec.c consistent.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>
> given the simplicity of the individual changes I do this all in a single
> patch. I you don't agree, please tell and I will happily split it.
>
> It's based on today's next, feel free to drop changes that result in a
> conflict when you come around to apply this. I'll care for the fallout
> at a later time then. (Having said that, if you use b4 am -3 and git am
> -3, there should be hardly any conflict.)
>
> Best regards
> Uwe
>
>  drivers/extcon/extcon-adc-jack.c     | 2 +-
>  drivers/extcon/extcon-intel-cht-wc.c | 2 +-
>  drivers/extcon/extcon-intel-mrfld.c  | 2 +-
>  drivers/extcon/extcon-max3355.c      | 2 +-
>  drivers/extcon/extcon-max77843.c     | 2 +-
>  drivers/extcon/extcon-rtk-type-c.c   | 2 +-
>  drivers/extcon/extcon-usb-gpio.c     | 2 +-
>  drivers/extcon/extcon-usbc-cros-ec.c | 6 +++---
>  8 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc=
-jack.c
> index 125016da7fde..46c40d85c2ac 100644
> --- a/drivers/extcon/extcon-adc-jack.c
> +++ b/drivers/extcon/extcon-adc-jack.c
> @@ -196,7 +196,7 @@ static SIMPLE_DEV_PM_OPS(adc_jack_pm_ops,
>
>  static struct platform_driver adc_jack_driver =3D {
>         .probe          =3D adc_jack_probe,
> -       .remove_new     =3D adc_jack_remove,
> +       .remove         =3D adc_jack_remove,
>         .driver         =3D {
>                 .name   =3D "adc-jack",
>                 .pm =3D &adc_jack_pm_ops,
> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon=
-intel-cht-wc.c
> index 93552dc3c895..8131a3d7d562 100644
> --- a/drivers/extcon/extcon-intel-cht-wc.c
> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> @@ -627,7 +627,7 @@ MODULE_DEVICE_TABLE(platform, cht_wc_extcon_table);
>
>  static struct platform_driver cht_wc_extcon_driver =3D {
>         .probe =3D cht_wc_extcon_probe,
> -       .remove_new =3D cht_wc_extcon_remove,
> +       .remove =3D cht_wc_extcon_remove,
>         .id_table =3D cht_wc_extcon_table,
>         .driver =3D {
>                 .name =3D "cht_wcove_pwrsrc",
> diff --git a/drivers/extcon/extcon-intel-mrfld.c b/drivers/extcon/extcon-=
intel-mrfld.c
> index a1f737f13d49..9219f4328d70 100644
> --- a/drivers/extcon/extcon-intel-mrfld.c
> +++ b/drivers/extcon/extcon-intel-mrfld.c
> @@ -275,7 +275,7 @@ static struct platform_driver mrfld_extcon_driver =3D=
 {
>                 .name   =3D "mrfld_bcove_pwrsrc",
>         },
>         .probe          =3D mrfld_extcon_probe,
> -       .remove_new     =3D mrfld_extcon_remove,
> +       .remove         =3D mrfld_extcon_remove,
>         .id_table       =3D mrfld_extcon_id_table,
>  };
>  module_platform_driver(mrfld_extcon_driver);
> diff --git a/drivers/extcon/extcon-max3355.c b/drivers/extcon/extcon-max3=
355.c
> index e62ce7a8d131..b2ee4ff8b04d 100644
> --- a/drivers/extcon/extcon-max3355.c
> +++ b/drivers/extcon/extcon-max3355.c
> @@ -127,7 +127,7 @@ MODULE_DEVICE_TABLE(of, max3355_match_table);
>
>  static struct platform_driver max3355_driver =3D {
>         .probe          =3D max3355_probe,
> -       .remove_new     =3D max3355_remove,
> +       .remove         =3D max3355_remove,
>         .driver         =3D {
>                 .name   =3D "extcon-max3355",
>                 .of_match_table =3D max3355_match_table,
> diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max=
77843.c
> index 9849e3b8327e..2ae9f7f1a67f 100644
> --- a/drivers/extcon/extcon-max77843.c
> +++ b/drivers/extcon/extcon-max77843.c
> @@ -956,7 +956,7 @@ static struct platform_driver max77843_muic_driver =
=3D {
>                 .of_match_table =3D of_max77843_muic_dt_match,
>         },
>         .probe          =3D max77843_muic_probe,
> -       .remove_new     =3D max77843_muic_remove,
> +       .remove         =3D max77843_muic_remove,
>         .id_table       =3D max77843_muic_id,
>  };
>
> diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-r=
tk-type-c.c
> index 19a01e663733..bdc2b7b3a246 100644
> --- a/drivers/extcon/extcon-rtk-type-c.c
> +++ b/drivers/extcon/extcon-rtk-type-c.c
> @@ -1778,7 +1778,7 @@ static const struct dev_pm_ops extcon_rtk_type_c_pm=
_ops =3D {
>
>  static struct platform_driver extcon_rtk_type_c_driver =3D {
>         .probe          =3D extcon_rtk_type_c_probe,
> -       .remove_new     =3D extcon_rtk_type_c_remove,
> +       .remove         =3D extcon_rtk_type_c_remove,
>         .driver         =3D {
>                 .name   =3D "extcon-rtk-type_c",
>                 .of_match_table =3D extcon_rtk_type_c_match,
> diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb=
-gpio.c
> index 9b61eb99b7dc..5e8ad21ad206 100644
> --- a/drivers/extcon/extcon-usb-gpio.c
> +++ b/drivers/extcon/extcon-usb-gpio.c
> @@ -279,7 +279,7 @@ MODULE_DEVICE_TABLE(platform, usb_extcon_platform_ids=
);
>
>  static struct platform_driver usb_extcon_driver =3D {
>         .probe          =3D usb_extcon_probe,
> -       .remove_new     =3D usb_extcon_remove,
> +       .remove         =3D usb_extcon_remove,
>         .driver         =3D {
>                 .name   =3D "extcon-usb-gpio",
>                 .pm     =3D &usb_extcon_pm_ops,
> diff --git a/drivers/extcon/extcon-usbc-cros-ec.c b/drivers/extcon/extcon=
-usbc-cros-ec.c
> index 805a47230689..529ac5898e38 100644
> --- a/drivers/extcon/extcon-usbc-cros-ec.c
> +++ b/drivers/extcon/extcon-usbc-cros-ec.c
> @@ -525,12 +525,12 @@ MODULE_DEVICE_TABLE(of, extcon_cros_ec_of_match);
>
>  static struct platform_driver extcon_cros_ec_driver =3D {
>         .driver =3D {
> -               .name  =3D "extcon-usbc-cros-ec",
> +               .name =3D "extcon-usbc-cros-ec",

If there is  no change, this line is changed.
Please don't touch this line.

>                 .of_match_table =3D of_match_ptr(extcon_cros_ec_of_match)=
,
>                 .pm =3D DEV_PM_OPS,
>         },
> -       .remove_new =3D extcon_cros_ec_remove,
> -       .probe   =3D extcon_cros_ec_probe,
> +       .remove =3D extcon_cros_ec_remove,
> +       .probe =3D extcon_cros_ec_probe,

If there is  no change on probe, this line is changed.
Please don't touch this line.

(snip)

If you fix the above comment, it looks good to me.

Best Regards,
Chanwoo Choi
Samsung Electronics

