Return-Path: <linux-kernel+bounces-189038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 098828CEA37
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E02281AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4801844376;
	Fri, 24 May 2024 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKyUccAg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB8640849;
	Fri, 24 May 2024 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716578075; cv=none; b=BpeppYeH/eFTy76sg12AtYwpe1+IzsLZcWhjLzWyCQMx37Z1zxCJBdJ+oeuMpuI5ioXStRpcETCXTggL42DPpWuIewPI6vu1oiQehIyCwyNi99DqAJjWSzOm6DvmfL+QaXTyI+qVakLJpyBx+QQkDWJrYWR1Pl6lwiaWMY3opBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716578075; c=relaxed/simple;
	bh=KDWjHn6X23J3MNH+ElTxn7OMjIfbknqvcHnHXTliwfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6TKg2YvSCpoUyDvZLBA4Bh00wBRFdnc973IycP6nlDExCyXfLTI0WJ8j0v8ypwqgK0BWc5skflARzh+gKxq/qaO9K5pVdXWyBYQmShGez+TaBNrO1UpGageqAIOHvxTdfrUrw4/L8ioXzM+B8Hf99/QkVsDqUDelaCCSXktzuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKyUccAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0339FC2BBFC;
	Fri, 24 May 2024 19:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716578075;
	bh=KDWjHn6X23J3MNH+ElTxn7OMjIfbknqvcHnHXTliwfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKyUccAgahk7VOYtR0R1dCMT3bwKqK5liRZoBAAl0rAsQw6FLIEKCI88WrZ4+UQiW
	 GnpWcFrq3Pk8gPG90y5ixLlH+1hUxqEU3e1vpq/hCdjezG9siNHoTiwJr8frig4mYj
	 KZ6XlacY8WZVrYXqbyn6h4MoZ5kz1r+BuiK97LuRgp1goPfEVL3H+RW0+HSdHELwax
	 4gC3Cp/s09ry6oBTnUFwwO7lgn6nA/B+/Ks9VjC17ENI0YNRDJIqW6/nrCkQprFPlJ
	 Y2qXpNP196n9xSeUY993vNhD6+qCymuK2joQa2R9f0UUMvV86MubkoBR2C0w22GBtK
	 MMQU8O7G4290A==
Date: Fri, 24 May 2024 20:14:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, corbet@lwn.net,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
	costa.shul@redhat.com, Conor Dooley <conor.dooley@microchip.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: RISC-V: uabi: Only scalar misaligned
 loads are supported
Message-ID: <20240524-ruckus-trickily-1cda26c1a455@spud>
References: <20240524185600.5919-1-palmer@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/ZOy8tql2JsUXvLD"
Content-Disposition: inline
In-Reply-To: <20240524185600.5919-1-palmer@rivosinc.com>


--/ZOy8tql2JsUXvLD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 11:56:00AM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> We're stuck supporting scalar misaligned loads in userspace because they
> were part of the ISA at the time we froze the uABI.  That wasn't the
> case for vector misaligned accesses, so depending on them
> unconditionally is a userspace bug.  All extant vector hardware traps on
> these misaligned accesses.
>=20
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  Documentation/arch/riscv/uabi.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/arch/riscv/uabi.rst b/Documentation/arch/riscv=
/uabi.rst
> index 54d199dce78b..2b420bab0527 100644
> --- a/Documentation/arch/riscv/uabi.rst
> +++ b/Documentation/arch/riscv/uabi.rst
> @@ -65,4 +65,6 @@ the extension, or may have deliberately removed it from=
 the listing.
>  Misaligned accesses
>  -------------------
> =20
> -Misaligned accesses are supported in userspace, but they may perform poo=
rly.
> +Misaligned scalar accesses are supported in userspace, but they may perf=
orm
> +poorly.  Misaligned vector accesses are only supported if the Zicclsm ex=
tension
> +is supported.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Now we just need to find someone that cares sufficiently about Zicclsm
to write the bindings, detection and hwprobe key for Zicclsm. Maybe I'll
be the lucky fool, depending on what the x280 does...

Thanks,
Conor.

--/ZOy8tql2JsUXvLD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlDnFgAKCRB4tDGHoIJi
0j7sAQDFc2gfp1NN+WtHV5hOv86OGvZlIMu340StRhWaH9OJVAD+P0fMN7A4/i2x
j7jW9XsRLDijgGsUemTQdO+5qHFSpgQ=
=FnYL
-----END PGP SIGNATURE-----

--/ZOy8tql2JsUXvLD--

