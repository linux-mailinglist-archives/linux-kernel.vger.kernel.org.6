Return-Path: <linux-kernel+bounces-211367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3669050AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28611C21037
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED43E16E88B;
	Wed, 12 Jun 2024 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkKqrD4z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D9B84A21
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718189193; cv=none; b=PSdn+XVzV3yZ3f5URHzNl3LiStISm0RmFXZojKRYfQs+wqjRn/dH9jaLosm9ZVppBSwGkch9Ig5TkeAeEQHNewVlKVr8PzUh5cxsA0NTNAhAZjcNhepqko5Uq8tuNw6yK9H0ONWw7FQusVClBofM72BsgbIA21tm4T/16T8Xsz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718189193; c=relaxed/simple;
	bh=WOFMFihXVv9KxbsCnwWds020toilnkak1LojX92RAOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaMAN+eKZAJpb/ulf/StmwvCTL4E0zzxBCpOIFPBoAOFB1DIvz9TDjuGheCBH3YT8M1II8eoFhHQrBf2LXTaEc8Ft7Bl0NtpGwpwB+ZhLs71FFg7mbXsTSzipI/DPnBO4BAKrlsVFcF6pqAWhswjf3EgJSaQXMH1SaLhznZkKAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkKqrD4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C626C3277B;
	Wed, 12 Jun 2024 10:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718189192;
	bh=WOFMFihXVv9KxbsCnwWds020toilnkak1LojX92RAOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkKqrD4zpN6yMzvHKEaL/9kx1szbkzOReGWgSrMjUCc8hr4Zkxz55XKU05RXVCzTz
	 a7qDQVrCnqIiETIFgMXrPh5Q2tCh3l4Hf2EZsh/GMejl+JRCQbtMbSRzWsU1wlsc8O
	 Og6GY1BNOlgdtJg3oFmABMSZ4sgy7NDdQwbaYO2Q2yd5EBy6heZKw2xMCQNd4rfI8Q
	 2tov1EOfoiYBIsZldE/ZS864wNMEXe+8j3ReKJnzsVNsrwOwvrwJbAulWPkVRe6z1W
	 +SLCDEuD364gt5TUECU1I5mH6PPzUHhJsjwl0y0NvxktTnDKrXB9Hd2Cf2xD3LA1zY
	 NJHsGf6eYxZQQ==
Date: Wed, 12 Jun 2024 11:46:29 +0100
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
Subject: Re: [RESEND PATCH v4] ASoc: tas2781: Enable RCA-based playback
 without DSP firmware download
Message-ID: <Zml8hVjRf-aH3Rif@finisterre.sirena.org.uk>
References: <20240612082332.1407-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iS94sJ3zuV/6KtTn"
Content-Disposition: inline
In-Reply-To: <20240612082332.1407-1-shenghao-ding@ti.com>
X-Cookie: Your love life will be... interesting.


--iS94sJ3zuV/6KtTn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2024 at 04:23:30PM +0800, Shenghao Ding wrote:
> In only RCA (Reconfigurable Architecture) binary case, no DSP program will
> be working inside tas2563/tas2781, that is dsp-bypass mode, do not support
> speaker protection, and audio acoustic algorithms in this mode.

Pierre keeps raising issues with this which I've not seen addressed, why
is it being resent?

--iS94sJ3zuV/6KtTn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZpfIUACgkQJNaLcl1U
h9AooQf+Iw5jLH4Gh/aBFIoOYIWjICQbjH8maeOHa5qj92O5m8HHwNMcBxkCFC5c
F9wKm9ezkjaDJjCUHUN0CEkQT+Sr0YjFt3gb553rLUlkIk1zJVRz7xx9DOJpQuKf
5KNwTaxxmk04KlXOid/wQr/UoxtaZhfXnFUi4wgPK4zqjdR9NYOz9/jeEpnejeg+
E9CcglGUWsDJjZSWQ/juh0YQT7/Gizbo3+FYNvJgNptP+u1igGOSygYJ+aK1V5Su
085X8ot2ioS1oFnFZFcAB0Lj/Djo6vTlPmanzAXpy6uWAtkxbm1gQKxgnDB6EBPL
nXqbEBZvUCTo6dhmFRR0X22eQuOJtw==
=E8aj
-----END PGP SIGNATURE-----

--iS94sJ3zuV/6KtTn--

