Return-Path: <linux-kernel+bounces-541275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2CBA4BAD0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4347C17080B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381211EF0B6;
	Mon,  3 Mar 2025 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ApAYQhp+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19F2EC4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994245; cv=none; b=CigedPfWny1uufa6eVJ8b5/dPsW+VCdG4TRR47ZahJb424OZcC5qMedBuzYtQ2OYY4ZBcTWoD899LImE9MsF02bDi2eARDW6ai3Y5lSXkuyYa/2IdVMV2EFEuYOluTsgXGzcncfuYXE8rOd9SEmtsWay29qQDXffeU34He0yAu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994245; c=relaxed/simple;
	bh=T1FmQ6LIchNam/vh1+twPMasFXg2M6wIlP9IlQFY0Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hBk7er65jyYIW6ux7H8OpiYfLerPhzniToIPBJgI7MOvmD+8KxCbOk9LZdWtYgCVdrdS66u1AoXSLbL4/ylzKSYOUrpmpAkwm5oIXLSPsdl17PFyWJPJe0P4K9XzVkUy/vLW732SFASHmxPwYyMShhen7AoJ+qUKQQ6DJY0iU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ApAYQhp+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52309L9i002169;
	Mon, 3 Mar 2025 09:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r2jFIZdUKx5Dbc3ZCsERsiLP2tPI95deItMdu/Cb6SQ=; b=ApAYQhp+bBNOfR+2
	vDkaPsNp4jGa2/W771Qf0oy2K2APdg/A5NF9z0uEhHzd9O0xqpmJsWCB0/OIrd6Y
	xLBzECAmWMGyMTbHNtoUhaFQS5ZgFFkuLcWU4TAcZu0hKpHsBwo9nEaMbg87C9hz
	6haYxN3PRFBzSEcAR4jI8RBMCLEY9Ke/NjIKJ1O1f+7V9VhpOG2AXmiDVC2xWuhs
	gETA/5iZf7WOcTf5sWes14WNx5Rpaxuch+FFte/i3Xn31MeX4HtJvLBrUnIsHttR
	l4FstB60v1frcIm2QzUpcZkcSi4BZvQgxsX7Far31EQqxD3j+86u6Ui5sGYoPOHR
	obSqcQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t88vf7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 09:30:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5239U9Gp017890
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 09:30:09 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Mar 2025
 01:30:03 -0800
Message-ID: <45076e28-dd70-456f-83b2-7b4d532c455c@quicinc.com>
Date: Mon, 3 Mar 2025 17:29:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] arm64: mm: Populate vmemmap at the page level if not
 section aligned
To: David Hildenbrand <david@redhat.com>, <anshuman.khandual@arm.com>,
        <catalin.marinas@arm.com>
CC: <will@kernel.org>, <ardb@kernel.org>, <ryan.roberts@arm.com>,
        <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_tingweiz@quicinc.com>
References: <20250217092907.3474806-1-quic_zhenhuah@quicinc.com>
 <8c1578ed-cfef-4fba-a334-ebf5eac26d60@redhat.com>
 <ce2bd045-3e3a-42bf-9a48-9ad806ff3765@quicinc.com>
 <871c0dae-c419-4ac2-9472-6901aab90dcf@redhat.com>
 <a5439884-551c-4104-9175-f95b0895a489@quicinc.com>
 <00c82c92-35a0-441c-b5b5-e4a6c8a4a9b7@redhat.com>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <00c82c92-35a0-441c-b5b5-e4a6c8a4a9b7@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jBcZU8ak7qkip-7X9ZyIEw8nwf0ChjlD
X-Proofpoint-GUID: jBcZU8ak7qkip-7X9ZyIEw8nwf0ChjlD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_03,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503030072



On 2025/2/27 1:13, David Hildenbrand wrote:
> Sorry, I somehow missed this mail.
> 

No problem. Thanks for your reply.

>>>> Hi David,
>>>>
>>>> I had the same doubt initially.
>>>> After going through the codes, I noticed for vmemmap_populate(), the
>>>> arguments "start" and "end" passed down should already be within one
>>>> section.
>>>> early path:
>>>> for_each_present_section_nr
>>>>      __populate_section_memmap
>>>>          ..
>>>>          vmemmap_populate()
>>>>
>>>> hotplug path:
>>>> __add_pages
>>>>      section_activate
>>>>          vmemmap_populate()
>>>>
>>>> Therefore.. focusing only on the size seems OK to me, and fall back
>>>> solution below appears unnecessary?
>>>
>>> Ah, in that case it is fine. Might make sense to document/enforce that
>>> somehow for the time being ...
>>
>> Shall I document and WARN_ON if the size exceeds? like:
>> WARN_ON(end - start > PAGES_PER_SECTION * sizeof(struct page))
> 
> Probably WARN_ON_ONCE() along with a comment that we should never exceed 
> a single memory section.

Got it.

> 
>>
>> Since vmemmap_populate() is implemented per architecture, the change
>> should apply for other architectures as well. However I have no setup to
>> test it on...
>> Therefore, May I implement it only for arm64 now ?
> 
> Would work for me; better than no warning.

I made one patch several days ago, could you please help review once? 
https://lore.kernel.org/linux-mm/20250219084001.1272445-1-quic_zhenhuah@quicinc.com/T/
Is there anything else you would suggest besides preferring WARN_ON_ONCE() ?

> 
>> Additionally, from previous discussion, the change is worth
>> backporting(apologies for missing to CC stable kernel in this version).
>> Keeping it for arm64 should simplify for backporting. WDYT?
> 
> Jup. Of course, we could add a generic warning in a separate patch.
> 
>>
>>>
>>>
>>>>> +/*
>>>>> + * Try to populate PMDs, but fallback to populating base pages when
>>>>> ranges
>>>>> + * would only partially cover a PMD.
>>>>> + */
>>>>>     int __meminit vmemmap_populate_hugepages(unsigned long start,
>>>>> unsigned
>>>>> long end,
>>>>>                                             int node, struct 
>>>>> vmem_altmap
>>>>> *altmap)
>>>>>     {
>>>>> @@ -313,6 +317,9 @@ int __meminit vmemmap_populate_hugepages(unsigned
>>>>> long start, unsigned long end,
>>>>>            for (addr = start; addr < end; addr = next) {
>>>>
>>>> This for loop appears to be redundant for arm64 as well, as above
>>>> mentioned, a single call to pmd_addr_end() should suffice.
>>>
>>> Right, that was what was confusing me in the first place.
>>>
>>>>
>>>>>                    next = pmd_addr_end(addr, end);
>>>>>
>>>>> +               if (!IS_ALIGNED(addr, PMD_SIZE) || !IS_ALIGNED(next,
>>>>> PMD_SIZE))
>>>>> +                       goto fallback;
>>>>> +
>>>>>                    pgd = vmemmap_pgd_populate(addr, node);
>>>>>                    if (!pgd)
>>>>>                            return -ENOMEM;
>>>>> @@ -346,6 +353,7 @@ int __meminit vmemmap_populate_hugepages(unsigned
>>>>> long start, unsigned long end,
>>>>>                            }
>>>>>                    } else if (vmemmap_check_pmd(pmd, node, addr, 
>>>>> next))
>>>>>                            continue;
>>>>> +fallback:
>>>>>                    if (vmemmap_populate_basepages(addr, next, node,
>>>>> altmap))
>>>>>                            return -ENOMEM;
>>>>
>>>> It seems we have no chance to call populate_basepages here?
>>>
>>>
>>> Can you elaborate?
>>
>> It's invoked within vmemmap_populate_hugepages(), which is called by
>> vmemmap_populate(). This implies that we are always performing a whole
>> section hotplug?
> 
> Ah, you meant only in the context of this change, yes. I was confused, 
> because there are other reasons why we run into that fallback (failing 
> to allocate a PMD).

I observed that this logic was introduced in 
2045a3b8911b("mm/sparse-vmemmap: generalise 
vmemmap_populate_hugepages()") which moved from arch-dependent 
codes(such as vmemmap_set_pmd() in arch/loongarch/mm/init.c or 
arch/x86/mm/init_64.c) to common arch-independent code(function 
vmemmap_populate_hugepages).

I suspect it might be causing the confusion, as it may not be fully 
compatible with arm64. However, it does not seem to cause any bugs :)

> 


