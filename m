Return-Path: <linux-kernel+bounces-442029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A3E9ED721
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351B8167502
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DA4200BA9;
	Wed, 11 Dec 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mf0h5BmL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583FB2594BF;
	Wed, 11 Dec 2024 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948347; cv=none; b=LhygRbP+ZIi0VUMkNC3h/GCa50A3Lzb72LIgnfii27F4QxpZet08mi2nG6kbYLYGv89qvsEOh5oKEoR+Tu8kMzjrreh5XpZFZM3aQYfdr22upYjvI0hAZ7tgcN9lhpNEokoXwwdKAmsgCdgJsb+T4ngvbcKdOmkoTlgGAizFKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948347; c=relaxed/simple;
	bh=IkwxHX00+wl47DROPOwkBU5hh7CAbNFRv0VQe5XsJqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kaefzEPe5x3vodZd5BNf3tBNiH8cnweEGjPuZit1NWY7HVMW+ulMJZJ8eIaKwzLemYU38TRaI5/rlSixIzYNSZF3rx84wOnkQPGYK4vETGlMqCmV2uEK7lZrhM+5PheMzsFOQ6ghREhgEe5K/gQVtsYGClfMJvFwY0K5AcF+Js4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mf0h5BmL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBHD9M7027303;
	Wed, 11 Dec 2024 20:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eUHuOhpMT/oVqa7LQQkF5OqrsSb4kUNcxIjOf/Zljs0=; b=Mf0h5BmLohXGWvOg
	mV0L8aOt95arxIOhNo3jUrixrU2kxbzlAuBU3DjwRXa94YTdoZ25JHtj1kv5qEc4
	7vgFLMd1THYNdRTqV4xJng32xQdh7BvZgj71CPeOacR9YjkJMeFyyD8rJ5K+hOya
	FfJIEe2q9+JiCCDI4O6I9XPW5Ib+N7v0kRSRdG8YDDFIMc3S5yUpz6p8F6V2Wiz9
	Bf+aB5Sf8qIdqex+meJwzdGzAuSt36S7pGL11D28eXi4MypERtd95+Rx/VquEQWs
	d54c/PAcejX3PkBplkUZSrpX3tGApq+v3I1Qnj1KaDKSu2pBsm8moaTeRChBq09+
	BWrR4A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43etn8v1y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 20:18:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BBKIofR027802
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 20:18:50 GMT
Received: from [10.110.5.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Dec
 2024 12:18:47 -0800
Message-ID: <a03ae7e8-391e-4303-91fc-15a59979fd2a@quicinc.com>
Date: Wed, 11 Dec 2024 12:18:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ci: add kms_cursor_legacy@torture-bo to apq8016
 flakes
To: Helen Mae Koike Fornazier <helen.koike@collabora.com>,
        Vignesh Raman
	<vignesh.raman@collabora.com>
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
Content-Language: en-US
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <19393604e18.f9b6fe7d298023.1937039548910081216@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XvBkvNKkeoxsjEiP7EBvXf-YaOqqwJpD
X-Proofpoint-GUID: XvBkvNKkeoxsjEiP7EBvXf-YaOqqwJpD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110143

Hi Helen / Vignesh

On 12/4/2024 12:33 PM, Helen Mae Koike Fornazier wrote:
> 
> 
> 
> 
> ---- On Wed, 04 Dec 2024 16:21:26 -0300 Abhinav Kumar  wrote ---
> 
>   > Hi Helen
>   >
>   > On 12/4/2024 11:14 AM, Helen Mae Koike Fornazier wrote:
>   > > Hi Abhinav,
>   > >
>   > > Thanks for your patch.
>   > >
>   > >
>   > >
>   > > ---- On Wed, 04 Dec 2024 15:55:17 -0300 Abhinav Kumar  wrote ---
>   > >
>   > >   > From the jobs [1] and [2] of pipeline [3], its clear that
>   > >   > kms_cursor_legacy@torture-bo is most certainly a flake and
>   > >   > not a fail for apq8016. Mark the test accordingly to match the results.
>   > >   >
>   > >   > [1] : https://gitlab.freedesktop.org/drm/msm/-/jobs/67676481
>   > >   > [2] : https://gitlab.freedesktop.org/drm/msm/-/jobs/67677430
>   > >   > [3]: https://gitlab.freedesktop.org/drm/msm/-/pipelines/1322770
>   > >   >
>   > >   > Signed-off-by: Abhinav Kumar quic_abhinavk@quicinc.com>
>   > >   > ---
>   > >   >  drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt | 5 +++++
>   > >   >  1 file changed, 5 insertions(+)
>   > >   >
>   > >   > diff --git a/drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt b/drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt
>   > >   > new file mode 100644
>   > >   > index 000000000000..18639853f18f
>   > >   > --- /dev/null
>   > >   > +++ b/drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt
>   > >   > @@ -0,0 +1,5 @@
>   > >   > +# Board Name: msm-apq8016-db410c
>   > >   > +# Failure Rate: 100
>   > >
>   > > Is failure rate is 100%, isn't it a fail than?
>   > > (I know we have other cases with Failure Rate: 100, maybe we should fix them as well)
>   > >
>   >
>   > Maybe I misunderstood the meaning of "Failure rate" for a flake.
>   >
>   > I interpreted this as this test being flaky 100% of the time :)
> 
> Ah right, I see, inside deqp-runner (that auto-retries).
> 
> I'd like to hear Vignesh's opinion on this.
> 
> (In any case, we probably should document this better)
> 
> Regards,
> Helen
> 

Can you let me know which way we need to go?

Just in case I did post a v2 fixing this, 
https://patchwork.freedesktop.org/patch/627276/

If thats the way to go, can you pls take a look?

Thanks

Abhinav
>   >
>   > Out of the 3 runs of the test, it passed 2/3 times and failed 1/3.
>   >
>   > So its fail % actually is 33.33% in that case.
>   >
>   > I think I saw a Failure rate of 100% on msm-sm8350-hdk-flakes.txt and
>   > mistook that as the rate at which flakes are seen.
>   >
>   > Let me fix this up as 33%
>   >
>   > > Regards,
>   > > Helen
>   > >
>   > >   > +# IGT Version: 1.28-ga73311079
>   > >   > +# Linux Version: 6.12.0-rc2
>   > >   > +kms_cursor_legacy@torture-bo
>   > >   >
>   > >   > ---
>   > >   > base-commit: 798bb342e0416d846cf67f4725a3428f39bfb96b
>   > >   > change-id: 20241204-cursor_tor_skip-9d128dd62c4f
>   > >   >
>   > >   > Best regards,
>   > >   > --
>   > >   > Abhinav Kumar quic_abhinavk@quicinc.com>
>   > >   >
>   > >   >
>   > >
>   >
> 

