Return-Path: <linux-kernel+bounces-537273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BCCA489E1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C2E188F7A7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F1726FDA0;
	Thu, 27 Feb 2025 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DrECWy27"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D5226E97A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688175; cv=none; b=Re8RO2JMLP649/Q/rssQ5VEUggf7ES5j1v2Bd1Cg9JmGWA+D5Vo3NZtWVwZuHPjiicm6+sdlbtfTsgPjQ2FwQgojDM5VN4ZEtrP7i8dSYYbU/jxCFwuurKgoAatAYrn8RVeV8dCeRXLTGa3hI+EIJwl/xd6Qm9U4vqtOznvpDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688175; c=relaxed/simple;
	bh=PQWN+lgxZqPxEPgdzTFGJuSHRJdqN3FGfR8dBOWtDkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYzj1dXkxkEwKEEAz5xujlGIyBVbCDAKjtNvMG9RJa8kC0PeFLfCI+YA1bhFhfwnqArgaj9II1JbQ8Vs6ZZC9xK8Z4r7kjDw4HhvFIM7ASkKv/tcZXyIWfftv+hRDqXQPh0MB3ogf2aqEBr8bEWwMylhAXPec5vlWpbhTtWemsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DrECWy27; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJSqoI025285
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rdz3BwWFGxS8sRJ2eAc3H5jI9A0FhVUYuzt3xIUmMfE=; b=DrECWy27O4CoUQ6B
	8yywe+p6u1m2G7Ee3kmUUCSZCqZ2Iw/rxM8Y0/M3zLlbv9Ifdc3QDvSEv8DxJzSe
	vuJ9A0SlzgpfUDrQ1Jt8lldC4QT2lQVeNEGET5d91FJrtAvvdXomkMPSe2/RA1bi
	zXOu1T+r2WabLv8uLZMjsFAPZE+PAj5U2pa8L1d4sLKNSVDfKDYrHpcMA9+goivA
	VGcQheO511LEgT8l7NgJr0Y8DkSnhy2MfSsyZwJIJ62fNzku1jefr9+hVxiC9eBf
	x8T5geQgLuTTtHJuZY5XYg6ckeiMpXWvJv0MpdpKjFqi5Ns8s/tNJ84o4sv4cjtj
	6ZojJw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prmpyye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:29:32 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e89b5746d0so1844146d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740688172; x=1741292972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdz3BwWFGxS8sRJ2eAc3H5jI9A0FhVUYuzt3xIUmMfE=;
        b=HSTol2IHLToEslNS8+6Pw9NWFUCgUGUXxXknaPq/C/hlGmpxuXNmss+btAvD98Y4G3
         2XXxniiUYHN+PpeoStcYj8dN0ZnK97YKThrINY1NSfklFg0HGyKyVOkmIApWvv2TN0LC
         Lc3xjzLT5x7cYHjP+KuqN5+egzF36dezummiAeOSh8l3Xw1SrX0wD6BjOvsNRRWmswhB
         mz5vv1n+rDfIXvLPf7e8EOwFQQLyL6yTxh1cppF5nDa9qOY7ugp5Mu7tTMP7/9vfJQf7
         bt40B9cuqAk+q0PI4KIBQWzyP6XqW8bOhtR5RER5PMUxkOawZJeZ3P2WfRkBlfjbqUyP
         Hfrw==
X-Forwarded-Encrypted: i=1; AJvYcCULGc8KgzwHXXaW4ZFiQ7P/iYxp3efaobbTp/ryZDn0ez8TIMDJbDun/EAAc1u/NeoA9ol45idGSNMcYlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs6dDrmq31qHl153us+RvrMb/0lbgGiIoYzc2UJyObl4eCGIED
	20lrkm+Y4QueUiTWmYFuoTT14RhGioSpnrCQPKmkDCTcWVXE84o0/nQqOo6rijRGBJ9Z5QCh1o5
	Y0tNqwDlpuexMi1lahrfqc8KPZs5bAom8nhjrQge+e9PGrYf0LyEmvP4UecfUCg8=
X-Gm-Gg: ASbGnctjIc5o/gZ/VmVQE1LPhUuGgYPvNW7Mk9Bs0ObWkQIHFy2XEWtRdNHXzX9szL4
	micb6nnU3FlK3QUSKbA32vJ7Bld1Qpqil9o0x0xhSCkWSsabdqnd5XkRIQD0NHlF3Pm/7KaKeYa
	P8crgxG0wl8/NqNsf9JvxLX6vs/lSfSWQc3R2U7L0Ww63i5xIpyanwGF561pScQ+AAZI0ctmidS
	3szNAvDl4LgfNQi8Jp0b8466ttxPWgJSGDk/+0ht21/do2qKE4xy9asKPZ8IDwmtrahyX6uYFWK
	hgwS5/sf6qhQZIQ5sA9cQelhMYhKCC2jo93QxnTK9bun9dnoiSba75J+MrXiI+h7pvYSPA==
X-Received: by 2002:a05:6214:5006:b0:6e8:9ac9:55b8 with SMTP id 6a1803df08f44-6e8a0c7d646mr4995746d6.2.1740688172067;
        Thu, 27 Feb 2025 12:29:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFp08iDf7beYh6+dvjAc+g6WR7kEIPaDwueuBvEdPQwdhLWHvqK0vAhDkPw7V5LNXpNIx57xQ==
X-Received: by 2002:a05:6214:5006:b0:6e8:9ac9:55b8 with SMTP id 6a1803df08f44-6e8a0c7d646mr4995516d6.2.1740688171740;
        Thu, 27 Feb 2025 12:29:31 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c7bc015sm173071666b.164.2025.02.27.12.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 12:29:30 -0800 (PST)
Message-ID: <7ffcc2fc-c783-49de-b01f-9ffb442d2a72@oss.qualcomm.com>
Date: Thu, 27 Feb 2025 21:29:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] drm/msm/a6xx: Add support for Adreno 623
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>
References: <20250228-a623-gpu-support-v2-0-aea654ecc1d3@quicinc.com>
 <20250228-a623-gpu-support-v2-3-aea654ecc1d3@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250228-a623-gpu-support-v2-3-aea654ecc1d3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ac7Lw51qqpL8ODjCqtrbAbhtGPaJNYGy
X-Proofpoint-ORIG-GUID: ac7Lw51qqpL8ODjCqtrbAbhtGPaJNYGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502270152

On 27.02.2025 9:07 PM, Akhil P Oommen wrote:
> From: Jie Zhang <quic_jiezh@quicinc.com>
> 
> Add support for Adreno 623 GPU found in QCS8300 chipsets.
> 
> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c   | 29 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c       |  8 ++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  2 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h     |  5 +++++
>  4 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index edffb7737a97b268bb2986d557969e651988a344..53e2ff4406d8f0afe474aaafbf0e459ef8f4577d 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -879,6 +879,35 @@ static const struct adreno_info a6xx_gpus[] = {
>  			{ 0, 0 },
>  			{ 137, 1 },
>  		),
> +	}, {
> +		.chip_ids = ADRENO_CHIP_IDS(0x06020300),
> +		.family = ADRENO_6XX_GEN3,
> +		.fw = {
> +			[ADRENO_FW_SQE] = "a650_sqe.fw",
> +			[ADRENO_FW_GMU] = "a623_gmu.bin",
> +		},
> +		.gmem = SZ_512K,
> +		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> +		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> +			ADRENO_QUIRK_HAS_HW_APRIV,
> +		.init = a6xx_gpu_init,
> +		.a6xx = &(const struct a6xx_info) {
> +			.hwcg = a690_hwcg,

You used the a620 table before, I'm assuming a690 is correct after all?

Konrad

