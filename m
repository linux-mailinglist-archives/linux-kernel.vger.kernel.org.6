Return-Path: <linux-kernel+bounces-176272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79B38C2C99
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6332228562D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 22:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0513D260;
	Fri, 10 May 2024 22:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5vbAAzy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A613D244
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379987; cv=none; b=oy8igNGIMW3sdiyfqbC4OfBpnnolRzhT4H24511oO26lf1O9H6Ym3C91nrDk2DDvrSrZ5jY3d/GknBUnIqQa04m7cQtwpcBYBvOtys9jtz9dgbgojbQ5e8sSJTlOrAVIabympBOn5W1z4V/saluXpwKTjqgr2lg4DhBRLZn9HJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379987; c=relaxed/simple;
	bh=7AiDI83wh1yuDTxM8zawvskTQliLVpgN03KQsOSmIbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnXqQXlFwzIMA/bkAIB9GSq5b08StT1rxsRx1iRIMuxlAf9+zSct/1yl87QsANl4OF/fGNaPvTOkbDVwruhh+Y5rcRdLzEm8UNilDOuxRw3ZvafB21PCic4uj+8+nxPVJdr9raoN6x7+kf67cV2RvFEeWRSi4Z7Y74AgXxU6OKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5vbAAzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD57C113CC;
	Fri, 10 May 2024 22:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715379987;
	bh=7AiDI83wh1yuDTxM8zawvskTQliLVpgN03KQsOSmIbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5vbAAzyygPUoflDfm2+WfORsmKIWrU5hyDenSGkQpfTj3vlQ1o4tBqK+Hg0zTSiA
	 d69twgicFFhPkapfZVrTAjoh6J9jiO5lmuwlb7a38ykiZ2aD4+OiN0cuWnGPgkhyq2
	 zxLJoyITqmNPmfFFnwAl7iZikmc0lLP3KwbywOJpMfWG9d+hIj7Dg03jBMgaXQL8IQ
	 RBu3nrBZyoANA5z1DHPxL89svP9WQ8nTEHNpjcBvcpPkBxwuferQZg6wWvz8+vTURA
	 R62ZtkeuLBlKr9AsmxFxsuU3xJdvbxVb7BwZ/lSkl4bhC4yTgy5q6hEwxW52XhgWu2
	 DfN6Fc1hCQOZQ==
Date: Fri, 10 May 2024 23:26:22 +0100
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
Message-ID: <20240510-pursuable-oppose-e0b8430271f6@spud>
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
 <20240507-compile_kernel_with_extensions-v2-2-722c21c328c6@rivosinc.com>
 <20240510-earthly-regress-7a8c8dba55db@spud>
 <Zj6U7sZNNh8GQPYM@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HEtmufuxgphf9/yt"
Content-Disposition: inline
In-Reply-To: <Zj6U7sZNNh8GQPYM@ghost>


--HEtmufuxgphf9/yt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 02:43:10PM -0700, Charlie Jenkins wrote:
> On Fri, May 10, 2024 at 09:43:33PM +0100, Conor Dooley wrote:
> > Hey Charlie,
> >=20
> > On Tue, May 07, 2024 at 06:36:28PM -0700, Charlie Jenkins wrote:
> > > Current versions of the kernel add "v" to the march and then immeidat=
ely
> > > filter it out such that "v" is not passed to CFLAGS.  Instead of doing
> > > this filtering, code blocks in the kernel that want to use vector
> > > assembly have been changed to locally enable vector (using ".option
> > > arch, +v").
> >=20
> > Other content in the series aside, since this is a change that could be
> > made independently of the main series objectives, I figured it was worth
> > pointing out that this is not a change without downsides: I think that
> > it would drop support for vector with most versions of LLVM as
> > .option arch support there is much more recent thing than it is for gcc.
> > Off the top of my head I don't know exactly the versions involved, but
> > it is something like LLVM-14 supports vector but only LLVM-17 and later
> > supports .option arch.
>=20
> Toolchain incompatibilities are always fun. It does look like .option
> arch was introduced in LLVM-17. That would be a regression. We do use
> .option arch for every other extension, but vector was treated special
> when it was introduced unfortunately so maybe we have to live with the
> weird march parsing hack.

I wrote out a long message about the history of some of this, but right
at the end I was scrolling through my chat logs with Andy and realised
we actually did make it depend on AS_HAS_OPTION_ARCH, so it should be
safe to do without regressing anything. I didn't notice in the diff that
the AS_HAS_OPTION_ARCH was a movement, not an addition. Maybe Andy knows
why, despite the dependency on the assembler having it, we didn't use it
everywhere.


--HEtmufuxgphf9/yt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj6fDgAKCRB4tDGHoIJi
0lfQAQD3cQ2CGBi7hXtxX18Wz1zL4peotma/GipMZCf24Lst1wD+Pe1HhV+6Rivu
m6xh9DDrjmnxYPbvbcSjixAM7a5evwc=
=FWXT
-----END PGP SIGNATURE-----

--HEtmufuxgphf9/yt--

