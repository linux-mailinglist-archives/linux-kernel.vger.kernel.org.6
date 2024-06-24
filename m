Return-Path: <linux-kernel+bounces-228044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 605EB9159F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189EE281613
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037051A0B03;
	Mon, 24 Jun 2024 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OXeHd1ip"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99645C1C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719268784; cv=none; b=fDarrr303vlAsECymN/gx9ADoFKQVNX6ehJ8SkHIPkd1epts4HAF+1zCPsmsh5etu5rwf9v1dDok+AJ5VSUBLO2tq2VEMBtGQpScw0pVOx+pOx7q/I/5XcMNGqlDRFZ/6Tk8KtBwlJKFyjWPRKisFbWEMtBQzr4Nyn34lbrhhcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719268784; c=relaxed/simple;
	bh=x+b4bRqj97+MfCvtfL5ymBvYZve/Gk+HfwO7+8F3uzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rpYgFsAnWbJKiQDxuPv2H7khDSSdrlm/nWE/4emyTm4PApPN2yM4xb38SOPG/x6iD//xokGS9vZLTp8Fr+Z7DkaeZaEHnVIfmoRE2tPy3q6MhQUQxz09FzDKCTw/liYI0JNulKoJ95tXrwaY7B/KCWhcRoP+EXtAn/opY2csJFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OXeHd1ip; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OHlW5U008969;
	Mon, 24 Jun 2024 22:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gckfGlMYuYnbR8RAyruOxvuX9UaymnP8Tgn3DVWINCA=; b=OXeHd1ipuJNmSaoL
	5zthFPOga/pl5nKyPEdIdu8lnoYQsCIj5wZhR4xxTCBA4Lyd41pXka5DcIpbDGN5
	pZXQXQ++PzQTp01sFvVzeQ3dlupqDupg58lUI7IUQOcQPSwQSi2IDnmUe3O5U9UQ
	QuxfxGiKhYUk0SWIyV467uSCsoYMuA8e5j2cXwQrbd4sDx4m1eU5nwAk8L1eUQsp
	hwWcCwYhPVQpEK1G1ZbR9MsLHTYCPxaqaVZ85cxv/WOOZVDAeN7HHUB82a9HJWYg
	FlbjVY1RTwszcK3NykTJYNE6YklR8iIgDwRQAVdeQTKOYuxj9ek1pSH5vAhdqLxZ
	S7D6CA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqcecwwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:39:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45OMdMej025279
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:39:22 GMT
Received: from [10.110.106.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 15:39:21 -0700
Message-ID: <99ff549c-f5c4-dc9c-42f3-396dc3d29d6b@quicinc.com>
Date: Mon, 24 Jun 2024 15:39:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] drm/connector: automatically set immutable flag
 for max_bpc property
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
	<dave.stevenson@raspberrypi.com>,
        "igt-dev@lists.freedesktop.org"
	<igt-dev@lists.freedesktop.org>,
        Petri Latvala <adrinael@adrinael.net>,
        Kamil
 Konieczny <kamil.konieczny@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?=
	<ville.syrjala@linux.intel.com>
CC: Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
 <20240623-drm-bridge-connector-fix-hdmi-reset-v2-2-8590d44912ce@linaro.org>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-2-8590d44912ce@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HI8gNzKyRqLtvy82URy1NYj525oXg_qI
X-Proofpoint-ORIG-GUID: HI8gNzKyRqLtvy82URy1NYj525oXg_qI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_19,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240181

+ IGT dev

On 6/22/2024 10:40 PM, Dmitry Baryshkov wrote:
> With the introduction of the HDMI Connector framework the driver might
> end up creating the max_bpc property with min = max = 8. IGT insists
> that such properties carry the 'immutable' flag. Automatically set the
> flag if the driver asks for the max_bpc property with min == max.
> 

This change does not look right to me.

I wonder why we need this check because DRM_MODE_PROP_IMMUTABLE means 
that as per the doc, userspace cannot change the property.

          * DRM_MODE_PROP_IMMUTABLE
          *     Set for properties whose values cannot be changed by
          *     userspace. The kernel is allowed to update the value of 
these
          *     properties. This is generally used to expose probe state to
          *     userspace, e.g. the EDID, or the connector path property 
on DP
          *     MST sinks. Kernel can update the value of an immutable 
property
          *     by calling drm_object_property_set_value().
          */

Here we are allowing userspace to change max_bpc


drm_atomic_connector_set_property()
{
	**********

         } else if (property == connector->max_bpc_property) {
                 state->max_requested_bpc = val;

	**********
}

I believe you are referring to this IGT check right?

https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/kms_properties.c#L428

I think we should fix IGT in this case unless there is some reason we 
are missing. Because just because it has the same min and max does not 
mean its immutable by the doc of the IMMUTABLE flag.


> Fixes: aadb3e16b8f3 ("drm/connector: hdmi: Add output BPC to the connector state")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/drm_connector.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index ab6ab7ff7ea8..33847fd63628 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -2610,7 +2610,12 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>   
>   	prop = connector->max_bpc_property;
>   	if (!prop) {
> -		prop = drm_property_create_range(dev, 0, "max bpc", min, max);
> +		u32 flags = 0;
> +
> +		if (min == max)
> +			flags |= DRM_MODE_PROP_IMMUTABLE;
> +
> +		prop = drm_property_create_range(dev, flags, "max bpc", min, max);
>   		if (!prop)
>   			return -ENOMEM;
>   
> 

