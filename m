Return-Path: <linux-kernel+bounces-189327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA348CEE70
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 12:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9151C20C97
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE3823765;
	Sat, 25 May 2024 10:14:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4741D2230C
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716632089; cv=none; b=XZb9WxVmpRMUqZAmy9wh8T1CE6Su9nCnQ/WkU6fpVzDLaWV2xMf/jWs2e53iuyLjKL7/ZKslsrWDpmP+q2zuEWik8Co48geoUahA4uvswu3cLHlqD1CF4qYprlhG4CBLEWelyAlLXbsaYR6fN6kVtMmfajntFsPZZwTPIr8BGv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716632089; c=relaxed/simple;
	bh=Cal6esDsmUOPJtvcLNAzJ+BG22f0jJ9tEpfnKqqsE14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLkJUnyPZc9z9zX53mtcLGy18IkovF5IgQ9yKG7p09qoI0qjZVx4yGeXb5UNbIexQ6LhAo1mpWwAAt7QUvXMgnrLiHYVuus0MuWX0rgWFnlJPZlIDqnoxskx3Fi/fQTyAtlxxmVYTECUYF/WIuqMEbdtR4lRF+Ci/PDyncUBO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1sAoQ8-0005j0-Sx; Sat, 25 May 2024 12:14:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1sAoQ7-002ucj-4n; Sat, 25 May 2024 12:14:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1sAoQ7-00Bs96-0B;
	Sat, 25 May 2024 12:14:35 +0200
Date: Sat, 25 May 2024 12:14:34 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nishanth Menon <nm@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Tero Kristo <kristo@kernel.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	Santosh Shilimkar <ssantosh@kernel.org>, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 0/3] reset: Convert to platform remove callback returning
 void
Message-ID: <3emqw7comsegnkso6o3srb3ebeoa7n2m5ckv2ycznu6muh7ydz@krrx33tn4vyv>
References: <cover.1709674157.git.u.kleine-koenig@pengutronix.de>
 <f35398925846addb282df9c8a6f09d24ecc5c6fc.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iyy2kxqaffif7hoa"
Content-Disposition: inline
In-Reply-To: <f35398925846addb282df9c8a6f09d24ecc5c6fc.camel@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--iyy2kxqaffif7hoa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Philipp,

On Tue, Mar 12, 2024 at 09:47:24AM +0100, Philipp Zabel wrote:
> On Di, 2024-03-05 at 22:32 +0100, Uwe Kleine-K=F6nig wrote:
> > this series converts all platform drivers below drivers/reset to struct
> > platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
> > Provide a remove callback that returns no value") for an extended
> > explanation and the eventual goal.
> >=20
> > All conversations are trivial, because their .remove() callbacks
> > returned zero unconditionally.
> >=20
> > There are no interdependencies between these patches, so they could be
> > picked up individually. But I'd hope that they get picked up all
> > together by Philipp.
>=20
> Thank you, I'll pick them up.
>=20
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

These patches made it into next (as v6.9-rc1..6d89df61650d), but not yet
into Linus's tree for v6.10-rc1. I intend to send a PR to Greg early
next week changing platform_driver::remove to match remove_new to cook
long in next for v6.11-rc1. If these reset commits don't make it in in time,
I'll be so bold and just include the commits from your for-next branch
in my PR.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--iyy2kxqaffif7hoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZRugoACgkQj4D7WH0S
/k6A3wgAjRmgp8rQGY3fCinrKANP6demihtOLmhz5ruJuqwXt7ngOJE1/K58Caka
iuBBb9iemanBGqXfEb05ZjDakzK+UCQX2XxuP2uFUMl9SOm/dOG3K5G28OpkHZba
2eVybGlBFbcCAT6HG9RdMp6GnAY/AqNTwW6WD5CSPaOjYB08AwXTMw7eDAZ6ysv0
8kNd1+VrRAHtVZ+ua3OIrb7Dvw024vnp3+Kg4bV1oemz2ZrkshPX2YMd7NIKnzfV
QoHr8SHQRiz0Buo+QKJUzzhlvFdq/W2EtgpeHy0zo9GKTWufMyo0FLgKPVGQinCn
TJALA692czBe6XmnAWg3O49wqZtriQ==
=pHv1
-----END PGP SIGNATURE-----

--iyy2kxqaffif7hoa--

