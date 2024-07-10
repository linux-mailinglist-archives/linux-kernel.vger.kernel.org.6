Return-Path: <linux-kernel+bounces-248195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D850192D9A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168A71C21298
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C640A196C86;
	Wed, 10 Jul 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+GcvbFU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151738F66;
	Wed, 10 Jul 2024 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720641396; cv=none; b=enp99jBzFedeRYK9pt+dE31/CkMnPea0+Fk+cZ2YyqSeT6Cjk5rU9TiuPJ7D/7uPHXEQz+LGg11pFdcHeU3mBz6UJQVvKdXQ16p/8alTm3in4Qc8fL9w3sBxzlCupAak6Ku9cJwW8wPIL/OOfSi5TzVlCJwrchqDer4hKorfAq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720641396; c=relaxed/simple;
	bh=ro7p272460qqn5pIA0OqMhCSJP2ZAay9e/58qs09Yn8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=kyPLT8JwpCsrTz/0mWjIT/Qk5qBBbQwYivY/yGMJOTS2/GswMl6aQc3cWCvB+JSaSAnRSeu009NzTbENZeJ00z6+NTTGThD7i5/gZlCVjUY5FGOm9keKXJI3gKal7DHM//I1eEVtLi9HzPlHvdEOi2E1eqtG6UDH8Yu8IBavBlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+GcvbFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFA2C32781;
	Wed, 10 Jul 2024 19:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720641395;
	bh=ro7p272460qqn5pIA0OqMhCSJP2ZAay9e/58qs09Yn8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=g+GcvbFU17imdNN+5jIeSNVEjrLfEx6xRL+ZTmSeQasNj6NEcqEnPhBNwDKrKIoSz
	 ZQT1vXtO1WdqaNPbECyRVHeq7nOnkfwvN9B1UXfpa78pVcwWxykMthqUb5ER3cvhOp
	 PI9cEKfIW9pnHebsbCXeHMGJLuhYaEWG2GTL4sshfC1ArFUX2Icb4jBBviLlNylwlU
	 xzArOyHlz//+Zzc6I8fftyVtG5UxGkJT6S6SUor2P46SZen0ut9hOXuEYAbnEJfqmU
	 8v+9N/elg96pMbi0g3K8PZnjHKkH01SwcHkrn/30BdURcOLlUXASOepaNl9Gu2t50C
	 MqTojEPEjBjjw==
Message-ID: <a2a41f77c854b2399a0d87142c5bfe39.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7f2bf860ffaccd10899b72fdda6a3ca9c50d2107.camel@maquefel.me>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me> <20240617-ep93xx-v10-3-662e640ed811@maquefel.me> <6c5d6c0730698969ef613ec9ec4aa14a.sboyd@kernel.org> <7f2bf860ffaccd10899b72fdda6a3ca9c50d2107.camel@maquefel.me>
Subject: Re: [PATCH v10 03/38] clk: ep93xx: add DT support for Cirrus EP93xx
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
To: Michael Turquette <mturquette@baylibre.com>, Nikita Shubin <nikita.shubin@maquefel.me>, Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Wed, 10 Jul 2024 12:56:33 -0700
User-Agent: alot/0.10

Quoting Nikita Shubin (2024-07-10 03:34:12)
> Hello Stephen!
>=20
> On Mon, 2024-07-08 at 15:18 -0700, Stephen Boyd wrote:
> > Quoting Nikita Shubin via B4 Relay (2024-06-17 02:36:37)
> > > diff --git a/drivers/clk/clk-ep93xx.c b/drivers/clk/clk-ep93xx.c
> > > new file mode 100644
> > > index 000000000000..a0430a5ae4da
> > > --- /dev/null
> > > +++ b/drivers/clk/clk-ep93xx.c
> > > @@ -0,0 +1,834 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > [...]
> > > +
> > > +static int ep93xx_clk_enable(struct clk_hw *hw)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ep93xx_clk *clk =3D ep93=
xx_clk_from(hw);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ep93xx_clk_priv *priv =
=3D ep93xx_priv_from(clk);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 val;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guard(spinlock_irqsave)(&priv->=
lock);
> >=20
> > I thought guard() was most important when there were multiple exit
> > paths
> > from a function, but OK.
> >=20
> > > +
> > [...]
> > > +
> > > +static int ep93xx_plls_init(struct ep93xx_clk_priv *priv)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char fclk_divisors[] =3D =
{ 1, 2, 4, 8, 16, 1, 1, 1 };
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char hclk_divisors[] =3D =
{ 1, 2, 4, 5, 6, 8, 16, 32 };
> > [...]
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(value & EP93XX_SYSCON_CLK=
SET2_NBYP2))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 clk_pll2_rate =3D EP93XX_EXT_CLK_RATE;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (value & EP93XX_SYSCON_=
CLKSET2_PLL2_EN)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 clk_pll2_rate =3D calc_pll_rate(EP93XX_EXT_CLK_RATE,
> > > value);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 clk_pll2_rate =3D 0;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw =3D devm_clk_hw_register_fix=
ed_rate(dev, "pll2", "xtali",
> > > 0, clk_pll2_rate);
> >=20
> > Please use clk_parent_data for topology descriptions.
>=20
> It's look like clk_hw_register_fixed_rate_parent_hw() is missing devm_
> version of this function. Is it ok to provide wrapper for
> __clk_hw_register_fixed_rate() in drivers/clk/clk-ep93xx.c ?
>=20

It's not very hard to put it in the header file though, so why not
implement the wrapper in include/linux/clk-provider.h like
devm_clk_hw_register_fixed_rate()?

