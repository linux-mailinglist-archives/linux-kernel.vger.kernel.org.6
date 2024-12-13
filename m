Return-Path: <linux-kernel+bounces-445227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7949F130F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53046188D596
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9961E3DF2;
	Fri, 13 Dec 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qqxb8nGo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF1C1E04B8
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108949; cv=none; b=sE8F3BE7A0gSGlld8coatEVacC9s2JoLh2J5Pc0DCu+vrpgqAlquIMOk7z8Upuem8+kbwFXn6b5L2iGEQzPAf4llO0zr/yWFoYmSlLkrPEv/EaQOXl2s+p+zVRrXT9VKnbTzo9lXzjEt5xDV+ciYRW/wTfbYfPWj1WrmRpHwW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108949; c=relaxed/simple;
	bh=0OTul8bI5rWXtsT+uQ0v5z3rSTVDK0iYdJ8pLwxIP6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KKozdol9igiM6laLYL15aYDQ9BY+r5aYT0U/rrR1+uH1L+sKSwFix8Ll3qPoLf3mhlwOM20OTrIPZx4IpglI758gEL4jj5JCnjLHbh9RrFuUmZL92cjaHt9VjL4tL8YcMmiLs1o7Xob9A9C3q9B9V/Iew1weP7/OaiZjLG//XJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qqxb8nGo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD91R7H022816;
	Fri, 13 Dec 2024 16:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GMOZxZhdaMQj27AqvsnB0B0ki10wfKOas4Sd1wNzl+A=; b=Qqxb8nGonEMJtFQx
	bUr+0Jjf5W0Bo2RYQGGhE4/TfYf3vQSyh2PWF3DpvEQO+hvKwzIVC+2ZZvTcUvO/
	DkArS6KijDfKsdBV+2QdiDCHN46t2IvQ+rb/Xtq1yxU+bauJJTeRbiNaubot/hUL
	vrwDqihtly3XhTzpFVCwoFx9ECDPl4aEsPD29hhhZjdtqBNndGWwmwJUY/BJOSrk
	jPXdVL3aQ/R3FlL9MNkqtBOxx83eDIpqpdxU2Fovxz09xnbV6om9ameO8AVRl/5j
	/hBaS2XZzuZ8/0yWI7/cHA3KH+HHi8GhcMWePRftEnNw4koV+zBEpAki3QlasN+d
	7UO3Nw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43g4wnb45u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:55:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDGth4x013964
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:55:43 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 08:55:42 -0800
Message-ID: <58715579-1dc4-acc7-0cd4-870f1cd1f579@quicinc.com>
Date: Fri, 13 Dec 2024 09:55:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 6/8] accel/amdxdna: Enhance power management settings
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>,
        <mario.limonciello@amd.com>,
        Narendra Gutta <VenkataNarendraKumar.Gutta@amd.com>,
        George Yang
	<George.Yang@amd.com>
References: <20241206220001.164049-1-lizhi.hou@amd.com>
 <20241206220001.164049-7-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241206220001.164049-7-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dDAQBv4TgH-7mLvczJNy9oRZwBFpQed3
X-Proofpoint-GUID: dDAQBv4TgH-7mLvczJNy9oRZwBFpQed3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=925 spamscore=0
 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412130118

On 12/6/2024 2:59 PM, Lizhi Hou wrote:
> +/**
> + * struct amdxdna_drm_get_power_mode - Get the configured power mode
> + * @power_mode: The mode type from enum amdxdna_power_mode_type
> + * @pad: MBZ.

I don't see a check for zero in the implementation

> + */
> +struct amdxdna_drm_get_power_mode {
> +	__u8 power_mode;
> +	__u8 pad[7];
> +};
> +
>   /**
>    * struct amdxdna_drm_query_firmware_version - Query the firmware version
>    * @major: The major version number
> @@ -397,6 +416,7 @@ enum amdxdna_drm_get_param {
>   	DRM_AMDXDNA_QUERY_SENSORS,
>   	DRM_AMDXDNA_QUERY_HW_CONTEXTS,
>   	DRM_AMDXDNA_QUERY_FIRMWARE_VERSION = 8,
> +	DRM_AMDXDNA_GET_POWER_MODE,
>   };
>   
>   /**
> @@ -411,6 +431,34 @@ struct amdxdna_drm_get_info {
>   	__u64 buffer; /* in/out */
>   };
>   
> +enum amdxdna_drm_set_param {
> +	DRM_AMDXDNA_SET_POWER_MODE,
> +	DRM_AMDXDNA_WRITE_AIE_MEM,
> +	DRM_AMDXDNA_WRITE_AIE_REG,
> +};
> +
> +/**
> + * struct amdxdna_drm_set_state - Set the state of the AIE hardware.
> + * @param: Value in enum amdxdna_drm_set_param.
> + * @buffer_size: Size of the input param.
> + * @buffer: Input param.

Is this a pointer address?  Maybe clarify that?

> + */
> +struct amdxdna_drm_set_state {
> +	__u32 param; /* in */
> +	__u32 buffer_size; /* in */
> +	__u64 buffer; /* in */
> +};
> +
> +/**
> + * struct amdxdna_drm_set_power_mode - Set the power mode of the AIE hardware
> + * @power_mode: The sensor type from enum amdxdna_power_mode_type
> + * @pad: MBZ.

I don't see a check for zero in the implementation.


