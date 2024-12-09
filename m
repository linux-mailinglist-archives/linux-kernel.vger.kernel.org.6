Return-Path: <linux-kernel+bounces-436656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D00BB9E8917
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BCB282FE2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 02:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C003D3B3;
	Mon,  9 Dec 2024 02:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WbHaGdDl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEBD4C91;
	Mon,  9 Dec 2024 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733709725; cv=none; b=fSxlUD19zWetJblEVvxiKT8xR9/jXOVElnju2h5ID50i1bDEcMil14MTi8f8JwYmgK2ZEApe1hfH/SY4nXMdzJRmt8Pl7/SOJGvV6HQ0LmjgLs7yZ/sORUMsYznuD38YF3Yfzf512qKIpdfEqnZ5HHgas0wjgch7eBoklPcBWRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733709725; c=relaxed/simple;
	bh=bPlPNZHgZikC9Hnnh24awFrk5DXr7B97LSdAzwZYfgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NozguvWO0PWg2tJYZAu8Wsaguzw5/bq1eDqG+bB5sJxmIglzYWIk/vLOG6H8ELWtUled8jI52fba5jfXsBs3z70SCyEf767ULshnIshhUfnOFByMSUKtEEPfeoexA2HwBPRBsZ1Vcmve3/p5hsDa17KCC7kaEF9rNGf58fGi68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WbHaGdDl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8MWspg031776;
	Mon, 9 Dec 2024 02:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IresmKe1mjwpJSHLQfjQSYUnCJJGMLNdO1oSBM8tT1I=; b=WbHaGdDl1BrQNCQc
	jPZHUTW0TNZshAzbNArx3MId4z3/+jV9xU+7CQG+3kCGwx0EWAuwrqp6nutuP3Q0
	IXW/vogMpOoohX/CrHmSjgSW8hkXxFkKjohi66AdW6EMX+6OQREomSx/kgJdo4w0
	QehbERUbNFiypJL0mxVLMjQDKEDbuHjG0Y+Qvg5T87u/u4pSmtbeZNS1n/UJw29n
	/q6IZ35c8JPWen2q9/OEqL5he9XlmtCWmNsNcgBM+8bseEbzIWqS30w9t9Gs6KmY
	WT78STeNGIkbukheNT5eN3Mli8PoFUjMpnwGbl2EasoHY19I6EUjwPFwGM36OJkj
	LQbJUA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cbqn38cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 02:01:56 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B921tQt008881
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 02:01:55 GMT
Received: from [10.64.68.153] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 8 Dec 2024
 18:01:51 -0800
Message-ID: <25a410a7-2418-45bd-be06-3672a9fb1928@quicinc.com>
Date: Mon, 9 Dec 2024 10:01:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: Add coresight nodes for QCS8300
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241205084418.671631-1-quic_jiegan@quicinc.com>
 <16efb6a8-ecaf-4097-ac5f-368ebab177a8@quicinc.com>
Content-Language: en-US
From: Jie Gan <quic_jiegan@quicinc.com>
In-Reply-To: <16efb6a8-ecaf-4097-ac5f-368ebab177a8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t8sLhEEnpo--JP_g0tcohY2rh8esl8nD
X-Proofpoint-GUID: t8sLhEEnpo--JP_g0tcohY2rh8esl8nD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090015



On 12/8/2024 12:28 AM, Aiqun Yu (Maria) wrote:
> 
> 
> On 12/5/2024 4:44 PM, Jie Gan wrote:
>> Add following coresight components for QCS8300 platform.
>> It includes CTI, dummy sink, dynamic Funnel, Replicator, STM,
>> TPDM, TPDA and TMC ETF.
>>
>> Signed-off-by: Jie Gan <quic_jiegan@quicinc.com>
>> ---
>> Changes in V2:
>> 1. Rebased on tag next-20241204.
>> 2. Padding the register address to 8 bits.
>> Link to V1 - https://lore.kernel.org/linux-arm-msm/20240929-add_coresight_devices_for_qcs8300-v1-1-4f14e8cb8955@quicinc.com/
>> ---
>>   arch/arm64/boot/dts/qcom/qcs8300.dtsi | 2150 +++++++++++++++++++++++++
>>   1 file changed, 2150 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
>> index 73abf2ef9c9f..eaec674950d8 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
>> @@ -293,6 +293,18 @@ system_sleep: domain-sleep {
>>   		};
>>   	};
>>   
>> +	dummy_eud: dummy-sink {
>> +		compatible = "arm,coresight-dummy-sink";
>> +
>> +		in-ports {
>> +			port {
>> +				eud_in: endpoint {
>> +					remote-endpoint = <&swao_rep_out1>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +

[...]

>> +
>> +		tpdm@482c000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x0482c000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +			status = "disabled";
> 
> Could you please provide more detailed information on why some TPDM
> nodes are disabled by default while others are not?
Some of TPDM nodes are disabled by default because the one of the 
following reasons:
1. TPDM device are designed to generate HW events, it needs a clock 
source to read&write its registers. Coresight driver cannot control the 
clock source ouside AP core, so those TPDM devices without enabled clock 
source will crash device in probe.
2. Some of TPDM devices can't bootup with fused devices.
3. Some of TPDM devices have known hardware issues that not resolved.

I put those disabled TPDM devices in DT in case some of them may be 
"fixed" in future.

Thanks,
Jie

>> +
>> +			out-ports {
>> +				port {
>> +					gcc_tpdm_out: endpoint {
>> +						remote-endpoint = <&dlct0_tpda_in20>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4841000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04841000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <32>;
>> +			qcom,cmb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					prng_tpdm_out: endpoint {
>> +						remote-endpoint = <&dlct0_tpda_in19>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4850000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04850000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <64>;
>> +			qcom,cmb-msrs-num = <32>;
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					pimem_tpdm_out: endpoint {
>> +						remote-endpoint = <&dlct0_tpda_in25>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4860000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04860000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					dlst_ch_tpdm0_out: endpoint {
>> +						remote-endpoint = <&dlst_ch_tpda_in8>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4861000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04861000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <64>;
>> +			qcom,cmb-msrs-num = <32>;
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					dlst_ch_tpdm1_out: endpoint {
>> +						remote-endpoint = <&dlst_ch_tpda_in9>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpda@4864000 {
>> +			compatible = "qcom,coresight-tpda", "arm,primecell";
>> +			reg = <0x0 0x04864000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@8 {
>> +					reg = <8>;
>> +
>> +					dlst_ch_tpda_in8: endpoint {
>> +						remote-endpoint = <&dlst_ch_tpdm0_out>;
>> +					};
>> +				};
>> +
>> +				port@9 {
>> +					reg = <9>;
>> +
>> +					dlst_ch_tpda_in9: endpoint {
>> +						remote-endpoint = <&dlst_ch_tpdm1_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					dlst_ch_tpda_out: endpoint {
>> +						remote-endpoint = <&dlst_ch_funnel_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		funnel@4865000 {
>> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>> +			reg = <0x0 0x04865000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +
>> +					dlst_ch_funnel_in0: endpoint {
>> +						remote-endpoint = <&dlst_ch_tpda_out>;
>> +					};
>> +				};
>> +
>> +				port@4 {
>> +					reg = <4>;
>> +
>> +					dlst_ch_funnel_in4: endpoint {
>> +						remote-endpoint = <&dlst_funnel_out>;
>> +					};
>> +				};
>> +
>> +				port@6 {
>> +					reg = <6>;
>> +
>> +					dlst_ch_funnel_in6: endpoint {
>> +						remote-endpoint = <&gdsp_funnel_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					dlst_ch_funnel_out: endpoint {
>> +						remote-endpoint = <&funnel1_in7>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4980000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04980000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					turing2_tpdm_out: endpoint {
>> +						remote-endpoint = <&turing2_funnel_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		funnel@4983000 {
>> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>> +			reg = <0x0 0x04983000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				port {
>> +					turing2_funnel_in0: endpoint {
>> +						remote-endpoint = <&turing2_tpdm_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					turing2_funnel_out0: endpoint {
>> +						remote-endpoint = <&gdsp_tpda_in5>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@49ca000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x049ca000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <32>;
>> +			qcom,cmb-msrs-num = <32>;
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					sdcc_tpdm_out: endpoint {
>> +						remote-endpoint = <&dlst_tpda_in1>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@49c0000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x049c0000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <64>;
>> +			qcom,cmb-msrs-num = <32>;
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					rdpm_tpdm_out: endpoint {
>> +						remote-endpoint = <&dlct0_tpda_in23>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@49d0000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x049d0000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					qm_tpdm_out: endpoint {
>> +						remote-endpoint = <&dlct0_tpda_in21>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4ac0000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04ac0000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					dlmm_tpdm0_out: endpoint {
>> +						remote-endpoint = <&dlmm_tpda_in27>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4ac1000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04ac1000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <64>;
>> +			qcom,cmb-msrs-num = <32>;
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					dlmm_tpdm1_out: endpoint {
>> +						remote-endpoint = <&dlmm_tpda_in28>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpda@4ac4000 {
>> +			compatible = "qcom,coresight-tpda", "arm,primecell";
>> +			reg = <0x0 0x04ac4000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@8 {
>> +					reg = <8>;
>> +
>> +					dlmm_tpda_in8: endpoint {
>> +						remote-endpoint = <&mdss1_tpdm_out>;
>> +					};
>> +				};
>> +
>> +				port@1b {
>> +					reg = <27>;
>> +
>> +					dlmm_tpda_in27: endpoint {
>> +						remote-endpoint = <&dlmm_tpdm0_out>;
>> +					};
>> +				};
>> +
>> +				port@1c {
>> +					reg = <28>;
>> +
>> +					dlmm_tpda_in28: endpoint {
>> +						remote-endpoint = <&dlmm_tpdm1_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					dlmm_tpda_out: endpoint {
>> +						remote-endpoint = <&dlmm_funnel_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		funnel@4ac5000 {
>> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>> +			reg = <0x0 0x04ac5000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				port {
>> +					dlmm_funnel_in0: endpoint {
>> +						remote-endpoint = <&dlmm_tpda_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					dlmm_funnel_out: endpoint {
>> +						remote-endpoint = <&funnel1_in6>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4ad0000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04ad0000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					dlct0_tpdm0_out: endpoint {
>> +						remote-endpoint = <&dlct0_tpda_in26>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4ad1000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04ad1000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <64>;
>> +			qcom,cmb-msrs-num = <32>;
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					dlct0_tpdm1_out: endpoint {
>> +						remote-endpoint = <&dlct0_tpda_in27>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpda@4ad3000 {
>> +			compatible = "qcom,coresight-tpda", "arm,primecell";
>> +			reg = <0x0 0x04ad3000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@13 {
>> +					reg = <19>;
>> +
>> +					dlct0_tpda_in19: endpoint {
>> +						remote-endpoint = <&prng_tpdm_out>;
>> +					};
>> +				};
>> +
>> +				port@14 {
>> +					reg = <20>;
>> +
>> +					dlct0_tpda_in20: endpoint {
>> +						remote-endpoint = <&gcc_tpdm_out>;
>> +					};
>> +				};
>> +
>> +				port@15 {
>> +					reg = <21>;
>> +
>> +					dlct0_tpda_in21: endpoint {
>> +						remote-endpoint = <&qm_tpdm_out>;
>> +					};
>> +				};
>> +
>> +				port@17 {
>> +					reg = <23>;
>> +
>> +					dlct0_tpda_in23: endpoint {
>> +						remote-endpoint = <&rdpm_tpdm_out>;
>> +					};
>> +				};
>> +
>> +				port@19 {
>> +					reg = <25>;
>> +
>> +					dlct0_tpda_in25: endpoint {
>> +						remote-endpoint = <&pimem_tpdm_out>;
>> +					};
>> +				};
>> +
>> +				port@1a {
>> +					reg = <26>;
>> +
>> +					dlct0_tpda_in26: endpoint {
>> +						remote-endpoint = <&dlct0_tpdm0_out>;
>> +					};
>> +				};
>> +
>> +				port@1b {
>> +					reg = <27>;
>> +
>> +					dlct0_tpda_in27: endpoint {
>> +						remote-endpoint = <&dlct0_tpdm1_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					dlct0_tpda_out: endpoint {
>> +						remote-endpoint = <&dlct0_funnel_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		funnel@4ad4000 {
>> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>> +			reg = <0x0 0x04ad4000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +
>> +					dlct0_funnel_in0: endpoint {
>> +						remote-endpoint = <&dlct0_tpda_out>;
>> +					};
>> +				};
>> +
>> +				port@4 {
>> +					reg = <4>;
>> +
>> +					dlct0_funnel_in4: endpoint {
>> +						remote-endpoint = <&ddr_funnel5_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					dlct0_funnel_out: endpoint {
>> +						remote-endpoint = <&funnel1_in5>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		funnel@4b04000 {
>> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>> +			reg = <0x0 0x04b04000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@6 {
>> +					reg = <6>;
>> +
>> +					aoss_funnel_in6: endpoint {
>> +						remote-endpoint = <&aoss_tpda_out>;
>> +					};
>> +				};
>> +
>> +				port@7 {
>> +					reg = <7>;
>> +
>> +					aoss_funnel_in7: endpoint {
>> +						remote-endpoint = <&qdss_funnel_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					aoss_funnel_out: endpoint {
>> +						remote-endpoint = <&etf0_in>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tmc_etf: tmc@4b05000 {
>> +			compatible = "arm,coresight-tmc", "arm,primecell";
>> +			reg = <0x0 0x04b05000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				port {
>> +					etf0_in: endpoint {
>> +						remote-endpoint = <&aoss_funnel_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					etf0_out: endpoint {
>> +						remote-endpoint = <&swao_rep_in>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		replicator@4b06000 {
>> +			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
>> +			reg = <0x0 0x04b06000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				port {
>> +					swao_rep_in: endpoint {
>> +						remote-endpoint = <&etf0_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@1 {
>> +					reg = <1>;
>> +
>> +					swao_rep_out1: endpoint {
>> +						remote-endpoint = <&eud_in>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpda@4b08000 {
>> +			compatible = "qcom,coresight-tpda", "arm,primecell";
>> +			reg = <0x0 0x04b08000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +
>> +					aoss_tpda_in0: endpoint {
>> +						remote-endpoint = <&aoss_tpdm0_out>;
>> +					};
>> +				};
>> +
>> +				port@1 {
>> +					reg = <1>;
>> +
>> +					aoss_tpda_in1: endpoint {
>> +						remote-endpoint = <&aoss_tpdm1_out>;
>> +					};
>> +				};
>> +
>> +				port@2 {
>> +					reg = <2>;
>> +
>> +					aoss_tpda_in2: endpoint {
>> +						remote-endpoint = <&aoss_tpdm2_out>;
>> +					};
>> +				};
>> +
>> +				port@3 {
>> +					reg = <3>;
>> +
>> +					aoss_tpda_in3: endpoint {
>> +						remote-endpoint = <&aoss_tpdm3_out>;
>> +					};
>> +				};
>> +
>> +				port@4 {
>> +					reg = <4>;
>> +
>> +					aoss_tpda_in4: endpoint {
>> +						remote-endpoint = <&aoss_tpdm4_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					aoss_tpda_out: endpoint {
>> +						remote-endpoint = <&aoss_funnel_in6>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4b09000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04b09000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <64>;
>> +			qcom,cmb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					aoss_tpdm0_out: endpoint {
>> +						remote-endpoint = <&aoss_tpda_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4b0a000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04b0a000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <64>;
>> +			qcom,cmb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					aoss_tpdm1_out: endpoint {
>> +						remote-endpoint = <&aoss_tpda_in1>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4b0b000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04b0b000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <64>;
>> +			qcom,cmb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					aoss_tpdm2_out: endpoint {
>> +						remote-endpoint = <&aoss_tpda_in2>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4b0c000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04b0c000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <64>;
>> +			qcom,cmb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					aoss_tpdm3_out: endpoint {
>> +						remote-endpoint = <&aoss_tpda_in3>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4b0d000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04b0d000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					aoss_tpdm4_out: endpoint {
>> +						remote-endpoint = <&aoss_tpda_in4>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		cti@4b13000 {
>> +			compatible = "arm,coresight-cti", "arm,primecell";
>> +			reg = <0x0 0x04b13000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +		};
>> +
>> +		tpdm@4b80000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04b80000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					turing0_tpdm0_out: endpoint {
>> +						remote-endpoint = <&turing0_tpda_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4b81000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04b81000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <32>;
>> +			qcom,cmb-msrs-num = <32>;
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					turing0_tpdm1_out: endpoint {
>> +						remote-endpoint = <&turing0_tpda_in1>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4b82000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04b82000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <32>;
>> +			qcom,cmb-msrs-num = <32>;
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					turing0_tpdm2_out: endpoint {
>> +						remote-endpoint = <&turing0_tpda_in2>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4b83000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04b83000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <64>;
>> +			qcom,cmb-msrs-num = <32>;
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					turing0_tpdm3_out: endpoint {
>> +						remote-endpoint = <&turing0_tpda_in3>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4b84000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04b84000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <64>;
>> +			qcom,cmb-msrs-num = <32>;
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					turing0_tpdm4_out: endpoint {
>> +						remote-endpoint = <&turing0_tpda_in4>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpda@4b86000 {
>> +			compatible = "qcom,coresight-tpda", "arm,primecell";
>> +			reg = <0x0 0x04b86000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +
>> +					turing0_tpda_in0: endpoint {
>> +						remote-endpoint = <&turing0_tpdm0_out>;
>> +					};
>> +				};
>> +
>> +				port@1 {
>> +					reg = <1>;
>> +
>> +					turing0_tpda_in1: endpoint {
>> +						remote-endpoint = <&turing0_tpdm1_out>;
>> +					};
>> +				};
>> +
>> +				port@2 {
>> +					reg = <2>;
>> +
>> +					turing0_tpda_in2: endpoint {
>> +						remote-endpoint = <&turing0_tpdm2_out>;
>> +					};
>> +				};
>> +
>> +				port@3 {
>> +					reg = <3>;
>> +
>> +					turing0_tpda_in3: endpoint {
>> +						remote-endpoint = <&turing0_tpdm3_out>;
>> +					};
>> +				};
>> +
>> +				port@4 {
>> +					reg = <4>;
>> +
>> +					turing0_tpda_in4: endpoint {
>> +						remote-endpoint = <&turing0_tpdm4_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					turing0_tpda_out: endpoint {
>> +						remote-endpoint = <&turing0_funnel_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		funnel@4b87000 {
>> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>> +			reg = <0x0 0x04b87000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				port {
>> +					turing0_funnel_in0: endpoint {
>> +						remote-endpoint = <&turing0_tpda_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					turing0_funnel_out: endpoint {
>> +						remote-endpoint = <&gdsp_funnel_in4>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		cti@4b8b000 {
>> +			compatible = "arm,coresight-cti", "arm,primecell";
>> +			reg = <0x0 0x04b8b000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +		};
>> +
>> +		tpdm@4c40000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04c40000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					gdsp_tpdm0_out: endpoint {
>> +						remote-endpoint = <&gdsp_tpda_in8>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4c41000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04c41000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <64>;
>> +			qcom,cmb-msrs-num = <32>;
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					gdsp_tpdm1_out: endpoint {
>> +						remote-endpoint = <&gdsp_tpda_in9>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpda@4c44000 {
>> +			compatible = "qcom,coresight-tpda", "arm,primecell";
>> +			reg = <0x0 0x04c44000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@5 {
>> +					reg = <5>;
>> +
>> +					gdsp_tpda_in5: endpoint {
>> +						remote-endpoint = <&turing2_funnel_out0>;
>> +					};
>> +				};
>> +
>> +				port@8 {
>> +					reg = <8>;
>> +
>> +					gdsp_tpda_in8: endpoint {
>> +						remote-endpoint = <&gdsp_tpdm0_out>;
>> +					};
>> +				};
>> +
>> +				port@9 {
>> +					reg = <9>;
>> +
>> +					gdsp_tpda_in9: endpoint {
>> +						remote-endpoint = <&gdsp_tpdm1_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					gdsp_tpda_out: endpoint {
>> +						remote-endpoint = <&gdsp_funnel_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		funnel@4c45000 {
>> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>> +			reg = <0x0 0x04c45000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +
>> +					gdsp_funnel_in0: endpoint {
>> +						remote-endpoint = <&gdsp_tpda_out>;
>> +					};
>> +				};
>> +
>> +				port@4 {
>> +					reg = <4>;
>> +
>> +					gdsp_funnel_in4: endpoint {
>> +						remote-endpoint = <&turing0_funnel_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					gdsp_funnel_out: endpoint {
>> +						remote-endpoint = <&dlst_ch_funnel_in6>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4c50000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04c50000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					dlst_tpdm0_out: endpoint {
>> +						remote-endpoint = <&dlst_tpda_in8>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4c51000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04c51000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <64>;
>> +			qcom,cmb-msrs-num = <32>;
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					dlst_tpdm1_out: endpoint {
>> +						remote-endpoint = <&dlst_tpda_in9>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpda@4c54000 {
>> +			compatible = "qcom,coresight-tpda", "arm,primecell";
>> +			reg = <0x0 0x04c54000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@1 {
>> +					reg = <1>;
>> +
>> +					dlst_tpda_in1: endpoint {
>> +						remote-endpoint = <&sdcc_tpdm_out>;
>> +					};
>> +				};
>> +
>> +				port@8 {
>> +					reg = <8>;
>> +
>> +					dlst_tpda_in8: endpoint {
>> +						remote-endpoint = <&dlst_tpdm0_out>;
>> +					};
>> +				};
>> +
>> +				port@9 {
>> +					reg = <9>;
>> +
>> +					dlst_tpda_in9: endpoint {
>> +						remote-endpoint = <&dlst_tpdm1_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					dlst_tpda_out: endpoint {
>> +						remote-endpoint = <&dlst_funnel_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		funnel@4c55000 {
>> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>> +			reg = <0x0 0x04c55000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				port {
>> +					dlst_funnel_in0: endpoint {
>> +						remote-endpoint = <&dlst_tpda_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					dlst_funnel_out: endpoint {
>> +						remote-endpoint = <&dlst_ch_funnel_in4>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4c70000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04c70000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +			qcom,cmb-element-bits = <32>;
>> +			qcom,cmb-msrs-num = <32>;
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					mdss1_tpdm_out: endpoint {
>> +						remote-endpoint = <&dlmm_tpda_in8>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4e00000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04e00000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +			qcom,cmb-element-bits = <32>;
>> +			qcom,cmb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					ddr_tpdm3_out: endpoint {
>> +						remote-endpoint = <&ddr_tpda_in4>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4e01000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04e01000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <64>;
>> +			qcom,cmb-msrs-num = <32>;
>> +			status = "disabled";
>> +
>> +			out-ports {
>> +				port {
>> +					ddr_tpdm4_out: endpoint {
>> +						remote-endpoint = <&ddr_tpda_in5>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpda@4e03000 {
>> +			compatible = "qcom,coresight-tpda", "arm,primecell";
>> +			reg = <0x0 0x04e03000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +
>> +					ddr_tpda_in0: endpoint {
>> +						remote-endpoint = <&ddr_funnel0_out0>;
>> +					};
>> +				};
>> +
>> +				port@1 {
>> +					reg = <1>;
>> +
>> +					ddr_tpda_in1: endpoint {
>> +						remote-endpoint = <&ddr_funnel1_out0>;
>> +					};
>> +				};
>> +
>> +				port@4 {
>> +					reg = <4>;
>> +
>> +					ddr_tpda_in4: endpoint {
>> +						remote-endpoint = <&ddr_tpdm3_out>;
>> +					};
>> +				};
>> +
>> +				port@5 {
>> +					reg = <5>;
>> +
>> +					ddr_tpda_in5: endpoint {
>> +						remote-endpoint = <&ddr_tpdm4_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					ddr_tpda_out: endpoint {
>> +						remote-endpoint = <&ddr_funnel5_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		funnel@4e04000 {
>> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>> +			reg = <0x0 0x04e04000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				port {
>> +					ddr_funnel5_in0: endpoint {
>> +						remote-endpoint = <&ddr_tpda_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					ddr_funnel5_out: endpoint {
>> +						remote-endpoint = <&dlct0_funnel_in4>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4e10000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04e10000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					ddr_tpdm0_out: endpoint {
>> +						remote-endpoint = <&ddr_funnel0_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		funnel@4e12000 {
>> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>> +			reg = <0x0 0x04e12000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				port {
>> +					ddr_funnel0_in0: endpoint {
>> +						remote-endpoint = <&ddr_tpdm0_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					ddr_funnel0_out0: endpoint {
>> +						remote-endpoint = <&ddr_tpda_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@4e20000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x04e20000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					ddr_tpdm1_out: endpoint {
>> +						remote-endpoint = <&ddr_funnel1_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		funnel@4e22000 {
>> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>> +			reg = <0x0 0x04e22000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				port {
>> +					ddr_funnel1_in0: endpoint {
>> +						remote-endpoint = <&ddr_tpdm1_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					ddr_funnel1_out0: endpoint {
>> +						remote-endpoint = <&ddr_tpda_in1>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		etm@6040000 {
>> +			compatible = "arm,primecell";
>> +			reg = <0x0 0x06040000 0x0 0x1000>;
>> +			cpu = <&cpu0>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			arm,coresight-loses-context-with-cpu;
>> +			qcom,skip-power-up;
>> +
>> +			out-ports {
>> +				port {
>> +					etm0_out: endpoint {
>> +						remote-endpoint = <&apss_funnel0_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		etm@6140000 {
>> +			compatible = "arm,primecell";
>> +			reg = <0x0 0x06140000 0x0 0x1000>;
>> +			cpu = <&cpu1>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			arm,coresight-loses-context-with-cpu;
>> +			qcom,skip-power-up;
>> +
>> +			out-ports {
>> +				port {
>> +					etm1_out: endpoint {
>> +						remote-endpoint = <&apss_funnel0_in1>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		etm@6240000 {
>> +			compatible = "arm,primecell";
>> +			reg = <0x0 0x06240000 0x0 0x1000>;
>> +			cpu = <&cpu2>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			arm,coresight-loses-context-with-cpu;
>> +			qcom,skip-power-up;
>> +
>> +			out-ports {
>> +				port {
>> +					etm2_out: endpoint {
>> +						remote-endpoint = <&apss_funnel0_in2>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		etm@6340000 {
>> +			compatible = "arm,primecell";
>> +			reg = <0x0 0x06340000 0x0 0x1000>;
>> +			cpu = <&cpu3>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			arm,coresight-loses-context-with-cpu;
>> +			qcom,skip-power-up;
>> +
>> +			out-ports {
>> +				port {
>> +					etm3_out: endpoint {
>> +						remote-endpoint = <&apss_funnel0_in3>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		etm@6440000 {
>> +			compatible = "arm,primecell";
>> +			reg = <0x0 0x06440000 0x0 0x1000>;
>> +			cpu = <&cpu4>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			arm,coresight-loses-context-with-cpu;
>> +			qcom,skip-power-up;
>> +
>> +			out-ports {
>> +				port {
>> +					etm4_out: endpoint {
>> +						remote-endpoint = <&apss_funnel0_in4>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		etm@6540000 {
>> +			compatible = "arm,primecell";
>> +			reg = <0x0 0x06540000 0x0 0x1000>;
>> +			cpu = <&cpu5>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			arm,coresight-loses-context-with-cpu;
>> +			qcom,skip-power-up;
>> +
>> +			out-ports {
>> +				port {
>> +					etm5_out: endpoint {
>> +						remote-endpoint = <&apss_funnel0_in5>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		etm@6640000 {
>> +			compatible = "arm,primecell";
>> +			reg = <0x0 0x06640000 0x0 0x1000>;
>> +			cpu = <&cpu6>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			arm,coresight-loses-context-with-cpu;
>> +			qcom,skip-power-up;
>> +
>> +			out-ports {
>> +				port {
>> +					etm6_out: endpoint {
>> +						remote-endpoint = <&apss_funnel0_in6>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		etm@6740000 {
>> +			compatible = "arm,primecell";
>> +			reg = <0x0 0x06740000 0x0 0x1000>;
>> +			cpu = <&cpu7>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			arm,coresight-loses-context-with-cpu;
>> +			qcom,skip-power-up;
>> +
>> +			out-ports {
>> +				port {
>> +					etm7_out: endpoint {
>> +						remote-endpoint = <&apss_funnel0_in7>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		funnel@6800000 {
>> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>> +			reg = <0x0 0x06800000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +
>> +					apss_funnel0_in0: endpoint {
>> +						remote-endpoint = <&etm0_out>;
>> +					};
>> +				};
>> +
>> +				port@1 {
>> +					reg = <1>;
>> +
>> +					apss_funnel0_in1: endpoint {
>> +						remote-endpoint = <&etm1_out>;
>> +					};
>> +				};
>> +
>> +				port@2 {
>> +					reg = <2>;
>> +
>> +					apss_funnel0_in2: endpoint {
>> +						remote-endpoint = <&etm2_out>;
>> +					};
>> +				};
>> +
>> +				port@3 {
>> +					reg = <3>;
>> +
>> +					apss_funnel0_in3: endpoint {
>> +						remote-endpoint = <&etm3_out>;
>> +					};
>> +				};
>> +
>> +				port@4 {
>> +					reg = <4>;
>> +
>> +					apss_funnel0_in4: endpoint {
>> +						remote-endpoint = <&etm4_out>;
>> +					};
>> +				};
>> +
>> +				port@5 {
>> +					reg = <5>;
>> +
>> +					apss_funnel0_in5: endpoint {
>> +						remote-endpoint = <&etm5_out>;
>> +					};
>> +				};
>> +
>> +				port@6 {
>> +					reg = <6>;
>> +
>> +					apss_funnel0_in6: endpoint {
>> +						remote-endpoint = <&etm6_out>;
>> +					};
>> +				};
>> +
>> +				port@7 {
>> +					reg = <7>;
>> +
>> +					apss_funnel0_in7: endpoint {
>> +						remote-endpoint = <&etm7_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					apss_funnel0_out: endpoint {
>> +						remote-endpoint = <&apss_funnel1_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		funnel@6810000 {
>> +			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>> +			reg = <0x0 0x06810000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +
>> +					apss_funnel1_in0: endpoint {
>> +						remote-endpoint = <&apss_funnel0_out>;
>> +					};
>> +				};
>> +
>> +				port@3 {
>> +					reg = <3>;
>> +
>> +					apss_funnel1_in3: endpoint {
>> +						remote-endpoint = <&apss_tpda_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					apss_funnel1_out: endpoint {
>> +						remote-endpoint = <&funnel1_in4>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		cti@682b000 {
>> +			compatible = "arm,coresight-cti", "arm,primecell";
>> +			reg = <0x0 0x0682b000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +		};
>> +
>> +		tpdm@6860000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x06860000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <64>;
>> +			qcom,cmb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					apss_tpdm3_out: endpoint {
>> +						remote-endpoint = <&apss_tpda_in3>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@6861000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x06861000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					apss_tpdm4_out: endpoint {
>> +						remote-endpoint = <&apss_tpda_in4>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpda@6863000 {
>> +			compatible = "qcom,coresight-tpda", "arm,primecell";
>> +			reg = <0x0 0x06863000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +
>> +					apss_tpda_in0: endpoint {
>> +						remote-endpoint = <&apss_tpdm0_out>;
>> +					};
>> +				};
>> +
>> +				port@1 {
>> +					reg = <1>;
>> +
>> +					apss_tpda_in1: endpoint {
>> +						remote-endpoint = <&apss_tpdm1_out>;
>> +					};
>> +				};
>> +
>> +				port@2 {
>> +					reg = <2>;
>> +
>> +					apss_tpda_in2: endpoint {
>> +						remote-endpoint = <&apss_tpdm2_out>;
>> +					};
>> +				};
>> +
>> +				port@3 {
>> +					reg = <3>;
>> +
>> +					apss_tpda_in3: endpoint {
>> +						remote-endpoint = <&apss_tpdm3_out>;
>> +					};
>> +				};
>> +
>> +				port@4 {
>> +					reg = <4>;
>> +
>> +					apss_tpda_in4: endpoint {
>> +						remote-endpoint = <&apss_tpdm4_out>;
>> +					};
>> +				};
>> +			};
>> +
>> +			out-ports {
>> +				port {
>> +					apss_tpda_out: endpoint {
>> +						remote-endpoint = <&apss_funnel1_in3>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@68a0000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x068a0000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <32>;
>> +			qcom,cmb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					apss_tpdm1_out: endpoint {
>> +						remote-endpoint = <&apss_tpda_in1>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@68b0000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x068b0000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,cmb-element-bits = <32>;
>> +			qcom,cmb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					apss_tpdm0_out: endpoint {
>> +						remote-endpoint = <&apss_tpda_in0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		tpdm@68c0000 {
>> +			compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +			reg = <0x0 0x068c0000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			qcom,dsb-element-bits = <32>;
>> +			qcom,dsb-msrs-num = <32>;
>> +
>> +			out-ports {
>> +				port {
>> +					apss_tpdm2_out: endpoint {
>> +						remote-endpoint = <&apss_tpda_in2>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		cti@68e0000 {
>> +			compatible = "arm,coresight-cti", "arm,primecell";
>> +			reg = <0x0 0x068e0000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +		};
>> +
>> +		cti@68f0000 {
>> +			compatible = "arm,coresight-cti", "arm,primecell";
>> +			reg = <0x0 0x068f0000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +		};
>> +
>> +		cti@6900000 {
>> +			compatible = "arm,coresight-cti", "arm,primecell";
>> +			reg = <0x0 0x06900000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +		};
>> +
>>   		pmu@9091000 {
>>   			compatible = "qcom,qcs8300-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
>>   			reg = <0x0 0x9091000 0x0 0x1000>;
> 


