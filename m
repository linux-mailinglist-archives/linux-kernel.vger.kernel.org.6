Return-Path: <linux-kernel+bounces-370707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8C89A3114
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C421F23771
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF9E1D86ED;
	Thu, 17 Oct 2024 22:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IOWnfb4w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD141D5142
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729205675; cv=none; b=YJeF911sXHyWQta/C5dE37oUflM2zvwAJVjv5w/n3XPbvRA1+9JyNN9in9wPnkFxgYE8UV69MQPHC0CMU1lVHHNDPzSD/6tm3eYGtU6Io90fT3AKxMCj9NkON2fz4UN9nthJ09uSpBMGtVedMTKD9GmnkiSWiJkv0jQ3H9kTN08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729205675; c=relaxed/simple;
	bh=q0eMo5KImOHDPGrF8/x0DvjmXjDrgukZtxOcCgFuJm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tT8iPWCgs0FKFBahKaMO0t8o9mOONLC2Wn3akZGyfL6eLogDOjTuz6654AYbddxOIczKC/8I5iSKO4qnZPiOEpg1hM3CCJeZA5/UuVCWCuirHG8cZvF7SQvZrMCOW0PYMoVqrDTR4hohOLV1tcNzNRyNvzFpWnoD+O6rHxSqDG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IOWnfb4w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HIpikk013279;
	Thu, 17 Oct 2024 22:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	udSvq1C78g2ybpLzpRiraZIab6iFDvkSD4f9AwGC4p4=; b=IOWnfb4wR9uktgdU
	wpptarWLsEvsTTBUYodGBinXayooEtXsvnUIW8M8MHOSS3Obq5UmiLBbmS+/HTh/
	ry8IFmw/+6MUOPONWqoudNZiecemNnHUdOYdyrZQBsgmfGzYIevUBCX2j48Y3VQC
	puomslosPb5bjHW5mxuKmoeYqcO62FmBtHEJj0mHwFYHDy2yjzqJ87WGQ5y2/N+l
	0NSklfMoAHzXNulL4Nu9SkigGIq8803abbEbb41gOUwMojRikKD9vqej4ebT2nSs
	tCMCUjXgFmUx9MqQUg/xLp/PxMYEnHKdRz5zQ+w3EHVXPXfpB/FCJkYj52g/Fwmp
	rlYkZA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42abbxwq3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 22:52:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49HMq789030742
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 22:52:07 GMT
Received: from [10.134.71.247] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Oct
 2024 15:52:06 -0700
Message-ID: <c633a57f-7f22-41e0-8b3d-bd95ad212e9b@quicinc.com>
Date: Thu, 17 Oct 2024 15:52:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/display: Drop obsolete dependency on COMPILE_TEST
To: Jean Delvare <jdelvare@suse.de>, <dri-devel@lists.freedesktop.org>,
        LKML
	<linux-kernel@vger.kernel.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Doug Anderson
	<dianders@chromium.org>,
        YueHaibing <yuehaibing@huawei.com>
References: <20241015134606.5b87093e@endymion.delvare>
Content-Language: en-US
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20241015134606.5b87093e@endymion.delvare>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Qi6nSij_vao25x4vmDC-dJll4SJBYyNh
X-Proofpoint-GUID: Qi6nSij_vao25x4vmDC-dJll4SJBYyNh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=916 bulkscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410170154



On 10/15/2024 4:46 AM, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> To avoid reintroducing the randconfig bug originally fixed by commit
> 876271118aa4 ("drm/display: Fix build error without CONFIG_OF"),
> DRM_MSM which selects DRM_DISPLAY_DP_HELPER must explicitly depend
> on OF. This is consistent with what all other DRM drivers are doing.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
> For regular builds, this is a no-op, as OF is always enabled on
> ARCH_QCOM and SOC_IMX5. So this change only affects test builds. As
> explained before, allowing test builds only when OF is enabled
> improves the quality of these test builds, as the result is then
> closer to how the code is built on its intended targets.
> 
> Changes in v3:
> * Rebase on top of kernel v6.11.
> Changes in v2:
> * Let DRM_MSM depend on OF so that random test builds won't break.
> 
>   drivers/gpu/drm/display/Kconfig |    2 +-
>   drivers/gpu/drm/msm/Kconfig     |    1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

