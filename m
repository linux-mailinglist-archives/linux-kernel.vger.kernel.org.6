Return-Path: <linux-kernel+bounces-571322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6323A6BBB9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8543B6950
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E3E22B8C8;
	Fri, 21 Mar 2025 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ7nIWn1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970122B8BC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742563615; cv=none; b=f664hlq/DMY7C2fjgJs+MZ4yherDaCCIVKXbsJUy+tCVZWTPhASUGbXfHCNRvqj9WxCjrD4FLCCruuVjzYPy/ZITYaEsM7XxtXeLmD3VQGCRHZ2Zdld8aSUPbqv+hV9JkEEvWK9BKXg0QH68qkzbqA31PuEFNsWHwhj46HYFqaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742563615; c=relaxed/simple;
	bh=WStLqp1ynSLWMVQyUpuz+64+OhpFnQ6C/9pDM62Nmtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thPULynDW2dvDw17CufxsTCpozVIXhkpUSHdiJGZcUTqfOPtK7OijSijBYutzQsUK2Hp6Eh879n+tEWmPfnWk0m1HsNJcc5G+q9nlnwZnpC/vkH1oubesTN6O6JrGpu0WsuEq0o65UGWkIJPxTNhC9ypSYz8gD6Qh518k0MoSZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ7nIWn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB551C4CEE3;
	Fri, 21 Mar 2025 13:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742563613;
	bh=WStLqp1ynSLWMVQyUpuz+64+OhpFnQ6C/9pDM62Nmtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZ7nIWn1FdbOiqQTlwmzlTSSUH4YkroaUwwwUlRTOv5LntAydivVehC8Id7POrCDr
	 V0lXXeM3mSvn78BL1Arg9FyUOfNs4fifWc1WYi7fai4gQVTsHYF65sXI5ADL46IfsN
	 PfmBL2SEH0yD43tSsa2QI9YTDJatCqZczwqYyQbgGe7wuM95P7VSrSSPFgqeFrAiCV
	 UBIS+MCrzW6AxRGSfNVF5vAXgCdH9BsefLpNy41AjAC+rVz+xY85Mp8X0cqrbSBWvG
	 2YYDaQNpc/4tNqOcdD/GjFoxmDt4KfqQW2+JzC56alzHz5H6dw+MIHyyqXTsLqAnHg
	 AyVeSX37/zG1g==
Date: Fri, 21 Mar 2025 13:26:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/include: make uapi/linux/types.h usable from
 assembly
Message-ID: <Z91pEzSpbMn170Ku@finisterre.sirena.org.uk>
References: <20250321-uapi-consistency-v1-1-439070118dc0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="npBknlLH1QqjidJC"
Content-Disposition: inline
In-Reply-To: <20250321-uapi-consistency-v1-1-439070118dc0@linutronix.de>
X-Cookie: Well begun is half done.


--npBknlLH1QqjidJC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 09:31:17AM +0100, Thomas Wei=DFschuh wrote:
> The "real" linux/types.h UAPI header gracefully degrades to a NOOP when
> included from assembly code.
>=20
> Mirror this behaviour in the tools/ variant.
>=20
> Test for __ASSEMBLER__ over __ASSEMBLY__ as the former is provided by the
> toolchain automatically.

Reviewed-by: Mark Brown <broonie@kernel.org>

--npBknlLH1QqjidJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfdaRIACgkQJNaLcl1U
h9AxzQf/U1WhvPlqdTlxtKA91CimreaLN2n4ZKluU1rRzu0LrHuBbv3kEbzpBDmJ
oeuppRPEESGst/k+8wyCD5F9/JyqtqSNADYTteaLwMFsA3fWAvI3K39Avf2eqbMc
XTkpVJ/xKChQY7ruaI06F4uSvDGTC6BMTnGimdxvnc4ld/NgPaTkxfv29lzpRjWR
dXs2sTjy/DV1Kh3CRKGeIyPOAdg7B0Ax+2DhIOspNnbomQ2rQe28fhLjC7I1GnrL
V6VZLNEFmkhfBRlgBRBoU+01WAHSNSqPElVNvuDGvte8/Pk6xag2LjYibgfx3peA
oAsy0csE1e9XNBwMfucXrpxScw2wEw==
=9UyS
-----END PGP SIGNATURE-----

--npBknlLH1QqjidJC--

