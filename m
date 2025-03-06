Return-Path: <linux-kernel+bounces-549001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08D9A54BEC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1911C16218F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C4320E016;
	Thu,  6 Mar 2025 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4GnPR9R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4FB20AF7D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267348; cv=none; b=YNRjiFyM7Ry/NkJopB4OCTIYJj3IOmYNiOn7Ol4ExwBg9RQRTGV2q8V4wSbDoC3E3Tun3m0bhVbxBZvwBa25b3IV2voQOxqMn/nKpd1LaIqIHyIbTwjsKDEPuHLfw24GP9aFbiunmMJPmqUAMyPp6qrWrhRekzSt5++xnoAXDOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267348; c=relaxed/simple;
	bh=5eA2fLHHytvpJsyufAJwyobEAShcLAnIBdswKa/Z1lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxZV1yT2i4pzQ2Dq1VUCTGsy5C2i2bAQLmdBGU/aT0aSHHXlIHicreNTiKgTJdfsnPVFPiipw6jSpRx4dXWcpeR21HvS/ATvIJ0LoC9Hrer1f0kKrV4dYMN1n9t29YHqZnQX42Jm6HAGRZFbKbGA6tRsAhucG8wcunrYo/oJ73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4GnPR9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A70C4CEE0;
	Thu,  6 Mar 2025 13:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741267348;
	bh=5eA2fLHHytvpJsyufAJwyobEAShcLAnIBdswKa/Z1lQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h4GnPR9RmMvQ0OWRNHnFkYNA8Qzx1rrG6j3xc+FA+xT3GZ7l+GfVG6UmtrxuOlv9L
	 BqYzgXl06LV9TkfaDmscSJuQTrh9JJVm5uAgVoV5HyqnPbfj+QDCMfdpNJd182++D6
	 hIoNYuEJ/pHzmLLJQyounH7roHgQvEnlJDOIb7jqz2WzLioVA17tbdM6XYCjtwS03l
	 L3ulPHdKCVSrvV5AybwS+AIC83i7ENsr6pMcj2JkD+ocZLD63SPARZvthnjrUBp0F9
	 5eYxV7dsEsth+JXV1L5s6fpzwqG28DRS7tXxOZhlOEB7io11rEGM1I740RxDwRR8LR
	 A1pVwL/a99YjQ==
Date: Thu, 6 Mar 2025 13:22:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, lgirdwood@gmail.com,
	bleung@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Convert regulator drivers to use
 devm_kmemdup_array()
Message-ID: <e993a833-45bb-44c1-9129-63e3a3ac106b@sirena.org.uk>
References: <20250228072057.151436-1-raag.jadav@intel.com>
 <174077776750.602863.5336934105237710269.b4-ty@kernel.org>
 <Z8kFW13EyR0YXnJd@black.fi.intel.com>
 <Z8loo-N5byavJLkm@smile.fi.intel.com>
 <Z8l1ozUOMTDNQupC@black.fi.intel.com>
 <Z8mBQEKAJfZd6a7G@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ayCJo+E4ycenxaol"
Content-Disposition: inline
In-Reply-To: <Z8mBQEKAJfZd6a7G@smile.fi.intel.com>
X-Cookie: What!?  Me worry?


--ayCJo+E4ycenxaol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 06, 2025 at 01:04:32PM +0200, Andy Shevchenko wrote:

> I;m not sure what you exactly pointing out here. Mark seems applied only
> necessary part of the immutable tag, which have the same effect. The Git merges
> only once the stuff as long as it has the same hash.

Yes, there was a lot of random IIO stuff applied on top of the API
change so I rolled back to the API change.

--ayCJo+E4ycenxaol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfJoY8ACgkQJNaLcl1U
h9BL8gf/cduCWkNZ8ybQsoPgWyU1dB+EilRvOOqOdvXhb3TT/TtCOSfRsQoB583y
F8jbE42mdTbRttZ/If3qVyzoKgfczmM/+3HAFQIu9HSH+W3rNVmX0fyZbE8ELJ4k
cdhwWNtERS+71S4s98EuN/MMS0YuRpzPalyJOx6r7mFYobNRhSIjVzd9ReyLWpR4
Psysx7lmdiXLhF9mX1a+53fJ0K+1hePNWjPxlii7qZ+10ceUycVXzpmDTsT+Sw6p
C8mlLXQxOX9LHVi72PoVSuxsZN9dPjV18ODc2Cmd+aIfMHVDTf3ybcQqottu9hNe
WNQ4opCxroTbSIubeR1Ft29YJfQ7bA==
=cG7z
-----END PGP SIGNATURE-----

--ayCJo+E4ycenxaol--

