Return-Path: <linux-kernel+bounces-180128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C27E8C6A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261A6284234
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D555156655;
	Wed, 15 May 2024 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCbEkMsg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A04C43144;
	Wed, 15 May 2024 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789976; cv=none; b=KOQVpEPfFyo85n2b9aEI8r9Un9Q3eP0hR3B8u1Pl3E1qRQeT1k08B9mgeyjP1MMqnPp4LwGJd2KjdbtHS2Mc4SVTlz8+ic3InDnLJ5hQ6KLqB3Cu6KjJ6sjRmMd1hmwU/vQEgaMadTgap0iHPlBDl41RA+wPEmRX32rjdq/1quY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789976; c=relaxed/simple;
	bh=/He7CAq7HiGjDS6udlxRywGS+srOIUjRiPK0TOJkqk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7LVsXawRWU72acXALHzqwDCc26hajYU/7k6SVLg7Joy+oAIi8i/oE9p2InEfkA8M5/o0XAYj90KYd11s1OXo2y2evHDgDX6CUh5pfv3BZYcbUGcXGWjRR7yTChFxEvCOnzYTMQtthsjkK20YQX4UBrkGItN475F60Ixx3iUEvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCbEkMsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EB4C116B1;
	Wed, 15 May 2024 16:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715789975;
	bh=/He7CAq7HiGjDS6udlxRywGS+srOIUjRiPK0TOJkqk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCbEkMsgY8TOtD4BoWYV4ytezczs/FHfE9OtBrCmlKm5e7OxMakHsokNybGeIogcs
	 yqk/Tshaec1pcV0HOTV2rjbnc8G4I6vN+L/RzwxSFhX4Iy+TMfvCo2BVVnAbG4q7Uk
	 DxVxd+yP7NCh3Znj9ExtkE3uZhelNmIqJFnCs+lwOhgcq8W1uiNphd5UNlJXkW+SrT
	 s7g9NvY4NcQMKWfD04G3thdF/bYuCyPqeDBfzBb7F1zPFpUd8P4bwr5ASI4W7BqWa1
	 BdZauP7TVWwIZtGiDG78EBBm1eT+aCMPC4Lelzf6tBDhrwy6j/2AkBJt7rPwyQQOR9
	 095J9zLa17mmg==
Date: Wed, 15 May 2024 17:19:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: display: vop2: Add VP clock resets
Message-ID: <20240515-risk-exes-13db315da6bb@spud>
References: <20240514152328.21415-1-detlev.casanova@collabora.com>
 <20240514152328.21415-4-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P/Z/zOdIpdF94JWu"
Content-Disposition: inline
In-Reply-To: <20240514152328.21415-4-detlev.casanova@collabora.com>


--P/Z/zOdIpdF94JWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 11:19:47AM -0400, Detlev Casanova wrote:
> Add the documentation for VOP2 video ports reset clocks.
> One reset can be set per video port.
>=20
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

Are these resets valid for all VOPs or just the one on 3588?

> ---
>  .../display/rockchip/rockchip-vop2.yaml       | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-=
vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop=
2.yaml
> index 2531726af306b..941fd059498d4 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.ya=
ml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.ya=
ml
> @@ -65,6 +65,22 @@ properties:
>        - const: dclk_vp3
>        - const: pclk_vop
> =20
> +  resets:
> +    minItems: 3
> +    items:
> +      - description: Pixel clock reset for video port 0.
> +      - description: Pixel clock reset for video port 1.
> +      - description: Pixel clock reset for video port 2.
> +      - description: Pixel clock reset for video port 3.
> +
> +  reset-names:
> +    minItems: 3
> +    items:
> +      - const: dclk_vp0
> +      - const: dclk_vp1
> +      - const: dclk_vp2
> +      - const: dclk_vp3
> +
>    rockchip,grf:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> @@ -128,6 +144,11 @@ allOf:
>          clock-names:
>            minItems: 7
> =20
> +        resets:
> +          minItems: 4
> +        reset-names:
> +          minItems: 4
> +
>          ports:
>            required:
>              - port@0
> @@ -183,6 +204,12 @@ examples:
>                                "dclk_vp0",
>                                "dclk_vp1",
>                                "dclk_vp2";
> +                resets =3D <&cru SRST_VOP0>,
> +                         <&cru SRST_VOP1>,
> +                         <&cru SRST_VOP2>;
> +                reset-names =3D "dclk_vp0",
> +                              "dclk_vp1",
> +                              "dclk_vp2";
>                  power-domains =3D <&power RK3568_PD_VO>;
>                  iommus =3D <&vop_mmu>;
>                  vop_out: ports {
> --=20
> 2.43.2
>=20

--P/Z/zOdIpdF94JWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkTgkQAKCRB4tDGHoIJi
0lwXAP9ODH1i6CX+87vgyTIDRUsnCdlaUgSTbNvl8Tlmwa+XDgD+L3V6TQMyak1G
+54i1z3/hchYtm3/A1uMHW3Irz9oKAQ=
=h/hX
-----END PGP SIGNATURE-----

--P/Z/zOdIpdF94JWu--

