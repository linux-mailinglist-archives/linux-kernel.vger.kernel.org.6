Return-Path: <linux-kernel+bounces-412388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787D19D085B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDEAEB21268
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF567F460;
	Mon, 18 Nov 2024 04:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kQFgBWdI"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37F581745
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 04:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731903258; cv=none; b=k81InxhQtd3to2qXYZKZhR0p+x2ahgvaN5Pbs2JMmmwscp//cBPOb9Zz6PztPWMQdn4yJBYd5g47ST5ULCW2MdBO9re1hOJK/XTE/EvGRpB1c6EedsHPgPHDqYbIKmq2DFp1SDo5ILP0kGxpWmsBENEGmJT1b2Xli9VeN0UZiTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731903258; c=relaxed/simple;
	bh=d+tL0KwV1n4w0y+aQKArnpxFMg/v7LoAmZuEToUallo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acMJfMA1+yVI95/kwgMCw/xoS426hnpxYNcIGvsUyk5IfenWBazDBboQ/QOghQ7t0sy3g45AvMdmhfXLAiLmvIlIHcJR8rMQBAIQZtRs3pKW81peWv/4WKs8ri5jaq1nCbjhXE7pM+nXwBXKm4P7ZYMkxWUlZFb2PIwJZ692Dyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=kQFgBWdI; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1731903248;
	bh=d+tL0KwV1n4w0y+aQKArnpxFMg/v7LoAmZuEToUallo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kQFgBWdIqDRyMo+1efplIwL+XPWvPLsSMJUskwRSFsn7XB6tvPglNWk8A46ENsYcQ
	 ZcjPk+psEpvifed84X8FNvag5RwoJFPJyRd4+Jiuwj+AOgY6cP6bDqNd2CMHdMFYcY
	 Wz0uv5RBMl7KRPtQo2YHMBvh+5whTZtVqfSGN2vy29P/HIXncpH7F/DUV9O8aFHOKG
	 vMzO+cy2o8o4mYi65130aPI+2+Q8mKnoo2kg3W3XYzZ5NYcpj0TB2Ozp/ylYpsI6g8
	 5Zrn1sxQB2+E0aqLCblAsayTaZzp442QlTV9n7OLl0B9MjTdfe9DzsRlbsabNnFkAA
	 T8/445ZmTlAjg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XsDlg5t2mz4x8m;
	Mon, 18 Nov 2024 15:14:07 +1100 (AEDT)
Date: Mon, 18 Nov 2024 15:14:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
 Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Subject: Re: [GIT PULL] random number generator updates for 6.13-rc1
Message-ID: <20241118151409.2a6a2333@canb.auug.org.au>
In-Reply-To: <20241118020939.641511-1-Jason@zx2c4.com>
References: <20241118020939.641511-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pLR6yKQ2jdQD0mFZy7=ShCJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/pLR6yKQ2jdQD0mFZy7=ShCJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 18 Nov 2024 03:09:39 +0100 "Jason A. Donenfeld" <Jason@zx2c4.com> w=
rote:
>
> This pull request contains a single series from Uros to replace uses of
> #include <linux/random.h> with prandom.h or other more specific headers, =
as
> needed, in order to avoid a circular header issue. Uros' goal is to be ab=
le to
> use percpu.h from prandom.h, which will then allow him to define __percpu=
 in
> percpu.h rather than in compiler_types.h.
>=20
> This has been sitting in next for most of the 6.12 cycle.

One conflict against the DRM tree.

https://lore.kernel.org/lkml/20241010153855.588ec772@canb.auug.org.au/

--=20
Cheers,
Stephen Rothwell

--Sig_/pLR6yKQ2jdQD0mFZy7=ShCJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmc6vxEACgkQAVBC80lX
0GzyyAf/RtTTTtMAfPx2mqkl5u6fGrAriuFttFWVZm7bwFQEqbU3PfDS75WjZaZ/
5J/gtguRN+A6YxH/8mf6DP0XvW51l60R5go4TEwfWcAoB1KRRM2mF8NS34vtZ4eN
/mP+tS4CcVYiHRZJTorRDQn4fwE30sWr7wJl4ftBseNEAptGfo62aa/qjl8mNN8B
JuoUXqaL95dFw+jK//fZClIalnS+SkWi+zDPzNvvW6Da4Nhzsh6FtNDOEp+m0bb2
7+KyTvrsJ2R2uMpK9ufEykp6L0Nb/+IQt3g6z37Q52ww0OaWq7IzCvfYqwW+xmiX
SVs4jqgi2zmcvaDgNevsHHiRE9SG7g==
=uEIf
-----END PGP SIGNATURE-----

--Sig_/pLR6yKQ2jdQD0mFZy7=ShCJ--

