Return-Path: <linux-kernel+bounces-356932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091359968E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904CD1F25D7B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE11D191461;
	Wed,  9 Oct 2024 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EM+vqAJT"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA8E18FDAF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728473700; cv=none; b=JB+PA85KWPzV9icByEI7LLxHmsY2NtGi4QP2ezBQb16E+caZM6TGhAa6W6mrBT6r6k6yUrQ/A4C8hCCnnWyup6U2vlI36iDAF+SYKNKP8FFgUBNEFUJIcdhbopZL/9j3csdiSqCi4ri4soQ00KPs4a+tRm3e9o1k03/5mXXUlm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728473700; c=relaxed/simple;
	bh=4fqO8u7cvvSjeL3zuv6zSEcb+7CKfth8WfC3w9lp3bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7hO6qP4uRJxVRkwbc2NGOIZ2vYot0VEl83vBmRRDpVroPsRzvCNPoV04FBzFoUnlz+58Nuv+1sc7m/bLWBGHAmZvLOEzdmYWUqCgxCnJirOt4EiFmFEvLOEJLhN2wFgiT3NwVwOix85NI2pNmma0SRsrUSOuQlnbEgh4CSma3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EM+vqAJT; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso94461291fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 04:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728473696; x=1729078496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IqieDyDw5XZkcW+vd3y/Zt0xQWIhvfr757jNg6MYJU=;
        b=EM+vqAJTPVWLztfNxtvq68UX1g7tvAf+KN4tfhVh3PxWADgz89ReZSdtoaQ/YFUSAJ
         aGWhcvCeWY3ACFv1cliX9p6LqUYUJJu1NdJUMnd2Z5gd61WvNAdnch70/H9x6WiWXVVJ
         WBN6Ott8DYleCeJgKIBdf08EeLTz3muFA0B7o8b5O7Qpa9AhfGDCIql2H0YLb2riVhl2
         FZknkG5IcJpbQNaNgrICwGYqe1gURANMU1SJ/9nlqyNnxqFiQ8vilu7ePwLZr862pHO7
         T5yHtIK+nTj5Ccq1WWWgJFBs9D8T+GFP9XWfy8DVjfCxOQvyRgNP1imz7REsTNr+BD2V
         r/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728473696; x=1729078496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IqieDyDw5XZkcW+vd3y/Zt0xQWIhvfr757jNg6MYJU=;
        b=aeOstZrzBzN103opU16axSgpCd9MaVBX3twiKEO8sMTbYa6FHEpbYnHQ4JLiGpWVVy
         EBCSY65Sr713wf8NvtMO63ZcfkLclGLx/F+la7impklHetoTl6iDp6HKiW5DyD+s86hC
         6vFCZesQafqbsqXC/WigLxz/Zvk5+mRK9U/eA3HPsfyirEuUMf1D/w3i80nkM5I5tKui
         ThRmG0w85jLEBNeZpz/l4FCahQqwyVzHH4yEbRUaiNAwc3t3/0dkYQGRQBm8r/7kKfaI
         gonXwNxVBmsoca3dlLEU8Yl8q1SHG6x7Y2uxv5JIPlyrAtje1wRyMMnLfAMX2blt+FAr
         /MjA==
X-Forwarded-Encrypted: i=1; AJvYcCXor9+f995JAhThN5goZnAJ57KVKRrqlUwXn3r3qN7zwJquKY53mSNdTVgo8EuYE52CKISNbxEttBGH6EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC0qYitFtqpyYGZ2aLcwd9PfVGeDMEmRn00cLPE608ZOXlQm1I
	UXh4y8qez8cGSDLqdPMaQeLvoZrWxCsbzASOPea82u9iuLts1rR9QpRlBiz6leeE4txLFmxWNJu
	TTYDrekODJzK2pE/u5rx3x38oe9kJobDQEjrfAA==
X-Google-Smtp-Source: AGHT+IGaLdBAhONdnkFtECR5ohDtwnSqH60carMI5sSUmJWKPTVxiJxryZWYW8zREuu9kR4ZNudLqCWseYjgWxZTtFU=
X-Received: by 2002:a2e:610a:0:b0:2fa:cdac:8732 with SMTP id
 38308e7fff4ca-2fb187ca702mr16902571fa.30.1728473696034; Wed, 09 Oct 2024
 04:34:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-mbly-i2c-v2-0-ac9230a8dac5@bootlin.com> <20241009-mbly-i2c-v2-5-ac9230a8dac5@bootlin.com>
In-Reply-To: <20241009-mbly-i2c-v2-5-ac9230a8dac5@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Oct 2024 13:34:45 +0200
Message-ID: <CACRpkdZyyFR1niN+w_t43uE0XASKMzkUHGHuHWdj_VXCKLTR-g@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] i2c: nomadik: fix BRCR computation
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	=?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Theo,

thanks for your patch!

On Wed, Oct 9, 2024 at 12:23=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Current BRCR computation is:
>
>     brcr =3D floor(i2cclk / (clkfreq * div))
>
> With brcr: "baud rate counter", an internal clock divider,
>  and i2cclk: input clock rate (24MHz, 38.4MHz or 48MHz),
>  and clkfreq: desired bus rate,
>  and div: speed-mode dependent divider (2 for standard, 3 otherwise).
>
> Assume i2cclk=3D48MHz, clkfreq=3D3.4MHz, div=3D3,
>   then brcr =3D floor(48MHz / (3.4MHz * 3)) =3D 4
>    and resulting bus rate =3D 48MHz / (4 * 3) =3D 4MHz
>
> Assume i2cclk=3D38.4MHz, clkfreq=3D1.0MHz, div=3D3,
>   then brcr =3D floor(38.4MHz / (1.0MHz * 3)) =3D 12
>    and resulting bus rate =3D 38.4MHz / (12 * 3) =3D 1066kHz
>
> The current computation means we always pick the smallest divider that
> gives a bus rate above target. We should instead pick the largest
> divider that gives a bus rate below target, using:
>
>     brcr =3D floor(i2cclk / (clkfreq * div)) + 1
>
> If we redo the above examples:
>
> Assume i2cclk=3D48MHz, clkfreq=3D3.4MHz, div=3D3,
>   then brcr =3D floor(48MHz / (3.4MHz * 3)) + 1 =3D 5
>    and resulting bus rate =3D 48MHz / (5 * 3) =3D 3.2MHz
>
> Assume i2cclk=3D38.4MHz, clkfreq=3D1.0MHz, div=3D3,
>   then brcr =3D floor(38.4MHz / (1.0MHz * 3)) + 1 =3D 13
>    and resulting bus rate =3D 38.4MHz / (13 * 3) =3D 985kHz
>
> This is much less of an issue with slower bus rates (ie those currently
> supported), because the gap from one divider to the next is much
> smaller. It however keeps us from always using bus rates superior to
> the target.
>
> This fix is required for later on supporting faster bus rates:
> I2C_FREQ_MODE_FAST_PLUS (1MHz) and I2C_FREQ_MODE_HIGH_SPEED (3.4MHz).
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/i2c/busses/i2c-nomadik.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-no=
madik.c
> index 8f52ae4d6285af2dd2b3dc7070672757e831a019..b2b9da0b32ed903c080f4bdc4=
27ea0dd7b031b49 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -454,9 +454,12 @@ static void setup_i2c_controller(struct nmk_i2c_dev =
*priv)
>          * operation, and the other is for std, fast mode, fast mode
>          * plus operation. Currently we do not supprt high speed mode
>          * so set brcr1 to 0.
> +        *
> +        * BRCR is a clock divider amount. Pick highest value that
> +        * leads to rate strictly below target.
>          */

You could push in some more details from the commit message here so it's no=
t
so terse.

>         brcr1 =3D FIELD_PREP(I2C_BRCR_BRCNT1, 0);
> -       brcr2 =3D FIELD_PREP(I2C_BRCR_BRCNT2, i2c_clk / (priv->clk_freq *=
 div));
> +       brcr2 =3D FIELD_PREP(I2C_BRCR_BRCNT2, i2c_clk / (priv->clk_freq *=
 div) + 1);

Doesn't the last part correspond to something like
#include <linux/math.h>
u64 scaler =3D DIV_ROUND_DOWN_ULL(i2c_clk, (priv->clk_freq * div));
brcr2 =3D FIELD_PREP(I2C_BRCR_BRCNT2, (u32)scaler);

Certianly one of the in-kernel division helpers like DIV_ROUND_DOWN
round_up() etc are better to use IMO, but I might not be understanding the
fine details of the math here.

Yours,
Linus Walleij

