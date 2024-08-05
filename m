Return-Path: <linux-kernel+bounces-274867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 501BC947DD8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18E11F22D05
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FBD13AD29;
	Mon,  5 Aug 2024 15:18:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C47158DD2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871121; cv=none; b=pfKbC7lIKvAb3PQZ1IB+nOqqX1TZ7w8y432ETEetZ/NXLJRM6WKNf4X/LBHH6+kr73gCdHbdRyYaLOpwkk2zdZypWyN2SmZ/kXvL1vqFxU/IMyxt1fWx/6whNVjvb/0GZOExNvWCNEHkxcAo9ucKuNoKEfaJsVtQLH2kV052hsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871121; c=relaxed/simple;
	bh=DibMZJWK5NQD3RRWExVa4EWPR7ZifgfwPkDUEaB7joM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNQ1vK4gPbCjQwSQRk5eoCm/RZDb+rewPtxFs0Wi4+RYd//gpNQ0XAGFqXt9GDbfkXrC4z3LVcQJwj9YzG+W4f2jQHjSYTY3POa7bEGTQ7w/2W49QzDIVXJ/uiwAXWAKqSH7F0nbvVO10g71AZTZCi6cPATv29zZJ5xd+jyDrS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sazTY-0000aQ-8t; Mon, 05 Aug 2024 17:18:20 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sazTW-004k75-Ra; Mon, 05 Aug 2024 17:18:18 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D55773172C8;
	Mon, 05 Aug 2024 14:44:05 +0000 (UTC)
Date: Mon, 5 Aug 2024 16:44:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: can: fsl,flexcan: add common
 'can-transceiver' for fsl,flexcan
Message-ID: <20240805-capable-fox-of-grandeur-e88dbc-mkl@pengutronix.de>
References: <20240629021754.3583641-1-Frank.Li@nxp.com>
 <20240704-outstanding-outrageous-herring-003368-mkl@pengutronix.de>
 <Zqv5+St34E7hR2Ou@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zxfbvnp33c2bstsb"
Content-Disposition: inline
In-Reply-To: <Zqv5+St34E7hR2Ou@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--zxfbvnp33c2bstsb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.08.2024 17:11:21, Frank Li wrote:
> On Thu, Jul 04, 2024 at 12:07:02PM +0200, Marc Kleine-Budde wrote:
> > On 28.06.2024 22:17:54, Frank Li wrote:
> > > Add common 'can-transceiver' children node for fsl,flexcan.
> > >
> > > Fix below warning:
> > > arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: can@2180000: 'can-=
transceiver' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >         from schema $id: http://devicetree.org/schemas/net/can/fsl,fl=
excan.yaml#
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >
> > Applied to linux-can-next.
>=20
> I have not seen it at v6.11-rc1. Anything wrong?

No, it go mainline by v6.12.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zxfbvnp33c2bstsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmaw5TMACgkQKDiiPnot
vG80qwf/d2For99JejteDIEgMbTKcbTED5H+Tb+mj3pcjOWnJ1di6f6C4PcZ2oPP
Ha8qDRNNq//f2hZXfUT2MTQ4sCnAwyMmvOmYdjn24SXmsA4x3QY3mdwzrf1sAXnK
fbD549B0mymBH00K6X2d4rMGPSq8k4z7keOoZDVxyPHCevGccesxEZz7JKu9HS4/
bSt/YuCiHIHMtur3C/FVE4QDczWVnZ8wBcMMBGzKanOi19gPVy1QgfwjYeeioNv7
GIqqbp0IpI0O1PRRgDu+yknNZf8gjpWyZdKjkZshbmP6ZScxHAAXX7n5sw6BXjUB
Sgb9V2nEQ0s6FSHuvVtMmEYoRw7HKg==
=QCNJ
-----END PGP SIGNATURE-----

--zxfbvnp33c2bstsb--

