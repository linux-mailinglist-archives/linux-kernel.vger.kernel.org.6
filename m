Return-Path: <linux-kernel+bounces-562102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 454C1A61C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629E4460A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE4620D514;
	Fri, 14 Mar 2025 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KiTM+Tvz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DAA205519;
	Fri, 14 Mar 2025 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982854; cv=none; b=pLDsE3Vqudj9LcRQDc/xjdpmaoHE2oMyC6kg1e2OG8ors2yFmsw+a5BD/OtRrza9V5jRPPSWGxvVVYvRPO954vNCvCBvchFNjVEXbjXhLlC1gb4lBU+Q0ESIe8RVwpmGeSdpu3CXfwez1VMKqBUut5gdQP7dYdI43yrY1ML6KIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982854; c=relaxed/simple;
	bh=jMHqGd3lD2mdRD4W8Ylf0vQtB+nL3oICzQVLeqxy5BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M7M9+GhvsXapiMk8tHHrSILk8+Szyt/Mh05c99BuNKoc9VawMSVT65bUwFX5lC47Y/sm/IUoje5YolZuGTtnKkMb+vgsupqKYTEeZ4pHn14pL9PZuZlRZFfhGikqaB7sEPSgmiJl8khBg+iCnIRWF9DEzM4XBs/oPRsxOpG0d8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KiTM+Tvz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EA65VU029072;
	Fri, 14 Mar 2025 20:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j2UJCix3JztGr18PVp53iCTYdyjaY6rLNVnankBkSrI=; b=KiTM+TvzAXWFdi00
	ucgycjwaLCXwbQzcAyR0yni7z0S7Ur+3M7zIxwr96+4UGbec73aJMDdy92bUbgj0
	Z4Nlto0Wh/MdLEtAfT7uWWZ6nmWCOEkMXEC43pQDCjYM4tJloe20QTAmjwHg6xiC
	FSp1uh3KeP9ChKhG983Mqb2LZKWL6pgOk8TnPattUaG5agwwVzKHgVQWGXMtPpGT
	K0UH4mtHAo6Q8+aRfKn+XE/pec25W9XmN1rDS8sCgZRBLUzEdD6FwYZrothpMbKx
	d3k7Hj9c/Fgk0JpQDb/u3LwhQqI773VJ2BQ9ZJS80Gpato/JdeTsCRDrPQE//a9V
	nkQtpQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45c6733c5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 20:07:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52EK7EsG028781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 20:07:14 GMT
Received: from [10.216.48.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 14 Mar
 2025 13:07:08 -0700
Message-ID: <4525d045-745a-4d8b-987e-45d3fa9917b5@quicinc.com>
Date: Sat, 15 Mar 2025 01:37:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm/a6xx+: Don't let IB_SIZE overflow
To: Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>
CC: <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        "Rob
 Clark" <robdclark@chromium.org>,
        Connor Abbott <cwabbott0@gmail.com>, "Sean
 Paul" <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav
 Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        "Marijn Suijten" <marijn.suijten@somainline.org>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jordan Crouse
	<jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        open list
	<linux-kernel@vger.kernel.org>
References: <20250314183455.120824-1-robdclark@gmail.com>
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250314183455.120824-1-robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=a5Iw9VSF c=1 sm=1 tr=0 ts=67d48c72 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=cm27Pg_UAAAA:8 a=pGLkceISAAAA:8 a=8h70kQ2kJuFCpcA7z_cA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4Z5HyAAkr8OH45VbzAufHEIhCnbXlY58
X-Proofpoint-ORIG-GUID: 4Z5HyAAkr8OH45VbzAufHEIhCnbXlY58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_08,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140155

On 3/15/2025 12:04 AM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> IB_SIZE is only b0..b19.  Starting with a6xx gen3, additional fields
> were added above the IB_SIZE.  Accidentially setting them can cause
> badness.  Fix this by properly defining the CP_INDIRECT_BUFFER packet
> and using the generated builder macro to ensure unintended bits are not
> set.
> 
> v2: add missing type attribute for IB_BASE
> 
> Reported-by: Connor Abbott <cwabbott0@gmail.com>
> Fixes: a83366ef19ea ("drm/msm/a6xx: add A640/A650 to gpulist")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> Backport notes, prior to commit ae22a94997b8 ("drm/msm: import A2xx-A4xx
> XML display registers database"), just open code, ie:
> 
>    OUT_RING(ring, submit->cmd[i].size & 0xfffff);
> 
> Prior to commit af66706accdf ("drm/msm/a6xx: Add skeleton A7xx
> support"), a7xx_submit() did not exist so that hunk can be dropped.
> 
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c               | 8 ++++----
>  drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml | 7 +++++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index d3978cfa3f20..ea52b7d0b212 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -245,10 +245,10 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>  				break;
>  			fallthrough;
>  		case MSM_SUBMIT_CMD_BUF:
> -			OUT_PKT7(ring, CP_INDIRECT_BUFFER_PFE, 3);
> +			OUT_PKT7(ring, CP_INDIRECT_BUFFER, 3);
>  			OUT_RING(ring, lower_32_bits(submit->cmd[i].iova));
>  			OUT_RING(ring, upper_32_bits(submit->cmd[i].iova));
> -			OUT_RING(ring, submit->cmd[i].size);
> +			OUT_RING(ring, A5XX_CP_INDIRECT_BUFFER_3_IB_SIZE(submit->cmd[i].size));
>  			ibs++;
>  			break;
>  		}
> @@ -382,10 +382,10 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>  				break;
>  			fallthrough;
>  		case MSM_SUBMIT_CMD_BUF:
> -			OUT_PKT7(ring, CP_INDIRECT_BUFFER_PFE, 3);
> +			OUT_PKT7(ring, CP_INDIRECT_BUFFER, 3);
>  			OUT_RING(ring, lower_32_bits(submit->cmd[i].iova));
>  			OUT_RING(ring, upper_32_bits(submit->cmd[i].iova));
> -			OUT_RING(ring, submit->cmd[i].size);
> +			OUT_RING(ring, A5XX_CP_INDIRECT_BUFFER_3_IB_SIZE(submit->cmd[i].size));
>  			ibs++;
>  			break;
>  		}
> diff --git a/drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml b/drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml
> index 55a35182858c..a71bc6f16cbf 100644
> --- a/drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml
> +++ b/drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml
> @@ -2259,5 +2259,12 @@ opcode: CP_LOAD_STATE4 (30) (4 dwords)
>  	</reg32>
>  </domain>
>  
> +<domain name="CP_INDIRECT_BUFFER" width="32" varset="chip" prefix="chip" variants="A5XX-">
> +	<reg64 offset="0" name="IB_BASE" type="address"/>
> +	<reg32 offset="3" name="3">

Why is the offset 3 here? It looks to me that it doesn't match the code
above.

-Akhil.

> +		<bitfield name="IB_SIZE" low="0" high="19"/>
> +	</reg32>
> +</domain>
> +
>  </database>
>  


