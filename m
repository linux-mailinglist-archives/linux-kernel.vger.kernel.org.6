Return-Path: <linux-kernel+bounces-436402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E771E9E857A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 14:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABD52811CE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 13:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6417114885B;
	Sun,  8 Dec 2024 13:32:44 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A9122C6C5
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733664763; cv=none; b=smyPII+4UXJfecsgg6f+xem1SrP4tVkPt5aMfmEosqJ6aIEcH9QP86mXrgXs6CAmGCyKvUcKwG3Z9wZpKWJLnCUI+ucsWbC2dx7TAAtfICgI2lup+fPurps58GBI5r4XyMTaV0r5NH7AA3+8lC/Gx3zF2OhzQUs9JeEDuocM+ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733664763; c=relaxed/simple;
	bh=AL4y6UI8DCEl681xWhtSIL+b3OTeNNOeR9o8zd17Lrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WaapiEmEadHyf6odHfVJZGuj5/UVTghxkqtpEqRSbCFDLWE4hdB6t2uWt6M+7A9KCBaeDPNfqs+/HNbgPYUTsaEAZI6+MCSTcukF9JKt0yNJBZWJMkBzB7+6wPipnp1fVDJtye6GqA3hvW0/zrM7LXe4nRSpGxGCD19VT7NxiDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53df80eeeedso3492553e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 05:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733664758; x=1734269558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFkeEKqBBHCcWonJL8Ne+TZTQzqLuCgCMRmmgPcaAiY=;
        b=fjyNCDzot7MuB7STTsD3K7tl7nbnoh77xfcjHJkVz2M4q3ZRIaxLmhW2ZXfUrzWF+0
         nGUiPn7bbWxmBS1KTkPiC5EPMWWul1ETspwYEC97XrCLuYdQpgaBSpVS3TdcqGi3lCuu
         wi37QJux0N5+1KqMufuTV5cfsc6n4mjwK6bq+KZ6H0DBCw9XrlVoDs5RF/rcjanPyGqP
         d+dKyPhjOGb09LWDXz3SP4Us1MM9hgliX2Mt1xNWPRXyTgYO27zZ9Kt24vG5YKu2cLaO
         AG1EU25+R9R4vbQPBOKtlFKfbokWQ49msN0+/ytS52NL+bJQS3Rb7UB9vJTgaVtxQ3KE
         CxWA==
X-Forwarded-Encrypted: i=1; AJvYcCVqyAdvk5EDv+l/a3Fpqx23sxWX5eHt/3QcJnc0lXAcpLJn0kFdx1oClhU732ONY+Zu2bwo6paCHS/0/tI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6IKKpiE+dC235LtbYEHi5wNQx/uk3hdP06xA6ec/n1/Yi+FjW
	13HvWuE31dWpTSI+s6orJSaGjdVdtGdtpgGBxjHKsVXGTUwGd6ymUUuMwoRx
X-Gm-Gg: ASbGncuMGtr4r6zGYiHVTJC9F4fPrdKf9w5t6nQ3I/hNcOq6BOrbRd9shMLv7KN1RsK
	mNwAqlh0KyQqbFkUjo5uV0gpZdbs+OhE/2+FJbayDhD/P/2SLMKXRqgCia1IJsvk3/fCrzWYeXo
	OD86+MtCqzPNJNO7TdnnNtK2mIQgw9TVSzDYCsBe3p9jnLQUKLb8CpWC9IUWxlvHE9b7sxCx9TO
	cX/WydGJoF5402fuZIEZyNaD+bt2MyuABipt8fodiJcCTvskdkDxFcpuTpR/v8AOVba7iasTsqF
	MW733YY=
X-Google-Smtp-Source: AGHT+IGdG4apVFXlZsZLOGd5sMcAe8QDQfMV57+uFVsdzNrG/uvUooZNB1CGDs/3AOeyvjNL3XH/yA==
X-Received: by 2002:a05:6512:118a:b0:53e:27d4:b913 with SMTP id 2adb3069b0e04-53e2c2edef5mr3162865e87.54.1733664757982;
        Sun, 08 Dec 2024 05:32:37 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e39f595a1sm565434e87.80.2024.12.08.05.32.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 05:32:37 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-300392cc4caso17112301fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 05:32:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcDdSpuazKw4bTXEH9mgg6hnWUB0eGpYSTheyaN4kQrd3ckEHxSn1KMuj9L9OaKd79OALR4RfNW94tv64=@vger.kernel.org
X-Received: by 2002:a2e:a550:0:b0:302:1d8e:f4f3 with SMTP id
 38308e7fff4ca-3021d8efa1amr6772271fa.8.1733664756849; Sun, 08 Dec 2024
 05:32:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241208124308.5630-1-simons.philippe@gmail.com>
In-Reply-To: <20241208124308.5630-1-simons.philippe@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 8 Dec 2024 21:32:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v64AkoWVuAzBnMx7MHNipjYJpg1RiED=z7neEGUvdjyB2g@mail.gmail.com>
Message-ID: <CAGb2v64AkoWVuAzBnMx7MHNipjYJpg1RiED=z7neEGUvdjyB2g@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: axp20x: AXP717: set ramp_delay
To: Philippe Simons <simons.philippe@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" <linux-kernel@vger.kernel.org>, Hironori KIKUCHI <kikuchan98@gmail.com>, 
	Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 8:43=E2=80=AFPM Philippe Simons
<simons.philippe@gmail.com> wrote:
>
> AXP717 datasheet says that regulator ramp delay is 15.625 us/step,
> which is 10mV in our case.
>
> Add a AXP_DESC_RANGES_DELAY macro and update AXP_DESC_RANGES macro to
> expand to AXP_DESC_RANGES_DELAY with ramp_delay =3D 0
>
> For DCDC4, steps is 100mv
>
> Add a AXP_DESC_DELAY macro and update AXP_DESC macro to
> expand to AXP_DESC_DELAY with ramp_delay =3D 0
>
> This patch fix crashes when using CPU DVFS.
>
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
> Tested-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> Tested-by: Chris Morgan <macromorgan@hotmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

The following tags should also be added:

Fixes: d2ac3df75c3a ("regulator: axp20x: add support for the AXP717")
Cc: <stable@vger.kernel.org> # v6.10+

You probably don't need to send a new version just to add them. The scripts
used by maintainers should be able to pick them up together.


> ---
> Changes in v2:
> - set ramp_delay for AXP717 DCDC4
> - Link to v1: https://lore.kernel.org/all/20241206123751.981977-1-simons.=
philippe@gmail.com/
> ---
>  drivers/regulator/axp20x-regulator.c | 36 ++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp=
20x-regulator.c
> index a8e91d9d0..945d2917b 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -371,8 +371,8 @@
>                 .ops            =3D &axp20x_ops,                         =
         \
>         }
>
> -#define AXP_DESC(_family, _id, _match, _supply, _min, _max, _step, _vreg=
,      \
> -                _vmask, _ereg, _emask)                                  =
       \
> +#define AXP_DESC_DELAY(_family, _id, _match, _supply, _min, _max, _step,=
 _vreg,        \
> +                _vmask, _ereg, _emask, _ramp_delay)                     =
       \
>         [_family##_##_id] =3D {                                          =
         \
>                 .name           =3D (_match),                            =
         \
>                 .supply_name    =3D (_supply),                           =
         \
> @@ -388,9 +388,15 @@
>                 .vsel_mask      =3D (_vmask),                            =
         \
>                 .enable_reg     =3D (_ereg),                             =
         \
>                 .enable_mask    =3D (_emask),                            =
         \
> +               .ramp_delay =3D (_ramp_delay),                           =
         \
>                 .ops            =3D &axp20x_ops,                         =
         \
>         }
>
> +#define AXP_DESC(_family, _id, _match, _supply, _min, _max, _step, _vreg=
,      \
> +                _vmask, _ereg, _emask)                                  =
       \
> +       AXP_DESC_DELAY(_family, _id, _match, _supply, _min, _max, _step, =
_vreg, \
> +                _vmask, _ereg, _emask, 0)
> +
>  #define AXP_DESC_SW(_family, _id, _match, _supply, _ereg, _emask)       =
       \
>         [_family##_##_id] =3D {                                          =
         \
>                 .name           =3D (_match),                            =
         \
> @@ -419,8 +425,8 @@
>                 .ops            =3D &axp20x_ops_fixed                    =
         \
>         }
>
> -#define AXP_DESC_RANGES(_family, _id, _match, _supply, _ranges, _n_volta=
ges,   \
> -                       _vreg, _vmask, _ereg, _emask)                    =
       \
> +#define AXP_DESC_RANGES_DELAY(_family, _id, _match, _supply, _ranges, _n=
_voltages,     \
> +                       _vreg, _vmask, _ereg, _emask, _ramp_delay)      \
>         [_family##_##_id] =3D {                                          =
         \
>                 .name           =3D (_match),                            =
         \
>                 .supply_name    =3D (_supply),                           =
         \
> @@ -436,9 +442,15 @@
>                 .enable_mask    =3D (_emask),                            =
         \
>                 .linear_ranges  =3D (_ranges),                           =
         \
>                 .n_linear_ranges =3D ARRAY_SIZE(_ranges),                =
         \
> +               .ramp_delay =3D (_ramp_delay),                           =
         \
>                 .ops            =3D &axp20x_ops_range,                   =
         \
>         }
>
> +#define AXP_DESC_RANGES(_family, _id, _match, _supply, _ranges, _n_volta=
ges,   \
> +                       _vreg, _vmask, _ereg, _emask)                    =
       \
> +       AXP_DESC_RANGES_DELAY(_family, _id, _match, _supply, _ranges,    =
       \
> +                _n_voltages, _vreg, _vmask, _ereg, _emask, 0)
> +
>  static const int axp209_dcdc2_ldo3_slew_rates[] =3D {
>         1600,
>          800,
> @@ -781,21 +793,21 @@ static const struct linear_range axp717_dcdc3_range=
s[] =3D {
>  };
>
>  static const struct regulator_desc axp717_regulators[] =3D {
> -       AXP_DESC_RANGES(AXP717, DCDC1, "dcdc1", "vin1",
> +       AXP_DESC_RANGES_DELAY(AXP717, DCDC1, "dcdc1", "vin1",
>                         axp717_dcdc1_ranges, AXP717_DCDC1_NUM_VOLTAGES,
>                         AXP717_DCDC1_CONTROL, AXP717_DCDC_V_OUT_MASK,
> -                       AXP717_DCDC_OUTPUT_CONTROL, BIT(0)),
> -       AXP_DESC_RANGES(AXP717, DCDC2, "dcdc2", "vin2",
> +                       AXP717_DCDC_OUTPUT_CONTROL, BIT(0), 640),
> +       AXP_DESC_RANGES_DELAY(AXP717, DCDC2, "dcdc2", "vin2",
>                         axp717_dcdc2_ranges, AXP717_DCDC2_NUM_VOLTAGES,
>                         AXP717_DCDC2_CONTROL, AXP717_DCDC_V_OUT_MASK,
> -                       AXP717_DCDC_OUTPUT_CONTROL, BIT(1)),
> -       AXP_DESC_RANGES(AXP717, DCDC3, "dcdc3", "vin3",
> +                       AXP717_DCDC_OUTPUT_CONTROL, BIT(1), 640),
> +       AXP_DESC_RANGES_DELAY(AXP717, DCDC3, "dcdc3", "vin3",
>                         axp717_dcdc3_ranges, AXP717_DCDC3_NUM_VOLTAGES,
>                         AXP717_DCDC3_CONTROL, AXP717_DCDC_V_OUT_MASK,
> -                       AXP717_DCDC_OUTPUT_CONTROL, BIT(2)),
> -       AXP_DESC(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
> +                       AXP717_DCDC_OUTPUT_CONTROL, BIT(2), 640),
> +       AXP_DESC_DELAY(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
>                  AXP717_DCDC4_CONTROL, AXP717_DCDC_V_OUT_MASK,
> -                AXP717_DCDC_OUTPUT_CONTROL, BIT(3)),
> +                AXP717_DCDC_OUTPUT_CONTROL, BIT(3), 6400),
>         AXP_DESC(AXP717, ALDO1, "aldo1", "aldoin", 500, 3500, 100,
>                  AXP717_ALDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
>                  AXP717_LDO0_OUTPUT_CONTROL, BIT(0)),
> --
> 2.47.1
>

