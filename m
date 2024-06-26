Return-Path: <linux-kernel+bounces-230488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E128917D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B6428510A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A817217A918;
	Wed, 26 Jun 2024 10:15:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC96176FB6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396946; cv=none; b=rMJ2QF/C/oCvZWz0OSDq9/4e7tqbN4EmqeM+O41pyyASaxYT4Fp4ZZPlSUFRjOqgYrrcu83E/MdO/IZjZ8i61Zcaqq+cLpfzuJpaBWSqUG48K40rV06K73Netl+JxbI824EdeMqHPAxnnCqkUMP8y23gWGlVgDhwEfkgTJnpdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396946; c=relaxed/simple;
	bh=7Vv/38yXXS6Mw/kIpaWszQSVXYeuVTY8r2rsU6ywIuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+s4/gMX1iaFns10BayQA3vmQeTq3zhBxA44bv7/nTOg/KFVGtZfsNW1P7Sv2tLRCpLAu1dxR9Y/l2n0d3KDoX5YCMG/ol+7DkzcDl3d0VHyVcshSVTFdULMquOTgXII21B0AF+/o2GEC8//hl2HQtdV6VRqoDzyPO+VfvvEM/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sMPgQ-0006E2-4e; Wed, 26 Jun 2024 12:15:22 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sMPgO-0056aZ-Rj; Wed, 26 Jun 2024 12:15:20 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 62EB32F3FC2;
	Wed, 26 Jun 2024 10:15:20 +0000 (UTC)
Date: Wed, 26 Jun 2024 12:15:20 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Herve Codina <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, =?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>, 
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, 
	Antoine Tenart <atenart@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH net-next v13 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240626-expert-gharial-of-amplitude-79e83f-mkl@pengutronix.de>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
 <20240626-worm-of-remarkable-leadership-24f339-mkl@pengutronix.de>
 <20240626120137.10c2ad61@fedora-5.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="45kzkz4ehdxunhp2"
Content-Disposition: inline
In-Reply-To: <20240626120137.10c2ad61@fedora-5.home>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--45kzkz4ehdxunhp2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.06.2024 12:01:37, Maxime Chevallier wrote:
> Thanks for giving this a test.

I was looking at this to figure out if it's possible to use/reuse/abuse
this for CAN transceiver switching. Although Oleksij coded a CAN
transceiver struct phy_device POC integration, we're using the "other"
PHY framework from drivers/phy, i.e. struct phy now.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--45kzkz4ehdxunhp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ76jUACgkQKDiiPnot
vG+gRAf/WTo2sBmipgFQU528oVB0wkUX7yBWwy/ft0FsxHVVEdtQqq9q/EKwGOLY
E0M+Kq7EyF+TKTDZRdghlMftZ3HUvwz30RaHbm/fUr6miC1G9k1UsncoySO3eafn
7gdEqpG1xrdtgtNqizfmD4MIqs2FUnfQoVQ5Q6KSrs7aT50zMf24UG7zprZ7VMth
9QBnnsQVq9a8zqAU0pFnCnUPYbf2f2uYLKupYVmp9E2YA7zlvr8OuMy+7xaWalIR
RI0e9mjH7qpWPzDKrtCQ4h57Lo7J8NFRg6TeeHUiTxnpv7ygA8DUN1DvgJs88zpg
k3QESogcJa73i5OswBY3vdD9k+3cXA==
=lKXj
-----END PGP SIGNATURE-----

--45kzkz4ehdxunhp2--

