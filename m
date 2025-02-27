Return-Path: <linux-kernel+bounces-536540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75899A480ED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E9D19C1939
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D73223ED66;
	Thu, 27 Feb 2025 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URDiW1WH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A27235BF0;
	Thu, 27 Feb 2025 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665368; cv=none; b=g2ySpqaobw2omC2cyJA9tkT2ykTTi1IbjC65MYm1FME63NAe3ALaCHwl30GOuDoRt9q1s1KjdcQ7IX7h2L2EzwoowYTh+j0YFf/2N0Sj1T5AlZnTAl9ibKGahF/OJ8keDDt1xyJ+Zse3QdAWgz8pRrRgv2a2T+AHIx5/CtWS8NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665368; c=relaxed/simple;
	bh=TDjlbYyga/Kdmo2q8cag6iyCiTb+t5ApmuDdADAdWMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8Xg6AZM4lViOTvmKG0QNz/tKhuvBRF2lmeCag+hPgy/r3pqzJWXz620rMK0wZqPGRPbJrTlXtLmPg12pzpRTw85q2IlFr1JYkWi7izTTmKX+6vFRcYUTJnmqTLj1msjywguDq2+nAaB1HlwwiambT03VCOzN5LEKkMs3UOHb7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URDiW1WH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05894C4CEE6;
	Thu, 27 Feb 2025 14:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740665368;
	bh=TDjlbYyga/Kdmo2q8cag6iyCiTb+t5ApmuDdADAdWMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URDiW1WH4pfZpqC3328Vw9HlHHU/hH8D3MPJ5NXo4Ls0Y8y+uGT8nz/daM0eLINq3
	 5Q00kzv7aouUHw6HSIz26/diBjcn28LNvgRhL+NqCjzL5T6g8A5ykiK1WLVfqe6Dce
	 RaBm35/ZJ51FJN+uuYgEqk7J4i+2DepW3v60HpBkzBX+ftGxhL66oYPtR9q/ThTu7w
	 QbvfV7puDelxMxAVDPowovwwYiteU9iQ6sRQs9Xg5X5XjIdYyisXkpTC3ngFSByMNS
	 lJ+OpDCcD3uqkX2PeAVntUJOa2Etz2MCKJ/O0XpdvDFsj4e0gcUWiZTMfxARLGUCw4
	 pEa0HGG9WOpmQ==
Date: Thu, 27 Feb 2025 14:09:19 +0000
From: Mark Brown <broonie@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v3 07/20] ASoC: tas2764: Reinit cache on part reset
Message-ID: <2bd2a75b-457e-447a-bfcf-549f17c05d12@sirena.org.uk>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
 <20250227-apple-codec-changes-v3-7-cbb130030acf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4B6KGqyRTVYPzK2N"
Content-Disposition: inline
In-Reply-To: <20250227-apple-codec-changes-v3-7-cbb130030acf@gmail.com>
X-Cookie: Swim at your own risk.


--4B6KGqyRTVYPzK2N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 10:07:34PM +1000, James Calligeros wrote:
> From: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>=20
> When the part is reset in component_probe, do not forget to reinit the
> regcache, otherwise the cache can get out of sync with the part's
> actual state. This fix is similar to commit 0a0342ede303
> ("ASoC: tas2770: Reinit regcache on reset") which concerned the
> tas2770 driver.
>=20
> Fixes: 827ed8a0fa50 ("ASoC: tas2764: Add the driver for the TAS2764")

As previously and repeatedly mentioned please put fixes at the start of
patch serieses so they don't end up with spurious dependencies on other
non-fix patches.

--4B6KGqyRTVYPzK2N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfAcg4ACgkQJNaLcl1U
h9BgKAf6AiGuXhc4Q9dbmhxACf/RVQiCCntr3O5Lw0MqtQZ/OzBtg/CmeZV+bVdq
qzB3L5UQRhIl96AcMVVSQaBLzr+JPxbqTTUBAgmBWtENEarv3nbJJAcUd/MtgGYL
VuOIQxcD8EMnQnHyd1il2C7M1EmI9No5RpuernSelphZHczPisYmP3acn38+RcfV
aVVjngHNskuwRL5Y9Z96XhMrX+oJ3lS1XGIrCWwfaR0M9yc19pAnPwlEjyHvel6X
dAMqPVT8EJMuPUHkXmshsT2TIcw1R7GkSEho8kfzamqVpO4ATs9fkPzLH0B/Q9Lx
D4CMlEha5IFs29QcsrKl4rKdQE7ABg==
=LrmF
-----END PGP SIGNATURE-----

--4B6KGqyRTVYPzK2N--

