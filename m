Return-Path: <linux-kernel+bounces-180010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B708C68D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F39C281029
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92EB1553B7;
	Wed, 15 May 2024 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUEUoATW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB372F870
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783681; cv=none; b=tOrQok4S2aObunhm80xofWoluWNfKHvFCvE7eQ48+sSfXJQCQUesBklpKCHMwfJpuKr8dY1yqRmA1o3w8tyY9lmHgeaG+qo9K0Sfnf0/CmQhISuH+k3LZuD5+h2UWvfOg0wKxKDgH5ogj3nWdpgpQECq/pTVLFARg7Pc0U9LCtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783681; c=relaxed/simple;
	bh=j/XnY4Ou9a6eJs+MOmPai9peUKhp5Tll7YO5cG6SzzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEpDjsLjoBBggP/eclz/hK6rBfz5EKcIi1T2PpS7lmAlNaF/c4L668L4uFplcqdhyv4shv/i8ufDtMaKJMfENkofGfikhNqkwJuymm7GYModcX/1RfNl1dPmtb4IR+ZmBCwHoZlQieSBRbwFsobYEmkTa394rGco0UTo174U3ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUEUoATW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C58DC4AF07;
	Wed, 15 May 2024 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715783680;
	bh=j/XnY4Ou9a6eJs+MOmPai9peUKhp5Tll7YO5cG6SzzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUEUoATWfr34myIc0rnXR0ELSQlSHOVVtrffGh6wdBaiV1iMv8fn/Dylc4VdJ7eIa
	 z/IFSMUy5AAksOk8fPYFcD+kchrQ7y3ZuqZNyKrqyK3WKhfCnBGUNFqGE5++MQtMe9
	 UWv8nfk3G7wo27kskoEEljP1JbNJa912uxc7ud7NiI9Dqq3CjYG1CXz82ykprcqjcC
	 XJbjW1RX5pJ/KbOjpoC8Dh/uCKH/UBs1EkGLSo9sWLNnh7y2agam9IlM7QXGabTwn7
	 uxFm+Y7weh8PId23dRle1mBqIN8DBiLDmd/w/HHsHJzZu9tb5esgvWVkYo0Zs1n4W/
	 bIqV0TDUTF60Q==
Date: Wed, 15 May 2024 15:34:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Song Liu <song@kernel.org>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andy Chiu <andy.chiu@sifive.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_V
 Kconfig option
Message-ID: <20240515-subpar-implement-6fcf333ce9d3@spud>
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
 <20240507-compile_kernel_with_extensions-v2-2-722c21c328c6@rivosinc.com>
 <20240510-earthly-regress-7a8c8dba55db@spud>
 <Zj6U7sZNNh8GQPYM@ghost>
 <20240510-pursuable-oppose-e0b8430271f6@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZKjQ/5BhNQvy54yM"
Content-Disposition: inline
In-Reply-To: <20240510-pursuable-oppose-e0b8430271f6@spud>


--ZKjQ/5BhNQvy54yM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 11:26:22PM +0100, Conor Dooley wrote:
> On Fri, May 10, 2024 at 02:43:10PM -0700, Charlie Jenkins wrote:
> > On Fri, May 10, 2024 at 09:43:33PM +0100, Conor Dooley wrote:
> > > Hey Charlie,
> > >=20
> > > On Tue, May 07, 2024 at 06:36:28PM -0700, Charlie Jenkins wrote:
> > > > Current versions of the kernel add "v" to the march and then immeid=
ately
> > > > filter it out such that "v" is not passed to CFLAGS.  Instead of do=
ing
> > > > this filtering, code blocks in the kernel that want to use vector
> > > > assembly have been changed to locally enable vector (using ".option
> > > > arch, +v").
> > >=20
> > > Other content in the series aside, since this is a change that could =
be
> > > made independently of the main series objectives, I figured it was wo=
rth
> > > pointing out that this is not a change without downsides: I think that
> > > it would drop support for vector with most versions of LLVM as
> > > .option arch support there is much more recent thing than it is for g=
cc.
> > > Off the top of my head I don't know exactly the versions involved, but
> > > it is something like LLVM-14 supports vector but only LLVM-17 and lat=
er
> > > supports .option arch.
> >=20
> > Toolchain incompatibilities are always fun. It does look like .option
> > arch was introduced in LLVM-17. That would be a regression. We do use
> > .option arch for every other extension, but vector was treated special
> > when it was introduced unfortunately so maybe we have to live with the
> > weird march parsing hack.
>=20
> I wrote out a long message about the history of some of this, but right
> at the end I was scrolling through my chat logs with Andy and realised
> we actually did make it depend on AS_HAS_OPTION_ARCH, so it should be
> safe to do without regressing anything. I didn't notice in the diff that
> the AS_HAS_OPTION_ARCH was a movement, not an addition. Maybe Andy knows
> why, despite the dependency on the assembler having it, we didn't use it
> everywhere.

And while I remember, the bits of this doing the .option arch conversion
should be (IMO) split into a different patch to anything dealing with
Kconfig options etc.

Cheers,
Conor.

--ZKjQ/5BhNQvy54yM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkTH/AAKCRB4tDGHoIJi
0szcAQDBzSfhT6hyr1aMrYz0B6QSH4FaqNn9GXsP9yi3ZgA6aAEAqEXaBTtCPjux
6DPqxss1XZfW3iAObMh2xDZIwaJlnQk=
=+Ld6
-----END PGP SIGNATURE-----

--ZKjQ/5BhNQvy54yM--

