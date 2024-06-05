Return-Path: <linux-kernel+bounces-202919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74938FD2FD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DE3DB212CA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8196C14D6F6;
	Wed,  5 Jun 2024 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQBIbr1K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D294597F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605297; cv=none; b=QdfVXf3FB1vJjln72H4ydRRU2kheJfhZ0GmstUl62AIGU9XlzvWL7+XrOeKJ2m1Z/fY9QnVj9XNi7EDrWSIpObrb85VupkJepOWH8budX1rgggk5y1dQJwBvohtanb6egg0YYT+UoqaEUCwMhe4+AZkGaFtL2opkz/mT8dXeq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605297; c=relaxed/simple;
	bh=xUjOgD1MyQ9M5v+aEoVa+5lBN47le78b6xl8mERqNMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ME0Ro+YgSDhMJ2BIdvt7ID35Ey11G5+ISjHUVF/XfEofrhBfRZcs8HacHreq7S0VxR8OjRJOTHE3nHkiAHVb38bGlq1IZUmFIhSZb/6Z7NiKeywlub6VjpNL1NQJAN+/I5MuehICktDxNWg1GE9b4CH51tuaSgO6dj83MrFCkaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQBIbr1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB2EC2BD11;
	Wed,  5 Jun 2024 16:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717605297;
	bh=xUjOgD1MyQ9M5v+aEoVa+5lBN47le78b6xl8mERqNMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQBIbr1KCC2UDPT1LxhnakDfxnaoCREnhIPWuz0dcxbM21NXf3c5aD2MLx1YzZ75a
	 0504O+ZkHJ90rqRDmXZfBSKzybYjRdR4LuG/xKKeehpAvnzDx0i5ylN5qL2E/8MGmQ
	 9LYLUZx1Is3g88LL47P80XZHqOva46h9iDq2af82/j39TkZxQ71WBJiFVZN+Y79vVw
	 MJVxUAzzLTl7Ub5TvfwqP/zs8aY4wC95C64eu5LQEsWDHTQZi9xGpl7x/9Egvggr7B
	 jABJvOFRQzf4uk7JXGc+YjUhza+k6b3hdy9Ru9WEtoLLyTKPRPpSPzhUM0xvq+9luL
	 7uWNo+RBv7REw==
Date: Wed, 5 Jun 2024 17:34:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Evan Green <evan@rivosinc.com>
Cc: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
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
Message-ID: <20240605-swipe-giant-2f9659fbf430@spud>
References: <20240604162457.3757417-1-jesse@rivosinc.com>
 <CALs-Hsu5LakOVKvGRP0-sbq5ptH8FLPGhBAkupv3tRLKVAdnUA@mail.gmail.com>
 <20240605-bullfight-ivory-b0151ad2b987@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8xKL+FQLxTuCrMWr"
Content-Disposition: inline
In-Reply-To: <20240605-bullfight-ivory-b0151ad2b987@spud>


--8xKL+FQLxTuCrMWr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Jun 05, 2024 at 08:54:21AM -0700, Evan Green wrote:
> > On Tue, Jun 4, 2024 at 9:25=E2=80=AFAM Jesse Taube <jesse@rivosinc.com>=
 wrote:
> > What value should be returned when V is not enabled in the kernel, or
> > V is not supported in the hardware? Currently in the code it would be
> > UNKNOWN, right? Is that what we want, or is it worth differentiating
> > "no support for V" from "I don't know the speed of misaligned loads"?
> > Maybe UNKNOWN is the right value, as there are other values to tell
> > you V is not enabled.
>=20
> I think UNKNOWN is fine for !V, assuming identical definitions as scalar.

I dunno, maybe we should set it to UNSUPPORTED in that case, but there's
probably some funny behaviour around the v prctl we might need to be
aware of. If the system has vector, we should probably figure out the
actual speed is, but not report it while vector is disabled from the
prctl?

--8xKL+FQLxTuCrMWr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmCTqwAKCRB4tDGHoIJi
0iTYAQDoRc7CTqJQPG3KQEVPKCP3+Otu7uuOldxgilGh0Fu6VAD/Twk8nc9C3hfp
zLZbFEP0/FzGD0K2QtWUaQT0WccX7Qs=
=dr74
-----END PGP SIGNATURE-----

--8xKL+FQLxTuCrMWr--

