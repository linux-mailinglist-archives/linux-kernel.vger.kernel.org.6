Return-Path: <linux-kernel+bounces-252938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527B9931A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26321F229BB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B9161FCA;
	Mon, 15 Jul 2024 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e59gx80N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6830C10A2A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067462; cv=none; b=NcVTUCxYCLbYztvfeJH5c39zbnTs50rA7WaZIZjZpay9n7kKjj5WDSj1ezhCuvDCL9t85zaIfQeQlhrCuC7PilznIuT+OiBqmPZ8OYMzx+uLpszMrBWgiR6cMLX9NsNFX1i3GaHNSWCcIKEuNGmh6kzGV0Vpp43mx1sW3Qzf+LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067462; c=relaxed/simple;
	bh=/a7n+L06/3cwBvsUR+R5BPDaGBL3GPi9f9ewNLQr5sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT3izv8EKnPYdiXT2NE3PdppEBJNL9lkMC2qAONCf/nuri4FNI9TWHg0B6fEL8WYDVjC2ArmzUjFsSjp6mgWA4c0MRIYuoLA5HpQ4TvVpe6wA1MMuWv7RT8KW7vXyiWF4yNtzmyXYNRfH5Li42mpUgZp/IiRWzTCO/YslRajroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e59gx80N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D19C32782;
	Mon, 15 Jul 2024 18:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721067461;
	bh=/a7n+L06/3cwBvsUR+R5BPDaGBL3GPi9f9ewNLQr5sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e59gx80NuvMFPiOJCDd5+eKnTh2fJOx2oeMiLtN08PStrCTN0pegn0SKoRSSqG6nP
	 i9M5gpZwDgxFTNkL8vBLMN9zmSPSzbFcDNwEr2nDARee8R1gO64VGEEhhP8ot3ghZG
	 Ru1Kwshg6m3I/tLcMfuBmdMwSp+uLyp5CPCH9pC1A+sHJMk2pczFL1gt6657f2OVC3
	 nOfZ45/Qsfykek0412e0xF0Ahw0ksDRV4urjpZWnGTOfyc0XfPqSc8NcyTekCCxi9c
	 C/DWQSApIPyrwL07dwSyXVgbcQr10uu0x1TC4k6xCrU1DYDZ2KeKlPvsi89YYC4VHs
	 dnzOKi0z1KoJA==
Date: Mon, 15 Jul 2024 19:17:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	zhourui@huaqin.com, alsa-devel@alsa-project.org, i-salazar@ti.com,
	linux-kernel@vger.kernel.org, j-chadha@ti.com,
	liam.r.girdwood@intel.com, jaden-yue@ti.com,
	yung-chuan.liao@linux.intel.com, dipa@ti.com, yuhsuan@google.com,
	henry.lo@ti.com, tiwai@suse.de, baojun.xu@ti.com, soyer@irl.hu,
	Baojun.Xu@fpt.com, judyhsiao@google.com, navada@ti.com,
	cujomalainey@google.com, aanya@ti.com, nayeem.mahmud@ti.com,
	savyasanchi.shukla@netradyne.com, flaviopr@microsoft.com,
	jesse-ji@ti.com, darren.ye@mediatek.com
Subject: Re: [PATCH v1 2/2] ASoc: tas2781: Rename dai_driver name to unify
 the name between TAS2563 and TAS2781
Message-ID: <8ee6346f-8608-4436-9371-35a29c763e4a@sirena.org.uk>
References: <20240713015145.314-1-shenghao-ding@ti.com>
 <20240713015145.314-2-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8LkSsyNIfzHoV24h"
Content-Disposition: inline
In-Reply-To: <20240713015145.314-2-shenghao-ding@ti.com>
X-Cookie: You'll be sorry...


--8LkSsyNIfzHoV24h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 09:51:42AM +0800, Shenghao Ding wrote:
> Rename dai_driver name to unify the name between TAS2563 and
> TAS2781, remove unnecessary line feed, strscpy replace scnprintf.

This should be split into several changes, the name unification, the
linefeed cleanup and the scnprintf() replacement don't seem to overlap
at all.

> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
>=20
> v1:
>  - Use strscpy to replace scnprintf.
>  - rename dai_driver name from "tas2781_codec" to "tasdev_codec"
>  - Remove unnecessary line feed for tasdevice_dsp_create_ctrls
> ---

These changelogs should come after the --- so that tools can cut them
out when applying.

--8LkSsyNIfzHoV24h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaVZ7wACgkQJNaLcl1U
h9AKuAf9EzKY5bZtrfwCgfckt8+TSEnO+8AaYC/hRJmziSj5sStrTISP5Psoeqtx
EikijpKOEs6faFyafTgeVYjy0z8gycpPXRA3kN8iuYOT4qiXgfgg70LL5aEZbyt6
UtljkGXCNfNs5U4pYk/FaGj1wULTr+M91qFQbQOfLswbF1XPN7Xf3T/oaPp1bdz6
M1Rnjwnrh8/gVoV/ReViYDqDz+jRUPS+ae8YJj21qWYnmM80juOBy+V7ng3cjQL3
8EziPDKzh9tXduyfBbW20rMOYoVTMALOPm/y2zNnyGwabM/jPCZLOIcLe+tn76J+
5ZLgRDdRK4i8kMZbJqRzlAF7B8XQxg==
=s1cR
-----END PGP SIGNATURE-----

--8LkSsyNIfzHoV24h--

