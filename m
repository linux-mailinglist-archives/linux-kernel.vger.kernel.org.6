Return-Path: <linux-kernel+bounces-215025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C322B908D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F0D1F2306C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E504EAE4;
	Fri, 14 Jun 2024 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gS6HM00w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D519D8B7;
	Fri, 14 Jun 2024 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375539; cv=none; b=Xxhj9X2Fik23dN1rNKQ5XQPRDNdRsq4PGx8Zkd3opCHCnhmztHYnrZTWPP+w9jUG7/w7vhW6CiUUi2LaeZB3dbgtY8tg9j9OdNE0I/WZpguks8vTdHIBNDE1tF3X0LlS9WON62lpTX9EwN5dvGjip+pKubiqfIRXW1FDIqO3KOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375539; c=relaxed/simple;
	bh=iqgP90dDsEQCkjx7UcrzAwPtRtQlcKUNmNJS3dtkUmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTZ3IGXT4afM5tizDv7D1H8apUo8/iKnLhsoN56NNPVKY4EnsXMNW8YUy5YeviQIGMX54Qs7Rp62Sfh/JTpXAqnPXCzEZ4jEajZ7Zo4c2NN8QoLnjT9G9dQqrFNdxZgVPR/kyznq7qJ+jgeTkMOW6WJHXY9mHP4wDuvAVzhIGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gS6HM00w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DAFC4AF1A;
	Fri, 14 Jun 2024 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718375539;
	bh=iqgP90dDsEQCkjx7UcrzAwPtRtQlcKUNmNJS3dtkUmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gS6HM00wZQ4biXH608dOWYvzfZ3sWln2jUaXUAfkpi0zf29YW+rb9ky9d0u3dcQig
	 U9pYfH9wdgmCVEgmpKg7LLZ/oSYBNJrRpmBY8dNLhfLIp5YOgC/6zH/ciz/hlRJe3F
	 KRmKyWfP3Oihordds7tM59CB67SY3Xf/ArB+8kWx/KSjQJt7htjvIP5rKvjRWbqucJ
	 hk92NH35caak4pX1yEamaAEx0vstdnlCutBny4Le3u248lfzSNCIPkkcsBgmCfH8fG
	 tdRkv5yQlOVM5xVKZHgKIyMHOncB3aOxQltX4kdwFPy8yk9273nBiurZSXqTsb1vcs
	 4Hqd7kw7qTv9g==
Date: Fri, 14 Jun 2024 15:32:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Jesse Taube <jesse@rivosinc.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/6] RISC-V: Detect unaligned vector accesses
 supported.
Message-ID: <20240614-broadly-lucrative-d2c1e746ee32@spud>
References: <20240613191616.2101821-1-jesse@rivosinc.com>
 <20240613191616.2101821-5-jesse@rivosinc.com>
 <20240614-viral-dinghy-71d5f6585a55@wendy>
 <20240614-distaste-negligee-ba9216a8684e@wendy>
 <acb7a467-fc0e-4f32-8410-cd7aafce8bae@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bHd5NbqcRQWbEnk6"
Content-Disposition: inline
In-Reply-To: <acb7a467-fc0e-4f32-8410-cd7aafce8bae@rivosinc.com>


--bHd5NbqcRQWbEnk6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 10:28:17AM -0400, Jesse Taube wrote:
>=20
>=20
> On 6/14/24 04:40, Conor Dooley wrote:
> > On Fri, Jun 14, 2024 at 09:36:55AM +0100, Conor Dooley wrote:
> > > On Thu, Jun 13, 2024 at 03:16:13PM -0400, Jesse Taube wrote:
> > > > --- a/arch/riscv/kernel/unaligned_access_speed.c
> > > > +++ b/arch/riscv/kernel/unaligned_access_speed.c
> > > > @@ -19,7 +19,8 @@
> > > >   #define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
> > > >   #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
> > > > -DEFINE_PER_CPU(long, misaligned_access_speed);
> > > > +DEFINE_PER_CPU(long, misaligned_access_speed) =3D RISCV_HWPROBE_MI=
SALIGNED_UNKNOWN;
> > > > +DEFINE_PER_CPU(long, vector_misaligned_access) =3D RISCV_HWPROBE_V=
EC_MISALIGNED_UNSUPPORTED;
> > > >   #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> > > >   static cpumask_t fast_misaligned_access;
> > > > @@ -268,12 +269,18 @@ static int check_unaligned_access_all_cpus(vo=
id)
> > > >   	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
> > > >   		for_each_online_cpu(cpu) {
> > > > +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
> > > > +			per_cpu(vector_misaligned_access, cpu) =3D RISCV_HWPROBE_VEC_MI=
SALIGNED_FAST;
> > > > +#endif
> > > > +#ifdef CONFIG_RISCV_MISALIGNED
> > > >   			per_cpu(misaligned_access_speed, cpu) =3D RISCV_HWPROBE_MISALI=
GNED_FAST;
> > > > +#endif
> > >=20
> > > Can you IS_ENABLED()-ify these two as well please?
> >=20
> > Ah, you can't cos the variable doesn't exist in the other case.
>=20
> Yeah kinda just dealing with how it was originally written ideally we wou=
ld
> use IS_ENABLED. I don't really want to have a 500+ diff patch
> IS_ENABLED()-ifying the original code as well. I can do that if necessary
> though.

No, dw about it. I made a mistake.

--bHd5NbqcRQWbEnk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmxUagAKCRB4tDGHoIJi
0o1sAP0TjaWh4s+Jwxjvs/uZ5QEX2QJNGQYVE//gvXVXIHZMNQEA3q14c179bYze
sMPmEmacDngXPwLaxzE2H5mG8E6jtwc=
=POGL
-----END PGP SIGNATURE-----

--bHd5NbqcRQWbEnk6--

