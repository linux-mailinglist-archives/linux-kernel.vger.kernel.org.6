Return-Path: <linux-kernel+bounces-230966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88946918494
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFDC2B29E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0331862B7;
	Wed, 26 Jun 2024 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcyVdO6S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FDB18629F;
	Wed, 26 Jun 2024 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412453; cv=none; b=cYQo9SYS3+9ZOd8xFYyNk2prhVl6Hld6kowTgWtrYRIGiww2UkY3Fe4C7lLk+N3zDUIX5xYBOUSTjgm1HfZAcx6OGLZlAiYbCekZdEWTam7oVggf3v2OPIzt76ggaFLuVIMFHPNLGbf4ttcpGAoprVyI8UnSV2fdG8rELeApwQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412453; c=relaxed/simple;
	bh=D3c1gQ648tEhgLlYiDSolRNCSiuz2KJRJlQeBmzlIDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gv4Deah4cmdcdm4XSx6S5MAl7M5/4TM5rUTo6fJ4s/Dwh/PwRGkNggO7UPAJnXCePxn2z1d2A/iH1vLko96mFinm6Yk5PKISEg+s/4+F+aBg7uQgqME2U1eogfDqHRe4dGQk0Uzgy87LgIo8oODfDhB5OucZq+4FOpkii/Ahv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcyVdO6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D53C116B1;
	Wed, 26 Jun 2024 14:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719412452;
	bh=D3c1gQ648tEhgLlYiDSolRNCSiuz2KJRJlQeBmzlIDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcyVdO6SVYo33x8dKozPZT65CCTcHp2r+Dmjtl/gV/bzVsIVi7YWz7MISUOPChANC
	 /UePeVTUD8OG5VotiuAN+xLye0XvlDZSnlfUabWKgq9qRGyJ2sozV5UML72ajB2k8W
	 zOzxKR63my7huwwO+jyPUSoHudbqCZb9K1lYuddKkqevNnoL/xVgKzFleWyKJWYscO
	 MIOApBxr4Fl3j53wa2dpjIrO6paZN7sXbqpaO2LBeaEKmnNiOOo99eKmu4ayrkaiuk
	 iGKhLkfVwPioInX5wfmgdejG1ca1B8rZs95d847V+ModAJ0Ni8wFe29LQ/apubwyrg
	 ndc/aaROSAOXA==
Date: Wed, 26 Jun 2024 15:34:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Yangyu Chen <cyy@cyyself.name>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Erick Archer <erick.archer@gmx.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/2] RISC-V: hwprobe: Add SCALAR to misaligned perf
 defines
Message-ID: <20240626-ungraded-legend-65480eabd255@spud>
References: <20240625165121.2160354-1-evan@rivosinc.com>
 <20240625165121.2160354-3-evan@rivosinc.com>
 <20240625-kindle-sanitizer-c52b48ed9b86@spud>
 <CALs-HsuEc9ympGsQP3bvXaowiAj0bq3nvD=9CcX0NNMza+79OA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8Hy1V/9xQfoCyn26"
Content-Disposition: inline
In-Reply-To: <CALs-HsuEc9ympGsQP3bvXaowiAj0bq3nvD=9CcX0NNMza+79OA@mail.gmail.com>


--8Hy1V/9xQfoCyn26
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 12:08:09PM -0700, Evan Green wrote:
> On Tue, Jun 25, 2024 at 11:35=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Tue, Jun 25, 2024 at 09:51:21AM -0700, Evan Green wrote:
> > > In preparation for misaligned vector performance hwprobe keys, rename
> > > the hwprobe key values associated with misaligned scalar accesses to
> > > include the term SCALAR.
> > >
> > > Signed-off-by: Evan Green <evan@rivosinc.com>
> > >
> > > ---
> > >
> > > Changes in v2:
> > >  - Added patch to rename misaligned perf key values (Palmer)
> > >
> > >  Documentation/arch/riscv/hwprobe.rst       | 20 ++++++++++----------
> > >  arch/riscv/include/uapi/asm/hwprobe.h      | 10 +++++-----
> > >  arch/riscv/kernel/sys_hwprobe.c            | 10 +++++-----
> > >  arch/riscv/kernel/traps_misaligned.c       |  6 +++---
> > >  arch/riscv/kernel/unaligned_access_speed.c | 12 ++++++------
> > >  5 files changed, 29 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arc=
h/riscv/hwprobe.rst
> > > index c9f570b1ab60..83f7f3c1347f 100644
> > > --- a/Documentation/arch/riscv/hwprobe.rst
> > > +++ b/Documentation/arch/riscv/hwprobe.rst
> > > @@ -215,22 +215,22 @@ The following keys are defined:
> > >    the performance of misaligned scalar word accesses on the selected=
 set of
> > >    processors.
> > >
> > > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of =
misaligned
> > > -    accesses is unknown.
> > > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN`: The performa=
nce of
> > > +    misaligned accesses is unknown.
> > >
> > > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned accesse=
s are
> > > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED`: Misaligned =
accesses are
> > >      emulated via software, either in or below the kernel.  These acc=
esses are
> > >      always extremely slow.
> > >
> > > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned word access=
es are
> > > -    slower than equivalent byte accesses.  Misaligned accesses may b=
e supported
> > > -    directly in hardware, or trapped and emulated by software.
> > > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW`: Misaligned word=
 accesses
> > > +    are slower than equivalent byte accesses.  Misaligned accesses m=
ay be
> > > +    supported directly in hardware, or trapped and emulated by softw=
are.
> > >
> > > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned word access=
es are
> > > -    faster than equivalent byte accesses.
> > > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_FAST`: Misaligned word=
 accesses
> > > +    are faster than equivalent byte accesses.
> > >
> > > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned acce=
sses are
> > > -    not supported at all and will generate a misaligned address faul=
t.
> > > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED`: Misalign=
ed accesses
> > > +    are not supported at all and will generate a misaligned address =
fault.
> > >
> > >  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int wh=
ich
> > >    represents the size of the Zicboz block in bytes.
> > > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/inclu=
de/uapi/asm/hwprobe.h
> > > index 22073533cea8..e11684d8ae1c 100644
> > > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > > @@ -66,11 +66,11 @@ struct riscv_hwprobe {
> > >  #define              RISCV_HWPROBE_EXT_ZVE64F        (1ULL << 40)
> > >  #define              RISCV_HWPROBE_EXT_ZVE64D        (1ULL << 41)
> > >  #define RISCV_HWPROBE_KEY_CPUPERF_0  5
> > > -#define              RISCV_HWPROBE_MISALIGNED_UNKNOWN        0
> > > -#define              RISCV_HWPROBE_MISALIGNED_EMULATED       1
> > > -#define              RISCV_HWPROBE_MISALIGNED_SLOW           2
> > > -#define              RISCV_HWPROBE_MISALIGNED_FAST           3
> > > -#define              RISCV_HWPROBE_MISALIGNED_UNSUPPORTED    4
> > > +#define              RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN        =
 0
> > > +#define              RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED       =
 1
> > > +#define              RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW           =
 2
> > > +#define              RISCV_HWPROBE_MISALIGNED_SCALAR_FAST           =
 3
> > > +#define              RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED    =
 4
> > >  #define              RISCV_HWPROBE_MISALIGNED_MASK           7
> >
> > How come the "old" names do not need to be preserved for userspace?
>=20
> It depends on what exactly the big userspace compatibility rule is.
> This preserves binary compatibility, which I think is the big one, but
> breaks source compatibility, though with an easy translation to fix.
> We could keep the old names around, but then it seems sort of silly to
> introduce the new names. I introduced this patch upon request, so I
> don't personally have a horse in the race on this one.

So apparently this isn't quite Palmer actually wanted. In today's call
he suggested that he'd send a new version himself, but also that what we
should do define a new key for scalar /and/ new add new defines values that
contain the word scalar, retaining the old defines. The values can of
course be the same.

--8Hy1V/9xQfoCyn26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnwm3wAKCRB4tDGHoIJi
0pN+AQCreK6NjvZnRI9VZsvMHlvKpUtNrWcwhuTMHxzCmRVdvgD/YODVuyDP1okz
Il+G9mctAu4ZDZGzZc/ojuyFxxOcXQk=
=TfxS
-----END PGP SIGNATURE-----

--8Hy1V/9xQfoCyn26--

