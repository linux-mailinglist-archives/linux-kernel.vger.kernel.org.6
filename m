Return-Path: <linux-kernel+bounces-284374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8306495004C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451DD286AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6B813C3CD;
	Tue, 13 Aug 2024 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="bDX0KbfK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="PPd6yOiw"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65AE74063;
	Tue, 13 Aug 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538999; cv=none; b=bVSJiR8Fv929Kzz+LaskLuCOf4oCArs/havHiLiBtn/0JwB/rpjqUkGDIEdwEjO2M+uys7o/aYu9ytYgQ44qIagHCbzmnvBPEPZhToUWRoegKc3pKnFoMOhHdwtwxyUynPHnCFoDZpbkOCD/pvfA/AHAsk5OWuUFbEw59LlwnM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538999; c=relaxed/simple;
	bh=V4WrTgh7MmtFqW9PEtTPb2Mnk/On9500/pADdmBv+YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spyMe28KLWLbALHV3Q515LuUegbrRs35I4+h5ZsKuct5ZzE/tYz00F7rQd8LBoo+lU/7cq/lkNDfd4SFcwaZgvBMCukVBNjjM7B5POzpg3vYArFqpypCe213AKrZEBVffxfy962baw6Bei6NoZkFy7RCf6XHBdnTUM+ZQN9Cn68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=bDX0KbfK; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=PPd6yOiw reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723538996; x=1755074996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cLEFcP5r+oiRTfc8TQfpRiyUkDNMA7o5nOq1zVUjk9A=;
  b=bDX0KbfKZpBCKaBpgWcWra6bJqoigeyypvTEhDA2+cNL8GL9zsfve67O
   egI4DUVRAjfuToi22mPD7hY2itn72Z8TLFAX8a4TH5Pi3iwmqkgD00N8i
   qUr5XHu8XB2Czby7/j73EtoeKufkLP9vcpAZ6qLhAGL2n0AXLv/moQI/T
   6IwwgOxTxMDdjzj7YPUf6FnzB3RLgpvcwutrfV19YifWpeguLWV4vZJuJ
   iaJdSwdqt3jRnmRYiJ+qB3iUeWIJwyufdV/Nyd2zQnFB/n1sFdqLZxs8q
   k+Ea56fB7qZci92HYqGB3IxWMeaii2mJxO+ccjl7sqnp4ECq+AEckyIwO
   g==;
X-CSE-ConnectionGUID: kTgJzGXJQgid59hRvnmnLA==
X-CSE-MsgGUID: J0fTtBl5Steu2rBh11VQTw==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38379655"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 10:49:53 +0200
X-CheckPoint: {66BB1E31-36-751552D8-F91D2344}
X-MAIL-CPID: C06C22A27F7258845CFA44B24CC0BFBA_4
X-Control-Analysis: str=0001.0A782F25.66BB1E31.01A2,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA009164491;
	Tue, 13 Aug 2024 10:49:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723538989;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cLEFcP5r+oiRTfc8TQfpRiyUkDNMA7o5nOq1zVUjk9A=;
	b=PPd6yOiwCqAnrnd1hghnEGC/sKlz+5v32iN04vT6gqMP5yy5Uaf0+gBLTkajj7EKSD86bF
	7CbhwiH/uGK21Sjo95veRNees0kAuY9dEh2Z+9r0y6bvFoxVfhjpSKra5j+yQnJTAPo4kH
	qOO3TreiSZgA5495VHuCwwrGVO3D3b5jFEtJcjJNClLBqUG0ThRr3RM6ay354H7b6w7ZTi
	mU83KW3Z5K01QK02RBHOP4nc2EQJD9YI/G/ZL4P1WLjr/xigGKj90lxiE5Xi8EFgXb+YuQ
	0JvD2uaXCn0uoAXuqdZ2bJSXMipTGKtUOeGdPm1f3PSDUR45IVoMMgvqHGxBbw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Gregor Herburger <gregor.herburger@ew.tq-group.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 15/17] arm64: dts: imx93-tqma9352-mba93xxla: rename hub to usb
Date: Tue, 13 Aug 2024 10:49:51 +0200
Message-ID: <1998267.usQuhbGJ8B@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <1802961.VLH7GnMWUR@steina-w>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com> <20240813-imx_warning-v1-15-3494426aea09@nxp.com> <1802961.VLH7GnMWUR@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Dienstag, 13. August 2024, 10:40:04 CEST schrieb Alexander Stein:
> Am Dienstag, 13. August 2024, 06:35:10 CEST schrieb Frank Li:
> > Rename hub to usb to fix below warning:
> > arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dtb: hub@1: $nod=
ename:0: 'hub@1' does not match '^usb(@.*)?'
> >=20
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>=20
> Thanks.
>=20
> Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Still valid, but there is already https://lore.kernel.org/all/2024080812320=
6.192906-1-festevam@gmail.com/

> > ---
> >  arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts | 2 +-
> >  arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts=
 b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> > index 852dd3d2eac74..325d8097bf7fc 100644
> > --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> > @@ -533,7 +533,7 @@ &usbotg2 {
> >  	samsung,picophy-dc-vol-level-adjust =3D <7>;
> >  	status =3D "okay";
> > =20
> > -	hub_2_0: hub@1 {
> > +	hub_2_0: usb@1 {
> >  		compatible =3D "usb424,2517";
> >  		reg =3D <1>;
> >  		reset-gpios =3D <&expander1 2 GPIO_ACTIVE_LOW>;
> > diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts=
 b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> > index da8f19a646a98..b1fcbc12bd882 100644
> > --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> > @@ -486,7 +486,7 @@ &usbotg2 {
> >  	samsung,picophy-dc-vol-level-adjust =3D <7>;
> >  	status =3D "okay";
> > =20
> > -	hub_2_0: hub@1 {
> > +	hub_2_0: usb@1 {
> >  		compatible =3D "usb424,2517";
> >  		reg =3D <1>;
> >  		reset-gpios =3D <&expander1 2 GPIO_ACTIVE_LOW>;
> >=20
> >=20
>=20
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



