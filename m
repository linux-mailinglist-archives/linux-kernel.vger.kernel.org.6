Return-Path: <linux-kernel+bounces-391737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1309B8B12
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8FA0B2111D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 06:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA2214B962;
	Fri,  1 Nov 2024 06:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="HNrTED0L"
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374D1482E5;
	Fri,  1 Nov 2024 06:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441683; cv=none; b=bTG2Wn2QQyqWiESdEbuc9qtz36kI7neTTELzcNPEhnYXgZkU/Ys78wg4j6bPgVjC3UJDbYuIUJy0KJs3XhcraiX+li7WjuDg3Kz7LzM477cdDuiGr7hF8SJ0pjtPhq4xsxspPCwkbldrXVRe+k7wIWvnhMEFimw+JlXsSGP8J/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441683; c=relaxed/simple;
	bh=D/kAMVeeZ1GBnRC8sst69KP3zOv7FeYAbNLbfbLkabo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dtJZKPyrk2VnxgXb+gplfV2OzIkphzJSahauDs4bZggm2bYD4ldxXa20iBW2qFfeSKcO75VYhMjI8jbgH8j3eFjP6Zrsh2qeFxDxOGvR4Uq2hNJs/NlS3kR3kAwX+uhXyquipd4WQ92Cdn/N3+xHhXJOEIfDqM6DuavtR6Hep2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=HNrTED0L; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730441679;
	bh=D/kAMVeeZ1GBnRC8sst69KP3zOv7FeYAbNLbfbLkabo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HNrTED0L2H9cloFtJBd+q9cfwbKmy6zBOcIMvUfokosLXqYALQbi2ufYWQucriNPy
	 lRUGasfiv0WrWp77DVYYc6qOam68sb5H9DrRBCituuBLxwsrLBaatU26bm9xpNSr4r
	 VKrOlrQraJCCHR2x36dujf6u6FcBA6uAl9WWX9Z2U+ovyD4qW4FkPpvV07bbqdf8kh
	 uQfRc6E659H7m5CiJL3i8YgreDllYuf7nRjHIiKbW1i7FxRNhPp6euibTYWxn3rTb6
	 d3awEskB1M93ZKRzD3rYikffpDwV6LHj/YwJexbfGKpY4U+Rgau2CeyjFD36Brdfzr
	 fPDVGy/RP8PgA==
X-Virus-Scanned: by epochal.quest
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 01 Nov 2024 03:14:32 -0300
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Maxime Ripard <mripard@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Vinod Koul
 <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Yangtao Li <tiny.windzz@gmail.com>, Parthiban
 <parthiban@linumiz.com>, Andre Przywara <andre.przywara@arm.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/13] arm64: dts: allwinner: a100: add usb related
 nodes
In-Reply-To: <20241031070232.1793078-7-masterr3c0rd@epochal.quest>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
 <20241031070232.1793078-7-masterr3c0rd@epochal.quest>
Message-ID: <c231d0fbd13e2ff6ea23dc907b46112f@epochal.quest>
X-Sender: masterr3c0rd@epochal.quest
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/31 4:02 am, Cody Eksal wrote:
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi 
> b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> index adb11b26045f..f6162a107641 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> @@ -302,6 +302,97 @@ ths: thermal-sensor@5070400 {
>  			#thermal-sensor-cells = <1>;
>  		};
> +
> +		usb_otg: usb@5100000 {
> +			compatible = "allwinner,sun50i-a100-musb",
> +				     "allwinner,sun8i-a33-musb";
> +			reg = <0x05100000 0x0400>;
> +			clocks = <&ccu CLK_BUS_OTG>;
> +			resets = <&ccu RST_BUS_OTG>;
> +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "mc";
> +			phys = <&usbphy 0>;
> +			phy-names = "usb";
> +			extcon = <&usbphy 0>;
> +			status = "disabled";
> +		};
Quick note: it was determined that if ehci0 and/or ohci0 are enabled,
peripheral mode does not function correctly. From my understanding, it 
is
an unrelated issue in musb that causes this; the PHY gets claimed by the
HCI nodes before MUSB, and due to some other issue, the PHY doesn't get
properly rerouted to MUSB. With those nodes disabled, attaching gadgets 
to
MUSB works correctly, and with them enabled, host mode works properly.

- Cody
> +		usbphy: phy@5100400 {
> +			compatible = "allwinner,sun50i-a100-usb-phy",
> +				     "allwinner,sun20i-d1-usb-phy";
> +			reg = <0x05100400 0x100>,
> +			      <0x05101800 0x100>,
> +			      <0x05200800 0x100>;
> +			reg-names = "phy_ctrl",
> +				    "pmu0",
> +				    "pmu1";
> +			clocks = <&ccu CLK_USB_PHY0>,
> +				 <&ccu CLK_USB_PHY1>;
> +			clock-names = "usb0_phy",
> +				      "usb1_phy";
> +			resets = <&ccu RST_USB_PHY0>,
> +				 <&ccu RST_USB_PHY1>;
> +			reset-names = "usb0_reset",
> +				      "usb1_reset";
> +			status = "disabled";
> +			#phy-cells = <1>;
> +		};
> +
> +		ehci0: usb@5101000 {
> +			compatible = "allwinner,sun50i-a100-ehci",
> +				     "generic-ehci";
> +			reg = <0x05101000 0x100>;
> +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_OHCI0>,
> +				 <&ccu CLK_BUS_EHCI0>,
> +				 <&ccu CLK_USB_OHCI0>;
> +			resets = <&ccu RST_BUS_OHCI0>,
> +				 <&ccu RST_BUS_EHCI0>;
> +			phys = <&usbphy 0>;
> +			phy-names = "usb";
> +			status = "disabled";
> +		};
> +
> +		ohci0: usb@5101400 {
> +			compatible = "allwinner,sun50i-a100-ohci",
> +				     "generic-ohci";
> +			reg = <0x05101400 0x100>;
> +			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_OHCI0>,
> +				 <&ccu CLK_USB_OHCI0>;
> +			resets = <&ccu RST_BUS_OHCI0>;
> +			phys = <&usbphy 0>;
> +			phy-names = "usb";
> +			status = "disabled";
> +		};

