Return-Path: <linux-kernel+bounces-372449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DBF9A48AB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C491F25AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FA818DF73;
	Fri, 18 Oct 2024 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UNVT3fJd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C450A13541B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729285313; cv=none; b=tMqLF3zfK+8t7GSevxcGLkatugFExbv3mYhIRcRmHFXsU1J6yMo3iOvacbgeBLrnXgdaNHOQYVvWVVNMlpLRArI+gzw3jEN4A49pXzTr/DUs18/UDRNHbopBy6NKY7gQw/SqqsmvWGYH1Wxhgxs0UvweT24TvTfWCMqUmiZleAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729285313; c=relaxed/simple;
	bh=ixH/ghtHgcJy0Lmj13nWNNLNotx8rlF13wh8Dq9sPZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M9uCvl5SAVMOjR3HdUs3z30BzmuSr1hDGOiq9/7jngWRJcxl+lOKUwM/TlMYna76AUvy4e3qsbKXuEx3xOY7SPY5+ZF5saVR9mCeSQKz1/ep8i+4e0xDuiRWHPdceTPfhqAjX9MDXMRLx7KW2EtWWU0cbsKjirb7LiTrU22iFpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UNVT3fJd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ICGTe5020850;
	Fri, 18 Oct 2024 21:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pDHC/e17+8DUmuZglJqWLj+6wKJ0YGpCOEYVA4nBZ+Q=; b=UNVT3fJd+z+Y0UXX
	fCVjVaOXT6FMsit1CKxgO1hpAC13008BfYBGZhqLGyMiUI4czKk2Gz52qkb/PzEm
	9Gmt5Kn/m4CmM8fUcxtgslpLR7FcoztFDPY/2v+gu4vmWq8da+McUXfB69kxLFU2
	F9VAG+goaHZmyOgqM1eDKLwjnTi6QHmX3S933SbxTHFFLPzDExkU7Gdq8aFx78fR
	Mp0QI81+NW1FgKLyeAkZwANk1lZZIjdc47V7l873xtp+rwm/7iSzVds0wcU1vPqr
	wFzh0LaRNfNVJd5FpnjSAiRsA+2Ysi3CxHnMLIY9KnT4e9vEBzYNd68l89IG8BsD
	ayJ2iA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42bexpawq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 21:01:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49IL1kLC010399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 21:01:46 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 18 Oct
 2024 14:01:45 -0700
Message-ID: <1c16640f-0bc3-2692-910f-09ea5869a5b6@quicinc.com>
Date: Fri, 18 Oct 2024 15:01:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V4 09/10] accel/amdxdna: Add error handling
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20241011231244.3182625-1-lizhi.hou@amd.com>
 <20241011231244.3182625-10-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241011231244.3182625-10-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3d8QqqbVV7ximTssG3lBjpEsrs6mGESp
X-Proofpoint-ORIG-GUID: 3d8QqqbVV7ximTssG3lBjpEsrs6mGESp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180134

On 10/11/2024 5:12 PM, Lizhi Hou wrote:
> When there is a hardware error, the NPU firmware notifies the host through
> a mailbox message. The message includes details of the error, such as the
> tile and column indexes where the error occurred.
> 
> The driver starts a thread to handle the NPU error message. The thread
> stops the clients which are using the column where error occurred. Then
> the driver resets that column.
> 
> Co-developed-by: Min Ma<min.ma@amd.com>
> Signed-off-by: Min Ma<min.ma@amd.com>
> Signed-off-by: Lizhi Hou<lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/Makefile       |   1 +
>   drivers/accel/amdxdna/aie2_error.c   | 356 +++++++++++++++++++++++++++
>   drivers/accel/amdxdna/aie2_message.c |  19 ++
>   drivers/accel/amdxdna/aie2_pci.c     |  32 +++
>   drivers/accel/amdxdna/aie2_pci.h     |   9 +
>   5 files changed, 417 insertions(+)
>   create mode 100644 drivers/accel/amdxdna/aie2_error.c
> 
> diff --git a/drivers/accel/amdxdna/Makefile b/drivers/accel/amdxdna/Makefile
> index a688c378761f..ed6f87910880 100644
> --- a/drivers/accel/amdxdna/Makefile
> +++ b/drivers/accel/amdxdna/Makefile
> @@ -2,6 +2,7 @@
>   
>   amdxdna-y := \
>   	aie2_ctx.o \
> +	aie2_error.o \
>   	aie2_message.o \
>   	aie2_pci.o \
>   	aie2_psp.o \
> diff --git a/drivers/accel/amdxdna/aie2_error.c b/drivers/accel/amdxdna/aie2_error.c
> new file mode 100644
> index 000000000000..d2787549f3b7
> --- /dev/null
> +++ b/drivers/accel/amdxdna/aie2_error.c
> @@ -0,0 +1,356 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023-2024, Advanced Micro Devices, Inc.
> + */
> +
> +#include <drm/drm_cache.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_print.h>
> +#include <drm/gpu_scheduler.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/kthread.h>
> +#include <linux/kernel.h>
> +
> +#include "aie2_msg_priv.h"
> +#include "aie2_pci.h"
> +#include "amdxdna_mailbox.h"
> +#include "amdxdna_pci_drv.h"
> +
> +struct async_event {
> +	struct amdxdna_dev_hdl		*ndev;
> +	struct async_event_msg_resp	resp;
> +	struct workqueue_struct		*wq;
> +	struct work_struct		work;
> +	u8				*buf;
> +	dma_addr_t			addr;
> +	u32				size;
> +};
> +
> +struct async_events {
> +	struct workqueue_struct		*wq;
> +	u8				*buf;
> +	dma_addr_t			addr;
> +	u32				size;
> +	u32				event_cnt;
> +	struct async_event		event[] __counted_by(event_cnt);
> +};
> +
> +/*
> + * Below enum, struct and lookup tables are porting from XAIE util header file.
> + *
> + * Below data is defined by AIE device and it is used for decode error message
> + * from the device.
> + */
> +
> +enum aie_module_type {
> +	AIE_MEM_MOD = 0,
> +	AIE_CORE_MOD,
> +	AIE_PL_MOD,
> +};
> +
> +enum aie_error_category {
> +	AIE_ERROR_SATURATION = 0,
> +	AIE_ERROR_FP,
> +	AIE_ERROR_STREAM,
> +	AIE_ERROR_ACCESS,
> +	AIE_ERROR_BUS,
> +	AIE_ERROR_INSTRUCTION,
> +	AIE_ERROR_ECC,
> +	AIE_ERROR_LOCK,
> +	AIE_ERROR_DMA,
> +	AIE_ERROR_MEM_PARITY,
> +	/* Unknown is not from XAIE, added for better category */
> +	AIE_ERROR_UNKNOWN,
> +};
> +
> +/* Don't pack, unless XAIE side changed */
> +struct aie_error {
> +	u8			row;
> +	u8			col;
> +	u32			mod_type;
> +	u8			event_id;
> +};

This looks like it is a structure to decode data from an external 
device.  Assuming that is so, the wrong types are used here.  Should be 
the "__" types like "__u8", no?  Normal u8, etc are kernel internal only 
types.

> +
> +struct aie_err_info {
> +	u32			err_cnt;
> +	u32			ret_code;
> +	u32			rsvd;
> +	struct aie_error	payload[] __counted_by(err_cnt);
> +};
> +
> +struct aie_event_category {
> +	u8			event_id;
> +	enum aie_error_category category;
> +};


