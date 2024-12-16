Return-Path: <linux-kernel+bounces-448036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BD99F3A24
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD3F18844D9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092EA20C48E;
	Mon, 16 Dec 2024 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pyp8ZAgn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F66207DF3;
	Mon, 16 Dec 2024 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734378437; cv=none; b=bBwGmzwjrNICPsvSBrl0Yv0KlgEnvO04X3WtUpPff1MDqMZ1oixE9RCsBy/Uw3SI5QtNDqadKevh2DC1ODOsEe8s8JiF934QOnhJUYYKLWNgUu/fFUVqBfZ3q+a5HI4X8kwT5ez5zGOn7/qdGs5d9r5LsI5oTg79df0MSaf+tZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734378437; c=relaxed/simple;
	bh=SWx76gDujVgcOWz7VDOOXvCvpRGmmEwknI5CpzCkJVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ROZlTUM4tcA1FPLilaKoH911RA0vEjLEMxGO2Cok7zq69FptHscTzgznIF1CcZRyYuDDgDxfNPwSsVRWvorXE9YJH6keJfRCWKvfZWEnCkJMmSZ/ip8Buel5xddPh9i6OKPK69nJ/gnhLW6/Chfg1Aiikc92RniwCQ4tzD0xsdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pyp8ZAgn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGIbjQj010023;
	Mon, 16 Dec 2024 19:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R2mp61jP/WcNaDZR1PYIjaKroxYOLzI15eeolVPyUfw=; b=Pyp8ZAgnZmF3cNDe
	hlHFWWrdyAWk+4ie2eZwryPMQ2jXNX40isg3vXLgwhjAusjIxr1lKEPDM6BnBCBN
	+XY6xf+6KumxNa+nr2RQRneEY1CUaM12Ez/lYI+qXvDQ5w47sOeTZGGrzYNetjgd
	MRLlrlMl6U1hqpFuJcliZIOaK0BwtJmzbzxeqoiEl13MxpFO6tiOyfv2PC9MwI27
	wVXOq16LxlijsFb+xlVBxLH9hPfiQCE+7zqwnpUwjjlsa20oOen9/MdoS5Le1UzD
	0BF3qlCLrW919z+6+z7qetRXK+AEwWDWvpJnMA1GsXNVWZ+ulowlwNT+DT27KDGm
	VNVqTg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jsn9g4ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 19:47:03 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BGJl2Z6032729
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 19:47:02 GMT
Received: from [10.134.70.212] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Dec
 2024 11:47:02 -0800
Message-ID: <7563faa3-a326-4cb8-9eeb-93ba53a22215@quicinc.com>
Date: Mon, 16 Dec 2024 11:47:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/22] drm: Add valid clones check
To: Maxime Ripard <mripard@kernel.org>
CC: Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        <quic_abhinavk@quicinc.com>, Sean Paul
	<sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "David
 Airlie" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann
	<tzimmermann@suse.de>, <quic_ebharadw@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Rob Clark
	<robdclark@chromium.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?=
	<ville.syrjala@linux.intel.com>
References: <20240924-concurrent-wb-v2-0-7849f900e863@quicinc.com>
 <20240924-concurrent-wb-v2-2-7849f900e863@quicinc.com>
 <20240925-hasty-bald-caribou-eedbf5@houat>
 <80d08449-71de-4a7f-8b2a-8af565d8d701@quicinc.com>
 <20241216-elated-vagabond-numbat-14fe8f@houat>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20241216-elated-vagabond-numbat-14fe8f@houat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vJkNvjTdj1vVk_U3K0W-hIjwWMl2onF3
X-Proofpoint-ORIG-GUID: vJkNvjTdj1vVk_U3K0W-hIjwWMl2onF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160163



On 12/16/2024 6:47 AM, Maxime Ripard wrote:
> On Fri, Dec 06, 2024 at 04:48:43PM -0800, Jessica Zhang wrote:
>> On 9/25/2024 12:23 AM, Maxime Ripard wrote:
>>> On Tue, Sep 24, 2024 at 03:59:18PM GMT, Jessica Zhang wrote:
>>>> Check that all encoders attached to a given CRTC are valid
>>>> possible_clones of each other.
>>>>
>>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>>> ---
>>>>    drivers/gpu/drm/drm_atomic_helper.c | 23 +++++++++++++++++++++++
>>>>    1 file changed, 23 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
>>>> index 43cdf39019a4..cc4001804fdc 100644
>>>> --- a/drivers/gpu/drm/drm_atomic_helper.c
>>>> +++ b/drivers/gpu/drm/drm_atomic_helper.c
>>>> @@ -574,6 +574,25 @@ mode_valid(struct drm_atomic_state *state)
>>>>    	return 0;
>>>>    }
>>>> +static int drm_atomic_check_valid_clones(struct drm_atomic_state *state,
>>>> +					 struct drm_crtc *crtc)
>>>> +{
>>>> +	struct drm_encoder *drm_enc;
>>>> +	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>>>> +									  crtc);
>>>> +
>>>> +	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask) {
>>>> +		if ((crtc_state->encoder_mask & drm_enc->possible_clones) !=
>>>> +		    crtc_state->encoder_mask) {
>>>> +			DRM_DEBUG("crtc%d failed valid clone check for mask 0x%x\n",
>>>> +				  crtc->base.id, crtc_state->encoder_mask);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    /**
>>>>     * drm_atomic_helper_check_modeset - validate state object for modeset changes
>>>>     * @dev: DRM device
>>>> @@ -745,6 +764,10 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
>>>>    		ret = drm_atomic_add_affected_planes(state, crtc);
>>>>    		if (ret != 0)
>>>>    			return ret;
>>>> +
>>>> +		ret = drm_atomic_check_valid_clones(state, crtc);
>>>> +		if (ret != 0)
>>>> +			return ret;
>>>>    	}
>>>
>>> Pretty much the same comment, we should have kunit tests for this.
>>
>> Hey Maxime,
>>
>> I'm working on the kunit test for this and had a question on the design for
>> the unit test:
>>
>> Since this is a static helper that returns a pretty common error code, how
>> would you recommend going about making sure that
>> `drm_atomic_check_valid_clones()` specifically is returning the error (and
>> not a different part of check_modeset) when testing the check_valid_clones()
>> failure path?
> 
> There's two ways to go about it. Either you can unit test it, prepare a
> series of custom states and use
> EXPORT_SYMBOL_FOR_TESTS_ONLY/EXPORT_SYMBOL_IF_KUNIT, or you can go the
> integration test way and just test that drm_atomic_check is rejected for
> unsafe combinations.
> 
> I guess I'd prefer the former, but the latter also makes sense and
> eventually, it checks what we want: to make sure that we reject such a
> state. What part of the code does or with what error code is less
> important imo.

Thanks for confirming! The changes I made are based on the latter 
approach. Will post the changes later today if you have no objections on 
this

Thanks,

Jessica Zhang

> 
> Maxime


