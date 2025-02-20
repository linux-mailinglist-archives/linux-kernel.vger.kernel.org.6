Return-Path: <linux-kernel+bounces-524063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1DEA3DEB8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C9A7016E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC21E1FF7BB;
	Thu, 20 Feb 2025 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNW4I7ZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6E1FC7C1;
	Thu, 20 Feb 2025 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065358; cv=none; b=ha7zhOr1Xa+IzOVinkuAk0ASM8KCAWTCEjVZ015pPZ+0lQkjrtgoiDYM8Zfoz6bBFbbJyCTM693LOGJzKcFzzqdRdqkedBTZG09MUWvVXitjh1sOPofQHoenEWA/uUFr99eOrFzP3KwAxiqQ0l63JnuKnrnQjwgMGlukbbTShCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065358; c=relaxed/simple;
	bh=MTLWHOpBFgCO7z7n2peuBWtocXKLNU0/5mK6lDkn0Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfVktktAM99OCoLRdIAZT//cSdOqFF6AwwvlCw/iED+s5K8zo4n9KGVWVHRVEyDUGSKKteiVYG/I6Y5B5aIR8zRtUAYkGZ52q4tLKXDMR/OEX/PJjcn50rvi/ypYWsq0zltE0ycm4CBdk3mHc7O88IGN0+GjaIIuYmbNK4e3png=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNW4I7ZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35480C4CEDD;
	Thu, 20 Feb 2025 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740065357;
	bh=MTLWHOpBFgCO7z7n2peuBWtocXKLNU0/5mK6lDkn0Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sNW4I7ZCKs8HynfqyRTjQpOAgKwDFZYNmiWEpQemlDaIkIsk1Qv4JYYlhWy1N67Sv
	 EEYKyHF9GwKwObewsR3l76fRiElnv/FVUdfm4BM5K6Xg2bOa8Ufkb8udidOEfk324n
	 NeEPDKgExSPJF1APNOU16xlBZEDu36hXOX3UR/xu43A3cQzZop0qDjNJej4NYI7Fj5
	 1ShARsi8RfLH69XQ0IY7QmDb4nTKa32YhzsVD6Cj3iqtUAb87ZrBmnMObJdcpGFFVN
	 6eAapY4bHq+tyMpQFfSNh5b+KNlDyq9I5RXnpkqhMHPOV3CoCEejs/DOxK3Kh+BG7U
	 ko3K7wgO6fSAQ==
Date: Thu, 20 Feb 2025 15:29:10 +0000
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
Message-ID: <20250220-iciness-mobilize-94a027ff52ce@spud>
References: <20241002-hula-unwashed-1c4ddbadbec2@spud>
 <2b49c4df-a34a-42c5-8d44-9e47da630fe8@linaro.org>
 <1jwmiqsks3.fsf@starbuckisacylon.baylibre.com>
 <20241003-tacking-ladylike-dfe2b633e647@spud>
 <20241106-freefall-slider-db379b05821e@spud>
 <430bde3b35382e640843e32a9f351326.sboyd@kernel.org>
 <20241128-monstrous-embargo-a665d921410d@wendy>
 <e53adbf9fdf6e3f142083b0d40d074ca.sboyd@kernel.org>
 <20241206-threaten-showing-1214491f3899@spud>
 <20250121-cheddar-kissing-bea27c6f2726@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wwzakjPEFGD9XyPd"
Content-Disposition: inline
In-Reply-To: <20250121-cheddar-kissing-bea27c6f2726@spud>


--wwzakjPEFGD9XyPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 05:38:53PM +0000, Conor Dooley wrote:
> Hey Stephen,
>=20
> Any thoughts on the example I gave below?

I'll give you a few more days to comment, and then I'll just send a
fresh revision, implemented as below. The links seem to have expired in
a rebase along the way, so I've provided some fresh links.

Cheers,
Conor.

>=20
> On Fri, Dec 06, 2024 at 01:56:08PM +0000, Conor Dooley wrote:
> > On Tue, Dec 03, 2024 at 02:50:31PM -0800, Stephen Boyd wrote:
> > > Quoting Conor Dooley (2024-11-28 02:36:16)
> > > > On Thu, Nov 14, 2024 at 05:29:54PM -0800, Stephen Boyd wrote:
> > > > > Quoting Conor Dooley (2024-11-06 04:56:25)
> > > > > > My use case doesn't
> > > > > > actually need the registration code changes either as, currentl=
y, only reg
> > > > > > gets set at runtime, but leaving that out is a level of incompl=
ete I'd not
> > > > > > let myself away with.
> > > > > > Obviously shoving the extra members into the clk structs has th=
e downside
> > > > > > of taking up a pointer and a offset worth of memory for each cl=
ock of
> > > > > > that type registered, but it is substantially easier to support=
 devices
> > > > > > with multiple regmaps that way. Probably moot though since the =
approach you
> > > > > > suggested in the thread linked above that implements a clk_hw_g=
et_regmap()
> > > > > > has to store a pointer to the regmap's identifier which would t=
ake up an
> > > > > > identical amount of memory.
> > > > >=20
> > > > > We don't need to store the regmap identifier in the struct clk. W=
e can
> > > > > store it in the 'struct clk_init_data' with some new field, and o=
nly do
> > > > > that when/if we actually need to. We would need to pass the init =
data to
> > > > > the clk_ops::init() callback though. We currently knock that out =
during
> > > > > registration so that clk_hw->init is NULL. Probably we can just s=
et that
> > > > > to NULL after the init routine runs in __clk_core_init().
> > > > >=20
> > > > > Long story short, don't add something to 'struct clk_core', 'stru=
ct
> > > > > clk', or 'struct clk_hw' for these details. We can have a 'struct
> > > > > clk_regmap_hw' that everyone else can build upon:
> > > > >=20
> > > > >   struct clk_regmap_hw {
> > > > >         struct regmap *regmap;
> > > > >         struct clk_hw hw;
> > > > >   };
> > > >=20
> > > > What's the point of this? I don't understand why you want to do thi=
s over
> > > > what clk_divider et al already do, where clk_hw and the iomem point=
er
> > > > are in the struct itself.
> > >=20
> > > Can you give an example? I don't understand what you're suggesting. I
> > > prefer a struct clk_regmap_hw like above so that the existing struct
> > > clk_hw in the kernel aren't increased by a pointer. SoC drivers can u=
se
> > > the same struct as a replacement for their struct clk_hw member today.
> >=20
> > Best example I guess is to link what I did? This one is the core
> > changes:
> > https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/=
?h=3Dsyscon-rework-2&id=3D35904222355e971c24b3eb9b9fad3dd0c38d1393

https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?h=
=3Dsyscon-rework-2&id=3D435c8eb223ee804297a0491fae2b00d3d5a9c773

> > clk-gate has my original hack that I did while trying to figure out
> > what you wanted, clk-divider-regmap is a 99% copy of clk-divider with
> > the types, function names and readl()/writel() implementations modified.
> > Before your last set of comments I was doing something identical to the
> > clk-gate change for clk-divider also.
> > Here's the changes required to my driver to make it work with the
> > updated:
> > https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/=
?h=3Dsyscon-rework-2&id=3Dea40211fe20f8bc6ef0320b93e1baa5b3f244601

https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?h=
=3Dsyscon-rework-2&id=3Df55e907e93c55c943725dd62c2fc7dc76cdbd8d5

> > It's pretty much a drop in replacement, other than the additional
> > complexity in probe.
> >=20
> > Hopefully that either gets my point across or lets you spot why I don't
> > understand the benefit of a wrapper around clk_hw.
> >=20
> > Cheers,
> > Conor.
>=20
>=20



--wwzakjPEFGD9XyPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7dKRgAKCRB4tDGHoIJi
0mt+AP9ZtNoPxvKbOcIMX0fDvI5s5NZddcJQVg/zunmjaBs72gEA0n82Gu5ZYQLK
6fogd/rOINP7HeHjE0oQlvy2nriVwgA=
=0xmx
-----END PGP SIGNATURE-----

--wwzakjPEFGD9XyPd--

