Return-Path: <linux-kernel+bounces-236709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FFD91E62C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2431B1C21A31
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B2A16D31E;
	Mon,  1 Jul 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXLDwVgW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814116DEC8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853553; cv=none; b=ZNcyCbLVX/Ox0W+oIxNk2lMy3izKzA19msqeWYK/YFMFInj8JWMb5A0yy7mz9Bog0I+/zmG8taUS7EbwNQYNEod4NpAHJ9y0seSQzPEKRT90Vfa2zHVULdyVaSI84MINN2iF3ZJexhSLCUMxHxAguqZTxPlbB6gsyaOUtTcEKHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853553; c=relaxed/simple;
	bh=tlKf3Bi7mDMgBZM+n2HDcWcjHjGpwC6uvUpUb8PK+MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgTSlW7ue4J8CVbtj5Y37Lvn9km14+aFg1Vm8BPOz+R3OqYujQIV1Q/tfo0KZiQ4KpLy2fPNGSs56hogQgb7GYf8n1pcHS/aCV9i6kprk5g1UO1mDiOdFXhsHBFSsDLJhWwyo2bnIK2olBqWyrsiIe0mIPlREK0jBRIaDKBkPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXLDwVgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9175C116B1;
	Mon,  1 Jul 2024 17:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719853553;
	bh=tlKf3Bi7mDMgBZM+n2HDcWcjHjGpwC6uvUpUb8PK+MA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kXLDwVgWaV3pM3cwc9TWqi9Ycg6BiEWLKkRqJkDNk4JHaChdgFfo/ThoVPQoilM+e
	 mjXu7rlFaiQjU/QpoZVlmbhsUcla+mVDOb9vbrifekEMrEBfPynKyH59GWs4BTcrJf
	 9Uw5bW5mv0mWZyv3vRrs/2MqkFk3Hu23ve6dxLzag0U2iTOhcXK+BU6NUMAnu6vKHl
	 YO7hKeXOWmsAmUXo0FtLAXrQO9FlfjvmcpvbXGquBXudpMD1Cv3WY7ITohOwpUZudQ
	 GDoDjVPuXvzeybKmotQfxUukkeIcjnTueqM3ZC0WoTJQIeTXJ75ZbTz86P/CKU1wIJ
	 /+iEWTee0+Yaw==
Date: Mon, 1 Jul 2024 18:05:45 +0100
From: Mark Brown <broonie@kernel.org>
To: "Ding, Shenghao" <shenghao-ding@ti.com>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"zhourui@huaqin.com" <zhourui@huaqin.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"Salazar, Ivan" <i-salazar@ti.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Chadha, Jasjot Singh" <j-chadha@ti.com>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"Yue, Jaden" <jaden-yue@ti.com>,
	"yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
	"Rao, Dipa" <dipa@ti.com>,
	"yuhsuan@google.com" <yuhsuan@google.com>,
	"Lo, Henry" <henry.lo@ti.com>, "tiwai@suse.de" <tiwai@suse.de>,
	"Xu, Baojun" <baojun.xu@ti.com>, "soyer@irl.hu" <soyer@irl.hu>,
	"Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
	"judyhsiao@google.com" <judyhsiao@google.com>,
	"Navada Kanyana, Mukund" <navada@ti.com>,
	"cujomalainey@google.com" <cujomalainey@google.com>,
	"Kutty, Aanya" <aanya@ti.com>,
	"Mahmud, Nayeem" <nayeem.mahmud@ti.com>,
	"savyasanchi.shukla@netradyne.com" <savyasanchi.shukla@netradyne.com>,
	"flaviopr@microsoft.com" <flaviopr@microsoft.com>,
	"Ji, Jesse" <jesse-ji@ti.com>,
	"darren.ye@mediatek.com" <darren.ye@mediatek.com>
Subject: Re: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Add name_prefix as the
 prefix name of DSP firmwares and calibrated data files
Message-ID: <7a44a36c-6f95-4c5b-a86d-044f9ad13ac1@sirena.org.uk>
References: <20240629101112.628-1-shenghao-ding@ti.com>
 <8245d8e7-3ff0-4f05-9f99-666e9693603f@sirena.org.uk>
 <664b818a177f4403bd60c3d4cd0bf4d1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X468BpO+KDEWwkKZ"
Content-Disposition: inline
In-Reply-To: <664b818a177f4403bd60c3d4cd0bf4d1@ti.com>
X-Cookie: Microwaves frizz your heir.


--X468BpO+KDEWwkKZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 02:00:13PM +0000, Ding, Shenghao wrote:

> > I'll apply this but I do wonder if it's worth falling back to trying to=
 load the
> > unprefixed name if we fail to load the prefixed one.

> If fail to load dsp firmware, the driver won't load unprefixed name firmw=
are,=20
> but switch tas2563/tas2781 to bypass-dsp mode automatically.
> In this mode, smartamp become simple amp.
> These day, I met a case from one of my customers, they put 2 pieces of ta=
s2563,=20
> and 2 pieces of tas2781 in the same i2c bus. In order to identify tas2563=
 and=20
> tas2781, I think name_prefix is a good solution for this case.
> Looking forward to your comment. Thanks.

Yes, the name_prefix is a good idea and probably people want things
specifically tuned for the DSP - I was thinking about error handling or
upgrade cases where wrong calibration might work better.  Bypass mode
means the device will still function at least.

--X468BpO+KDEWwkKZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaC4egACgkQJNaLcl1U
h9C/aAf/awSSP6/CWpeSsZln8BvRCZrSNarnxmhakBfubuGZsBnYigj6B6a1+3yl
nL9O1GGnP9K+gqXmOGyROc5RAo5AYlEW3WMJ2XulzQ1cJQJp9y9B7NI2tG77ifS3
PatH/PvgLVBkGSHucYN8l5xl7+cbtTJHClg/o0xBbUTQ55tUjsylDYi9v7pJoWSB
VBiceGAY7n9cSOa7DCw7Cvk0e5pugNSzx5QtimuOcZwuGvdKCL/2AVuq9wpXHl2o
1TVfUVxOxPBRySgjW5TOzJtKMBndPfORQ3VkqDLjGTwayj4GUTtTs89P5ypyGRln
Pv1+4b3ufBR65fMywQVN/DmzZ54NpQ==
=3KUS
-----END PGP SIGNATURE-----

--X468BpO+KDEWwkKZ--

