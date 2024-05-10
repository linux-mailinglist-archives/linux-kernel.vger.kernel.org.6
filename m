Return-Path: <linux-kernel+bounces-175433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A688A8C1FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DEC1C21823
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AFA15FA7D;
	Fri, 10 May 2024 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvX2y8ZJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380821BC2A
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329542; cv=none; b=ozlqIVcZLqAhoK3Osm9dR90JdFYwr+zf6f65LnhCX7/t7qLmzVjGe7P2alkvEcMzhU5N2nhCzxa1DQfjclfBG9gXyuk7FDO9Sv75Jh9MiRr1W42ow8wDy1s9Na/08th4GpJa95D7iJBivPhF3fp1oan8CgMDps9pbjDkCp9YMUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329542; c=relaxed/simple;
	bh=x7eOLArKZlJ6Jjdv6wdjIvSJbMgG4/RroQBS+sVq94A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hf23Amt0vwnUQ3aEdMLPdh9fv6Pb8IUS7JlYgSOuPlcf4uA7yZ4djAHR6kCs2FsHn+y6ryWaQE0XLc5izcdo6pscoKSwI5IJ/DKje3urDUVX/v4l0b6U36MJLiDuZiMvFFyFEmaFilGnPU+Kv0Sry/SaGC/IZcaBqCi+N8Dzcv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvX2y8ZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210FFC113CC;
	Fri, 10 May 2024 08:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715329541;
	bh=x7eOLArKZlJ6Jjdv6wdjIvSJbMgG4/RroQBS+sVq94A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvX2y8ZJLu3RkYqJQvbbcfiofmJLuXo21dv+0w1PP6AlhjElmbUmTWBcJJrFwvX6z
	 TYbMWTxPHVB8/qwTRmfUfsOakuPE3H+qCB1swBQKz+6VrAfxpixQbMvDODiGu2BD2v
	 /neuwXES6X9NQfx/fbQ5dRuJFrULKWHh1ixC4xcQVOZZV7DNzvZlLJ/hQq8DovubR5
	 Y6Nui23vJGpF4M5ZixJVHqGUfQlFqkl0sjFvf+vh2dWrk90McnfW5e8TOGvekx5xhB
	 7K7lFembeD4k211WzPEYLmn/CE22TvH62rysGn/qy4qK1m2aJv6bZeVkPtnRq/Bx1p
	 4UdPP3KDnzRcQ==
Date: Fri, 10 May 2024 09:25:37 +0100
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
Subject: Re: [PATCH v2 0/8] riscv: Support compiling the kernel with more
 extensions
Message-ID: <20240510-okay-trade-8826cb134979@spud>
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
 <20240509-uptown-aging-5bdec4730d70@spud>
 <Zj09IUE5k1EJL08X@ghost>
 <20240509-google-passing-3e7577235c44@spud>
 <Zj1UUIY8RYV1kJLM@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EwfUi93w0+FmVOuD"
Content-Disposition: inline
In-Reply-To: <Zj1UUIY8RYV1kJLM@ghost>


--EwfUi93w0+FmVOuD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 03:55:12PM -0700, Charlie Jenkins wrote:
> On Thu, May 09, 2024 at 11:08:34PM +0100, Conor Dooley wrote:

> > Maybe if you read what I wrote you'd see what I was getting at, or maybe
> > not as I might not have been sufficiently clear. I'm not saying that th=
is
> > particular optimisation is not worth having, but rather than I wanted to
>=20
> I seem to frequently give you the impression that I don't read what you
> say before responding.

Does it happen frequently? I don't really recall it annoying me before.

> What we each view as "important" in the kernel is
> different so we come from different places when approaching a problem. I
> respond in the way that I do not because I am not listening to you, but
> simply because I have a different opinion and I am not explaining that
> properly.

If you're trying to describe a different opinion, responding to the bit
I was talking about, as you do below in your latest response is ideal.
Responding inline but not actually addressing the points I was making
did make me think you were [un]intentionally ignoring what I was trying
to say.

> > see why this particular optimisation was worth maintaining 3 code paths
>=20
> I interpreted the "3 code paths" as with Zbb + 64 bit, with Zbb + 32
> bit, and without Zbb. I directly responded to that by saying that we
> could eliminate all of the code paths that are not Zbb + 64 bit could be
> eliminated. I should have given performance numbers for these alternate
> cases too, and somebody should have asked. I agree that performance
> needs justification, and I understand that I did not provide ample
> justification in this patch. All other architectures optimized these
> code paths so I figured that was sufficient justification for riscv to
> do the same, but I understand that it is not.

And hey, if you look at the commit in question, who acked it? I'm just
saying that I think we should have a higher standard going forwards.

> > for but the commit message does not detail any of the benefits, and
> > looking at the cover I discovered that it was not tested in hardware nor
> > seemingly with a real test case.
>=20
> It's hard when riscv currently is very focused on microcontrollers.

Zbb is actually implemented in hardware, so testing it in the real world
is not a barrier. Palmer probably has a JH7110 board that someone gave
to him is not using...

> These changes are in order to help future hardware that is more focused
> about performance.

I'm not replying to most of your response rn, got other stuff to do, but
what I was trying to say is that I think the point at which optimisations
for future hardware/extensions should be merged is the point at which
those extensions are no longer future.

> That's why I contribute this upstream with the hope
> that other people, like me, care about performance.

Heh, that could be read to mean that I do not care about performance,
which wouldn't be true.

Cheers,
Conor.

--EwfUi93w0+FmVOuD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj3aAAAKCRB4tDGHoIJi
0nK5AQCoDMSe9DzUyhpQR58HC2BsiABcEwTWZgGhSBBKbfG+FgD+LfsnoPklGhGT
eJ6+WpbCfqceocD7hR5oKi+JaTKMMAs=
=9cVI
-----END PGP SIGNATURE-----

--EwfUi93w0+FmVOuD--

