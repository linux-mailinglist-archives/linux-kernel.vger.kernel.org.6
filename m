Return-Path: <linux-kernel+bounces-325943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4252976000
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1332E1C22D23
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAAF187843;
	Thu, 12 Sep 2024 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="CYOpulRW"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4199F320E;
	Thu, 12 Sep 2024 04:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726115685; cv=none; b=PzYGJnQZT2lgrF82+6banj7Pd3w5OxAEzSd0I1A3yG9eXP+5t7cUBxQR1W9JY8iViqAbpM8kIKF5+fNiTGf0JoOXiqaCoXNOo+P4/dFhyIb/wDXoF4ofM0OJ1ezPCI6HqXpWjImiURV3zJmeKVrhQ3eI7cnPYH+qozqIatpBSCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726115685; c=relaxed/simple;
	bh=z0Pe99FV4dd/NXlx9NQeYtmKtiklY5Q6Dx7uO/3zwOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=awMfDQurYLljSDQdBaEjDjLkvzCoPXtnGdk5mlCn30SZxjjT/rKAxsSLRCe8Ab+6/4O+KuWAJdpsx+A/eom5jrM768uFA3R+FjU7Zd8BenSA5vy8YrodKAVNTy6aszI8WfcdYi3RkjJ2iVB3yvsGzQPGD/8RpaMjdvX1sIypVwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=CYOpulRW; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726115681;
	bh=qaPDBs60GYvv9drlrAghEXB5v3hfoGAd/AfA0tP8YIM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CYOpulRWGFuI+h8s9pPoqXUJAIWgXxPKdw1zPUUUTZ64tybehBDYGbE9/yUyQszDA
	 2xbNwmBjzOVdeD8GxcsyY1dsStnWWFQnX4Nl61PsHTvbxGF8CD8/jwS4Byi4EUyZf5
	 1Jp5tWLSiPaMVXz0tBSx90bXNJbRrnP851ptO7sn/gJWEPFjQ/Astu4hLAeUPvYl4b
	 LG2l8B2by2JU00n67VZTFOQaeiVMpblDyfGeiITmsBdRFwEsI8EzqZ0H7VHciMEuv9
	 8nrUVOY4IL/tN0ZRJM3xjdZn9naV+C+X+cf7vXDh9G3QtlVnsJb+BtwDYXrQ/9P8Ao
	 nrbTolkhOgILw==
Received: from [192.168.68.112] (ppp118-210-89-8.adl-adc-lon-bras32.tpg.internode.on.net [118.210.89.8])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7656964FDD;
	Thu, 12 Sep 2024 12:34:38 +0800 (AWST)
Message-ID: <24ab22b5403adb379f942b3dadb8f49b54f28bb0.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: mtmitchell: Add I2C FAN
 controllers
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Chanh Nguyen <chanh@os.amperecomputing.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, OpenBMC
 Maillist <openbmc@lists.ozlabs.org>, Open Source Submission
 <patches@amperecomputing.com>
Cc: Thang Nguyen <thang@os.amperecomputing.com>, Phong Vo
	 <phong@os.amperecomputing.com>, Khanh Pham <khpham@amperecomputing.com>, 
	Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 12 Sep 2024 14:04:37 +0930
In-Reply-To: <20240905063521.319416-2-chanh@os.amperecomputing.com>
References: <20240905063521.319416-1-chanh@os.amperecomputing.com>
	 <20240905063521.319416-2-chanh@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-05 at 06:35 +0000, Chanh Nguyen wrote:
> Add the MAX31790 nodes as i2c fan controllers.
>=20
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
>  .../boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/=
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> index 0295f5adcfbc..da181f9ae820 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> @@ -684,6 +684,16 @@ bmc-ocp0-en-hog {
>  			line-name =3D "bmc-ocp0-en-n";
>  		};
>  	};
> +
> +	fan-controller0@20 {
> +		compatible =3D "maxim,max31790";
> +		reg =3D <0x20>;
> +	};
> +
> +	fan-controller1@2f {
> +		compatible =3D "maxim,max31790";
> +		reg =3D <0x2f>;
> +	};
>  };

This generates some warnings based on v6.11-rc1:

Executing: ./scripts/checkpatch.pl --strict -g HEAD                        =
                                                                           =
        =20
WARNING: DT compatible string "maxim,max31790" appears un-documented -- che=
ck ./Documentation/devicetree/bindings/                                    =
        =20
#25: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts:689:  =
                                                                           =
        =20
+               compatible =3D "maxim,max31790";                           =
                                                                           =
          =20
                                                                           =
                                                                           =
        =20
WARNING: DT compatible string "maxim,max31790" appears un-documented -- che=
ck ./Documentation/devicetree/bindings/                                    =
        =20
#30: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts:694:  =
                                                                           =
        =20
+               compatible =3D "maxim,max31790";                           =
                                                                           =
          =20
                                                                           =
                                                                           =
        =20
total: 0 errors, 2 warnings, 0 checks, 16 lines checked

However, Guenter's applied the binding here:

https://lore.kernel.org/all/3382f952-daae-43ff-bb85-fa4820ecbc5f@roeck-us.n=
et/

`make CHECK_DTBS=3Dy aspeed/aspeed-bmc-ampere-mtmitchell.dtb` didn't turn
up anything interesting after merging in hwmon-next, so I've applied
these to be integrated via the BMC tree.

Andrew

