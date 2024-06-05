Return-Path: <linux-kernel+bounces-202856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC50A8FD1F7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6878B283952
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F22B6CDA1;
	Wed,  5 Jun 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkcFclWH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0392145340
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602311; cv=none; b=GvTEBPKdMsy3z1ZEdsFL3fvOh/ZCJldNxt11Zgojc4M/5I1jCmuaewZmg4xA31vYDJXj8BCCv9jvxJPPwyaFLpyBeg9kCw9fpc4GXPgEAHBSCjFXUvuCRs5JbVvQictFiRjl3oAfytIoFwtyiGxqQgXawzAiz2QLp/IO4AgzAHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602311; c=relaxed/simple;
	bh=j0rMndXLq1rio0UdMWk+Pzy9T/J6NqtZCqpB/roM3rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0UWk/aO126S2MDIEYMUfpGRdBVVKcVO2pI/sdiiYk2MMP5+FBcIhN3JsjbrayzUO86N98V6fAe/AfSGaYCk4sD+1DxKnv3dAOpU5UR3CYxVtNywEFhG4Z5GWB4jkD6GDQd/6DxGEnLRcC4VfN+P6VPygk5IiUFYyCbs15DQvtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkcFclWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0941BC2BD11;
	Wed,  5 Jun 2024 15:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717602310;
	bh=j0rMndXLq1rio0UdMWk+Pzy9T/J6NqtZCqpB/roM3rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HkcFclWHz1QL9rIC3mApEB7RDOsAgvw3yccqB0UO8WGi56FP0DQKJi8c4RjOYbYuG
	 7XojgoBqScWJV3khwJMgmmZhFEZuadYXtWSlPh+u5qJM1sIvLEMLVgU2Kqz9ltvmmF
	 JTJ83iK0LnBmip8qHlgyB/z6kayd1JZmAKqKuaX+PYY0Sd1Lc19bzmNQNZFsuQU78p
	 8M5LvlPfFfkNtDar6BUQyfSFFmLXaNIIUBL4Uk4jbeeJXe5L1xxTY5DvOasGJtp4kR
	 6YFDotTR36BCFIh0dXnrZNJ3JgvzwKnHHr7lebNLGHwy+9KnWWnD2+NONqctCo+wqV
	 jcAlJN42BWO8Q==
Date: Wed, 5 Jun 2024 16:45:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Erick Archer <erick.archer@gmx.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v0] RISCV: Report vector unaligned accesses hwprobe
Message-ID: <20240605-chowtime-mannish-d0f428acd173@spud>
References: <20240604162457.3757417-1-jesse@rivosinc.com>
 <8e2556d2-8021-4e4c-9380-7568ff74a84f@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="03IvgSR7vpRDfuV8"
Content-Disposition: inline
In-Reply-To: <8e2556d2-8021-4e4c-9380-7568ff74a84f@rivosinc.com>


--03IvgSR7vpRDfuV8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 12:42:10PM -0400, Jesse Taube wrote:
> On 6/4/24 12:24, Jesse Taube wrote:
> > diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/ke=
rnel/unaligned_access_speed.c
> > index a9a6bcb02acf..92a84239beaa 100644
> > --- a/arch/riscv/kernel/unaligned_access_speed.c
> > +++ b/arch/riscv/kernel/unaligned_access_speed.c
> > @@ -20,6 +20,7 @@
> >   #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
> >   DEFINE_PER_CPU(long, misaligned_access_speed);
> > +DEFINE_PER_CPU(long, vector_misaligned_access) =3D RISCV_HWPROBE_VEC_M=
ISALIGNED_UNKNOWN;
> >   #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> >   static cpumask_t fast_misaligned_access;
> > @@ -264,6 +265,8 @@ static int check_unaligned_access_all_cpus(void)
> >   {
> >   	bool all_cpus_emulated =3D check_unaligned_access_emulated_all_cpus(=
);
>=20
> There was talks about Zicclsm, but spike doesnt have support for Zicclsm
> afaik,

Support for Zicclsm just means that it can perform misaligned loads and
stores to cache coherent memory. I guess support in Spike would involve
setting that in its devicetree iff/when that's the case.

> but I was wondering if i should add Zicclsm to cpufeature and aswell.

Ye, please do add detection for Zicclsm. I think that should be fairly
straightforward to do, nothing too special to document.

Cheers,
Conor.

--03IvgSR7vpRDfuV8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmCH/wAKCRB4tDGHoIJi
0r7xAP9jbFQzTrog7i5n5EAYAE+bJz/oSCWgrT9GztBbC6wUjgD9GX0VhFIUjIEh
r5T/gvSXy7WZaTg4asdowbl5nicgfAQ=
=oWHY
-----END PGP SIGNATURE-----

--03IvgSR7vpRDfuV8--

