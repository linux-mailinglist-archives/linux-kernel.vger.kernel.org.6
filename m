Return-Path: <linux-kernel+bounces-266741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877FA940623
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90C71C21646
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C5C15FD15;
	Tue, 30 Jul 2024 03:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ihpbVfD3"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A61C1474BC;
	Tue, 30 Jul 2024 03:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722311954; cv=none; b=ftseaJj+prbWuH6Xvf3N39Q7M+f3JQnU/kKoKE1qBkpo4iIwOIZBh3tpGRdxxRTQrhHWp3EFyYXqEp1cknyzosGJgYE+KYpJMMJev0Xo+2S7ji+TyMMy7O1b7zXFTQ4mEpVM3c32AXt6vf2xPs6hiaDne9w/2wlKAmOGZXjbcqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722311954; c=relaxed/simple;
	bh=lCEOBMNK6HXjhZZPWMjaCKh7PhpXD5XkbjAdQ8Yyb1I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C94AsEHOnUB0ZoJb9gb4jRASu/aPnKTbVe+Yr8p7fLBDGFVU79I6LmRTtQZnw40IHsp2AcVdpoXfqrxtbJ8nZyAvZdzZU6ZP5H2hLvPevyrwjM88hCRjy+rIVibgd/YQV+OucItCQWth8zjXcrOzhEgRYbEm90D604hcGetFPns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ihpbVfD3; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722311950;
	bh=4mdg6uNPlSlauYbqabzkmGIjQsigmJdCbZUU2fN6GHw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ihpbVfD3yuXOH42/S++YNFoUIDokwIAYeTvYZbGB9bdHqVBHjvnLH28I3V2pJ86lA
	 y18iJjyxGDg8yzdrRjHpLEgT0fgG7x6qBF7IRpAt9Y3flwtEYaj7h+Yosd4IhdLtIS
	 9vmtgi5TRY4l74OpDjOfK5iBDMdNZ9Oqx34uml/e+rasa+g1WP+90IV1ecwkcQz5Rb
	 l+kY/vLikGiw5K3qeYFfVG809nOLDplj4ruFifhJwZvZX5YmvuiGZG/iFXh8PhAwaG
	 MlPnIIdNZ4nBtp3b0TNhCQvgoz5F6pOwxpjvTdCgpKKS0dVfR4Vyy/EiS91S0PdHAv
	 2k+Yu2wzyAaNA==
Received: from [192.168.68.112] (ppp118-210-29-70.adl-adc-lon-bras31.tpg.internode.on.net [118.210.29.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7114966CCF;
	Tue, 30 Jul 2024 11:59:09 +0800 (AWST)
Message-ID: <86a3b58d00fc475065ad51458504a636e2f67e02.camel@codeconstruct.com.au>
Subject: Re: [PATCH v11 20/27] ARM: dts: aspeed: yosemite4: support medusa
 board adc sensors
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Patrick Williams <patrick@stwcx.xyz>, Delphine CC Chiu
	 <Delphine_CC_Chiu@wiwynn.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Date: Tue, 30 Jul 2024 13:29:08 +0930
In-Reply-To: <ZqgTz9DVPcqtTfUC@heinlein.vulture-banana.ts.net>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240723092310.3565410-21-Delphine_CC_Chiu@wiwynn.com>
	 <ZqgTz9DVPcqtTfUC@heinlein.vulture-banana.ts.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-29 at 17:12 -0500, Patrick Williams wrote:
> On Tue, Jul 23, 2024 at 05:23:01PM +0800, Delphine CC Chiu wrote:
> > Add ina233/ina28 support for medusa board adc sensors
> >=20
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > ---
> >  .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts    | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts=
 b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > index 98eeee49b082..49500db53a13 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > @@ -915,6 +915,19 @@ power-sensor@40 {
> >  		reg =3D <0x40>;
> >  	};
> > =20
> > +	power-sensor@41 {
> > +			compatible =3D "ti,ina233";
> > +			resistor-calibration =3D /bits/ 16 <0x0a00>;
> > +			current-lsb=3D /bits/ 16 <0x0001>;
> > +			reg =3D <0x41>;
> > +	};
>=20
> This depends on this unmerged patchset, right?
>=20
> https://lore.kernel.org/lkml/4a1cb223-448c-3e93-eb38-d86f543659e3@roeck-u=
s.net/
>=20
> Please resolve the issues Guenter raised.

Probably best to drop these nodes until those issues are resolved and
the binding patch is merged.

Andrew

