Return-Path: <linux-kernel+bounces-348940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E9798EE3D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6499BB21717
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1511F156231;
	Thu,  3 Oct 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqWQ7z7R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF871474C5;
	Thu,  3 Oct 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727955227; cv=none; b=LcST6XARx0TxPJUF708JFnLAofe8zx6Knh9dNgVC9NCnTqH3THye2CDRGHfC0TIFi3qH6SHSQlhZbnsdVwwNIe90xx507YASriflndnhsCQs8WT7eLD+H4S0wHaFltGR+1c8uul6tcdHzVzRmyJD/n6GI7J8wbEdLKPyzhKq/5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727955227; c=relaxed/simple;
	bh=NLctO8JI0MYGf7CqUEPw7Kskjrc+MaQ2Y++XMVrcnE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2W0LVJBAZrolkeEO5UxuPL0MexpaBuhM5t8X5eNjh0ZusxssFUwX3iMV3cmhClyS80h+kksY/BmUurCHLb+evo2KxaJWGbpn3A5GrJMqN6daQURcrv94RKO/K5pmhdLSnKjgMDCLFfvBcx5y712z8CIDDWi7kotxgS1rfrcm0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqWQ7z7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECB1C4CEC5;
	Thu,  3 Oct 2024 11:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727955226;
	bh=NLctO8JI0MYGf7CqUEPw7Kskjrc+MaQ2Y++XMVrcnE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NqWQ7z7R/QiDmVe1vwzFaIZH3Bfi4p0TGx5ZhHXG8nX5K4Ta30gOCci/jlREHBNET
	 ezHW/slty1w1mKw5zwX+gk+BRRRkaRJ8c57l1SBYv/W+QqftETZVkcHBEjSJXrSMgG
	 Kq6rlRNULhQQ1u2YU3kaBIzwrwOHIIbzr76ke6BfQfRd1y3B36m/663nhsZkc3FLr1
	 qW60VceSzoySuVa0AdGWA1RMBi/5XdjqzA/T0nWhf/JSJE22Q/EuiuG0MZGiEHVwVv
	 bZXjl/SWowvwIRGo4FaGy0b6B9tM5zrfKqp6FILJH1owDHTMcOew/mUEFfsF/KFKKY
	 JYJxh5wiQ4sSg==
Date: Thu, 3 Oct 2024 12:33:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
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
Message-ID: <20241003-tacking-ladylike-dfe2b633e647@spud>
References: <20241002-private-unequal-33cfa6101338@spud>
 <20241002-hula-unwashed-1c4ddbadbec2@spud>
 <2b49c4df-a34a-42c5-8d44-9e47da630fe8@linaro.org>
 <1jwmiqsks3.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uCgVWK9mZdISCwYL"
Content-Disposition: inline
In-Reply-To: <1jwmiqsks3.fsf@starbuckisacylon.baylibre.com>


--uCgVWK9mZdISCwYL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2024 at 03:21:16PM +0200, Jerome Brunet wrote:
> On Wed 02 Oct 2024 at 13:20, Neil Armstrong <neil.armstrong@linaro.org> w=
rote:
>=20
> > On 02/10/2024 12:48, Conor Dooley wrote:
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >> I like this one better than qualcomms and wish to use it for the
> >> PolarFire SoC clock drivers.
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >>   drivers/clk/Kconfig                           |  4 ++
> >>   drivers/clk/Makefile                          |  1 +
> >>   drivers/clk/{meson =3D> }/clk-regmap.c          |  2 +-
> >>   drivers/clk/meson/Kconfig                     | 46 +++++++++--------=
--
> >>   drivers/clk/meson/Makefile                    |  1 -
> >>   drivers/clk/meson/a1-peripherals.c            |  2 +-
> >>   drivers/clk/meson/a1-pll.c                    |  2 +-
> >>   drivers/clk/meson/axg-aoclk.c                 |  2 +-
> >>   drivers/clk/meson/axg-audio.c                 |  2 +-
> >>   drivers/clk/meson/axg.c                       |  2 +-
> >>   drivers/clk/meson/c3-peripherals.c            |  2 +-
> >>   drivers/clk/meson/c3-pll.c                    |  2 +-
> >>   drivers/clk/meson/clk-cpu-dyndiv.c            |  2 +-
> >>   drivers/clk/meson/clk-dualdiv.c               |  2 +-
> >>   drivers/clk/meson/clk-mpll.c                  |  2 +-
> >>   drivers/clk/meson/clk-phase.c                 |  2 +-
> >>   drivers/clk/meson/clk-pll.c                   |  2 +-
> >>   drivers/clk/meson/g12a-aoclk.c                |  2 +-
> >>   drivers/clk/meson/g12a.c                      |  2 +-
> >>   drivers/clk/meson/gxbb-aoclk.c                |  2 +-
> >>   drivers/clk/meson/gxbb.c                      |  2 +-
> >>   drivers/clk/meson/meson-aoclk.h               |  2 +-
> >>   drivers/clk/meson/meson-eeclk.c               |  2 +-
> >>   drivers/clk/meson/meson-eeclk.h               |  2 +-
> >>   drivers/clk/meson/meson8-ddr.c                |  2 +-
> >>   drivers/clk/meson/meson8b.c                   |  2 +-
> >>   drivers/clk/meson/s4-peripherals.c            |  2 +-
> >>   drivers/clk/meson/s4-pll.c                    |  2 +-
> >>   drivers/clk/meson/sclk-div.c                  |  2 +-
> >>   drivers/clk/meson/vclk.h                      |  2 +-
> >>   drivers/clk/meson/vid-pll-div.c               |  2 +-
> >>   .../meson =3D> include/linux/clk}/clk-regmap.h  |  0
> >>   32 files changed, 53 insertions(+), 53 deletions(-)
> >>   rename drivers/clk/{meson =3D> }/clk-regmap.c (99%)
> >>   rename {drivers/clk/meson =3D> include/linux/clk}/clk-regmap.h (100%)
> >>=20
> > <snip>
> >
> > I don't have objections, but I think Stephen didn't like the idea
> > a few years ago, but perhaps it has changed...
> >
> > Anyway, take my:
> > Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
>=20
> We had a similar discussion 3y ago indeed:
> https://lore.kernel.org/linux-clk/162734682512.2368309.120158730107770830=
14@swboyd.mtv.corp.google.com/
>=20
> There are needs for a common regmap backed clocks indeed, but allowing
> meson flavored regmap clocks to spread in the kernel was not really the
> prefered way to do it.=20

Cool, thanks for that link.

> IIRC, Stephen's idea was more the bring regmap support in clk-gate.c,
> clk-mux, etc ... I'm not quite sure how make iomem and regmap co-exist
> in a manageable/maintainable way within those drivers (without adding yet
> another level of abstraction I mean) ? Silently creating a regmap maybe
> ? but that's probably a bit heavy. I did not really had time to dig more
> on this, I guess no one did.

I guess I have some motivation to looking into it at the moment. I had
my reservations about the Meson approach too, liking it more than
Qualcomm's didn't mean I completely liked it.
It was already my intention to implement point b of your mail, had the
general idea here been acceptable, cos that's a divergence from how the
generic clock types (that the driver in question currently uses) work.
And on that note, I just noticed I left the mild-annoyance variable name
"sigh" in the submitted driver changes, which I had used for the
clk_regmap struct that your point b in the link relates to.

> I don't really have a preference one way or the other but if it is going
> to be exposed in 'include/linux', we need to be sure that's how we want
> to do it. With clocks poping in many driver subsystems, it will
> difficult to change afterward.=20

Yeah, I agree. I didn't expect this to go in right away, and I also
didn't want to surge ahead on some rework of the clock types, were
people to hate even the reuse.



--uCgVWK9mZdISCwYL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZv6BFAAKCRB4tDGHoIJi
0jmWAP9z0C6fhBUSC/WWZ6MZddGsLo6oJD3x2WT9TTBT2I9w/wEAs8bEOsrFDfek
0QgAHx+Dw07ysrdYhC0Q1STP5zoaUAI=
=3uTP
-----END PGP SIGNATURE-----

--uCgVWK9mZdISCwYL--

