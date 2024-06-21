Return-Path: <linux-kernel+bounces-223600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0E391156B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0834FB213D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE473130ADA;
	Thu, 20 Jun 2024 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K14IK04R"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E1A823DC;
	Thu, 20 Jun 2024 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921147; cv=none; b=BjmghetAlnj7wOkEZszARz9Jq0z0nvjo72Gq7+QsBEoNPF1y0jA/qQfUrYtNHMy7/2t+XRf9FQjZRrxF3zwzJZUHGhCNYs/Wgg3kBOL99k0MmpqmQjdqb43cP5g6giyE971eGvX19sNiJuJ4oiwqAvhoQHQosDvQFC5DMR8e8Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921147; c=relaxed/simple;
	bh=hT6s//pTSX0YwHlp3kMXXaoxOWF+HvSw6JDW4O5VWLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TdK1lNeY1l/3txEVmw4k8hO1T3ywsBH+z/JD0XWlDG7u3UUaaHg72hczadYmy+8JcxUHCjQFNc8TbZryPU3+mxy50hHniApnTb/3YXoct9TgrSl0mD9MSxiRMLGPzewYjVb4HIrgjjVrnd+h6k5NHc+dSWH6b2HccQP4NzjpaRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K14IK04R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHBOib019765;
	Thu, 20 Jun 2024 22:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1YAP8zPHKHo0Y24mJ/ad0S4D7m/z8Aj5tDFRDH8bKX8=; b=K14IK04RhBXHiBZX
	nAvp6Vz2WQfRNswEWLUnPyO0qKc12eh3ps0dYIXF2OFqKNnHT5zNWSRS1oct2hnB
	/E0aEangx4eKrGRpyaLKr6HfFP3MwC0CEDsw776eFkwx8ON2kaoWs6McS9PNuLgf
	xHM5ITczFTcWB6YGsVdNphTot6MkE+j6hHNWM+8+wRpDIWzHmjN4LAZlE3cIFRLR
	lWTwVuFR/OcX8xzsLc+GuAx3jOKbDU2LabIwfYBuv6WC1+yg7GQPnMhLMeP1+xm8
	el4JTp2We449tTNKv0AeDOWV2pgWkvL402Piz2r6OY8yKK0CiDr7vOwM781KvNz2
	bys1Nw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrkw8rfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 22:05:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KM5MoV023845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 22:05:22 GMT
Received: from [10.110.82.141] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 15:05:18 -0700
Message-ID: <8dd4a43e-d83c-1f36-21ff-61e13ff751e7@quicinc.com>
Date: Thu, 20 Jun 2024 15:05:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 5/9] drm/msm/hdmi: turn mode_set into atomic_enable
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
        Rob Clark <robdclark@gmail.com>, Sean Paul
	<sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
 <20240607-bridge-hdmi-connector-v5-5-ab384e6021af@linaro.org>
 <f34c4210-fd59-9d27-0987-3345631c9e35@quicinc.com>
 <xymopystyfjj3hpqes3uiw2g3dqynxzvz23snrbfzf2judgxnt@j4nmpcbuy7a4>
 <6d416e1a-1069-8355-e9f3-d2732df081a3@quicinc.com>
 <il2bg6bsu4nu4lpztzwo2rfonttiy64grxcsn7n4uybn3eui77@jxyzd744ksva>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <il2bg6bsu4nu4lpztzwo2rfonttiy64grxcsn7n4uybn3eui77@jxyzd744ksva>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 46wqhs0be5KKmtJK3ZXUKY61neLK-sdU
X-Proofpoint-ORIG-GUID: 46wqhs0be5KKmtJK3ZXUKY61neLK-sdU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_10,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406200162



On 6/20/2024 2:24 PM, Dmitry Baryshkov wrote:
> On Thu, Jun 20, 2024 at 01:49:33PM GMT, Abhinav Kumar wrote:
>>
>>
>> On 6/20/2024 1:32 PM, Dmitry Baryshkov wrote:
>>> On Thu, Jun 20, 2024 at 01:27:15PM GMT, Abhinav Kumar wrote:
>>>>
>>>>
>>>> On 6/7/2024 6:23 AM, Dmitry Baryshkov wrote:
>>>>> The mode_set callback is deprecated, it doesn't get the
>>>>> drm_bridge_state, just mode-related argumetns. Turn it into the
>>>>> atomic_enable callback as suggested by the documentation.
>>>>>
>>>>
>>>> mode_set is deprecated but atomic_mode_set is not.
>>>
>>> There is no atomic_mode_set() in drm_bridge_funcs. Also:
>>>
>>
>> Please excuse me. I thought since encoder has atomic_mode_set(), bridge has
>> one too.
>>
>>> * This is deprecated, do not use!
>>> * New drivers shall set their mode in the
>>> * &drm_bridge_funcs.atomic_enable operation.
>>>
>>
>> Yes I saw this note but it also says "new drivers" and not really enforcing
>> migrating existing ones which are using modeset to atomic_enable.
> 
> Well, deprecated functions are supposed to be migrated.
> 

Along with rest of the pieces of the driver :)

>> My concern is that today the timing engine setup happens in encoder's
>> enable() and the hdmi's timing is programmed in mode_set().
>>
>> Ideally, we should program hdmi's timing registers first before the
>> encoder's timing.
>>
>> Although timing engine is not enabled yet, till post_kickoff, this is
>> changing the sequence.
>>
>> If this really required for rest of this series?
> 
> No, it was just worth doing it as I was doing conversion to atomic_*
> anyway. I can delay this patch for now.
> 
> Two questions:
> 
> 1) Are you sure regarding the HDMI timing registers vs INTF order? I
> observe the underrun issues while changing modes on db820c.
> 

Yes this is the order I see in the docs:

1) setup HDMI PHY and PLL
2) setup HDMI video path correctly (HDMI timing registers)
3) setup timing generator to match the HDMI video in (2)
4) Enable timing engine

This change is mixing up the order of (2) and (3).

> 2) What should be the order between programming of the HDMI timing
> engine and HDMI PHY?
> 

Mentioned above.

> What would be your opinion on moving HDMI timing programming to
> atomic_pre_enable? (the exact place depends on the answer on the second
> question).
> 

So

-> bridge->pre_enable() : Do HDMI timing programming
-> encoder->atomic_enable() : Do timing engine programming
-> post_kickoff() does timing engine enable

This matches the steps I wrote above.

Hence this is fine from my PoV.

>>
>>>>
>>>> I would rather use atomic_mode_set because moving to atomic_enable() would
>>>> be incorrect.
>>>>
>>>> That would be called after encoder's enable and hence changes the sequence.
>>>> That was not the intention of this patch.
>>>>
>>>> NAK.
>>>>
>>>>> Acked-by: Maxime Ripard <mripard@kernel.org>
>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>> ---
>>>>>     drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 33 ++++++++++++++++++++++++++-------
>>>>>     1 file changed, 26 insertions(+), 7 deletions(-)
>>>
>>>
> 

