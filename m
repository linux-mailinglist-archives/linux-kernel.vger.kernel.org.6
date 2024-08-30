Return-Path: <linux-kernel+bounces-308821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 172A796622D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B34B22D18
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA501A284A;
	Fri, 30 Aug 2024 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thiwJNo+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D99416EB5D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022782; cv=none; b=W9NkEteHLnMJQ3FjFTvkdaniOSUyYg/gGQPCm/o/5R17NnEhpQKdnACK6z3EDgYhWNLXQLPjl9m8/7YRYW3tCgWYg8ptVebAevIH6V8440+tdJz0Unv7zSXoB8/ymU4khEsOwniiTlPAOAjYxSXzi+3QnJQckhKO5MPdP5BhZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022782; c=relaxed/simple;
	bh=uFTaIQmao++WMsK76RUhgx7ncRMszlOrVoJG7KLW/pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skjLCV7xOblZtXFPhwYKsO8F0xXlrpzoPgflbK58Mwn69J5sixHIxelwij3gSiuXh9+WvHBbUtCM22v3eMAlADi4kaOS8ksmzsImnn31eY25UeMswLPKEHbjwJsCCKtOOmNby60Oloy8xsDTvqN7FlAq33iXTjnVS9GrTE8I63E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thiwJNo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057ADC4CEC2;
	Fri, 30 Aug 2024 12:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725022782;
	bh=uFTaIQmao++WMsK76RUhgx7ncRMszlOrVoJG7KLW/pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thiwJNo+yK7GHsNtmTM1yn1DKXlkqlRYnEFUnY2oA+mxB3+F2KV6UlI2GBjOk/wQD
	 ndyDoP0kq1Mye0jZ7NRldzLTa4Cbl9lRM//bRBpwJksL2lU7td4jTCIUJ3IRrU8q0B
	 Msh5oRfaw0Qn784WulZkjUkZDnQCNwnhsKO1jHVgw/BYpOq0xOIq9WYN84MEMdGn+A
	 57D5N5sg1/PVnkg83RoL1CenvcUIeMuRkdnDyOf5odKifWWScviOPT6kjLF0fHsDNF
	 gHYJQ94qu59DoG4tW6hD6YqnYwk7EYX/R6EGiWzHTs73v/fMisuw6XVDVCB4Spk9Uu
	 Bj8t24Vk0FlMA==
Date: Fri, 30 Aug 2024 13:59:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Aishwarya TCV <aishwarya.tcv@arm.com>, dev.jain@arm.com
Subject: Re: [PATCH v2 06/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <622b3769-fb5c-4a3e-82b7-1301623faf43@sirena.org.uk>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
 <57f55a1473586a88211e04b44c6b128332d4272c.1724441678.git.lorenzo.stoakes@oracle.com>
 <51452bab-65ef-4924-8ca8-61536d2bc168@sirena.org.uk>
 <9dcddc2c-482b-4e12-a409-eee8d902ba26@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+HwhJGFuaIQgoGSS"
Content-Disposition: inline
In-Reply-To: <9dcddc2c-482b-4e12-a409-eee8d902ba26@lucifer.local>
X-Cookie: for ARTIFICIAL FLAVORING!!


--+HwhJGFuaIQgoGSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 10:22:53PM +0100, Lorenzo Stoakes wrote:

> Thanks, I figured out the problem, it's not arm-specific, I was running
> self-tests but eyeballing-failure resulted in me missing this.
>=20
> This is a product of vma_merge_extend() invoking vma_merge_new_range() wi=
thout
> having determined the next VMA correctly, after moving from vma_merge() (=
which
> looked this up for us) to vma_merge_new_range() (which does not).
>=20
> This is after having adjusted the assumptions between v1 and v2 of the se=
ries in
> each merge function, and I simply missed this mremap()-specific case.
>=20
> Andrew - I enclose a fix-patch to get a fix out for this asap, but I am d=
ue a
> respin relatively soon and will also include that in this.
>=20
> ----8<----
> From 3678f8a53f98de52f11946d4d32e6fb239d11c2f Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Thu, 29 Aug 2024 22:18:02 +0100
> Subject: [PATCH] mm: correctly determine vmg.next in vma_merge_extend()
>=20
> vma_merge_next_range() requires that the caller specify prev AND next.

This fixes the problem for me.

Tested-by: Mark Brown <broonie@kernel.org>

--+HwhJGFuaIQgoGSS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbRwjgACgkQJNaLcl1U
h9AXbAf9FkWBHDchz8lVBIYqoq4in52zRMMQobF6cNp8/HyUUDWMa9OWZJk8byZZ
3ogVYfXYc6BPFaY/ePBCH8ByVdUHb0r5zC6vuyK9lKg10/O0lHWKPCLBdJz+Vnuz
NDAygjzV3tGPTlGSr/vZK4h2lSX/fFw59dd/1fsebnDxv+0PPnbSvzx3LKEVoXj2
r5DIbk/CuIYuvDbs2MsYTZBorDJ5PBQI9rtAXZ8SdQpSWfWZyprKED2kwnsH1IJi
Ht8207Q05g9e9Ck607vSElZzSIIFkgbHcWPUFTrJ+8Uydt8Kasp09SmszudU6SJg
4Xd4pXqGzH9L27f63tdt81Rs7SHmRA==
=OiSW
-----END PGP SIGNATURE-----

--+HwhJGFuaIQgoGSS--

