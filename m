Return-Path: <linux-kernel+bounces-194344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C258D3A82
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556C81C240B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2077A17F396;
	Wed, 29 May 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0MlBfJ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626E317BB17;
	Wed, 29 May 2024 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995840; cv=none; b=jVpgdCrQiHL9Bw1UuA8JLg/O3GsOC/lttLIPlfsNScdq2sKeD5D/fbYcjUQR7AuDc7Tu8uhVVf1KWBfDFJba5JS9/TnetQfYzVFRBh61MioZfKw+tKn9hcINVVqdMmM+YxZqiARRwIPQn8yiKDyKo8gukMPUgMWXKnTi7ml8bnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995840; c=relaxed/simple;
	bh=tRSPxp67b5/5Zs1BaKIcU7e76dVz6jxvEF0XMXgjsqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0SDAHTP/8DY1A35nZyDyLhX64vtD+kH/NNgCURbGQS508hX/N6rG9DiVckEm36mJg/3uYkHC8OIY9AuntCStWWM8if/JKiWB2Y2Umt/apaZvVI5Y1HgHhZ5sx6BNUPwEqdDKozaog76Vc5VpSkuXf0TQMBeqz3RItgjrSSdxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0MlBfJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3737CC113CC;
	Wed, 29 May 2024 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716995839;
	bh=tRSPxp67b5/5Zs1BaKIcU7e76dVz6jxvEF0XMXgjsqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0MlBfJ+wGg3UwyFMwWfZEgt0MLOAeK2hTSg8URUYtWhVL5zAyca4eQcljcTBE/Wm
	 rALc2J3z9jeSoCaSKpP8TWCKnEaGhF9HjkOZm9GRFPSw6JV6Wcd4NPE7FxQLA7F+ZJ
	 GY2XMYc7LpkiNQCmTfNnoduF8UJER1QV6/tEWWBAGeebh0oGBtrfgVq882C+PSTA/a
	 idCgMvssZHIEAkunqTbN4PkGsxsQxsWC67dB0R3BP84nm0NVcKtxjtTXxo8KrhYa7r
	 9CEJC6D53/7AgtSIseJSnS44gyZZPAcwA9WMV7S41q8EDav25p6ct68ZcvU5P9S2Wk
	 NyEbh9aLUFgKg==
Date: Wed, 29 May 2024 16:17:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Saravana Kannan <saravanak@google.com>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] of: property: Fix fw_devlink handling of interrupt-map
Message-ID: <20240529-rust-tile-a05517a6260f@spud>
References: <20240528164132.2451685-1-maz@kernel.org>
 <CAK9=C2XNPJP0X=pg5TSrQbsuouDD3jP-gy2Sm4BXNJp0ZiWp+A@mail.gmail.com>
 <86bk4pm8j1.wl-maz@kernel.org>
 <CAK9=C2XRx==OTPoGW_AHmjq4Th0bv4okwcq6-3L5JYwHwQp97A@mail.gmail.com>
 <86a5k8nbh1.wl-maz@kernel.org>
 <CAK9=C2Ugq=0y8M86CD75mQccBo=TBLBomb4rqC4i1naKy2LyWQ@mail.gmail.com>
 <868qzsn7zs.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QuT3/USFLVPqyc21"
Content-Disposition: inline
In-Reply-To: <868qzsn7zs.wl-maz@kernel.org>


--QuT3/USFLVPqyc21
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 01:00:07PM +0100, Marc Zyngier wrote:
> > > > In the RISC-V world, there have been quite a few QEMU releases
> > > > where the generated DT node of the interrupt controller does not
> > > > have the "#address-cells" property. This patch breaks the kernel
> > > > for all such QEMU releases.
> > >
> > > Congratulations, you've forked DT. News at 11.
> >=20
> > Can you elaborate how ?
>=20
> You've stated it yourself. You are relying on a behaviour that
> deviates from the standard by having DTs with missing properties
>=20
> And since we can't travel back it time to fix this, the only solution
> I can see is to support both behaviours by quirking it.

I'm not convinced that there is any actual production hardware that
would get broken by your patch, just QEMU, so I think it should get
fixed to output devicetrees that are spec compliant rather than add some
riscv-specific hacks that we can't even gate on the "qemu,aplic"
compatible because QEMU doesn't use the compatible created for it...

Spec violations aside, the QEMU aplic nodes in the DT contain a bunch
of other issues, including using properties that changed in the
upstreaming process. Here's the issues with Alistair's current riscv
tree for QEMU w/ -smp 4 -M virt,aia=3Daplic,dumpdtb=3D$(qemu_dtb) -cpu max =
-m 1G -nographic

qemu.dtb: aplic@d000000: $nodename:0: 'aplic@d000000' does not match '^inte=
rrupt-controller(@[0-9a-f,]+)*$'
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,aplic.yaml#
qemu.dtb: aplic@d000000: compatible:0: 'riscv,aplic' is not one of ['qemu,a=
plic']
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,aplic.yaml#
qemu.dtb: aplic@d000000: compatible: ['riscv,aplic'] is too short
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,aplic.yaml#
qemu.dtb: aplic@d000000: Unevaluated properties are not allowed ('compatibl=
e' was unexpected)
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,aplic.yaml#
qemu.dtb: aplic@c000000: $nodename:0: 'aplic@c000000' does not match '^inte=
rrupt-controller(@[0-9a-f,]+)*$'
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,aplic.yaml#
qemu.dtb: aplic@c000000: compatible:0: 'riscv,aplic' is not one of ['qemu,a=
plic']
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,aplic.yaml#
qemu.dtb: aplic@c000000: compatible: ['riscv,aplic'] is too short
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,aplic.yaml#
qemu.dtb: aplic@c000000: Unevaluated properties are not allowed ('compatibl=
e', 'riscv,delegate' were unexpected)
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/riscv,aplic.yaml#

I guess noone updated QEMU to comply with the bindings that actually got
upstreamed for the aplic?

--QuT3/USFLVPqyc21
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZldG/AAKCRB4tDGHoIJi
0oYWAPoDsUoaVQGx27axveY1n1lIrXkUGHlGo31YRIruXNo+ngD/R9/DjC94q7t/
JpAE9JiPE1EcGTOVFoRzpEHCL0sh8wg=
=qPe7
-----END PGP SIGNATURE-----

--QuT3/USFLVPqyc21--

