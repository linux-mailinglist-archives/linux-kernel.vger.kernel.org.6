Return-Path: <linux-kernel+bounces-398341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACADD9BEFD6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A176B242F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3C4201026;
	Wed,  6 Nov 2024 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxbH4Fy1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C317DFF2;
	Wed,  6 Nov 2024 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902256; cv=none; b=PcAAT29ytNFDKTC1s+j31EqdE3U7+lIyxymxJouS/dm1BkRfnRpdjKnE862Psx8TY84Rp67wcM+Eo2mpCJWAgiZeDc6HH6P2OcdrxI5olbDmX5FtjMz8i41jee0WW/RUsgWWNe3d9YPvKxdnsG5relsxTy96EVivqay/MDhroSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902256; c=relaxed/simple;
	bh=PUuS0tCe3CTdgQYCNE9gH0S9LxjXaMV04akfmdLt1xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Juhh59djhrGRvaCu7klXHOeIxtRP6fs92UdG5xKEoGbj5jdUJp8eWdRoP4b3MBHl+CCh72NUTkjGYhO5saKUBZpKIF5jDAvHf3M9IkzTM/DeskCT7ohdpmiX84CxlEC895SxzFgdwD7u4v7QPEBqfG982faXTTqVWAUfx93ZSdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxbH4Fy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEB8C4CEC6;
	Wed,  6 Nov 2024 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730902256;
	bh=PUuS0tCe3CTdgQYCNE9gH0S9LxjXaMV04akfmdLt1xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QxbH4Fy1pHJGyPJ41m5e8emEMCv+1P3lPgpD4yb/wjS3uXFcz2crCkvWANABOzvOc
	 rbfJddnBnRCOl/q4LDwWwi+nGY84IESfg58bpVcdy8SJSDNF/vqR0NBdgqZXYpbC4N
	 ymryP4ePwsJjTPSxDxLtXyof+w9HgOIcIUzZGX03UPDpBMhPM1M8yxpEaxir2KUAFB
	 077dGpmyQjttR0Uc5S7ehZPPGeET2YLNVl7LmaGSLIZaocltrG+VGv4LOXtVeeBCN8
	 BGRquysPKdlW2R+IhbHurjwXdehrmqqKOXo2MUl8vds4Ojo6ts7U23D/7rNlcr8/xH
	 QiFvgSp1TSqKA==
Date: Wed, 6 Nov 2024 14:10:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
	Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
	syed.sabakareem@amd.com,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Emil Velikov <emil.velikov@collabora.com>,
	"moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: SOF: amd: Fix for incorrect DMA ch status register
 offset
Message-ID: <5e1f7675-1f64-4078-a923-ee51945f3c03@sirena.org.uk>
References: <20241106101455.1229113-1-venkataprasad.potturu@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sV4lFD4NC59+GAjz"
Content-Disposition: inline
In-Reply-To: <20241106101455.1229113-1-venkataprasad.potturu@amd.com>
X-Cookie: Polymer physicists are into chains.


--sV4lFD4NC59+GAjz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024 at 03:44:53PM +0530, Venkata Prasad Potturu wrote:

> Update correct register offset for DMA ch status register.
>=20
> Fixes: bff3c2a4062d ("ASoC: SOF: amd: add support for acp7.0 based platfo=
rm")

I can't seem to find this commit.

--sV4lFD4NC59+GAjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcreOgACgkQJNaLcl1U
h9BORAf9GKqaFL4aeOlaQ2Hl3x4DbSrO+YV7ljPwZhaeL2BwWMAEOWd8YkiWOa03
XsQKgPIWJZu97/1/I1O8FOMRrh0o7Kgea8wz7LO8QgsoH1c2e0Uxzqh9ZZvEKyHn
wlTX+Ulan8s9IKID24TuaT2Ba++7ce0qTM54+eR5gw0xNpgBMJ6YgnRG0NoCKodz
rg701vF7M339+wo5ylJ+KKXq4hgOr1pxMmAktHDmuPPIi7ZoqO9qmoj/g8qo6Rk1
xKU6GEdLJLxBO3xioi5lXv69u0GDawFqoBOTc/4liixQ4o2k3Lkx3qVBdAttWeIF
eUuGNr/6hiV4EsZN2j6sL232T6ikTg==
=OyQE
-----END PGP SIGNATURE-----

--sV4lFD4NC59+GAjz--

