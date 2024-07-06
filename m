Return-Path: <linux-kernel+bounces-243284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F76929401
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 16:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3580E1C218DD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 14:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF196139588;
	Sat,  6 Jul 2024 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bzwISKtK"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C9E1F94A
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720275376; cv=none; b=A6vCsvyEn8ah+gZHDWbcIkMtfEByqhMakCpDFM+dpDc9DQNWPw31kK/7aB35BAS+FuU+5uuf0wxuKRD33TPPmmjlQ9HIogsK4TB0KuP9YdM0L+yQZ9hl/0+P+BvtfbUelpIRIgpaUqBtgWz7Iii0OlkSeiQgkgWl3kjhrhKjnrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720275376; c=relaxed/simple;
	bh=qswpG7HM9/+63dhg7D5ryWyMPINcfuRDBHyPx9737Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM+wvUqrg8BOOYRoQoV3KEhcAaUYeB749pYHpP3BykechnwnhVc82vqibrIBOTovSE1NesTnmmBJPJ+PII8YrjvZutR0GIrHTzLWpzE1B312dt8FUFKFDRvOryHAjHDggpawKHDAvOmtHZPHRjaBsZ2jrjOSRQ8Ow5Y9hye5XC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bzwISKtK; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=qswp
	G7HM9/+63dhg7D5ryWyMPINcfuRDBHyPx9737Zk=; b=bzwISKtKBoTXHNF5pzSO
	PJ01x6O/PAadKLIHH2CcIVTSrRJY43exp9dIhS2V9QcJ1tolAeS3ns/7YzqXJ2ep
	JYFxCGNxg+mDHspOZah5Dzb9yaj5tTtFHSWkcG9B8gKaJX4KUmTsU0NGF8/lyGWG
	7NHjNfpRDANBYDHOKZ7fgUjVNxvJBLqU8pWORzXc5KE7FcUSLxBPJd5Ce632q/tc
	/B6XTCkxpbOi27QEhaQ2D/3ujYPN1rJsfOCiJbWcZ475JNHEznDfe3e7OdvORf4p
	RAOyoncTzpzUJzZhbL43C8QMfBEg1faeLmMfQllCzkIijpZg0KUAKISrb/d+uSTT
	Tw==
Received: (qmail 3844746 invoked from network); 6 Jul 2024 16:16:02 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 16:16:02 +0200
X-UD-Smtp-Session: l3s3148p1@G5fb0ZQcLKFQT+F6
Date: Sat, 6 Jul 2024 16:16:01 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Aleksandr Mishin <amishin@t-argos.ru>,
	Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Zhang Shurong <zhang_shurong@foxmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] staging: ks7010: Remove unneeded check in
 ks_wlan_get_range()
Message-ID: <ZolRoeaPETSmJMGJ@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Zhang Shurong <zhang_shurong@foxmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
References: <20240705204434.10541-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nEOPBJ7qUqMeqsl5"
Content-Disposition: inline
In-Reply-To: <20240705204434.10541-1-amishin@t-argos.ru>


--nEOPBJ7qUqMeqsl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 11:44:34PM +0300, Aleksandr Mishin wrote:
> In ks_wlan_get_range() variable 'i' which value is always 12, is compared
> to 2. This check is unneeded and should be removed.
>=20
> Remove unneeded check to clean up the code.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 13a9930d15b4 ("staging: ks7010: add driver from Nanonote extra-rep=
ository")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

I thought this driver was to be removed[1]? Phillip (CCed), what is the
current status? If you are busy, I can remove it as well...

[1] https://lore.kernel.org/all/igi27iwrzg3ovgj3sym4gsi45timpkt4vkl5ss5dbft=
dzat6p4@ctxcjocvunpt/


--nEOPBJ7qUqMeqsl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmaJUaEACgkQFA3kzBSg
KbYXsg/9F9lDcloURuKEd74oJH0/gSGKTh+Uy1hslnHWs0cjNepYMVPIi/IRC7Cf
67JRJoeFCdJgNkac3pOBKHLqSDaYgMOnlYRAKKvVFKWO6qC3Pl27aisYLeqgxRm1
oCDIhr8FpCVFDOmPDBqxcvMHvz583lssPiQiBubjgMV0o4zAUH8l0d4oq1+xIXq/
nDBBVufSqk4BgTR2yiqpf880pcG2B8OYwwCB/XU7u9tR4pHH1cxaLbIPgN0QJ9eG
f/GotdC0rygRbURVxc25FvImYY+dEyyAW5M/s+M7QX1UksBohJSYwLs9qcfjRH0k
DYQp1f96dGMVfLduOOsgLsCedN4S34+NOVpiXtEbmjPt0yKI8BvAyufIDTjup1NJ
k0NB8EBF9GpJNz2ppOOZO1BcJn1ZXFMu1Q/S8cju8iQhRk2PUaqq4wj1svzgGiJF
ksiL9YHmiPUIH3q2CRMSZ5SLEKdiU1QtaXyVPlxD/5huFe7YysyrBVaaY6EVEnJB
2d+BZ0IwhrpI+9eUMdoWd1WhUG3xeU/UNASjKSyxzwWgH66jnwI3vO5iNSVbLJSR
/soy598yJk9rbGbUcAPeJB1qSPTCepohdPiynHSCalztapZVpTAOO3nOKCoL37QG
mrWCoBw0Abw8PZSwgCs/jvqr+E8kJQurkbqLxhT7zdDmjzsqwxs=
=iuBZ
-----END PGP SIGNATURE-----

--nEOPBJ7qUqMeqsl5--

