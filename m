Return-Path: <linux-kernel+bounces-210224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0103F904107
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C0D286F23
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888263BB48;
	Tue, 11 Jun 2024 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SPKC9XXl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928FD1CFB2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122713; cv=none; b=ETg4Rijl0jj8znZh1qVP3DZoq0tnlwfP9lyJmX3SQJrK9RbzCOPTHJWp3pLZu9bLl8Xb7IXygWEP/wp4UpxeUGZpmZ6Gx/tiNeXVBTfx5wRfehN14WIRobNXSNc76Bv9To3Z6UEtJkyB8m9S7UsMrvBdm28tpspOf3A59Y7/D98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122713; c=relaxed/simple;
	bh=VkplcyEAK/CqqPuprQXUn75nzjvEwusfyevOKBqtIL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=loSFuaBu/egeMmtue8kp2DvCx54o+wMTSOevw6x1wTT4wmlPgfuaBSg8GKS1EVg3gwOp/ou38NYuhJa1roC96QiAO2F/A13gkgSB11BQhWQS2O4DJo6zIlsO6BpYY/GDBzWNe6hQ+mrrtBF+ODHCJg56SW9DFa6+oLgSlH/JV6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SPKC9XXl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BA7vJR016951;
	Tue, 11 Jun 2024 16:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NbIGTfkXL7QFDB2dDvLKDcIZZq590Hs4Si1rtkYPMcA=; b=SPKC9XXlebuNa6in
	pO1bOsxvDBh70f/1o7lUDSwFXcl/1p20DsN+FdUgiCwgZrmGeNJIZxiSYzhHwNB5
	zaqTS2LhCjc14tdZF4LP6K/2z5fdMuNkQmac4AbJKeoMm1GaF3jRJQ+BYRpryOPb
	OEO8mnGmy6NRW5UDrtDqJz3/Wz6uCxAuYwF9+qI+yOigvbWeeR6sH98cG2EowQhB
	2l9E5gGuKj+3uw+rGjpk1LWeCWJ7G2cBSuHMZoxpFe331PRUhARu5Ekju9k4bCzG
	4FfJ4dTm8wzeJzcm6oKAGZ3vQV8c8CetlJnivV1i320hQG75VZd+5Q5rjlogIN46
	tjytwA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ypmjas08h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 16:18:21 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45BGIKIv024411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 16:18:20 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 09:18:20 -0700
Message-ID: <b1ce756e-c9c0-49bd-b5f4-e6db79dc8f1d@quicinc.com>
Date: Tue, 11 Jun 2024 09:18:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panel : himax-hx83102: fix incorrect argument to
 mipi_dsi_msleep
Content-Language: en-US
To: Tejas Vipin <tejasvipin76@gmail.com>, <neil.armstrong@linaro.org>
CC: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <1b7c19ec-536f-4f28-a68f-b03c1b51b99b@gmail.com>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <1b7c19ec-536f-4f28-a68f-b03c1b51b99b@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7dwBttWeolFO5AeyFJd4qyLAd8mRFZXA
X-Proofpoint-ORIG-GUID: 7dwBttWeolFO5AeyFJd4qyLAd8mRFZXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110115



On 6/11/2024 7:05 AM, Tejas Vipin wrote:
> mipi_dsi_msleep expects struct mipi_dsi_multi_context to be passed as a
> value and not as a reference.
> 
> Fixes: a2ab7cb169da ("drm/panel: himax-hx83102: use wrapped MIPI DCS functions")
> 
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>

Hi Tejas,

(for future reference, you don't need an extra newline between the Fixes 
and Signed-off-by tags)

LGTM,

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> ---
> 
> Changes in v2:
>      - Add Fixes tag
> 
> v1: https://lore.kernel.org/all/d9f4546f-c2f9-456d-ba75-85cc195dd9b8@gmail.com/
> 
> ---
>   drivers/gpu/drm/panel/panel-himax-hx83102.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> index 6009a3fe1b8f..ab00fd92cce0 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> @@ -479,7 +479,7 @@ static int hx83102_disable(struct drm_panel *panel)
>   	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>   	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>   
> -	mipi_dsi_msleep(&dsi_ctx, 150);
> +	mipi_dsi_msleep(dsi_ctx, 150);
>   
>   	return dsi_ctx.accum_err;
>   }
> -- 
> 2.45.2
> 

