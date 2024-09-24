Return-Path: <linux-kernel+bounces-337135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2E89845D0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15233B2636E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2BF1A4F3E;
	Tue, 24 Sep 2024 12:17:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10181A4F18
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180229; cv=none; b=ui4SMDggNekm7wc1Y4pEM7MT8HvaJMeAGWL1oJcpBZNz9RA2iFM9VCtauVQlnmbDxCgyhx8p8UoSaPTzzMJRG/xBpPTg/BpHstmeEjnT22IQHEM8fFJ/H+oVixInAWVBaWbrjfmeqSRMAUNTOcC8aUsRWSZJK7bJmNfEmgUHPY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180229; c=relaxed/simple;
	bh=tl7y8kRBBHdFc79s2DuTQU8RzP2BajFebxnEf0mmfYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw++VJHMaYuxV+FsiEz7nJUYOZt2HJ83c3nc74wrv8xBXc2elBFlgSwiIlO7kRyTg3YVrOrcla383z+rQndCLUAp00oV/yVAM6V6KcZAz/vdDhcj4m4OhIAofXzoYn2DD+mSHci+quJe/WQWNMSWjizp7aFDsf10eQdmiKaKAk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1st4TL-0004Yy-P6; Tue, 24 Sep 2024 14:16:51 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1st4TJ-001CpB-TZ; Tue, 24 Sep 2024 14:16:49 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 53C90341CA6;
	Tue, 24 Sep 2024 12:16:49 +0000 (UTC)
Date: Tue, 24 Sep 2024 14:16:48 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiko Stuebner <heiko@sntech.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: CAN_ROCKCHIP_CANFD should depend on ARCH_ROCKCHIP
Message-ID: <20240924-portable-spotted-hawk-279a86-mkl@pengutronix.de>
References: <a4b3c8c1cca9515e67adac83af5ba1b1fab2fcbc.1727169288.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="luiiscxjhx5doxr2"
Content-Disposition: inline
In-Reply-To: <a4b3c8c1cca9515e67adac83af5ba1b1fab2fcbc.1727169288.git.geert+renesas@glider.be>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--luiiscxjhx5doxr2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.09.2024 11:15:31, Geert Uytterhoeven wrote:
> The Rockchip CAN-FD controller is only present on Rockchip SoCs.  Hence
> add a dependency on ARCH_ROCKCHIP, to prevent asking the user about this
> driver when configuring a kernel without Rockchip platform support.
>=20
> Fixes: ff60bfbaf67f219c ("can: rockchip_canfd: add driver for Rockchip CA=
N-FD controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to linux-can/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--luiiscxjhx5doxr2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbyra0ACgkQKDiiPnot
vG+1PQf/UylvX67IKTMkg7IHv8Andvsu3ca/sqfLejrVeJnVdsG1ObQCbDcBLJDf
Ak+W/ilndcH9Kv6IbNQSslYyukRhS5H+0cbEqO4EAYtthdBJ86CTcYKfJIhOIRxW
QSJGg/MpxxVxf2526VCEJJvc6R/8j3rxsLFGZK2vJrApKKUQJk1vIpv0mMVMa43l
x7T1oGwnkaP8auRQL7gSmA6TWd7Gh+o/6KZow1z/asUYRvdzeg3MDoneraLqNJ3q
Ghn/ZWLz/v2YgEh0tNOjv9K1NNFFJhryOwGmOyGmxiOtfogc+wCYrCqI1kOjxwg9
Jj3LBsk8f6qKjQN88mgvF+GiQPt4Zw==
=ZWHR
-----END PGP SIGNATURE-----

--luiiscxjhx5doxr2--

