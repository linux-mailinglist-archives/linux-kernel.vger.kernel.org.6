Return-Path: <linux-kernel+bounces-364364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A7199D3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E630FB2C512
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CE51C75E6;
	Mon, 14 Oct 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kL297kc0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBC11C304F;
	Mon, 14 Oct 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920486; cv=none; b=uixvV63PU3GMAX7jQliHPAW1nIRWLFp/4OWBYD9koDk/RnVltjBElTUdxnOayEQT7h82xS2LQEpgTrZ6B02lqZZhz5SkGzDbtlDnyiXMKTb01jtKukkU8fHfm4jjHuqKkzAViSBctfPFir43UF8Hxw9Qnuwm8Z4u85XZxGEnKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920486; c=relaxed/simple;
	bh=M0aqPwu+dFXtECjVSJ3QQ5hXIYiJbEv0SIsk3LZpeHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOlEeRKYgCW/7c28BQdkU3dqdwhBYQh0ntQqpLGHixG5fCUtqHsfU76rkpGwGHK2wE1ViXsUyGgvkS2F400Mj+Pv4R6qZqdhO5xpLp1wKyZqGFaQFe9bDg7ZazmPF0xYQHlkGNJBIVZrD3+EBlUCQDtIX2v6AgqVOxwXuouLQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kL297kc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2A3C4CEC3;
	Mon, 14 Oct 2024 15:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728920485;
	bh=M0aqPwu+dFXtECjVSJ3QQ5hXIYiJbEv0SIsk3LZpeHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kL297kc07fbW2HgkUOc148A271m26BHS4lp+RD+YMjAZNWG7RS3zbnqIpIbvU0UdF
	 YEK279kohnxZHwrC4PJ1QopPzyzFtrajkawya/r2iMFAFvdzksIsRsz1JzzfXre7FJ
	 J3zLjgAXQQEAYBNKZEaab3FMjTurNincfIviP+8hZ5gQVHLU8ImzO7wpMEiIStf+HZ
	 sQ1hd7BhZZMPLovWzebcALmnf7wLcchIEiqvrHOtOgc2Ct2k5lA9yLnRrtB368LIcG
	 ErIwaBkXsqkfiPkWipkqbpSCdwcVQdoolHAdPju2l59jNRtO18M0ye3nkd26r+pvYh
	 RBk4ROumnVUgg==
Date: Mon, 14 Oct 2024 16:41:19 +0100
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 10/11] riscv: dts: microchip: fix mailbox description
Message-ID: <20241014-decorator-coma-bdaca54f459b@spud>
References: <20241002-private-unequal-33cfa6101338@spud>
 <20241002-finch-sugar-9958077e8c2b@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AMmGHX8GSM3kEZUA"
Content-Disposition: inline
In-Reply-To: <20241002-finch-sugar-9958077e8c2b@spud>


--AMmGHX8GSM3kEZUA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2024 at 11:48:08AM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> When the binding for the mailbox on PolarFire SoC was originally
> written, and later modified, mistakes were made - and the precise
> nature of the later modification should have been a giveaway, but alas
> I was naive at the time.
>=20
> A more correct modelling of the hardware is to use two syscons and have
> a single reg entry for the mailbox, containing the mailbox region. The
> two syscons contain the general control/status registers for the mailbox
> and the interrupt related registers respectively. The reason for two
> syscons is that the same mailbox is present on the non-SoC version of
> the FPGA, which has no interrupt controller, and the shared part of the
> rtl was unchanged between devices.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/boot/dts/microchip/mpfs.dtsi | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dt=
s/microchip/mpfs.dtsi
> index 9883ca3554c50..f8a45e4f00a0d 100644
> --- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
> +++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
> @@ -259,6 +259,11 @@ clkcfg: clkcfg@20002000 {
>  			#reset-cells =3D <1>;
>  		};
> =20
> +		sysreg_scb: syscon@20003000 {
> +			compatible =3D "microchip,mpfs-sysreg-scb", "syscon";
> +			reg =3D <0x0 0x20003000 0x0 0x1000>;
> +		};
> +
>  		ccc_se: clock-controller@38010000 {
>  			compatible =3D "microchip,mpfs-ccc";
>  			reg =3D <0x0 0x38010000 0x0 0x1000>, <0x0 0x38020000 0x0 0x1000>,
> @@ -521,10 +526,14 @@ usb: usb@20201000 {
>  			status =3D "disabled";
>  		};
> =20
> -		mbox: mailbox@37020000 {
> +		control_scb: syscon@37020000 {
> +			compatible =3D "microchip,mpfs-control-scb", "syscon", "simple-mfd";
> +			reg =3D <0x0 0x37020000 0x0 0x100>;

It came up today that this 0x100 isn't correct - the actual size here is
4 KiB, so there's a zero missing.

> +		};
> +
> +		mbox: mailbox@37020800 {
>  			compatible =3D "microchip,mpfs-mailbox";
> -			reg =3D <0x0 0x37020000 0x0 0x58>, <0x0 0x2000318C 0x0 0x40>,
> -			      <0x0 0x37020800 0x0 0x100>;
> +			reg =3D <0x0 0x37020800 0x0 0x100>;
>  			interrupt-parent =3D <&plic>;
>  			interrupts =3D <96>;
>  			#mbox-cells =3D <1>;
> --=20
> 2.45.2
>=20

--AMmGHX8GSM3kEZUA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZw07nwAKCRB4tDGHoIJi
0uvxAP9ZQ8cvIGni9H/XnWtk13xiTiUDsVDUdKEmVRW5hAVqsQD/SnIowi8Sck+a
xDVwEskn483v/i7rcplrFORdLLx7OwQ=
=2myu
-----END PGP SIGNATURE-----

--AMmGHX8GSM3kEZUA--

