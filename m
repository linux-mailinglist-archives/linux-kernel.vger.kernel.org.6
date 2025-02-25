Return-Path: <linux-kernel+bounces-531263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 646B8A43E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B521896BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF26267F50;
	Tue, 25 Feb 2025 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImpAUPrm"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6455267F4E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484174; cv=none; b=d1D34I+Frzz33zloLjNmB9RgvUQ6pBApOZqw44p+4yA+JCjqB4ZlhCGXcnMUA7zEZ3hJidyZmGpx++SWcD3AZnGveuBH2qnueApZqNUau/VSUUTY9x/usUPvnQpWeFvSjDqiDQuyZoHuLrSjVQDl/jZ16HbldyvGsOIh9xXQl8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484174; c=relaxed/simple;
	bh=5JyTXm1C7TLfUgdWh6JUEGg5OiPQQfcMcYocIRYLAuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLwDQD5OcIOgw6Br1bX0ieitXo5jCPr3vt51h+M8zGUjw2BGu7Q1ZG3OcV9aOjOkdIzWKPQeith9+PWlvRk6NajJTINnzQt6oUg5ewTYX2Fmm437PnmHw6jNbpe3ZbSALlUkmd7Crc1VWpaHrxL4exS1va9Wc+3UXlVNWMeeX8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ImpAUPrm; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54298ec925bso7774137e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740484171; x=1741088971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MRXJ0sgeLLR+ArObNCkDui7AFges8ho1M4llXnQe6m4=;
        b=ImpAUPrmsWUb1ne2XcVYI8rBDVEJb7qDjcbHHwrUMkUTNRKuQnlsk4ZNoIxDA0xO1o
         +7lWbHX+mdW/cvh0QILVapSB+U/ohTSpQN2duJg+WF6tcHTdCNXjkQxA2PM8T1kn7PFj
         rGoEkz64rzjJLpBGUqOFe78xKCpYz6znel/x5dg1Q3ZgKI6P39Vos/8gOZjueMm9zHVf
         nO70vueDz/1MPrpwdNQk0wkQdV7xPa8qzVTRYg71Nhq9IJhqRaB7IiFowsuVw7xBTD+Q
         DOAkJuBR5zYliSogJHK72wcToDGu6kztLqac8viideanAtSX4xiB+wjv/sa6ODLttaMd
         EW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484171; x=1741088971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRXJ0sgeLLR+ArObNCkDui7AFges8ho1M4llXnQe6m4=;
        b=nHX3yRW0IOuKHIQe7paCR6xeijqtGpmKjooCvzBUySEzhV4diJnpTnXOXvLDizfasA
         Xsb1B5RfyeTfVvlpZvK1dBxy5mH3GjTfAshxJOdTV0cBlrb/q3p6C6cyNPasSriyRQ8P
         xP3TK6ii9B2kXVypvJiV4WLt+TkhRNiG3qo07NDtwVfwGGIgKZ+rA66o+Lqig91OEvil
         bLhVckUTLkp5GXA1pVr8EeYzGzSGfR7m7XSo7RyWvTj4koJ6CrwCUYX0OtkqGTgBUKV2
         POm/9bQ29gp/4CsJST6zL6nLcDdyWoyzJU7ly5jXjKyOl5t+vRrbxW9HWGSQ+w9Ky1zD
         FwiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh1fhfgKnNzmtWrQxIBQ/eRJN5p6ceKT1kkYHA6OWqYk3GxXijgZbY5BRQPjgi+JDsyIGJ93j0U9N33ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1kY8XD8Il6ea4BqXH8JE9GcIbbqIAzKW0beerMqxx1MK52Anb
	ldaVPuqQGUybFTs7ybC+6FPfjmYaYRFY8su2IoaEi62yfTtKyorzgwgiZ9XYgiE=
X-Gm-Gg: ASbGnctraWNoK8qIok9oOa4cdPtUualMbnOgOBXbjzmNBHXPvwsiaZtajOSEfnwn9VR
	ruP7dr/TmYQkhQ0yJY49eK7TRLpvvEbf02gttxLUt7CW9+0GCy8Q43u1fd0a+jvfOstLVMiO+F9
	I7Dgd7XB1xH4kNORkAZmpY7UmUA95NaWus8x11nUGIEVY9zmv0UjpYUpJO8a1tP1O7k5vqwEB7S
	AfAEHgdoBU1DB/iDOrxuNZ73c8fCVLVjA9Eg5qVol6AZ2OmZkLrnayQQic6M2RhNacLZ97YS3dp
	43dPT8pGF+VBq96MDn6uIXGVpcEiPlnUtYQdqEBU104PfoGyGMHFJKcxFLOyOwhFmsRbQK3iwX/
	F0h8RVA==
X-Google-Smtp-Source: AGHT+IFyPF+05j6PQr+C+0URjfCkkwkHxs7RWK4V64HpQyr1wOWt4SpVijtFSG3Diuo6wjyM5MQDBw==
X-Received: by 2002:a19:8c4e:0:b0:549:38eb:d68b with SMTP id 2adb3069b0e04-54938ebdad6mr193636e87.33.1740484170953;
        Tue, 25 Feb 2025 03:49:30 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b97a9sm155591e87.70.2025.02.25.03.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:49:30 -0800 (PST)
Date: Tue, 25 Feb 2025 13:49:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	chaitanya chundru <quic_krichai@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com, 
	amitk@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com
Subject: Re: [PATCH v4 02/10] arm64: dts: qcom: qcs6490-rb3gen2: Add TC956x
 PCIe switch node
Message-ID: <ciqgmfi4wkvqpvaf4zsqn3k2nrllsaglbx7ve3g2nbecoj35d6@okgcsvfx27z5>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>

On Tue, Feb 25, 2025 at 03:03:59PM +0530, Krishna Chaitanya Chundru wrote:
> Add a node for the TC956x PCIe switch, which has three downstream ports.
> Two embedded Ethernet devices are present on one of the downstream ports.
> 
> Power to the TC956x is supplied through two LDO regulators, controlled by
> two GPIOs, which are added as fixed regulators. Configure the TC956x
> through I2C.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 116 +++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
>  2 files changed, 117 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 7a36c90ad4ec..13dbb24a3179 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -218,6 +218,31 @@ vph_pwr: vph-pwr-regulator {
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
> +
>  };
>  
>  &apps_rsc {
> @@ -735,6 +760,75 @@ &pcie1_phy {
>  	status = "okay";
>  };
>  
> +&pcie1_port {
> +	pcie@0,0 {
> +		compatible = "pci1179,0623", "pciclass,0604";
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

PCIe bus can be autodetected. Is there a reason for describing all the
ports and a full topology? If so, it should be stated in the commit
message.

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

-- 
With best wishes
Dmitry

