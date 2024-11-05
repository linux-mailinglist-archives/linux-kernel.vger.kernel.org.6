Return-Path: <linux-kernel+bounces-396918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09809BD448
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967601C22FB7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8583E1E6DFE;
	Tue,  5 Nov 2024 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuy7307N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7301DD0D9;
	Tue,  5 Nov 2024 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830390; cv=none; b=GK1KOvXfwlyDRHsF9jN2UtQuO0nSR/xQQ7LOYV/NLn21Ni6BiNOUxGSIDQ9cMsv/Bp/T4wiaeMsZ+86suPh/kdRHMZATYcEIdB96h9LJEItEKGKAJhqHpEAt7DzLXhpYXF7bsjRATXPuF+rfxcexu7bn5lXC0OFXVfLCQHk69wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830390; c=relaxed/simple;
	bh=pxqB7qCPgf6SdrFqZG7JzmVzNL3Eokwf44mDjUQzHfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mt4pNGyX0r3utI/7toGYIdrIPMnZOwg73Ep0qf2VrsddEcSPw9fYmpalkAaPLuaez0R4APYpctHRYaH4L36hEMhXvEJlHEBip6mBGmkJuDacyq9OcHtXffUc1I5tDuYYvWtKs1AwermsAFXTEZRxcIfkim81BZ7oLUyjkh7oPog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuy7307N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D4DC4CECF;
	Tue,  5 Nov 2024 18:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730830390;
	bh=pxqB7qCPgf6SdrFqZG7JzmVzNL3Eokwf44mDjUQzHfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuy7307NTZAW7l+Q8xtduxKrBLrSSffzLiuD9yd/Evp64dVBZJ+Yv8depWaLxk8dU
	 7f7cKZeUP7FO2Sx7nQRC/0esYs/0R9cdKlFSp2PjHiwxBievF4nwZJZ+aRrx5gTWGe
	 ZhSuvZXPjkrW+fzjwSQO6nVqE2Bzo6qemZSLV2L6gNnwXmREKWZSVvD1HQRP1STjS2
	 Qp+HGKOTtMpl1H5yC4BoSFZhB1aTrL/IPwIhorI5HadxPaDhVZ1ZvkXVKZDwXdgkDb
	 uFiJGIeoPns0ZSRFi6IEJa12b6ulyKiaguMvMgy+uiaLFQd2ZcsOtPDVkBzjgZJrjL
	 oHszmpQmgCyRQ==
Date: Tue, 5 Nov 2024 18:13:04 +0000
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
Subject: Re: [PATCH 01/21] dt-bindings: gpu: img: More explicit compatible
 strings
Message-ID: <20241105-matron-gangway-64e78576ec47@spud>
References: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
 <20241105-sets-bxs-4-64-patch-v1-v1-1-4ed30e865892@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HC9jzF+yIAdMYD3B"
Content-Disposition: inline
In-Reply-To: <20241105-sets-bxs-4-64-patch-v1-v1-1-4ed30e865892@imgtec.com>


--HC9jzF+yIAdMYD3B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 03:58:07PM +0000, Matt Coster wrote:
> The current compatible strings are not specific enough to constrain the
> hardware in devicetree. For example, the current "img,img-axe" string
> refers to the entire family of Series AXE GPUs. The more specific
> "img,img-axe-1-16m" string refers to the AXE-1-16M GPU which, unlike the
> rest of its family, only uses a single power domain.

That's not true, you could apply the rules using the ti,am62-gpu
compatible, no?

> Work is currently underway to add support for volcanic-based Imagination
> GPUs; also add a generic top-level "img,img-rogue" compatible string to
> allow for simpler differentiation in devicetrees.

This makes no sense, how does adding another fallback compatible make
it simpler? I have to assume that this means there will be geothermally
powered axes in the future and you want to tell the difference between
them and those pesky rogue axes that chop the heads off of naughty
children?

>=20
> Make these changes now before introducing more compatible strings to keep
> the legacy versions to a minimum.
>=20
> Signed-off-by: Matt Coster <matt.coster@imgtec.com>
> ---
>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml    | 19 +++++++++++++=
+-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml=
 b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index 256e252f8087fa0d6081f771a01601d34b66fe19..ef7070daf213277d0190fe319=
e202fdc597337d4 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -12,10 +12,19 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - ti,am62-gpu
> -      - const: img,img-axe # IMG AXE GPU model/revision is fully discove=
rable
> +    oneOf:
> +      - items:
> +          - enum:
> +              - ti,am62-gpu
> +          - const: img,img-axe-1-16m
> +          - const: img,img-rogue
> +
> +      # This legacy combination of compatible strings was introduced ear=
ly on before the more
> +      # specific GPU identifiers were used. Keep it around here for comp=
atibility, but never use
> +      # "img,img-axe" in new devicetrees.
> +      - items:
> +          - const: ti,am62-gpu
> +          - const: img,img-axe
> =20
>    reg:
>      maxItems: 1
> @@ -64,7 +73,7 @@ examples:
>      #include <dt-bindings/soc/ti,sci_pm_domain.h>
> =20
>      gpu@fd00000 {
> -        compatible =3D "ti,am62-gpu", "img,img-axe";
> +        compatible =3D "ti,am62-gpu", "img,img-axe-1-16m", "img,img-rogu=
e";
>          reg =3D <0x0fd00000 0x20000>;
>          clocks =3D <&k3_clks 187 0>;
>          clock-names =3D "core";
>=20
> --=20
> 2.47.0
>=20

--HC9jzF+yIAdMYD3B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZypgMAAKCRB4tDGHoIJi
0nC4AQC4AzHjeKvDrm+ExJzNjJmg5LhdaVii97hh964tmhK59QD4jl8H5QIn/+vE
4NZXGn3q7P2E/PvGBSyFkSd9XRUHBw==
=IOI3
-----END PGP SIGNATURE-----

--HC9jzF+yIAdMYD3B--

