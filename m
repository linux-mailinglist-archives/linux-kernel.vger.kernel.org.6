Return-Path: <linux-kernel+bounces-416123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814629D40CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06F86B33774
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350F1153BEE;
	Wed, 20 Nov 2024 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+EndPRh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9351474CC;
	Wed, 20 Nov 2024 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121335; cv=none; b=mQa+DEkzks3dG3rw/lSgq0dnalhGBKZ9wcXaMql2ZN5ZxubZoXG37efkxB/t1SwjhZ5Ayvb2+iw8OAEXA51Waqt9Uv6wf9bT+e14A0Om9XRfTPxU7InRHQE2/EQTkJfxitQumGSnR4dG2+64M+CUMPERxVcGJ0exgq+VWVBRSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121335; c=relaxed/simple;
	bh=Xj2XGnCnlH9Wd8nMgGB5FfrrL5fgMMi97SviUhy/am4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJfgqdORz0Yj/UD1625bqXuWkD32VDJJkuHP9dFyq/9D0rmd2Quh6TyYYpAOkYoFsNCC5S7OpBteq4Yv2+Tf+q3USnQDSJzvvi2GPkA2akDQ5i4K84NCyuYpjw+c9/k0hBtSKaILgEclLeLQ3F3MouOoF9qc9TYpvDVyMza9FEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+EndPRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D785CC4CECD;
	Wed, 20 Nov 2024 16:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732121335;
	bh=Xj2XGnCnlH9Wd8nMgGB5FfrrL5fgMMi97SviUhy/am4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+EndPRhTsi7i44TUXsfXGdxSfoianw4lY75huz+86XqeQ4qkm57bVUQXwpb8D9DH
	 QHvkMPukfO6dKiNgga/fEogkNXLqo1AoMMRJJA1JzVAjbtxeV6jqiZ3TepgvE8qBa8
	 jVQh9qf6wyP8ORXtvtOfOPSujcSHZjtKjz6sPiRwYf1TXN1iHN7/l2QJDfFC9Hu/dX
	 gM99gtoUMBSo/8WkTn6YIEIAUHU4exWGwCsf6iFIOsLUTRYPlp9dvVuI4N7Iv8Fsbn
	 JEB7Q75yIbqwJkfVAWTyqWGhlfb/cUJm3yNx5FqHmFKOKMotYMcQGpz7UBR3bOTrtx
	 E6fo1XiBZgK3Q==
Date: Wed, 20 Nov 2024 16:48:47 +0000
From: Conor Dooley <conor@kernel.org>
To: keith zhao <keith.zhao@starfivetech.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	andrzej.hajda@intel.com, neil.armstrong@linaro.org,
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
	william.qiu@starfivetech.com, xingyu.wu@starfivetech.com,
	kernel@esmil.dk, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, p.zabel@pengutronix.de,
	changhuang.liang@starfivetech.com, jack.zhu@starfivetech.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/9] riscv: dts: Add display property
Message-ID: <20241120-ricotta-rescuer-90bad7c38e93@spud>
References: <20241120061848.196754-1-keith.zhao@starfivetech.com>
 <20241120061848.196754-3-keith.zhao@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Etb5DlIYTN201Rze"
Content-Disposition: inline
In-Reply-To: <20241120061848.196754-3-keith.zhao@starfivetech.com>


--Etb5DlIYTN201Rze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 02:18:41PM +0800, keith zhao wrote:
> Add the display DT nodes in Starfive JH7110 soc-specific DT file.
>=20
> Signed-off-by: keith zhao <keith.zhao@starfivetech.com>

$subject: "riscv: dts: Add display property"

a) this is jh7110 exclusive, not for all riscv devicetrees
b) you are adding more than a property

> ---
>  .../boot/dts/starfive/jh7110-common.dtsi      | 125 ++++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  41 ++++++
>  2 files changed, 166 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv=
/boot/dts/starfive/jh7110-common.dtsi
> index 9d77713f5361..301b56f2ef0c 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -30,6 +30,25 @@ memory@40000000 {
>  		reg =3D <0x0 0x40000000 0x1 0x0>;
>  	};
> =20
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		/* vout applies for space from this CMA

"vout" could be a voltage, please be more specific. Comments should be
wrapped at at least 80 chars. Linux coding style puts /* on a line of
its own.

> +		 * Without this CMA reservation,
> +		 * vout may not work properly.
> +		 */
> +		linux,cma {
> +			compatible =3D "shared-dma-pool";
> +			reusable;
> +			size =3D <0x0 0x20000000>;
> +			alignment =3D <0x0 0x1000>;
> +			alloc-ranges =3D <0x0 0x70000000 0x0 0x20000000>;
> +			linux,cma-default;
> +		};
> +	};
> +
>  	gpio-restart {
>  		compatible =3D "gpio-restart";
>  		gpios =3D <&sysgpio 35 GPIO_ACTIVE_HIGH>;
> @@ -62,12 +81,55 @@ codec {
>  			};
>  		};
>  	};
> +
> +	hdmi_con: hdmi-con {
> +		compatible =3D "hdmi-connector";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint =3D <&hdmi_out_con>;
> +			};
> +		};
> +	};
>  };
> =20
>  &cpus {
>  	timebase-frequency =3D <4000000>;
>  };
> =20
> +&dc8200 {
> +	status =3D "okay";
> +	crtc_out: ports {

blank line between properties and child nodes please.

> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		dc_out0: port@0 {

Cheers,
Conor.

--Etb5DlIYTN201Rze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZz4S7wAKCRB4tDGHoIJi
0lFnAQC5Cen9HmRFPLpRfCMQUx1G5Jj1IRCOVFmH1cknmLUOAQD+NaQFuXCPLkQt
WA5fC3L7EGS8TK65udHTJdbrhlMQLQU=
=Zb+5
-----END PGP SIGNATURE-----

--Etb5DlIYTN201Rze--

