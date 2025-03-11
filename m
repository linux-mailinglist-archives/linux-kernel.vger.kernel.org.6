Return-Path: <linux-kernel+bounces-556675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFECA5CD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307FA3B45F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F6B262D37;
	Tue, 11 Mar 2025 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV9CbVES"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17B7262D0D;
	Tue, 11 Mar 2025 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716464; cv=none; b=CNlzR5UAqEnMpc6mzBP6V9WbYNYBIOABGHSOc9P5JqWkvoU9QH/HhMoTDywt3/UKV7A1BugYyuIGf5U2yUG1OAxmUVHxhmbbUxwXV4kFLPzGddJEjslVOYiEm0T6J5uonQLVce7R3s/n/wCHj7v46HRmE5V3LR/i1C53MiAI8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716464; c=relaxed/simple;
	bh=/8sCzo09LD1mdUJPxmXKa2i8Cun9j2U4D43IY/3nebk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/xPN7z2kZhuaXcYa7y/XUVkp+CyH3f1OkVcXW9WRHgZevf5TszJBKh6ACFjVeww7gD6WteXRdm6V4miPIk7frg8W7MkfoG1u06eeEsoeYoBmRZ9tp1BXlqiO1oqdgUvwbD/pSwH/dc/JsEFsRusVe/ZjX1ke/IoxO9scWtnYhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lV9CbVES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AADC4CEE9;
	Tue, 11 Mar 2025 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741716464;
	bh=/8sCzo09LD1mdUJPxmXKa2i8Cun9j2U4D43IY/3nebk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lV9CbVESi0mwa7NPSqazEt3LCxc+y7/vjXsNQr8IeoWR6WTTWSNoYVpN59cPpas+m
	 UOUZu7MgC4+fHG8LtYnA56KbvlX41H8X02Z1Yy7V269IaHVoVljKyEwFMqPh30d/Ct
	 kR8AGRAMy5NYtzXoc3Ng8HJInukn96ie0NF7uAc46dWYvw5fhvF1MFvvQnhdlOLyqI
	 EfCAjw2FepzyKTH1KNaQSUZNFyRsSTY3EcEvmVr+nXYhsSoLZ6pYAe/3qkl8GuE0E4
	 RS/SIteOeNQqoc+XbDm1r5j5zYZrSfJT8w8vR0KAUCMk8xBs85qP3+oT4rjQmWXKcp
	 XY21ZaGmCmWEA==
Date: Tue, 11 Mar 2025 18:07:37 +0000
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
Subject: Re: [PATCH 00/10] Basic device tree support for ESWIN EIC7700 RISC-V
 SoC
Message-ID: <20250311-backdrop-porthole-440ae005e8fa@spud>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ccnRVPIec56gG3E1"
Content-Disposition: inline
In-Reply-To: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>


--ccnRVPIec56gG3E1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 01:04:22PM +0530, Pinkesh Vaghela wrote:
> Add support for ESWIN EIC7700 SoC consisting of SiFive Quad-Core
> P550 CPU cluster and the first development board that uses it, the
> SiFive HiFive Premier P550.
>=20
> This patch series adds initial device tree and also adds ESWIN
> architecture support.
>=20
> Boot-tested using intiramfs with Linux 6.14.0-rc2 on HiFive Premier
> P550 board using U-Boot 2024.01 and OpenSBI 1.4.

There's no git tree in your MAINTAINERS entry, nor mention here of what
the story is going to be in terms of sending patches to Arnd. Who is
going to be doing that?

Cheers,
Conor.

> Darshan Prajapati (3):
>   dt-bindings: riscv: Add SiFive P550 CPU compatible
>   dt-bindings: interrupt-controller: Add ESWIN EIC7700 PLIC
>   dt-bindings: timer: Add ESWIN EIC7700 CLINT
>=20
> Min Lin (2):
>   riscv: dts: add initial support for EIC7700 SoC
>   riscv: dts: eswin: add HiFive Premier P550 board device tree
>=20
> Pinkesh Vaghela (2):
>   riscv: Add Kconfig option for ESWIN platforms
>   cache: sifive_ccache: Add ESWIN EIC7700 support
>=20
> Pritesh Patel (3):
>   dt-bindings: vendor-prefixes: add eswin
>   dt-bindings: riscv: Add SiFive HiFive Premier P550 board
>   dt-bindings: cache: sifive,ccache0: Add ESWIN EIC7700 SoC
>     compatibility
>=20
>  .../bindings/cache/sifive,ccache0.yaml        |  28 +-
>  .../sifive,plic-1.0.0.yaml                    |   1 +
>  .../devicetree/bindings/riscv/cpus.yaml       |   1 +
>  .../devicetree/bindings/riscv/eswin.yaml      |  29 ++
>  .../bindings/timer/sifive,clint.yaml          |   1 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |   7 +
>  arch/riscv/Kconfig.socs                       |   6 +
>  arch/riscv/boot/dts/Makefile                  |   1 +
>  arch/riscv/boot/dts/eswin/Makefile            |   2 +
>  .../dts/eswin/eic7700-hifive-premier-p550.dts |  29 ++
>  arch/riscv/boot/dts/eswin/eic7700.dtsi        | 344 ++++++++++++++++++
>  drivers/cache/sifive_ccache.c                 |   2 +
>  13 files changed, 450 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/riscv/eswin.yaml
>  create mode 100644 arch/riscv/boot/dts/eswin/Makefile
>  create mode 100644 arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550=
=2Edts
>  create mode 100644 arch/riscv/boot/dts/eswin/eic7700.dtsi
>=20
> --=20
> 2.25.1
>=20

--ccnRVPIec56gG3E1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ9B76QAKCRB4tDGHoIJi
0vQ8AP43Anh9XY0PB4DXa7cODFRPlV0FhokZ8K/uAp2SiIdq3gEA+iI1Mf0iiizD
F/N0vWPXU/KQ4Y5X+2kFV9FcHGFH1Qs=
=RNCF
-----END PGP SIGNATURE-----

--ccnRVPIec56gG3E1--

