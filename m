Return-Path: <linux-kernel+bounces-274913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F8A947E2A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168CF1F2199E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2164215B10C;
	Mon,  5 Aug 2024 15:32:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D15615AD95
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871975; cv=none; b=pJEtOe+tH/3F3TVlAbdje81kEQMuHqMVY0z+qgokCHQYcwjUmSIShaoSOLMtyi1tp4Nqh7Dzsxa6TaGa6/AyQ7QssOAqCgzEkK4gGjD4ZUMpDm3NYxz3lBL48KRzahc8vy4xsilMA+MR3PKaKuOTAT7dBy3WGU3ntNyrTwDjPIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871975; c=relaxed/simple;
	bh=z2PWg3UgFL3vxMYQCpFBun45yhNzNmK5bmif1gNBQTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/K+u5jYrpWFRNliHOn5GpCsEhh2yFMyED/zq547fGH7PHQcpQRqixoFBHvQzf3ZSNgEAhjrjk5lbpUCyOoeiD5ZUtDi0QccqYxF0nQMipHC1S6GwEW8U83bODcyxUxqgxmohLPlgD1tIUnDNm7Xd4kMFIyLa6XkCr0vFCaEP3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sazhV-0001pr-Sx; Mon, 05 Aug 2024 17:32:45 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sazhU-004k8t-VR; Mon, 05 Aug 2024 17:32:45 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 987ED31735A;
	Mon, 05 Aug 2024 15:32:44 +0000 (UTC)
Date: Mon, 5 Aug 2024 17:32:44 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 0/2] can: esd_402_pci: Do cleanup; Add one-shot mode
Message-ID: <20240805-hopeful-harrier-of-foundation-166056-mkl@pengutronix.de>
References: <20240717214409.3934333-1-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jpipnikmvmowscpn"
Content-Disposition: inline
In-Reply-To: <20240717214409.3934333-1-stefan.maetje@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--jpipnikmvmowscpn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.07.2024 23:44:07, Stefan M=C3=A4tje wrote:
> The goal of this patch series is to do some cleanup
> and also add the support for the one-shot mode before
> the next patch introduces CAN-FD support for this
> driver.

Applied to linux-can-next.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jpipnikmvmowscpn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmaw8JkACgkQKDiiPnot
vG9ftQgAj8WItmgYwyGlU55B+0TPzrn7Z5TeLQvKtiPSxW9BG17aLNErOyGpf9xT
CAaWFBhlFVR/vb0uVjwCXasUQXQMsduUWuBa0nrezKZ2eUbwG5hchHs1n63SHtQi
Lqf3ViB0g0rbUuH3pi5HjGUihdgDCR6hcbKEyf/iuhXRmKKPof88VuGpsS4lAVTy
DV1cOTqaP0/turqY8T2Xq8S8B1a2FpTV659Tk4JINGTxp3S74i1UAsC5gXu4LaRP
OlmVK9howa0JWApDQzYKdXr35av/cIkv8rHcART0JkwDs75JBzy/27Y8/up3Ca/Z
duhT2PtElCHFeiklA6ZpYVHw9qBSYA==
=CaEM
-----END PGP SIGNATURE-----

--jpipnikmvmowscpn--

