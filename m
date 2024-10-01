Return-Path: <linux-kernel+bounces-345057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD1698B17C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F532822A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF0C33E1;
	Tue,  1 Oct 2024 00:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Qv+AoF4V"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064D4A21;
	Tue,  1 Oct 2024 00:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727743055; cv=none; b=FLzkVCOm3BkAHYt0mBZR7vVI+nrt9ZNkZauMvedSqWJpxDBAs+BHag7Ytz/cf0JNcJ8ouydNbWbYwH8351oL2e7qdNILte+lLQNllpUhvuFYUYnwxHpsNiKKJl7NqpSc8gnnTkW/uaNVqD4xUS3Ilz3jWs5zMEtO+LKT6PPDkN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727743055; c=relaxed/simple;
	bh=8pgn5iqA0aX4iLMtpQIwn80fo+yAcP/kJIHUmoiUSkg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hEwtlyglCWYx5wRHnmdag3ey6Vc5uZgezd4wavTaUZbC/V4j8B10rLj1tg4eHkaLDU+YL+v5ecqKyoxOKJqNzpYwFXGk/xP2FqATCEmjw2yhLu5g6JyDYOXvHAZSGQMam0O36XZ3IAVOUwWi55Gimh+rKzIPHQB75qmCeM+USBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Qv+AoF4V; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727743046;
	bh=0OjlemPLmRuT7L4kYUkhwkgv6/KlB/R9FhMl7U4Cm6c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qv+AoF4Vl27mVWXkSEfa5n3tNY9EbN7iWXbnXw32/EbaTBfUtYCksBpBzwWjJWTSd
	 +JMC4Y5UqPISlYRq0loVXAbMeaDCpmGHottWl/DPco7g5MABRf4GVelqKclegKfZjL
	 rDS130SQ82JT0Cw3tstmSAv8wVXmWclP/nz0Miwhg/0icPaHE6gVR2qRBqAXC7mgh2
	 QihdIi5d3bx/vh/ireLA0QsSFs9jn3rNzt0ZOqc8oGJAQsqr3YajsrUGurTcJzoEA6
	 HoZML6pAs5FXf7wIumejrN9cqilOv1xNWUYNL1JO5GVjaCCwSUwksY1kojGGAltbk2
	 5sQDHAD5MBFdg==
Received: from [192.168.68.112] (ppp118-210-73-17.adl-adc-lon-bras32.tpg.internode.on.net [118.210.73.17])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 04459650AC;
	Tue,  1 Oct 2024 08:37:24 +0800 (AWST)
Message-ID: <fffb98e40d407c68dc3de6fd21c8a724be96e38a.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 2/8] ARM: dts: aspeed: yosemite4: Add i2c-mux for
 four NICs
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 01 Oct 2024 10:07:23 +0930
In-Reply-To: <20240930070500.3174431-3-Delphine_CC_Chiu@wiwynn.com>
References: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240930070500.3174431-3-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-30 at 15:04 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
>=20
> Add i2c-mux on Spider board for four NICs and add the temperature sensor
> and EEPROM for the NICs.
>=20
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 75 ++++++++++++++++++-
>  1 file changed, 72 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index dbc992a625b7..b813140b3c5b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -26,6 +26,10 @@ aliases {
>  		i2c21 =3D &imux21;
>  		i2c22 =3D &imux22;
>  		i2c23 =3D &imux23;
> +		i2c24 =3D &imux24;
> +		i2c25 =3D &imux25;
> +		i2c26 =3D &imux26;
> +		i2c27 =3D &imux27;
>  		i2c34 =3D &imux34;
>  		i2c35 =3D &imux35;
>  	};
> @@ -1196,8 +1200,9 @@ adc@35 {
>  };
> =20
>  &i2c15 {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
>  	status =3D "okay";
> -	mctp-controller;

Why are you deleting this if you're not also deleting the MCTP endpoint
node?

Unless there's some reason this is related to the NICs, this should be
its own patch with its own justification.

Andrew

