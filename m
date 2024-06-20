Return-Path: <linux-kernel+bounces-223063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B09910D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223E81C2387F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C791B3F31;
	Thu, 20 Jun 2024 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2ERoqHj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CB91AED3B;
	Thu, 20 Jun 2024 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901018; cv=none; b=NnPZk2WrONebqa3ZRSbzZtO0jsqNVdmlagiJkXNJO3t9Oe5jbzWTanbaQG7yOqAcuKeodzAGkfnJoSkFLdl60MYWPudbQWp/cJiRzvmpT0JrvdHv48BdeLFAS0jdQwJ0532wC5wPZ+Z4b5I1i0eLPwPTckCiyNK5MNlgAFlJ2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901018; c=relaxed/simple;
	bh=2nApdRW4uFWIFKAeWO48GxrtOn9CEoIKmUrYIKGLbhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7wIDJQdPkwVV8U+RiA+zyf348HpNaPUuUA8fdMU1AWFoW6g2z0TuoXG/wY4mV1K1jqwR86IeTEVtnYaJ3//bUX52xWW1s2onkrWDo2WL+EfIJpvT9tlQBEZcqwwkNIZ679yyCrqDNIqhf+1GhHGY1Ojasid96UvpVKvif2YPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2ERoqHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75CCC2BD10;
	Thu, 20 Jun 2024 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718901018;
	bh=2nApdRW4uFWIFKAeWO48GxrtOn9CEoIKmUrYIKGLbhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J2ERoqHjMVj7J7iiKKY7CLQUQBWT2OD0KPDkExlb1q0FDGvMI83NKfoiUqNPrmfX0
	 mEH4QJ1t9ti1FWWszJppGi3GHjWQq+47H+ZIBffNIHvtZJYWEUV+KLcSbWjUTMKR6f
	 16lRiHf9HH3RbI+dskTpxeHYV+JWqU4VXvy/r5ReRto5xqMW7VRF3V0XYU5QzgoMHA
	 kv0eeU1THmYjLlrIPAd95+WwPAkKfdYl9bypTX+2j7Qiwkk2xQqarsV+Jl8qHF45xy
	 6u/Hpbes8H4kqOXj6LuNSUpsV56jF/modm9ZJ+zB0w0cTAF/QLIseVigYVpT2zVkJ/
	 0V1a6nNYDRC0Q==
Date: Thu, 20 Jun 2024 17:30:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] clk: thead: Add support for TH1520 AP_SUBSYS clock
 controller
Message-ID: <20240620-pregame-statute-2b43c0547064@spud>
References: <20240615-th1520-clk-v1-0-3ba4978c4d6b@tenstorrent.com>
 <20240619-tapping-jaundice-471811929d96@spud>
 <ZnMgKs/dUcYXiisk@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HSewvxSgds9cd/HB"
Content-Disposition: inline
In-Reply-To: <ZnMgKs/dUcYXiisk@x1>


--HSewvxSgds9cd/HB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 11:15:06AM -0700, Drew Fustini wrote:
> On Wed, Jun 19, 2024 at 12:12:30PM +0100, Conor Dooley wrote:
> > On Sat, Jun 15, 2024 at 06:54:29PM -0700, Drew Fustini wrote:
> > > This series adds support for the AP sub-system clock controller in the
> > > T-Head TH1520 [1]. Yangtao Li originally submitted this series in May
> > > 2023 [2]. Jisheng made additional improvements and then passed on the
> > > work in progress to me.
> >=20
> > One thing I noticed on the dts side is that the GPIO controllers have no
> > clocks provided. Does the AP sub-system clock controller provide their
> > clocks too?
>=20
> Good question. I see that dwapb_get_clks() in drivers/gpio/gpio-dwapb.c
> does call devm_clk_bulk_get_optional() for "bus" and "db". There doesn't
> seem to be to many in-tree examples of clocks being defined for gpio
> controllers with compatible "snps,dw-apb-gpio", but I do see that
> k210.dtsi defines K210_CLK_APB0 for "bus" and K210_CLK_GPIO for "db".
>=20
> From the TH1520 System User Manual, I do see the gpio related clocks in
> Section 4.4.2.2 AP_SUBSYS. The peripheral clock gate control register
> (PERI_CLK_CFG) has:
>=20
> Bit 20: GPIO3_CLK_EN
> Bit  8: GPIO0_CLK_EN
> Bit  7: GPIO1_CLK_EN
> Bit  6: GPIO2_CLK_EN
>=20
> I will add these gates to the clk-th1520-ap.c and reference them from
> the gpio controller nodes.
>=20
> Since each gpio controller will only have one clock, do you think I can
> omit the clock-names property?

Sure, thanks for looking into this.

>=20
> Thanks,
> Drew
>=20
> Link: https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main=
/docs

--HSewvxSgds9cd/HB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnRZFAAKCRB4tDGHoIJi
0jhfAPsFxSm+IHVQdarF1A8PQAiZE2P45kwvHpTzuUOpbO41gwEA3g6fNgbFnrZT
cPWAqmEQpUXzmehcdcTKzTlP4ETGrwQ=
=Y3Yf
-----END PGP SIGNATURE-----

--HSewvxSgds9cd/HB--

