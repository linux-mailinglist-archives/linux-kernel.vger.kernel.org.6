Return-Path: <linux-kernel+bounces-396913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFA19BD428
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C081C22301
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C3B1F12F2;
	Tue,  5 Nov 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXPa2yZb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3023D1E7677;
	Tue,  5 Nov 2024 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829960; cv=none; b=tBwkP0v5bj0tyY4yEKg/ckM3/Uxme4jYc7YotBKZIaHsiY/BbHD3UDzXHajOyOrdFIYLIZy7VnUSmHnaJLnGNmN0hUn5J+yt+uZs4H6BvfDVpp7rdxmvFaXN1Xk/MeDc8ZyQ4OKWzbnniyUN6gyeT2g65h+FsLEKxr6B32paN/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829960; c=relaxed/simple;
	bh=FA8YasXCkWty96pqWC0zbLicpOpd5y8Au/gsIejDV2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0Jc0rnFDI1Kw+SKtiqyAHx0I1UHaPAwu25vDYpu7Ha9OEQNL5Bkk6ab4s6ilonfNvccY3bXXR8I1SQGtGG6ZaY/QlxQRUGNsH2Y3T7+ifNlgxj0zTFoO3XWPhV6MtP29ZzBOxdeOam1xQVTrSZDEOqK6XVsHa3NinZ34Xa/IjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXPa2yZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C10C4CED1;
	Tue,  5 Nov 2024 18:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730829959;
	bh=FA8YasXCkWty96pqWC0zbLicpOpd5y8Au/gsIejDV2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXPa2yZbl/YzFD6fN4IXrDTqd8EwkmHkksEM8AHSCKJIe5fBIMXKc59E24o2vevU7
	 F2Ky3cwcsfqyKhbJRbeLpmreL3FYIzP/Cnrs4yI1gZbOXE/WJHbsF8l1nToXJ16qi5
	 ax6x+yTZg+dbK7mXDVBLqVgy582W8oySuJApcK9ugfntggedBUYWjYAnwv9g3yRB6r
	 pOsFUKhR+L7C1qeJdHFtJitcQu3U/Jrvy71zMhrEWSU+t6AmJoPsLuPFWz3OQiOZ2a
	 2KSA5SPrmgJiJCoLNrQbyg4TvEzEJqUaF/HLw9xgNi2IhIsBCPDDFADHvp0kuIhkSd
	 FXPH0XThYaJgg==
Date: Tue, 5 Nov 2024 18:05:54 +0000
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
Message-ID: <20241105-disarm-baggie-e2563299a24f@spud>
References: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
 <20241105-sets-bxs-4-64-patch-v1-v1-3-4ed30e865892@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RoFUdNR+eVTM1NxM"
Content-Disposition: inline
In-Reply-To: <20241105-sets-bxs-4-64-patch-v1-v1-3-4ed30e865892@imgtec.com>


--RoFUdNR+eVTM1NxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 03:58:09PM +0000, Matt Coster wrote:
> The single existing GPU (AXE-1-16M) only requires a single power domain.
> Subsequent patches will add support for BXS-4-64 MC1, which has two power
> domains. Add infrastructure now to allow for this.
>=20
> Signed-off-by: Matt Coster <matt.coster@imgtec.com>
> ---
>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 29 ++++++++++++++++=
+++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml=
 b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index 6924831d3e9dd9b2b052ca8f9d7228ff25526532..55f422be1bc5b7564e3e81f24=
c4b93857f3e12fe 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -49,7 +49,16 @@ properties:
>      maxItems: 1
> =20
>    power-domains:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  power-domain-names:
> +    oneOf:
> +      - items:
> +          - const: a
> +      - items:
> +          - const: a
> +          - const: b
> =20
>  required:
>    - compatible
> @@ -57,10 +66,27 @@ required:
>    - clocks
>    - clock-names
>    - interrupts
> +  - power-domains
> +  - power-domain-names

A new required property is an ABI break. Please explain why this is
acceptable in your commit message.

> =20
>  additionalProperties: false
> =20
>  allOf:
> +  # Cores with a single power domain
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            anyOf:
> +              - const: img,img-axe-1-16m
> +    then:
> +      properties:
> +        power-domains:
> +          minItems: 1
> +          maxItems: 1
> +        power-domain-names:
> +          items:
> +            - const: a
>    # Vendor integrations using a single clock domain
>    - if:
>        properties:
> @@ -90,4 +116,5 @@ examples:
>          clock-names =3D "core";
>          interrupts =3D <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
>          power-domains =3D <&k3_pds 187 TI_SCI_PD_EXCLUSIVE>;
> +        power-domain-names =3D "a";
>      };
>=20
> --=20
> 2.47.0
>=20

--RoFUdNR+eVTM1NxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZypegQAKCRB4tDGHoIJi
0hvYAP41d81+vVbGwurEhXKOPcmyx+xk6+iazN0Bol8EGVlghgEAg8Np/YUjcJ45
HQFB+cbVr2jjAxIggFlx2U/eGOrdAA0=
=CO6v
-----END PGP SIGNATURE-----

--RoFUdNR+eVTM1NxM--

