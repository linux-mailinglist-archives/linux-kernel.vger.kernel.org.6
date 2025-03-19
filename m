Return-Path: <linux-kernel+bounces-567295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E401BA68446
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180AC42518F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 04:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16C524E4DA;
	Wed, 19 Mar 2025 04:45:08 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B79C20F075
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742359508; cv=none; b=bqFRB5DMgD3N8vULSLx85JGYSdpLobTF+370Ij7UqE7OgjlHS4J+SF7SAPGpVL2MOfsr2z58TF7aI5s9ugqfD+G+hNUdOSqr6KT0tj6O3UggJk4gNeSIWmJYWTOOCVpB4oLoAzsgbNcijPxnIdealbLD643xi3KkuYxgXmuVm4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742359508; c=relaxed/simple;
	bh=B36dPMNxF0hv/qEcsbl1LpG+8jCGQTKvIwQB64AkVzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8BSokIACakUSD/fjuWokx/VfRnpfCuqAYUUdH0hwFHXT0KzxfSrNU8RNRnP6Gvkr6n+oIujiB06xVu7fXI2v9EZwd4vpK7Ld06XFa8d6WJCjEuX5CN9CxFj0zyAtj1xHC1TUeJBEDmxZ3LCoV203Y3M0lA1BULex/iSTdZUrqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bfca745c7so65440021fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742359502; x=1742964302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jjd0eXrU4BczBvsJPDTEC6i8/DIpoc8+bHaWB53FwME=;
        b=UydVraUOslZWV2ae6i9x+C2pQ5jqjKmm1CK75vQ2oosuO5e3VI+1vZD4TMnpFIvwzN
         YLLuVeLN4UtMC+zIB+DUP9UuD3pHPJwzMlAgs/UxIeVzMydTIebYrTKV5tn3uD0JRJUL
         I/EYPtf2l5rYBOwV/D1++pGLqYo13VNKX9NX5umY1iviKxJRLUdeLcBnV3nd2Im6ewBD
         oiZYzAqOGb4ta2qzo7Nj82Uo9kJUNYm8P56MPHZvGiYhSLZjDPfVqmnM/3kEdXEoLf8h
         fL8FJjYq84EuIkuWT7MYcwJo3uvgtNEB3qBoc8sRfxmQq0G2qoKk8nPn7E4uTaq5chlQ
         v12w==
X-Forwarded-Encrypted: i=1; AJvYcCVfmzRa4JzWTurPC81kPzb1ZAx7LxCWkA/ysMPjEFYsFSpO7jZM/8KxHp+pC+yC40GEm55pAUQ0WeByvHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN7KUo/KoFa/NSaXv0brac7wB8Midgjsdd0oQPJ0GAUWpk5tFj
	zAFXLFy0sG82GnLAtzirUWnA9zPwn/KCFEfEwkL72pG69gmelnzIYht6Zbg9
X-Gm-Gg: ASbGncuBMI0KRy9f3w0ZwANV+gjXj/7XyRQHfZCkFMl510jM/erbG8vozHv356VQlkE
	Cf0bNzovM0/nM63kT7Kt7KXXyQDy5vdULNrp09JtUmdTUxuskBMYSFta2VK5ipG8YKMk2lgqgOI
	Ztr2Lz/dUtt/W4f+FHP6huCrc2FUfz2DSCQLr0iVWyxuh37qH/XHEmZNWzO6MNpkYa+brHGWOBw
	p7INHkCGAUcu6W5ZYM1/4uuXznytEDHdCBHfwmf5PPo+ZMoksr3UQyht01ZhEtRTjQVDR0BGKEg
	wLPq1rFLB1h/WIZa2+/v2eWaAymE/Nb05nxY+9BkPCUjE5Vn29WJ36Wj3RDb+bwYIskAmWA8wcf
	cRw==
X-Google-Smtp-Source: AGHT+IGzOAebkKra9pD3ng1K/Z6LdcjEADFRGyiJZi/WMDzFfVrZ9baBWXEft1MdMATGt/NObPWHWg==
X-Received: by 2002:a2e:bc1b:0:b0:30b:b987:b6a7 with SMTP id 38308e7fff4ca-30d6a1dac61mr5262261fa.0.1742359501696;
        Tue, 18 Mar 2025 21:45:01 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1da6desm21982971fa.94.2025.03.18.21.44.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 21:44:59 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bfca745c7so65439621fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:44:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/rsXoGMtctgI+IuGLWX70jzGeBfeW0pt6pKzbC87yJ9JRNREVaa5gplYrksLpbGi4lJk0NvgjPlDwMjw=@vger.kernel.org
X-Received: by 2002:a2e:868d:0:b0:30b:efa5:69c3 with SMTP id
 38308e7fff4ca-30d6a43ddc1mr4049431fa.22.1742359499504; Tue, 18 Mar 2025
 21:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318205147.42850-1-simons.philippe@gmail.com>
In-Reply-To: <20250318205147.42850-1-simons.philippe@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 19 Mar 2025 12:44:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v65nJySARZJomSrfpiy1rQiETNUGWF1h6PDft=0Gru37SA@mail.gmail.com>
X-Gm-Features: AQ5f1JoMJGMRq0yOio2oCIyxLrpG84wFLT0_fcU1wIYnlgGEJWVSpPPLN5n4yck
Message-ID: <CAGb2v65nJySARZJomSrfpiy1rQiETNUGWF1h6PDft=0Gru37SA@mail.gmail.com>
Subject: Re: [PATCH] regulator: axp20x: AXP717: dcdc4 doesn't have delay
To: Philippe Simons <simons.philippe@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 4:51=E2=80=AFAM Philippe Simons
<simons.philippe@gmail.com> wrote:
>
> According to AXP717 user manual, DCDC4 doesn't have a ramp delay like
> DCDC1/2/3 do.
>
> Remove it from the description and cleanup the macros.
>
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  drivers/regulator/axp20x-regulator.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp=
20x-regulator.c
> index dca99cfb7cbb..da891415efc0 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -371,8 +371,8 @@
>                 .ops            =3D &axp20x_ops,                         =
         \
>         }
>
> -#define AXP_DESC_DELAY(_family, _id, _match, _supply, _min, _max, _step,=
 _vreg,        \
> -                _vmask, _ereg, _emask, _ramp_delay)                     =
       \
> +#define AXP_DESC(_family, _id, _match, _supply, _min, _max, _step, _vreg=
,      \
> +                _vmask, _ereg, _emask)                                  =
       \
>         [_family##_##_id] =3D {                                          =
         \
>                 .name           =3D (_match),                            =
         \
>                 .supply_name    =3D (_supply),                           =
         \
> @@ -388,15 +388,9 @@
>                 .vsel_mask      =3D (_vmask),                            =
         \
>                 .enable_reg     =3D (_ereg),                             =
         \
>                 .enable_mask    =3D (_emask),                            =
         \
> -               .ramp_delay =3D (_ramp_delay),                           =
         \
>                 .ops            =3D &axp20x_ops,                         =
         \
>         }
>
> -#define AXP_DESC(_family, _id, _match, _supply, _min, _max, _step, _vreg=
,      \
> -                _vmask, _ereg, _emask)                                  =
       \
> -       AXP_DESC_DELAY(_family, _id, _match, _supply, _min, _max, _step, =
_vreg, \
> -                _vmask, _ereg, _emask, 0)
> -
>  #define AXP_DESC_SW(_family, _id, _match, _supply, _ereg, _emask)       =
       \
>         [_family##_##_id] =3D {                                          =
         \
>                 .name           =3D (_match),                            =
         \
> @@ -805,9 +799,9 @@ static const struct regulator_desc axp717_regulators[=
] =3D {
>                         axp717_dcdc3_ranges, AXP717_DCDC3_NUM_VOLTAGES,
>                         AXP717_DCDC3_CONTROL, AXP717_DCDC_V_OUT_MASK,
>                         AXP717_DCDC_OUTPUT_CONTROL, BIT(2), 640),
> -       AXP_DESC_DELAY(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
> +       AXP_DESC(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
>                  AXP717_DCDC4_CONTROL, AXP717_DCDC_V_OUT_MASK,
> -                AXP717_DCDC_OUTPUT_CONTROL, BIT(3), 6400),
> +                AXP717_DCDC_OUTPUT_CONTROL, BIT(3)),
>         AXP_DESC(AXP717, ALDO1, "aldo1", "aldoin", 500, 3500, 100,
>                  AXP717_ALDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
>                  AXP717_LDO0_OUTPUT_CONTROL, BIT(0)),
> --
> 2.48.1
>

