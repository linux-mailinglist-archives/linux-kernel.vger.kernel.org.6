Return-Path: <linux-kernel+bounces-435097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0799E6FA8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A381882FE1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F3D207E19;
	Fri,  6 Dec 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0++dduS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19FC1FF7B4;
	Fri,  6 Dec 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493375; cv=none; b=P2EBLn+pc4fMCuALsrgn8SbNdE5ApOrcrMrifMF7PxgWINWJ8gDyTecxGEE/3DJ34WG8h5LT8fUIS45UPKAvTlIiPzHOLac3eYgwO0TZqnCM4+xkz2cDRUdZWr5MrIYk5YJ3Z+Kbbo16p0hbkHf6UoRFKkF+XZVFH1KOhy4BtKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493375; c=relaxed/simple;
	bh=563SsPu6/+OsYwdbvzEtes3bIYtTyUec5qqj5KSLCAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvF0vYeGzv02Ksbrz2qGeJ7fSyYZbi9s0x9doPprSwSrCJFExApXDgTxMzwxsW06hJHN2H2URyETYi7fZniAls6DW0DKoVYai409pH36XqZRySESItKGuijMr5D8wcH9j36hseDVwnMNd2gxUt8UhnT3XvepED9TqQPp10cLKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0++dduS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261C0C4CEDC;
	Fri,  6 Dec 2024 13:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733493375;
	bh=563SsPu6/+OsYwdbvzEtes3bIYtTyUec5qqj5KSLCAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0++dduS4VP6El2s8mBfIALW+2dmy6vZ33ooYuEgdXM317b/U4EqhGelyHGrrZNzL
	 miIzeR+cSJnDn2jCkwlWbbPQzMvGFWSHJhDdY+7Q/Yd+Cq1A2hSDtsk9xQb/HEkLVt
	 0ZmBu6Yv/uqEFGGpNw+RidIfX39MLYvNpox74jqIsyHDwG8s0kme4AlF6hXb3g1p4Q
	 PD8UA0A0sOhtVkJtPiVQde7vkG47XDvRIjeALCafiEVQT9rNkK5XaiRD+igQQhlf1T
	 9Ixw6DsaTKfU0t/e/lZGzQ9lrlMDkUdvGSpTCflX+LMZTIiL/wAyKsXyfrrwV7lYxj
	 OjWK6lrW78A6Q==
Date: Fri, 6 Dec 2024 13:56:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-kernel@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 08/11] clk: move meson clk-regmap implementation to
 common code
Message-ID: <20241206-threaten-showing-1214491f3899@spud>
References: <20241002-private-unequal-33cfa6101338@spud>
 <20241002-hula-unwashed-1c4ddbadbec2@spud>
 <2b49c4df-a34a-42c5-8d44-9e47da630fe8@linaro.org>
 <1jwmiqsks3.fsf@starbuckisacylon.baylibre.com>
 <20241003-tacking-ladylike-dfe2b633e647@spud>
 <20241106-freefall-slider-db379b05821e@spud>
 <430bde3b35382e640843e32a9f351326.sboyd@kernel.org>
 <20241128-monstrous-embargo-a665d921410d@wendy>
 <e53adbf9fdf6e3f142083b0d40d074ca.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D3KsjEcBH/hYSuAR"
Content-Disposition: inline
In-Reply-To: <e53adbf9fdf6e3f142083b0d40d074ca.sboyd@kernel.org>


--D3KsjEcBH/hYSuAR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 02:50:31PM -0800, Stephen Boyd wrote:
> Quoting Conor Dooley (2024-11-28 02:36:16)
> > On Thu, Nov 14, 2024 at 05:29:54PM -0800, Stephen Boyd wrote:
> > > Quoting Conor Dooley (2024-11-06 04:56:25)
> > > > My use case doesn't
> > > > actually need the registration code changes either as, currently, o=
nly reg
> > > > gets set at runtime, but leaving that out is a level of incomplete =
I'd not
> > > > let myself away with.
> > > > Obviously shoving the extra members into the clk structs has the do=
wnside
> > > > of taking up a pointer and a offset worth of memory for each clock =
of
> > > > that type registered, but it is substantially easier to support dev=
ices
> > > > with multiple regmaps that way. Probably moot though since the appr=
oach you
> > > > suggested in the thread linked above that implements a clk_hw_get_r=
egmap()
> > > > has to store a pointer to the regmap's identifier which would take =
up an
> > > > identical amount of memory.
> > >=20
> > > We don't need to store the regmap identifier in the struct clk. We can
> > > store it in the 'struct clk_init_data' with some new field, and only =
do
> > > that when/if we actually need to. We would need to pass the init data=
 to
> > > the clk_ops::init() callback though. We currently knock that out duri=
ng
> > > registration so that clk_hw->init is NULL. Probably we can just set t=
hat
> > > to NULL after the init routine runs in __clk_core_init().
> > >=20
> > > Long story short, don't add something to 'struct clk_core', 'struct
> > > clk', or 'struct clk_hw' for these details. We can have a 'struct
> > > clk_regmap_hw' that everyone else can build upon:
> > >=20
> > >   struct clk_regmap_hw {
> > >         struct regmap *regmap;
> > >         struct clk_hw hw;
> > >   };
> >=20
> > What's the point of this? I don't understand why you want to do this ov=
er
> > what clk_divider et al already do, where clk_hw and the iomem pointer
> > are in the struct itself.
>=20
> Can you give an example? I don't understand what you're suggesting. I
> prefer a struct clk_regmap_hw like above so that the existing struct
> clk_hw in the kernel aren't increased by a pointer. SoC drivers can use
> the same struct as a replacement for their struct clk_hw member today.

Best example I guess is to link what I did? This one is the core
changes:
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?h=
=3Dsyscon-rework-2&id=3D35904222355e971c24b3eb9b9fad3dd0c38d1393
clk-gate has my original hack that I did while trying to figure out
what you wanted, clk-divider-regmap is a 99% copy of clk-divider with
the types, function names and readl()/writel() implementations modified.
Before your last set of comments I was doing something identical to the
clk-gate change for clk-divider also.
Here's the changes required to my driver to make it work with the
updated:
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?h=
=3Dsyscon-rework-2&id=3Dea40211fe20f8bc6ef0320b93e1baa5b3f244601
It's pretty much a drop in replacement, other than the additional
complexity in probe.

Hopefully that either gets my point across or lets you spot why I don't
understand the benefit of a wrapper around clk_hw.

Cheers,
Conor.

--D3KsjEcBH/hYSuAR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1MCeAAKCRB4tDGHoIJi
0sqzAP9waSsOIi7fzVRAF2IfUyhCzbN2HRg7fuiXsVL8Q28vwQD7BAtQFxtD1L8h
wFWZMACgozCdkOQyTUTRyE/s54HVoAg=
=wQYC
-----END PGP SIGNATURE-----

--D3KsjEcBH/hYSuAR--

