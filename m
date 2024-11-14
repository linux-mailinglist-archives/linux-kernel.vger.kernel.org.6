Return-Path: <linux-kernel+bounces-409885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8FC9C92E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16721B2B17A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457DF1A9B3A;
	Thu, 14 Nov 2024 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="rue3X+pQ"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB91AB531
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614681; cv=none; b=nJ8/n1LYUsTV39uwVYJy8pzRXeP0BOKdSzx61CahEr/M+GXvkV6wA5saJb/X1xoBwj+aXhIABW93SVySKNRjxvBbKmZtEnW8HSQJqNUWAh8YqN03zQkrlEE1Ku4j2XEwEXKGrmmZkzwzz3OgY7ykfuucQgEa7JF8axsfgK76x0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614681; c=relaxed/simple;
	bh=ZLyeiex3XlgRmZz6XBUiIoGd2AQynxz/NXy1B9x32l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdEMDtKwODF2n+b2wS3sqOQ5tzegrL1LSZo7NrUDT9xb0kHG3RH+m0eRF42NKfwwGjOrMxV3e3dPg3pLMYOeOv/93Kn9Zfep2WwQ19F767mVAM1YXX9Ki8X2n6ctN80pSlSIL+fnpSoJhhrxd/3XeygQUOmyaO9mPYjzlHLeD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=rue3X+pQ; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id B5DC36159C23;
	Thu, 14 Nov 2024 21:04:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1731614675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nczuuQn4zwyaCr23BO1zixTYdoxGSf2bXN4HXwIwYyE=;
	b=rue3X+pQeaxTjJgJRBZPzy9fKUO+uMTO0Q4HBbs8/tgiWnLKpEpmTpRsw9K0dZdpJF7gj1
	NgbmOSMEBxY2d4ALwyqtsYV+491rFqN1ebhk9Bpyk7CbxTu0KLIeZjgS0Ny43VVcTlX0/K
	oMGM57KWYWO6tBTc73kVfTWE92YyQKo=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Wladislav Wiebe <wladislav.kw@gmail.com>, motiejus@jakstys.lt,
 vishal.moola@gmail.com
Subject: Re: [PATCH] tools/mm: fix show_page() build error
Date: Thu, 14 Nov 2024 21:03:57 +0100
Message-ID: <2754934.mvXUDI8C0e@natalenko.name>
In-Reply-To: <20241114190204.1486-1-sj@kernel.org>
References: <20241114190204.1486-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12549902.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart12549902.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/mm: fix show_page() build error
Date: Thu, 14 Nov 2024 21:03:57 +0100
Message-ID: <2754934.mvXUDI8C0e@natalenko.name>
In-Reply-To: <20241114190204.1486-1-sj@kernel.org>
References: <20241114190204.1486-1-sj@kernel.org>
MIME-Version: 1.0

Hello.

On =C4=8Dtvrtek 14. listopadu 2024 20:02:04, st=C5=99edoevropsk=C3=BD stand=
ardn=C3=AD =C4=8Das SeongJae Park wrote:
> On Thu, 14 Nov 2024 11:01:40 +0100 Oleksandr Natalenko <oleksandr@natalen=
ko.name> wrote:
>=20
> > At one point I needed mm tools for debugging but couldn't compile them =
due to the
> > following error:
> >=20
> > gcc -Wall -Wextra -I../lib/ -pthread -o page-types page-types.c ../lib/=
api/libapi.a -pthread
> > page-types.c: In function \u2018show_page\u2019:
> > page-types.c:423:49: error: expected \u2018;\u2019 before \u2018if\u2019
> >   423 |                 printf("@%" PRIu64 "\t", cgroup)
> >       |                                                 ^
> >       |                                                 ;
> >   424 |         if (opt_list_mapcnt)
> >       |         ~~
> > page-types.c:416:65: warning: unused parameter \u2018mapcnt\u2019 [-Wun=
used-parameter]
> >   416 |                       uint64_t flags, uint64_t cgroup, uint64_t=
 mapcnt)
> >       |                                                        ~~~~~~~~=
~^~~~~~
> > make: *** [Makefile:23: page-types] Error 1
> >=20
> > Trailing ; was forgotten, so add it.
> >=20
> > Fixes: ece5897e5a10 ("tools/mm: -Werror fixes in page-types/slabinfo")
> > Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > ---
> >  tools/mm/page-types.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
> > index 6eb17cc1a06c5..bcac7ebfb51fd 100644
> > --- a/tools/mm/page-types.c
> > +++ b/tools/mm/page-types.c
> > @@ -420,7 +420,7 @@ static void show_page(unsigned long voffset, unsign=
ed long offset,
> >  	if (opt_file)
> >  		printf("%lx\t", voffset);
> >  	if (opt_list_cgroup)
> > -		printf("@%" PRIu64 "\t", cgroup)
> > +		printf("@%" PRIu64 "\t", cgroup);
> >  	if (opt_list_mapcnt)
> >  		printf("%" PRIu64 "\t", mapcnt);
> > =20
>=20
> Just FYI, a very similar patch has posted a few days ago:
> https://lore.kernel.org/20241112171655.1662670-1-motiejus@jakstys.lt

OK, if the other one is taken, consider adding my Acked-by: then.

Thank you.

=2D-=20
Oleksandr Natalenko, MSE
--nextPart12549902.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmc2V60ACgkQil/iNcg8
M0tyMRAAx/f9+m0I2GFJTL7oHbbD6MW4YSQoFj4/YkaOLppR8+n1wtKXnwhRwyWT
NC0ckOg6v964BV47B4gQdA7O3T1IeTK2zS+tqTVMTzzkZLcg4niUrIhVJ/vgBlor
3SHZA1xIxPoERvWb2BqvefZwfllCab+WHtBW4ypU2mEM0a3XCHMxh/MyT7r4wE3X
tW2ejGc9XsrKGtI71f0GXuE1kGwxM7DUcAG/W7hWbbgjER+JWJehylx+NPfCBkiE
O5rozTzKGEwyAsBKgxnTymcynviffSf2+MzzYFXQ8HnRnSyvVRJAZr65j8GzD0Eh
Avg7w/8M/mr3Sko7oBvS+NzmvCNMqWiVoySPOjEKJd3r6vVcD4YirnIc32zm9DRu
IY+doPwVzoL3hpIAHPrkdIotF2zt5cLTMIIVZh0qoA/akmogRdLZT5I79ITL+i+N
kwhFbW0dzUyyTgksPgvKg1iYkTiY2ptwpme83/ZbK67wBUnCxk0GKYIFIZK/oVIB
5CGv0eSAe8aU62p2m2hndnriYMwWBx2yo4r6X+3d4V1ooweXTUDO/bPlWWYg+kXC
0bIBa5LJuvlZY1rJj3mullPc4Iq2bJpzyl4yBIv3tUfb5jvWBa8lgl0th7nQFOEB
zsReBUuKvJmCshSCqroANdmxssMbIxeNgQAXTpNAAF1JoBh+gRw=
=uieD
-----END PGP SIGNATURE-----

--nextPart12549902.O9o76ZdvQC--




