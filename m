Return-Path: <linux-kernel+bounces-303244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B657960977
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC47228669A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9591A08B1;
	Tue, 27 Aug 2024 12:02:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3731CD31
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760143; cv=none; b=ZLDi7yQwSWsnhhjWdlal70v1NWWIFkLyH2vw7wd7qvwZVp4u3YS8lDXs033v1i9Ma31L6aWD6TG9Bc2ZzhWTPOtt6NInzJ53vpHvl2RphUaJ7aEdIJoAYh4Nm+A/UCB0mYGlIQeFn+4mhPv5LhDBLonAz8Rahxr1mN0XWv7qzWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760143; c=relaxed/simple;
	bh=eiLK3F+/vUbTbCvu/QK1J1+TZgaGLosfrxeEGlbvEMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHs/mFRNWtvIW7IVbgzQi+2eeJOYxPSXLlkAwreGdi9GLB22OJMynbpHWaHJJ9luUoHCc+aU0PjmgkOpZXufO48nEjM35KdLxllWbyby+f/zTY6xndfvV60q11sDHzJP1xw1S/0UPmZRKfA7ILFI/M19e6nvleiWf3ylWFSuxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1siutV-00086L-E2; Tue, 27 Aug 2024 14:01:53 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1siutU-003Q5D-9X; Tue, 27 Aug 2024 14:01:52 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E9D3C32A516;
	Tue, 27 Aug 2024 12:01:51 +0000 (UTC)
Date: Tue, 27 Aug 2024 14:01:51 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Message-ID: <20240827-arboreal-purring-seahorse-5d2353-mkl@pengutronix.de>
References: <20240823120158.19294-1-tarang.raval@siliconsignals.io>
 <20240823-demonic-jolly-chital-fb4d61-mkl@pengutronix.de>
 <PN3P287MB1829E68257FC17F8ADA725028B942@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="egn5wl6oqvlwcn7i"
Content-Disposition: inline
In-Reply-To: <PN3P287MB1829E68257FC17F8ADA725028B942@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--egn5wl6oqvlwcn7i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.08.2024 11:16:02, Tarang Raval wrote:
> Yes, I have tested it, and you can see the logs below.
> After running ifconfig can0 up, the bus is operational.

Thanks for testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--egn5wl6oqvlwcn7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbNwCwACgkQKDiiPnot
vG+NbAf+JBJeGMKIG1kfgMFb/ws/spN94Vz4Mi+K1lWudCmmb7VEuszbUBWSCDSP
Kei/gHez/pQLYZRUR/h95Kb3X7PcLPYFTTZS5sObtA3Sm+nguueO1qmh9CIiU6iu
at0qyuyPhfZeCgNQ4nHUVgGKoMXAGHHR89FGmx3X4mWjr5jV5XdoqIa3C61z5QAl
RidIg6dtw1NEULeFhYDh6x9xZlQukVcxb8A/zh5WpDvLV5DRttivScp1nD/K9wb+
K9N1nY8P59iDkb5c2veQU1JF61We8SxAMbD3aa0MoN/OZIgdsVJWldRU1/3wv69B
ZLqmhznWpy71gFpXMaAkAPcAPgYktA==
=InBt
-----END PGP SIGNATURE-----

--egn5wl6oqvlwcn7i--

