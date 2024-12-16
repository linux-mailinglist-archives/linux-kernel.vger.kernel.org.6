Return-Path: <linux-kernel+bounces-448153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4259F3C36
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B5D164760
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE071DB53A;
	Mon, 16 Dec 2024 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry74bAht"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FAC1D54D6;
	Mon, 16 Dec 2024 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382660; cv=none; b=j875MrFSFHsD/aStX3cIC39Ks+wJVQC2lbKhUS46g/SsvdxVv46FHV4ICFIjn47ECU3Ee/9TJ2eND5Nn5DZ89Knjznq0PmUGG4hOrEKJ9RVjg2pp1/bVrNDA0rFbX5s6k6VxcktlypZavk4owNSsEfGIfUgyedu28yAYnbYPIqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382660; c=relaxed/simple;
	bh=dUCokILFAhe1TeQ8AP9BFXp7WcCOGZ9VoQeUHpvzSVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfuLFQ6HzjKS8eEks4GsGvn1EL0cP05sla7GFM3fPTgjE3MT4wuPSsxqwVER0utefkvTneK+KmSLA1iuSyEeKbiI6Dz79sTlwqiaI0cB8+X96nhfFMuiCHdadeg+rfaFvh1yRMFZKSVpElHyQ8bYqMRGZuYzdi+PtmnA5HVgIAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry74bAht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79813C4CED0;
	Mon, 16 Dec 2024 20:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734382659;
	bh=dUCokILFAhe1TeQ8AP9BFXp7WcCOGZ9VoQeUHpvzSVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ry74bAht+j7Yb+3PLt9ikvHcUjFI/Rjq96N/KKb/4PjRcvJCCJEbWNEe0L4HZY2xU
	 fIAwLehF3EgBLz5RvEybSN08cu6WQ+RnX0qA8eTFCl55Eo4pcuAzDETyoF7LUXpn2r
	 hcXBuQYcHT0lNg81f49GHQyAdDBAl6TbBMtN6EOzTimXXiWudQ1XQfmby0FnXPzy+x
	 C9EIR7+kRU+ABKboDqo1tui044995Csa5BaQxBeRUSICMz43wbpug6moFz7te7PG8L
	 M0qtUgRXMG7WXlPLiHeRBCatW9WbEGb/xAWDaJnP7mOZSDcPJv90SNfR6TNuhkkSDB
	 83UO7/cSSyZoA==
Date: Mon, 16 Dec 2024 20:57:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, maz@kernel.org,
	ryan.roberts@arm.com, Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH V2 10/46] arm64/sysreg: Add register fields for MDSELR_EL1
Message-ID: <9004e368-6e0d-4313-8ae7-62e3200697f7@sirena.org.uk>
References: <20241210055311.780688-1-anshuman.khandual@arm.com>
 <20241210055311.780688-11-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iHVTl3Ik9oIY/II9"
Content-Disposition: inline
In-Reply-To: <20241210055311.780688-11-anshuman.khandual@arm.com>
X-Cookie: Be different: conform.


--iHVTl3Ik9oIY/II9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2024 at 11:22:35AM +0530, Anshuman Khandual wrote:
> This adds register fields for MDSELR_EL1 as per the definitions based
> on DDI0601 2024-09.

Reviewed-by: Mark Brown <broonie@kernel.org>

--iHVTl3Ik9oIY/II9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdglD0ACgkQJNaLcl1U
h9AOFwf7BA2WfqloQj9HA2ADyHaPT54vh7gI/1Ca4P+RV6QXVNk8heRuDU4KGu/v
R4G59TH4DzmpTitMKTuJRVfCbRGx9ye++8k6cRRcvoT2Zmj6u0HbdmP05MSGczl0
d3D2VApNIWS0WJuSsyuq1AUZ5Wt0/mHnXr5nqQxVevGW41Fc+w37y0ccjOVsDjRE
DoudrfrUL9Fx9pnwyt+kDsVYqzS2+zYawsDtCAagiesIqEI34AMCMhcYPLkICQ8G
YuE76bqbaKQNBYaVQ8nhQy3mP4HzTOKtgIW5wHT0zMolTGW/HvUmRZF1Yq4N90ox
JPWfTzzY9Ev15BDJiGuzmPHPttHM8A==
=ObPL
-----END PGP SIGNATURE-----

--iHVTl3Ik9oIY/II9--

