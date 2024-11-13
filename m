Return-Path: <linux-kernel+bounces-407644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A48E59C7086
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57EC31F2305C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEBA1EE018;
	Wed, 13 Nov 2024 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfWbQ5mW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749E1E0E09;
	Wed, 13 Nov 2024 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504253; cv=none; b=YmN5qSkFknwi1kImvcO5HmhQOvp2nWjFXdElV2Bchw3Jb8WYDp2RRveJs/wQwqqlK2ickmjSckI8PohBv3q9Kkg94jqPo/4HZU0579Hnrm0x0RMqXrVsWagt2mJ0evGK95o0h56ONVp76psLQabdQf9n30NcV5QTHUQkpPVBHJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504253; c=relaxed/simple;
	bh=w1uGH5DI7jQ4MMG1d2kSZOZ7U2WjgNn6EaaD1OTP5BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBGxVdYhHGHN0KZYtyFfJIbsBeJXDiRUvPQq3KdaqJLpKh4bF8BVeTySES+axIHoxoyVxUkaVXwxd0PNOVg6OfOGpYHfc6Gy3nDEEUX4MLSrUxgztA2nD2iF8r8gJ1lrGYYz8UcH7oDRkIU53/gLCktPhvxEE1+7bcOobj5ZnKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfWbQ5mW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E678DC4CECF;
	Wed, 13 Nov 2024 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731504252;
	bh=w1uGH5DI7jQ4MMG1d2kSZOZ7U2WjgNn6EaaD1OTP5BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QfWbQ5mWy38NB7BhUKkVnGbBQd42dc9mRwjmpKGNPraivGf7PztAwCQaQF2IF6jPA
	 HI06wjm+Q0ALHRXQZ8OEn4La7cwccfA+ZG+BZjHxrybfdhMTruJ+2GLAsqdKacVYdg
	 t7mXNqlRW8r1NsA5V4tuIs+VeBZ3ttUp84duASrDjyhQI/Vav1aOsg4L1erMLlyGBZ
	 Zkl1UT5XONYa6gWD5JZWRUwgo8Lq2HTU7qNzxS0Z9ajBzUkoN1fKfC1oQdrn384EfF
	 o+oLEUUSrA5B3dO9GbH+42EH9OCIoQ4qBtoSu56rSkT8FMno/ZA9/tprh9kbzvnWnB
	 vtMYF4sMDcNTw==
Date: Wed, 13 Nov 2024 13:24:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Kiseok Jo <kiseok.jo@irondevice.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tang Bin <tangbin@cmss.chinamobile.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: sma1307: fix uninitialized variable refence
Message-ID: <ZzSoeF7dnWDw6rqj@finisterre.sirena.org.uk>
References: <20241113115708.4772-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dG8CkEoz4e8R5/aM"
Content-Disposition: inline
In-Reply-To: <20241113115708.4772-1-arnd@kernel.org>
X-Cookie: Editing is a rewording activity.


--dG8CkEoz4e8R5/aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 12:56:50PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> When firmware loading is disabled, gcc warns that the local
> 'fw' variable fails to get initialized:
>=20
> sound/soc/codecs/sma1307.c: In function 'sma1307_setting_loaded.isra':
> sound/soc/codecs/sma1307.c:1717:12: error: 'fw' is used uninitialized [-W=
error=3Duninitialized]
>  1717 |         if (!fw) {
>       |            ^
> sound/soc/codecs/sma1307.c:1712:32: note: 'fw' was declared here
>  1712 |         const struct firmware *fw;
>=20
> Initialize this to NULL as that is what it gets checked for in
> case of error.

This is just shutting the warning up - looking at the stub the real
issue is that there's a return value from request_firmware() which isn't
being checked, we're checking for the initialisation of fw instead.
There is one path in the actual implementation that returns an error
code without setting fw, though most do.  Either this caller should be
updated to check the return code or if checking fw alone is valid (which
TBH does look like the intent) the stub should be updated to set it.

--dG8CkEoz4e8R5/aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc0qHcACgkQJNaLcl1U
h9D8QggAg56F1egAfYIWAARNgFhDs0u5nfZZLY0ZhnJClG7okQVatveZ+yjuWO4b
3kp5qedHaLits7uzc+IZ/+zEX/0kW8xsp028kP4+sj3m9NswvLkVuApkuHEX0T4H
Tst4d3wfv0QTnGIO4nWushocxH3JM1X377Qr18AbJrEIV6z0WgkGiy2QzXahzHIH
j3HbI+GLVC3vlMLR6ipnUNaOudkJSe4ZnRb0C7V85VrGOXvuj/ksVchbdB4s9L+N
qA11e5+3ER7LYtsGAPq0F5rIqhF1awKLJW/h1oTc8AX8/ivqOH4ihH2aQy9oAbzE
ZMJLGTN7y/1EdD2VJU6lY0uaiD9ZLQ==
=EYyE
-----END PGP SIGNATURE-----

--dG8CkEoz4e8R5/aM--

