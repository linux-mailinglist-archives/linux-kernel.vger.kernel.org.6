Return-Path: <linux-kernel+bounces-519940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC47A3A3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF98172715
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18324270ED2;
	Tue, 18 Feb 2025 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdZJ40HP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F61326FA53;
	Tue, 18 Feb 2025 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898575; cv=none; b=q5lwHdwMUE5uYxIF5s2nbxMI8WSJ5wDLSvZW08Djyc85FD1W6PNhOAxtopQxFLmCvdpGESAz/JAbPyqKlYGuoWITBC0JRIQjVkFSoNchyRoqRYe0W7LNKoRelADtwgp+nJ1lkPzeifvStg5N89LpJiZ9ZTdPJ7JBxRU238/AcA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898575; c=relaxed/simple;
	bh=rxpL1H7O2VdHAvI1ZRjYb0VzrGNCU0nMXi6S7wu99H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEyyznePBb0+cv9crmeqyHXw7r40VfB2iZj4uG00Fw8C5gb5YPljrhY/CfLD2xqWMgjJqW3IqinhlwwmN4ztnuRqYFwYjyeY8bPwJ+ihhcZPKOpVGUeoT99VnEv63mNPSmqzreFLoUloTVy8CTVwNUA1k9k3EeqmRhhWuUAC558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdZJ40HP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7E2C4CEE2;
	Tue, 18 Feb 2025 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739898574;
	bh=rxpL1H7O2VdHAvI1ZRjYb0VzrGNCU0nMXi6S7wu99H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SdZJ40HPDjbGBAAp/Gk+/O3GJowuyU+8HdtKvFrmPDevJxdMmUC4aP7mnTDLd9Ty6
	 DPdMFf7eOhEp5sSV/2KSbmAsleS09gRWkg+U1Cbtqv1IMdYxGlkUz9E4NzLiIb35mC
	 DMCrUu3Jnmdtm9u0+3Z1hwTNA6l8D7Jb/g9mYzHRlgjLMC4Zj3+vc5QkzAy53DurTK
	 Mi6ysZ8RTkiTknEhHYskbIFo2VevqC8WQNBXADXuKu9dXdl97MxYFh7AL+jqqfeRHH
	 A3lzDr7TYXmlBGpmaijRa0ygexxjCUD5lySTqETOdluD7/H4Xh41JQaa1CgUOIvCuv
	 tvDSdUMlsc+WA==
Date: Tue, 18 Feb 2025 17:09:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: display: bridge: Document Solomon
 SSD2825
Message-ID: <20250218-thinly-passcode-f659d81cd5a4@spud>
References: <20250213135605.157650-1-clamor95@gmail.com>
 <20250213135605.157650-2-clamor95@gmail.com>
 <20250213-pumice-overcrowd-6c22b0d5d66c@spud>
 <CAPVz0n1CpoAFvwwvoTOFQu4mgg57jCwS5W4GXCiUZ3eLEAdwZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jUeovMtJEMp6ohsP"
Content-Disposition: inline
In-Reply-To: <CAPVz0n1CpoAFvwwvoTOFQu4mgg57jCwS5W4GXCiUZ3eLEAdwZA@mail.gmail.com>


--jUeovMtJEMp6ohsP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 08:29:22AM +0200, Svyatoslav Ryhel wrote:
> =D1=87=D1=82, 13 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 22:34 Co=
nor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Thu, Feb 13, 2025 at 03:56:04PM +0200, Svyatoslav Ryhel wrote:
> > > Add bindings for Solomon SSD2825 MIPI master bridge chip that connect=
s an
> > > application processor with traditional parallel LCD interface and an =
LCD
> > > driver with MIPI slave interface. The SSD2825 supports both parallel =
RGB
> > > interface and serial SPI interface.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../display/bridge/solomon,ssd2825.yaml       | 140 ++++++++++++++++=
++
> > >  1 file changed, 140 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/bridge/=
solomon,ssd2825.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/solomon=
,ssd2825.yaml b/Documentation/devicetree/bindings/display/bridge/solomon,ss=
d2825.yaml
> > > new file mode 100644
> > > index 000000000000..cd7ff971495c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/bridge/solomon,ssd282=
5.yaml
> > > @@ -0,0 +1,140 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/bridge/solomon,ssd2825.ya=
ml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Solomon SSD2825 RGB to MIPI-DSI bridge
> > > +
> > > +maintainers:
> > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: solomon,ssd2825
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  reset-gpios: true
> > > +
> > > +  dvdd-supply:
> > > +    description: Regulator for 1.2V digital power supply.
> > > +
> > > +  avdd-supply:
> > > +    description: Regulator for 1.2V analog power supply.
> > > +
> > > +  vddio-supply:
> > > +    description: Regulator for 1.8V IO power supply.
> > > +
> > > +  spi-max-frequency:
> > > +    maximum: 1000000
> > > +
> > > +  spi-cpha: true
> > > +  spi-cpol: true
> >
> > Should these be required? Supplies should really be required too, since
> > the device probably cannot function without them?
> >
>=20
> No, since spi-* define mode in which device works. If both are present
> it is mode 3, if none it is mode 0.
>=20
> About supplies, device cannot work without power supply obviously, but
> often exact supplies are not known and I would like to not enforce
> someone to add random regulators just because they are mandatory.

If the device doesn't work without the supplies, the supplies should be
mandatory in the binding.

>=20
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  clock-names:
> > > +    const: tx_clk
> >
> > Drop the _clk, since this cannot be anything else! clock-names isn't
> > really useful when you have just one, so I'd be inclined to say remove
> > it entirely...
> >
>=20
> TX_CLK is the name which datasheet refers to hence I have included
> clock name solely to have clear link between datasheet clock
> references and clock used here.

I think people will be able to make the leap between "tx_clk" and "tx".

>=20
> > > +  solomon,hs-zero-delay-ns:
> > > +    description:
> > > +      HS zero delay period
> > > +    default: 133
> > > +
> > > +  solomon,hs-prep-delay-ns:
> > > +    description:
> > > +      HS prep delay period
> > > +    default: 40
> >
> > Do these two have limits? Use maximum/minimum to set them if so.
> > Cheers,
> > Conor.
> >
>=20
> Datasheet does not specify limits actually, only defaults. I will try
> to calculate boundaries.

Hmm, that's interesting. I see in your driver that the eventual value
gets converted down to a u8? That should at least impose some sort of
limits I guess.

--jUeovMtJEMp6ohsP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7S+yQAKCRB4tDGHoIJi
0tZ9AP9JAAMNXWYdg/TBy4XNztE8Ae+dUaENkSycA9YxR2kLWwD+MJ4f+T6TzYEM
ubzOjZtfD6wNXLAjlV5bLvbS6nd6YAU=
=lSJg
-----END PGP SIGNATURE-----

--jUeovMtJEMp6ohsP--

