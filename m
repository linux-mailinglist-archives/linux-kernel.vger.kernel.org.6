Return-Path: <linux-kernel+bounces-396914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AFF9BD42A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE301C22018
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BEE1E572D;
	Tue,  5 Nov 2024 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH3nvH1w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0754D8D0;
	Tue,  5 Nov 2024 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830010; cv=none; b=FILkalsFgFWIkMuV/ONMO8m4eh1POYvTWGRPX+h/Ew0/bQNPl75fdAh0golKhiBkdQ8w0V73e3WzDpO6H9b3y5jnVNvUtf3yrSjtwB1JzsC/9FdTnwNPFJ1wlBW8PYS3RJT5vR+oMpae1VlYg6iCuMXXOpx+m2PRiey9maF8SLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830010; c=relaxed/simple;
	bh=ocjrByOas5NhchIJiVvTx3nmU3SUFZrLi1qRmcnrqgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnJep9WU0AbuGUMDJtb8P5Ffy8qIETIve79SvF6FcajfGd5TVcksHEN/FyMPFCkV1YoNUcXEdlgm6UY6IfmmgqGxTzehRXwFGEWDYwVQWJeK31Y3m+3YW5yx/xjQQVLwyYLjJfJSDyzlbX79P6jHEiLuY1SF0qp05FCzUIA8F0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH3nvH1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2976C4CECF;
	Tue,  5 Nov 2024 18:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730830010;
	bh=ocjrByOas5NhchIJiVvTx3nmU3SUFZrLi1qRmcnrqgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KH3nvH1wKtgOAdbmdI25MGBzoIlIZUU0DuJoNlsOeVJbdZaTVD/pW1K3FTVrB6Uf0
	 FQnD2oWWlqeGpexF2tlqglZqcOcH0PB7QFh43/YKzrV5jbzi3liphlOSt343dBgHcZ
	 Qw8qdPcknJdMN8rtEvlquuSLJnnf668tZfMgkK3MzlZvpByh+JmtXASIW6n3f08vmP
	 fEu1+Y7fgreG8qwTvA9Coor9F2HXC7Irq258xMtSZKtHqGoR4/9Pbj0pLKmbaehTHW
	 vG+rZB03i95oIS4gqIdT68miY3oA7HBvjIoyR3dIcH4CphIObSgiB/rg7QIBGh979K
	 JqofCVlclV1Dw==
Date: Tue, 5 Nov 2024 18:06:44 +0000
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
Subject: Re: [PATCH 04/21] dt-bindings: gpu: img: Allow dma-coherent
Message-ID: <20241105-linseed-steadfast-98cd8abe898c@spud>
References: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
 <20241105-sets-bxs-4-64-patch-v1-v1-4-4ed30e865892@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jZZZ0TtrazABMAIy"
Content-Disposition: inline
In-Reply-To: <20241105-sets-bxs-4-64-patch-v1-v1-4-4ed30e865892@imgtec.com>


--jZZZ0TtrazABMAIy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 03:58:10PM +0000, Matt Coster wrote:
> This attribute will be required for the BXS-4-64 MC1 and will be enabled =
in
> the DTS for the TI k3-j721s2 in a subsequent patch; add it now so
> dtbs_check doesn't complain later.

Sounds like the property should be made required for that integration.

>=20
> Signed-off-by: Matt Coster <matt.coster@imgtec.com>
> ---
>  Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml=
 b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index 55f422be1bc5b7564e3e81f24c4b93857f3e12fe..8a1861ca960c48853b2ceef41=
4f588cc343b49b2 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -60,6 +60,8 @@ properties:
>            - const: a
>            - const: b
> =20
> +  dma-coherent: true
> +
>  required:
>    - compatible
>    - reg
>=20
> --=20
> 2.47.0
>=20

--jZZZ0TtrazABMAIy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZypetAAKCRB4tDGHoIJi
0kjsAQCsk2h19nWNOK2QLV16dXvVjJGuABtG2kMsJv5im2dsSgD/VsBRyWBSA9aK
3hEs1FqMGnHBcwnC2OCwsSUNxcO2hQI=
=QtP+
-----END PGP SIGNATURE-----

--jZZZ0TtrazABMAIy--

