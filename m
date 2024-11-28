Return-Path: <linux-kernel+bounces-424983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE539DBC10
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3211016416D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446DC1C1F0D;
	Thu, 28 Nov 2024 18:05:25 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854E1917F1;
	Thu, 28 Nov 2024 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732817124; cv=none; b=VlphMusQZyndDaC8xNbz9cIBk58SctF7jE7DGycJ96W1Bekz71eu/0+12iE5Z2Y+9TeRKAORd4cttweiqenEMGakO4Mek96wiVDWJobz9NmeiwWwMhnYGh4iJh5DhKzq2KWOKdVOPQUGcmwZbrqtUFA5tE/cyRWBFziTlnbYmGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732817124; c=relaxed/simple;
	bh=hhgpMzS8pN9T8uIknwZ8HxuAzC9Z8YBN9l9692StdeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPUrtA3K+lsCcPS9vlVoGwCGKyjHiHNmnueLM+yHHen3bKpmtvlVe+uwWh5/g0ns9hvmWYpAchz/hk+ZUv7GkN6P5VT6FCm2GFiOri74frMWVhTeOFpq35ouc+3fLpnd6sRfZUov2qYS4zGrKtGUL9uaHOw7qXsaaxJuWlLlBEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 471521C00D9; Thu, 28 Nov 2024 19:05:21 +0100 (CET)
Date: Thu, 28 Nov 2024 19:05:20 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, uwu@icenowy.me
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/98] 6.1.117-rc1 review
Message-ID: <Z0iw4Hwltov+x89b@duo.ucw.cz>
References: <20241112101844.263449965@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oqo3nIbTnLByV64u"
Content-Disposition: inline
In-Reply-To: <20241112101844.263449965@linuxfoundation.org>


--oqo3nIbTnLByV64u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Icenowy Zheng <uwu@icenowy.me>
>     thermal/of: support thermal zones w/o trips subnode

This seems to introduce memory leak.

+++ b/drivers/thermal/thermal_of.c
@@ -238,18 +238,15 @@ static struct thermal_trip *thermal_of_trips_init(str=
uct device_node *np
, int *n
=2E..    =20
        trips =3D of_get_child_by_name(np, "trips");
-       if (!trips) {
-               pr_err("Failed to find 'trips' node\n");
-               return ERR_PTR(-EINVAL);
-       }
+       if (!trips)
+               return NULL;
=20
        count =3D of_get_child_count(trips);
-       if (!count) {
-               pr_err("No trip point defined\n");
-               ret =3D -EINVAL;
-               goto out_of_node_put;
-       }
+       if (!count)
+               return NULL;


In the !count case, we still need to do the of_node_put, AFAICT.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oqo3nIbTnLByV64u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ0iw4AAKCRAw5/Bqldv6
8u6fAKCvN8zN8FZ3yvxQNlH9T0I0ckJLXACffOWxUEAAiduhpx95v/4Kkfstzgg=
=9At1
-----END PGP SIGNATURE-----

--oqo3nIbTnLByV64u--

