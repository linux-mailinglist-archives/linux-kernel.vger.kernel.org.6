Return-Path: <linux-kernel+bounces-537345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36DAA48AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497EB188C570
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B9A270EA2;
	Thu, 27 Feb 2025 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="byUc7cDF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9707B1E3DD7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692714; cv=none; b=OTaFgeZucDdgrlKjpBVOAw0VIvY+7LQ2Tpy/yYJUcjEssV9lJllwwmrykySaRYnRTfpsUa9LVupYyeFuFEc544JyBZZ5PBp/RU6gtm2E7Y8laoE9D0GJDIKew7Rg81fowLm2wmcRx9iaM/gunGXakRSez/IF68c5AR7pL4nZ9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692714; c=relaxed/simple;
	bh=C8qfB6+wenyjSqnbDL3aZEselLtVlPaffdmp9czXrAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yd356/RwbuFqlIoafmrqSvORXbZmYNLH5RpafY4CFVkXDVTK2/dAnJjnFK2e0L/m9h/ZqokZzsG5xzwnckrHwhGYsq8ZvtMgjx4ULPQ8Pu11mQpZZ02nlH4TokBPRW1HHO4H+BPpiY2cz/fGoKmXAaLpsCSVdc0AoA340GBWEys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=byUc7cDF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RAmAeD003209
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pPBKVO+2HKSAMc7Se1bC13bCptlwACdJvuRTzPMifj8=; b=byUc7cDFabjRDYma
	2ED9iqovTOEpSD2UVewCDm+HOWFJnTYLUgnX2puyPhPfHY3pXrB/nyl2fz3kz8Jk
	oGkDDrB0O80taq43Raf6XsMdF1ySqJthhAaHgWi0n6PchthQ/wPg+JFCvpO3aJ5+
	bhmdr2uX/lIzzgN8W4R68H10xaGt0JglEaTZm0ABT5f7AjOpLSlVY0oTHy2pCgXR
	Zbq+A4O/gcV2ha22CYHxZJkKCifo5gxez6cot/GNaavDw8gdnrakGn3o5eZyk1vS
	DWKcKpvNZbVhDL80H/XhhUDl4PjsKuXmcRNE1SU2TP8CGdqxkpkURIW7LiXjjaAe
	WpV01A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 452pm7huj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:45:11 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e892c72145so2411116d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740692710; x=1741297510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPBKVO+2HKSAMc7Se1bC13bCptlwACdJvuRTzPMifj8=;
        b=I2FHUxExn2uc9Gv5PLomJvdO1y/hcQylB8ozjxgzvp+mXT/RyEfIyi0Z44LHCPCHQp
         CVgBXMAHLhK2DvOtpUm2mFNORdlhdGXiWwEp/PJnTvvtHvl8P/5OO1kV59eumtJPDB0+
         siDbfnHS6FQ3cDjTe9wt06yptdRVlx719y6rUcmKBaPNIPDRAENkTn8/ISWweuMVIbk9
         BjNddPsriwgu4msxg8zYPIBWE8EKRsbIlp0mxaBAMPVtnXFW3aUymo1Ep0KzYDWxwP03
         h0wjpcNQYko7yzrnnBilAQlzEBy4/AmURcyO3CpvoIAZFXcOK882d+Cac8fGOSeQm1rH
         iZvg==
X-Forwarded-Encrypted: i=1; AJvYcCX6ANK1CG/nQCZ54eeIM2M4cHpciLoR8fpgzx1M79FeHvWgY1MjtLr2yzKiEiDr0h4zziKAJ8u1ioFTG80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8DhuNPCl2D3PocluPDAfYIE3cYhCG/fbU8W9oMupMkHm8TKzK
	6lw9QYZGMuMPQTtZ9AM6aCdwGe8CsWOWxZv8jhgm6YzMc2vkO8RbNaqxnm8bnKQYS5DfSTdLzVa
	FC/kQVLQaNRrn/OQTbvFKXdotEtFOdkK3N43RKbvLatP+xbcAZx1Iph2PahKJ6/E=
X-Gm-Gg: ASbGncvm1IToUt1JS8DfIYYxuTCxFL1lnryCnoI4/8yiE/dXKbwrNL7O7hGNJEzZdrB
	dgDjnP2sWEYbx1tVOx+Xr0zP6CSNgXy5JNc1DyXQ7waXSODE/0i4utsWc0zFFNek4SKy5qEThi6
	ilR/t3wIu3VpxQ5vnynyl9UXHoqsv8BGpajum8eREN/QIx1r2RD3hzdvglQEDxyf5INXs1ipDSU
	U2AIoDDl0eBWyVZxlyvDGNawmA64EJ+Y9LooKHWLOYvFcUcPBZZ8D9gYdcEmyRZU+bHaOakSQNn
	eMQ/LXhOqT4df7bX1N4+woKLvmoYercBtAquanQCLYKgUlrOc/XfJqjfMHLW5I7JNTIP5Q==
X-Received: by 2002:a05:6214:2aad:b0:6e4:2e03:c54c with SMTP id 6a1803df08f44-6e8a0d9dac7mr6021016d6.10.1740692710376;
        Thu, 27 Feb 2025 13:45:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHL2H3h1fXY/M+zGEyzBHinGXz7e+qU8JKuFYeji+RiUMLgw7RNmuLoI3TzZXEd8LNSaq4xjg==
X-Received: by 2002:a05:6214:2aad:b0:6e4:2e03:c54c with SMTP id 6a1803df08f44-6e8a0d9dac7mr6020696d6.10.1740692709869;
        Thu, 27 Feb 2025 13:45:09 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0dcb07sm182253466b.47.2025.02.27.13.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 13:45:09 -0800 (PST)
Message-ID: <234cfd96-04f9-416a-84ee-fe127f81f49d@oss.qualcomm.com>
Date: Thu, 27 Feb 2025 22:45:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] drm/msm/a6xx: Add support for Adreno 623
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
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
 <7ffcc2fc-c783-49de-b01f-9ffb442d2a72@oss.qualcomm.com>
 <70c7f4fc-137c-442a-b65e-3743d7b1b736@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <70c7f4fc-137c-442a-b65e-3743d7b1b736@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Y9OByJ4h_IEM8YwVS3YEehwpKZzUaHQf
X-Proofpoint-GUID: Y9OByJ4h_IEM8YwVS3YEehwpKZzUaHQf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270161

On 27.02.2025 10:06 PM, Akhil P Oommen wrote:
> On 2/28/2025 1:59 AM, Konrad Dybcio wrote:
>> On 27.02.2025 9:07 PM, Akhil P Oommen wrote:
>>> From: Jie Zhang <quic_jiezh@quicinc.com>
>>>
>>> Add support for Adreno 623 GPU found in QCS8300 chipsets.
>>>
>>> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>>> ---
>>>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c   | 29 +++++++++++++++++++++++++++++
>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c       |  8 ++++++++
>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  2 +-
>>>  drivers/gpu/drm/msm/adreno/adreno_gpu.h     |  5 +++++
>>>  4 files changed, 43 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>> index edffb7737a97b268bb2986d557969e651988a344..53e2ff4406d8f0afe474aaafbf0e459ef8f4577d 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>> @@ -879,6 +879,35 @@ static const struct adreno_info a6xx_gpus[] = {
>>>  			{ 0, 0 },
>>>  			{ 137, 1 },
>>>  		),
>>> +	}, {
>>> +		.chip_ids = ADRENO_CHIP_IDS(0x06020300),
>>> +		.family = ADRENO_6XX_GEN3,
>>> +		.fw = {
>>> +			[ADRENO_FW_SQE] = "a650_sqe.fw",
>>> +			[ADRENO_FW_GMU] = "a623_gmu.bin",
>>> +		},
>>> +		.gmem = SZ_512K,
>>> +		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>>> +		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
>>> +			ADRENO_QUIRK_HAS_HW_APRIV,
>>> +		.init = a6xx_gpu_init,
>>> +		.a6xx = &(const struct a6xx_info) {
>>> +			.hwcg = a690_hwcg,
>>
>> You used the a620 table before, I'm assuming a690 is correct after all?
> 
> Correct. a690_hwcg array has the recommended values for a623.

Thanks for double checking

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

