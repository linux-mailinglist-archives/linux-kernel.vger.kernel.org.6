Return-Path: <linux-kernel+bounces-558809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 962DBA5EB80
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5B616B998
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4017B1FAC5D;
	Thu, 13 Mar 2025 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae3th+hd"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E01F4C82;
	Thu, 13 Mar 2025 06:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741846051; cv=none; b=AL4+zpTMPs85Eh3rO2BXJavs9BvR2m6uMEp6oa8IHmpdybHPTpJJ6148j3q5u4uC89yLHbqzrdneNKUoA3hzLzFn3hm+EZAbAsmGnoVOmiHxZKX8P6oSkztXbUha46zZs6f1owdM8H/CSCmLHiPe+QbC2N7lYYO7Q/jIqxm/p18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741846051; c=relaxed/simple;
	bh=oY6o8II9iLNtAxXs2X/GMZFzCo3ZF6DKGHBUDkbm90U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THdoKcWiduw8Yru4UhAAaWe1VdEHlfJz2YMq0mVyKHrte4PNNumQOG49RJVzPKdCBfvnsJPe72DkhpNNHyEL/C6yXhdYnim81Uelv7iLRz0yTlLO+aPF01mG9oey+t5L1UQ0+Iu0ZVzAjV0Pdf5j5rc9uPce5w/sDVuMWEVwPQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae3th+hd; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaeec07b705so93608366b.2;
        Wed, 12 Mar 2025 23:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741846048; x=1742450848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fna2H3vwjdEZcl/b/bY1yvDSI46yeeVTssxA2eJJMgo=;
        b=Ae3th+hdARA643YJcFr1fq9esNJ+vH0UvbX9J1yYsYgA3odzRYk1fBRLjCcWHw3EMK
         Ma/AfBbEc/UVCHmtx0FYOF6B+DszxhhB8XDygEDPPc5gG32FLlx4DikN+4ot0Fb95v33
         kCTGcJJXVOCBplyMpVHR6JRAb7Xk5nR7LgskC3CqBAEgKEVk5R0TeU0wWdcvT3oU/MkE
         OknrQHKuiwOb80pXw0Vx54z+xX3DiftVg4mHUCA7HqQg23KZE+visKWo+pYEUySV7LSK
         1IwsY+1VRDs/PcYF5M1uLw7QwB5HOMV7pYtaa1+Qbbyr/KyN/q7Ewpv7TBK5NogGaFfP
         jMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741846048; x=1742450848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fna2H3vwjdEZcl/b/bY1yvDSI46yeeVTssxA2eJJMgo=;
        b=V5MtN6eGfp3YiWwhCIyEXCX8d9Ev3fmqg7a9izYNEFk8/Tmhx+Y5Ki7VKRBRGl+t3j
         DouHfgt1uisGyRa8vmBaTuGQZJapxJt2/wstxMNmS6Q6oPPqWZjq8vPLkZbspic7Cjjo
         lwUxwufF+fEDAe6TXmc/OEzJxrrCYL3byWFtaXaJpR9B03xJanqKmQk135FiqM+VDp/I
         5u6WFs27lCgUJEMzazZsCze1PESkxsJdkNcpfsi9SgW7+nVncRuh60nZlZBLnhAKCGce
         MgcZxkbSODtyFj72LOGQFY8Xkh6Y4FZdtNPbGkxwvb62Hx5jFjHVZBOTbCs16+K2xQFG
         /hug==
X-Forwarded-Encrypted: i=1; AJvYcCV0bTk7XLK005D88JkkuOalv53NL003062fQVHT9EoCIaM+UAqyEoSngE9hR7XjZgajkjrW/PFw+hwf@vger.kernel.org, AJvYcCWej5YmPzJ1RclZS5ggb11Ht7QXtJx0UD+Cln0Vv4QBhK9vfNzgBRH9GlC67iMpC7bjTXwOvxsOAvThDswY@vger.kernel.org
X-Gm-Message-State: AOJu0YxCnPNwJH+HPnf734rsJXzSEoa3npujQLbk1WdRHYXBQpCiOEfX
	e5Svor4aeMwM1LKuPK5bY9UMtTopA0390NIsqQHgoUI3XDlT06r7
X-Gm-Gg: ASbGncvVYrOGheikTY5HhLhZiqwuw1HKyRqH4aSioFttLvhFWTflMmOdE3qlPfJnoVE
	CozVlA3p6QasV3ZTZTYNxpEaZmCEvY+kdlYqmacc8ja25pzz4rMpYTrqy9L8+GCkkoma0828U9f
	1KybA52Wqr71erQARqxUKLDHOzV1/lveL2wZSgKBLyRuUOOTFbOZ09fN3Zz0YM2Ve7OWoAbj8TC
	PkrYtUuPoIU09cPwfgk5BxQRPq7SXurP9vsJXhz003oqgZs5KSQBWwQ+11Zbdn1Sh71quc/NE2n
	nOCIXWBKhN9KiyOXgG9xCqUr2PS/Fs3QnFjiPT8Fw2CXJxZqaph1iWuLJ3aGuBchC5cm2L1qrtd
	5U1z/qEhoe5r4GW/MwDMKXaVfrHklYoA=
X-Google-Smtp-Source: AGHT+IHhGz8J8Life4SG/qgqJ0ye1c0G+Al3baprNQ+dcPxYYmPbWk9QrWHvq7NPTGPL3KzA3Wv0eQ==
X-Received: by 2002:a17:907:c10:b0:ac2:7cf9:71a1 with SMTP id a640c23a62f3a-ac2b9ea16d2mr1529284566b.41.1741846047859;
        Wed, 12 Mar 2025 23:07:27 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aef85sm39791166b.20.2025.03.12.23.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 23:07:27 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Michael Klein <michael@fossekall.de>
Cc: Michael Klein <michael@fossekall.de>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: bananapi: add support for PHY LEDs
Date: Thu, 13 Mar 2025 07:07:24 +0100
Message-ID: <4637912.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20250312193629.85417-2-michael@fossekall.de>
References:
 <20250312193629.85417-1-michael@fossekall.de>
 <20250312193629.85417-2-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Dne sreda, 12. marec 2025 ob 20:36:28 Srednjeevropski standardni =C4=8Das j=
e Michael Klein napisal(a):
> The Bananapi M1 has three LEDs connected to the RTL8211E ethernet PHY.
> Add the corresponding nodes to the device tree.
>=20
> Signed-off-by: Michael Klein <michael@fossekall.de>

This is patch 2/2. Which one is patch 1/2? I got only one.

Best regards,
Jernej

> ---
>  .../boot/dts/allwinner/sun7i-a20-bananapi.dts | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts b/arch/ar=
m/boot/dts/allwinner/sun7i-a20-bananapi.dts
> index 46ecf9db2324..4976453ed192 100644
> --- a/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts
> +++ b/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts
> @@ -48,6 +48,7 @@
> =20
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/leds/common.h>
> =20
>  / {
>  	model =3D "LeMaker Banana Pi";
> @@ -169,6 +170,32 @@ &ir0 {
>  &gmac_mdio {
>  	phy1: ethernet-phy@1 {
>  		reg =3D <1>;
> +
> +		leds {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			led@0 {
> +				reg =3D <0>;
> +				color =3D <LED_COLOR_ID_GREEN>;
> +				default-state =3D "keep";
> +				linux,default-trigger =3D "netdev";
> +			};
> +
> +			led@1 {
> +				reg =3D <1>;
> +				color =3D <LED_COLOR_ID_AMBER>;
> +				default-state =3D "keep";
> +				linux,default-trigger =3D "netdev";
> +			};
> +
> +			led@2 {
> +				reg =3D <2>;
> +				color =3D <LED_COLOR_ID_BLUE>;
> +				default-state =3D "keep";
> +				linux,default-trigger =3D "netdev";
> +			};
> +		};
>  	};
>  };
> =20
>=20





