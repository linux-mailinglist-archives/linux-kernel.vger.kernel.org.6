Return-Path: <linux-kernel+bounces-519720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A60A3A106
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF51E168080
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8594D26B968;
	Tue, 18 Feb 2025 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4nEi1cY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB26926B941;
	Tue, 18 Feb 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892143; cv=none; b=r+cMIywKMhJdG8gTDkSxM/t8AP9hS0f16Z6kT1U0u373gLIo2+eWiA6qqvtw/NEig7VN366sg3BC6NuUICOOQ2rDo+u1F4qgSjFWEoU1ejesjcYPoTev7fgihF/rA7Ue+pcMQH6TOFHCc8yjBgz2jJXIIpyUWPjC06wuhwIV+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892143; c=relaxed/simple;
	bh=CphACLAqvIflXYcAv3QKKAHMG/CZ8j6uTUMma5nm02U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyzqeU8pB729yoZxiwNA9NaN9r+9cttAiwJ3TZAQy4BzDYkZj5vrYL0de8NH02y/HaEYJwiJtOt6IzYYjRqgbibf+PpbE+4tOX/ewnudMalUeHRyD4GiFQiXjCe3Z8MdwnPhQrsm0PktVrRje1eGjzgwW9XJv4rn0pktm33txT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4nEi1cY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4A7C4CEE2;
	Tue, 18 Feb 2025 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739892143;
	bh=CphACLAqvIflXYcAv3QKKAHMG/CZ8j6uTUMma5nm02U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z4nEi1cYRufTXj05gej7K+ULv4chRcbJ68967+ViNhFmanT9xtJJHTIBXU+WQUsOh
	 Sugd0EfHNEsLxJsHCYUjSbD6rwl6z4IHZARjP77ohoWUi3RoEAZSfCwr/BidoJSwMd
	 CyJZA1lUQCrwOv8U++AFWuoGDZz10Tmxj7TnXMYO3Y4TLxGLSPwoXhsT3beTQvDPn/
	 CDkrIun0fLUTO1vyubCZGKSMX4pChXtVcd5nxHVpJc5CGvb23Ndw4n8Kc8+XafoBPL
	 jNcHgXgT3y4CqP4AL3GGq2ONIk0KU+0nbc7cK70W8r9q56JAcQ2ARzZ3/FL4K0/2KU
	 418wc93C68PIQ==
Date: Tue, 18 Feb 2025 15:22:19 +0000
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
Subject: Re: [PATCH v2 13/29] ASoC: tas2770: Export 'die_temp' to sysfs
Message-ID: <Z7Slq3BQY7S5REPy@finisterre.sirena.org.uk>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-13-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gLFGwsPnElS71BpA"
Content-Disposition: inline
In-Reply-To: <20250218-apple-codec-changes-v2-13-932760fd7e07@gmail.com>
X-Cookie: Editing is a rewording activity.


--gLFGwsPnElS71BpA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 06:35:47PM +1000, James Calligeros wrote:
> From: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>=20
> Export a file for the readout of die temperature measurements.
> As per the datasheet, the temperature can be calculated by
> dividing the register value by 16 and then subtracting 93.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

--gLFGwsPnElS71BpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme0paoACgkQJNaLcl1U
h9DDJAf+JFf0wYxVTABeL8XV4Dgi3VAJTcYK5vbEnWYyk3QVfdFY/xhugPSm08OL
9CJ/VGbsmn1dOaey46o7EAAdUFoxIf4k0swg86TM/E8P70c+YuaFjnauYC34kqnj
3mlHbK1yKK4W8GTd+GWJF16DLhaz9y87mEM/BO94RcBPkc3lSOGLxEktpdRfA/jS
sP3TjPb2/Zh7O2VvjmCskrsGbc6nT3cqWDJDD/5npuTX06WtOSZDBFiP75gU15mB
OGL6sa65zUYmNeVdAPYkTJDWJy/2HAP8R+fLvB2socWQqsKUaCQB8omfQTj7CiAK
9vyU4osjCsyKwVFO4Y4nyUhC2R5QkA==
=yqb3
-----END PGP SIGNATURE-----

--gLFGwsPnElS71BpA--

