Return-Path: <linux-kernel+bounces-225157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F6A912CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D0B1F2487C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075F0161319;
	Fri, 21 Jun 2024 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jroCIC3Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6216A935;
	Fri, 21 Jun 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992981; cv=none; b=QpLR5Yx/YqSH5CCg/BldiEpPl1uYOakzKno/2cMC5nq1HGQaNfRJard0A0PcF2w0je4GFWMs0VHDHY+Xb9w9LN6nDJpacnI2RE7gj1Cvm4wDfm5dluOePNn2ObysId5bawlfMaH7JXMLZ1hO32YOukviMA2j0RDh7RPuiGwyrdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992981; c=relaxed/simple;
	bh=lV5vpxY7i91ZTamCgJMl2uj4acUyubWy3CFf0VMVG58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjeYOCWl57hwbHKM4xcPBmhXFvlt3svXP7GHOFaHBWwZInZVisoSLTKnduBe/eVvTc3lIk69daO2EUykWpT2/T7y3+smhKDUqZK0BbSu7hn+UbpEKWtIa5n5L3INDEGaVcc4fGb6Rg0r8tTNHx4SwFhVssBhd94PVZ8w6f4b5k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jroCIC3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2043EC2BBFC;
	Fri, 21 Jun 2024 18:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718992981;
	bh=lV5vpxY7i91ZTamCgJMl2uj4acUyubWy3CFf0VMVG58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jroCIC3Z2WvoRFEriUHXkuuZiOnhATzwUaeitybywKGEOtGWi3TrxPVYQashY+HpH
	 Psp8daSARTb24/5VrEeGgy4oZBfX2R6DkkPtHYdwTiAeyAry7N32fM0n7KcVKec5iy
	 HA6TRMTcZTm+bMIzraUk487nhSjm8BNKLv82o6jUTwevsba0HmmJB7QmCtAEvgvl53
	 nACu7FM6wA7p3GrLdRIJsCZgFAqtFF2qnpwq/XeIMbqPdP6+eh8tygzU5iKaLRuvr0
	 /ol1aIMpCwX1Z7ogxg2kCs/IPxY7YPy2FXCUtVSCrnBsiLTbjgC+9940AwW+kpyfpd
	 VoHJoGJvhMOyw==
Date: Fri, 21 Jun 2024 19:02:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>,
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
Message-ID: <20240621-cone-departed-c445e3bcee90@spud>
References: <20240613191616.2101821-1-jesse@rivosinc.com>
 <20240613191616.2101821-5-jesse@rivosinc.com>
 <ZnDmRK0ZtKzmWN5S@ghost>
 <ZnDsdzv4o/Xz9kWm@ghost>
 <e6f7a061-50f0-4a6a-a09b-468502703c20@rivosinc.com>
 <ZnSptpobfqjik3RM@ghost>
 <20240621-reveler-underfed-37600a9f16d5@wendy>
 <ZnW130PqW56CnZT8@ghost>
 <20240621175816.GD2081@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LTVlyJ3znXw1uEhF"
Content-Disposition: inline
In-Reply-To: <20240621175816.GD2081@sol.localdomain>


--LTVlyJ3znXw1uEhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 10:58:16AM -0700, Eric Biggers wrote:
> On Fri, Jun 21, 2024 at 10:18:23AM -0700, Charlie Jenkins wrote:
> > > Additionally, what are we doing in the kernel if we detect that
> > > misaligned stuff isn't supported? Are we going to mandate that kernel
> > > code is aligned only, disable in-kernel vector or some other mechanism
> > > to make sure that things like crypto code don't have/introduce code
> > > that'll not run on these systems?
> >=20
> > UNSUPPORTED will still be set by the quick probe so it would be possible
> > for the kernel/userspace to avoid running misaligned vector when it's
> > unsupported. Any kernel methods would probably want to always run
> > aligned vector unless misaligned support was determined to be FAST
> > anyway, I am doubtful that code will have different optimizations for
> > FAST, SLOW, and UNSUPPORTED but it is possible.=20
> >=20
> > I would prefer consistency between scalar and vector misaligned support,
> > but this is not a deal breaker for this patch. I am not convinced it is
> > the best choice, but I am okay with leaving this option in the kernel.
> >=20
>=20
> Note that most of the vector crypto code (in arch/riscv/crypto/) assumes =
that
> vector misaligned accesses are supported.  Many of the RISC-V vector cryp=
to
> instructions require using SEW=3D32 or SEW=3D64, and as a result, loads a=
nd stores
> of data can be misaligned unless the code changes the SEW to 8 and back a=
gain,
> which would be inefficient and add extra complexity.  I don't anticipate
> workarounds for CPUs that couldn't be bothered to support misaligned acce=
sses
> being added.

> So what we'll probably have to do is just disable the vector
> crypto algorithms if the CPU doesn't support misaligned accesses...

Right. I was thinking similarly, and that we should just disable all
in-kernel vector code if the platform doesn't support misaligned vector.

--LTVlyJ3znXw1uEhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnXATAAKCRB4tDGHoIJi
0p46AP9QHMf429CTroVDTIUETnYFoY4fH5v/C7x5Ac7RQKwtPwD/fY56J3WkdGCV
3biOKsj+RG9Hj6D8f8JtBbIs2/g33w0=
=59Qv
-----END PGP SIGNATURE-----

--LTVlyJ3znXw1uEhF--

