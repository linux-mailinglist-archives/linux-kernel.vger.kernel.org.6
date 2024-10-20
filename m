Return-Path: <linux-kernel+bounces-373460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8660C9A56EA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 23:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343561F219AA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AF6198A06;
	Sun, 20 Oct 2024 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="T+0uMew2"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50B03A1CD;
	Sun, 20 Oct 2024 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729458448; cv=none; b=h2NiW71K88k4MOYhtwtEhgYql8YSKwuSc1FkaUoStH97n9JubmTaW60fdZhndSuN1ZAiRtKPsiYcSl9Gy+ZzWJoIlZ7GWieZrQVyx6B9OKGi/og9EvE0He0XRF8gr+OXa1RPJC/eZJ7qhNCRp8qXpTP/QFvuAHQkwUZ6AwQieYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729458448; c=relaxed/simple;
	bh=Rak7smfvFZuG8pTd0YZjqSm5UlWH6+ZVw84ynDVgDzo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9FNuks3rf7UC45vmLZYUU3wGQ6myoBtePyu14nvZb+ifGXkKl7ze6z+lsOhT2JYsNmLhyuF2ZXzSRXaGsFfVSD9BulZjzGaEN2HJdzcc+3IsRrtaXJB5WqIK7DL89RCY3xf9R2MusydR53tUKr/d2X1Ho/Wz52GjG4kKwX6024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=T+0uMew2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1729458442;
	bh=Rak7smfvFZuG8pTd0YZjqSm5UlWH6+ZVw84ynDVgDzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T+0uMew2wk18XSjSEMsTPLezcns9EdbyvEsZb/SqP3tcAqh9H0MKCMVc8mIXf6Te0
	 yjZzw7knnHsVBcBFMHEk5RIp5QHZf/Pmzi4tjA59tmYQTMYfMxwXhwbUu6HUMqjYMQ
	 y8G+giSpyiQV3DdfSJhWIcoH00nFW6Q1eJNm01MhTH13/lWP9TN3jeRNElK1fP05Ks
	 ZQ7V1qTJLf/OY/RMRSKczwt4dXDMgB3r/VKYdC1Er71hIal2QZm+2KlGHuM0aSX5nI
	 o89BajhgGy8onpLm4+ZS8CyD8b5YiGRiW+ZrdifRhqVk2kjd0vg9myaNCzz+o/Cogo
	 0c2mjLco4hODg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XWrcB1m6bz4wbv;
	Mon, 21 Oct 2024 08:07:22 +1100 (AEDT)
Date: Mon, 21 Oct 2024 08:07:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: error trying to fetch the bcachefs tree
Message-ID: <20241021080722.2aa7db61@canb.auug.org.au>
In-Reply-To: <pmdkqd63ywjl4ktdjg24v6pjslepes7fmmu4llpqzeueeeos2b@vldhjmmcqfil>
References: <20241021073823.1a89e1fa@canb.auug.org.au>
	<pmdkqd63ywjl4ktdjg24v6pjslepes7fmmu4llpqzeueeeos2b@vldhjmmcqfil>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1tUTJ3QBz3+CxJZJd_1islX";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/1tUTJ3QBz3+CxJZJd_1islX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kent,

On Sun, 20 Oct 2024 16:40:32 -0400 Kent Overstreet <kent.overstreet@linux.d=
ev> wrote:
>
> On Mon, Oct 21, 2024 at 07:38:23AM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Fetching the bcachefs tree produces this error:
> >=20
> > fatal: unable to connect to evilpiepirate.org:
> > evilpiepirate.org[0: 5.161.236.196]: errno=3DNo route to host
> >=20
> > This also applies to the header_cleanup tree. =20
>=20
> It should be back up in a day or so, for now I have a github mirror:
> https://github.com/koverstreet/bcachefs/ for-next

OK, thanks, I will use that for now.

--=20
Cheers,
Stephen Rothwell

--Sig_/1tUTJ3QBz3+CxJZJd_1islX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcVcQoACgkQAVBC80lX
0GxieggApkYTGmPr7awKvt6KRyosmr6f2vHMSwwR8H6+F/XbaeXYKM86/qySfeM5
nfejmtdXuCoKiwuvC425nM2l48MSAZxsZRwHGNszSV+A6kdjh+ftwqnPan5u4QcU
zM14ofKxD7exvCf4kIPTiSPSbNpp4kLq0+3BUo7jLjQ6BiHNvail0Nfg4YTgYdLR
9RBFT8WeQGTrgMSrtM4ilqOvH8wH+ha5LFc0Oadq0x1JZ+n3DPRnHfnqDy7q+DR/
5w4t2XCG2gqdbCncQL+RzZ+7I+Daoye/qL520ZCwYmct6tMTSTb3cGDGiN+4DUIw
/ME9sfeTGs8IjCq5JO1eRoyIV7Oegw==
=f8aU
-----END PGP SIGNATURE-----

--Sig_/1tUTJ3QBz3+CxJZJd_1islX--

