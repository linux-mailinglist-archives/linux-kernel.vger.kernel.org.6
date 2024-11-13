Return-Path: <linux-kernel+bounces-407295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B74D9C6B76
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 860D2B27A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546421F80B2;
	Wed, 13 Nov 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2PxZcdY"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEFD1F77B6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731490051; cv=none; b=KQBHMnaAb7d40wsa6wZB1qg5JNLATuf/JMCyg86ng80Q0Xj0xZQahbnA18SZILEbkampJJJ4jR48eE8XD2DZqbT3y+4vcrdYdSZ/avG2o6H48OTDLrwQ8GJ1VTBUi/U7dvfBe1qTuyRc54D7EEIaCrNRAMlzM5PXxO8YjR7FQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731490051; c=relaxed/simple;
	bh=Woik8mGxHb8sDKp6LYHmg0VUPoY8l0PGA3nFglGEYPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+RgsVRD1fYTbwNH0yPQDJHg/vDbVI/xLShZ4uDvpdQ6FN/MdEDsG9kqjaGEDSiB8wnJ4H2DVWweiFZUVXVIER90o5uNjzq7kONYpcaNq/yTMoCT+1mcfFvXDyJojLqgEyuI/XbA5nUAbvVQmzvW74uMX23mLpFZaCuwniSWGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n2PxZcdY; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e60966297fso3089635b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 01:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731490046; x=1732094846; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BvbMB4wNwdVnYSjLQzzIJ1JPopQ50W3YrXVI3V03iEQ=;
        b=n2PxZcdYdMtfa+53JuLZp9xdnaPwj9dFWNbULDI2XMbrLsH20fw+93HgWKPaY14s4Q
         HaX3U8sQkNMIbm+PoA9I5xQNb3O/QqhEBXyzin/B9MOGkuz47+Q89cURMsG6fIDWSpP5
         DWqGvm3fEfF87CkhVIy+SQnLjm5RH2xNBqe/obCjodsQphKqx1T8WOGQH3m6qWXuP9Zk
         cYeqVTcitVCKVQaKiacyi1kkPcqzU4shUtIDbXu4X4A3TmF7Y3cGBGe9dIazL7uvPLto
         6hcbuOos9cOUThzhUC/qG5nrLaRG8H5yQ6ixW51nXWDsTynhO3w1aqk2MgDdMoifJLGq
         RwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731490046; x=1732094846;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvbMB4wNwdVnYSjLQzzIJ1JPopQ50W3YrXVI3V03iEQ=;
        b=sTNc8Lfmox9qEqpJbUw0BPNZPqWY2JJF0bsoQvEbplX7kz/PVCk3ihp+cjWkEkk3NA
         PN3uBFLQvOmM71foHD0UULoej99Up70LvLT3Lqo9mBm609sY9KPziC/csedpnOJynBum
         4pY2T4GHomAdsPbPFb0/2JtvKdXXiPvGLx4T//PgywaljqNppur7TFumbLr5fxVKTCsu
         scSj6YAW2NWIZTBNm7IWjgkiC5dwHIYJgfb22oOxKR4FS+7rB8xYrwQgcK2On3zJurDD
         luftc1OlBic2Xqqq5FTfhjRZfO4M/HxlXwOr12tncpjxnkCx83+xS8ee4dfol75QVy5h
         hCiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWyDkaYPaJ387lQs3lV+kESKX1cW62lfyKYFRiaVPOXQ5ww1mEqzSvWoHdWXI9/nYN9YScqu+Marg4BkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz7XyRdzi4eJI3oh19O+9rrA/rG4mT/wXb8shUBRY8Z7Y1MZjn
	FoJbyu8uzAUgh1Z6gf53JpvNyEFffjtCwHuxBTE2CqHOz/Mbh5xi+QR8Ofm52A==
X-Google-Smtp-Source: AGHT+IEx4uAAxtCoiiBH+++NqpeCtgOYTj3kESrEXYNyqknD9YqnWM0YpRT+Ci+UYLhuuKE7MSjOzg==
X-Received: by 2002:a05:6808:219f:b0:3e6:366f:8e3b with SMTP id 5614622812f47-3e79475a747mr16256490b6e.39.1731490045743;
        Wed, 13 Nov 2024 01:27:25 -0800 (PST)
Received: from thinkpad ([117.213.103.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f643e9asm11986600a12.59.2024.11.13.01.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 01:27:25 -0800 (PST)
Date: Wed, 13 Nov 2024 14:57:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Xin Liu <quic_liuxin@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	quic_jiegan@quicinc.com, quic_aiquny@quicinc.com,
	quic_tingweiz@quicinc.com, quic_sayalil@quicinc.com
Subject: Re: [PATCH v1 3/4] arm64: dts: qcom: qcs615: add UFS node
Message-ID: <20241113092716.h3mabw4bzgc5gcha@thinkpad>
References: <20241017042300.872963-1-quic_liuxin@quicinc.com>
 <20241017042300.872963-4-quic_liuxin@quicinc.com>
 <5fe37609-ed58-4617-bd5f-90edc90f5d8b@oss.qualcomm.com>
 <28069114-9893-486b-a8d8-4c8b9ada1b0c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28069114-9893-486b-a8d8-4c8b9ada1b0c@quicinc.com>

On Wed, Nov 13, 2024 at 05:19:49PM +0800, Xin Liu wrote:
> 
> 
> 在 2024/10/26 3:24, Konrad Dybcio 写道:
> > On 17.10.2024 6:22 AM, Xin Liu wrote:
> > > From: Sayali Lokhande <quic_sayalil@quicinc.com>	
> > > 	
> > > Add the UFS Host Controller node and its PHY for QCS615 SoC.
> > > 
> > > Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
> > > Co-developed-by: Xin Liu <quic_liuxin@quicinc.com>
> > > Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
> > > ---
> > 
> > + Taniya (see below)
> > 
> > >   arch/arm64/boot/dts/qcom/qcs615.dtsi | 74 ++++++++++++++++++++++++++++
> > >   1 file changed, 74 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> > > index fcba83fca7cf..689418466dc2 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> > > @@ -458,6 +458,80 @@ mmss_noc: interconnect@1740000 {
> > >   			qcom,bcm-voters = <&apps_bcm_voter>;
> > >   		};
> > > +		ufs_mem_hc: ufs@1d84000 {
> > 
> > ufshc@ would be consistent with other files in dts/qcom
> > 
> I referred to qcom files such as sa8775p/sm8550/sm8650 etc.All use ufs@

That's an oddity. But 'ufshc' is documented in the devicetree spec. So you
should use it for UFSHC nodes.

- Mani

> > 
> > > +			compatible = "qcom,qcs615-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
> > > +			reg = <0x0 0x01d84000 0x0 0x3000>, <0x0 0x01d90000 0x0 0x8000>;
> > > +			reg-names = "std", "ice";
> > 
> > One per line, please
> Thank you, I will fix it next version.
> > 
> > > +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> > > +			phys = <&ufs_mem_phy>;
> > > +			phy-names = "ufsphy";
> > > +			lanes-per-direction = <1>;
> > > +			#reset-cells = <1>;
> > > +			resets = <&gcc GCC_UFS_PHY_BCR>;
> > > +			reset-names = "rst";
> > > +
> > > +			power-domains = <&gcc UFS_PHY_GDSC>;
> > > +			required-opps = <&rpmhpd_opp_nom>;
> > > +
> > > +			iommus = <&apps_smmu 0x300 0x0>;
> > > +			dma-coherent;
> > > +
> > > +			interconnects = <&aggre1_noc MASTER_UFS_MEM QCOM_ICC_TAG_ALWAYS
> > > +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> > > +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> > > +					 &config_noc SLAVE_UFS_MEM_CFG QCOM_ICC_TAG_ALWAYS>;
> > > +			interconnect-names = "ufs-ddr",
> > > +					     "cpu-ufs";
> > > +
> > > +			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
> > > +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> > > +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
> > > +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> > > +				 <&rpmhcc RPMH_CXO_CLK>,
> > > +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> > > +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> > > +				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
> > > +			clock-names = "core_clk",
> > > +				      "bus_aggr_clk",
> > > +				      "iface_clk",
> > > +				      "core_clk_unipro",
> > > +				      "ref_clk",
> > > +				      "tx_lane0_sync_clk",
> > > +				      "rx_lane0_sync_clk",
> > > +				      "ice_core_clk";
> > > +			freq-table-hz = <50000000 200000000>,
> > > +					<0 0>,
> > > +					<0 0>,
> > > +					<37500000 150000000>,
> > > +					<0 0>,
> > > +					<0 0>,
> > > +					<0 0>,
> > > +					<75000000 300000000>;
> > 
> > Please try to match the order of properties present in sm8650.dtsi
> Thank you, I will fix it next version.
> > 
> > And please use an OPP table instead of freq-table-hz (see sm8*5*50.dtsi)
> Thank you, I will fix it next version.
> > 
> > > +
> > > +			status = "disabled";
> > > +		};
> > > +
> > > +		ufs_mem_phy: phy@1d87000 {
> > > +			compatible = "qcom,qcs615-qmp-ufs-phy", "qcom,sm6115-qmp-ufs-phy";
> > > +			reg = <0x0 0x01d87000 0x0 0xe00>;
> > 
> > This register region is a bit longer
> I just confirmed again, there's no problem here.
> > 
> > > +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> > > +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
> > > +				 <&gcc GCC_UFS_MEM_CLKREF_CLK>;
> > > +			clock-names = "ref",
> > > +				      "ref_aux",
> > > +				      "qref";
> > > +
> > > +			power-domains = <&gcc UFS_PHY_GDSC>;
> > > +
> > > +			resets = <&ufs_mem_hc 0>;
> > > +			reset-names = "ufsphy";
> > > +
> > > +			#clock-cells = <1>;
> > 
> > The PHY is a clock provider. Normally, it's a parent of
> > gcc_ufs_phy_[rt]x_symbol_n clocks.
> > 
> > Taniya, could you please wire that up in your patchset?
> > 
> > Konrad
> 

-- 
மணிவண்ணன் சதாசிவம்

