Return-Path: <linux-kernel+bounces-445450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BED9F169C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3AF18894B5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085A01EF0AA;
	Fri, 13 Dec 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ATGXjsSU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF431EC4FF;
	Fri, 13 Dec 2024 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118821; cv=none; b=q2jnGQjV4LVygJeejgwpCCH42qVw5+BrkllH64CNb92KopBupqTBX7HyJqPHG/8zD6pJzQxhVs5X3lSLrAGHIr06KlL+rY996/6+rbOH1VBFJ/ugsH7zxgU3b1y0AT+NATmIUUqRduIn8en/IQMIQQ7u+VwWBLKRi/8HT4H3q8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118821; c=relaxed/simple;
	bh=xzCm4f1poUAO5fgdrLqYUsGuNdvNWR8FFSh9WZoK/CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=STgf3OWNwk6EUVNmbyy37lZj2noQTFvmdpXD0LgJ5OgoQof0u9oS4R3EHhuL9nIGnzAGnaU3d4us6BwKKO2yRUeE9RiB6PWS0YljJQeeqoFTua3PBTU/NlyLQMn58/wb5aT0Fm2t023z8aahZ0X2kNkwPpg+bCjWqEBDCzdXMfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ATGXjsSU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD8VouK022852;
	Fri, 13 Dec 2024 19:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MFtUIli6dWtishohx82WQ+5BOXiH00eA4XIfCtJdvPU=; b=ATGXjsSUF1957xIE
	ODp4j65FsK+SZ7GWGULQRHYvyRjIVXRK9w/ncirMVEWLA7yDQPqAODR7L387zo/4
	NPwYJl7i5s9wXVmwKVmj/Ampyor2f6MSj4x5thxbEMS2c63k521xlzq1Np5RH6Sb
	uCgQEUpkwS/Hj0m/S/8PvWpxRUA+tAMwFPlfxD/j9acVec3NJC4U9M4ap/XizZYZ
	qhbN99lEAdrv7seGJU7FB/ypy9Pf6yF0Z2A/Tf9V0LIDw76XWm2OrHQlhj5+6rYU
	aS0EMjsD6RbA3/LXtlagXIhko6/UFC/FT40ZUYOm1L+uN1l8eR5yuw2Al7/+Bykn
	ss9KGA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43g4wnbfu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 19:40:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDJe3aJ018860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 19:40:03 GMT
Received: from [10.110.102.127] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 11:40:01 -0800
Message-ID: <ac13139d-1cbf-47dd-b200-1a511ffc9453@quicinc.com>
Date: Fri, 13 Dec 2024 11:39:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ci: add kms_cursor_legacy@torture-bo to apq8016
 flakes
To: Vignesh Raman <vignesh.raman@collabora.com>,
        Helen Mae Koike Fornazier
	<helen.koike@collabora.com>
CC: Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel
	<dri-devel@lists.freedesktop.org>,
        freedreno
	<freedreno@lists.freedesktop.org>
References: <20241204-cursor_tor_skip-v1-1-f5f0bba5df7b@quicinc.com>
 <193931869a5.f923adf2270026.8321075661083367617@collabora.com>
 <20a3955e-3d10-47c5-8e68-d70342805010@quicinc.com>
 <19393604e18.f9b6fe7d298023.1937039548910081216@collabora.com>
 <a03ae7e8-391e-4303-91fc-15a59979fd2a@quicinc.com>
 <ed90ca8c-ed81-419f-a5db-a4e8bcd35835@collabora.com>
Content-Language: en-US
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <ed90ca8c-ed81-419f-a5db-a4e8bcd35835@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: h4_RMTJ3BCrHmU395Wnv50LEXVf-Okju
X-Proofpoint-GUID: h4_RMTJ3BCrHmU395Wnv50LEXVf-Okju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412130140

Hi Vignesh

On 12/11/2024 9:10 PM, Vignesh Raman wrote:
> Hi Abhinav / Helen,
> 
> On 12/12/24 01:48, Abhinav Kumar wrote:
>> Hi Helen / Vignesh
>>
>> On 12/4/2024 12:33 PM, Helen Mae Koike Fornazier wrote:
>>>
>>>
>>>
>>>
>>> ---- On Wed, 04 Dec 2024 16:21:26 -0300 Abhinav Kumar  wrote ---
>>>
>>>   > Hi Helen
>>>   >
>>>   > On 12/4/2024 11:14 AM, Helen Mae Koike Fornazier wrote:
>>>   > > Hi Abhinav,
>>>   > >
>>>   > > Thanks for your patch.
>>>   > >
>>>   > >
>>>   > >
>>>   > > ---- On Wed, 04 Dec 2024 15:55:17 -0300 Abhinav Kumar  wrote ---
>>>   > >
>>>   > >   > From the jobs [1] and [2] of pipeline [3], its clear that
>>>   > >   > kms_cursor_legacy@torture-bo is most certainly a flake and
>>>   > >   > not a fail for apq8016. Mark the test accordingly to match 
>>> the results.
>>>   > >   >
>>>   > >   > [1] : https://gitlab.freedesktop.org/drm/msm/-/jobs/67676481
> 
> The test passes - kms_cursor_legacy@torture-bo,UnexpectedImprovement(Pass)
> 

Yes, thats the problem

https://gitlab.freedesktop.org/drm/msm/-/jobs/67676481/viewer#L2696

24-12-04 03:51:55 R SERIAL> [  179.241309] [IGT] kms_cursor_legacy: 
finished subtest all-pipes, SUCCESS
24-12-04 03:51:55 R SERIAL> [  179.241812] [IGT] kms_cursor_legacy: 
finished subtest torture-bo, SUCCESS

Here it passes whereas it was marked a failure. Hence pipeline fails.

>>>   > >   > [2] : https://gitlab.freedesktop.org/drm/msm/-/jobs/67677430
> 
> There are no test failures
> 

No, thats not true

https://gitlab.freedesktop.org/drm/msm/-/jobs/67677430/viewer#L2694

24-12-04 04:18:38 R SERIAL> [  170.379649] Console: switching to colour 
dummy device 80x25
24-12-04 04:18:38 R SERIAL> [  170.379938] [IGT] kms_cursor_legacy: 
executing
24-12-04 04:18:38 R SERIAL> [  170.393868] [IGT] kms_cursor_legacy: 
starting subtest torture-bo
24-12-04 04:18:38 R SERIAL> [  170.394186] [IGT] kms_cursor_legacy: 
starting dynamic subtest pipe-A
24-12-04 04:18:38 R SERIAL> [  170.661749] [IGT] kms_cursor_legacy: 
finished subtest pipe-A, FAIL
24-12-04 04:18:38 R SERIAL> [  170.662060] [IGT] kms_cursor_legacy: 
starting dynamic subtest all-pipes
24-12-04 04:18:38 R SERIAL> [  170.713237] [IGT] kms_cursor_legacy: 
finished subtest all-pipes, FAIL
24-12-04 04:18:38 R SERIAL> [  170.713513] [IGT] kms_cursor_legacy: 
finished subtest torture-bo, FAIL
24-12-04 04:18:38 R SERIAL> [  170.721263] [IGT] kms_cursor_legacy: 
exiting, ret=98
24-12-04 04:18:38 R SERIAL> [  170.737857] Console: switching to colour 
frame buffer device 128x48

Please check these logs, the torture-bo test-case did fail. The pipeline 
was marked pass because it was an expected fail.

So we have two pipelines, where one failed and the other passed. So 
thats a flake for me.

>>>   > >   > [3]: 
>>> https://gitlab.freedesktop.org/drm/msm/-/pipelines/1322770
> 
> The job is same as 2
> 
> In this case, the test passes and deqp-runner does not report it as 
> flake. So we only need to remove it from fails file.
> 

No, like I mentioned above we have a pass and a fail.

> 
>>>   > >   >
>>>   > >   > Signed-off-by: Abhinav Kumar quic_abhinavk@quicinc.com>
>>>   > >   > ---
>>>   > >   >  drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt | 5 +++++
>>>   > >   >  1 file changed, 5 insertions(+)
>>>   > >   >
>>>   > >   > diff --git 
>>> a/drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt 
>>> b/drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt
>>>   > >   > new file mode 100644
>>>   > >   > index 000000000000..18639853f18f
>>>   > >   > --- /dev/null
>>>   > >   > +++ b/drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt
>>>   > >   > @@ -0,0 +1,5 @@
>>>   > >   > +# Board Name: msm-apq8016-db410c
>>>   > >   > +# Failure Rate: 100
>>>   > >
>>>   > > Is failure rate is 100%, isn't it a fail than?
>>>   > > (I know we have other cases with Failure Rate: 100, maybe we 
>>> should fix them as well)
>>>   > >
>>>   >
>>>   > Maybe I misunderstood the meaning of "Failure rate" for a flake.
>>>   >
>>>   > I interpreted this as this test being flaky 100% of the time :)
>>>
>>> Ah right, I see, inside deqp-runner (that auto-retries).
>>>
>>> I'd like to hear Vignesh's opinion on this.
>>>
>>> (In any case, we probably should document this better)
> 
> deqp-runner reports new (not present in flakes file) or known (present 
> in flakes file) flakes
> 
> 2024-12-11 07:25:44.709666: Some new flakes found:
> 2024-12-11 07:25:44.709676:   kms_lease@page-flip-implicit-plane
> 
> 2024-12-11 13:15:16.482890: Some known flakes found:
> 2024-12-11 13:15:16.482898: 
> kms_async_flips@async-flip-with-page-flip-events-atomic
> 
> we add it to flakes file if deqp runner reports new flakes. Another case 
> where we update flake tests is when a test passes in one run but fails 
> in another, but deqp-runner does not report it as flake.
> 
> Regards,
> Vignesh
> 

The confusion here i guess is about what to mention as a "Failure rate"

Failure rate means how many times it fails (like normally) ? In that 
case 100% which I used is wrong and I used 33% instead for which I have 
pushed v2.

>>>
>>> Regards,
>>> Helen
>>>
>>
>> Can you let me know which way we need to go?
>>
>> Just in case I did post a v2 fixing this, 
>> https://patchwork.freedesktop.org/patch/627276/
>>
>> If thats the way to go, can you pls take a look?
>>
>> Thanks
>>
>> Abhinav
>>>   >
>>>   > Out of the 3 runs of the test, it passed 2/3 times and failed 1/3.
>>>   >
>>>   > So its fail % actually is 33.33% in that case.
>>>   >
>>>   > I think I saw a Failure rate of 100% on msm-sm8350-hdk-flakes.txt 
>>> and
>>>   > mistook that as the rate at which flakes are seen.
>>>   >
>>>   > Let me fix this up as 33%
>>>   >
>>>   > > Regards,
>>>   > > Helen
>>>   > >
>>>   > >   > +# IGT Version: 1.28-ga73311079
>>>   > >   > +# Linux Version: 6.12.0-rc2
>>>   > >   > +kms_cursor_legacy@torture-bo
>>>   > >   >
>>>   > >   > ---
>>>   > >   > base-commit: 798bb342e0416d846cf67f4725a3428f39bfb96b
>>>   > >   > change-id: 20241204-cursor_tor_skip-9d128dd62c4f
>>>   > >   >
>>>   > >   > Best regards,
>>>   > >   > --
>>>   > >   > Abhinav Kumar quic_abhinavk@quicinc.com>
>>>   > >   >
>>>   > >   >
>>>   > >
>>>   >
>>>

