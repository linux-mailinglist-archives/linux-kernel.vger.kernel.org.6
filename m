Return-Path: <linux-kernel+bounces-531899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB8DA446A2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88668867CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA415197A7A;
	Tue, 25 Feb 2025 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j04eIAjM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497081946DF;
	Tue, 25 Feb 2025 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501476; cv=none; b=UJ8LcSFh03hA7tEQC5VGNL+mCw53zC+jf0o16Cy6V/POrej37mRSR3avCrdeCo15PPuPH9R0uU+pcJcgdN0jRZXTKJ+yEeDelPVoVu68tHoLdFoNbCnRiKkbpnOjXbXbSuQxypiY9zRxtFYuHkQiAuMZ2YQh29OSaX294z/8g6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501476; c=relaxed/simple;
	bh=x0zgUEyszgmXbH70RPAvEFcAqEKHO4ecuk8dAHzOCM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fG5yKMJp4CZ44lDYSG3J4Hl7f4kjyOQ9q2jRqH/8iVgMPihe0RvLhAXQPBhABenYRia3N8jKbQ6CLRoJIdBwLOb3wmAwhmxicwj4wdssX1UsPJqDuZRnIFeehPJvQ2AnR9bGdQ611knkWmAdqEaPaYR+ho4NrMZJw+3fFkgxS0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j04eIAjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A906AC4CEE9;
	Tue, 25 Feb 2025 16:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501475;
	bh=x0zgUEyszgmXbH70RPAvEFcAqEKHO4ecuk8dAHzOCM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j04eIAjMqRhX/Lvpjxdud0obWUV3HeVnZb68G5pnJb0Xlek8Kzkd9IdjPfbaU/dls
	 8ANmIGcuV9YmnixOQbWs/lvDYdHx2PqV1n8hqE5z9Hp1QXPlgMvemJJhWg3w76LY+e
	 j/1graw0NghecYI95Z0P93e1J1VvCM2Nufm79vDXY5jo5kKAwbxvzxr8mvHqTsaFEi
	 XKzguORi2xADcE6i3fWuwShOnmvcCbHiRupbyllC3qYrDOCVFo26gFj/F/QAjM30z/
	 yAtWpGbx394iPUaEZimTa70W0zYuOoObzPqs//AQc03DzL6Lh53IWZb/BcScnjad/K
	 WAgbv09KA909w==
Date: Tue, 25 Feb 2025 16:37:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: tiwai@suse.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] firmware: cs_dsp: Remove async regmap writes
Message-ID: <5814df5e-315e-4556-9196-df982716d9b8@sirena.org.uk>
References: <20250225131843.113752-1-rf@opensource.cirrus.com>
 <20250225131843.113752-2-rf@opensource.cirrus.com>
 <e2f3397b-05c0-42f7-9950-29c4d9b24350@sirena.org.uk>
 <a027bb81-01a9-4658-a089-8035ae5f0815@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sJf7fJbshNhYBAus"
Content-Disposition: inline
In-Reply-To: <a027bb81-01a9-4658-a089-8035ae5f0815@opensource.cirrus.com>
X-Cookie: I'm not available for comment..


--sJf7fJbshNhYBAus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2025 at 04:22:49PM +0000, Richard Fitzgerald wrote:

> Ok. It was a very long time ago.
> Do you want a V2 with a commit message that doesn't libel the SPI
> framework?

No, it's fine - it's in CI already.

> FWIW switching to sync write reduced the download of small amp firmware
> by 200ms on a 1.67MHz SPI bus.

Yeah, with modern multi-core systems that's unsurprising especially
with a controller that does small writes synchronously - the cost of
locking on modern CPUs tends to blow out the overlapping of the
formatting with the I/O.  It's part of why maple tree caches don't do
async writes during sync.

--sJf7fJbshNhYBAus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme98d8ACgkQJNaLcl1U
h9A/YQf/bPoRa91Fg8GSmJA3mBYJAj2i6LlWssI4A2LuQg8Dk5lNaZNZTgYUZb8V
l4O/KwHq2lo5HOMP0U0zjGHBEWJT6T7r/SboIZsipwLsAOzDmFtRjx48AQRglph/
M7erzTtVqBwR/ehCWkesCxQrwScKFYM3Sp1/O1YyfZ1ZsLFx6tKETStINVquW4on
P2C7h9gFBQIWc2nHIV7erEga2EEwymXoiB9jaV7mZSnVCaJTZRWB2UtbN3dbycZz
wdRnqXeNWQmQQO2AX8XpgWWtB9953sjR7cXt6V3UzeeNGnRmCQkJ9wh1O6hLo4VS
1PLlXOMroSqwYouiTFG9LoJy8x4mJA==
=Rnao
-----END PGP SIGNATURE-----

--sJf7fJbshNhYBAus--

