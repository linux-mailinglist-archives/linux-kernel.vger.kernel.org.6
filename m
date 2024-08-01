Return-Path: <linux-kernel+bounces-271787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8712945336
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4B61C2270E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943511494D1;
	Thu,  1 Aug 2024 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="olXFmT0G"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596913D62C;
	Thu,  1 Aug 2024 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722539891; cv=none; b=cIw4GFaXYMF/ZsSr3/eVC9cjB+AncSyaeXAGd1QzwI/sFhrNumPa1azewnCCyAj1QXVAm186R/muFUHS+F3qoQPUhH+fgvqVB6dPNlTV9wGuKEGkMcMMQpDGEFBFEgThUuBVR1BSkvJOzUaaJtfv6Gp5Qa7RCddjThyUMnZoYFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722539891; c=relaxed/simple;
	bh=y8V9pV7NtOlYZ9R03DAAGQMitzA9LF14iQB/izlExco=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JDnYOV8QKHoiBYM9qkfAvATeh3vtde9imjsB0R2DaLjlyxkPH8shan76zu0KEktHGiEPzxPqWHczzFkY6nA5TGGTUaPnqzLMUfPBGfqxzbu/0yFszW99LUVw14NapJgmlgN1KprkEGwAI+c8SrAIHZ07u82lO1QUIk0gVqiJ70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=olXFmT0G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471DaVe9004853;
	Thu, 1 Aug 2024 19:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Zcb7YaymxDvG1+CVo1YmMGArzp+SsZXzZ0LFGHgMpA=; b=olXFmT0GCXvSiDu8
	pR3YIn/JpV1MTfqPsDx/SgFWF3j8pg9U6idNX7nx7cpn7dVBSwkezMwhAGSl2rYE
	hFDQeCXL4+GZpzGByPlWuKjX6TmkpMuHBhgC3vNcBmTzs6aJa4Z3tEufmVM7TaqJ
	TZ2Mf02qOxwlIIPjHF0ezoe2EAOQ6WgPLkL477BRHlFMSa6PyHI8h1yyAWc317x/
	KgICzty/JX0flpnBasUFA2OYXuTANdLrvYTrGiPldArqXeKszw8kVCbr1SF3EJsz
	K7+82x/UH8a7AOFe9zXJPlPhXUvemJ3/bK0jZL7h/gOWl8kp1Y8x4kXezhNxzAUN
	27Ob1A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40pw459f9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 19:17:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 471JHbtP018544
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 19:17:37 GMT
Received: from [10.110.73.139] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 1 Aug 2024
 12:17:36 -0700
Message-ID: <9c476b12-a4ca-43f7-875a-eb0a1032c494@quicinc.com>
Date: Thu, 1 Aug 2024 12:17:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] Add SCMI transport descriptors
Content-Language: en-US
To: Cristian Marussi <cristian.marussi@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <arm-scmi@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <sudeep.holla@arm.com>, <james.quinlan@broadcom.com>,
        <f.fainelli@gmail.com>, <vincent.guittot@linaro.org>,
        <etienne.carriere@st.com>, <peng.fan@oss.nxp.com>,
        <michal.simek@amd.com>, <quic_sibis@quicinc.com>,
        <dan.carpenter@linaro.org>, <souvik.chakravarty@arm.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>
References: <20240730144707.1647025-1-cristian.marussi@arm.com>
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20240730144707.1647025-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UYin6VE9cEp8HFV_qWGzL_m1nmuweziG
X-Proofpoint-ORIG-GUID: UYin6VE9cEp8HFV_qWGzL_m1nmuweziG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_17,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408010127


On 7/30/2024 7:47 AM, Cristian Marussi wrote:
> Hi,
>
> this small series is an extended version of this recent, already reviewed,
> series [1] posted by Peng to add a new arm,scmi property to describe some
> platform-specific SCMI timeout constraints.
>
> On top of that, this adds 2 more properties to describe a couple more
> platform-specific transport characteristics.
>
> To minimize conflicts, the whole series is based on top of another recent
> series, which represents a rework of the core SCMI stack to split SCMI
> transports as standalone drivers. [2]
>
> Thanks,
> Cristian
>
> [1]: https://lore.kernel.org/linux-arm-kernel/20240709140957.3171255-1-peng.fan@oss.nxp.com/
> [2]: https://lore.kernel.org/linux-arm-kernel/20240730133318.1573765-1-cristian.marussi@arm.com/T/#t
>
> ---

Thanks Cristian for the series. I have validated them on Qualcomm
SA8255p(to be upstreamed) Ride platform.

-Nikunj

>
> Cristian Marussi (5):
>   firmware: arm_scmi: Remove const from transport descriptors
>   firmware: arm_scmi: Use max-rx-timeout-ms from devicetree
>   dt-bindings: firmware: arm,scmi: Introduce more transport properties
>   firmware: arm_scmi: Use max_msg and max_msg_size from devicetree
>   firmware: arm_scmi: Relocate atomic_threshold to scmi_desc
>
> Peng Fan (1):
>   dt-bindings: firmware: arm,scmi: Introduce property max-rx-timeout-ms
>
>  .../bindings/firmware/arm,scmi.yaml           | 22 +++++++++
>  drivers/firmware/arm_scmi/common.h            |  9 +++-
>  drivers/firmware/arm_scmi/driver.c            | 46 ++++++++++++-------
>  .../arm_scmi/scmi_transport_mailbox.c         |  2 +-
>  .../firmware/arm_scmi/scmi_transport_optee.c  |  2 +-
>  .../firmware/arm_scmi/scmi_transport_smc.c    |  2 +-
>  .../firmware/arm_scmi/scmi_transport_virtio.c |  2 +-
>  7 files changed, 64 insertions(+), 21 deletions(-)
>

