Return-Path: <linux-kernel+bounces-439988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9F29EB72B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFAB728325D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05006230D2C;
	Tue, 10 Dec 2024 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujJozhiH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672E422FE1E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849578; cv=none; b=SdpJwQdCikA77A9safT0tvmnf1iEF/MC4T2yGjzf7zm0z2Wiao5RPSJEXx/d2xLYIYdhGqpBUsaBQEvamEn6zkk4+4B1geoe6gmJltyF3jmwsB1zO+lgal1HdpFnWqjGdk2rppj8sAkmSDAq+tmYlq/ZpcvgIhf8BGRLYUi2F3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849578; c=relaxed/simple;
	bh=bt7l9QQFX2W1SBnh7LutyXggXBhQo8Dk1+MzlBzfQjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PC1zg6OxnoAzhSukuNZGVgDXryeNQwgsUoc+A8135x7MBbVFZbUWtOwRgVaIQeeYa0SBH4qz//MaG+ZNisBb7CogAq4/ciqHBN6717j6CMkj4p6qQCjc/tx/hjl3/SHPvrn3e1vmL/H6UMNsnNHJKLzvbMtHD9yyL1CO1AZwQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujJozhiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF91C4CEDD;
	Tue, 10 Dec 2024 16:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733849578;
	bh=bt7l9QQFX2W1SBnh7LutyXggXBhQo8Dk1+MzlBzfQjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujJozhiHKizSCMhx02HN0yPwCGKv5N4q+Hf8gguWZaYdrJN3Th8BjVxC3EpCQ6I2N
	 NPAfxb2Mcttztz8xo1wjtRNrW0oao6+6jrtZlKLIq29pC9bwTTC2S9LgjaCbbSYn3u
	 O79g7VKiPAAwR/toZKo6uxrMWYTZmZ/Z+rpbb/JHxw0hzgD96aN7GuY+G8XQEKNb+5
	 up6UBRW6tBUTzdj8GqgpMY+7IWtgSuqiBZSyMF9st9buHicP7CiR76Iys5f7Hr1gzi
	 0V+3J1XjN3rLV/I5GsI6VEkenY0Kvrt7x7GoZ8AjYR120ggJmDwAqN2eWRTiLFjVir
	 c/P1YncOkq6cw==
Date: Tue, 10 Dec 2024 16:52:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] arm64/signal: Silence spurious sparse warning storing
 GCSPR_EL0
Message-ID: <6d839dfb-0a85-44c5-90cc-2b2426353a5f@sirena.org.uk>
References: <20241210-arm64-gcs-signal-sparse-v1-1-26888bcd6f89@kernel.org>
 <Z1hU0Ii-Sm9NHnhj@J2N7QTR9R3>
 <20c12aac-193e-43ae-9418-39db1af4ede9@sirena.org.uk>
 <Z1ht7X2LRw34pMJK@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4GnNgA4R5gHCruw/"
Content-Disposition: inline
In-Reply-To: <Z1ht7X2LRw34pMJK@J2N7QTR9R3>
X-Cookie: Leave no stone unturned.


--4GnNgA4R5gHCruw/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 04:35:57PM +0000, Mark Rutland wrote:
> On Tue, Dec 10, 2024 at 03:44:29PM +0000, Mark Brown wrote:

> > The spuriousness is arguable, from my point of view it's spurious in
> > that we don't have the type of the system register we're writing to.

> All that I'm asking for here is a trivial rewording; make the title say
> something like:

Yes, I had already removed the references to spurious and false positive
locally and changed the unsigned long cast to a __force u64 cast.

> > I find it both safer and clearer to keep values which are userspace
> > pointers as userspace pointers rather than working with them as
> > integers, using integers just sets off alarm bells. =20

> Having casts strewn throughout the code sets off more alarm bells for
> me.

With the new code there's only a cast when we store the value to the
register, which is the point where we're discarding the type safety.

> > > Similarly in map_shadow_stack(), it'd be simpler to treat cap_ptr as =
an
> > > integer type.

> > With map_shadow_stack() it's a bit of an issue with letting users
> > specify a size but yeah, we could do better there.

> I don't follow. The only place where size interacts with cap_ptr is when
> we initialize cap_ptr, and there we're adding size to an integer type:

> 	cap_ptr =3D (unsigned long __user *)(addr + size -
> 					   (cap_offset * sizeof(unsigned long)));

Ugh, addr is also not a pointer which I'd not noticed but still.  My
main thought there was to move the cap_offset change to a second step so
it was done type safely.

> I was suggesting something along the lines of the diff below.

Yes, I know.

--4GnNgA4R5gHCruw/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdYceEACgkQJNaLcl1U
h9DMnAf/e7GYV/9VWlVJj2n1GvhEBRh0aqm9VuM+yHZ2lZYm98Zl8gnxzmSS89+Y
VVinFBnogkqH1XWjjH+DFjROYIZROKu0hawHe4sLqcnGiaZL/zVMTIzL5fFKSR4e
xFYjXL8FPrXo7UHiNTlHn1s8EAjgnVDcC1so3Rz0a+ZBVlxNJoxFsiNmGssn/Cyh
88o4ig0epIG7cGSZA8PpCKqfzd0//27M/FZIUjd5dNMtMPiuG2486l28FwOx9I+l
+nGrB5vasHm8QXP+6SnG7zbAsCMoHNnsOGpZ+ECH1x+ce5WgYWVaJ6la3+sYDGgL
A0s2LZR4PuYO7ND3w4jLX/+edR//AA==
=p+xW
-----END PGP SIGNATURE-----

--4GnNgA4R5gHCruw/--

