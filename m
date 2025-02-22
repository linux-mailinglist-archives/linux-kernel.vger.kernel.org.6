Return-Path: <linux-kernel+bounces-527367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA777A40A5D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620FC3AE1E6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E323213C81B;
	Sat, 22 Feb 2025 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UyyOOHxz"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FD33224
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740243227; cv=none; b=lKrl7Ynu9jgkUCkNwJyKGIkCxJCSRwo9fJLyZjlKLY8RVyhpUeYRV8q+jcRmKBkVkdF7Le1KJiAgDyXLLwi0lLj+FSwAsGnejrnhUiMLSn4F52oDgMB9jBcAk/nDAIL95tuF6jJ2xIzY14oUBByp/abdvxTjjO3ymDBqkpludwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740243227; c=relaxed/simple;
	bh=oBv+tlg9GiYsoONeeRdW7AslFMIO5QJEVmpgDjwJmc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dA45C8t3FIGrm5IcXbXYu3VZAYSHbaexbMLdoObG+OCYhK/z8feTqpHIT27G3L6PnA9tCxtu6jg/CEMH79wksL6dC3TRQCtbdWsXCcK5HOJlR2pF8af8/NRE7kYt6PtNklV+9nK7IZ5zL78Cw4Jljv2Upo+2LWF1opVWgE3BqQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UyyOOHxz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220d28c215eso48083845ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 08:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740243225; x=1740848025; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ivNrLGUA+/d37ElkamWeFCb8ka1YsgzGOwciXXog6g=;
        b=UyyOOHxz3PA+F2yMtF5ehomgFVZVva5SWra1KnHuI+pzH2HaOwjWAjMyaQluWSvP43
         /kbxb3xTZWaaIh+tFZnjj0vQfHTCgDY8Co+gXcky4H7jiNvIKJW53gXku+i3Bd9MPYv7
         3WpueyvIggC9y4g+LPHPjNVbC9BxqSlJZgBAn5RbtI0JBqH7fT3x5qLUNBWGgNbWTW5w
         J0nrE0u7NYInfcy5bRzTiEI0krtD9hVzQ67AD//JQqFOaiICARfTnxwaOQO8+mJQvadB
         kGUDBtZjvFXy9GKBFMyust7Iv8/n9gqqB3LOOhamFb7dzV/19Yw8ZvGjGQSXNDMkRvbJ
         gxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740243225; x=1740848025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ivNrLGUA+/d37ElkamWeFCb8ka1YsgzGOwciXXog6g=;
        b=okVgF7o+07VZq7ofXqbDDlfEY8EaU44+a2Q6/nAcwI8ZLmMhKJMKq4xmZ9sKsl/By/
         396o9HLg/mnZUdLQyHKBh6tjSr1CGxE0EksmEW0UXbM3Jc75G3sCuXck7anUxGIzDgvE
         UkqSfYOJQCA0jA0IetBZOWF6v7jvzDj7Q/nolqGKmdnKqEvM52Q7wUKNa3bkb5nXrnP4
         xyYWBq6jtPBb/JZoqBmpKKhxeKpyFeea/J5zHVlGwlmYhuS7MOy5OwlqXRBf8V2/9gsx
         cvs6aBttAva8JZcjd7XlfGZDw+bNGLs91+BoGDUzCrwvgwM8LYXbsIaqDkAsh+5zn3XH
         CulQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpSfFQfJ7nH/7aCuAiS1dYj/RXN/ofkHQSzUZ0ncPAACx6mwAFP0GtHQyJsBZNAhgm3ej+OUpQmiWR/yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSr2380/cJ0gNHjvOUm2ucwjSOVc6DROAnIS81LveJHcf6qRlG
	FkD8sFzl3GelI9vdSxhvAelNmxuRES6u3JcPp1Bd9UA/9MXvA1DIpsmPwAV1uQ==
X-Gm-Gg: ASbGncu2q/HLnUG4wSskorcGv06JhRA7Ls4Ea9YKShnYG2IKwNd7I4EquluZ7VbzBkg
	0tNzuroFqR9jEPUs7rdBOiunxuPnoeOW4z3TrekOYzF/nxSksYSda9qYOCrYbgOZsbJykQ+f53b
	rTFnihzMyTz8Cp0n46jUWcZ8O71AfUiLVxCvpjeQKkQcmqQqTNJTId/truROyFDuJ5TuGtbHcRx
	rEtYzDELiGb785UDTv9nVqNvX353nQ8w6Udk2fPklLOUw+mtrOi11jsz3F4YYDhTCVJNJKl3te7
	G66ua0g1252GZ8r0bBgVQjnYuST8Kcoyijf+dw==
X-Google-Smtp-Source: AGHT+IE7FLZPo+Ma+N1F3NmGoxoA/bCHud1Y21Z8/QxeoATe5u21D1vdPBAkZwGc/+Tc08xFw55W9g==
X-Received: by 2002:a17:903:41c8:b0:21c:fb6:7c3c with SMTP id d9443c01a7336-2219ff56500mr123579655ad.17.1740243224960;
        Sat, 22 Feb 2025 08:53:44 -0800 (PST)
Received: from thinkpad ([120.60.135.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d6d2sm151661135ad.177.2025.02.22.08.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 08:53:44 -0800 (PST)
Date: Sat, 22 Feb 2025 22:23:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] arm64: dts: qcom: sm8450: add PCIe EP device nodes
Message-ID: <20250222165338.oox3d63ven2kokez@thinkpad>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
 <20250221-sar2130p-pci-v3-8-61a0fdfb75b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221-sar2130p-pci-v3-8-61a0fdfb75b4@linaro.org>

On Fri, Feb 21, 2025 at 05:52:06PM +0200, Dmitry Baryshkov wrote:
> On the Qualcomm SM8450 platform the second PCIe host can be used
> either as an RC or as an EP device. Add device node for the PCIe EP.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 62 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 9c809fc5fa45a98ff5441a0b6809931588897243..3783930d63a73158addc44d00d9da2efa0986a25 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2262,6 +2262,68 @@ pcie@0 {
>  			};
>  		};
>  
> +		pcie1_ep: pcie-ep@1c08000 {
> +			compatible = "qcom,sm8450-pcie-ep";
> +			reg = <0x0 0x01c08000 0x0 0x3000>,
> +			      <0x0 0x40000000 0x0 0xf1d>,
> +			      <0x0 0x40000f20 0x0 0xa8>,
> +			      <0x0 0x40001000 0x0 0x1000>,
> +			      <0x0 0x40200000 0x0 0x1000000>,
> +			      <0x0 0x01c0b000 0x0 0x1000>,
> +			      <0x0 0x40002000 0x0 0x1000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "addr_space",
> +				    "mmio",
> +				    "dma";
> +
> +			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
> +				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "ref",
> +				      "ddrss_sf_tbu",
> +				      "aggre_noc_axi";
> +
> +			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "global",
> +					  "doorbell",
> +					  "dma";
> +
> +			interconnects = <&pcie_noc MASTER_PCIE_1 QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &config_noc SLAVE_PCIE_1 QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			interconnect-names = "pcie-mem",
> +					     "cpu-pcie";
> +
> +			iommus = <&apps_smmu 0x1c80 0x7f>;
> +			resets = <&gcc GCC_PCIE_1_BCR>;
> +			reset-names = "core";
> +			power-domains = <&gcc PCIE_1_GDSC>;
> +			phys = <&pcie1_phy>;
> +			phy-names = "pciephy";
> +			num-lanes = <2>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pcie1_default_state>;
> +
> +			status = "disabled";
> +		};
> +
>  		pcie1_phy: phy@1c0e000 {
>  			compatible = "qcom,sm8450-qmp-gen4x2-pcie-phy";
>  			reg = <0 0x01c0e000 0 0x2000>;
> 
> -- 
> 2.39.5
> 

-- 
மணிவண்ணன் சதாசிவம்

