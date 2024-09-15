Return-Path: <linux-kernel+bounces-330015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E115979876
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 21:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402841C218B0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 19:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FC91CA691;
	Sun, 15 Sep 2024 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uce/rLQF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A051CA685;
	Sun, 15 Sep 2024 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726428908; cv=none; b=k5CK7Go0BTyqCzf/x7+Kv9kFOwZFKiZazAnrII00NPDrjKkDeIXMFEPCI3lPa/wraiSQNZ5RLF89MHJbE9jsWaH1ddLlDqhmNGTlNE61Y7IYpo/VRjR0USGGgdt8iEMVYSguyHvEgDGyZr2d9EkwnG+XcDGiyiBcgyqE34mKTx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726428908; c=relaxed/simple;
	bh=TegTfxzMRKVsjSI958Q3E0pV4BcivWmeXOWpP71ZNh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlR6n4TnbpgGOj/+9KspLsdRQS3vBII8rG6oaISosfcvb/XopUDjJJfBrV5QZ3/sPQqdyFRti2u/q/WPr8pUjScg8GfWq+3HChMGTOGzY6zYay1NpsShwXuZlaIFzNjEKqSPUSAw2ZGrraM9o20AHgdtZsUHS/X6xzGN4ecXNl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uce/rLQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47350C4CEC3;
	Sun, 15 Sep 2024 19:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726428907;
	bh=TegTfxzMRKVsjSI958Q3E0pV4BcivWmeXOWpP71ZNh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uce/rLQFmd2E1rkjh8POBHvnJYzVZsdoRWrsqAH4jxBLkC++ToznVXMGsZXneSsnT
	 1mAf0PP5pJtlGnh1qpQjERBVkEKD8vUJbssm3D7PkVZKwGqis4ox1j64o2YoYZk9Q5
	 i7IpnNQpMVA5HvXHUoHfjaKpsO1O4unouAvAxEMUvfsiv/R5uwR7zpYJi+g5mpgrEP
	 v02UhFpu3c//sss+5+52xKJgH5CVGnls7NduFfYni/PHn9c0klt3MBhbAyv6SXEHTz
	 6CMstSEUCq0thVzF3cMJotaaH6hkkjwJA3/xhrtAHlc8MI6usuDZMldZbKceuYCe5t
	 jt446Li/EB0oA==
Date: Sun, 15 Sep 2024 20:35:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Ze Huang <18771902331@163.com>
Cc: linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, cyy@cyyself.name, jesse@rivosinc.com,
	jszhang@kernel.org, inochiama@outlook.com, uwu@icenowy.me,
	zhangmeng.kevin@spacemit.com, kevin.z.m@hotmail.com,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, dlan@gentoo.org
Subject: Re: [PATCH 0/3] Add initial support for Canaan Kendryte K230 pinctrl
Message-ID: <20240915-flinch-harness-e9e1b92f5c79@spud>
References: <ZubtZKlxqejnCFx_@jean.localdomain>
 <320c1fd8-2f8d-414d-a6a5-23280955b9b8@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CyzwYAu3/6FE9Ujm"
Content-Disposition: inline
In-Reply-To: <320c1fd8-2f8d-414d-a6a5-23280955b9b8@163.com>


--CyzwYAu3/6FE9Ujm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 11:22:16PM +0800, Ze Huang wrote:
>=20
> On 9/15/24 10:21 PM, Ze Huang wrote:
> > This patch series introduces support for the pinctrl driver of the Cana=
an
> > K230 SoC. The K230 SoC features 64 IO pins, each of which can be config=
ured
> > for up to five different functions.
> > 						=09
> > The controller manages the entire pin configuration and multiplexing
> > through a single register, which control features such as schmitt trigg=
er,
> > drive strength, bias pull-up/down, input/output enable, power source, a=
nd
> > mux mode.
> >=20
> > The changes have been tested on the K230 development board.
> > 						=09
> > The pin function definition can be found here [1], and most of the DTS =
data
> > was converted from the vendor's code [2].
> >=20
> > Link: https://developer.canaan-creative.com/k230/dev/_downloads/a53655a=
81951bc8a440ae647be286e75/K230_PINOUT_V1.1_20230321.xlsx [1]
> > Link: https://github.com/kendryte/k230_sdk/blob/main/src/little/uboot/a=
rch/riscv/dts/k230_canmv.dts [2]
> >=20
> > Ze Huang (3):
> >    dt-bindings: pinctrl: Add support for canaan,k230 SoC
> >    pinctrl: canaan: Add support for k230 SoC
> >    riscv: dts: canaan: Add k230's pinctrl node
> >=20
> >   .../bindings/pinctrl/canaan,k230-pinctrl.yaml | 128 ++++
> >   arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi  | 318 +++++++++
> >   arch/riscv/boot/dts/canaan/k230-pinctrl.h     |  18 +
> >   arch/riscv/boot/dts/canaan/k230.dtsi          |   2 +
> >   drivers/pinctrl/Kconfig                       |  10 +
> >   drivers/pinctrl/Makefile                      |   1 +
> >   drivers/pinctrl/pinctrl-k230.c                | 674 ++++++++++++++++++
> >   7 files changed, 1151 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/pinctrl/canaan,k=
230-pinctrl.yaml
> >   create mode 100644 arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi
> >   create mode 100644 arch/riscv/boot/dts/canaan/k230-pinctrl.h
> >   create mode 100644 drivers/pinctrl/pinctrl-k230.c
> >=20
>=20
> lost base commit and prerequisite patch id here:
>=20
> base-commit: 0eea987088a22d73d81e968de7347cdc7e594f72
> prerequisite-patch-id: 740cbeb9fc3f3e3fd30df4914cd31e9eb148a581
> prerequisite-patch-id: b5cc919a7e8e2f852569d5918944dbe4f21e6912
> prerequisite-patch-id: 554cb838b7264109437359e88443cc3497ed344c

I don't have the ability to convert those to something I can understand,
is
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=3Dk2=
30-basic
effectively the basis for your series?

--CyzwYAu3/6FE9Ujm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuc25gAKCRB4tDGHoIJi
0ulQAQCknK6VYQasoWh8AAI3+LsDn+3tbfKKbzDGoTZdf0W2tQD/ayh4pmeE6f4b
G7dvGUnbYVw+aPXbxopXJPwekkLhtQU=
=a291
-----END PGP SIGNATURE-----

--CyzwYAu3/6FE9Ujm--

