Return-Path: <linux-kernel+bounces-444242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1AB9F0344
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11D6281134
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3E31607A4;
	Fri, 13 Dec 2024 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PfrW7HR0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E87DA62
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734061899; cv=none; b=nipDEbgwEBRMNcZjeR/8zn9KfeLjsIEFkK/5gSKPCennQ9F07LANfQPYPWifzqQf5gVsJUA8tjIrTt3j4uHvjq6FFxP+rXsjouAbt8A6iNHKU4OWa7MLFB48QFAYOIUnqeLduh05Rj032XSyX0JwruePTUptkG1HMH5tuIoNA7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734061899; c=relaxed/simple;
	bh=WR2aOhsKlxcC+Ualj5d7fGNc9vqwgHsQ9l+44vFqFfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HlbDkdPl8Y0CuG7n4zJj2lRYbT7dnk8N0T0b6gQA606M7PI8edbSvR47Z/XZYd8rCEHDI0IbCJY0rQlq1dokIsOzHHmE46/6jD5u09o0NSO7w7OlBqG7+tKjA4ABZWqh78YjgqGYWkfvlmC118loej0CkirEyL6CKBiEff7V3R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PfrW7HR0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCIDN5r024728;
	Fri, 13 Dec 2024 03:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0WlVVhuuMZbcprATQkmkfPuIsGNaCLEJRsRRrs6ecRk=; b=PfrW7HR0x836L9NY
	9i5yEMlZ/3K/YI0buD1hI12lBUlWy8iELgGs9iARlIK2YyoU0kLTjxNPWEVKIW5W
	7pAlDsnA6k/012fn+aZyUnb/fVEq+ahYecFo4AOKexUGlVgm3S/kw7FHVyF51b1i
	1RsROv2QimR5bGD+hOtHyFIyLXN/R62tGIWw/4wuSDZQmJit8wyr/QCvAsvnaPEd
	FLq7SVUGWBJZoOR+JaBErBRM2Z3G3PuTST6dprIopjdZwBgITGA69z1u9MzB2XXJ
	41l/QUCOsD2M1q+F31D4bC7DR8D+sjIQZOESBoCHOy74K1RehxCCXcgFL+sYSpsp
	lWaG1Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43g4wn93d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 03:51:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BD3p55p003225
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 03:51:05 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Dec
 2024 19:51:03 -0800
Message-ID: <2c97de38-4256-47c4-97e4-7d1cb6c30fc0@quicinc.com>
Date: Fri, 13 Dec 2024 11:51:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/code_tag: Skip displaying the code_tag if it is not
 called
To: Suren Baghdasaryan <surenb@google.com>
CC: <akpm@linux-foundation.org>, <kent.overstreet@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20241211085616.2471901-1-quic_zhenhuah@quicinc.com>
 <CAJuCfpHP2QAhiYmzaAJgxy7A4H3mYep5NKL-iQRy3xSazZ13LQ@mail.gmail.com>
 <ca2aa662-e05e-4ad8-b4cf-33dd2d498af7@quicinc.com>
 <CAJuCfpH-qXf7unhzr7PKY9iX0AcwDrpuKCoigQM+edV=AVYXJg@mail.gmail.com>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <CAJuCfpH-qXf7unhzr7PKY9iX0AcwDrpuKCoigQM+edV=AVYXJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NQnHQwSddZ8JHVitINq7erOljEmatnlS
X-Proofpoint-GUID: NQnHQwSddZ8JHVitINq7erOljEmatnlS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412130027



On 2024/12/13 10:44, Suren Baghdasaryan wrote:
> On Wed, Dec 11, 2024 at 11:50 PM Zhenhua Huang
> <quic_zhenhuah@quicinc.com> wrote:
>>
>> Hi Suren,
>>
>> On 2024/12/12 15:16, Suren Baghdasaryan wrote:
>>> On Wed, Dec 11, 2024 at 12:56 AM Zhenhua Huang
>>> <quic_zhenhuah@quicinc.com> wrote:
>>>>
>>>> /proc/allocinfo is full of callsites which are not called at all.
>>>> Let's only output if the callsite actually been invoked.
>>>
>>> No, I disagree. Allocation that was never invoked is not the same as
>>> no allocation at all. How would we know the difference if we filter
>>
>> But it doesn't affect further display when it is actually called? why we
>> need to know the diff here...
>>
>> The point from me is: up to now, the callsite hasn't been invoked, so it
>> can be ignored in the output.. The original output is really huge..
> 
> My point is that with this change we lose information which can be
> useful. For example if I want to analyze all the places in the kernel
> where memory can be potentially allocated, your change would prevent
> me from doing that.

OK, Thanks, got it.

> 
>>
>>> out the empty ones?
>>> If you don't want to see all the unused sites, you can filter them in
>>> the userspace. I also suspect that for practical purposes you would
>>> want to filter small ones (below some threshold) as well.
>>
>> Yeah, that's the expected way from us as well :)
>>
>>>
>>>>
>>>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>>>> ---
>>>>    lib/alloc_tag.c | 10 ++++++----
>>>>    1 file changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
>>>> index 35f7560a309a..06fb7eb5c0bc 100644
>>>> --- a/lib/alloc_tag.c
>>>> +++ b/lib/alloc_tag.c
>>>> @@ -95,10 +95,12 @@ static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
>>>>           struct alloc_tag_counters counter = alloc_tag_read(tag);
>>>>           s64 bytes = counter.bytes;
>>>>
>>>> -       seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
>>>> -       codetag_to_text(out, ct);
>>>> -       seq_buf_putc(out, ' ');
>>>> -       seq_buf_putc(out, '\n');
>>>> +       if (bytes || counter.calls) {
>>>> +               seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
>>>> +               codetag_to_text(out, ct);
>>>> +               seq_buf_putc(out, ' ');
>>>> +               seq_buf_putc(out, '\n');
>>>> +       }
>>>>    }
>>>>
>>>>    static int allocinfo_show(struct seq_file *m, void *arg)
>>>> --
>>>> 2.25.1
>>>>
>>


