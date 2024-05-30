Return-Path: <linux-kernel+bounces-195163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06278D4866
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0345B1F24123
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0627E17C7A3;
	Thu, 30 May 2024 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FWh1zwAc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E917C7BB;
	Thu, 30 May 2024 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060941; cv=none; b=Z1zTjDeu3SQ9ZXjA2MmukQW3FQGRbxZjc2lgEV0TBlhBgDAEAX2Ism5LV3UHjCZPrGdqPpISeA+g3dtWaXTm7JzRm6UdMGGoRQqO0a5zqwL2iWJ40kH7g8OjrQlfdaZRvjBBus9Dhq/k3ciMpuNhEJ/rAXudUSByMXz6l1fzT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060941; c=relaxed/simple;
	bh=BjRTz9TchtzrBVg/HEcF4tA52CP3B5H6c4c82WYsrR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JKqtukyddwI+TKOqYId0mXSd58QgQ3NCJR3TU9wAg7OKsASK+8z/YAQSCzuCJ6ZjenQJ6rx0xiy85ci8RjLXUIqa058sbHJdiPvFD4jiVgumoacUavdyCRGM8AoxHud23P9gIi0gzoeEAPyGeYFjjfRnWaThz9ext7NMutL5Qlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FWh1zwAc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44U7H1vC011441;
	Thu, 30 May 2024 09:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tYo6XGg1O8v9DJsWPcuugjUn+k1HSgSEboCMqRsTWNs=; b=FWh1zwAc+K8DntOO
	ZNsV+6gvz0GSHx60H2XfTHAv9Ewi9DlEnmFX/hwApSVjt95UPTf2l0oN8MrTYGtN
	x4/9tj3aJ/6sLce92G00D0bshDgRXXHpP0E8d+Buim6Omv+2mCFfyeeONfGwBLC/
	PNFGe+7aUTY4UqJwfI33fFhCE9eHsGgx4zMCSO2cIvBiQgEOtZeTNkjs5MynT9GI
	btGb395a7Brpe5n5VKoFYy38jj070wYIiTJQRZalY/AUSgQKHbI7XIGe75X//mJC
	Yj5BbCpM8rKtFHMnPqf/TO/4GYWW77NHaxGFX+ghwB39zNdlWkNDBj5YDy+/ES+n
	wGOYjw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0qkj7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 09:21:49 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44U9Llqb013414
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 09:21:47 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 02:21:38 -0700
Message-ID: <f5779af2-d690-45da-b223-352f2cc91b8a@quicinc.com>
Date: Thu, 30 May 2024 14:51:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark <robdclark@gmail.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <jsnitsel@redhat.com>,
        <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
 <20240123144543.9405-4-quic_bibekkum@quicinc.com>
 <CAF6AEGs3_wBNo58EbGicFoQuq8--fDohTGv1JSFgoViygLS5Lg@mail.gmail.com>
 <f2222714-1e00-424e-946d-c314d55541b8@quicinc.com>
 <51b2bd40-888d-4ee4-956f-c5239c5be9e9@linaro.org>
 <0a867cd1-8d99-495e-ae7e-a097fc9c00e9@quicinc.com>
 <7140cdb8-eda4-4dcd-b5e3-c4acdd01befb@linaro.org>
Content-Language: en-US
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <7140cdb8-eda4-4dcd-b5e3-c4acdd01befb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -ZXQb_nHr_WoIoA47StNbEokdeQYln6X
X-Proofpoint-ORIG-GUID: -ZXQb_nHr_WoIoA47StNbEokdeQYln6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_06,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300070



On 5/28/2024 6:29 PM, Konrad Dybcio wrote:
> 
> 
> On 5/15/24 15:59, Bibek Kumar Patro wrote:
>>
>>
>> On 5/10/2024 6:32 PM, Konrad Dybcio wrote:
>>> On 10.05.2024 2:52 PM, Bibek Kumar Patro wrote:
>>>>
>>>>
>>>> On 5/1/2024 12:30 AM, Rob Clark wrote:
>>>>> On Tue, Jan 23, 2024 at 7:00 AM Bibek Kumar Patro
>>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>>
>>>>>> Currently in Qualcomm  SoCs the default prefetch is set to 1 which 
>>>>>> allows
>>>>>> the TLB to fetch just the next page table. MMU-500 features ACTLR
>>>>>> register which is implementation defined and is used for Qualcomm 
>>>>>> SoCs
>>>>>> to have a custom prefetch setting enabling TLB to prefetch the 
>>>>>> next set
>>>>>> of page tables accordingly allowing for faster translations.
>>>>>>
>>>>>> ACTLR value is unique for each SMR (Stream matching register) and 
>>>>>> stored
>>>>>> in a pre-populated table. This value is set to the register during
>>>>>> context bank initialisation.
>>>>>>
>>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>>>> ---
>>>
>>> [...]
>>>
>>>>>> +
>>>>>> +               for_each_cfg_sme(cfg, fwspec, j, idx) {
>>>>>> +                       smr = &smmu->smrs[idx];
>>>>>> +                       if (smr_is_subset(smr, id, mask)) {
>>>>>> +                               arm_smmu_cb_write(smmu, cbndx, 
>>>>>> ARM_SMMU_CB_ACTLR,
>>>>>> +                                               actlrcfg[i].actlr);
>>>>>
>>>>> So, this makes ACTLR look like kind of a FIFO.  But I'm looking at
>>>>> downstream kgsl's PRR thing (which we'll need to implement vulkan
>>>>> sparse residency), and it appears to be wanting to set BIT(5) in ACTLR
>>>>> to enable PRR.
>>>>>
>>>>>           val = KGSL_IOMMU_GET_CTX_REG(ctx, KGSL_IOMMU_CTX_ACTLR);
>>>>>           val |= FIELD_PREP(KGSL_IOMMU_ACTLR_PRR_ENABLE, 1);
>>>>>           KGSL_IOMMU_SET_CTX_REG(ctx, KGSL_IOMMU_CTX_ACTLR, val);
>>>>>
>>>>> Any idea how this works?  And does it need to be done before or after
>>>>> the ACTLR programming done in this patch?
>>>>>
>>>>> BR,
>>>>> -R
>>>>>
>>>>
>>>> Hi Rob,
>>>>
>>>> Can you please help provide some more clarification on the FIFO 
>>>> part? By FIFO are you referring to the storing of ACTLR data in the 
>>>> table?
>>>>
>>>> Thanks for pointing to the downstream implementation of kgsl driver for
>>>> the PRR bit. Since kgsl driver is already handling this PRR bit's
>>>> setting, this makes setting the PRR BIT(5) by SMMU driver redundant.
>>>
>>> The kgsl driver is not present upstream.
>>>
>>
>> Right kgsl is not present upstream, it would be better to avoid 
>> configuring the PRR bit and can be handled by kgsl directly in 
>> downstream.
> 
> No! Upstream is not a dumping ground to reduce your technical debt.
> 
> There is no kgsl driver upstream, so this ought to be handled here, in
> the iommu driver (as poking at hardware A from driver B is usually not good
> practice).
> 

Okay, so I see this point now. Driver B need to use hardware A's driver
exposed interface only to interact with the hardware functionality
instead of directly poking it. Agree on this, it looks to be an
appropriate approach.

>>
>>>> Thanks for bringing up this point.
>>>> I will send v10 patch series removing this BIT(5) setting from the 
>>>> ACTLR
>>>> table.
>>>
>>> I think it's generally saner to configure the SMMU from the SMMU 
>>> driver..
>>
>> Yes, agree on this. But since PRR bit is not directly related to SMMU
>> configuration so I think it would be better to remove this PRR bit
>> setting from SMMU driver based on my understanding.
> 
> Why is it not related? We still don't know what it does.
> 

By not related, I meant to say this bit is used for GFX implementation 
instead of direct SMMU related configuration.

Thanks & regards,
Bibek

> Konrad

