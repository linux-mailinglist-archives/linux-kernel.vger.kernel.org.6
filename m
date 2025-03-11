Return-Path: <linux-kernel+bounces-556687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5C3A5CDC2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B807D189EB43
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788A5263C8A;
	Tue, 11 Mar 2025 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbNZ//VP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABEF262D05;
	Tue, 11 Mar 2025 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716710; cv=none; b=sVL5fNOHLpGPEMECRWfvd2sT3RKSd7jXlbguB08Lrvx8avHvdOB/cROA6NNaIrIw3ps2/FKNYbp6ylS1nXvdfvZE9zkhtDsZWiEnoY/Akn9lO5YMb7ZCfUjj5+Wel5/T+i5y0bV2eV5lFHTUbsJxqlQLyrFSuCT4cIUFGy7vYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716710; c=relaxed/simple;
	bh=6F/k+ohWhXcoXwg5XBr9rp54e3QcQ9v3bx+s3rTBQZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJRKZ04LCqUo6oO1ZReyYTJU40yN6U63I2/i40SY7cEJNr2VX6LPekmoIUqaCe9Kq0r/7TEqLAeofp3gNbWPdoMQH+o1HZASS8u59EcJotQ44mySFzFXWbtkmWcjAYBuxh2tpRenfqu7MEQeGYtXiRqoD4plvUQpwY0Aaoek2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbNZ//VP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370A0C4CEEF;
	Tue, 11 Mar 2025 18:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741716710;
	bh=6F/k+ohWhXcoXwg5XBr9rp54e3QcQ9v3bx+s3rTBQZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SbNZ//VPLZlh9QJO50mf5586izFK6ZQOSDpMdacVnUloSNC2dTtGORykLAYOYgXi1
	 V3uaVsi3Vn0ZGmVyRbA708FTYANDdK7bYnzhJtmQn4X1juNUE2o8ocyRmlU8sfB74n
	 nXY3DFqrYT/xjCXpK+TivylNgCYmgfdqZxRKYYYF3OkDGIhhBmyqe8owtRXb8MPZci
	 Mk4+DSQzg0PRGWbJhM1eR/UJkr8l416k4Yj17KJEJHruAyS6QHzoPbPQ3aDGXa1ZCh
	 5wQRufVfLB65+lf1e0b68N2cphBx0CTWuyLABvg2c4J2JQ7h4pAnt/YHeYopZIg8UT
	 ZgeM4FuSY61gA==
Date: Tue, 11 Mar 2025 18:11:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl, Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: cache: sifive,ccache0: Add ESWIN
 EIC7700 SoC compatibility
Message-ID: <20250311-exposure-relive-f33873964914@spud>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
 <20250311073432.4068512-6-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4KqL/Ursy/O0/Cxs"
Content-Disposition: inline
In-Reply-To: <20250311073432.4068512-6-pinkesh.vaghela@einfochips.com>


--4KqL/Ursy/O0/Cxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 01:04:27PM +0530, Pinkesh Vaghela wrote:
> From: Pritesh Patel <pritesh.patel@einfochips.com>
>=20
> This cache controller is also used on the ESWIN EIC7700 SoC.
> However, it have 256KB private L2 Cache and shared L3 Cache of 4MB.
> So add dedicated compatible string for it.
>=20
> Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
> ---
>  .../bindings/cache/sifive,ccache0.yaml        | 28 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml =
b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> index 7e8cebe21584..11e9df2cd153 100644
> --- a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> +++ b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> @@ -39,6 +39,7 @@ properties:
>            - const: cache
>        - items:
>            - enum:
> +              - eswin,eic7700-l3-cache
>                - starfive,jh7100-ccache
>                - starfive,jh7110-ccache
>            - const: sifive,ccache0
> @@ -55,10 +56,10 @@ properties:
>      enum: [2, 3]
> =20
>    cache-sets:
> -    enum: [1024, 2048]
> +    enum: [1024, 2048, 4096]
> =20
>    cache-size:
> -    const: 2097152
> +    enum: [2097152, 4194304]

Making this an enum makes either value permitted on each SoC. Can you
add cache-size restrictions to the if statements below to keep it
restricted to the correct value please?

Cheers,
Conor.

> =20
>    cache-unified: true
> =20
> @@ -89,6 +90,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - eswin,eic7700-l3-cache
>                - sifive,fu740-c000-ccache
>                - starfive,jh7100-ccache
>                - starfive,jh7110-ccache
> @@ -122,11 +124,31 @@ allOf:
>          cache-sets:
>            const: 2048
> =20
> -    else:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,mpfs-ccache
> +              - sifive,fu540-c000-ccache
> +
> +    then:
>        properties:
>          cache-sets:
>            const: 1024
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - eswin,eic7700-l3-cache
> +
> +    then:
> +      properties:
> +        cache-sets:
> +          const: 4096
> +
>    - if:
>        properties:
>          compatible:
> --=20
> 2.25.1
>=20

--4KqL/Ursy/O0/Cxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ9B83wAKCRB4tDGHoIJi
0qg6AP9/9GbV4BfcxIJ0Hq3/t9Jb3rfm4yxgeB1hMbL/+rUcHgD/eGLTFdv6dNBd
zNDict/2TFKThTFRgSv01Oz9CJbLGAA=
=BjHP
-----END PGP SIGNATURE-----

--4KqL/Ursy/O0/Cxs--

