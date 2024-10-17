Return-Path: <linux-kernel+bounces-369224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ABD9A1A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8B81C214B9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4A417A5BD;
	Thu, 17 Oct 2024 06:13:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98C178CF6
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729145612; cv=none; b=obhi3FsV6yxf1+qSyvXnTdbaLNnfIXSnln1X7cImx+mmWiDtzjrc1D6TBmUJqxiULTY6EBb+lPWmm4fQUSUdGNo5YpYMKgJZmNUTo9Fig5MfF+A8t3qV0GnkFTZ43AKclVXt4mVxOsG2yXF8HwdYyWNIQQ7sA2u1z3xLQbLXN6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729145612; c=relaxed/simple;
	bh=bJKmjLwH9BvfxSNccXi/g5mAmMWF2AY3QT9/gKADG4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euL+9JWJq8AAnMkboN/m1IFg6vU9GqyI2vo/M1W7WvQirGoPEbEZItCkglJ2nQpGgKzBF4bqV88tp7ehmOWunNyZmhkCPLsRe7GW+CKBFcGJdus7K5xPgUK8Z69eJGeVGijjs0+WMW9QT8X+zcuLs1L8I6A33vLW729fiouslpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1Jl5-0005WM-7A; Thu, 17 Oct 2024 08:13:15 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1Jl3-002TsA-4b; Thu, 17 Oct 2024 08:13:13 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C31A1354D07;
	Thu, 17 Oct 2024 06:13:12 +0000 (UTC)
Date: Thu, 17 Oct 2024 08:13:12 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 07/13] net: fec: fec_probe(): update quirk:
 bring IRQs in correct order
Message-ID: <20241017-ambitious-truthful-pegasus-8f1078-mkl@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-7-de783bd15e6a@pengutronix.de>
 <ZxBzT2/SZFhgfPpW@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2r46lw4nlvumw4s4"
Content-Disposition: inline
In-Reply-To: <ZxBzT2/SZFhgfPpW@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--2r46lw4nlvumw4s4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.10.2024 22:15:43, Frank Li wrote:
> On Wed, Oct 16, 2024 at 11:51:55PM +0200, Marc Kleine-Budde wrote:
> > With i.MX8MQ and compatible SoCs, the order of the IRQs in the device
> > tree is not optimal. The driver expects the first three IRQs to match
> > their corresponding queue, while the last (fourth) IRQ is used for the
> > PPS:
> >
> > - 1st IRQ: "int0": queue0 + other IRQs
> > - 2nd IRQ: "int1": queue1
> > - 3rd IRQ: "int2": queue2
> > - 4th IRQ: "pps": pps
> >
> > However, the i.MX8MQ and compatible SoCs do not use the
> > "interrupt-names" property and specify the IRQs in the wrong order:
> >
> > - 1st IRQ: queue1
> > - 2nd IRQ: queue2
> > - 3rd IRQ: queue0 + other IRQs
> > - 4th IRQ: pps
>=20
> why not fix dts?

Because of compatibility. You could update the fec driver and try to
detect if the IRQs in the DTS are in the "correct" order, but the new
DTS will be incompatible with the old driver.

I'm working on a patch series that updates the fec driver to "per queue
IRQ and NAPI" handling. For this approach it's crucial that the IRQs
match the queue number.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2r46lw4nlvumw4s4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcQqvUACgkQKDiiPnot
vG/FCgf+NP/8LkAHc+Nfss/bVYAT8KoQgWzYCPN8uEae0UzcD16U3VfZMyUL9uz5
HNyeWG9F3p0ZZlP0pTGtOH983B8dF7u9Qdto1sW2wtz829MekSmZ/mx7YKvTbufu
9E7nztKVHzNoeEskHBuf9XO8xJ1VICvBM3idGnjkGWfWGZBL0kODkvGi21PFgvxE
29RUnJ1XZFkQ2zAsEBoWBKq/qLuUsTB2EknxUkD6LY6c8dX0vdq4YhlV5FhI2llt
nQiYuCnU8RIzyi+z9Lhd82UUsNtwissO3n3IdtvyhKQzpA2XBYOPCjBmEyMXKFzr
uz+6oikrCX6775/ofot97615bfc01g==
=Pxnm
-----END PGP SIGNATURE-----

--2r46lw4nlvumw4s4--

