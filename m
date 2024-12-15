Return-Path: <linux-kernel+bounces-444792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEE19F0C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B576C2893A1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4B91DF97F;
	Fri, 13 Dec 2024 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G01sJSyO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798A1DF741
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093596; cv=none; b=KqqsX2o7pJBmyOzbiYD1VhAzsj9FqGe5m902dlEChxpiJ0YunOsUYLNgdXKs9JnpqV5YBMO5SElvThVhDv38LSuF9/NzORsn8VCIhk5yUV9qE30SKKP1n15GvhyzMN+jnGrTR6YYeq/ykB92Etgv7LcmCxD9RMwIzLR9L7i/CwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093596; c=relaxed/simple;
	bh=u89LrWgijApdxo4L99Ej0ByAW7ycADQAsKXMBBhj+4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncxUCLqFS8CVHpL+KTs8hHCoWp29WZwUypioam40FyudB7nzpN0mbPnC5dMz+bmHMRH7X33viWB15qDlu5FFEaccYMfSL2aJhSn9Q0tvHy1kWvHaF8uFALNbDzlBAWPro+W9HfqMB5Xn7/VybpSdTyfvwwmwAcLbSCK50qZD0pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G01sJSyO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9nqNZ017524
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9F9F/oa6KnYOh6nwKXJwdcyz5bofoAigh7/wW+YIVsE=; b=G01sJSyOMKdSWUKy
	LaCXcxmPGtWXLZkNLxN/OCa9XxxDNu7ei8eByZAdk18rLtcpxnrwU7Gd92Isvup7
	kIk+SVcD4Zf+7mUZocVQdDRDowFqcUxhM8XwKhAC6i0NpF+Jjhnwxbk+y3hEyNlm
	N8x62F31eEzjEmleNo6p69MLg8WHRounLOLeTnRKCnY9OW/G2RhPR8e7a5zsGwjp
	fpgXZ4mAAujWmyZkV+TycHu56tr9QW+I67eiu5kyEjLszvFehebxW4IoDCSL51kp
	Bmphb+AEcFvWkt6aFn3/W9WUqv07FOpaAO9FARsf3ewJ6T7tpe/plhUUm0lo0tEB
	DBw0rQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gjmt0gjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:39:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46748e53285so3432781cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734093593; x=1734698393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9F9F/oa6KnYOh6nwKXJwdcyz5bofoAigh7/wW+YIVsE=;
        b=cEgVEqSD5WkKg+69ri+VMCiz26UrH6QrSyyeUeMQUMNwwQ+GqHj3M2jWrbv3pRaXhi
         RCAJFUssJZzVPNF3SoV/xn011YQjYN9xXd/BMHWQ1jAQKB5SdPjUgPzsBmH8Mho9z1xH
         i7XaiwGfiMtfzcpIzn4o8Jcc/9NWRBecj7RWQJbnrb0ngsVtkL1fvD40/lgAaFyt4XIi
         vFkyZhj7zHHP+A60sL2FUs7qvXmmdDOk5ePLoBDzrenlBaEI1tmiXblbsYtbsmLgvKd4
         jUGYdjQbl1j9gDf7BC/H0ikQpre5Eu1zGBD33gtHR2X3bnZHWKYvEaruc2OCy3iDBPX5
         2MVA==
X-Forwarded-Encrypted: i=1; AJvYcCVKszZ34PjL8/AMhuLdlK5+WVONy35bp+ofOJLV3X2lr4Wh75+0hbs3+PRFzPViBojSxgYkSJ4DpLd2Ze4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy58WiMV6yS/1b/hHmKgTk04WVfU5UU8J2as31UQO1OpYCpePbE
	4zWpKcHDMW8jY8UdxqxIkQwchrL+skK6VpBahbX72vKfybbtQyjIjeFJcsFDRO5u94gmvbt6V+q
	yiJ2LQFvnjBPdPXiN3Amfos9o6rC3QnO+CE+hSUGu3nJmZyqP+rLAmGbHKJRu1jo=
X-Gm-Gg: ASbGncsRSRR/HpSmJvIA8BlDyypWGT3yzo9WzS9fifbOjctPThHiDM84d0HrLdXEqFu
	TSzWIfSktoslgeWwELLel5gl2XIrSJbA3+6mdAWOM+VbJSPO4kbf46sitvTpe+gjaEEMVvyOS83
	Y3EKf2Umg+iAe4Q5+S3iobX5PKIurL7Hk8V4+KdQM88QeyuQTSFu5+2BBjPFrYOMay0jzQ7s2ux
	5HpBh85Xq9c7Y5zJimNU1/OwQcQjjJiD+VCmJOonAyrmUYY8GuE4HU5fPTslUwPYcyhY/WVOkGx
	3cR+Q7xg5vm4olms+UfJ6AMHzLhrdJkBH3Aq
X-Received: by 2002:a05:620a:4410:b0:7b6:dc4f:8874 with SMTP id af79cd13be357-7b6fbf3d252mr140860585a.12.1734093592941;
        Fri, 13 Dec 2024 04:39:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHizu5Ba85DKQuxdTDo+aKc1Ajo8QrAOao/BfP4OE0LSBLUvAIPd8kr45CvfnT9+hDRFnKKFg==
X-Received: by 2002:a05:620a:4410:b0:7b6:dc4f:8874 with SMTP id af79cd13be357-7b6fbf3d252mr140859185a.12.1734093592599;
        Fri, 13 Dec 2024 04:39:52 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a49dc6sm11352497a12.31.2024.12.13.04.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 04:39:52 -0800 (PST)
Message-ID: <230eb99b-b223-4d5f-92f6-27edc6827cb0@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 13:39:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] drm/msm: adreno: enable GMU bandwidth for A740 and
 A750
To: neil.armstrong@linaro.org, Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20241211-topic-sm8x50-gpu-bw-vote-v5-0-6112f9f785ec@linaro.org>
 <20241211-topic-sm8x50-gpu-bw-vote-v5-5-6112f9f785ec@linaro.org>
 <31264e68-2cdc-41b2-8d84-459dc257f0f5@oss.qualcomm.com>
 <76592f0b-85f4-4c84-b45b-859d55c4e87d@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <76592f0b-85f4-4c84-b45b-859d55c4e87d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _J4CqiOqCZCxEaltgcURxev3U1XBUxuW
X-Proofpoint-ORIG-GUID: _J4CqiOqCZCxEaltgcURxev3U1XBUxuW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412130089

On 12.12.2024 10:36 PM, Neil Armstrong wrote:
> On 12/12/2024 21:32, Konrad Dybcio wrote:
>> On 11.12.2024 9:29 AM, Neil Armstrong wrote:
>>> Now all the DDR bandwidth voting via the GPU Management Unit (GMU)
>>> is in place, declare the Bus Control Modules (BCMs) and the
>>> corresponding parameters in the GPU info struct.
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 22 ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>> index 0c560e84ad5a53bb4e8a49ba4e153ce9cf33f7ae..edffb7737a97b268bb2986d557969e651988a344 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>> @@ -1388,6 +1388,17 @@ static const struct adreno_info a7xx_gpus[] = {
>>>               .pwrup_reglist = &a7xx_pwrup_reglist,
>>>               .gmu_chipid = 0x7020100,
>>>               .gmu_cgc_mode = 0x00020202,
>>> +            .bcms = (const struct a6xx_bcm[]) {
>>> +                { .name = "SH0", .buswidth = 16 },
>>
>> All a7xx targets use the same BCMs with the only difference being
>> the ACV voting mask. You may want to make these non-anonymous structs.
> 
> it can be done in a second step
> 
>>
>>> +                { .name = "MC0", .buswidth = 4 },
>>> +                {
>>> +                    .name = "ACV",
>>> +                    .fixed = true,
>>> +                    .perfmode = BIT(3),
>>> +                    .perfmode_bw = 16500000,
>>
>> I think perfmode is simply supposed to be set when bw == max_bw
> 
> Not for a750

Akhil, is there any way to determine a suitable OPP for this
dynamically?

Konrad

