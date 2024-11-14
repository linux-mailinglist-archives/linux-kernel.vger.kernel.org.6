Return-Path: <linux-kernel+bounces-409328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AAB9C8B51
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD611F23226
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B6F1FAC51;
	Thu, 14 Nov 2024 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BDOL3MU3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D9027466
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589377; cv=none; b=MnT/p79zwcC0UZtSpo8DiQGjpLdhNLvlzr4/jt7ajawk5xUsQEXvFWkjS0mCha+xZPZx4AfcAeBF9wvEPem2c+N3exXn9WD91p2hbOCgRsuepBqB09VyrVwE3sQCIlmROo+BrzIPXyp0/syuZnkWoeW/7TnmPc8LLjljkGlQfWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589377; c=relaxed/simple;
	bh=KpQSEV0F/SoadF22vnoSln4VGjlgZUVzfALiOxGi0xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUE1+Q5AOA1F5op8lWuLwHMuw3yF9pIrD50FvbwNat9CisNo1NkhxI2D1Ij9QODCLtVmoz4RgtZg0FSD0uMxI9v0F9ktic8YydNjyQQJQ7zTz37bdf4XDiYI3Gxv3SudIGqZ7Mrtv526s8FtT7kLIJhpC3zcRNMjVKoZ6I/fXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BDOL3MU3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE3xlIf020583
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QP2OORrJCqh4d/rWOsnd4tkvUDI8ltC0YswJYfXH6lg=; b=BDOL3MU3H3PD/qxI
	ZUIh0iZBQeQ1GWyjgc67L+Rg7fKp7N+dm4HZ8jJJgr2oYY6Cg/1bXBFqOwIH/rcF
	/eauzYhszRS4sAvFSzyaQhJFmRpCYuePAxCc+Eb57ZbqR2ciSBVu79rp64TuEmJU
	hyfbW1X7Jqx372hb0er+qJEGqiUua8S/E0ZPqkmWNJlS4hWjxMEPK2ne3QSsYoSB
	GP3eeVrW+9GzN0NGqalsWfXGpUwTHcSWl57/E8qAfSsszUC46+F+JhxMA+h2b4tU
	7FOmShb1J+ZT9WbYDfbjKnvx65r+St+3BCXdUOkPf8fVBwLim6eKUOu0R7TnX4bO
	jsh9ng==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42w9sv2cj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:02:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-46093edbf1fso1468581cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:02:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731589373; x=1732194173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QP2OORrJCqh4d/rWOsnd4tkvUDI8ltC0YswJYfXH6lg=;
        b=xIj18MJeu/z5b01wP37MHKNGBccBWKm/GAaIC1OucFV5NobVD0M6dZaHouTKqoyidA
         C96U3+/YKDuiNI+tLhhCBLNckxBjPmhVtl051g/3YY30C7xCbkDHdc5Ht5+tfVN7yw+b
         9ujZhq522oDvPNeGeI9wvR5OTadyGHO1fU8whwazTB2auOiH53a00//4mG3MxGU0PnX+
         xAjH28NaNEYLA2gVFF1O8mExLCEmXs///r4SRZOLl/+K8VrJ09ydcr4JAVJdYjS8p7K6
         eNkV+FriiF24O1kfexkfD753hAczGWfC4syCw7SH3z3EkDwiqfLHhLzoPLLIhpLvbNE8
         uCYw==
X-Forwarded-Encrypted: i=1; AJvYcCUnDCl4uXvm8fCj19nshsN0vs5i4ZBNsZVAIuz4sueJamYTp5mNRdf7TJoEyTEl+kiqjEtqPXQUeLrI+Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyK3zByf/vjWaZKh77lu+Uece/lA8Ai779PEWbsDVOEXO7AWy3
	imowsVLLF/UTGNAMVjCp4m9ubj4RPZV2TNuPU4N+h+k59TsM7iSqecgheOasaXGCuAbMpDTKrsM
	b738/2/GXTRmVfjHnkgu+bMb1hEWGHC/r0TygWdC3iViavlUCVdIx+ubklq3hYSE=
X-Received: by 2002:a05:622a:13ca:b0:462:fb65:cdc5 with SMTP id d75a77b69052e-4630937948cmr149938341cf.8.1731589373591;
        Thu, 14 Nov 2024 05:02:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz5OO7uv5yCAm8X+yScUZ4xyIfrQ/1g7/Ukf8j7FpRrAROqzLOvWj9RwVnZUICeZpIufZ+nQ==
X-Received: by 2002:a05:622a:13ca:b0:462:fb65:cdc5 with SMTP id d75a77b69052e-4630937948cmr149938091cf.8.1731589373227;
        Thu, 14 Nov 2024 05:02:53 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df27068sm61531966b.8.2024.11.14.05.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 05:02:52 -0800 (PST)
Message-ID: <a02925d7-2d09-4902-97e4-5e7f09d7ef21@oss.qualcomm.com>
Date: Thu, 14 Nov 2024 14:02:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: qcs8300: enable pcie0 for QCS8300
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com, kw@linux.com,
        lpieralisi@kernel.org, quic_qianyu@quicinc.com, conor+dt@kernel.org,
        neil.armstrong@linaro.org, andersson@kernel.org,
        konradybcio@kernel.org
Cc: quic_shashim@quicinc.com, quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20241114095409.2682558-1-quic_ziyuzhan@quicinc.com>
 <20241114095409.2682558-5-quic_ziyuzhan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241114095409.2682558-5-quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lwyDih_XGcoUrCdiMTQ8L5AoXT3X4mdl
X-Proofpoint-GUID: lwyDih_XGcoUrCdiMTQ8L5AoXT3X4mdl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140102

On 14.11.2024 10:54 AM, Ziyue Zhang wrote:
> Add configurations in devicetree for PCIe0, including registers, clocks,
> interrupts and phy setting sequence.
> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts |  44 +++++-
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi     | 176 ++++++++++++++++++++++

This implies this patch should be two separate ones


[...]


> +&tlmm {
> +	pcie0_default_state: pcie0-default-state {
> +		perst-pins {
> +			pins = "gpio2";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		clkreq-pins {
> +			pins = "gpio1";
> +			function = "pcie0_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		wake-pins {
> +			pins = "gpio0";

Sorting these in an increasing order would be welcome


>  
> +		pcie0: pci@1c00000 {
> +			compatible = "qcom,pcie-qcs8300","qcom,pcie-sa8775p";

Missing ' ' after ','

> +			reg = <0x0 0x01c00000 0x0 0x3000>,
> +			      <0x0 0x40000000 0x0 0xf20>,
> +			      <0x0 0x40000f20 0x0 0xa8>,
> +			      <0x0 0x40001000 0x0 0x4000>,
> +			      <0x0 0x40100000 0x0 0x100000>,
> +			      <0x0 0x01c03000 0x0 0x1000>;
> +
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "config",
> +				    "mhi";
> +
> +			device_type = "pci";

Please try to match the style in x1e80100, it's mostly coherent but
things like newlines differ, which is tiny but mildly annoying

> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;

Looks like there's a bit more space in there
> +			bus-range = <0x00 0xff>;
> +
> +			dma-coherent;
> +
> +			linux,pci-domain = <0>;
> +			num-lanes = <2>;
> +
> +			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-names = "msi0",
> +					  "msi1",
> +					  "msi2",
> +					  "msi3",
> +					  "msi4",
> +					  "msi5",
> +					  "msi6",
> +					  "msi7";

Please also add a "global" interrupt.. looks like it's GIC_SPI 166, but
please confirm

> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
> +
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_0_AUX_CLK>;
> +			assigned-clock-rates = <19200000>;
> +
> +			interconnects = <&pcie_anoc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,

QCOM_ICC_TAG_ALWAYS

> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;

QCOM_ICC_TAG_ACTIVE_ONLY

[...]

> +
> +			pcieport0: pcie@0 {
> +				device_type = "pci";
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +				bus-range = <0x01 0xff>;
> +			};

Are you going to use this? If not, please drop

> +		};
> +
> +		pcie0_phy: phy@1c04000 {
> +			compatible = "qcom,qcs8300-qmp-gen4x2-pcie-phy";
> +			reg = <0x0 0x1c04000 0x0 0x2000>;
> +
> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,

This clock goes to the RC, it should be _PHY_AUX (which you put below
as phy_aux), please replace it.

> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_CLKREF_EN>,
> +				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE_0_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_0_PIPEDIV2_CLK>,
> +				 <&gcc GCC_PCIE_0_PHY_AUX_CLK>;
> +
> +			clock-names = "aux",
> +				      "cfg_ahb",
> +				      "ref",
> +				      "rchng",
> +				      "pipe",
> +				      "pipediv2",
> +				      "phy_aux";

Konrad

