Return-Path: <linux-kernel+bounces-292523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE4795707D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB08B27A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA85917920A;
	Mon, 19 Aug 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZemkRePn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A85E175D53;
	Mon, 19 Aug 2024 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085261; cv=none; b=NBf5iQ6t1IxP98LI4I/puhheny5We+Vh100NJ0U1usNiFfXFhFe+cm0d7YjA4u6Cb7koO7ImTVgOPKT+lWravasKPY5fV7udIcEzP6lfhPP+gCJyx0fBZlAA6pWqBNPkKFa9auLeG1nhmNPxcPlt3pJlpvadBMgSpT+SYYYJZSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085261; c=relaxed/simple;
	bh=gd0XwIlIyEwVbHTi1dPq1iCsJvX+UHnxyvuzIYrvEMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnKCbR303SiX0XPmwwOX55iMo/H5jYP/22lbEq8wNI5SKhOvNdf14/4H+vXrySiwwE275calNuHYEkgUhuILFAGg8OdbUCAxT8fsQiqvk0lMqV7QptEuzWfenSxhREkPxOySs7VJW+SbBjZAPaDZuf6B2Pivnqxq8vky2HSyxK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZemkRePn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA25C32782;
	Mon, 19 Aug 2024 16:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724085260;
	bh=gd0XwIlIyEwVbHTi1dPq1iCsJvX+UHnxyvuzIYrvEMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZemkRePn2DCO6oIPLfT7UAZPavHAnvjo7WEy6DDDdUZw8tuZRjpTOyO3ccSeydCUW
	 VcKCVgrmzuAUI9YO7qLEY+LGCiKRQkB9He7EchhuHQlBQfH97ICr6MsJSCHZcAdWvw
	 I/olZsC8DdCKpO6gVfwxj3ySns4wrvFtIzXdbwnO2IsAI+oHJxLJ/bYMKBXonKA4iP
	 ZAMrLxgsUILmJR4aMcHPNO4XSfFVZc/v6tHclvXNT/hoEPrEsV/rE2Tv9fB9ol419J
	 Q/PSNn+IQRsB4K7J/Kinr9y12MEKgFOKUGBstUkWyr4EIuCaIguHg6jqXxBtoUjOEa
	 wjgUoLRBWWunw==
Date: Mon, 19 Aug 2024 17:34:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com,
	Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: clock, reset: Add support for rk3576
Message-ID: <20240819-pelvis-monetary-211e2294f2f4@spud>
References: <20240814222159.2598-1-detlev.casanova@collabora.com>
 <20240814222159.2598-2-detlev.casanova@collabora.com>
 <20240815-tassel-whacking-a460ee2ebd41@spud>
 <5018731.31r3eYUQgx@trenzalore>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n6FCtSpE7Uh9i8vt"
Content-Disposition: inline
In-Reply-To: <5018731.31r3eYUQgx@trenzalore>


--n6FCtSpE7Uh9i8vt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 10:08:31AM -0400, Detlev Casanova wrote:
> Hi Conor,
>=20
> On Thursday, 15 August 2024 11:07:46 EDT Conor Dooley wrote:
> > On Wed, Aug 14, 2024 at 06:19:22PM -0400, Detlev Casanova wrote:
> > > Add clock and reset ID defines for rk3576.
> > >=20
> > > Compared to the downstream bindings written by Elaine, this uses
> > > continous gapless IDs starting at 0. Thus all numbers are
> > > different between downstream and upstream, but names are kept
> > > exactly the same.
> > >=20
> > > Also add documentation for the rk3576 CRU core.
> > >=20
> > > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > > Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> > > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > > ---
> > >=20
> > >  .../bindings/clock/rockchip,rk3576-cru.yaml   |  64 ++
> > >  .../dt-bindings/clock/rockchip,rk3576-cru.h   | 592 ++++++++++++++++=
++
> > >  .../dt-bindings/reset/rockchip,rk3576-cru.h   | 564 +++++++++++++++++
> > >  3 files changed, 1220 insertions(+)
> > >  create mode 100644
> > >  Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml cre=
ate
> > >  mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h create m=
ode
> > >  100644 include/dt-bindings/reset/rockchip,rk3576-cru.h>=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
> > > b/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml new
> > > file mode 100644
> > > index 0000000000000..d69985e6fa0ce
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
> > > @@ -0,0 +1,64 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/rockchip,rk3576-cru.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Rockchip rk3576 Family Clock and Reset Control Module
> > > +
> > > +maintainers:
> > > +  - Elaine Zhang <zhangqing@rock-chips.com>
> > > +  - Heiko Stuebner <heiko@sntech.de>
> > > +  - Detlev Casanova <detlev.casanova@collabora.com>
> > > +
> > > +description:
> > > +  The RK3576 clock controller generates the clock and also implement=
s a
> > > reset +  controller for SoC peripherals. For example it provides
> > > SCLK_UART2 and +  PCLK_UART2, as well as SRST_P_UART2 and SRST_S_UART2
> > > for the second UART +  module.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: rockchip,rk3576-cru
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  "#clock-cells":
> > > +    const: 1
> > > +
> > > +  "#reset-cells":
> > > +    const: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 2
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: xin24m
> > > +      - const: xin32k
> > > +
> > > +  rockchip,grf:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description: >
> > > +      phandle to the syscon managing the "general register files". I=
t is
> > > used +      for GRF muxes, if missing any muxes present in the GRF wi=
ll
> > > not be +      available.
> >=20
> > Two questions on this property:
> > - you only support one soc, why is this optional?
>=20
> It is optional because only used for some specific clocks. The SoC can st=
ill be=20
> used without this, but some devices might not work (Not tested but USB PH=
Ys=20
> might not be working without the GRF)
> This is also set as optional in similar rockchip CRU bindings (rk3588).
>=20
> > - why can't you look it up by compatible?
>=20
> These bindings are specific to one compatible only. It is very similar to=
=20
> rk3588 but it looks like all rockchip CRU driver has its own yaml file, s=
o I=20
> followed that trend instead of merging with the rk3588 CRU bindings.

I don't think you've answered the question I am asking. Why can you not
look up the syscon by the /syscon/'s compatible in the clock driver, and
thus remove the property from here?

Thanks,
Conor.

--n6FCtSpE7Uh9i8vt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsN0BwAKCRB4tDGHoIJi
0iYXAQDAm/y+dzUTli+bib6dXnLBthHX7v21Tc7mhhY+48ZfYQD9GCaRaMsJHCfV
Z41SWteQOCY6BLIRilKvteLShnxHogI=
=7mM6
-----END PGP SIGNATURE-----

--n6FCtSpE7Uh9i8vt--

