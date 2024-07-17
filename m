Return-Path: <linux-kernel+bounces-255149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55389933CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B86C282275
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753ED17FAA0;
	Wed, 17 Jul 2024 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7/dtYEd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84DB11CA1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721218003; cv=none; b=b+kQw+t+l+iWxhp7NU18i4WrGpSj5zwNwewkMX3NXtcs3wGYKWgjiZHIFA52204fCN9/cnyTDsChsGHLatOy1J89J2kkVJERsLKhNaBJel6yGxSpB9ZhMIwGve97GDMQ0tRoWzI3ZIjxy8ZqHC1H3WmzFYXoN5TSGIdfzZgV8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721218003; c=relaxed/simple;
	bh=nywpXi2h4zG79mMkSQKTimVu1LXY5R/z5vuogaMkbEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfotmqzT4edtpzq8lmm1b+zomlA4DWXVe0nQso9btcizFRERyvBxqXbcwbkdiCWu3/PuuRkLdvod/mGGFXyhXsqE86JJWNS6Mr+jgmUjqL76P6si+ZdCeSARqdGde5J1J/6YbmPYvKkNHlQSptxh02FtDfnZ4rHyt9SaCGAP3jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7/dtYEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6350EC32782;
	Wed, 17 Jul 2024 12:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721218003;
	bh=nywpXi2h4zG79mMkSQKTimVu1LXY5R/z5vuogaMkbEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7/dtYEd1+AotXXsTRKn/rlcwnr9eTZWcLvMN8EMhLeE+oun+q74YFw3ey/WQOmX7
	 1Pb4jRXqoNp7rmeUYACVkjM/KVIB1gncqJ6ANNpP0IzXugjBAXu8Bk+X99+ZQSXXKB
	 fqXUgy+AyVT8B2SFy1d2mfB8gtCN4jkM5A2XgCzxSJVFW8kGHr4Uo0vqObjwZ+glc7
	 D0m6C+DWLOIRDKtWgmbAutHpqtZ3dMXEJKvhTQpfNa+uGz0HhD3Nt3qH9PbWqhTAsH
	 GOUUs9TItY+iTD4yzPu0j+LmHDMag5iCO1cNm2mWdCrsQCW8CqPp5JPJzFqHcfRh2N
	 PXUoFGPWCCc7Q==
Date: Wed, 17 Jul 2024 13:06:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH RFC] riscv: Allow to build only with LLVM >= 17.0.0
Message-ID: <20240717-theft-resample-19c248bb2a26@spud>
References: <20240717111716.157149-1-alexghiti@rivosinc.com>
 <20240717-synapse-decade-a0d41bd7afce@spud>
 <203e8784-54f2-43ea-a442-833d7e4a06c8@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+0B+bzp0mRRL4CCI"
Content-Disposition: inline
In-Reply-To: <203e8784-54f2-43ea-a442-833d7e4a06c8@ghiti.fr>


--+0B+bzp0mRRL4CCI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 01:41:23PM +0200, Alexandre Ghiti wrote:
> Hi Conor,
>=20
> On 17/07/2024 13:32, Conor Dooley wrote:
> > On Wed, Jul 17, 2024 at 01:17:16PM +0200, Alexandre Ghiti wrote:
> > > The following build failure happens when using LLVM < 17.0.0:
> > >=20
> > > kernel/sched/core.c:11873:7: error: cannot jump from this asm goto st=
atement to one of its possible targets
> > >=20
> > > This is a known issue [1] so let's upgrade the minimal requirement for
> > > LLVM to the version 17.0.0, which is the first version to contain the
> > > fix.
> > I think doing this unilaterally is kinda insane, LLVM 17 isn't even a
> > year old. Debian testing doesn't have anything later than 16.
>=20
>=20
> Debian will very likely select the qspinlocks when available anyway, so
> they'll need llvm >=3D 17. And Debian won't ship a kernel >=3D 6.11 until=
 some
> time right? So they'll probably update their infra to llvm >=3D 17 (and
> they'll probably do to take advantages of the new extensions).

What I mean is that you are going to prevent people building the kernel
with llvm on machines running anything but very recent rolling-release
distros. Your patch would stop most developers, including those who don't
care about your qspinlock stuff, even build testing with the version of
LLVM that their distro provides. I'm not talking about distros building
kernels in their build infrastructure.

>=20
>=20
> > Why does
> > it need to be done unilaterally rather than just when the qspinlock
> > stuff is built?
>=20
>=20
> We can do that indeed, it may happen again and we can keep requiring llvm=
 17
> on a per-config basis.
>=20
>=20
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1886#issuecomme=
nt-1645979992 [1]
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202407041157.odTZAYZ6-l=
kp@intel.com/
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > If Nathan wrote the patch, you need to set him as the author of the
> > patch :)
>=20
>=20
> I thought I did, how should I do that then?
>=20
>=20
> >=20
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> > >=20
> > > This patch was done by Nathan, I'm just sending it as an RFC to get q=
uicker
> > > feedbacks.
> > >=20
> > > I tested it successfully.
> > >=20
> > > Note that the build failure happens on the not-yet merged qspinlock
> > > patchset.
> > >=20
> > >   scripts/min-tool-version.sh | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> > > index 91c91201212c..e81eb7ed257d 100755
> > > --- a/scripts/min-tool-version.sh
> > > +++ b/scripts/min-tool-version.sh
> > > @@ -28,6 +28,8 @@ llvm)
> > >   		echo 15.0.0
> > >   	elif [ "$SRCARCH" =3D loongarch ]; then
> > >   		echo 18.0.0
> > > +	elif [ "$SRCARCH" =3D riscv ]; then
> > > +		echo 17.0.0
> > >   	else
> > >   		echo 13.0.1
> > >   	fi
> > > --=20
> > > 2.39.2
> > >=20
> > >=20
> > >=20
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv

--+0B+bzp0mRRL4CCI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpezzwAKCRB4tDGHoIJi
0lAAAP4ukSsQNKH83VinYN4P6TvkUEYT19wBuJZQ39VnokQpRgD9F06sCd7yG2b1
Su+5N0ApRQvIXvkTAxx1AMkl5cQNKQc=
=N3ed
-----END PGP SIGNATURE-----

--+0B+bzp0mRRL4CCI--

