Return-Path: <linux-kernel+bounces-176997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A008E8C384F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA3AB21667
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 19:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA9852F9B;
	Sun, 12 May 2024 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oW8CE6Qb"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D8C282E5
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715543701; cv=none; b=a7xzIJSP4++cupI6POa6Y10kDQhGBkjdAOWowJEl32kpD2Oac+BSDdAwZTtkBzVBJU6nD3e+fhr/slv2LoVSHtzlqZu+cjjLygerIdAeNlGxrOx41pSAuyHRJXJEncCaqBedWxrYFQC4QZyFCvpAJBZxIeKQ1lOUD5XLYg1+8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715543701; c=relaxed/simple;
	bh=8mYNLdkXP+xY9KzNFU3vbMsByG1pYykBkrEy3knEQYE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=McdqIrzT6t31u25+euN8fDdAiAWYx2OMC39n+FrL3DIejxUF8ouOlfrsj+G6A1cgLS3A5DjI3BwSdAXuPckD4KJwIO88HVESPPrIy/yl2uIyEVqEM4jsV85ebdPMTYU4DLG5Cqzgg766iUaOqx9QcQlmxEwbs22Ytmg4kVpHeRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oW8CE6Qb; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240512195456euoutp02b844add76c04254c234784c1c1486ca7~O1eccGBY42518325183euoutp02R;
	Sun, 12 May 2024 19:54:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240512195456euoutp02b844add76c04254c234784c1c1486ca7~O1eccGBY42518325183euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715543696;
	bh=8mYNLdkXP+xY9KzNFU3vbMsByG1pYykBkrEy3knEQYE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=oW8CE6QbLr6/vZXpjMvmJxywXGPF4M0xDgBU6aeR4QXppipQyNKFjS1vZQh3+oyvb
	 3UZriokT9LFBegJKEzXaSSIsiKuoNPONNPyRLUkOfSNasHd51/9ZaKSLH5Lka6nfBi
	 Qck6U7qoDAD3x3Y6Op5kTGcDV7CTJjf3eGzWVc0E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240512195455eucas1p2869a7f3a26047e0e8ed83b93aa62b4ea~O1ebtVje32646626466eucas1p2-;
	Sun, 12 May 2024 19:54:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id FC.C8.09624.F8E11466; Sun, 12
	May 2024 20:54:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240512195454eucas1p15a0e27f00e0401e4b6a3ac9552a20dd7~O1eaiv1MO1610716107eucas1p16;
	Sun, 12 May 2024 19:54:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240512195454eusmtrp2f8e99fc05bfb2f3fc8e4d3462bce46a4~O1eaiRAyB0954909549eusmtrp21;
	Sun, 12 May 2024 19:54:54 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-4d-66411e8fdfa5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id CB.D2.08810.E8E11466; Sun, 12
	May 2024 20:54:54 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240512195454eusmtip10002260ca19acafb0ca3bb2283914c8f~O1eaVbwFz3157231572eusmtip1e;
	Sun, 12 May 2024 19:54:54 +0000 (GMT)
Received: from localhost (106.210.248.15) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sun, 12 May 2024 20:54:53 +0100
Date: Sun, 12 May 2024 21:54:49 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] ucounts: constify usage of
 ctl_table_header::ctl_table_arg
Message-ID: <20240512195449.mlpgs7qczwozzn5f@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="gdwgjkkhg5r2cb4i"
Content-Disposition: inline
In-Reply-To: <dbd64d52-977f-4229-9f36-82a45d65fbe7@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djP87r9co5pBn8O61n839bCbnF51xw2
	i98/njFZ3JjwlNGBxWPTqk42j8+b5Dz6u4+xe0w51M4SwBLFZZOSmpNZllqkb5fAlfGt4zdT
	wQ7eiicPr7M2MD7j7mLk5JAQMJHoevaNuYuRi0NIYAWjxKW7e9khnC+MEpf3nGGBcD4zSvSv
	/MHWxcgB1vL5iQBEfDmjxPeVk5jgit7P6IVq38Io0ds8lRmkg0VAVeLFUm+QfWwCOhLn39xh
	BrFFBGwkVn77zA5iMwuUS3yZ1cEKYgsLBEr86VnIBmLzCjhI9FycxwJhC0qcnPmEBaK+QmLX
	5rtg45kFpCWW/+MACXMCjfxzcD4jxGtKEs3HeqDsWolTW26B3Skh8INDon3FO6iEi8ShK7fZ
	IGxhiVfHt7BD2DIS/3fOh2qYzCix/98HdghnNaPEssavTBBV1hItV55AdThKvNy+hgUSRHwS
	N94KQhzKJzFp23RmiDCvREebEES1msTqe29YJjAqz0Ly2iwkr81CeA0irCdxY+oUNgxhbYll
	C18zQ9i2EuvWvWdZwMi+ilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzBFnf53/NMOxrmv
	PuodYmTiYDzEqALU/GjD6guMUix5+XmpSiK8DoX2aUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
	VVPkU4UE0hNLUrNTUwtSi2CyTBycUg1Mi47OSeu/XnGB1yKP9ZFnxV3/9QZ1ORu9vUIiGtzX
	tk6ryK1lVb/62Of7acZJE7qPn63qtjl8/fPMI/tMHeWTEnluNryfezW1eePRTMlfl5Zlyt23
	3BdWEeLr/WnSs2mSBYxvthd4/F3w5WUwO3uKqKj7ZcmNWmo/NG/nCxqX/tyaeaFa3/bX3yrJ
	HI/s/EZ1n0dsfjO+zXhuE37b8sRu3eJUrek8OzSv5F5SjqttY9n+ZMmpAwHXt7z8pnx109K6
	rdoBay+dEPGcUekTpLxAS2bqgxaXKTVT8hJNej821b0vjJtY8bNt2baI+5UMDekP77pPrFIQ
	zgme7Cr5fHKRUrVHTZKE8VkeFyGR6m9KLMUZiYZazEXFiQDsAZpczAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7p9co5pBgdPK1j839bCbnF51xw2
	i98/njFZ3JjwlNGBxWPTqk42j8+b5Dz6u4+xe0w51M4SwBKlZ1OUX1qSqpCRX1xiqxRtaGGk
	Z2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7FkQwNzwTbeihnvr7A1MD7h7mLk4JAQ
	MJH4/ESgi5GLQ0hgKaPEmxttLF2MnEBxGYmNX66yQtjCEn+udbGB2EICHxklGveoQzRsYZQ4
	M3U3K8ggFgFViRdLvUFq2AR0JM6/ucMMYosI2Eis/PaZHcRmFiiX+DKrA2ymsECgxJ+ehWAz
	eQUcJHouzmOBmHmbUeJZxxNGiISgxMmZT1ggmssk5n7uZgHZxSwgLbH8HwdImBNo/p+D8xkh
	7lSSaD7WA2XXSnz++4xxAqPwLCSTZiGZNAthEkRYR2Ln1jtsGMLaEssWvmaGsG0l1q17z7KA
	kX0Vo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYJRuO/Zz8w7Gea8+6h1iZOJgPMSoAtT5aMPq
	C4xSLHn5ealKIrwOhfZpQrwpiZVVqUX58UWlOanFhxhNgYE4kVlKNDkfmD7ySuINzQxMDU3M
	LA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYdG5FuC2+uzL96yK9nEdu+2+U16Ve
	8DWaGb+Fte2S3lFGcamnKXdT9HtlTp05t0dz0fRfC6Nz7O/Gn0+UfzYh+4dyrdUdqajtkeq7
	aqSma5dolsx111mb/EPk6dMq7uVep1gVeQvmnrrjynyWf+OKx5e9nn/oS3+QOyPdq/r0a0cp
	5pq9trf+3eAIFe/bWDDN0GL99x2PQz7q73m652hkq025wLu41Jvq+qI+x696PVp7WS36v/p5
	wfKvxQFO946fyv7rd0hByz/71oLYwp22/jt05ill7FIxyPknMV9S/P7m89EWG1hqgnf51j7Z
	WWu2SSVbYZXKr27hK2zrXmzoeVjT/P1jwTvbW2/WnLHnUmIpzkg01GIuKk4EAGBtgnVnAwAA
X-CMS-MailID: 20240512195454eucas1p15a0e27f00e0401e4b6a3ac9552a20dd7
X-Msg-Generator: CA
X-RootMTR: 20240512072222eucas1p1019ce6f79a10f5e85cd4ead5bba3dbbb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240512072222eucas1p1019ce6f79a10f5e85cd4ead5bba3dbbb
References: <20240511-sysctl-const-table-arg-ucount-v1-1-a00ad8f6f233@weissschuh.net>
	<CGME20240512072222eucas1p1019ce6f79a10f5e85cd4ead5bba3dbbb@eucas1p1.samsung.com>
	<dbd64d52-977f-4229-9f36-82a45d65fbe7@t-8ch.de>

--gdwgjkkhg5r2cb4i
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024 at 09:22:13AM +0200, Thomas Wei=DFschuh wrote:
> On 2024-05-11 21:28:10+0000, Thomas Wei=DFschuh wrote:
> > The sysctl core is preparing to only expose instances of
> > struct ctl_table as "const".
> > This will also affect the member
> > ctl_table_header::ctl_table_arg.
> >=20
> > Prepare for that change to "struct ctl_table_header",
> > and already constify the usage of ctl_table_arg.
>=20
> Please disregard this patch.
> Apparently Dave already picked it up as part of [0] through the
> net-next tree, which makes sense the ctl_table_arg changes are in net/
> for the largest part.
>=20
> See commit bfa858f220ab ("sysctl: treewide: constify ctl_table_header::ct=
l_table_arg").
Nice. Thx for pointing this out.

Best

--=20

Joel Granados

--gdwgjkkhg5r2cb4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmZBHokACgkQupfNUreW
QU9aGgv8DCIY6beH0BGy5wn0+1Bdo6584SPM89B02yf2iskoBzlDX/Sf3wxPoduE
jE4UOtWCNkd5ecaVYxe/bQ9giLn4JquXYCPcaX+r78rTTvTU+Y8n2PXBI0esTnhp
VDDRVy7mbezDa8fAaCQfBUG/c6/rKL8+QdmxSUzx7Q5tyglAF+DbZzTYbSh++0G7
Wp4FFSQ04UCNG+gnoNK72r0qKuz74jNAgiGsLSK7udTk5radRmjeHGXefJd2iUpo
bP54hv4ekY/6u5DlFOUswbA5kRIds5PqaOHhfZ+9gWuiEYokL94xESrXvH+HOOT4
g89gLx5OLjU8qM9/92/nmyuITTfoSow6ENsrDIGodFRMIe91/c+fHsXROl7oSJtZ
5j6LOi5MwU/ueUTDrwu4DdOHpBudS8aA1jCcYy0JJZ4Ab2UyD/Y+ZV5O3VPNpc7A
tJJbdib9VLAn6yDGt3p1tc7f2LC8IViAltLtqALs9X5qWEiJpquxoNrS/iMyQLsU
JyyC1+cJ
=p7Fi
-----END PGP SIGNATURE-----

--gdwgjkkhg5r2cb4i--

