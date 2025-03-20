Return-Path: <linux-kernel+bounces-570439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CEEA6B051
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73949818CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDD522A7E4;
	Thu, 20 Mar 2025 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOPawomh"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB943227E9B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508525; cv=none; b=TH6WfhFLGH/B7WF+ASaswMCiSoJbQrXVkreSEyse91jotM0Dryv+mc31znKa+y8U8J7fTjUfJac5Y06m3ILmnTNs+WhvZ2iBXKBYa4j0OKl0ou5w6CzRm+uS2tHMQzfaiofFfl2K4E+9I0K0K9UhpMhxdKqSkTvsIZ+Yek9rcps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508525; c=relaxed/simple;
	bh=8m18k/YVZXwaT6cjdUBIoBsH0d1LYOwkxCZPIfG+MK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OC2rTj/BdftA3fbcQ0Bw1fyrQ4el48FIWLCP/dQYHxCa+8wKYbu4MZEmMclHtOeKeOOKOcv9d4NjtoZfKq/w5RXyZO9myp7LaPpJaN8gGLyn4TggNLa1mN1kRaVCrlG+5rD1rwKbrprSKiV1Cilu5WaKMuzMbCCwWZnK6pg2zOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uOPawomh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3997205e43eso1042085f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742508521; x=1743113321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b51iP35KFG1CIl36iu8PXktEtqpi3MNuLw8E+xpgKP4=;
        b=uOPawomhDsS/Q+lyamKZdGR/UI4feiY862gA+XgsPVub/HbO3FiqqqcnGHsHwOnQvn
         wwSnGIW4YWsb5sKQxvRdT+lIoGWZ6PsFF29MQFowAky9DEchw+YxZMN+AcZvRKGE5tML
         JH9UK4pByQEru5awUc6SKolQz7ILaNskHt42UrpUcXxx0gcJ6jaWUCssUQgyHmCw5eC8
         q3D528/cOzC+r7XJqudWXuPSqilZdjDK8YB9Gd47ubn6Xx9+lMWE0TiM6nCaXhxBkSnH
         TNWHmFeV+9bMO5PVzs/Mzn4yOfE/7eAt95+mp1CijTKQLl32qYgU0SZLHYgUfiqfRPLK
         NKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742508521; x=1743113321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b51iP35KFG1CIl36iu8PXktEtqpi3MNuLw8E+xpgKP4=;
        b=Xki8eCzXqP5FJkSMYRnIudD8jKCprfyL8QioHmWWxnTrPmiq2fBKni30T273oPLJKq
         I9tAJbUcXYTCedkax8h/ZHVT3NqsEUtlx6OiResDqVI7rNLnrddTck7mHi4gssh/RNIS
         XtbS9Q5u6cQnN8kfbxtlTC0gvpD6dzTp0dYtJQGrXTWMOEP1KTS/nOdOfYqMv/wAB8Kx
         H/buAa9a+weTyiOzyjnsYTsfwkoBTwl0kxWrAreRSqE2gQ2KnpAYcSYYKcBO3PlVmdQg
         N6mSEXvKoHVWQXakpr6YqXcUQ6hVsF21gg3A4qyPr4Hp2kJo1S82r7/lk152KA3G5ESO
         xphQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7HQG/FkyOERDDsTEm/qF8L52Ro739MKYdOTU+h6HiTGVKVKtmWfFxC+Lpf+7Xi/BeZCxSfukZf4IwrAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziBco5DjtEliVzBUkuU5S9rrcrBfuBsCcfr7aALT6KQUPg436L
	otxYg/tFC3SKDDL7fxGO+0qsMyW+63ImKP18rek7OjtPN8w1EClxn9VNmJIZ3ns=
X-Gm-Gg: ASbGncumJ6/iBmFFxUMFskdallH0g/vCEY+wgh1+ACDC/lxv+AgSVtE4x/E7WiS1TTF
	PhYX1udEYFg9RTAkHRf/eI96O48Ft+mnEjBRe4+RqcY0Bd1XSKgGB+RFIVL6JH8NkcBZn8YqEUy
	WGXOvnMWNqh7AMuevw+R8k4WCkBiiOGfMeJwwjnxuGQ+U0Rpfb75j7Z3DyOriPdQUNuEE/oQg0o
	xgtID/7INt+FMd4D440aH79bzfDSOzV4M79RaYbf2VV0nbSc3nbcQY9pKBEGKVosjco09E1suNh
	w+8ext6p5p8kaENFN33n/lcEV8rGL6dwzwLX2EHeOwann368iNSH1sbKoYwWN0b0tnVRzmTxbjj
	a27Lhw07jwg==
X-Google-Smtp-Source: AGHT+IG6cZVwmLEZurTazZCr7atPJy2iNnHxLpGHe6xlII+3K7WFRsUslXpp2g67TeBOVTtPbGFAyQ==
X-Received: by 2002:a05:6000:400e:b0:391:2a9a:4796 with SMTP id ffacd0b85a97d-3997f901786mr1265282f8f.18.1742508521013;
        Thu, 20 Mar 2025 15:08:41 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a50c1sm692749f8f.38.2025.03.20.15.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 15:08:39 -0700 (PDT)
Message-ID: <54c588be-d630-4901-8885-a042b477f168@linaro.org>
Date: Thu, 20 Mar 2025 22:08:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: x1e80100-qcp: Add power control
 and sideband signals for PCIe3
To: Wenbin Yao <quic_wenbyao@quicinc.com>, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, quic_qianyu@quicinc.com,
 sfr@canb.auug.org.au, linux-arm-kernel@lists.infradead.org
References: <20250320055502.274849-1-quic_wenbyao@quicinc.com>
 <w7mbnqG7DHPCH6hVoSu4E2p8pV7Rw6uvurlK-CUxF7TYQ53fFyagxmLUCmCTfG0DOUgIQn7GdppXgBlq8Gyv9Q==@protonmail.internalid>
 <20250320055502.274849-4-quic_wenbyao@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250320055502.274849-4-quic_wenbyao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2025 05:55, Wenbin Yao wrote:
> From: Qiang Yu <quic_qianyu@quicinc.com>
> 
> Add perst, wake and clkreq sideband signals and required regulators in
> PCIe3 controller and PHY device tree node. Describe the voltage rails of
> the x8 PCI slots for PCIe3 port.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 119 ++++++++++++++++++++++
>   1 file changed, 119 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
> index 28086a2bc..9cd313802 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
> @@ -318,6 +318,48 @@ vreg_wcn_3p3: regulator-wcn-3p3 {
>   		regulator-boot-on;
>   	};
> 
> +	vreg_pcie_12v: regulator-pcie_12v {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_PCIE_12V";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +
> +		gpio = <&pm8550ve_8_gpios 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie_x8_12v>;
> +	};
> +
> +	vreg_pcie_3v3_aux: regulator-pcie_3v3_aux {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_PCIE_3P3_AUX";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmc8380_3_gpios 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pm_sde7_aux_3p3_en>;
> +	};
> +
> +	vreg_pcie_3v3: regulator-pcie_3v3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_PCIE_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmc8380_3_gpios 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pm_sde7_main_3p3_en>;
> +};
> +
>   	usb-1-ss0-sbu-mux {
>   		compatible = "onnn,fsusb42", "gpio-sbu-mux";
> 
> @@ -907,6 +949,60 @@ &mdss_dp3_phy {
>   	status = "okay";
>   };
> 
> +&pm8550ve_8_gpios {
> +	pcie_x8_12v: pcie-12v-default-state {
> +		pins = "gpio8";
> +		function = "normal";
> +		output-enable;
> +		output-high;
> +		bias-pull-down;
> +		power-source = <0>;
> +	};
> +};
> +
> +&pmc8380_3_gpios {
> +	pm_sde7_aux_3p3_en: pcie-aux-3p3-default-state {
> +		pins = "gpio8";
> +		function = "normal";
> +		output-enable;
> +		output-high;
> +		bias-pull-down;
> +		power-source = <0>;
> +	};
> +
> +	pm_sde7_main_3p3_en: pcie-main-3p3-default-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		output-enable;
> +		output-high;
> +		bias-pull-down;
> +		power-source = <0>;
> +	};
> +};
> +
> +&pcie3 {
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie3_default>;
> +	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&pcie3_phy {
> +	vdda-phy-supply = <&vreg_l3j_0p8>;
> +	vdda-pll-supply = <&vreg_l3e_1p2>;
> +	vdda-qref-supply = <&vreg_l3c_0p8>;
> +
> +	status = "okay";
> +};
> +
> +&pcie3port {
> +	vpcie12v-supply = <&vreg_pcie_12v>;
> +	vpcie3v3-supply = <&vreg_pcie_3v3>;
> +	vpcie3v3aux-supply = <&vreg_pcie_3v3_aux>;
> +};
> +
>   &pcie4 {
>   	perst-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
>   	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
> @@ -1118,6 +1214,29 @@ nvme_reg_en: nvme-reg-en-state {
>   		bias-disable;
>   	};
> 
> +	pcie3_default: pcie3-default-state {
> +		clkreq-n-pins {
> +			pins = "gpio144";
> +			function = "pcie3_clk";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-n-pins {
> +			pins = "gpio143";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		wake-n-pins {
> +		       pins = "gpio145";
> +		       function = "gpio";
> +		       drive-strength = <2>;
> +		       bias-pull-up;
> +		};
> +	};
> +
>   	pcie4_default: pcie4-default-state {
>   		clkreq-n-pins {
>   			pins = "gpio147";
> --
> 2.34.1
> 
> 

Recommend breaking this patch into at least two patches @ the and

-> Add power control
-> Add sideband signals

if your patch title requires an and its usually a good indicator of a 
place to break that patch into different parts.

---
bod

