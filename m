Return-Path: <linux-kernel+bounces-526544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2078A40009
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9F2421C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874CF252907;
	Fri, 21 Feb 2025 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mYe1LYof"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5A11FBEBE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167486; cv=none; b=XmiMJiUjRIahw0/bU9rZ9imBlXRcxC6mtPXrl9Az99GXAjpOp8B7WRtzXNoiLgrRjIgIvEYwvoBk9jsAEgmaNxh6fGCDNwsXb93TlEGcnBTQmjaLpdcih+iPpMmOuc3QIIUWGdG8cvtul3bAinZXt28PrWmWkLMoy+TnC9knGQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167486; c=relaxed/simple;
	bh=uyiF/QHDt3ei/5eDvHIAfJrbglGWLmfExHnZHGY8eE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUrHVGKcMv4LhCb8/culKbMNS7i6jYDj+4KsoxZgfJxbh2A5XYjSmKTC3whjgeO1iGb3n/2tYNg7V3NkmwRCA74lyDurjih8ct237zUfrRqcgQ9ZxnHxNbtix6s8udb2kGxasUAUAoAgPTpa2kp7LfQEOQ0n09YmxTNM+81FIXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mYe1LYof; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LBqhDp012178
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	slCnnx3Ju6AXQtgwn1/8Fq3BnRvUMWgyzQWIGQVJ7rE=; b=mYe1LYofpZxGtTo2
	PZR8vjH+2x2+Pa2T/nsiyynsYjx1MYLgVpzf/PUE9XhmCpx7IudhsQBreSAPr5a1
	b14qv6WOrBY2e3MGlyTxtI+1P3HNGH7QR1ajn6G/UZ5q+sPJxYCv2VMhXaBzMSor
	ZGVmcX7yCWjGCz9qXgYXH+8cQcrEqGU1oylu/tiils4aPAI3rmp1L7GwP2a2tU4W
	M+8mPpRX7M3EHsu0Zrf0RHvvq8TgpazbjtmqqeyUooncrXZspE6W7Oy8uhr4rX31
	K2lbn2B9G+WR6XBBQmUFyi5htbEuIkP/ZxUCqvEK1tKcjf0UAzuMKCDS/2rC+22E
	unwRKg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy1u5b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:51:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-471ef402246so5515211cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740167483; x=1740772283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slCnnx3Ju6AXQtgwn1/8Fq3BnRvUMWgyzQWIGQVJ7rE=;
        b=D4LKJ+hhXBcGuIdfwr2rywOsxIT/4FmMFHZQ7OBoG3uTM0ZFLgtE1arsp9R2972PjI
         jQU1rslEEZ5BjkzR1rOI+8fG/JvfYdhDppjueU7pHljHdiVZyoSHyXkgeDosUo/jxqtv
         Eft4fWv1zIk60QuqFMUhWgr3mneSnKvEDEZDSVI2Knuj0f7hy8RGDYgXJ7C0MFFRB6qs
         8rUCTrHggMvk/aCiwQVBVvxQzsdSymW+6ZZZYFZfnapYB5zmykTNTVLEKmnkhn2g8RMt
         4IfDVr6gVYqjcNqAaymxboBS2u/iQHxrRLtelraFA+wUuxloxnFj2x2HWtmSPoOnk5i1
         Feyw==
X-Forwarded-Encrypted: i=1; AJvYcCUvQ/KjY6ZL8htS7Osp1Ig5SAgqDEZSDZpHgqmJ5On2EyUJqpuM8hgD0a857mgwMHpT2WlPLO3eQM7u0pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmAH/Si7ag3ZKO41wAYf0knENlsDFX+TaK6lhicsWcl0JsC/4e
	jFH89clrS/bXjJMyLkwQM1Mzb8XxC3VbR7TmEbD6/fxcOXDJkJiqVqYaOslUcv/DjQpa9VKo18R
	t505maF1u92e6eMRLOEjYGoEgCHOZAYKOQngxer8i3Cy3mF6m/8ZybLQL51b+eXk=
X-Gm-Gg: ASbGncuy+ZZa3HdjoP+j3jfsWFLzn537QZXduLZvxYrSWb4MYQ+ipEY+sa24nkqikXW
	rX4OEDS7EJCfzWLjOxqhZWA/++YF5rGPgYwaY21Vqako8iAl3rkq1flEmOWI5BYSQPXEls0XsrR
	z4l0buIehQVtPMg6dYFaKFqWBZkcJEbisiFPrKzLKoQ0P47wWvsN89Qen7v6LDEqypb2Azf3Ldj
	olvZ/tiGc7URXD31UuFL5S8ANNn9hblma1ol52SxpGLgV/1zonfJc5bpMtSXrndIQi8Tdkx312n
	9cVw7e2CCXj2+9fn7Fx2H35ZI8VY+ixvKQqq/FvfQaJLc322SiVANKh83B5k2zQ0znD02A==
X-Received: by 2002:ac8:5710:0:b0:471:ef27:a30b with SMTP id d75a77b69052e-472229a8a3dmr23685651cf.13.1740167483198;
        Fri, 21 Feb 2025 11:51:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkR63TPCM61UzrS8r5cdu4GiDJKbAb4BpmgRg1ZST/E8eZwpjn3gXn09+LIotX9lkdJBHVdA==
X-Received: by 2002:ac8:5710:0:b0:471:ef27:a30b with SMTP id d75a77b69052e-472229a8a3dmr23685481cf.13.1740167482783;
        Fri, 21 Feb 2025 11:51:22 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbad297430sm867677566b.5.2025.02.21.11.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 11:51:22 -0800 (PST)
Message-ID: <638f05f4-3a0e-459d-aec0-b925ca7f657c@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 20:51:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8750: Fix cluster hierarchy for idle
 states
To: Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_lsrao@quicinc.com
References: <20250218-sm8750_cluster_idle-v1-1-5529df00f642@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250218-sm8750_cluster_idle-v1-1-5529df00f642@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: h5icwm_2-b4Nzh4LxZo-zqCFDkN8l6r3
X-Proofpoint-ORIG-GUID: h5icwm_2-b4Nzh4LxZo-zqCFDkN8l6r3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=865 suspectscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210135

On 18.02.2025 7:58 AM, Maulik Shah wrote:
> SM8750 have two different clusters. cluster0 have CPU 0-5 as child and
> cluster1 have CPU 6-7 as child. Each cluster requires its own idle state
> and power domain in order to achieve complete domain sleep state.
> 
> However only single cluster idle state is added mapping CPU 0-7 to the
> same power domain. Fix this by correctly mapping each CPU to respective
> cluster power domain and add domain idle state for cluster1.
> 
> Fixes: 068c3d3c83be ("arm64: dts: qcom: Add base SM8750 dtsi")
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> index 3bbd7d18598ee0a3a0d5130c03a3166e1fc14d82..3af928be5b68b47988dd55f4add8e3712f07d5ab 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> @@ -178,7 +178,15 @@ cluster1_c4: cpu-sleep-1 {
>  		};
>  
>  		domain-idle-states {
> -			cluster_cl5: cluster-sleep-0 {
> +			cluster0_cl5: cluster-sleep-0 {
> +				compatible = "domain-idle-state";
> +				arm,psci-suspend-param = <0x01000054>;
> +				entry-latency-us = <2150>;
> +				exit-latency-us = <1983>;
> +				min-residency-us = <9144>;
> +			};

I don't think this is necessary, you should be gtg with just creating the
new power domain for cluster 0/1 and pointing both to the same cluster idle
state (unless they both need different latency numbers

Konrad

