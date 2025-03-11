Return-Path: <linux-kernel+bounces-556936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464CBA5D0F9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E7817C2F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3B62638BA;
	Tue, 11 Mar 2025 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBFZi2TO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71A1C6FFD;
	Tue, 11 Mar 2025 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741725984; cv=none; b=MXVxPxsUN0mo4TqN8qjHKn1lpghM9cRLgfbIaNufSJNj6sW3rl55Lwe6xJGi/ihv58nuobvMyUpgIf7S0TlIk7rpQGAU7OTOJgmUAKDHg+0jMEQ5bFdpcYGch73BJyeLCKh48q2xFTBMaBQZiU4NVcBK58HRZfyycphinXwFtIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741725984; c=relaxed/simple;
	bh=LbZesismxX7E9wcOE1PTIHl6vTm03qtzd8ZKWTPOcRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2G5an3JMPEC3/GEiBBuL2onJLvBz9Lm20nx3vXtySpE6Z8z8GSElBZFf9T3tHJdmfyiP4kkxtqD2JXx41KREiEq2hOvjdI6y38dFNfSbM/GrZYKzo5aXYLalyTlUBCysSIsI2zzmpSdP2FcqeWxKgBpI5r8RYOpDQACDEYzvAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBFZi2TO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392C2C4CEE9;
	Tue, 11 Mar 2025 20:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741725983;
	bh=LbZesismxX7E9wcOE1PTIHl6vTm03qtzd8ZKWTPOcRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBFZi2TOz7HAhBovwML44NZQj/uAJfAsdgSh9L5DFXRZ5816zHWO5Pbl54ee3KTy7
	 ZdLN3d4+gwSYJdiaaAUv8E8dIht/xklWyxmJj9tgEEMwzScXe9JQaCtLY2Mqr4OqLT
	 msB72ui9conHDuqp2ww2OcYY4nJog2XYT7Io5CbjgeuVt6r8kHLzHHtQRVnsiTYXJu
	 kIVoJkdanGR6imvlXsqbrxV77cG0e7mgc+VR3KawS6UF8PE1+FRFpM1fasm3L+iyAU
	 D7Inp3bEEtmLyaTcfh8F2xbAgN3JhoMMPr6pjI3udgJ+fvthsjZ1+zRnODXGcVOV8g
	 lRTSo1tU8QBfg==
Date: Tue, 11 Mar 2025 20:46:18 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Nick Hu <nick.hu@sifive.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: timer: Add SiFive CLINT2
Message-ID: <20250311-erasure-rival-f68525c21742@spud>
References: <20250311051903.3825-1-nick.hu@sifive.com>
 <20250311195953.GA14239-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0fd6JZQkWEDyMXyS"
Content-Disposition: inline
In-Reply-To: <20250311195953.GA14239-robh@kernel.org>


--0fd6JZQkWEDyMXyS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 02:59:53PM -0500, Rob Herring wrote:
> On Tue, Mar 11, 2025 at 01:19:03PM +0800, Nick Hu wrote:
> > Add compatible string and property for the SiFive CLINT v2.
> >=20
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> > ---
> >  .../bindings/timer/sifive,clint.yaml          | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml =
b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > index 76d83aea4e2b..93d74c504b5f 100644
> > --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > @@ -36,6 +36,9 @@ properties:
> >                - starfive,jh7110-clint   # StarFive JH7110
> >                - starfive,jh8100-clint   # StarFive JH8100
> >            - const: sifive,clint0        # SiFive CLINT v0 IP block
>=20
> Notice that we don't allow clint0 by itself. We shouldn't start now.
>=20
> > +      - items:
>=20
> If you don't have a specific one yet, then add '- {}' for the first=20
> entry.
>=20
> > +          - const: sifive,clint2        # SiFive CLINT v2 IP block
> > +        description: SiFive CLINT v2 is the HRT that supports the Zicn=
tr
> >        - items:
> >            - enum:
> >                - allwinner,sun20i-d1-clint
> > @@ -62,6 +65,22 @@ properties:
> >      minItems: 1
> >      maxItems: 4095
> > =20
> > +  sifive,fine-ctr-bits:
> > +    description: The width in bits of the fine counter.
>=20
> maximum: 15
>=20
> Unless you know of a different maximum in which case why aren't you=20
> documenting that too?

I'm curious why this is not something that can be discerned from the
compatible. It's max 15, but are there actually versions of this with a
less-than-15-bit width?

>=20
> > +
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: sifive,clint2
> > +then:
> > +  properties:
> > +    sifive,fine-ctr-bits:
> > +      maximum: 15
> > +else:
> > +  properties:
> > +    sifive,fine-ctr-bits: false
> > +
> >  additionalProperties: false
> > =20
> >  required:
> > --=20
> > 2.17.1
> >=20

--0fd6JZQkWEDyMXyS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ9ChGgAKCRB4tDGHoIJi
0ihcAQCvzEPh3CyOg5RGcbc3WFKyP9lEHbdVA1DmpDaT0ef8PQEA8lE22unjuWly
UWaSwzt3ffOJka+dyI5Lh24LUPlymws=
=7hoV
-----END PGP SIGNATURE-----

--0fd6JZQkWEDyMXyS--

