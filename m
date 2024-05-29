Return-Path: <linux-kernel+bounces-194250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B22938D38ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BAE1C2086B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7143145A0A;
	Wed, 29 May 2024 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tClvJ4KF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4811386AC;
	Wed, 29 May 2024 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992056; cv=none; b=iEvKFvDAHeoXOA5M6AsnFGelaG3v5LFMJgAqOUDwws/d38L2rMezA3mOvmKDqQAZA2vl8rh10RFLT7Bo21DDto6R1gZDiOPb7QL5cIe3/E4Qlg6kqSGV3r2gyQ6h0LxZo4uFpKu2Y4mLXjcGbOcZjumlxw7vxmfA/7lABmv4PXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992056; c=relaxed/simple;
	bh=sQQTv1UdIETncPR4XwxlpnukQ24r3phSG1REaxgX8cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSKwu8JzsbMzmebuSGvV/ic5BfThJ3+cKRXF3ZQlfZ2hYCwOhUkdVlk82pl3rQA2FeiuyvJV7lA/GqF29z+Fyxj4CVHYOq8MQ+24L5e0eUuJebrixD/vAMAumPPAso9Zfo3Mqotqvbh/1BVsdnWjVkiT/6kN7icy95BwUu7isDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tClvJ4KF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C11C113CC;
	Wed, 29 May 2024 14:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716992055;
	bh=sQQTv1UdIETncPR4XwxlpnukQ24r3phSG1REaxgX8cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tClvJ4KFAgZyfcnnPLxwx/VXQvnE96HeyUgYETGNm8Hh9jJaFo5Ir6dKCgEzOqWBc
	 usRQbHZwffy2z0AKVdgNaOG52eWUBT8V+JzeCUZSfJopSRaOfSletg5Bl5QFjIfEpi
	 ulAIc0KP09SNriSK0jiAK4EAwoQUh0V6VgAvkYqeUMAhn6h+AYHXW9aNfA02t01IGN
	 ZTznG0WVUIWmfve5kxfjd6sGIvaUCojIUm1393wTMx1DUwEVmthaKutBs0lDiHKWjC
	 S0c5AB4y2MVijk/hm6eK/SoueIU3rIVls0m9W+grAkePTxy5IIxStHbpo1N/uL3F7t
	 PqIF9MopHh9cw==
Date: Wed, 29 May 2024 15:14:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Marcus Cooper <codekipper@gmail.com>,
	=?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s
 mode
Message-ID: <a003dac1-de47-4a15-8959-25f7d5f1c129@sirena.org.uk>
References: <20240529140658.180966-2-matteomartelli3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T4metVCkfwi6doRH"
Content-Disposition: inline
In-Reply-To: <20240529140658.180966-2-matteomartelli3@gmail.com>
X-Cookie: Everybody gets free BORSCHT!


--T4metVCkfwi6doRH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 04:00:14PM +0200, Matteo Martelli wrote:

> I found an issue on the sunxi i2s controller driver while doing some
> tests with a Pine64 A64 host board and an external codec (ES8311).
> The A64 i2s controller is compatible with the sun8i-h3-i2s driver.
> The LRCLK was being inverted when the bus was operated in i2s mode:
> normally should be left channel on low LRCLK and right channel on high
> LRCLK, but it was the opposite instead.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--T4metVCkfwi6doRH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZXODAACgkQJNaLcl1U
h9BYYwf/dVAfFCi8d2kgQybs/8m9Ts2tBb33JWq8cltUEKSQ/pglU8Vl7uXxfoqT
FeXJ1oOYvH3mncBVKj2sZ/ZNifdojVFMAVwUDEerx31c2En8BbpSgXTOhOc4AJ4v
ESnplOG/o1TpiWVPSl/f1ZG0YGSnA93fEqftugTHr2yhXniQfqrnEvCzuXWpcE1v
xjsDD6P1VrG8Y0KaM2L4Y1YDontNLWNBU0wi0E64XaZjzxEW1gqi+nIIYWLnN13a
6v1IQy62jmdqfbMpszQNRG1qsryyJaoiShua3dSNEC639JZ1s7UqlFG9uq/PfcG/
DQf3Xf5NkDBj8ha2q5+nqna/4y4VqA==
=7A7B
-----END PGP SIGNATURE-----

--T4metVCkfwi6doRH--

