Return-Path: <linux-kernel+bounces-396919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDC89BD452
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141C0283282
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485F81E7642;
	Tue,  5 Nov 2024 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/Y+TCUd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FD74D8D0;
	Tue,  5 Nov 2024 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830436; cv=none; b=eQInqtJQR8WEg+lCSWRAq6DDVFhev5vl5iFw7vTZFUnlubKHTVWJQV0mryD3y5BQ4ffJ4WlQ0na6kzd+RqoPhiwXfAzYzxGoYfx4SRABAnHa4kDYll9ubkDM0aKgvI0tIjyE/zdxE3XjlcVu123uWaZuWPMJ1IUXs5127JTgcvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830436; c=relaxed/simple;
	bh=j/hVO0QTQ7lh4OLZKHXt9OfuNaNn7hMoHNsw5w3AxGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEaMpEIKbC/C0Eo0LSbKp4YRMB+YxUFO8bDQeBk0B2gqeptkJ/HqxnTOJfnm/odUKi81VG7G0oZpnZOVYfmPQ07xF1qMUdejNShD7yoZvwlJVZdcSqDul1wic4/W/vy8f9ZjTlIVrm8liuxof59E/KULEvgMghvWiAZGJuaHpM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/Y+TCUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ADFC4CECF;
	Tue,  5 Nov 2024 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730830436;
	bh=j/hVO0QTQ7lh4OLZKHXt9OfuNaNn7hMoHNsw5w3AxGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t/Y+TCUd+UCPFyz/QmYOaNyOrEY1F37aPU3mTkW94gcgl6YKusgTFEavVQPhoeeIv
	 1g25+SjPc863n/03n17Q8U9+vubjmu/gxSHJ0FwrPO41zjM8FNNp/gP6dEqmG2n2er
	 9KW3n3/R4c6vJ6TiAAjCbiqNirR7q4OgkSP0BBfkg+Xvp50q9Z6R92N4hnJtltMI75
	 ssHBAEY7YDX0LcU08JrKl6NgWaUBPwVHaIqAiXKsce8YC8up4aOciVTBdIPAsHEtd2
	 AXxX75o5LueqSOLgkNBl21uKzU1/+LmOy1z8R6Upf1iga/VyFvU/LwZF8e2frzRNN+
	 REGnoAwCz4KmQ==
Date: Tue, 5 Nov 2024 18:13:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Matt Coster <matt.coster@imgtec.com>
Cc: Frank Binns <frank.binns@imgtec.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Randolph Sapp <rs@ti.com>,
	Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH 03/21] dt-bindings: gpu: img: Power domain details
Message-ID: <20241105-endearing-huddling-30728a002321@spud>
References: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
 <20241105-sets-bxs-4-64-patch-v1-v1-3-4ed30e865892@imgtec.com>
 <20241105-disarm-baggie-e2563299a24f@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h6DOoDpaBp8hRAn5"
Content-Disposition: inline
In-Reply-To: <20241105-disarm-baggie-e2563299a24f@spud>


--h6DOoDpaBp8hRAn5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 06:05:54PM +0000, Conor Dooley wrote:
> On Tue, Nov 05, 2024 at 03:58:09PM +0000, Matt Coster wrote:
> > The single existing GPU (AXE-1-16M) only requires a single power domain.
> > Subsequent patches will add support for BXS-4-64 MC1, which has two pow=
er
> > domains. Add infrastructure now to allow for this.
> >=20
> > Signed-off-by: Matt Coster <matt.coster@imgtec.com>
> > ---
> >  .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 29 ++++++++++++++=
+++++++-
> >  1 file changed, 28 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.ya=
ml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > index 6924831d3e9dd9b2b052ca8f9d7228ff25526532..55f422be1bc5b7564e3e81f=
24c4b93857f3e12fe 100644
> > --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > @@ -49,7 +49,16 @@ properties:
> >      maxItems: 1
> > =20
> >    power-domains:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  power-domain-names:
> > +    oneOf:
> > +      - items:
> > +          - const: a
> > +      - items:
> > +          - const: a
> > +          - const: b

Additionally, a & b? Are those actually the names for the power domains?

> > =20
> >  required:
> >    - compatible
> > @@ -57,10 +66,27 @@ required:
> >    - clocks
> >    - clock-names
> >    - interrupts
> > +  - power-domains
> > +  - power-domain-names
>=20
> A new required property is an ABI break. Please explain why this is
> acceptable in your commit message.
>=20
> > =20
> >  additionalProperties: false
> > =20
> >  allOf:
> > +  # Cores with a single power domain
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            anyOf:
> > +              - const: img,img-axe-1-16m
> > +    then:
> > +      properties:
> > +        power-domains:
> > +          minItems: 1
> > +          maxItems: 1
> > +        power-domain-names:
> > +          items:
> > +            - const: a
> >    # Vendor integrations using a single clock domain
> >    - if:
> >        properties:
> > @@ -90,4 +116,5 @@ examples:
> >          clock-names =3D "core";
> >          interrupts =3D <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> >          power-domains =3D <&k3_pds 187 TI_SCI_PD_EXCLUSIVE>;
> > +        power-domain-names =3D "a";
> >      };
> >=20
> > --=20
> > 2.47.0
> >=20



--h6DOoDpaBp8hRAn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZypgXgAKCRB4tDGHoIJi
0tmqAP9uwcomPx5whZkcSbKHa8dRJnwZZX53eRiq8F+FqIWxuAD6A6vFpCuNo4V0
stf8zberB2p7Bwefhwsl5aJGNmHl/QY=
=EWBb
-----END PGP SIGNATURE-----

--h6DOoDpaBp8hRAn5--

