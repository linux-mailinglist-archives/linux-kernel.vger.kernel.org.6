Return-Path: <linux-kernel+bounces-213059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53805906A76
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D05283503
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DEB142649;
	Thu, 13 Jun 2024 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="KC3CvdxZ"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973FE1422AB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275931; cv=none; b=UDZeNvvXbcFRqwViZianbMU3yE5FefPhBxbjAscV0m1UY2XwYxLdk5saNggaJE1T799tDHklzI8hhg5xiCmSYPyqWkjsAY2GKUVwa2FRRaKN8m1U0cj/dGdH/4CvI5fPA0pZ+oWGTB+tqgQdftbCTSE1arrjPJ8WwFV0Y9PVJo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275931; c=relaxed/simple;
	bh=+WEP1Pf+9MAbP3pEYkJ4Cb2UyDAzbJd+ioJxVOm2eFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcvFpSkLRBzTVnoQxw1CnU+uePIZGJrPHCF7E8xT6lrf/6VAXYnThaPUMk9Ty8w6oaA5Us0a1BtaR4wbtfUKCz7frQVbon9a4L+tKGpBypluJxDFxUPbRgL+CthA2wuP584EaHBX1fGyBhv6uCu1R8ESiW2Wwa6HMRsKWh5glnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=KC3CvdxZ; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BF8A51C0082; Thu, 13 Jun 2024 12:52:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1718275926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lA5428gfvz7Iskz05AHS5wF8JaSsBlmWEgNMiyBah8o=;
	b=KC3CvdxZkBaO9a6YIYe/hFZg9KTuf48wzarXiYh/LaaROt7mxFlfG8X+SZkKtGmBJfV9Ci
	UD8/oezS9bWPq/nOylKirmrf4k+RPjnhLYaJbPIezYYIJAaQ/cT+D/PQDN8x+sNecmwidJ
	w+RoYxDfnqiMkl+WA2JapkA688yjpbA=
Date: Thu, 13 Jun 2024 12:52:06 +0200
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
Message-ID: <ZmrPVg6PwlYLRiSS@duo.ucw.cz>
References: <KL1PR03MB7037E7FDCC426ED77C917910C6F12@KL1PR03MB7037.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dYM3x6sj/MVTnwzb"
Content-Disposition: inline
In-Reply-To: <KL1PR03MB7037E7FDCC426ED77C917910C6F12@KL1PR03MB7037.apcprd03.prod.outlook.com>


--dYM3x6sj/MVTnwzb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I encountered a kernel panic when using the Hibernation on kernel version=
 6.1.25. Below are the details of the issue:
>=20
> **Description:**
> When I enable CONFIG_HIBERNATION and assign a specific partition for hibe=
rnation resuming and perform a specific operation, the system crashes with =
a kernel panic.
>=20
> CONFIG_HIBERNATION=3Dy
> CONFIG_PM_STD_PARTITION=3D"/dev/mmcblk0p16"
>=20
> **Steps to Reproduce:**
> 1.	Set printk to level 8: ` echo 8 > /proc/sys/kernel/printk`
> 2.	Set up the swap partition: ` mkswap /dev/mmcblk0p16`
> 3.	Enable the swap partition: ` swapon -p -3 /dev/mmcblk0p16`
> 4.	Configure hibernation resuming settings: ` echo "/dev/mmcblk0p16" > /s=
ys/power/resume`
> 5.	Configure hibernation mode:` echo reboot > /sys/power/disk`
> 6.	Perform the operation: ` echo disk > /sys/power/state`
> 7.	Observe the kernel panic
>=20
>=20
> **Expected Behavior:**
> The operation should complete successfully without causing a kernel panic.
>=20
> **Actual Behavior:**
> The system crashes with a kernel panic.
>=20
> **Environment:**
> - Kernel version: 6.1.25
> - Distribution: Yocto 4.0 32bit/Kernel 6.1.25 32bit
> - Hardware: Arm Cortex A55, 1GB RAM

We'd need to know way more about the hardware. Also testing with
latest mainline would be useful.

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--dYM3x6sj/MVTnwzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmrPVgAKCRAw5/Bqldv6
8n4IAKCnBPdYu6Kv4gnKFIla372mF+fr/wCgxExGNdQtQrBQUa5SZTnqypWmilM=
=FIqV
-----END PGP SIGNATURE-----

--dYM3x6sj/MVTnwzb--

