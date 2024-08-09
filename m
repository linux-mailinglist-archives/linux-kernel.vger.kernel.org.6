Return-Path: <linux-kernel+bounces-280510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EB694CB7D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43EDB1C226DC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1065E176AD0;
	Fri,  9 Aug 2024 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANIuIKC4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF916D315;
	Fri,  9 Aug 2024 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188949; cv=none; b=aNlEL/h0CsDlGyS4O92mtGzoymg5GGA8ziVURMPoMEtCXADJP9DZIXWTtT9T/8G9HhNzWc0CSbh9YS4LNwHoB2Hu6lE+VGst9XCAcEBdHYnA6YiVO1JGXNonP1JXQKejLYmoIIScgnGeYMlBvXH3KhszyoahdPhQq3DU5ii1610=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188949; c=relaxed/simple;
	bh=1QQ6IERaVvmQgZYfk/xYBeo9a86+7mGsf8Ey/jbzXQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8NYgATU1nqzPT9dTGk5xWcewv6HADSWIN8acJOwwm6WaYqlMWzy75POQ6hXWN4LeBc61u/mZeiedCc4yKjnELDB71E8NWKY16KAtyOxNk/Bh1Z733/GeiR3JXD8GYPIvl92TVaD5TffvgI7ssUkGMpBqZuXwvGVLvgqHqAZhv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANIuIKC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F67C32782;
	Fri,  9 Aug 2024 07:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723188948;
	bh=1QQ6IERaVvmQgZYfk/xYBeo9a86+7mGsf8Ey/jbzXQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANIuIKC44kb6rGZ2+BWwRs1fobAope6oTe2TR7eZVrvbX7dln1qyRVxRQKEsfbkrh
	 uwriJwOtabpfS9B0tJrWQn1FcHKN3ttkKaRVh+2mSZ4kSB6X7kuvbEMSai2CkabR62
	 ux2cXvV/DaG8/+vCDJu3qff1flOWYJSyBe7B7/RYUrZYCFJQogCIIqMxhXRkTg7CL0
	 Xcujy+YV88lBR3Q1z6YyEykvS/oTBx7dBPTqFFmW8iBYtNnB5CKSok2KZ3RfzIQjTc
	 fXg4+nWPdLP7tHpV3f/ATUGx985XAwj7U+f0fDwbpN7iaoTPgIDTyHQRZ596jTYLRr
	 KbbiBQT9dnY/w==
Date: Fri, 9 Aug 2024 08:35:42 +0100
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
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
Message-ID: <ZrXGzmhgyIJ9ID6I@finisterre.sirena.org.uk>
References: <20240807051341.1616925-1-Vijendar.Mukunda@amd.com>
 <20240807051341.1616925-2-Vijendar.Mukunda@amd.com>
 <ZrUdOyGiFRH0sRlt@finisterre.sirena.org.uk>
 <a6a0c975-728b-4379-b074-b88ac928c58b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oZGvFgiQ7XPpJzCg"
Content-Disposition: inline
In-Reply-To: <a6a0c975-728b-4379-b074-b88ac928c58b@amd.com>
X-Cookie: Your love life will be... interesting.


--oZGvFgiQ7XPpJzCg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 07:30:54AM +0530, Mukunda,Vijendar wrote:
> On 09/08/24 01:02, Mark Brown wrote:

> > /build/stage/linux/sound/soc/sof/amd/acp.c: In function =E2=80=98acp_ir=
q_handler=E2=80=99:
> > /build/stage/linux/sound/soc/sof/amd/acp.c:407:26: error: =E2=80=98stru=
ct acp_dev_data=E2=80=99 h
> > as no member named =E2=80=98pci_rev=E2=80=99
> >   407 |                 if (adata->pci_rev >=3D ACP_RMB_PCI_ID)
> >       |                          ^~

> This patch is part of https://github.com/thesofproject/linux/pull/5103
> which got successfully merged into sof github without any build errors.
> This patch is dependent on
> Link: https://patch.msgid.link/20240801111821.18076-10-Vijendar.Mukunda@a=
md.com
> which got already merged in to ASoC tree for-next base.
> It shouldn't cause build error if the dependent patch already merged.

Are the patches it depends on actually before it in the patch series?
We want the resulting git tree to be bisectable, that means testing each
commit not just the final result.

--oZGvFgiQ7XPpJzCg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma1xs0ACgkQJNaLcl1U
h9D8Awf+Idi79Uow4rDHeevyxUJtVFJXMcuUJIjmkUD4+D/O9De7gvSHEszmIGbL
J8DQrDQ6PJhXBSEcdGojOFP4EB5zXiX3f4pt3rY+Fi2D7ek4A+kjdG8UFrpeX4qQ
WBQP1ycUxZSV0JI7+a0pBVoo+Zr0tAcn4Rar29VXRKFH4ZD1JCUIKsRf6Db1JZRt
hgJf41uLg5siRcgrouiVrJeqiL0SvsK2IWbINNbbJ4xc52YDjLs0H8+ux0MCh+/E
h2Hd3q7THZibHlVEuBO+v6h6e86dR6k+X05Ou5uPgGeygR88Mm+3NQb47SXIj28K
l56vUzz42Bjtmk0dQLonssYugDtOyg==
=iQRN
-----END PGP SIGNATURE-----

--oZGvFgiQ7XPpJzCg--

