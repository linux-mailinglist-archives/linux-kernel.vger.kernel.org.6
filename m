Return-Path: <linux-kernel+bounces-525867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F15A3F698
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD41419C304D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FD41F3FE2;
	Fri, 21 Feb 2025 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqzNB9be"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28202202F64
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146113; cv=none; b=dBr0H1dTXSNG3RL5+Dme0jV3bufwD1oCu7jB+AQH3iyFKqbw27iPkUo5Y3hcg+O955byRy4cBtu7ikM3dPaVqG+7RT6gBy0tjhPE73tDNWsyfvoEwgnUWF/2Wl+pa5/8JkrpeTIbXRr8HzH3IT5oHjsR69YRAbSB9e1QSqxuNJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146113; c=relaxed/simple;
	bh=HO7i7XxZkxelkKOIDkBkNovHj3SjDp4B3C/5v6f+hnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4MPOAmMJ1DoveThLDxcV0PzfVFpLGdpi42XOarfrR9yTGjh8ifru7mdcl2ZswUbo6mtqmUp/nhdVScTW1FM56J01HdyF2OkaPK+1cUveSS4+7IgldiiSXdSheMw8lhuyPpqySH2f2JsNLmnxxX6q8U+W+AL2LidXAs8b9408xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OqzNB9be; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5462ea9691cso2345571e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740146108; x=1740750908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6wNJiZKSoKPVlfFfRZ9OJ6JR74GVm4JTrMp+TJUPtiw=;
        b=OqzNB9beJMATa+jmK/3+y42ZLvQNd483fXxOjn8mae909RDFMGv+f5YSUU/6RbM/oQ
         RlIGUfcw7SSeo9cR48naWmpM4tWIcwISouhli1qgWygwPhZHGMQlTfgFu7mb0YXgf+wT
         wcSk5BS2TgE82tX9ybWd+RcvjWB/lhpxUpcUPuYKjhtGFT3p/yrL5NX7XWeXz0LtEJbU
         NDRbwunNMevnRNqcW1Bu/mB8b3JO9awcb2vrBkPqQf+kZSqmrymk+qIKqNFN93E3z/Mv
         N9Xo7yyWKK2r0sVHAn7pg4Mgnn8EjckACdbsyg1G16ABLN7TggyqGYE5U+bbTmNOeIyb
         EQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740146108; x=1740750908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wNJiZKSoKPVlfFfRZ9OJ6JR74GVm4JTrMp+TJUPtiw=;
        b=vTFASe5oT0HuzINvg7/hS23GuhDLebOjA9qREHo9aMUbny2Jk7+iSiYCONkHMCTVwK
         xUMGLvxivMPOL+vxnd38dRtwWo5h3GiPeY5w7vzpY9uxygUsp4tCC/fzsNU9ZXPYS0c8
         ob2XKBoOxSVfxx/W+bm5mg+s6LyolE2XuoHoj6j6CBaI3J0Gs08B8sRsRpfmjKTg+8KH
         /c4qcZN53+BNR57cBjA33m6KwiWv+ZLZWYrkRbdF+3l0Z//6oNE065MgwZIsUs2GRfKL
         fJHeehNn0oQkhS2AYNXYXN4UVAykDegMQ1ssJesgETXhfdpj2aJZZ2/dQFdYRzAIeCWj
         2fzg==
X-Forwarded-Encrypted: i=1; AJvYcCX07WSozT6w4FOgr3kYHJuqFIJNZscQeJP8+0yVc5pGYrSgmBnWaPdj1jxygbCEt6UCgggObEu2zVCXPaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8onOoJXT7tg+M2vp7lqkfXFRUfaeCGG3z51smBFH/V6ndp3FZ
	E19rpzHBEXSsf816j3GMg/GuMWML+qjgBoEzCmL2G0roXMifBL7Rb9Cr9sc1Bfs=
X-Gm-Gg: ASbGncuLDpEhEPGivahrnE9k/QpiN00K6csEyIR0Dl+Nk+gqdLKgBJTz0CrNvDGCgC5
	60pNuRpoajD+AZHFM+M3Jh4+c9J4dO5SQ0PVwP54SMsht6ukOciT+CuE7Vz0O9VFPg/Ry9otsgl
	9JkT5bw5ZNfX0fo4RixDsYAi53VwEVzUkYMZqQtNa44EsSVM1cmAiFxAMFhNjWaFLafRqc+mZjU
	puqnU7jEBPwlzfYN7IcFRdWsAVj41j1kGqKnYGbQ4h596B4oNiHcBLX1fBYvM/5l6dS2SaYpWrt
	ynq0d7dFHCBIrvQbUDkRBrX5aAcbXzl1rIxTJ/Ri8Ja9cDlGGOJItT5VLSuyTMJAAciCIXmKT8U
	Cv6Pcbw==
X-Google-Smtp-Source: AGHT+IEXHt9PwDCHU7/bbW2hfGATqtM9ttAqItuz3wSuFU98Zngu1NcXX829XFI2rQeO3C89Zh/YMA==
X-Received: by 2002:a05:6512:31c6:b0:545:c7d:1796 with SMTP id 2adb3069b0e04-54838f5be58mr1376208e87.43.1740146108161;
        Fri, 21 Feb 2025 05:55:08 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5453035f233sm2085404e87.215.2025.02.21.05.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:55:07 -0800 (PST)
Date: Fri, 21 Feb 2025 15:55:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org
Subject: Re: [RESEND PATCH v9 1/2] arm64: dts: qcom: qcs6490-rb3gen: add and
 enable BT node
Message-ID: <s36psuynvcak337thjcy6o532mvxrqogwutdinqodco6tzeebu@npaazdpl6qh3>
References: <20250220112945.3106086-1-quic_janathot@quicinc.com>
 <20250220112945.3106086-2-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220112945.3106086-2-quic_janathot@quicinc.com>

On Thu, Feb 20, 2025 at 04:59:44PM +0530, Janaki Ramaiah Thota wrote:
> Add the PMU node for WCN6750 present on the qcs6490-rb3gen
> board and assign its power outputs to the Bluetooth module.
> 
> In WCN6750 module sw_ctrl and wifi-enable pins are handled
> in the wifi controller firmware. Therefore, it is not required
> to have those pins' entries in the PMU node.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 167 ++++++++++++++++++-
>  1 file changed, 166 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 7a36c90ad4ec..0a3243499dfb 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: BSD-3-Clause
>  /*
> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  /dts-v1/;
> @@ -34,6 +34,7 @@ / {
>  
>  	aliases {
>  		serial0 = &uart5;
> +		serial1 = &uart7;
>  	};
>  
>  	chosen {
> @@ -218,6 +219,63 @@ vph_pwr: vph-pwr-regulator {
>  		regulator-min-microvolt = <3700000>;
>  		regulator-max-microvolt = <3700000>;
>  	};
> +
> +	wcn6750-pmu {
> +		compatible = "qcom,wcn6750-pmu";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_en>;

pinctrl-0
(pinctrl-1 etc.)
pinctrl-names


> +		vddaon-supply = <&vreg_s7b_0p972>;
> +		vddasd-supply = <&vreg_l11c_2p8>;
> +		vddpmu-supply = <&vreg_s7b_0p972>;
> +		vddrfa0p8-supply = <&vreg_s7b_0p972>;
> +		vddrfa1p2-supply = <&vreg_s8b_1p272>;
> +		vddrfa1p7-supply = <&vreg_s1b_1p872>;
> +		vddrfa2p2-supply = <&vreg_s1c_2p19>;
> +
> +		bt-enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
> +
> +		regulators {
> +			vreg_pmu_rfa_cmn: ldo0 {
> +				regulator-name = "vreg_pmu_rfa_cmn";
> +			};
> +
> +			vreg_pmu_aon_0p59: ldo1 {
> +				regulator-name = "vreg_pmu_aon_0p59";
> +			};
> +
> +			vreg_pmu_wlcx_0p8: ldo2 {
> +				regulator-name = "vreg_pmu_wlcx_0p8";
> +			};
> +
> +			vreg_pmu_wlmx_0p85: ldo3 {
> +				regulator-name = "vreg_pmu_wlmx_0p85";
> +			};
> +
> +			vreg_pmu_btcmx_0p85: ldo4 {
> +				regulator-name = "vreg_pmu_btcmx_0p85";
> +			};
> +
> +			vreg_pmu_rfa_0p8: ldo5 {
> +				regulator-name = "vreg_pmu_rfa_0p8";
> +			};
> +
> +			vreg_pmu_rfa_1p2: ldo6 {
> +				regulator-name = "vreg_pmu_rfa_1p2";
> +			};
> +
> +			vreg_pmu_rfa_1p7: ldo7 {
> +				regulator-name = "vreg_pmu_rfa_1p7";
> +			};
> +
> +			vreg_pmu_pcie_0p9: ldo8 {
> +				regulator-name = "vreg_pmu_pcie_0p9";
> +			};
> +
> +			vreg_pmu_pcie_1p8: ldo9 {
> +				regulator-name = "vreg_pmu_pcie_1p8";
> +			};
> +		};
> +	};
>  };
>  
>  &apps_rsc {
> @@ -799,6 +857,39 @@ &pon_resin {
>  	status = "okay";
>  };
>  
> +&qup_uart7_cts {
> +	/*
> +	 * Configure a bias-bus-hold on CTS to lower power
> +	 * usage when Bluetooth is turned off. Bus hold will
> +	 * maintain a low power state regardless of whether
> +	 * the Bluetooth module drives the pin in either
> +	 * direction or leaves the pin fully unpowered.
> +	 */
> +	bias-bus-hold;
> +};
> +
> +&qup_uart7_rts {
> +	/* We'll drive RTS, so no pull */
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +
> +&qup_uart7_rx {
> +	/*
> +	 * Configure a pull-up on RX. This is needed to avoid
> +	 * garbage data when the TX pin of the Bluetooth module is
> +	 * in tri-state (module powered off or not driving the
> +	 * signal yet).
> +	 */
> +	bias-pull-up;
> +};
> +
> +&qup_uart7_tx {
> +	/* We'll drive TX, so no pull */
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
> @@ -842,12 +933,86 @@ &sdhc_2 {
>  &tlmm {
>  	gpio-reserved-ranges = <32 2>, /* ADSP */
>  			       <48 4>; /* NFC */
> +
> +	bt_en: bt-en-state {
> +		pins = "gpio85";
> +		function = "gpio";
> +		output-low;
> +		bias-disable;
> +	};
> +
> +	qup_uart7_sleep_cts: qup-uart7-sleep-cts-state {
> +		pins = "gpio28";
> +		function = "gpio";
> +		/*
> +		 * Configure a bias-bus-hold on CTS to lower power
> +		 * usage when Bluetooth is turned off. Bus hold will
> +		 * maintain a low power state regardless of whether
> +		 * the Bluetooth module drives the pin in either
> +		 * direction or leaves the pin fully unpowered.
> +		 */
> +		bias-bus-hold;
> +	};
> +
> +	qup_uart7_sleep_rts: qup-uart7-sleep-rts-state {
> +		pins = "gpio29";
> +		function = "gpio";
> +		/*
> +		 * Configure pull-down on RTS. As RTS is active low
> +		 * signal, pull it low to indicate the BT SoC that it
> +		 * can wakeup the system anytime from suspend state by
> +		 * pulling RX low (by sending wakeup bytes).
> +		 */
> +		bias-pull-down;
> +	};
> +
> +	qup_uart7_sleep_rx: qup-uart7-sleep-rx-state {
> +		pins = "gpio31";
> +		function = "gpio";
> +		/*
> +		 * Configure a pull-up on RX. This is needed to avoid
> +		 * garbage data when the TX pin of the Bluetooth module
> +		 * is floating which may cause spurious wakeups.
> +		 */
> +		bias-pull-up;
> +	};
> +
> +	qup_uart7_sleep_tx: qup-uart7-sleep-tx-state {
> +		pins = "gpio30";
> +		function = "gpio";
> +		/*
> +		 * Configure pull-up on TX when it isn't actively driven
> +		 * to prevent BT SoC from receiving garbage during sleep.
> +		 */
> +		bias-pull-up;
> +	};
>  };
>  
>  &uart5 {
>  	status = "okay";
>  };
>  
> +&uart7 {
> +	/delete-property/interrupts;

Missing space before 'interrupts'.

> +	interrupts-extended = <&intc GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>,
> +				<&tlmm 31 IRQ_TYPE_EDGE_FALLING>;

Align by the opening angle bracket.

> +	pinctrl-1 =  <&qup_uart7_sleep_cts>, <&qup_uart7_sleep_rts>,
> +		<&qup_uart7_sleep_tx>, <&qup_uart7_sleep_rx>;

Align '<' vertically.

> +	pinctrl-names = "default", "sleep";

Vertical list, please, aligned by the opening quote.

Also please add empty line before status.

> +	status = "okay";
> +
> +	bluetooth: bluetooth {
> +		compatible = "qcom,wcn6750-bt";
> +		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> +		vddaon-supply = <&vreg_pmu_aon_0p59>;
> +		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
> +		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
> +		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
> +		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
> +		max-speed = <3200000>;
> +	};
> +};
> +
>  &usb_1 {
>  	status = "okay";
>  };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

-- 
With best wishes
Dmitry

