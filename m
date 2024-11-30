Return-Path: <linux-kernel+bounces-426223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B4A9DF080
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 14:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7422B212EF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 13:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AE1154457;
	Sat, 30 Nov 2024 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NCV5A7up"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A181DFF7
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732973473; cv=none; b=hPHweujHGxbbjI1kjbcMumIbaPY3GC2WSrwb23u+hAwTDNahMKom84JOIK/0jYqsj1bQUUQhMuM5cbiIjtD1Dx0ieiG6fk6o5PtKhEOgKS17XqkQvgSa/Yoaqi4/qlrPRmV/MqlBx06F4FVrjIluF9UMBDsEWjZncL1hWLKuMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732973473; c=relaxed/simple;
	bh=KPz1SjBztz5JdaMEn6dA+9ukipFu5uVo/ow1c1Z4s74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oS6MEZGvYWBqVGUf4WaznTLQnueYx8Pjv+zXwK7b49KGf4mFztdOHYb0Z0xdAqp1JK0rr8DuAcu7/X2Fz+H5+HI6Gng5q+gUW1gQmubYKv+YYbOo8wZw7E8r+QMoH5kDOpSHwW3w+bue5Kdvmd5S12rwAPC97gtOVgVv+VZi8ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NCV5A7up; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AUCcq9C031891
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 13:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gxJ2wIRNvSM3N6UVUGLPO/sM5c1M6IW8tewhLB69p6s=; b=NCV5A7uphBpvtj1k
	VcAf3jplIuealtib1G1mS7TTTegB+u0yNAj/mHtjvIULIHp0jqtle1iDRav4yAk2
	PaERcYmylCxE9fX7O5nq8kVJ8dt6Rphbnw9yulOOtJmHpTAGVjgUtE1oVfvDh7A7
	udAkT9S6PT47fZ+Z/aY8qe/6juJDUrmyx3D8bzgCpV4MyloYvavAs5ihWPPl9sUR
	4edn9Tz5B4HCox/p0j1Q26dFhPu9afVFG1ZLgoq2NhJD4AWvZNP7/BXka6oHs3LS
	tFviutw9bZZZRJb5HqcUuCZ3+nRkkuBgJsqpvecsJH27iER0tK/75itpn+QFGDmn
	JIlSgg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437tx1rrkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 13:31:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4668f2d0e50so4492761cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 05:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732973469; x=1733578269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxJ2wIRNvSM3N6UVUGLPO/sM5c1M6IW8tewhLB69p6s=;
        b=l2c23Dyu2hncVcFJ7QQfjIHzZOZDO8yJB1VXxs9wg4GttWFM6X4NgcVyQx/rP2/HY5
         dyyH4Xw5yAdpQXkS8aYYuwEwXhBy0feHpmGId6blOEPz+nV4m/v3f4/RGcBuWfVS79FB
         c404NGRbF1HTHVyCbxviDFz7UrQhy5epY4dnSmvGTmYHCVAR2KMkfo2rJ7FBGrhht42b
         u4RmgmSYc7H8oX/6JpWxYgAKEzApPPwmBQnqGSKMDNdXvsAkKbWuw/Raus+JjTcBJgnQ
         fnLXbbUuMGb6QHFEOkLGBFVcQsPZluqarTqx637851cf+05Elvwx9NebDm/SkRR9JMYn
         CtwA==
X-Forwarded-Encrypted: i=1; AJvYcCXQfRDlcUUT+sC20Z4tcW3RSjiOwEFoR/4/TRgolC9KXOnX+3C/79v36eHwPtuf/OTBx84UtpexNdZw8Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbGVRNUQGtkNOSehF6aepBtLvm64oO664ijb4LSzyde/ClB94R
	Uz6V2ECBX0qoGHtrd67Fq5Bc5/iemt7xduM68JDTSacFJiq6pXXzjbBx5H2CorCAl7FfIqvdSNV
	YXzD9T8zB8VHPz+97hb2zmfCVKeB3kUjieULBh9+VPlSwXG3Zq9BHfIFmfilZdsc=
X-Gm-Gg: ASbGncsh0O8us1LLg3ElnRwC1JAZhdp+u4Xn+c6a2d5H8clDvRqFvU7AjHHRe5RgnQX
	NCNJUOm+rNhDaYtkotDt/GE4kPV0LZNCA4xE+TY9/UHMvDHt6Q5HqBe/JiIj4weCr4LU3BSJGj7
	BmOK3bujiGZJAC1puPjF67eUDXtBlxtnbzaTa+tauUHj9LcrBxh/6HS8QSUwUKyLRNPrUUQl0xn
	GYa0pamaj7Hk755C+YYmbA6PlyfCG2UTLVTmxR2fiuNcUc3/S9s45jp/88rsOoRPOc0Vn8Hlx13
	zWEQoRsFiVj9Ybii0KWE9chPhiXOnlM=
X-Received: by 2002:ac8:7c52:0:b0:458:2619:457e with SMTP id d75a77b69052e-466b3611145mr92207551cf.10.1732973469504;
        Sat, 30 Nov 2024 05:31:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFA3A1BRN4RMAIbP6npbCwI+ZoMyXm/5LUNoiC87xG0beQy19ime/EPwkDRNZ07vfeLL4l0Sg==
X-Received: by 2002:ac8:7c52:0:b0:458:2619:457e with SMTP id d75a77b69052e-466b3611145mr92207321cf.10.1732973469125;
        Sat, 30 Nov 2024 05:31:09 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097e8da8fsm2828475a12.58.2024.11.30.05.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 05:31:07 -0800 (PST)
Message-ID: <752484b5-2db1-4714-8046-17cd5496d81d@oss.qualcomm.com>
Date: Sat, 30 Nov 2024 14:31:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/msm/adreno: Introduce ADRENO_QUIRK_NO_SYSCACHE
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241125-a612-gpu-support-v2-0-b7cc38e60191@quicinc.com>
 <20241125-a612-gpu-support-v2-1-b7cc38e60191@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241125-a612-gpu-support-v2-1-b7cc38e60191@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bCzMVFlrLUiN1yQVPbyr3tNiIGp5XBLX
X-Proofpoint-GUID: bCzMVFlrLUiN1yQVPbyr3tNiIGp5XBLX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411300111

On 25.11.2024 5:33 PM, Akhil P Oommen wrote:
> There are a few chipsets which don't have system cache a.k.a LLC.
> Currently, the assumption in the driver is that the system cache
> availability correlates with the presence of GMU or RPMH, which
> is not true. For instance, Snapdragon 6 Gen 1 has RPMH and a GPU
> with a full blown GMU, but doesnot have a system cache. So,
> introduce an Adreno Quirk flag to check support for system cache
> instead of using gmu_wrapper flag.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 3 ++-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 7 +------
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h   | 1 +
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 0c560e84ad5a..5e389f6b8b8a 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -682,6 +682,7 @@ static const struct adreno_info a6xx_gpus[] = {
>  		},
>  		.gmem = (SZ_128K + SZ_4K),
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> +		.quirks = ADRENO_QUIRK_NO_SYSCACHE,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a610_zap.mdt",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -1331,7 +1332,7 @@ static const struct adreno_info a7xx_gpus[] = {
>  		},
>  		.gmem = SZ_128K,
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> -		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
> +		.quirks = ADRENO_QUIRK_HAS_HW_APRIV | ADRENO_QUIRK_NO_SYSCACHE,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a702_zap.mbn",
>  		.a6xx = &(const struct a6xx_info) {

+a619_holi

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 019610341df1..a8b928d0f320 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1863,10 +1863,6 @@ static void a7xx_llc_activate(struct a6xx_gpu *a6xx_gpu)
>  
>  static void a6xx_llc_slices_destroy(struct a6xx_gpu *a6xx_gpu)
>  {
> -	/* No LLCC on non-RPMh (and by extension, non-GMU) SoCs */
> -	if (adreno_has_gmu_wrapper(&a6xx_gpu->base))
> -		return;
> -
>  	llcc_slice_putd(a6xx_gpu->llc_slice);
>  	llcc_slice_putd(a6xx_gpu->htw_llc_slice);
>  }
> @@ -1876,8 +1872,7 @@ static void a6xx_llc_slices_init(struct platform_device *pdev,
>  {
>  	struct device_node *phandle;
>  
> -	/* No LLCC on non-RPMh (and by extension, non-GMU) SoCs */
> -	if (adreno_has_gmu_wrapper(&a6xx_gpu->base))
> +	if (a6xx_gpu->base.info->quirks & ADRENO_QUIRK_NO_SYSCACHE)
>  		return;

I think A612 is the "quirky" one here.. it has some sort of a GMU,
but we're choosing not to implement it. maybe a check for

if (adreno_has_gmu_wrapper && !adreno_is_a612)

would be clearer here, with a comment that RGMU support is not
implemented



But going further, I'm a bit concerned about dt-bindings.. If we
implement RGMU on the driver side in the future, that will require
DT changes which will make the currently proposed description invalid.

I think a better angle would be to add a adreno_has_rgmu() func with
a qcom,adreno-rgmu compatible and plumb it correctly from the get-go.

This way, we can avoid this syscache quirk as well.

Konrad

