Return-Path: <linux-kernel+bounces-394310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E919BAD3B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3E61C20E11
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0C719882C;
	Mon,  4 Nov 2024 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B0RkwPn3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A0A15B97D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730705769; cv=none; b=XvOqLeS3bnukoooISuoKqy5C5watrE+GBy3sndY+SFbV0ifI53PwnFiUePkPKSU8+UM2jhluks/irU71YQX8GqipXjZndTRL4WcguL4xE3Iw08/IJrQ/BgruUpxySe+JJiYv31Qz70nVeiBTeQ56CQezAYCiQItRWEBSW/6sFyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730705769; c=relaxed/simple;
	bh=LzABZ8X9UjJKgOYlIVONXsFu/JM3curKyaE5d/s+zfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mG2MZqcKfYL9PhsR4c0n5oob2EEAsN9jQgjpr3Y1tKj0U+NHEEDmh11JVFWdDwHpIU2A2p9ii5nYFfy7PjsLNYTJdaaSzM4BbxYxqH0ekM5K+w9VUrtzh/5sjlQ2IYAuFAj9h5N3yFhbWnJ20xeFgpps3wi5KwPamo6iaZa7zHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B0RkwPn3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3NDUPP004484;
	Mon, 4 Nov 2024 07:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v3l5DdxxAOARiur4tbayDd2e4oDk6ZXK0d4TJzUv5ms=; b=B0RkwPn3JpN4Qn/Z
	Q7QKui1NnPmlv7NN1wsd2GTETpBudNlwDq91CdjZLxJ7tr2nUuzMuqQbFNyaM2dW
	2hoyRs4ChYIVHqzaCd4BVcy0jv3hZPZMbkrmJf92ES9N3GUc1gXHsQ4luEXg4vNG
	duqNwOwAauVNiHvVELe7VjLUT1CIbFxZ9pIUxz/r0BGW7B0FbTG6VN0pFB3VqQ6K
	DHyrkEOu6vq5/T+KReGnbanK3vdF64hKEzQSRCFBzYMKWYhmPwE88wtQqRzYr36K
	vzYMxxwceqV6tV7R/wBwhClTkFsIIdMjNCluXDIi12bZTLjY+qQ8cd8q/Y97bLzb
	UUHPPg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ncyxud6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 07:35:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A47ZgbR005164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 07:35:42 GMT
Received: from [10.232.65.248] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 3 Nov 2024
 23:35:40 -0800
Message-ID: <55f6332d-3b4c-4478-93f9-514a906e348d@quicinc.com>
Date: Mon, 4 Nov 2024 15:35:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] trace/events/page_ref: add page info to page_ref trace
 event
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, <akpm@linux-foundation.org>
CC: <minchan@kernel.org>, <vbabka@suse.cz>, <iamjoonsoo.kim@lge.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox
	<willy@infradead.org>
References: <20241031024222.505844-1-quic_yingangl@quicinc.com>
 <8418b91e-04bb-4b74-96dd-a9489fbf9ba6@kernel.org>
Content-Language: en-US
From: Kassey Li quic <quic_yingangl@quicinc.com>
In-Reply-To: <8418b91e-04bb-4b74-96dd-a9489fbf9ba6@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: q-RO3xvf1_qIewPAKvoIOf2H6y-5coX9
X-Proofpoint-GUID: q-RO3xvf1_qIewPAKvoIOf2H6y-5coX9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040066


On 2024/10/31 15:24, Vlastimil Babka (SUSE) wrote:
> On 10/31/24 03:42, Kassey Li wrote:
>> This followed
>> commit 53d884a6675b ("mm, tracing: unify PFN format strings")
>> to add page info.
>>
>> In many kernel code we are talking with page other than pfn,
>> here we added page algin with pfn.
> How exactly would this help you, what are you doing with the trace?

we met some problem where filesystem held the page.

we can show the page pointer other than pfn in filesystem code.

>
>> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
>> ---
>>   include/trace/events/page_ref.h | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
>> index fe33a255b7d0..76df13b2a5b3 100644
>> --- a/include/trace/events/page_ref.h
>> +++ b/include/trace/events/page_ref.h
>> @@ -18,6 +18,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
>>   
>>   	TP_STRUCT__entry(
>>   		__field(unsigned long, pfn)
>> +		__field(const struct page *, page)
>>   		__field(unsigned long, flags)
>>   		__field(int, count)
>>   		__field(int, mapcount)
>> @@ -28,6 +29,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
>>   
>>   	TP_fast_assign(
>>   		__entry->pfn = page_to_pfn(page);
> pfn is derived from the page, but not subject to KASLR, so in that sense is
> better.
> If you need to correlate the trace with some other data you obtained that
> does contains page pointers, you will have to postprocess the trace with a
> pfn_to_page() step, which is rather simple (but you'll need to obtain and
> supply the randomized base) or have that other data source give you pfn too.
>
> The tracepoints should not reveal the randomized base as trivially as they
> would do after this patch.

ok, thanks for the suggest, I think generally we can try to handle the 
debug code in our local only.

>
>> +		__entry->page = page;
>>   		__entry->flags = page->flags;
>>   		__entry->count = page_ref_count(page);
>>   		__entry->mapcount = atomic_read(&page->_mapcount);
>> @@ -36,8 +38,9 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
>>   		__entry->val = v;
>>   	),
>>   
>> -	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
>> +	TP_printk("pfn=0x%lx page=%p flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
>>   		__entry->pfn,
>> +		__entry->page,
>>   		show_page_flags(__entry->flags & PAGEFLAGS_MASK),
>>   		__entry->count,
>>   		__entry->mapcount, __entry->mapping, __entry->mt,
>> @@ -66,6 +69,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
>>   
>>   	TP_STRUCT__entry(
>>   		__field(unsigned long, pfn)
>> +		__field(const struct page *, page)
>>   		__field(unsigned long, flags)
>>   		__field(int, count)
>>   		__field(int, mapcount)
>> @@ -77,6 +81,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
>>   
>>   	TP_fast_assign(
>>   		__entry->pfn = page_to_pfn(page);
>> +		__entry->page = page;
>>   		__entry->flags = page->flags;
>>   		__entry->count = page_ref_count(page);
>>   		__entry->mapcount = atomic_read(&page->_mapcount);
>> @@ -86,8 +91,9 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
>>   		__entry->ret = ret;
>>   	),
>>   
>> -	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d ret=%d",
>> +	TP_printk("pfn=0x%lx page=%p flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d ret=%d",
>>   		__entry->pfn,
>> +		__entry->page,
>>   		show_page_flags(__entry->flags & PAGEFLAGS_MASK),
>>   		__entry->count,
>>   		__entry->mapcount, __entry->mapping, __entry->mt,

