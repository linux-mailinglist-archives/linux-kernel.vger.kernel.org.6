Return-Path: <linux-kernel+bounces-442289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D72E69EDA42
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCE1283900
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA681D8A0B;
	Wed, 11 Dec 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FsCDDLrl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1F51DE4F0;
	Wed, 11 Dec 2024 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956702; cv=none; b=tBel937Wk90FLC8EVGRQ/OnfbKjxpjjmmFKH7n31gsDtUMG5cJdIdWuMOQefcRvthabBZVvY3ccN25JwvBP2m6tyc/We/R3nMwMLe34ruqY8bkQ4c3p1hAHG1l98zsSkWa+/TD3Lq8pLiVDlI8EzfMLg8owZ+3BHySknTXviCY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956702; c=relaxed/simple;
	bh=+wtQa/0A7z74C8XMWedpqUoGa7FVGJnBex7iiMm6Yqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eLeO++yGPQhefLZNJi9HWw3BhTgqIpqzpKXLs5NtJTvSr7ZhKcyWpQQcQnpThrZkz3492YauzDGakUrzmhh6FB3RpoqayXuy3N/tFd6VxQNLF0GV4gAnXD/7pIZxBwbZjajPrJqliRrVVIplysBqNHnc8LsiTkiMF8wUhyNQoPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FsCDDLrl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBHD9So027303;
	Wed, 11 Dec 2024 22:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z2C7/fCtt5pTk0XOcT922hfBtdgDzW72cIzpyOZ/pDQ=; b=FsCDDLrlecHyhAW3
	KyM1GjKYg0G2WSIri5NS1Jtxcy0g2jNItQ4hKN6OLoGRejx52ZnrK5zgjm6pPk9o
	ZSyJhki4ahs+4iHDfDTGKQUNsqbOGktGJUmLG5Sta4jOfcStqrBu0pVSAUdQQK00
	PxdilWh4ktFI09EIliHMdqq1U7ZlMwyS2w+Px9HIEmEOdOnoRwh3Hwu1IjQTrx/Q
	5kzVvNSg7JF9BqvRZZ7iSnSm+L1dQTaNBRwqzp2jYP6Oxbqi2K8WO2CJFGi+oiCs
	Z1DkkAttAt9bQSfSJRcB3q+SZhxve08X4gEKhl1TBCY1To8L+5CGEnDCeZ4wtIpX
	Zj9+Wg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43etn8v9w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 22:38:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BBMcCYu008305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 22:38:12 GMT
Received: from [10.110.5.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Dec
 2024 14:38:10 -0800
Message-ID: <cfbadc5a-6de0-4081-948c-3542c615a992@quicinc.com>
Date: Wed, 11 Dec 2024 14:38:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] drm/msm/dpu: allow using two SSPP blocks for a
 single plane
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn
 Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20241130-dpu-virtual-wide-v7-0-991053fcf63c@linaro.org>
 <20241130-dpu-virtual-wide-v7-2-991053fcf63c@linaro.org>
 <160151f0-9cc6-40f6-9f53-466185835e4d@quicinc.com>
 <hpmxj7tjmvbo55izoxgygqmysbabnpb35mprvn6w53vbtehnwe@yxmiigoeuyf3>
Content-Language: en-US
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <hpmxj7tjmvbo55izoxgygqmysbabnpb35mprvn6w53vbtehnwe@yxmiigoeuyf3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1Ceqt1n_9QUXArHlCDcs3zamBR8BFko0
X-Proofpoint-GUID: 1Ceqt1n_9QUXArHlCDcs3zamBR8BFko0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=946 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110158



On 12/11/2024 2:24 PM, Dmitry Baryshkov wrote:
> On Wed, Dec 11, 2024 at 01:51:51PM -0800, Abhinav Kumar wrote:
>>
>>
>> On 11/29/2024 5:55 PM, Dmitry Baryshkov wrote:
>>> Virtual wide planes give high amount of flexibility, but it is not
>>> always enough:
>>>
>>> In parallel multirect case only the half of the usual width is supported
>>> for tiled formats. Thus the whole width of two tiled multirect
>>> rectangles can not be greater than max_linewidth, which is not enough
>>> for some platforms/compositors.
>>>
>>> Another example is as simple as wide YUV plane. YUV planes can not use
>>> multirect, so currently they are limited to max_linewidth too.
>>>
>>> Now that the planes are fully virtualized, add support for allocating
>>> two SSPP blocks to drive a single DRM plane. This fixes both mentioned
>>> cases and allows all planes to go up to 2*max_linewidth (at the cost of
>>> making some of the planes unavailable to the user).
>>>
>>
>> Overall looks so much cleaner after unification!
>>
>> One small nit below,
>>
>>
>> You can still have,
>>
>> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Note: we have started testing this series with sc7180 CrOS, and will report
>> our findings/ give tested-by this week.
>>
>>
>> <snip>
>>
>>> +static bool dpu_plane_try_multirect_parallel(struct dpu_sw_pipe *pipe, struct dpu_sw_pipe_cfg *pipe_cfg,
>>> +					     struct dpu_sw_pipe *r_pipe, struct dpu_sw_pipe_cfg *r_pipe_cfg,
>>> +					     struct dpu_hw_sspp *sspp, const struct msm_format *fmt,
>>> +					     uint32_t max_linewidth)
>>> +{
>>> +	r_pipe->sspp = NULL;
>>> +
>>> +	pipe->multirect_index = DPU_SSPP_RECT_SOLO;
>>> +	pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
>>> +
>>> +	r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
>>> +	r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
>>> +
>>
>>
>> There are two places where the multirect_index and multirect_mode are reset.
>> Would it be better to just have a small api dpu_plane_reset_multirect() and
>> do this there?
> 
> I'm not sure, what's the benefit. We can add an API to reset one pipe
> (to also be able to use it in _dpu_plane_atomic_disable()), but then
> it's just deduplication for the sake of deduplication.
> 

Yeah I was thinking something like

dpu_plane_reset_multirect(pipe);
dpu_plane_reset_multirect(r_pipe);

But its only a minor benefit, hence as I wrote it as a nit. We can keep 
things as it is, if its unnecessary in your opinion.


> 

