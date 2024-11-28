Return-Path: <linux-kernel+bounces-424730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23E59DB8AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741EC164CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F551AA1D5;
	Thu, 28 Nov 2024 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zQI7L1om"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AFF1A0BFD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800558; cv=none; b=hULKLAv9MwNBbTVamydS4qCHBkgGH/JgKDJVUJoJysI/+jjHPylTAhYzwBC6+zJ5DUKaksN6ht83of94f84GVh4LT4dGYrcZz0IJ6jI7YC58y9PULeUi4i3z42EXq0RgAv6GNEXzLCGiSvry5opAK7U4ZMdXZnfMXesmOl8rwJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800558; c=relaxed/simple;
	bh=wMAWalfuWsuDIz3yowdMMxvuCErhNK7h384phiTRa9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZZZ1YUVX6Ep8fN6UjLg74abhNTpFjpylp0h+MHjMlMkMi3+RfRxddWZ76h3bAQ75vp9g5yh6vyHH86GSdxBvk3fRDF2wftflLcIGhmpxEir6+Iq2iJ5GjOm9oC6ENM2+TetQmavqZ0aQp/dYWamNNX4KxmiN1xoQNgnaKadDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zQI7L1om; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53de035ea13so828822e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732800554; x=1733405354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1M9x+r+YCviBGoZJC9x2b+6oMkUPbXP/SxU+uMpJQBk=;
        b=zQI7L1om6mbufH4f2d4gaUKQTV0IY5t1b6XDuZNlbXWjbsN1uoww4llCfyVWO1BjVU
         55ny/jYF9E5qF5+eNRrva9L0c9O5CE0tH3A2Gjm7hla9oCKbGoZz74ezGjV3cDFkBYzm
         E1JFMtcWZn2zIhtIwM11LMdQpc6pLXWMSnSwQG0iMLcdLUh5NcXuQMrWUBjjaGorX8sY
         UAqJAnmWTy7SP1TabF0AmEgWPmK/rzVDH3ApP3+lU5ATwr7+YKKSvGpUgN2L5VZSbSDs
         t4axkGSepvUf2woTFxZpagShkMWj1xJhKXQNUgeA+7KG+KfYRUOfrDUbpNd1tdkGgjOe
         WchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732800554; x=1733405354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1M9x+r+YCviBGoZJC9x2b+6oMkUPbXP/SxU+uMpJQBk=;
        b=KSnh4WjQ0Nhbnz7liaEL20M94tZZDrLD5l0d+Mxtfs7VxM/zuWSib63oZe2cRdAfkp
         Y6msS02SLI6fcKF9yaLb61RshyMmGq5XoRRl9oHXJiD+ZdeSrghj+rtrpcvSOaTCalQj
         5IgI7UHquqAu8fwGP+8ac0B+QiRwqHcakIW0VQvz3GIx3a/zvnC+ixK8GCQCczSeEqqJ
         MynC286YUTqgp46rKYZSuVbYzqiSFnG20Gnb+v8bP2zYZOUNkPhIloUw+RocvFY5OrFv
         3W76mASuTQ4/VcbdOPL8gbkx1ximDwXT3ENXQAvlQzE6jit0UpcnVC+8IsysRq9VBieV
         X1lA==
X-Forwarded-Encrypted: i=1; AJvYcCVzEI31DCG7xAtr4IEi0px8iRdWvz3PdY/i0PlIqsABiupYBKqo2j0NtoifU4aeTa6/N5yhrpSTMcYPIvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5wVN4mRWdVq0h/jc0VguwVdYY/zJ5Kx6YEpggne37zVn8sr3m
	DnNw24QWekujzGnR9e+Dwu2JdqPBmVWf4sYnNX1oTE6Ps1AYT/hVjsbor7EpIM8=
X-Gm-Gg: ASbGncsWeQGCFRvw9GwYjmmBnT/0CsGyOHkXmnD9Kk+zMmTFRaTiTWt+zxsnSn+Xpy5
	GfqnSVOHRiEyal5fV66xHQM5+/pxFF7KLB1to/TKxIGE3rXwSPng54SsxUUwrFNByzs6H0rMgv9
	wsBDttnuRQkF4ld7Eu6hyi8EIll9GUdB5Qb5gPB6/cBRhrZlNiwKIMO1Rw4zjafZJcjQRWlIrN2
	RM41l97vK9gfdvx/6RWN+/OTuVQy1hbPu25UuJmRQLG+NlcUR6mnf/VgKIIqlGNaxjQPwtVAktd
	iLurtfIBXhpyDyMBKD5sBVzRnvXIMQ==
X-Google-Smtp-Source: AGHT+IHy0ZGE4Q0Xmg9+8tJl78/gObc6lT7zqEAjjh/Q+2LBS9UBU7Z9bBloHS8dGT7KVHRth1FBbg==
X-Received: by 2002:a05:6512:3b9e:b0:53d:ecf6:aad5 with SMTP id 2adb3069b0e04-53df00d1b2dmr4636025e87.16.1732800554046;
        Thu, 28 Nov 2024 05:29:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64434d3sm179283e87.97.2024.11.28.05.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:29:13 -0800 (PST)
Date: Thu, 28 Nov 2024 15:29:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jingyi Wang <quic_jingyw@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, quic_tengfan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: add base QCS8300 RIDE board
Message-ID: <hswfcxj6vlutl7covrbqqzueljv6nkm3q4qrgccii3zh72qrig@spfbtrvrar5f>
References: <20241128-qcs8300_initial_dtsi-v3-0-26aa8a164914@quicinc.com>
 <20241128-qcs8300_initial_dtsi-v3-4-26aa8a164914@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-qcs8300_initial_dtsi-v3-4-26aa8a164914@quicinc.com>

On Thu, Nov 28, 2024 at 04:44:46PM +0800, Jingyi Wang wrote:
> Add initial support for Qualcomm QCS8300 RIDE board which enables DSPs,
> UFS and booting to shell with uart console.
> 
> Written with help from Tingguo Cheng (added rpmhpd nodes) and Xin Liu
> (added ufs, adsp and gpdsp nodes).
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile         |   2 +-
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 267 ++++++++++++++++++++++++++++++
>  2 files changed, 268 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 9bb8b191aeb5..d9545743606a 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -114,7 +114,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-shift-otter.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
> -dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs8300-ride.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> new file mode 100644
> index 000000000000..7eed19a694c3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +#include "qcs8300.dtsi"
> +/ {
> +	model = "Qualcomm Technologies, Inc. QCS8300 Ride";
> +	compatible = "qcom,qcs8300-ride", "qcom,qcs8300";
> +	chassis-type = "embedded";
> +
> +	aliases {
> +		serial0 = &uart7;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	clocks {
> +		xo_board_clk: xo-board-clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <38400000>;
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <32000>;
> +		};

Move both clocks to the qcs8300.dtsi. If you wish, you can keep
frequencies in the board DT file.

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
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s9a: smps9 {
> +			regulator-name = "vreg_s9a";
> +			regulator-min-microvolt = <1352000>;
> +			regulator-max-microvolt = <1352000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3a: ldo3 {
> +			regulator-name = "vreg_l3a";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4a: ldo4 {
> +			regulator-name = "vreg_l4a";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5a: ldo5 {
> +			regulator-name = "vreg_l5a";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6a: ldo6 {
> +			regulator-name = "vreg_l6a";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7a: ldo7 {
> +			regulator-name = "vreg_l7a";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8a: ldo8 {
> +			regulator-name = "vreg_l8a";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9a: ldo9 {
> +			regulator-name = "vreg_l9a";
> +			regulator-min-microvolt = <2970000>;
> +			regulator-max-microvolt = <3072000>;
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
> +		vreg_s5c: smps5 {
> +			regulator-name = "vreg_s5c";
> +			regulator-min-microvolt = <1104000>;
> +			regulator-max-microvolt = <1104000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1c: ldo1 {
> +			regulator-name = "vreg_l1c";
> +			regulator-min-microvolt = <300000>;
> +			regulator-max-microvolt = <500000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2c: ldo2 {
> +			regulator-name = "vreg_l2c";
> +			regulator-min-microvolt = <900000>;
> +			regulator-max-microvolt = <904000>;
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
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6c: ldo6 {
> +			regulator-name = "vreg_l6c";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7c: ldo7 {
> +			regulator-name = "vreg_l7c";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8c: ldo8 {
> +			regulator-name = "vreg_l8c";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9c: ldo9 {
> +			regulator-name = "vreg_l9c";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +};
> +
> +&gcc {
> +	clocks = <&rpmhcc RPMH_CXO_CLK>,
> +		 <&sleep_clk>,
> +		 <0>,
> +		 <0>,
> +		 <0>,
> +		 <0>,
> +		 <0>,
> +		 <0>,
> +		 <0>,
> +		 <0>;

Move this to the qcs8300.dtsi (and rpmhcc too).

> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&remoteproc_adsp {
> +	firmware-name = "qcom/qcs8300/adsp.mbn";
> +	status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +	firmware-name = "qcom/qcs8300/cdsp0.mbn";
> +	status = "okay";
> +};
> +
> +&remoteproc_gpdsp {
> +	firmware-name = "qcom/qcs8300/gpdsp0.mbn";
> +	status = "okay";
> +};
> +
> +&rpmhcc {
> +	clocks = <&xo_board_clk>;
> +	clock-names = "xo";

qcs8300.dtsi

> +};
> +
> +&uart7 {
> +	status = "okay";
> +};
> +
> +&ufs_mem_hc {
> +	reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
> +	vcc-supply = <&vreg_l8a>;
> +	vcc-max-microamp = <1100000>;
> +	vccq-supply = <&vreg_l4c>;
> +	vccq-max-microamp = <1200000>;
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l4a>;
> +	vdda-pll-supply = <&vreg_l5a>;
> +	status = "okay";
> +};
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

