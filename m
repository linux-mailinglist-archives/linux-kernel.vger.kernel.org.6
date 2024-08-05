Return-Path: <linux-kernel+bounces-274658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E05947B37
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AFC1F2187F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090D21581E1;
	Mon,  5 Aug 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHJy2VPQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502D21803A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862091; cv=none; b=FeRMgXUJonz81h9Qc7uKp76ddxHr/sV5V+oXmDW5Q35RNnuA5N/B0oYR9oC0mUPwb+oi0HyzckZWyt0Snd6PmH/FwcMva2ldKpkXg9w6K8UjffP0lKwCl6z3cb5YcxWzcw/UaOSqWcR0LyKxrHCl7tXpfRTqfLZUxeRpwjRkas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862091; c=relaxed/simple;
	bh=7NPQrnLmKomB8dVE0yVfIXBwKOpLM0u7n9p/PPQ7BXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JB6M+huNzAw7txs4LOV8uMQqPhlHFYCge+7OCCSZHMIN3QNmF6F+d7RCH6OXtc5sfFPlycAQa6TMMhONcwD7/MhBWvAuQE6hXLl9WzV+LAXhjevlsNpYyEOBKJAscYg9X3yJ40feURpXZDpvFhdmnlKJ7e4DCSk6M2BtuY2/Rqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHJy2VPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28902C32782;
	Mon,  5 Aug 2024 12:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722862090;
	bh=7NPQrnLmKomB8dVE0yVfIXBwKOpLM0u7n9p/PPQ7BXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FHJy2VPQiNZnE7ZeWks7hMPfUFbgWhdDrCwT712wOXVLDPOxPwg7dK7H6Q0FOyqM4
	 9EZ0LDI5bGUM5eBxR3iNJb1PuFaTA/riRtiSWcs6T+l+JN6MsZcI9TkkNWtnb3IWMS
	 xhieZki+WGLDsMHQrGxxWm9Ayt5+gjF92OpgDzrqGB7p+31I1Plnt4/v+KcTxdmm3F
	 SobaZUvO8v0ipGlW03d58vG9ErEKGpV6Q1KwK4EQ3+eBzBQleHH9oSUwfViusZdn5I
	 iBTxlHiSn4V44x5sRvVDDonFg6nt7Xb/VfXUxIl9UFNlQne1axtANnn0bXtHVjiWeW
	 xqbXN/1AoQkZA==
Date: Mon, 5 Aug 2024 13:48:01 +0100
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
	jesse-ji@ti.com, darren.ye@mediatek.com, antheas.dk@gmail.com,
	Jerry2.Huang@lcfuturecenter.com
Subject: Re: [PATCH v1] ASoc: tas2781: Rename dai_driver name to unify the
 name between TAS2563 and TAS2781
Message-ID: <bbaa05e8-4f4b-4ea4-ab57-3b5fb77ed8c8@sirena.org.uk>
References: <20240803032717.175-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DDYajqUCQj3cvoaz"
Content-Disposition: inline
In-Reply-To: <20240803032717.175-1-shenghao-ding@ti.com>
X-Cookie: Goodbye, cool world.


--DDYajqUCQj3cvoaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 03, 2024 at 11:27:14AM +0800, Shenghao Ding wrote:

> Rename dai_driver name to unify the name between TAS2563 and
> TAS2781, remove unnecessary line feed, strscpy replace scnprintf.

As people have previously said and is covered in submitting-patches.rst
you should be submitting one patch per change, not combining multiple
patches into a single change.  Each of the tree things you describe in
the changelog here should be a separate patch.

--DDYajqUCQj3cvoaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmawygAACgkQJNaLcl1U
h9APbAf/R3qFOYmRDX5yo5NRFAuvqgKawnlgMNTLrqlkyYgySSIFtNol6VWDWBoR
xhDwbWnOH/IOysx7cOMAvr5FRqkzfIANLs6jld081UvoyAsSuXuPXip+5yQ5G+7C
99zQQt/8j+S1OdDowgk2aCcvynbcBwEzRMHrPjDxtuwUE/a833MeskZoiO0GIdWK
+Eh2rl8xHsVVdvxGJyB5cJbd1lG5567onIhJyaqpFEGlR0/Js7yjWIwk02TG/Z2v
YVRjX+iMUlq2Mu9eLEK8InBXTEaZwrarCnoTkkVg/ZsmWX34UmyK/BCEP5F85vj8
kw6AqgdCfcRypBY+tv11PHGzRcnDFw==
=EMF3
-----END PGP SIGNATURE-----

--DDYajqUCQj3cvoaz--

