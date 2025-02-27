Return-Path: <linux-kernel+bounces-536849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB27A4852C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F1E1754E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6F71B3956;
	Thu, 27 Feb 2025 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOKBAi98"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E401B041C;
	Thu, 27 Feb 2025 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673426; cv=none; b=gC+xhSHP621dN839C+RRc+VxC+YlYWP8G5pHUGbFmdiaqxtZOvqG/bkDTY5mTBZvIFfqWOFR46lm11PAwKqkR1BIJWSygZYzsuhf/ebVzGHXIZKa6wyjdMiIEYoDHjHGOsNKmeH/gGeN22k3IQGg64Kxpn8zoPP6q9S2KvDlBGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673426; c=relaxed/simple;
	bh=hRTLLI+V63ZTqfAe2Vku07MrmJYqxX3HszgPccCeGOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmQFgwfuQhCq67b4d9GT+v7ZqKb/J6AfHYkAKLuPv0Gc34pjyN7ZvIX1HGdieka3VINhlnI4mr/CoeycKsApG717k2US2H7XwlqI/jQ4AhOD7l+Grm/iJKpda+H7AjWlgubzNM3Aj5YhoT3zUzoIgjYu64rQ682dFmWWQpLPLxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOKBAi98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A91C4CEEA;
	Thu, 27 Feb 2025 16:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740673425;
	bh=hRTLLI+V63ZTqfAe2Vku07MrmJYqxX3HszgPccCeGOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOKBAi98ARB2s4C+nQkth1QQmgpZpAeJmIoDnuzPYAwSqYKdRPiLglOJh8K0wJ2Tt
	 RSiMHP/IG9omE9EJU1TckpKuoetbPqgaC7FkGj8rUa/LixV48XsdNRNAaZviudNXNc
	 TV0sCWnh1ZPqVu8qdKJyRQR4HwLJZAEP5L1ZkBNSy0HqMWilDYwRr5Vs+/jq1EU86Q
	 L7daRO6SIg4pyL+ht5dMplMTMrww8zGlyXFZNIkTROX3CoDBQ9YbMP8DcHnFZdiKKe
	 WJkqLLBEqG+yioiIUltbt6FiOaCEMcEkYkLF7QfrtSzxHov2TBYuNZtPZRurTNPD1H
	 7HRl3rBU8bTFw==
Date: Thu, 27 Feb 2025 16:23:37 +0000
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
Subject: Re: [PATCH v3 15/20] ASoC: tas2764: Enable main IRQs
Message-ID: <f3eecce4-51d1-4414-af85-680d51e588fa@sirena.org.uk>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
 <20250227-apple-codec-changes-v3-15-cbb130030acf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xh/2KfVmmxBW7uMY"
Content-Disposition: inline
In-Reply-To: <20250227-apple-codec-changes-v3-15-cbb130030acf@gmail.com>
X-Cookie: Swim at your own risk.


--Xh/2KfVmmxBW7uMY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 10:07:42PM +1000, James Calligeros wrote:
> From: Hector Martin <marcan@marcan.st>
>=20
> IRQ handling was added in commit dae191fb957f ("ASoC: tas2764: Add IRQ
> handling") however that same commit masks all interrupts coming from
> the chip. Unmask the "main" interrupts so that we can see and
> deal with a number of errors including clock, voltage, and current.

Shouldn't this also be a fix?

--Xh/2KfVmmxBW7uMY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfAkYkACgkQJNaLcl1U
h9C91Qf/W/xSSm2MphMfElXu776JaJ/c1ogrwQljVZCAXT9K+gX9xynwVnjtnhPA
a+bPEHDxgCkxvLEcjdp7sbx4h1lNjPJ+bnrlymPPUdrg4GErmcU1+QVB9bRcm0ub
hjhLx72qSHcKK/FSWn6AwFSy8a2nqWIhbbDvBFngHptBslxBs05eaqkQGyGIn6pT
cj1U7BtFotULFKVvrLmV+jV1Lgy688Elo6eRif4Tfpk2/2Yo0VJ9vFe6LuajFZTO
uZgYX7VKIcySWUGCoX2o2TYZFWRSlH8kPlQn9YO65qk/gh3KJERgnkHgGYgjREwv
dSrBxeNszlSMQUHFe7IexiRxFp/yPw==
=B8ch
-----END PGP SIGNATURE-----

--Xh/2KfVmmxBW7uMY--

