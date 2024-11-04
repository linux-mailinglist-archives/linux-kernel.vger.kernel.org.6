Return-Path: <linux-kernel+bounces-395555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3916E9BBFCB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9AE51F23958
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1EE1FAEEA;
	Mon,  4 Nov 2024 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnVXECTH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE621FAC4D;
	Mon,  4 Nov 2024 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754750; cv=none; b=P3yf6LvOAvnk/698A9a2aWoGYp+BvLCB89wyTNp/3TazY3rZSl8yi52n6z/YaQDUGrw+IN4NnFftebzYQkbFOK+TT/XBGA2LtDeOcnXJP97nGxIe2BR+x81vPGQBivA1Y3CDOCTmWn8vuZ7oBHD9ZX/Z/dls7Yn+25YM3c/ovBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754750; c=relaxed/simple;
	bh=Ge7cZ9ZbzoR8ao8b7oGum7vK7hHAW59mt0jCVyFPlis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgoG4tkqqL/pS5GL9ErvBoGxQjy7ZB8bo6bcQ1/VZsjNbXhEaiLuGLZ5oQHLIiBqeWXOSW/7QJCpnVD+qlT1CenjLjOzV2ToPPIeMiHCln1/8ogcFJMRm9n6J1TWj1EjhN3GHyjYtefniCsCX2qP2vy7lDgcOqE6DLql+7Vj1V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnVXECTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC93C4CECE;
	Mon,  4 Nov 2024 21:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730754749;
	bh=Ge7cZ9ZbzoR8ao8b7oGum7vK7hHAW59mt0jCVyFPlis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnVXECTHl2d+Yh8Hee++kEQr98gw8XdgecRqVNdWREggQWAkBRHHq7B8eZ4HV0mdH
	 t6eKgu5p8k3PhjbmfHlxy9Y5SDAFP/uUtmYVT1tEecHuzlvH6eXKLoQ7CN6OJXHGzD
	 1LoYsgokBL0q1187pOGSqiMTVkxknbFkKn94l7jvdl+2v71UuaCRXi0QydVJdlNrOg
	 yluv3wPSNWyJalJ9p4K+PoTHsEtFAOTIohOuBD9+ZYHA6fHLwRTX9MIM3/8Y/GaIx1
	 5HZ6HHZBvIisEMb8CI+TwDRFVwSf28+Nx4XHOMkwvV4LnJNQNXFsLR4umfUnIblTLt
	 ZPFOLsOEYz+dg==
Date: Mon, 4 Nov 2024 21:12:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Nicolas Belin <nbelin@baylibre.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 1/1] ASoc: mediatek: mt8365: Don't use "proxy" headers
Message-ID: <d7bf7863-fd24-4f8e-8cd0-d84867a997bb@sirena.org.uk>
References: <20241031102725.2447711-1-andriy.shevchenko@linux.intel.com>
 <ZykbMlshvlwCaeGJ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JSrXVVE4KL1bPTNt"
Content-Disposition: inline
In-Reply-To: <ZykbMlshvlwCaeGJ@smile.fi.intel.com>
X-Cookie: The meek are contesting the will.


--JSrXVVE4KL1bPTNt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 04, 2024 at 09:06:26PM +0200, Andy Shevchenko wrote:
> On Thu, Oct 31, 2024 at 12:27:25PM +0200, Andy Shevchenko wrote:
> > Update header inclusions to follow IWYU (Include What You Use)
> > principle.

> Hmm... I think we are waiting for somebody to Ack / review this change?

Yes.

--JSrXVVE4KL1bPTNt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcpOLcACgkQJNaLcl1U
h9A+Xgf8DL0xbsC9QTvJ6PRG9kwZT0mqrDxTEqD2aa7uKL/BWe/4iYsDhzva68pJ
kMULqD+2acYoXMapAq5yXLcHKceCj0yGRUegY3xin06Qn5mxAIqq/+kUXwSYxHZ6
GRZcB6QZZYIjuxMGbSFBbFYIU/yar28WL1JWFDoE8uLljBz0LeW2RHEqRgro6FnZ
pXqcXsV9o7gruTH+FWeQukJ6yc2bun7IA2UQRrtFSW43u4lKNNv2IIweXu2hcek6
lCq0OTQSDcK3wwTOKivjHm2e61Rxz0XWwrnHD4+94UZiGmvUITQWEeyBpgkZ72w1
/UfnNCQ32IQc9tb3VECJdVgZekfXtA==
=xe2s
-----END PGP SIGNATURE-----

--JSrXVVE4KL1bPTNt--

