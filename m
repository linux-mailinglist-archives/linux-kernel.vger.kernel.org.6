Return-Path: <linux-kernel+bounces-350844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E0990A68
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7C61F2190B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8DC1DACAC;
	Fri,  4 Oct 2024 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SxH5/v3z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117A082D94
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064239; cv=none; b=i7nyenitIbzn4ZxXLmfxRK+zfv4SBJIu+MjQss4ld83KxYc0/aBmPE3D0/5LcvZjmqHe/L3OJi+VorXxwwNvLDVNjkz9jyuVaEtCgCoOtoNMCxc2EIiuuDnMCOnIOx0SPTZzGds2P9xE3k8ol1qDbrNeapIWWuCc/HWU7KCmhNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064239; c=relaxed/simple;
	bh=btFTC6DDlHlbTcdsMdcSfYq2W0MoLCUVGkjtIUrAlrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i607JCICnJC/kZfFSlQHUKKHEbQCb4rlrxSEdBjQb/deFOsFEnMTPHCwEF9KNYmXf+rcklYXkTJzIDYz3jDiV4Nhb47+rSGBl0VbJTuGl/hpG3/cPcCdfuf0t2n4wNbY8M9R+NE4Oxsr7KxSvGfXDqbee+8E5J8KuETbCmR/etQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SxH5/v3z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494AXd14012742;
	Fri, 4 Oct 2024 17:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kYC3/otrx6wZfYYsfKEqO9HhEkosQLQun98tsAVzUl4=; b=SxH5/v3zv+2XluhK
	5eJtQUIWGQhe6v+gjEPV3ewa5Pztj7I80Hd86k6OHFIrly3LDlboPVsBp4Hv4e8p
	clKH2iWayqjA9ggbgxFq/pdpfIN0YA3t7LuJ6MS1RB9xQZsZGu6OKPrIFJFWXLYZ
	RB//BlxkdTBBFGoU8ODOgrTM3WIkqSfPPhodZny87ayWHiKeBSFXOd3N6O5Hnfow
	0XtBf6jycaWnd5KUxTqztcV/4s5xsW4ZyX+qMr2aepC/sxyooM18CHdoK1cWnSs7
	yZ6zCDCWyO4fqkDxIWGfprBbRhMt8AmFy935MJk9wL505VgDE1HJAcJTcOEy0vlF
	QS9wFQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42205kauff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 17:50:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 494HoW2Y019311
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 17:50:32 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 4 Oct 2024
 10:50:31 -0700
Message-ID: <c1f92388-bd94-ebc2-dd59-0434a3fa63a6@quicinc.com>
Date: Fri, 4 Oct 2024 11:50:30 -0600
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
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240911180604.1834434-6-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: X-JDjG1V8kxyHiMPqmbi2sb6y3IiSBTn
X-Proofpoint-ORIG-GUID: X-JDjG1V8kxyHiMPqmbi2sb6y3IiSBTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040123

On 9/11/2024 12:05 PM, Lizhi Hou wrote:
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> new file mode 100644
> index 000000000000..52a71661f887
> --- /dev/null
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + */
> +
> +#include <drm/amdxdna_accel.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_print.h>
> +#include <linux/types.h>
> +
> +#include "amdxdna_ctx.h"
> +#include "amdxdna_mailbox.h"
> +#include "amdxdna_pci_drv.h"
> +#include "aie2_pci.h"
> +#include "aie2_solver.h"

Alphabetical order?

<snip>
> +/**
> + * struct amdxdna_drm_create_hwctx - Create hardware context.
> + * @ext: MBZ.
> + * @ext_flags: MBZ.
> + * @qos_p: Address of QoS info.
> + * @umq_bo: BO handle for user mode queue(UMQ).
> + * @log_buf_bo: BO handle for log buffer.
> + * @max_opc: Maximum operations per cycle.
> + * @num_tiles: Number of AIE tiles.
> + * @mem_size: Size of AIE tile memory.
> + * @umq_doorbell: Returned offset of doorbell associated with UMQ.
> + * @handle: Returned hardware context handle.
> + * @pad: MBZ.

You specify must be zero, but I don't see that checked anywhere.

> + */
> +struct amdxdna_drm_create_hwctx {
> +	__u64 ext;
> +	__u64 ext_flags;
> +	__u64 qos_p;
> +	__u32 umq_bo;
> +	__u32 log_buf_bo;
> +	__u32 max_opc;
> +	__u32 num_tiles;
> +	__u32 mem_size;
> +	__u32 umq_doorbell;
> +	__u32 handle;
> +	__u32 pad;
> +};

