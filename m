Return-Path: <linux-kernel+bounces-228049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD03F915A21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD111C223EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E385B1A2559;
	Mon, 24 Jun 2024 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MmHifq85"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9288D47A64
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269779; cv=none; b=AeTv+gwQjjGsIyP1RSSFTQVR+wsnlfOL+ec1QchqjoGNPduyP//ri7WK48ey+17yS9VaCbG8KrOYStWPWFBsC4E4PUvS+fSjkR1LUqBf0dW7uZqRZYMbvmTCUjs1VwGlulB5b5UBWLGLTgff4c1RTVpL2dmfZmm0wt3U3PuUWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269779; c=relaxed/simple;
	bh=IL1KYzHTIVTceKq0cQhntdI/5YpCcAQJ15WiMrnZmEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PhvHxhw43iF6mjFSJ1wUtEPNhQTvCSfJSkBAGCRLejsqUX1xlkP//bULUqiCCINaPkig2S01K0f/RU+G2AoWsuRcckJC7BSKw8N0wwc/2Fd3USwug0YY4zkdM6pTIdVf0+1awi6tt6sGJ/1QijO6nNXXWxa9OvCJSSqIK7cuZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MmHifq85; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OHVsIg001878;
	Mon, 24 Jun 2024 22:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3E/g0gscuSG5pGPTNlXdT0z8AMhyDwzyCrtpE2W1+HI=; b=MmHifq85x2p9k6TO
	Xa8EkKt7JJrNE3LsqrEvv/jTJ6TB8yBLBRxARji5On7zlfhH4O468ucDobMEPjJj
	1/oeAaT/A4KNT1QE3uLOR7gbzlwqZoqQCZmowJzsx185HqS/uVaEss+rMid1j8pn
	TDE4lj/E2LOGI6KLNRgtBk/MeioDZE9b4cTmuth0oujlBDIdKe0A9PrC9MAw2KBf
	bgI3Raw2skhOmiHcJ1UBUKIowKqV83iSMDkPM61nTPncbUDYAdcSPYwSU9ShqlyF
	3TSgedpo/I36yij2UnLJLHNye+k4NGA4s4onxauXV/7N0QF3Qs4bD4DPfHyitgVR
	S2MxMA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywmaew6je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:55:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45OMtwtx013076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:55:58 GMT
Received: from [10.110.106.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 15:55:57 -0700
Message-ID: <30fa4e53-5a03-4030-2be5-f383a1c60077@quicinc.com>
Date: Mon, 24 Jun 2024 15:55:56 -0700
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
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
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
	<ville.syrjala@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
 <20240623-drm-bridge-connector-fix-hdmi-reset-v2-2-8590d44912ce@linaro.org>
 <99ff549c-f5c4-dc9c-42f3-396dc3d29d6b@quicinc.com>
 <CAA8EJppcH-z275m6xDQaigsxmVhnfJkLVsq68GHLFoAq_p_2GA@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJppcH-z275m6xDQaigsxmVhnfJkLVsq68GHLFoAq_p_2GA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lyDjhoTlWdnbej9hMddkGvrd0JwJCu4R
X-Proofpoint-GUID: lyDjhoTlWdnbej9hMddkGvrd0JwJCu4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_20,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406240184



On 6/24/2024 3:46 PM, Dmitry Baryshkov wrote:
> On Tue, 25 Jun 2024 at 01:39, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>> + IGT dev
>>
>> On 6/22/2024 10:40 PM, Dmitry Baryshkov wrote:
>>> With the introduction of the HDMI Connector framework the driver might
>>> end up creating the max_bpc property with min = max = 8. IGT insists
>>> that such properties carry the 'immutable' flag. Automatically set the
>>> flag if the driver asks for the max_bpc property with min == max.
>>>
>>
>> This change does not look right to me.
>>
>> I wonder why we need this check because DRM_MODE_PROP_IMMUTABLE means
>> that as per the doc, userspace cannot change the property.
>>
>>            * DRM_MODE_PROP_IMMUTABLE
>>            *     Set for properties whose values cannot be changed by
>>            *     userspace. The kernel is allowed to update the value of
>> these
>>            *     properties. This is generally used to expose probe state to
>>            *     userspace, e.g. the EDID, or the connector path property
>> on DP
>>            *     MST sinks. Kernel can update the value of an immutable
>> property
>>            *     by calling drm_object_property_set_value().
>>            */
>>
>> Here we are allowing userspace to change max_bpc
>>
>>
>> drm_atomic_connector_set_property()
>> {
>>          **********
>>
>>           } else if (property == connector->max_bpc_property) {
>>                   state->max_requested_bpc = val;
>>
>>          **********
>> }
>>
>> I believe you are referring to this IGT check right?
>>
>> https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/kms_properties.c#L428
> 
> Yes
> 
>>
>> I think we should fix IGT in this case unless there is some reason we
>> are missing. Because just because it has the same min and max does not
>> mean its immutable by the doc of the IMMUTABLE flag.
> 
> Well, having the same min and max means that it is impossible to
> change the property. So the property is immutable, but doesn't have
> the flag.
> 

True, then does DRM_MODE_PROP_IMMUTABLE need a doc update too indicating 
that even if the min and max is same, property will be interpreted as 
immutable.

>>
>>
>>> Fixes: aadb3e16b8f3 ("drm/connector: hdmi: Add output BPC to the connector state")
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>    drivers/gpu/drm/drm_connector.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
> 
> With best wishes
> Dmitry

