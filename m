Return-Path: <linux-kernel+bounces-292640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515B0957232
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C2B1F2540C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3994418787A;
	Mon, 19 Aug 2024 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b00VJOt1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5279317C98D;
	Mon, 19 Aug 2024 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088675; cv=none; b=tetQZVGE9iZ/1P4UiwTGS+HgURauI874lHoF+o9m/J6XVyMjdEVX7/zjzG+j1808ha0oU+LhYIw/d4xerVXWez7xcMrjyj0NLmOUCk0+lEjjyJvZfjBX0PahJIt1mHepdcvyvNwRMnpjPzEzgLM7dH1/xNBdRlNyoR4Pv8sgAiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088675; c=relaxed/simple;
	bh=CDXuThWufIjZiVOPIB93srMMHrTj0bHZ7xzdnTWXYrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E57dUFWNrxSTbeLlwefguOZ34Kc0wbqmi4bDOpZpwW0lfdGGbw13rCrW8hezVh+Aasr3MVPayB9Qcn+SjJPc+IrJGjgI56uJ06QNCxkTmurvR+VvAk2+/qI3+61oiORvhvzb+Ab/rUgSH7gZwY0XwEc/b5Sk5M8JeA1m5QKkCo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b00VJOt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03C3C4AF0F;
	Mon, 19 Aug 2024 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724088674;
	bh=CDXuThWufIjZiVOPIB93srMMHrTj0bHZ7xzdnTWXYrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b00VJOt1sTeXtc+MN3jBiySiwgvusC/rqeIfZTiURt+OHXuzaiiLnykvuu3Yvzjmz
	 Lb6G4QIQtHBBMiU52IsRTG5ImdzymzLfjOC8o7u0LjU3ZcLJKcZApMp87i5Gb5efhN
	 HeKQ5OMhuRy/jpj2RRBbaAOd7j1Y3t+me/R/O4dX328gWHQ3xwfw1yCQp77NHS62NB
	 gIVPsi361g/Z0jkhSaq2QLdHXtD8+Lt8nq0uJ5y+xCU/HyFqEj5wHFaYtksLwXZtn7
	 ywxoGRI5gGKdZBgW95AzOJFBz0UTxA+Kd5fjAPeXx+wjiX3T6+X9gNlB/3QD8I1zzC
	 +XgI3LYtEje9w==
Date: Mon, 19 Aug 2024 18:31:09 +0100
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
Message-ID: <20240819-robust-gutter-27540adb4621@spud>
References: <20240814222159.2598-1-detlev.casanova@collabora.com>
 <5018731.31r3eYUQgx@trenzalore>
 <20240819-pelvis-monetary-211e2294f2f4@spud>
 <2071848.usQuhbGJ8B@trenzalore>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8nory5apk8iuCTjB"
Content-Disposition: inline
In-Reply-To: <2071848.usQuhbGJ8B@trenzalore>


--8nory5apk8iuCTjB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 01:14:38PM -0400, Detlev Casanova wrote:
> On Monday, 19 August 2024 12:34:15 EDT Conor Dooley wrote:
> > On Mon, Aug 19, 2024 at 10:08:31AM -0400, Detlev Casanova wrote:
> > > Hi Conor,
> > >=20
> > > On Thursday, 15 August 2024 11:07:46 EDT Conor Dooley wrote:
> > > > On Wed, Aug 14, 2024 at 06:19:22PM -0400, Detlev Casanova wrote:
> > > > > Add clock and reset ID defines for rk3576.
> > > > >=20
> > > > > Compared to the downstream bindings written by Elaine, this uses
> > > > > continous gapless IDs starting at 0. Thus all numbers are
> > > > > different between downstream and upstream, but names are kept
> > > > > exactly the same.
> > > > >=20
> > > > > Also add documentation for the rk3576 CRU core.
> > > > >=20
> > > > > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > > > > Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> > > > > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > > > > ---
> > > > >=20
> > > > >  .../bindings/clock/rockchip,rk3576-cru.yaml   |  64 ++
> > > > >  .../dt-bindings/clock/rockchip,rk3576-cru.h   | 592
> > > > >  ++++++++++++++++++
> > > > >  .../dt-bindings/reset/rockchip,rk3576-cru.h   | 564 ++++++++++++=
+++++
> > > > >  3 files changed, 1220 insertions(+)
> > > > >  create mode 100644
> > > > >  Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
> > > > >  create
> > > > >  mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h crea=
te
> > > > >  mode
> > > > >  100644 include/dt-bindings/reset/rockchip,rk3576-cru.h>
> > > > >=20
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
> > > > > b/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yam=
l new
> > > > > file mode 100644
> > > > > index 0000000000000..d69985e6fa0ce
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru=
=2Eyaml
> > > > > @@ -0,0 +1,64 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/clock/rockchip,rk3576-cru.yam=
l#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Rockchip rk3576 Family Clock and Reset Control Module
> > > > > +
> > > > > +maintainers:
> > > > > +  - Elaine Zhang <zhangqing@rock-chips.com>
> > > > > +  - Heiko Stuebner <heiko@sntech.de>
> > > > > +  - Detlev Casanova <detlev.casanova@collabora.com>
> > > > > +
> > > > > +description:
> > > > > +  The RK3576 clock controller generates the clock and also imple=
ments
> > > > > a
> > > > > reset +  controller for SoC peripherals. For example it provides
> > > > > SCLK_UART2 and +  PCLK_UART2, as well as SRST_P_UART2 and SRST_S_=
UART2
> > > > > for the second UART +  module.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: rockchip,rk3576-cru
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  "#clock-cells":
> > > > > +    const: 1
> > > > > +
> > > > > +  "#reset-cells":
> > > > > +    const: 1
> > > > > +
> > > > > +  clocks:
> > > > > +    maxItems: 2
> > > > > +
> > > > > +  clock-names:
> > > > > +    items:
> > > > > +      - const: xin24m
> > > > > +      - const: xin32k
> > > > > +
> > > > > +  rockchip,grf:
> > > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > > +    description: >
> > > > > +      phandle to the syscon managing the "general register files=
". It
> > > > > is
> > > > > used +      for GRF muxes, if missing any muxes present in the GRF
> > > > > will
> > > > > not be +      available.
> > > >=20
> > > > Two questions on this property:
> > > > - you only support one soc, why is this optional?
> > >=20
> > > It is optional because only used for some specific clocks. The SoC can
> > > still be used without this, but some devices might not work (Not test=
ed
> > > but USB PHYs might not be working without the GRF)

I would not bother making them optional. I don't think there's any
benefit to doing so when there's only one instance of this controller
on the device, and the grfs will also always be present.

> > > This is also set as optional in similar rockchip CRU bindings (rk3588=
).
> > >=20
> > > > - why can't you look it up by compatible?
> > >=20
> > > These bindings are specific to one compatible only. It is very simila=
r to
> > > rk3588 but it looks like all rockchip CRU driver has its own yaml fil=
e, so
> > > I followed that trend instead of merging with the rk3588 CRU bindings.
> > I don't think you've answered the question I am asking. Why can you not
> > look up the syscon by the /syscon/'s compatible in the clock driver, and
> > thus remove the property from here?
>=20
> I don't think that this is possible.

Undesirable maybe, impossible no.

> That means modifying rockchip/clk.c to=20
> lookup the syscon instead of using the `rockchip,grf` phandle. As it is u=
sed=20
> by other rockchip clock drivers, that means that we'd need to change the=
=20
> syscon's node name for some other SoCs to match what is being looked up.

No, you would not have to change anything for other SoCs, it would
definitely be possible to do compatible based lookups on some devices
and phandle on others, particularly given you're adding a new driver.

> But the GRF nodes have different compatibles:
> - rk3588 uses php_grf (rockchip,rk3588-php-grf)
> - rk3576 uses pmu0_grf (rockchip,rk3576-pmu0-grf)

Ditto this, the new clock driver that you're adding with knowledge of
the clock tree could also contain the new compatible for that soc.

>=20
> So an optional rockchip,grf phandle sounds a good solution for this=20

--8nory5apk8iuCTjB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsOBXQAKCRB4tDGHoIJi
0u/vAQDSwsluEKRxoOcYRAh1uVu2XPsw/p4RBvLSsDukZCR+2wEA9HnBhF+e7Itd
Zv3H4QkSggfMtdslb8Hu9gCENceHNQE=
=QO6A
-----END PGP SIGNATURE-----

--8nory5apk8iuCTjB--

