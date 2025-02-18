Return-Path: <linux-kernel+bounces-518577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F082CA3911D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 04:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED5D7A2906
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 03:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADAE15667D;
	Tue, 18 Feb 2025 03:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BqDYxcUh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662DD1482E7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 03:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848097; cv=none; b=B03mJUIUn9CSqcNm1NbrS49q2zhkzNQM4WPmSvbgEQfZ+8H7PXmRVkinloBBcp3xfOZ6RrI3YVzVuY0YA92MD/WSuHCGIZJlC4NsKg7jKBeFECNYTKaH67hivB94FYKmXIUhXT9ibuvCm+zjNmj9QzNdtgPKNuxX0TFUqwJUlKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848097; c=relaxed/simple;
	bh=oa0IjU9UTAJ1KPp+r7Rt2Ef0yn+tXBSXpgRYVUvoTtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BfWZvibZK/LUbG37l+xQ95X/z2OCq0MB5I8wdaJ3CZIcSHPFdgd8/En5IdIwxwb42/qG/jfMDiHPUUpWE7wUZzPAcpOrCa5p+DksUgPP7UtbN7MLma+32z9xUY/BAW8yejtjXhofEBYEXBKFWY1H2blSDIruVAyGj3n/CPSMIaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BqDYxcUh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I2xMk8003648;
	Tue, 18 Feb 2025 03:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	shYYV8RRo/e3jDenMP8rmX0RcYFCmW9iJwK2gN92jOQ=; b=BqDYxcUhGRXXD0Ea
	iNLJZwzc/vK+5tSoUsJw1jF4DfvejElryRziGRwb/HlC6Q2C2qtWnIlIHy5oN0/z
	yxKoRuvYEX9bZv774AmVDsHwZR/qs7/3kpgiqdTEcDgZDUT1A7F5tz+6B1TiN+43
	HWentZh54sTsUfUSymTYzshN+0ZFc62zyunLYX4Beht51ps52WJbQkGbQ7/BkMGp
	Vmhvggzz/66SAmBlWghnEK0yGMrS+qFzieRQIRIDuh+8vaOue13Ea+Hlj7YXymKD
	148A2YROZLNTp4263eek7smu9ecsH9zAkGcER51hR+PSGn5wX97u6ccJ5vytkIBT
	pszhhg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44v3mg1wxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 03:07:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51I37eSp018444
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 03:07:40 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Feb
 2025 19:07:36 -0800
Message-ID: <a5439884-551c-4104-9175-f95b0895a489@quicinc.com>
Date: Tue, 18 Feb 2025 11:07:28 +0800
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
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <871c0dae-c419-4ac2-9472-6901aab90dcf@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HAMYsGH-0wqSvpR5iF_z7pyr5kB9jYSr
X-Proofpoint-ORIG-GUID: HAMYsGH-0wqSvpR5iF_z7pyr5kB9jYSr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_09,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180021



On 2025/2/17 22:30, David Hildenbrand wrote:
> On 17.02.25 11:34, Zhenhua Huang wrote:
>>
>>
>> On 2025/2/17 17:44, David Hildenbrand wrote:
>>> On 17.02.25 10:29, Zhenhua Huang wrote:
>>>> On the arm64 platform with 4K base page config, SECTION_SIZE_BITS is 
>>>> set
>>>> to 27, making one section 128M. The related page struct which vmemmap
>>>> points to is 2M then.
>>>> Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
>>>> vmemmap to populate at the PMD section level which was suitable
>>>> initially since hot plug granule is always one section(128M). However,
>>>> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>>>> introduced a 2M(SUBSECTION_SIZE) hot plug granule, which disrupted the
>>>> existing arm64 assumptions.
>>>>
>>>> The first problem is that if start or end is not aligned to a section
>>>> boundary, such as when a subsection is hot added, populating the entire
>>>> section is wasteful.
>>>>
>>>> The Next problem is if we hotplug something that spans part of 128 MiB
>>>> section (subsections, let's call it memblock1), and then hotplug
>>>> something
>>>> that spans another part of a 128 MiB section(subsections, let's call it
>>>> memblock2), and subsequently unplug memblock1, vmemmap_free() will 
>>>> clear
>>>> the entire PMD entry which also supports memblock2 even though 
>>>> memblock2
>>>> is still active.
>>>>
>>>> Assuming hotplug/unplug sizes are guaranteed to be symmetric. Do the
>>>> fix similar to x86-64: populate to pages levels if start/end is not
>>>> aligned
>>>> with section boundary.
>>>>
>>>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>>>> ---
>>>>    arch/arm64/mm/mmu.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index b4df5bc5b1b8..eec1666da368 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -1178,7 +1178,8 @@ int __meminit vmemmap_populate(unsigned long
>>>> start, unsigned long end, int node,
>>>>    {
>>>>        WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
>>>> -    if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
>>>> +    if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) ||
>>>> +        (end - start < PAGES_PER_SECTION * sizeof(struct page)))
>>>>            return vmemmap_populate_basepages(start, end, node, altmap);
>>>>        else
>>>>            return vmemmap_populate_hugepages(start, end, node, altmap);
>>>
>>> Yes, this does mimic what x86 does. That handling does look weird,
>>> because it
>>> doesn't care about any address alignments, only about the size, which is
>>> odd.
>>>
>>> I wonder if we could do better and move this handling
>>> into vmemmap_populate_hugepages(), where we already have a fallback
>>> to vmemmap_populate_basepages().
>>
>> Hi David,
>>
>> I had the same doubt initially.
>> After going through the codes, I noticed for vmemmap_populate(), the
>> arguments "start" and "end" passed down should already be within one
>> section.
>> early path:
>> for_each_present_section_nr
>>     __populate_section_memmap
>>         ..
>>         vmemmap_populate()
>>
>> hotplug path:
>> __add_pages
>>     section_activate
>>         vmemmap_populate()
>>
>> Therefore.. focusing only on the size seems OK to me, and fall back
>> solution below appears unnecessary?
> 
> Ah, in that case it is fine. Might make sense to document/enforce that 
> somehow for the time being ...

Shall I document and WARN_ON if the size exceeds? like:
WARN_ON(end - start > PAGES_PER_SECTION * sizeof(struct page))

Since vmemmap_populate() is implemented per architecture, the change 
should apply for other architectures as well. However I have no setup to 
test it on...
Therefore, May I implement it only for arm64 now ?
Additionally, from previous discussion, the change is worth 
backporting(apologies for missing to CC stable kernel in this version). 
Keeping it for arm64 should simplify for backporting. WDYT?

> 
> 
>>> +/*
>>> + * Try to populate PMDs, but fallback to populating base pages when 
>>> ranges
>>> + * would only partially cover a PMD.
>>> + */
>>>    int __meminit vmemmap_populate_hugepages(unsigned long start, 
>>> unsigned
>>> long end,
>>>                                            int node, struct vmem_altmap
>>> *altmap)
>>>    {
>>> @@ -313,6 +317,9 @@ int __meminit vmemmap_populate_hugepages(unsigned
>>> long start, unsigned long end,
>>>           for (addr = start; addr < end; addr = next) {
>>
>> This for loop appears to be redundant for arm64 as well, as above
>> mentioned, a single call to pmd_addr_end() should suffice.
> 
> Right, that was what was confusing me in the first place.
> 
>>
>>>                   next = pmd_addr_end(addr, end);
>>>
>>> +               if (!IS_ALIGNED(addr, PMD_SIZE) || !IS_ALIGNED(next,
>>> PMD_SIZE))
>>> +                       goto fallback;
>>> +
>>>                   pgd = vmemmap_pgd_populate(addr, node);
>>>                   if (!pgd)
>>>                           return -ENOMEM;
>>> @@ -346,6 +353,7 @@ int __meminit vmemmap_populate_hugepages(unsigned
>>> long start, unsigned long end,
>>>                           }
>>>                   } else if (vmemmap_check_pmd(pmd, node, addr, next))
>>>                           continue;
>>> +fallback:
>>>                   if (vmemmap_populate_basepages(addr, next, node, 
>>> altmap))
>>>                           return -ENOMEM;
>>
>> It seems we have no chance to call populate_basepages here?
> 
> 
> Can you elaborate?

It's invoked within vmemmap_populate_hugepages(), which is called by 
vmemmap_populate(). This implies that we are always performing a whole 
section hotplug?
However, since it's common code used by other architectures like x86, 
RISC-V and LoongArch, it is still necessary to review the code for these 
architectures as well. At the very least, it's not a BUG :)

> 
> 


