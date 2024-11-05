Return-Path: <linux-kernel+bounces-397016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56289BD5A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AC91C21015
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09EA1EC01A;
	Tue,  5 Nov 2024 19:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKxoGNOO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6F31EC003;
	Tue,  5 Nov 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730833636; cv=none; b=L25kT5SckA0dHRLJFpar8BFejdhiaUqxeHzlpDJo2rH2OB0RBcCWS1xi3J3iynVUSfBqJFCtCDmA42D+iKRlmCSL/z6+dcOBOq/7USOpuiMWuSJvLXIJ49mIMRQ6gdaBZSZVBJyez0q5qxgEo6KiSLfgx6AJcWtX7XG+JIcTeBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730833636; c=relaxed/simple;
	bh=by3WSMeIlp25DqmO0s/ecQ2fFxdASB3OVFPoOptdzRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9lVJfs2OZAzdaPZaEzQ47BtaGaoIuA1n+qhIP6fZU4si5OG5hWZs+OIPZkbxbpIiwnObsEvjD+LW9y8T0pblyEQ3kb24G8DyU0a/YCebYL5tijBYYJMXa1EpvvZ15P8Z1dAQfSfoRGMESF8KKxed0STT2IU25cLXGBts+OlnKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKxoGNOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA1BC4CED3;
	Tue,  5 Nov 2024 19:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730833633;
	bh=by3WSMeIlp25DqmO0s/ecQ2fFxdASB3OVFPoOptdzRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKxoGNOOE/nW+68w7Ezqn1AwZfDHPOiARia89Sf4iNLglWqrglSYIpYPkjSDKNqb6
	 koUDALI2Pldzy2eVYYbBXfkJYrfCOea3hJYgN1h42z4ITCkFDLkzJ5oxVhrIck8G3W
	 TF4IdzYnyok0+NrVbANpZXCvLP+YsWWZdZCcEX0RrtoGIbdGqko9VibeUwbs41BI9B
	 Ml+cBZVTQ6muYoliWEfFW6t71BSIEB9KmZ3rVobt4U5cdE+la0TKii03M8uCnbcm/g
	 R0DLSvQEjKskN18zj0Cc+Ao5fHgoRby+0zm1OJtwLZ51I7mRBY+mKFeVSABkIrtqWT
	 /o2N9fecc/HeQ==
Date: Tue, 5 Nov 2024 19:07:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
	lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, perex@perex.cz,
	pierre-louis.bossart@linux.dev, ranjani.sridharan@linux.intel.com,
	sound-open-firmware@alsa-project.org, tiwai@suse.com,
	yung-chuan.liao@linux.intel.com
Subject: Re: [PATCH v2] sound: fix uninit-value in
 sof_ipc4_pcm_dai_link_fixup_rate
Message-ID: <7016fcb5-329d-44f1-967b-3059e059aeb9@sirena.org.uk>
References: <20241030155705.31327-1-surajsonawane0215@gmail.com>
 <20241103113702.27673-1-surajsonawane0215@gmail.com>
 <09d8462d-d305-4b83-ade9-747a88aedc38@linux.intel.com>
 <d19b77e2-496b-4633-a69c-576cc79c004a@sirena.org.uk>
 <1611f678-edaf-4588-8455-61eed32b2baa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a9wn3mMvYQg3MSF8"
Content-Disposition: inline
In-Reply-To: <1611f678-edaf-4588-8455-61eed32b2baa@gmail.com>
X-Cookie: Don't get mad, get interest.


--a9wn3mMvYQg3MSF8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 04:20:23PM +0530, Suraj Sonawane wrote:

> Thank you, Mark and P=C3=A9ter, for the guidance. I understand now that, =
while
> the copier should always have at least one input format, static analysis
> tools can=E2=80=99t detect this. Based on your suggestions, I=E2=80=99ve =
considered the
> following possible solutions to address the issue:

> 1. Add a WARN_ON_ONCE(!num_input_formats) check: This would issue a warni=
ng
> and return an error if num_input_formats is unexpectedly zero, ensuring we
> handle any edge cases explicitly.

> 2. Return an error if no input formats are available: Implementing the
> following check could provide immediate feedback if num_input_formats is
> zero:
>     if (num_input_formats <=3D 0) {
>         dev_err(sdev->dev, "No input formats available\n");
>         return -EINVAL; // Return an error if there are no formats
>     }

> Would it be preferable to proceed with the WARN_ON_ONCE(!num_input_format=
s)
> approach, or is there a preferred alternative from the options above?

I don't have a super strong preference between the two options.

--a9wn3mMvYQg3MSF8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcqbNoACgkQJNaLcl1U
h9BU2Af/aT9TD+DRiTvPdJaE4H7ksT57o5Q8RmBGix8NXsy4KmkPaZ4K3dEsONFD
S7ck+frCLsRuIC4S/OGlL5FP7r0txZfovFOpxzKYNXsSmGcTBdBcBQ42DOrHb05u
D/ptkI7ZFaSz/JSmpON4gLjM1Ti417B+OBTADPEbhyC8d4Z8CbtqjYluyy9mR3jf
2z0ldaG1O0ao2HD2ESM3/C4XF9uZj7429c9qHYOzzcKZVR5RreCbe87rg5uOd4Lp
TRyb/muKS5xlBh6Gf2Qu8dWqIe0bzZgZjnsqAgwm2Vdxc0BvB2s0LT4GcuNPgsww
JkCzl+nB9jdAtGRQAe5JJ4hbC9tEQA==
=vjG9
-----END PGP SIGNATURE-----

--a9wn3mMvYQg3MSF8--

