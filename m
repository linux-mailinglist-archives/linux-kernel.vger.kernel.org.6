Return-Path: <linux-kernel+bounces-187178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BFA8CCE23
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060A81C21001
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17FF13CAA4;
	Thu, 23 May 2024 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ld1Fb+GU"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A713BAFE
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452622; cv=none; b=Fem+kM5ejA5jH8906WBORo31NrfQhDpaFXTv5z64buGrTu6FopKg3IZ/bO1MiFS62Ri9jWIN+35iMvhsa4mW2CFWP6CZ3cn3u0CLQeo87BcnbWqqyxKAogYZrn7S3BiirvSMMe2LjlmHGA2LTYHoVZ5h1AcusqvHcsQddHxyHkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452622; c=relaxed/simple;
	bh=s7NnonYSEK8azZFYRNIzO/IHTSaAiATEGhFpXCA3G18=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=oxJV8ZFeWfM76CeuvGV0YfpHAC0dlpJtJ1bjS98JC7WBzj9+MgXbEN09yQ33KM3Aasp3ynlTANnj5ROsJ7RlSOkQWVILF8X/XdrHhVZAbZe0Dy8Hy+FzuhcCt60GB1S6YQa1k76tGGJ5ch8rIqM5tXT4RBa0QkBwBR9zxPi98+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ld1Fb+GU; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240523082332euoutp018e094be922bef814298c778550f676f4~SEI56D0N00828708287euoutp01t;
	Thu, 23 May 2024 08:23:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240523082332euoutp018e094be922bef814298c778550f676f4~SEI56D0N00828708287euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716452612;
	bh=wmRA8FCUUHJPkjSMcV+AKXEmyaqUd9m1Ixa8m8TH95A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Ld1Fb+GUS4jKIvbjV8sXw1H3XatC14xWhzplUlxdxdb1ZnUyk1rOTJoHTevSZ037O
	 toxXBzo01coYxOwrkEr4UfIgNSCgmKR7Cws8Cx2UDDbdpcGwg92b6HL2H6oSwLLgAr
	 ImcWBfdtrB19vBo2NozbSAa7Fm9i6gt+LeBJI1kY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240523082331eucas1p2ac7c4c8486e2d3b3daf6dd3bdae4e437~SEI5xvru73021930219eucas1p2G;
	Thu, 23 May 2024 08:23:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 2E.74.09875.30DFE466; Thu, 23
	May 2024 09:23:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240523082331eucas1p1adbc5371f1c1c1036e47fb71640f70c0~SEI5dWsUy0093200932eucas1p1r;
	Thu, 23 May 2024 08:23:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240523082331eusmtrp2f2a9d8ce6dd86adf6c94acec0c379dc1~SEI5cxtJe2491724917eusmtrp2M;
	Thu, 23 May 2024 08:23:31 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-36-664efd034b4b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 6D.B9.09010.30DFE466; Thu, 23
	May 2024 09:23:31 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240523082331eusmtip18612fa4f8a5abdc09e2719c678ba6f30~SEI5PkF7s0952609526eusmtip14;
	Thu, 23 May 2024 08:23:31 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 23 May 2024 09:23:30 +0100
Date: Thu, 23 May 2024 10:19:08 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] utsname: constify ctl_table arguments of utility
 function
Message-ID: <20240523081908.6wdecuconwmmid7d@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="j5fiwfzozgqe2gv3"
Content-Disposition: inline
In-Reply-To: <20240518-sysctl-const-handler-utsname-v1-1-27a6c8813620@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7rMf/3SDNbvMre4vGsOm8XvH8+Y
	LG5MeMrowOyxaVUnm8fnTXIe/d3H2AOYo7hsUlJzMstSi/TtErgyrp1cwl7QIljxua+TsYHx
	FV8XIweHhICJxLPFaV2MXBxCAisYJSb9vsYO4XxhlNgx4Q4LhPOZUeLW1XagDCdYx86zbawQ
	ieWMEpsu/mWCq2o/OguqZTOjxKG/3WAtLAKqEm2tFxhBbDYBHYnzb+4wg9giAjYSK799Bqth
	FvCQOHdsGliNsECAxN9nn9hAbF4BB4kPrX+gbEGJkzOfsIAczixQITHvRQmEKS2x/B8HSAWn
	QKhE17zlrBCHKkp8XXyPBcKulTi15RbYnRICLzgkHnU9gCpykXhw9RYzhC0s8er4FqgvZST+
	75wP1TCZUWL/vw/sEM5qRolljV+ZIKqsJVquPIHqcJQ4t2AOGyRU+SRuvBWE+ItPYtK26cwQ
	YV6JjjYhiGo1idX33rBMYFSeheSzWQifzUL4bBbYHD2JG1OnsGEIa0ssW/iaGcK2lVi37j3L
	Akb2VYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIHJ6PS/4192MC5/9VHvECMTB+MhRhWg
	5kcbVl9glGLJy89LVRLhjV7pmybEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7
	NbUgtQgmy8TBKdXAxN/nZV6rZP1fUWz3pqX2CRfNj8W07hEX2H6vy3rPHIPEw4x5JU7rdE+I
	lPSa3P416YuEoX/pFbVn82admKEhuECXl2P9weIZNhvK+xNLTeT2b9kQtehcAkvmJ4HV/xPc
	SxYWLf9UECdwZ1NZXWxR571XTisnSTz23BNvvWL5K94pL+7YbOljbGucVZ4W1331/o8l75mT
	mjesWaW97HPdw1MZrVw9r97eW8F6p3uNw/JiPkcl9wvndqR0T9rLdC2vvO3LtydTNXQt9R7s
	Kjh4QytkcsTvv0zvf1wpK+u8/jfG2m5naVCVx6clrstKC85vFS2fbd26VTd76fzgh0uefZk3
	UXD96bfJziEyju7+X5VYijMSDbWYi4oTAXiMYh3BAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7rMf/3SDLbukrO4vGsOm8XvH8+Y
	LG5MeMrowOyxaVUnm8fnTXIe/d3H2AOYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
	zWOtjEyV9O1sUlJzMstSi/TtEvQy7q1/wVrQJFgxs/keYwPjC74uRk4OCQETiZ1n21i7GLk4
	hASWMko03jvOBJGQkdj45SorhC0s8edaFxtE0UdGiWW3/oAVCQlsZpQ4PkUYxGYRUJVoa73A
	CGKzCehInH9zhxnEFhGwkVj57TM7iM0s4CFx7tg0sBphAT+JOwfXgc3hFXCQ+ND6B2rBCkaJ
	NQ3z2CASghInZz5hgWgukzj0/wDQUA4gW1pi+T8OkDCnQKhE17zlUIcqSnxdfI8Fwq6V+Pz3
	GeMERuFZSCbNQjJpFsIkiLCOxM6td9gwhLUlli18zQxh20qsW/eeZQEj+ypGkdTS4tz03GIj
	veLE3OLSvHS95PzcTYzAqNx27OeWHYwrX33UO8TIxMF4iFEFqPPRhtUXGKVY8vLzUpVEeKNX
	+qYJ8aYkVlalFuXHF5XmpBYfYjQFhuJEZinR5HxgusgriTc0MzA1NDGzNDC1NDNWEuf1LOhI
	FBJITyxJzU5NLUgtgulj4uCUamBqebwwXUf6Q7TBsze5oXfULx5+cO1p+94UucMJCSrXjloG
	Cz3mqF6+Oz4uWHal8FefV/fcg4MSxL/MeNJ7jm2FQOkGibmFPPp348/8VCgKTjEW/L5LU8Hh
	kGXv5he+i4/IaSkVqmkz+5tHSc1fosptt453ToRfwAbljuLPs3ZfuWP1YGJC/PsJ/N3OApue
	39XatdVjGmeankxr59Tk5t0bdGtaIrNKF+7KzihxbZXnsj37gkf6djnjtMkvFrKe3nLNqDJH
	LVbei2nHrWuzK1pnCJeUnj596oDpc715mVf0/xltX6awfKeDhdTWnztcDnu3rMrNs+pdqDmt
	4EFIs/EGnajdzP/3i3rsCzvokKbEUpyRaKjFXFScCAD97E2hXwMAAA==
X-CMS-MailID: 20240523082331eucas1p1adbc5371f1c1c1036e47fb71640f70c0
X-Msg-Generator: CA
X-RootMTR: 20240518135357eucas1p224f3a8d62089be73990a9bcb7049490f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240518135357eucas1p224f3a8d62089be73990a9bcb7049490f
References: <CGME20240518135357eucas1p224f3a8d62089be73990a9bcb7049490f@eucas1p2.samsung.com>
	<20240518-sysctl-const-handler-utsname-v1-1-27a6c8813620@weissschuh.net>

--j5fiwfzozgqe2gv3
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 03:53:40PM +0200, Thomas Wei=DFschuh wrote:
> The sysctl core is preparing to only expose instances of
=2E..
>=20
> Cc: Joel Granados <j.granados@samsung.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  kernel/utsname_sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/utsname_sysctl.c b/kernel/utsname_sysctl.c
> index 76a772072557..04e4513f2985 100644
> --- a/kernel/utsname_sysctl.c
> +++ b/kernel/utsname_sysctl.c
> @@ -15,7 +15,7 @@
> =20
>  #ifdef CONFIG_PROC_SYSCTL
> =20
> -static void *get_uts(struct ctl_table *table)
> +static void *get_uts(const struct ctl_table *table)
>  {
>  	char *which =3D table->data;
>  	struct uts_namespace *uts_ns;
>=20
> ---
> base-commit: 4b377b4868ef17b040065bd468668c707d2477a5
> change-id: 20240518-sysctl-const-handler-utsname-3f3eec4e6dc3
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

LGTM.

I'll bring this in through the sysctl tree for the next release; unless
folks want it to go in another way. For now it will go to sysctl-testing
waiting for the merge window to be closed.

Reviewed-by: Joel Granados <j.granados@samsung.com>

--=20

Joel Granados

--j5fiwfzozgqe2gv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmZO+/wACgkQupfNUreW
QU/IDAv9GCGkcQ1lGLjdp5BSIGjz+23xzPHa03OW1YBhxLlSFSIqvwFHFGNVrToJ
Tm77JWdXmguUJOx7FZeHMdfj4IECA6wuhTotS1BuozkeaUmsWE61X5Gjtw9TmNkq
NAzQnc6Ct8VQ1925zNmuNckt9s9j4VbmBcpE5SHhj52kg/AQWkY9kIJDKZzz+DwC
ZgpurgRuedRhuUJ/+CJiP0IiOR8+PsBpgDBFNbpEOi8wOj46PObck6SaBglbmnv/
J7LeWk5GUJZmMu4OKEdTF5dQpv06ZyPulBhamI8/HzkfnEQ4CLzE5eWzuCHchdNf
oRCAubwQ2046nw7yvJopYTcVp7day2BMFntjbEwCwARgbRof79TUPtwY+gOat+VX
VjDGkT71/rnTqfvhJdwezOk4xMnvl8jC2HTB2glC0gwTxx99NYS/ZzflMnrlpmHG
hcq7276DlT09uD6VTppAeIT479W01W0rb0AyR53WDUrrgRMV4zwdQx8Xrp0rUGhC
2ocx4Si5
=RgYT
-----END PGP SIGNATURE-----

--j5fiwfzozgqe2gv3--

