Return-Path: <linux-kernel+bounces-412677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAD29D0DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989991F229F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096BC192D76;
	Mon, 18 Nov 2024 10:03:40 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28F918858A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924219; cv=none; b=m9aevnlDMqfIj/IB4cBEjNHI+lN52+3BtFAbpg4DFZicqG1KrksPKVUFBhwM1v+4NOB5CQvMuyYhP/d59z0DBFi+RIlU+vNVigLT1VuiLpWsSzcC3mb4sR4ghr6nE5v7U+oXQVlhYDYOAZttppgX5UXMduoSrk4WK8WehKIo2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924219; c=relaxed/simple;
	bh=JGzFTOLncpgjhRuPdiTF8Rsl+jdWOlA2QxBhWVk6NAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aytU5Q5wZbQS1WBfSKy2LdIWPQ3WM6R2J7fu9jSbyLCHdbdSirLC4BYVYHFxjbZkh13ycAJxcsFvd+DPId9HYQ448MtQlQ2htRMKvEypdbzYU4ft22WFQKfzcU+OoD1vMgkl446Av/qdtn2zULVJ2IyvLZ0jKUYkBIF8tjFs2f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XsMyk2xDqz10Rxr;
	Mon, 18 Nov 2024 17:39:10 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 45A50140393;
	Mon, 18 Nov 2024 17:41:46 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 18 Nov
 2024 17:41:45 +0800
Message-ID: <03c18a7b-24fa-4ee6-8682-63f1a81363e5@huawei.com>
Date: Mon, 18 Nov 2024 17:41:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/1] mm/vmscan: move the written-back folios to the
 tail of LRU after shrinking
To: Barry Song <21cnbao@gmail.com>, Matthew Wilcox <willy@infradead.org>
CC: Chen Ridong <chenridong@huaweicloud.com>, <akpm@linux-foundation.org>,
	<mhocko@suse.com>, <hannes@cmpxchg.org>, <yosryahmed@google.com>,
	<yuzhao@google.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangweiyang2@huawei.com>, <xieym_ict@hotmail.com>
References: <20241116091658.1983491-1-chenridong@huaweicloud.com>
 <20241116091658.1983491-2-chenridong@huaweicloud.com>
 <Zzq8jsAQNYgDKSGN@casper.infradead.org>
 <CAGsJ_4x0OrdhorQdz8PyLD84GOYVZJ7kLfGV_5yupLG_ZQ_B3w@mail.gmail.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <CAGsJ_4x0OrdhorQdz8PyLD84GOYVZJ7kLfGV_5yupLG_ZQ_B3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/11/18 12:14, Barry Song wrote:
> On Mon, Nov 18, 2024 at 5:03 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Sat, Nov 16, 2024 at 09:16:58AM +0000, Chen Ridong wrote:
>>> 2. In shrink_page_list function, if folioN is THP(2M), it may be splited
>>>    and added to swap cache folio by folio. After adding to swap cache,
>>>    it will submit io to writeback folio to swap, which is asynchronous.
>>>    When shrink_page_list is finished, the isolated folios list will be
>>>    moved back to the head of inactive lru. The inactive lru may just look
>>>    like this, with 512 filioes have been move to the head of inactive lru.
>>
>> I was hoping that we'd be able to stop splitting the folio when adding
>> to the swap cache.  Ideally. we'd add the whole 2MB and write it back
>> as a single unit.
> 
> This is already the case: adding to the swapcache doesn’t require splitting
> THPs, but failing to allocate 2MB of contiguous swap slots will.
> 
>>
>> This is going to become much more important with memdescs.  We'd have to
>> allocate 512 struct folios to do this, which would be about 10 4kB pages,
>> and if we're trying to swap out memory, we're probably low on memory.
>>
>> So I don't like this solution you have at all because it doesn't help us
>> get to the solution we're going to need in about a year's time.
>>
> 
> Ridong might need to clarify why this splitting is occurring. If it’s due to the
> failure to allocate swap slots, we still need a solution to address it.
> 
> Thanks
> Barry

shrink_folio_list
  add_to_swap
    folio_alloc_swap
      get_swap_pages
      	scan_swap_map_slots
    	/*
    	* Swapfile is not block device or not using clusters so unable
    	* to allocate large entries.
    	*/
      	if (!(si->flags & SWP_BLKDEV) || !si->cluster_info)
          return 0;

In my test, I use a file as swap, which is not 'SWP_BLKDEV'. So it
failed to get get_swap_pages.

I think this is a race issue between 'shrink_folio_list' executing and
writing back asynchronously. In my test, 512 folios(THP split) were
added to swap, only about 60 folios had not been written back when
'move_folios_to_lru' was invoked after 'shrink_folio_list'. What if
writing back faster? Maybe this will happen even 32 folios(without THP)
are in the 'folio_list' of shrink_folio_list's inputs.

Best regards,
Ridong

