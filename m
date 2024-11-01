Return-Path: <linux-kernel+bounces-392266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934AE9B91B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50865283E80
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA501C28E;
	Fri,  1 Nov 2024 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INmbzHNb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74C7179A7;
	Fri,  1 Nov 2024 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466931; cv=none; b=K7aM2NLJ75TlTiXY77rNtOCgRPbZQJiZGkYaWUTFp1Cyf/Nzu1lFmZZ383SeFl7UaDo/UJNgO/zChG9/mOf4gEXtwjMf5g17slZxrFiNgx5vZFu5PbDcR6F8i8YTKBrpspxlJPLGgAbNsLG0yIB6alS36Q8LizhRjEqAp2w0t2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466931; c=relaxed/simple;
	bh=34jK9u71dBeRq4LfD7okVBhggB093QCI3qnCn6bIW8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auzm+1yjUZ7mI5nmD7h+saRvZrZdert4jg/G5nc4LM7ZNwd6NSdGKJyXcAICTmCwOJO8U3qeckbRV6Bs6dXxlqbUcjLB5Z9jzoU2AwKcuD4rJgkhyB869K3PifrT/laBS9UOOldrxj0vVUbNAsOfGP4mPgzhlg18tI1Tbr+jrWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INmbzHNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF46C4CECE;
	Fri,  1 Nov 2024 13:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730466931;
	bh=34jK9u71dBeRq4LfD7okVBhggB093QCI3qnCn6bIW8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INmbzHNbQE8guAkPiUXHaHI23PG5llf459Sjls1//MK50JHkwaaRrR5Oipad3fjLg
	 eLNusZudXBFXfluRs1v0qYwMCIB8tZKzcX8NxsPpZGB2tpoGj+GEJYR9jVmZHcRGZk
	 YaOQ+29NjzYFcMbsve6xydLRqFUZQtW2/aHIpFzp4Nf4Az7n11kjWOph3h61MsXkLq
	 1zdPp7r19WOWRe7Ld2W7hgQZ45Rmq8zU2a5tI8IBVVW3WnrH7ido29+kgz7cxKCo/k
	 DFeuf9QynVs3NldqVXoyx/nJAyS/EdiSRVrON0xoSWyHkrZgiH4eYBQA+N3GG6CIjn
	 apxitUi8JdQOg==
Date: Fri, 1 Nov 2024 13:15:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: fix uninit-value in i2s_dma_isr
Message-ID: <15f9733b-fe7a-4bf2-a6b9-7f7e04cf26f7@sirena.org.uk>
References: <20241030170829.36161-1-surajsonawane0215@gmail.com>
 <635f1691-74e9-4e48-8ebf-8e7ce0c6d1e3@sirena.org.uk>
 <a4039ca2-6c76-4431-8e27-caebe1a56deb@gmail.com>
 <d97a58c7-347b-48f9-aa69-d4ff5a4038e3@sirena.org.uk>
 <e8fe072a-e1b9-41b0-9382-6562139e31d3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cVyy7pEeS6IuTpUo"
Content-Disposition: inline
In-Reply-To: <e8fe072a-e1b9-41b0-9382-6562139e31d3@gmail.com>
X-Cookie: We read to say that we have read.


--cVyy7pEeS6IuTpUo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2024 at 02:32:43PM +0530, Suraj Sonawane wrote:

> I reviewed the context around val_1 and val_2 in dma_addr_next. These val=
ues
> are expected to come from the registers when offlevel is non-zero,
> representing the next DMA address and length information. If offlevel is
> zero, it means there=E2=80=99s no offset data to process, and dma_addr_ne=
xt might
> not need updating in that case.

> A more precise solution would be to conditionally update prtd->dma_addr_n=
ext
> only when offlevel is non-zero, as this would reflect the intended logic
> without relying on an arbitrary initialization.

> Would it be better to revise the patch to conditionally update
> prtd->dma_addr_next only when offlevel is non-zero?

> Let me know if this approach aligns better with the expected behavior.

That seems like a reasonable approach, just skip the update when we
didn't read the values.

--cVyy7pEeS6IuTpUo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmck1G4ACgkQJNaLcl1U
h9BFwQf+KIyyJk/oh+z79U0Xsh5p3d0pz3LWI0nyx1LQeb1rslZk4EVdZ0/N1KDx
GoYyu+NwUS3FMtPldDfEqjFIysY8/+2+ehXaT8AO3X0AL0I85Igh2mVdSqmLGpPO
qmoBxw3KuWFH83Mc8mS4jA/YWs77oMv0aBwn4r9bz3Rcwz4f8p7Qvs44ELfOu2Ks
i55UbLOIR3tSOh7j1ya9YtMqhHGdnBAyQ0ObdexXs8z73X+rgltmz1qJ/nmUxw71
KU6/bXFO0NuXkuZoY3YKmNYXIxLLHqAFCmZ6geXU5Cs5fqP67uTSYrd8nN6zt9NZ
v6FA29VXSrxF2Cqas6soungdtdC40A==
=oCbm
-----END PGP SIGNATURE-----

--cVyy7pEeS6IuTpUo--

