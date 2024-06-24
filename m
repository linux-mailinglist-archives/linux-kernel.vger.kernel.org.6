Return-Path: <linux-kernel+bounces-228036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CAB9159E0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311C61F226BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027271A0B10;
	Mon, 24 Jun 2024 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jIOnvVIY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C47B73454
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719268139; cv=none; b=nLi2eE+A9M9Nq1hAHpGk2yGqEZ9ejtt4rnqBWzh8l+U+kwYIvP9vA0FsicfvmbxjEGy5QJhGsqKe6GqlF4YdC8+qG3Z2g+ITKQGpnldj/ll1tBRxb/K2bmaCCp3np7nfeBYUI9YO1e+xca3oKauAaIT7eJkavb6HJnbVNKTBpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719268139; c=relaxed/simple;
	bh=OowDTvQsp/79L/GViE3+JzPRPtpSVg4kCxYvJN14es4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CMM77+ifYFIqd7QgaWjkE4qQ1GHHMIegOsqShO5n7As8FMd6adT76kKFdN9wohhFDIkOciu6oCkchHzodIEZ4TngdKt+R1mUeRWgusth2f96xNEMwGEKnjXmc2y73EgyWaIEhuTFwVJe3VSxGfkowqldR/UVf4bXamcqkL95CAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jIOnvVIY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OIfuJU031942;
	Mon, 24 Jun 2024 22:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qQGNPMjXxj/37KqwhG1qLhggf6rNJ+AAGcm+KDdlV4Q=; b=jIOnvVIYtn7X4612
	phzE/Qo802Riq4WQQPNtrsqVpeJ6SfCU9ZZwL5ZWvgndFImhaqYKB2O8lDsJGFUq
	FUPkkD3+Z13I6tNhSD86bikfgE8g7TqaGHErCfUF1Vgsne9YnyHCM449rDz+GwAI
	G0e0m1kPkZFyVxVM4cjoM2M+KjRXa3a40MPaRBKeEaErCDipG1o71RY/shbn0gEI
	69sYiyu7J/JdgVaogF5TNSIqNqOqvQu9oBBdhvlYPPpOmgsG/OeS3lxMTxPlO0zv
	OoQUXFixUvUuQ+NVsZROSQFGSNqQloCmKMPhh3yV6bTSYUGOBhKAdOyAXxy9qKtf
	jppqUQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywppv4s7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:28:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45OMSdb2022764
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:28:39 GMT
Received: from [10.110.106.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 15:28:38 -0700
Message-ID: <45c25e4b-d64d-549f-6711-7b753d24e2f9@quicinc.com>
Date: Mon, 24 Jun 2024 15:28:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] drm/bridge-connector: reset the HDMI connector
 state
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andrzej Hajda
	<andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert
 Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Dave Stevenson
	<dave.stevenson@raspberrypi.com>
CC: Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
 <20240623-drm-bridge-connector-fix-hdmi-reset-v2-1-8590d44912ce@linaro.org>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-1-8590d44912ce@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Igwf34iY7-uHXXA9X1Wot4KaNxhQCbk3
X-Proofpoint-ORIG-GUID: Igwf34iY7-uHXXA9X1Wot4KaNxhQCbk3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_19,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406240180



On 6/22/2024 10:40 PM, Dmitry Baryshkov wrote:
> On HDMI connectors which use drm_bridge_connector and DRM_BRIDGE_OP_HDMI
> IGT chokes on the max_bpc property in several kms_properties tests due
> to the the drm_bridge_connector failing to reset HDMI-related
> properties.
> 
> Call __drm_atomic_helper_connector_hdmi_reset() if there is a
> the drm_bridge_connector has bridge_hdmi.
> 
> Note, the __drm_atomic_helper_connector_hdmi_reset() is moved to
> drm_atomic_state_helper.c because drm_bridge_connector.c can not depend
> on DRM_DISPLAY_HDMI_STATE_HELPER. At the same time it is impossible to
> call this function from HDMI bridges, there is is no function that
> corresponds to the drm_connector_funcs::reset().
> 
> Fixes: 6b4468b0c6ba ("drm/bridge-connector: implement glue code for HDMI connector")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/display/drm_hdmi_state_helper.c | 21 ---------------------
>   drivers/gpu/drm/drm_atomic_state_helper.c       | 21 +++++++++++++++++++++
>   drivers/gpu/drm/drm_bridge_connector.c          | 13 ++++++++++++-
>   include/drm/display/drm_hdmi_state_helper.h     |  3 ---
>   include/drm/drm_atomic_state_helper.h           |  2 ++
>   5 files changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> index 2dab3ad8ce64..67f39857b0b4 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -8,27 +8,6 @@
>   #include <drm/display/drm_hdmi_helper.h>
>   #include <drm/display/drm_hdmi_state_helper.h>
>   
> -/**
> - * __drm_atomic_helper_connector_hdmi_reset() - Initializes all HDMI @drm_connector_state resources
> - * @connector: DRM connector
> - * @new_conn_state: connector state to reset
> - *
> - * Initializes all HDMI resources from a @drm_connector_state without
> - * actually allocating it. This is useful for HDMI drivers, in
> - * combination with __drm_atomic_helper_connector_reset() or
> - * drm_atomic_helper_connector_reset().
> - */
> -void __drm_atomic_helper_connector_hdmi_reset(struct drm_connector *connector,
> -					      struct drm_connector_state *new_conn_state)
> -{
> -	unsigned int max_bpc = connector->max_bpc;
> -
> -	new_conn_state->max_bpc = max_bpc;
> -	new_conn_state->max_requested_bpc = max_bpc;
> -	new_conn_state->hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
> -}
> -EXPORT_SYMBOL(__drm_atomic_helper_connector_hdmi_reset);
> -
>   static const struct drm_display_mode *
>   connector_state_get_mode(const struct drm_connector_state *conn_state)
>   {
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 519228eb1095..1518ada81b45 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -478,6 +478,27 @@ void drm_atomic_helper_connector_reset(struct drm_connector *connector)
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_connector_reset);
>   
> +/**
> + * __drm_atomic_helper_connector_hdmi_reset() - Initializes all HDMI @drm_connector_state resources
> + * @connector: DRM connector
> + * @new_conn_state: connector state to reset
> + *
> + * Initializes all HDMI resources from a @drm_connector_state without
> + * actually allocating it. This is useful for HDMI drivers, in
> + * combination with __drm_atomic_helper_connector_reset() or
> + * drm_atomic_helper_connector_reset().
> + */
> +void __drm_atomic_helper_connector_hdmi_reset(struct drm_connector *connector,
> +					      struct drm_connector_state *new_conn_state)
> +{
> +	unsigned int max_bpc = connector->max_bpc;
> +
> +	new_conn_state->max_bpc = max_bpc;
> +	new_conn_state->max_requested_bpc = max_bpc;

I understand this is just code propagation but do we need a max_bpc 
local variable?

We can just do

new_conn_state->max_bpc = connector->max_bpc;
new_conn_state->max_requested_bpc = connector->max_bpc;

But apart from that nit, this LGTM.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

