Return-Path: <linux-kernel+bounces-398634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AC09BF3EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2BE8B23387
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B517E206E86;
	Wed,  6 Nov 2024 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApH/yve7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188320694E;
	Wed,  6 Nov 2024 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912807; cv=none; b=O1t9X4fVochBZSU2PMI5BkYky46mRRdtjsBpCuSD1ZK1I5l/O/gmTp4wS1oQjzb4euzgkDJqArrJDeC1qGJZIQMaoOUUXDq23aP1od9TVVj6gn4FwuYVAaOfkc6E05VvDKUpxBuFxKmWCMmy+DBUkHd88izcleIN3MTlQ/qrMpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912807; c=relaxed/simple;
	bh=Osy2vFRVeMd9d4xPWdCbKDRnNTUTz3AzLAA1gmYcZWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrayTS6EIWalbbrz0t5Zb5VtI3Co9VqIEiHwIRaLUCzd4PEH3v5X36nIqsFCvt9vsEEWywiyOB4m3xxXZhp22OY5yyV/qRxCnUdteJUg7xQqHWlO1mNLId0+f7U9LY0gCJlwsjHeiiX3F0hRInfZ6ZhBfxaXMCeEm6y6FrUIVDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApH/yve7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD25BC4CECD;
	Wed,  6 Nov 2024 17:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730912806;
	bh=Osy2vFRVeMd9d4xPWdCbKDRnNTUTz3AzLAA1gmYcZWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ApH/yve7hfFkIWz8NxQI4YWwvUKSSr2K0uNrGI9klXB3LWLiZGNYs8aRlsKRuGfIj
	 VeR6RqxMVFmLW3pFprKcjapbxD1pgJo7zdQkYeVsAVXS8iQBMa69l2634SxB7Kp8KU
	 Bpzc2AeuuVggLHHN3wb3cG/5W4e6x7isacM6schd59G/mlAOsY4FwLVOtBXnRfzOO3
	 JmCubQh3b/LNlCJuof5tT/ZPg8qLOqZ7g0R+e+1ysPzxz7Af+9xzeUobz80bRrPhaE
	 cnEPbpcRby6mYK3i3AtzeC6DJscubyPnX25UPDaNcaHRIPHLPmfwjWf2qZrEGH1OjJ
	 /ximySYwjsXow==
Date: Wed, 6 Nov 2024 17:06:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Matt Coster <Matt.Coster@imgtec.com>
Cc: Frank Binns <Frank.Binns@imgtec.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH 02/21] dt-bindings: gpu: img: Further constrain clocks
Message-ID: <20241106-fragment-luckiness-51ccb4bd2b4e@spud>
References: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
 <20241105-sets-bxs-4-64-patch-v1-v1-2-4ed30e865892@imgtec.com>
 <20241105-blooper-unflawed-6181022944d9@spud>
 <5b26e693-d37f-41ee-b119-32ef648de6f4@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7/EssgUtkRYKje0N"
Content-Disposition: inline
In-Reply-To: <5b26e693-d37f-41ee-b119-32ef648de6f4@imgtec.com>


--7/EssgUtkRYKje0N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024 at 10:17:53AM +0000, Matt Coster wrote:
> On 05/11/2024 18:16, Conor Dooley wrote:
> > On Tue, Nov 05, 2024 at 03:58:08PM +0000, Matt Coster wrote:
> >> All Imagination GPUs use three clocks: core, mem and sys. All reasonab=
ly
> >> modern Imagination GPUs also support a single-clock mode where the SoC
> >> only hooks up core and the other two are derived internally. On GPUs w=
hich
> >> support this mode, it is the default and most commonly used integratio=
n.
> >>
> >> Codify this "1 or 3" constraint in our bindings and hang the specifics=
 off
> >> the vendor compatible string to mirror the integration-time choice.
> >>
> >> Signed-off-by: Matt Coster <matt.coster@imgtec.com>
> >> ---
> >>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 27 +++++++++++++=
++-------
> >>  1 file changed, 19 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.y=
aml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> >> index ef7070daf213277d0190fe319e202fdc597337d4..6924831d3e9dd9b2b052ca=
8f9d7228ff25526532 100644
> >> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> >> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> >> @@ -30,15 +30,20 @@ properties:
> >>      maxItems: 1
> >> =20
> >>    clocks:
> >> -    minItems: 1
> >> -    maxItems: 3
> >> +    oneOf:
> >> +      - minItems: 1
> >> +        maxItems: 1
> >> +      - minItems: 3
> >> +        maxItems: 3
> >=20
> > Just put the outer constraints here and...
> >=20
> >>    clock-names:
> >> -    items:
> >> -      - const: core
> >> -      - const: mem
> >> -      - const: sys
> >> -    minItems: 1
> >> +    oneOf:
> >> +      - items:
> >> +          - const: core
> >> +      - items:
> >> +          - const: core
> >> +          - const: mem
> >> +          - const: sys
> >> =20
> >>    interrupts:
> >>      maxItems: 1
> >> @@ -56,15 +61,21 @@ required:
> >>  additionalProperties: false
> >> =20
> >>  allOf:
> >> +  # Vendor integrations using a single clock domain
> >>    - if:
> >>        properties:
> >>          compatible:
> >>            contains:
> >> -            const: ti,am62-gpu
> >> +            anyOf:
> >> +              - const: ti,am62-gpu
> >>      then:
> >>        properties:
> >>          clocks:
> >> +          minItems: 1
> >>            maxItems: 1
> >=20
> > ...adjust the constraints in conditional bits. Setting minItems to 1
> > should be a nop too. Pretty sure what you already had here was actually
> > already sufficient.
> >=20
> > Cheers,
> > Conor.
>=20
> Is there an implicit constraint ensuring "clocks" and "clock-names" are
> the same size? I wasn't sure if we could rely on that, hence the
> slightly odd constraint on "clocks". The only real goal here is to
> codify that you can't have one of "mem" or "sys". it's both or nothing.

You can just constrain clock-names: maxItems: 1 like you have already
done for clocks. The items list that was already in the file enforces
that the first clock provided must be core. When you add your new
compatible you can set clock{-names}: minItems: 3 for it, and that will
ensure that either 1 clock (core) or all 3 are the only options.

--7/EssgUtkRYKje0N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyuiIAAKCRB4tDGHoIJi
0jRkAQDGZQfnlzA6wVW+zIxouu+T1KIMoChkv7UzyuIaXs06nAEAmyPWR4iVUQZq
mzvYlkKzFEVKWuN3OjfBXjh9lFrzVQI=
=IFE4
-----END PGP SIGNATURE-----

--7/EssgUtkRYKje0N--

