Return-Path: <linux-kernel+bounces-527366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE207A40A5A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541D73A9BCE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7357F1487ED;
	Sat, 22 Feb 2025 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7agYjCX"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507FF13C81B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740243096; cv=none; b=j2FZNjEEWJImXXkpk9ZZCIEj4Icemt2apS51TV91sHxQiY5kuudN0zd+bhDHpSATa2EHG+ZNCLGUDQ83P6NI3LiLrS5DwQoWEmmSmCeBaB0feL9tAWdjRgHVAIf+AjTIKoWF2+eqHrOKTVA4t23cQhX99rYb5dtmHpXp0KHdFkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740243096; c=relaxed/simple;
	bh=w0LmQz49aT/pe7eaUqi7mMgp1KIC2QgVZzGW5zZxAmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIHYFmCb/VTzsn0rUuIe3TtLi2lUFhr2MrIk5cLZFfJoDjYNwNRg7JdYy9GoP1D63o116h2yPIfPLWx0njoPprFgc57PcxESmQdOsks+hXWl8u+jpyw69h8cfgn+k8DW0hnUMJIPaBmzhevlTyZqft48VQ/BnRuRczKGaYLlufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h7agYjCX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fcb6c42c47so4984014a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740243095; x=1740847895; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sOUENYnzvt8ZQH4Hyb/QTR5W7roK5/nHLc7Zp4LFoQ0=;
        b=h7agYjCXoIz8r84QFAZ7cja5o9kqRXB9nEiVT7ToJrgO8AybkWuhKBU3kJniROwKfd
         b3h7XehRi/+IeU/BpBdb85YJwycA7qWUxeluZMIufofHkZbQPR6TViFO1J2WXNHp47M4
         rtDZ36ASNJ46Ytl/4vaYfz7S6IfB8tsLUihO36UakhHNNHE41kmxhYgRo5AAAmxcv0sC
         J5/hCv+73e5zoknCT6eOcBlDBhS5M15kKGAW9cnHwU+1DsGUrc6xquXqrNQoK3aGF6T5
         8b2WXnNkP9AerjzwpjXtXyOzhf4qtD7KmdJLJPSZbjnMXWqxtgdvCQUGfTn5Jwljujg/
         iYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740243095; x=1740847895;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOUENYnzvt8ZQH4Hyb/QTR5W7roK5/nHLc7Zp4LFoQ0=;
        b=t6vAhvW4z74yM0DdEh7GZpU1tbXtJX3/TuJChnSD8t4yYE+ByZfCL7Y27+fEfRT/rA
         BikxwLQsrv2/VFLMxMqQE0w/wTDV0HPZ+ICBnLSM1VBR55IdnMXo1fZjhLvsArKLfMB9
         lrf61dqJhoBiUqjgoYwuMcFu1BD3NHbh4SvNZMaBTKBrW+IKQPMdSGVJ7I4VeMn40dhm
         GiUE3ERDObgWQ8/iV+2Iup8qnuxaXDF5c2PMsIg5RtUXzCKnWC/p8q37Wbas58sZvN33
         ky72pGTJCRtxC6eqvhjtzsvIyGTKrwhcUfu1otfueJ2taLGP4FV2SIQHIEms2dw2ke0+
         sszg==
X-Forwarded-Encrypted: i=1; AJvYcCVpGP6h4aMMSgwLIGQzlzBoyQK025JdBCuR5o75OqgUt6fRQpCrwmfRF7x8zuMG8S5cDIThJ+GYWymrngA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5VXIMmKI4Re9MFOxiFKqtGjWqBfYXt76P0hYKNHTJDEycH2dA
	DvDQHQ0KYUSX5e6rH9ASy4Y+sFpRQ1SrMKRvlQVdG7dXawAMwrkUXCKaBPbxRw==
X-Gm-Gg: ASbGncvL+eztmjzDTVdmG44JP27rQKk4mZvhJY3cbzHjczHYhANYwUytS3LnDVlfEiA
	jVacfuwb/ddoIPnENVbGlPCEpmGMuVuW3hSaosBLTHP1iXZ9/XUL1tKH+/xP72dwnnpW7gzLZCK
	vqYpkhXaQY+wFo+VCxwCuRJNmoCfUvAnKlFYYUmolplBztNbLmQj58BA/o2jsIxJ0egkuucqUbY
	0gaE1T50JBdXX+T3E7H4+809N21PHosPMRDs0YYUwL8sY0e95IDaudE7OUUXApW7um2k3P/KaSl
	wLljSybpkIZAIvObX2soh8DqDKFm7FaKaGyHLQ==
X-Google-Smtp-Source: AGHT+IHJoDxHiXuse7PDv45xfuzLtsqgGLpJ0OEKAFEDkIQnRP5KJLDYqtkpTUaVZ1UEGlR/auVcng==
X-Received: by 2002:a17:90b:1dcb:b0:2f8:4a3f:dd2d with SMTP id 98e67ed59e1d1-2fce78d1b51mr13034417a91.15.1740243094733;
        Sat, 22 Feb 2025 08:51:34 -0800 (PST)
Received: from thinkpad ([120.60.135.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb04c697sm3437710a91.19.2025.02.22.08.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 08:51:34 -0800 (PST)
Date: Sat, 22 Feb 2025 22:21:28 +0530
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
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: sar2130p: add PCIe EP device
 nodes
Message-ID: <20250222165128.55ly42qw2id4pucv@thinkpad>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
 <20250221-sar2130p-pci-v3-7-61a0fdfb75b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221-sar2130p-pci-v3-7-61a0fdfb75b4@linaro.org>

On Fri, Feb 21, 2025 at 05:52:05PM +0200, Dmitry Baryshkov wrote:
> On the Qualcomm AR2 Gen1 platform the second PCIe host can be used
> either as an RC or as an EP device. Add device node for the PCIe EP.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/sar2130p.dtsi | 61 ++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sar2130p.dtsi b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
> index dd832e6816be85817fd1ecc853f8d4c800826bc4..b45e9e2ae0357bd0c7d719eaf4fc1faa1cf913f2 100644
> --- a/arch/arm64/boot/dts/qcom/sar2130p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
> @@ -1474,6 +1474,67 @@ pcie@0 {
>  			};
>  		};
>  
> +		pcie1_ep: pcie-ep@1c08000 {
> +			compatible = "qcom,sar2130p-pcie-ep";
> +			reg = <0x0 0x01c08000 0x0 0x3000>,
> +			      <0x0 0x40000000 0x0 0xf1d>,
> +			      <0x0 0x40000f20 0x0 0xa8>,
> +			      <0x0 0x40001000 0x0 0x1000>,
> +			      <0x0 0x40200000 0x0 0x1000000>,
> +			      <0x0 0x01c0b000 0x0 0x1000>,
> +			      <0x0 0x40002000 0x0 0x2000>;
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
> +				 <&gcc GCC_DDRSS_PCIE_SF_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>,
> +				 <&gcc GCC_CFG_NOC_PCIE_ANOC_AHB_CLK>,
> +				 <&gcc GCC_QMIP_PCIE_AHB_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "ddrss_sf_tbu",
> +				      "aggre_noc_axi",
> +				      "cnoc_sf_axi",
> +				      "qmip_pcie_ahb";
> +
> +			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
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
> +			iommus = <&apps_smmu 0x1e00 0x1>;
> +			resets = <&gcc GCC_PCIE_1_BCR>;
> +			reset-names = "core";
> +			power-domains = <&gcc PCIE_1_GDSC>;
> +			phys = <&pcie1_phy>;
> +			phy-names = "pciephy";
> +
> +			num-lanes = <2>;
> +
> +			status = "disabled";
> +		};
> +
>  		pcie1_phy: phy@1c0e000 {
>  			compatible = "qcom,sar2130p-qmp-gen3x2-pcie-phy";
>  			reg = <0x0 0x01c0e000 0x0 0x2000>;
> 
> -- 
> 2.39.5
> 

-- 
மணிவண்ணன் சதாசிவம்

