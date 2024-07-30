Return-Path: <linux-kernel+bounces-266744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F7094062C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BAD1F226DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 04:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B071487DF;
	Tue, 30 Jul 2024 04:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="e13R1Vy+"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D8C184E;
	Tue, 30 Jul 2024 04:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722312053; cv=none; b=OVhZHFgWGmdju0TVjtcs0/6z4htPztQBY2TpZADVV+pqS2rq81XQa/9Vc4FfAlBfBlhkR39gZJ6Op1+9/SCc8QBisyibXQ7F83x1FMR2uXKu7newegYRlgdIlP/AR+t/md6mp+mNGXMoaKtOt6xMoWS9e23iGTxZ+QYjqJIrSpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722312053; c=relaxed/simple;
	bh=V+2IMn+plI9jREalFO30lzjVnTMgvNBJe9ZAQbA5Ku0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HYem3K0KTKg+UZ2P1mGH0KwwXmxv1vpcoTNtrGwt0Eyo4H5j5wrk1cT/oe7GtXnxDlTMVBqrSpWdSP1xKX1uFvrKxyoyxRt8/FhBqn9xhYuec7ngsCgzFuNVaA6IsZzajgC1L1V7Ci4YCUyAbGaugN2dkqxz+qxnWTpJzLFt4nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=e13R1Vy+; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722312049;
	bh=5hs93budehkzX9Q4D8B3eGfGDY0os2f4EhftOfeCigs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e13R1Vy+J5d8003I6X1CnM/oqYsLT6/EihQCuFuwUR4eEke67bbdSoF1TEMbhHnow
	 CLDFmdu6LFCPaL698kMpxw26JHv8Z+g3ahrWRQaWUu7sgACCGK9APgxwcSZpT6xOTd
	 OeXas52U+XyqKFXQYkNpUUd/SLK+Tqssu2juDTM/qku27sU0iBi0SHc8XIxVXfwYp4
	 /myOiiDoIt9KzGcvkYrXXVKZSfmsHDmBrDr/Cb9dQgZSKW2Q4TxZW5W4DR/Do6mvuk
	 cuRuWfA4lfmDdR0QHvzrSgFRZ0ffBorraK80LDiSl5ovWZRyHxcd0pIB8lYDFUc94G
	 WXes2/532E6Jw==
Received: from [192.168.68.112] (ppp118-210-29-70.adl-adc-lon-bras31.tpg.internode.on.net [118.210.29.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6A0B866CD3;
	Tue, 30 Jul 2024 12:00:48 +0800 (AWST)
Message-ID: <87dc3f83dfd85c2d6b81fb28b9058d59efc6b2c6.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Patrick Williams
 <patrick@stwcx.xyz>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,  Cosmo Chou
 <cosmo.chou@quantatw.com>, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, Conor Dooley <conor+dt@kernel.org>, Potin
 Lai <potin.lai@quantatw.com>, Joel Stanley <joel@jms.id.au>, Conor Dooley
 <conor.dooley@microchip.com>
Date: Tue, 30 Jul 2024 13:30:47 +0930
In-Reply-To: <CAGfYmwVSd846mX=WwhPu9dzZ0-d92jEzWG=dbDA+hQP+25uC9A@mail.gmail.com>
References: <20240726-potin-catalina-dts-v5-0-8f02305af527@gmail.com>
	 <172199921421.1507234.14901757413141840919.robh@kernel.org>
	 <6d73dcf20c726ad59e2aa16e507af17b3af59c42.camel@codeconstruct.com.au>
	 <CAGfYmwVSd846mX=WwhPu9dzZ0-d92jEzWG=dbDA+hQP+25uC9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-29 at 09:50 +0800, Potin Lai wrote:
> On Mon, Jul 29, 2024 at 9:17=E2=80=AFAM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > Hi Potin,
> >=20
> > On Fri, 2024-07-26 at 08:09 -0500, Rob Herring (Arm) wrote:
> > > On Fri, 26 Jul 2024 18:26:48 +0800, Potin Lai wrote:
> > > > Add Linux device tree entry related to Meta(Facebook) Catalina spec=
ific
> > > > devices connected to BMC(AST2600) SoC.
> > >=20
> > ...
> > >=20
> > > My bot found new DTB warnings on the .dts files added or changed in t=
his
> > > series.
> > >=20
> > > Some warnings may be from an existing SoC .dtsi. Or perhaps the warni=
ngs
> > > are fixed by another series. Ultimately, it is up to the platform
> > > maintainer whether these warnings are acceptable or not. No need to r=
eply
> > > unless the platform maintainer has comments.
> > >=20
> > > If you already ran DT checks and didn't see these error(s), then
> > > make sure dt-schema is up to date:
> > >=20
> > >   pip3 install dtschema --upgrade
> > >=20
> > >=20
> > > New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-=
catalina.dtb' for 20240726-potin-catalina-dts-v5-0-8f02305af527@gmail.com:
> > >=20
> > >=20
> > ...
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/b=
us@1e78a000/i2c@100/i2c-mux@70/i2c@2/pwm@21: failed to match any schema wit=
h compatible: ['maxim,max31790']
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/b=
us@1e78a000/i2c@100/i2c-mux@70/i2c@2/pwm@27: failed to match any schema wit=
h compatible: ['maxim,max31790']
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/b=
us@1e78a000/i2c@100/i2c-mux@70/i2c@3/vrm@60: failed to match any schema wit=
h compatible: ['isil,raa228004']
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/b=
us@1e78a000/i2c@100/i2c-mux@70/i2c@3/vrm@61: failed to match any schema wit=
h compatible: ['isil,raa228004']
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/b=
us@1e78a000/i2c@100/i2c-mux@70/i2c@3/vrm@62: failed to match any schema wit=
h compatible: ['isil,raa228004']
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/b=
us@1e78a000/i2c@400/ipmb@10: failed to match any schema with compatible: ['=
ipmb-dev']
> > ...
> >=20
> > The snipped errors are mostly from the DTSI, but these errors above are
> > specific to your DTS. Can you please address them?
> >=20
> > Andrew
>=20
> Hi Andrew,
>=20
> I tried to follow exist dts files to add the compatible strings, but
> all of them are showing error when I manual running "make ARCH=3Darm
> CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-catalina.dtb".
>=20
> - "ipmb-dev": arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts at l=
ine 432
> - "max31790": arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts at l=
ine 196
> - "maxim,max31790": arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts
> at line 511
> - "isil,raa229004": arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
> at line 512
>=20
> And there is no .yaml file for these drivers to check the proper
> compatible string.
> Do you have any suggestions in this case? Thank you.

Yes, please don't add any more cases of these warnings :)

Either get the bindings merged for these devices, or drop these nodes
from your devicetree (... and add them back later once the bindings are
merged).

Cheers,

Andrew

