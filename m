Return-Path: <linux-kernel+bounces-351041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543B9990CA1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06A11F22242
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA461FB3C4;
	Fri,  4 Oct 2024 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ic6Eu+cZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51CC1FAC44
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066225; cv=none; b=sDkLFXdgQvjGeI/d4lG+BziiNW0vECUO/UPn3PHVgkmu9AwN6k0RBLr2aCzLdJkUQDn8EPI1fn75yXXOOthxXPO7XZEYsKKF8HrhnijEnifCDl8MHM2s2EvQD9mrxsjxrQ2rHsUtJ88+qtOKxy87VIfh5xxbzqbLiQFfZbndxjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066225; c=relaxed/simple;
	bh=opHH52SekK6nZaQeI5hv1osvzD+JfYbxKdx73XHC/Xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lFQtcnHhG+w0NL47Try1BcQfBEzpaOhI46Em7Vxe848SgMrEJ/5TxI7A9PNfJD5ea3s9gqMsvA3dxOgSUz+msT8Is2hIYYyyjqmHLGwjSDf1G9nykgKADO+cAmciu/HGkaNAmOPNYDsnWGJ3AExD7HVjePRZHF4/kT5lbDlcnJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ic6Eu+cZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494A4grc031989;
	Fri, 4 Oct 2024 18:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bqBt+x4TRRe7C1lPlzRCRL5ZSm4Dw8vlyjsXr8DFA/0=; b=ic6Eu+cZVkTKbwqm
	ybfjM4am4lOvpnZsinhnZnuJUoOB5q6g91GTGkJ1+7DzQoIMsDc7UJB9YU60HswM
	0yk2pIcpEeQqFSzVXRuBxS0bq7CBrm1uJVMygqW4keT7ZBHjrBvdNHwwtVOS5nGE
	rl8PZwX7XujHFnfSXPAI6uuqNWtLxOA8C8dPuLVZjUA0xUfArQZTDTFFpgfejirx
	MGMPyyTyVUd8gGuXX7aoFUWUWP+atjbpfeEoPUySqW29xSIElv7fi+BH0PvwxLMM
	Dz6WrZpvtBDVHtDvJqcmm1yEBv/tuJaYHh8JggyJ2SbSYrAFOSjOofVAdOy0be/N
	bw/KlQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42205f2xp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 18:23:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 494INdR5032471
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 18:23:39 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 4 Oct 2024
 11:23:38 -0700
Message-ID: <bc45a66f-70d1-da44-808c-e924d8e06c37@quicinc.com>
Date: Fri, 4 Oct 2024 12:23:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V3 10/11] accel/amdxdna: Add query functions
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20240911180604.1834434-1-lizhi.hou@amd.com>
 <20240911180604.1834434-11-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240911180604.1834434-11-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vqHGHLNlK-WsapGgwE7jC2IumvKkXO98
X-Proofpoint-ORIG-GUID: vqHGHLNlK-WsapGgwE7jC2IumvKkXO98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=998 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040127

On 9/11/2024 12:06 PM, Lizhi Hou wrote:
> diff --git a/drivers/accel/amdxdna/aie2_error.c b/drivers/accel/amdxdna/aie2_error.c
> index 3b8223420f5b..9dc44ecf2adb 100644
> --- a/drivers/accel/amdxdna/aie2_error.c
> +++ b/drivers/accel/amdxdna/aie2_error.c
> @@ -3,6 +3,7 @@
>    * Copyright (C) 2023-2024, Advanced Micro Devices, Inc.
>    */
>   
> +#include <drm/amdxdna_accel.h>
>   #include <drm/drm_cache.h>
>   #include <drm/drm_device.h>
>   #include <drm/drm_print.h>

Feels like this should be in the previous patch.

