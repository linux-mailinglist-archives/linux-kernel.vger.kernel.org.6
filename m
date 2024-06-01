Return-Path: <linux-kernel+bounces-197627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B288B8D6D42
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 03:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1CD1C21250
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D022C566A;
	Sat,  1 Jun 2024 01:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="cM6v70+J"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4A22582
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 01:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717205334; cv=none; b=PnOTlO3zckSGkBHKjMqJkwdb5yXepdmdx0BNQ57QBG6MI0hE6W0XoB+d7om5+/E1TZlN+5zFL1cmHe93nuHr7hDmhFcuUtxiw3Ahkg7uaVabCQhQDS140OeHK4WmDcE7n6p1XIdodj+0IKW+EtilNoeylxNdjujdkCFPe6UQsK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717205334; c=relaxed/simple;
	bh=K0dXAdksh+i6GPoOz3SNlGeawSia8gf189LXs0UIoNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjsdZPy8YmhF7483DBHWj/5WVDkY6JpY/rrE0cADjTFFPkUr0AZeLiYezAOxXiqtoPC2Ib7oRnsrDiPZOigkdYVwcRZynrEAQICpoGMjp0wYH2qwudyuLTzK8QUZoNsP1+bNV/9Hw169rX1lPFvXvWrXJYQfy9hwTgQxFqvnljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=cM6v70+J; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=nsyB
	Yubvsxt79/q9f0pugqP2ozHD/6I7Jc7gSjc9vwc=; b=cM6v70+J5+d3xSQIuFZZ
	A/3qBvufcoRaPa2nruh9GEjYW3DLtKwkSL2rBQ+1oHzsFCy0W1txS0v3zkDGUg/d
	EAEyN6HlUTmGkvtR7DAZV8jBLs3cm/+rRfLEiKWqorrmlOEOu0kQmJEuKN++2KpH
	Fyc8j9QVWdXKN7jZhxOy/qx9yLFMv/Mm1Vv+ng6KjI8Xh5b2gARV59csnXVHW6ca
	J6LYX9ic/GOEP+DFKzY57xrPc91QcwvKUCFM7p8gIjpNEbxdxkzPa3n4OO7GxU+G
	a5oUxyPOIB2ktZZjq6+j8el0Yohowaxl/1cyf+FLnPNQZRvOfLNwQhej0izb25iC
	jA==
Received: (qmail 1314606 invoked from network); 1 Jun 2024 03:28:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Jun 2024 03:28:50 +0200
X-UD-Smtp-Session: l3s3148p1@K1+wBcoZnORehhtB
Date: Sat, 1 Jun 2024 03:28:49 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, =?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>
Subject: Re: [PATCH v3 2/4] hwmon: Add support for SPD5118 compliant
 temperature sensors
Message-ID: <uvikiflwuoz3szchmvke7p3ymqvcngkydehk6cctdv24cxsh6r@7d5vxcvdca6l>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, =?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>
References: <20240531230556.1409532-1-linux@roeck-us.net>
 <20240531230556.1409532-3-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yq7qukcenpm3ibk2"
Content-Disposition: inline
In-Reply-To: <20240531230556.1409532-3-linux@roeck-us.net>


--yq7qukcenpm3ibk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +/* Return 0 if detection is successful, -ENODEV otherwise */
> +static int spd5118_detect(struct i2c_client *client, struct i2c_board_info *info)
> +{
> +	struct i2c_adapter *adapter = client->adapter;
> +	int regval;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_WORD_DATA))
> +		return -ENODEV;
> +
> +	regval = i2c_smbus_read_word_swapped(client, SPD5118_REG_TYPE);
> +	if (regval != 0x5118)
> +		return -ENODEV;
> +
> +	regval = i2c_smbus_read_word_data(client, SPD5118_REG_VENDOR);
> +	if (regval < 0 || !spd5118_vendor_valid(regval & 0xff, regval >> 8))
> +		return -ENODEV;
> +
> +	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_CAPABILITY);
> +	if (regval < 0)
> +		return -ENODEV;
> +	if (!(regval & SPD5118_CAP_TS_SUPPORT) || (regval & 0xfc))
> +		return -ENODEV;
> +
> +	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_TEMP_CLR);
> +	if (regval)
> +		return -ENODEV;
> +	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_ERROR_CLR);
> +	if (regval)
> +		return -ENODEV;
> +
> +	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_REVISION);
> +	if (regval < 0 || (regval & 0xc1))
> +		return -ENODEV;
> +
> +	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_TEMP_CONFIG);
> +	if (regval < 0)
> +		return -ENODEV;
> +	if (regval & ~SPD5118_TS_DISABLE)
> +		return -ENODEV;
> +
> +	strscpy(info->type, "spd5118", I2C_NAME_SIZE);
> +	return 0;
> +}

What about adding DDR5 to i2c_register_spd() and dropping this function?


--yq7qukcenpm3ibk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZaeVEACgkQFA3kzBSg
KbbgyxAAqE+ScpBLU96XG/G/fwdHnYzmRzPSIDh3hS3WrGTiKbiADyZdKDv0QzI2
ay8NiTS5Qbrhsmwym+FIlTSEGHbUeOy3tfiwHCpEb46NdWKWkVFec8KjZh03S7JW
Krkv/V5iiyGTugcrxtzLkBQUTBZQZxped1RcfbDBX9+CjGnzNHWe3CskTU0Zk9br
m1Xb6BRg+rEzpiaGdDbOecQJeGwgAj6x7TEo5r5qeFA6gqJzPekcfrNayrnMPDL0
VQSpaaL73YCZwytnSroDx2qunLhbL+6QTvzNZ/1760oe+m95V7Cc2wPXbFS5X11c
sikHnP7ZZMoKZ5ZzCceNkJdBxJqTlZTIZ3MLqtn9jZ0E5KT9yStvBdsdhE0T3t4Z
wv4hLRzPW3NgANZu2AKki4G+ync/k4vku1kr0tPeuHCQA8OiuGQG0x3MRCst+8Uo
odfRZwMtWJtuSEVBXfvD2QSxP9E1AYqRDt1lJQtD4zFaul/w78w9ng/uYgiyhzuY
SS0OcpayaeobWd/rxviy3yKO3ZHwcTlr43sxiqaiOtA2Touq50cpMCa971zFkWOp
0XrwfYbSCsUus8RDb5z7TliJA1zVhNy547ao7/uRPj+BUT1/2MCd+4bZ1j7eTami
p01vZXUSy1Tk2LedVl4012X8LGTy0olO6ingqNsMVfOkW91Lbv4=
=+2io
-----END PGP SIGNATURE-----

--yq7qukcenpm3ibk2--

