Return-Path: <linux-kernel+bounces-247548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD0992D10D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D22C4B26863
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEB019049D;
	Wed, 10 Jul 2024 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="pgEcWP6x"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8181CA87
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612439; cv=none; b=X7pL6EjJgsK2wMUc5moDdmWN4LPaiPHBR/aHPyJToovN2oXfzPRxxDTsY2oQ+1oBKAbGlPGiTK3qwzsTLb17CbHJ0J16pPTTInlWeLV1j0SO6226/M3aU0A9NOEUFaXD9Zu0HzF1bPCTNrZFhoVftrTpG2wtPaMi/9DJSbMQe6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612439; c=relaxed/simple;
	bh=KmaLpqqToEIljRwq7bzbX484nSPogoykSuJuRRKRT5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZnbdeDyisF1uIfTdlZo3PH+EjzoIixW7FNzt2LWEhIYved51Fxp8YV5z3NLGaevqNZghXdbOTUMGnw3Tqc0kve1HZY9vxPvisG+yWlVXsGI8XQ0Yazagoue05mf7RnEO1zHSVvqJGbQOx0wm6ZX8Af9tH4WjUxL47WiAY7Q9vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=pgEcWP6x; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 20A6F1C0082; Wed, 10 Jul 2024 13:53:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1720612434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lGpYJD0FIGgypfpaFOSXUTovcC2NgpLwqiLmnXcJM/4=;
	b=pgEcWP6xoAU1LmC0PDEeJ7HNQxnGNnd+CoR4iu0N79wZVhjTtNL3iSSPJgD9Zve0Et+JJ9
	qJJoldF2QpzJpsteHrxKA9zJ6XYRbTxesvD0guz0zgxoRJQp+6GBur6Uva83qMUJO8htPS
	2aQEocxdZvSSIISEsru/naMKJWdfXl0=
Date: Wed, 10 Jul 2024 13:53:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jia-hao Bai =?utf-8?B?KOeZveWutuixqik=?= <Jia-hao.Bai@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	Iverlin Wang =?utf-8?B?KOeOi+iLs+mclik=?= <Iverlin.Wang@mediatek.com>,
	Boy Wu =?utf-8?B?KOWQs+WLg+iqvCk=?= <Boy.Wu@mediatek.com>,
	Seiya Wang =?utf-8?B?KOeOi+i/uuWQmyk=?= <seiya.wang@mediatek.com>,
	Dengjun Su =?utf-8?B?KOiLj+mCk+WGmyk=?= <Dengjun.Su@mediatek.com>,
	Win Yeh =?utf-8?B?KOiRieaYjOWAqyk=?= <Win.Yeh@mediatek.com>,
	Sowell Peng =?utf-8?B?KOW9remmluWBiSk=?= <Sowell.Peng@mediatek.com>,
	Richard-CC Yang =?utf-8?B?KOaliuiBt+mKkyk=?= <Richard-CC.Yang@mediatek.com>
Subject: Re: [BUG] Kernel panic when using Hibernation on kernel 6.1.25
Message-ID: <Zo52UVec5YeVkoHb@duo.ucw.cz>
References: <KL1PR03MB7037E7FDCC426ED77C917910C6F12@KL1PR03MB7037.apcprd03.prod.outlook.com>
 <ZmrPVg6PwlYLRiSS@duo.ucw.cz>
 <TYUPR03MB7030367311B22CA3580997FDC6C22@TYUPR03MB7030.apcprd03.prod.outlook.com>
 <KL1PR03MB7037F446BB2E9EB2FF1B2EE4C6A42@KL1PR03MB7037.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DoQzZMeTb46sgS53"
Content-Disposition: inline
In-Reply-To: <KL1PR03MB7037F446BB2E9EB2FF1B2EE4C6A42@KL1PR03MB7037.apcprd03.prod.outlook.com>


--DoQzZMeTb46sgS53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> We have CONFIG_KFENCE enabled, and KFENCE detects use-after-free, invalid=
 reads, and out-of-bounds reads in safe_copy_page(kernel/power/snapshot.c).
>=20
> Do you know why hibernation encounters these problems when entering
> suspend?

Hibernation will be hard to make cooperating with KFENCE. Just disable
one of them :-).

Alternatively, go to latest mainline and start fixing stuff.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--DoQzZMeTb46sgS53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZo52UQAKCRAw5/Bqldv6
8vtjAKCWVAtFiAqxLT4EcGAi1yjcjlRrJQCgoB1QDmucAgzvH2MWldU/kPU/qD4=
=b/2R
-----END PGP SIGNATURE-----

--DoQzZMeTb46sgS53--

