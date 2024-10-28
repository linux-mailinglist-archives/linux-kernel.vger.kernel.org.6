Return-Path: <linux-kernel+bounces-385103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620A69B326F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD627B2293E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC671DD54A;
	Mon, 28 Oct 2024 14:03:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F461DD540
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124205; cv=none; b=h728301dGAwxG0zmyEC1CQ7Iwdhj0gt6tmz+AI7olpTXSeYat7yUI8xkX+Wf9bYtrqgvbd/z2hfCcn03xqlcoVQy4tg6+BFP2OfRWRtD2+FIj2nbks+xPmPO2eXGoqjAnBQJjpYSCMdgQnmQrW3+8GL2uPAHTeQorFe4GJgQsS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124205; c=relaxed/simple;
	bh=E8cUzWZBg9UkSuuRre1SQE2+p8/GoStVEDw5IGzymS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEte/sVY8VklTm/wb6SpCxYmhV0Afi8fBDIgjgBcW2XY3go9zs5RvBhFrfepe7rglTAN8EnkRX5FRrXl4qf3nD+GQQ2Jh0oxyPxsx1W0g56ba253h0GY+xMd+q2CZ3D1feTBrjm4KgxuA27q7dTcgatSWjXTcNWal0g2XmWzeHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t5QKw-0000uc-5f; Mon, 28 Oct 2024 15:03:14 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t5QKv-000rbZ-2y;
	Mon, 28 Oct 2024 15:03:13 +0100
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9C2C736093C;
	Mon, 28 Oct 2024 14:03:13 +0000 (UTC)
Date: Mon, 28 Oct 2024 15:03:13 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 07/24] can: Switch to use hrtimer_setup()
Message-ID: <20241028-talented-terrier-of-glory-bdd5de-mkl@pengutronix.de>
References: <cover.1729865232.git.namcao@linutronix.de>
 <e4ce3a3a28625d54ef93e47bfb02f7ffb741758a.1729865232.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lnl5aue4w4gomesx"
Content-Disposition: inline
In-Reply-To: <e4ce3a3a28625d54ef93e47bfb02f7ffb741758a.1729865232.git.namcao@linutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--lnl5aue4w4gomesx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 07/24] can: Switch to use hrtimer_setup()
MIME-Version: 1.0

On 28.10.2024 08:34:20, Nam Cao wrote:
> There is a newly introduced hrtimer_setup() which will replace
> hrtimer_init(). This new function is similar to the old one, except that =
it
> also sanity-checks and initializes the timer's callback function.
>=20
> Switch to use this new function.
>=20
> Patch was created by using Coccinelle.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lnl5aue4w4gomesx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcfmZ4ACgkQKDiiPnot
vG9eEAf+LLFA1bo0l4Xv8sCnzSlUIpsc0Cgib1+KfPur06j5rNUYXXMeBxTPQYNO
Mj6FpIeNp38hpO/3qYOKHQ7W0GX60IglzeX4V1aKquK6AECDl/POeDvuq4ZKUUFZ
iSfJWXs2FqQj0AqgOAeGjKVi6GQgUpcptOjU4YWSqm7JYtNibZ6Qp1eOJ9s3zsu7
QCwSfR6DnFWUL5PhPjHCdEDjsVqIw30gN4m3wJ6rsHIUV30nhwHUlJCREr5AIrAZ
ebO46QOzrDKYT9WUHSeDEZBz86G9ZDRqJAJ+p9WM7Jb1tuyqCq2l6D5OeYG99lHR
eZ70waNkA0jKGJFfIEOksh4CddpuDw==
=1Yfw
-----END PGP SIGNATURE-----

--lnl5aue4w4gomesx--

