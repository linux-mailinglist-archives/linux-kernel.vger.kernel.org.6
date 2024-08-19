Return-Path: <linux-kernel+bounces-291297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7016956093
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4EC8281B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036D8179A7;
	Mon, 19 Aug 2024 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="aTzhA+5G"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56990EC2;
	Mon, 19 Aug 2024 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724027435; cv=none; b=siWW2xyjXxU5kpx9Jet4cSlYfAFn3pIAKNx8j0BXpol0hmuDyGIEbZS4inujGyqNcDcDo1QOZl9HN/P7D/q/+LFnv9jyehYZbNCce0JtbzcI2I/N4BYSU/RN1Nn5LLBlbZDf8PRjHgPiDTFMbkvXme5sRGHagUDEHGHD6IwgrJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724027435; c=relaxed/simple;
	bh=HhpLjcme4SOYp9ranQhZwCS26esB0ibLDHj4UVGB5C4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=txxdtpSiK2g8omnZY+NX8TMgZes5X5PBUMdmQNCncA36pU9bblfHe77CkuY17o1OYDK68wX7r+q5VJo/3h5xJfgAGmO2cNPK0f/hGKA+Zc1kOWYNkmRTYa0W2dHgC8gsG25PgXa/oZHrRw0zcMtrVc6ek5Rra6HlbEMx+GJbOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=aTzhA+5G; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1724027431;
	bh=rTGgY3aHExRZzJq6zw8CNonDfFysPyBeT0Xa98FNgtk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aTzhA+5GYEIScmNuzLJPKGaqNO9VJb4wYVYQ4GYkDM1chmPD5TMD6W5DSPGjGu6oT
	 ELZFpl1eRING75F6BpjdYyf5Cya9L+dLPlCcJr42hu0LSAc04FlboAyk/y73L9j6sG
	 bMnXZwa5MlCXXapG9PgO/OYMjRqzwKuQikVcKs27uHFMdNjjhVmnLyXpJ+S/pKFje1
	 ++n8if+sBTBTPUtI+KRscZRZDYRm44b/CfuAhx6//eE+2njVMSaGs/o5lAt+5x6sjN
	 0BZK+Deas7C5ir53q1m5YLkLiNmuzh3jAnfq7yYuaFhHnkWj0rBaW3NqpmpkQQp5R6
	 JZlLqfiGUpmrg==
Received: from [192.168.68.112] (ppp118-210-94-119.adl-adc-lon-bras32.tpg.internode.on.net [118.210.94.119])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6157164BE9;
	Mon, 19 Aug 2024 08:30:30 +0800 (AWST)
Message-ID: <729e650fc7716b8507b19d43979782a7f2c420cb.camel@codeconstruct.com.au>
Subject: Re: [PATCH v12 10/28] ARM: dts: aspeed: yosemite4: Add power sensor
 for power module reading
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Aug 2024 10:00:29 +0930
In-Reply-To: <20240816092417.3651434-11-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240816092417.3651434-11-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-16 at 17:23 +0800, Delphine CC Chiu wrote:
> Add power sensor for power module reading
>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 09bbbcb192f5..139a09de24cf 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -906,6 +906,11 @@ gpio@23 {
>  		"HSC7_ALERT2_R_N","HSC8_ALERT2_R_N";
>  	};
> =20
> +	power-sensor@40 {
> +		compatible =3D "mps,mp5023";
> +		reg =3D <0x40>;
> +	};
> +

This appears to be supported by hmwon but there's no binding for the
driver[1]. I'm hesitant to accept it and add more warnings to the
Aspeed devicetrees, but at the same time I'm sympathetic to leaving it
in.

Can you perhaps send a patch for
Documentation/devicetree/bindings/trivial-devices.yaml along with this
series?

Andrew

[1]: https://lore.kernel.org/all/20211217155206.GA3015782@roeck-us.net/

