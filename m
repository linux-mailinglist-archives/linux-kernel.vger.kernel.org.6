Return-Path: <linux-kernel+bounces-314006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F4896AD98
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D541F2245C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C8753BE;
	Wed,  4 Sep 2024 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VNz3LRrQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764D173;
	Wed,  4 Sep 2024 01:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725411875; cv=none; b=AuYyqwUU29VEbYuc9Cmww5q648JiK0/TcCGPr63I5X/ubDRg2l8/7ul99hveXTV4k3O7wFB5FurMaIW0DUtts3Ez0kPrUbtfSYLuHwgOmlbsvbuO5szvS/zhLItZof1BngXqrjySSrlMWqH7Kxh886vzGJ6VCmdHeL2HP9AoT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725411875; c=relaxed/simple;
	bh=kCvnV+QM3OUe6za+pNAAuC5zXs+e0nHkOJGawuxwGvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m9LXocB/1jLZOcECPJOvosX0M5pX9MIA++Z2HZ5b/L3r31pWIhGp0QAylU5lXLkr0G40JaDrlkpxj+RDBPl1DADII9sr1Wfs8EVXjd4Pi69p6dCpMStY7mNuW8qBLhkdOyWnZBXJhNF36PxVG9yEvU1MvPZBEIPcap6tV921U3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VNz3LRrQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483NVBjh020611;
	Wed, 4 Sep 2024 01:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	alvapbi0VYChpzGs1c+SE4QBePrSOaMdAIuaPbtJG40=; b=VNz3LRrQSaJW7bgD
	NyGLCFWDn0PhTxQv77QDWfJmDPPJxJ0tcd1SndZIuqKWdhZ6GLP4To+MD2fs4EQ2
	Oda2oVqdurgJl5nLCkV65YjUz6t1XZCqSH2pbQsrwfSftNvMIfNHqandCOatR2RL
	3/rqy9XuqTWZYTfAExkZzzIXWe1JV3hitfzd+lC2cEoahq32Y/h0PuH0BZQ3ZmI5
	ecElLL4UeLowk6Wzvq+yCcPXUEgwGkTXAMo2dFtNTMvy4uBrZiTj1j7bfd3NA9NN
	hLvpPlHzYXhGIt0DeejGwXagzooV8fdNVH60l6j73lsyiRzV9yXwjPyqH03Twe0i
	8AjE0g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41btrxs4mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 01:04:15 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48414EK0019853
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 01:04:14 GMT
Received: from [10.134.70.212] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Sep 2024
 18:04:13 -0700
Message-ID: <0e5dc874-0b50-4a6b-ba98-83cb01f7cce6@quicinc.com>
Date: Tue, 3 Sep 2024 18:04:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] drm/msm/dpu: Add RM support for allocating CWB
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, <quic_abhinavk@quicinc.com>,
        Sean Paul
	<sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "David
 Airlie" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, <quic_ebharadw@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-11-502b16ae2ebb@quicinc.com>
 <pf6xgu7yjanzjigfpupons4ud6jbcmbr5icnd7yur6qhh3n5sf@plj4bi3beguw>
 <665da6e9-d9f3-4a28-a53b-0f467967fc78@quicinc.com>
 <CAA8EJpo0X7yRaqYV-tTco9+9WyexiPN_ey8hKivFrE3jTojUpg@mail.gmail.com>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <CAA8EJpo0X7yRaqYV-tTco9+9WyexiPN_ey8hKivFrE3jTojUpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WWU7yhrmGWheViu9JuNeh47IoUUVEu9n
X-Proofpoint-ORIG-GUID: WWU7yhrmGWheViu9JuNeh47IoUUVEu9n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_12,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409040006



On 8/30/2024 3:16 PM, Dmitry Baryshkov wrote:
> On Fri, 30 Aug 2024 at 22:28, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>>
>>
>>
>> On 8/30/2024 10:18 AM, Dmitry Baryshkov wrote:
>>> On Thu, Aug 29, 2024 at 01:48:32PM GMT, Jessica Zhang wrote:
>>>> Add support for allocating the concurrent writeback mux as part of the
>>>> WB allocation
>>>>
>>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  5 ++++-
>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 30 +++++++++++++++++++++++++++--
>>>>    2 files changed, 32 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
>>>> index c17d2d356f7a..c43cb55fe1d2 100644
>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
>>>> @@ -1,5 +1,7 @@
>>>>    /* SPDX-License-Identifier: GPL-2.0-only */
>>>> -/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
>>>> +/*
>>>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + * Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
>>>>     */
>>>>
>>>>    #ifndef _DPU_HW_MDSS_H
>>>> @@ -352,6 +354,7 @@ struct dpu_mdss_color {
>>>>    #define DPU_DBG_MASK_DSPP     (1 << 10)
>>>>    #define DPU_DBG_MASK_DSC      (1 << 11)
>>>>    #define DPU_DBG_MASK_CDM      (1 << 12)
>>>> +#define DPU_DBG_MASK_CWB      (1 << 13)
>>>>
>>>>    /**
>>>>     * struct dpu_hw_tear_check - Struct contains parameters to configure
>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
>>>> index bc99b04eae3a..738e9a081b10 100644
>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
>>>> @@ -1,9 +1,10 @@
>>>>    // SPDX-License-Identifier: GPL-2.0-only
>>>>    /*
>>>>     * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
>>>> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>>>     */
>>>>
>>>> +#include <drm/drm_managed.h>
>>>>    #include "msm_drv.h"
>>>>    #define pr_fmt(fmt)        "[drm:%s] " fmt, __func__
>>>>    #include "dpu_kms.h"
>>>> @@ -34,6 +35,7 @@ int dpu_rm_init(struct drm_device *dev,
>>>>               void __iomem *mmio)
>>>>    {
>>>>       int rc, i;
>>>> +    struct dpu_hw_blk_reg_map *cwb_reg_map;
>>>>
>>>>       if (!rm || !cat || !mmio) {
>>>>               DPU_ERROR("invalid kms\n");
>>>> @@ -100,11 +102,35 @@ int dpu_rm_init(struct drm_device *dev,
>>>>               rm->hw_intf[intf->id - INTF_0] = hw;
>>>>       }
>>>>
>>>> +    if (cat->cwb_count > 0) {
>>>> +            cwb_reg_map = drmm_kzalloc(dev,
>>>> +                            sizeof(*cwb_reg_map) * cat->cwb_count,
>>>> +                            GFP_KERNEL);
>>>
>>> Please move CWB block pointers to dpu_rm. There is no need to allocate a
>>> separate array.
>>
>> Hi Dmitry,
>>
>> Sorry, I'm not sure what you mean here. Can you clarify your comment?
>>
>> This is just allocating an array of the CWB register addresses so that
>> the hw_wb block can use it to configure the CWB mux registers.
> 
> Excuse me. I asked to make the cwb_reg_map array a part of the
> existing dpu_rm structure. This way other subblocks can access it
> through dpu_rm API.

Got it, thanks for the clarification. Just wondering, is the intent here 
to add CWB to rm's get_assigned_resourced?

The CWB registers will be handled by hw_wb and isn't referenced anywhere 
outside of hw_wb (aside from when it's being allocated and passed into 
hw_wb_init) so I'm not sure what's the benefit of adding it to the 
dpu_rm struct.

> 
>>
>> Thanks,
>>
>> Jessica Zhang
>>
>>>
>>>> +
>>>> +            if (!cwb_reg_map) {
>>>> +                    DPU_ERROR("failed cwb object creation\n");
>>>> +                    return -ENOMEM;
>>>> +            }
>>>> +    }
>>>> +
>>>> +
>>>> +    for (i = 0; i < cat->cwb_count; i++) {
>>>> +            struct dpu_hw_blk_reg_map *cwb = &cwb_reg_map[i];
>>>> +
>>>> +            cwb->blk_addr = mmio + cat->cwb[i].base;
>>>> +            cwb->log_mask = DPU_DBG_MASK_CWB;
>>>> +    }
>>>> +
>>>>       for (i = 0; i < cat->wb_count; i++) {
>>>>               struct dpu_hw_wb *hw;
>>>>               const struct dpu_wb_cfg *wb = &cat->wb[i];
>>>>
>>>> -            hw = dpu_hw_wb_init(dev, wb, mmio, cat->mdss_ver);
>>>> +            if (cat->cwb)
>>>> +                    hw = dpu_hw_wb_init_with_cwb(dev, wb, mmio,
>>>> +                                    cat->mdss_ver, cwb_reg_map);
>>>> +            else
>>>> +                    hw = dpu_hw_wb_init(dev, wb, mmio, cat->mdss_ver);
>>>> +
>>>>               if (IS_ERR(hw)) {
>>>>                       rc = PTR_ERR(hw);
>>>>                       DPU_ERROR("failed wb object creation: err %d\n", rc);
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>>
>>> --
>>> With best wishes
>>> Dmitry
> 
> 
> 
> -- 
> With best wishes
> Dmitry

