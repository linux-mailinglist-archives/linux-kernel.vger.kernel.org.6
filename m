Return-Path: <linux-kernel+bounces-174289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1CB8C0C92
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FF8281FC4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B361149DF1;
	Thu,  9 May 2024 08:30:24 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FE73EA72
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715243424; cv=none; b=rOEwMPAaQU2UjR8F3DIdTY6yl9ftfrgAbudwRcIvoXM3yIl/UMGF0yNuaY55tnPubiVseqxK+9PSfvJ6IavOvRYMdURZqqj7XjxJHGDQugXolLuINX8zfe1nIp190uKuwc6QyzVwIZgxl+/v1u7DDmNsGAdpOivFYbtwFx1pOf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715243424; c=relaxed/simple;
	bh=C328mu3ZLLaMoY86QHm4QsC2s9qDJqQwWW5EVTHPZEQ=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WkA7I8S5qVuhdCgzGYbq/joXnSQsbpR+m7n6Ky4vtgxJfD9ko9j38E9NtYmHkUkMrHsy+S34rc9bEK61V7z0H/XZJBrACUD0DmI/rwnAGSbTHFIFfpEucQHoD2eisl1lL1l2e4OpedYjoI2JhNKoETJjVBX79m4zKMr+ZZOcgtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VZlVR4S05z1RDD8;
	Thu,  9 May 2024 16:26:55 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 9962A180032;
	Thu,  9 May 2024 16:30:16 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 16:30:16 +0800
Subject: Re: [PATCH 3/3] mm/memory-failure: send SIGBUS in the event of thp
 split fail
To: Jane Chu <jane.chu@oracle.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-4-jane.chu@oracle.com>
 <038cffc0-e027-b518-460f-40099819c588@huawei.com>
 <c172fa3d-d4a4-4605-8f39-df0536718bd5@oracle.com>
 <b6c1b513-4470-4721-120c-1b1c813b2680@huawei.com>
 <1b4c50b6-2371-4e1b-aef3-d70c32888054@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <30d4d249-e3b1-79d5-3501-0ccb9c529110@huawei.com>
Date: Thu, 9 May 2024 16:30:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1b4c50b6-2371-4e1b-aef3-d70c32888054@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/9 1:45, Jane Chu wrote:
> On 5/8/2024 1:08 AM, Miaohe Lin wrote:
> 
>> On 2024/5/7 4:26, Jane Chu wrote:
>>> On 5/5/2024 12:00 AM, Miaohe Lin wrote:
>>>
>>>> On 2024/5/2 7:24, Jane Chu wrote:
>>>>> When handle hwpoison in a GUP longterm pin'ed thp page,
>>>>> try_to_split_thp_page() will fail. And at this point, there is little else
>>>>> the kernel could do except sending a SIGBUS to the user process, thus
>>>>> give it a chance to recover.
>>>>>
>>>>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>>>> Thanks for your patch. Some comments below.
>>>>
>>>>> ---
>>>>>    mm/memory-failure.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>>    1 file changed, 36 insertions(+)
>>>>>
>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>>> index 7fcf182abb96..67f4d24a98e7 100644
>>>>> --- a/mm/memory-failure.c
>>>>> +++ b/mm/memory-failure.c
>>>>> @@ -2168,6 +2168,37 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>>>>        return rc;
>>>>>    }
>>>>>    +/*
>>>>> + * The calling condition is as such: thp split failed, page might have
>>>>> + * been GUP longterm pinned, not much can be done for recovery.
>>>>> + * But a SIGBUS should be delivered with vaddr provided so that the user
>>>>> + * application has a chance to recover. Also, application processes'
>>>>> + * election for MCE early killed will be honored.
>>>>> + */
>>>>> +static int kill_procs_now(struct page *p, unsigned long pfn, int flags,
>>>>> +            struct page *hpage)
>>>>> +{
>>>>> +    struct folio *folio = page_folio(hpage);
>>>>> +    LIST_HEAD(tokill);
>>>>> +    int res = -EHWPOISON;
>>>>> +
>>>>> +    /* deal with user pages only */
>>>>> +    if (PageReserved(p) || PageSlab(p) || PageTable(p) || PageOffline(p))
>>>>> +        res = -EBUSY;
>>>>> +    if (!(PageLRU(hpage) || PageHuge(p)))
>>>>> +        res = -EBUSY;
>>>> Above checks seems unneeded. We already know it's thp?
>>> Agreed.
>>>
>>> I  lifted these checks from hwpoison_user_mapping() with a hope to make kill_procs_now() more generic,
>>>
>>> such as, potentially replacing kill_accessing_processes() for re-accessing hwpoisoned page.
>>>
>>> But I backed out at last, due to concerns that my tests might not have covered sufficient number of scenarios.
>>>
>>>>> +
>>>>> +    if (res == -EHWPOISON) {
>>>>> +        collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
>>>>> +        kill_procs(&tokill, true, pfn, flags);
>>>>> +    }
>>>>> +
>>>>> +    if (flags & MF_COUNT_INCREASED)
>>>>> +        put_page(p);
>>>> This if block is broken. put_page() has been done when try_to_split_thp_page() fails?
>>> put_page() has not been done if try_to_split_thp_page() fails, and I think it should.
>> In try_to_split_thp_page(), if split_huge_page fails, i.e. ret != 0, put_page() is called. See below:
>>
>> static int try_to_split_thp_page(struct page *page)
>> {
>>     int ret;
>>
>>     lock_page(page);
>>     ret = split_huge_page(page);
>>     unlock_page(page);
>>
>>     if (unlikely(ret))
>>         put_page(page);
>>     ^^^^^^^^^^^^^^^^^^^^^^^
>>     return ret;
>> }
>>
>> Or am I miss something?
> 
> I think you caught a bug in my code, thanks!
> 
> How about moving put_page() outside try_to_split_thp_page() ?

If you want to send SIGBUS in the event of thp split fail, it might be required to do so.
I think kill_procs_now() needs extra thp refcnt to do its work.

> 
>>
>>> I will revise the code so that put_page() is called regardless MF_ACTION_REQUIRED is set or not.
>>>
>>>>> +
>>>> action_result is missing?
>>> Indeed,  action_result() isn't always called, referring to the re-accessing hwpoison scenarios.
>>>
>>> In this case, I think the reason  is that, we just killed the process and there is nothing
>>>
>>> else to do or to report.
>>>
>>>>> +    return res;
>>>>> +}
>>>>> +
>>>>>    /**
>>>>>     * memory_failure - Handle memory failure of a page.
>>>>>     * @pfn: Page Number of the corrupted page
>>>>> @@ -2297,6 +2328,11 @@ int memory_failure(unsigned long pfn, int flags)
>>>>>             */
>>>>>            SetPageHasHWPoisoned(hpage);
>>>>>            if (try_to_split_thp_page(p) < 0) {
>>>> Should hwpoison_filter() be called in this case?
>>> Yes, it should. I will add the hwpoison_filter check.
>>>>> +            if (flags & MF_ACTION_REQUIRED) {
>> Only in MF_ACTION_REQUIRED case, SIGBUS is sent to processes when thp split failed. Any reson under it?
> 
> I took a clue from kill_accessing_process() which is invoked only if MF_ACTION_REQUIRED is set.
> 
> The usual code path for delivery signal is
> 
> if page-is-dirty or MF_MUST_KILL-is-set or umap-failed, then
> 
> - send SIGKILL if vaddr is -EFAULT
> 
> - send SIGBUS with BUS_MCEERR_AR if MF_ACTION_REQUIRED is set
> 
> - send SIGBUS with BUS_MCEERR_AO if MF_ACTION_REQUIRED is not set and process elected for MCE-early-kill
> 
> So, if kill_procs_now() is invoked only if MF_ACTION_REQUIRED (as it is in the patch), one can argue that
> 
> the MCE-early-kill request is not honored which deviates from the existing behavior.
> 
> Perhaps I should remove the
> 
> + if (flags & MF_ACTION_REQUIRED) {

I tend to agree MCE-early-kill request should be honored when try to kill process.
Thanks.
.


