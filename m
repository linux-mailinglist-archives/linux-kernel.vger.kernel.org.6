Return-Path: <linux-kernel+bounces-295859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D855C95A227
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 640FEB280DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4F11547F6;
	Wed, 21 Aug 2024 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWEuEzW2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D0E1537C1;
	Wed, 21 Aug 2024 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255734; cv=none; b=WJzBbl0zLcyFYVsAxTDKdOhUazN2pgFamY/PZzgnG5yB9lgFOf17+61FT0vbgdWGMFtvTWiwO4QYmt2oolR2oR/hZ7sfHkHiTKiFME5kG+pdyBMmZJkmol6s76VDto9flQP4ApzMNbit8YnXGCYFSaFOT66/hZkf/RttcazJQpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255734; c=relaxed/simple;
	bh=oO+0Tv2uU9zbU6edOpbgsXoLNpUE9+d8dxygISVgGuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7WI9cSXK3KnuQTU3cOmPAoos1/FtWTTX93ajk/tn6vf49Tid4xeEZsGDWczoddg8+l9gfrFzcGay7Zw6YPjGpglLdpcHRr7GVF8FFv4eFS4p1AyKRz81AXZBhnA8yylw6kh+vkyZHA4ZIKbqYqqsKtB4iZ135RJAoZtSVDIhWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWEuEzW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D346C32781;
	Wed, 21 Aug 2024 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724255733;
	bh=oO+0Tv2uU9zbU6edOpbgsXoLNpUE9+d8dxygISVgGuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IWEuEzW2eAOAzTIBdvnMKwDqxONi5bvAss+1DyQAZgggcO9o17lUl0wRyfbgeBAm7
	 qjeqktvAqgbnvq2/RbeWaHqPs92nlJHf8Y7dZH9FJOognOMFEmsDWGl5Bjqx0tw4LH
	 Sr2tvh1enoQxBtEg9pob6hyWyoX7538CrU33rEVev+x5ebtevlffQY0nlHiydMCx37
	 mYiyE6Q9QUC80lO/It8vpxu5ShyRyZ50X6+D1hew4wUDDt5/HLAi2en3uV4UIfQS+B
	 /d/EoAKCYH5sfHBk28GaMBvhhYA6oPslp6IVhx/1fJxSzV9OYCsqZltmNmVET92dQz
	 pvXC3Cq49g01Q==
Date: Wed, 21 Aug 2024 16:55:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexander Dahl <ada@thorsis.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Christian Melki <christian.melki@t2data.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 09/12] clk: at91: sam9x60: Allow enabling main_rc_osc
 through DT
Message-ID: <20240821-gnat-pushcart-882aa3a3f252@spud>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-10-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CijNXcpqoUP9GEdm"
Content-Disposition: inline
In-Reply-To: <20240821105943.230281-10-ada@thorsis.com>


--CijNXcpqoUP9GEdm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 12:59:40PM +0200, Alexander Dahl wrote:
> SAM9X60 Datasheet (DS60001579G) Section "23.4 Product Dependencies"
> says:
>=20
>     "The OTPC is clocked through the Power Management Controller (PMC).
>     The user must power on the main RC oscillator and enable the
>     peripheral clock of the OTPC prior to reading or writing the OTP
>     memory."
>=20
> The code for enabling/disabling that clock is already present, it was
> just not possible to hook into DT anymore, after at91 clk devicetree
> binding rework back in 2018 for kernel v4.19.
>=20
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  drivers/clk/at91/sam9x60.c       | 3 ++-
>  include/dt-bindings/clock/at91.h | 1 +

Generally we don't want binding changes in the same patch as a driver
change. If your fix was determined to be faulty down the line and
reverted, the binding change would remain valid, for example. Can you
split it into two patches please, for the next version please?

>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
> index e309cbf3cb9a..4d5ee20b8fc4 100644
> --- a/drivers/clk/at91/sam9x60.c
> +++ b/drivers/clk/at91/sam9x60.c
> @@ -207,7 +207,7 @@ static void __init sam9x60_pmc_setup(struct device_no=
de *np)
>  	if (IS_ERR(regmap))
>  		return;
> =20
> -	sam9x60_pmc =3D pmc_data_allocate(PMC_PLLACK + 1,
> +	sam9x60_pmc =3D pmc_data_allocate(PMC_MAIN_RC + 1,
>  					nck(sam9x60_systemck),
>  					nck(sam9x60_periphck),
>  					nck(sam9x60_gck), 8);
> @@ -218,6 +218,7 @@ static void __init sam9x60_pmc_setup(struct device_no=
de *np)
>  					   50000000);
>  	if (IS_ERR(hw))
>  		goto err_free;
> +	sam9x60_pmc->chws[PMC_MAIN_RC] =3D hw;
> =20
>  	hw =3D at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NU=
LL, 0);
>  	if (IS_ERR(hw))
> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock=
/at91.h
> index 3e3972a814c1..f957625cb3ac 100644
> --- a/include/dt-bindings/clock/at91.h
> +++ b/include/dt-bindings/clock/at91.h
> @@ -25,6 +25,7 @@
>  #define PMC_PLLBCK		8
>  #define PMC_AUDIOPLLCK		9
>  #define PMC_AUDIOPINCK		10
> +#define PMC_MAIN_RC		11
> =20
>  /* SAMA7G5 */
>  #define PMC_CPUPLL		(PMC_MAIN + 1)
> --=20
> 2.39.2
>=20

--CijNXcpqoUP9GEdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsYN8AAKCRB4tDGHoIJi
0oRoAQDqtnDTQk6fJ7GbAum6paH3b3FjF1bhS3Aw7qSeJrWA5AD/W3STyVNEqGq6
acYI6UGYoGZTPnCaJg5CdZ2hifHbjQI=
=esFu
-----END PGP SIGNATURE-----

--CijNXcpqoUP9GEdm--

