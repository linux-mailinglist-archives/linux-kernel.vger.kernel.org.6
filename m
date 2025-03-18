Return-Path: <linux-kernel+bounces-565482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BAAA66949
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22EE817C5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADFF1D9A49;
	Tue, 18 Mar 2025 05:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n1VUWMHo"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B41A8413
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742275730; cv=none; b=nLm7H8jZ7/VUMjLN1ItQvnc7YqEsTNI/CYijBZHBDLuyM43+o1gFL+ZRZiN7FLPRTeeVKSZTb6xnkZGr0Kqmmzsf4/stYr/ibEoObxVst6KnLbeHnGj2G3LNRLLO5h1AhMgufkTTcEWUguxRz8DaKAMMahA54v6sVoZLmt+mQOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742275730; c=relaxed/simple;
	bh=/0mkySwxx8CUCvupfW3tEVscVADwcQaLSwPmfTKJfsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDa5I1WVWvTaUmkX9Xsy9Z0ptEu5fOLhIbQokMb4hMPGsJed2Xg5DEX2o2W+NhL4DiYv+DjJutffEuCDCwudhUjc9cckK2XJT/1bs4XmjSRsm3C9jCzK6/7ybLuylfSsl/eXFWEWQ7tvyNoVcScB7an/WyeVcERONZ1Wc37wKVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n1VUWMHo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22548a28d0cso141873935ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742275728; x=1742880528; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VRqPHtspOPLV5fzzZRBSafJQnspJw3fNNbyVspVhWQ4=;
        b=n1VUWMHogcTpKm1MVl0iy7k2Ew+vTSFDZHP4Da/IsEnW0lZykV/iAfwsdNJBGznFyq
         bRNWL+P/X20QCsioixrhSXzuPa/RbYxje/RHM6Efbd/swKjIxygOQRDHSzlYnnixpcw4
         qDOvvMEEoAzipXQ9I8EzTjn4PkFkXTPE3+lPfnhYp9dUoKvTPK9okKWyC5ngR2VGCKWD
         ix3Q1SJqs175pidMXDxr/yE3me+5ELtATfuzL/aqFYFRwu0+DGNApY+aqUx08LAjz94C
         fwS5UEgBKvH90Pmh4gq74tR6MegboNIG2+voLEHSlEqThrio6qEHHgBacS3l746dfyuE
         76uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742275728; x=1742880528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VRqPHtspOPLV5fzzZRBSafJQnspJw3fNNbyVspVhWQ4=;
        b=FEfAQo57kQQM2wGiw3xggBnao2rHQrgHd16cdnYp13XxjphaQ4vhsuM4PDfJADaro/
         to8kPtYDaNDXN5LAJQhSsOt/iyPZcm5XrN4m3i24ZJhRGRNVUs5YnGv2zKfnI7h5YbB6
         9IBrQ19crPjL9ydpjP95qSV3pLx6sMsCTi3K2ZsId/GQpDDnrkdZqfzWHoU0NKvKo02H
         oj8bQ2pNn6eYJRgc37C/VId1LdJmBYwbS1Ty5f4sOwh7h3cB2iQNJhIRpQ+csjszpkt+
         boLeMKDDaEi9JHct+2dNONl/m3cqzLYSmDOiEhcvRLCS2Kxr5Dx9l/UiphGasM2VamzF
         hXtg==
X-Forwarded-Encrypted: i=1; AJvYcCUwe17VwyvQd1Ha1QQW4BdC0HDso/DWPE5NFfIl5q8BUdAU6ttLHceIemJt9ECEWHzhyJrnp5KYAeRjjio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzz19vHa7VxhU3DuB0ZIyUR9AnQFXJtNTZsffXLyywVNCkitTU
	F5amJ1w8WMKh4KLBulzaY86Xl9HsbkbGFw2/zW4ffd+yltWeAZ4EPx6Ggx6zHg==
X-Gm-Gg: ASbGncsC+V4rOBIuEYFCz+SdUSJ/uX1y+en2vYYo5/g6ad9siEqm5WJGmEvJNa5lTtN
	SXTRMrgMJB/bgyvnXNhNy1fFDO90T4m8s8mWLGqDwJtKhj2iQX9E/LLBj084mAi3gXh+eTuS+Y9
	WtVYVwP+V1xygyuRO3ViEHRuREbSpgHnA2aW03Co/8IuNvGxcbnaZUe/dGfwoQY6Xcc7yMbTyZ5
	HHDlUDIbh+tv+UysiQgfJ90Vub9M+Jphod9WqNpUsypCdnnXem/hDlmBjTQ3zu8g4AiLpA/IFKS
	4ftFEJmcSv73S15ZEXyAfOiaanFqucFar0Heg8PaH05mus+OjPa0+eYmyglXuN+XSos=
X-Google-Smtp-Source: AGHT+IFG5Sp+xZKN+EExsVukhBXmwQgVJv7iaqIRzDwSj/npYT8oIBOs7InzmHh3m7smIDKT/Xzh+w==
X-Received: by 2002:a17:902:d4c6:b0:223:58ea:6fdf with SMTP id d9443c01a7336-225e0a7a005mr192432975ad.28.1742275728222;
        Mon, 17 Mar 2025 22:28:48 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22637cf43ffsm2371755ad.129.2025.03.17.22.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 22:28:47 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:58:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Manish Pandey <quic_mapa@quicinc.com>
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sm8750: Add UFS nodes for
 SM8750 SoC
Message-ID: <20250318052841.bdiqbzxrpzwqf7h7@thinkpad>
References: <20250310-sm8750_ufs_master-v2-0-0dfdd6823161@quicinc.com>
 <20250310-sm8750_ufs_master-v2-4-0dfdd6823161@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310-sm8750_ufs_master-v2-4-0dfdd6823161@quicinc.com>

On Mon, Mar 10, 2025 at 02:12:32PM -0700, Melody Olvera wrote:
> From: Nitin Rawat <quic_nitirawa@quicinc.com>
> 
> Add UFS host controller and PHY nodes for SM8750 SoC.
> 
> Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 106 +++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> index 529e4e4e1d0ea9e99e89c12d072e27c45091f29e..72f69e717ce049bb0c524aa389d837ecd1459535 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/power/qcom,rpmhpd.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/gpio/gpio.h>

Sort includes alphabetically.

>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -2675,6 +2676,111 @@ gic_its: msi-controller@16040000 {
>  			};
>  		};
>  
> +		ufs_mem_phy: phy@1d80000 {
> +			compatible = "qcom,sm8750-qmp-ufs-phy";
> +			reg = <0 0x01d80000 0 0x2000>;

Use 0x0 for consistency.

> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				<&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
> +				 <&tcsrcc TCSR_UFS_CLKREF_EN>;

Please align the clocks.

> +
> +			clock-names = "ref",
> +				      "ref_aux",
> +				      "qref";
> +
> +			resets = <&ufs_mem_hc 0>;
> +			reset-names = "ufsphy";
> +
> +			power-domains = <&gcc GCC_UFS_MEM_PHY_GDSC>;
> +
> +			#clock-cells = <1>;
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +			};

Here too.

> +
> +		ufs_mem_hc: ufs@1d84000 {
> +			compatible = "qcom,sm8750-ufshc",
> +				     "qcom,ufshc",
> +				     "jedec,ufs-2.0";

Compatibles can be ordered in the same line.

> +			reg = <0 0x01d84000 0 0x3000>;

0x0

> +
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
> +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> +				 <&rpmhcc RPMH_LN_BB_CLK3>,
> +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> +			clock-names = "core_clk",
> +				      "bus_aggr_clk",
> +				      "iface_clk",
> +				      "core_clk_unipro",
> +				      "ref_clk",
> +				      "tx_lane0_sync_clk",
> +				      "rx_lane0_sync_clk",
> +				      "rx_lane1_sync_clk";
> +
> +			operating-points-v2 = <&ufs_opp_table>;
> +
> +			resets = <&gcc GCC_UFS_PHY_BCR>;
> +			reset-names = "rst";
> +
> +			interconnects = <&aggre1_noc MASTER_UFS_MEM QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &config_noc SLAVE_UFS_MEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			interconnect-names = "ufs-ddr",
> +					     "cpu-ufs";
> +
> +			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
> +			required-opps = <&rpmhpd_opp_nom>;
> +
> +			iommus = <&apps_smmu 0x60 0>;
> +			dma-coherent;
> +
> +			lanes-per-direction = <2>;
> +
> +			phys = <&ufs_mem_phy>;
> +			phy-names = "ufsphy";
> +
> +			#reset-cells = <1>;
> +
> +			status = "disabled";
> +

Extra newline

- Mani

-- 
மணிவண்ணன் சதாசிவம்

