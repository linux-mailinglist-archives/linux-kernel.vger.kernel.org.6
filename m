Return-Path: <linux-kernel+bounces-291299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C9395609A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B9F1C20D62
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761E418638;
	Mon, 19 Aug 2024 00:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="d6FSQom6"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3161E12B8B;
	Mon, 19 Aug 2024 00:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724028412; cv=none; b=kIizhhkB+NQscqMbl3QIEZlZ7ebwQDp2gmwp37/+b/9uMwFHRtaqrvq5MMyaKVCg9HdWNIn/m+cllMRSnikqfFRunSR0EuWCw+BQIvWZgoo3iOojYKxDkix0xDoPpQMVm3lJozrxGkN/Z6g18fd7UpXtI0ngMkKpUs+vg7GzdcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724028412; c=relaxed/simple;
	bh=jrPlZbE7LoOXj9mQ/5B3ZcNxT0IT0z22GvomMwFyG3s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ic1Qv7yeoIsMomx9Xu2f7eBZ8wIPXGK96e16UUUwRxv6Ilyc4+6UyfDU7M2dfeHTXyQ8ju+rUWmFJ51x7yYiGHUsijLO1lp9FVagn6Mf/GqZATDVh+0ZqASqOouHQZ8jI1MeWAxd2EhLmhtBj0BmFE5yKfqhdy6BLgM3WTGpJ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=d6FSQom6; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1724028409;
	bh=bGQ/6crBzg1SbZu2JoYzHaThvgd+RzBseuDcIcIe2/c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d6FSQom6vPscKpKyn+aa9H1ffN0cbZnR+trtLKlJP5NDfPyXrBiZQKZHvEEEW85t6
	 YFAQQUpeLSJOlDDeUIPSTY/thcWl/Afekd5eOmH3A1abvnSzvZGkwVVE8rIKVEqvOg
	 Jh69GK+5eFcvKtqIzjzpfIPRo349wiljHq4PwcK00STHCyFKA7XWIxHw2JDhIUJeBt
	 W7NV3CVCBOtnwrP1J/EolVj9wSUAKqwcaRIoLgjmWqdxXtJPH0MPP/fwx5gl1P/20X
	 KqfQsR0gvSqdGd8jP3edagqSwQz1ovZ3UFm8/41GJwfVrKc9g18SwD9jCTxyd0c13U
	 Xm/18aoskkNrQ==
Received: from [192.168.68.112] (ppp118-210-94-119.adl-adc-lon-bras32.tpg.internode.on.net [118.210.94.119])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2CC2A64BE9;
	Mon, 19 Aug 2024 08:46:48 +0800 (AWST)
Message-ID: <aa4a9c154f54a2f1b5b55fa80bdd2e14aa3d1b3b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v12 18/28] ARM: dts: aspeed: yosemite4: add mctp config
 for NIC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Aug 2024 10:16:47 +0930
In-Reply-To: <20240816092417.3651434-19-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240816092417.3651434-19-Delphine_CC_Chiu@wiwynn.com>
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
> add mctp config for NIC
>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index b46a0b9940e2..7b8a2384d99d 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1281,40 +1281,64 @@ imux24: i2c@0 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0>;
> +			mctp-controller;
>  			temperature-sensor@1f {
>  				compatible =3D "ti,tmp421";
>  				reg =3D <0x1f>;
>  			};
> +
> +			temperature-sensor@3c {
> +				compatible =3D "smsc,emc1403";
> +				reg =3D <0x3c>;
> +			};

These nodes are unrelated to MCTP? Given we're assembling the puzzle
via the jigsaw pieces in the rest of the series, please split the
addition of these nodes out to a separate patch.

Further, the EMC1403 compatible is undocumented as of v6.11-rc1, and a
brief search didn't turn up anything on the lists. Please send a patch
adding it to the trivial-devices binding document.

Andrew

