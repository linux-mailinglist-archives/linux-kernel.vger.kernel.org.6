Return-Path: <linux-kernel+bounces-565592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5625FA66B67
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF173BB64E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4761EB5CE;
	Tue, 18 Mar 2025 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQ2Dj7Fu"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375DC1A5BAF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742282297; cv=none; b=u+LGiJHVEnUkfUZgZiU5X8ioF5Soy8RatJJnM3s2NJqQ6RcCvODZdZstJwmf9BnPK8Fb7VoS/K94Orcoy+0x2A7ICcSA2D3QudFzOK2/anwb2XuPb7tMJ8GaZ90DvST9zoN/BoZR7V2GIpuS9sKt3/QzftWjiHgbc511BWdNn8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742282297; c=relaxed/simple;
	bh=sHkWokmPrqXsdDV7+i8VB3rJOPWoE1XI438bG7S5Nlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxVEIBFS9u8U8gZxpCBLkT5m8k0/MxPGZ3U77T0VzhS1430gyo6DLcByQW3FRba50fDdFp7C/xEYEgejq1N631sOYnLh+MX/LQ3YfZ9WwEZa01mrqQCDs1P83i26VpeLiYMI0DYB/xNJwlIZxxnwepB0VTkUNkDKLEDOxYaQQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MQ2Dj7Fu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224191d92e4so100003245ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742282295; x=1742887095; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uL3J0kJ07qCQwLi/H8v/Z+UezU+LpDO7hkpWTExk8ys=;
        b=MQ2Dj7FuHbOQVJ5YTk0xYiXvhy57ZnHOSkxAJ0yPyePEmJh9SaVwgup/Sc6Fq8A4v3
         7Mwe3Duhv/9grkY8khBxRl1JLymtWOG6oIBV+Z9acEtLjDNp6xvNAFeha/7Kp4xnZYsV
         qvpVlpGnAVZtKHmq1J7HqZigN8n5ETDmNxtiZGhP5ejtRlt92HBuUNU1n9R72ehYwIum
         BmQ3VTYZ+t7zsJuTozqLaK4193Xj9bTYZ7h4TOw0VOV2USV+Lw8SMZb7oCkT1qEBPTMU
         EokAipHKCrPZiY8Zkx/9csn8fQoUOmCvQoJ+epj8M4RTK7/QRPzJFj25ZC89Ab0KRD62
         FFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742282295; x=1742887095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uL3J0kJ07qCQwLi/H8v/Z+UezU+LpDO7hkpWTExk8ys=;
        b=NNYV2XPRljrhpg5EG9VnZICDfE9+Htl9rFvb1CvkYdDqy+5w18B43aYDM7kraFz4nH
         2XRPhmrA10aGur7OFFWDqO8vWrGJyuDv7IHLOKmcIqfCWoqXA8yM1wwNAob5PLXV5UYF
         0UcleMnimVpIAo6obx+X6/Y4wxVOqeut/8K1gkb5Y/6ZuUgmQkIb7u/y+gxSJ82pj+Tn
         0RNl2mCN/9U+gWTn6BtFLLAwahqvYkQTjP3ETxpbZW3g//N0jk2VuW3sLswz64eg+dwr
         sBKG0VahbQ7a78+kEBJ3yxXrLZdMDpAH1OQ20clxVqku8Gg6rmgq4d/yh7SX1yOPi5iL
         uE6g==
X-Forwarded-Encrypted: i=1; AJvYcCWBeT6GfdAMER56HnLhu35Zka2L5CJSkZbnC802EH+4d/EXS4NGC6Oo8Mt10jlvQzImd32KmI9O2ikfuJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Oevt+wieKnNnqGktbprJg5sorC6C1wp0bo7tsc0mcbyEysnx
	r9JsnlVBr1DYACTbuizzythtu6b8VJuZg8OqkGKCeSLU7iBhl9b9wg2aOkf+lQ==
X-Gm-Gg: ASbGncuxkKr1Cl4b4Ip4bn1lBJmjeBHr5kY0t7nmjfwmh/rlMkbpS8jcVOEo7f5RrsS
	huffExlKmOrxyhxaVweJrfQcpSfxSBlDjJPVfnAqllW0g6FiURtvnRGHsf6W/GCqhvXszOwrJ2b
	39Ow85DE2+eV6fAD+fS3apSdlgHBsz5O58EBYivlhLJ5GOkr9boPUrpsI1mjzvdfye6xKHBRLBn
	FCsYjgfC6KYiAanx5tX/hBjHySFPFvGbI8+V53rnn1lgliHE8vIdM5zDpGBMU6F/OdKIOwgH+VR
	rq54GU1KuOWDeJdl0GU/FcgW6CIg5XnCA2PkI+M6gwtHbfKhdgRzSewdEfXL2FPaEsM=
X-Google-Smtp-Source: AGHT+IEzVk5IzlQIC5VwuXRJuSpzspEea6bADLr7EeZbZUTj69tT3vTxsaaX4dqVtRwwYUxDGF902w==
X-Received: by 2002:a17:903:3bad:b0:223:2cae:4a96 with SMTP id d9443c01a7336-225e0b0fa67mr181209535ad.42.1742282295391;
        Tue, 18 Mar 2025 00:18:15 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba7275sm87355885ad.115.2025.03.18.00.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:18:15 -0700 (PDT)
Date: Tue, 18 Mar 2025 12:47:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	andersson@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
	kishon@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
	kw@linux.com, lpieralisi@kernel.org, p.zabel@pengutronix.de,
	quic_nsekar@quicinc.com, robh@kernel.org, robimarko@gmail.com,
	vkoul@kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v3 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
Message-ID: <20250318071756.uilfhwfzgr5gds3o@thinkpad>
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
 <DS7PR19MB8883E4A90C8AFF66BCAE14F49DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS7PR19MB8883E4A90C8AFF66BCAE14F49DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>

On Wed, Mar 05, 2025 at 05:41:30PM +0400, George Moussalem wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add phy and controller nodes for a 2-lane Gen2 and
> a 1-lane Gen2 PCIe bus. IPQ5018 has 8 MSI SPI interrupts and
> one global interrupt.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 232 +++++++++++++++++++++++++-
>  1 file changed, 230 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 8914f2ef0bc4..301a044bdf6d 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -147,6 +147,234 @@ usbphy0: phy@5b000 {
>  			status = "disabled";
>  		};
>  
> +		pcie1: pcie@78000 {
> +			compatible = "qcom,pcie-ipq5018";
> +			reg = <0x00078000 0x3000>,
> +			      <0x80000000 0xf1d>,
> +			      <0x80000f20 0xa8>,
> +			      <0x80001000 0x1000>,
> +			      <0x80100000 0x1000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "config";
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <1>;
> +			max-link-speed = <2>;

Why do you want to limit link speed?

> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			phys = <&pcie1_phy>;
> +			phy-names ="pciephy";
> +
> +			ranges = <0x81000000 0 0x80200000 0x80200000 0 0x00100000>,	/* I/O */
> +				 <0x82000000 0 0x80300000 0x80300000 0 0x10000000>;	/* MEM */

These ranges are wrong. Please check with other DT files.

Same comments to other instance as well.

> +
> +			msi-map = <0x0 &v2m0 0x0 0xff8>;
> +
> +			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
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
> +			interrupt-map = <0 0 0 1 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +			clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
> +				 <&gcc GCC_PCIE1_AXI_M_CLK>,
> +				 <&gcc GCC_PCIE1_AXI_S_CLK>,
> +				 <&gcc GCC_PCIE1_AHB_CLK>,
> +				 <&gcc GCC_PCIE1_AUX_CLK>,
> +				 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>;
> +			clock-names = "iface",
> +				      "axi_m",
> +				      "axi_s",
> +				      "ahb",
> +				      "aux",
> +				      "axi_bridge";
> +
> +			resets = <&gcc GCC_PCIE1_PIPE_ARES>,
> +				 <&gcc GCC_PCIE1_SLEEP_ARES>,
> +				 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
> +				 <&gcc GCC_PCIE1_AXI_MASTER_ARES>,
> +				 <&gcc GCC_PCIE1_AXI_SLAVE_ARES>,
> +				 <&gcc GCC_PCIE1_AHB_ARES>,
> +				 <&gcc GCC_PCIE1_AXI_MASTER_STICKY_ARES>,
> +				 <&gcc GCC_PCIE1_AXI_SLAVE_STICKY_ARES>;
> +			reset-names = "pipe",
> +				      "sleep",
> +				      "sticky",
> +				      "axi_m",
> +				      "axi_s",
> +				      "ahb",
> +				      "axi_m_sticky",
> +				      "axi_s_sticky";
> +
> +			status = "disabled";
> +
> +			pcie@0 {
> +				device_type = "pci";
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +			};
> +		};
> +
> +		pcie1_phy: phy@7e000{
> +			compatible = "qcom,ipq5018-uniphy-pcie-phy";
> +			reg = <0x0007e000 0x800>;
> +
> +			clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
> +
> +			resets = <&gcc GCC_PCIE1_PHY_BCR>,
> +				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
> +
> +			#clock-cells = <0>;
> +

Please get rid of these newlines between -cells properties.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

