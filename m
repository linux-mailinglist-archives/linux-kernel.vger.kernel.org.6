Return-Path: <linux-kernel+bounces-408996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3EB9C8627
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E9C288237
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E18E1632F2;
	Thu, 14 Nov 2024 09:29:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DAC1E8859
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576575; cv=none; b=CRSTwRQE1T477GYoB2v6rXsHAM07S0rSxwTrMD17/JG1vCa3O4DgeGF48ViqfbiXvI6PHo72hmddps2HM3U8KeybkrcU97E7VlenN+QbVj1ytNHTry7ff+KUZCDDHxmOsVdOB9DGNoCARqSNi2w26vniHiW0tgxjnq/Hqmg7fAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576575; c=relaxed/simple;
	bh=8Yd0/TEJi56FeR8EgbegfxdHTlDuoiPPyVHul7cJxB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJvOOoupizzpFZ+7oUk7Gs6RAK8p/MXRAfU9lBz+MAFQTl3KyO6qQow/mmGDjUELOIhma89SKxvnESukiJm6c7au5I/WnR0CxcYpSbzv3+md/zb8XcQtHK7V/90on9WJMrfbj/9zGxkXEwKTEjIsFj296eFkAvI56qm0SU6bAUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBWA6-0001EK-Eg; Thu, 14 Nov 2024 10:29:14 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBWA6-000icz-02;
	Thu, 14 Nov 2024 10:29:14 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 98E12372F4A;
	Thu, 14 Nov 2024 09:29:13 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:29:13 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Charan.Pedumuru@microchip.com
Cc: krzk@kernel.org, mailhol.vincent@wanadoo.fr, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, Nicolas.Ferre@microchip.com, 
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: net: can: atmel: Convert to json schema
Message-ID: <20241114-magnetic-eggplant-elephant-14e724-mkl@pengutronix.de>
References: <20241003-can-v2-1-85701d3296dd@microchip.com>
 <xykmnsibdts7u73yu7b2vn3w55wx7puqo2nwhsji57th7lemym@f4l3ccxpevo4>
 <cd3a9342-3863-4a81-9b09-db7b8da1d561@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ia4wiuv7bjc5o7j2"
Content-Disposition: inline
In-Reply-To: <cd3a9342-3863-4a81-9b09-db7b8da1d561@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ia4wiuv7bjc5o7j2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] dt-bindings: net: can: atmel: Convert to json schema
MIME-Version: 1.0

On 13.11.2024 05:30:53, Charan.Pedumuru@microchip.com wrote:
> On 03/10/24 14:04, Krzysztof Kozlowski wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >
> > On Thu, Oct 03, 2024 at 10:37:03AM +0530, Charan Pedumuru wrote:
> >> Convert atmel-can documentation to yaml format
> >>
> >> Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
> >> ---
> >> Changes in v2:
> >> - Renamed the title to "Microchip AT91 CAN controller"
> >> - Removed the unnecessary labels and add clock properties to examples
> >> - Removed if condition statements and made clock properties as default=
 required properties
> >> - Link to v1: https://lore.kernel.org/r/20240912-can-v1-1-c5651b1809bb=
@microchip.com
> >> ---
> >>   .../bindings/net/can/atmel,at91sam9263-can.yaml    | 58 ++++++++++++=
++++++++++
> >>   .../devicetree/bindings/net/can/atmel-can.txt      | 15 ------
> >>   2 files changed, 58 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/can/atmel,at91sam92=
63-can.yaml b/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-c=
an.yaml
> >> new file mode 100644
> >> index 000000000000..c818c01a718b
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.=
yaml
> >> @@ -0,0 +1,58 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/net/can/atmel,at91sam9263-can.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Microchip AT91 CAN Controller
> >> +
> >> +maintainers:
> >> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> >> +
> >> +allOf:
> >> +  - $ref: can-controller.yaml#
> >> +
> >> +properties:
> >> +  compatible:
> >> +    oneOf:
> >> +      - enum:
> >> +          - atmel,at91sam9263-can
> >> +          - atmel,at91sam9x5-can
> >> +      - items:
> >> +          - enum:
> >> +              - microchip,sam9x60-can
> >> +          - const: atmel,at91sam9x5-can
> > That is not what old binding said.
>=20
> Apologies for the late reply, the driver doesn't have compatible with=20
> "microchip,sam9x60-can",
> so I made "atmel,at91sam9x5-can" as fallback driver

I think a better answer is:

The CAN IP core on the microchip,sam9x60-can is compatible with the IP
core on the "atmel,at91sam9x5-can".

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ia4wiuv7bjc5o7j2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc1wuYACgkQKDiiPnot
vG9Sqgf9G/Fg9mjf2UZVGGZWrYCj65mGdUNZgeVJfWBMxLzfrrBzSbDoC7BHvtk8
kTCC4Q9xW18ne3S9xbZBACX/9j3Sn9+r5DPQDo2Nd04p6w1qAzkgdoMsgZw9M8CU
uPbHPsWCqpG6ZyJnDWYYnRcI0DLozdRYeNH+3IJN0FIV9PQUXth6n51mak0eCgei
xCtAqR+8ggUrebUlyuw6MddiZFStgeCFGmqnoxKk3TAz7OdwnPlb+mUDux+1Grpo
GZEM6MMr4bqEtGjXxjXb72nmvcL3LpyE6NVDjvtKILQX03nARds7ZGuSXshaDj84
aN65bsQb3LbFLmqNiBOcJPb1OGHRRg==
=bN37
-----END PGP SIGNATURE-----

--ia4wiuv7bjc5o7j2--

