Return-Path: <linux-kernel+bounces-424872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DD09DBA83
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46726B2266F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D78E1BC066;
	Thu, 28 Nov 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h46E8anA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A890C6F06A;
	Thu, 28 Nov 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807867; cv=none; b=YtT2/dPp+orFEnE8wIIQGuNER8O0A1zQrbwvJC00UzIAYSRp/n9rdGiJvyzEHDgAMdFaeR0t/Z5UaSEaiuAvelYIJXtiALSv3CdYSWE8KBRkQC1ljR5Phlr3pDcIFVXxOhvARKG01A3E/ZMErczi7g+/FKYSHH/6ck09dCCiPMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807867; c=relaxed/simple;
	bh=caA69x6QUAyZ/eXBBtCJk6xQcdI5mH/IcuVdWXMQYkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5HneB4rTjipipLdh7envFrkzmBgLYfQU/LxfahEjJuZSbZFCD8MZyeKsJSEL8Lxdsi72p2G9Zs4cM3NcM3itV+2zYF75ebYNrCVpp56c2JWOjcyOKF8RZqh2Fqh3jTICNrLdaunCEC8wvPjJXy+lsVeUJohsTU7bkLInoVrzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h46E8anA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C638BC4CECE;
	Thu, 28 Nov 2024 15:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732807867;
	bh=caA69x6QUAyZ/eXBBtCJk6xQcdI5mH/IcuVdWXMQYkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h46E8anAEw7U0AhUKZLSPRPhPXoPIHKcbr0aE426YXbEUtfCyIVigLu0d2QuXacHL
	 kaBxieGJaDGQLT6fPBQf2ufblekZezR7O9Lx/GYHpRNvfhN62Qvqu79A+8gz4xHhdZ
	 iGZPTz3IXoxTYZrTPc1twemDUFcISigMk0R1zC7eeB6sqOG5fjKyWhh/b+PfBXJ0ne
	 oseVvlbyvLF/R1r4RrUhCbD7NDcpeDx4bDvP34PpkDtYCRVolh8uI1Y6mI/FwxU0Xn
	 I1QsGQBuU+JzLUjmO69lTWe1K4zu6U4sMHU8TEyGsq9A2GKRbL9n4SZm9269DbfLOY
	 prl53gNNxLvbQ==
Date: Thu, 28 Nov 2024 15:31:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Marek Maslanka <mmaslanka@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: Intel: avs: da7219: Remove suspend_pre() and
 resume_post()
Message-ID: <444630f5-1f0c-47ea-83c7-f267473be115@sirena.org.uk>
References: <10062d09-34c8-4e53-b5d7-f96a5b19f6f8@intel.com>
 <20241128151239.1666582-1-mmaslanka@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9qTyXkEkKJ2cvz5U"
Content-Disposition: inline
In-Reply-To: <20241128151239.1666582-1-mmaslanka@google.com>
X-Cookie: Close cover before striking.


--9qTyXkEkKJ2cvz5U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2024 at 03:12:32PM +0000, Marek Maslanka wrote:
> The presence of a plugged jack is not detected after resuming the device if the jack was plugged
> before the device was suspended. This problem is caused by calling the
> sound/soc/codecs/da7219-aad.c:da7219_aad_jack_det() function on resume, which forces the jack
> insertion state to be unplugged.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--9qTyXkEkKJ2cvz5U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdIjLQACgkQJNaLcl1U
h9CAoQf+MYRy+uhu/IADACa8/W5qZIcsxp8SOSlPDPS/oN7yYvI+TnXlTmEmUTuz
UIiJbgg7O1SZmFKyM5jR1jHGpDXlN9N1+5q7oxvFcaWR7XmgYpGhzFMkT238DPyq
538hghLgOAgcPDp2kD4gf2bwzGK8cHrh/tsppjGLsGc6Vila/AdN+dl1z/RN1wRK
OYuoIrMDdDOv+YT56Um6PBZfhFMKt226WA2bdvF+rjaQpAwude5auNBpR8VWl8Mb
O37HpDBj5/4A1oH+/RWNmbzRAd0wblAhkWA8Ji5VdgDx1dezudkn0wS/cppi58/K
UMmlY9EjtFmzrl/KyhHs+BiS5L0omw==
=B0Zs
-----END PGP SIGNATURE-----

--9qTyXkEkKJ2cvz5U--

