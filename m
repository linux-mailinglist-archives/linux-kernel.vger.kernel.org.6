Return-Path: <linux-kernel+bounces-291298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8556956097
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3185B281B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C256D1A28C;
	Mon, 19 Aug 2024 00:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="e180Ns5f"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A0179A7;
	Mon, 19 Aug 2024 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724027582; cv=none; b=AP/13LKKYu7tE/eOZ/92rgoh5+K4bLonVzusVgZ4xm4RyxwHQeRrBW7rOrplHJHcLSE0LlTDMJD8ZlXpMj8vJcMDpG/x9KmSkRgzkE52RLbs79XfA24xZ8Iil5WPziTSrfkhK2Rmr600x6ltYiGV4mvCqU/KLqqeKYXtQa8iuio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724027582; c=relaxed/simple;
	bh=zzyQm492PKP7Tg3nISM9g2C4sTTIE8c5hO9wrKIpXNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H+tje5258jrHJFdSsf13Hett1tGgj6MkcUslMsit8Buste4MgtDDgzmMFUzkLd+fPEyZou3R5eKxW04mtcrXrmgs+VmUqNECL+3uP9jmvCoP/0Gp5hBk0KMmjMny/nGJ7yv42sifsmjA4sNXkV15tKX3/UjXNsIe3kk4lCv2lM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=e180Ns5f; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1724027578;
	bh=FbUkf0vf4nPTxDEKtxyiEBQtf4h9Z61lRGRPcxHrRCU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e180Ns5fDeR7O6FjKC5Nr8lTciKbOX4GAhWdEzYYiveZQ9UI69sOwNU5WgLqBl5O4
	 71OH0FqBXP1LywkmSp+//T2xc4EFK0o1rszv3Xh5M+Rs2dacW/hzeXKAfsnluD+EGu
	 S02ogDYhSOtfmmDMNogppgOTN64+paS1uVR6FnvJmipNETvdxWKeAquvzRBhX2W3Fr
	 A1FRgcqUEslwv5GsKEIAD72KoNDrv76OhKfUeo9rJ/TKEsGlG5AW/pUIsLRAFrYgLT
	 vAUV1U6f7Se/RctoPkJNWTu70wVqp+/H8nT0bVzJI0gzH3UF5mSYFzq9o69WrEx4tR
	 w2NlaoDQ86+3w==
Received: from [192.168.68.112] (ppp118-210-94-119.adl-adc-lon-bras32.tpg.internode.on.net [118.210.94.119])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BE0EC64BE9;
	Mon, 19 Aug 2024 08:32:57 +0800 (AWST)
Message-ID: <2aaf4cc4de2c3ed96400fc5d98e9873ea5ec1411.camel@codeconstruct.com.au>
Subject: Re: [PATCH v12 14/28] ARM: dts: aspeed: yosemite4: Revise ina233
 config for yosemite4 schematic change
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Aug 2024 10:02:57 +0930
In-Reply-To: <20240816092417.3651434-15-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240816092417.3651434-15-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-16 at 17:24 +0800, Delphine CC Chiu wrote:
> Revise ina233 config for yosemite4 schematic change
>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 ++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 1765a0bb70d7..df389b506b4b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1034,28 +1034,38 @@ adc@37 {
>  	};
> =20
>  	power-sensor@40 {
> -		compatible =3D "ti,ina230";
> +		compatible =3D "ti,ina233";

Can you please address my previous comment?

https://lore.kernel.org/all/86a3b58d00fc475065ad51458504a636e2f67e02.camel@=
codeconstruct.com.au/

Andrew

