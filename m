Return-Path: <linux-kernel+bounces-220937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A73090E961
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666BD1C23220
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4216013C8EA;
	Wed, 19 Jun 2024 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="f38Jovt6"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9058A13A3E7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796358; cv=none; b=TZcouHtComh8/dq1iFiJ1rSdnKi8FPqYiE6DsQH7HU+0TOlStuOKQGCnWDzUGRJ+dB9m/HmZkq8cylgXB2zpkUTJqWG39a/RXsuC1VE3cL9RqcO51CWcUO0U3bZR7rflLMX2iR4PS3lemPNhxoX+zuBhuZn+qZhWWudCW0HuR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796358; c=relaxed/simple;
	bh=zMNJY4JjcBq/I5iScuiawuQ46bXABJDkunpWXhzv/hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCxWzoICeX79uWC6GJLh1NDN3K3a1+/WjWaYC7UVmVd9pi36cg6CzcONP23IiD4SwjbAwWWFPLoBj+85QKlzMmEZrlobXt9J6e4LoCHBi5qqccSuJPDBDm4UTGG5Oafs8BM+PIgbJJ1p6YDPNoNiOqILlWrSjVMrD5i8cG4aKXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=f38Jovt6; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=aG/vx2BDuqsQqUPEZ8hVa2/sJkJ0MxkksOjRduMcktM=;
	b=f38Jovt6Dpp8AVGlqTbgw8GZKwlmaxEh7S5+mn9SNzcECo/fNZP3gZBGijWeeU
	8YkmwQeFsYnHRe8L1ym0wEz7+KQuO7GuxiXWJhD1Pr5YLWm/EE70ha+sYNKmrVR6
	qrMP6czA06SLFSTrVChrA3OeislhDyl5Tzk8RFDvKpnwg=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wCHv9VgvHJmqdiPBA--.21500S2;
	Wed, 19 Jun 2024 19:09:21 +0800 (CST)
Message-ID: <86e39cc3-cae9-485a-9854-c998fb906cc2@126.com>
Date: Wed, 19 Jun 2024 19:09:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: add one PCP list for THP
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
 liuzixing@hygon.cn, Mel Gorman <mgorman@techsingularity.net>
References: <1718790499-28151-1-git-send-email-yangge1116@126.com>
 <CAGsJ_4zAg_Ui3uNUz6rwRPeERo6PskthGUB2V=4Yr+c+AU8iqA@mail.gmail.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <CAGsJ_4zAg_Ui3uNUz6rwRPeERo6PskthGUB2V=4Yr+c+AU8iqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHv9VgvHJmqdiPBA--.21500S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArW3Kr1rGrW5KrWkKw4Durg_yoWrury3pF
	WxJF4YvayjqryUCw1xJwn0krna93sxGFn7Cr1I9348ZrsxXFyS9a47KFnF9FykZrW7Cr1x
	Xryqq3sxuF4qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRTrW7UUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWQYDG2VLa09vDwAAst



在 2024/6/19 18:13, Barry Song 写道:
> +Mel, the original author of commit 5d0a661d808f
> ('mm/page_alloc: use only one PCP list..."
> 
> 
> On Wed, Jun 19, 2024 at 9:48 PM <yangge1116@126.com> wrote:
>>
>> From: yangge <yangge1116@126.com>
>>
>> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
>> THP-sized allocations") no longer differentiates the migration type
>> of pages in THP-sized PCP list, it's possible that non-movable
>> allocation requests may get a CMA page from the list, in some cases,
>> it's not acceptable.
>>
>> If a large number of CMA memory are configured in system (for
>> example, the CMA memory accounts for 50% of the system memory),
>> starting a virtual machine with device passthrough will get stuck.
>> During starting the virtual machine, it will call
>> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to pin memory. Normally
>> if a page is present and in CMA area, pin_user_pages_remote() will
>> migrate the page from CMA area to non-CMA area because of
>> FOLL_LONGTERM flag. But if non-movable allocation requests return
>> CMA memory, migrate_longterm_unpinnable_pages() will migrate a CMA
>> page to another CMA page, which will fail to pass the check in
>> check_and_migrate_movable_pages() and cause migration endless.
>> Call trace:
>> pin_user_pages_remote
>> --__gup_longterm_locked // endless loops in this function
>> ----_get_user_pages_locked
>> ----check_and_migrate_movable_pages
>> ------migrate_longterm_unpinnable_pages
>> --------alloc_migration_target
>>
> 
> Please also describe its potential negative impact to cma_alloc().
> 
>> To fix the problem above, we add one PCP list for THP, which will
>> not introduce a new cacheline. THP will have 2 PCP lists, one PCP
> 
> not introduce a new cacheline for struct per_cpu_pages.
> 
>> list is used by MOVABLE allocation, and the other PCP list is used
>> by UNMOVABLE allocation. MOVABLE allocation contains GPF_MOVABLE,
>> and UNMOVABLE allocation contains GFP_UNMOVABLE and GFP_RECLAIMABLE.
>>
>> Link: https://lore.kernel.org/all/1717492460-19457-1-git-send-email-yangge1116@126.com/
> 
> no this tag.
> 
>> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for THP-sized allocations")
> 
> Cc: <stable@vger.kernel.org> ?
> 

Thanks, I will prepare the next version.

>> Signed-off-by: yangge <yangge1116@126.com>
>> ---
>>   include/linux/mmzone.h | 9 ++++-----
>>   mm/page_alloc.c        | 9 +++++++--
>>   2 files changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index b7546dd..cb7f265 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -656,13 +656,12 @@ enum zone_watermarks {
>>   };
>>
>>   /*
>> - * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. One additional list
>> - * for THP which will usually be GFP_MOVABLE. Even if it is another type,
>> - * it should not contribute to serious fragmentation causing THP allocation
>> - * failures.
>> + * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. Two additional lists
>> + * are added for THP. One PCP list is used by GPF_MOVABLE, and the other PCP list
>> + * is used by GFP_UNMOVABLE and GFP_RECLAIMABLE.
>>    */
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -#define NR_PCP_THP 1
>> +#define NR_PCP_THP 2
>>   #else
>>   #define NR_PCP_THP 0
>>   #endif
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 8f416a0..0ecbde3 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -504,10 +504,15 @@ static void bad_page(struct page *page, const char *reason)
>>
>>   static inline unsigned int order_to_pindex(int migratetype, int order)
>>   {
>> +       bool __maybe_unused movable;
>> +
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>          if (order > PAGE_ALLOC_COSTLY_ORDER) {
>>                  VM_BUG_ON(order != HPAGE_PMD_ORDER);
>> -               return NR_LOWORDER_PCP_LISTS;
>> +
>> +               movable = migratetype == MIGRATE_MOVABLE;
>> +
>> +               return NR_LOWORDER_PCP_LISTS + movable;
>>          }
>>   #else
>>          VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
>> @@ -521,7 +526,7 @@ static inline int pindex_to_order(unsigned int pindex)
>>          int order = pindex / MIGRATE_PCPTYPES;
>>
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -       if (pindex == NR_LOWORDER_PCP_LISTS)
>> +       if (order > PAGE_ALLOC_COSTLY_ORDER)
> 
> pindex >= NR_LOWORDER_PCP_LISTS
> 
>>                  order = HPAGE_PMD_ORDER;
>>   #else
>>          VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
>> --
>> 2.7.4
>>
> 
> Thanks
> Barry


