Return-Path: <linux-kernel+bounces-519702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7CCA3A0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7915E1656E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D445226B2BF;
	Tue, 18 Feb 2025 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wl2JcCyL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084F26B2A2;
	Tue, 18 Feb 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891496; cv=none; b=cR0/Rh2ZC6cFV0oaNc9o12yX0EbeLEWPYTa5VmEapWmk2UgkrmWk+1JO2bVYTrnRLaIkrjO1T6Ui1x8GMyOBmvOMhoXiuyGC5KmYMZpEYA7PLWMArLot70BxCm9zvo3i5Vc10lOhygefpW5QWAp7HeGvdGgdBG0txv8eMV3Vjaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891496; c=relaxed/simple;
	bh=turHXDwkpIiNyMXD+1g9N3ggiuvF4xsG88lQ77iVpMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DV3x6OjFUh+u8jmkyrwC1xwKnUDIP7SOJkTNKj4DWigSnej/f5V4bSP9NPNA9aGGC/tDEtZ85FoKvP8GzL/HzoJkaOsUwQg/oQ7nuM9upkFMnVok/s8vn0qYqN/QbveyQiohqypGWKUXh9oR1EXKANdCF1U3772zzpkIBwOYJzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wl2JcCyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CEDC4CEE2;
	Tue, 18 Feb 2025 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739891495;
	bh=turHXDwkpIiNyMXD+1g9N3ggiuvF4xsG88lQ77iVpMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wl2JcCyL4swZSuUygn4Mzpv3os6pEXc/Xbr1/vWWY5IyafBrMKvXEASGwevuLat4r
	 Z6TJyTiWlybPvKSApyQY9lBPY9/PMPF9wxMumJFAhV+L3BvLCyNy+7uDZ91uERbH2+
	 9rU5SleansbmIovtyxv3DYQj4t74iG/G1XfQQywCn0Sj4kVvFx/iHr/09gSsFtga71
	 d/+NprrZcDkP6QRJ6Vfw0rb1P2Got9udCzoce4ibw4IruU7Z+t8Er6ducD2tr3yyTJ
	 maSn1PLFu8A9VQAjQHMClVKAPjd9o6hLxsM2FxxhRWVPM0tkor8ewOVplAM5rhXALI
	 PboQctBfpWfdw==
Date: Tue, 18 Feb 2025 15:11:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"open list:AMD NODE DRIVER" <linux-kernel@vger.kernel.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	"moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>
Subject: Re: [PATCH 0/7] Adjust all AMD audio drivers to use AMD_NODE
Message-ID: <Z7SjI-NIZbMEgz2y@finisterre.sirena.org.uk>
References: <20250217231747.1656228-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="170e2EepvI2niirm"
Content-Disposition: inline
In-Reply-To: <20250217231747.1656228-1-superm1@kernel.org>
X-Cookie: Editing is a rewording activity.


--170e2EepvI2niirm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2025 at 05:17:40PM -0600, Mario Limonciello wrote:

> The various AMD audio drivers have self contained implementations
> for SMN router communication that require hardcoding the bridge ID.

> These implementations also don't prevent race conditions with other
> drivers performing SMN communication.

> A new centralized driver AMD_NODE is introduced and all drivers in
> the kernel should use this instead. Adjust all AMD audio drivers to
> use it.
> Mario Limonciello (7):
>   x86/amd_node: Add a helper for use with `read_poll_timeout`

What's the thinking for merging this - the SMN driver is in arch/x86 but
the bulk of the changes are in ASoC?  My first thought is that it's
mostly ASoC stuff, are the x86 people OK with me picking up the arch
patch (I'd put it on a branch anyway so if needed we can do a merge
later)?

--170e2EepvI2niirm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme0oyMACgkQJNaLcl1U
h9C4Lwf+JXdKsotpmFA5I71pyqyK9Ort4MqCE+7/frPtYibf+Aiy/gWhSctb2pUD
wmjX0NU8EZMHV34AAErrfrGTDuV+h9TadhSkcD4RdhCQEf616Y1D7aM79/YI91zt
fxayA3z7vIZgpwZsNOyNGtUZHCiPVKb43G7ZYoSSPL2QNJc3GxL5ijXQHrttQPcl
tpmH8wYyvOFUylR9w+HL8ldh1LbBIEveuA8CJQgGfGYdAdG1Zv0bPMc/3/QDA5WQ
pfxA+95+rzN43+B+ug3HWJfV8SE38NHPDE45b9sHLqIHuSwSa3wYQ/376zM+5Iwt
K/3TKWL47Rq4sgxsTJiGUDeL7UNeqA==
=wt+f
-----END PGP SIGNATURE-----

--170e2EepvI2niirm--

