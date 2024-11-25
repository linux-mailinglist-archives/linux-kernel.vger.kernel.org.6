Return-Path: <linux-kernel+bounces-421388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5DE9D8AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E07B284BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7311B6CE6;
	Mon, 25 Nov 2024 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0NvgdJfe"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91171B0F15
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732553630; cv=none; b=ENcnhejJ8HVM/y3OXuVCmw0hF+gqMW8Y/G5CrG0CMQ42FrgJyF2+qe1qetu19d+iYaYvOpLC6fc5w6oVxaSTxxp+uKwJ3yKeddPcVctY+TTImENrVGkziRmUM55mH+89OWMdMwDW3/8Uonk8ggn9Wx7Nlr91pn1bAsO7/Mogq4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732553630; c=relaxed/simple;
	bh=Az0UVFgnANX6qnmfK1Modq86ztAp992GKPHQ6g7IPFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U+Jvg0GmS8MgnHsVV5o9dRyW/gMn35S50n4zPHGjoAEFpbayYm2S8xg50ugGrKNIkKu0qpF6kvU+KriGNE6EU4BD1H98cSBMbL9W7FDLb/cCcj5CubRJk2kUyGE3+fWN8phz+ApsNrJS2rEQ+10+yZqzDl44G7gCqd8fd7/xFvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0NvgdJfe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so43207655e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732553626; x=1733158426; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/SMneUlG+U+/tNBslNiwEKbHU6PijesxwJIBcLZUUM=;
        b=0NvgdJfeoIZbmamTQ8mv5oAv39j8dxTh/0/ioqFi/YB7ApV5UEQqkxtoZEEQdjwkYg
         Pc1OLyy1fIr10zbz5M+q14Xk8W+ukj+Vxd23sEYxSXgKjCQMQIdyrpqjv5ztGgGxpGea
         PvtNgdHf+iGLNyvIQFJSsaRrUMa3Cb0yK8m3LtLuziGbzVdOHfqJq1eWyIgm/P7IyLY6
         H1LEv0bllQkmFSaTLUbW1AlfTqHhU2eXgL1HyF033P5nPdDFwxj74aK+B+8V1mXcdy8d
         UvfrGY225YK4u8yMoOZ8Yah1mdk9AsNbQIcnXyQ0MbivTljxDscLG8YsUGkFzfi0DU0i
         1znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732553626; x=1733158426;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/SMneUlG+U+/tNBslNiwEKbHU6PijesxwJIBcLZUUM=;
        b=WC+11JNgeBaF52izlZcWMWcTKh1rreh2jb5OA8yvMohVWjDuX7FZGfxjY3MhQwG2k5
         DTxgJmbKnIuR3PUZzke75C6J5XbYQ7v+RgI9a4l5Z7f1bJiuFKHeVShRA0F+v3jRucmZ
         dntv4LgGIzKX6401ft0XaxLdTr1TTL8y875mK6Bdydp3vGhmYesIfFXDcgl5GwRIWA1u
         KwHrI//x5XX4azORjbV4sXqWu60iNUcUGvWN2jKvYOMSK9jPDbzZskMz2vx1JltS0/gX
         pdJm+gHVnpV/VpgkRAAsgwMhOH9T61fDPIes4NPG3McRBoW5kWfunpGp0k4jk3zeDVgF
         bxFA==
X-Forwarded-Encrypted: i=1; AJvYcCUQgISCGG6Gnhf7bhPdrPvZcfDXBBvM+EX7klMlrRKgyIBURiNG49MC17OQ+dcpZ5JgTMDEdOVJIMdCcNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztfVRA4YK9fju4p0vcLSg7/zCEwWO2JdjgypFOEhgU9utmVCYd
	uSYsANyg7bTdXCGp3aoCt8ec4+I88x7xsmgew4HeRKlCn2Oi5q7LMu2yOvZ5XFk=
X-Gm-Gg: ASbGncsGONVoyWL6Q+HR6zr+M39mDMVmOqM7jN+LJ9Ud8q+OjvNpqHdipxCapOohp/+
	3fZ/vh2l8F4jFfZD2InLhQ04cv6jAOA2Rxve+FsMXN/yv5O4+7Cuejrnfl3V+E/lW52r/URBj87
	618rtWozWV7BHt7o29DvY0NABlNJv6wHV8bE6Z4rOfa+rPbSLQmwDLQTeCdBGzEsn+hq11kZmlW
	f2cUyYFuhbPWNrrRwxh4SSLl+aF1uxmoe0RJ2Z/DkfDy3tS
X-Google-Smtp-Source: AGHT+IFplvSQW/AK3neE/bqS0bgzqZVofphwlQzp3Xvyc4WU40Cdle5aRvyQbnke4EIH2nhLl5gphA==
X-Received: by 2002:a05:600c:4e91:b0:431:6083:cd38 with SMTP id 5b1f17b1804b1-433ce417b2amr111604955e9.6.1732553626360;
        Mon, 25 Nov 2024 08:53:46 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:97f5:4cdc:1888:403])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b463ab5fsm202102845e9.27.2024.11.25.08.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 08:53:45 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Chuan Liu <chuan.liu@amlogic.com>,  Kevin
 Hilman <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  xianwei.zhao@amlogic.com,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/5] dt-bindings: clock: add Amlogic A5 peripherals
 clock controller
In-Reply-To: <20241120-a5-clk-v2-3-1208621e961d@amlogic.com> (Xianwei Zhao
	via's message of "Wed, 20 Nov 2024 15:01:15 +0800")
References: <20241120-a5-clk-v2-0-1208621e961d@amlogic.com>
	<20241120-a5-clk-v2-3-1208621e961d@amlogic.com>
Date: Mon, 25 Nov 2024 17:53:45 +0100
Message-ID: <1jmshntfty.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 20 Nov 2024 at 15:01, Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:

> From: Chuan Liu <chuan.liu@amlogic.com>
>
> Add the peripherals clock controller dt-bindings for Amlogic A5 SoC family.
>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../clock/amlogic,a5-peripherals-clkc.yaml         | 130 ++++++++++++++++++++
>  .../clock/amlogic,a5-peripherals-clkc.h            | 132 +++++++++++++++++++++
>  2 files changed, 262 insertions(+)
>
> diff --git
> a/Documentation/devicetree/bindings/clock/amlogic,a5-peripherals-clkc.yaml
> b/Documentation/devicetree/bindings/clock/amlogic,a5-peripherals-clkc.yaml
> new file mode 100644
> index 000000000000..0f15e104fd12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a5-peripherals-clkc.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2024 Amlogic, Inc. All rights reserved
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/amlogic,a5-peripherals-clkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic A5 series Peripheral Clock Controller
> +
> +maintainers:
> +  - Xianwei Zhao <xianwei.zhao@amlogic.com>
> +  - Chuan Liu <chuan.liu@amlogic.com>
> +
> +properties:
> +  compatible:
> +    const: amlogic,a5-peripherals-clkc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 18
> +    items:
> +      - description: input oscillator (usually at 24MHz)
> +      - description: input oscillators multiplexer
> +      - description: input fix pll
> +      - description: input fclk div 2
> +      - description: input fclk div 2p5
> +      - description: input fclk div 3
> +      - description: input fclk div 4
> +      - description: input fclk div 5
> +      - description: input fclk div 7
> +      - description: input mpll2
> +      - description: input mpll3
> +      - description: input gp0 pll
> +      - description: input gp1 pll
> +      - description: input hifi pll
> +      - description: input sys clk
> +      - description: input axi clk
> +      - description: input sys pll div 16
> +      - description: input cpu clk div 16
> +      - description: input pad clock for rtc clk (optional)
> +      - description: input ddr pll (optional)
> +      - description: input source from clk-measure (optional)
> +
> +  clock-names:
> +    minItems: 18
> +    items:
> +      - const: xtal_24m

You should not mention the rate here. xtal is fine.

> +      - const: oscin
> +      - const: fix
> +      - const: fdiv2
> +      - const: fdiv2p5
> +      - const: fdiv3
> +      - const: fdiv4
> +      - const: fdiv5
> +      - const: fdiv7
> +      - const: mpll2
> +      - const: mpll3
> +      - const: gp0
> +      - const: gp1
> +      - const: hifi
> +      - const: sysclk
> +      - const: axiclk
> +      - const: sysplldiv16
> +      - const: cpudiv16
> +      - const: pad_osc
> +      - const: ddr
> +      - const: clkmsr
> +
> +  "#clock-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    apb {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clock-controller@0 {
> +            compatible = "amlogic,a5-peripherals-clkc";
> +            reg = <0x0 0x0 0x0 0x224>;
> +            #clock-cells = <1>;
> +            clocks = <&xtal_24m>,
> +                     <&scmi_clk 0>,
> +                     <&scmi_clk 7>,
> +                     <&scmi_clk 15>,
> +                     <&scmi_clk 17>,
> +                     <&scmi_clk 19>,
> +                     <&scmi_clk 21>,
> +                     <&scmi_clk 23>,
> +                     <&scmi_clk 25>,
> +                     <&clkc_pll 6>,
> +                     <&clkc_pll 8>,
> +                     <&clkc_pll 10>,
> +                     <&scmi_clk 5>,
> +                     <&clkc_pll 12>,
> +                     <&scmi_clk 1>,
> +                     <&scmi_clk 2>,
> +                     <&scmi_clk 9>,
> +                     <&scmi_clk 10>;
> +            clock-names = "xtal_24m",
> +                          "oscin",
> +                          "fix",
> +                          "fdiv2",
> +                          "fdiv2p5",
> +                          "fdiv3",
> +                          "fdiv4",
> +                          "fdiv5",
> +                          "fdiv7",
> +                          "mpll2",
> +                          "mpll3",
> +                          "gp0",
> +                          "gp1",
> +                          "hifi",
> +                          "sysclk",
> +                          "axiclk",
> +                          "sysplldiv16",
> +                          "cpudiv16";
> +        };
> +    };
> diff --git a/include/dt-bindings/clock/amlogic,a5-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,a5-peripherals-clkc.h
> new file mode 100644
> index 000000000000..74e740ebe6bd
> --- /dev/null
> +++ b/include/dt-bindings/clock/amlogic,a5-peripherals-clkc.h
> @@ -0,0 +1,132 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
> + * Author: Chuan Liu <chuan.liu@amlogic.com>
> + */
> +
> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_A5_PERIPHERALS_CLKC_H
> +#define _DT_BINDINGS_CLOCK_AMLOGIC_A5_PERIPHERALS_CLKC_H
> +
> +#define CLKID_RTC_XTAL_CLKIN			0
> +#define CLKID_RTC_32K_DIV			1
> +#define CLKID_RTC_32K_MUX			2
> +#define CLKID_RTC_32K				3
> +#define CLKID_RTC_CLK				4
> +#define CLKID_SYS_RESET_CTRL			5
> +#define CLKID_SYS_PWR_CTRL			6
> +#define CLKID_SYS_PAD_CTRL			7
> +#define CLKID_SYS_CTRL				8
> +#define CLKID_SYS_TS_PLL			9
> +#define CLKID_SYS_DEV_ARB			10
> +#define CLKID_SYS_MAILBOX			11
> +#define CLKID_SYS_JTAG_CTRL			12
> +#define CLKID_SYS_IR_CTRL			13
> +#define CLKID_SYS_MSR_CLK			14
> +#define CLKID_SYS_ROM				15
> +#define CLKID_SYS_CPU_ARB			16
> +#define CLKID_SYS_RSA				17
> +#define CLKID_SYS_SAR_ADC			18
> +#define CLKID_SYS_STARTUP			19
> +#define CLKID_SYS_SECURE			20
> +#define CLKID_SYS_SPIFC				21
> +#define CLKID_SYS_DSPA				22
> +#define CLKID_SYS_NNA				23
> +#define CLKID_SYS_ETH_MAC			24
> +#define CLKID_SYS_RAMA				25
> +#define CLKID_SYS_RAMB				26
> +#define CLKID_SYS_AUDIO_TOP			27
> +#define CLKID_SYS_AUDIO_VAD			28
> +#define CLKID_SYS_USB				29
> +#define CLKID_SYS_SD_EMMC_A			30
> +#define CLKID_SYS_SD_EMMC_C			31
> +#define CLKID_SYS_PWM_AB			32
> +#define CLKID_SYS_PWM_CD			33
> +#define CLKID_SYS_PWM_EF			34
> +#define CLKID_SYS_PWM_GH			35
> +#define CLKID_SYS_SPICC_1			36
> +#define CLKID_SYS_SPICC_0			37
> +#define CLKID_SYS_UART_A			38
> +#define CLKID_SYS_UART_B			39
> +#define CLKID_SYS_UART_C			40
> +#define CLKID_SYS_UART_D			41
> +#define CLKID_SYS_UART_E			42
> +#define CLKID_SYS_I2C_M_A			43
> +#define CLKID_SYS_I2C_M_B			44
> +#define CLKID_SYS_I2C_M_C			45
> +#define CLKID_SYS_I2C_M_D			46
> +#define CLKID_SYS_RTC				47
> +#define CLKID_AXI_AUDIO_VAD			48
> +#define CLKID_AXI_AUDIO_TOP			49
> +#define CLKID_AXI_RAMB				50
> +#define CLKID_AXI_RAMA				51
> +#define CLKID_AXI_NNA				52
> +#define CLKID_AXI_DEV1_DMC			53
> +#define CLKID_AXI_DEV0_DMC			54
> +#define CLKID_AXI_DSP_DMC			55
> +#define CLKID_12_24M_IN				56
> +#define CLKID_12M_24M				57
> +#define CLKID_FCLK_25M_DIV			58
> +#define CLKID_FCLK_25M				59
> +#define CLKID_GEN_SEL				60
> +#define CLKID_GEN_DIV				61
> +#define CLKID_GEN				62
> +#define CLKID_SARADC_SEL			63
> +#define CLKID_SARADC_DIV			64
> +#define CLKID_SARADC				65
> +#define CLKID_PWM_A_SEL				66
> +#define CLKID_PWM_A_DIV				67
> +#define CLKID_PWM_A				68
> +#define CLKID_PWM_B_SEL				69
> +#define CLKID_PWM_B_DIV				70
> +#define CLKID_PWM_B				71
> +#define CLKID_PWM_C_SEL				72
> +#define CLKID_PWM_C_DIV				73
> +#define CLKID_PWM_C				74
> +#define CLKID_PWM_D_SEL				75
> +#define CLKID_PWM_D_DIV				76
> +#define CLKID_PWM_D				77
> +#define CLKID_PWM_E_SEL				78
> +#define CLKID_PWM_E_DIV				79
> +#define CLKID_PWM_E				80
> +#define CLKID_PWM_F_SEL				81
> +#define CLKID_PWM_F_DIV				82
> +#define CLKID_PWM_F				83
> +#define CLKID_PWM_G_SEL				84
> +#define CLKID_PWM_G_DIV				85
> +#define CLKID_PWM_G				86
> +#define CLKID_PWM_H_SEL				87
> +#define CLKID_PWM_H_DIV				88
> +#define CLKID_PWM_H				89
> +#define CLKID_SPICC_0_SEL			90
> +#define CLKID_SPICC_0_DIV			91
> +#define CLKID_SPICC_0				92
> +#define CLKID_SPICC_1_SEL			93
> +#define CLKID_SPICC_1_DIV			94
> +#define CLKID_SPICC_1				95
> +#define CLKID_SD_EMMC_A_SEL			96
> +#define CLKID_SD_EMMC_A_DIV			97
> +#define CLKID_SD_EMMC_A				98
> +#define CLKID_SD_EMMC_C_SEL			99
> +#define CLKID_SD_EMMC_C_DIV			100
> +#define CLKID_SD_EMMC_C				101
> +#define CLKID_TS_DIV				102
> +#define CLKID_TS				103
> +#define CLKID_ETH_125M_DIV			104
> +#define CLKID_ETH_125M				105
> +#define CLKID_ETH_RMII_DIV			106
> +#define CLKID_ETH_RMII				107
> +#define CLKID_DSPA_0_SEL			108
> +#define CLKID_DSPA_0_DIV			109
> +#define CLKID_DSPA_0				110
> +#define CLKID_DSPA_1_SEL			111
> +#define CLKID_DSPA_1_DIV			112
> +#define CLKID_DSPA_1				113
> +#define CLKID_DSPA				114
> +#define CLKID_NNA_CORE_SEL			115
> +#define CLKID_NNA_CORE_DIV			116
> +#define CLKID_NNA_CORE				117
> +#define CLKID_NNA_AXI_SEL			118
> +#define CLKID_NNA_AXI_DIV			119
> +#define CLKID_NNA_AXI				120
> +
> +#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_A5_PERIPHERALS_CLKC_H */

-- 
Jerome

