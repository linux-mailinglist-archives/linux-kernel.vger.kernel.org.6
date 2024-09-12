Return-Path: <linux-kernel+bounces-325848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F75D975EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7381C21F94
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012F55028C;
	Thu, 12 Sep 2024 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="G1c8nAHP"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C2250EC;
	Thu, 12 Sep 2024 02:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726108446; cv=none; b=QhhmNwewvZ2/ZLQJOIY1drogiPBBYEzx0KQzx12IAfXIkC3UW7cJK0jFdSecMQjkmN0RdPVKt42egmV3ekUEB65Si/VCAhwNn9foC65DaA35pdc7hdBHpfjfxz6/+nTp7kWQmZOwqGa+kmm1rFvi4OZ4i1UmDtod1sSsk0EbRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726108446; c=relaxed/simple;
	bh=kzdpGYHpR8t+EWCDLyPinUUmiIWAsZAqeNVqny4dfw4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZfPixh4udoa8M15CHJtvYcoscu1oeTF1JKiftXvrULN9bKW8JlyDjy8e/T8ynz0UPhRCONxxI0fncyklsL8kNsit9DnYZYBXHMdce6dCIR/UDg1SX/ZDVcMpNOWqHyeNXl0IQ3kyjzk+6d0qtrEdGF91UCVnuDkr9jAR5liDf6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=G1c8nAHP; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726108442;
	bh=7YUclhj44Kyj9d/lxkh3kctrbYaslwM23zCN0mCChZM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G1c8nAHP2+fWZgBrge/Lwz4XFo2Gch36lC54YlL0QKvRBbPfHBnG683b6H+gdN/5f
	 jL8OaGge60Bt9Bns2329yAR2KG2IwmvYNKVqD8CF6m9R0QOk2f+GIaNb6QvvHIyYs8
	 0KhJ4fSoKajZX8HISAuoncmrDA7xh+XjxNA24T+nZsPq8Th//cV450FS5QT8lr/fM4
	 MrdemVOky131UXBHUA1KID5dRASIAvnCHGSZATdqcNXAAWw0f4kacX9bsp1coLSJ24
	 ZwjX3UaSKqp0wEkchahAGOoklBKRF27+NCKh2GmKiITFxAQzXZkD379L4zUMFG1dfo
	 N1XhNR6Yid/VQ==
Received: from [192.168.68.112] (ppp118-210-89-8.adl-adc-lon-bras32.tpg.internode.on.net [118.210.89.8])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 177FB650D6;
	Thu, 12 Sep 2024 10:34:02 +0800 (AWST)
Message-ID: <39630cb9cf923eec6d8e229aea4e6fc5980aa73e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v18 0/3] Add i2c-mux and eeprom devices for Meta
 Yosemite4
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, Ricky CX Wu
	 <ricky.cx.wu.wiwynn@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, devicetree@vger.kernel.org, Joel
 Stanley <joel@jms.id.au>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, linux-aspeed@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, patrick@stwcx.xyz, 
 linux-kernel@vger.kernel.org
Date: Thu, 12 Sep 2024 12:04:01 +0930
In-Reply-To: <172589661042.199175.14634437656639420015.robh@kernel.org>
References: <20240909105420.441607-1-Delphine_CC_Chiu@wiwynn.com>
	 <172589661042.199175.14634437656639420015.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ricky,

On Mon, 2024-09-09 at 10:45 -0500, Rob Herring (Arm) wrote:
> On Mon, 09 Sep 2024 18:54:15 +0800, Delphine CC Chiu wrote:
> > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> >=20
...
> >=20
> > Ricky CX Wu (3):
> >   ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
> >   ARM: dts: aspeed: yosemite4: add mctp config and sensors for NIC
> >   ARM: dts: aspeed: yosemite4: add fan led config
> >=20
> >  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 706 ++++++++++++++++--
> >  1 file changed, 660 insertions(+), 46 deletions(-)
> >=20
> > --
> > 2.25.1
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>=20
>   pip3 install dtschema --upgrade
>=20
>=20
> New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-yose=
mite4.dtb' for 20240909105420.441607-1-Delphine_CC_Chiu@wiwynn.com:
>=20
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: pwm@20: '#add=
ress-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$',=
 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: pwm@2f: '#add=
ress-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$',=
 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@=
1e78a000/i2c@780/i2c-mux@74/i2c@0/gpio@61: failed to match any schema with =
compatible: ['nxp,pca9552']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: pwm@20: '#add=
ress-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$',=
 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: pwm@2f: '#add=
ress-cells', '#size-cells' do not match any of the regexes: '^fan-[0-9]+$',=
 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@=
1e78a000/i2c@780/i2c-mux@74/i2c@1/gpio@61: failed to match any schema with =
compatible: ['nxp,pca9552']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@=
1e78a000/i2c@800/i2c-mux@72/i2c@0/temperature-sensor@3c: failed to match an=
y schema with compatible: ['smsc,emc1403']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@=
1e78a000/i2c@800/i2c-mux@72/i2c@1/temperature-sensor@3c: failed to match an=
y schema with compatible: ['smsc,emc1403']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@=
1e78a000/i2c@800/i2c-mux@72/i2c@2/temperature-sensor@3c: failed to match an=
y schema with compatible: ['smsc,emc1403']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@=
1e78a000/i2c@800/i2c-mux@72/i2c@3/temperature-sensor@3c: failed to match an=
y schema with compatible: ['smsc,emc1403']
>=20

Please either:

1. Remove the offending nodes from your series so we don't add yet more
warnings, or
2. Write appropriate bindings and send them as part of the series

Regarding 1, you can always update the devicetree to add the nodes
after someone else has got the bindings merged. However, if you must
have the nodes, then you need to do 2.

Thanks,

Andrew

