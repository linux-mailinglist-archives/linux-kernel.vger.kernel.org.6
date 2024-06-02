Return-Path: <linux-kernel+bounces-198403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F918D77CF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B7A2B20DE8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 20:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDB27581F;
	Sun,  2 Jun 2024 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="QgkUH0cD"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C364757E8
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717359511; cv=none; b=NSmyUbDXL2GayGsQNwGT+235uoSq+pvSb0r7t9j07uO5dQSqDdSf8eivEy3C2qeYT953OqAkJ/31b7dZumaV0pJ1Fn7W9286ReWnfJyrkwTOqkGVLjWr9jsU2F8lGL+de3zak1FN3V47vYGEcSeMm4K6y1UWOTYNFvuQmjQuihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717359511; c=relaxed/simple;
	bh=mtPx8u7Uu9tuEappI7gmzj7YNw+G8ZFnAW4+i304kzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8wNjbTmIcD4QYmzC9aiw7kWQ9DfYQiWbePyXfVdOHSxx/+fUW5SecoOwBacPyPZSr6jrC23CLlHB8wJm9f+QOZxcZYDYFnzYYUAvTtv6hxeNN9zy9hCEsO+R/CYfX01/bSfy64z72X4vlPmKVBb4jKSrNbz4BRzzH8apXytQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=QgkUH0cD; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=mtPx
	8u7Uu9tuEappI7gmzj7YNw+G8ZFnAW4+i304kzs=; b=QgkUH0cDEtW1qKOiXyf0
	vNIKB3sII/MUl8O+PrFQkACbE3p/6T/Vd8HYkxCaQc9dhjafD5f5vpuzz5cFi1DQ
	hc/hpUF2WYkJgDTVnkgtSSsKxjOwzVY8v+SYxH3sfr284cqhXu2/JTwDyOWKPGPx
	8ZpuhO2p56kMpiHhh3erAxk18KYw2RjpM5NySuvcQuAIZr5wIQcS8CvOrsKxexo2
	GxQa8AYaG0OPhD/9qH+lWoYRKOEMNbPhrvml+vbDaqYBMCF2VUzaf2njA+bWT5ZF
	Z3zkVKHLwECBdRSpvhG1ZnLPrebugfv7fyh83qA8lXYi2i2bTEVywD8aMX23eb35
	2Q==
Received: (qmail 1741334 invoked from network); 2 Jun 2024 22:18:19 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Jun 2024 22:18:19 +0200
X-UD-Smtp-Session: l3s3148p1@wIPf6u0ZOOlehhtB
Date: Sun, 2 Jun 2024 22:18:17 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, =?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>
Subject: Re: [PATCH v3 2/4] hwmon: Add support for SPD5118 compliant
 temperature sensors
Message-ID: <baktuhx525cyrxam63z4oyy62p35s3n7n7wsv3yz6opyoprp6z@vtxlfwdejdmt>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, =?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>
References: <20240531230556.1409532-1-linux@roeck-us.net>
 <20240531230556.1409532-3-linux@roeck-us.net>
 <uvikiflwuoz3szchmvke7p3ymqvcngkydehk6cctdv24cxsh6r@7d5vxcvdca6l>
 <e5d95d3d-1ca5-43f1-8c17-d24bd38f28b7@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oxluy5kl3unneebw"
Content-Disposition: inline
In-Reply-To: <e5d95d3d-1ca5-43f1-8c17-d24bd38f28b7@roeck-us.net>


--oxluy5kl3unneebw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> would introduce a cross-subsystem dependency. Of course, that depends a bit
> on your position about such dependencies. If I do that as part of this series,
> would you Ack it, or would you want to handle that through the i2c tree ?

I would ack it. If I'd have a conflicting commit in my tree (unlikely),
I'd ask you for an immutable branch to pull into my tree.


--oxluy5kl3unneebw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZc04UACgkQFA3kzBSg
KbZinxAAqHFAFPtmwofD9up/UTGj2j9gC7X1COlNcXHK+tz5JQF+l0L5znQ9zUhz
HRWxQDpC8OdW5k372rRcY1YTs+mLFfWCteDcjlUTLcP2c/jNqKg+Yqd/FS/fawaZ
Pq+n4GZdp7LGTQG8GePfKo4UfrAFhVidepVZU5Fq2Q/faMX3OVe4H3vqpHXxWS2K
IUYTlHtBJ6nmlViakbuopRkiMPeIFaCF1/9fJs/iQewExRtv/35zfTW0fBUa9DAR
ThoTDjTqZ1SlrozOLQVszqjJl4bjdYPxaDCUOPyhwRvo/x7AuNooHBY3H3NnhwY+
hfrRp9Z7iORXjTdJxqIiG01OjMXlXLl1s5pQ44kb0lFydp+eqnR1po/trqIaOGF3
UWc6T5BDQUE04z2bwmFmN6iKx+kqCiYsmsscFUewSUxBT4n0kxxYRi3Y2BduAIWA
5g024LHEobJ335ZFjC4Q+UXE+XCtnwr1g1F/LP0OHOzt9L9KOvELixDVXekGN4Is
Qrcv11YdF1JKGjUVMRpSAV2m5tTdRbpqKaMSBljOVuLEqDsB92esbayaQksACOhG
b3Zo+sqy3OhM2OXN5hYSQfdL9gAF9NsmmDEglLKUhsY5EgGuCz/tJ5AEhaulVdU8
DPgWwfzqIlYv7lEaf/qjmVZfvuV1h+0guNItsXba+7JRbwXc7RE=
=Kthw
-----END PGP SIGNATURE-----

--oxluy5kl3unneebw--

