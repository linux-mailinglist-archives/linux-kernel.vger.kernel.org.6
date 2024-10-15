Return-Path: <linux-kernel+bounces-365502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA2A99E349
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4B81F24192
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3D51E3768;
	Tue, 15 Oct 2024 10:01:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370111E2847
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986486; cv=none; b=X5SmpQQ91C5kXdiJzXH4Ov1GL2BjXTEr6UowKSQbIs2BVPYuXmhN7hJZ8ZBOWDLxviCZ1X/RZ+yypKV/SV+uX8MXUSz8dNGCvWypS/ltVPclpx3ngbIUEgdIcupZdThsKWbi9Coug5B4NOj8HEQux7r/uVtNaHK4aEbYyhGrdgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986486; c=relaxed/simple;
	bh=81nipewEOAtcck8YDJAXOAg/JeuKCZCvDIXlHxwqhpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGNUUfyydsLRrv0UbS1gy85vo94n0/TkZLMHQ+ZgzgjMIQEhtnzKqtrEFfl2m3MfruvgsTpfKI/BbI7yoaOhTZHZURnWjGzy8vTHifAhKALC6N2BqW460Gn1Cj99ukMU1lBbGpaoFHziDmFnKXII2nmmTMufpImfWYAwwT8Jcq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t0eMW-00011T-A9; Tue, 15 Oct 2024 12:01:08 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t0eMV-0020DP-DR; Tue, 15 Oct 2024 12:01:07 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 068093531C8;
	Tue, 15 Oct 2024 10:01:07 +0000 (UTC)
Date: Tue, 15 Oct 2024 12:01:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: RE: [EXT] Re: [PATCH v8 0/5] v8: firmware: imx: driver for NXP
 secure-enclave
Message-ID: <20241015-literate-onyx-rhino-1f73c7-mkl@pengutronix.de>
References: <20241015-imx-se-if-v8-0-915438e267d3@nxp.com>
 <20241015-silky-mussel-of-tolerance-b3f5ba-mkl@pengutronix.de>
 <AM9PR04MB860408A38DB566BB18B6E2E695452@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n6jdaofux4wzmf7d"
Content-Disposition: inline
In-Reply-To: <AM9PR04MB860408A38DB566BB18B6E2E695452@AM9PR04MB8604.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--n6jdaofux4wzmf7d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.10.2024 09:52:01, Pankaj Gupta wrote:
> Details about Base-Commits for this patch set:
>=20
> commit b63ff26648537a5600cf79bd62f916792c53e015 arm64: dts: imx8ulp: add =
caam jr
> commit 74f3788167230721a47d9f22afb746b8e6ba33e9 drivers: crypto: caam: i.=
MX8ULP donot have CAAM page0 access
> commit 5adcb3eebd33e5ced26b5ecc59f54be027bb4f1a caam: init-clk based on c=
aam-page0-access
> commit 28e880c89d1ca6315a67330f15dddcf693be58ab Linux 6.9
>=20
> Above base commits are corresponding to the following commits in the Linu=
x tree:
>=20
> d2835701d93c crypto: caam - i.MX8ULP donot have CAAM page0 access
> 6144436803b7 crypto: caam - init-clk based on caam-page0-access
> e6b73eb23f0b arm64: dts: imx8ulp: add caam jr ..... // This one is the ba=
se commit

Please base your patch set on public available base commits. Preferred
v6.12-rc1.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--n6jdaofux4wzmf7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcOPV8ACgkQKDiiPnot
vG+r9Af/QCG/uPTp1pYre4bqWgeQI3Uss2Ii2/5vwQHFAeakZaHpUOqLnjxagw1M
Nx9sTQRO5usW+VHdWeSeyxeJI+gE0SOdfkOmcQ8AN3KnPNAjyCj9t1YxtHpDsUYj
5Iz1ZA2CiqNVYMqQsVbdN/55Y8u16SR8FsMVCwidqBoI8d75NBQXFPV5KmIoIizI
89TipQKRGOa+MQvit/42UCz6ebW6unPQGpTdI7pqQMcueH8QMewL2eBCBS1agv4T
twfsKnNcwLTRXuLJte7QETQtfImtjPkkJcQqK7kp4UQFO2Hghnb0k3CHo0AtG5lF
0bfTyNGqnitV/DIagyaMWfY/ue3xFQ==
=wwPf
-----END PGP SIGNATURE-----

--n6jdaofux4wzmf7d--

