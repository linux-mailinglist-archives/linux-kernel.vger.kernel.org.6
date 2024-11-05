Return-Path: <linux-kernel+bounces-396924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E1E9BD466
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4782D1C2363A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EAB1E7664;
	Tue,  5 Nov 2024 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHgQ8Ljq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729613D51E;
	Tue,  5 Nov 2024 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830602; cv=none; b=Vj5XUCt+6R46EY0eVuR0M8c735XQEZjMfjbGEqJhOTMpn45P3/H3QcBfesRZg+ooX3oUcnZ5c/rc8/sCkLEgpEjtaLBnJ0kYRcdYmdJnjJzDL0uB3xKUggB2aCguEFQScn5wxZZgPTabHwqHv3+ABsWlWUsQT5w8NAM3sn4yeA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830602; c=relaxed/simple;
	bh=gxbmixww9e8I54+a85Lk0u6Qwx29iopkn1bwWVNFU5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv8fvxX20WytRbx4OnUTdFLHyhaXJX4bmgFMf/w/xxgczTHH7itjFPFwsMb4pSeQnkcryc1AoI2p5fvA9bUHehO7prbE0yQH82NCKsqEa+MBMsfQ9HDafBCTLzMiaIARKmaTS6M7KZoNojat0IiWm9+71EHcsTJbK/D2qfKY4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHgQ8Ljq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BA4C4CECF;
	Tue,  5 Nov 2024 18:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730830602;
	bh=gxbmixww9e8I54+a85Lk0u6Qwx29iopkn1bwWVNFU5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHgQ8LjqxMiYEcG4CIthiY+qyb8BJdbl9bqOF8Vdv1Giz2jL4Qm+VprGqVquRtP11
	 csBm24NGhMOP9JX4x7Dm7bLaabuorAtEVqVAXySPJ2TTvMAtgvgaodmQA82oUpllaB
	 wuIZbJuGQcYZoEXft7YQ2osOP+9l9i4gK49e+YHxH+iYuBvEBNSYIhaAbKGLuF47Ti
	 SwkXgjjDYM64f5w1DsnZjNE/5Z5QAZ5kQRpPDinJ5HglGx9bPZgv/WZPR0ggoAPAJe
	 2Na7tgqYoQRtHFwnL1zdfmLBedKBXJi//RPvNNJNkbej5IWHuxpgZeXlfITLKBf1Ow
	 UgehZeMzcKlkw==
Date: Tue, 5 Nov 2024 18:16:36 +0000
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
Subject: Re: [PATCH 02/21] dt-bindings: gpu: img: Further constrain clocks
Message-ID: <20241105-blooper-unflawed-6181022944d9@spud>
References: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
 <20241105-sets-bxs-4-64-patch-v1-v1-2-4ed30e865892@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TeFaw0Jl+M7/bDvg"
Content-Disposition: inline
In-Reply-To: <20241105-sets-bxs-4-64-patch-v1-v1-2-4ed30e865892@imgtec.com>


--TeFaw0Jl+M7/bDvg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 03:58:08PM +0000, Matt Coster wrote:
> All Imagination GPUs use three clocks: core, mem and sys. All reasonably
> modern Imagination GPUs also support a single-clock mode where the SoC
> only hooks up core and the other two are derived internally. On GPUs which
> support this mode, it is the default and most commonly used integration.
>=20
> Codify this "1 or 3" constraint in our bindings and hang the specifics off
> the vendor compatible string to mirror the integration-time choice.
>=20
> Signed-off-by: Matt Coster <matt.coster@imgtec.com>
> ---
>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 27 +++++++++++++++-=
------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml=
 b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index ef7070daf213277d0190fe319e202fdc597337d4..6924831d3e9dd9b2b052ca8f9=
d7228ff25526532 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -30,15 +30,20 @@ properties:
>      maxItems: 1
> =20
>    clocks:
> -    minItems: 1
> -    maxItems: 3
> +    oneOf:
> +      - minItems: 1
> +        maxItems: 1
> +      - minItems: 3
> +        maxItems: 3

Just put the outer constraints here and...

>    clock-names:
> -    items:
> -      - const: core
> -      - const: mem
> -      - const: sys
> -    minItems: 1
> +    oneOf:
> +      - items:
> +          - const: core
> +      - items:
> +          - const: core
> +          - const: mem
> +          - const: sys
> =20
>    interrupts:
>      maxItems: 1
> @@ -56,15 +61,21 @@ required:
>  additionalProperties: false
> =20
>  allOf:
> +  # Vendor integrations using a single clock domain
>    - if:
>        properties:
>          compatible:
>            contains:
> -            const: ti,am62-gpu
> +            anyOf:
> +              - const: ti,am62-gpu
>      then:
>        properties:
>          clocks:
> +          minItems: 1
>            maxItems: 1

=2E..adjust the constraints in conditional bits. Setting minItems to 1
should be a nop too. Pretty sure what you already had here was actually
already sufficient.

Cheers,
Conor.

> +        clock-names:
> +          items:
> +            - const: core
> =20
>  examples:
>    - |
>=20
> --=20
> 2.47.0
>=20

--TeFaw0Jl+M7/bDvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyphBAAKCRB4tDGHoIJi
0mt+AQCX5TGxUHLmqloLO4UQ2/Z5nICBf/HCL/Q8rZcVfo8ebAEAlFYu7OnzNesz
ZWwQOmVqab0lEHWZg2h1BTjxEg+tFwA=
=fITo
-----END PGP SIGNATURE-----

--TeFaw0Jl+M7/bDvg--

