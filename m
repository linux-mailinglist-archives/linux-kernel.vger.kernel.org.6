Return-Path: <linux-kernel+bounces-395082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1659B9BB833
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2412281A03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A681B6D02;
	Mon,  4 Nov 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dnUrk4ps"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAA5F9E8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731567; cv=none; b=m5epgBPf7MlpXxi/KpTMDH49Q4PwNo7sad41XkPBCt1SPtbqO4H7CnelZJEhjkkJBfKzQ6DFBGfa/lWyOzShMGtV0PisZzO1JODmg4vKQYFxoW7qvh4B4u6SuokBBvKW0EJxKBvuPCs1T7QuQ/3laJdryM5FLPZ41UXeCEigtL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731567; c=relaxed/simple;
	bh=ri5gKANv6TvUTPl9+9xRfhB8LDqHtD0yB8YlHumIS9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p/rcHz4ec1QKHUoLtGqC5R1waoEBxZGxa1jD/QnxkTmD6jrnsJNDPsqRqMGwP9OG4/AUijmGzamaZJL6GTgaA2sHPQv26gHHJcSdV4jkyNGk/3oLGTc1wXpjD5cw8sFarlN/80xjSXR7tablFIsLZ4xdY00QC+K2Q266r5HLG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dnUrk4ps; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BgjBm030808
	for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2024 14:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iEq/Fez3KiO14L7XUIPT1fn4g59MvDWGnwPCbPiCdc8=; b=dnUrk4psxz61ql1d
	XTAu50K15rdAPnpWd0A9Whx7RVc9UH+Mog/DM6oiw4kFxB5A4tgQugcPW4hr5erg
	1ICb6mCY68H1TP9y+GLQPnf5K2Rzx528BCfaegzZWkXRhDZNYBelfjr9C1ZEZLaz
	FpRvlTe0OPOMsT1zGwpO1W6a4/2E4TuGk0AZrPM3ZFIoOEbAcnSaODX9TrStjGKD
	+Do0voXrDhMTadRVzNq8wNFrcEvcK6sU0sFUr3NGfb94WXKW6td6ahHPfV0XdyRK
	9nWKXdmtUiYiMW1bHYdvOfDNWO6YxhrEcLEjGcFZRcBcxoC9PlPIBzH2kvzr66QG
	SXNkHg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd4ymfec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 14:46:06 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3df19f2433cso60479b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 06:46:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730731565; x=1731336365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEq/Fez3KiO14L7XUIPT1fn4g59MvDWGnwPCbPiCdc8=;
        b=P0FM4mw9Rxfxx53J9IYxNk8X72UEjU3ecRfrHN3fand9l2iTpT7L9ADR9hIkil5uoS
         FDYRvvctUN01KMbqTBeN0ZNolnkEzzbdb3w4wQWuSyCUOhznC/K1DPBMIufOAhmM768i
         Usw7syLEdfJg329Dtr8jVYaT8203lYAe6mZl472E/C3MuK20Y2MG2nNccdJwyp/Y3Upa
         bBnRV8q7/VBcumSsiFrguMtwEntG1TaErQ6Dxjo9JoMDjvmynZxGMung+YnxfUqte3XO
         WCR5NHzYld/JKvMfEXLdzTldK8b1QN+X6WKB9GCUtJ2P827vB6xVAecTwZFqTf7K6VkY
         dySQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjk4fw3i9vUCX1egPzHS36BfD047dCIAqIPqP+wqXUluAKNMoTzg5jXCpdRt43Bs9XFjj7elkI4H5MPds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyitU0l0ePP3y2ehqDPaoSOUJujlph7X29x4r+I2nB2HnJjTYbN
	0D0tFw80iBlNMKbjeJOCHZbXj+zKDJIr1CrSjIFwkFBWgud1C81UOHnmRzTnEoXrk0eiNX1zjGA
	QcoY0gNGel/pp1feBhvvMb1uRNZWaURf+DUomm2cIaPFmuos23uijxeE+CtqredQ=
X-Received: by 2002:a54:4713:0:b0:3e4:d640:7449 with SMTP id 5614622812f47-3e638443fcamr7064328b6e.4.1730731565114;
        Mon, 04 Nov 2024 06:46:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjt7yLH7obj2yJY5lX8bMi7SMYsNafpSge3M0yoLdMOlcEwQ3eZbty9K7EcZfKV6+orGjU0w==
X-Received: by 2002:a54:4713:0:b0:3e4:d640:7449 with SMTP id 5614622812f47-3e638443fcamr7064299b6e.4.1730731563300;
        Mon, 04 Nov 2024 06:46:03 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e566797a7sm561800866b.190.2024.11.04.06.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 06:46:02 -0800 (PST)
Message-ID: <f0863c6a-44cc-4709-aaab-a089fb6620e6@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 15:45:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: Fix CDSP context banks unit
 addresses
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Ling Xu <quic_lxu5@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241104144204.114279-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241104144204.114279-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yFhcZ4FKXVbAMKedOI_U-Rm_ukqZXpur
X-Proofpoint-ORIG-GUID: yFhcZ4FKXVbAMKedOI_U-Rm_ukqZXpur
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1015 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040128

On 4.11.2024 3:42 PM, Krzysztof Kozlowski wrote:
> There is a mismatch between 'reg' property and unit address for last
> there CDSP compute context banks.  Current values were taken as-is from
> downstream source.  Considering that 'reg' is used by Linux driver as
> SID of context bank and that least significant bytes of IOMMU value
> match the 'reg', assume the unit-address is wrong and needs fixing.
> This also won't have any practical impact, except adhering to Devicetree
> spec.
> 
> Fixes: dae8cdb0a9e1 ("arm64: dts: qcom: sm8650: Add three missing fastrpc-compute-cb nodes")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

