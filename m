Return-Path: <linux-kernel+bounces-260527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A11093AA8F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1331F229D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1DC6125;
	Wed, 24 Jul 2024 01:22:57 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4BB79F0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721784177; cv=none; b=AcERFPbA2vmPD4WNuVVOd4kh6aO+CLsFGD7IDFodTB18frSr9cnCZ3Nwo7gsRWbSlb+Jn+55kAlVXCvetRhJrWnaiouvpPHG1jPQlVuyBTlQQF69eGodN096PE47MzWaQEw46a839e+aia0+onkOOCUxgcxBFea0JWQPzJgJ59A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721784177; c=relaxed/simple;
	bh=XKPNagy2RNGD56dkX2nV1zvKCM2jX1EVYuxZCU/yd64=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XfMPqLwa02cnFNDc1bKo6u/WoVDoY5cHhUu1qizb+qWFiCkNYeCDzl/5bnp4E4kqkjDjfCcChZPcpyVioNtFoIfwiglx8X9fv5gDBu2NM8a3nTKwrhq+OVkz9v9FJ5YWpm/OXHOMn0Kyufo5JF8OSf1wtaj16hjGyyL7fkdPPj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WTGPF3V5vzQms7;
	Wed, 24 Jul 2024 09:18:41 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 472D31800A2;
	Wed, 24 Jul 2024 09:22:52 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Jul 2024 09:22:51 +0800
Message-ID: <661e85d3-e2ce-4238-8c3b-077b8980a822@huawei.com>
Date: Wed, 24 Jul 2024 09:22:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] memory tiering: count PGPROMOTE_SUCCESS when mem
 tiering is enabled.
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: "Huang, Ying" <ying.huang@intel.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, <linux-kernel@vger.kernel.org>
References: <20240722172917.503370-1-ziy@nvidia.com>
 <20240722172917.503370-3-ziy@nvidia.com>
 <5230d72e-81fa-4ef1-b386-90bd3b06bf0e@huawei.com>
 <D2WJLRHB9T9S.DRAUA25VKCBP@nvidia.com>
 <d31b0226-6013-4152-af4b-1526146eb179@huawei.com>
 <1621fcbd-38b5-46a8-8b68-911f2920d52e@redhat.com>
 <D2WXTV2186EV.2OTDTPCJSNVN1@nvidia.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <D2WXTV2186EV.2OTDTPCJSNVN1@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/7/23 21:03, Zi Yan wrote:
> On Tue Jul 23, 2024 at 6:17 AM EDT, David Hildenbrand wrote:
>> On 23.07.24 05:24, Kefeng Wang wrote:
>>>
>>>
>>> On 2024/7/23 9:54, Zi Yan wrote:
>>>> On Mon Jul 22, 2024 at 9:48 PM EDT, Kefeng Wang wrote:
>>>>>
>>>>>
>>>>> On 2024/7/23 1:29, Zi Yan wrote:
>>>>>> memory tiering can be enabled/disabled at runtime and
>>>>>> sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING is used to check
>>>>>> it. In migrate_misplaced_folio(), the check is missing when
>>>>>> PGPROMOTE_SUCCESS is incremented. Add the missing check.
>>>>>>
>>>>>> Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>> Closes: https://lore.kernel.org/linux-mm/f4ae2c9c-fe40-4807-bdb2-64cf2d716c1a@huawei.com/
>>>>>> Fixes: 33024536bafd ("memory tiering: hot page selection with hint page fault latency")
>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>
>>>>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>
>>>> Thanks.
>>>>
>>>>>> ---
>>>>>>      mm/migrate.c | 4 +++-
>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>> index bdbb5bb04c91..b819809da470 100644
>>>>>> --- a/mm/migrate.c
>>>>>> +++ b/mm/migrate.c
>>>>>> @@ -2630,7 +2630,9 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>>>>>>      		putback_movable_pages(&migratepages);
>>>>>>      	if (nr_succeeded) {
>>>>>>      		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
>>>>>> -		if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))
>>>>>> +		if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
>>>>>> +		    && !node_is_toptier(folio_nid(folio))
>>>>>> +		    && node_is_toptier(node))
>>>>>>      			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
>>>>>>      					    nr_succeeded);
>>>>>
>>>>> The should be in advance of patch2, and change above to use
>>>>> folio_has_cpupid() helper() too.
>>>>
>>>> It shares the same logic of !folio_has_cpupid() but it might be confusing to
>>>> put !folio_has_cpupid(folio) && node_is_toptier(node) here. folio's
>>>> cpupid has nothing to do with the stats here, thus I did not use the
>>>> function.
>>>
>>> If folio don't include access time, we do migrate it but it isn't a
>>> promotion, so don't count it, other comments?
>>>
>>> PS: Could we rename folio_has_cpupid() to folio_has_access_time(), even
>>> without memory_tiering, we still have cpupid in folio, right?
> 
> folio_has_access_time() would be the opposite of folio_has_cpupid().
> If memory tiering is off (either at compile time or dynamically), a
> folio has cpupid all the time.
> 
>>
>> Maybe call it "folio_use_cpupid()" or sth like that? The "has" is a bit
>> misleading, because the folio has a cpuid in any case, no?
> 
> The folio's cpupid field is reused to record page access time, when the folio
> is !node_is_toptier() and memory tiering mode is on.
> 
> In sum, using folio_use_access_time() as !folio_has_cpupid() seems
> better to me, since it covers the special use of folio's cpupid field.
> 

It sounds good, thanks.

> Let me know your thoughts.
> 

