Return-Path: <linux-kernel+bounces-245562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD4A92B466
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06155284A35
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BCC155739;
	Tue,  9 Jul 2024 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3oZYSxh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47682152E03;
	Tue,  9 Jul 2024 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518694; cv=none; b=dU0t80ZEGkBJdy3nNgULMUxV4GpHUMXa5xqbV9WA4ycunLCnZ6L87/1mrf5MGchp7mhEK3tbJhAQHv3ghhAYzsY6ZZVOl/dV7Gl2LSuvq59zD3LCBcv1W7ylpQhInqnd4KMGHrGk8ctOxkq735eQJfeuhMgYk3WOA7IICAG+7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518694; c=relaxed/simple;
	bh=bL4qqpnXgSeE002tT5hkhdq/LTVBpp3383J8u7fQ4bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1G9BqznIxbSu0szRjFLMXK+lFU0hLkw4bSMLnriHpf1zY3vaxnwrzrYoNOa4SvWdtfOBXKHpA502XfE2M1l1pZSRex5j53o6NWwP7x7BpWQiVi5QEA1UzxuO7IqRlHcnckdjRfxxuK9MIDWfxo7Hi5vn/rzfVWNKDcH9zwrJkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3oZYSxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0883C3277B;
	Tue,  9 Jul 2024 09:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720518693;
	bh=bL4qqpnXgSeE002tT5hkhdq/LTVBpp3383J8u7fQ4bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3oZYSxhrUHeBC7D3++kc3VMMIROXNpVTp/zPdT90QqvPQgNm5XI2F6MBXPM/+UA3
	 UH9RuK2MShKrBmUTslqSXwP3Vk6xC9PEhP727zHiCfE1dR9NNi04itTL2M4g2JPGca
	 DYbyB6fhgfRRpxw2TSGozYaH9fBkaZqsPy7wqUTf/Em/9DzIDZtwFFcgksMprYZaEr
	 aZMcxEFFAdQ80JKr95+yYz7gtnWdrvetTEsvaLEIzp8rQlJK8hzi7OlJIcFemoHGE/
	 v0rnx/MlMCVg9pE9T6LJmQXapizmm4+K4joqB3CEAt9ivGtpfDOMHt/a2HbXmnnjPB
	 mBMeYRnBPpOlQ==
Date: Tue, 9 Jul 2024 10:51:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Anup Patel <apatel@ventanamicro.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>,
	Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Atish Patra <atishp@atishpatra.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v14 01/18] irqchip/sifive-plic: Convert PLIC driver into
 a platform driver
Message-ID: <20240709-mutt-truffle-3ac954bc00ba@spud>
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-2-apatel@ventanamicro.com>
 <CAJM55Z9hGKo4784N3s3DhWw=nMRKZKcmvZ58x7uVBghExhoc9A@mail.gmail.com>
 <CAK9=C2WP2+gKScUFuoE9782gjSfnDtcLAw01eCwram3LMAStBg@mail.gmail.com>
 <CAJM55Z8ti-ePT0t714h1Za9X3Ns3=Fw0pCu3NZ=7eT76JU_p5g@mail.gmail.com>
 <CAAhSdy1pesbdTfWnFURMJRcy2ujjX+cXtt-cfLDj2CQf2Ua_gw@mail.gmail.com>
 <CAJM55Z_=94+aMv=ywhih44eF0pR2WXiyx3FcrwRaX6tZto4gpQ@mail.gmail.com>
 <CAK9=C2XWjtWtV1WbQrX4Cg8KyzjVevMjG18YTgQJbZxi61BFjg@mail.gmail.com>
 <ZoydV7vad5JWIcZb@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bSqWFTNZ10MZH6YN"
Content-Disposition: inline
In-Reply-To: <ZoydV7vad5JWIcZb@ghost>


--bSqWFTNZ10MZH6YN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 07:15:51PM -0700, Charlie Jenkins wrote:
> CONFIG_NONPORTABLE=3Dy
> CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS=3Dy
>=20
> A new warning is tripped:
>=20
> [    1.015134] No max_rate, ignoring min_rate of clock 9 - pll-video0
> [    1.021322] WARNING: CPU: 0 PID: 1 at drivers/clk/sunxi-ng/ccu_common.=
c:155 sunxi_ccu_probe+0x144/0x1a2
> [    1.021351] Modules linked in:
> [    1.021360] CPU: 0 PID: 1 Comm: swapper Tainted: G        W          6=
=2E10.0-rc6 #1
> [    1.021372] Hardware name: Allwinner D1 Nezha (changed) (DT)
> [    1.021377] epc : sunxi_ccu_probe+0x144/0x1a2
> [    1.021386]  ra : sunxi_ccu_probe+0x144/0x1a2
> [    1.021397] epc : ffffffff80405a50 ra : ffffffff80405a50 sp : ffffffc8=
0000bb80
> [    1.021406]  gp : ffffffff815f69c8 tp : ffffffd801df8000 t0 : 61000000=
00000000
> [    1.021414]  t1 : 000000000000004e t2 : 61725f78616d206f s0 : ffffffc8=
0000bbe0
> [    1.021422]  s1 : ffffffff81537498 a0 : 0000000000000036 a1 : 00000000=
0000054b
> [    1.021430]  a2 : 00000000ffffefff a3 : 0000000000000000 a4 : ffffffff=
8141f628
> [    1.021438]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 00000000=
4442434e
> [    1.021446]  s2 : 0000000000000009 s3 : 0000000000000000 s4 : ffffffd8=
01dc9010
> [    1.021453]  s5 : ffffffd802428a00 s6 : ffffffd83ffdcf20 s7 : ffffffc8=
00015000
> [    1.021462]  s8 : ffffffff80e55360 s9 : ffffffff81034598 s10: 00000000=
00000000
> [    1.021470]  s11: 0000000000000000 t3 : ffffffff8160a257 t4 : ffffffff=
8160a257
> [    1.021478]  t5 : ffffffff8160a258 t6 : ffffffc80000b990
> [    1.021485] status: 0000000200000120 badaddr: 0000000000000000 cause: =
0000000000000003
> [    1.021493] [<ffffffff80405a50>] sunxi_ccu_probe+0x144/0x1a2
> [    1.021510] [<ffffffff80405af6>] devm_sunxi_ccu_probe+0x48/0x82
> [    1.021524] [<ffffffff80409020>] sun20i_d1_ccu_probe+0xba/0xfa
> [    1.021546] [<ffffffff804a8b40>] platform_probe+0x4e/0xa6
> [    1.021562] [<ffffffff808d81ee>] really_probe+0x10a/0x2dc
> [    1.021581] [<ffffffff808d8472>] __driver_probe_device.part.0+0xb2/0xe8
> [    1.021597] [<ffffffff804a67aa>] driver_probe_device+0x7a/0xca
> [    1.021621] [<ffffffff804a6912>] __driver_attach+0x52/0x164
> [    1.021638] [<ffffffff804a4c7a>] bus_for_each_dev+0x56/0x8c
> [    1.021656] [<ffffffff804a6382>] driver_attach+0x1a/0x22
> [    1.021673] [<ffffffff804a5c18>] bus_add_driver+0xea/0x1d8
> [    1.021690] [<ffffffff804a7852>] driver_register+0x3e/0xd8
> [    1.021709] [<ffffffff804a8826>] __platform_driver_register+0x1c/0x24
> Emil[    1.021725] [<ffffffff80a17488>] sun20i_d1_ccu_driver_init+0x1a/0x=
22
> [    1.021746] [<ffffffff800026ae>] do_one_initcall+0x46/0x1be
> [    1.021762] [<ffffffff80a00ef2>] kernel_init_freeable+0x1c6/0x220
> [    1.021791] [<ffffffff808e0b46>] kernel_init+0x1e/0x112
> Linked as a fwnode consumer[    1.021807] [<ffffffff808e7632>] ret_from_f=
ork+0xe/0x1c
>=20
> The warning is not fatal, so execution continues until hanging at
>=20
> [    2.110919] printk: legacy console [ttyS0] disabled
> [    2.136911] 2500000.serial: ttyS0 at MMIO 0x2500000 (irq =3D 205, base=
_baud =3D 1500000) is a 16550A=EF=BF=BD[    2.145674] printk: legacy consol=
e [ttyS0] enabled
> [    2.145674] printk: legacy console [ttyS0] enabled
> [    2.155095] printk: legacy bootconsole [sbi0] disabled
> [    2.155095] printk: legacy bootconsole [sbi0] disabled
>=20
> I have not been able to discover why it hangs here.

FWIW, that's probably because the CCU is the clock driver providing the
clock for the uart, so when the sbi console goes away you lose output
cos the uart driver cannot get the right rate for its input.
You'd probably get further if you set keep_bootcon in your cmdline - but
realistically the clock driver failing to probe is gonna have a load of
knock on effects that it's probably enough to just have the failure you
link here.

--bSqWFTNZ10MZH6YN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZo0IHwAKCRB4tDGHoIJi
0vRfAP9bUI5Q8gO+0jDxlcnbZTpLWQkYqx7dZemPzbLJwoQxWgD/bpGeA4LqYj1+
AREvEnMKmNas6haB0YYEh9d10Wx65g4=
=hcxv
-----END PGP SIGNATURE-----

--bSqWFTNZ10MZH6YN--

