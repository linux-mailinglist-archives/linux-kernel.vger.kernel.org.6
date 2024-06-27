Return-Path: <linux-kernel+bounces-232031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B98F991A1D9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02AE6B209F4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629F112D214;
	Thu, 27 Jun 2024 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="I+Nqw1kp"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A91B819
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478079; cv=none; b=mOUD/8juSLRwr0N/WP+5iZYhTIeOBai6KKe+Z7fjuaiCQ53j/fJuLRJ1QmiXjgWldfvBpWPSBZIajMwPIerU6IwKK/sYK2OP//dv1+DoPIeouTEB8yiaTf+QH9hFolm9mMyDqTNN0HZRiYvzjjhYaD3OGeW/c+huGbVqD7kizas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478079; c=relaxed/simple;
	bh=q8M51lQjnt7Y5JmkpTTvZKAPcUFC9o9IUGAz86qhKF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OF9gLMl3MB/s32eL836k38ljFNmOB2WNPNwdrzHzAI1ZshlzwXazh8b/cngEUguv7Bt5bsym3lGEYSxRELSC7VId5uOl+1sIhHU7Z1LccRKXR+6e7pWhZR5bCbCVk/CauownIArzj+hT9sZIhgs/QeI9jOJ5IwdjWGoe6gQVs7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=I+Nqw1kp; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1719478069; x=1722070069;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q8M51lQjnt7Y5JmkpTTvZKAPcUFC9o9IUGAz86qhKF0=;
	b=I+Nqw1kposlm4eXP6F8ybFXxzBb9jMBRvPvMiKPWuqOzVJVkuy+sY68gsnFX92jO
	pp3MZnnmfkgXjNF34YL0zLyTlqF3DQWaI108VoLzkCBHkR2PBEI4Z0xL7cOIV82m
	tGI8yPpX7Tt7MBZdvDvjUgZ+XOfL6o++jAIk+hPKkhc=;
X-AuditID: ac14000a-03e52700000021bc-94-667d273597b1
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 0A.74.08636.5372D766; Thu, 27 Jun 2024 10:47:49 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 27 Jun
 2024 10:47:48 +0200
Message-ID: <ed3e13c0-1e2e-428f-ae78-f30d590effb4@phytec.de>
Date: Thu, 27 Jun 2024 10:47:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: dts: ti: Add am62x-phyboard-lyra carrier
 board
To: Garrett Giordano <ggiordano@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
References: <20240626155244.3311436-1-ggiordano@phytec.com>
 <20240626155244.3311436-2-ggiordano@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240626155244.3311436-2-ggiordano@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWyRpKBR9dUvTbN4ONedYs1e88xWcw/co7V
	Yv2W32wWyz/PZrd4Oesem8Wmx9dYLS7vmsNm8ebHWSaL/3t2sFt0v1O3+H/2A7sDt8emVZ1s
	HpuX1Hv0d7ewevy5+I7V4/iN7UwenzfJBbBFcdmkpOZklqUW6dslcGV0329gKXjbzFixrucH
	WwPjqfQuRk4OCQETiS+33jB2MXJxCAksYZJ4/bSdBcK5yyix+9NMNpAqXgEbiZk/D7GD2CwC
	qhJ9qw6xQMQFJU7OfAJmiwrIS9y/NQOsRlggWOLju5+sIINEBJYwSkzqXMgG4jALtDFKPHl4
	gBmkSkggV2LDtDVgNrOAuMStJ/OZQGw2AXWJOxu+AXVzcHACbX52Pw6ixEJi8ZuD7BC2vMT2
	t3OgxshLvLi0nAXiHXmJaedeM0PYoRJHNq1mmsAoPAvJrbOQbJuFZOwsJGMXMLKsYhTKzUzO
	Ti3KzNYryKgsSU3WS0ndxAiKOREGrh2MfXM8DjEycTAeYpTgYFYS4Q0tqUoT4k1JrKxKLcqP
	LyrNSS0+xCjNwaIkzru6IzhVSCA9sSQ1OzW1ILUIJsvEwSnVwLhj3veQALGZE+uSHPmlXXf3
	b3qebHDi4mOZfZlyDHLHlBRfOF5R17fLjT2WnlrfXN9pFV9St+9P4LyTEpJWczNP3OIy2NNo
	/7vXNHvlm/NVEVfZpK1lmS9y/UqW6nnqa/Ts+cdtd/fnG4TubHl41snC2OnS9brW5GqPowVF
	XQWxOcGfTx8NVWIpzkg01GIuKk4EAEz9zVmnAgAA



Am 26.06.24 um 17:52 schrieb Garrett Giordano:
> PHYTECs phyBOARD-Lyra carrier board is able to accomidate multiple SoMs.
> Refactor k3-am625-phyboard-lyra-rdk.dts into an include file so it can
> be reused in combination with our phyCORE-AM62Ax SoM.
> 
> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>


> ---
> -v2
>    - Reformat patches using -B/-M/-C arguments
> ---
>   .../dts/ti/k3-am625-phyboard-lyra-rdk.dts     | 501 +-----------------
>   ...ra-rdk.dts => k3-am62x-phyboard-lyra.dtsi} |   8 -
>   2 files changed, 18 insertions(+), 491 deletions(-)
>   rewrite arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts (96%)
>   copy arch/arm64/boot/dts/ti/{k3-am625-phyboard-lyra-rdk.dts => k3-am62x-phyboard-lyra.dtsi} (97%)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> dissimilarity index 96%
> index 50d2573c840e..4fa5efdffcd7 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> @@ -1,483 +1,18 @@
> -// SPDX-License-Identifier: GPL-2.0-only OR MIT
> -/*
> - * Copyright (C) 2022-2024 PHYTEC Messtechnik GmbH
> - * Author: Wadim Egorov <w.egorov@phytec.de>
> - *
> - * Product homepage:
> - * https://www.phytec.com/product/phyboard-am62x
> - */
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/input/input.h>
> -#include <dt-bindings/leds/common.h>
> -#include <dt-bindings/net/ti-dp83867.h>
> -#include "k3-am625.dtsi"
> -#include "k3-am62-phycore-som.dtsi"
> -
> -/ {
> -	compatible = "phytec,am625-phyboard-lyra-rdk",
> -		     "phytec,am62-phycore-som", "ti,am625";
> -	model = "PHYTEC phyBOARD-Lyra AM625";
> -
> -	aliases {
> -		serial2 = &main_uart0;
> -		serial3 = &main_uart1;
> -		mmc1 = &sdhci1;
> -		usb0 = &usb0;
> -		usb1 = &usb1;
> -		ethernet1 = &cpsw_port2;
> -	};
> -
> -	can_tc1: can-phy0 {
> -		compatible = "ti,tcan1042";
> -		#phy-cells = <0>;
> -		max-bitrate = <8000000>;
> -		standby-gpios = <&gpio_exp 1 GPIO_ACTIVE_HIGH>;
> -	};
> -
> -	hdmi0: connector-hdmi {
> -		compatible = "hdmi-connector";
> -		label = "hdmi";
> -		type = "a";
> -
> -		port {
> -			hdmi_connector_in: endpoint {
> -				remote-endpoint = <&sii9022_out>;
> -			};
> -		};
> -	};
> -
> -	keys {
> -		compatible = "gpio-keys";
> -		autorepeat;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&gpio_keys_pins_default>;
> -
> -		key-home {
> -			label = "home";
> -			linux,code = <KEY_HOME>;
> -			gpios = <&main_gpio1 23 GPIO_ACTIVE_HIGH>;
> -		};
> -
> -		key-menu {
> -			label = "menu";
> -			linux,code = <KEY_MENU>;
> -			gpios = <&gpio_exp 4 GPIO_ACTIVE_HIGH>;
> -		};
> -	};
> -
> -	sound {
> -		compatible = "simple-audio-card";
> -		simple-audio-card,name = "phyBOARD-Lyra";
> -		simple-audio-card,widgets =
> -			"Microphone",           "Mic Jack",
> -			"Headphone",            "Headphone Jack",
> -			"Speaker",              "External Speaker";
> -		simple-audio-card,routing =
> -			"MIC3R",                "Mic Jack",
> -			"Mic Jack",             "Mic Bias",
> -			"Headphone Jack",       "HPLOUT",
> -			"Headphone Jack",       "HPROUT",
> -			"External Speaker",     "SPOP",
> -			"External Speaker",     "SPOM";
> -		simple-audio-card,format = "dsp_b";
> -		simple-audio-card,bitclock-master = <&sound_master>;
> -		simple-audio-card,frame-master = <&sound_master>;
> -		simple-audio-card,bitclock-inversion;
> -
> -		simple-audio-card,cpu {
> -			sound-dai = <&mcasp2>;
> -		};
> -
> -		sound_master: simple-audio-card,codec {
> -				sound-dai = <&audio_codec>;
> -				clocks = <&audio_refclk1>;
> -		};
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&leds_pins_default>, <&user_leds_pins_default>;
> -
> -		led-1 {
> -			gpios = <&main_gpio0 32 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "mmc0";
> -		};
> -
> -		led-2 {
> -			gpios = <&gpio_exp 2 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "mmc1";
> -		};
> -	};
> -
> -	vcc_1v8: regulator-vcc-1v8 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "VCC_1V8";
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -	vcc_3v3_mmc: regulator-vcc-3v3-mmc {
> -		compatible = "regulator-fixed";
> -		regulator-name = "VCC_3V3_MMC";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -
> -	vcc_3v3_sw: regulator-vcc-3v3-sw {
> -		compatible = "regulator-fixed";
> -		regulator-name = "VCC_3V3_SW";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
> -};
> -
> -&main_pmx0 {
> -	audio_ext_refclk1_pins_default: audio-ext-refclk1-default-pins {
> -		pinctrl-single,pins = <
> -			AM62X_IOPAD(0x0a0, PIN_OUTPUT, 1) /* (K25) GPMC0_WPn.AUDIO_EXT_REFCLK1 */
> -		>;
> -	};
> -
> -	gpio_keys_pins_default: gpio-keys-default-pins {
> -		pinctrl-single,pins = <
> -			AM62X_IOPAD(0x1d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
> -		>;
> -	};
> -
> -	gpio_exp_int_pins_default: gpio-exp-int-default-pins {
> -		pinctrl-single,pins = <
> -			AM62X_IOPAD(0x244, PIN_INPUT, 7) /* (C17) MMC1_SDWP.GPIO1_49 */
> -		>;
> -	};
> -
> -	hdmi_int_pins_default: hdmi-int-default-pins {
> -		pinctrl-single,pins = <
> -			AM62X_IOPAD(0x040, PIN_INPUT, 7) /* (N23) GPMC0_AD1.GPIO0_16 */
> -		>;
> -	};
> -
> -	main_dss0_pins_default: main-dss0-default-pins {
> -		pinctrl-single,pins = <
> -			AM62X_IOPAD(0x0b8, PIN_OUTPUT, 0) /* (U22) VOUT0_DATA0 */
> -			AM62X_IOPAD(0x0bc, PIN_OUTPUT, 0) /* (V24) VOUT0_DATA1 */
> -			AM62X_IOPAD(0x0e0, PIN_OUTPUT, 0) /* (V20) VOUT0_DATA10 */
> -			AM62X_IOPAD(0x0e4, PIN_OUTPUT, 0) /* (AA23) VOUT0_DATA11 */
> -			AM62X_IOPAD(0x0e8, PIN_OUTPUT, 0) /* (AB25) VOUT0_DATA12 */
> -			AM62X_IOPAD(0x0ec, PIN_OUTPUT, 0) /* (AA24) VOUT0_DATA13 */
> -			AM62X_IOPAD(0x0f0, PIN_OUTPUT, 0) /* (Y22) VOUT0_DATA14 */
> -			AM62X_IOPAD(0x0f4, PIN_OUTPUT, 0) /* (AA21) VOUT0_DATA15 */
> -			AM62X_IOPAD(0x0c0, PIN_OUTPUT, 0) /* (W25) VOUT0_DATA2 */
> -			AM62X_IOPAD(0x0c4, PIN_OUTPUT, 0) /* (W24) VOUT0_DATA3 */
> -			AM62X_IOPAD(0x0c8, PIN_OUTPUT, 0) /* (Y25) VOUT0_DATA4 */
> -			AM62X_IOPAD(0x0cc, PIN_OUTPUT, 0) /* (Y24) VOUT0_DATA5 */
> -			AM62X_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (Y23) VOUT0_DATA6 */
> -			AM62X_IOPAD(0x0d4, PIN_OUTPUT, 0) /* (AA25) VOUT0_DATA7 */
> -			AM62X_IOPAD(0x0d8, PIN_OUTPUT, 0) /* (V21) VOUT0_DATA8 */
> -			AM62X_IOPAD(0x0dc, PIN_OUTPUT, 0) /* (W21) VOUT0_DATA9 */
> -			AM62X_IOPAD(0x0fc, PIN_OUTPUT, 0) /* (Y20) VOUT0_DE */
> -			AM62X_IOPAD(0x0f8, PIN_OUTPUT, 0) /* (AB24) VOUT0_HSYNC */
> -			AM62X_IOPAD(0x104, PIN_OUTPUT, 0) /* (AC24) VOUT0_PCLK */
> -			AM62X_IOPAD(0x100, PIN_OUTPUT, 0) /* (AC25) VOUT0_VSYNC */
> -		>;
> -	};
> -
> -	main_i2c1_pins_default: main-i2c1-default-pins {
> -		pinctrl-single,pins = <
> -			AM62X_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17) I2C1_SCL */
> -			AM62X_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */
> -		>;
> -	};
> -
> -	main_mcan0_pins_default: main-mcan0-default-pins {
> -		pinctrl-single,pins = <
> -			AM62X_IOPAD(0x1dc, PIN_INPUT, 0) /* (E15) MCAN0_RX */
> -			AM62X_IOPAD(0x1d8, PIN_OUTPUT, 0) /* (C15) MCAN0_TX */
> -		>;
> -	};
> -
> -	main_mcasp2_pins_default: main-mcasp2-default-pins {
> -		pinctrl-single,pins = <
> -			AM62X_IOPAD(0x070, PIN_INPUT, 3) /* (T24) GPMC0_AD13.MCASP2_ACLKX */
> -			AM62X_IOPAD(0x06c, PIN_INPUT, 3) /* (T22) GPMC0_AD12.MCASP2_AFSX */
> -			AM62X_IOPAD(0x064, PIN_OUTPUT, 3) /* (T25) GPMC0_AD10.MCASP2_AXR2 */
> -			AM62X_IOPAD(0x068, PIN_INPUT, 3) /* (R21) GPMC0_AD11.MCASP2_AXR3 */
> -		>;
> -	};
> -
> -	main_mmc1_pins_default: main-mmc1-default-pins {
> -		pinctrl-single,pins = <
> -			AM62X_IOPAD(0x23c, PIN_INPUT_PULLUP, 0) /* (A21) MMC1_CMD */
> -			AM62X_IOPAD(0x234, PIN_INPUT_PULLDOWN, 0) /* (B22) MMC1_CLK */
> -			AM62X_IOPAD(0x230, PIN_INPUT_PULLUP, 0) /* (A22) MMC1_DAT0 */
> -			AM62X_IOPAD(0x22c, PIN_INPUT_PULLUP, 0) /* (B21) MMC1_DAT1 */
> -			AM62X_IOPAD(0x228, PIN_INPUT_PULLUP, 0) /* (C21) MMC1_DAT2 */
> -			AM62X_IOPAD(0x224, PIN_INPUT_PULLUP, 0) /* (D22) MMC1_DAT3 */
> -			AM62X_IOPAD(0x240, PIN_INPUT_PULLUP, 0) /* (D17) MMC1_SDCD */
> -		>;
> -	};
> -
> -	main_rgmii2_pins_default: main-rgmii2-default-pins {
> -		pinctrl-single,pins = <
> -			AM62X_IOPAD(0x184, PIN_INPUT, 0) /* (AE23) RGMII2_RD0 */
> -			AM62X_IOPAD(0x188, PIN_INPUT, 0) /* (AB20) RGMII2_RD1 */
> -			AM62X_IOPAD(0x18c, PIN_INPUT, 0) /* (AC21) RGMII2_RD2 */
> -			AM62X_IOPAD(0x190, PIN_INPUT, 0) /* (AE22) RGMII2_RD3 */
> -			AM62X_IOPAD(0x180, PIN_INPUT, 0) /* (AD23) RGMII2_RXC */
> -			AM62X_IOPAD(0x17c, PIN_INPUT, 0) /* (AD22) RGMII2_RX_CTL */
> -			AM62X_IOPAD(0x16c, PIN_OUTPUT, 0) /* (Y18) RGMII2_TD0 */
> -			AM62X_IOPAD(0x170, PIN_OUTPUT, 0) /* (AA18) RGMII2_TD1 */
> -			AM62X_IOPAD(0x174, PIN_OUTPUT, 0) /* (AD21) RGMII2_TD2 */
> -			AM62X_IOPAD(0x178, PIN_OUTPUT, 0) /* (AC20) RGMII2_TD3 */
> -			AM62X_IOPAD(0x168, PIN_OUTPUT, 0) /* (AE21) RGMII2_TXC */
> -			AM62X_IOPAD(0x164, PIN_OUTPUT, 0) /* (AA19) RGMII2_TX_CTL */
> -		>;
> -	};
> -
> -	main_uart0_pins_default: main-uart0-default-pins {
> -		pinctrl-single,pins = <
> -			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
> -			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
> -		>;
> -	};
> -
> -	main_uart1_pins_default: main-uart1-default-pins {
> -		pinctrl-single,pins = <
> -			AM62X_IOPAD(0x194, PIN_INPUT, 2) /* (B19) MCASP0_AXR3.UART1_CTSn */
> -			AM62X_IOPAD(0x198, PIN_OUTPUT, 2) /* (A19) MCASP0_AXR2.UART1_RTSn */
> -			AM62X_IOPAD(0x1ac, PIN_INPUT, 2) /* (E19) MCASP0_AFSR.UART1_RXD */
> -			AM62X_IOPAD(0x1b0, PIN_OUTPUT, 2) /* (A20) MCASP0_ACLKR.UART1_TXD */
> -		>;
> -	};
> -
> -	main_usb1_pins_default: main-usb1-default-pins {
> -		pinctrl-single,pins = <
> -			AM62X_IOPAD(0x258, PIN_OUTPUT, 0) /* (F18) USB1_DRVVBUS */
> -		>;
> -	};
> -
> -	user_leds_pins_default: user-leds-default-pins {
> -		pinctrl-single,pins = <
> -			AM62X_IOPAD(0x084, PIN_OUTPUT, 7) /* (L23) GPMC0_ADVn_ALE.GPIO0_32 */
> -		>;
> -	};
> -};
> -
> -&cpsw3g {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&main_rgmii1_pins_default>, <&main_rgmii2_pins_default>;
> -};
> -
> -&cpsw_port2 {
> -	phy-mode = "rgmii-rxid";
> -	phy-handle = <&cpsw3g_phy3>;
> -};
> -
> -&cpsw3g_mdio {
> -	cpsw3g_phy3: ethernet-phy@3 {
> -		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
> -		reg = <3>;
> -		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
> -		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> -		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> -	};
> -};
> -
> -&dss {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&main_dss0_pins_default>;
> -	status = "okay";
> -};
> -
> -&dss_ports {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -
> -	/* VP2: DPI/HDMI Output */
> -	port@1 {
> -		reg = <1>;
> -
> -		dpi1_out: endpoint {
> -			remote-endpoint = <&sii9022_in>;
> -		};
> -	};
> -};
> -
> -&main_i2c1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&main_i2c1_pins_default>;
> -	clock-frequency = <100000>;
> -	status = "okay";
> -
> -	audio_codec: audio-codec@18 {
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&audio_ext_refclk1_pins_default>;
> -
> -		#sound-dai-cells = <0>;
> -		compatible = "ti,tlv320aic3007";
> -		reg = <0x18>;
> -		ai3x-micbias-vg = <2>;
> -
> -		AVDD-supply = <&vcc_3v3_sw>;
> -		IOVDD-supply = <&vcc_3v3_sw>;
> -		DRVDD-supply = <&vcc_3v3_sw>;
> -		DVDD-supply = <&vcc_1v8>;
> -	};
> -
> -	gpio_exp: gpio-expander@21 {
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&gpio_exp_int_pins_default>;
> -		compatible = "nxp,pcf8574";
> -		reg = <0x21>;
> -		interrupt-parent = <&main_gpio1>;
> -		interrupts = <49 0>;
> -		#gpio-cells = <2>;
> -		gpio-controller;
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -		gpio-line-names = "", "GPIO1_CAN0_nEN",
> -				  "GPIO2_LED2", "GPIO3_LVDS_GPIO",
> -				  "GPIO4_BUT2", "GPIO5_LVDS_BKLT_EN",
> -				  "GPIO6_ETH1_USER_RESET", "GPIO7_AUDIO_USER_RESET";
> -	};
> -
> -	usb-pd@22 {
> -		compatible = "ti,tps6598x";
> -		reg = <0x22>;
> -
> -		connector {
> -			compatible = "usb-c-connector";
> -			label = "USB-C";
> -			self-powered;
> -			data-role = "dual";
> -			power-role = "sink";
> -			port {
> -				usb_con_hs: endpoint {
> -					remote-endpoint = <&typec_hs>;
> -				};
> -			};
> -		};
> -	};
> -
> -	sii9022: bridge-hdmi@39 {
> -		compatible = "sil,sii9022";
> -		reg = <0x39>;
> -
> -		interrupt-parent = <&main_gpio0>;
> -		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hdmi_int_pins_default>;
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@0 {
> -				reg = <0>;
> -
> -				sii9022_in: endpoint {
> -					remote-endpoint = <&dpi1_out>;
> -				};
> -			};
> -
> -			port@1 {
> -				reg = <1>;
> -
> -				sii9022_out: endpoint {
> -					remote-endpoint = <&hdmi_connector_in>;
> -				};
> -			};
> -		};
> -	};
> -
> -	eeprom@51 {
> -		compatible = "atmel,24c02";
> -		pagesize = <16>;
> -		reg = <0x51>;
> -	};
> -};
> -
> -&main_mcan0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&main_mcan0_pins_default>;
> -	phys = <&can_tc1>;
> -	status = "okay";
> -};
> -
> -&main_uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&main_uart0_pins_default>;
> -	status = "okay";
> -};
> -
> -&main_uart1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&main_uart1_pins_default>;
> -	/* Main UART1 may be used by TIFS firmware */
> -	status = "okay";
> -};
> -
> -&mcasp2 {
> -	#sound-dai-cells = <0>;
> -
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&main_mcasp2_pins_default>;
> -
> -	/* MCASP_IIS_MODE */
> -	op-mode = <0>;
> -	tdm-slots = <2>;
> -
> -	/* 0: INACTIVE, 1: TX, 2: RX */
> -	serial-dir = <
> -			0 0 1 2
> -			0 0 0 0
> -			0 0 0 0
> -			0 0 0 0
> -	>;
> -	tx-num-evt = <32>;
> -	rx-num-evt = <32>;
> -	status = "okay";
> -};
> -
> -&sdhci1 {
> -	vmmc-supply = <&vcc_3v3_mmc>;
> -	vqmmc-supply = <&vddshv5_sdio>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&main_mmc1_pins_default>;
> -	disable-wp;
> -	no-1-8-v;
> -	status = "okay";
> -};
> -
> -&usbss0 {
> -	ti,vbus-divider;
> -	status = "okay";
> -};
> -
> -&usbss1 {
> -	ti,vbus-divider;
> -	status = "okay";
> -};
> -
> -&usb0 {
> -	usb-role-switch;
> -
> -	port {
> -		typec_hs: endpoint {
> -			remote-endpoint = <&usb_con_hs>;
> -		};
> -	};
> -};
> -
> -&usb1 {
> -	dr_mode = "host";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&main_usb1_pins_default>;
> -};
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2022-2024 PHYTEC Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov@phytec.de>
> + *
> + * Product homepage:
> + * https://www.phytec.com/product/phyboard-am62x
> + */
> +
> +#include "k3-am625.dtsi"
> +#include "k3-am62-phycore-som.dtsi"
> +#include "k3-am62x-phyboard-lyra.dtsi"
> +
> +/ {
> +	compatible = "phytec,am625-phyboard-lyra-rdk",
> +		     "phytec,am62-phycore-som", "ti,am625";
> +	model = "PHYTEC phyBOARD-Lyra AM625";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
> similarity index 97%
> copy from arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> copy to arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
> index 50d2573c840e..e4633af87eb9 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
> @@ -3,22 +3,14 @@
>    * Copyright (C) 2022-2024 PHYTEC Messtechnik GmbH
>    * Author: Wadim Egorov <w.egorov@phytec.de>
>    *
> - * Product homepage:
> - * https://www.phytec.com/product/phyboard-am62x
>    */
> 
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/input/input.h>
>   #include <dt-bindings/leds/common.h>
>   #include <dt-bindings/net/ti-dp83867.h>
> -#include "k3-am625.dtsi"
> -#include "k3-am62-phycore-som.dtsi"
> 
>   / {
> -	compatible = "phytec,am625-phyboard-lyra-rdk",
> -		     "phytec,am62-phycore-som", "ti,am625";
> -	model = "PHYTEC phyBOARD-Lyra AM625";
> -
>   	aliases {
>   		serial2 = &main_uart0;
>   		serial3 = &main_uart1;
> --
> 2.25.1
> 

