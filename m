Return-Path: <linux-kernel+bounces-209995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3AD903DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5AA287628
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC7717D340;
	Tue, 11 Jun 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XoIgw3PF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C651E4AF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113583; cv=none; b=unmJZl6qVR7Y5Q4zjmKNEhs70X0V4gPwjieljVPbkmzclrz+ZYMt2HybFzdnDNn0t6QmRDPNUWjc+T3ueMcspuDGagkTrVhkAvwMTGusQwzZsDIb6JZxWuZlKXqYZD/TV/As6NsuR5l4is9ftj+9Momkf/dKxhfdjJib2lw8b0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113583; c=relaxed/simple;
	bh=harjIYdYL2bsUjYLZjwLgV437sow8kcv1YcjNBux4gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F4VlcqnCYC4aKe03I3vR+uSrstdtnHDpyG+wdfGg9YKF559MF7kSeerscptImZM2aKcvqZLGAWM4UMDqTctjOfYdFvQGHS4zwyhBcxvM/EAV+cym1tqAv4oHu4eRwpO088cxA0dczpOIwKANTBnkYeU/1ndA3RZisOxDi7pRPlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XoIgw3PF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B6Il1W003639;
	Tue, 11 Jun 2024 13:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H57Yly94lUujR4aEs3lPMh0cm7TnWcXLJp+i5ENoF98=; b=XoIgw3PFEf0rqGgJ
	c86bL7EkJgSqXUBuGommE0Ut1E89U/NVs2opVwtqnjd08klx/ylit7UHd+B3dkS4
	wK1WZ+4BScXezW1wUkCCy/bOwxEtLBGcAyu1eD7mjY2YdCgFwsN7ADi7GWYSoGaQ
	1/bzquUVcrjHq12Bi6svopY33CE2UvHvA86Izxl5YfZH11qw9C/UiTQFP0cqAtn2
	40AVGg7dtPmNhkLGpA8PYzfzmTUH0jp+pVNEHJSBV1GL0+oJqL6eeLHZPtrlxyFl
	hF4mWg39+OK+xo5glIDVATho7x9OXxjyRyVp7qCDfYv3A/zk2G3p5ktME/9dOmdZ
	FUSaig==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymg2epj90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 13:46:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45BDkDNJ025735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 13:46:13 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 06:46:13 -0700
Message-ID: <4e13caf0-c6f5-4df0-82b9-be72ffe06beb@quicinc.com>
Date: Tue, 11 Jun 2024 06:46:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] drm/mipi-dbi: Add missing MODULE_DESCRIPTION()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240425125627.2275559-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240425125627.2275559-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QgWs6Q-tnn3leFIMyyZbGw8rMFDpiPz4
X-Proofpoint-GUID: QgWs6Q-tnn3leFIMyyZbGw8rMFDpiPz4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_07,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110100

On 4/25/24 05:56, Andy Shevchenko wrote:
> The modpost script is not happy
> 
>    WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/drm_mipi_dbi.o
> 
> because there is a missing module description.
> 
> Add it to the module.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/gpu/drm/drm_mipi_dbi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
> index daac649aabdb..ee6fa8185b13 100644
> --- a/drivers/gpu/drm/drm_mipi_dbi.c
> +++ b/drivers/gpu/drm/drm_mipi_dbi.c
> @@ -1475,4 +1475,5 @@ EXPORT_SYMBOL(mipi_dbi_debugfs_init);
>   
>   #endif
>   
> +MODULE_DESCRIPTION("MIPI Display Bus Interface (DBI) LCD controller support");
>   MODULE_LICENSE("GPL");

I'll remove this from my series
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>


