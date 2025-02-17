Return-Path: <linux-kernel+bounces-517401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 253BDA38046
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03BB47A2588
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E662215F68;
	Mon, 17 Feb 2025 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gu9z0zao"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F3155321
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788489; cv=none; b=G9x8K+BmyoDa+yo0KeFP88M7H9Mo8CMAPj6Uwai/WxxYoJVj/U8HanMN/Kn/dFUVojRraAcu4vyVfETMLtmnZK4Dr9RsF2ujIhi7NSBt/U49JjsvMl/w3RGMEr9HUe/GXRZoEhrDDjXLRTnx/BIOaS6LM1XsWgHbruFKnGqoaLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788489; c=relaxed/simple;
	bh=b5QQRnYVSAkR2gluU8sVN2rGpkjWzxnVKnGetCMJnPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qtuSpvFOJZEp7xe17OiAFEcMmfPMi1zOeC9ZK3aJvbzEWrYl6m3E7xsnHXQfMKmMjcGww/Gbo2xtlpo9afJ1tWrHSKvIpC8t0JgzMUko8dnDBeuoYSfotPiSehBR3uv981gdg9tD+/oVFMN81G6UJthryvkLxSfNw9fWn7GWTk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gu9z0zao; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H03RS2027346;
	Mon, 17 Feb 2025 10:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zEF/t1yOI2x4Lz67WwMMmiTHnzEvQPEcnkfnDYR7dWk=; b=gu9z0zaoxsOYLrS5
	2CvVceT25iEGKFC5fjfdDxDyjp8phH6Fwb1kAAvBn0LEl3j2OqorvVr0JtdxeHYl
	g7hzwlS8TJXpccP+O4enNvFTEpAx90IqkcvxqcCiPGCwcyArreJ6AzEU0rVy0nGn
	J87/Rs0Ku6bD25nKWUrm+9RF/M284BQjnTWxgLKN2Ms8vyzZvW+4kbJC3/JhEaXj
	1dcpsv6nvZZ1O5SQAZc0hqHDvQvyMFNPax5fkA/0Felh1//l4bdJ2hRw0RD+6vDN
	OavnTJqJwtLoF3EoElPlSkuDfk8Mac318hwqXmlKxDKtB0ADzjoLxE3Av9k0hEq/
	0lSy7A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7shce8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 10:34:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51HAYMuD002859
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 10:34:22 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Feb
 2025 02:34:18 -0800
Message-ID: <ce2bd045-3e3a-42bf-9a48-9ad806ff3765@quicinc.com>
Date: Mon, 17 Feb 2025 18:34:16 +0800
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
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <8c1578ed-cfef-4fba-a334-ebf5eac26d60@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y2LJ5ii9FP1h9mkiK860PuGsQdhLpovy
X-Proofpoint-ORIG-GUID: y2LJ5ii9FP1h9mkiK860PuGsQdhLpovy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502170093



On 2025/2/17 17:44, David Hildenbrand wrote:
> On 17.02.25 10:29, Zhenhua Huang wrote:
>> On the arm64 platform with 4K base page config, SECTION_SIZE_BITS is set
>> to 27, making one section 128M. The related page struct which vmemmap
>> points to is 2M then.
>> Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
>> vmemmap to populate at the PMD section level which was suitable
>> initially since hot plug granule is always one section(128M). However,
>> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> introduced a 2M(SUBSECTION_SIZE) hot plug granule, which disrupted the
>> existing arm64 assumptions.
>>
>> The first problem is that if start or end is not aligned to a section
>> boundary, such as when a subsection is hot added, populating the entire
>> section is wasteful.
>>
>> The Next problem is if we hotplug something that spans part of 128 MiB
>> section (subsections, let's call it memblock1), and then hotplug 
>> something
>> that spans another part of a 128 MiB section(subsections, let's call it
>> memblock2), and subsequently unplug memblock1, vmemmap_free() will clear
>> the entire PMD entry which also supports memblock2 even though memblock2
>> is still active.
>>
>> Assuming hotplug/unplug sizes are guaranteed to be symmetric. Do the
>> fix similar to x86-64: populate to pages levels if start/end is not 
>> aligned
>> with section boundary.
>>
>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>> ---
>>   arch/arm64/mm/mmu.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index b4df5bc5b1b8..eec1666da368 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1178,7 +1178,8 @@ int __meminit vmemmap_populate(unsigned long 
>> start, unsigned long end, int node,
>>   {
>>       WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
>> -    if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
>> +    if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) ||
>> +        (end - start < PAGES_PER_SECTION * sizeof(struct page)))
>>           return vmemmap_populate_basepages(start, end, node, altmap);
>>       else
>>           return vmemmap_populate_hugepages(start, end, node, altmap);
> 
> Yes, this does mimic what x86 does. That handling does look weird, 
> because it
> doesn't care about any address alignments, only about the size, which is 
> odd.
> 
> I wonder if we could do better and move this handling
> into vmemmap_populate_hugepages(), where we already have a fallback
> to vmemmap_populate_basepages().

Hi David,

I had the same doubt initially.
After going through the codes, I noticed for vmemmap_populate(), the 
arguments "start" and "end" passed down should already be within one 
section.
early path:
for_each_present_section_nr
	__populate_section_memmap
		..
		vmemmap_populate()

hotplug path:
__add_pages
	section_activate
		vmemmap_populate()

Therefore.. focusing only on the size seems OK to me, and fall back 
solution below appears unnecessary?

BTW, I have few more doubt about the original codes below, but they're 
not bugs, so I have not raised them. Please correct me if it's incorrect.

> 
> Something like:
> 
> One thing that confuses me is the "altmap" handling in x86-64 code: in 
> particular
> why it is ignored in some cases. So that might need a bit of thought / 
> double-checking.
> 
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 01ea7c6df3036..57542313c0000 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1546,10 +1546,10 @@ int __meminit vmemmap_populate(unsigned long 
> start, unsigned long end, int node,
>          VM_BUG_ON(!PAGE_ALIGNED(start));
>          VM_BUG_ON(!PAGE_ALIGNED(end));
> 
> -       if (end - start < PAGES_PER_SECTION * sizeof(struct page))
> -               err = vmemmap_populate_basepages(start, end, node, NULL);
> -       else if (boot_cpu_has(X86_FEATURE_PSE))
> +       if (boot_cpu_has(X86_FEATURE_PSE))
>                  err = vmemmap_populate_hugepages(start, end, node, 
> altmap);
> +       else
> +               err = vmemmap_populate_basepages(start, end, node, NULL);
>          else if (altmap) {
>                  pr_err_once("%s: no cpu support for altmap allocations\n",
>                                  __func__);
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 3287ebadd167d..8b217265b25b1 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -300,6 +300,10 @@ int __weak __meminit vmemmap_check_pmd(pmd_t *pmd, 
> int node,
>          return 0;
>   }
> 
> +/*
> + * Try to populate PMDs, but fallback to populating base pages when ranges
> + * would only partially cover a PMD.
> + */
>   int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned 
> long end,
>                                           int node, struct vmem_altmap 
> *altmap)
>   {
> @@ -313,6 +317,9 @@ int __meminit vmemmap_populate_hugepages(unsigned 
> long start, unsigned long end,
>          for (addr = start; addr < end; addr = next) {

This for loop appears to be redundant for arm64 as well, as above 
mentioned, a single call to pmd_addr_end() should suffice.

>                  next = pmd_addr_end(addr, end);
> 
> +               if (!IS_ALIGNED(addr, PMD_SIZE) || !IS_ALIGNED(next, 
> PMD_SIZE))
> +                       goto fallback;
> +
>                  pgd = vmemmap_pgd_populate(addr, node);
>                  if (!pgd)
>                          return -ENOMEM;
> @@ -346,6 +353,7 @@ int __meminit vmemmap_populate_hugepages(unsigned 
> long start, unsigned long end,
>                          }
>                  } else if (vmemmap_check_pmd(pmd, node, addr, next))
>                          continue;
> +fallback:
>                  if (vmemmap_populate_basepages(addr, next, node, altmap))
>                          return -ENOMEM;

It seems we have no chance to call populate_basepages here?

>          }
> 
> 


