Return-Path: <linux-kernel+bounces-527005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE10A4061D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE43417CD3A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC91E205E1C;
	Sat, 22 Feb 2025 07:41:26 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538113C3F2
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740210086; cv=none; b=YHW3R3t3jbb2hcBqx0XwQ/7TsH8k6lrgIBhYzBNYA8BGsvAsQJAfd6Kn75d8DHHeGjsGxnOcAR7GVfnWaxpsMIYoZdRZBmgOkZloJqZS0UNbk2NbgDSmHiFQGDR8vGDoP6ZkSacPwtEu7HnMK+kz6eBU00L6fQES811Z6U8b9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740210086; c=relaxed/simple;
	bh=3h/oOXxNyk1GeCkXR31OeqcPgDyLOpqYMRTuUwVtpDQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RYeVlR0fMZVfZn41gLcBfYtYXaJhno05N+rDh/f9hFuvhev6cpxF8uLLoEY52F3f1ECmPRkbvpAuJ3f6Z3ZM9IQDZ7MDmaEAUsAyZgqYP38rUXP+qjzadwPIzqCJFsa9uuY34CatTOxaIyImOEJvRKaQfAvd/hICIeNJyjeK5Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z0Jjs50Nwz2JYZX;
	Sat, 22 Feb 2025 15:37:21 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 23C7E140155;
	Sat, 22 Feb 2025 15:41:20 +0800 (CST)
Received: from [10.174.178.114] (10.174.178.114) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Feb 2025 15:41:18 +0800
Message-ID: <a868e635-a86e-4dd7-8bae-c6ca94a2dc09@huawei.com>
Date: Sat, 22 Feb 2025 15:41:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<ryan.roberts@arm.com>, <chrisl@kernel.org>, <huang.ying.caritas@gmail.com>,
	<schatzberg.dan@gmail.com>, <baohua@kernel.org>, <hanchuanhua@oppo.com>,
	<willy@infradead.org>, <gaoxu2@honor.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <nphamcs@gmail.com>, <yosryahmed@google.com>
Subject: Re: [PATCH] mm: swap: Avoid infinite loop if no valid swap entry
 found during do_swap_page
To: <ryncsn@gmail.com>
References: <20250222024617.2790609-1-mawupeng1@huawei.com>
 <CAMgjq7AfZnwGAHoyCEhO5p2km-gPLk65WLL+2vO1i8hQDaTy+A@mail.gmail.com>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <CAMgjq7AfZnwGAHoyCEhO5p2km-gPLk65WLL+2vO1i8hQDaTy+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2025/2/22 15:33, Kairui Song wrote:
> On Sat, Feb 22, 2025 at 10:56 AM Wupeng Ma <mawupeng1@huawei.com> wrote:
>>
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> During our test, infinite loop is produced during #PF will lead to infinite
>> error log as follow:
>>
>>    get_swap_device: Bad swap file entry 114000000
>>
>> Digging into the source, we found that the swap entry is invalid due to
>> unknown reason, and this lead to invalid swap_info_struct. Excessive log
> 
> Hi Wupeng,
> 
> What is the kernel version you are using? If it's another bug causing
> this invalid swap entry, we should fix that bug instead, not
> workaround it.
> 
> This looks kind of similar to another PATCH & Bug report, corrupted
> page table or swap entry:
> https://lore.kernel.org/linux-mm/e223b0e6ba2f4924984b1917cc717bd5@honor.com/
> 
> Might be the same kernel bug? Gaoxu mentioned the bug was observed on
> Kernel 6.6.30 (android version), and neither of these two workarounds
> will fix it completely, the invalid value could cause many other
> issues too. We definitely need to find out the root cause.

We are having this problem in linux-v5.10, since the log is lost and swap
is not enabled in this machines, maybe memory corrupted in the pt.

> 
>> printing can fill up the prioritized log space, leading to the purging of
>> originally valid logs and hindering problem troubleshooting. To make this
>> more robust, kill this task.
>>
>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>> ---
>>  include/linux/swap.h | 1 +
>>  mm/memory.c          | 9 ++++++++-
>>  mm/swapfile.c        | 2 +-
>>  3 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index b13b72645db3..0fa39cf66bc4 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -508,6 +508,7 @@ struct backing_dev_info;
>>  extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
>>  extern void exit_swap_address_space(unsigned int type);
>>  extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
>> +struct swap_info_struct *_swap_info_get(swp_entry_t entry);
>>  sector_t swap_folio_sector(struct folio *folio);
>>
>>  static inline void put_swap_device(struct swap_info_struct *si)
>> diff --git a/mm/memory.c b/mm/memory.c
>> index b4d3d4893267..2d36e5a644d1 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4365,8 +4365,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>
>>         /* Prevent swapoff from happening to us. */
>>         si = get_swap_device(entry);
>> -       if (unlikely(!si))
>> +       if (unlikely(!si)) {
>> +               if (unlikely(!_swap_info_get(entry)))
>> +                       /*
>> +                        * return VM_FAULT_SIGBUS for invalid swap entry to
>> +                        * avoid infinite #PF.
>> +                        */
>> +                       ret = VM_FAULT_SIGBUS;
> 
> This could lead to VM_FAULT_SIGBUS on swapoff. After swapoff
> get_swap_device will return NULL.

If swap is off, All swap pages should be swap in as expected, so
such entry can not trigger do_swap_page?


