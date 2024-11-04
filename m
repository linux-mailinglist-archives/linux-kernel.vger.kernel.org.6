Return-Path: <linux-kernel+bounces-394821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 727D69BB474
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F88B2264A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5C21B3928;
	Mon,  4 Nov 2024 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISYXWq50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54C715C139;
	Mon,  4 Nov 2024 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722595; cv=none; b=OjhUd3suT0RTeb+tkuT4HLWLoV0ms6Rl4iH3POOk01wBUTAtxG3XnZHqQPBjeVC55WYdoHH2BsPk5NYuUAIAndCMU6rvEi3axJSlrilb0w9laHr9zl8f9qYeRtv+YAJPK7O8frXti1fWJaadk6Gyr6kJ+LlTSSxMOHSOtXTXAu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722595; c=relaxed/simple;
	bh=2q5cM5jBgPwB0S1xjxKGbk0Ij/bx8viMdMSL73+1hxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNlhAnm4MInVgqjsSbstdB5SDLusgWhoNdgJVQugzwe3Ta3jYCoawVU4C+La4d88GC52OWlp0zWNB5lAYI9tQkduovi4arcrkjIpwS7xvD+97iSsA9+DWMY+Xjxk4oLjMgTdW37daGML+JjIojRpPca1uxKjDd2eBzEa31didaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISYXWq50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD52C4CECE;
	Mon,  4 Nov 2024 12:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730722595;
	bh=2q5cM5jBgPwB0S1xjxKGbk0Ij/bx8viMdMSL73+1hxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISYXWq50pkwY7IaQdLnqnQ6LvPiNyernU2Y9U8ikMDdaBY/QUiNnbnJaAjDHFHbE7
	 2FTHnBZPsWJFGKCeKpc5tiYQjPPxEh8sgbHbSJmJOpl0SNguGBm3ALc4bmaJUkQWoe
	 slpJ5z/q+IRU5Yfof5et6OVUeCw4mAOiMXana6Xz1YOLvt/QLwegp8PWVr8cgNR3YC
	 JbviL7aHu7oMmJsgdV61397zHvO33QupWW8n2/Q+u6As8aPZykV7hwN9T7evw/rldT
	 N0tF1yyvtaf6GTzIDzDiPvA5wraIjCLUKNMA5L+y5gEplnCJF0BKLFDJ2K7Qkd4seK
	 dR1QNONAnfuTw==
Date: Mon, 4 Nov 2024 12:16:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
	LKML <linux-kernel@vger.kernel.org>,
	Basavaraj Hiregoudar <Basavaraj.Hiregoudar@amd.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Emil Velikov <emil.velikov@collabora.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sunil-kumar Dommati <Sunil-kumar.Dommati@amd.com>,
	syed saba kareem <ssabakar@amd.com>, Takashi Iwai <tiwai@suse.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: Fix for ACP SOF dmic tplg component load
 failure
Message-ID: <d53810ac-a7f6-47da-aa12-0562ed565008@sirena.org.uk>
References: <20241104091312.1108299-1-venkataprasad.potturu@amd.com>
 <e1ac11b3-b746-4564-8daa-3527aa13e348@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kTb8e3B9zP668jr+"
Content-Disposition: inline
In-Reply-To: <e1ac11b3-b746-4564-8daa-3527aa13e348@web.de>
X-Cookie: The meek are contesting the will.


--kTb8e3B9zP668jr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 10:35:23AM +0100, Markus Elfring wrote:
> =E2=80=A6
> > As SOF framework assigns dailink->stream name, overriding stream name
> > other than link name causes SOF dmic component load failure.
> =E2=80=A6

> Will another imperative wording be helpful for an improved change descrip=
tion?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.12-rc5#n94

Feel free to ignore Markus, he has a long history of sending
unhelpful review comments and continues to ignore repeated requests
to stop.

--kTb8e3B9zP668jr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcouxsACgkQJNaLcl1U
h9BKcAf/TNNGFpwVuNpRbVlSMez8V2eMkz5wyQajdqcAKWhgfpA4LjxqXW/f4A1g
ZEHgOPg7WdSnazsqaI/t/q8JOj/j7S033Cw1z6RGT/pXs/CnYnlbi6NSeSSXaUZ9
vS6ouSn/2qdgqePwSAjcqMUYS5bEHlkI5iBIGcBAugKcBK2W0VI3s679ss+Br83m
+3CHGp4XNiV5LKQyCx948EItuH3d0ncdxTPjgyTUQiPz/WeT9s3xY/TAShRPaB1s
vt+hfxCNCttGrKtq4+iTNc9l63W2B1cxEjrGrc8WO7Jy7QzDu4RN6boru6xJng7o
NVY1DEAQ2MYP+8N76znghsRRZkPYrw==
=9nQZ
-----END PGP SIGNATURE-----

--kTb8e3B9zP668jr+--

