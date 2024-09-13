Return-Path: <linux-kernel+bounces-328316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D20EC9781FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3FE1F21356
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85A81DCB11;
	Fri, 13 Sep 2024 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxCR1lZn"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1F1DC759
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235841; cv=none; b=gCA8+gQKEKtCYyXGFxIWI5wuP8IPXgtEuxWRQBSWUwtB8CE0qrnOC+7O4yPPjFoguSnqrB6z5otkmW/YoyjBM593VAybehEz+VHe/m9rqq+pd70fmCL+kHMPXihsy1oYhXJsKVS9J6SsRI4rH5B6exbwu25WVRd1AvEtXGDpCRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235841; c=relaxed/simple;
	bh=nygQcvBgkEXlQczrMZaRkwU7DMO4Sgzp88nUG5kKe5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSqSa+kUwg7M0MGEp/qaE38jHbbK634ZGAa6fNeVpPiFc8UKBAGJy3YdfY9iPzby4x4AdCaLMYd4F+kCetNU1529p5FVX6hJsQKnT0qelcjtQ9yoW38NB/vu3tACCrjl/3aPnFGtfbkt2OZ/xZkzH6wZNr7RXE28Od3Q6weAikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mxCR1lZn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2053616fa36so25368385ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726235839; x=1726840639; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j4zVOa+rsJLoaZtlg7qNm3b8vXOuxAqtzpJMF/Jo70g=;
        b=mxCR1lZnLia7tXuzndmEmU9G/PqZ3bWM7olWjHgy68VKbkcAa7fFyPgiXkmK3EyeN1
         I0O6lqAiVB0zxCBLs/U1Yf+0aQ/cRjO+qwDx6rsL6SkJe2QFVETz9C/bd1a3lgkX+8bi
         tAzvU/Gzv5xXBDYC/V0Vpp6f8SR5L6e+MKOQm/vjKi4olziVi+iXMsbaRu556EAH+6rq
         9q5YPGCdyYxbZOxMci57owTtPivKZTEOUZp0dVTPWbtXZXd4WhGQpP8o8Dgkzrjj05Pd
         Z5CwhDH2/+S6mDMlyiDOVojhLse+vhGlMxKWnVsxc+QF16rZTx4sSoyDkLQ/nXQMrKRf
         RpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726235839; x=1726840639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4zVOa+rsJLoaZtlg7qNm3b8vXOuxAqtzpJMF/Jo70g=;
        b=Q4bTvPZjDqthIL0VyUzBgpStCAvBplCQQzojw6VVS/z7EgKJOEdsLopkia4gUP5Ae6
         NZl1je5B3ySDDwQakPC3RxjsIO2/l3pm2SJdIuWp2kONBam6dltTYA+kCsmZfU+sfrnZ
         xpzMTMpoTC1NX2Ta+ISZQWF+Hyh2uBYrqvAX0K0Sw2760NXNuu8ljkgbcKSKFK3f23PU
         3MorScs+jNuq5tQeUokqLBXduhOVIyUqez4eZ3XLB2KWPI93AqKqTay1bLp9SI0H02Im
         TPNwEw4FKO0890vQU9d7ifovZkfPS8QFOCW0ed1SvGUqX/trlD2xPK8OJzcH8KoxbdJ1
         1wew==
X-Forwarded-Encrypted: i=1; AJvYcCXpGzgXOSzTKsAkPd9hWX7LYhTBkbFIWj1Q9DM3l6BUaS3ydhilu4I4AYTosaw+pvAdvFfWi57dTN1QsyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2M6eAAfH/8AUCzzQcWqk6hJ+8BTE8HFeop3kiFBKEGJZe01JR
	obGw/CdHRd7BrTF2bDY9BhT6N/n3e++XC60lu76DSWJUeDQypestXmxbWqmR9Q==
X-Google-Smtp-Source: AGHT+IF/dhpwnwCRU/9Bk+v+2G3zbmxcvhusIOoU80hBY2klO7C51mKtJhG7H4NPXx22niLc5+SxxA==
X-Received: by 2002:a17:902:f785:b0:205:7863:2dec with SMTP id d9443c01a7336-2076e3698edmr95862965ad.27.1726235838719;
        Fri, 13 Sep 2024 06:57:18 -0700 (PDT)
Received: from thinkpad ([120.60.66.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af4739asm28455325ad.66.2024.09.13.06.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:57:18 -0700 (PDT)
Date: Fri, 13 Sep 2024 19:27:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
Message-ID: <20240913135710.6ionsmzo45orin6n@thinkpad>
References: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
 <20240913083724.1217691-6-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240913083724.1217691-6-quic_qianyu@quicinc.com>

On Fri, Sep 13, 2024 at 01:37:24AM -0700, Qiang Yu wrote:
> Describe PCIe3 controller and PHY. Also add required system resources like
> regulators, clocks, interrupts and registers configuration for PCIe3.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 202 ++++++++++++++++++++++++-
>  1 file changed, 201 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index a36076e3c56b..a7703e4974a6 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -744,7 +744,7 @@ gcc: clock-controller@100000 {
>  
>  			clocks = <&bi_tcxo_div2>,
>  				 <&sleep_clk>,
> -				 <0>,
> +				 <&pcie3_phy>,
>  				 <&pcie4_phy>,
>  				 <&pcie5_phy>,
>  				 <&pcie6a_phy>,
> @@ -2907,6 +2907,206 @@ mmss_noc: interconnect@1780000 {
>  			#interconnect-cells = <2>;
>  		};
>  
> +		pcie3: pci@1bd0000 {

pcie@

> +			device_type = "pci";
> +			compatible = "qcom,pcie-x1e80100";
> +			reg = <0 0x01bd0000 0 0x3000>,
> +			      <0 0x78000000 0 0xf1d>,

0x0 here and below.

> +			      <0 0x78000f40 0 0xa8>,
> +			      <0 0x78001000 0 0x1000>,
> +			      <0 0x78100000 0 0x100000>,
> +			      <0 0x01bd3000 0 0x1000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "config",
> +				    "mhi";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x78200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x78300000 0x0 0x78300000 0x0 0x3d00000>,
> +				 <0x03000000 0x7 0x40000000 0x7 0x40000000 0x0 0x40000000>;
> +			bus-range = <0x00 0xff>;
> +
> +			dma-coherent;
> +
> +			linux,pci-domain = <3>;
> +			num-lanes = <8>;
> +
> +			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 671 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0",
> +					  "msi1",
> +					  "msi2",
> +					  "msi3",
> +					  "msi4",
> +					  "msi5",
> +					  "msi6",
> +					  "msi7";

Can you add 'global' interrupt as well? While doing so, please make sure the
global_irq related patches are applied and Link up works fine. Those patches are
already in linux-next.

> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 0 220 IRQ_TYPE_LEVEL_HIGH>,

Use GIC_SPI for the parent interrupt specifier.

- Mani

> +					<0 0 0 2 &intc 0 0 0 221 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 0 237 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 0 238 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE_3_AUX_CLK>,
> +				 <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_3_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_3_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_3_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_CFG_NOC_PCIE_ANOC_NORTH_AHB_CLK>,
> +				 <&gcc GCC_CNOC_PCIE_NORTH_SF_AXI_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "noc_aggr",
> +				      "cnoc_sf_axi";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_3_AUX_CLK>;
> +			assigned-clock-rates = <19200000>;
> +
> +			interconnects = <&pcie_south_anoc MASTER_PCIE_3 QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> +					 &cnoc_main SLAVE_PCIE_3 QCOM_ICC_TAG_ALWAYS>;
> +			interconnect-names = "pcie-mem",
> +					     "cpu-pcie";
> +
> +			resets = <&gcc GCC_PCIE_3_BCR>,
> +				 <&gcc GCC_PCIE_3_LINK_DOWN_BCR>;
> +			reset-names = "pci",
> +				      "link_down";
> +
> +			power-domains = <&gcc GCC_PCIE_3_GDSC>;
> +
> +			phys = <&pcie3_phy>;
> +			phy-names = "pciephy";
> +
> +			operating-points-v2 = <&pcie3_opp_table>;
> +
> +			status = "disabled";
> +
> +			pcie3_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				/* GEN 1 x1 */
> +				opp-2500000 {
> +					opp-hz = /bits/ 64 <2500000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <250000 1>;
> +				};
> +
> +				/* GEN 1 x2 and GEN 2 x1 */
> +				opp-5000000 {
> +					opp-hz = /bits/ 64 <5000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <500000 1>;
> +				};
> +
> +				/* GEN 1 x4 and GEN 2 x2 */
> +				opp-10000000 {
> +					opp-hz = /bits/ 64 <10000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <1000000 1>;
> +				};
> +
> +				/* GEN 1 x8 and GEN 2 x4 */
> +				opp-20000000 {
> +					opp-hz = /bits/ 64 <20000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <2000000 1>;
> +				};
> +
> +				/* GEN 2 x8 */
> +				opp-40000000 {
> +					opp-hz = /bits/ 64 <40000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <4000000 1>;
> +				};
> +
> +				/* GEN 3 x1 */
> +				opp-8000000 {
> +					opp-hz = /bits/ 64 <8000000>;
> +					required-opps = <&rpmhpd_opp_svs>;
> +					opp-peak-kBps = <984500 1>;
> +				};
> +
> +				/* GEN 3 x2 and GEN 4 x1 */
> +				opp-16000000 {
> +					opp-hz = /bits/ 64 <16000000>;
> +					required-opps = <&rpmhpd_opp_svs>;
> +					opp-peak-kBps = <1969000 1>;
> +				};
> +
> +				/* GEN 3 x4 and GEN 4 x2 */
> +				opp-32000000 {
> +					opp-hz = /bits/ 64 <32000000>;
> +					required-opps = <&rpmhpd_opp_svs>;
> +					opp-peak-kBps = <3938000 1>;
> +				};
> +
> +				/* GEN 3 x8 and GEN 4 x4 */
> +				opp-64000000 {
> +					opp-hz = /bits/ 64 <64000000>;
> +					required-opps = <&rpmhpd_opp_svs>;
> +					opp-peak-kBps = <7876000 1>;
> +				};
> +
> +				/* GEN 4 x8 */
> +				opp-128000000 {
> +					opp-hz = /bits/ 64 <128000000>;
> +					required-opps = <&rpmhpd_opp_svs>;
> +					opp-peak-kBps = <15753000 1>;
> +				};
> +			};
> +		};
> +
> +		pcie3_phy: phy@1be0000 {
> +			compatible = "qcom,x1e80100-qmp-gen4x8-pcie-phy";
> +			reg = <0 0x01be0000 0 0x10000>;
> +
> +			clocks = <&gcc GCC_PCIE_3_PHY_AUX_CLK>,
> +				 <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
> +				 <&tcsr TCSR_PCIE_8L_CLKREF_EN>,
> +				 <&gcc GCC_PCIE_3_PHY_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE_3_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_3_PIPEDIV2_CLK>;
> +			clock-names = "aux",
> +				      "cfg_ahb",
> +				      "ref",
> +				      "rchng",
> +				      "pipe",
> +				      "pipediv2";
> +
> +			resets = <&gcc GCC_PCIE_3_PHY_BCR>,
> +				 <&gcc GCC_PCIE_3_NOCSR_COM_PHY_BCR>;
> +			reset-names = "phy",
> +				      "phy_nocsr";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_3_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			power-domains = <&gcc GCC_PCIE_3_PHY_GDSC>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "pcie3_pipe_clk";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>  		pcie6a: pci@1bf8000 {
>  			device_type = "pci";
>  			compatible = "qcom,pcie-x1e80100";
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

