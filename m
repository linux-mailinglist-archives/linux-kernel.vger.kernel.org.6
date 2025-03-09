Return-Path: <linux-kernel+bounces-552969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19967A581A4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524E71888D9B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 08:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005D8192B71;
	Sun,  9 Mar 2025 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQM7SNW3"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A918FC7B
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741509231; cv=none; b=ZnoXjy62Q2B/U1V5erhkx07tvFOnurKW9+MeyT+neExtabTkkz/M6lS8vdRdOffw+/1jLYBgFQxCLqmmgqQ7MJv8LSI1B4y5HczdZlaxX2qsxcfbR4nTz3LOw7U7jYUCtcirkd9fpt6x8YLNJAfJVBO/5Jhc86yGgdj/34dWiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741509231; c=relaxed/simple;
	bh=DA4Kxjtg2wyfiGDjO0XkWZ8J8EZ7dUH8HeuhUhvDAGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWiID68GdtghcXglmsHbwW/Bj0uvLKN0wZxpWV7Cq4NIRuaugv5PgwIC0aurtKXsifxw1+ytLF/O1P8yxBMEhU65NKxZPFV6R7yWWL83FPrq/GRx2QzQfD6wRPahHQxa7nZYmJOP5wlPn5AWp8QpAbRQYB/zz1RDxSfPmekGrIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eQM7SNW3; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30c0517142bso7439991fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 00:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741509227; x=1742114027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rKR4H/QECSO/fobjTrFesS+ZjcSBWrrROqlfipaQXZQ=;
        b=eQM7SNW35/m/HoGbWCq4xC8drIOSJM8BTkpYqE1Px1/RCBavPlyaNNLx6MNcvXApSQ
         rZHPXzqHSwFoVpnic/1y9ikE23mVSVBf+S2+0ypCnSPngKy24ladqwAmb+iEIrgTRFJD
         nw74SoLZ+tc74qoFgncqpLXeAY+XZLalzpwd+YXq4Kmi8Svaid0bG5TC7con8MAUMnbK
         QwbZck+ZpCk1Ly+ugJ5KXkuxxkof+mWmEUOj+wpZwX+knlLKB/AxWcXh39DIp01HBL+e
         8LKTnTppqbjYR1p2PhaufZnEjzZ4BmL8rvCBMsrV1t5aSyW3e2VKiDOm+SFpsqbdFF0L
         69bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741509227; x=1742114027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKR4H/QECSO/fobjTrFesS+ZjcSBWrrROqlfipaQXZQ=;
        b=dy89Mpjk8fzxpM8Un6Lq4K+iH5XRUBAq9lNEllF+itnxUkXD9d9bMiYJQu+cyfyQi/
         1eTlxvcRbI/rAXD2BU1JsKkbobFWns4Y6GYdqT2LVbh/XO4F4SI7mVNN6X/BjlOzn0vz
         dwKlcYad11r61tfSaQbaZxFN1NmH+8S6HpO658x3558TB0ivaFe7byyI+vxkoqtw3gS1
         4v+PLsoaHMN9sG1R0/OwoH/cs2na7aPwZVgcYKaKThMjI/eIa5S2jE7MVMnUbAysD3ea
         JvDfwTAWtBE9MQCk0OYvlmWSWRGP595ozJyQ0A4bwGEV5hVIDgtwp38upEPrNFUlmBu/
         WfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2LpN71TKtuRHCXuGiJkczkUbed58kTsCXx2dmGK/0O7RSiA5ey7ToV2zSqTbyIVM/oBsdIjZmGl7IiCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKECxJYM6yhxHhTVvR399e0HJ7lWuscRECC3sppwyPdUtVx6aM
	8WI8XILOguf7JWrji6XN0C7RVY+3smMcDgGVJEX0vMnDnF4zIOUhLEJdMGAM+/s=
X-Gm-Gg: ASbGncvPVqR8OHwqfhHd2B7w56ZI/zPCzqbD7BOrhBf0nyNweM641J9xHXKv4GRbeLI
	zi734K7/0hFFl/Y4g9XS5VBeRwKNFLoUORKmQUUdXPNNPkC8NeupXht5m54tkxkzeCU32DZ4XUq
	Ym2TTz2BAM4ZeT1nwg4PHGgnHWcEboFLzVlk0dSn9CA/Pr1m4uRXb1RZDmUD2qCouRrii9QVqKL
	phdvSWYZwX+/s9vfq/1ZzABLGdqShgpvZX+dheUwmiJRo5Wl2CeJ0u+p3TIdcs4BlAIJQu/0DFa
	Hg1Cbzh2h1wAkT9xtWHWWGpbKTeRnPEY48R76ijCy/idxLTGfpTyN1GQgJiFwIeOZQh4aVFuqfG
	H+WbPQW5q/c/skMkABLZIUYDV
X-Google-Smtp-Source: AGHT+IGeARXVcG2cHhhuIEZTvFQOsMPoaHjmx3ib/t6sXJ722tNpW4RJ3V2x8jYPJEBhJrS3NGqcyA==
X-Received: by 2002:a05:6512:1597:b0:549:8d67:c48b with SMTP id 2adb3069b0e04-54990e5d44dmr3729878e87.20.1741509226867;
        Sun, 09 Mar 2025 00:33:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4605asm1047163e87.29.2025.03.09.00.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 00:33:46 -0800 (PST)
Date: Sun, 9 Mar 2025 10:33:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: david@ixit.cz
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Ivan Belokobylskiy <belokobylskij@gmail.com>
Subject: Re: [PATCH v3] ARM: dts: nexus4: Initial dts
Message-ID: <l4lv22oi2ktubf7aveqxqtwb7zz7cfrzdayuxxgwdj46ygubfs@qpl6ut37taoe>
References: <20250309-lg-nexus4-mako-v3-1-1dc2807df296@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309-lg-nexus4-mako-v3-1-1dc2807df296@ixit.cz>

On Sun, Mar 09, 2025 at 01:45:51AM +0100, David Heidelberg via B4 Relay wrote:
> From: Ivan Belokobylskiy <belokobylskij@gmail.com>
> 
> Add initial support for LG Nexus 4 (mako).
> 
> Features currently working: regulators, eMMC, WiFi, and volume keys.
> 
> Signed-off-by: Ivan Belokobylskiy <belokobylskij@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> Changes in v3:
> - rebased against next-20250307
> - dropped backlight until driver gets converted to DT
> 
> Changes in v2:
> - lge vendor doesn't exist anymore, rename to lg
> - sdcc@ to mmc@ to comply with dt-schema
> ---
>  arch/arm/boot/dts/qcom/Makefile                    |   1 +
>  .../boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts  | 342 +++++++++++++++++++++
>  2 files changed, 343 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
> index f06c6d425e91dd73c2b453d15543d95bd32383b9..0c1d116f6e84f76994aa8c8286350bdcd1657a42 100644
> --- a/arch/arm/boot/dts/qcom/Makefile
> +++ b/arch/arm/boot/dts/qcom/Makefile
> @@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-apq8064-ifc6410.dtb \
>  	qcom-apq8064-sony-xperia-lagan-yuga.dtb \
>  	qcom-apq8064-asus-nexus7-flo.dtb \
> +	qcom-apq8064-lg-nexus4-mako.dtb \
>  	qcom-apq8074-dragonboard.dtb \
>  	qcom-apq8084-ifc6540.dtb \
>  	qcom-apq8084-mtp.dtb \
> diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..bcb57675aa24892b290d543601f7a6b36b6a65f6
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts
> @@ -0,0 +1,342 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "qcom-apq8064-v2.0.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/mfd/qcom-rpm.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +/ {
> +	model = "LG Nexus 4 (mako)";
> +	compatible = "lg,nexus4-mako", "qcom,apq8064";
> +
> +	aliases {
> +		serial0 = &gsbi7_serial;
> +		serial1 = &gsbi6_serial;
> +		serial2 = &gsbi4_serial;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		ramoops@88d00000{
> +			compatible = "ramoops";
> +			reg = <0x88d00000 0x100000>;
> +			record-size = <0x00020000>;
> +			console-size = <0x00020000>;
> +			ftrace-size = <0x00020000>;
> +		};
> +	};
> +
> +	battery_cell: battery-cell {
> +		compatible = "simple-battery";
> +		constant-charge-current-max-microamp = <900000>;
> +		operating-range-celsius = <0 45>;
> +	};
> +
> +	soc {
> +		rpm@108000 {

Please use &rpm { ... }; instead.

> +			regulators {
> +				vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
> +				vin_lvs1_3_6-supply = <&pm8921_s4>;

Please move vin_lvs2-supply here.

> +				vin_lvs4_5_7-supply = <&pm8921_s4>;
> +

Please move vdd_l1_l2_l12_l18 here.

> +				vdd_l24-supply = <&pm8921_s1>;
> +				vdd_l25-supply = <&pm8921_s1>;
> +				vin_lvs2-supply = <&pm8921_s1>;
> +
> +				vdd_l26-supply = <&pm8921_s7>;
> +				vdd_l27-supply = <&pm8921_s7>;
> +				vdd_l28-supply = <&pm8921_s7>;
> +
> +				/* Buck SMPS */
> +				s1 {
> +					regulator-always-on;
> +					regulator-min-microvolt = <1225000>;
> +					regulator-max-microvolt = <1225000>;
> +					qcom,switch-mode-frequency = <3200000>;
> +					bias-pull-down;
> +				};

empty line

> +				s2 {
> +					regulator-min-microvolt = <1300000>;
> +					regulator-max-microvolt = <1300000>;
> +					qcom,switch-mode-frequency = <1600000>;
> +					bias-pull-down;
> +				};
> +
> +				/* msm otg HSUSB_VDDCX */
> +				s3 {
> +					regulator-min-microvolt = <500000>;
> +					regulator-max-microvolt = <1150000>;
> +					qcom,switch-mode-frequency = <4800000>;
> +					bias-pull-down;
> +				};
> +
> +				/*
> +				 * msm_sdcc.1-sdc-vdd_io
> +				 * tabla2x-slim-CDC_VDDA_RX
> +				 * tabla2x-slim-CDC_VDDA_TX
> +				 * tabla2x-slim-CDC_VDD_CP
> +				 * tabla2x-slim-VDDIO_CDC
> +				 */
> +				s4 {
> +					regulator-always-on;
> +					regulator-min-microvolt	= <1800000>;
> +					regulator-max-microvolt	= <1800000>;
> +					qcom,switch-mode-frequency = <1600000>;
> +					bias-pull-down;
> +					qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
> +				};
> +
> +				/*
> +				 * supply vdd_l26, vdd_l27, vdd_l28
> +				 */
> +				s7 {
> +					regulator-min-microvolt = <1300000>;
> +					regulator-max-microvolt = <1300000>;
> +					qcom,switch-mode-frequency = <3200000>;
> +				};
> +
> +				s8 {
> +					regulator-min-microvolt = <2200000>;
> +					regulator-max-microvolt = <2200000>;
> +					qcom,switch-mode-frequency = <1600000>;
> +				};
> +
> +				l1 {
> +					regulator-min-microvolt = <1100000>;
> +					regulator-max-microvolt = <1100000>;
> +					regulator-always-on;
> +					bias-pull-down;
> +				};
> +
> +				/* mipi_dsi.1-dsi1_pll_vdda */
> +				l2 {
> +					regulator-min-microvolt = <1200000>;
> +					regulator-max-microvolt = <1200000>;
> +					bias-pull-down;
> +				};
> +
> +				/* msm_otg-HSUSB_3p3 */
> +				l3 {
> +					regulator-min-microvolt = <3075000>;
> +					regulator-max-microvolt = <3500000>;
> +					bias-pull-down;
> +				};
> +
> +				/* msm_otg-HSUSB_1p8 */
> +				l4 {
> +					regulator-always-on;
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +				};
> +
> +				/* msm_sdcc.1-sdc_vdd */
> +				l5 {
> +					regulator-min-microvolt = <2950000>;
> +					regulator-max-microvolt = <2950000>;
> +					bias-pull-down;
> +				};
> +
> +				/* earjack_debug */
> +				l6 {
> +					regulator-min-microvolt = <3000000>;
> +					regulator-max-microvolt = <3000000>;
> +					bias-pull-down;
> +				};
> +
> +				/* mipi_dsi.1-dsi_vci */
> +				l8 {
> +					regulator-min-microvolt = <2800000>;
> +					regulator-max-microvolt = <3000000>;
> +					bias-pull-down;
> +				};
> +
> +				/* wcnss_wlan.0-iris_vddpa */
> +				l10 {
> +					regulator-min-microvolt = <2900000>;
> +					regulator-max-microvolt = <2900000>;
> +					bias-pull-down;
> +				};
> +
> +				/* mipi_dsi.1-dsi1_avdd */
> +				l11 {
> +					regulator-min-microvolt = <2850000>;
> +					regulator-max-microvolt = <2850000>;
> +					bias-pull-down;
> +				};
> +
> +				/* touch_vdd */
> +				l15 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <2950000>;
> +					bias-pull-down;
> +				};
> +
> +				/* slimport_dvdd */
> +				l18 {
> +					regulator-min-microvolt = <1100000>;
> +					regulator-max-microvolt = <1100000>;
> +					bias-pull-down;
> +				};
> +
> +				/* touch_io */
> +				l22 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					bias-pull-down;
> +				};
> +
> +				/*
> +				 * mipi_dsi.1-dsi_vddio
> +				 * pil_qdsp6v4.1-pll_vdd
> +				 * pil_qdsp6v4.2-pll_vdd
> +				 * msm_ehci_host.0-HSUSB_1p8
> +				 * msm_ehci_host.1-HSUSB_1p8
> +				 */
> +				l23 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					bias-pull-down;
> +				};
> +
> +				/*
> +				 * tabla2x-slim-CDC_VDDA_A_1P2V
> +				 * tabla2x-slim-VDDD_CDC_D
> +				 */
> +				l24 {
> +					regulator-min-microvolt = <750000>;
> +					regulator-max-microvolt = <1150000>;
> +					bias-pull-down;
> +				};
> +
> +				l25 {
> +					regulator-min-microvolt = <1250000>;
> +					regulator-max-microvolt = <1250000>;
> +					regulator-always-on;
> +					bias-pull-down;
> +				};
> +
> +				l26 {
> +					regulator-min-microvolt = <375000>;
> +					regulator-max-microvolt = <1050000>;
> +					regulator-always-on;
> +					bias-pull-down;
> +				};
> +
> +				l27 {
> +					regulator-min-microvolt = <1100000>;
> +					regulator-max-microvolt = <1100000>;
> +				};
> +
> +				l28 {
> +					regulator-min-microvolt = <1050000>;
> +					regulator-max-microvolt = <1050000>;
> +					bias-pull-down;
> +				};
> +
> +				/* wcnss_wlan.0-iris_vddio */
> +				lvs1 {
> +					bias-pull-down;
> +				};
> +
> +				/* wcnss_wlan.0-iris_vdddig */
> +				lvs2 {
> +					bias-pull-down;
> +				};
> +
> +				lvs3 {
> +					bias-pull-down;
> +				};
> +
> +				lvs4 {
> +					bias-pull-down;
> +				};
> +
> +				lvs5 {
> +					bias-pull-down;
> +				};
> +
> +				/* mipi_dsi.1-dsi_iovcc */
> +				lvs6 {
> +					bias-pull-down;
> +				};
> +
> +				/*
> +				 * pil_riva-pll_vdd
> +				 * lvds.0-lvds_vdda
> +				 * mipi_dsi.1-dsi1_vddio
> +				 * hdmi_msm.0-hdmi_vdda
> +				 */
> +				lvs7 {
> +					bias-pull-down;
> +				};
> +
> +				ncp {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					qcom,switch-mode-frequency = <1600000>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&pmicintc {
> +	keypad@148 {
> +		compatible = "qcom,pm8921-keypad";
> +		reg = <0x148>;
> +		interrupt-parent = <&pmicintc>;
> +		interrupts = <74 1>, <75 1>;

IRQ_TYPE_EDGE_RISING


> +		linux,keymap = <
> +			MATRIX_KEY(0, 0, KEY_VOLUMEDOWN)
> +			MATRIX_KEY(0, 1, KEY_VOLUMEUP)
> +		>;
> +
> +		keypad,num-rows = <1>;
> +		keypad,num-columns = <5>;
> +		debounce = <15>;
> +		scan-delay = <32>;
> +		row-hold = <91500>;
> +	};
> +};
> +
> +&gsbi1 {
> +	status = "okay";

Status should be the last property. Add empty line before it (here and
further)

> +	qcom,mode = <GSBI_PROT_I2C>;
> +};
> +
> +&gsbi1_i2c {
> +	status = "okay";
> +	clock-frequency = <200000>;
> +	pinctrl-0 = <&i2c1_pins>;
> +	pinctrl-names = "default";

I don't see i2c1_pins being defined. Did it pass the build?
Also there is already a pinctrl for this device. Why do you need to
overwrite it?

> +};
> +
> +&gsbi4 {
> +	status = "okay";
> +	qcom,mode = <GSBI_PROT_I2C_UART>;
> +};
> +
> +&gsbi4_serial {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gsbi4_uart_pin_a>;

Unnecessary, can be dropped. It's set in qcom-apq8064.dtsi.

> +};
> +
> +/* eMMC */
> +&sdcc1 {
> +	status = "okay";
> +	vmmc-supply = <&pm8921_l5>;
> +	vqmmc-supply = <&pm8921_s4>;
> +};
> +
> +&riva {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&riva_wlan_pin_a>;

Where is it defined? Also pinctrl-names should come after pinctrl-N.

> +};
> 
> ---
> base-commit: 0a2f889128969dab41861b6e40111aa03dc57014
> change-id: 20250309-lg-nexus4-mako-da0833885b26
> 
> Best regards,
> -- 
> David Heidelberg <david@ixit.cz>
> 
> 

-- 
With best wishes
Dmitry

