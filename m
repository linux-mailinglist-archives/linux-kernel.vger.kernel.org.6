Return-Path: <linux-kernel+bounces-179067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C9B8C5B34
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4474FB22849
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56723180A85;
	Tue, 14 May 2024 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jUUudZ4h"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E646F53E15;
	Tue, 14 May 2024 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711951; cv=none; b=hQLHeozWWaOIcJvmryCL5tFjXFT6j9wd6rff31dALF+xTpyc3Q3o1gTgr/WXLl7MDwZU4INqBJESkez0znTpGBxyBoLWGEmIntG+HNLr99vzJIcY4++Eh2ipk5Wh1qKHV+1q6cdOxogGzKM7hyPflZnt4DIttgviRU5QfFQyxOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711951; c=relaxed/simple;
	bh=czIKGh7kjFcE4G5Q93DQfzMgugJbdzW9uTBDHG77UC8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiKGoDK156yO1KmOwdIFTqii8M8wva9W4gEJbRSmBlcjIsxNqJB0uASMN2I/6QlCV6ECVnTN1nBILd8mTT8uE8rK5adWd/mblM/bN6QcmqGncLnsxSqmxaG26pf6aYtDSK5f6i9K6Ggi3ges6gAhQZt0dw1vipJ5mOgIgtBhO3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jUUudZ4h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44EHQXUh022836;
	Tue, 14 May 2024 18:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=m/fiLvJsWpr9G6qsukFEU
	Sc5hV1grK9gRSXaYOAzDis=; b=jUUudZ4hGYU5ek3zT/lUmOCfB2QjzUM5/9X/y
	i7KXsfXaNOeHJ+QK3zcI2xzop4uUTGtYJ5KD5m4zl1oNXuhMNAOBnGwShsVuh62I
	c/0TvWxYTgk8e5kTh9Nh+6jqZH/VsbCi0P/RiWgKp4Dc3yRIvdRWnMIzCGjwuY3t
	0W+3NCGJ1FsMMMnJIX/cl0fLF+fnWjxFvwPUGkOYaBkUhQ5XKe9d/wIgyK/qgScC
	Q7Ol7XqFA6zhgnSgBHWcZDTNs9+TEm8UvBcI8scDTavs1+qDTV8yQdalDPu23i4M
	o1LJcFXm3JxSVzKPZSiL+JhgUNLyWcUGYVj4o6jSxEogGRZQw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y1ymq77v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 18:38:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44EIcvpS006115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 18:38:57 GMT
Received: from hu-akhilpo-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 May 2024 11:38:53 -0700
Date: Wed, 15 May 2024 00:08:49 +0530
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "Abhinav
 Kumar" <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/adreno: De-spaghettify the use of memory barriers
Message-ID: <20240514183849.6lpyplifero5u35r@hu-akhilpo-hyd.qualcomm.com>
References: <20240508-topic-adreno-v1-1-1babd05c119d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240508-topic-adreno-v1-1-1babd05c119d@linaro.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4hgFhaRoHXPTduSItrerIsVUgSm4UFkq
X-Proofpoint-ORIG-GUID: 4hgFhaRoHXPTduSItrerIsVUgSm4UFkq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_11,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 mlxlogscore=649 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405140132

On Wed, May 08, 2024 at 07:46:31PM +0200, Konrad Dybcio wrote:
> Memory barriers help ensure instruction ordering, NOT time and order
> of actual write arrival at other observers (e.g. memory-mapped IP).
> On architectures employing weak memory ordering, the latter can be a
> giant pain point, and it has been as part of this driver.
> 
> Moreover, the gpu_/gmu_ accessors already use non-relaxed versions of
> readl/writel, which include r/w (respectively) barriers.
> 
> Replace the barriers with a readback that ensures the previous writes
> have exited the write buffer (as the CPU must flush the write to the
> register it's trying to read back) and subsequently remove the hack
> introduced in commit b77532803d11 ("drm/msm/a6xx: Poll for GBIF unhalt
> status in hw_init").
> 
> Fixes: b77532803d11 ("drm/msm/a6xx: Poll for GBIF unhalt status in hw_init")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  5 ++---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 14 ++++----------
>  2 files changed, 6 insertions(+), 13 deletions(-)

I prefer this version compared to the v2. A helper routine is
unnecessary here because:
1. there are very few scenarios where we have to read back the same
register.
2. we may accidently readback a write only register.

> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 0e3dfd4c2bc8..4135a53b55a7 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -466,9 +466,8 @@ static int a6xx_rpmh_start(struct a6xx_gmu *gmu)
>  	int ret;
>  	u32 val;
>  
> -	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 1 << 1);
> -	/* Wait for the register to finish posting */
> -	wmb();
> +	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, BIT(1));
> +	gmu_read(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ);

This is unnecessary because we are polling on a register on the same port below. But I think we
can replace "wmb()" above with "mb()" to avoid reordering between read
and write IO instructions.

>  
>  	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_RSCC_CONTROL_ACK, val,
>  		val & (1 << 1), 100, 10000);
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 973872ad0474..0acbc38b8e70 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1713,22 +1713,16 @@ static int hw_init(struct msm_gpu *gpu)
>  	}
>  
>  	/* Clear GBIF halt in case GX domain was not collapsed */
> +	gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);

We need a full barrier here to avoid reordering. Also, lets add a
comment about why we are doing this odd looking sequence.

> +	gpu_read(gpu, REG_A6XX_GBIF_HALT);
>  	if (adreno_is_a619_holi(adreno_gpu)) {
> -		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
>  		gpu_write(gpu, REG_A6XX_RBBM_GPR0_CNTL, 0);
> -		/* Let's make extra sure that the GPU can access the memory.. */
> -		mb();

We need a full barrier here.

> +		gpu_read(gpu, REG_A6XX_RBBM_GPR0_CNTL);
>  	} else if (a6xx_has_gbif(adreno_gpu)) {
> -		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
>  		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
> -		/* Let's make extra sure that the GPU can access the memory.. */
> -		mb();

We need a full barrier here.

> +		gpu_read(gpu, REG_A6XX_RBBM_GBIF_HALT);
>  	}
>  
> -	/* Some GPUs are stubborn and take their sweet time to unhalt GBIF! */
> -	if (adreno_is_a7xx(adreno_gpu) && a6xx_has_gbif(adreno_gpu))
> -		spin_until(!gpu_read(gpu, REG_A6XX_GBIF_HALT_ACK));
> -

Why is this removed?

-Akhil

>  	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
>  
>  	if (adreno_is_a619_holi(adreno_gpu))
> 
> ---
> base-commit: 93a39e4766083050ca0ecd6a3548093a3b9eb60c
> change-id: 20240508-topic-adreno-a2d199cd4152
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 

