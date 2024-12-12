Return-Path: <linux-kernel+bounces-443906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7E99EFD52
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96764286EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246A11B21AA;
	Thu, 12 Dec 2024 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f2Ql4mnL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7908189BAF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034888; cv=none; b=WECg2nlxbe4kWzm800DK7fJl1RmvzewR6E+1icCXbQBP3wW8V5fjGXRuyq2h/u90gyQyCIEjGuy5u8/bavSp8luOlrd/o+oCDXCAG6SmGiuUonWwbOrBR3BiqqmU70xOoPMhYC3P/wAVi9sZMFHP1D2qRc5WCuYKluLkiTP/CTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034888; c=relaxed/simple;
	bh=lnbiGDICBPKUGbMsuUDe070QnpEu+VQV/gPE7SSROc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0KPFp5xYiHEmC3jlkRB0i/KG8MPUGB0KkaNkd1EaTyD7UYDPXtcfCKpwbDNIYycYhYaj1jDgKfr5W7pkjo83DTVDSk+TjO+ucpRklY8FQK5Rb8lugVs9OUu40M5sTakMGmld7GtxTflyrHwEbjvBOmi4tyhuG3N6/2zWelZRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f2Ql4mnL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCICobZ022917
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7hwbIErcsoN4GpMsinEbq0OUuK0bXMQyc2AxZ7xTRrs=; b=f2Ql4mnL23gJH5Xm
	5xHz9ddBNOpxZsugr71q1dytDxqimObkkd/bfU2jhukHQKRIQ/guR2XWui4Wex0Q
	uVFMkDK2PZ5p9q10ym50Ms4cF3+tiGX/Re9kzcdhsKoEyDOtHlIKHLTiwL8V3fSX
	wRtPI7SSGilvQ+qn4dTKFyCBFN6c01QkHz3/hm+I8PuMrPuYy8fQHgpObZdxIONS
	Fh6UiKXMeIb/1zeqoxOumrYOhFT3qTmp/VrjGFm0bTyAZwnbc7QeQiSRDcnQOwyN
	GHUaA2vzr5sgk274oICmHiiwwANFtjw0v4tYtst/NrpEUj2bjudF8RdhuHcgxcqG
	s68GXw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43g4wn894t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:21:24 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6db1009a608so1044366d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734034883; x=1734639683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hwbIErcsoN4GpMsinEbq0OUuK0bXMQyc2AxZ7xTRrs=;
        b=Jlwcso5ochyaUYMRRiFvMtHKArQewWKnIuQqhwAH7C4aIB/50Yvd0dxDV/J9q78YAO
         TqeysdCOgNCoWHcxTYIH8tkGQ72CkuClWwl/qdGg6N62s0XxkU/5A5TujGj0FYli7fzG
         B57pBa05jn4ryMtbw8wG+7gQovfZFC1VG1vSxmkdEnKEtt5LcLW22QhE8ho+NeCSvOCn
         Im8aCY3Y1kLUilZzq7zpqgy4BtlUSXrUU/JIonHDUsT6FW21gkln4eVKiLggrkJI3XLz
         DtVNKzX8dIxJzwIxmaEA23Vv0rHgG/GR9JXorMt2GAu/ExlAdFD1EdMM4aZib64Byh7Q
         UGLg==
X-Forwarded-Encrypted: i=1; AJvYcCVn0DZTPnRWH807dQVFUe9SX0WOfzGaON2Hq3TT9JNZu4vCdbY5cF7n4ycZ654wB2AjCjL7RCtjkBjvLNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ZHfq8RN4d7nfn03Ari6LQQf9GXaKti2w0ZmyLqlNfPO9Rt9q
	HXajSWhvY36eRn94zlVGOmoPayn5dmGM8DQtaL0V/xJVglYFaUyShxPWSx52vLB9OLflFtHyjET
	rgYq0UHes14qVgATydh+MvdVM5QaaC1jd1uZtZ/NgofUVYVybripj+jmc+Sh+NIU=
X-Gm-Gg: ASbGncugR6gFaH/aNh5y+7vApAIQYm+c2d3efgL6gH7C9DzPONylh7YtyRQMdQR3ajW
	sRjaV7K9UD/B8cYTXAdgwgjzGZPETnVbwHveVy1MueoXeazs6+WNQz5poIqoLAI+U2iiq+JxzMX
	XwxX57kAiGg9cCX8DQ0bpvAYinpu4Iu3raEGYszMbP7HKk/zOvL+u9DYGQiPXMmIgyoPnpMM29o
	2nqKQJbf8r3jKrSXlAatulHOhfC6qSPenBRIMiigrsI5CY+CvVBYTX4CGc+AjdmRjd0ehZzPape
	IjbzwP3BhtGM/MQyoGit+iKLkWyA6WiC2Z9New==
X-Received: by 2002:a05:6214:528d:b0:6d4:2db5:e585 with SMTP id 6a1803df08f44-6db0f704123mr9378106d6.1.1734034883403;
        Thu, 12 Dec 2024 12:21:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFy3so1lvDr+vr11bSRGt9FQBphmUj+4Zo6HiK7Y4JuHMAjDDbDQrFuFQWWlQEjDLaG1rQy9A==
X-Received: by 2002:a05:6214:528d:b0:6d4:2db5:e585 with SMTP id 6a1803df08f44-6db0f704123mr9377886d6.1.1734034883034;
        Thu, 12 Dec 2024 12:21:23 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa673474e27sm742971366b.102.2024.12.12.12.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 12:21:21 -0800 (PST)
Message-ID: <ddf91ba2-cab2-4653-b842-65a8e82b5160@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 21:21:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] drm/msm: adreno: find bandwidth index of OPP and
 set it along freq index
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20241211-topic-sm8x50-gpu-bw-vote-v5-0-6112f9f785ec@linaro.org>
 <20241211-topic-sm8x50-gpu-bw-vote-v5-4-6112f9f785ec@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241211-topic-sm8x50-gpu-bw-vote-v5-4-6112f9f785ec@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XIb9F5jqSFocLWeb5MtQIGiRKt-3abrO
X-Proofpoint-GUID: XIb9F5jqSFocLWeb5MtQIGiRKt-3abrO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412120148

On 11.12.2024 9:29 AM, Neil Armstrong wrote:
> The Adreno GPU Management Unit (GMU) can also scale the DDR Bandwidth
> along the Frequency and Power Domain level, until now we left the OPP
> core scale the OPP bandwidth via the interconnect path.
> 
> In order to enable bandwidth voting via the GPU Management
> Unit (GMU), when an opp is set by devfreq we also look for
> the corresponding bandwidth index in the previously generated
> bw_table and pass this value along the frequency index to the GMU.
> 
> The GMU also takes another vote called AB which is a 16bit quantized
> value of the floor bandwidth against the maximum supported bandwidth.
> 
> The AB is calculated with a default 25% of the bandwidth like the
> downstream implementation too inform the GMU firmware the minimal
> quantity of bandwidth we require for this OPP.
> 
> Since we now vote for all resources via the GMU, setting the OPP
> is no more needed, so we can completely skip calling
> dev_pm_opp_set_opp() in this situation.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 39 +++++++++++++++++++++++++++++++++--
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c |  6 +++---
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.h |  5 +++++
>  4 files changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 36696d372a42a27b26a018b19e73bc6d8a4a5235..46ae0ec7a16a41d55755ce04fb32404cdba087be 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -110,9 +110,11 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
>  		       bool suspended)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	const struct a6xx_info *info = adreno_gpu->info->a6xx;
>  	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>  	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>  	u32 perf_index;
> +	u32 bw_index = 0;
>  	unsigned long gpu_freq;
>  	int ret = 0;
>  
> @@ -125,6 +127,37 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
>  		if (gpu_freq == gmu->gpu_freqs[perf_index])
>  			break;
>  
> +	/* If enabled, find the corresponding DDR bandwidth index */
> +	if (info->bcms && gmu->nr_gpu_bws > 1) {

if (gmu->nr_gpu_bws)

> +		unsigned int bw = dev_pm_opp_get_bw(opp, true, 0);
> +
> +		for (bw_index = 0; bw_index < gmu->nr_gpu_bws - 1; bw_index++) {
> +			if (bw == gmu->gpu_bw_table[bw_index])
> +				break;
> +		}
> +
> +		/* Vote AB as a fraction of the max bandwidth */
> +		if (bw) {

This seems to only be introduced with certain a7xx too.. you should
ping the GMU with HFI_VALUE_GMU_AB_VOTE to check if it's supported

> +			u64 tmp;
> +
> +			/* For now, vote for 25% of the bandwidth */
> +			tmp = bw * 25;
> +			do_div(tmp, 100);
> +
> +			/*
> +			 * The AB vote consists of a 16 bit wide quantized level
> +			 * against the maximum supported bandwidth.
> +			 * Quantization can be calculated as below:
> +			 * vote = (bandwidth * 2^16) / max bandwidth
> +			 */
> +			tmp *= MAX_AB_VOTE;
> +			do_div(tmp, gmu->gpu_bw_table[gmu->nr_gpu_bws - 1]);
> +
> +			bw_index |= AB_VOTE(clamp(tmp, 1, MAX_AB_VOTE));
> +			bw_index |= AB_VOTE_ENABLE;
> +		}
> +	}

BTW, did you dump the values we send to the GMU here and in the RPMh
builder part & validate against downstream?

Konrad

