Return-Path: <linux-kernel+bounces-536513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B7AA4808D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5C5C7A5E32
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C884233128;
	Thu, 27 Feb 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFlFJZf2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05AD1B3725;
	Thu, 27 Feb 2025 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665099; cv=none; b=rw0AXKNQmKaVR4jeSz1v+vdkE5IS1WYaLu4CsK86bAzAAtueCr9wwDyLKfLMBPCvHqD0MnjUvLgJe6/807rXjVRJm1aPrsiJjfyK18KCIcuiaynxyWjf0qvPrtf5RnzvhgApuiN/LbOhXCu0l4Fek2WcqbQE0ssUQHltbUVz0nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665099; c=relaxed/simple;
	bh=dgAlLSurJORMf0+1xamz5/LbTrkIl0a0+wfI6SvNKjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8QZt8e2CVclNMApRBxNfq2ngj8iUIuDOXnO0td1/S8eZamecH//QeiTlwladejWYm+oeZ/xLQJD6zv+8UYIv6oG/TPlnDBTepwI0E0YRWhDr2f7LZuHQ+hszq4utmld4DM29ds1wo7x7XFkuWiDYBbQd0YtaJnD7iHIQ1WGn20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFlFJZf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE48C4CEDD;
	Thu, 27 Feb 2025 14:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740665098;
	bh=dgAlLSurJORMf0+1xamz5/LbTrkIl0a0+wfI6SvNKjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uFlFJZf2RGzIUNxW1+ykXJ1WRNvWPGJ38acDuJ4Omr5GCsM7RjzMySc09HI/tG+nM
	 BqsY4jbBH+GQ5efEl3LCmeAAeZnA4nC9cIH/Us3KoiqKQdqtMYE9y9viaCIB7AZ+8q
	 VhHZhvUW1ATR0I+NE4CbmyEal8gFCCXtIOgJsuZZxIYe314odrCLOcDcV5jFeNZJB0
	 y3fJm4d1BTj2H+xvY1oJ+9weRtX3uR/Pf6bYB9RhSvbScz8e8FZfK3qMHGzspE6Ukj
	 Z9VezYOq/uePrLIi4P+Q8/Qz79tY55FO1WHHOLAOtEjBk7EQIpY3r+8iP006CFbLpR
	 V3N8m6nAjcsbA==
Date: Thu, 27 Feb 2025 14:04:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: James Calligeros <jcalligeros99@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Jean Delvare <jdelvare@suse.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 12/20] ASoC: tas2770: expose die temp to hwmon
Message-ID: <16d46b4c-9fba-4432-ac68-9ca19492d754@sirena.org.uk>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
 <20250227-apple-codec-changes-v3-12-cbb130030acf@gmail.com>
 <b1be4c35-b452-479c-9dcb-700ae276e8b7@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LxdrajutEeelhphe"
Content-Disposition: inline
In-Reply-To: <b1be4c35-b452-479c-9dcb-700ae276e8b7@roeck-us.net>
X-Cookie: Swim at your own risk.


--LxdrajutEeelhphe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2025 at 04:45:35AM -0800, Guenter Roeck wrote:
> On 2/27/25 04:07, James Calligeros wrote:

> > +static int tas2770_read_die_temp(struct tas2770_priv *tas2770, long *result)
> > +{
> > +	int ret, reading;
> > +
> > +	/*
> > +	 * component could be uninitialised if the codec is not
> > +	 * attached to a machine driver
> > +	 */
> > +	if (!tas2770->component)
> > +		return -EINVAL;
> > +

> If this is temporary, it should return -ENODATA or better only instantiate after
> a component is attached. If it is permanent, the device should not instantiate
> in the first place.

I am wondering why this is using the ASoC component rather than just
the regmap, then there wouldn't be any issue here and the reads would
always work so long as the device was probed.

--LxdrajutEeelhphe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfAcQIACgkQJNaLcl1U
h9B2fgf+KCWqBaGMQpq3R9Tvbz0u9vWC/fsINo29LZsErFWWYPMoV8YrJFmMBhKD
myLKCFxn13/MVueLCvBJoHW+Oq5HnOqfi3ql4nbbOXns0uRoce2qVxPd3Zp0GMMU
g2Xvg4tDw7bSHTCjPbBtAxAVgYLOnwQzg5mmA6J39yX0PtF89QA8xXI2cafbjsUl
zIbLyxtw7PvtANvV7BED8uUmj2LxaxD9MzF3s5m2yi1xi2p0cLppCFlDU9c0DwPj
wxYezPjc1xfJf1xKDsFgfkirq66S19A69NSmhzdEnHOD7fYU+nd8E7EckadIXtXO
lUD6i81bnR53Ri94EdEIdXczN6WDVg==
=PFH1
-----END PGP SIGNATURE-----

--LxdrajutEeelhphe--

