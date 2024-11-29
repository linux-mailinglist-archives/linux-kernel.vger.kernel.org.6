Return-Path: <linux-kernel+bounces-420388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFC29D79D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 02:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934E41636CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 01:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CACDEAC7;
	Mon, 25 Nov 2024 01:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mir+povm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FA810F9;
	Mon, 25 Nov 2024 01:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732499086; cv=none; b=LFYix3JRbHzyhGJ4oY1dBpD9yjWkMwO63sIjmQBmWn//g9V2O40EIgY0gReyRAPqQUyoKa8F+QdAYdhMQfUSsAjaV8vXbGDwebdCb5pz9GcMna7N08KIYJQfNvYjw79iJiMQt6mmx2GmRVsR4l551fHWjS7Uk67gC/mHDUYYI4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732499086; c=relaxed/simple;
	bh=wTMdRmUB6ZsWBhv8uPeSdAAH33/P1tWe4+yZBvYk+hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tFjqMTS3/BPKGziEiOpCIXSQUgQ/cK+ZBo+/3wGrvoKTgIjSypfz5jaEzex1t4qoj/KeDgMbPDXr3jz4+XXLl+tTB6rlAf1r2teEukcrrtcNwasi4Fi8fFr/MV+lnzFnx8zdq/qaLyoCTJhKw6aiEDet4SypfJMM97zFfOOMhFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mir+povm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP0L7tV006014;
	Mon, 25 Nov 2024 01:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iGaYT6nZ/4PiLaqqfZNnRdCsS1EzHLa59yqMFNnJ2X0=; b=mir+povmuBtEd5+T
	2oYJoTZ6tUh3oQjLy+JCRBFablP+gvIZ3jv/kQhennjTmAnUonm+Z0NG9zUsr1e+
	NxpvPmv0YsWHalX7TGuPuelOe9lLnAgdHdI7iNOvAfp5Nx8OGuAkLXFODcDxh/sU
	kA2jFyZ/KcTbtgbfUaLjmSifdhXG1/nfDRQdirRZR17GppZyTeEfbz5w1z8jexQ/
	HeGjUl7ZJJBOQu+unX7CK/WjMrVTTsO6xSN+2I+C84gr5I1izKxijDvaz9wOs3A7
	uMRGBUtWD0+PvS6qpstLBjqva72EYLn53DRI00HQ05TDE7NqCQcDqxGvFMYaWU9h
	+Up4rw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4336cfk4gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 01:44:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AP1iMhU025369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 01:44:22 GMT
Received: from [10.64.16.151] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 24 Nov
 2024 17:44:15 -0800
Message-ID: <10413094-500f-4044-b4e3-8ce83fee3dbd@quicinc.com>
Date: Mon, 25 Nov 2024 09:44:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] drm/msm/dpu: Add SM6150 support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Krishna
 Manikandan" <quic_mkrishn@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Liu
	<quic_lliu6@quicinc.com>,
        Xiangxu Yin <quic_xiangxuy@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20241122-add-display-support-for-qcs615-platform-v3-0-35252e3a51fe@quicinc.com>
 <20241122-add-display-support-for-qcs615-platform-v3-5-35252e3a51fe@quicinc.com>
 <bhylewwvztm7gsmkjwo6asceuph2jlqgvy2lhocdvg6r7y4i6w@duvbnsko3xg2>
Content-Language: en-US
From: fange zhang <quic_fangez@quicinc.com>
In-Reply-To: <bhylewwvztm7gsmkjwo6asceuph2jlqgvy2lhocdvg6r7y4i6w@duvbnsko3xg2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ALnY4WQC7U_GidKZVMBIyRRX_D5Sz7vY
X-Proofpoint-ORIG-GUID: ALnY4WQC7U_GidKZVMBIyRRX_D5Sz7vY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250013



On 2024/11/22 18:07, Dmitry Baryshkov wrote:
> On Fri, Nov 22, 2024 at 05:56:48PM +0800, Fange Zhang wrote:
>> From: Li Liu <quic_lliu6@quicinc.com>
>>
>> Add definitions for the display hardware used on the Qualcomm SM6150
>> platform.
>>
>> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
>> Signed-off-by: Fange Zhang <quic_fangez@quicinc.com>
>> ---
>>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h | 263 +++++++++++++++++++++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>>   4 files changed, 266 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..e8b7f694b885d69a9bbfaa85b0faf0c7af677a75
>> --- /dev/null
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h
>> @@ -0,0 +1,263 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef _DPU_5_3_SM6150_H
>> +#define _DPU_5_3_SM6150_H
>> +
>> +	}, {
>> +		.name = "intf_2", .id = INTF_2,
>> +		.base = 0x6b000, .len = 0x2c0,
>> +		.features = INTF_SC7180_MASK,
>> +		.type = INTF_NONE,
>> +		.controller_id = 0,
>> +		.prog_fetch_lines_worst_case = 24,
>> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 28),
>> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 29),
> 
> Please drop. No need to declare missing blocks.
got it, will remove this block in the next patch
> 
> Other than that:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> 
>> +	}, {
>> +		.name = "intf_3", .id = INTF_3,
>> +		.base = 0x6b800, .len = 0x280,
>> +		.features = INTF_SC7180_MASK,
>> +		.type = INTF_DP,
>> +		.controller_id = MSM_DP_CONTROLLER_1,
>> +		.prog_fetch_lines_worst_case = 24,
>> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
>> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 31),
>> +	},
>> +};
>> +
> 


