Return-Path: <linux-kernel+bounces-442708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5117B9EE099
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0885428307E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A81F20B204;
	Thu, 12 Dec 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cnZfadcC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C6C259483
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733989868; cv=none; b=tFTDupeCXbx8kY7rhTlXUMrffpN1nV5+nIf2+Id3E6UMSbITLNZSUe0X1qvVZLqVby7KA5ege38oh+NWE1plHroeL2XOlh5nuQs9z5w3+oTkPDN4PG0m1GP6Q1yKCVJabYKj883LoyUwIScKCzPBCDTUUPlAWNouMLdS9ZkdqCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733989868; c=relaxed/simple;
	bh=M0MUsJ9LimNsy1HMHpL4H1l4j/kl/Rsgyeq2nScP1qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TaAvR9OnyBDfXM9nW1aJzJVVR63feOL2g9q4c6oP2uojPJSJBXa2HPYaNCczaxejwTAY7YPUsLSpxSzkS16h5SxeucTLs9a8M8D4zIrXrqsZ6l+rWL5g0PN7BY1b6aFKSOkpUHlXV6UIlu7j9iUxL6p329dmoRBurYyWCGre32c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cnZfadcC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC72sUX030098;
	Thu, 12 Dec 2024 07:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N0fDG9czXcIfHX8ntkk7y0sz92jcGrSzEkNajuWjIVc=; b=cnZfadcCIZ7alfbF
	vSdgT0irD4m58VPjsS6WThQZhofLbZvk/j4c7kepkXt5ulJk0DRnI1AdVPMajcqk
	mvBNZJ2tyHSOkq/o8tBMrDtRNZqsaV84xpO0D0IjSreWQmDMtL/k7RCSChaCSXOi
	Lx4uF6lfCk95Z5jL4jYp46jzSH32310YQK9hr189cZ8CCA5NpAiIVgDbXLRgBynP
	EUZPFNDwHo2ozXz9d/TU9SFAVTZ3I8hZXlwxXoSxgffX9oG720NqiX2I23TK6z4Y
	1L+d0p+MgRmKl8mNIui93710dT/NLg0/hgdbuwAsKOOti+fmhBDxKqf5XXfNNDYR
	E2KsKA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dxw4ahhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 07:50:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC7olHp032755
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 07:50:47 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Dec
 2024 23:50:45 -0800
Message-ID: <ca2aa662-e05e-4ad8-b4cf-33dd2d498af7@quicinc.com>
Date: Thu, 12 Dec 2024 15:50:43 +0800
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
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <CAJuCfpHP2QAhiYmzaAJgxy7A4H3mYep5NKL-iQRy3xSazZ13LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N9J9giHnv6lGpTb7dDY2SDLS8jZdPMIt
X-Proofpoint-GUID: N9J9giHnv6lGpTb7dDY2SDLS8jZdPMIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120053

Hi Suren,

On 2024/12/12 15:16, Suren Baghdasaryan wrote:
> On Wed, Dec 11, 2024 at 12:56 AM Zhenhua Huang
> <quic_zhenhuah@quicinc.com> wrote:
>>
>> /proc/allocinfo is full of callsites which are not called at all.
>> Let's only output if the callsite actually been invoked.
> 
> No, I disagree. Allocation that was never invoked is not the same as
> no allocation at all. How would we know the difference if we filter

But it doesn't affect further display when it is actually called? why we 
need to know the diff here...

The point from me is: up to now, the callsite hasn't been invoked, so it 
can be ignored in the output.. The original output is really huge..

> out the empty ones?
> If you don't want to see all the unused sites, you can filter them in
> the userspace. I also suspect that for practical purposes you would
> want to filter small ones (below some threshold) as well.

Yeah, that's the expected way from us as well :)

> 
>>
>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>> ---
>>   lib/alloc_tag.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
>> index 35f7560a309a..06fb7eb5c0bc 100644
>> --- a/lib/alloc_tag.c
>> +++ b/lib/alloc_tag.c
>> @@ -95,10 +95,12 @@ static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
>>          struct alloc_tag_counters counter = alloc_tag_read(tag);
>>          s64 bytes = counter.bytes;
>>
>> -       seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
>> -       codetag_to_text(out, ct);
>> -       seq_buf_putc(out, ' ');
>> -       seq_buf_putc(out, '\n');
>> +       if (bytes || counter.calls) {
>> +               seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
>> +               codetag_to_text(out, ct);
>> +               seq_buf_putc(out, ' ');
>> +               seq_buf_putc(out, '\n');
>> +       }
>>   }
>>
>>   static int allocinfo_show(struct seq_file *m, void *arg)
>> --
>> 2.25.1
>>


