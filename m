Return-Path: <linux-kernel+bounces-433731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC31E9E5C4B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DCF283FBB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A51225763;
	Thu,  5 Dec 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hH3uGare"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8FE224B19
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417735; cv=none; b=f/GfklyBwshl+61EUoZnDArg7Zh4Ov34Aitzrw/CnY1vvPCctmuBCK/MuE74fjP0SXIq7FVghyC0bLYF4al1aQ7k/qyU0Y38khto+6F6EzyyS9UXr/UKcmA45O39f3xqo662lXNh9ameUigh+r2TNTR2WYosLQCgN7HxLuIQ/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417735; c=relaxed/simple;
	bh=I+r7NyhBCySrHUmUTasjt7eybB4bk+66IFCAfbgb2Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfKrkaxUUwVkYh9N8TnqIUGYqBgSyilmdDDR3Q3EQiVL0+DRrF8h0EM2drgHvMfnsi+Q/yyBsCK/+BhqzXPDyf+0EttS/qJoBmuMWs22sn2rOm51cHjap6MXRBebMKGhKYSy9PDgMXhauttJd4gCCAu7iqtvSh9dxQpuB/y13qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hH3uGare; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5EW4rI015937
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 16:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VOFQylGJgYNMCJcUBcofUAuX/+VKBXcVVeUUlHN8vVk=; b=hH3uGaren9vGIINs
	j2WI3cccYIp5+se1M6em2KECJk7kR2vZz6OIlY/IpflNiTiuYAtyRxbl+OrAOn+t
	l0/K+xO8ZdylPDpgUmQQK3kbVFjdJ8GQs7Vojxoy02N9jm/1/tTRC1NTp3nV+2mq
	reumS8wt8cUtz8hwlZEme0OdSdeA0Y4euv5rf/vmahH0KReq4TBuAatGX3Y/K24s
	fUxAakPP1/9ra3Z9Mu8YFvLu5uVZhN/MU3fWAJDJvUCJxyl7V3zTJewQt6UnKtbI
	N8JddbJ86tf0VyHP+VXNqmA5cof4Wzj35ofsOE8UfYbYp2525rxxLyW68d95fdFP
	8YjmmA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43be170dj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:55:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4668cee0202so2039611cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:55:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733417731; x=1734022531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOFQylGJgYNMCJcUBcofUAuX/+VKBXcVVeUUlHN8vVk=;
        b=WIbFYUFaC/nXV+NoaYyCTYlO1OQQjl+lSsiCn30xRFjVVelCBHYDQKGVTnqHyNVzjN
         Z/yRpbIQCbG5CLo5FamT4Kl3/oDJbXqCE8CKMqZlvmsNVDk7KjeR06bqmPqFXRGmAK7d
         CHAYqE2V4e0nkuuOTbKoqBLsBnVNcbC69snjLj04ZB9YNxbBwhmR+x1K6/0DHnWXBKZ5
         aSB3dISC04LwP2F+sT0xrLKfIPm+Y+t/b3Nkwpm5cO/wfF4/3GKCJHYdqPV+/8UZdE7J
         wkqpYhYvmff7nPsE7PoMSJLWbfjaU1zBdg49f6aLVErK0tSyR3LBk8+69FUDcH6vo8Om
         oHTA==
X-Forwarded-Encrypted: i=1; AJvYcCWO0DpEUM8tqKDPbTD+yBpwP6fUV2NKSRiusoInzwZzCH3pIVLF8GlcmsSXTGgalooe3uY6rfo9X7BFdUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqbnfxTGCG6VbG5rhswEN2WUPc/b4QRuEMLwfkDlQMG8xbpQsI
	rJK8eimS2cMKC7WYK4c74gwX2dcqhBmc7zD4Hk8eoJ04ii2KmF1xpYnN/UTd80JxZmX2825YcMH
	Uo3Dj60VsiE9N19aLP1q6wwsR+Ndn26Xs6N7O3HrTa0A58T7VnrFTm8BZtw7H3us=
X-Gm-Gg: ASbGncvI9BsCG1PK2Xzf03IcLLcfZJjrPQvqM3dec4s+366YUnTt6/z6TCE1nM2ibyL
	ISsRi4xcGeOCkAHBSEFX/a6efSArWJ28E3SYtWrApEhryxNzISMQXiG/dJ9rGHWkDXYQJeVOMEj
	tU+n+qSde4kqHQHp6sUv2p/UtRalO2/tOzk8xCXLZTbJ+Or3WVHLp+v4ZLziMWY7JxOlrKU41sY
	FgEca9hf7HADhsAY519X3cSDzYFnif+66txDtfLTevhxVI1AeVhO4h6ccNdBa/89xZuT2LI8yM8
	THpyOToRGN41Xj1EOe6ykOg8o5oddOw=
X-Received: by 2002:a05:622a:58c:b0:466:92d8:737f with SMTP id d75a77b69052e-4670c0c19d8mr67579621cf.8.1733417731450;
        Thu, 05 Dec 2024 08:55:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpOyIz3ExEZb6pa6ljRFBJV3XGl7gjiUagmYMxGVfn+2598vcJKlgl8xXch7qaXTeppX9Nrg==
X-Received: by 2002:a05:622a:58c:b0:466:92d8:737f with SMTP id d75a77b69052e-4670c0c19d8mr67579291cf.8.1733417730950;
        Thu, 05 Dec 2024 08:55:30 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4dc95sm115378266b.38.2024.12.05.08.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 08:55:30 -0800 (PST)
Message-ID: <6fe09de4-c94c-495d-92a4-aa902d2519ef@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 17:55:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: ipq5332: Add PCIe related nodes
To: Varadarajan Narayanan <quic_varada@quicinc.com>, lpieralisi@kernel.org,
        kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
        bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, p.zabel@pengutronix.de,
        quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc: Praveenkumar I <quic_ipkumar@quicinc.com>
References: <20241204113329.3195627-1-quic_varada@quicinc.com>
 <20241204113329.3195627-6-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241204113329.3195627-6-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yDIMnG0aNTTo4DK5mlAxWqCdknqY2rng
X-Proofpoint-ORIG-GUID: yDIMnG0aNTTo4DK5mlAxWqCdknqY2rng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050123

On 4.12.2024 12:33 PM, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Add phy and controller nodes for pcie0_x1 and pcie1_x2.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

[...]

> +		pcie0: pcie@20000000 {
> +			compatible = "qcom,pcie-ipq5332";
> +			reg =  <0x20000000 0xf1d>,
> +			       <0x20000F20 0xa8>,

Please use lowercase hex

> +			       <0x20001000 0x1000>,
> +			       <0x00080000 0x3000>,
> +			       <0x20100000 0x1000>;
> +			reg-names = "dbi", "elbi", "atu", "parf", "config";

Please also add the MHI region
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <1>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x01000000 0 0x20200000 0x20200000 0 0x00100000>, /* I/O */
> +				 <0x02000000 0 0x20300000 0x20300000 0 0x0fd00000>; /* MEM */

Please drop these comments
> +
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0",
> +					  "msi1",
> +					  "msi2",
> +					  "msi3",
> +					  "msi4",
> +					  "msi5",
> +					  "msi6",
> +					  "msi7";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 35 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 0 36 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 0 37 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 0 38 IRQ_TYPE_LEVEL_HIGH>; /* int_d */

And these too

> +
> +			clocks = <&gcc GCC_PCIE3X1_0_AXI_M_CLK>,
> +				 <&gcc GCC_PCIE3X1_0_AXI_S_CLK>,
> +				 <&gcc GCC_PCIE3X1_0_AXI_S_BRIDGE_CLK>,
> +				 <&gcc GCC_PCIE3X1_0_RCHG_CLK>,
> +				 <&gcc GCC_PCIE3X1_0_AHB_CLK>,
> +				 <&gcc GCC_PCIE3X1_0_AUX_CLK>;
> +
Stray newline

> +			clock-names = "axi_m",
> +				      "axi_s",
> +				      "axi_bridge",
> +				      "rchng",
> +				      "ahb",
> +				      "aux";
> +
> +			resets = <&gcc GCC_PCIE3X1_0_PIPE_ARES>,
> +				 <&gcc GCC_PCIE3X1_0_CORE_STICKY_ARES>,
> +				 <&gcc GCC_PCIE3X1_0_AXI_S_STICKY_ARES>,
> +				 <&gcc GCC_PCIE3X1_0_AXI_S_CLK_ARES>,
> +				 <&gcc GCC_PCIE3X1_0_AXI_M_STICKY_ARES>,
> +				 <&gcc GCC_PCIE3X1_0_AXI_M_CLK_ARES>,
> +				 <&gcc GCC_PCIE3X1_0_AUX_CLK_ARES>,
> +				 <&gcc GCC_PCIE3X1_0_AHB_CLK_ARES>;
> +
Ditto

> +			reset-names = "pipe",
> +				      "sticky",
> +				      "axi_s_sticky",
> +				      "axi_s",
> +				      "axi_m_sticky",
> +				      "axi_m",
> +				      "aux",
> +				      "ahb";
> +
> +			phys = <&pcie0_phy>;
> +			phy-names = "pciephy";
> +
> +			interconnects = <&gcc MASTER_SNOC_PCIE3_1_M &gcc SLAVE_SNOC_PCIE3_1_M>,
> +					<&gcc MASTER_ANOC_PCIE3_1_S &gcc SLAVE_ANOC_PCIE3_1_S>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";
> +
> +			msi-map = <0x0 &v2m0 0x0 0xffd>;
> +			status = "disabled";
> +		};
> +
> +		pcie1: pcie@18000000 {

Same comments as pcie0

Konrad

