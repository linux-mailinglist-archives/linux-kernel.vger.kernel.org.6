Return-Path: <linux-kernel+bounces-316780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EB896D4BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC1D2817D5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F35194ACD;
	Thu,  5 Sep 2024 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nwwwea0W"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A0154BFF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530143; cv=none; b=cBavRce9/0sdWoT02EHeT7iePoKrrf67gaZliHvLxbbAJytEZULPG20c0DPap1wDroNDLVBG1FKPqNnfxFclEIbKZJCRWG8RDyAmJ3u/tCNopb9YYvDo1ZLe2hJHpvwZfICfRVaODOqNvYQCL6rp9fHW8gLVhycs03no5YcQa/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530143; c=relaxed/simple;
	bh=XipgE3i98EJ89Zlgm1rDcLeQ2Fuhol925Krp35yo9Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ym85RCoclGKfh17xa2isEhwGXVG5cz8LkAUW9uLbslN8wZ+QyF7HfgbbX2r3RdcwZsOqro1O4vzyoQAPWJWpBSosJwvCRPUb2AaOS67la2IJCaLTwAjQ6Y2/8gilo3W1TXMfj30gnNqPNpVru0+4p1ZaKEAaBxSPzsubCtGQijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nwwwea0W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485972us021530;
	Thu, 5 Sep 2024 09:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eBMqXnOczsEWfeTQoQ51IDQfRhAhgM15JSl0gQxMj6A=; b=Nwwwea0W9WbcRxVF
	2PmCAg0NDpYKxGvQygueg5nVyCwyc4MNbkgfjj9shpK30dun19947UnfHiDuC6S4
	PHWiy3brVswKKHLeEDMfv+DeMbCNN+TrB3mN0nqY47wpZJXgJjlU6Y+NfGTyLF6i
	o9MXLMAchYv2Atf+LnKLQzQfu8/oV57DUhdTMiaAL6jkqCqAGPWE8K48RTv0/Ehp
	DP1dhmVuxEw+0FN1C9byjJbloNK4haOPGd9nNiNolT+FmQ+hMZERDo7IYcZzheNK
	hWDA+kE6zBOYy0MzhsmpjoedmYMHr5yFzZelBTtPIptXbRUvf3Ewtw4prk5oSpRl
	SYOUTQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41f6rngm2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 09:55:32 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4859tENU025863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 09:55:14 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 02:55:11 -0700
Message-ID: <3da836dc-d79c-41b9-aa44-06a94b812bbf@quicinc.com>
Date: Thu, 5 Sep 2024 15:25:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] i3c: master: Avoid sending DISEC command with old
 device address.
To: Ravindra Yashvant Shinde <ravindra.yashvant.shinde@nxp.com>,
        Alexandre
 Belloni <alexandre.belloni@bootlin.com>,
        "moderated list:I3C SUBSYSTEM"
	<linux-i3c@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC: <imx@lists.linux.dev>, <Frank.Li@nxp.com>
References: <20240820151917.3904956-1-ravindra.yashvant.shinde@nxp.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <20240820151917.3904956-1-ravindra.yashvant.shinde@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: --tq_WtyveLVUmGPAkj8J0FB7csNXAuG
X-Proofpoint-ORIG-GUID: --tq_WtyveLVUmGPAkj8J0FB7csNXAuG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_05,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1011 phishscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409050073

Hi Ravindra,


On 8/20/2024 8:49 PM, Ravindra Yashvant Shinde wrote:
> When a new device hotjoins, a new dynamic address is assigned.
> i3c_master_add_i3c_dev_locked() identifies that the device was previously
> attached to the bus and locates the olddev.
> 
After  2-3 reads i could understand what exactly you are trying.
Could you please keep the complete commit log here ?

"
The olddev should not receive any commands on the i3c bus as it
does not exist and has been assigned a new address. This will
result in NACK or timeout. So, update the olddev->ibi->enabled
flag to false to avoid DISEC with OldAddr.
"

Make a complete story here, you don't need function to be added here 
since description should make it clear to understand.

> i3c_master_add_i3c_dev_locked()
> {
>      ...
>      olddev = i3c_master_search_i3c_dev_duplicate(newdev);
>      ...
>      if (olddev) {
>          enable_ibi = true;
>          ...
>      }
>      i3c_dev_free_ibi_locked(olddev);
>      ^^^^^^^^
>      This function internally calls i3c_dev_disable_ibi_locked(addr)
>      function causing to send DISEC command with old Address.
> 
>      The olddev should not receive any commands on the i3c bus as it
>      does not exist and has been assigned a new address. This will
Isn't this the same device who raised HOTJOIN and seeking a new dynamic 
address ? you intend to have no communication with older device address 
right ?
>      result in NACK or timeout. So, update the olddev->ibi->enabled
>      flag to false to avoid DISEC with OldAddr.
>      ...
> }
> 
> Signed-off-by: Ravindra Yashvant Shinde <ravindra.yashvant.shinde@nxp.com>
> ---
> change from v1 to v2
> - Fixed the author name.
> - Unconditional set to the false & added some comments.
> ---
>   drivers/i3c/master.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 7028f03c2c42..0dd8d1c28d58 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2043,7 +2043,14 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
>   				enable_ibi = true;
>   				i3c_dev_disable_ibi_locked(olddev);
>   			}
> -
> +			/*
> +			 * The olddev should not receive any commands on the
> +			 * i3c bus as it does not exist and has been assigned
> +			 * a new address. This will result in NACK or timeout.
> +			 * So, update the olddev->ibi->enabled flag to false
> +			 * to avoid DISEC with OldAddr.
> +			 */
> +			olddev->ibi->enabled = false;
>   			i3c_dev_free_ibi_locked(olddev);
>   		}
>   		mutex_unlock(&olddev->ibi_lock);

