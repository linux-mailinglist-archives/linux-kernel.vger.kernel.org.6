Return-Path: <linux-kernel+bounces-368800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B14B9A151A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B58F2B23773
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678541D3181;
	Wed, 16 Oct 2024 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ivg7+PkR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08F4125B9;
	Wed, 16 Oct 2024 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115204; cv=none; b=Khy7zBSTtdN3HZ9k0+wguzNFWPUvqkDURaub/HPr+OHrqYdESfWp5wPf9RHyOjd2QOOUL/YXsQIpSEsac6P6DynAYHu9msSSYTJgmpwyDSNU2zhGlQ95KuTRgyTCbU7AjWD2vPAbaCup8eALW/o6DD9V2iobh3J8/rF61YJSHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115204; c=relaxed/simple;
	bh=iRJD58NN0RHQ0+qB/8iQYxPqWTBN6Et86iB4WbEAlag=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ExdpBKgPKgXf8jMNjFzFgvaOqPegGpH8T5HBvPvB+SWps37Tvfka+8ahcFDlQa13wppQjdOopK27xA6wgDHyTnhh0n1vffskXg0q3GHwC5jFZFITGBNF0V0KYB5LpfLQU0NBt/+CZxNXSNM/FThhMZ0KTliJiUHBYMIV9uMZAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ivg7+PkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529A5C4CEC5;
	Wed, 16 Oct 2024 21:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729115204;
	bh=iRJD58NN0RHQ0+qB/8iQYxPqWTBN6Et86iB4WbEAlag=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Ivg7+PkR06qUFEyddB14oZqs8pyAKPazOE49tJE8kKIxi3mufnIUXJBzeaH9eqbaF
	 2j4ltbbOp03ltvJFalCIw/FD8wNrwjyU3qz54FxXZQU/DFL7EO1kZ1CHkINZ/TYf3J
	 4v3ZsSCzuvosXJkzu9gsgLSv+MT3MJPOFs+B224UMMq9qbP9QUF+FhVzKXh/MFP34u
	 R5gEeuzsNw6Pyy8Y37ugjUrVQH4E14M3UjAetIGKqT2YGrSFDnVfR2KCWXrLOHtZef
	 RvSS/m01fZ45UINpTPcXLcYUjyTMKVduXCgz06Z8MaM2d3vudepCAVzPsnW7BMTAK5
	 OM6ZRaWPRzHkg==
Message-ID: <98e82f4c4e6c62fe61d65ae03b027f79.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241014-imx-clk-v1-v1-1-ee75876d3102@nxp.com>
References: <20241014-imx-clk-v1-v1-0-ee75876d3102@nxp.com> <20241014-imx-clk-v1-v1-1-ee75876d3102@nxp.com>
Subject: Re: [PATCH 1/4] clk: imx: lpcg-scu: SW workaround for errata (e10858)
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Peng Fan (OSS) <peng.fan@oss.nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Date: Wed, 16 Oct 2024 14:46:42 -0700
User-Agent: alot/0.10

Quoting Peng Fan (OSS) (2024-10-14 02:11:22)
> diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-sc=
u.c
> index dd5abd09f3e206a5073767561b517d5b3320b28c..2cffec0c42dccc256e8dc5e91=
81952e250870a76 100644
> --- a/drivers/clk/imx/clk-lpcg-scu.c
> +++ b/drivers/clk/imx/clk-lpcg-scu.c
> @@ -6,6 +6,7 @@
> =20
>  #include <linux/bits.h>
>  #include <linux/clk-provider.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> @@ -41,6 +42,31 @@ struct clk_lpcg_scu {
> =20
>  #define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu, hw)
> =20
> +/* e10858 -LPCG clock gating register synchronization errata */
> +static void lpcg_e10858_writel(ulong rate, void __iomem *reg, u32 val)

s/ulong/unsigned long/

> +{
> +       u32 reg1;
> +
> +       writel(val, reg);
> +
> +       if (rate >=3D 24000000 || rate =3D=3D 0) {

Can be '24 * HZ_PER_MHZ'

> +               /*
> +                * The time taken to access the LPCG registers from the A=
P core
> +                * through the interconnect is longer than the minimum de=
lay
> +                * of 4 clock cycles required by the errata.
> +                * Adding a readl will provide sufficient delay to prevent
> +                * back-to-back writes.
> +                */
> +               reg1 =3D readl(reg);
> +       } else {
> +               /*
> +                * For clocks running below 24MHz, wait a minimum of
> +                * 4 clock cycles.
> +                */
> +               ndelay(4 * (DIV_ROUND_UP(1000000000, rate)));

Can be '1000 * HZ_PER_MHZ'

