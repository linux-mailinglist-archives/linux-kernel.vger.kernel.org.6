Return-Path: <linux-kernel+bounces-443716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBB79EFAFB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E28169296
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1405223E92;
	Thu, 12 Dec 2024 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cdSPk2Ic"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B0223E75
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028350; cv=none; b=QG2yCeoGzZXF0+bKNIW7J93Q3oY2aNLwjUNi93ztLooLZXn4ZERpjXnhaV1qaNXDr287BBQFSSMRhxfhHRf+ud4FStwsT+dusy1+ZYd4f9WjEwN+hyHnFGaaVbWdOsueAuu7qGG6lINR+sv2w4AMCE73W9+O+Q3H892l2QM0oYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028350; c=relaxed/simple;
	bh=ab91+ueCYgrYH2bc5L7WlbOD9Ax1t0nzav8cgMZbK7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2DzmvFw13Y7t0yi3+eBgrU2vXTo9gUYYFQksqi+YC4J8qLawd4fXwaFNK3fP8TUxvVulUjClyb0cS3cO0kCurgNRpjWjINjIRhS+/WITZaP70vQH8qespdFqbM/CuHiYnIZyJa9VzfLL8abIYxkJVhu8wCJ8887cUkqSvYH548=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cdSPk2Ic; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCCE76R001145
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uxM7khpFXIRWVrEqLH01YG/cMrQdSKce000WX+jkPIo=; b=cdSPk2IcvGz6VJ1z
	vfGVxBlmbFyVE5jx5lwWH6+MoovacNQYMfI5jBBIGMSfYmMzNOVUHls6omsHNuEf
	kQW/h6k6GXCHXdLkKaxAZrv7mbPuisNwuL8cfJdo2tORAaCVNI3ThVDfE+vP1MEh
	/s//3lpXbHwNt1o/roRKoXfxCB5QYf0AkdpCynZiF704lNMXJOvkt3tCv/Nkemg+
	//jVjk7xhUirbz1gwNKynSlTA2BVQNuV7Bi4Bl20mixCJfK6L0QPDesL6dnxI/N2
	Fg/dohulBYophg/856blMrkcTeNpl/wd4/fA9eMW2oyeKPzo4jwHOSOYYbwnDMAL
	m8TOLA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fqes2db2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:32:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4679d6f9587so1756721cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734028347; x=1734633147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxM7khpFXIRWVrEqLH01YG/cMrQdSKce000WX+jkPIo=;
        b=iOKevXSIYevJHWz87uwFLzJxlenxo9s3t9UPE2ZRps0mnXzV+1uYMrJKze56TGTXUz
         12nwiNK3fcLGQe+vtvUgWe9hdv7cnjnMxXXenAq4XXa8OlMwdzwaIis0Cavx7cYHOrxH
         lxAZG/DFxR9NzMi0UOPwUMLK6DaGTFPicLc+hKEZt2IK2lXhh9c5oB4x7EDQTmq+ji0N
         EwNcrJRe+WWk1104CSXT9XXMswKZWZDtw0I/Zx9hna38khjKgTy6o4DLZpEvnMtJpHAW
         YVop+N4obY5X9akK9vLnzMx1FP7evPrOaYhfgH2TYrHwMKi/JxTquxZohI1zOKvH4FSi
         8L5g==
X-Forwarded-Encrypted: i=1; AJvYcCWt3AI+p3rO9cC0dVlZlFObZkxZIENjkNtmCWAufDqi120+x7DRs7el2+H6WSxLImDb7WxWkvDoYcq7Np8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUiGO9xnFkZ7qjc3AGwnBoCfT9/WcuRJAFF7UgyiZyC7doqqYd
	+jUdoBsEWMoF4rX8gzw0TqGD46FLnTPzcQhPg6/h7AQRMEv3tfUM64KXAcm3/+XWs/6FOMCwNVd
	i88O8ijEK0OX62sOnS0iCrmhypDdhrXxOkOD1sf5w6+btxMbznOi0qbhZb19Ia4w=
X-Gm-Gg: ASbGncuQxAqfAe7PBtU9RCxjGvfO6R6L+PYdBeOk/uJrJGDGLwoUMMd+/yIGBhNxiWw
	YLpScWEsMWZ7Pv0rijH2hJBBduZp5fySdpLvc7cYtNGbMXV0xBOl9098H41EGK4Gx6E+014691e
	zoWOzYSclaE1FZn9ss9rDsNLvXE9MPDBo2VCx01ExwwFgHKvdyZ7XBWv/SKXhq3eOZcjthWsW87
	+bHzCJpnAb1grCVERiJIXrUWa9tajwv+DUmOXei6uC5gaeHqyXsCewJtLY4Ne4vdPcfqQI5KkgB
	uqa/1SAKSzBnFqduU1nWrf6aBzRvp//op3kZ0Q==
X-Received: by 2002:a05:622a:494:b0:467:5eaf:7d22 with SMTP id d75a77b69052e-467a1619b60mr8325431cf.10.1734028347211;
        Thu, 12 Dec 2024 10:32:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnrfljY2vkd3Lt/DfsHE9Q4yKVSefuodPmXn/tMSCjfeYw6ACCIUoa/Od1A+jurMZ4xVqPMg==
X-Received: by 2002:a05:622a:494:b0:467:5eaf:7d22 with SMTP id d75a77b69052e-467a1619b60mr8325201cf.10.1734028346752;
        Thu, 12 Dec 2024 10:32:26 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6808c03a5sm669945466b.137.2024.12.12.10.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:32:26 -0800 (PST)
Message-ID: <22491b41-f081-45cc-8766-6b4c851516f4@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 19:32:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] arm64: dts: qcom: Add CMN PLL node for IPQ9574 SoC
To: Luo Jie <quic_luoj@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com,
        quic_suruchia@quicinc.com, quic_pavir@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
        bartosz.golaszewski@linaro.org, srinivas.kandagatla@linaro.org
References: <20241107-qcom_ipq_cmnpll-v6-0-a5cfe09de485@quicinc.com>
 <20241107-qcom_ipq_cmnpll-v6-4-a5cfe09de485@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241107-qcom_ipq_cmnpll-v6-4-a5cfe09de485@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XqEhIiQ1_cRjDmpqkoGmD1NkVqeRnkOz
X-Proofpoint-ORIG-GUID: XqEhIiQ1_cRjDmpqkoGmD1NkVqeRnkOz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120133

On 7.11.2024 10:50 AM, Luo Jie wrote:
> The CMN PLL clock controller allows selection of an input clock rate
> from a defined set of input clock rates. It in-turn supplies fixed
> rate output clocks to the hardware blocks that provide the ethernet
> functions such as PPE (Packet Process Engine) and connected switch or
> PHY, and to GCC.
> 
> The reference clock of CMN PLL is routed from XO to the CMN PLL through
> the internal WiFi block.
> .XO (48 MHZ or 96 MHZ)-->WiFi (multiplier/divider)-->48 MHZ to CMN PLL.
> 
> The reference input clock from WiFi to CMN PLL is fully controlled by
> the bootstrap pins which select the XO frequency (48 MHZ or 96 MHZ).
> Based on this frequency, the divider in the internal Wi-Fi block is
> automatically configured by hardware (1 for 48 MHZ, 2 for 96 MHZ), to
> ensure output clock to CMN PLL is 48 MHZ.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi | 16 ++++++++++++++-
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi            | 26 +++++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> index 91e104b0f865..78f6a2e053d5 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
> @@ -3,7 +3,7 @@
>   * IPQ9574 RDP board common device tree source
>   *
>   * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  /dts-v1/;
> @@ -164,6 +164,20 @@ &usb3 {
>  	status = "okay";
>  };
>  
> +/*
> + * The bootstrap pins for the board select the XO clock frequency,
> + * which automatically enables the right dividers to ensure the
> + * reference clock output from WiFi is 48 MHZ.

I'm a bit puzzled by this comment. Does it mean this clock could
run at some different speeds?

[...]

>  
> +		cmn_pll: clock-controller@9b000 {
> +			compatible = "qcom,ipq9574-cmn-pll";
> +			reg = <0x0009b000 0x800>;
> +			clocks = <&ref_48mhz_clk>,
> +				 <&gcc GCC_CMN_12GPLL_AHB_CLK>,
> +				 <&gcc GCC_CMN_12GPLL_SYS_CLK>;
> +			clock-names = "ref", "ahb", "sys";
> +			#clock-cells = <1>;
> +			assigned-clocks = <&cmn_pll CMN_PLL_CLK>;
> +			assigned-clock-rates-u64 = /bits/ 64 <12000000000>;

Does devlink not complain about self-referencing the clock here?

Konrad

