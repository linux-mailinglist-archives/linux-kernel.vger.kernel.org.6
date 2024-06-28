Return-Path: <linux-kernel+bounces-234093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E657791C21F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C991F2169D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344AF1C232D;
	Fri, 28 Jun 2024 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nxv7EW6o"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0B1C2314;
	Fri, 28 Jun 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587424; cv=none; b=EjNsvGfRir/REey8h3bluKJ3/BiqBXwaYmJJhF5IrytY+Ek9Hytr6c0HunLBurDe+t4iw1KMMWMSPb7qWR8LO0Szb/jG9iV0ksfbXWMm17n7d43jhDLcXCT11I4RBU+pQ3kbpO2qV/INGUUeqF3vModhZ5PeviVnHvNZeSmqx0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587424; c=relaxed/simple;
	bh=4pOtqd7aznQ0H5L6NPfL6p00KX7xxaxSb9ApwXmQB/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SGQVSL9hts2ezTu4pyhGWlLf/4IH/DptBQoGp+ThpQ25vU6tQuRac1Dy2sOkNBR6ZOJSdgKWavxU/vGKvKHucTnBL+Jg3lFlM0oNGG7JELjU5jhy9ZGZuSWUSjATfaVQHWhLjqpYYqFGynb+Gk9IBi6cXeClNfk4uefYO7edJKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nxv7EW6o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SEWxDj015132;
	Fri, 28 Jun 2024 15:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GOng33xxFnbzPXnOdxfJnKWb6UEonBkwu9pgAcPZdE4=; b=nxv7EW6o8mU/upED
	23gXpzsJHtG2aq0Cxa64zO+ma+c32vKwfS3XZG+Eww5U4EvqaekYIPKYT9YR5iwY
	jj4F+ej8L59PniZK5/I67Qtn0iYr5sn8fR9C2zcZkOJlva3g+uOJivlB/dMdOlnP
	NqvZUYb6D21ZhMib80NCbLw2OeHEAr/Bnh6UIWmRSXelON8A/loqRqe18g6/z5n7
	j40QX/eFw5tpkhKJSPkO/vI5INRr+8nHkG3FEDQ8bd5Ez62zb60eRm6mmSVxHsql
	DVYDv+qtwrXuDNjyXLzCdJdU8UNRYwtCsP5CxplsEvR0kcWHsfJqpSV35sOnL9S1
	aWWRLQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqsj0dk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 15:09:58 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45SF9ve1024972
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 15:09:57 GMT
Received: from [10.216.25.91] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Jun
 2024 08:09:52 -0700
Message-ID: <0650ba0a-4453-4e2d-8a76-0f396ac1999c@quicinc.com>
Date: Fri, 28 Jun 2024 20:39:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/6] iommu/arm-smmu: add support for PRR bit setup
To: Rob Clark <robdclark@gmail.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <jgg@ziepe.ca>, <jsnitsel@redhat.com>, <robh@kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <quic_c_gdjako@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <iommu@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240628140435.1652374-1-quic_bibekkum@quicinc.com>
 <20240628140435.1652374-7-quic_bibekkum@quicinc.com>
 <CAF6AEGvroi8rJimFv95tkWmRFa5_aTpBJ7GFcRAuZpLGdSyEYQ@mail.gmail.com>
Content-Language: en-US
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <CAF6AEGvroi8rJimFv95tkWmRFa5_aTpBJ7GFcRAuZpLGdSyEYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uG4YaFbvO4k6-zmB8RNoJGODp6maD0wO
X-Proofpoint-GUID: uG4YaFbvO4k6-zmB8RNoJGODp6maD0wO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_10,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406280112



On 6/28/2024 7:47 PM, Rob Clark wrote:
> On Fri, Jun 28, 2024 at 7:05 AM Bibek Kumar Patro
> <quic_bibekkum@quicinc.com> wrote:
>>
>> Add an adreno-smmu-priv interface for drm/msm to call
>> into arm-smmu-qcom and initiate the PRR bit setup or reset
>> sequence as per request.
>>
>> This will be used by GPU to setup the PRR bit and related
>> configuration registers through adreno-smmu private
>> interface instead of directly poking the smmu hardware.
>>
>> Suggested-by: Rob Clark <robdclark@gmail.com>
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 23 ++++++++++++++++++++++
>>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
>>   include/linux/adreno-smmu-priv.h           |  6 +++++-
>>   3 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index bd101a161d04..64571a1c47b8 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -28,6 +28,7 @@
>>   #define PREFETCH_SHALLOW       (1 << PREFETCH_SHIFT)
>>   #define PREFETCH_MODERATE      (2 << PREFETCH_SHIFT)
>>   #define PREFETCH_DEEP          (3 << PREFETCH_SHIFT)
>> +#define GFX_ACTLR_PRR          (1 << 5)
>>
>>   static const struct actlr_config sc7280_apps_actlr_cfg[] = {
>>          { 0x0800, 0x04e0, PREFETCH_DEFAULT | CMTLB },
>> @@ -235,6 +236,27 @@ static void qcom_adreno_smmu_resume_translation(const void *cookie, bool termina
>>          arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_RESUME, reg);
>>   }
>>
>> +static void qcom_adreno_smmu_set_prr(const void *cookie, phys_addr_t page_addr, bool set)
>> +{
>> +       struct arm_smmu_domain *smmu_domain = (void *)cookie;
>> +       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
>> +       u32 reg = 0;
>> +
>> +       writel_relaxed(lower_32_bits(page_addr),
>> +                               smmu->base + ARM_SMMU_GFX_PRR_CFG_LADDR);
>> +
>> +       writel_relaxed(upper_32_bits(page_addr),
>> +                               smmu->base + ARM_SMMU_GFX_PRR_CFG_UADDR);
>> +
>> +       reg =  arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR);
>> +       reg &= ~GFX_ACTLR_PRR;
>> +       if (set)
>> +               reg |= FIELD_PREP(GFX_ACTLR_PRR, 1);
>> +       arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_ACTLR, reg);
>> +
> 
> nit, extra line
> 

Ack, will remove this. Thanks for pointing out.

> Also, if you passed a `struct page *` instead, then you could drop the
> bool param, ie. passing NULL for the page would disable PRR.  But I
> can go either way if others have a strong preference for phys_addr_t.
> 

Oh okay, this looks simple to reset the prr bit.
But since this page is allocated and is used inside gfx driver
before being utilized for prr bit operation, would it be safe for
drm/gfx driver to keep a reference to this page in smmu driver?

Since we only need the page address for configuring the
CFG_UADDR/CFG_LADDR registers so passed the phys_addr_t.

> Otherwise, lgtm
> 
> BR,
> -R
>

Thanks & regards,
Bibek

>> +}
>> +
>>   #define QCOM_ADRENO_SMMU_GPU_SID 0
>>
>>   static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
>> @@ -407,6 +429,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>          priv->get_fault_info = qcom_adreno_smmu_get_fault_info;
>>          priv->set_stall = qcom_adreno_smmu_set_stall;
>>          priv->resume_translation = qcom_adreno_smmu_resume_translation;
>> +       priv->set_prr = qcom_adreno_smmu_set_prr;
>>
>>          actlrvar = qsmmu->data->actlrvar;
>>          if (!actlrvar)
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> index d9c2ef8c1653..3076bef49e20 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> @@ -154,6 +154,8 @@ enum arm_smmu_cbar_type {
>>   #define ARM_SMMU_SCTLR_M               BIT(0)
>>
>>   #define ARM_SMMU_CB_ACTLR              0x4
>> +#define ARM_SMMU_GFX_PRR_CFG_LADDR     0x6008
>> +#define ARM_SMMU_GFX_PRR_CFG_UADDR     0x600C
>>
>>   #define ARM_SMMU_CB_RESUME             0x8
>>   #define ARM_SMMU_RESUME_TERMINATE      BIT(0)
>> diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
>> index c637e0997f6d..d6e2ca9f8d8c 100644
>> --- a/include/linux/adreno-smmu-priv.h
>> +++ b/include/linux/adreno-smmu-priv.h
>> @@ -49,7 +49,10 @@ struct adreno_smmu_fault_info {
>>    *                 before set_ttbr0_cfg().  If stalling on fault is enabled,
>>    *                 the GPU driver must call resume_translation()
>>    * @resume_translation: Resume translation after a fault
>> - *
>> + * @set_prr:      Extendible interface to be used by GPU to modify the
>> + *                 ACTLR register bits, currently used to configure
>> + *                 Partially-Resident-Region (PRR) feature's
>> + *                 setup and reset sequence as requested.
>>    *
>>    * The GPU driver (drm/msm) and adreno-smmu work together for controlling
>>    * the GPU's SMMU instance.  This is by necessity, as the GPU is directly
>> @@ -67,6 +70,7 @@ struct adreno_smmu_priv {
>>       void (*get_fault_info)(const void *cookie, struct adreno_smmu_fault_info *info);
>>       void (*set_stall)(const void *cookie, bool enabled);
>>       void (*resume_translation)(const void *cookie, bool terminate);
>> +    void (*set_prr)(const void *cookie, phys_addr_t page_addr, bool set);
>>   };
>>
>>   #endif /* __ADRENO_SMMU_PRIV_H */
>> --
>> 2.34.1
>>

