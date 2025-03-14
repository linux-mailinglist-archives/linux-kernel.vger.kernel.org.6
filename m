Return-Path: <linux-kernel+bounces-560985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658E0A60C05
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4848417CA25
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E236E1C863D;
	Fri, 14 Mar 2025 08:44:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87801B414F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941862; cv=none; b=JSWiQdwFXUebW9NHCTmkKEBBTZeXP0t72O4g9g+tdmaER3Db9ZlnWlYwgshh4W8z7wCsF/ldjtCtU891qPZIo/ZR3pMNX9dcriETrk4L4aEVzAG6wxsjLLgp/LumOaTSkOKy7boeKqjlgOQb0slFtlJFgn51WTkXd9fGziRicmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941862; c=relaxed/simple;
	bh=NMIRyZ4OLQxyaLL+oZvy5HXvNOl3xhBRToxaxRy/2Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNdsVE5aSniFay/6vhvoDk5Vxe6k61bN7paoALWQd37/sdhHZ8Y0bb6fXKzdE47OGaJd+qJkRFsf7WSxjq9Owv5CEVDgf78A8czdafadhEYxivcxcGZqVtrxTOgWOFNGGyBnHxGpb57C8WMbcjcvrO9bXBrQrAQrdns/XXt1zwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt0eB-0006O9-42; Fri, 14 Mar 2025 09:44:03 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt0eA-005flW-04;
	Fri, 14 Mar 2025 09:44:02 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A635F3DB824;
	Fri, 14 Mar 2025 08:44:01 +0000 (UTC)
Date: Fri, 14 Mar 2025 09:44:01 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH RESEND v4 0/2] can: flexcan: add transceiver capabilities
Message-ID: <20250314-visionary-basilisk-of-drizzle-2f51f9-mkl@pengutronix.de>
References: <20250312-flexcan-add-transceiver-caps-v4-0-29e89ae0225a@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mo2lt322kvpj2dkt"
Content-Disposition: inline
In-Reply-To: <20250312-flexcan-add-transceiver-caps-v4-0-29e89ae0225a@liebherr.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--mo2lt322kvpj2dkt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND v4 0/2] can: flexcan: add transceiver capabilities
MIME-Version: 1.0

On 12.03.2025 18:45:21, Dimitri Fedrau via B4 Relay wrote:
> Currently the flexcan driver does only support adding PHYs by using the
> "old" regulator bindings. Add support for CAN transceivers as a PHY. Add
> the capability to ensure that the PHY is in operational state when the li=
nk
> is set to an "up" state.
>=20
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Merged to can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mo2lt322kvpj2dkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfT7E4ACgkQDHRl3/mQ
kZxY8Af8DEJZvuDVHPhbuvHnPgsXAiD0RYaDpVYogPm6iQUhEZZNaOrKp+7G+svv
DVtb7AheXaGjFf90QfsjS5owttyb7RB/qhLklmHd1z8UDwRnVpMFHYiI8rrBMYyK
FpSjfTU4pt9CQbNXYE7bX1i2/OvSW6uYbERrvqrU5X+44G3KT5GViCQZBH1uyfMR
m7uBV9yxHt4O6p/uXaPJrodrsp83j+9oIhwDkgrPqYzUzy+oGJLWWcjJ8I/KyLN1
d1LRMsNM9gnZSQEa+4dRVPDoWpDd2q8314HXopQ9lM3aR+djOU/kbPxIJ4f+kkGb
ESgPF7PyjUZAWxsA9Dj/TE113BFOpA==
=+tZC
-----END PGP SIGNATURE-----

--mo2lt322kvpj2dkt--

