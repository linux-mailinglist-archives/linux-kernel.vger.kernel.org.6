Return-Path: <linux-kernel+bounces-411511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20439CFB55
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2705281BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4531AF0A7;
	Fri, 15 Nov 2024 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBd2jpir"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE99618FC65
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 23:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731714789; cv=none; b=emfUCkwmQxXia5QCJRPfSoSwGsQqyyK1GcDeCNotMUc2ZR6GxljHx/veXYvsuHVCx2qWQjN2oVXsRUiWUxKPUxY0GelqMNSfdQdYiRWirrTMUTRn8IZQ0hfN6MZMG7ZPpEHldJ3lh01SfNgUgh8s8WWE33uTocFunvdOQw9apHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731714789; c=relaxed/simple;
	bh=V1G/mNWNaLg+H+zslwg7XCQ5AaoMJLnm0g7bnXLqxd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5qKPzygaMEuthKjN/VbCvF7F2C52Jw71hzCphqEl/dQqrMwSQ1tmd4n7L5pSwzOOIQlMiCwoBrHG90MntbnoVJHGKY59zU+EB3OOpkpnUE2G9dUf07qxfWGAnlINb+bn6FArEyYjSOaL4ay4QDCAYCJhY9I3bG2p6eNL+Orvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mBd2jpir; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53d8c08cfc4so117375e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731714785; x=1732319585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MgEmcQdNkdut2IPPprxEWQBt06I4sG12AuVKHa7RR4=;
        b=mBd2jpir8x5UEgnUf/eomo/pFjdUwsg/24OZHVfMKflS6qEeHgZ7/w3hw4NNG+3tIG
         9RRUshE684Czv1wu9OrZlJiaqA5CrD8OkMXobYAGNmdeTidXP/tsg8V1QJTz9AhO6H/8
         1Z8uSP2lijHs2cD60/wNKUwuzW1wOEyVleDXcr8W+3nP+W9DR6G4x4zOJDyEKs1PXQgw
         rDGQrN+oSR8SiKuCicoXK7ALRWCeM1mclQqDn4cbbGyHfZcgIxwguaIScx1dIUu9lIIG
         Ml6+33LQbX68ZzBZKg+49RwsSrW3Q9HRltLao8mAqFjYGu+85a6/JE1ujrQHKrEqUIei
         LVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731714785; x=1732319585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MgEmcQdNkdut2IPPprxEWQBt06I4sG12AuVKHa7RR4=;
        b=dhvKkaxSKLC7uYNPOWCx9bbe2qkCxf16WaxbME6hOlWSBIdpk4MlgN2blS0FbmB3cm
         Z/TZBR4HYvAbZASgtnBrDRn4/IQKXUsbM63xyI1er2TfArkj2lgKnLeAQFSkjEAGrvG2
         fj8VtICjacQO85tOQZ6ZZ4tqh/7t0LpOz2uMJhdCZyqTdB7OYl8enTCLmIXvWwiHq8k/
         7Z86uknet9gh74S5r0I6KzQE0lSnE7YxhCG2XQzEEI79I70Zwmo3bTRLflx+wvtZZlnI
         sMRYO+qsZAsFp4QW/oh5rNiNaOzFM4851Xk0UvRzX48R34dV7SAZPhmVSXG6mZtlfnTq
         IOaA==
X-Forwarded-Encrypted: i=1; AJvYcCW1Q6wmid7gTPf3g6bI0Cva1Ar4lNv+KVI1mO/xxjmHdFLG68Ekdn22f+iqwe9kmCZFu2oWgxGzwf/NJy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybg7x2+uoklkPY8AgqLgAz952A3cjzQrm3jFLa72cQHg2hggs/
	qxtX+oZ/FFHOk5YykYFT7ZwjG4/uIi8OlhJvIKSWo1DvlNWlnrZAwOLax+mWRN0=
X-Google-Smtp-Source: AGHT+IFQLJ7tUIwuCogyWhUiQoXDm2bAfttKBUC86asOr9JPXcXRBy/7dRrbuos5aMQuE9VvMxc7XQ==
X-Received: by 2002:a05:6512:1190:b0:53d:a024:ddb2 with SMTP id 2adb3069b0e04-53dab2a076amr2006230e87.24.1731714784701;
        Fri, 15 Nov 2024 15:53:04 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da8622ec8sm691101e87.245.2024.11.15.15.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 15:53:03 -0800 (PST)
Date: Sat, 16 Nov 2024 01:53:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Wasim Nazir <quic_wasimn@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@quicinc.com
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: Add support for QCS9075 RB8
Message-ID: <5r4m3p3kwix2jjp23l5eqk74mbt2dusozwxml4um2i773qxb6g@swzszlybrqfa>
References: <20241115225152.3264396-1-quic_wasimn@quicinc.com>
 <20241115225152.3264396-5-quic_wasimn@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115225152.3264396-5-quic_wasimn@quicinc.com>

On Sat, Nov 16, 2024 at 04:21:51AM +0530, Wasim Nazir wrote:
> Add device tree support for the QCS9075-RB8 board.
> 
> Basic changes are supported for boot to shell.
> 
> Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile        |   1 +
>  arch/arm64/boot/dts/qcom/qcs9075-rb8.dts | 281 +++++++++++++++++++++++
>  2 files changed, 282 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs9075-rb8.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 9bb8b191aeb5..5d9847119f2e 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -115,6 +115,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs9075-rb8.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qcs9075-rb8.dts b/arch/arm64/boot/dts/qcom/qcs9075-rb8.dts
> new file mode 100644
> index 000000000000..e4307ff1e2a7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs9075-rb8.dts
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +#include "sa8775p.dtsi"
> +#include "sa8775p-pmics.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. QCS9075 RB8";

Is this going to be an actual product name? Usually RBx boards are named
differently.

> +	compatible = "qcom,qcs9075-rb8", "qcom,qcs9075", "qcom,sa8775p";
> +
> +	aliases {
> +		serial0 = &uart10;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&apps_rsc {
> +	regulators-0 {
> +		compatible = "qcom,pmm8654au-rpmh-regulators";
> +		qcom,pmic-id = "a";
> +
> +		vreg_s4a: smps4 {
> +			regulator-name = "vreg_s4a";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1816000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s5a: smps5 {
> +			regulator-name = "vreg_s5a";
> +			regulator-min-microvolt = <1850000>;
> +			regulator-max-microvolt = <1996000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s9a: smps9 {
> +			regulator-name = "vreg_s9a";
> +			regulator-min-microvolt = <535000>;
> +			regulator-max-microvolt = <1120000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4a: ldo4 {
> +			regulator-name = "vreg_l4a";
> +			regulator-min-microvolt = <788000>;
> +			regulator-max-microvolt = <1050000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5a: ldo5 {
> +			regulator-name = "vreg_l5a";
> +			regulator-min-microvolt = <870000>;
> +			regulator-max-microvolt = <950000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6a: ldo6 {
> +			regulator-name = "vreg_l6a";
> +			regulator-min-microvolt = <870000>;
> +			regulator-max-microvolt = <970000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7a: ldo7 {
> +			regulator-name = "vreg_l7a";
> +			regulator-min-microvolt = <720000>;
> +			regulator-max-microvolt = <950000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8a: ldo8 {
> +			regulator-name = "vreg_l8a";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9a: ldo9 {
> +			regulator-name = "vreg_l9a";
> +			regulator-min-microvolt = <2970000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-1 {
> +		compatible = "qcom,pmm8654au-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vreg_l1c: ldo1 {
> +			regulator-name = "vreg_l1c";
> +			regulator-min-microvolt = <1140000>;
> +			regulator-max-microvolt = <1260000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2c: ldo2 {
> +			regulator-name = "vreg_l2c";
> +			regulator-min-microvolt = <900000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3c: ldo3 {
> +			regulator-name = "vreg_l3c";
> +			regulator-min-microvolt = <1100000>;
> +			regulator-max-microvolt = <1300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4c: ldo4 {
> +			regulator-name = "vreg_l4c";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			/*
> +			 * FIXME: This should have regulator-allow-set-load but
> +			 * we're getting an over-current fault from the PMIC
> +			 * when switching to LPM.
> +			 */
> +		};
> +
> +		vreg_l5c: ldo5 {
> +			regulator-name = "vreg_l5c";
> +			regulator-min-microvolt = <1100000>;
> +			regulator-max-microvolt = <1300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6c: ldo6 {
> +			regulator-name = "vreg_l6c";
> +			regulator-min-microvolt = <1620000>;
> +			regulator-max-microvolt = <1980000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7c: ldo7 {
> +			regulator-name = "vreg_l7c";
> +			regulator-min-microvolt = <1620000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8c: ldo8 {
> +			regulator-name = "vreg_l8c";
> +			regulator-min-microvolt = <2400000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9c: ldo9 {
> +			regulator-name = "vreg_l9c";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <2700000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-2 {
> +		compatible = "qcom,pmm8654au-rpmh-regulators";
> +		qcom,pmic-id = "e";
> +
> +		vreg_s4e: smps4 {
> +			regulator-name = "vreg_s4e";
> +			regulator-min-microvolt = <970000>;
> +			regulator-max-microvolt = <1520000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s7e: smps7 {
> +			regulator-name = "vreg_s7e";
> +			regulator-min-microvolt = <1010000>;
> +			regulator-max-microvolt = <1170000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s9e: smps9 {
> +			regulator-name = "vreg_s9e";
> +			regulator-min-microvolt = <300000>;
> +			regulator-max-microvolt = <570000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6e: ldo6 {
> +			regulator-name = "vreg_l6e";
> +			regulator-min-microvolt = <1280000>;
> +			regulator-max-microvolt = <1450000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8e: ldo8 {
> +			regulator-name = "vreg_l8e";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1950000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +};
> +
> +&qupv3_id_1 {
> +	status = "okay";
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32768>;
> +};
> +
> +&tlmm {
> +	qup_uart10_default: qup-uart10-state {
> +		pins = "gpio46", "gpio47";
> +		function = "qup1_se3";
> +	};
> +};
> +
> +&uart10 {
> +	compatible = "qcom,geni-debug-uart";
> +	pinctrl-0 = <&qup_uart10_default>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&xo_board_clk {
> +	clock-frequency = <38400000>;
> +};
> --
> 2.47.0
> 

-- 
With best wishes
Dmitry

