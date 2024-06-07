Return-Path: <linux-kernel+bounces-206730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9403900D17
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA23A1C214A6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD35153804;
	Fri,  7 Jun 2024 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWbBwSm6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F317479DC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792795; cv=none; b=IkC3GS/o2rn0r2sXSPcaEw1JZCdC6tu1cV/oghaAS9Y6OTNOzZ+OJrOhm+Vgnl9UnLKAeNMrkvmxA/9yYbfMbdgwcZACX/4CXSyLnNwdWWymbuM+CbJhv26Md5lrZu5pEjuE3dACq/ywPAs/5HqzjuN5nIzJ2N/Dm5NswSCS4PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792795; c=relaxed/simple;
	bh=4XNrpSMvFp8sQ1EJsXH4i20xSwPT4VZNeTgz4nZcwwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbsxUc2JPNR2UX0DS8jWCVSlhKTHWh/hPXdd7xtQppYzyIQNWNrliAICSaMCBq3EHU99d3cnVBa5pq4FJ94gA5YJ8pm0kySWOkuZunRYcevPRBGznkmVJPzoPRKuHk3Jj648SMgcFmfIPU7hk3TT8k3DTp/UTLt4uGqoA/bxf5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWbBwSm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D78C2BBFC;
	Fri,  7 Jun 2024 20:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717792794;
	bh=4XNrpSMvFp8sQ1EJsXH4i20xSwPT4VZNeTgz4nZcwwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JWbBwSm6Xfw5e0/unvO61jPE+gOGcElpb66E4q9WgYx4KK8JSvu9G0ZqG4BwcH3op
	 FR+R0RgAUiCoZrRW50D+yZUJCjixDAoQsA5N13g1fsgq+PUjZ7lRMx33yUwQYVHEj0
	 to82/Lx3LsN4tZ8TEJtljTpgPp9dEnTteiRv2WHZepQrkYAbefE9yyAFZHYnY1M6ep
	 mv5V4P01b7KDPtwFWhDiDQeZP88O47tAqALfGR9raWW6tBJuvXBy6RobsWNiKZN3st
	 n1NKrPbiLqOE5G3BUYQbM1h6JO8Yp3u6NaZGGKrefX1Lqzg89xXx5kIc0tbync6h8I
	 6qsBCCFfDdyqA==
Date: Fri, 7 Jun 2024 21:39:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] riscv: Enable cbo.zero only when all harts support
 Zicboz
Message-ID: <20240607-unwound-ethics-b6bf97cddc3e@spud>
References: <20240605205658.184399-1-samuel.holland@sifive.com>
 <20240605205658.184399-2-samuel.holland@sifive.com>
 <ZmNu9AkHOTGj9uvw@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7d2x7RwjZFbRmT7E"
Content-Disposition: inline
In-Reply-To: <ZmNu9AkHOTGj9uvw@debug.ba.rivosinc.com>


--7d2x7RwjZFbRmT7E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2024 at 01:35:00PM -0700, Deepak Gupta wrote:
> On Wed, Jun 05, 2024 at 01:56:45PM -0700, Samuel Holland wrote:
> > Currently, we enable cbo.zero for usermode on each hart that supports
> > the Zicboz extension. This means that the [ms]envcfg CSR value may
> > differ between harts. Other features, such as pointer masking and CFI,
> > require setting [ms]envcfg bits on a per-thread basis. The combination
> > of these two adds quite some complexity and overhead to context
> > switching, as we would need to maintain two separate masks for the
> > per-hart and per-thread bits. Andrew Jones, who originally added Zicboz
> > support, writes[1][2]:
> >=20
> >  I've approached Zicboz the same way I would approach all
> >  extensions, which is to be per-hart. I'm not currently aware of
> >  a platform that is / will be composed of harts where some have
> >  Zicboz and others don't, but there's nothing stopping a platform
> >  like that from being built.
> >=20
> >  So, how about we add code that confirms Zicboz is on all harts.
> >  If any hart does not have it, then we complain loudly and disable
> >  it on all the other harts. If it was just a hardware description
> >  bug, then it'll get fixed. If there's actually a platform which
> >  doesn't have Zicboz on all harts, then, when the issue is reported,
> >  we can decide to not support it, support it with defconfig, or
> >  support it under a Kconfig guard which must be enabled by the user.
> >=20
> > Let's follow his suggested solution and require the extension to be
> > available on all harts, so the envcfg CSR value does not need to change
> > when a thread migrates between harts. Since we are doing this for all
> > extensions with fields in envcfg, the CSR itself only needs to be saved/
> > restored when it is present on all harts.
> >=20
> > This should not be a regression as no known hardware has asymmetric
> > Zicboz support, but if anyone reports seeing the warning, we will
> > re-evaluate our solution.
> >=20
> > Link: https://lore.kernel.org/linux-riscv/20240322-168f191eeb8479b2ea16=
9a5e@orel/ [1]
> > Link: https://lore.kernel.org/linux-riscv/20240323-28943722feb57a41fb0f=
f488@orel/ [2]
> > Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> > ---
> >=20
> > arch/riscv/kernel/cpufeature.c | 7 ++++++-
> > arch/riscv/kernel/suspend.c    | 4 ++--
> > 2 files changed, 8 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 5ef48cb20ee1..2879e26dbcd8 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -27,6 +27,8 @@
> >=20
> > #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
> >=20
> > +static bool any_cpu_has_zicboz;
> > +
> > unsigned long elf_hwcap __read_mostly;
> >=20
> > /* Host ISA bitmap */
> > @@ -92,6 +94,7 @@ static bool riscv_isa_extension_check(int id)
> > 			pr_err("Zicboz disabled as cboz-block-size present, but is not a pow=
er-of-2\n");
> > 			return false;
> > 		}
> > +		any_cpu_has_zicboz =3D true;
> > 		return true;
> > 	case RISCV_ISA_EXT_INVALID:
> > 		return false;
> > @@ -724,8 +727,10 @@ unsigned long riscv_get_elf_hwcap(void)
> >=20
> > void riscv_user_isa_enable(void)
> > {
> > -	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EX=
T_ZICBOZ))
> > +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
> > 		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
> > +	else if (any_cpu_has_zicboz)
> > +		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
>=20
> `riscv_has_extension_unlikely` will check bitmap `riscv_isa[0]` which I t=
hink gets populated
> by boot cpu (correct me if I am wrong here). So as long boot processor ha=
s the extension, it'll
> try to set it on CPU which doesn't have it.
>=20
> How about doing this
>=20
> `riscv_fill_hwcap_from_isa_string` checks and enables bitmap for all CPUs.
> So make a check there and if any of the CPU dont have `Zicboz`, then set =
a global bool
> `zicboz_cpu_not_homogenous`.

That is what riscv_fill_hwcap.*() already does, we track both what each
cpu has and what is common across all cpus.
riscv_has_extension_[un]likely() is a test for whether all cpus have the
extension.

> Now in `riscv_user_isa_enable`, check following
>=20
> If `zicboz_cpu_not_homogenous` is set, then you already detected that som=
e of the CPUs don't
> have support for `Zicboz` and thus you wouldn't set for CPU which even ha=
s the support and
> print a warning message.
>=20
> If `zicboz_cpu_not_homogenous` is clear, then that means all CPUs support=
 the feature.
> You simply enable it on hart.

--7d2x7RwjZFbRmT7E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmNwFgAKCRB4tDGHoIJi
0mowAQC+vvnP/CghzXrekQcv9TZWEb/wPwRLBKlAIdsA7M7HHwEAncawDymOXnKT
urx08zh66oYywZj5ZD9n4+dbAGz+5A0=
=1CLG
-----END PGP SIGNATURE-----

--7d2x7RwjZFbRmT7E--

