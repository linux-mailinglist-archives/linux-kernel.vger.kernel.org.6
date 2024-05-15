Return-Path: <linux-kernel+bounces-179340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F46A8C5EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801581C214D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 01:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2575D3613D;
	Wed, 15 May 2024 01:49:23 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347424316B
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715737760; cv=none; b=RnRWcgz4qASBOxOR7pLHLg5+NXXihPsRjpNSzKSVohGM2gm10V/nCsDrppLNI7MZFAUhN4MhiibkZgZHMBs/XUGfFTFczpPomCjfKkBV/sCswThLi34xRoEQDTTUTblxyniinZ/AA+gAH80H/fg/UkXH4LkzAhXEHeZ4SkgrV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715737760; c=relaxed/simple;
	bh=fcC4jQN8Gab4+R53kJwjMJeFHnSY3XdoD/ZzuHnROcc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KS5s2l3cMl+SrDhsdauI9kWPrU0wgwSIIyevlv/vSz9zmwmSuAesxcivS/kYH7izjJKYoXOS1ZzjZmETMQ/F7bA1GCaUvMGinS4FClap7TYoAefVroFKY/Y0/Hb9XX6UJgumY+oQHcsStZ12NwDV82n19aEiSpamSoX8B4rt2Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VfGHz47TNzvY1W;
	Wed, 15 May 2024 09:45:03 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 30B471804AA;
	Wed, 15 May 2024 09:48:32 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 09:48:31 +0800
Subject: Re: [PATCH -rc7] mm/huge_memory: mark huge_zero_page reserved
To: Yang Shi <shy828301@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <nao.horiguchi@gmail.com>, <xuyu@linux.alibaba.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240511035435.1477004-1-linmiaohe@huawei.com>
 <20240514141439.55fba39c81c1af55c9a100e1@linux-foundation.org>
 <CAHbLzkq+NBjwjSvU1fQe56nLf5mmGp65TH8hDpb66EFLENctKA@mail.gmail.com>
 <20240514144204.88790f125b0275ef68acf6de@linux-foundation.org>
 <CAHbLzkpQvr2K5yxwmtoHsj_UJ78ak=m-YdZxk=vpnPJ8iZdncw@mail.gmail.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9e5e51d7-e5bf-8209-317e-6f03c548727f@huawei.com>
Date: Wed, 15 May 2024 09:48:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHbLzkpQvr2K5yxwmtoHsj_UJ78ak=m-YdZxk=vpnPJ8iZdncw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/15 5:55, Yang Shi wrote:
> On Tue, May 14, 2024 at 3:42 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Tue, 14 May 2024 15:28:12 -0600 Yang Shi <shy828301@gmail.com> wrote:
>>
>>> On Tue, May 14, 2024 at 3:14 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>>
>>>> On Sat, 11 May 2024 11:54:35 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>
>>>>> When I did memory failure tests recently, below panic occurs:
>>>>>
>>>>>  kernel BUG at include/linux/mm.h:1135!
>>>>>  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>>>>>  CPU: 9 PID: 137 Comm: kswapd1 Not tainted 6.9.0-rc4-00491-gd5ce28f156fe-dirty #14
>>>>>
>>>>> ...
>>>>>
>>>>> --- a/mm/huge_memory.c
>>>>> +++ b/mm/huge_memory.c
>>>>> @@ -208,6 +208,7 @@ static bool get_huge_zero_page(void)
>>>>>               __free_pages(zero_page, compound_order(zero_page));
>>>>>               goto retry;
>>>>>       }
>>>>> +     __SetPageReserved(zero_page);
>>>>>       WRITE_ONCE(huge_zero_pfn, page_to_pfn(zero_page));
>>>>>
>>>>>       /* We take additional reference here. It will be put back by shrinker */
>>>>> @@ -260,6 +261,7 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
>>>>>               struct page *zero_page = xchg(&huge_zero_page, NULL);
>>>>>               BUG_ON(zero_page == NULL);
>>>>>               WRITE_ONCE(huge_zero_pfn, ~0UL);
>>>>> +             __ClearPageReserved(zero_page);
>>>>>               __free_pages(zero_page, compound_order(zero_page));
>>>>>               return HPAGE_PMD_NR;
>>>>>       }
>>>>
>>>> This causes a bit of a mess when staged ahead of mm-stable.  So to
>>>> avoid disruption I staged it behind mm-stable.  This means that when
>>>> the -stable maintainers try to merge it, they will ask for a fixed up
>>>> version for older kernels so you can please just send them this
>>>> version.
>>>
>>> Can you please drop this from mm-unstable since both I and David
>>> nack'ed a similar patch in another thread.
>>> https://lore.kernel.org/linux-mm/20240511032801.1295023-1-linmiaohe@huawei.com/
>>
>> That appears to link to the incorrect email thread?
> 
> I meant that patch is actually same with this one. Just used folio
> interface instead of page. I'm not sure why Miaohe posted two. Maybe
> target to different version.

Sorry for causing confusion. These two patches really target to different branch.
This patch is for mainline and another one for mm-unstable.
Thanks both.
.


