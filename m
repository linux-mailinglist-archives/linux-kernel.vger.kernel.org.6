Return-Path: <linux-kernel+bounces-299197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812F695D16C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D7F1C21F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B464C188A1A;
	Fri, 23 Aug 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy6le3J9"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D507F1E529;
	Fri, 23 Aug 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427093; cv=none; b=Q0QsFK3NqKFfo/LJ1FKmJYeSMkz6zj0xV5qEtyp38B08XuZHQl49OnYMXt1qXv6tt3dXMo2FbTfwJBU5EZKNACa7dmRij8l5f0mub54pX0uEIvGiP91rJ/dx6etU6/qHiWAiN60ou7uP2u8AGgP+eHAemiBEHAju6HNpSefDl0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427093; c=relaxed/simple;
	bh=tu9HJS2Ao5RkDJHMqzZld1LS3I9I1ND2SSzO3CgqBJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAcG/Pcsvz5lyZeRGlbRV/bFllfIvs5ltXWfPsay2rTu5YN0mYi5zsRAjXY22zAvS1HL1pzJHin9DS7WKLLsDql2qa/euWvyw8jYisIZY6dPVLnqMXDiabe6oO1V3Ozt8egBbbSsJWtWkE5wSTkdISJjghoDH03EmpssnwXj3dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zy6le3J9; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6bf7b48d2feso11048946d6.0;
        Fri, 23 Aug 2024 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724427091; x=1725031891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p6TeDuGkHFTvwpLmk3wSYtuFFYYwEpgCUQnGmRnlaj0=;
        b=Zy6le3J9e7zVEbh53fWCGgahtgPwkKDIXPZex0GkevGSOcHio09fqGeZbLt7XqxHDX
         5LZjsS4rJN84eByOzLxcJ1HANNTOiAsVwOXYMaFmBvDX4R1BlFZFRJtHUua/6Dwdn2jL
         s3b11j7+fVcBYO4s5swkbew0xHXzOGgOTH40v0ySAGX6ZaxdTzHEFBVmF5DpgDZYBsII
         OaucAL2iH7DsFF8ebEb3hDtagEKOMw0JlcjjNMI/+iigyBqU3wLXgyHR+eQxaniRpOFs
         0SoZ9FBo/2CftzxRFsKIbTEgYk0T6p1yu1GMABFOH/VjkrKrWmnLjfSLfDcTMxDHYizI
         1yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724427091; x=1725031891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6TeDuGkHFTvwpLmk3wSYtuFFYYwEpgCUQnGmRnlaj0=;
        b=sg3GRLemM41rUM07usT+ErBD980+4MyE4uKUCb0pAJSrJ+gPW58WRYD72a45QaLx92
         1lX1s/JIErp1VPKu42L+wt74xjaedW1JqGOomXmf3f/ehqJhPZGtu1taJDszhPj12WUB
         urS+vbSH1jOBDHlObQl6OyOII0VUVsvXffwiZ6vAWVVUUFubcfrYC5IUHPt4XASKCyA2
         kitKBN/IbTUbTU3+yThnhs+rSfesjFR1tiJ+xe9FhCZSTAoWghSPOGfYVrYjVyeog4TK
         7gQPyMDQuitIBkie+ZS1vk3m50GLx+5QiM0ogT1QQTT9SM/iS+ca/r0LA7k3L4ui31t+
         o6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXW2Efd3DeWvhOSOqAOUtmfWO/hNOxqptPn9Dc4yfy6LCKbZcmQBG3ot8HsvSFvy/H4PPbmH6RfFqM6JsL@vger.kernel.org, AJvYcCXIe8xvqMVY6rqzYITuQd5Vq/E4UpaYEJCRUefGqGUA0HAbXyiMLdZFZahhEY/PkLOhUohkkaEsjHfO@vger.kernel.org
X-Gm-Message-State: AOJu0YxNJSLEmKGFYFvP0MH9AXxtPKTewwJM2rxK7otBIFajZXOh+vEf
	/ijB2YB2VgWZmTGayraoIxFl0sriyvNIuLWcUxXMH3jwUzezs0ww/5FwrMpREF2Pn1WE8LreEIo
	QenDGdkdhveyOCWY6tDomCcec73I=
X-Google-Smtp-Source: AGHT+IEAS+yk6acOOgZnHXL2+qCoZfu9MrpvApcKw/0xAHt+8kstjRt6G1OBuNG0kb5+GR5JL5kgVdABfBDd12Hh0+s=
X-Received: by 2002:a05:6214:1712:b0:6c1:6ef2:dbe5 with SMTP id
 6a1803df08f44-6c16ef2dc71mr20379856d6.20.1724427090322; Fri, 23 Aug 2024
 08:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822170440.265055-1-robertcnelson@gmail.com>
 <20240822170440.265055-2-robertcnelson@gmail.com> <dlfqejfb2lhbopybt5x6maoonw37krin6iezmwnngjflcbn425@5xn25d3gkxkn>
In-Reply-To: <dlfqejfb2lhbopybt5x6maoonw37krin6iezmwnngjflcbn425@5xn25d3gkxkn>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Fri, 23 Aug 2024 10:31:04 -0500
Message-ID: <CAOCHtYj__Azt8Y9=Byj_0VD56fsEKe0zq483TTwZya=h1=ioBQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: Add k3-am67a-beagley-ai
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>, Jai Luthra <j-luthra@ti.com>, 
	Roger Quadros <rogerq@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Jared McArthur <j-mcarthur@ti.com>, Jason Kridner <jkridner@beagleboard.org>, 
	Deepak Khatri <lorforlinux@beagleboard.org>, Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"

> >  # Boards with J722s SoC
> > +dtb-$(CONFIG_ARCH_K3) += k3-am67a-beagley-ai.dtb
>
> So am67 is J772s? Then why calling it am67a?

I agree, it's stupid..  Back in April with v1, i called this J772s,
then TI and TI marketing got involved.. J772s is a family, am67 and
am67a are parts in that family... From the current docs, am67a is a
fully efused J772s..

Anywho that was TI's decision back in April, thousands of boards have
now shipped, so for user's sake, it's now locked in at beagleboard.org
forever as k3-am67a-beagley-ai.dtb

>
> >  dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
> >
> >  # Boards with J784s4 SoC
> > diff --git a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
> > new file mode 100644
> > index 000000000000..c8cbb875d4c7
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
> > @@ -0,0 +1,406 @@
> > +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> > +/*
> > + * https://beagley-ai.org/
> > + *
> > + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> > + * Copyright (C) 2024 Robert Nelson, BeagleBoard.org Foundation
> > + */
>
> ...
>
> > +     vsys_5v0: regulator-1 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vsys_5v0";
> > +             regulator-min-microvolt = <5000000>;
> > +             regulator-max-microvolt = <5000000>;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             bootph-all;
> > +     };
> > +
> > +     vdd_3v3: regulator-2 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vdd_3v3";
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             vin-supply = <&vsys_5v0>;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +     };
> > +
> > +     vdd_mmc1: regulator-mmc1 {
>
> Keep consistent naming of the nodes. Why this is sometimes "1" sometimes
> "mmc"?
>
> Please use name for all fixed regulators which matches current format
> recommendation: 'regulator-[0-9]v[0-9]'
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml?h=v6.11-rc1#n46

Okay, i'll change these... I already see a problem, as I've got two
3v3... can we use 'regulator-[0-9]v[0-9]-X' ?

>
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vdd_mmc1";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&vdd_3v3_sd_pins_default>;
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             regulator-boot-on;
> > +             enable-active-high;
> > +             gpio = <&main_gpio1 50 GPIO_ACTIVE_HIGH>;
> > +             bootph-all;
> > +     };
> > +
> > +     vdd_sd_dv: regulator-TLV71033 {
>
> No upper-case characters.
>
> See DTS coding style.

I'll fix it..

>
> > +             compatible = "regulator-gpio";
> > +             regulator-name = "tlv71033";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&vdd_sd_dv_pins_default>;
> > +             regulator-min-microvolt = <1800000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             regulator-boot-on;
> > +             vin-supply = <&vsys_5v0>;
> > +             gpios = <&main_gpio1 49 GPIO_ACTIVE_HIGH>;
> > +             states = <1800000 0x0>,
> > +                      <3300000 0x1>;
> > +             bootph-all;
> > +     };
> > +
> > +     vsys_io_1v8: regulator-vsys-io-1v8 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vsys_io_1v8";
> > +             regulator-min-microvolt = <1800000>;
> > +             regulator-max-microvolt = <1800000>;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +     };
> > +
> > +     vsys_io_1v2: regulator-vsys-io-1v2 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vsys_io_1v2";
> > +             regulator-min-microvolt = <1200000>;
> > +             regulator-max-microvolt = <1200000>;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +     };
> > +
> > +     leds {
> > +             compatible = "gpio-leds";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&led_pins_default>;
> > +
> > +             led-0 {
> > +                     gpios = <&main_gpio0 11 GPIO_ACTIVE_LOW>;
> > +                     linux,default-trigger = "default-off";
> > +                     default-state = "off";
> > +             };
> > +
> > +             led-1 {
> > +                     gpios = <&main_gpio0 12 GPIO_ACTIVE_HIGH>;
> > +                     function = LED_FUNCTION_HEARTBEAT;
> > +                     linux,default-trigger = "heartbeat";
> > +                     default-state = "on";
> > +             };
> > +     };
> > +};
> > +
> > +&main_pmx0 {
> > +
>
> Drop blank line.

I'll fix it..

>
> > +     main_i2c0_pins_default: main-i2c0-default-pins {
> > +             pinctrl-single,pins = <
> > +                     J722S_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (D23) I2C0_SCL */
> > +                     J722S_IOPAD(0x01e4, PIN_INPUT_PULLUP, 0) /* (B22) I2C0_SDA */
> > +             >;
> > +             bootph-all;
> > +     };
> > +
> > +     main_uart0_pins_default: main-uart0-default-pins {
> > +             pinctrl-single,pins = <
> > +                     J722S_IOPAD(0x01c8, PIN_INPUT, 0)       /* (A22) UART0_RXD */
> > +                     J722S_IOPAD(0x01cc, PIN_OUTPUT, 0)      /* (B22) UART0_TXD */
> > +             >;
> > +             bootph-all;
> > +     };
> > +
> > +     vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
> > +             pinctrl-single,pins = <
> > +                     J722S_IOPAD(0x0244, PIN_OUTPUT, 7) /* (A24) MMC1_SDWP.GPIO1_49 */
> > +             >;
> > +             bootph-all;
> > +     };
> > +
> > +     main_mmc1_pins_default: main-mmc1-default-pins {
> > +             pinctrl-single,pins = <
> > +                     J722S_IOPAD(0x023c, PIN_INPUT, 0) /* (H22) MMC1_CMD */
> > +                     J722S_IOPAD(0x0234, PIN_OUTPUT, 0) /* (H24) MMC1_CLK */
> > +                     J722S_IOPAD(0x0230, PIN_INPUT, 0) /* (H23) MMC1_DAT0 */
> > +                     J722S_IOPAD(0x022c, PIN_INPUT_PULLUP, 0) /* (H20) MMC1_DAT1 */
> > +                     J722S_IOPAD(0x0228, PIN_INPUT_PULLUP, 0) /* (J23) MMC1_DAT2 */
> > +                     J722S_IOPAD(0x0224, PIN_INPUT_PULLUP, 0) /* (H25) MMC1_DAT3 */
> > +                     J722S_IOPAD(0x0240, PIN_INPUT, 7) /* (B24) MMC1_SDCD.GPIO1_48 */
> > +             >;
> > +             bootph-all;
> > +     };
> > +
> > +     mdio_pins_default: mdio-default-pins {
> > +             pinctrl-single,pins = <
> > +                     J722S_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AC24) MDIO0_MDC */
> > +                     J722S_IOPAD(0x015c, PIN_INPUT, 0) /* (AD25) MDIO0_MDIO */
> > +             >;
> > +     };
> > +
> > +     rgmii1_pins_default: rgmii1-default-pins {
> > +             pinctrl-single,pins = <
> > +                     J722S_IOPAD(0x014c, PIN_INPUT, 0) /* (AC25) RGMII1_RD0 */
> > +                     J722S_IOPAD(0x0150, PIN_INPUT, 0) /* (AD27) RGMII1_RD1 */
> > +                     J722S_IOPAD(0x0154, PIN_INPUT, 0) /* (AE24) RGMII1_RD2 */
> > +                     J722S_IOPAD(0x0158, PIN_INPUT, 0) /* (AE26) RGMII1_RD3 */
> > +                     J722S_IOPAD(0x0148, PIN_INPUT, 0) /* (AE27) RGMII1_RXC */
> > +                     J722S_IOPAD(0x0144, PIN_INPUT, 0) /* (AD23) RGMII1_RX_CTL */
> > +                     J722S_IOPAD(0x0134, PIN_OUTPUT, 0) /* (AF27) RGMII1_TD0 */
> > +                     J722S_IOPAD(0x0138, PIN_OUTPUT, 0) /* (AE23) RGMII1_TD1 */
> > +                     J722S_IOPAD(0x013c, PIN_OUTPUT, 0) /* (AG25) RGMII1_TD2 */
> > +                     J722S_IOPAD(0x0140, PIN_OUTPUT, 0) /* (AF24) RGMII1_TD3 */
> > +                     J722S_IOPAD(0x0130, PIN_OUTPUT, 0) /* (AG26) RGMII1_TXC */
> > +                     J722S_IOPAD(0x012c, PIN_OUTPUT, 0) /* (AF25) RGMII1_TX_CTL */
> > +             >;
> > +     };
> > +
> > +     led_pins_default: led-default-pins {
> > +             pinctrl-single,pins = <
> > +                     J722S_IOPAD(0x002c, PIN_OUTPUT, 7) /* (K26) OSPI0_CSn0.GPIO0_11 */
> > +                     J722S_IOPAD(0x0030, PIN_OUTPUT, 7) /* (K23) OSPI0_CSn1.GPIO0_12 */
> > +             >;
> > +     };
> > +
> > +     pmic_irq_pins_default: pmic-irq-default-pins {
> > +             pinctrl-single,pins = <
> > +                     J722S_IOPAD(0x01f4, PIN_INPUT_PULLUP, 0) /* (B23) EXTINTn */
> > +             >;
> > +     };
> > +
> > +     vdd_3v3_sd_pins_default: vdd-3v3-sd-default-pins {
> > +             pinctrl-single,pins = <
> > +                     J722S_IOPAD(0x0254, PIN_OUTPUT, 7) /* (E25) USB0_DRVVBUS.GPIO1_50 */
> > +             >;
> > +     };
> > +};
> > +
> > +&cpsw3g {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&rgmii1_pins_default>, <&gbe_pmx_obsclk>;
> > +
> > +     assigned-clocks = <&k3_clks 227 0>;
> > +     assigned-clock-parents = <&k3_clks 227 6>;
> > +     status = "okay";
> > +};
> > +
> > +&cpsw3g_mdio {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&mdio_pins_default>;
> > +     status = "okay";
> > +
> > +     cpsw3g_phy0: ethernet-phy@0 {
> > +             reg = <0>;
> > +             ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> > +             ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> > +             ti,min-output-impedance;
> > +     };
> > +};
> > +
> > +&cpsw_port1 {
> > +     phy-mode = "rgmii-rxid";
> > +     phy-handle = <&cpsw3g_phy0>;
> > +     status = "okay";
> > +};
> > +
> > +&main_gpio1 {
> > +     status = "okay";
> > +};
> > +
> > +&main_uart0 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&main_uart0_pins_default>;
> > +     bootph-all;
> > +     status = "okay";
> > +};
> > +
> > +&mcu_pmx0 {
> > +
>
> Drop blank line

I'll fix it..

>
> > +     wkup_uart0_pins_default: wkup-uart0-default-pins {
> > +             pinctrl-single,pins = <
> > +                     J722S_MCU_IOPAD(0x02c, PIN_INPUT, 0)    /* (C7) WKUP_UART0_CTSn */
> > +                     J722S_MCU_IOPAD(0x030, PIN_OUTPUT, 0)   /* (C6) WKUP_UART0_RTSn */
> > +                     J722S_MCU_IOPAD(0x024, PIN_INPUT, 0)    /* (D8) WKUP_UART0_RXD */
> > +                     J722S_MCU_IOPAD(0x028, PIN_OUTPUT, 0)   /* (D7) WKUP_UART0_TXD */
> > +             >;
> > +             bootph-all;
> > +     };

Thanks!

-- 
Robert Nelson
https://rcn-ee.com/

