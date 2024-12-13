Return-Path: <linux-kernel+bounces-444807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7179F0CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5335A28308E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CB71DFD85;
	Fri, 13 Dec 2024 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OhyI+DD+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12081CF7A2
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094586; cv=none; b=XmXviGzYyP+RUjbzsoTeUh7C+I9gZTD2bLB7CiqCFvUQew5RsLxFYc6XGTBhK2x6IBwvkiG2XJbLzdJmgfih5q5tv0mjn+WDpEWjymQXS+x+W4LNn5R2+T2avFmqV5zhyonVs+yPBNQOVkxqlUQOIOfYlbFnEG6llOZvw81gJeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094586; c=relaxed/simple;
	bh=GMttzT4pot3dLqMBEdVTWxSOV0+jV+zYGFDjeNmFE4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CONNVlfef640whhHvmKyHtdz7l8RupZv59sDW1CVWVunE0cXxAYLSHKeqhe4tCghtVSm/3zNuJYN4/usKG+g43KHlXNryiXp+pA2wzCp4JSTAkbgLrOQOOX+pC+8xEj19jZyPqEmXD3Owr57TsFlaq3imPp3mySbO784ppy6CKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OhyI+DD+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9ZfMI005944
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SPsyxPu5glRW5NRlm6WjE2usv+YXfBn9Tyv4A04asGY=; b=OhyI+DD+Bx1Q9xNc
	dqttnd+unVGFf6/rG2ZpwZmGRZQ09gYvBQo08+Hle0/TyIvLrk/Gu+lmZXRSh7Wv
	DUUPZQBt+1yflmxqb5jknTJfDBSQOdvsXEKGJgx6Mq3EHe5pE6PIfFH1Zj+9gV3n
	LS4aW5j8Qe250iJKByU4+rgPxMJGbvf4Y+9nkkc64dhi1eMTbmAUTL7YKB+YmY7p
	d+4hVOv4kGaHS9E1W5mzKpFY2xD1XWiNWwd3+GwwICYG+LcrsMBsJiFlEk702VqD
	4lkkpo4yOMJ6LNphlYJzA2vSw2qqTWcCl/Hq0Gc4mXbn9pF3v4n+1toKzns+2Hcm
	X3Rilg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43g6xut6tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:56:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6f134dac1so21697785a.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734094568; x=1734699368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPsyxPu5glRW5NRlm6WjE2usv+YXfBn9Tyv4A04asGY=;
        b=okhgg3kw+8/Ic9zT8Bsm48+CAqumZnohXAbUFIvDoOmEA+oR4afP8y1jP41w2n1Jgu
         j5qlDkklFrdPxLYv9o1jtTlEta0/PwVbchTSw/B8J79beoxpPiuZaLVoRhk4ho2v0DbD
         2nuOozG71B6qa3nMt46Ze0PHyylTreSBhTNakwh4qpt9isHJUj6JzFAifhlAZRejisRU
         FzVIwM/nOEeK9JrZZBsZSNkczZ/FVLZ0pfP1OmZJAypuwrjXjIp87sSWVHF2a7LQkNRP
         p0sbvwk1nEXzrRS50cQO/J57HFuuh5tWUfkyOhZE0pHBJUQI3NZlmxoBWUD7mHQoKWfk
         /ShA==
X-Forwarded-Encrypted: i=1; AJvYcCUaOYhLzePPDfHmTmERx1QgHz5Nrayo2UtUtdSDort2zoRmNEeYECMf++0mnQIbeIhtsg+ryguXU1zvQPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKD0Ce4YrMsFgdR1wSO4f5yMKn5NQZMRtwCjcQkLtnF47I7sNu
	A7O0dU9EAw/5/elJ651GYEN5lxreWi86ZXwYWhlQuml4j/+SWcP7tfIDE/MuFsaGYLisbkIEdcb
	4W0WhVQil0BGrByl7Cn4ROMhAJ7P1RB7pdRbA9t9SHhLwyQ6eJOK5TVpCToEST+E=
X-Gm-Gg: ASbGncujlvYIH7MxofS+k9w8vaFRibYasr/d5V1Yhc1ZIcOao71cC9SRUATBud/o5dN
	9+v/+Cip/ME7oy0FmIQTH+PxmiZieQoUgDk0SNbHuY3s0yEkyo6igd4mUVWESd2mOJ0CuEDboTO
	LurNXtAiuhmD6AjERbj3mT5pOo964NFEvrzlExsjck8prlsL2W+V1zxDSQqoR8WpC9/Kvi4yAmP
	xQi0K2wPZqTchrOBcRtDAYVbpjlyl+siHJuGZI9jsxZzaPrjOdAF7yoxZwvQBl/ujU8Sjb1wfSs
	81Sun76kvrJ8IPYNUIEz/Rt85QGCNE7ptslV
X-Received: by 2002:a05:620a:2943:b0:7a9:bf88:7d9a with SMTP id af79cd13be357-7b6fbf33233mr136599685a.10.1734094568412;
        Fri, 13 Dec 2024 04:56:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhEp6KKzBxIcWe6wDHGk51pVr4pAr29fZikvoE3RJwni2r6ufWTfFBhktuM1lfYxiUEc1SFA==
X-Received: by 2002:a05:620a:2943:b0:7a9:bf88:7d9a with SMTP id af79cd13be357-7b6fbf33233mr136597485a.10.1734094568038;
        Fri, 13 Dec 2024 04:56:08 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3a80d6csm493602666b.8.2024.12.13.04.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 04:56:07 -0800 (PST)
Message-ID: <dac91ee1-4e1c-47d2-ba7b-6ab47582731f@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 13:56:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: qcs615: add SDHC1 and SDHC2
To: Yuanjie Yang <quic_yuanjiey@quicinc.com>, ulf.hansson@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        bhupesh.sharma@linaro.org, andersson@kernel.org,
        konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_tingweiz@quicinc.com
References: <20241206023711.2541716-1-quic_yuanjiey@quicinc.com>
 <20241206023711.2541716-2-quic_yuanjiey@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241206023711.2541716-2-quic_yuanjiey@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RTAy5su02Q4yJgWg2cYd077Xs3KiVPSP
X-Proofpoint-GUID: RTAy5su02Q4yJgWg2cYd077Xs3KiVPSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130091

On 6.12.2024 3:37 AM, Yuanjie Yang wrote:
> Add SDHC1 and SDHC2 support to the QCS615 Ride platform.
> 
> Signed-off-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 209 +++++++++++++++++++++++++++
>  1 file changed, 209 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> index 590beb37f441..e52bf8c77884 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> @@ -399,6 +399,72 @@ qfprom: efuse@780000 {
>  			#size-cells = <1>;
>  		};
>  
> +		sdhc_1: mmc@7c4000 {
> +			compatible = "qcom,qcs615-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x0 0x007c4000 0x0 0x1000>,
> +			      <0x0 0x007c5000 0x0 0x1000>,
> +			      <0x0 0x007c8000 0x0 0x8000>;
> +			reg-names = "hc",
> +				    "cqhci",
> +				    "ice";
> +
> +			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq",
> +					  "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_SDCC1_ICE_CORE_CLK>;
> +			clock-names = "iface",
> +				      "core",
> +				      "xo",
> +				      "ice";
> +
> +			resets = <&gcc GCC_SDCC1_BCR>;
> +
> +			power-domains = <&rpmhpd RPMHPD_CX>;
> +			operating-points-v2 = <&sdhc1_opp_table>;
> +			iommus = <&apps_smmu 0x02c0 0x0>;
> +			interconnects = <&aggre1_noc MASTER_SDCC_1 QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> +					 &config_noc SLAVE_SDCC_1 QCOM_ICC_TAG_ALWAYS>;

QCOM_ICC_TAG_ACTIVE_ONLY for the CPU path

> +			interconnect-names = "sdhc-ddr",
> +					     "cpu-sdhc";
> +
> +			qcom,dll-config = <0x000f642c>;
> +			qcom,ddr-config = <0x80040868>;
> +			supports-cqe;
> +			dma-coherent;
> +			status = "disabled";

Nit: please add a newline before status for consistency

(both comments apply to both controllers)

Konrad

