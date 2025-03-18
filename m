Return-Path: <linux-kernel+bounces-566340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49339A6769C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCDE3BE3A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CD520DD7B;
	Tue, 18 Mar 2025 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gIwFQGJe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8E320E016
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308684; cv=none; b=NEAczwPcnnYpkFG5Hkz0Kaui7Vuom5q2yVUQCfMW4HENgCH0F2QMV7Nkr0ZHGMbECSCY3TXsLTctXsSaTwWZ3CcMhfKh0INeGdB+JBPua6vMzqpxtznoIchInmCjcQCjkBOaOBnGs9uaYg61lr0MjVkW8YM5Fv0ytJguILM2ZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308684; c=relaxed/simple;
	bh=uXwPKYySsEu1qWFsITyTxKcgqX5hr/OVHNzrPrYSLKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UU7ncL+/DrfP87s2Zz+zB0sGS1mdzJHRLLEafno3w7x22q3umABN+M5KpN433UDf665AbJUVfFW5WNs40CwwvHK7iXarN2/EwysBtqSUoo9RbUYFYpEqsR/Ibk5zB6LmO4k3uBGpcyDCH2EUeDEDj01snxPxxf4ToKvnRAjfaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gIwFQGJe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IAVrhb027058
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tAGhhqN4VqHtfbgt2Tbr4gpqwtjyfCZLT6lo8yTUy6A=; b=gIwFQGJenoLrfmKY
	gUUGigyv8Nxbs+7reoenvfxxhzVUPGCKHpp8UpmFblCooYaopFNrMjZzCvSi9SVk
	6Dd+XQ2judMxwpwkb1cJT3BUakr2cUA67/iUK+MGt7DUi1kTr/76VZjlB5BxnV3e
	IWBCZloyBl2a55wHWD4kTPe3omYfoGcaRx3GjGHRxhXIIGMJNISJzN6R6JkG8HZg
	gOfEPpu3jLzIRnhFAG4H26ldYNiXsGZunjHeDqdWxbELol7Udlf07XvQ+lwnbezY
	LVqPrAFfPqekxwXMwKxm4zsQIItcl9DoflvaKnMv5P3oWwIbIGksugKOSLHARDzA
	EYZBkQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwtj8a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:37:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4767b8e990fso8108281cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308677; x=1742913477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAGhhqN4VqHtfbgt2Tbr4gpqwtjyfCZLT6lo8yTUy6A=;
        b=OtCKAiJ+YEXFXBS/Q53NWomPAcsakk5dIOVlAPz4nhW4t3pzWFctWEO3Y6UTaqYcuc
         PhNn1DinxfMmIXkjoegyCTSlUCFOFpho1SH8kyKwvplQzolUAolRC2GYLuge46u8+tc0
         vCPykV4x3dC+sFj2J0JzGMO07ba54lMfYRjsGWLh9vS1qi7yFKJHjvukYFbeYQWqAvIi
         miclxE232WWP2G+ssVnQAgvw37qt0tdJIfJHTEtuTBvAuo81cjxNEpJ+yjsxvjdtbPZ7
         FdnJK18zg/RjxorwZgDgxzNmFxgAajcn1Ity7txaIAWJS6WCR/Ajh9l4G6Y9II+0xHg9
         pWcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7lpef/X2oI6g5ivNS0o01osyYDJitwM3sE1gcZ0UT03pohH2qK7VKh8RgHshJycYaFfCswXKy2dX52Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKPlZZ7zTvH2yNs4yK/Mn2FckZV2E5d6xRq5hDELH5R3QD0D1m
	uemk6Fe14xvg1FfjAgb39Tb3P88dII0nc1iMb1qDIxWM+pm8M1/mHhhihoAQJ6/WXNZK207H9Ao
	faGbVnSKKfo4eD2CNX2ZHAp0xfLWezDStHF4tXe8QaHfA3xcE2QP2Oe/h/K7L7BQ=
X-Gm-Gg: ASbGncsUBoTWug+rLJujR7eh1AyN19l7VEoc3vOC6/lVV7VbAPodPSqbaqP1cWvdELS
	RZ65fL3q3g3tAnB5c0KdxrpLXlhmbzX5Axg/h6FD4pmjODrlTMeWvHdDwghiK97UrG2VyEwg1/8
	C1tl7w/8889CfmfSI8cWDMmno7TWvVbW1Jgb5WOLuCGcgG60D1HfFoi4IBoNhW8K6QuL/R0pp6s
	uEjz6Hr9GumfywNRRN1GjNnOAxtcdrYOQ7YkHDMIwzZFkmu568ZgoRm8OVD9G6uW6017TGe9Iut
	ANeBrMyuiR/eZFm3vNfzxtNR1BVu7LvWDqiDcYaeEvWxUik1jigVleTv7J3+z47HMVdx0Q==
X-Received: by 2002:a05:622a:113:b0:472:17b5:dc3b with SMTP id d75a77b69052e-476c8202f85mr104871671cf.15.1742308677571;
        Tue, 18 Mar 2025 07:37:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu3NI9SHwDJRtRLeM+LYyy91ZTXP2zu1wGYSCx+/R4CBuBs8q75lus1IkTgKetEM2ptDStBQ==
X-Received: by 2002:a05:622a:113:b0:472:17b5:dc3b with SMTP id d75a77b69052e-476c8202f85mr104871391cf.15.1742308677170;
        Tue, 18 Mar 2025 07:37:57 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149ced82sm840656866b.123.2025.03.18.07.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:37:56 -0700 (PDT)
Message-ID: <08d0a3ba-9141-4877-84ef-3b16b074b31d@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 15:37:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] ARM: dts: qcom: apq8064: move replicator out of
 soc node
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Lee Jones <lee@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
References: <20250318-fix-nexus-4-v2-0-bcedd1406790@oss.qualcomm.com>
 <20250318-fix-nexus-4-v2-10-bcedd1406790@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250318-fix-nexus-4-v2-10-bcedd1406790@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: C2yw1q8AUfF8ujYJYjO99tXgCuQbIBV-
X-Proofpoint-ORIG-GUID: C2yw1q8AUfF8ujYJYjO99tXgCuQbIBV-
X-Authority-Analysis: v=2.4 cv=UoJjN/wB c=1 sm=1 tr=0 ts=67d98546 cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=X_QOm82O2s3uUHrGAOcA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=824
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180108

On 3/18/25 2:22 PM, Dmitry Baryshkov wrote:
> The CoreSight static replicator device isn't a part of the system MMIO
> bus, as such it should not be a part of the soc node. Follow the example
> of other platforms and move it out of the soc bus to the top-level (and
> reoder ports to follow alphabetic order).
> 
> Fixes: 7a5c275fd821 ("ARM: dts: qcom: Add apq8064 CoreSight components")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

