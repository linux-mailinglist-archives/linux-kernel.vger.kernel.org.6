Return-Path: <linux-kernel+bounces-444669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7338B9F0AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7332832F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A17E1DB55C;
	Fri, 13 Dec 2024 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ty1UiBt1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184D1A8F86
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088658; cv=none; b=dHSOxCtShprjmbaeW9ZLtS4nOdzNph8lQj70RNwpEooBfZjCfIfAFhpxig4/BkraHRrCIlZN1o1wrbAZSdlLr4jUSG0ahKFPZZS319TmwTpjZD3Bh4h3dzCVxaRr/7ascaqniDJ+bMQgZTjOHi5655URNiy71Qd+a8cwXWRrNnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088658; c=relaxed/simple;
	bh=K+cyT7IH7s13bj/nzoms8a0X++/cCDX95iiwNa5P4dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgq0r+DZjG2whouk70ykgjSTeNurUCyLlWXd9b8UA8q0Bd33tritWFZ15XxGpzlmlUYEaKBxR35iDENpbWev9JWbejHfMPgBFpjTn/AUZuIHuVQnKqM7uSG0wV7Z2GcJoGvnZifkBrNwlFVWFERYunpa4Skl+Mz331dC6VLJJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ty1UiBt1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9t23h006142
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	22DdllJUx8c525feb9BABGaXYzEDkdsU1L5H+dtpqJk=; b=Ty1UiBt1pMVbIqjG
	uTAczAQNfUqNz+JS0mmWcqXkmGhu8NzcOlWEurDv0ylOSLDm/UrVDeyzgmI+6Hz6
	M/sYoolyV8482tKuzx2LyVF8PQP/ENexWPdU2yy0ygdmifYOW/Lx0Qg7sfx95DwM
	tNdNwbt2CgIM4xaJcxBYyu0vNop0remU9UrazB+pFTSFSSep51GR5SD4R7EqxSE3
	t9lu62faWanIbRuZdF32t/m1q8ZwXXHPw0RCCa6g6tUgg/8y2zc6zHFpVV6krvkJ
	4g2uiP0ccT2+fpsedkZ4HdgMW/z1il9tQ+yb3xTzzM/pvZ2x+LrPLbSkIFKN73Uz
	kM6xfA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43g6xusx7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:17:34 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8e7016630so4034746d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:17:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734088654; x=1734693454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22DdllJUx8c525feb9BABGaXYzEDkdsU1L5H+dtpqJk=;
        b=QavgjzSny0tvhtQLx7wxGQyZV8Ab8ObeFLGKtyOkr5Zy9vTfKN4o2uFudHzfqbtPUS
         UdabecMMalt9jBxSZfUq8FrkYrjPNBdxqj5wfXTe5hILDd8HvfRJoNmC89SKmBR/JR0G
         7YeS4u3Ir/gk8++DVGIPKd6ekQLrZH+O/3/UgSgSG5IweXdzLhzsiJLKQ6BJ2Dm5kLe2
         fAOwziN6Vsia6PK+tOyiDzBiXv94wnGC2yv9ES6M4V9l8qlnAcXp1zP5rjWXhT2+zkhI
         PXWnvdKTirTK4S0ZOWtp2isNWD2fC+A6CEWvL1gO59THZTmgnPrZQFDcINUU3PDBLTSk
         Xhsg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ56KImsd4/pUWsm3bHexLekc7V8I1WFnedT8i8Lm/YPDNpkYa4K0G3cEkE6ERqFPHJ+eZ6kFoBmUXE/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkUp1UKuqJu1vul/J/PyGuIQv/hCrnqsH2U37Yi+AY11hNvUGm
	3csA2I0JP5CWBhylfqFTH49cSuoV3iMA+YEitesURQ9tyLddnpDVAG+GdkZOc38YEjTUN1GOip0
	awXrnn0mOf6X7XwT1EpFdh9wB26ljn4ut9GqYSEVKhCRtRxsWnsVIZ5MheNksPmU=
X-Gm-Gg: ASbGncsRHmbps4ZQwe3/3WkZSnmLyFAoUX6vPNx0Jj0MFA87gFe569BJb5qVcKz4iOZ
	lI153kyTK+J2Q0uS0kQ9LOyHDwME7HjADLj4hKZXt0Ozn0RGGD/00m+QyJ9druUpOBvjzQAiqFd
	UUAOZ6TB7KYJHjEI0shoR12gg5tsiHhNn/CFyED3KORPy6DcylOcj6MffZemqgQIMed3n5ttLG6
	nZJFspW7mY8Rsa/SpIPc5fQqN3eF47f4m81pKT4o0+ZZ0b7wWC88/chxaukEhI3J48FU1Z3RHch
	/JMx5Q2kzOrNigT7Yk5brnorGtNREqAfa60X
X-Received: by 2002:a05:620a:1a95:b0:7b6:d089:2749 with SMTP id af79cd13be357-7b6fbf0713fmr117971885a.7.1734088654035;
        Fri, 13 Dec 2024 03:17:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGD+GDmKeinZ6iYtcXL0S/mpK+8aIUpXK3aOY+mNBKrJvpqSkt1hyGsBzayOsJI+bMandu74A==
X-Received: by 2002:a05:620a:1a95:b0:7b6:d089:2749 with SMTP id af79cd13be357-7b6fbf0713fmr117969185a.7.1734088653665;
        Fri, 13 Dec 2024 03:17:33 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab88d930a9sm27933266b.95.2024.12.13.03.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 03:17:33 -0800 (PST)
Message-ID: <f38e0aa3-e10e-4e5a-923a-76686baf2482@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 12:17:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] arm64: dts: qcom: sc7280: Add support for camss
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
        todor.too@gmail.com, bryan.odonoghue@linaro.org, mchehab@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        akapatra@quicinc.com, hariramp@quicinc.com, andersson@kernel.org,
        konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
        cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com,
        will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        Luca Weiss <luca.weiss@fairphone.com>
References: <20241206191900.2545069-1-quic_vikramsa@quicinc.com>
 <20241206191900.2545069-5-quic_vikramsa@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241206191900.2545069-5-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SwO6cJMmuvgxKKzY1_U2hxCje9fPBP29
X-Proofpoint-GUID: SwO6cJMmuvgxKKzY1_U2hxCje9fPBP29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130078

On 6.12.2024 8:18 PM, Vikram Sharma wrote:
> Add changes to support the camera subsystem on the SC7280.
> 
> Signed-off-by: Suresh Vankadara <quic_svankada@quicinc.com>
> Signed-off-by: Trishansh Bhardwaj <quic_tbhardwa@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Tested-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 178 +++++++++++++++++++++++++++
>  1 file changed, 178 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 55db1c83ef55..afe7113df4af 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -4426,6 +4426,184 @@ cci1_i2c1: i2c-bus@1 {
>  			};
>  		};
>  
> +		camss: isp@acb3000 {
> +			compatible = "qcom,sc7280-camss";
> +
> +			reg = <0x0 0x0acb3000 0x0 0x1000>,
> +			      <0x0 0x0acba000 0x0 0x1000>,
> +			      <0x0 0x0acc1000 0x0 0x1000>,
> +			      <0x0 0x0acc8000 0x0 0x1000>,
> +			      <0x0 0x0accf000 0x0 0x1000>,
> +			      <0x0 0x0ace0000 0x0 0x2000>,
> +			      <0x0 0x0ace2000 0x0 0x2000>,
> +			      <0x0 0x0ace4000 0x0 0x2000>,
> +			      <0x0 0x0ace6000 0x0 0x2000>,
> +			      <0x0 0x0ace8000 0x0 0x2000>,
> +			      <0x0 0x0acaf000 0x0 0x4000>,
> +			      <0x0 0x0acb6000 0x0 0x4000>,
> +			      <0x0 0x0acbd000 0x0 0x4000>,
> +			      <0x0 0x0acc4000 0x0 0x4000>,
> +			      <0x0 0x0accb000 0x0 0x4000>;
> +			reg-names = "csid0",
> +				    "csid1",
> +				    "csid2",
> +				    "csid_lite0",
> +				    "csid_lite1",
> +				    "csiphy0",
> +				    "csiphy1",
> +				    "csiphy2",
> +				    "csiphy3",
> +				    "csiphy4",
> +				    "vfe0",
> +				    "vfe1",
> +				    "vfe2",
> +				    "vfe_lite0",
> +				    "vfe_lite1";
> +
> +			clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
> +				 <&camcc CAM_CC_CPAS_AHB_CLK>,
> +				 <&camcc CAM_CC_CSIPHY0_CLK>,
> +				 <&camcc CAM_CC_CSI0PHYTIMER_CLK>,
> +				 <&camcc CAM_CC_CSIPHY1_CLK>,
> +				 <&camcc CAM_CC_CSI1PHYTIMER_CLK>,
> +				 <&camcc CAM_CC_CSIPHY2_CLK>,
> +				 <&camcc CAM_CC_CSI2PHYTIMER_CLK>,
> +				 <&camcc CAM_CC_CSIPHY3_CLK>,
> +				 <&camcc CAM_CC_CSI3PHYTIMER_CLK>,
> +				 <&camcc CAM_CC_CSIPHY4_CLK>,
> +				 <&camcc CAM_CC_CSI4PHYTIMER_CLK>,
> +				 <&gcc GCC_CAMERA_AHB_CLK>,

This one's permanently enabled, you can drop it

> +				 <&gcc GCC_CAMERA_HF_AXI_CLK>,

Is GCC_CAMERA_SF_AXI_CLK required too?

> +				 <&camcc CAM_CC_ICP_AHB_CLK>,
> +				 <&camcc CAM_CC_IFE_0_CLK>,
> +				 <&camcc CAM_CC_IFE_0_AXI_CLK>,
> +				 <&camcc CAM_CC_IFE_0_CPHY_RX_CLK>,
> +				 <&camcc CAM_CC_IFE_0_CSID_CLK>,
> +				 <&camcc CAM_CC_IFE_1_CLK>,
> +				 <&camcc CAM_CC_IFE_1_AXI_CLK>,
> +				 <&camcc CAM_CC_IFE_1_CPHY_RX_CLK>,
> +				 <&camcc CAM_CC_IFE_1_CSID_CLK>,
> +				 <&camcc CAM_CC_IFE_2_CLK>,
> +				 <&camcc CAM_CC_IFE_2_AXI_CLK>,
> +				 <&camcc CAM_CC_IFE_2_CPHY_RX_CLK>,
> +				 <&camcc CAM_CC_IFE_2_CSID_CLK>,
> +				 <&camcc CAM_CC_IFE_LITE_0_CLK>,
> +				 <&camcc CAM_CC_IFE_LITE_0_CPHY_RX_CLK>,
> +				 <&camcc CAM_CC_IFE_LITE_0_CSID_CLK>,
> +				 <&camcc CAM_CC_IFE_LITE_1_CLK>,
> +				 <&camcc CAM_CC_IFE_LITE_1_CPHY_RX_CLK>,
> +				 <&camcc CAM_CC_IFE_LITE_1_CSID_CLK>;
> +			clock-names = "camnoc_axi",
> +				      "cpas_ahb",
> +				      "csiphy0",
> +				      "csiphy0_timer",
> +				      "csiphy1",
> +				      "csiphy1_timer",
> +				      "csiphy2",
> +				      "csiphy2_timer",
> +				      "csiphy3",
> +				      "csiphy3_timer",
> +				      "csiphy4",
> +				      "csiphy4_timer",
> +				      "gcc_camera_ahb",
> +				      "gcc_cam_hf_axi",

No other binding calls it that, please use `gcc_axi_hf` for
consistency

Other than that, looks good

Konrad

