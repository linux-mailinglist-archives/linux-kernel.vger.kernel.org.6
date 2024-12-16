Return-Path: <linux-kernel+bounces-448039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4639F3A36
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3C81888A56
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AE920C497;
	Mon, 16 Dec 2024 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaJ7W90r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE09205AA8;
	Mon, 16 Dec 2024 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734378659; cv=none; b=UOkR5Yz2mSdi5GwfB5sWkux9ialkPQPdhoMPs7ZP8WAh8dyUXTJ+b23ZL8OAelvjeewFCMub6RuDuI8fqsisdr5zWtam0f5kepgts++Td1vDnXFBQkFoF8O3bwNgazJg+/9U+jq5YJ2hbcQWIM0ZSO9HuHLysEgPxNfgtWwVbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734378659; c=relaxed/simple;
	bh=DCENrOvzdQr/kVc1IkdcNpE1zRhi24sD9OPqr7cgrd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrKTwlFakOzYMkEcDeyW9wOepn5Ew9nsPJJ6teC+UQaxdhkGL1FgTAflysvjtyZNlodZ+NGW+Z/S859Yte6Pz967kUp7R8CVGaW9tjv1nvpoPKkuDwqdQ1ai3lPPJiBGXqPcj5KXt5yAbsh2h5C0EoOH/b/BHisSl5Cuoh3Bx1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaJ7W90r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193EFC4CED0;
	Mon, 16 Dec 2024 19:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734378658;
	bh=DCENrOvzdQr/kVc1IkdcNpE1zRhi24sD9OPqr7cgrd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EaJ7W90r0NH1YcpXzq/MObcJhIwJpFskVv8yOHb4b50pzHCRZrcv2xGOXH8HMvn6o
	 j6kqOzpUYKqIMXrWxQBCeiq7mEMCNwSm88t1vAQy0koidh9Nofph6gi6Z+1wR37j1G
	 8XT7ByEO3m9UJZ0xu9JQLDKPHIvd91jcIup4AxSvncC/d7Q+H2S1hWLeUqdt3cElYQ
	 9ZndKGBy1a214SUZ1ap1VEYOVQzFnvlRmFPYlAUn1GWunCDQNFoM7oxDzgp8x5AkM9
	 64ybcID98YsAKdTNQa5Bzq5+z907uiNK1iE0CJhwLgkCh2yWoy7J3+zM4jw4QqTQvN
	 xQpRmhBd00OQw==
Date: Mon, 16 Dec 2024 19:50:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Frieder Schrempf <frieder@fris.de>,
	linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>, Joy Zou <joy.zou@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 03/11] dt-bindings: regulator: pca9450: Document
 nxp,sd-vsel-fixed-low property for LDO5
Message-ID: <20241216-reburial-turmoil-4825bbee6aa8@spud>
References: <20241127164337.613915-1-frieder@fris.de>
 <20241127164337.613915-4-frieder@fris.de>
 <20241128-endanger-envy-d1b19f650b38@spud>
 <9276fad1-0e3c-4935-a62a-1580af2e0a4b@kontron.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Mv3VqQIkN3EYFrXr"
Content-Disposition: inline
In-Reply-To: <9276fad1-0e3c-4935-a62a-1580af2e0a4b@kontron.de>


--Mv3VqQIkN3EYFrXr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 04:36:41PM +0100, Frieder Schrempf wrote:
> On 28.11.24 6:33 PM, Conor Dooley wrote:
> > On Wed, Nov 27, 2024 at 05:42:19PM +0100, Frieder Schrempf wrote:
> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>
> >> This new property can be used for boards which have the SD_VSEL tied
> >> to a fixed low level. The voltage of LDO5 is therefore only controlled
> >> by writing to the LDO5CTRL_L register.
> >>
> >> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >> ---
> >> Changes for v2:
> >> * new patch
> >> ---
> >>  .../bindings/regulator/nxp,pca9450-regulator.yaml           | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-r=
egulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-reg=
ulator.yaml
> >> index 5d0d684186c96..0e19c54aa5f8a 100644
> >> --- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulato=
r.yaml
> >> +++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulato=
r.yaml
> >> @@ -49,6 +49,12 @@ properties:
> >>            Properties for single LDO5 regulator.
> >> =20
> >>          properties:
> >> +          nxp,sd-vsel-fixed-low:
> >> +            type: boolean
> >> +            description:
> >> +              Let the driver know that SD_VSEL is hardwired to low le=
vel and
> >> +              there is no GPIO to get the actual value from.
> >=20
> > Does this mean that if you don't provide the property or a GPIO it is t=
ied
> > high or High-Z? If so, please mention it here. More likely, given the
> > context of this patch, no gpio and no tied low property means the driver
> > should handle things as they used to be - but you should call that out
> > in your commit message to be clear.
>=20
> Providing neither 'sd-vsel-gpios', nor 'nxp,sd-vsel-fixed-low' means the
> driver has to assume that SD_VSEL is tied high and it has to use the
> LDO5CTRL_H for voltage control.
>=20
> I will make this more clear in the commit message.
>=20
> This is the original/current behavior of the driver, though it doesn't
> match the actual hardware as all known boards actually have the SD_VSEL
> connected to the USDHC_VSELECT (which changes state whenever the USDHC
> controller wants to switch IO voltage).

That's fine, as long as it is a match for the old behaviour. Sorry for
the delay responding, I was unexpectedly AFK last week.

>=20
> Getting rid of this mismatch is one of the main motivations for this seri=
es.
>=20
> >=20
> >> +
> >>            sd-vsel-gpios:
> >>              description:
> >>                GPIO that can be used to read the current status of the=
 SD_VSEL
> >> --=20
> >> 2.46.1
> >>
>=20

--Mv3VqQIkN3EYFrXr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2CEnQAKCRB4tDGHoIJi
0oetAP9Pu1rjpU+pdzrm+eH6iXyG806l63oOj31Uyy4uLHkwsQD2JBjIL+4gCPRG
BRzqvKOglizkXPaKI5xuRY1P6rmvBA==
=XLsF
-----END PGP SIGNATURE-----

--Mv3VqQIkN3EYFrXr--

