Return-Path: <linux-kernel+bounces-262639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA5093C9E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359E71F2163D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ABA13CA93;
	Thu, 25 Jul 2024 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="YoS96BZu"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B7139D19
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940672; cv=none; b=ZjQUPXGVaN6vlfj3SyoNK3cLUSIIFxWrZo/6D/+9qOQdVlQpscQEvXDB8OT9f1QTQuSX2EYmsx6qOMHBPPueapC1Tm8m7qfr+urG6ynUa2yOy67dYBCPKj7eQleDTYJo376JSXMe6/GRTqiob2/fi3ptrqfKEUqOHJ33397w2ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940672; c=relaxed/simple;
	bh=pHvSN8DoBfbkuxC6vxuPFVFOp9Dj94m2Vvcua1tVfBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNQ4IGwGjh3JDzw46+LEmtfR7Zd+bfLyz51gVSWApNusPDEbn8bxDe3mw89lkU2WhKJu/mKX7RRobfb3ufRwt5LWbf9i3+cSxRqwiBPfROTr5TZZGqTDgH4EC02wNRjeQiDvI4pYJV5JiRNydtvpZvKlVyB43OnWwP6xOrzSdnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=YoS96BZu; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=pHvS
	N8DoBfbkuxC6vxuPFVFOp9Dj94m2Vvcua1tVfBo=; b=YoS96BZusVdBpdOS9a4s
	Kt+TcGhFaW7rGgn5huDGGC4+i5rBHJYc8wWckAdSy2k8s9tI3tKv4yI+GGJSFAI7
	3vDOz3KH0B90Rdnrsyw9lfwb420/ej8JCRoeVdE2WtwNwxwOY2Pqv4o1slrqOt61
	jbw8MqmYGeRLzbMWqPbwZGmOdsbgBOURDKZNzEh8q7Zg1NR1dD7WHdO/evCM4oWs
	pTn39iEOsT4L7FQJYln/SEidZ3Czj7aOBxALsNctNn+semya5xipzu+8xFDBa1yv
	d8DHwgYxDU0/BsAhefjWVBugemd/mKwU9wa9khmJGSU/R5SKouGqnWHSt0iQp42x
	tA==
Received: (qmail 3099906 invoked from network); 25 Jul 2024 22:51:04 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Jul 2024 22:51:04 +0200
X-UD-Smtp-Session: l3s3148p1@X+aijRgeQO4ujnsv
Date: Thu, 25 Jul 2024 22:51:04 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Wolfram Sang <wsa@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: ds2482: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-ID: <ZqK6uI6zsZVyqWVl@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
References: <20240725160909.326143-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E1WFM6FE3ISvlKSb"
Content-Disposition: inline
In-Reply-To: <20240725160909.326143-2-u.kleine-koenig@baylibre.com>


--E1WFM6FE3ISvlKSb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 06:09:07PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> This driver doesn't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
>=20
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--E1WFM6FE3ISvlKSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmaiurgACgkQFA3kzBSg
KbaczQ/8DCjArzaBvniIDmo+9u1kBPLexon01UOYebCkrFhLjOO7TuBsaJoDgPh1
yzsFLssjzwjY060RR9mjhaEA6eRmLlYJryRbnMkRRYg2kOebeeHNQ8BW/YuP5kWb
Q62QqzKv465YnKKx8CGiliNMlfkVMAY+QXCaEphlz1ISuin+WweLIr6pD0npQwN/
SjVaf2c0MfrAClx3DREFFGyrdko1S6A4DCO59ohTL1ZOmNZeVzx+W69M9QrawFgB
haTFK6YS0uA+cGLgxUME4oprwavkPJv3Kqsm9D2fxzDY1meoEHgeF1FIDbJxYIsl
+Ao87T+DMvjtjhZhKz81SzB+FFxjW/JKC7zMxECv2yYBhYRJDQVKBBK1zpYnNgSm
dnND53vBkAmauGuQeMIzC5smkg2KPFtXxL9pO4Ha0IH9mXLFTV+p8skEu7i5V9PN
O9fc5k3HtSIit3ovPT3zpru/2SFW3FWVmVtvQMpQ/MFvuw8dHQoZ/3WqiNK4Ig6P
8WkejVOc3foCo0Z9Lq4BBgmy4chFCrZev7fjLl/Vsk+LFRwIqIeAshGblWkGxihF
+ldTYkoD3d96isDhQsEt18ASGC1smvzRwqKJUI7sdqrfUBBetavDmPNImEMoABz4
9mQh+dkbjS5UvY/nVpkNAsMVpaWGLJIsEJCS8OnHgd1BbPEajRY=
=S7of
-----END PGP SIGNATURE-----

--E1WFM6FE3ISvlKSb--

