Return-Path: <linux-kernel+bounces-353703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2362C99315B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992C31F23A8B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C5B1D79B3;
	Mon,  7 Oct 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pvDYrBch"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455201D7E58
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315314; cv=none; b=tgYGGWghZJ38wlYPQvqYcNB4CUqgXwu8r5FoSqnsmGBku9lzDv1/sdKCQfNnL9B0gOIbqesp8JgOzVBw1W7lOziya/CV6d4KJ+XZ5RbDEUbWxOmzOIaNkM/IoqtRJCauWck51Yuku39EgNyPmP4ZnDgwBdDm2KO1OOw0sioR1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315314; c=relaxed/simple;
	bh=0orHk1J0R/893lbdKF5Cu4u55khz1hz6KOdXnnDA4qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=isimZxPlwc71MjX5sVUXgnYhGuFG9lHuFizREO8SlvwepDv1xv8AWxP5KvK4xyCOrneLmtkEkiUGGaYhaCkd8RDcxdpMtJKSN1T/HYBcH3vu64kTz7zvzY/IvwvyV5PNLaFuWvMyXdL9VF0IwqvtCQRkTb7CT62zI37kgJrMREU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pvDYrBch; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497EXn3Z017629;
	Mon, 7 Oct 2024 15:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UkEEq4gcaGzW0fOXtqZ8kKALhByPUK1hGvOz1KIx114=; b=pvDYrBchLXPjSHPY
	1968jDIItAzVsDVedX8v69qyKsgSqS/GutyHoOiGr3ZiwROfp+jE0lugWbAFP4MJ
	rcjJdIpol1imMHUe24VAiujmz99NaXLZDSCCBnc1lP/4sCZK/EqJVHwhSnk3J1PK
	GbnQPuMfVuPuJAeRm1vEmE57oKngrzuAoFFJAKc2M8CcLgYqg7ApkW7493wHVAkL
	UpAuS2F7FlRZIGdJ3YSdGUWDlJYYWnS7GpF0OMzLjxZ0zh/m3V40d09zIhMbNRfH
	7tdIcbku2EkuWbmGCLY90An97AFCThOU9DB3GKAu00J1TZjnGB6XDmrPVpcXnFBX
	calXFQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xs4cmh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 15:35:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 497FZ4T1003210
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Oct 2024 15:35:04 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 7 Oct 2024
 08:35:04 -0700
Message-ID: <38be2c5c-8543-968b-e91e-a7f485909171@quicinc.com>
Date: Mon, 7 Oct 2024 09:34:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V3 03/11] accel/amdxdna: Support hardware mailbox
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        George Yang <George.Yang@amd.com>
References: <20240911180604.1834434-1-lizhi.hou@amd.com>
 <20240911180604.1834434-4-lizhi.hou@amd.com>
 <86c8f688-eea3-ff95-5ae5-2e4da32b7edb@quicinc.com>
 <7e337655-a0ff-0c9f-f074-35ca61b0d934@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <7e337655-a0ff-0c9f-f074-35ca61b0d934@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nn3yxfXteA1koF7-i05XMElNuv_JGJQM
X-Proofpoint-GUID: nn3yxfXteA1koF7-i05XMElNuv_JGJQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410070110

On 10/6/2024 10:15 PM, Lizhi Hou wrote:
> 
> On 10/4/24 10:34, Jeffrey Hugo wrote:
>> On 9/11/2024 12:05 PM, Lizhi Hou wrote:
>>> +struct create_ctx_req {
>>> +    __u32    aie_type;
>>> +    __u8    start_col;
>>> +    __u8    num_col;
>>> +    __u16    reserved;
>>> +    __u8    num_cq_pairs_requested;
>>> +    __u8    reserved1;
>>> +    __u16    pasid;
>>> +    __u32    pad[2];
>>> +    __u32    sec_comm_target_type;
>>> +    __u32     context_priority;
>>
>> Alignment
> Will fix it.
>>
>>> +} __packed;
>>> +
>>> +struct create_ctx_resp {
>>> +    enum aie2_msg_status    status;
>>> +    __u32            context_id;
>>> +    __u16            msix_id;
>>> +    __u8            num_cq_pairs_allocated;
>>> +    __u8            reserved;
>>> +    struct cq_pair        cq_pair[MAX_CQ_PAIRS];
>>> +} __packed;
>>> +
>>> +struct destroy_ctx_req {
>>> +    __u32    context_id;
>>> +} __packed;
>>> +
>>> +struct destroy_ctx_resp {
>>> +    enum aie2_msg_status    status;
>>> +} __packed;
>>> +
>>> +struct execute_buffer_req {
>>> +    __u32    cu_idx;
>>> +    __u32    payload[19];
>>> +} __packed;
>>> +
>>> +struct exec_dpu_req {
>>> +    __u64    inst_buf_addr;
>>> +    __u32     inst_size;
>>> +    __u32     inst_prop_cnt;
>>> +    __u32     cu_idx;
>>
>> Alignment
> will fix it.
>>
>>> +    __u32    payload[35];
>>> +} __packed;
>>> +
>>> diff --git a/drivers/accel/amdxdna/aie2_psp.c 
>>> b/drivers/accel/amdxdna/aie2_psp.c
>>> index c87ca322e206..ac5296f4f2ae 100644
>>> --- a/drivers/accel/amdxdna/aie2_psp.c
>>> +++ b/drivers/accel/amdxdna/aie2_psp.c
>>> @@ -8,6 +8,8 @@
>>>   #include <drm/drm_print.h>
>>>   #include <linux/iopoll.h>
>>>   +#include "amdxdna_mailbox.h"
>>> +#include "amdxdna_pci_drv.h"
>>>   #include "aie2_pci.h"
>>
>> Doesn't look like alphabetical order to me.  Also similar instances in 
>> the *_regs.c files below
> 
> aie2 is one type of amdxdna hw platform. I would put amdxdna_*.h ahead 
> of aie_*.h. Otherwise I probably need to add include in aie2_*.h.  Is it 
> acceptable reason? Or I must use alphabetical for #include?

Sorting the includes is part of the Linux coding style, and the current 
style document mentions using clang-format for ordering them (in 
alphabetical order).  Requesting ordered includes is common feedback per 
Lore.

Relying on include ordering seems very fragile.

-Jeff

