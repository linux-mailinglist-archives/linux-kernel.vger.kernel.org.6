Return-Path: <linux-kernel+bounces-393076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A7E9B9B9A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3851F21E61
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D91DC125;
	Sat,  2 Nov 2024 00:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hsSJy6KS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0DE4C9F;
	Sat,  2 Nov 2024 00:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730508061; cv=none; b=s3y+7mvTlpv6ZVOOFsfeIIJ+tFIcqnhIdDk07QOG8eWUfBlwkXh7oVPVVIg7N/0qXWPqwQZhpSVzGdnOLXu7onMaG6/6tfH2niaBZjtBHwInTyEe85cl01qldBtT4cjL20Fu5+gryLaVcIgOk7vFetYygo8eBAwRn3k/vF0tTMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730508061; c=relaxed/simple;
	bh=glxRuiSGujtTEKcROldCXuM10M/dzkzKRuziXkqgjGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=llRnak+mxNEp8skN4tqlF9lmWjmGBa0qpor6r5Nge2rdcm5VzdjRhqCVlWieJ+MuQ3fcWT+CkJJJOO5wqusXIiOdF+zq9wYkX2Z2mBNdDPtiMDlL07nqx2zFae0r5efweKxpvVWJ4wuozevXoEVSNOPVW0AvEB6NDM17lGFECJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hsSJy6KS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1JGIC8004719;
	Sat, 2 Nov 2024 00:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S1N0C5/naHD+KMeBpxDCt10SYR7Nu7wUABrDfLhFiNM=; b=hsSJy6KSyu+s/Rwl
	7XLuK31o8GjXPIAm3tTmw46BXLzkIN4QtxHoSMqylX0EXzAb8v3eE9RZc0evsfeV
	tgBX7yCtMpumYohqHilWIiujsvC8tfUwgTQTHH077VCTQljMxW3Laz/m9OUR/vbv
	2Y+NZFBBujlJZhyozmxukZ7tkf7qRjGPq67l5k2+sEDu+lYAwD8Iyd2mp9E/kEXW
	zvsnCENZjlAwbqAfR+oqPh9tAuHtj4lOxD6ZW+V+PtHQzYGo0mTvxiGLLftk7ySB
	C3xoSG8G5I0rlzxPPqO3DAzcHbnAHA01cyMZILrUq+Qg66zolamtjTS/wm5jFPdY
	JPLO1A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42m65pe0vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Nov 2024 00:40:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A20enAQ017417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 2 Nov 2024 00:40:49 GMT
Received: from [10.110.96.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 1 Nov 2024
 17:40:47 -0700
Message-ID: <bb5bd688-34dc-4c9e-8abf-d1395f3a385e@quicinc.com>
Date: Fri, 1 Nov 2024 17:40:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/hdmi: mark interlace_allowed as true
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn
 Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20241019-msm-hdmi-interlaced-v1-1-03bf85133445@linaro.org>
 <52229a96-64b0-48d0-9868-31be42b12db1@quicinc.com>
 <CAA8EJpps+spdowEbDoO2zNfyn+DnWwPgnZiFMw13ZE=iAnJEnA@mail.gmail.com>
Content-Language: en-US
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJpps+spdowEbDoO2zNfyn+DnWwPgnZiFMw13ZE=iAnJEnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yhWfHnEOW5gm7o8OfA1GYCFMVeoJk1PG
X-Proofpoint-GUID: yhWfHnEOW5gm7o8OfA1GYCFMVeoJk1PG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411020002



On 11/1/2024 3:26 PM, Dmitry Baryshkov wrote:
> On Fri, 1 Nov 2024 at 23:41, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>>
>>
>> On 10/18/2024 2:10 PM, Dmitry Baryshkov wrote:
>>> The MSM HDMI driver supports interlaced modes. Set the corresponding
>>> flag to allow interlaced modes on the corresponding connectors.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>    drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
>>> index 4a5b5112227f..643c152e6380 100644
>>> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
>>> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
>>> @@ -336,6 +336,7 @@ int msm_hdmi_bridge_init(struct hdmi *hdmi)
>>>        bridge->funcs = &msm_hdmi_bridge_funcs;
>>>        bridge->ddc = hdmi->i2c;
>>>        bridge->type = DRM_MODE_CONNECTOR_HDMIA;
>>> +     bridge->interlace_allowed = true;
>>>        bridge->ops = DRM_BRIDGE_OP_HPD |
>>>                DRM_BRIDGE_OP_DETECT |
>>>                DRM_BRIDGE_OP_EDID;
>>>
>>
>> I had quite a bit of discussion on this internally because this spans
>> quite a few generations of chipsets.
>>
>> On very old hardware, even before msm8996, there was dedicated hardware
>> de-interlacer. But even on msm8996 or other HDMI supported chipsets
>> where the handling of if (mode->flags & DRM_MODE_FLAG_INTERLACE) is
>> present, these were because its carry forward of older interface code.
>>
>> The way we handle interlaced formats today, is software needs to handle
>> the part of dividing height / 2 and width * 2 and adjust the source crop
>> if necessary. This part has moved to userspace for recent chips.
>>
>> Othwerise, we will need to add this part in the dpu driver to adjust
>> this. I am not seeing this part there yet. So may I know how you
>> validated this change? Something similar to :
>>
>> https://git.codelinaro.org/clo/la/kernel/msm-4.4/-/blob/caf_migration/LE.UM.1.3.r3.25/drivers/gpu/drm/msm/sde/sde_plane.c#L1340
>>
>> If we add this part first to dpu code, then we can mark interlace_allowed.
> 
> I think you are mixing the interlaced formats and interlaced output.
> The code that you have pointed to is related to hardware deinterlacing
> - in other words taking the interlaced framebuffer and outputting it
> to the progressive display.
> 
> The interlace_allowed flag controls a different feature - filtering of
> the internalced modes (aka 576i, 1080i, etc). In this case we are
> using progressive frames, but the HDMI outputs a picture as two
> separate fields. I have validated this by outputting image (modetest)
> to the external HDMI display on IFC6410 and on DB820c boards.
> 

Yes I did think that this was to show interlaced content but that being 
said, I traced through the HDMI code a bit, it does have support for 
changing the HDMI timing but without the support of dpu, progressive 
content really cannot be converted to interlaced. So I think the HDMI 
pieces there were supposed to go along with the rest of the dpu pipeline 
that is the entire pipeline shows out interlaced content. But dpu 
support for giving out interlaced content is not there, so this hdmi 
piece by itself is not complete enough to mark interlace_allowed as true.



