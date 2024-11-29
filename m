Return-Path: <linux-kernel+bounces-425190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B149DBEB0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 03:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0FF8280E13
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 02:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7F514D6F6;
	Fri, 29 Nov 2024 02:25:18 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF1F14B088
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 02:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732847118; cv=none; b=urAy/CkPQbC7l0frugLsMfHtAkjBNL22ZFu+P2MeHDJ+TXMLCD3JNu8GsD6MgKONGDdeA8z40Zo4Jt1ORyV4aZw73cIT5ovJMQPMEjPDbVGcEGIwQz51KBU5mem0UYknn7/4zJ25hGGi3m45IsQwqMLb7WjKZIcKeQPhUZfHnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732847118; c=relaxed/simple;
	bh=ioaytzW6Zje28ozOlBr8TdG9570mz60lVng3cRfG3cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K5IBpt/rdpRRu1ClztNNOIsSkQmrGpvHORLr46ZFfVkOD01D6vp3uT21qgyYNIHSPecAGMe3UgkKnoM/PB5x+YkUsNrYVsu4RzLey1VpgJ0ysjvnNst64gwBfcFbErpSeeL68YriWuL8PKvbrTG9ANZrlhOWocL5TGJbkaEiDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XzxlY20nRzPppV;
	Fri, 29 Nov 2024 10:22:17 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id A06C1140120;
	Fri, 29 Nov 2024 10:25:04 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 29 Nov
 2024 10:25:03 +0800
Message-ID: <bf98a80a-2be0-413f-8a7a-34bb17f053cc@huawei.com>
Date: Fri, 29 Nov 2024 10:25:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/1] mm/vmscan: move the written-back folios to the
 tail of LRU after shrinking
To: Barry Song <21cnbao@gmail.com>, Yu Zhao <yuzhao@google.com>
CC: Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, Chen
 Ridong <chenridong@huaweicloud.com>, <akpm@linux-foundation.org>,
	<mhocko@suse.com>, <hannes@cmpxchg.org>, <yosryahmed@google.com>,
	<yuzhao@google.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangweiyang2@huawei.com>, <xieym_ict@hotmail.com>
References: <20241116091658.1983491-1-chenridong@huaweicloud.com>
 <20241116091658.1983491-2-chenridong@huaweicloud.com>
 <Zzq8jsAQNYgDKSGN@casper.infradead.org>
 <CAGsJ_4x0OrdhorQdz8PyLD84GOYVZJ7kLfGV_5yupLG_ZQ_B3w@mail.gmail.com>
 <ZzrA5nXldoE2PWx4@casper.infradead.org>
 <7e617fe7-388f-43a1-b0fa-e2998194b90c@huawei.com>
 <CAGsJ_4yA5graSSE3cBf_RB=cGc3hLpcB-3pR9ymVfzKx_dg3Zg@mail.gmail.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <CAGsJ_4yA5graSSE3cBf_RB=cGc3hLpcB-3pR9ymVfzKx_dg3Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/11/29 7:08, Barry Song wrote:
> On Mon, Nov 25, 2024 at 2:19 PM chenridong <chenridong@huawei.com> wrote:
>>
>>
>>
>> On 2024/11/18 12:21, Matthew Wilcox wrote:
>>> On Mon, Nov 18, 2024 at 05:14:14PM +1300, Barry Song wrote:
>>>> On Mon, Nov 18, 2024 at 5:03 PM Matthew Wilcox <willy@infradead.org> wrote:
>>>>>
>>>>> On Sat, Nov 16, 2024 at 09:16:58AM +0000, Chen Ridong wrote:
>>>>>> 2. In shrink_page_list function, if folioN is THP(2M), it may be splited
>>>>>>    and added to swap cache folio by folio. After adding to swap cache,
>>>>>>    it will submit io to writeback folio to swap, which is asynchronous.
>>>>>>    When shrink_page_list is finished, the isolated folios list will be
>>>>>>    moved back to the head of inactive lru. The inactive lru may just look
>>>>>>    like this, with 512 filioes have been move to the head of inactive lru.
>>>>>
>>>>> I was hoping that we'd be able to stop splitting the folio when adding
>>>>> to the swap cache.  Ideally. we'd add the whole 2MB and write it back
>>>>> as a single unit.
>>>>
>>>> This is already the case: adding to the swapcache doesn’t require splitting
>>>> THPs, but failing to allocate 2MB of contiguous swap slots will.
>>>
>>> Agreed we need to understand why this is happening.  As I've said a few
>>> times now, we need to stop requiring contiguity.  Real filesystems don't
>>> need the contiguity (they become less efficient, but they can scatter a
>>> single 2MB folio to multiple places).
>>>
>>> Maybe Chris has a solution to this in the works?
>>>
>>
>> Hi, Chris, do you have a better idea to solve this issue?
> 
> Not Chris. As I read the code again, we have already the below code to fixup
> the issue "missed folio_rotate_reclaimable()" in evict_folios():
> 
>                 /* retry folios that may have missed
> folio_rotate_reclaimable() */
>                 list_move(&folio->lru, &clean);
> 
> It doesn't work for you?
> 
> commit 359a5e1416caaf9ce28396a65ed3e386cc5de663
> Author: Yu Zhao <yuzhao@google.com>
> Date:   Tue Nov 15 18:38:07 2022 -0700
>     mm: multi-gen LRU: retry folios written back while isolated
> 
>     The page reclaim isolates a batch of folios from the tail of one of the
>     LRU lists and works on those folios one by one.  For a suitable
>     swap-backed folio, if the swap device is async, it queues that folio for
>     writeback.  After the page reclaim finishes an entire batch, it puts back
>     the folios it queued for writeback to the head of the original LRU list.
> 
>     In the meantime, the page writeback flushes the queued folios also by
>     batches.  Its batching logic is independent from that of the page reclaim.
>     For each of the folios it writes back, the page writeback calls
>     folio_rotate_reclaimable() which tries to rotate a folio to the tail.
> 
> 
>     folio_rotate_reclaimable() only works for a folio after the page reclaim
>     has put it back.  If an async swap device is fast enough, the page
>     writeback can finish with that folio while the page reclaim is still
>     working on the rest of the batch containing it.  In this case, that folio
>     will remain at the head and the page reclaim will not retry it before
>     reaching there.
> 
>     This patch adds a retry to evict_folios().  After evict_folios() has
>     finished an entire batch and before it puts back folios it cannot free
>     immediately, it retries those that may have missed the rotation.
>     Before this patch, ~60% of folios swapped to an Intel Optane missed
>     folio_rotate_reclaimable().  After this patch, ~99% of missed folios were
>     reclaimed upon retry.
> 
>     This problem affects relatively slow async swap devices like Samsung 980
>     Pro much less and does not affect sync swap devices like zram or zswap at
>     all.
> 
>>
>> Best regards,
>> Ridong
> 
> Thanks
> Barry

Thank you for your reply, Barry.
I found this issue with 5.10 version. I reproduced this issue with the
next version, but the CONFIG_LRU_GEN_ENABLED kconfig is disabled. I
tested again with  CONFIG_LRU_GEN_ENABLED enabled, and this issue can be
fixed.

IIUC, the 359a5e1416caaf9ce28396a65ed3e386cc5de663 commit can only work
when CONFIG_LRU_GEN_ENABLED is enabled, but this issue exists when
CONFIG_LRU_GEN_ENABLED is disabled and it should be fixed.

I read the code of commit 359a5e1416caaf9ce28396a65ed3e386cc5de663, it
found folios that are missed to rotate in a more complicated way, but it
 makes it much clearer what is being done. Should I implement in Yu
Zhao's way?

Best regards,
Ridong

