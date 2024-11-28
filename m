Return-Path: <linux-kernel+bounces-424559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D629DB5D2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BA0281CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3522D191F79;
	Thu, 28 Nov 2024 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KY3bXFRN"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2901428E7;
	Thu, 28 Nov 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732790238; cv=none; b=qcrnpGyLXvIBD6SuKTUUG87w1saDOGnIXQSn0XmK1yNWHQo/Rs2wkGF3Sy2T73dZj6+gVyX2nxeP/8cBlfWGlGF7i8fO9pM1HELbhDt2imflNWe/fbMytDPRnFnJvfS+0dYUF5w2L9NUfBaMIIC+IYHT70wDAdlQj8gmtChnwgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732790238; c=relaxed/simple;
	bh=X//+aLlv/ZUgHtxgxEk8ipshJKC/R6yilpLawZd/s4Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVIGu+Mxpukb/MidKJ5k1IsCIDC0iPRiyRtKPcjPuIcjSKcGLlbBeNspl3PqvUfKyIbJitYetjc9H6zjsW60KnNviDkeXYGlNXzn7G3ejZ/3BrRHCd/mCODudIoXW2Bkcb7/F2U5WVTaB73+i6uQKOl3eLWTkVDqrbf3jbKrcrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KY3bXFRN; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732790237; x=1764326237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X//+aLlv/ZUgHtxgxEk8ipshJKC/R6yilpLawZd/s4Q=;
  b=KY3bXFRN1WtxX1Bmg45pfac1UjWhLRI/RhKqkGGcSZ4F144H+4bxOJIS
   YYD2sneJHMBaE9cFN/iPNk2Zx0UxFWjMKVaeVIWLqqBxeyJwuKEuyGbRG
   mJ/yoQndt64WJkmFPbo4pVfIfo4MYUfHrv39HT8X2gIz0+Q3ijH5OwS2M
   578FCgBG/afcr6Eqf2ouE5qzybbwQCum8Hdb+XVsQf0oMUSZ0ymmNg4b9
   niiDD4nKTRNuG9ueM+iS/874sIvdowP91ccDJ0lpstdntj6sFsD9pi4T5
   3xl414u6OO8x0QOQkp7jMNDZPVkECTnVuRuaxL3Uj0hzKdDeRN/DCn/+9
   w==;
X-CSE-ConnectionGUID: wSflfb+LS36CStD+2SM6ZQ==
X-CSE-MsgGUID: PIuDtMU8RDao3fADMTrbCA==
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="asc'?scan'208";a="35386534"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2024 03:37:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Nov 2024 03:36:47 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Nov 2024 03:36:43 -0700
Date: Thu, 28 Nov 2024 10:36:16 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Stephen Boyd <sboyd@kernel.org>
CC: Conor Dooley <conor@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, <linux-kernel@vger.kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	<pierre-henry.moussay@microchip.com>,
	<valentina.fernandezalanis@microchip.com>, Michael Turquette
	<mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones
	<lee@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Kevin Hilman
	<khilman@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	<linux-riscv@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 08/11] clk: move meson clk-regmap implementation to
 common code
Message-ID: <20241128-monstrous-embargo-a665d921410d@wendy>
References: <20241002-private-unequal-33cfa6101338@spud>
 <20241002-hula-unwashed-1c4ddbadbec2@spud>
 <2b49c4df-a34a-42c5-8d44-9e47da630fe8@linaro.org>
 <1jwmiqsks3.fsf@starbuckisacylon.baylibre.com>
 <20241003-tacking-ladylike-dfe2b633e647@spud>
 <20241106-freefall-slider-db379b05821e@spud>
 <430bde3b35382e640843e32a9f351326.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jOw7oZ/dHujpxqRG"
Content-Disposition: inline
In-Reply-To: <430bde3b35382e640843e32a9f351326.sboyd@kernel.org>

--jOw7oZ/dHujpxqRG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 05:29:54PM -0800, Stephen Boyd wrote:
> Quoting Conor Dooley (2024-11-06 04:56:25)
> > My use case doesn't
> > actually need the registration code changes either as, currently, only =
reg
> > gets set at runtime, but leaving that out is a level of incomplete I'd =
not
> > let myself away with.
> > Obviously shoving the extra members into the clk structs has the downsi=
de
> > of taking up a pointer and a offset worth of memory for each clock of
> > that type registered, but it is substantially easier to support devices
> > with multiple regmaps that way. Probably moot though since the approach=
 you
> > suggested in the thread linked above that implements a clk_hw_get_regma=
p()
> > has to store a pointer to the regmap's identifier which would take up an
> > identical amount of memory.
>=20
> We don't need to store the regmap identifier in the struct clk. We can
> store it in the 'struct clk_init_data' with some new field, and only do
> that when/if we actually need to. We would need to pass the init data to
> the clk_ops::init() callback though. We currently knock that out during
> registration so that clk_hw->init is NULL. Probably we can just set that
> to NULL after the init routine runs in __clk_core_init().
>=20
> Long story short, don't add something to 'struct clk_core', 'struct
> clk', or 'struct clk_hw' for these details. We can have a 'struct
> clk_regmap_hw' that everyone else can build upon:
>=20
>   struct clk_regmap_hw {
>         struct regmap *regmap;
>         struct clk_hw hw;
>   };

What's the point of this? I don't understand why you want to do this over
what clk_divider et al already do, where clk_hw and the iomem pointer
are in the struct itself.

>=20
> and then set the regmap pointer during registration in
> clk_hw_init_regmap().
>=20
> int clk_hw_init_regmap(struct clk_hw *hw)
> {
> 	struct device *dev;
> 	struct regmap *regmap;
> 	struct clk_regmap_hw *rhw;
>=20
> 	rhw =3D clk_hw_to_clk_regmap_hw(hw);
>=20
> 	dev =3D clk_hw_get_dev(hw);
> 	if (!dev)
> 		return -EINVAL;
>=20
> 	regmap =3D dev_get_regmap(dev, hw->init->regmap_name);
> 	if (!regmap)
> 		return -EINVAL; // Print helpful message
> 	rhw->regmap =3D regmap;
>=20
> 	return 0;
> }

--jOw7oZ/dHujpxqRG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0hHlQAKCRB4tDGHoIJi
0r+YAQDAe67NaDMRenGcDGtot2a/AgJVl48Api+arsoWqWN6QAD9GCn98CCFJZBY
gZMaI09bAeDcbhzSqAEHQ9GpSbRtMAg=
=CQKc
-----END PGP SIGNATURE-----

--jOw7oZ/dHujpxqRG--

