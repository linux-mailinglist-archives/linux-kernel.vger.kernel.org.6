Return-Path: <linux-kernel+bounces-280065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DFD94C551
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67451F21E6A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DEE148318;
	Thu,  8 Aug 2024 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qbqh5C4Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9880433AD;
	Thu,  8 Aug 2024 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145538; cv=none; b=P5HCMp7Kq9/yajwecR0tDjxhuW7OT7aqTNXh0ntNO+fF6ev38rSKsb89jJOxQaiY7oyeFjKASOuCXeQOs7tIKRI2Xzk0+HDwQ10yIeEWdA/HDyWCypFkanWSiiMvJTkU1E9iWXbcRheUo5SZBZDPR/uvNp/o7j8nRbFfTYfrSGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145538; c=relaxed/simple;
	bh=SzKzmpEu7GnyJJQGPutFmsrQXVrxKt8Z6WX3Zjdg/EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kr5aKl8k0vhUqZP7GiBoWUlgyuZ5KB26ksdXG3th8p3X2SGEsAffXwwUTqhC0bs5oy177ve2Lpyw1bGDwNPMAmFcouiDISoXJIjBbvMHc8pyVPo/XOiZ/krCBbdqXDjlAE3nCOdZHVBnVTuoks7OGJbW9D1qFi8fxXmtwlIv4TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qbqh5C4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5137EC32782;
	Thu,  8 Aug 2024 19:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723145538;
	bh=SzKzmpEu7GnyJJQGPutFmsrQXVrxKt8Z6WX3Zjdg/EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qbqh5C4ZwsxZP9LipKvN64N8kS2kOIxptu0Bso46LZaQ6M3u7nUcOICyyUraYbPT2
	 srH4O//m3c70G+OxwFOB4uoOmdFTooKkuTG7tjY8dXXNApoT0IXf3xKJz0eyjqfkmm
	 gwqmdeqo5uCYLX99r7oJXEqLjZUWJQEdnEX/Flfr0qJNt9/gWNjeo1pgk3aCQxH86L
	 CPc3kHHNQBLwtjVCVyQAsI9Cncs60nPky6pb41/mjpoTd7zWFuZT52VTE3igKjYBeH
	 lAZ3uDg2TUG0m/0L4ZN/PahT4j95dVChveOilldY2b+CLKU3OWYDfKligcTcbQKmEW
	 rOw1tOQmI1djA==
Date: Thu, 8 Aug 2024 20:32:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] ASoC: SOF: amd: fix for acp error reason registers
 wrong offset
Message-ID: <ZrUdOyGiFRH0sRlt@finisterre.sirena.org.uk>
References: <20240807051341.1616925-1-Vijendar.Mukunda@amd.com>
 <20240807051341.1616925-2-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M8Dce5wO5cfW5jxQ"
Content-Disposition: inline
In-Reply-To: <20240807051341.1616925-2-Vijendar.Mukunda@amd.com>
X-Cookie: optimist, n:


--M8Dce5wO5cfW5jxQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 10:43:14AM +0530, Vijendar Mukunda wrote:
> Fix the incorrect register offsets for acp error reason registers.
> Add 'acp_sw0_i2s_err_reason' as register field in acp descriptor structure
> and update the value based on the acp variant.
> ACP_SW1_ERROR_REASON register was added from Rembrandt platform onwards.
> Add conditional check for the same.
>=20
> Fixes: 96eb81851012 ("ASoC: SOF: amd: add interrupt handling for SoundWir=
e manager devices")

This breaks an x86 allmodconfig build:

/build/stage/linux/sound/soc/sof/amd/acp.c: In function =E2=80=98acp_irq_ha=
ndler=E2=80=99:
/build/stage/linux/sound/soc/sof/amd/acp.c:407:26: error: =E2=80=98struct a=
cp_dev_data=E2=80=99 h
as no member named =E2=80=98pci_rev=E2=80=99
  407 |                 if (adata->pci_rev >=3D ACP_RMB_PCI_ID)
      |                          ^~
/build/stage/linux/sound/soc/sof/amd/acp.c: In function =E2=80=98acp_power_=
on=E2=80=99:
/build/stage/linux/sound/soc/sof/amd/acp.c:444:22: error: =E2=80=98struct a=
cp_dev_data=E2=80=99 h
as no member named =E2=80=98pci_rev=E2=80=99
  444 |         switch (adata->pci_rev) {
      |                      ^~

--M8Dce5wO5cfW5jxQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma1HTgACgkQJNaLcl1U
h9Abvwf/VL1PihLf4mO0zdcK8agYvT3wWBXvBRWJ2sWWWiQbqgRYQdtAXdv5Lhlp
2y6m04AYARrGfqpZsTE74rXardMdxN7n7lyRj40LTENvPX/iSVh/94fe3Jw+fhfz
SAOgKy7E+7iBA2IMXTQLU0nbx0OkdFOkezZVU+YKAkIunFyDMLfrn/Ujr5tBUs34
b2tzZvFKDM7VYS/mEiFC42O3w3gscUye8RWA71Y1dsZEOa2C3D6lt2Uq32r/N4iT
K86GAsqPJJgGNS/GLxBWQdy2xluWn3zUPl60EYJ2bJMH/b26bctPkI4ABPzq/srY
UPyW4h7DsiWcY5Yp0GftrmXkYuB7cQ==
=SGMn
-----END PGP SIGNATURE-----

--M8Dce5wO5cfW5jxQ--

