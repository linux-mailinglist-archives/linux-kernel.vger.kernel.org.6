Return-Path: <linux-kernel+bounces-346912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F1998CAF7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DD21F23BDE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D47623BB;
	Wed,  2 Oct 2024 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="BWM7+oZ3"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9F17D2;
	Wed,  2 Oct 2024 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833674; cv=none; b=ZioZZQ3AalMF+Zklu6Nt+SSVUwm73DFttkJXFfFsKOgokANvqBomqGjl8HuZAICzXDmx2qe5qXCq1h3L+l8gRVURWm0bHdS0TeTnVZW/0O4QoPwn3aPRTYkkhKmF9KdOedlEKZhwtja1BeB+rgZWCtMFHatwUzpayRJOI0Ol8X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833674; c=relaxed/simple;
	bh=eTVz+Ij1GpdJVeXuJgTs6dRLlqV2z0uudkTu70TL7h8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cdwxybiZChg2XDwUehYQngzcepr9fDymegV+Q1Q1P38odjCgu82j3zodWK0jCIZOuPI7+mrttIN+QCzgiVs2nSFdzpBmBZk8netSI30XaVlJauY/vDmbwRnIn9HSQi161Zk/Ysk9E1vJ95yqMA9c1wXOJQinZ+PVcOYKHnXjRs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=BWM7+oZ3; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727833670;
	bh=+1Hb3ho1UIWmxjP8x4+K5GqWSB7N2LYWC8IVzjSU3GI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BWM7+oZ3yveLbOZPROEWiCfIr9HEBBjdCN5VDTD3i1LWuxGjAP59l0Co9OOExTYsi
	 Xn59l2f2dVIcX86PT8ZclfBJYHV34ll820EJZe0+HaUdjrfyCmTj4JVlzzXMmSzVuc
	 g9EA54nzkqxAkUg/q4PShsy1nocUkiX2lxdt8OAbgq/vjOQdrzNvip5hlAAD+seH5K
	 GtEartBZwL3RW5Xf8XCQvydjqZSAhWTcv/o/p6psGlMCeefwgslAnhYejzdyYjtZPQ
	 5FtKi8YR0MTte3jb+vpc2kQKE8vVe4cpy7Yav8wBwZeuIK3dvV3yxwvdBdphyTXwXK
	 tbBdk0zdRnToQ==
Received: from [192.168.68.112] (ppp118-210-73-17.adl-adc-lon-bras32.tpg.internode.on.net [118.210.73.17])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3A43565013;
	Wed,  2 Oct 2024 09:47:50 +0800 (AWST)
Message-ID: <ac786013183162b78181de85fd72b1eb7df81e3d.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 2/8] ARM: dts: aspeed: yosemite4: Add i2c-mux for
 four NICs
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>, 
	"patrick@stwcx.xyz"
	 <patrick@stwcx.xyz>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Wed, 02 Oct 2024 11:17:49 +0930
In-Reply-To: <TYZPR04MB585305DCD18AF723B8A48480D6772@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240930070500.3174431-3-Delphine_CC_Chiu@wiwynn.com>
	 <fffb98e40d407c68dc3de6fd21c8a724be96e38a.camel@codeconstruct.com.au>
	 <TYZPR04MB585305DCD18AF723B8A48480D6772@TYZPR04MB5853.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-01 at 07:52 +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
>=20
> > -----Original Message-----
> > From: Andrew Jeffery <andrew@codeconstruct.com.au>
> > Sent: Tuesday, October 1, 2024 8:37 AM
> > To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> > patrick@stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> > <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> > <joel@jms.id.au>
> > Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v1 2/8] ARM: dts: aspeed: yosemite4: Add i2c-mux fo=
r four
> > NICs
> >=20
> >  [External Sender]
> >=20
> >  [External Sender]
> >=20
> > On Mon, 2024-09-30 at 15:04 +0800, Delphine CC Chiu wrote:
> > > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > >=20
> > > Add i2c-mux on Spider board for four NICs and add the temperature
> > > sensor and EEPROM for the NICs.
> > >=20
> > > Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > > ---
> > >  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 75
> > > ++++++++++++++++++-
> > >  1 file changed, 72 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git
> > > a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > > b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > > index dbc992a625b7..b813140b3c5b 100644
> > > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > > @@ -26,6 +26,10 @@ aliases {
> > >               i2c21 =3D &imux21;
> > >               i2c22 =3D &imux22;
> > >               i2c23 =3D &imux23;
> > > +             i2c24 =3D &imux24;
> > > +             i2c25 =3D &imux25;
> > > +             i2c26 =3D &imux26;
> > > +             i2c27 =3D &imux27;
> > >               i2c34 =3D &imux34;
> > >               i2c35 =3D &imux35;
> > >       };
> > > @@ -1196,8 +1200,9 @@ adc@35 {
> > >  };
> > >=20
> > >  &i2c15 {
> > > +     #address-cells =3D <1>;
> > > +     #size-cells =3D <0>;
> > >       status =3D "okay";
> > > -     mctp-controller;
> >=20
> > Why are you deleting this if you're not also deleting the MCTP endpoint=
 node?
> >=20
> > Unless there's some reason this is related to the NICs, this should be =
its own
> > patch with its own justification.
> >=20
> > Andrew
> Hi Andrew,
>=20
> We have discussed with Jeremy from Code Construct about removing the
> mctp-controller on bus 15 before.
>=20
> He thought it would be better to add the mctp-controller on each i2c mux =
port
> so the MCTP driver would ensure that the mux was configured properly befo=
re
> communicating with the device.
>=20
> I'll split a patch to remove the mctp-controller on bus 15 in next serial=
 of patches.

Ah, so having looked through v2, I can see what you're trying to
achieve. I don't think it's necessary to split this out from the NIC
mux patch, they are related.

Andrew

