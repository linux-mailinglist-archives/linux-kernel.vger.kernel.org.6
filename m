Return-Path: <linux-kernel+bounces-279797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C55694C1FC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92E61F235CA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA6718E749;
	Thu,  8 Aug 2024 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCT5eUnH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C762A18FDD0;
	Thu,  8 Aug 2024 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132298; cv=none; b=al2BKIKrE4axmjaYp8jKcR0uubsneI2ztOchBWDypbBQz0UgSuR3J4aHaVbm4sU3Wms3pSba6GSC4eFoHBcrfCYPFFjXjbmjxib5cPlDL3o4SQOb5Xo3n6seuCBXztVxOH/PySJ4Oo5N7FIIriKyHKqVWUlIuIz3LsaxPCb1Bh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132298; c=relaxed/simple;
	bh=R6c8rl7ufutyWXm8jkvNyo62VDrI1v9HB3PzuzT63dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxfo5GgYicPY+e8mZDxFA7M8tT0Er5uat148JI5cf9aeUJdP+UDpK9+R9bl+soqTWrjFUkKmBlZxRoPdfq0/bC9CjQsmWjIx5Tx+D2BEJGtvJGGKYlwT6UDmiGO/z0yaBGtXWTGOL6F/3hYIwNZ9OPRE+NB/lo2UCMIS6oQxvY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCT5eUnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A62AC32782;
	Thu,  8 Aug 2024 15:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723132298;
	bh=R6c8rl7ufutyWXm8jkvNyo62VDrI1v9HB3PzuzT63dA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCT5eUnHA8t96DLMfc3GAXJdZwpI2f8X1lnkIxNIj1/vA19Xb/yS/03fAQ6oevcpo
	 XtB+CVKIeGs0qH73wIep7MUQM9471p6wpt2BmcrDFXlD/4ZT4/CcAup/x/8g4u1FEQ
	 jK3Zt7kgq1lgXuev1bCauNCXkQRVMqLvnp3feqqRdAsG7J8/737X413MMsEwZWW9oW
	 KPdqi+IVhxq2D0I13mVb0Xi5Z7NEz/SARqmWgxIADS0WkDdCE101kSP1S0cRnKWch0
	 XIZV2KgtGe6KMLUabhXN6ZjCDE5J4nNEXD24Ma+/61ZS76YDUSnCnHxhYCFPuysbpx
	 a3jERvF83dLQg==
Date: Thu, 8 Aug 2024 16:51:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, robh@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kalyani Akula <kalyani.akula@amd.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] dt-bindings: nvmem: Use soc-nvmem node name instead
 of nvmem
Message-ID: <20240808-imply-backroom-b5a9aaf44db8@spud>
References: <1184b2799ecdeef04128f4bab3db7460fd8edb10.1723114978.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Jk3H8VNe9y+Nh+rN"
Content-Disposition: inline
In-Reply-To: <1184b2799ecdeef04128f4bab3db7460fd8edb10.1723114978.git.michal.simek@amd.com>


--Jk3H8VNe9y+Nh+rN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 01:02:59PM +0200, Michal Simek wrote:
> Based on commit d8764d347bd7 ("dt-bindings: firmware: xilinx: Describe
> soc-nvmem subnode") soc-nvmem should be used instead of simple nvmem that=
's
> why also update example to have it described correctly everywhere.
>=20
> Fixes: c7f99cd8fb6b ("dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt t=
o yaml")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>=20
> Changes in v2:
> - Fix sha1 in Fixes tag - reported by Stephen
>=20
> Adding comments from origin version
> https://lore.kernel.org/r/42c21f3bcd75f821061d047730dbbcd40233e256.171680=
0023.git.michal.simek@amd.com
>=20
> Rob:
>  This doesn't seem like an improvement. Is there another nvmem node at
>  this level? I would fix the binding instead if not.
>=20
> Michal:
> That name came from discussion with Conor.

Did it? I don't recall that, only discussion about adding a "real"
example to the binding and noting a typo in the commit message.

> None suggested to fix dt-schema that's why soc-nvmem has been propagated =
to DT already and this patch is just fixing last occurrence.
>=20
> commit d8764d347bd737efec00fae81133ffad0ae084bb (tag: zynqmp-dt-for-6.9)
> Author:     Michal Simek <michal.simek@amd.com>
> AuthorDate: Wed Jan 31 10:17:28 2024 +0100
>=20
>     dt-bindings: firmware: xilinx: Describe soc-nvmem subnode
>=20
>     Describe soc-nvmem subnode as the part of firmware node. The name can=
't be
>     pure nvmem because dt-schema already defines it as array property tha=
t's
>     why different name should be used.
>=20
>     Acked-by: Conor Dooley <conor.dooley@microchip.com>
>     Link: https://lore.kernel.org/r/24fe6adbf2424360618e8f5ca541ebfd8bb07=
23e.1706692641.git.michal.simek@amd.com
>     Signed-off-by: Michal Simek <michal.simek@amd.com>
>=20
> ---
>  Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.ya=
ml b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
> index 917c40d5c382..1cbe44ab23b1 100644
> --- a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
> @@ -28,7 +28,7 @@ unevaluatedProperties: false
> =20
>  examples:
>    - |
> -    nvmem {
> +    soc-nvmem {
>          compatible =3D "xlnx,zynqmp-nvmem-fw";
>          nvmem-layout {
>              compatible =3D "fixed-layout";
> --=20
> 2.43.0
>=20

--Jk3H8VNe9y+Nh+rN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrTphQAKCRB4tDGHoIJi
0kAMAQC683gInc/ymUfVB/jtg22GLt2gWZYNyAM0KKWoaMoXawD+IKWGwsHkBsck
u7JwbvrU4Oj5+UmpMeXMX7Ux+ztR+wE=
=tVbK
-----END PGP SIGNATURE-----

--Jk3H8VNe9y+Nh+rN--

