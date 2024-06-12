Return-Path: <linux-kernel+bounces-210725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3987F9047EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 02:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04691F243BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 00:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C4164F;
	Wed, 12 Jun 2024 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IfYGIevV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3186917C;
	Wed, 12 Jun 2024 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718150702; cv=none; b=qVmiHikuK675Q2GJ/5BhT89/oJtNcGRKw/RY3cDtqRPLT+Ag0a/+VYEL9jyGwfHPlROxpwcmFju0ikIfiDiYkGFcRuhL5SRIVhq2iyK1uBMPDMCj0VdzyCNPZWKJYtlpepLy6H2rU+zXFYy07G5NKN17zc4MnM2ArcbytHBoyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718150702; c=relaxed/simple;
	bh=Ptaq9HoVyJOFyH31HBb6lARmwieao3a5iSUKLd04Tzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SJL1u0mcNsZvDk16L3L/4WXHtkV1Wlus0H7W1EeFES/0BvzQt/R3L9mOFjzo9rOhR59teV4fAA+Tkc+NlBdJ07RFyM5jycx6QDWKNQUyd4ZD/YWPFMt7FTpJqU8xoA9Sa44TjpR8SuvL+CkYhxR7m8bPWHvoTOjUxa3OGuzsP9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IfYGIevV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFMqXH026070;
	Wed, 12 Jun 2024 00:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NzZWDUzEYH97W8rJBkKtxt30ULIZaPPxoWU3xHJZVyo=; b=IfYGIevVHM6Az9+q
	zwHoNsuJsck+6l4M7eBr7zBe5bsAdruuG9cVTS0F7VBGJ1Wss9y5TzafMBofz3Lp
	/FkgY82IJpIjMZ/dmCT4B/rh+HlBrifwQ41qs1W8wP6O524M9j3l6VyzMkz5lsKc
	XMQKsAFvmKkbWUwoxlZyBrrqM+pucVsRGrvNUtkYebm/S9Q1tXsRf3Z1X0ZWsqNX
	e2hVBXxpDWTt3gcufhm2vJ6ikFYgR6sSfJ3hLUKvOZDVEpYHmL/10BXEXjEFjyTu
	89UkOYmu8ocOye6BwW6sbyFh5Fy17ulBcakZx2V74pEzYQf4XpR+TlU9Z/7kJxY/
	efWrEg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yps5x919c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 00:04:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45C04qM3016093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 00:04:52 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 17:04:52 -0700
Message-ID: <6f51224a-a7cd-4774-827a-967a4f4b38ee@quicinc.com>
Date: Tue, 11 Jun 2024 17:04:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] drm/msm/hdmi: set infoframes on all pre_enable
 calls
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark
	<robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul
	<sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "David
 Airlie" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240522-fd-hdmi-hpd-v2-0-c30bdb7c5c7e@linaro.org>
 <20240522-fd-hdmi-hpd-v2-4-c30bdb7c5c7e@linaro.org>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240522-fd-hdmi-hpd-v2-4-c30bdb7c5c7e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Cp7JDNilM0owFr5HiQ_J0I9CQx2em4ES
X-Proofpoint-ORIG-GUID: Cp7JDNilM0owFr5HiQ_J0I9CQx2em4ES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_12,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406110164



On 5/22/2024 3:50 AM, Dmitry Baryshkov wrote:
> In consequent modeset calls, the atomic_pre_enable() will be called
> several times without calling atomic_post_disable() inbetween. Thus

Hi Dmitry,

Just wondering, where are you seeing multiple pre_enable() calls without 
a post_disable() happening?

IIRC, the msm commit_tail always calls commit_modeset_disables() before 
the commit_modeset_enables(). Also, doesn't the pre_enable() and 
post_disable() only happen once for bringing up/down the bridge?

Thanks,

Jessica Zhang

> iframes will not be updated for the next mode. Fix this by setting the
> iframe outside of the !power_on check.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> index 3c6121c57b01..fb99328107dd 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> @@ -133,10 +133,11 @@ static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>   		msm_hdmi_phy_resource_enable(phy);
>   		msm_hdmi_power_on(bridge);
>   		hdmi->power_on = true;
> -		if (hdmi->hdmi_mode) {
> -			msm_hdmi_config_avi_infoframe(hdmi);
> -			msm_hdmi_audio_update(hdmi);
> -		}
> +	}
> +
> +	if (hdmi->hdmi_mode) {
> +		msm_hdmi_config_avi_infoframe(hdmi);
> +		msm_hdmi_audio_update(hdmi);
>   	}
>   
>   	msm_hdmi_phy_powerup(phy, hdmi->pixclock);
> 
> -- 
> 2.39.2
> 

