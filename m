Return-Path: <linux-kernel+bounces-183785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302AB8C9E17
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB6D2B23EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F22E13664D;
	Mon, 20 May 2024 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZqUX0+Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACACD13398E;
	Mon, 20 May 2024 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716211465; cv=none; b=sMBkcuKngo5kVi/fFv7kAlbwpZb1Rnnb1IHhawuWUiPJF6MbpNaBh+wLymVV+bKeMz5p2wh60EpgCFusrQSTfaGlvRVLCOf32542htMBcrktm5u8wqYZhYxGiapCRjA1YrE29o6WtHp3kAFLXIQ0f/nZ3WsXn1wnCF8RIGrVWiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716211465; c=relaxed/simple;
	bh=KmZVxGEYbyrP9V7WE809KECo6k1t051ppisGlj+zDQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhlfjCXjVaQhzK7iFB8JxAtO9OZ1c6G170Sr0FCnUHtBNLvDhKSJZqcIe9NuPPWnJY2raDgM632F+CjhYdQ5dLUVhXzijRVOCP9eOsB3MFMWCmlPaoWikqJyOqJix53deg+ernxtAhrWdXMUCZ/jM2DkTtra4lIprqxhxUgzBnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZqUX0+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1367C4AF08;
	Mon, 20 May 2024 13:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716211465;
	bh=KmZVxGEYbyrP9V7WE809KECo6k1t051ppisGlj+zDQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZqUX0+QMkw5pTpm4DONwaNufkqX3zzWfwapwSgBpkV2TWxHsn+grw39j7Lk9LnXz
	 AKQRNqjcuPochJglbbEfrX6pcl+TYohqQUm5xtClM3jtnYZvMaTcRqQH3/gDSjKIhI
	 hZXHw6KGK1csT4XJK/nhON9zaHir+22pxLIQv4zDAtw3T09tos5Cl7DkE59O7AKmU4
	 qJXyyPd28EWmOZPVqZhGsaStx/28y0DbRTzH1m1lICPu1/t5M2LValnltn1dPD2nlY
	 34w2l9JfjJg7g8Ezosdoup1VX77pYUISsTmVm25Hnq/NBsijKCTybcfpvNDUXEQm3w
	 Z2M+KCBHjANSw==
Date: Mon, 20 May 2024 14:24:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
	peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
	srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
	daniel.baluta@nxp.com, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/6] ASoC: topology: Constify an argument of
 snd_soc_tplg_component_load()
Message-ID: <baf1789a-a573-470f-b816-ca9bb0d7f299@sirena.org.uk>
References: <f2f983e791d7f941a95556bb147f426a345d84d4.1715526069.git.christophe.jaillet@wanadoo.fr>
 <1fb69d24-03af-4742-9f44-5a93704f5cfb@sirena.org.uk>
 <b736e11e-430a-462b-898a-d5e1dcf7f74a@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ra5j95P2SXUw+yS"
Content-Disposition: inline
In-Reply-To: <b736e11e-430a-462b-898a-d5e1dcf7f74a@wanadoo.fr>
X-Cookie: We are what we are.


--3ra5j95P2SXUw+yS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 10:34:33AM +0200, Christophe JAILLET wrote:
> Le 14/05/2024 =E0 12:21, Mark Brown a =E9crit=A0:

> > As mentioned in submitting-patches.rst when submitting a patch series
> > you should supply a cover letter for that patch series which describes
> > the overall content of the series.  This helps people understand what
> > they are looking at and how things fit together.

> Ok.
> I usually do, but I thought that the subjects were self-explanatory enough
> in this case.

> Do you want me to resend?

It's fine this time.

--3ra5j95P2SXUw+yS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZLTwIACgkQJNaLcl1U
h9Dgigf+O7QTQ4V66dmxfo81LtTtdJ9xws2tiMsQz2yhw40n6x/uUnAI/DpVsJBM
7bnp8/mWqL0S36pfO4c+ypaAOjI/V0BjVEsLBIEIcyWNHlvicUGTAE0UrkUfeUyt
zIomDWwKLYl6V7o3dUyUn/CASeVpft1esGq8jlyvp9woke55IKQJIp+iX2H/rfZY
4XZZ+c37WFAj1VsRKD3drP9PrXrVsVfhAzpcq2ZrPLj5llC0nltM7IgPEfZFXIjG
VkQ8GS2lNoTHiZHgg+lLtqD2l89Ri4Yl0IS4DT1S/iez2COuCZfadttzQxJbDNUa
ASeX6pfwcXFqRHE0F6YAYkSzaB53YA==
=rysW
-----END PGP SIGNATURE-----

--3ra5j95P2SXUw+yS--

