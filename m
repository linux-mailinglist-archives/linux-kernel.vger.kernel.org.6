Return-Path: <linux-kernel+bounces-194652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B2E8D3F91
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B07AB21788
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEFF1C68AE;
	Wed, 29 May 2024 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m5QQ9EY+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41A13D63B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014259; cv=none; b=Xpu5qxHyo/gFIy2AWHycY7BQjKsLtpSAqaiGjVm8ZnpbXwnutkeyqGcNPEpoFgnHdTnC5mLR0jJvPpIkyoW8MbfU5GEzDPA9kVHKS+2t8FH+3kvaLU9tQCMi3SULNne9/yx29lubvx8qWJCCpn6xlveTJQK+N6phRXnXJUDqjbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014259; c=relaxed/simple;
	bh=VqWS/6VyIDQ9XwIkJFJP3KRnkfBNBETeL06WEBD7Y2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fG1srz5iQ28i7+3Qb2B5bH/HKGAIYAGp9L+RtgmKbMcXGHR6V65440t0atdLLYsdgSs7yeR9Tc+5Yvg65WrLPof5orHUJ3CBbhl7OVeegALrCXcPUsSc7U+OfKZupsa2XOWEIOkOWDMKV0vIUMdqpeb1gzDLrEbrXzP3uW3WVLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m5QQ9EY+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TKAS29019859;
	Wed, 29 May 2024 20:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	15Q/WFvKJeSeWdTC0wHFvU6ZrvIrtGaXBSccicqqmJY=; b=m5QQ9EY+neU4Q2Qo
	URE1T/mHgFSFYfHJIao3A9njHgZzZahI+iZsypk80WE7K1vaxMPbFt2CAlWIRCZ6
	9rL5WanVsMnK4d0mB5c5NlWTdMzIlSGYBsjKoyl6VFtAx3grF8P2PCeyANMb+qxX
	f+9I0FQ56dvyAdqBlwFChY5ovwpxtyZZnVfZ0+kkkzgi4mCG5wRrZ7+YxWeiCJ6U
	s6rdHxJCvXxGYNY6Kw5k7mpbuKVwhot/2bzMdx/UvGLAhXac3L9/8Gn/D10NN4fN
	aI7QTDKMOMdNm16FebCGtWQkzZkY6XBKaekYRf9kN37cfwc4YqSA+RX866Rjg3hG
	ERHymQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0qj9vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 20:24:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TKO4GT031058
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 20:24:04 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 13:24:04 -0700
Message-ID: <da0bb4ea-cc74-458d-8869-22bd127d9654@quicinc.com>
Date: Wed, 29 May 2024 13:24:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/panel: sitronix-st7789v: fix display size for
 jt240mhqs_hwt_ek_e3 panel
Content-Language: en-US
To: Gerald Loacker <gerald.loacker@wolfvision.net>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240409-bugfix-jt240mhqs_hwt_ek_e3-timing-v2-0-e4821802443d@wolfvision.net>
 <20240409-bugfix-jt240mhqs_hwt_ek_e3-timing-v2-3-e4821802443d@wolfvision.net>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240409-bugfix-jt240mhqs_hwt_ek_e3-timing-v2-3-e4821802443d@wolfvision.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ryeOim6n8OyN9GzHpy5DBoJDYKXqgxLw
X-Proofpoint-ORIG-GUID: ryeOim6n8OyN9GzHpy5DBoJDYKXqgxLw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_16,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290143



On 5/29/2024 7:42 AM, Gerald Loacker wrote:
> This is a portrait mode display. Change the dimensions accordingly.
> 
> Fixes: 0fbbe96bfa08 ("drm/panel: sitronix-st7789v: add jasonic jt240mhqs-hwt-ek-e3 support")
> Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>

Acked-by: Jessica Zhang <quic_jesszhan@quicinc.com>

> ---
>   drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> index c7e3f1280404..e8f385b9c618 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> @@ -289,8 +289,8 @@ static const struct drm_display_mode jt240mhqs_hwt_ek_e3_mode = {
>   	.vsync_start = 280 + 48,
>   	.vsync_end = 280 + 48 + 4,
>   	.vtotal = 280 + 48 + 4 + 4,
> -	.width_mm = 43,
> -	.height_mm = 37,
> +	.width_mm = 37,
> +	.height_mm = 43,
>   	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
>   };
>   
> 
> -- 
> 2.37.2
> 

