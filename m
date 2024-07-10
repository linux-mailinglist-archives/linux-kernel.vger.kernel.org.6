Return-Path: <linux-kernel+bounces-247758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F2F92D427
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63BF1C228C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC10193468;
	Wed, 10 Jul 2024 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWaCs5LU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D890193453;
	Wed, 10 Jul 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621437; cv=none; b=mriNdgUBsLVk9mVKh1uwtoHbt0yuCLwvhemM5PqDteTZJpZ86aNyGs+pj14YKm+vVgMbWGYK5l8nTsEkQOip8D/+/41ONlE0RqDppLiA8BZJD+rP6wHeBlnWw+5PcUhuGcxPvs2ZbOpQ7Z8WrcQh189PhcT7ze93/oE+y26slkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621437; c=relaxed/simple;
	bh=7YzqRCYnt7MuRGKtu80TloyRA0Nph6JUjkvK5cC5ud8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWrcWF9bjOh1Y7M4HD+J/934h0O7INwu7eRMMYmTQUU+9g6DbzxRwtFh7MLI6uoFMehEAz8hNWQqtXUSc/pvR8hFhj5kTLLImWNIwJOmkaL4enbWFqqwCRfLroUPE3axmbTFGsJ14OcM4l1rc6lzUv5MeTvUEBIFyL3pk8TS4IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWaCs5LU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D842C32781;
	Wed, 10 Jul 2024 14:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720621437;
	bh=7YzqRCYnt7MuRGKtu80TloyRA0Nph6JUjkvK5cC5ud8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWaCs5LUsTpKJj42IbfEAwUsNLAWqYFKeFrXCk3URlSPK6zaYnls3Oq16pN1OlB7J
	 oGfzI7n7RBIZa3f+94nTLNN/LgCSjSb0CwitQxM8kIw7hjfwtZ9pOoUfqSo2QJFMSe
	 DzFGTqODIJn33YbOUmgnlGUzGVsSmxnaiyOT2O5Hmi81z7QmZxNEDuREx3W+hS2/VV
	 3LYsp4YiMZPDteQciLofyO4O6apxU8/x9km1ZLQn6KyDzF2aZ9zvGeoWjZDvT4cpry
	 K+CGflRVXCNzWaTMoeWF5usQM3pIKgkpDUTCMwSbIJuAZ/U84rg4NSPQ40q7RO30Jz
	 x44kwur+s3THA==
Date: Wed, 10 Jul 2024 15:23:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Wende Tan <twd2.me@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sami Tolvanen <samitolvanen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Charlie Jenkins <charlie@rivosinc.com>,
	Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v4 4/4] RISC-V: Use Zkr to seed KASLR base address
Message-ID: <20240710-stroller-serve-3ab5d6d8d5a1@spud>
References: <20240709173937.510084-1-jesse@rivosinc.com>
 <20240709173937.510084-5-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7zh9yYUyOTKyeTN/"
Content-Disposition: inline
In-Reply-To: <20240709173937.510084-5-jesse@rivosinc.com>


--7zh9yYUyOTKyeTN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 01:39:37PM -0400, Jesse Taube wrote:
> Parse the device tree for Zkr in the isa string.
> If Zkr is present, use it to seed the kernel base address.
>=20
> On an ACPI system, as of this commit, there is no easy way to check if
> Zkr is present. Blindly running the instruction isn't an option as;
> we have to be able to trust the firmware.
>=20
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Tested-by: Zong Li <zong.li@sifive.com>

My heads a bit addled from being sick still, but I think you've dealt
with the things I had send on the previous version and I didn't spot any
obvious problems with the parsing.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--7zh9yYUyOTKyeTN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZo6ZdgAKCRB4tDGHoIJi
0pyWAQC29yv8Hh+seQ8rlWltrhX7hdTycKox6W76tesnacZjZgEA89qbqP3Fetxj
ie+EVMpvY5yVfOsu3tnzj8YF1fnwGw4=
=WyJk
-----END PGP SIGNATURE-----

--7zh9yYUyOTKyeTN/--

