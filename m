Return-Path: <linux-kernel+bounces-197626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D8D8D6D3F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 03:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382B9B212F8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B8D5227;
	Sat,  1 Jun 2024 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="HfNgtfdm"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6148A2582
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 01:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717205222; cv=none; b=i6YZ83uJmeGVHyMXdwUJLzmQqsyWG4tyGHW5/8t/uyjI/IhE+2PpuqVPBy6q2sjH6jiNviTSIIywTtwsHIeus6W7wmjBrvMwxH5Htut0NyPXmm62fyaGc7dJt+bMpieACkWxeD3HONZSg1eF9/CgSNB07TZpfTK67AxdaxQNS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717205222; c=relaxed/simple;
	bh=xhS5k1LoFw5mHk1aYTyPPiWqY8Y9sGTdnl0TTeyKosk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eioRxE4zk0dVw5V98F7NXIlL1j6BWifcimxFRIaaPSN6znm6nGF7rWk8OdrXqKcxHT54x/9US3T6ebq/yGPV+l7r9fpLYdaq/VQH+pszGDL8Rcf70I7MP6/9ZaF13mkMQ2M2v3aHVk7DdvFsDWD9bscOJUJfbqmt0uxssak7fU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=HfNgtfdm; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=9UZT
	vRqTSkopzoGWC2DBGKqkLzYonV3O5fndQzXH9II=; b=HfNgtfdmT4BLtLqbvTR7
	X5CLrKaBktaR0GpVNXh3n0mMAs+lgbC8GcyljjBJ/87WEXhuQ95X+MxqcF2hep1c
	vli23LDYKVXKtUFkxefjbKP+xFOouKXkOL02z18OpYQBSg0i/vJAJJuhyH0Fn31A
	V04W8WEJEA2tfaMIHn5RQtFKlz9fN6bb147W0URY1GYy1aUhRz+KODbqmUpnGtRd
	zqYTlOjn6FcIr1ooQ1jAnRmGKnux8k+hJ5HgvmJe+BkvtgNfzvxlByPCslTJM0hK
	eY437V4Crk4wwCs4wgmqscT/2RBOfDdP1k0PH1Dxq9Wj7Vd34uusdVDaLiTvZjaY
	vA==
Received: (qmail 1314356 invoked from network); 1 Jun 2024 03:26:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Jun 2024 03:26:50 +0200
X-UD-Smtp-Session: l3s3148p1@whCN/skZrNJehhtB
Date: Sat, 1 Jun 2024 03:26:49 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Guenter Roeck <linux@roeck-us.net>, 
	Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, =?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>
Subject: Re: [PATCH v3 0/4] hwmon: Add support for SPD5118 compliant chips
Message-ID: <3hkjw3r3pa7w4jgpr4hftak2lrnwbt6sgswoxwcs4oxy7ekxht@uuviup2qdr3w>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Guenter Roeck <linux@roeck-us.net>, Paul Menzel <pmenzel@molgen.mpg.de>, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	Armin Wolf <W_Armin@gmx.de>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	=?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>
References: <20240531230556.1409532-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u2xqz2yf5d7fs4dc"
Content-Disposition: inline
In-Reply-To: <20240531230556.1409532-1-linux@roeck-us.net>


--u2xqz2yf5d7fs4dc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 04:05:52PM -0700, Guenter Roeck wrote:

Adding Paul to CC who is likely interested in this series.

> Add support for SPD5118 (Jedec JESD300) compliant chips supporting
> a temperature sensor and SPD NVRAM. Such devices are typically found on
> DDR5 memory modules.
>=20
> The first patch of the series adds SPD5118 devicetree bindings. The second
> patch adds support for SPD5118 temperature sensors. The third patch adds
> support for suspend/resume. The last patch adds support for reading the S=
PD
> NVRAM.
>=20
> Note: The driver introduced with this patch series does not currently
> support accessing SPD5118 compliant chips in I3C mode.
>=20
> v3: Drop explicit bindings document; add binding to trivial devices inste=
ad
>     Add support for reading SPD NVRAM
>=20
> v2: Drop PEC support; it only applies to I3C mode.
>     Update documentation
>     Add suspend/resume support=20
>=20
> ----------------------------------------------------------------
> Guenter Roeck (4):
>       dt-bindings: trivial-devices: Add jedec,spd5118
>       hwmon: Add support for SPD5118 compliant temperature sensors
>       hwmon: (spd5118) Add suspend/resume support
>       hwmon: (spd5118) Add support for reading SPD data
>=20
>  .../devicetree/bindings/trivial-devices.yaml       |   2 +
>  Documentation/hwmon/index.rst                      |   1 +
>  Documentation/hwmon/spd5118.rst                    |  56 ++
>  drivers/hwmon/Kconfig                              |  12 +
>  drivers/hwmon/Makefile                             |   1 +
>  drivers/hwmon/spd5118.c                            | 648 +++++++++++++++=
++++++
>  6 files changed, 720 insertions(+)
>  create mode 100644 Documentation/hwmon/spd5118.rst
>  create mode 100644 drivers/hwmon/spd5118.c

--u2xqz2yf5d7fs4dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZaeNQACgkQFA3kzBSg
KbaLtA//SZ6LH1y/YlEz9PjGHWj5toWB7vpZufcYfOpYC727e6MQq3GHSQUi0LGE
8qCFvr1/pOdOt3sfIJOoZDbGuKV5fort56dB/QtsuhR0dq3QpMtLeBeuyU3aqBha
UM81geIC0FOS7ivxwJ8muRHd2y7yEMEziF+CXPJM8oQ5DzPzUxkMfPhBv/HGYK+v
GVdjPBoeaQvesIazK7ZFRPEFaxFwfbPNMtQDZBfdgQmEk1vWoZnlnFgEuyf/7Aca
enQqIS4fq99qzbdVX+27BrtMZZ0KWBfb4N4MMoBQio8yMAsvYKm1o8XKQmCBfzEU
ggN9n13fUw80usJ4Ko5PXPSKx4CjCog2Yk7Dwc3FgiBrFqydFCjPTdcMljc6e3/9
i7k2QQ8KoG/QX2YNkco/lnz/Zg1pke8ntQtQsC0HNMyhTOuKOW1kgwrs1QmdNNt7
5DPDAwywITrLzVSJBlOQCbZvksvKBzIRkKQr9yJ+Y8oKPoKBNpe5e1QcH4MGrRHw
uPxUpJDboTRJsvZdk3zvSjHjLnOsuS0el65pkmiBlV2ndEKam0IY5CVj2SNxQ98m
Ew4wypT6/8EC9uNRpnwoUTFsoj5CASprGkDtgi3n33nW70VSRIXHMvKPYh6I6Ify
DQgsm3/Ig8H38no0/XbbdcA4qPVnu25mby3hTVC2xlh7s03/zUw=
=4YsR
-----END PGP SIGNATURE-----

--u2xqz2yf5d7fs4dc--

