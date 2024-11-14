Return-Path: <linux-kernel+bounces-409520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FE39C8DED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410761F250D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473E51487CD;
	Thu, 14 Nov 2024 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xm5p6S6/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F7D2C859
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598011; cv=none; b=kbj8G3za/G1NcSsWt4LEOw5FxeWiHSl9ashpoi5B3K8+DhrKAn/VRknPA7GgDNS2rupjOjN5dVojUnYYGAhqoEFcxQPLHl+MvVthJMXDMdMHoylnxJzEu3pIRJxklAFUReTih7kRN0F/Ivu7a4+1mpwPCItq7f8pCRBOf+PMfpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598011; c=relaxed/simple;
	bh=+jeoGf9IWx7kxj5wQSqzv2q+UrmcExRVO+ScQVuijCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMTHFIaeRsPEkToNt/jgDqJmTLxPBOHJYNjr23d3M3qcW0elAHE8lVGWtRcvmTWWNE05yG/Z8ILzGdcrJ8eblLJb8vRXrB6Q3Bmni/R29FrvzUOnebg75vCdPFanCGbZZ7YQwSZowFZQ8Ima/VgfvOe0M0K1st3fNNDwA9FAfOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xm5p6S6/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE6fv7F001047
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MaAEA/MQL5Iap4up1jmtqc010b7v6svP+NEN3Qkjamg=; b=Xm5p6S6/VldMOuay
	5rDQEKKux7pB3srITl7eFter0sjwCoHmBgANAXvM2vz2JhCE5PgVOtXNfIvxZ16U
	Ixurh6AGLfwxtdO+d5yrFxsGzDj+C1C7RK35afcw32EvDjQI3Lol9NLPKISxSpVG
	F+YyyVR6gp5EukjuCUaMnW1r7dbHzptp3RTuUFWN0Uzm9V8FW9ensdyyKC5EJyLK
	bhsZEtRcua+gtd7GtrZ7vvZLb3XVGMaZPcTkHZU1mufjnAgsqa0WZS/3kGZfeCLP
	JT1tI35Riz6lbVOtmB4t+4f7h0m9mlPfMOjXMTG+leyhqnZi1wMYsYb5Nf4kMfRo
	T8nFVg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vqbm5usk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:26:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4634796c2cbso1487981cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598008; x=1732202808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MaAEA/MQL5Iap4up1jmtqc010b7v6svP+NEN3Qkjamg=;
        b=rzysWhSMU7K1UeoW6Pf+fGGI1UFqFaTq3O9Py1nD8WmYfX0wNRFbe5bJEGnI3TVYej
         5Fu5LR/IsRV84qOoS9vAuHBXvpSdEfv/ypl6Xc2ObBMivuv2eyIzzdSe4iOgGXGieEUq
         NAZ/KG32ULJrEGe72ZyskgafLGqCsUQbTCX/QRKfsOsU0bgq8HhYE7LmW3sM9V97hKmx
         p5cM3gK7lyR19QYjLaVEGc9f4gaEw35vNBMSDA6G0nfBXVs8t/AyWfcUf8L1ZuW7nfe3
         YkCXXBQlfH3dWclRnMk/pemYK5BKJ4cDakCAwgmY06UKvGnh0t+kvf/HDrwvpDGY0M19
         MPvw==
X-Forwarded-Encrypted: i=1; AJvYcCV0EVFbvK0C760YHTXiE8tRXuLeWqUms7x8CMjbvC6PRgtGUR28JlYmIUjLZtF/4qoMmQy8IO/RoRKk1ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9IonjCZrLiBfwAqgM8vIpgd8DOiA6688fRxL22e7j86rGeTTG
	0LZVkSpnoKw9kvuRU2hcASFM1JnXxW5m1MRFRnOZIpK5QtcPaUJnPppVGrxsmQDsIiIFOZ0Ll6B
	JlhrZd/Hu8W3/K7cII93Jo5DeYFSZyfQCH7xr/QYtpCXngLYW6gAzwyUIUwy5YP8=
X-Gm-Gg: ASbGncsyhtP5dkpvi7WGJDeUqDZ1GMXj6MJz/WzsjU0O9+61oOuPMRFW63rvT5ZgyI4
	6GkZsH7GrMPgSs4lFGZVTgkxoHsMdu1TX5ByZVCx++uVqtMDwi3BKnXHj560T/q6TuRMrugtXFI
	jlMLhJN1+dAccYSIzbr7wzHTFe2fup42QRxGZwT8Dj4KLaZjNKNUrHBbRaWMvwuG5slPu4wV9l5
	6+AYJeCujGttXmNAF8RA8VjBYK3aAe7R9LdmIcQaPQAT9Nf9e7tZSeUwjoQAaXVoXV0SnGt33Cd
	G6vImOHhmpFai1aQyFxgmazI2lq2yRw=
X-Received: by 2002:a05:622a:2a0d:b0:463:97c:a2b with SMTP id d75a77b69052e-463097c0a2fmr145377341cf.0.1731598008115;
        Thu, 14 Nov 2024 07:26:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+Km+brd9preE/+PlVgl2cbIAUN7sFBM9KxI766x2sS9tI2y1AA2KqybBztWk0dxxSz5JK+A==
X-Received: by 2002:a05:622a:2a0d:b0:463:97c:a2b with SMTP id d75a77b69052e-463097c0a2fmr145377191cf.0.1731598007771;
        Thu, 14 Nov 2024 07:26:47 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e043316sm73590466b.135.2024.11.14.07.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 07:26:47 -0800 (PST)
Message-ID: <f987667a-5af9-468d-84eb-93051ed015f3@oss.qualcomm.com>
Date: Thu, 14 Nov 2024 16:26:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] arm64: dts: qcom: qcs8300: add TRNG node
To: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241113021819.2616961-1-quic_yrangana@quicinc.com>
 <20241113021819.2616961-3-quic_yrangana@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241113021819.2616961-3-quic_yrangana@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: W-u9kioKCkhqIUs_KvGEnrRhXAXIvIas
X-Proofpoint-GUID: W-u9kioKCkhqIUs_KvGEnrRhXAXIvIas
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140120

On 13.11.2024 3:18 AM, Yuvaraj Ranganathan wrote:
> The qcs8300 SoC has a True Random Number Generator, add the node with
> the correct compatible set.
> 
> Reviewed-by: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Signed-off-by: Yuvaraj Ranganathan <quic_yrangana@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> index 2c35f96c3f28..2a3862568da2 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> @@ -588,6 +588,11 @@ &clk_virt SLAVE_QUP_CORE_0 0>,
>  			};
>  		};
>  
> +		rng@10d2000 {
> +			compatible = "qcom,qcs8300-trng", "qcom,trng";
> +			reg = <0 0x010d2000 0 0x1000>;
> +		};
> +
>  		config_noc: interconnect@14c0000 {
>  			compatible = "qcom,qcs8300-config-noc";
>  			reg = <0x0 0x014c0000 0x0 0x13080>;

There's a jarring style difference visible looking just at this diff :/

Konrad

