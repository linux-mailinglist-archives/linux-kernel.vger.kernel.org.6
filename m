Return-Path: <linux-kernel+bounces-353710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87098993172
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B601C23E61
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013621D90D3;
	Mon,  7 Oct 2024 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="URHBLrHc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5F1D86DC
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315457; cv=none; b=bP5bpubfjGPy12wMqvS7EYyUBOaGzUSu7FfKMBWf2g+FWECwb8sSB3sjrS6pU5Tw5FfdFV7EEcaorYa8gJNGJOfFPB86RzqcRtB7ZBtn5D8W87jjWIy79ADpaIU4zhUyUlQT5BdIPFjJZ7xXFKxSbqugrRSgO0EUqkPdUmJnQ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315457; c=relaxed/simple;
	bh=iLOc1Y9Pu7q+0z9wbNsHPsSVfAQRLsl0IA0CbzydHG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FUisZe07gY1mnO92xquLMaFxSDs412cRK8RQLAxIPGqDpyAi0hTgXoCtb1rn60DWb79BvlYLNx55I1OGyUVLSbFzmO1YGmdYhYsCz+bJTDooVLg4C5+L9eFiZNLjoNfEbjRfhit04qbfdeVQni5Tohf27m8+5Kncn6Wb6N/8xu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=URHBLrHc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4979NYQp006632;
	Mon, 7 Oct 2024 15:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CtcYNex15jOvgc7acCb9pU9YAaY9ZHPFUk8Vc00WlpQ=; b=URHBLrHcM5iy5PZn
	GElEMRSwwygt2Yef1YAEQORmus8xaSI+tb7e4An2Ixc0Clom2xvO0qiXQk1alzUe
	aTT2OIKZ2hOuxnnN4mtrOPZOhAtmlQw65YIf2OsX7szRrf20W+VbEHnWLZ5ghxi8
	yNxV/Izb8IoDGlCbUedyGRfB8gGHMwH3Z/bEuw5Tf5AWNrhsnqVSECV5p6n39qwM
	E4YkqbX3p+GHQmBm+/R3w4qiBDflS+ww1OHK8V3wH35U4JyFLdUqo2Ztna2GhRCs
	K9kTd3G38zcNkoHfNIycmFfLuVZd81aWmLbG2CF4wuwt1z8Kf9B/Nsy9zKiNhho7
	c6OoXQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424cy791kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 15:37:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 497FbRrq007569
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Oct 2024 15:37:27 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 7 Oct 2024
 08:37:27 -0700
Message-ID: <fa5290e6-ed5c-1dd4-4586-c48650fbb836@quicinc.com>
Date: Mon, 7 Oct 2024 09:37:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V3 05/11] accel/amdxdna: Add hardware context
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20240911180604.1834434-1-lizhi.hou@amd.com>
 <20240911180604.1834434-6-lizhi.hou@amd.com>
 <c1f92388-bd94-ebc2-dd59-0434a3fa63a6@quicinc.com>
 <8347abb4-7c9a-416c-4837-29e78fd715f0@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <8347abb4-7c9a-416c-4837-29e78fd715f0@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jvEWmtl-hSkKTmYcu2kqAbxBIMDCZvF0
X-Proofpoint-GUID: jvEWmtl-hSkKTmYcu2kqAbxBIMDCZvF0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070110

On 10/6/2024 11:02 PM, Lizhi Hou wrote:
> 
> On 10/4/24 10:50, Jeffrey Hugo wrote:
>> On 9/11/2024 12:05 PM, Lizhi Hou wrote:
>>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>>> b/drivers/accel/amdxdna/aie2_ctx.c
>>> new file mode 100644
>>> index 000000000000..52a71661f887
>>> --- /dev/null
>>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>>> @@ -0,0 +1,186 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>>> + */
>>> +
>>> +#include <drm/amdxdna_accel.h>
>>> +#include <drm/drm_device.h>
>>> +#include <drm/drm_print.h>
>>> +#include <linux/types.h>
>>> +
>>> +#include "amdxdna_ctx.h"
>>> +#include "amdxdna_mailbox.h"
>>> +#include "amdxdna_pci_drv.h"
>>> +#include "aie2_pci.h"
>>> +#include "aie2_solver.h"
>>
>> Alphabetical order?
>>
>> <snip>
>>> +/**
>>> + * struct amdxdna_drm_create_hwctx - Create hardware context.
>>> + * @ext: MBZ.
>>> + * @ext_flags: MBZ.
>>> + * @qos_p: Address of QoS info.
>>> + * @umq_bo: BO handle for user mode queue(UMQ).
>>> + * @log_buf_bo: BO handle for log buffer.
>>> + * @max_opc: Maximum operations per cycle.
>>> + * @num_tiles: Number of AIE tiles.
>>> + * @mem_size: Size of AIE tile memory.
>>> + * @umq_doorbell: Returned offset of doorbell associated with UMQ.
>>> + * @handle: Returned hardware context handle.
>>> + * @pad: MBZ.
>>
>> You specify must be zero, but I don't see that checked anywhere.
> 
> Ok. I did not see any driver checks structure pad. And pad should not be 
> used. I will remove MBZ for pad.

Be aware, if you don't check for 0, you can never reuse that portion of 
the structure for future use as there may be existing userspace that 
happens to be putting random garbage in that area at that future point.

-Jeff

