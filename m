Return-Path: <linux-kernel+bounces-448172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9749F3C81
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D9C18897CF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B021A1F63CF;
	Mon, 16 Dec 2024 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/xbPaZc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182431F63D9;
	Mon, 16 Dec 2024 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383010; cv=none; b=muj4FcAJaF3xKI4+NfTzG4XWbIkRhpelryWgYStGUBPIP9NptadELGpkoo9GucLlP9zZI/opaq4De9z6wXwVfSvUfzGnB800VdeZI/QC2/pKT5r/SsxB8ADpyEDGDfJ+2orzsVXpy4X2h7YsWFcXVIVUkC4Q8JtX/QFAzczYJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383010; c=relaxed/simple;
	bh=F1GGXFKM2vPoBAMUY2f+aZJfQU5i2+Rz7sxAkluP1WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOHcYpuyqvS0X8W1D/oK7j5Ib/obIN7H6L0qs1KjG6xkvPb7q23oauYC1XelSQeqMRoP3XMhLLnyJCijpLcxeNeRP0aVeuQ1rhiTVY1BanOnEjgTsfs+9BfKVMOkxE2LPjMTR/jXbt3gc5w69K7jFNw43aJr7T6tizLD9SB3aGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/xbPaZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60541C4CED0;
	Mon, 16 Dec 2024 21:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734383009;
	bh=F1GGXFKM2vPoBAMUY2f+aZJfQU5i2+Rz7sxAkluP1WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/xbPaZcdNjZ9OIc+YLMwcwx6dC1yrtNJJ2i/EBm5Nqs2+xptnf6UXTcNCH7b4lmm
	 DHw3zP+c1a46yc62cnfnOrXLeuIK0WoA+pOTzjXytub1/GCV9jb+DHmRNSgII5Pp/c
	 LQCuOPYMmwYnq9pQKIuqn1XHRoIML7h1SGTWpaaz1cXb7+Onp4untwC3E+JNiG9oFM
	 UF14Ri/Sg7Fcib5qfL79bai1M2YYBY+5LbDKbieIqurZ2FZKLNvmaLH5IImw3vSQWJ
	 8A3M7t2CkIQ2CBHITdYjh1ublI3jUU+Lfvl8kFArXXImqLuGn59ipC/LuKzM3/+LeM
	 yrR0YKHwU/LnQ==
Date: Mon, 16 Dec 2024 21:03:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, maz@kernel.org,
	ryan.roberts@arm.com, Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH V2 11/46] arm64/sysreg: Add register fields for PMSIDR_EL1
Message-ID: <ae09e8bd-271a-4942-ab59-f257a67b991b@sirena.org.uk>
References: <20241210055311.780688-1-anshuman.khandual@arm.com>
 <20241210055311.780688-12-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d+2E/ZEnkGK2vKyL"
Content-Disposition: inline
In-Reply-To: <20241210055311.780688-12-anshuman.khandual@arm.com>
X-Cookie: Be different: conform.


--d+2E/ZEnkGK2vKyL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2024 at 11:22:36AM +0530, Anshuman Khandual wrote:
> This adds register fields for PMSIDR_EL1 as per the definitions based
> on DDI0601 2024-09.

Reviewed-by: Mark Brown <broonie@kernel.org>

--d+2E/ZEnkGK2vKyL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdglZsACgkQJNaLcl1U
h9DjrAf/YmSAgJm0a5DqQgM6gTVYp0uHGDnVkImVfPXXd7Rz1jRCENLVQmBN9rUD
qVAi3jy7NcSP5SIKpEYNGotp1A2EUdUG5xH4rCzlzEOGyuf9tFd1PHTPsvZZN8XY
HhkZMQC6hW1MTw+sMm612Sbc9VLgzG6RuC1lSOUOVuEd4k/3d2oaLFIPawV49TZm
Kw4U05rq0TpAE6D5RDgWGWJXeliq8RqFrGPnWi9Pr5r98/VqDOyz/5sqjznoUvDo
SxnBVTahAbUlA0KaRHg57EW+jVxI0yzB9YT8hRuZHXHia8xMGQiPPNycDMO71rJV
tikpTZzBnYMW0yid/LmKVozwScpN9Q==
=kQw8
-----END PGP SIGNATURE-----

--d+2E/ZEnkGK2vKyL--

