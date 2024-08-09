Return-Path: <linux-kernel+bounces-281258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB87694D4E2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C411F22386
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E99210EE;
	Fri,  9 Aug 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m2XDgHeX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EB51CA94
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723221788; cv=none; b=RVSVAUgV2IA/an3jjUi49ghCOI3QTg94iSrJTuLa0QB45AVzPOZH4w3clKuT1XP5e6eb1k2jznf4tLdqh4GI74Mjcj6EUkhSzUw10zEzJYFZKls/2Meb9Utf/pkMQer4irmpQO1PLJ+IowcYrO28KtSZX9NLOEBhjia/cKZVLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723221788; c=relaxed/simple;
	bh=khBQyipgC+xqvY07uKRPNMt0byYTCVYRiljjZIpVvpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KGdiMyt1IT/s80+x6I4KASTY6kbucQalH2A/vbAuE7FXqaQKfBNhIhQwl6duZ+pQV0T4+FAJIUYpPXYrb1Wg3i+Nk/ezUXBMrGmVuuidJReUDDrbyprfReeCFHfPbfqdREW7VmI7xm3jXe5xxV8Bdkyev7DhNa6BO8YTZREJclE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m2XDgHeX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479CXjEO019134;
	Fri, 9 Aug 2024 16:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3iNENNCKgMSSnVAFJiUwiDvA7ONrEFhOxsIBgb4ZxBg=; b=m2XDgHeXC1qTIEK7
	THRRLlKLkDZYLb/zu2QlbFRXdYd6nFf1/o85fPYaYbv+UN5ORu40lFfYgtUESUlM
	hsIz03+8TTvuUEywQotqV/x8Ot6Y7oTtVO3zoi2ZTBpsasMIb1WevmjxKZ/BrDwl
	htELuNUVJkgKNe3Gi20HwfIP1OPO/r1B1owmItCDdQbUNLtKpoqq2Wc3wVjmKkLs
	xvILsgayEDCCkT20JAfO3CVdNWRLbUeEn3UfmPu/ZXTPwABr0A4JIXAPWIsSfqeI
	8iv+ymciMQs9AjRg90kTw3TFLARz7KgJAG7fl9nju+s0s6W6ycaSBR3woBSe4YcK
	Cy/08A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40vvgm42ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 16:43:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 479Gh0YW030876
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Aug 2024 16:43:00 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 9 Aug 2024
 09:42:59 -0700
Message-ID: <3f79b66c-89fa-ce78-e34b-294df1d9d1a0@quicinc.com>
Date: Fri, 9 Aug 2024 10:42:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 09/10] accel/amdxdna: Add query functions
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20240805173959.3181199-1-lizhi.hou@amd.com>
 <20240805173959.3181199-10-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240805173959.3181199-10-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4LNx1Cls1-JtkleyglxhUlloDI1e8E2n
X-Proofpoint-GUID: 4LNx1Cls1-JtkleyglxhUlloDI1e8E2n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_13,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=964 bulkscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090120

On 8/5/2024 11:39 AM, Lizhi Hou wrote:
> +/**
> + * struct amdxdna_drm_query_hwctx - The data for single context.
> + * @context_id: The ID for this context.
> + * @start_col: The starting column for the partition assigned to this context.
> + * @num_col: The number of columns in the partition assigned to this context.
> + * @pid: The Process ID of the process that created this context.
> + * @command_submissions: The number of commands submitted to this context.
> + * @command_completions: The number of commands completed by this context.
> + * @migrations: The number of times this context has been moved to a different partition.
> + * @preemptions: The number of times this context has been preempted by another context in the
> + *               same partition.
> + * @pad: MBZ.

Did you make the documentation?  This looks like it'll generate errors 
from missing fields, and not having the same order as the struct.

> + */
> +struct amdxdna_drm_query_hwctx {
> +	__u32 context_id;
> +	__u32 start_col;
> +	__u32 num_col;
> +	__u32 pad;
> +	__s64 pid;
> +	__u64 command_submissions;
> +	__u64 command_completions;
> +	__u64 migrations;
> +	__u64 preemptions;
> +	__u64 errors;
> +};

