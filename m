Return-Path: <linux-kernel+bounces-565849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8823CA6700B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F145189E7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB971FC7D2;
	Tue, 18 Mar 2025 09:42:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C161A83FB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290956; cv=none; b=YMybqTRzQ+SqL/LtCQ7F8q+VnqR5lsrwSSCaDJ+qaqw/eVlIkpCTJ2YDyG+N9owpccvsTpM5OrLMBy5rfarz9WelR113yr1RUtJhnph2GwDTmXR47hvT0zLS7rSwsPkchvM20KD5kLqDO+Mok8fdh809/EljTNfXDOPFupKu+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290956; c=relaxed/simple;
	bh=y8jL4qekQfiGukKg+ROrGvBhtZJLqKiazo6PakAQMcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNm7Z+K/z/J8j0h/KQC2bvpxmnGXAf7CdgosFkBHIoBn20I6RB9f/Nw48XRGK2RF295NMmec78GnHluRD7skTY4207D01qbsElzcmex0yeliHts2q1y0KeBflh523zrD+k8GVA0BjkomevK3az1fZgJtka1K2Qi89+Lb95KjC44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tuTSp-0007k8-Sr; Tue, 18 Mar 2025 10:42:23 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tuTSp-000P5E-0c;
	Tue, 18 Mar 2025 10:42:23 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 321633DF4DB;
	Tue, 18 Mar 2025 09:42:23 +0000 (UTC)
Date: Tue, 18 Mar 2025 10:42:22 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Russell King <rmk+kernel@armlinux.org.uk>, 
	Thangaraj Samynathan <Thangaraj.S@microchip.com>, Rengarajan Sundararajan <Rengarajan.S@microchip.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>, 
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, kernel@pengutronix.de, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 04/10] net: usb: lan78xx: improve error
 reporting on PHY attach failure
Message-ID: <20250318-belligerent-emu-of-authority-0beddf-mkl@pengutronix.de>
References: <20250318093410.3047828-1-o.rempel@pengutronix.de>
 <20250318093410.3047828-5-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="35643vawmk6esmbi"
Content-Disposition: inline
In-Reply-To: <20250318093410.3047828-5-o.rempel@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--35643vawmk6esmbi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v4 04/10] net: usb: lan78xx: improve error
 reporting on PHY attach failure
MIME-Version: 1.0

On 18.03.2025 10:34:04, Oleksij Rempel wrote:
> Include error code in the log message when PHY attachment fails,
> providing better debugging information.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v3:
> - update commit message
> ---
>  drivers/net/usb/lan78xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index e54b1ac2c4fc..d2bc6cbdbb66 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -2693,8 +2693,8 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
> =20
>  	ret =3D phylink_connect_phy(dev->phylink, phydev);
>  	if (ret) {
> -		netdev_err(dev->net, "can't attach PHY to %s\n",
> -			   dev->mdiobus->id);
> +		netdev_err(dev->net, "can't attach PHY to %s, error %pe\n",
> +			   dev->mdiobus->id, ERR_PTR(ret));
>  		return -EIO;

Probably unrelated to this patch, but what about propagating the error
value?

Marc

>  	}
> =20
> --=20
> 2.39.5
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--35643vawmk6esmbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfZP/wACgkQDHRl3/mQ
kZysRgf/ZK7iXPm8CUv1sZbinwkHKzA8Tw6N6ZzYr6SN42E0NJiLzlfojaBXtSON
u3GbRQM8pU0pr24x/uLJqgQX1jh6MqN9gJD/Bsdqr8IjueJpEvu7Dsxn1RX+31Re
KlKY83uF5H63tKtJduhqCoFYekU4hQsfyS6TI2T/aotOv/KB7t4Svr/BrUJ0Wv6Y
kWil/63ZOAl0AjVZkXikg71g4VLl6pvs2Wdtsvp8nkRg2y+NTLBULGc4DRj53r5f
nOabsASMgYTa8ThMcwYMILevAPUSGXelWA7dMCBydM5YmwNnwf5Ig89Ow073qEj6
U3tX+JS1ncOwl9TxGRtvX/omGny6eQ==
=s1r8
-----END PGP SIGNATURE-----

--35643vawmk6esmbi--

