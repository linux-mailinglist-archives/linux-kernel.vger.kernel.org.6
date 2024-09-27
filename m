Return-Path: <linux-kernel+bounces-341308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E94987E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8902859B1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 05:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AF017A92E;
	Fri, 27 Sep 2024 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Bj5SYJBS"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DBA179957;
	Fri, 27 Sep 2024 05:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727416652; cv=none; b=cCfA22dp2v3P5cYo38VxIk+D4aR+DOUKZ77zt3U3FMYSwh5Fc/apA7F7PtfN6BsqlWfQn6IdILE157lF0ZgtEbvYGFNNIqeq66DbgLBP3JAbDqFX6GII0oR42UtrlStdT7ZPi3a/ZPbZJuD+/qNguAFC3weiw2mUIJbsMdPkn2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727416652; c=relaxed/simple;
	bh=H9RTD74ddbmi3cjBhUqyYqgTmv+zK70VnZUBD2ZppfI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nIISSD5Eq2lqbiOi7EnQWsDBIfz5R0WslCWxAnaJtMuZWeaJn3zvbUour3tYh3m5T4SIFVWjC9k1xIwPXDhm5MWPA0m2Xvbrj7z3MNSyBw9ACnGE08lYwmw8J5LVHReXAi3nLC0oXCeJHZ+CDEIFtV8R4jbV+0hcxng8dKpSU54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Bj5SYJBS; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727416648;
	bh=eGQo/HTGjs3ISaIHu6Q8vT0fMKDRuGcwPfT4rFP9Omc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Bj5SYJBSHeTkNGOeTLidEjQytHkORHTbweHdN0NHnLekD0t4Rs2tqz1ONv0KhUFsY
	 lLGDgZ+YgtK03IReFtcwJJdLBMABgMAwF1VxVK1l9vyFDYK1yu/o4a9WT/IOyZH9JV
	 JYC9WxKzvgcktRgfXhy3XtzDnZ0uKZPdDRtg34msQ/01UgyFFjP1ew4Jvah9PNuOSd
	 5tb23z9fM3HdfgqmnJa5cBeXiZvZtXi+Qqb2/ms8x5cXD61UUBUJ3DWIEWGoDu6yNR
	 +6Eitm5VBPJAJ7Q+o5Ewiym/fFSnMF1t8uqUw+lC624/gQtSB7Rws93GufUmzwpci5
	 rJ4+rmTd5/iLw==
Received: from [192.168.68.112] (ppp118-210-187-73.adl-adc-lon-bras34.tpg.internode.on.net [118.210.187.73])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B483A65029;
	Fri, 27 Sep 2024 13:57:27 +0800 (AWST)
Message-ID: <fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD
 IOE on Spider Board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 27 Sep 2024 15:27:25 +0930
In-Reply-To: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-26 at 10:41 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
>=20
> Add I2C mux for CPLD IOE on Spider Board.
>=20
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 98477792aa00..ea1a9c765483 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -17,6 +17,9 @@ aliases {
>  		serial6 =3D &uart7;
>  		serial7 =3D &uart8;
>  		serial8 =3D &uart9;
> +
> +		i2c28 =3D &imux28;
> +		i2c29 =3D &imux29;
>  	};
> =20

Have you tried to apply all of your individual yosemite4 patches
together in one branch? I have, and unfortunately I can't apply them
all, because they generate conflicts with each other.

If your patches have context dependencies you need to send them as a
single series and not separate patches that cannot be properly
combined.

Please assess the remaining yosemite4 devicetree patches (those you
haven't received a thank-you email for) and send an appropriately
constructed series so they can all be applied together, based on the
tree here:

https://github.com/amboar/linux/tree/for/bmc/dt

Please also indicate in the cover letter (with links to lore) which
remaining patches are truly independent that still need to be applied.

Thanks,

Andrew

