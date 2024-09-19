Return-Path: <linux-kernel+bounces-333051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6038497C2CB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805D41C21529
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1423D1E89C;
	Thu, 19 Sep 2024 02:13:25 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42251CF8B
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726712004; cv=none; b=D5cnyyC/WDjVr/bfH0W8VhvtytvDpzbi2+ozlwvPI94JJO0VJC/9judexC1XAXvqqUCLSgLRSeuISKqADvEDzp/tO6g1WqM2Sr5BnnJK1Sn185isLC62+Yt274xwf+Nuai+0QkkE4EvKFmrL25bXAqNyH9uKIuK6iFRYKcoCRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726712004; c=relaxed/simple;
	bh=aflcISZtg3Xf5cBYYJsxcBTaNvMTvcjqMwcHBAJuvck=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HZXbQh4SCCQFA/GKukxTL8wUYzKKdMTfHanE5be+uzvg7qyIuF+zVGaAHViDk2YfDPkFAPFG4KpT8gY80uOEeQfgiFjz2YlVpsPYgCtM5RwIjnzJ6xIhWNCd/KbgJhTyUHQcvv7BIwVl3U3/JrUMaDUOBvpqI/i0z2inU0BDogY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X8Jvh4vnVz20nwP;
	Thu, 19 Sep 2024 10:13:04 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 09FB21401E9;
	Thu, 19 Sep 2024 10:13:19 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Sep 2024 10:13:18 +0800
Subject: Re: [PATCH] mm/huge_memory: ensure huge_zero_folio won't have
 large_rmappable flag set
To: David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
	<willy@infradead.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240914015306.3656791-1-linmiaohe@huawei.com>
 <2875de57-6e11-4cfe-a0a6-36879ca96091@redhat.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5d817637-00b3-dd0a-4d3c-cf550fcff440@huawei.com>
Date: Thu, 19 Sep 2024 10:13:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2875de57-6e11-4cfe-a0a6-36879ca96091@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/9/17 19:59, David Hildenbrand wrote:
> On 14.09.24 03:53, Miaohe Lin wrote:
>> Ensure huge_zero_folio won't have large_rmappable flag set. So it can be
>> reported as thp,zero correctly through stable_page_flags().
>>
>> Fixes: 5691753d73a2 ("mm: convert huge_zero_page to huge_zero_folio")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>> ---
>>   mm/huge_memory.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 2a73efea02d7..4e34b7f89daf 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -218,6 +218,8 @@ static bool get_huge_zero_page(void)
>>           count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
>>           return false;
>>       }
>> +    /* Ensure zero folio won't have large_rmappable flag set. */
>> +    folio_clear_large_rmappable(zero_folio);
>>       preempt_disable();
>>       if (cmpxchg(&huge_zero_folio, NULL, zero_folio)) {
>>           preempt_enable();
> 
> Doesn't that rather fix
> 
> commit 4c8763e84aae4d04d94b35aca9f7db6a8930ad77
> Author: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Date:   Fri Jul 5 10:43:43 2024 +0000
> 
>     kpageflags: detect isolated KPF_THP folios
> 
> 
> ?
> 
> We could fix it simply by changing the order of checks in there.

Sure, we can fix it like above but huge zero folio shouldn't have large_rmappable flag set anyway.

> 
> It makes sense, though. The huge zeropage is not tracked via the rmap ... ever. Mapcounts etc are unused. But clearing that flag is just ugly.
> 
> I wonder if the real problem lies in using folio_alloc() here, and that we should be never setting the flag in the first place .... Yes, we want a folio, but not really an rmappable one.

There was a similar problem. Hugetlb folio has large_rmappable flag set through using folio_alloc. And that cause kernel panic when migrating hugetlb folio.

Please see commit 1390a3334a48 ("mm/hugetlb: fix kernel NULL pointer dereference when migrating hugetlb folio").

Thanks.
.

> 
> ... Willy, what would be your take?
> 


