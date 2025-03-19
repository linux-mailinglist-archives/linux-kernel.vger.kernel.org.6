Return-Path: <linux-kernel+bounces-568967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE53A69CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750E1189C8D3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8B822371F;
	Wed, 19 Mar 2025 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="EGRGJb6H"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D68290F;
	Wed, 19 Mar 2025 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742428095; cv=none; b=eeC5Ozv3Nrc5MpU57eh42TTFcWASM/vn4sj+RbkmNJ1C7HzsFM93/pIR7C5AMkjbF7KtCNcvcreNgxiWmRo7UU2a7bimGt7C+WD2SkL4fQU1cnqQGlaHCH5d3qK3FLgDXEWyvd0qlWNFkn1VEccsFjdhosqyA9+FlkO37+v7MUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742428095; c=relaxed/simple;
	bh=9CdwFq4x9fa4iLQihxM8BJo/RgaGC0hhDEWpG6IwWg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9tpeYLxYBns8lPDkK6M4XXFpZwUsRgtjU1US8Mh4L+Qr5bxq2cuMzLqHlFp7Ia4oPFLo50GI6VlaxjtNMPbOph/0Nqx8J9m3buqdmqZcPD5cICX9lY0J16hr8T+W3itTT3h0Gt3JR0UdSFF8D02ERJwiOGS2f7OkSAN4VptmqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=EGRGJb6H; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Rw+f9/0oWfJPL5BafdAk8H8AdIxBBtfNNmHXGxv1VA4=; b=EGRGJb6HMeCSbau9OQWDTncAhJ
	+O9UgyhkLxHvEy0KVDW/TZ/D/E+dfg5Ob3QYk3Qg/LqL2SWkdKV/VUja+GYPrCn/geobH/wM9kmqS
	3d0yUMw3dK9rEihAFBKaSni2xJZYvUkC1l+rBNMk/+YcOyyb8Y+DjAtOqSF9ktdgbIOZ1/HujUhX0
	u3KJmC8dxsNAQIk04ONAsCT87Jh/yfhUJY+QDqez/buP1Z0WF8w5OqD3L9fdt8Y4ymU7pTeR6jKSs
	cC0mJtq+zeyrHykhlgwpGdsGWMmmrIk94WXWcUNnzxm09jYtPHJAP5XbDEClru/9TH58yIPdlMmpc
	sodb0RoQ==;
Received: from i53875bc6.versanet.de ([83.135.91.198] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tv38b-0001z5-GP; Thu, 20 Mar 2025 00:47:53 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>, Jonas Karlman <jonas@kwiboo.se>
Cc: Yao Zi <ziyao@disroot.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: Add pwm nodes for RK3528
Date: Thu, 20 Mar 2025 00:47:52 +0100
Message-ID: <2499436.jE0xQCEvom@phil>
In-Reply-To: <0d638134-0c0d-4918-af47-e23d2ead3bf3@kwiboo.se>
References:
 <20250318120003.2340652-1-amadeus@jmu.edu.cn>
 <20250318120003.2340652-2-amadeus@jmu.edu.cn>
 <0d638134-0c0d-4918-af47-e23d2ead3bf3@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 20. M=C3=A4rz 2025, 00:26:14 MEZ schrieb Jonas Karlman:
> Hi Chukun,
>=20
> On 2025-03-18 13:00, Chukun Pan wrote:
> > Add pwm nodes for RK3528. The PWM core on RK3528 is the same as
> > RK3328, but the driver does not support interrupts yet.
>=20
> The device tree should describe the hardware, not what the driver
> support, so interrupts should probably be included.
>=20
> However, looking closer at TRM for i.e. RK3328, RK3568 and RK3588 it
> look like the following description is not a true description of the
> hardware.
>=20
> Each PWM controller seem to support 4 channels, here (and for older RK
> SoCs) we instead describe each channel and not the controller.

Yep, that is something that did go wrong in the very early days.
And all other Rockchip socs also have the same issue - even back
to the rk3066.

So yes, at some point we should overhaul the thing.

But I think this is more involved, as right now everything is aimed
at the current single-channel status quo.


Heiko


> Maybe something like following would better represent the hardware:
>=20
> 	pwm0: pwm@ffa90000 {
> 		compatible =3D "rockchip,rk3528-pwm";
> 		reg =3D <0x0 0xffa90000 0x0 0x10000>;
> 		clocks =3D <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
> 		clock-names =3D "pwm", "pclk";
> 		interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> 	};
>=20
> 	pwm1: pwm@ffa98000 {
> 		compatible =3D "rockchip,rk3528-pwm";
> 		reg =3D <0x0 0xffa98000 0x0 0x10000>;
> 		clocks =3D <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
> 		clock-names =3D "pwm", "pclk";
> 		interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> 	};
>=20
> Regards,
> Jonas
>=20
> >=20
> > Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 80 ++++++++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot=
/dts/rockchip/rk3528.dtsi
> > index 1af0d036cf32..621fc19ac0b3 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > @@ -465,6 +465,86 @@ uart7: serial@ffa28000 {
> >  			status =3D "disabled";
> >  		};
> > =20
> > +		pwm0: pwm@ffa90000 {
> > +			compatible =3D "rockchip,rk3528-pwm",
> > +				     "rockchip,rk3328-pwm";
> > +			reg =3D <0x0 0xffa90000 0x0 0x10>;
> > +			clocks =3D <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
> > +			clock-names =3D "pwm", "pclk";
> > +			#pwm-cells =3D <3>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		pwm1: pwm@ffa90010 {
> > +			compatible =3D "rockchip,rk3528-pwm",
> > +				     "rockchip,rk3328-pwm";
> > +			reg =3D <0x0 0xffa90010 0x0 0x10>;
> > +			clocks =3D <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
> > +			clock-names =3D "pwm", "pclk";
> > +			#pwm-cells =3D <3>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		pwm2: pwm@ffa90020 {
> > +			compatible =3D "rockchip,rk3528-pwm",
> > +				     "rockchip,rk3328-pwm";
> > +			reg =3D <0x0 0xffa90020 0x0 0x10>;
> > +			clocks =3D <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
> > +			clock-names =3D "pwm", "pclk";
> > +			#pwm-cells =3D <3>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		pwm3: pwm@ffa90030 {
> > +			compatible =3D "rockchip,rk3528-pwm",
> > +				     "rockchip,rk3328-pwm";
> > +			reg =3D <0x0 0xffa90030 0x0 0x10>;
> > +			clocks =3D <&cru CLK_PWM0>, <&cru PCLK_PWM0>;
> > +			clock-names =3D "pwm", "pclk";
> > +			#pwm-cells =3D <3>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		pwm4: pwm@ffa98000 {
> > +			compatible =3D "rockchip,rk3528-pwm",
> > +				     "rockchip,rk3328-pwm";
> > +			reg =3D <0x0 0xffa98000 0x0 0x10>;
> > +			clocks =3D <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
> > +			clock-names =3D "pwm", "pclk";
> > +			#pwm-cells =3D <3>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		pwm5: pwm@ffa98010 {
> > +			compatible =3D "rockchip,rk3528-pwm",
> > +				     "rockchip,rk3328-pwm";
> > +			reg =3D <0x0 0xffa98010 0x0 0x10>;
> > +			clocks =3D <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
> > +			clock-names =3D "pwm", "pclk";
> > +			#pwm-cells =3D <3>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		pwm6: pwm@ffa98020 {
> > +			compatible =3D "rockchip,rk3528-pwm",
> > +				     "rockchip,rk3328-pwm";
> > +			reg =3D <0x0 0xffa98020 0x0 0x10>;
> > +			clocks =3D <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
> > +			clock-names =3D "pwm", "pclk";
> > +			#pwm-cells =3D <3>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		pwm7: pwm@ffa98030 {
> > +			compatible =3D "rockchip,rk3528-pwm",
> > +				     "rockchip,rk3328-pwm";
> > +			reg =3D <0x0 0xffa98030 0x0 0x10>;
> > +			clocks =3D <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
> > +			clock-names =3D "pwm", "pclk";
> > +			#pwm-cells =3D <3>;
> > +			status =3D "disabled";
> > +		};
> > +
> >  		saradc: adc@ffae0000 {
> >  			compatible =3D "rockchip,rk3528-saradc";
> >  			reg =3D <0x0 0xffae0000 0x0 0x10000>;
>=20
>=20





