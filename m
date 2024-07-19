Return-Path: <linux-kernel+bounces-257082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 032EC9374FC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C161F21E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AF86FE16;
	Fri, 19 Jul 2024 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYdclaLp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0CD208BA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721377510; cv=none; b=NZJSZx0XBze7UPDEOM1wO1q/8eLkkz+JDhGjUAd7dMXw7V8ovKsWY+kGDZLQj0Or3o18+mWFGBwQSMo+omSRYlvBPyjcf1C9UtVodAr01RVhFX96FG7gjD2nft1co+xiaAi7PaKekude3peZEAicXc78lCSKWx84351t8tvTcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721377510; c=relaxed/simple;
	bh=LM592MhcG52g/Uy25xMnj5tFMtQlEAaW7s+pk78voK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VO5RZGT7skxKirJXw0Rgyf9IUKmRW4Ldy+5upmbxB5SjlUDONBiEsqbGv6a3Ejr0qnb0osw0xeNGaOUYgaJTS1H3vx5ZJAAOE86swyjMnhlE5VZhMWtH7cmGYhjE4lQBtIgXzk/0iLzYoIo1EYmN1GpAUM5BnMv1PoNUP453pzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYdclaLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA259C32782;
	Fri, 19 Jul 2024 08:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721377509;
	bh=LM592MhcG52g/Uy25xMnj5tFMtQlEAaW7s+pk78voK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYdclaLpdJbN7LOhN06Kw/8fZWJACXXvGTJXZLE/fjBz3DOGva5/xoEW8XXmHq+KG
	 rDWW16qhBdrKiM7az1dw2QEma/lqVuNvsUWnsxR5jCInM30mHHIzonxJPARWa1xz1u
	 kxzPc4JbPXJRmZ63/7jnFcM1CE7/SkLXVo9DtAi3L/iIEZ17ECXvB5rGW12MHHcU7n
	 RyDF+83Xq6HMnnT+0j7TRl3wcieAwh2UghGejaYD7+zo87VJfz931y4jd/8er9tfUT
	 6lX+ej8iPgpXR3YOtElx1fNbHkgFoFAuRwdHfd1qGV3Kuvt85LQ9XcUmSFoAY9fuA7
	 hvDFcNh+SYAIg==
Date: Fri, 19 Jul 2024 09:25:04 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: cpufeature: Do not drop Linux-internal
 extensions
Message-ID: <20240719-deity-squander-e17b4dfed649@spud>
References: <20240718213011.2600150-1-samuel.holland@sifive.com>
 <20240718-a5097a4070f457529d2fff91@orel>
 <a36e07a1-f4da-4d6f-9e68-929b77b70836@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2cm0NOChvUbrKYjc"
Content-Disposition: inline
In-Reply-To: <a36e07a1-f4da-4d6f-9e68-929b77b70836@rivosinc.com>


--2cm0NOChvUbrKYjc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 09:11:20AM +0200, Cl=E9ment L=E9ger wrote:
>=20
>=20
> On 18/07/2024 23:57, Andrew Jones wrote:
> > On Thu, Jul 18, 2024 at 02:29:59PM GMT, Samuel Holland wrote:
> >> The Linux-internal Xlinuxenvcfg ISA extension is omitted from the
> >> riscv_isa_ext array because it has no DT binding and should not appear
> >> in /proc/cpuinfo. The logic added in commit 625034abd52a ("riscv: add
> >> ISA extensions validation callback") assumes all extensions are includ=
ed
> >> in riscv_isa_ext, and so riscv_resolve_isa() wrongly drops Xlinuxenvcfg
> >> from the final ISA string. Instead, accept such Linux-internal ISA
> >> extensions as if they have no validation callback.
> >=20
> > This assumes we'll never need a validation callback for a Linux-internal
> > ISA extension. We can make that assumption now and change our mind
> > later, but we could also add Xlinuxenvcfg to riscv_isa_ext now and
> > modify the places where it matters (just print_isa?). If we add
> > Xlinuxenvcfg to the array with a NULL name then we could do something
> > like
> >=20
> >  print_isa()
> >  {
> >     for (...) {
> >         ...
> >         if (!riscv_isa_ext[i].name)
> > 	   continue;
> >     }
> >  }
>=20
> I would rather add it to the riscv_isa_ext[] array and avoid handling it
> differently. There is already the xandespmu extension in this array so
> xlinuxenvcfg can be added as well.

xandespmu and xlinuxenvcfg are fundamentally different, the former is
parsed from devicetree and is a real extension. xlinuxengcfg is an
internal flag. I don't think we should be printing it.

--2cm0NOChvUbrKYjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpoi4AAKCRB4tDGHoIJi
0hxJAP9i3N6jApI0vw2TIsG19OWezjdWX2r7e+qRhyN4c8UXgQEAl80AVpDO0HgA
Xq/YtJebpMDHWKe/KJ3Sb1gXvmg/Mwg=
=s+ux
-----END PGP SIGNATURE-----

--2cm0NOChvUbrKYjc--

