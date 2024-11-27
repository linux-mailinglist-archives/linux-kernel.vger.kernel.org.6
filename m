Return-Path: <linux-kernel+bounces-423777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AA69DAC8A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381291673F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945F620111C;
	Wed, 27 Nov 2024 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxmS0+WO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED42914EC73;
	Wed, 27 Nov 2024 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728800; cv=none; b=Wag60qVGJkaFhX1GII7FOJUu7FEuzoHjW13Nv72M66IgIOwfvWYuDH3RFCamCpr+2t4F1Lot+VruQbUO13Ke5B/fzu1jZMIrBastxVbtRnkFg6q9d4amJux06RMLxInkHH2bChCfyF5EwH9qKvRQuVRaZLPA7JV8OnvK6r3RAGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728800; c=relaxed/simple;
	bh=BQh27LKzhiRLJMzOoMEdsd1yUoXl8z0wlylntXevl3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjhOU+MUQvdWpEqlOiyc1jTa9Bb+QTCUZWMG817j589MqIz2FykeC+a6DC29JwmKeN1pxiTnekRDk5r2cxg/BSbTHSXugw6s5Wx7QNZw0oC7mpFQY1dnGV8fXsEUAhdLFPlfz5IJmfVUttE93VVOBuh/fRHtnhGm4+CznDzW62Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxmS0+WO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8B8C4CED4;
	Wed, 27 Nov 2024 17:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732728799;
	bh=BQh27LKzhiRLJMzOoMEdsd1yUoXl8z0wlylntXevl3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TxmS0+WOLVHY5eS64570cFiWbtecRgJKcin7yobRxnJX/a580Kqw0Atd/lZmjAJc2
	 YXnJSpvUADMnz38GxD9HTv8ou1DLwPO26w43Q8PPJS+3WL0P1PNjztaRjAo+AOJxza
	 vBPqNIbijVuuLwk+v+hU8XzE44wEQvr/CaB2i4hHCZsYUIeJ2Mc+Gb1WfNlGOjcdqr
	 HcZJpxU69De7uK4o7AzfpwgHVPwZ7Ga6BpP3VgaRuLFGzqi62E8QGk/B8aPb9lffvM
	 tozY/K7Fq85i6mjOl61dPRkM67QXfUmTXksD/K0V7XBTBLCCIqautEtJaH2pWVjmKl
	 C/j6Y1lmxTMOQ==
Date: Wed, 27 Nov 2024 17:33:13 +0000
From: Mark Brown <broonie@kernel.org>
To: potturu venkata prasad <venkataprasad.potturu@amd.com>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
	Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com,
	mario.limonciello@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Tim Crawford <tcrawford@system76.com>,
	Attila =?utf-8?B?VMWRa8Opcw==?= <attitokes@gmail.com>,
	Techno Mooney <techno.mooney@gmail.com>,
	Jeremy Soller <jeremy@system76.com>,
	Malcolm Hart <malcolm@5harts.com>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: yc: Fix for enabling DMIC on acp6x via _DSD
 entry
Message-ID: <7291d216-59a9-4a99-af74-8789b9426916@sirena.org.uk>
References: <20241127112227.227106-1-venkataprasad.potturu@amd.com>
 <a6036171-2dfd-4296-9fe4-242c306e5449@perex.cz>
 <021436ab-8035-4c56-99d5-c478075e6add@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lQFgnXmO0PqXf7EH"
Content-Disposition: inline
In-Reply-To: <021436ab-8035-4c56-99d5-c478075e6add@amd.com>
X-Cookie: Every path has its puddle.


--lQFgnXmO0PqXf7EH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2024 at 10:34:32PM +0530, potturu venkata prasad wrote:
> On 11/27/24 18:06, Jaroslav Kysela wrote:

> > The logic seems wrong. The overrides code bellow won't be executed when
> > ACPI _WOV data are not set. I think that it may cause regressions for
> > some BIOS versions.

> > Also, the return code should be probably -ENODEV.

> Okay Jaroslav,

> We will correct it and resend v2 patch.

Given that I applied this before Jaroslav's review please send an
incremental patch that fixes the issue.

--lQFgnXmO0PqXf7EH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdHV9gACgkQJNaLcl1U
h9ArZAf+N5l4lAUmsCWhAQ0BxUbpe3RrQEtejxCILmg0QFcir8MVPxlmCMGDbNxX
eoGwEbxjJJcTILesjLHUEYH4lcwvd6qKQLdqQ9lFRcUyaJrjooalfrhoHYt4O+0F
3YgMfWlyMpbPi3E3QsGIj752IcNxEyn5a+s5Y/NMWAVWeVO3dB9nfi6A5FIkmFAQ
Za6VtF3rlmfpxo8MDpbGZvukz9f5ak4XCsfFBsJjDGqJfalYqJqi/R7XV+FsXDvH
hGaq5iSHviLu75d5U/gH+Lq+3mGqpYZbaQPsiYFCgisAn0260Ip+dJs157hs76l4
d8Gw9Yu1kJbKmF06Q4qK6kTVeB0KBQ==
=OBSP
-----END PGP SIGNATURE-----

--lQFgnXmO0PqXf7EH--

