Return-Path: <linux-kernel+bounces-410858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC969CE91B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0617B1F230FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78401D47C3;
	Fri, 15 Nov 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe6QXSID"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D061D47AD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683165; cv=none; b=mYyPDtKOq4OJyaA8PbGryHRQMMP879f58GnazUw0oJedmvXihmIJ4DX6tFroeaGTQrB6bQawqNHxzW4Xi4aTO4m7tvT9DVCy1+8zevF+aDKluwoms4Ah7ym4cADIqDp7rlBKGaVvHL8zCUadWqTVLQuqS/RnBKv6yz8bmMIvxmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683165; c=relaxed/simple;
	bh=ohSlArcrCn8HsNShzObP/cKlpHWBfNwiCTE7R8oJ91U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8+WBQwKXZKc660nMoWV+mPj1w9SNY9ydhyI7tkkBC8SlexSxpNuBTma25Zf3lWH9+l8jCEce4pPRZgOaza5N4JomXAifRf/4Ka+cvGU/KlZuR/gr9LsPvMy+mv4GzeJRlQOhi3Q3LKen9LEBUZmN1UAkmzKkhfYHSFWfuxoRo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe6QXSID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436E1C4CECF;
	Fri, 15 Nov 2024 15:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731683164;
	bh=ohSlArcrCn8HsNShzObP/cKlpHWBfNwiCTE7R8oJ91U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oe6QXSID/IpgY9kPNukp2eOpMkCKgiJT947x7UWS235fRqAtjrtDlX5z5LMrzjNEW
	 WRokDkwqfL/AGi1BvZfOUQj+uo0lo7PW1Sz/e8z+TxSP1Iw8rIDUXPAq0p3CpRsqJa
	 wQyZpkTzNMMYPc/SCwO42HsZ1lgRVZ6ZBWCn8yqlLvpDMhnsOv8oQBJErFTxcDDoWd
	 UUL3Z9UtCzm7J62hPKSPsr/foDB+flnvv2XsAKPCHzNiMrLh/GKEWbxKw1a7LoSPRn
	 knqYOlvc6lttg7ZCNWbl05IZ8b0AB44lwn2LOoAVP2iIMZ/pTXfRfZj0jvlIYIT7s6
	 MQnw7jPPoVZ1g==
Date: Fri, 15 Nov 2024 15:06:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: regmap I3C support
Message-ID: <ZzdjWWrTK1bniwFf@finisterre.sirena.org.uk>
References: <67d549d0-64c6-4d62-add6-0958ef24910f@roeck-us.net>
 <ZzSxKctLlLZexdF5@finisterre.sirena.org.uk>
 <feda265f-f7ba-4017-a08d-b35916aafe96@roeck-us.net>
 <ZzS6ph8KulEITt5C@finisterre.sirena.org.uk>
 <88f34137-b215-4bee-b117-3ff00402ba6c@roeck-us.net>
 <ZzXfmonkRB-KaBhi@finisterre.sirena.org.uk>
 <85584c2e-2c45-4ec4-89a0-111fa5ad1080@roeck-us.net>
 <ZzYyu4ptPtYT6vJC@finisterre.sirena.org.uk>
 <7b23e033-5cde-44e9-be97-10296833863b@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="06HKCtrWrOkbe4Qe"
Content-Disposition: inline
In-Reply-To: <7b23e033-5cde-44e9-be97-10296833863b@roeck-us.net>
X-Cookie: Editing is a rewording activity.


--06HKCtrWrOkbe4Qe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 10:58:05PM -0800, Guenter Roeck wrote:
> On Thu, Nov 14, 2024 at 05:26:19PM +0000, Mark Brown wrote:

> > Right, so the fact that I3C depends on I2C deals with a lot of the
> > problems that plague the I2C/SPI combination.  Ugh.  I guess the helper
> > should be OK and there's not much doing for I2C/SPI.

> Is it really that difficult for I2C and SPI ? The patch below seems to wo=
rk
> for the LTC2947 driver. It doesn't even need dummies (the compiler drops
> the unused code), though I am not sure if that can be relied on. I thought
> that dummy functions are needed, but maybe I am wrong.
>=20
> The Kconfig for the combined ltc2947 driver is
>=20
> config SENSORS_LTC2947
>         tristate "Analog Devices LTC2947 High Precision Power and Energy =
Monitor"
>         depends on I2C || SPI
>         depends on I2C || I2C=3Dn
>         select REGMAP_I2C if I2C
>         select REGMAP_SPI if SPI

This prevents building the driver in if I2C=3Dm which isn't always
desirable, and IIRC the randconfig people kept turning issues up.  You
can make things work well enough for normal configurations, it's all
edge cases that cause issues.

--06HKCtrWrOkbe4Qe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc3Y1kACgkQJNaLcl1U
h9B8jAf+Lw4+IyKkev3fhHsl5PiBuZZ6fkwIH7G9ogUG9piPOz6W35f5W57HRPtB
6diEpjtI3/XfB2kyZt2fCrHbQljZV5N60HMiqyHrvWId/sd2oPWVns4+qYgtLNeL
6yfDihCd+XoPEAvwvuUJVCoQSZKOR5MGzAxrRkBFT2s/JN8Zae+O8qyTyqhJ6U0g
47FATd3eqzLwDI2xk5fLuKMh+ui3PVM649jm8TaPyA6N9Y8CkI0MGFIwuHPkcLBY
/QdCku7bPLu45SVx0UJ3Y+GX8YCY7iI2xijDu6VDhQPcvSAsEV7HKXiTfpJ9Jc2t
sHN9zr2WfUsX5Y0o2nSu7anJjgkFYA==
=C5xB
-----END PGP SIGNATURE-----

--06HKCtrWrOkbe4Qe--

