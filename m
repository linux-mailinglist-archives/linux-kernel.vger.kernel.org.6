Return-Path: <linux-kernel+bounces-434018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156DC9E602F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5609283FDC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF9F1CCEE2;
	Thu,  5 Dec 2024 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ncs6g4QI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDFC1BC07A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434585; cv=none; b=EB8+pjaQAoQPb5ACKQk+Irv6Qzwvy11C+qslKU2mHP3ZnzDlk8oG9uELd4IFgEXuL91woQEc/6VTzrYobXNwIkz+Gn8JXRt1ED05aVXlh5RS0zsyTzXi2Qysy98qpO5B+Z43oxQEEfDQ9/nN/qNJAbMPyFvIIpXtIWDqtJUMlLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434585; c=relaxed/simple;
	bh=qxHeTYzJNmJuLcSV3rPAJwiQm3gS8Z6fFNGrm799O0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cChqZTnd4Q+zyfEGnGxbjrlnA3Q9jTSt4WnWIPAnFvWpSuEH43PmjbKWd6Pi0n83Jgeesmt7pXG331+y6R3kTFea9KinbL/impymvzaMxQOi8bKeWmlvojxFgRM2nhHxzOC4PtXpGLooxJMp8638e0izzhmbi3pKDNcLCUthLmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ncs6g4QI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5HaNA7004670
	for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2024 21:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wstxbk1OnzD64Npc360Pi802BNMyNjIUJQlSGDml8y0=; b=Ncs6g4QIGGVSfyBt
	HkxkhJQ8wCjloM7vs0fjN6hyfNBvrYXEEvZBqywUV/l75XiXsoP1sVuqejTHrs/A
	9q/VEBJ5YwJEjzsI2yB9xZ8Flaul0q3N3RmzFRepreX9esokca3TFJCagiV7AAF8
	mgiPlU9NLl1TwkT+73kEAddm5EfMqsmlN+17ZsTkj7x8VK3aw20nfHvF35dKZsHn
	xB5JG7I9uqxHhom3g0yUl0PO4FyAQrd9H/OA2KsiSBZnB17dNw1QrvldS/J2ZrfL
	Nqc36w/S6o5U7V30eqw+7WBvjElHoRcn4CnRs+aUdLHhucCjDbOUNeVf2irMpzZI
	P8N/Pw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ba141spj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 21:36:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b67127ab77so12629785a.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 13:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733434573; x=1734039373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wstxbk1OnzD64Npc360Pi802BNMyNjIUJQlSGDml8y0=;
        b=RC3VOph9/RcoOdll+thAaiAghoS5XAr39WVd3Lkbz00ba+uvfBjeyRKjGzSDo4YSnC
         HdS0FApu9qAQ0T7/RENY38OB9s5Q2wKr5/idK0RGCL5MtQiWg2bGGhgqkvPQFptYemq8
         wvWT8cPIyodYZ2C7Ym6ESWXQwP17jNxSRQn4PP4UyBuIrYRmiewHgiGPwFeHmKxJS0j0
         eAKGjiBny/pwnXjUq3UWrc51503goMM7lB7RjEgmCUDpn+B+m4MtXh63QbpOYKI4Yviq
         t/krIdPqxj7AgVCXpdTU5GGgGo1CLsDtjAdCz8U737SByQmu+320BnIQbuF2ExBO2C9z
         BbRA==
X-Forwarded-Encrypted: i=1; AJvYcCUosD7F+D/gQCCDYTGFtuMhSciXWlh35YmwD/wYhCao+7Dcn6ZqrshLPaDTu5rF6YBB0ZI59w3hY8ZBAlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhDv2JdzlffEZBvyE+39Ma7aBFCXE4s6DMiR4YcfTMkJBz9pq0
	svTl6gqdGs1q1LtNx4ClWZ5PFs/xGaoV3bMcH6TjaGVQ9lPQVgkzsxO4sfGXx4A5LXnvqIXQ5Yo
	8/7PPhQkkmrSCT699GSfLK0rE/bcIY+tt3q2wrqA/sUfqXJUE92UmrCoJc5INmms=
X-Gm-Gg: ASbGncuMEZlMGtnXQcKwkkr6h9h6S9srRHk4GIN4Hk3iTmQAARgGnl3Z0OzHck+GSm7
	zFi40JOGexhBQxHqyKEN8wAY9fnfAjm4Gw4LkVk3fkqu4i5f3aaCeHmRt2v6h13tCIIYzi8OFil
	Bn5JdlCt6EfvF/aSyGb4Bbpb2trbbIw5KiC43HTRRMwtk+/NUN4+HMn7BVJE+2Zl6MpU+A5y6oo
	73qfqeTSOkqURKr+eyGyN9zoykhPELZkOws9vsgEUXHrg+glS8k2s3bRB26+wnmvog5PCHgxQID
	pmkvwSDI3k1Lp/OTll7zy4cP4l4H6B8=
X-Received: by 2002:a05:620a:450c:b0:7b6:5e36:224c with SMTP id af79cd13be357-7b6bcac4fbfmr41656385a.3.1733434573598;
        Thu, 05 Dec 2024 13:36:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFV9ITN/o05Lqn7Hr8u38lLoE4ffPCZNKa+aOC+yUI+vFQdyY90szfu5RYo/Ll3Req0anAMFg==
X-Received: by 2002:a05:620a:450c:b0:7b6:5e36:224c with SMTP id af79cd13be357-7b6bcac4fbfmr41654685a.3.1733434573247;
        Thu, 05 Dec 2024 13:36:13 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260ebaabsm142014466b.198.2024.12.05.13.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 13:36:12 -0800 (PST)
Message-ID: <45643708-c138-4c77-85ce-fa7d49f2aa72@oss.qualcomm.com>
Date: Thu, 5 Dec 2024 22:36:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: qcs8300: add DisplayPort device
 nodes
To: Yongxing Mou <quic_yongmou@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ritesh Kumar <quic_riteshk@quicinc.com>
References: <20241127-dp_dts_qcs8300-v1-0-e3d13dec4233@quicinc.com>
 <20241127-dp_dts_qcs8300-v1-1-e3d13dec4233@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241127-dp_dts_qcs8300-v1-1-e3d13dec4233@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Y-L1AB41y8uEvSKei9Ux467XsnsmIwFS
X-Proofpoint-ORIG-GUID: Y-L1AB41y8uEvSKei9Ux467XsnsmIwFS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=996 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050161

On 27.11.2024 11:45 AM, Yongxing Mou wrote:
> Add device tree nodes for the DPTX0 controller with their
> corresponding PHYs found on Qualcomm QCS8300 SoC.
> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 115 +++++++++++++++++++++++++++++++++-
>  1 file changed, 114 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> index 1642e2863affd5af0b4f68118a47b7a74b76df95..28deba0a389641b4dddbf4505d6f44c6607aa03b 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> @@ -987,6 +987,19 @@ mdss_mdp: display-controller@ae01000 {
>  				interrupt-parent = <&mdss>;
>  				interrupts = <0>;
>  
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						dpu_intf0_out: endpoint {
> +							remote-endpoint = <&mdss_dp0_in>;
> +						};
> +					};
> +				};
> +
>  				mdp_opp_table: opp-table {
>  					compatible = "operating-points-v2";
>  
> @@ -1011,6 +1024,104 @@ opp-650000000 {
>  					};
>  				};
>  			};
> +
> +			mdss_dp0_phy: phy@aec2a00 {
> +				compatible = "qcom,qcs8300-edp-phy";
> +
> +				reg = <0x0 0x0aec2a00 0x0 0x200>,

0x19c

> +				      <0x0 0x0aec2200 0x0 0xd0>,

0xec
> +				      <0x0 0x0aec2600 0x0 0xd0>,

0xec

For lengths

> +				      <0x0 0x0aec2000 0x0 0x1c8>;

This one's correct

> +
> +				clocks = <&dispcc MDSS_DISP_CC_MDSS_DPTX0_AUX_CLK>,
> +					 <&dispcc MDSS_DISP_CC_MDSS_AHB_CLK>;
> +				clock-names = "aux",
> +					      "cfg_ahb";

power-domains = <&rpmhpd RPMHPD_MX>;

(or maybe even MXC?)

> +
> +				#clock-cells = <1>;
> +				#phy-cells = <0>;
> +
> +				status = "disabled";
> +			};
> +
> +			mdss_dp0: displayport-controller@af54000 {
> +				compatible = "qcom,qcs8300-dp";
> +
> +				reg = <0x0 0x0af54000 0x0 0x104>,
0x200

> +				      <0x0 0x0af54200 0x0 0x0c0>,
0x200

> +				      <0x0 0x0af55000 0x0 0x770>,
0xc00

> +				      <0x0 0x0af56000 0x0 0x09c>;
0x400

for lengths

Konrad

