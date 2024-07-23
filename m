Return-Path: <linux-kernel+bounces-259571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4526493989E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8ED1C21997
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 03:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9E113B7A6;
	Tue, 23 Jul 2024 03:24:32 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659908814
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721705071; cv=none; b=s84LIsEagg70ZaxvHUWi5BiSFTlGIefIo5jFTbFzQQbG/j1tNvsw8HQnjvgcwM6oPCFAjPKdQJtGV2TffItiQr2BrRi1eJKqsvQ9obHoSBhoKWHseToSWc5XIV6YTJSe3oyUNkLdMZcmsOndnzaCS7fAa7u6zBUaT0LNeO4CVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721705071; c=relaxed/simple;
	bh=pFbZu7g5LK4uzJKW80QH1xzfsjytBNX9LPtMxhmJ5xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YUnZV6MLbNt+uMTPvUYXVxjEcS7STItZnjI7kLtKPdcYzQO77n+yxcOvpmnCoHIlGBm0KyixZ+q8zG08ir8N5Kq0H0cgV273H2KmHg+h0cJqmMoOeFfRHMYDTKj1nzwUIZlYl33Tc1Tx+m0c9o8N9shLi9LJ9nPdL6NmBDxR0AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WSj7h2QvBz1X4fJ;
	Tue, 23 Jul 2024 11:20:00 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 62D14180028;
	Tue, 23 Jul 2024 11:24:24 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Jul 2024 11:24:23 +0800
Message-ID: <d31b0226-6013-4152-af4b-1526146eb179@huawei.com>
Date: Tue, 23 Jul 2024 11:24:23 +0800
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
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
CC: David Hildenbrand <david@redhat.com>, "Huang, Ying"
	<ying.huang@intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	<linux-kernel@vger.kernel.org>
References: <20240722172917.503370-1-ziy@nvidia.com>
 <20240722172917.503370-3-ziy@nvidia.com>
 <5230d72e-81fa-4ef1-b386-90bd3b06bf0e@huawei.com>
 <D2WJLRHB9T9S.DRAUA25VKCBP@nvidia.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <D2WJLRHB9T9S.DRAUA25VKCBP@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/7/23 9:54, Zi Yan wrote:
> On Mon Jul 22, 2024 at 9:48 PM EDT, Kefeng Wang wrote:
>>
>>
>> On 2024/7/23 1:29, Zi Yan wrote:
>>> memory tiering can be enabled/disabled at runtime and
>>> sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING is used to check
>>> it. In migrate_misplaced_folio(), the check is missing when
>>> PGPROMOTE_SUCCESS is incremented. Add the missing check.
>>>
>>> Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> Closes: https://lore.kernel.org/linux-mm/f4ae2c9c-fe40-4807-bdb2-64cf2d716c1a@huawei.com/
>>> Fixes: 33024536bafd ("memory tiering: hot page selection with hint page fault latency")
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>
>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>
> Thanks.
> 
>>> ---
>>>    mm/migrate.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index bdbb5bb04c91..b819809da470 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -2630,7 +2630,9 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>>>    		putback_movable_pages(&migratepages);
>>>    	if (nr_succeeded) {
>>>    		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
>>> -		if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))
>>> +		if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
>>> +		    && !node_is_toptier(folio_nid(folio))
>>> +		    && node_is_toptier(node))
>>>    			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
>>>    					    nr_succeeded);
>>
>> The should be in advance of patch2, and change above to use
>> folio_has_cpupid() helper() too.
> 
> It shares the same logic of !folio_has_cpupid() but it might be confusing to
> put !folio_has_cpupid(folio) && node_is_toptier(node) here. folio's
> cpupid has nothing to do with the stats here, thus I did not use the
> function.

If folio don't include access time, we do migrate it but it isn't a 
promotion, so don't count it, other comments?

PS: Could we rename folio_has_cpupid() to folio_has_access_time(), even 
without memory_tiering, we still have cpupid in folio, right?
> 

