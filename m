Return-Path: <linux-kernel+bounces-246148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4627492BE30
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC02CB21244
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD5E19DF46;
	Tue,  9 Jul 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EkV/fz5J"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863B319D07F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538533; cv=none; b=PhUruqO1dSOsxxUy4XdscmIqBGZn8FGAv5KH3pAy4yx0YaLXf3idkPNo6dWrSBwtm1sN1UNsIANsVhtzqZaXC6rHjVilabKQiCmDrU2qghqIk5fhwz/Yu5F6BuWdBamta+zKlw08op63aL2JWEynVufB/XsUE7MavrNfTWiADAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538533; c=relaxed/simple;
	bh=JWAQLFqZkuWOfZpZyTRyc8jygVtPln2o1M5TZCpyi7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNyzH0IPcpKY66M1MiJ53rsNCAzsLjtZx6rGcb+eco1hHIbcJ+iOKZAiIEoxRkhb5PWEBd8OG98TNIjElRFc75cQbSfEMBWnmyz5tyggOfFYrrGZTt4AIqhY0N7yy+0ousuhmdWD7O54XuSjyU8Do30mZiOUYX/1hAS3Ym8yy5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EkV/fz5J; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-426717a2d12so6760075e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 08:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720538529; x=1721143329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfUB9ZJ69EL9GipUtbkxGBaJaIV82ecNhY+j5SzQ2gM=;
        b=EkV/fz5JvvHmnnNHgq4YBGewGglZkbZNa2fXIL2HdY63vneGnl6IzcUIQrksC9fkk/
         6v3opD75UBPoSNI/KtCHYFOEnw7OgYVBWRREW/oIUtl7vaXPOkkMmG9HZrakDH/E3/wT
         AAv5y0kbebSyBPwOHK3auUFmOBjVElMRxmQ91soA6aOy2DUPXRqvytsQX5MU+1TW6s1D
         ee+F6JjwCPNJlKf4yhsjIkNAGD3mQRc9B/V3TXOGssh95SVNZ1cDJ3rn+/xui/u2Y0kz
         9RD6hXVj8Y3GfLtcRuwI/NQRz+mArYfTC2pAnm41DrP7QwtFEOb6h1OlYfXR4LF6/q50
         TgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720538529; x=1721143329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfUB9ZJ69EL9GipUtbkxGBaJaIV82ecNhY+j5SzQ2gM=;
        b=ChpBL76RSFOfmieJ58p49pCclMupoIoorHN95tso9Y2h6AIqBE5+P5ozLbWUgR0yIK
         WhXY7ez5PqGVGkgQf2iFa2vj4Wx4+mnaPD+QKEyb51nPt9se2WIb7wIgmBltGJPJ4qoo
         RgF7PROR7y/VJV+Kt9+P8gbySFBurnu+QSA1k4vaV4CWhVIUh/qcUayrF9foXUrm8TV1
         s9B+z/qH6z9caJQxNzJskAl9nFNiwH1RhgZS7/BnxDMq23znJGHfOcnhsAdINl6m648c
         x3E6s0tEKEOI9xkoT4Oi4VOmROSl97r0XmMTYnGL4g7BMSuWVTs+FRDzzfrpyDEWtH2w
         ITbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcD2FjV4ZObsfoqA5rrArTUWf2c+l/wx3/+D6DK28PV9yowTrVfsoCtc1oa8fBC3Uf+QP2SABvwSRYlQtAmsFNH9hBz0/+fINKiLkk
X-Gm-Message-State: AOJu0YwZ2/u53TNQXaETLQQ79x+H2L1I9bw5do3s/Mebd+yEB0sN5GKm
	ythxpU3UFWIbjQKbtFw2KbXqk61fsTZouOXlWw1xmsj8TnT66j2uDWFLwYiWUhE=
X-Google-Smtp-Source: AGHT+IFKyuCi8F65Rnjy2ONu9WDc7c8zSBudZGwZQkQFlY9b9EBnNysV/fwsOhCmIH3gVuNNKX3o0A==
X-Received: by 2002:a05:600c:4ba4:b0:424:aa83:ef27 with SMTP id 5b1f17b1804b1-426722c11a1mr22876765e9.1.1720538528867;
        Tue, 09 Jul 2024 08:22:08 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f5f51sm46910255e9.25.2024.07.09.08.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:22:08 -0700 (PDT)
Date: Tue, 9 Jul 2024 17:22:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Nikita Shubin <nikita.shubin@maquefel.me>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>, 
	Hartley Sweeten <hsweeten@visionengravers.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Lukasz Majewski <lukma@denx.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andy@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, 
	Mark Brown <broonie@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Ralf Baechle <ralf@linux-mips.org>, "Wu, Aaron" <Aaron.Wu@analog.com>, Lee Jones <lee@kernel.org>, 
	Olof Johansson <olof@lixom.net>, Niklas Cassel <cassel@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-spi@vger.kernel.org, netdev@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-ide@vger.kernel.org, linux-input@vger.kernel.org, linux-sound@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v10 00/38] ep93xx device tree conversion
Message-ID: <fjbvn3p7nqtvllcohtmcwlyv45blulb47t62gz3xey37wrbie5@ke6xcrfq2ztq>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
 <CAHp75VfSC9gAD9ipeWRPdQOxUp4FXqYYei-cJTs38nbz0cHpkg@mail.gmail.com>
 <48c242838c77034485a9e667dc0e867207c5beed.camel@maquefel.me>
 <241a4cf9830b0118f01e8fcf2853c62527636049.camel@maquefel.me>
 <jyvlqfvqn5bp3jmvxvwyrcqmihjohuq3o757mfph7x37kbwvtq@gtgyh4fca4fq>
 <CAL_Jsq+9Jk90HovH8bwzgCHwwh9j4mBm_Aaiq+EOj1HT3R17_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="piveefpjjxp5n6ob"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+9Jk90HovH8bwzgCHwwh9j4mBm_Aaiq+EOj1HT3R17_Q@mail.gmail.com>


--piveefpjjxp5n6ob
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rob,

On Tue, Jul 09, 2024 at 07:58:42AM -0600, Rob Herring wrote:
> On Fri, Jul 5, 2024 at 3:21=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > As we're approaching the merge window and this is still unclear, I
> > applied the pwm bits (i.e. patches 12, 13). If I understand correctly,
> > patch 33 isn't suitable for application yet as it has a dependency on
> > pinctrl changes in that series.
>=20
> Now causing an error in linux-next:
>=20
> Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.example.dts:18:18:
> fatal error: dt-bindings/clock/cirrus,ep9301-syscon.h: No such file or
> directory
>    18 |         #include <dt-bindings/clock/cirrus,ep9301-syscon.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [scripts/Makefile.lib:442:
> Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.example.dtb]
> Error 1

Oh, I thought I had tested that, but obviously I didn't. I'll drop them
again.

Thanks for letting me know.

Best regards
Uwe

--piveefpjjxp5n6ob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaNVZwACgkQj4D7WH0S
/k4myggAuVPCnTKtBso6CgCuYoUSZB8cGFx1+fM36OQ0B75EHfb+T+oujbdiO1op
Q/3NTb3vIUE2+lHn6n/WxHLdeKE1vhmOgiaHW3UabNSZZyT360OZNjin7rLPlQEy
r1DW1w3QOUIS4g8P/v7skKSis2rOiAkICHLcRdDbW5K5dHLInEshegSKVLo+4McU
8SqKoYP4acYJFTxAC+gPkDS663k7UCsJbnbHDLstfUnuxPbtKpbDx2z8zB9IXh89
DMwNeZq7tszOWVZ3i0QEX9fZ/DBoFWY+lSL62ZKsQgh3fJucnwXkwqCdLWahNY0k
Wth32xU/Xhmh//FAw+1Q2VDgLI37Kw==
=z8zY
-----END PGP SIGNATURE-----

--piveefpjjxp5n6ob--

