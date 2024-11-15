Return-Path: <linux-kernel+bounces-410593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8549CDDAD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6B31F2346E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803621B6D17;
	Fri, 15 Nov 2024 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6kgP6XZ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D52D52F9E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731671144; cv=none; b=AzSw7uC2yDYCyeYCb4jhQS+8vsAt9jeBMgTtKL2J1lIiSWA5YSGe2mg4ZbIM6MlD9LpIj2MxrSMUaupefqeOwwyatIpvq97cpeA02KcQjaYWuUcZzoRE2YjnSwyMbzvOWZLnGpH7cE6urkD2gMmaNi3IMnn1MPv2b8+8ExtKGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731671144; c=relaxed/simple;
	bh=AYQ6bm2XTleVCZIFNAkhoEQnWTu4KviKfTHZ/1z9dcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GN7AH6q1GxleCAO5DaJ2o2unNZzFRcVU20r6573dxYH/T2qETeIzAviDHvpG/AHCuvZRd4KmoF1GV6c2UywYv5kjGAb7VVGRSbUxS0yXFGbyKsWWwxFcw69pbiH69Bf404jtHlLZCCbiuf9e5sOYaSLZoVYIWyW3RvK6hPqLcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C6kgP6XZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cbca51687so17674765ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 03:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731671142; x=1732275942; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HimgWaHQTpzhPp/68+0fUZZbBB8cI4FMHzyZ2vd64Sw=;
        b=C6kgP6XZ8Y5CAu4v6tR8uaVfWM/jpP6L+z5M+VVa0fmWMXgWj30Is2qergxbpliyPg
         aG6kR7D2+FleQMWLiFgBp58/MjchzGKJl3ZrSzJdqDx8mMxgBi34Nd3Co3uEETgNQb1S
         QoGqzFB4uuA159dINKgtiAef1czmxa3bmgtgfKk5MAdU9H6NCi/ZtMOFBONOnesoX59Y
         YOMqIQ3kqiY+YuSym9iwhngRe/FvZNRKSkq0vp7fmlT7JhySE2qyUvvq3OpABAyXt9No
         aPwbbv+0J0ZuOShEWkYPUcxcnnxSwqKxDfB3xrWtiO8wSBxoyKQt3lqnLm4GHwYkBYw0
         8IJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731671142; x=1732275942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HimgWaHQTpzhPp/68+0fUZZbBB8cI4FMHzyZ2vd64Sw=;
        b=ht4PxefbxUpEM3AA9LATlHfLEGSmB5xbsxOtmRUhkfIckS0E3LO0K9hTdaW66pzdm7
         3NswsnQY7O980zC6U3aM7yc/y/wxwJEqFlU+1XtNZ+UuGf4B+e3RCsV/BMMDmAgG3Kpl
         rRitxROsyyEAJrndgKNJYWiADQbyAfdH4H3lhSfhF4S3sqVCPRHjviOamlCXWUv4tn4Z
         pedv4vrm2OFwyzPtsBaxwfGK6FmQeCu0oKjBtzVyeOaysPfywKqQJlRrLBNcTtGUYCD0
         40c0OJOqNrzFlSug+xl3TbyAW15h1X4Hpen9VZmxxYFUC5GruVkrXGe/t3AhX9DnzZX4
         seUA==
X-Forwarded-Encrypted: i=1; AJvYcCVEzeDS+0QVG2ckjfOdJheG3wW8Ck8WCeMkU+N8BiE76BCpmnwutHfEKyQUZ7/3bKr8l0qI+FQUt/brMHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyECbLEhY2xXvyEh1HwJtw7AXxl/fjdvRsv3WC56mcKgq8GcBY7
	2R/ObJykOHOvqLNN+Bybf/8eNHWhZFd/5c4/8irsMNhL6/p9ArStPiOyfPs0fA==
X-Google-Smtp-Source: AGHT+IFZFtP+1BGeoW8Q/+hmGF/1QZO1mnKMY+wp/cR1tUMg1R4X+CzMnsq8s7hdN6cWY5lMFAk59w==
X-Received: by 2002:a17:902:d48f:b0:20b:4875:2c51 with SMTP id d9443c01a7336-211d0d92274mr24621765ad.27.1731671142496;
        Fri, 15 Nov 2024 03:45:42 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f56e55sm10454435ad.274.2024.11.15.03.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:45:42 -0800 (PST)
Date: Fri, 15 Nov 2024 17:15:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] arm64: dts: qcom: qcs6490-rb3gen2: Add node for
 qps615
Message-ID: <20241115114533.vilxuszzmqg4vrko@thinkpad>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-2-29a1e98aa2b0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112-qps615_pwr-v3-2-29a1e98aa2b0@quicinc.com>

On Tue, Nov 12, 2024 at 08:31:34PM +0530, Krishna chaitanya chundru wrote:
> Add QPS615 PCIe switch node which has 3 downstream ports and in one
> downstream port two embedded ethernet devices are present.
> 
> Power to the QPS615 is supplied through two LDO regulators, controlled
> by two GPIOs, these are added as fixed regulators. And the QPS615 is
> configured through i2c.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One comment below.

> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 115 +++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
>  2 files changed, 116 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 0d45662b8028..0e890841b600 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -202,6 +202,30 @@ vph_pwr: vph-pwr-regulator {
>  		regulator-min-microvolt = <3700000>;
>  		regulator-max-microvolt = <3700000>;
>  	};
> +
> +	vdd_ntn_0p9: regulator-vdd-ntn-0p9 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDD_NTN_0P9";
> +		gpio = <&pm8350c_gpios 2 GPIO_ACTIVE_HIGH>;
> +		regulator-min-microvolt = <899400>;
> +		regulator-max-microvolt = <899400>;
> +		enable-active-high;
> +		pinctrl-0 = <&ntn_0p9_en>;
> +		pinctrl-names = "default";
> +		regulator-enable-ramp-delay = <4300>;
> +	};
> +
> +	vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDD_NTN_1P8";
> +		gpio = <&pm8350c_gpios 3 GPIO_ACTIVE_HIGH>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		enable-active-high;
> +		pinctrl-0 = <&ntn_1p8_en>;
> +		pinctrl-names = "default";
> +		regulator-enable-ramp-delay = <10000>;
> +	};
>  };
>  
>  &apps_rsc {
> @@ -684,6 +708,75 @@ &mdss_edp_phy {
>  	status = "okay";
>  };
>  
> +&pcie1_port {
> +	pcie@0,0 {
> +		compatible = "pci1179,0623";
> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +
> +		device_type = "pci";
> +		ranges;
> +		bus-range = <0x2 0xff>;
> +
> +		vddc-supply = <&vdd_ntn_0p9>;
> +		vdd18-supply = <&vdd_ntn_1p8>;
> +		vdd09-supply = <&vdd_ntn_0p9>;
> +		vddio1-supply = <&vdd_ntn_1p8>;
> +		vddio2-supply = <&vdd_ntn_1p8>;
> +		vddio18-supply = <&vdd_ntn_1p8>;
> +
> +		i2c-parent = <&i2c0 0x77>;
> +
> +		reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
> +
> +		pcie@1,0 {
> +			reg = <0x20800 0x0 0x0 0x0 0x0>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			device_type = "pci";
> +			ranges;
> +			bus-range = <0x3 0xff>;
> +		};
> +
> +		pcie@2,0 {
> +			reg = <0x21000 0x0 0x0 0x0 0x0>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			device_type = "pci";
> +			ranges;
> +			bus-range = <0x4 0xff>;
> +		};
> +
> +		pcie@3,0 {
> +			reg = <0x21800 0x0 0x0 0x0 0x0>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			ranges;
> +			bus-range = <0x5 0xff>;
> +

You haven't added any additional properties (dfe etc...) to any of the
downstream port nodes. Does this mean that this board doesn't need any of them?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

