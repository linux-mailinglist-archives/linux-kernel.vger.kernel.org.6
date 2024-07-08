Return-Path: <linux-kernel+bounces-244180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2579B92A059
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A326E1F211CC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B34977111;
	Mon,  8 Jul 2024 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNhkTbDO"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5667029CEB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435152; cv=none; b=NLh4ERB37CSUIu7tSPXq/xoXV9EP3p8UVkHpVJf85Laqj4owqxyysmTfhRFVaUWP6E7V8BH/tNZlIFTaUwdCcu1Ixj8irkaawuuENS6Z7OzGgPeBaRwtjmrHvsT5jfkCtF5vQSO1ebXTAtrac5asE4EpDiIz8dHfG7e7RAihcPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435152; c=relaxed/simple;
	bh=/xcVJFK6RKS+DK6bYBnuMiiKIYgcDjsHyc/DztIsWP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mS8lqh+tG90uVMCJPu2JtccGw3gh5k8PX+BqUZav6JgDK/SXYOhNOxhx/QblfIkf1dxFVu2fphGAx7x5CdqPv70nMNn+pO0DSkzDoxkVUSiS1kYnO3rkeqG5CtupCdJxXyfDgX7fLaCeiRMwH/FgP5gyXc5wdFcq4mh5vlvIrUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fNhkTbDO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77c349bb81so313385766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 03:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720435148; x=1721039948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9jxzyIxqTABgkhjm6R4qxSzR4yYlT0nTZszB5SrFD9s=;
        b=fNhkTbDOyOXiSzc0rOBjXIFzMpRtWiwjecBlNEorKTqbXtQ0Z+p5ewiRws4j0XwSWs
         /yi/DQFrFJe0tRp89Idt/Od9Iq40gL8jKP8aKVjZ35nxjSEYpOayHEDYQliP1RqScc/c
         TCMtj9EaJ0NIRMop1sVV4pmuFmgaBAzB42cggnltsnvGkPKJLAHu7Xm13KKvlOgUwJoO
         +IW5GQmJZhwsxOYGOmO75eHqBlmfN+1hd09wta9jkDxHzCHl0eZZbaMvlhlB+3N4FSz+
         MeV00Z5zcFRP+oiuC7rN1M5cAOgU1cA+5T3ldmIIPfbKIHDj6qtkkid6GI1vThRfec0o
         CmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720435148; x=1721039948;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jxzyIxqTABgkhjm6R4qxSzR4yYlT0nTZszB5SrFD9s=;
        b=i8uUEpA4YqGxS28Ss1mdJeCBLGkCP5KDCLCmo4bgGU87PmyhCmKEAsed1QlhEKJUjG
         pxBBZ/IN8MptFySSDxD6A5qQqFaFqop5qWBFlvIQmAgXhDfcv5z7PFPUY9YaJXeYQG+/
         f1/bUmuy838mlzg0EsMeEdvZv/jvsALHFF1XBBJIEig8Qjc9xDZCQ1vKweKJ1ANxrGhD
         7SCrYgGbOfD3dEM1q34oM6bsu9U/fkuKXbJ/uMYcgbSRqPhaSRIpsxc8EeoxltSmmlJi
         ZMtyW3RqTvG9YcoFAf5/mlxHNVKnN/3fyMHX9U/dQcPrS/vRanfwGQvdgC6HC293tZyt
         z1+w==
X-Forwarded-Encrypted: i=1; AJvYcCWVCvjdcr09MN/SYM8bxEOqcWxTFWd8UlBKmEATS49H+ZSg0r3aEU6apD1MQTUdjjBc6ID/71OYTnmSQFk4Ees1gZZBlWhzHKCtzL8D
X-Gm-Message-State: AOJu0YyQED7s8rR9QSRCy3057s0+KqdgBUzRaL0e6q3dFM7HgvFjA/HW
	m5c7poLrbXl75yA78H1gCA0Q4VM6JBDFcTtyTsI3waU6n5GFFblYBJjJpzqvWac=
X-Google-Smtp-Source: AGHT+IGDO+mSbeS1LZffv7q+j89FCECA4eSRvjqLw9Nh91QptkKNmlQCCH9zQz3ZWo4gZH60p/amvA==
X-Received: by 2002:a17:906:fa0e:b0:a72:8d2f:859c with SMTP id a640c23a62f3a-a77ba48deb1mr726233466b.33.1720435147450;
        Mon, 08 Jul 2024 03:39:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77c0117b15sm356874666b.43.2024.07.08.03.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 03:39:06 -0700 (PDT)
Message-ID: <a049486a-0ec6-4e12-afbf-7c0def8ef23b@linaro.org>
Date: Mon, 8 Jul 2024 12:39:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: aspeed: Add IEISystems NF5280M7 BMC machine
To: George Liu <liuxiwei1013@gmail.com>, linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au
References: <20240708062316.208383-1-liuxiwei@ieisystem.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240708062316.208383-1-liuxiwei@ieisystem.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/07/2024 08:23, George Liu wrote:
> The IEISystems NF5280M7 is an x86 platform server with an
> AST2600-based BMC.
> This dts file provides a basic configuration for its OpenBMC
> development.
> 
> Signed-off-by: George Liu <liuxiwei@ieisystem.com>
> ---

No changelog, so did you just ignore all feedback?

>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../aspeed/aspeed-bmc-ieisystems-nf5280m7.dts | 697 ++++++++++++++++++
>  2 files changed, 698 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index 5e3392621697..51531d494415 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -40,6 +40,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-ibm-rainier-1s4u.dtb \
>  	aspeed-bmc-ibm-rainier-4u.dtb \
>  	aspeed-bmc-ibm-system1.dtb \
> +	aspeed-bmc-ieisystems-nf5280m7.dtb \
>  	aspeed-bmc-intel-s2600wf.dtb \
>  	aspeed-bmc-inspur-fp5280g2.dtb \
>  	aspeed-bmc-inspur-nf5280m6.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts
> new file mode 100644
> index 000000000000..d706b4f64f6c
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts
> @@ -0,0 +1,697 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2023 IEISystems Corporation
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/leds/leds-pca955x.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +	model = "NF5280M7 BMC";
> +	compatible = "ieisystems,nf5280m7-bmc", "aspeed,ast2600";
> +	aliases {
> +		i2c200 = &bus2_mux70_0;
> +		i2c500 = &bus5_mux00;
> +		i2c501 = &bus5_mux01;
> +		i2c600 = &i2c6s0ch0;
> +		i2c601 = &i2c6s0ch1;
> +		i2c602 = &i2c6s0ch2;
> +		i2c603 = &i2c6s0ch3;
> +		i2c604 = &i2c6s0ch4;
> +		i2c605 = &i2c6s0ch5;
> +		i2c606 = &i2c6s0ch6;
> +		i2c607 = &i2c6s0ch7;
> +		i2c610 = &i2c6s1ch0;
> +		i2c611 = &i2c6s1ch1;
> +		i2c612 = &i2c6s1ch2;
> +		i2c613 = &i2c6s1ch3;
> +		i2c614 = &i2c6s1ch4;
> +		i2c615 = &i2c6s1ch5;
> +		i2c616 = &i2c6s1ch6;
> +		i2c617 = &i2c6s1ch7;
> +		i2c620 = &i2c6s2ch0;
> +		i2c621 = &i2c6s2ch1;
> +		i2c622 = &i2c6s2ch2;
> +		i2c623 = &i2c6s2ch3;
> +		i2c624 = &i2c6s2ch4;
> +		i2c625 = &i2c6s2ch5;
> +		i2c626 = &i2c6s2ch6;
> +		i2c627 = &i2c6s2ch7;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200n8";

Not much improved.

> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		video_engine_memory: jpegbuffer {
> +			size = <0x02000000>;	/* 32M */
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		vga_memory: frammebuffer {
> +			no-map;
> +			reg = <0x9ff00000 0x01000000>; /* 16M */
> +		};
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +                      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +                      <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
> +                      <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		cpld {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			label = "cpld";
> +			gpios = <&gpio0 ASPEED_GPIO(N, 2) GPIO_ACTIVE_HIGH>;
> +			linux,code = <ASPEED_GPIO(N, 2)>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		fan-fault {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			label = "fan-fault";
> +			gpios = <&gpio0 ASPEED_GPIO(B, 0) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		system-hot {
> +			label = "system-hot";
> +			gpios = <&gpio0 ASPEED_GPIO(B, 1) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		psu-fault {
> +			label = "psu-fault";
> +			gpios = <&gpio0 ASPEED_GPIO(B, 2) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		heartbeat {
> +			label = "heartbeat";
> +			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		memory-fault {
> +			label = "memory-fault";
> +			gpios = <&gpio0 ASPEED_GPIO(Y, 2) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		system-fault {
> +			label = "system-fault";
> +			gpios = <&gpio0 ASPEED_GPIO(Y, 3) GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&fmc {
> +	status = "okay";
> +
> +	flash@0 {
> +		status = "okay";
> +
> +		m25p,fast-read;
> +		label = "bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64.dtsi"
> +	};
> +	flash@1 {
> +		status = "okay";
> +
> +		m25p,fast-read;
> +		label = "alt-bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64-alt.dtsi"
> +	};
> +};
> +
> +
> +&spi1 {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi1_default>;
> +
> +	flash@0 {
> +		status = "okay";
> +
> +		m25p,fast-read;
> +		label = "bios";
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
> +&peci0 {
> +	status = "okay";
> +
> +	gpios = <&gpio0 ASPEED_GPIO(F, 6) 0>;
> +
> +	peci-client@30 {
> +		compatible = "intel,peci-client";
> +		reg = <0x30>;
> +	};
> +
> +	peci-client@31 {
> +		compatible = "intel,peci-client";
> +		reg = <0x31>;
> +	};
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +
> +	gpio-line-names =
> +	/*A0-A7*/	"","","","","","","","",
> +	/*B0-B7*/	"","","","","","","","",
> +	/*C0-C7*/	"","","","","","","","",
> +	/*D0-D7*/	"","","","","","","","",
> +	/*E0-E7*/	"","","","","","","","",
> +	/*F0-F7*/	"","","","","","","","",
> +	/*G0-G7*/	"","","","","","","","",
> +	/*H0-H7*/	"","","","","","","","",
> +	/*I0-I7*/	"","","","","","POWER_OUT","RESET_OUT","",
> +	/*J0-J7*/	"","","","","","","","",
> +	/*K0-K7*/	"","","","","","","","",
> +	/*L0-L7*/	"","","","","","","","",
> +	/*M0-M7*/	"","","","","","","","",
> +	/*N0-N7*/	"","","","","","","","",
> +	/*O0-O7*/	"","","","","","","","",
> +	/*P0-P7*/	"RESET_BUTTON","","","NMI_BUTTON","NMI_OUT","","","",
> +	/*Q0-Q7*/	"","","","","","","","",
> +	/*R0-R7*/	"","","","","","","","",
> +	/*S0-S7*/	"","","","SIO_ONCONTROL","","","","",
> +	/*T0-T7*/	"","","","","","","","",
> +	/*U0-U7*/	"","","","","","","","",
> +	/*V0-V7*/	"","SIO_S5","POWER_BUTTON","","PS_PWROK","","","",
> +	/*W0-W7*/	"","","","","","","","",
> +	/*X0-X7*/	"","","POST_COMPLETE","","","","","",
> +	/*Y0-Y7*/	"","","","","","","","",
> +	/*Z0-Z7*/	"","","","","","","","";
> +};
> +
> +&kcs3 {
> +	aspeed,lpc-io-reg = <0xCA2>;
> +	status = "okay";
> +};
> +
> +&kcs4 {
> +	aspeed,lpc-io-reg = <0xCA4>;
> +	status = "okay";
> +};
> +
> +&lpc_snoop {
> +	snoop-ports = <0x80>;
> +	status = "okay";
> +};
> +
> +&mdio1 {
> +	status = "okay";
> +
> +	ethphy1: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&mac2 {
> +	status = "okay";
> +
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy1>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii3_default>;
> +};
> +
> +&mac3 {
> +	status = "okay";
> +
> +	phy-mode = "rmii";
> +	use-ncsi;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii4_default>;
> +};
> +
> +&adc0 {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> +		&pinctrl_adc2_default &pinctrl_adc3_default
> +		&pinctrl_adc4_default &pinctrl_adc5_default
> +		&pinctrl_adc6_default &pinctrl_adc7_default>;
> +};
> +
> +&adc1 {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
> +		&pinctrl_adc10_default &pinctrl_adc11_default
> +		&pinctrl_adc12_default &pinctrl_adc13_default
> +		&pinctrl_adc14_default &pinctrl_adc15_default>;
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
> +
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&vuart1 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	multi-master;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	multi-master;
> +	status = "okay";
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c256";
> +		reg = <0x50>;
> +	};
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	i2c-mux@70 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x70>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		bus2_mux70_0:i2c@2 {

Why did you change the format and dropped the space after :?

Please respond to previous feedback and acknowledge each comment.

Best regards,
Krzysztof


