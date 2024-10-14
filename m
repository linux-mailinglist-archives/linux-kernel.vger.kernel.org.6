Return-Path: <linux-kernel+bounces-363977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2974B99C924
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3509293CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E5A198A1B;
	Mon, 14 Oct 2024 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBZjdVlu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F1D15AAB6;
	Mon, 14 Oct 2024 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905935; cv=none; b=TAvW1FyLXkTYbH0RSDQ016VM4NjCpeTY7BgZgNV1x5PRQ4WfQyncyBVDcQvXCOhskzbwZrlBArlAcDGsyjkvlgOSLDO5BTQGEpAlz5Qxl2GTRcJFmnmAvBJveBESH2kBpUEZxXMpyCLDqZnnRSa1sw478K1Fr6O+kbfVsqa4Dxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905935; c=relaxed/simple;
	bh=8VfuUeVgtGH6z1bv8BILTJVErAHzlY7901fz61AWmVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T31QdXqANsLgI2fgH9ioIoswQq+1Ac+kAQGUsjx6Xhr2jYTE3Ahbzn44QvlnOKsVUXXK591DLAWVQUgB4BS2lEVUEJiGADxh1bp1VDZbVgVH0C9929DKB/8cuuiapacgI3rCEH566ixVp3oQRv2D3QZS6L++33r7bhnSU/Wi0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBZjdVlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7AAC4CEC3;
	Mon, 14 Oct 2024 11:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728905935;
	bh=8VfuUeVgtGH6z1bv8BILTJVErAHzlY7901fz61AWmVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GBZjdVlu4Jj13xJuF4qu25fsYJTIPeBYkyw6aGaayoz/Xrjs7lhrWmvvu6ipvEZea
	 cOExRLfYqbbgzXg7Drv7cz/T7gq3ADxS82SDi7PQk+50F4rOTK1d0SkV+L1D3cOM9j
	 jv+GGA4FnP4T1bC4kysnH16Gflod0iLpodrURWXbd5qqEKXVDdzkytBa/23HdqNRGq
	 Yz0IICQTHAEvOFEF2TnKQF1kKg8EQDX/ExbbMRuddnMXngLRjfVIl/FnbvrJU4SHiR
	 B6qXaN/TXrEoiR+aqRwBURIrVXlpqALzPBU+EaUFOSSNTtlHHUs8cHINMzS3wyk1eX
	 rdQy+3QNRDOhQ==
Date: Mon, 14 Oct 2024 12:38:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>, Takashi Iwai <tiwai@suse.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-sound@vger.kernel.org
Subject: Re: [RFC PATCH v1 22/57] sound: Remove PAGE_SIZE compile-time
 constant assumption
Message-ID: <Zw0CyAlSmaxOCZJl@finisterre.sirena.org.uk>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-22-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ycN+RKQXjDkOKbxT"
Content-Disposition: inline
In-Reply-To: <20241014105912.3207374-22-ryan.roberts@arm.com>
X-Cookie: Q:	How do you keep a moron in suspense?


--ycN+RKQXjDkOKbxT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:58:29AM +0100, Ryan Roberts wrote:
> To prepare for supporting boot-time page size selection, refactor code
> to remove assumptions about PAGE_SIZE being compile-time constant. Code
> intended to be equivalent when compile-time page size is active.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

As documented in submitting-patches.rst please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

> -static const struct snd_pcm_hardware dummy_dma_hardware =3D {
> +static DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST(struct snd_pcm_hardware, dummy_=
dma_hardware, {
>  	/* Random values to keep userspace happy when checking constraints */
>  	.info			=3D SNDRV_PCM_INFO_INTERLEAVED |
>  				  SNDRV_PCM_INFO_BLOCK_TRANSFER,
> @@ -107,7 +107,7 @@ static const struct snd_pcm_hardware dummy_dma_hardwa=
re =3D {
>  	.period_bytes_max	=3D PAGE_SIZE*2,
>  	.periods_min		=3D 2,
>  	.periods_max		=3D 128,
> -};
> +});

It's probably better to just use PAGE_SIZE_MAX here and avoid the
deferred patching, like the comment says we don't particularly care what
the value actually is here given that it's a dummy.

--ycN+RKQXjDkOKbxT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcNAsgACgkQJNaLcl1U
h9BWAgf+LdKxooT0VD6Ci0TP5dkUHa2sxEvt7Ga+Fb/ouyFg4FxRMAkp+sEwiikJ
t69JrZ/RBXdF9knOyE22pj9DcD1zT0AlAIaI/G5ecJXLd3zIZJClHeMAJgfPtMEo
9CN1OU0Q3Snm6m1AiwZ45f1Xkj6b6nldlpRG1BcPTgYKB+C9STCX5809fm2dVFbF
w1LTjRW8FHla+sQs25Q71IIgAGo16QKJ9bB2uB5RM6BQXuiz1oht8QVU+9yjsRUO
cvAccu9UaUkYxy0tNHgHV0puMi3kzx8TvqtJpjs2cwOZCcm4J6AoLJlrGHBERLWr
K1YwrVWJypo+R9VFxN6GMOoDgoGNmg==
=I1aS
-----END PGP SIGNATURE-----

--ycN+RKQXjDkOKbxT--

