Return-Path: <linux-kernel+bounces-376732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AE99AB541
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F561F227CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EC71BDA88;
	Tue, 22 Oct 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJv41kuY"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE0E19AD9B;
	Tue, 22 Oct 2024 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618756; cv=none; b=n7tfOd+/rm0DU2RhDCykppc0qRNBLZ6rHLQquuozio71Ir5i2pL0KAVNAQN6IkVHyui1F+ie12F5e8tUrxodfBVDLb3Odd2ndLJpiGb5Nxn3ijpKJDeH7T/gxObCzIR9E0omtVY18dUqhfKj8td/fZq8RLhYQX592vDVz4XGwiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618756; c=relaxed/simple;
	bh=NLC2quIwJQOEzV+dNEt3EEV/0Q2o9u3Ofu/wbnX8l8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdnEQMxM0odFPPmaV2dPI/veVhIhLsjsafn46A+f6GXIw8GIXkP5NK+YYMA/OHmpvV8YpYggA08xMRGRfrv1mvyBWGv5vqNAff00nl8UdsIP5qo7JbjWshI7Jbm8RHclPnmUBMRvzADRTSmJY3KjICSps0RYNgVlP/ZktDSqQDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJv41kuY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71eb1d0e3c2so2592719b3a.2;
        Tue, 22 Oct 2024 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729618753; x=1730223553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLC2quIwJQOEzV+dNEt3EEV/0Q2o9u3Ofu/wbnX8l8g=;
        b=RJv41kuYwyXXJlw7o48dbWzOdGt0NHrkeCMi5YyDwYUw2eF0dhlWHWlGusk8IyP7YG
         a5QYaQCBAEoM/W4G67PBI0rTD1rLbel6az8Vs7e/PLGOMkDME4iR3Q4ZDnSQdl6wa957
         LKz0GOw0aeTMdpGQrM9iPU8O68KwLDUjHHw9KjLoOSFCY6H+wa7cmlXqPcOOlATiYtUF
         GTkF2bx2o9LvZrHW3VsFeoMaTy2C92eTv0iSbM5f+tkzEPum5d6W71F36/Oha2zhqtYW
         E3FnuEGC0jjHkhVbtbKjaM6qRyjZHEhPIUYazgXFWkf4XqdX4d6ml/YjyssPZYVLuUV4
         gONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618753; x=1730223553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLC2quIwJQOEzV+dNEt3EEV/0Q2o9u3Ofu/wbnX8l8g=;
        b=XgVPU6hy7t4sJG3PU7YdVS6+tyHdACKj9ET8UhvohuJTuN+UBixZrzW/JDZ12RRK0W
         MCw29Je1gvD3hHek9qavXeqXnQ+TYzHJgTDOru7TQXAS48rS+x+V4h4PJsQd47VHgRD1
         XJfmIDOpN8Ci7XTmcqk5foof5L9Qx3k2674G0/gCyHaJmTVToUpthd9G8j9p0Ti5HE2y
         NFVXqg0xJ3tb/BzRxlFpWvuS4k50BMg+n4F+LymAOjlTxhr4TvXo1+ZLQ6IysyOuKGaS
         qGJoC+Onn9F3+0zQX1HgIWgI2QAuGsUqsGd9SSuE57XUpHp/5HUMvbWZSvqeTB77Ju6L
         zlEw==
X-Forwarded-Encrypted: i=1; AJvYcCUGEwsDlZ7AizLhu0s8IFZa1QUlqfYHC2tIRLXzEBwJds2XvU7O2oCDuAYq/6iellvt5Fifk0xlrpvHZzdq@vger.kernel.org, AJvYcCXUVGHD3KITyHrnQKjdetzz/TKSCt2XKujl/AxHqKvEa3efcLBoDf5QCoIc0ougvBVnJaSkommID7PC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0VLXLOiAnbT+OlwS6NeJ90hvFQEnOESID/ItqpNCeqQiURBi7
	NzVWyB7PvlA7YMw218B29eKaiO5XKay0VNqZQ+6VPbU+/TMltiod
X-Google-Smtp-Source: AGHT+IH8cYRNLm/OBMa2usCJjZFrrme4j8ift59EPIBLlnkBtm0Mj/2m47fCizryLwUEvrjztLw+0g==
X-Received: by 2002:a05:6a00:2302:b0:70d:2a88:a483 with SMTP id d2e1a72fcca58-72030999937mr72568b3a.0.1729618753001;
        Tue, 22 Oct 2024 10:39:13 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2408:8262:245d:4d65:bc4b:53ff:fead:2725])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec14077f5sm5001735b3a.188.2024.10.22.10.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 10:39:12 -0700 (PDT)
From: Tianling Shen <cnsztl@gmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Andy Yan <andyshrk@163.com>,
	Jagan Teki <jagan@edgeble.ai>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board
Date: Wed, 23 Oct 2024 01:38:58 +0800
Message-ID: <20241022173901.892190-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <13bb8657-f048-4f79-a2c1-3680445f2bef@kwiboo.se>
References: <13bb8657-f048-4f79-a2c1-3680445f2bef@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit

Hi Jonas,

On Wed, Oct 23, 2024 at 12:49 AM Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Tianling,
>
> On 2024-10-20 19:39, Tianling Shen wrote:
> > The NanoPi R3S(as "R3S") is an open source platform with dual-Gbps
> > Ethernet ports designed and developed by FriendlyElec for IoT
> > applications.
> >
> > Specification:
> > - Rockchip RK3566
> > - 2GB LPDDR4X RAM
> > - optional 32GB eMMC module
> > - SD card slot
> > - 2x 1000 Base-T
> > - 3x LEDs (POWER, LAN, WAN)
> > - 2x Buttons (Reset, MaskROM)
> > - 1x USB 3.0 Port
> > - Type-C 5V 2A Power
> >
> > Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  .../boot/dts/rockchip/rk3566-nanopi-r3s.dts   | 554 ++++++++++++++++++
> >  2 files changed, 555 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > index 8e1025cb5d20..e641033d23d1 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -109,6 +109,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-model-a.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-box-demo.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-lckfb-tspi.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-lubancat-1.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-nanopi-r3s.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r66s.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts b/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
> > new file mode 100644
> > index 000000000000..951dd9bcb4b0
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
> > @@ -0,0 +1,554 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright (c) 2020 Rockchip Electronics Co., Ltd.
> > + *
> > + * Copyright (c) 2024 FriendlyElec Computer Tech. Co., Ltd.
> > + * (http://www.friendlyarm.com/
> > + *
> > + * Copyright (c) 2024 Tianling Shen <cnsztl@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/pinctrl/rockchip.h>
> > +#include <dt-bindings/soc/rockchip,vop2.h>
> > +#include "rk3566.dtsi"
> > +
> > +/ {
> > +     model = "FriendlyARM NanoPi R3S";
>
> Please use the marketing name, and the name added in binding:
>
>    FriendlyElec NanoPi R3S

Sorry for the copy & paste error, will fix it in new patch.

>
> > +     compatible = "friendlyarm,nanopi-r3s", "rockchip,rk3566";
> > +
> > +     aliases {
> > +             ethernet0 = &gmac1;
> > +             mmc0 = &sdmmc0;
> > +             mmc1 = &sdhci;
>
> This board comes with on-board eMMC this please use mmc0 as alias for
> &sdhci; and mmc1 for sd-card.

Is using mmc0 for sdhci a common practice for eMMC boards?
The eMMC module on R3S is optional and users may get boards without it.

>
> > +     };
> > +
> > +     chosen: chosen {
> > +             stdout-path = "serial2:1500000n8";
> > +     };
> > +
> > +     gpio-keys {
> > +             compatible = "gpio-keys";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&reset_button_pin>;
> > +
> > +             button-reset {
> > +                     label = "reset";
> > +                     gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_LOW>;
> > +                     linux,code = <KEY_RESTART>;
> > +                     debounce-interval = <50>;
> > +             };
> > +     };
> > +
> > +     gpio-leds {
> > +             compatible = "gpio-leds";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&power_led_pin>, <&lan_led_pin>, <&wan_led_pin>;
> > +
> > +             power_led: led-0 {
> > +                     color = <LED_COLOR_ID_RED>;
> > +                     function = LED_FUNCTION_POWER;
> > +                     gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> > +                     default-state = "on";
> > +             };
> > +
> > +             lan_led: led-1 {
> > +                     color = <LED_COLOR_ID_GREEN>;
> > +                     function = LED_FUNCTION_LAN;
> > +                     gpios = <&gpio3 RK_PC2 GPIO_ACTIVE_HIGH>;
> > +             };
> > +
> > +             wan_led: led-2 {
> > +                     color = <LED_COLOR_ID_GREEN>;
> > +                     function = LED_FUNCTION_WAN;
> > +                     gpios = <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
> > +             };
> > +     };
> > +
> > +     vdd_usbc: vdd-usbc-regulator {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vdd_usbc";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt = <5000000>;
> > +             regulator-max-microvolt = <5000000>;
> > +     };
> > +
> > +     vcc5v0_sys: vcc5v0-sys-regulator {
>
> This and other fixed regulators does not match the recommended naming
> pattern: ^regulator-(.*)$, please rename fixed regulator nodes.

Soory I missed the dt-binding update, also thanks Heiko for renaming the
regulator nodes.

>
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vcc5v0_sys";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt = <5000000>;
> > +             regulator-max-microvolt = <5000000>;
> > +             vin-supply = <&vdd_usbc>;
> > +     };
> > +
> > +     vcc3v3_sys: vcc3v3-sys-regulator {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vcc3v3_sys";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             vin-supply = <&vcc5v0_sys>;
> > +     };
> > +
> > +     vcc5v0_usb: vcc5v0_usb-regulator {
> > +             compatible = "regulator-fixed";
> > +             enable-active-high;
> > +             gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&vcc5v0_usb_host_en>;
> > +             regulator-name = "vcc5v0_usb";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt = <5000000>;
> > +             regulator-max-microvolt = <5000000>;
> > +             vin-supply = <&vcc5v0_sys>;
> > +     };
> > +};
> > +
> > +&combphy1 {
> > +     status = "okay";
> > +};
> > +
> > +&combphy2 {
> > +     status = "okay";
> > +};
> > +
> > +&cpu0 {
> > +     cpu-supply = <&vdd_cpu>;
> > +};
> > +
> > +&cpu1 {
> > +     cpu-supply = <&vdd_cpu>;
> > +};
> > +
> > +&cpu2 {
> > +     cpu-supply = <&vdd_cpu>;
> > +};
> > +
> > +&cpu3 {
> > +     cpu-supply = <&vdd_cpu>;
> > +};
> > +
> > +&gmac1 {
> > +     assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
> > +     assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru CLK_MAC1_2TOP>;
> > +     assigned-clock-rates = <0>, <125000000>;
> > +     clock_in_out = "output";
> > +     phy-mode = "rgmii-id";
> > +     phy-handle = <&rgmii_phy1>;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&gmac1m0_miim
> > +                  &gmac1m0_tx_bus2_level3
> > +                  &gmac1m0_rx_bus2
> > +                  &gmac1m0_rgmii_clk_level2
> > +                  &gmac1m0_rgmii_bus_level3>;
> > +     snps,reset-gpio = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
> > +     snps,reset-active-low;
> > +     /* Reset time is 20ms, 100ms for rtl8211f */
> > +     snps,reset-delays-us = <0 20000 100000>;
>
> These snps,reset props is deprecated, please add reset props to the
> Ethernet PHY node.

Will fix it in new patch.

>
> > +     status = "okay";
> > +};
> > +
> > +&gpu {
> > +     mali-supply = <&vdd_gpu>;
> > +     status = "okay";
> > +};
> > +
> > +&i2c0 {
> > +     status = "okay";
> > +
> > +     vdd_cpu: regulator@1c {
> > +             compatible = "tcs,tcs4525";
> > +             reg = <0x1c>;
> > +             fcs,suspend-voltage-selector = <1>;
> > +             regulator-name = "vdd_cpu";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt = <800000>;
> > +             regulator-max-microvolt = <1150000>;
> > +             regulator-ramp-delay = <2300>;
> > +             vin-supply = <&vcc5v0_sys>;
> > +
> > +             regulator-state-mem {
> > +                     regulator-off-in-suspend;
> > +             };
> > +     };
> > +
> > +     rk809: pmic@20 {
> > +             compatible = "rockchip,rk809";
> > +             reg = <0x20>;
> > +             interrupt-parent = <&gpio0>;
> > +             interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
> > +             #clock-cells = <1>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pmic_int>;
> > +             system-power-controller;
> > +             vcc1-supply = <&vcc3v3_sys>;
> > +             vcc2-supply = <&vcc3v3_sys>;
> > +             vcc3-supply = <&vcc3v3_sys>;
> > +             vcc4-supply = <&vcc3v3_sys>;
> > +             vcc5-supply = <&vcc3v3_sys>;
> > +             vcc6-supply = <&vcc3v3_sys>;
> > +             vcc7-supply = <&vcc3v3_sys>;
> > +             vcc8-supply = <&vcc3v3_sys>;
> > +             vcc9-supply = <&vcc3v3_sys>;
> > +             wakeup-source;
> > +
> > +             regulators {
> > +                     vdd_logic: DCDC_REG1 {
> > +                             regulator-name = "vdd_logic";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-initial-mode = <0x2>;
> > +                             regulator-min-microvolt = <500000>;
> > +                             regulator-max-microvolt = <1350000>;
> > +                             regulator-ramp-delay = <6001>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vdd_gpu: DCDC_REG2 {
> > +                             regulator-name = "vdd_gpu";
> > +                             regulator-always-on;
> > +                             regulator-initial-mode = <0x2>;
> > +                             regulator-min-microvolt = <500000>;
> > +                             regulator-max-microvolt = <1350000>;
> > +                             regulator-ramp-delay = <6001>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vcc_ddr: DCDC_REG3 {
> > +                             regulator-name = "vcc_ddr";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-initial-mode = <0x2>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-on-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vdd_npu: DCDC_REG4 {
> > +                             regulator-name = "vdd_npu";
> > +                             regulator-initial-mode = <0x2>;
> > +                             regulator-min-microvolt = <500000>;
> > +                             regulator-max-microvolt = <1350000>;
> > +                             regulator-ramp-delay = <6001>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vcc_1v8: DCDC_REG5 {
> > +                             regulator-name = "vcc_1v8";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-min-microvolt = <1800000>;
> > +                             regulator-max-microvolt = <1800000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vdda0v9_image: LDO_REG1 {
> > +                             regulator-name = "vdda0v9_image";
> > +                             regulator-min-microvolt = <950000>;
> > +                             regulator-max-microvolt = <950000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vdda_0v9: LDO_REG2 {
> > +                             regulator-name = "vdda_0v9";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-min-microvolt = <900000>;
> > +                             regulator-max-microvolt = <900000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vdda0v9_pmu: LDO_REG3 {
> > +                             regulator-name = "vdda0v9_pmu";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-min-microvolt = <900000>;
> > +                             regulator-max-microvolt = <900000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-on-in-suspend;
> > +                                     regulator-suspend-microvolt = <900000>;
> > +                             };
> > +                     };
> > +
> > +                     vccio_acodec: LDO_REG4 {
> > +                             regulator-name = "vccio_acodec";
> > +                             regulator-min-microvolt = <3300000>;
> > +                             regulator-max-microvolt = <3300000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vccio_sd: LDO_REG5 {
> > +                             regulator-name = "vccio_sd";
> > +                             regulator-min-microvolt = <1800000>;
> > +                             regulator-max-microvolt = <3300000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vcc3v3_pmu: LDO_REG6 {
> > +                             regulator-name = "vcc3v3_pmu";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-min-microvolt = <3300000>;
> > +                             regulator-max-microvolt = <3300000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-on-in-suspend;
> > +                                     regulator-suspend-microvolt = <3300000>;
> > +                             };
> > +                     };
> > +
> > +                     vcca_1v8: LDO_REG7 {
> > +                             regulator-name = "vcca_1v8";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-min-microvolt = <1800000>;
> > +                             regulator-max-microvolt = <1800000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vcca1v8_pmu: LDO_REG8 {
> > +                             regulator-name = "vcca1v8_pmu";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +                             regulator-min-microvolt = <1800000>;
> > +                             regulator-max-microvolt = <1800000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-on-in-suspend;
> > +                                     regulator-suspend-microvolt = <1800000>;
> > +                             };
> > +                     };
> > +
> > +                     vcca1v8_image: LDO_REG9 {
> > +                             regulator-name = "vcca1v8_image";
> > +                             regulator-min-microvolt = <1800000>;
> > +                             regulator-max-microvolt = <1800000>;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vcc_3v3: SWITCH_REG1 {
> > +                             regulator-name = "vcc_3v3";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +
> > +                     vcc3v3_sd: SWITCH_REG2 {
> > +                             regulator-name = "vcc3v3_sd";
> > +                             regulator-always-on;
> > +                             regulator-boot-on;
> > +
> > +                             regulator-state-mem {
> > +                                     regulator-off-in-suspend;
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&i2c1 {
> > +     status = "okay";
> > +
> > +     hym8563: rtc@51 {
> > +             compatible = "haoyu,hym8563";
> > +             reg = <0x51>;
> > +             #clock-cells = <0>;
> > +             clock-output-names = "hym8563";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&hym8563_int>;
> > +             interrupt-parent = <&gpio0>;
> > +             interrupts = <RK_PD3 IRQ_TYPE_LEVEL_LOW>;
> > +             wakeup-source;
> > +     };
> > +};
> > +
> > +&mdio1 {
> > +     rgmii_phy1: ethernet-phy@1 {
> > +             compatible = "ethernet-phy-ieee802.3-c22";
> > +             reg = <1>;
> > +             interrupt-parent = <&gpio4>;
> > +             interrupts = <RK_PC3 IRQ_TYPE_LEVEL_LOW>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&eth_phy_reset_pin>;
>
> Please add the reset props here.
>
> > +     };
> > +};
> > +
> > +&pcie2x1 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pcie_reset_h>;
> > +     reset-gpios = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
> > +     status = "okay";
> > +};
> > +
> > +&pinctrl {
> > +     gpio-leds {
> > +             lan_led_pin: lan-led-pin {
> > +                     rockchip,pins = <3 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> > +             };
> > +
> > +             power_led_pin: power-led-pin {
> > +                     rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> > +             };
> > +
> > +             wan_led_pin: wan-led-pin {
> > +                     rockchip,pins = <3 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
> > +             };
> > +     };
> > +
> > +     gmac {
> > +             eth_phy_reset_pin: eth-phy-reset-pin {
> > +                     rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_up>;
> > +             };
> > +     };
> > +
> > +     pcie {
> > +             pcie_reset_h: pcie-reset-h {
> > +                     rockchip,pins = <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_down>;
> > +             };
> > +     };
> > +
> > +     pmic {
> > +             pmic_int: pmic-int {
> > +                     rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> > +             };
> > +     };
> > +
> > +     rockchip-key {
> > +             reset_button_pin: reset-button-pin {
> > +                     rockchip,pins = <0 RK_PC2 RK_FUNC_GPIO &pcfg_pull_up>;
> > +             };
> > +     };
> > +
> > +     rtc {
> > +             hym8563_int: hym8563-int {
> > +                     rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
> > +             };
> > +     };
> > +
> > +     usb {
> > +             vcc5v0_usb_host_en: vcc5v0-usb-host-en {
> > +                     rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> > +             };
> > +     };
> > +};
> > +
> > +&pmu_io_domains {
> > +     status = "okay";
>
> The status prop is typically the last prop.

Will fix it in new patch.

>
> > +     pmuio1-supply = <&vcc3v3_pmu>;
> > +     pmuio2-supply = <&vcc3v3_pmu>;
> > +     vccio1-supply = <&vccio_acodec>;
> > +     vccio2-supply = <&vcc_1v8>;
> > +     vccio3-supply = <&vccio_sd>;
> > +     vccio4-supply = <&vcc_3v3>;
> > +     vccio5-supply = <&vcc_1v8>;
> > +     vccio6-supply = <&vcc_3v3>;
> > +     vccio7-supply = <&vcc_3v3>;
> > +};
> > +
> > +&sdhci {
> > +     bus-width = <8>;
> > +     max-frequency = <200000000>;
> > +     non-removable;
>
> Please add the hs200 prop here, or we will need to add is in U-Boot to
> be able to boot from eMMC.

Thanks for the hint, will fix it in new patch.

Thanks,
Tianling.

>
> Regards,
> Jonas
>
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
> > +     status = "okay";
> > +};
> > +
> > +&sdmmc0 {
> > +     bus-width = <4>;
> > +     cap-mmc-highspeed;
> > +     cap-sd-highspeed;
> > +     disable-wp;
> > +     no-sdio;
> > +     no-mmc;
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> > +     sd-uhs-sdr50;
> > +     vmmc-supply = <&vcc3v3_sd>;
> > +     vqmmc-supply = <&vccio_sd>;
> > +     status = "okay";
> > +};
> > +
> > +&tsadc {
> > +     status = "okay";
> > +};
> > +
> > +&uart2 {
> > +     status = "okay";
> > +};
> > +
> > +&usb2phy0 {
> > +     status = "okay";
> > +};
> > +
> > +&usb2phy0_host {
> > +     phy-supply = <&vcc5v0_usb>;
> > +     status = "okay";
> > +};
> > +
> > +&usb2phy0_otg {
> > +     status = "okay";
> > +};
> > +
> > +&usb_host0_xhci {
> > +     extcon = <&usb2phy0>;
> > +     status = "okay";
> > +};
> > +
> > +&usb_host1_xhci {
> > +     status = "okay";
> > +};
> > +
> > +&vop {
> > +     assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
> > +     assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
> > +     status = "okay";
> > +};
> > +
> > +&vop_mmu {
> > +     status = "okay";
> > +};
>

