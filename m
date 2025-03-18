Return-Path: <linux-kernel+bounces-565501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC7EA669AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F0E3A8A69
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA581DDC21;
	Tue, 18 Mar 2025 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ttudHPqj"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694128373
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276539; cv=none; b=F843jhxj9yQcDaaCLpBKO7IXmPoTbLYT459wPie8v8SHg3saMHZcJdvq+l2pVxGmdPjLFmvr1kuZ8QffOBJE3+IyPP+/AsY+8ZEhvfOkHWAW3sT2Bzql+/4Io6wClQWvSdoZ3n8BZI7AiOevce7uSHIcsWLV+ImA8kQYMKVY8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276539; c=relaxed/simple;
	bh=hyjCGTvTiDH/w1f1bIytV/cQyTSpEfGDWorJN1GSlvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Izk1pABAI7TAySRZ9ihKcFggkOWAZCp8zX4igKrF/AKRdWjh+aHq5erQjOoTYojQsZw9n7teidANQ744RjjnvUYGekWF8hPeXmh7FVT2bAuiK/ltwSUiU5Gz4TDjmN/xavxs7Lg/e04G8AdKwiqpODxW/KTQ6UNa7JJ+3vrczRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ttudHPqj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2241053582dso48359255ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742276534; x=1742881334; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6uTdlYTFmX0lcTy7/Wc30lbOKxSruoFsMBQRPIOcNoU=;
        b=ttudHPqjK1dAygDgKeBxGfLLvzatt73U3Ml8/HrC/IP320sp6kU25+kIWn3r08CeKB
         ouqJU+FrbMTUUD+WRCnj5ocBoCIanam+pUrrWt5qZDAMzlxb34dbyBkqrk2hSCcohqOu
         vtcfH3l29TDitnCkKfD/gTorAfq9fUJrGIMUpdmUXqQgP6MfQagbfSzOM4zAff73vBPb
         eYa3nc/WG5g18B08b+a7Ylv+i/uNMWQSUaOQx7PBtn5QsRLkYZ/L1maj+KnfN9E9GyLz
         tmc+PXowcyndgEgM6XX4/ED1WbBz4nefx8dMbAtPIP1aBd/JaYmw8a3+0J6PQMBzhNLv
         /lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742276534; x=1742881334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uTdlYTFmX0lcTy7/Wc30lbOKxSruoFsMBQRPIOcNoU=;
        b=Wib/IipUpm8ei72kQsa54elFPytuPjlm2fsBqHmfAUIiimUnbJevhYnyY824DODxRl
         hOjXXLqkwmqj61f9q2UZKWGFtYhw10yO6JCvSJZmKxuMC0Gov7mBrHsBrK3msyQe8Muc
         3j+orrODF7z2+pBovVoyF7V73HN+wKcF4Fq0WfpWO2J+ohfBb0KBe8xRfrPqyE2v+n4x
         fKHAKU55A6YwPwi6KnsYMAsWoyqNNF6ZdSsVleVE2NTrUrbV6Rfol/ZLs5D7tOr8lbAf
         ccPQYArKKM+DnXTWDi+GBuGqB1DBV6kNZKTvXxbhJAHNa1HxMgIBDJgC8j02oRgWtl1y
         73UA==
X-Forwarded-Encrypted: i=1; AJvYcCUG0P2ZT1p8Q8EKzkyeZiuMjaGiAttiQwV2I9QDjqDMqp7GxYYJyl5F8qhi30oEAoM9KTDinZ30TD5m1DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIavmgqqXeKsCsKk2z7G/JnYl8XplSfbvEiOd+DnAL3AImz+Yi
	1P8IefHCVc7I0uGISYcwxNWgUGeI5U/3YgxvIkm/y+VySFTF6DRDC9q2OUal9w==
X-Gm-Gg: ASbGnctUF7oZal38vxC52SvaNfwEZVNYSg5ZnMwltOuiEWlzFpa3NYPzqw038sjZwjp
	CbRG93E3GdNjdy0cnNmhLNZvCJs2Oi9KlyYWBNh6HnQ1llkwnCdiW569CA9XPA2+9suEoq0lG5n
	Z9nEHdjJVJtPxpdfI/c/pS26hi45cV+67vMUSC3EN4vYH2FUFLDxaPILS+TW3lU3e+3fzGZa2cw
	ktKDyQ3t9CYkL0axcRp8y/w7oJt67GEfJx226CsQZij9B85ei+l8yJ2Wx+6IbylkkJHV0en9/ao
	wEOSTo5JmI/Lhy5Po6IaM4rfTQUNlHLkU5J0Z9UzUtr4ZKL2KOlvn3kw
X-Google-Smtp-Source: AGHT+IFOH6UBcZLNFyKi3R0DYxxlEzwZKcLhc9kucytFBc8bEghyTXV17BElYA2xigUTl+vXY+lgbw==
X-Received: by 2002:a17:902:ea06:b0:21f:f3d:d533 with SMTP id d9443c01a7336-225e0a62cb3mr182056615ad.2.1742276534533;
        Mon, 17 Mar 2025 22:42:14 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688846csm85669065ad.33.2025.03.17.22.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 22:42:14 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:12:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org, abel.vesa@linaro.org,
	quic_qianyu@quicinc.com, quic_krichai@quicinc.com,
	johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 7/8] arm64: dts: qcom: qcs8300: enable pcie1
Message-ID: <20250318054207.baemwcyu43c54cbq@thinkpad>
References: <20250310063103.3924525-1-quic_ziyuzhan@quicinc.com>
 <20250310063103.3924525-8-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310063103.3924525-8-quic_ziyuzhan@quicinc.com>

On Mon, Mar 10, 2025 at 02:31:02PM +0800, Ziyue Zhang wrote:
> Add configurations in devicetree for PCIe1, including registers, clocks,
> interrupts and phy setting sequence.
> 
> Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 121 +++++++++++++++++++++++++-
>  1 file changed, 120 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> index 5d05640c5e21..c026b7e63eae 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> @@ -602,7 +602,7 @@ gcc: clock-controller@100000 {
>  			clocks = <&rpmhcc RPMH_CXO_CLK>,
>  				 <&sleep_clk>,
>  				 <&pcie0_phy>,
> -				 <0>,
> +				 <&pcie1_phy>,
>  				 <0>,
>  				 <0>,
>  				 <0>,
> @@ -877,6 +877,125 @@ pcie0_phy: phy@1c04000 {
>  			status = "disabled";
>  		};
>  
> +		pcie1: pci@1c10000 {
> +			device_type = "pci";
> +			compatible = "qcom,pcie-qcs8300", "qcom,pcie-sa8775p";
> +			reg = <0x0 0x01c10000 0x0 0x3000>,
> +			      <0x0 0x60000000 0x0 0xf20>,
> +			      <0x0 0x60000f20 0x0 0xa8>,
> +			      <0x0 0x60001000 0x0 0x4000>,
> +			      <0x0 0x60100000 0x0 0x100000>,
> +			      <0x0 0x01c13000 0x0 0x1000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "config",
> +				    "mhi";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x1fd00000>;
> +			bus-range = <0x00 0xff>;
> +
> +			dma-coherent;
> +
> +			linux,pci-domain = <1>;
> +			num-lanes = <4>;
> +
> +			interrupts = <GIC_SPI 519 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 518 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0",
> +					  "msi1",
> +					  "msi2",
> +					  "msi3",
> +					  "msi4",
> +					  "msi5",
> +					  "msi6",
> +					  "msi7",
> +					  "global";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
> +				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
> +			assigned-clock-rates = <19200000>;
> +
> +			interconnects = <&pcie_anoc MASTER_PCIE_1 QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &config_noc SLAVE_PCIE_1 QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";
> +
> +			iommu-map = <0x0 &pcie_smmu 0x0080 0x1>,
> +				    <0x100 &pcie_smmu 0x0081 0x1>;
> +
> +			resets = <&gcc GCC_PCIE_1_BCR>,
> +				 <&gcc GCC_PCIE_1_LINK_DOWN_BCR>;
> +			reset-names = "pci",
> +				      "link_down";
> +
> +			power-domains = <&gcc GCC_PCIE_1_GDSC>;
> +
> +			phys = <&pcie1_phy>;
> +			phy-names = "pciephy";
> +
> +			status = "disabled";
> +		};
> +
> +		pcie1_phy: phy@1c14000 {
> +			compatible = "qcom,sa8775p-qmp-gen4x4-pcie-phy";
> +			reg = <0x0 0x01c14000 0x0 0x4000>;
> +
> +			clocks = <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_CLKREF_EN>,
> +				 <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE_1_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_1_PIPEDIV2_CLK>,
> +				 <&gcc GCC_PCIE_1_PHY_AUX_CLK>;
> +			clock-names = "cfg_ahb",
> +				      "ref",
> +				      "rchng",
> +				      "pipe",
> +				      "pipediv2",
> +				      "phy_aux";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			resets = <&gcc GCC_PCIE_1_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "pcie_1_pipe_clk";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>  		ufs_mem_hc: ufs@1d84000 {
>  			compatible = "qcom,qcs8300-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
>  			reg = <0x0 0x01d84000 0x0 0x3000>;
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

