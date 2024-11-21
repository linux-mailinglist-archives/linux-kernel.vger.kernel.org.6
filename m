Return-Path: <linux-kernel+bounces-417246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6079D5130
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9BF1F250F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8231A2C0B;
	Thu, 21 Nov 2024 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L63LVHjP"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389FC13F43B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732208451; cv=none; b=TKniiOG5TSOvk0ZM3AeWlHRkr2I63hOqzFBSq7qD7ZoOFnca4tfVCrKnXq/yHYOplyUzSRUSRz6iGKbbr4FW+RoczqTPw21Zu7RVUAueQJxnqmVCoXFzdbsTWpfM1fuFBtlH3AEFYEM3/EpAr7+Oa7e36SLV9INBa5irSv1dSlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732208451; c=relaxed/simple;
	bh=jzTU/z32x3hB0JfDrm8MmAyZ6G+T5pKSWXdt0ly+8jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFnINefPRGyyszGiQmpDBvPK/OrQA31YpJ1FuuYO+Hnh89ftPo+R6VI3K3LOX4S7L3bp6AkRyFt5q9cwzYDcC75AmoiNQdIDcunJfwChto+UFAMHtkpfMt16VLROE7qkhn/PDZkp47cGLc6T9TUdogEZSpnRUnF7Hjlt5zEDxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L63LVHjP; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53dd1b4e01cso502909e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732208447; x=1732813247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTXid3Zut7ENV6u5lEywLtVroH0vN+GAHGKS1dMMtj0=;
        b=L63LVHjPHU791h+YKXmJCmR5Du5UeMwXxcy3Oangg5fsBdazuhST+klzqEjI4BUd37
         VCKL1hhApSfjju9vUqtvJoS1iNTlGZ8jgWB9c1a0Ki0/MWq/Hk2zgZBoOjHFxEllnr2T
         dleqlmsb4L94QZLXL9nbYYdR7enISgCVPjF7jmsycoItxl5b1vJDWON1Y/XZcB378I2B
         K3S6oH5g/UBWqEH9zlaZ8Vv4RvkvnL9iuU/JwvvjIcCIhiMgbHUMUtUtVkYpuCXKN8/k
         NZply0MBFOg2bljJ2k7piQm4zsba85IzpGCKYcoN9gc+bhLwPw8frLtLd0GWbdSUfxh0
         E0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732208447; x=1732813247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTXid3Zut7ENV6u5lEywLtVroH0vN+GAHGKS1dMMtj0=;
        b=dyljTMmhm4wjpy5JSNeyn1bO9Jx10zx7792t85x7vbvvrJnqxhRst/Fn8Zrk4khdsX
         mRNq8ctdHLLP6BUxRmGou2cgjohdZKcjRDSGKafqfA5w9qeoLCaVjxf+AIG82fYm3w16
         PLt6Y7Umn6l1ruQzIyQZokur048359A5JkRpYKiickggKF+QLshWAN2ohEizeMa2IlHa
         J5kuUHVt8QDOLUEe5zWc+W9dhBRQNdPBNcpld462ExK+rsypqvpNmQ4fAR9NgzrykW6H
         dqnLIURyBo7yzI7deMaUTL1xU/dI37vUzKXLXHzGRQzcWCkdtRjWiWn7VTj+a8dzQX7d
         ucmw==
X-Forwarded-Encrypted: i=1; AJvYcCXNmGZreq130iaurIkchh6Qw+/xCPWT/hR9bjMZKCvMeVpS3WksuE1g+dAKzXUufry6pj8g6s2UgGXfIOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb+eh+od3JDArHf/Mj/fWb/RduZQ/4OQYcND3BDswW0GF2hMJj
	V8kESIH5xyErm0UGmrO379dGWxmVonGViOr3tMPWxr4aDAZSoSPjgmJ60xw6SAU=
X-Gm-Gg: ASbGncuz81D3h3z50syNh+quSW26YzoYqMGEnPzzc6Ut68g7N0EDNYuacg7iG12qXK4
	0e/g/SKHa5bcS1mUWbtkKh/8jAz8/MsenGXHKfs7IwQS3ALUbwMExHDlEr6nj05vhLo33duCauL
	c9aARSes/xHRXSSi1ksHrrzSKr9FF0mae3GvP8T6jbn7yx/8+Hj4K98QktvY8kd+jUXgk9tNPSs
	UbsOWDD24BT4BFM1ig+F5gb7VzPlGUlWlY9WhAPqBqF4WmcGBBf+Zo93Zz8AdbMItjHmvzuaeY0
	GR5OUqqj40EDvPrKJ3cU5O+vE3mKDg==
X-Google-Smtp-Source: AGHT+IHHxVFXWhGPPdA9ksqKTV8tWCXoqA5zp3uVM/KOFvDJ1Wc2NNeKT6Y5HEDYj4Oq06/7SimNdw==
X-Received: by 2002:a05:6512:32d4:b0:53d:cfe0:5937 with SMTP id 2adb3069b0e04-53dcfe059a2mr1179637e87.13.1732208445738;
        Thu, 21 Nov 2024 09:00:45 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24455e6sm16713e87.3.2024.11.21.09.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 09:00:44 -0800 (PST)
Date: Thu, 21 Nov 2024 19:00:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Xin Liu <quic_liuxin@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	quic_jiegan@quicinc.com, quic_aiquny@quicinc.com, quic_tingweiz@quicinc.com, 
	quic_sayalil@quicinc.com
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: qcs615: add UFS node
Message-ID: <45cb4thpg6mrtxiwdb333w2jxgtpw426akik2l3f7qv57dvwmm@kma6vrglbrjh>
References: <20241119022050.2995511-1-quic_liuxin@quicinc.com>
 <20241119022050.2995511-3-quic_liuxin@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119022050.2995511-3-quic_liuxin@quicinc.com>

On Tue, Nov 19, 2024 at 10:20:49AM +0800, Xin Liu wrote:
> From: Sayali Lokhande <quic_sayalil@quicinc.com>
> 
> Add the UFS Host Controller node and its PHY for QCS615 SoC.
> 
> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
> Co-developed-by: Xin Liu <quic_liuxin@quicinc.com>
> Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 112 +++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> index 590beb37f441..ceceafb2e71f 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> @@ -458,6 +458,118 @@ mmss_noc: interconnect@1740000 {
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> +		ufs_mem_hc: ufshc@1d84000 {
> +			compatible = "qcom,qcs615-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
> +			reg = <0x0 0x01d84000 0x0 0x3000>, <0x0 0x01d90000 0x0 0x8000>;

Please consider splitting to have one entry per line (and reg-names
too).

> +			reg-names = "std", "ice";
> +
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
> +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> +				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>;
> +			clock-names = "core_clk",
> +				      "bus_aggr_clk",
> +				      "iface_clk",
> +				      "core_clk_unipro",
> +					  "core_clk_ice",

Wrong indentation

Other than that LGTM.


> +				      "ref_clk",
> +				      "tx_lane0_sync_clk",
> +				      "rx_lane0_sync_clk";
> +
> +			resets = <&gcc GCC_UFS_PHY_BCR>;
> +			reset-names = "rst";
> +
> +			operating-points-v2 = <&ufs_opp_table>;
> +			interconnects = <&aggre1_noc MASTER_UFS_MEM QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> +					 &config_noc SLAVE_UFS_MEM_CFG QCOM_ICC_TAG_ALWAYS>;
> +			interconnect-names = "ufs-ddr",
> +					     "cpu-ufs";
> +
> +			power-domains = <&gcc UFS_PHY_GDSC>;
> +			required-opps = <&rpmhpd_opp_nom>;
> +
> +			iommus = <&apps_smmu 0x300 0x0>;
> +			dma-coherent;
> +
> +			lanes-per-direction = <1>;
> +
> +			phys = <&ufs_mem_phy>;
> +			phy-names = "ufsphy";
> +
> +			#reset-cells = <1>;
> +
> +			status = "disabled";
> +
> +			ufs_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-50000000 {
> +					opp-hz = /bits/ 64 <50000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <37500000>,
> +						 /bits/ 64 <75000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-100000000 {
> +					opp-hz = /bits/ 64 <100000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <75000000>,
> +						 /bits/ 64 <150000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>;
> +					required-opps = <&rpmhpd_opp_svs>;
> +				};
> +
> +				opp-200000000 {
> +					opp-hz = /bits/ 64 <200000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <150000000>,
> +						 /bits/ 64 <300000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +				};
> +			};
> +		};
> +
> +		ufs_mem_phy: phy@1d87000 {
> +			compatible = "qcom,qcs615-qmp-ufs-phy", "qcom,sm6115-qmp-ufs-phy";
> +			reg = <0x0 0x01d87000 0x0 0xe00>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
> +				 <&gcc GCC_UFS_MEM_CLKREF_CLK>;
> +			clock-names = "ref",
> +				      "ref_aux",
> +				      "qref";
> +
> +			power-domains = <&gcc UFS_PHY_GDSC>;
> +
> +			resets = <&ufs_mem_hc 0>;
> +			reset-names = "ufsphy";
> +
> +			#clock-cells = <1>;
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x0 0x01f40000 0x0 0x20000>;
> -- 
> 2.34.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry

