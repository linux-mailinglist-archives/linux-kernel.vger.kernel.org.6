Return-Path: <linux-kernel+bounces-217960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6862F90B6EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA131C2372D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8303516630D;
	Mon, 17 Jun 2024 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Br9rhF+w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A85517C8;
	Mon, 17 Jun 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642794; cv=none; b=f9fLylV2tS2CS6as5hS2AZyRDdEfQ0V9mIUVvtEEGhw7hZbFePYV32C5Y0JsqFXhoCytit24dISCmQUGOpPEp1s2KbLYLCppFm5zQWP4xkXsip3Ome2cNHAS+0zkKMLFzNOtlAga1ckPNRSiFOVrTsfNHuW2me4acmTTLAZeUvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642794; c=relaxed/simple;
	bh=vd97vaQMsq53OVRgUZpwAbni9g8Y6CZ7AU9B12DalEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ia0iSB7sLYXQTzutUMzH8oFIumtwMI0Uqq5NerNBLdMRBkp/jh7qNn8khuMr93oVyC4HCQhSo2Le/YWN7voqPSP5ojkAR+s81Hh/2MA/V0d8KSy1pWZcWgIU/ZAyX2c50ogURc1w0xHKckPd2o/l35or64OzsV3AqwLqQgznmoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Br9rhF+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CADC4AF48;
	Mon, 17 Jun 2024 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718642794;
	bh=vd97vaQMsq53OVRgUZpwAbni9g8Y6CZ7AU9B12DalEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Br9rhF+wxtiKOtp20GpJdDvnB1wXyvG2QyUfT94QGAyrN0CphiQ3WEkgixJML/GeH
	 UyvMEbqji1JzhEGfjCNeW3NwPWLHouEUpbGAfBZ7tmIcew6U1At4lTJeFO+maKdG83
	 NRLd9BMW8ztDkldVVTQ+yyq7mXEYQMLHrDGX+22ps26F7JfEpdREP9kCzlfscA89MJ
	 S9/lcyOVqCHZCBrDMFJh4Ovse87r6MsVNGM/oHbiO/fshIHXv7uGQoNlW2YGfET/g+
	 jQH7YGLsA6wsf6CweLor5w31IxFdKAb00pT2cViRf4lrfivPbfMTcC6EDgS7XB2v44
	 QKg5ctIw7g6sQ==
Date: Mon, 17 Jun 2024 17:46:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, Nishanth Menon <nm@ti.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 6/7] dt-bindings: mfd: syscon: Split and enforce
 documenting MFD children
Message-ID: <20240617-purge-family-c0c62b8e73d8@spud>
References: <20240616-dt-bindings-mfd-syscon-split-v2-0-571b5850174a@linaro.org>
 <20240616-dt-bindings-mfd-syscon-split-v2-6-571b5850174a@linaro.org>
 <20240617-zoology-silica-2c8c78363b32@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f3lcdY1GhHNaaFOV"
Content-Disposition: inline
In-Reply-To: <20240617-zoology-silica-2c8c78363b32@spud>


--f3lcdY1GhHNaaFOV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 05:44:52PM +0100, Conor Dooley wrote:
> On Sun, Jun 16, 2024 at 03:19:26PM +0200, Krzysztof Kozlowski wrote:
> > Simple syscon nodes can be documented in common syscon.yaml, however
> > devices with simple-mfd compatible, thus with some children, should have
> > their own schema listing these children.  Such listing makes the binding
> > specific, allows better validation (so the incorrect child would not
> > appear in the simple-mfd node) and actually enforces repeated rule for
> > simple-mfd devices:
> >=20
> >   "simple-mfd" is only for simple devices, where the children do not
> >   depend on the parent.
> >=20
> > Currently the syscon+simple-mfd binding is quite broad and allows
> > any child or property, thus above rule cannot be enforced.
> >=20
> > Split the syscon.yaml binding into:
> > 1. Common syscon properties, used potentially by many bindings.
> > 2. Simple syscon devices (NO simple-mfd!).
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
> > ---
> >=20
> > Depends on:
> > 1. Patch in MFD: https://lore.kernel.org/all/171828959006.2643902.83082=
27314531523435.b4-ty@kernel.org/
> > 2. Previous patches in the series.
> > ---
> >  .../devicetree/bindings/mfd/syscon-common.yaml     |  72 +++++
> >  Documentation/devicetree/bindings/mfd/syscon.yaml  | 294 +++++++++++++=
--------
> >  2 files changed, 251 insertions(+), 115 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon-common.yaml b=
/Documentation/devicetree/bindings/mfd/syscon-common.yaml
> > new file mode 100644
> > index 000000000000..c3ff3a7afce3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/syscon-common.yaml
> > @@ -0,0 +1,72 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: System Controller Registers R/W Common Properties
> > +
> > +description: |
>=20
> This | can go, right?
>=20
> > +  System controller node represents a register region containing a set
> > +  of miscellaneous registers. The registers are not cohesive enough to
> > +  represent as any specific type of device. The typical use-case is
> > +  for some other node's driver, or platform-specific code, to acquire
> > +  a reference to the syscon node (e.g. by phandle, node path, or
> > +  search using a specific compatible value), interrogate the node (or
> > +  associated OS driver) to determine the location of the registers,
> > +  and access the registers directly.
> > +
> > +maintainers:
> > +  - Lee Jones <lee@kernel.org>
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
>=20
> And this can be const, given it's unlikely to grow?
>=20
> > +          - syscon
> > +
> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  compatible:
> > +    contains:
> > +      const: syscon
> > +    minItems: 2
> > +    maxItems: 5  # Should be enough
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  reg-io-width:
> > +    description: |
>=20
> Same with this one.
>=20
> > +      The size (in bytes) of the IO accesses that should be performed
> > +      on the device.
> > +    enum: [1, 2, 4, 8]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: simple-mfd
> > +    then:
> > +      properties:
> > +        compatible:
> > +          minItems: 3
> > +          maxItems: 5
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    syscon: syscon@1c00000 {
> > +        compatible =3D "allwinner,sun8i-h3-system-controller", "syscon=
";
> > +        reg =3D <0x01c00000 0x1000>;
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Docume=
ntation/devicetree/bindings/mfd/syscon.yaml
> > index d6fa58c9e4de..d4e9533cf3fe 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > @@ -4,7 +4,7 @@
> >  $id: http://devicetree.org/schemas/mfd/syscon.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> > =20
> > -title: System Controller Registers R/W
> > +title: System Controller Devices
> > =20
> >  description: |
> >    System controller node represents a register region containing a set
> > @@ -19,123 +19,196 @@ description: |
> >  maintainers:
> >    - Lee Jones <lee@kernel.org>
> > =20
> > +# Need a select with all compatibles listed for compatibility with old=
er
> > +# dtschema (<2024.02), so this will not be selected for other schemas =
having
> > +# syscon fallback.
> >  select:
> >    properties:
> >      compatible:
> >        contains:
> >          enum:
> > -          - syscon
>=20
> Wow, this is noisy. Is it not possible to achieve something similar by
> making the select check for not: compatible: contains: simple-mfd? Or
> did I misunderstand the intention here?

Ah, you'd match things then like the intel,lgm-syscon, right?

--f3lcdY1GhHNaaFOV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnBoYwAKCRB4tDGHoIJi
0uYIAP9U0vg1Om+wI+Ea8a94/cOvSL1g+49lge2yhs2csIzjoQD+MDs+0h94sqXN
B3YNAZJSO//xDpVCwRLiP51eOKZJCQU=
=xOgQ
-----END PGP SIGNATURE-----

--f3lcdY1GhHNaaFOV--

