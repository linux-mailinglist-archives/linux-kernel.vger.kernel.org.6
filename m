Return-Path: <linux-kernel+bounces-423255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AE09DA50F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09397B27D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C331946A0;
	Wed, 27 Nov 2024 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="o3SkBXnw"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A49198E92;
	Wed, 27 Nov 2024 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700769; cv=none; b=WjDPbe3NT/HrA11Naf51szsBIPHy7H5yomGmq6Y4jM9QrVL+6/zUpg0v2/3mNByZmIm66sMUU6bv0l58/m9UJdpFx2w9EbZ64OQU6N2wCsa2Z8XY1WDPpCL4qwG+STV3SEvC8GifChHnYHUJA9hLf58mjpGnRCtZR3P81I8geq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700769; c=relaxed/simple;
	bh=9InTLvSo5ICqqU75hhYveOol4IjDsuXatXacDKVpUdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuZDlZTlMlSeAtiRSJEn4CbRo4akeLyVXdgOSAnGiWIa7hsLdUrRztsQydapjQz5tXp6kwRW5eZNy1489cNZjtgcXbiHfnGBknofuQ4CmcqNQ6hYnYI1KopVAFVKqttwi96gRNggHGTU22K6ogw0xkxZ2cEaMavMwcyxvjokPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=o3SkBXnw; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SyxKs+KHPcd6JCGKDM5nONfpeJupnL+SBPURReFBlX0=; b=o3SkBXnw0CRR3bOAH60oImlOxB
	DDqJSD8yu3c0BzZEooC7g7Y8X0LB4qWYuNRZQL3IiGloekYO/RVVFn6kzGR8ua01nkIH1rsZgeujg
	blf75qx+LuC+vqJoaKwpM6SQAlxol0Tk9KnaD+tT4hs1af5m9TYtlR2wU/5S4Kx58OT3SR4rkFwL2
	MpxyXstlgb9BRD1rbmCH44ygBrNJAFQPQlO5QyneF50/mKhhVZYzxVIbO9nUSRsyQGYRSe9zcmy80
	+/fU6ZcLpmSsTw6y8boBg318e0AXNmwGV7WLJChlrk1Lg/h2yhn2+qPKM2oMKtoqyxu80BSKY3q+I
	pyvyHm7Q==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tGEcT-0007EQ-5U; Wed, 27 Nov 2024 10:46:01 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH 3/3] arm64: dts: rockchip: add overlay for tiger-haikou video-demo
 adapter
Date: Wed, 27 Nov 2024 10:46:00 +0100
Message-ID: <4636112.cEBGB3zze1@diego>
In-Reply-To: <c53b4149-fc8c-4357-a881-de07d6ebf7ac@cherry.de>
References:
 <20241106123758.423584-1-heiko@sntech.de>
 <20241106123758.423584-4-heiko@sntech.de>
 <c53b4149-fc8c-4357-a881-de07d6ebf7ac@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Quentin,

Am Mittwoch, 6. November 2024, 14:18:49 CET schrieb Quentin Schulz:
> On 11/6/24 1:37 PM, Heiko Stuebner wrote:
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > index 09423070c992..0c4ee6a767b8 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile

[...]

> > +&dsi0 {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> 
> Shouldn't those be in the SoC dtsi? Is there any world where this would 
> be different per board?

It's more of a we need that here to _compile_ the dtbo, so one gets
to duplicate them, as the dtbo is not compiled _against_ the dtb, hence
dtc does not know about the parent #address-cells value.


> > +	status = "okay";
> > +
> > +	panel@0 {
> > +		compatible = "leadtek,ltk050h3148w";
> > +		reg = <0>;
> > +		backlight = <&backlight>;
> > +		iovcc-supply = <&vcc1v8_video>;
> > +		reset-gpios = <&pca9670 0 GPIO_ACTIVE_LOW>;
> > +		vci-supply = <&vcc2v8_video>;
> > +
> > +		port {
> > +			mipi_panel_in: endpoint {
> > +				remote-endpoint = <&dsi0_out_panel>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&dsi0_in {
> > +	dsi0_in_vp3: endpoint {
> > +		remote-endpoint = <&vp3_out_dsi0>;
> > +	};
> > +};
> > +
> > +&dsi0_out {
> > +	dsi0_out_panel: endpoint {
> > +		remote-endpoint = <&mipi_panel_in>;
> > +	};
> > +};
> > +
> > +&i2c6 {
> > +	/* OV5675, GT911, DW9714 are limited to 400KHz */
> > +	clock-frequency = <400000>;
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +
> 
> Mmmm why the address and size cells properties here? They should already 
> be part of the SoC dtsi no?

same as above

> > +&pwm0 {
> > +	pinctrl-0 = <&pwm0m1_pins>;
> > +	pinctrl-names = "default";
> 
> The other two pin muxes for PWM0 are either:
> - the pin used for CAN
> - the pin routed to an internal component (unexposed to Q7) and used as 
> a GPIO
> 
> so please move the pinctrl to the Tiger SoM DTSI.

the pwm0-pinctrl is actually already set in the tiger.dtsi, so
I'll just remove it from here.

> > +	status = "okay";
> > +};
> > +
> > +&vp3 {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +
> 
> Shouldn't those be in the SoC dtsi?

same as dsi and i2c #adress-cells


Heiko



