Return-Path: <linux-kernel+bounces-425043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12FB9DBCCB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A271D281B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D7B1C07F2;
	Thu, 28 Nov 2024 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="geRFYmz/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389CE145323
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732824872; cv=none; b=oObqZLrb9LmTEaeu/WQGmiP1XqiKv0NVrXo30AcwqdkiAhw2z7SgzF00larUwXAA6bFFRyToPxParNVrDNeXJR/iJiPqJnITtYs43BiMi+8CeXhqxTIBHtOT17KgasTi5U+q0w/U/ZgGgpgi69kaK4cMgH1KynSabM8icSeuamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732824872; c=relaxed/simple;
	bh=+zXs3aELrrOdcH7l0CkDK1T02KJWAx6tezV7yYDVGX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRGZ/PdI/vF67b+3bQ02//brfYN97gjSi1z1tWYyN0qgfBgCGs6AWfoVpVnSGiduNJRpaxrNPM9IY104rypN8KNQuTudqlrcSXfsz978EoIBZrICd/DM4XBLDvisYZYeHsfLY22bn8Vzk+Oe7Qq0I9qhpx0Ob0PFF4I1lzbjVbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=geRFYmz/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASJ3w7T029902
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jjg0vsL9PIQrJqQc1ErY87Ss0UkRH1ifFtchX/4u0ic=; b=geRFYmz/taaZ3vJk
	7vD6y0TyGs2eA6LSduINCHTOQALBNDZxPk57TDvKyowo96olEnJrG8mlBbWugAjP
	+sBFSbl1RwbsEvUBIuVxm54TwxNAnrzH9THp1OgkO60GSWLtrNONsXvVDxAWXtKG
	BtZLam2eFnNh9g0Q8zseHoZdVfcCihq58zAv3A9dhwXwY9+Msh7bB6OW/YLYgoD1
	MHav5nJhz+6kMcP1t/2ACR27/X4MkP8vhkZaPqKvimTXRR/GTarp/2XhrAmH4ry5
	xBkUisLEoCIw/u57QNAJnbqFWwnQtH1tiEJuSVKBigeEcjVIqmYk9u+yuGTCJtP3
	9t6/Xw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366xwumbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:14:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4668c9aa8c7so2418441cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732824869; x=1733429669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjg0vsL9PIQrJqQc1ErY87Ss0UkRH1ifFtchX/4u0ic=;
        b=rhzgvc6R0xuq6NT45NxyorT/o4sN0K1atPYGi3BaznrQPUOvA+hJ06W4gQg4QqBj3Y
         y8SFSp/T3ozFBzHyUiNYfjJKox2Dwhf2t+mmgyRTYsp3AZj+/LtttelE6P/E9Qa2KG5+
         7bXlUumjer6sLDl1RKoth/MQWTzHftTLm4+t2zMaVdanYECVFMbBylofaDUpR+gHYAAt
         neaBKTVUnlAD0DwS3llrFZDF9kyvLQ0si0d+Gb8GqUP0TVfXQIu4nI4Jw9xK2Mut6v1E
         jtRf8z7vqEvYHourj1xQjwPTeJU648hpxvG9FNxrkfgxF5qlhZrnTlS74vkf9VZlhNRt
         05RA==
X-Forwarded-Encrypted: i=1; AJvYcCU6+DtwuQDtD2fW+up8/Nux5ku1pXPeLpvccrzqBdPoLhBDm9NE2WulS2U81DyNJormEMe3dRYT+GLwsB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVHUwuCVW3Dc/CaCfzrxI1TT92PMWAccM2496J+Lr+x1OPhQgs
	I1uVSmWKj/gBOZZCPUsSTO8NlDB76eVCnnecK8XUe1JYY0YZqzXv0su/onXnSJFTCqCtFR/WTMb
	BT9HqiEVZDJE/MPAW0EqynFYXBJozS2eeyVDXyYFN6ymxSiE3cEY0I3QrUCUcedA=
X-Gm-Gg: ASbGnctRJ90vb/BnPw1/+b+G5OI/Nkg/lWRlx+1CvfRlQdbxPPZrn4CtLxpX78JzyPE
	7mgEzYxEUvMqL/G/f26+1nsH1eIrlkJ7EipMgkRK7sq0vtsvV8e9nMr9hfNQFXOTlo9zT4+ylnU
	eUCNytZMnIx31Nha8+xSAlIpRe6Oo8yM3aI3ciAAfi3kwnSh1xJLyOsx6f9QOONTpw8XJZmAYsF
	y/CWibjyz+dPyO2MokY+mRq/5nGIRDPHTuZM/1DQCQTVzKLD1qXMgQeoCalUzrIVwqoFxmLYOku
	XOYKAQ/xLV/kgbcHBkuoG5w+O7gcZ0Y=
X-Received: by 2002:a05:622a:1a13:b0:460:62a1:70be with SMTP id d75a77b69052e-466b36737d2mr55782581cf.13.1732824868860;
        Thu, 28 Nov 2024 12:14:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJQMzZTd/mwyBiurFVOcv8v+qrOUQ80czSiwqfTqiVtFonMiHL9Th3LiaU5QNqC3afeeXn/g==
X-Received: by 2002:a05:622a:1a13:b0:460:62a1:70be with SMTP id d75a77b69052e-466b36737d2mr55782461cf.13.1732824868440;
        Thu, 28 Nov 2024 12:14:28 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e716fsm99165566b.108.2024.11.28.12.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 12:14:27 -0800 (PST)
Message-ID: <2a2a780d-5e3e-4582-b75d-211732a9b727@oss.qualcomm.com>
Date: Thu, 28 Nov 2024 21:14:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: add QCS8300 platform
To: Jingyi Wang <quic_jingyw@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: quic_tengfan@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20241128-qcs8300_initial_dtsi-v3-0-26aa8a164914@quicinc.com>
 <20241128-qcs8300_initial_dtsi-v3-3-26aa8a164914@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241128-qcs8300_initial_dtsi-v3-3-26aa8a164914@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fAioF28IIV7CRkI0GrySE3NTn61frluf
X-Proofpoint-ORIG-GUID: fAioF28IIV7CRkI0GrySE3NTn61frluf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411280160

On 28.11.2024 9:44 AM, Jingyi Wang wrote:
> Add initial DTSI for QCS8300 SoC.
> 
> Features added in this revision:
> - CPUs with PSCI idle states
> - Interrupt-controller with PDC wakeup support
> - Timers, TCSR Clock Controllers
> - Reserved Shared memory
> - GCC and RPMHCC
> - TLMM
> - Interconnect
> - QuP with uart
> - SMMU
> - QFPROM
> - Rpmhpd power controller
> - UFS
> - Inter-Processor Communication Controller
> - SRAM
> - Remoteprocs including ADSP,CDSP and GPDSP
> - BWMONs
> 
> Written with help from Zhenhua Huang(added the smmu node), Xin Liu(added
> ufs, adsp and gpdsp nodes), Tingguo Cheng(added the rpmhpd node), Kyle
> Deng(added the aoss_qmp node), Raviteja Laggyshetty(added interconnect
> nodes) and Cong Zhang(added the INTID of EL2 non-secure physical timer).
> 
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> ---

[...]

> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +
> +				core4 {
> +					cpu = <&cpu4>;
> +				};

The MPIDR_EL1 register value (CPU node reg) suggests they are not
part of the same cluster (as you confirmed in the psci idle domains
description)

[...]

> +
> +		ufs_mem_hc: ufs@1d84000 {
> +			compatible = "qcom,qcs8300-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
> +			reg = <0x0 0x01d84000 0x0 0x3000>;
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> +			phys = <&ufs_mem_phy>;
> +			phy-names = "ufsphy";
> +			lanes-per-direction = <2>;
> +			#reset-cells = <1>;
> +			resets = <&gcc GCC_UFS_PHY_BCR>;
> +			reset-names = "rst";
> +
> +			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
> +			required-opps = <&rpmhpd_opp_nom>;
> +
> +			iommus = <&apps_smmu 0x100 0x0>;
> +			dma-coherent;
> +
> +			interconnects = <&aggre1_noc MASTER_UFS_MEM 0

QCOM_ICC_TAG_ALWAYS, file-wide

[...]

> +		ufs_mem_phy: phy@1d87000 {
> +			compatible = "qcom,qcs8300-qmp-ufs-phy", "qcom,sa8775p-qmp-ufs-phy";
> +			reg = <0x0 0x01d87000 0x0 0xe10>;
> +			/*
> +			 * Yes, GCC_EDP_REF_CLKREF_EN is correct in qref. It
> +			 * enables the CXO clock to eDP *and* UFS PHY.
> +			 */
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
> +				 <&gcc GCC_EDP_REF_CLKREF_EN>;

Are you sure about this, or is this just copypasted from sa8775p?

[...]

> +
> +		intc: interrupt-controller@17a00000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
> +			      <0x0 0x17a60000 0x0 0x100000>;    /* GICR * 8 */

Drop these comments

> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			#redistributor-regions = <1>;
> +			redistributor-stride = <0x0 0x20000>;
> +		};
> +
> +		memtimer: timer@17c20000 {

Unused label

[...]

> +	arch_timer: timer {

Ditto

Konrad

