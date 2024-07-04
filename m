Return-Path: <linux-kernel+bounces-240906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D406E927469
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588A61F26D56
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45B31AC221;
	Thu,  4 Jul 2024 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7iwOw7o"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B461A08DE;
	Thu,  4 Jul 2024 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720090361; cv=none; b=UzQQYJK5k4UIAsHSOj8dt67h+CheQgv1tYnfW7t2lHTyoCVkNJu5xCSPqFVbbc6UUyoJ/a0q9tOn6YRVgYi9KzufR8BLdcskak7tEESjxfSvdkGeUIxnzBZp1GW17qz8ph17CRtJomsOBX4UlKa5pHLRB53U9+ntIWw6tLRfcWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720090361; c=relaxed/simple;
	bh=OcO9m+wuTVhWztPiJ+mzoPZNLAK+0RiANv6UmhJXZow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNajge1+cPXW5r5mePYyv15wCNGszYTTkosa3AaKCztFLAI28TZd3ReVxVCFmYXLBqlhi9C7Gp2aJIW54JshQc5zkBpwRqRRzbs09clkSeONgXXHAym+/6/ftjnRbCHlxXG7brrbni+f7I31mzNvSYmuh5h6Wf1DnFClvWhbAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7iwOw7o; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58b966b41fbso700894a12.1;
        Thu, 04 Jul 2024 03:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720090356; x=1720695156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5cCW6O5rLHohGIbpIvzk6T1RNsTScD5i/Fk0tmCOOs0=;
        b=M7iwOw7oJZBxzDw1jyML2YMGPZVX8voKRV6+teX56hpPWTN6eM8lVbkL0okBgS4cWw
         QtZW23IOMeiPUXa3fmerq7xxyRfQc1hbUGe8fq+g1ClnB1fT9r185mzdhkF4wccmyyDM
         4lQWflvIWIDXMKxqaCTo+mUrIHfHRRX2vjorSjllLsKljgrrruXx0u/xp1p9E8fPP676
         eWvJiS/nGTFmvfmMCcRPCh2M6mxDUtqNn7JowgmGluZUVKKAxhuEwiYwRme3LAY6gT9A
         eVINJ6ty2oJafvoRrOUBOBOH3FMO1EbEE4MW17xFwP+W1cplOdedBuKm99Vu0kDjbRCu
         rJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720090356; x=1720695156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cCW6O5rLHohGIbpIvzk6T1RNsTScD5i/Fk0tmCOOs0=;
        b=DVehAtl6p7fHHL1WRyD285Ut5/KkZf1D+K1ANr/AZUCUqKm634GNLl9t2ak19kTQso
         Me4Y9iFSvE27TIU1u1A91MjN/s+rUjAoM1/yEtFeVK6L/uBciNCaXI36aJ8K7+9liK4A
         WD5w0r+FEZw/wL3k246XrXa97mU0eagSoA48hn7e2HFaO8gEX41GutNClsJXMVkpHBD9
         3VoGgZ9ptJQbF92J5HpW/p9BEQdW8SulEbwr5pysMSnojmNWuhu/EGrp7ZpI0FXwiapy
         P1B9kJsJMUWom3Ic3wTn7noAJ9bdEIfRl+772MzOrnIKqF77+L2UfyODB4SbYjhzVd6y
         ZPmw==
X-Forwarded-Encrypted: i=1; AJvYcCX/Py61UbWxspWq6RzVropt0kom13ycXbpCJ0n0tbSZRnVldZKLbce0KKT8huytAxTnzY+CYihNxlmNuSPz6JjYQSi6l1gRzLkI74/Ja6JKCTJsEBxH9SDvzr2xDQqjP5F0aAlpvEwvGA==
X-Gm-Message-State: AOJu0YyDZB4/zMwsWRTLpGrZsfeV94KYI2PiCPpchJQTcShBDbPhTzzt
	xeMuSiRRp+EnFVdoXgBbZKUnrSWg8N+bPimzf9mq4CrSsBkgTAI=
X-Google-Smtp-Source: AGHT+IEHo7OdGarfLEwekWxaYF2ishd6FOKyy49yW13Z7mG39PW+pj+r85eQdVoqpD1A/2/FJx3VwA==
X-Received: by 2002:a05:6402:430a:b0:58d:318a:50a4 with SMTP id 4fb4d7f45d1cf-58e5965e833mr829893a12.14.1720090356042;
        Thu, 04 Jul 2024 03:52:36 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:5f4b:4104:ca7b:6efb? ([2a02:810b:f40:4600:5f4b:4104:ca7b:6efb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861381604asm8309040a12.45.2024.07.04.03.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 03:52:35 -0700 (PDT)
Message-ID: <faeb87de-b97e-4f95-bbb0-edd03a411f4c@gmail.com>
Date: Thu, 4 Jul 2024 12:52:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: add rock5 itx board
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240703210524.776455-1-heiko@sntech.de>
 <20240703210524.776455-3-heiko@sntech.de>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20240703210524.776455-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 03.07.24 um 23:05 schrieb Heiko Stuebner:
> The Rock 5 ITX as the name suggests is made in the ITX form factor and
> actually build in a form to be used in a regular case even providing
> connectors for regular front-panel io.
> 
> It can be powered either bei 12V, ATX power-supply or PoE.
> 
> Notable peripherals are the 4 SATA ports, M.2 M-Key slot, M.2 E-key slot,
> 2*2.5Gb pcie-connected ethernet nics.
> 
> As of yet unsupported display options consist of 2*hdmi, DP via type-c,
> eDP + 2*DSI via pcb connectors.
> 
> USB ports are 4*USB3 + 2*USB2 on the back panel and 2-port front-panel
> connector.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   arch/arm64/boot/dts/rockchip/Makefile         |    1 +
>   .../boot/dts/rockchip/rk3588-rock-5itx.dts    | 1188 +++++++++++++++++
>   2 files changed, 1189 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5itx.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index e8eba631da23e..0380768586436 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -132,6 +132,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-quartzpro64.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-ep.dtbo
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtbo
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5itx.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-toybrick-x0.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5itx.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5itx.dts
> new file mode 100644
> index 0000000000000..41d92ceeeb09c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5itx.dts
> @@ -0,0 +1,1188 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
> + * Copyright (c) 2022 Radxa Limited
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include "dt-bindings/usb/pd.h"
> +#include "rk3588.dtsi"
> +
> +/ {
> +	model = "Radxa ROCK 5 ITX";
> +	compatible = "radxa,rock-5itx", "rockchip,rk3588";
> +
> +	aliases {
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc;
> +		mmc2 = &sdio;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	adc_keys: adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 0>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1800000>;
> +		poll-interval = <100>;
> +		status = "okay";
> +
> +		button-maskrom {
> +			label = "Mask Rom";
> +			linux,code = <KEY_SETUP>;
> +			press-threshold-microvolt = <1750>;
> +		};
> +	};
> +
> +	analog-sound {
> +		compatible = "audio-graph-card";
> +		label = "rk3588-es8316";
> +
> +		widgets = "Microphone", "Mic Jack",
> +			  "Headphone", "Headphones";
> +
> +		routing = "MIC2", "Mic Jack",
> +			  "Headphones", "HPOL",
> +			  "Headphones", "HPOR";
> +
> +		dais = <&i2s0_8ch_p0>;
> +		hp-det-gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hp_detect>;
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins>;
> +
> +		power-led1 {
> +			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "default-on";
> +		};
> +
> +		hdd-led2 {
> +			gpios = <&gpio0 RK_PC0 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "disk-activity";
> +		};
> +	};
> +
> +	fan0: pwm-fan {
> +		compatible = "pwm-fan";
> +		#cooling-cells = <2>;
> +		cooling-levels = <0 64 128 192 255>;
> +		fan-supply = <&vcc12v_dcin>;
> +		pwms = <&pwm14 0 10000 0>;
> +	};
> +
> +	/* M.2 E-KEY */
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		clocks = <&hym8563>;
> +		clock-names = "ext_clock";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_enable_h>;
> +		reset-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	typec_vin: regulator-typec-vin {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio1 RK_PB6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vbus5v0_typec_en>;
> +		regulator-name = "typec_vin";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc12v_dcin: regulator-vcc12v-dcin {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc12v_dcin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	vcc33_io64: regulator-vcc33-io64 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc33_io64";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
> +	vcc3v3_ekey: regulator-vcc3v3-ekey {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ekey_en>;
> +		regulator-name = "vcc3v3_ekey";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		startup-delay-us = <50000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc3v3_lan: vcc3v3_lan_phy2: regulator-vcc3v3-lan {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_lan";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_3v3_s3>;
> +	};
> +
> +	vcc3v3_mkey: regulator-vcc3v3-mkey {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie30x4_pwren_h>;
> +		regulator-name = "vcc3v3_mkey";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		startup-delay-us = <5000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc3v3_sys: regulator-vcc3v3-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
> +	vcc5v0_sys: regulator-vcc5v0-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
> +	vcc5v0_usb20: vcc5v0_usb12: vcc5v0_usb34: regulator-vcc5v0-usb {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_host_pwren_h>;
> +		regulator-name = "vcc5v0_usb";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_1v1_nldo_s3";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1100000>;
> +		regulator-max-microvolt = <1100000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +};
> +
> +&combphy0_ps {
> +	status = "okay";
> +};
> +
> +&combphy1_ps {
> +	status = "okay";
> +};
> +
> +&combphy2_psu {
> +	status = "okay";
> +};
> +
> +&cpu_b0 {
> +	cpu-supply = <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b1 {
> +	cpu-supply = <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b2 {
> +	cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_b3 {
> +	cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_l0 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l1 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l2 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l3 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_gpu_s0>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0m2_xfer>;
> +	status = "okay";
> +
> +	vdd_cpu_big0_s0: regulator@42 {
> +		compatible = "rockchip,rk8602";
> +		reg = <0x42>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu_big0_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <1050000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	vdd_cpu_big1_s0: regulator@43 {
> +		compatible = "rockchip,rk8603", "rockchip,rk8602";
> +		reg = <0x43>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu_big1_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <1050000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1m2_xfer>;
> +	status = "okay";
> +
> +	vdd_npu_s0: regulator@42 {
> +		compatible = "rockchip,rk8602";
> +		reg = <0x42>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_npu_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <950000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +/* CAM0 connector */
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c3m0_xfer>;
> +};
> +
> +/* M.2 E-key */
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4m1_xfer>;
> +};
> +
> +/* RTC and LCD0 connector */
> +&i2c6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c6m0_xfer>;
> +	status = "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		clock-output-names = "wifi_32kout";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&rtc_int>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +/* Audio codec and CAM1 connector */
> +&i2c7 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c7m0_xfer>;
> +	status = "okay";
> +
> +	es8316: audio-codec@11 {
> +		compatible = "everest,es8316";
> +		reg = <0x11>;
> +		clocks = <&cru I2S0_8CH_MCLKOUT>;
> +		clock-names = "mclk";
> +		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
> +		assigned-clock-rates = <12288000>;
> +		#sound-dai-cells = <0>;
> +
> +		port {
> +			es8316_p0_0: endpoint {
> +				remote-endpoint = <&i2s0_8ch_p0_0>;
> +			};
> +		};
> +	};
> +};
> +
> +/* FUSB302 and LCD1 connector */
> +&i2c8 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c8m4_xfer>;
> +	status = "okay";
> +
> +	usbc0: usb-typec@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbc0_int>;
> +		vbus-supply = <&typec_vin>;
> +
> +		usb_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			data-role = "dual";
> +			power-role = "dual";
> +			try-power-role = "sink";
> +			op-sink-microwatt = <1000000>;
> +			sink-pdos =
> +				<PDO_FIXED(5000, 1000, PDO_FIXED_USB_COMM)>;
> +			source-pdos =
> +				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					usbc0_orien_sw: endpoint {
> +						remote-endpoint = <&usbdp_phy0_orientation_switch>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					usbc0_role_sw: endpoint {
> +						remote-endpoint = <&dwc3_0_role_switch>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					dp_altmode_mux: endpoint {
> +						remote-endpoint = <&usbdp_phy0_dp_altmode_mux>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c8m4_xfer {
> +	rockchip,pins =
> +		/* i2c8_scl_m4 */
> +		<3 RK_PC2 9 &pcfg_pull_up_drv_level_6>,
> +		/* i2c8_sda_m4 */
> +		<3 RK_PC3 9 &pcfg_pull_up_drv_level_6>;
> +};
> +
> +&i2s0_8ch {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2s0_lrck
> +		     &i2s0_mclk
> +		     &i2s0_sclk
> +		     &i2s0_sdi0
> +		     &i2s0_sdo0>;
> +	status = "okay";
> +
> +	i2s0_8ch_p0: port {
> +		i2s0_8ch_p0_0: endpoint {
> +			dai-format = "i2s";
> +			mclk-fs = <256>;
> +			remote-endpoint = <&es8316_p0_0>;
> +		};
> +	};
> +};
> +
> +&package_thermal {
> +	polling-delay = <1000>;
> +
> +	trips {
> +		package_fan0: package-fan0 {
> +			hysteresis = <2000>;
> +			temperature = <50000>;
> +			type = "active";
> +		};
> +
> +		package_fan1: package-fan1 {
> +			hysteresis = <2000>;
> +			temperature = <65000>;
> +			type = "active";
> +		};
> +	};
> +
> +	cooling-maps {
> +		map0 {
> +			cooling-device = <&fan0 THERMAL_NO_LIMIT 1>;
> +			trip = <&package_fan0>;
> +		};
> +		map1 {
> +			cooling-device = <&fan0 2 THERMAL_NO_LIMIT>;
> +			trip = <&package_fan1>;
> +		};
> +	};
> +};
> +
> +/* M.2 E-key */
> +&pcie2x1l0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie30x1_0_perstn_m1_l>;
> +	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_ekey>;
> +	status = "okay";
> +};
> +
> +/* RTL8125B_1 */
> +&pcie2x1l1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie30x1_1_perstn>;
> +	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_lan>;
> +	status = "okay";
> +};
> +
> +/* RTL8125B_2 */
> +&pcie2x1l2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie20x1_2_perstn>;
> +	reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_lan_phy2>;
> +	status = "okay";
> +};
> +
> +&pcie30phy {
> +	data-lanes = <1 1 2 2>;
> +	/* separate clock lines from the clock generator to phy and devices */
> +	rockchip,rx-common-refclk-mode = <0 0 0 0>;
> +	status = "okay";
> +};
> +
> +/* ASMedia ASM1164 Sata controller */
> +&pcie3x2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie30x2_perstn_m1_l>;
> +	reset-gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc33_io64>;
> +	status = "okay";
> +};
> +
> +/* M.2 M.key */
> +&pcie3x4 {
> +	num-lanes = <2>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie30x4_perstn_m1_l>;
> +	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_mkey>;
> +	status = "okay";
> +};
> +
> +&pwm14 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm14m1_pins>;
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&avcc_1v8_s0>;
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	max-frequency = <200000000>;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
> +	mmc-hs200-1_8v;
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	max-frequency = <200000000>;
> +	no-sdio;
> +	no-mmc;
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc_3v3_s3>;
> +	vqmmc-supply = <&vccio_sd_s0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc_det>;
> +	status = "okay";
> +};
> +
> +/* M.2 E-KEY */
> +&sdio {
> +	broken-cd;
> +	bus-width = <4>;
> +	cap-sdio-irq;
> +	disable-wp;
> +	keep-power-in-suspend;
> +	max-frequency = <150000000>;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	no-sd;
> +	no-mmc;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdiom0_pins>;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc3v3_ekey>;
> +	status = "okay";
> +};
> +
> +&sfc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&fspim2_pins>;
> +	status = "okay";
> +
> +	spi_flash: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-max-frequency = <50000000>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <1>;
> +	};
> +};
> +
> +&spi2 {
> +	status = "okay";
> +	assigned-clocks = <&cru CLK_SPI2>;
> +	assigned-clock-rates = <200000000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> +	num-cs = <1>;
> +
> +	pmic@0 {
> +		compatible = "rockchip,rk806";
> +		spi-max-frequency = <1000000>;
> +		reg = <0x0>;
> +
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> +			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> +
> +		system-power-controller;
> +
> +		vcc1-supply = <&vcc5v0_sys>;
> +		vcc2-supply = <&vcc5v0_sys>;
> +		vcc3-supply = <&vcc5v0_sys>;
> +		vcc4-supply = <&vcc5v0_sys>;
> +		vcc5-supply = <&vcc5v0_sys>;
> +		vcc6-supply = <&vcc5v0_sys>;
> +		vcc7-supply = <&vcc5v0_sys>;
> +		vcc8-supply = <&vcc5v0_sys>;
> +		vcc9-supply = <&vcc5v0_sys>;
> +		vcc10-supply = <&vcc5v0_sys>;
> +		vcc11-supply = <&vcc_2v0_pldo_s3>;
> +		vcc12-supply = <&vcc5v0_sys>;
> +		vcc13-supply = <&vcc_1v1_nldo_s3>;
> +		vcc14-supply = <&vcc_1v1_nldo_s3>;
> +		vcca-supply = <&vcc5v0_sys>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		rk806_dvs1_null: dvs1-null-pins {
> +			pins = "gpio_pwrctrl1";
> +			function = "pin_fun0";
> +		};
> +
> +		rk806_dvs2_null: dvs2-null-pins {
> +			pins = "gpio_pwrctrl2";
> +			function = "pin_fun0";
> +		};
> +
> +		rk806_dvs3_null: dvs3-null-pins {
> +			pins = "gpio_pwrctrl3";
> +			function = "pin_fun0";
> +		};
> +
> +		regulators {
> +			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_gpu_s0";
> +				regulator-enable-ramp-delay = <400>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_cpu_lit_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_log_s0: dcdc-reg3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <675000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_log_s0";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <750000>;
> +				};
> +			};
> +
> +			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_vdenc_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_ddr_s0: dcdc-reg5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <675000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_ddr_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <850000>;
> +				};
> +			};
> +
> +			vdd2_ddr_s3: dcdc-reg6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vdd2_ddr_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_2v0_pldo_s3: dcdc-reg7 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <2000000>;
> +				regulator-max-microvolt = <2000000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vdd_2v0_pldo_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <2000000>;
> +				};
> +			};
> +
> +			vcc_3v3_s3: dcdc-reg8 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc_3v3_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vddq_ddr_s0: dcdc-reg9 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vddq_ddr_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8_s3: dcdc-reg10 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc_1v8_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			avcc_1v8_s0: pldo-reg1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "avcc_1v8_s0";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vcc_1v8_s0: pldo-reg2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc_1v8_s0";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			avdd_1v2_s0: pldo-reg3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-name = "avdd_1v2_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3_s0: pldo-reg4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vcc_3v3_s0";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vccio_sd_s0: pldo-reg5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-name = "vccio_sd_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			pldo6_s3: pldo-reg6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "pldo6_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vdd_0v75_s3: nldo-reg1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-name = "vdd_0v75_s3";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <750000>;
> +				};
> +			};
> +
> +			vdd_ddr_pll_s0: nldo-reg2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-name = "vdd_ddr_pll_s0";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <850000>;
> +				};
> +			};
> +
> +			avdd_0v75_s0: nldo-reg3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-name = "avdd_0v75_s0";
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_0v85_s0: nldo-reg4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-name = "vdd_0v85_s0";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <837500>;
> +				};
> +			};
> +
> +			vdd_0v75_s0: nldo-reg5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-name = "vdd_0v75_s0";
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <750000>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&tsadc {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-0 = <&uart2m0_xfer>;
> +	status = "okay";
> +};
> +
> +/* Connected to M.2 E-key */
> +&uart6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart6m1_xfer &uart6m1_ctsn &uart6m1_rtsn>;
> +	status = "okay";
> +};
> +
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	status = "okay";
> +};
> +
> +&u2phy1 {
> +	status = "okay";
> +};
> +
> +&u2phy1_otg {
> +	/* connected to USB3 hub, which is powered by vcc5v0_usb12 */
> +	phy-supply = <&vcc5v0_usb12>;
> +	status = "okay";
> +};
> +
> +&u2phy2 {
> +	status = "okay";
> +};
> +
> +&u2phy2_host {
> +	/* connected to USB2 hub, which is powered by vcc5v0_usb20 */
> +	phy-supply = <&vcc5v0_usb20>;
> +	status = "okay";
> +};
> +
> +&u2phy3 {
> +	status = "okay";
> +};
> +
> +&u2phy3_host {
> +	phy-supply = <&vcc5v0_usb20>;
> +	status = "okay";
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ohci {
> +	status = "okay";
> +};
> +
> +&usb_host0_xhci {
> +	usb-role-switch;
> +	status = "okay";
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		dwc3_0_role_switch: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&usbc0_role_sw>;
> +		};
> +	};
> +};
> +
> +&usb_host1_xhci {
> +	dr_mode = "host";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	/* 2.0 hub on port 1 */
> +	hub_2_0: hub@1 {
> +		compatible = "usb5e3,610";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		vdd-supply = <&vcc5v0_usb12>;
Are you sure about this one? I couldn't find any schematics for this board,
but both the bindings for usb5e3,610 and the datasheet[0] are saying this
is the supply for the hub's internal logic which is typically ~3.3V. It's
definitely not a supply for the vbus.

[0] http://www.sunnyqi.com/upLoad/product/month_1308/GL852G.pdf

> +	};
> +
> +	/* 3.0 hub on port 4 */
> +	hub_3_0: hub@2 {
> +		compatible = "usb5e3,620";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gl3523_reset>;
> +		reset-gpios = <&gpio3 RK_PB1 GPIO_ACTIVE_LOW>;
> +		vdd-supply = <&vcc5v0_usb12>;
> +	};
> +};
> +
> +&usbdp_phy0 {
> +	mode-switch;
> +	orientation-switch;
> +	sbu1-dc-gpios = <&gpio4 RK_PB7 GPIO_ACTIVE_HIGH>;
> +	sbu2-dc-gpios = <&gpio4 RK_PC0 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		usbdp_phy0_orientation_switch: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&usbc0_orien_sw>;
> +		};
> +
> +		usbdp_phy0_dp_altmode_mux: endpoint@1 {
> +			reg = <1>;
> +			remote-endpoint = <&dp_altmode_mux>;
> +		};
> +	};
> +};
> +
> +&usbdp_phy1 {
> +	rockchip,dp-lane-mux = <2 3>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	hym8563 {
> +		rtc_int: rtc-int {
> +			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	leds {
> +		led_pins: led-pins {
> +			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>,
> +					<0 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pcie {
> +		pcie20x1_2_perstn: pcie20x1-2-perstn {
> +			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie30x1_0_perstn_m1_l: pcie30x1-0-perstn-m1-l {
> +			rockchip,pins = <4 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie30x1_1_perstn: pcie30x1-1-perstn {
> +			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie30x2_perstn_m1_l: pcie30x2-perstn-m1-l {
> +			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pcie30x4_perstn_m1_l: pcie30x4-perstn-m1-l {
> +			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		ekey_en: ekey-en {
> +			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
> +		pcie30x4_pwren_h: pcie30x4-pwren-h {
> +			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +
> +	sound {
> +		hp_detect: hp-detect {
> +			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +
> +	usb {
> +		usb_host_pwren_h: usb-host-pwren-h {
> +			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		vcc5v0_otg_en: vcc5v0-otg-en {
> +			rockchip,pins = <2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		gl3523_reset: rl3523-reset {
> +			rockchip,pins = <3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb-typec {
> +		usbc0_int: usbc0-int {
> +			rockchip,pins = <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		vbus5v0_typec_en: vbus5v0-typec-en {
> +			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	hdmirx {
> +		hdmirx_det: hdmirx-det {
> +			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	sdio-pwrseq {
> +		wifi_enable_h: wifi-enable-h {
> +			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	wireless-wlan {
> +		wifi_host_wake_irq: wifi-host-wake-irq {
> +			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +
> +	bt {
> +		bt_enable_h: bt-enable-h {
> +			rockchip,pins = <2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		bt_host_wake_l: bt-host-wake-l {
> +			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		bt_wake_l: bt-wake-l {
> +			rockchip,pins = <4 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	dp {
> +		dp1_hpd: dp1-hpd {
> +			rockchip,pins = <3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};


