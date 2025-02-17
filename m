Return-Path: <linux-kernel+bounces-510256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A508AA31A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCC0166EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BFF566A;
	Wed, 12 Feb 2025 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cr6Uz/k+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D1B184F;
	Wed, 12 Feb 2025 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319613; cv=none; b=XVZvz8PXw9s5eu7gULPZGRFZoNQNampUJ9z212TQV0Bbf9eMrwpUgHZJYQPg+Vh5QJLU9zd3Z9/8gOZ8Z5Ad3t3TL90gkQVQwqj7/WiGCt2PyPisN7XAdWWoe5hfNEo6cikMa1Sn0SuNg1BoUfjhBVy+yYuca3UsYVdB4hzCq5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319613; c=relaxed/simple;
	bh=uNhpK/uhZJl+vH2zILhptVnUBZWFzlkM2ddiuYDV5Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ITQU95y2NGvGga2niwb2Dbs4uB8HhcaiE7AteHpLOCJsEE6yVbn5K43UFfIvyH0Zt7TJUlzSTCpxAMEt+jigptynZ2/gElGW4USVlcDmLxgieTcCDLyUMWPkUnt8iAmkTOZWup2/bzWkcIdIVii5B2deGFUhXTj72d31iDZxqyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cr6Uz/k+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BCFLqW030181;
	Wed, 12 Feb 2025 00:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wQPD/tKrNf/RHAhrEicL4v/5nkiDZnaTEbOUl3FUsmo=; b=cr6Uz/k+JWTHcTS3
	LgqX7+ScnW7TbED9ir5sKVPOuj6H2CAskBxuTzut8fI9d1JMI2UDSGMdFXFEb8ge
	LdKFPa6CnlCSLvqP9Fv2thPxn5tAGQMl/KLzEc4BETEFr0EeVYBKjlkdZocjLRcj
	AA2ixq6k0P1RcJsbdP1/jRPRSlfa4jY6RUDhd82+l+7qqFetbgLLXmWFWrPuELJ7
	mSzBf5eibqj3jVDcTYT25TumpsR4BB6nTWfWI4naWVS4gJorI+x0DFfht9TGFclr
	QtjaXyol5uQdMnoxR+scTFhK+enYr59YOwAGV71UGmtSZBh2tzm8D3irisYzGR30
	3p7Yyw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qxg9k3tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 00:19:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51C0JnfV015787
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 00:19:49 GMT
Received: from [10.71.110.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Feb
 2025 16:19:49 -0800
Message-ID: <22c97d77-5983-429b-ba0b-ce821a717a0e@quicinc.com>
Date: Tue, 11 Feb 2025 16:19:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm/dpu: Fix uninitialized variable
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>
CC: Ethan Carter Edwards <ethan@ethancedwards.com>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <20250209-dpu-v2-1-114dfd4ebefd@ethancedwards.com>
 <8e40c1bf-6da7-46b1-925c-53d1fa25f3ce@quicinc.com>
 <zj7sqsg3ruev4akl5paedsg65qyh53iddqvssrye2pjtfofs3q@u4g3kevpl2jn>
 <nllxmdfk4wwm2bbrg5jc4tt7la65rwqdtt4tqjp36j6dr4hgmx@ukszi5llldup>
Content-Language: en-US
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <nllxmdfk4wwm2bbrg5jc4tt7la65rwqdtt4tqjp36j6dr4hgmx@ukszi5llldup>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xJSFfhadew4fjGUkI5e_3eSgux2B9IeH
X-Proofpoint-GUID: xJSFfhadew4fjGUkI5e_3eSgux2B9IeH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120001



On 2/11/2025 4:13 PM, Dmitry Baryshkov wrote:
> On Tue, Feb 11, 2025 at 10:23:54AM +0100, Marijn Suijten wrote:
>> On 2025-02-10 14:14:14, Abhinav Kumar wrote:
>>>
>>>
>>> On 2/9/2025 7:51 PM, Ethan Carter Edwards wrote:
>>>> There is a possibility for an uninitialized *ret* variable to be
>>>> returned in some code paths.
>>>>
>>>> Fix this by initializing *ret* to 0.
>>>>
>>>> Addresses-Coverity-ID: 1642546 ("Uninitialized scalar variable")
>>>> Fixes: 774bcfb731765d ("drm/msm/dpu: add support for virtual planes")
>>>> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
>>>> ---
>>>> Changes in v2:
>>>> - Return explicit 0 when no error occurs
>>>> - Add hardening mailing lists
>>>> - Link to v1: https://lore.kernel.org/r/20250209-dpu-v1-1-0db666884f70@ethancedwards.com
>>>> ---
>>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 7 +++----
>>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>
>>> Thanks for your patch, this was addressed with
>>>
>>> https://patchwork.freedesktop.org/patch/631567/ but since this is better
>>> I am fine with this, will pick this one up
>>
>> The `return 0;` in this patch should certainly fix this issue entirely and we
>> don't need to inline the `int ret` for that, which I think is against mixed
>> declaration rules anyway?
>>
>> As far as I understand that's what Dmitry suggested in v1, but he r-b'd it in
>> this form.  Dmitry, was that intended?
> 
> I think it should be fine, if the gcc doesn't warn against it.
> 

Let me test out the compilation while applying and see if it throws any 
errors. If it does, will report here and we can go with the other patch.

>>
>> - Marijn
>>
>>> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>
>>>
>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>>>> index 098abc2c0003cde90ce6219c97ee18fa055a92a5..af3e541f60c303eb5212524e877129359b5ca98c 100644
>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>>>> @@ -1164,7 +1164,6 @@ int dpu_assign_plane_resources(struct dpu_global_state *global_state,
>>>>    			       unsigned int num_planes)
>>>>    {
>>>>    	unsigned int i;
>>>> -	int ret;
>>>>    
>>>>    	for (i = 0; i < num_planes; i++) {
>>>>    		struct drm_plane_state *plane_state = states[i];
>>>> @@ -1173,13 +1172,13 @@ int dpu_assign_plane_resources(struct dpu_global_state *global_state,
>>>>    		    !plane_state->visible)
>>>>    			continue;
>>>>    
>>>> -		ret = dpu_plane_virtual_assign_resources(crtc, global_state,
>>>> +		int ret = dpu_plane_virtual_assign_resources(crtc, global_state,
>>>>    							 state, plane_state);
>>>>    		if (ret)
>>>> -			break;
>>>> +			return ret;
>>>>    	}
>>>>    
>>>> -	return ret;
>>>> +	return 0;
>>>>    }
>>>>    
>>>>    static void dpu_plane_flush_csc(struct dpu_plane *pdpu, struct dpu_sw_pipe *pipe)
>>>>
>>>> ---
>>>> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
>>>> change-id: 20250209-dpu-c3fac78fc617
>>>>
>>>> Best regards,
>>>
> 


