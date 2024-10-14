Return-Path: <linux-kernel+bounces-363833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A3699C7A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC3A1F234CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E17198A1B;
	Mon, 14 Oct 2024 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBxfvzbk"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED93197A8A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903204; cv=none; b=Et7Fzj7V1VLoY66tXF0mPAz7/gTJjDAEXO3usMTpsN23fVcq5gcoKqhTFFN4NnekY+nPTDM+KKzBzdBqZ/t7StHPMyNu1oMkKNStDJEg7DqQgtam2752rviHUUtCvZI4ys25T1y97VnNqMDscPQCzYowqa6Kb/fr2uivKhdpEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903204; c=relaxed/simple;
	bh=/KGp5WuGSXhihS3RY1/q53r1ThRuulY3gLXEy1o8qG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mISCrrji4BbS5t68yDX/E+tpek0SnhtDVfqivSq3LlSAUy30iChH4AnaEtmpKcALImI94Ic0TcEQDZ3XnvaY17YaOynPweFIspVeKDIpjkYOeE5EySAJzfCE3RQJDaTkw2HnEeQOPU2MK/i+P5tl7iRmLOGOqCTozrgApbmFXPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EBxfvzbk; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so1053165e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 03:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728903201; x=1729508001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ah5JGFfL/8Mq6gAERSVClFvpHHmSV8n4jJgFntOA3BQ=;
        b=EBxfvzbk8jJMVFIZULR/qUDL8U8840lp3UkPAxRqjiSi+DxfAFLiakXs3wIbe4dTet
         AQ5nHofAavSAa9Zm3qHyC7vEK/SPdhoW6AtmTH5nsLTIPiAzGxvjVe304uoQ1IYdMRj8
         1oWB2clJ7S9p+3Er5Z1A79UDu9bPS9ZWLxljk4+09OAoAaKz27W6rDqoPiLD5xEfGDUW
         uxPUH91pZEHeqtzIL/VWnwus3eDQnlR+VfLe4V4uskwG16uQne1uokUzJkWxDHd2aezK
         eRoNrHx28KykSeAWfIhZhxxde67hcbB9C+q+ahXy+VrN//sJrIENBEzxusmgeL/CAZdX
         g8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728903201; x=1729508001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah5JGFfL/8Mq6gAERSVClFvpHHmSV8n4jJgFntOA3BQ=;
        b=AFf59/blP9KBd+j9bi3Ohq+Ecs7s8SHKBu7WjTNkKvwC7EKx1K6nhby95GCmjLbS6z
         HU5L6UggfXQASoU6zRbssAGprLlYDHC9ByECWKfrUnyBHlIjzYDbOc4nOi9fZUSyEqjW
         f4KMokkbdwYDiky3lPDKrPzooss2LqcsAYcs3oHAwpU3/2mcQSVR0wP5MgBjvlOqLvcT
         E5KwOccaTf7zrEaQmDcEtWtq9M5r6dfMF5ai3DOjij+z2Vnqxup/q8aqDsDawzLh8N9O
         kIbM73AhT0jhkpAAfILxKeD7MUOC2Ta2EOsFLXkHeYWPMxgIGWH4UMUghRnT9sI+N9e3
         QbQg==
X-Forwarded-Encrypted: i=1; AJvYcCXY/FGSleemDCidicEsafwsWNtUJlIXEodEF0ypAAgXnNaO6ac6zMyONlD+nDcE3J18nJwQWos2EB6qxpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhwuESLgJXLtYegncpxpJ/hCaD8KcbPvfnDCvfTPxP1QBfvVk4
	F+up4USOm1A4ZhmNF3ROn0auqji6QtWV4H3qhu3BO9VOGV4vUpL53urSaFXu02w=
X-Google-Smtp-Source: AGHT+IFep1paR5SY6fJ7hoGsnnGto4tCheuYeA9MEBZ7X7nWx1/q5Reitn/7OecRY64RMXyPNc39vQ==
X-Received: by 2002:a05:6512:b1e:b0:539:f1ce:5fa8 with SMTP id 2adb3069b0e04-539f1ce62dbmr1332766e87.49.1728903201160;
        Mon, 14 Oct 2024 03:53:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539eb9ec836sm683013e87.144.2024.10.14.03.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 03:53:20 -0700 (PDT)
Date: Mon, 14 Oct 2024 13:53:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: quic_fenglinw@quicinc.com, quic_tingweiz@quicinc.com, 
	kernel@quicinc.com, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs615: Adds SPMI bus, PMIC and
 peripherals
Message-ID: <p7fw7jjfawbnk2vb7zdtr2dp3ni4g2uuiwvt6o4qva53zyrpvd@kokibgaidfzb>
References: <20241014-adds-spmi-pmic-peripherals-for-qcs615-v1-1-8a3c67d894d8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014-adds-spmi-pmic-peripherals-for-qcs615-v1-1-8a3c67d894d8@quicinc.com>

On Mon, Oct 14, 2024 at 06:08:17PM +0800, Tingguo Cheng wrote:
> Create a new file qcs615-pmic.dtsi to add on-board PMIC and peripher-
> als in the PMIC that controlled by SPMI bus. The peripherals include
> GPIO, RTC, PON, power key and resin-key for QCS615 platform. The power
> key and volume down key are controlled by PMIC PON hardware on QCS615.

Why do you need a separate file? Unless there is a good reason such
configuration should be split between the pmic.dtsi and the board file.

BTW, what is the PMIC id for pmm6155au? Is it a real PMIC or a version
of some other PMIC?

> 
> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> ---
> This patch depends on the patch series:
> - https://lore.kernel.org/all/20240926-add_initial_support_for_qcs615-v3-0-e37617e91c62@quicinc.com/
> ---
>  arch/arm64/boot/dts/qcom/qcs615-pmic.dtsi | 56 +++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts  |  1 +
>  arch/arm64/boot/dts/qcom/qcs615.dtsi      | 23 +++++++++++++
>  3 files changed, 80 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615-pmic.dtsi b/arch/arm64/boot/dts/qcom/qcs615-pmic.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..d5e98503bb32aa6c75f9a9c613d562c6140ddf14
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs615-pmic.dtsi
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus {
> +	pmm6155au_0: pmic@0 {
> +		compatible = "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmm6155au_0_pon: pon@800 {
> +			compatible = "qcom,pm8998-pon";
> +			reg = <0x800>;
> +
> +			pon_pwrkey: pwrkey {
> +				compatible = "qcom,pm8941-pwrkey";
> +				interrupts = <0x0 0x8 0x0 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				linux,code = <KEY_POWER>;
> +			};
> +
> +			pon_resin: resin {
> +				compatible = "qcom,pm8941-resin";
> +				interrupts = <0x0 0x8 0x1 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				linux,code = <KEY_VOLUMEDOWN>;
> +			};
> +		};
> +
> +		pmm6155au_0_rtc: rtc@6100 {
> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6100>, <0x6200>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
> +			allow-set-time;
> +		};
> +
> +		pmm6155au_0_gpios: gpio@c000 {
> +			compatible = "qcom,pm8150-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			gpio-ranges = <&pmm6155au_0_gpios 0 0 12>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +};
> +
> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> index 4ef969a6af150933c72a7a83374a5a2657eebc1b..b79c22730920e3097425e1d1933e744205b3c18e 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> @@ -6,6 +6,7 @@
>  
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "qcs615.dtsi"
> +#include "qcs615-pmic.dtsi"
>  / {
>  	model = "Qualcomm Technologies, Inc. QCS615 Ride";
>  	compatible = "qcom,qcs615-ride", "qcom,qcs615";
> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> index ac4c4c751da1fbb28865877555ba317677bc6bd2..9793161db515a2ef1df6465c8d0a04a11e71ffc1 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> @@ -517,6 +517,29 @@ sram@c3f0000 {
>  			reg = <0x0 0x0c3f0000 0x0 0x400>;
>  		};
>  
> +		spmi_bus: qcom,spmi@c440000 {
> +			compatible = "qcom,spmi-pmic-arb";
> +			reg = <0x0 0xc440000 0x0 0x1100>,
> +			      <0x0 0xc600000 0x0 0x2000000>,
> +			      <0x0 0xe600000 0x0 0x100000>,
> +			      <0x0 0xe700000 0x0 0xa0000>,
> +			      <0x0 0xc40a000 0x0 0x26000>;
> +			reg-names = "core",
> +				    "chnls",
> +				    "obsrvr",
> +				    "intr",
> +				    "cnfg";
> +			interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "periph_irq";
> +			interrupt-controller;
> +			#interrupt-cells = <4>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			cell-index = <0>;
> +			qcom,channel = <0>;
> +			qcom,ee = <0>;
> +		};
> +
>  		intc: interrupt-controller@17a00000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
> 
> ---
> base-commit: c83f0b825741bcb9d8a7be67c63f6b9045d30f5a
> change-id: 20240929-adds-spmi-pmic-peripherals-for-qcs615-16ee53179a7d
> prerequisite-change-id: 20240924-add_initial_support_for_qcs615-a01bb2dd4650:v3
> prerequisite-patch-id: 09782474af7eecf1013425fd34f9d2f082fb3616
> prerequisite-patch-id: 624720e543d7857e46d3ee49b8cea413772deb4c
> prerequisite-patch-id: 04ca722967256efddc402b7bab94136a5174b0b9
> prerequisite-patch-id: ab88a42ec69ad90e8509c9c5b7c6bdd595a7f783
> prerequisite-patch-id: 918724fafe43acaa4c4b980bfabe36e9c3212cd1
> prerequisite-patch-id: 91cb230c6d129ff21c24d124fad9e37a66cb6a22
> prerequisite-patch-id: 57afeee80c9aa069ee243f5a5b634702867d20f1
> 
> Best regards,
> -- 
> Tingguo Cheng <quic_tingguoc@quicinc.com>
> 

-- 
With best wishes
Dmitry

