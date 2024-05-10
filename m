Return-Path: <linux-kernel+bounces-175226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AB58C1CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 04:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD83E1C210D6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D986148840;
	Fri, 10 May 2024 02:59:52 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23FF56757
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715309991; cv=none; b=AJXE2+FFfHDxMuVMWDPJtEyAHjx+cECsGCIVpjLi3lGcuzFS1s+qqPE+m8vJvmsN7xptCFDnQWcNDafgOP8x0EhS3YkjVm6vlWHOve/M717OguMl0Kt5g3VODdnTOnbslF///Vu6D2u2QZJMsHrBwzC69WUkqVeDs8pgV1RvVNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715309991; c=relaxed/simple;
	bh=E35cDS4QnQB/w8COj0/DibA2uyG84mOHHN09JXoYD84=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VirX1iyYo2AwU7XJQQ3bXUyvudAAgLKggsWZdR7lU6FcKtg45Usf9nh+/6m71c1D+fyGMlP4G0h+EcRQXMnb09fbphaMG7nRF68EH0DeGVRZHhQ1+t7runCvBoogi9yG5NvzaxPNaPTxC0DSx1IHagkEjq+1vg5tXXG3n2TkoD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VbD8z6YMKzCrR4;
	Fri, 10 May 2024 10:58:27 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id C64A014038F;
	Fri, 10 May 2024 10:59:39 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 10:59:39 +0800
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
 <30d4d249-e3b1-79d5-3501-0ccb9c529110@huawei.com>
 <7a292357-8515-4ea6-b4d1-6ca6fa407e72@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <32b88a87-8edc-12eb-1fd7-2a028b8f9fb3@huawei.com>
Date: Fri, 10 May 2024 10:59:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7a292357-8515-4ea6-b4d1-6ca6fa407e72@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/9 23:34, Jane Chu wrote:
> 
> On 5/9/2024 1:30 AM, Miaohe Lin wrote:
>> On 2024/5/9 1:45, Jane Chu wrote:
>>> On 5/8/2024 1:08 AM, Miaohe Lin wrote:
>>>
>>>> On 2024/5/7 4:26, Jane Chu wrote:
>>>>> On 5/5/2024 12:00 AM, Miaohe Lin wrote:
>>>>>
>>>>>> On 2024/5/2 7:24, Jane Chu wrote:
>>>>>>> When handle hwpoison in a GUP longterm pin'ed thp page,
>>>>>>> try_to_split_thp_page() will fail. And at this point, there is little else
>>>>>>> the kernel could do except sending a SIGBUS to the user process, thus
>>>>>>> give it a chance to recover.
>>>>>>>
>>>>>>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>>>>>> Thanks for your patch. Some comments below.
>>>>>>
>>>>>>> ---
>>>>>>>     mm/memory-failure.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>>>>     1 file changed, 36 insertions(+)
>>>>>>>
>>>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>>>>> index 7fcf182abb96..67f4d24a98e7 100644
>>>>>>> --- a/mm/memory-failure.c
>>>>>>> +++ b/mm/memory-failure.c
>>>>>>> @@ -2168,6 +2168,37 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>>>>>>         return rc;
>>>>>>>     }
>>>>>>>     +/*
>>>>>>> + * The calling condition is as such: thp split failed, page might have
>>>>>>> + * been GUP longterm pinned, not much can be done for recovery.
>>>>>>> + * But a SIGBUS should be delivered with vaddr provided so that the user
>>>>>>> + * application has a chance to recover. Also, application processes'
>>>>>>> + * election for MCE early killed will be honored.
>>>>>>> + */
>>>>>>> +static int kill_procs_now(struct page *p, unsigned long pfn, int flags,
>>>>>>> +            struct page *hpage)
>>>>>>> +{
>>>>>>> +    struct folio *folio = page_folio(hpage);
>>>>>>> +    LIST_HEAD(tokill);
>>>>>>> +    int res = -EHWPOISON;
>>>>>>> +
>>>>>>> +    /* deal with user pages only */
>>>>>>> +    if (PageReserved(p) || PageSlab(p) || PageTable(p) || PageOffline(p))
>>>>>>> +        res = -EBUSY;
>>>>>>> +    if (!(PageLRU(hpage) || PageHuge(p)))
>>>>>>> +        res = -EBUSY;
>>>>>> Above checks seems unneeded. We already know it's thp?
>>>>> Agreed.
>>>>>
>>>>> I  lifted these checks from hwpoison_user_mapping() with a hope to make kill_procs_now() more generic,
>>>>>
>>>>> such as, potentially replacing kill_accessing_processes() for re-accessing hwpoisoned page.
>>>>>
>>>>> But I backed out at last, due to concerns that my tests might not have covered sufficient number of scenarios.
>>>>>
>>>>>>> +
>>>>>>> +    if (res == -EHWPOISON) {
>>>>>>> +        collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
>>>>>>> +        kill_procs(&tokill, true, pfn, flags);
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    if (flags & MF_COUNT_INCREASED)
>>>>>>> +        put_page(p);
>>>>>> This if block is broken. put_page() has been done when try_to_split_thp_page() fails?
>>>>> put_page() has not been done if try_to_split_thp_page() fails, and I think it should.
>>>> In try_to_split_thp_page(), if split_huge_page fails, i.e. ret != 0, put_page() is called. See below:
>>>>
>>>> static int try_to_split_thp_page(struct page *page)
>>>> {
>>>>      int ret;
>>>>
>>>>      lock_page(page);
>>>>      ret = split_huge_page(page);
>>>>      unlock_page(page);
>>>>
>>>>      if (unlikely(ret))
>>>>          put_page(page);
>>>>      ^^^^^^^^^^^^^^^^^^^^^^^
>>>>      return ret;
>>>> }
>>>>
>>>> Or am I miss something?
>>> I think you caught a bug in my code, thanks!
>>>
>>> How about moving put_page() outside try_to_split_thp_page() ?
>> If you want to send SIGBUS in the event of thp split fail, it might be required to do so.
>> I think kill_procs_now() needs extra thp refcnt to do its work.
> 
> Agreed.  I added an boolean to try_to_split_thp_page(),the boolean indicates whether to put_page().

IMHO, it might be too complicated to add an extra boolean to indicate whether to put_page(). It might be
more straightforward to always put_page outside try_to_split_thp_page?
Thanks.
.


