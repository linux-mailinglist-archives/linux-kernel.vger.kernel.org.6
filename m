Return-Path: <linux-kernel+bounces-559551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD90A5F573
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9C93A8BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC34A267B6B;
	Thu, 13 Mar 2025 13:06:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45F1267B62
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871188; cv=none; b=iLPrzXXhApHYF9P/wovLtoIj0FPEvK6BM5Ksg9+iEXf5PRRB3iMG6PD/2al0ntOMziFsSCotq/WMgrG1VeHvpj3Ry6I7mXXqUCsaxYQqZugK+SO8Nn7PpuikB1O2Z2ZwojWltLKw3kD+w65aPRe/WkYfhR4FDoF6dsTPDPN30Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871188; c=relaxed/simple;
	bh=6zXjh1h2grdtWlh32q/xSiG2WPMUoNGZUBzmL6hMRUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CH9NkgUgr9T3nsQ8mePJCYTtUFY06OgifyTjsAwqcwpa+9qmjT/lTiiVGI7BptgnVc+D/V/vIIA+L911lpvioliSoDpBQ1TFQVeH2MSPEwL3nKKiO/lLC8+F1eML5R8VkrxkbEJwftIkMvYDUCusqANLpcx9r4p2J1N4gDvOo84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tsiGM-0001HM-Ri; Thu, 13 Mar 2025 14:06:14 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tsiGL-005XTg-2Z;
	Thu, 13 Mar 2025 14:06:13 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tsiGL-0009sV-2J;
	Thu, 13 Mar 2025 14:06:13 +0100
Message-ID: <c27ab4ca4563d20a73ffc8a577f960fe59ffa88f.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] reset: Add USB2PHY control driver for Renesas
 RZ/V2H(P)
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Prabhakar
 <prabhakar.csengg@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Magnus Damm <magnus.damm@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Biju Das <biju.das.jz@bp.renesas.com>,  Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Chris Paterson
 <Chris.Paterson2@renesas.com>
Date: Thu, 13 Mar 2025 14:06:13 +0100
In-Reply-To: <TY3PR01MB12089B78E1DE163B740A51134C2D32@TY3PR01MB12089.jpnprd01.prod.outlook.com>
References: 
	<20250305123915.341589-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
	 <20250305123915.341589-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
	 <30b6841b3ce199488698ab272f103a0364adb000.camel@pengutronix.de>
	 <TY3PR01MB12089B78E1DE163B740A51134C2D32@TY3PR01MB12089.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Fabrizio,

On Do, 2025-03-13 at 10:14 +0000, Fabrizio Castro wrote:
> Hi Philipp,
>=20
> Thanks for your feedback!
>=20
> > From: Philipp Zabel <p.zabel@pengutronix.de>
> > Sent: 13 March 2025 08:37
> > Subject: Re: [PATCH v2 2/2] reset: Add USB2PHY control driver for Renes=
as RZ/V2H(P)
> >=20
> > On Mi, 2025-03-05 at 12:39 +0000, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >=20
> > > Add support for the USB2PHY control driver on the Renesas RZ/V2H(P) S=
oC.
> > > Make the driver handle reset and power-down operations for the USB2PH=
Y.
> > >=20
> > > Pass OF data to support future SoCs with similar USB2PHY hardware but
> > > different register configurations. Define device-specific initializat=
ion
> > > values and control register settings in OF data to ensure flexibility
> > > for upcoming SoCs.
> > >=20
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> > > ---
> > >  drivers/reset/Kconfig                    |   7 +
> > >  drivers/reset/Makefile                   |   1 +
> > >  drivers/reset/reset-rzv2h-usb2phy-ctrl.c | 223 +++++++++++++++++++++=
++
> > >  3 files changed, 231 insertions(+)
> > >  create mode 100644 drivers/reset/reset-rzv2h-usb2phy-ctrl.c
> > >=20
[...]
> > > diff --git a/drivers/reset/reset-rzv2h-usb2phy-ctrl.c b/drivers/reset=
/reset-rzv2h-usb2phy-ctrl.c
> > > new file mode 100644
> > > index 000000000000..a6daeaf37e1c
> > > --- /dev/null
> > > +++ b/drivers/reset/reset-rzv2h-usb2phy-ctrl.c
> > > @@ -0,0 +1,223 @@
[...]
> > > +static const struct rzv2h_usb2phy_regval rzv2h_init_vals[] =3D {
> > > +	{ .reg =3D 0xc10, .val =3D 0x67c },
> > > +	{ .reg =3D 0xc14, .val =3D 0x1f },
> > > +	{ .reg =3D 0x600, .val =3D 0x909 },
> >=20
> > What are these registers and what are those values doing?
>=20
> Unfortunately, there are some licensing restrictions on this IP, this is
> the best that we can do, as per the license agreement.

How am I expected to review this?

For now, I'll assume that these registers are not related to reset
functionality at all, and that this driver should be a phy controller
driver instead of a reset controller driver.

Can you convince me otherwise without breaking license agreements?

regards
Philipp

