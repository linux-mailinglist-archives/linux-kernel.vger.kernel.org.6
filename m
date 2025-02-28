Return-Path: <linux-kernel+bounces-539131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D180FA4A157
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D4617363C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B1D27181C;
	Fri, 28 Feb 2025 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHdJm99d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83821A2554;
	Fri, 28 Feb 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740766927; cv=none; b=TJA8gVFMzX5h/ppywCCS/8jwgwpAaPWcmEPQCo4OFYsibWdJTbUJFJLibbC0OicH9pK+iriyqt1en5sT0EtK+oxSYPBaiUXX5OAoUIN6i/z0xiUiqCD4jna5gnJ1/P9/2sXl5Iewh6nO4pY/9SSGDwzmH9reZp7IKYl5v9jwxWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740766927; c=relaxed/simple;
	bh=L7nx2qw0ww3IcjVdyW4mjPxnThBtNa64sCtxvSfHX1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHHFNfPUCID5SFL36WgO5sb1ddnTi2RYLdCh9A4IzrEPISbeQtFC/+KJXBhd7G0Vzvpbl3k48VXUhIklkk97l+YkaViauUDr72dHUw7do71x9X8fn6EzWU85LBo+/Bmj8GbCAwt5V6b725a9dmUsIMDSNvYDNDf6YZIRgBcRjdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHdJm99d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD57C4CED6;
	Fri, 28 Feb 2025 18:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740766927;
	bh=L7nx2qw0ww3IcjVdyW4mjPxnThBtNa64sCtxvSfHX1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHdJm99dr70XTwFpyITFYJXriGp1uxqm7Hh5XDySE+HKhTi5RfIAWdPSJ3SSka/ZG
	 1GyPH2hIvUrJX9dV0XwHXvSUNRddgbZ6RV6DW/Vqhefm5IZD9HupwFShXEX9GnwfJf
	 r5mmMVxaCVpa3jNFbjseWAKTBLUxg0XECFMN5aMEWLY8c/nwA3jzfrYc7yUzJyer6j
	 zzbftPKBIqvWs088hW0tBeLO9pbKyUhaao+UdS8Uk+9TQy0vCDJI1dVHkS+n0ZLua9
	 b36k0X6FT1mRPnfHc5qlHt/oKwJDEylV6L7btZ9j7y2gm+eXUG7ASefUZ5srCf94us
	 fUk+BWVLDujRw==
Date: Fri, 28 Feb 2025 18:22:02 +0000
From: Conor Dooley <conor@kernel.org>
To: Zixian Zeng <sycamoremoon376@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev, chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com
Subject: Re: [PATCH v2] riscv: sophgo: dts: Add spi controller for SG2042
Message-ID: <20250228-factual-rage-0e1e1e48b009@spud>
References: <20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5HTFhaoNLB+m4rvM"
Content-Disposition: inline
In-Reply-To: <20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com>


--5HTFhaoNLB+m4rvM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 08:40:23PM +0800, Zixian Zeng wrote:
> Add spi controllers for SG2042.
>=20
> SG2042 uses the upstreamed Synopsys DW SPI IP.
>=20
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
> For this spi controller patch, only bindings are included.

^^^ you've not actually included any bindings in this patch, copy-paste
mistake?

> This is tested on milkv-pioneer board. Using driver/spi/spidev.c
> for creating /dev/spidevX.Y and tools/spi/spidev_test for testing
> functionality.
> ---
> Changes in v2:
> - rebase v1 to sophgo/master(github.com/sophgo/linux.git).
> - order properties in device node.
> - remove unevaluated properties `clock-frequency`.
> - set default status to disable.
> - Link to v1: https://lore.kernel.org/r/20250228-sfg-spi-v1-1-b989aed9491=
1@gmail.com
> ---
>  .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts |  8 +++++++
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 28 ++++++++++++++++=
++++++
>  2 files changed, 36 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/r=
iscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> index be596d01ff8d33bcdbe431d9731a55ee190ad5b3..c43a807af2f827b5267afe5e4=
fdf6e9e857dfa20 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> @@ -72,6 +72,14 @@ &uart0 {
>  	status =3D "okay";
>  };
> =20
> +&spi0 {
> +	status =3D "okay";
> +};
> +
> +&spi1 {
> +	status =3D "okay";
> +};
> +
>  / {
>  	thermal-zones {
>  		soc-thermal {
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts=
/sophgo/sg2042.dtsi
> index e62ac51ac55abd922b5ef796ba8c2196383850c4..500645147b1f8ed0a08ad3caf=
b38ea79cf57d737 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -545,5 +545,33 @@ sd: mmc@704002b000 {
>  				      "timer";
>  			status =3D "disabled";
>  		};
> +
> +		spi0: spi@7040004000 {
> +			compatible =3D "snps,dw-apb-ssi";

I thought were were dropping the use of "snps,dw-abp-ssi" in isolation,
and starting to require soc-specific compatibles now.

Rob, Krzysztof?


--5HTFhaoNLB+m4rvM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8H+ygAKCRB4tDGHoIJi
0n2wAQCLvQ8ZMOWUD0T2/OYl1/lAg6L9QMRCqx+crVNoQ6oyJAEAwoY+HGNeol8+
sKuPMRdwNeSwauRr9jNk0DoRyGuLVw8=
=HgAK
-----END PGP SIGNATURE-----

--5HTFhaoNLB+m4rvM--

