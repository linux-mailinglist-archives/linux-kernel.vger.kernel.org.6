Return-Path: <linux-kernel+bounces-224233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA58911F34
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF061C20D06
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8523E16D4FE;
	Fri, 21 Jun 2024 08:47:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D390416D4EA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959633; cv=none; b=nRNPG7x2KDjOiYRE6EJaDdt3MEp18iOpM10FVTUm1T46OJ0bQwiCdhxcLQHxqOLbnNUsgEpEwVqi7UPkhB/fXPxQYZO5jvH8VFeDjfHAoZSSRpTvcBBNj4l5KPK+Bvy38ToDSlAebSoRo82C7DiCYGcoFQ1YuaOGs8w3EX6Zppw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959633; c=relaxed/simple;
	bh=OHaFAIancPg5B97CYC7U7qpvfYJQGIcnfVSOoitJsTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P30lctCuytgNCMLXjlJmEe5q1U9SS6zFVmQ4QN+EYzjAP+Psdc7o+iXP2IgmDCIbvJMI3k1aaOAxBqUOvBzKuXfRsVpKPt0CA54YWRkOLNrYtohfw1/Td0I6kMGFsLN8EDOUPRi0CxFzZsz9DSsta3SrxWWg4hGWuPq5+QhkJNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZvB-0001Wd-Ft; Fri, 21 Jun 2024 10:47:01 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZvA-003txB-Ko; Fri, 21 Jun 2024 10:47:00 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 53A292EE5B7;
	Fri, 21 Jun 2024 08:47:00 +0000 (UTC)
Date: Fri, 21 Jun 2024 10:47:00 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: robin@protonic.nl, o.rempel@pengutronix.de, kernel@pengutronix.de, 
	socketcan@hartkopp.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] can: j1939: Initialize unused data in j1939_send_one()
Message-ID: <20240621-sociable-juicy-kakapo-b225cc-mkl@pengutronix.de>
References: <20240517035953.2617090-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4a2nfbhzpnjrazrl"
Content-Disposition: inline
In-Reply-To: <20240517035953.2617090-1-syoshida@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--4a2nfbhzpnjrazrl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.05.2024 12:59:53, Shigeru Yoshida wrote:
> syzbot reported kernel-infoleak in raw_recvmsg() [1]. j1939_send_one()
> creates full frame including unused data, but it doesn't initialize it.
> This causes the kernel-infoleak issue. Fix this by initializing unused
> data.

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4a2nfbhzpnjrazrl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ1PgEACgkQKDiiPnot
vG+pfAf9ErIVSKFNz5AlblKgvg1U9veRg7zbWZn4TdM3efLMglkmTTabPtZ9q3W0
aq2NxoIasl6kqyBMjCkITaeu0p1Gix/sEnzCLy0u/GlZgc0d6WqhpaUCjcH9EnBw
gCgFS5lRxz+eL3WtptU4X24S4xyh4LJgTBw2mg8e6rKZl7CYGcqE3daa8r1tnkfg
Eh/gOx9PzNq/rFBrMJxOhic5cP+/SGdT2UtIyyg/WyHzKKdFQgdkNZa1SuXvQd7x
bmZETXl93AuRjUDLAk/iLitQGyOrLNuqBPiI7awGUQ1IxDQgx6rOPIBj49H1vOK1
FWvTmlIixuMq1FQL+RHxR7kUDD2edQ==
=17GV
-----END PGP SIGNATURE-----

--4a2nfbhzpnjrazrl--

