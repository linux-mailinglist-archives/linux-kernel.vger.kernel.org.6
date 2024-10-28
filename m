Return-Path: <linux-kernel+bounces-384665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 577739B2CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1871F22650
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951AF1D356C;
	Mon, 28 Oct 2024 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aFJMbP0C"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9691D2704
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111783; cv=none; b=U/EJXxvpVlMvU37b4WIe1+CPZivzuxK83J9kg8wwIC1uGO5d3Usz0t6CO65M0egy0wwBtd84chXskOE9V5LD67k40To+/0rZEY41lXcyb9O/p0bTzbrERg2GA+noC/qgJko6Zz1HFE7LATPJ2p6dThTa30NwyAE9BLHi1h1SMJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111783; c=relaxed/simple;
	bh=0B5MPxVg/FBYHnrg5GVK6/ZlSxu6vApM3a2osqh3oYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aIxFOo56AeVdMGTCxH6qbyfVezLd/fygkOWTQnuigH92l1HJjkN818/+Vk7yKB2zwmTP7wFTeTG67NM+SCG0Am4R8MpfGseERG1IGCZa799XtWuNkvt/Evt8EfTgv+jTDg9Rjizhu3e5ki48/EXfJpe0yS16fKbnitr1QdBs/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aFJMbP0C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49RNnA7i017530
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CH7JmnR4WoQC2OKYDorurQUr/WQqgAw1HO8xagcwjXY=; b=aFJMbP0Cfbwg1eTB
	G+c2VR8vLJLLVh3VXrzSwfBSQFbRRT5WNS/e6H+4Q44FmYNlgwad1A0Uj9nLJA6r
	JkJKukgPK5Qxpwpr2Df9on9/Vdk+ZmPB3XlvJ6jK+DpirQZL5QVawST2MasqCp/H
	WqjijgUc6vXxqqsL1hE7TkjWkpS4zT8z4tHKOyTNQM40oKPS9HVLomUQZF1Z9Xh7
	RB0Ivl7FgIQYMLece03yZBTfrVdaU1oRIujXdYbZSskexk3FdKGxYOwnPb4A55oY
	YkytiJ/EKtdca6Uduf9pxQJ6AygMgd6yBVfNVZnkPXsrZGWChugsXuc7MsXmq1eZ
	eQg8zA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grt6vftp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:36:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbe91571easo15243996d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730111780; x=1730716580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CH7JmnR4WoQC2OKYDorurQUr/WQqgAw1HO8xagcwjXY=;
        b=sOg6fWuiIGoYTPHHc0kjjBrc9bFswEo/W+grCsBzs1LeSZchSRl6mF68i+cxT/i9iV
         2JSB52IEJ3MZEHTF8HHS/T+XR25MT0iRJVMS3XIg2R4mNZKYlkO3y3geMcOzTvBXVT20
         cb9F3c9NtXv6KEq5KdTQoRicGXLUaVqO+ELg70qteFbg7abJssVhx14oQjahNTT6tnup
         4JFc4414QvrnTV54q0EwF/Oi9LbI2+mRdbPHLg1MbFkAp+pS2Pe1eIvSkeY8vevim+0P
         +No85DMiVa4SASgTeT5L0sPwInfyovlH+H5sggZr+tCK9cPwcYtVi1Qjj3igSBXXqnoo
         +9/w==
X-Forwarded-Encrypted: i=1; AJvYcCWVnQ3/71wpIPpCJg8bfBq66U4NlAsoY7WpJIKyjnsOUagqF0hhZVrHanInjE5LuB10yrS46wtd5twEqlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCFei7r+JMhUlob+UHvbv+1FxTfhY9y8Vfa4NbS+HTv7H2jChs
	Ih+iVRCkMnTeYCA05XhV1M5e/YcPRFvL8DrZOJmy4DMZMkHdggji4IU1Qr40CGRNXVP/Hy9Y3gJ
	GQL83F8bUuCn1ZtglFF7ZDImZiCElT6lm1AcfXwzS5m7sFrmzRTjZTUbKu04OojM=
X-Received: by 2002:a05:6214:194b:b0:6cb:f0f2:f56d with SMTP id 6a1803df08f44-6d185680265mr57679146d6.4.1730111779761;
        Mon, 28 Oct 2024 03:36:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENDTBpL5QFAQCGHq9cO4L85islHNim+U5PehHq1rXAjJQ4OzkNGTFXOdlvbMWSpBERyIw2Zg==
X-Received: by 2002:a05:6214:194b:b0:6cb:f0f2:f56d with SMTP id 6a1803df08f44-6d185680265mr57678966d6.4.1730111779381;
        Mon, 28 Oct 2024 03:36:19 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f028f36sm361269866b.63.2024.10.28.03.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 03:36:19 -0700 (PDT)
Message-ID: <b7f72f38-2758-405b-abc7-60b73448d8bb@oss.qualcomm.com>
Date: Mon, 28 Oct 2024 11:36:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx: Fix excessive stack usage
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling
 <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Arnd Bergmann <arnd@kernel.org>
References: <20241027-stack-size-fix-v1-1-764e2e3566cb@quicinc.com>
 <j2qapo66f64y7ddqlu63dqvog2fdbhnaq3t24wp2srvdt4v7xl@fyqu4ry4wmts>
 <6fea85fc-ccdc-46ec-b612-3712e9431301@quicinc.com>
 <CAA8EJpodjP3rY0Twe9sP37LWwk5ppP36dyLC9WKD6CTDOtmwzA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAA8EJpodjP3rY0Twe9sP37LWwk5ppP36dyLC9WKD6CTDOtmwzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: x7MGttlwdDMF8sy4oGmCZLSAN8UbnvSZ
X-Proofpoint-GUID: x7MGttlwdDMF8sy4oGmCZLSAN8UbnvSZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410280086

On 28.10.2024 11:27 AM, Dmitry Baryshkov wrote:
> On Mon, 28 Oct 2024 at 12:08, Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>>
>> On 10/28/2024 1:56 PM, Dmitry Baryshkov wrote:
>>> On Sun, Oct 27, 2024 at 11:35:47PM +0530, Akhil P Oommen wrote:
>>>> Clang-19 and above sometimes end up with multiple copies of the large
>>>> a6xx_hfi_msg_bw_table structure on the stack. The problem is that
>>>> a6xx_hfi_send_bw_table() calls a number of device specific functions to
>>>> fill the structure, but these create another copy of the structure on
>>>> the stack which gets copied to the first.
>>>>
>>>> If the functions get inlined, that busts the warning limit:
>>>>
>>>> drivers/gpu/drm/msm/adreno/a6xx_hfi.c:631:12: error: stack frame size (1032) exceeds limit (1024) in 'a6xx_hfi_send_bw_table' [-Werror,-Wframe-larger-than]
>>>>
>>>> Fix this by kmalloc-ating struct a6xx_hfi_msg_bw_table instead of using
>>>> the stack. Also, use this opportunity to skip re-initializing this table
>>>> to optimize gpu wake up latency.
>>>>
>>>> Cc: Arnd Bergmann <arnd@kernel.org>
>>>>
>>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>>>> ---
>>>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  1 +
>>>>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 34 ++++++++++++++++++++++------------
>>>>  2 files changed, 23 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
>>>> index 94b6c5cab6f4..b4a79f88ccf4 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
>>>> @@ -99,6 +99,7 @@ struct a6xx_gmu {
>>>>      struct completion pd_gate;
>>>>
>>>>      struct qmp *qmp;
>>>> +    struct a6xx_hfi_msg_bw_table *bw_table;
>>>>  };
>>>>
>>>>  static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>>>> index cdb3f6e74d3e..55e51c81be1f 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>>>> @@ -630,32 +630,42 @@ static void a6xx_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
>>>>
>>>>  static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
>>>>  {
>>>> -    struct a6xx_hfi_msg_bw_table msg = { 0 };
>>>> +    struct a6xx_hfi_msg_bw_table *msg;
>>>>      struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
>>>>      struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>>>>
>>>> +    if (gmu->bw_table)
>>>> +            goto send;
>>>> +
>>>> +    msg = devm_kzalloc(gmu->dev, sizeof(*msg), GFP_KERNEL);
>>>
>>> Is it necessary after being sent? Isn't it better to just kzalloc() it
>>> and then kfree() it at the end of the function?
>>
>> Keeping it around will help to cut down unnecessary work during
>> subsequent gpu wake ups.
> 
> Then, I'd say, it is better to make it a part of the a6xx_gpu struct.

I think a6xx_gmu makes more logical sense here.

FWIW, the driver allocates both _gmu and _gpu for all GPUs regardless

Konrad

