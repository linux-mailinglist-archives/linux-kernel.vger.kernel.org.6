Return-Path: <linux-kernel+bounces-391284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E269B84BC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 089C4B249A5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86811CCECE;
	Thu, 31 Oct 2024 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UAeAbSXa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8B1CCEF8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408162; cv=none; b=kHRIL2EaNRFU2e5T5eAU2gJ31MzzOfR3kQ0LYkwATD79uFhp9C1Swya83+7rWNDdD3X6ASMsgjmPnl57yS1mXf9zpImb2oV03dlyLWKR690OfSwJ3IJ+L+DJ2Qi8cpi0Jb5Yj1c6noitUjtrQFfdSKBHLVa1vVE2PXUr1LluyJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408162; c=relaxed/simple;
	bh=lUSUj5gpJWH3n+nu+zbQk0I/denqmKWaKjMGJHBTETQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hur8SVxP3/O6Ix32rTca1k3xxUREaD8/OBVALRTRV97o6C4ooeJizLLsP9Vif6aMaMK/QdmX6bLAaJpA9Grt2XuLtMfXUg2kr3xS6xAfyV2MaNVNlqHxT4V4FkzuZAb1R8v939WcvjI1E0RJWfdJUc2o5Hoqy0xJfCV6TvDLtvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UAeAbSXa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VALRcM012752
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G/GsUlv6jLw8dS2ijmCbA4pqN85zB0IfE2xsC+GERb8=; b=UAeAbSXaq0jCy6fP
	uniAzadaIqa+xq3xwFwk5c9EzLAgHLFpBgIg2WddDNvUNN3cbsyAzSa1eD/BuFHF
	jmMPR+q2Y65kzBhYWHPS+3REjMVnuZvMuKOvwMgO/99w/vJ3yCM0WIUk4HKAdoN7
	Eu0cxXLtU/pwCzHHhqhU4SXklTmU3pM3ACG+ON/KiVuAvhKNmcywbBxfHGJK5Cbd
	8vNtvUWkgLiNHsxyOiSg6nwTbjQf23DO5/IlvED5/OYTWc7mI3JWsoqim8shQsWi
	jD0I2nSCi28lw6yuPStmk+OemJtSrQ9T8JORQqPZspY/YpVX2GTfT5jJX5Oew7G/
	t/OSAA==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ky6rb4kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:55:55 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5ec1c46df37so186675eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730408155; x=1731012955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/GsUlv6jLw8dS2ijmCbA4pqN85zB0IfE2xsC+GERb8=;
        b=Oqe5aPQlfof/yC1DtPpVjx/gI8rAYG5G9bKqMSeXGSgtfX91UeW6ONnAIpQYmWCNlN
         Y2j2HbUNyZGoFGK+5I5JcIrgD8+XpIdyQxMr4/k//n8y7XsRFoox4atEOghp9YhgPwTp
         UF0RILi9w0MWCJ7i3N+3K7ZeafqD6ZMv5tVLJqZMWK+D/9dVaWthhFwLmX6pSdO2m3Xv
         iVtpAu/fX9WOv4MAixUWGyxW0aeG9E6AFCErg9N6346bqSnflwdw41WaWg3lWf+JdqcT
         Oxw1n4Y6k9m7ZUUEQ5t9BVwMdoY5oDUbZFa3FovCxdzVYJQOXmd4atAw+YBFEmdLUoDP
         AKxg==
X-Forwarded-Encrypted: i=1; AJvYcCVyt2jOhotng6Ksp7mjdmkpB6bR9FBLTo7li3Zj4RbsRbgf4lOOX0nkP0ikXmySAvw76F57Ypr/OqX62Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE1/XKGS/XFUn5ij+h82DO2QKt0s5qTnpQdB5GMNDHDWbUYTYI
	AWsB4Xn6Sp2QCi9r3lGXdz5agTLImqiAuhoNVq05p6UEmYkya2LRV8E73EvPLKmRXWlNgY3uwMx
	QaBiVl8hsRg5n3d3dtggy4VPOWyaCWGzckvECM1K+WEehUVQ7ZbDQm5jKTD8UvaE=
X-Received: by 2002:a05:6870:8321:b0:288:4747:6904 with SMTP id 586e51a60fabf-29051d35ad1mr5245840fac.10.1730408154734;
        Thu, 31 Oct 2024 13:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcabfjV3Q8jzqGajE+yo9p1xEPEdBIKwPgoG5DN9WtHI+OBzL6cWTytYzHNOkjOm8Pdwmg8Q==
X-Received: by 2002:a05:6870:8321:b0:288:4747:6904 with SMTP id 586e51a60fabf-29051d35ad1mr5245837fac.10.1730408154506;
        Thu, 31 Oct 2024 13:55:54 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56681a03sm102118466b.197.2024.10.31.13.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 13:55:53 -0700 (PDT)
Message-ID: <0fa67f4e-8aab-477b-9e40-065fa815696f@oss.qualcomm.com>
Date: Thu, 31 Oct 2024 21:55:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: qcs615: Adds SPMI support
To: Tingguo Cheng <quic_tingguoc@quicinc.com>, quic_fenglinw@quicinc.com,
        quic_tingweiz@quicinc.com, kernel@quicinc.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241028-adds-spmi-pmic-peripherals-for-qcs615-v3-0-f0778572ee41@quicinc.com>
 <20241028-adds-spmi-pmic-peripherals-for-qcs615-v3-1-f0778572ee41@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241028-adds-spmi-pmic-peripherals-for-qcs615-v3-1-f0778572ee41@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CvLVXS9nFqEqNFM628C0itFm-FhhjAzl
X-Proofpoint-ORIG-GUID: CvLVXS9nFqEqNFM628C0itFm-FhhjAzl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 phishscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=842 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410310158

On 28.10.2024 9:03 AM, Tingguo Cheng wrote:
> Add the SPMI bus Arbiter node for the PMIC on QCS615 platforms.
> 
> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

