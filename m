Return-Path: <linux-kernel+bounces-279375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849C194BC85
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8BF2820B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5865618B48A;
	Thu,  8 Aug 2024 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yJGeP1cW"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6519E145FE0
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117902; cv=none; b=jhJiumpbJMKzYS6W2aD4mq3kjqjXY/ahGHV+LGFm1ycGGhpFkUcjd88bL623RWrJYf3AeUiPbwpowiicRUHkO3jbZLdA8I5m5ru8QNyH7oJkpANur2B0fpdP796vbLzCDTKc/9FEaDkESOg/ISGQk6fSInNk+Kb+p1ptG2I2N5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117902; c=relaxed/simple;
	bh=TU4XZjnjmdqKR9vhbcYJPIsff6rENfGFjHNNKDUp418=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNJMiDDEN7vYKLhkMySDj/J9rp9hFoiCaT8QXhCqluqrCFtoiQAEd1y5bfeLhEJUMZhB5IHcX89ycEnaEa2CIut/QGdyQs1G46/Tp0ZrNgv62Y1ruxghI6zRLWyl3R3CGVDUN7xuqF+1Upr0XveoRrcbeKTHRjApksGwbI+YBvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yJGeP1cW; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723117896; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=38l1qgEuzCZS+F+/Nl/WPuHvdpIjeaLxUvsXN8uM9Q8=;
	b=yJGeP1cW4W0JbrmSEQGVGBmywRt2OS+P3G097yR/oJ3E7aUQ/P8UeoV9uULF/gn5zqgxztqUM4A89hFegMcf2DV730MWH1pW/3jkt/xhq2c7vQQ+wce/d2gjNwkOuPdDCStFuiNbry2JP/ZP6WAoy/zybjFejj7IzBhwYY4DDX4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032019045;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0WCMSrfA_1723117894;
Received: from 30.97.56.61(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCMSrfA_1723117894)
          by smtp.aliyun-inc.com;
          Thu, 08 Aug 2024 19:51:35 +0800
Message-ID: <3bf4f376-7bdf-4970-937e-7e47dc938578@linux.alibaba.com>
Date: Thu, 8 Aug 2024 19:51:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] mm: vmscan: add validation before spliting shmem
 large folio
To: Daniel Gomez <da.gomez@samsung.com>
Cc: David Hildenbrand <david@redhat.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "chrisl@kernel.org" <chrisl@kernel.org>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>,
 Pankaj Raghav <p.raghav@samsung.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
References: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
 <8a8c6dc9df0bc9f6f7f937bea446062be19611b3.1723012159.git.baolin.wang@linux.alibaba.com>
 <9b45a0dc-fa12-428a-8702-c7690c26aedc@redhat.com>
 <770190a2-3938-4ba9-9aaf-7320b34addf4@linux.alibaba.com>
 <03a7c798-7a0d-4873-8fcb-8940d8dadc00@redhat.com>
 <CGME20240808093456eucas1p17940e959eb7a34d03d921f56570a0b6a@eucas1p1.samsung.com>
 <1c4e67f1-caf5-4913-857d-b9cfbc30321e@linux.alibaba.com>
 <4dmzlg3rlhxnl3eihghe7enhtk67ooqpak3w5xlzehka6sfzf6@ahmahak2wyvj>
 <gyeyk436eopfyhwzjfuc2pfsyg7aemjrmpi3xbby6bqfxhlkqj@cpw4kqbww4ym>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <gyeyk436eopfyhwzjfuc2pfsyg7aemjrmpi3xbby6bqfxhlkqj@cpw4kqbww4ym>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/8 18:57, Daniel Gomez wrote:
> On Thu, Aug 08, 2024 at 12:48:52PM GMT, Daniel Gomez wrote:
>> On Thu, Aug 08, 2024 at 05:34:50PM GMT, Baolin Wang wrote:
>>>
>>>
>>> On 2024/8/8 16:51, David Hildenbrand wrote:
>>>> On 08.08.24 04:36, Baolin Wang wrote:
>>>>>
>>>>>
>>>>> On 2024/8/7 23:53, David Hildenbrand wrote:
>>>>>> On 07.08.24 09:31, Baolin Wang wrote:
>>>>>>> Page reclaim will not scan anon LRU if no swap space, however
>>>>>>> MADV_PAGEOUT
>>>>>>> can still split shmem large folios even without a swap device. Thus add
>>>>>>> swap available space validation before spliting shmem large folio to
>>>>>>> avoid redundant split.
>>>>>>>
>>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>>> ---
>>>>>>>     mm/vmscan.c | 8 ++++++++
>>>>>>>     1 file changed, 8 insertions(+)
>>>>>>>
>>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>>> index 31d13462571e..796f65781f4f 100644
>>>>>>> --- a/mm/vmscan.c
>>>>>>> +++ b/mm/vmscan.c
>>>>>>> @@ -1259,6 +1259,14 @@ static unsigned int shrink_folio_list(struct
>>>>>>> list_head *folio_list,
>>>>>>>                 }
>>>>>>>             } else if (folio_test_swapbacked(folio) &&
>>>>>>>                    folio_test_large(folio)) {
>>>>>>> +
>>>>>>> +            /*
>>>>>>> +             * Do not split shmem folio if no swap memory
>>>>>>> +             * available.
>>>>>>> +             */
>>>>>>> +            if (!total_swap_pages)
>>>>>>> +                goto activate_locked;
>>>>>>> +
>>>>>>>                 /* Split shmem folio */
>>>>>>>                 if (split_folio_to_list(folio, folio_list))
>>>>>>>                     goto keep_locked;
>>>>>>
>>>>>> Reminds me of
>>>>>>
>>>>>> commit 9a976f0c847b67d22ed694556a3626ed92da0422
>>>>>> Author: Luis Chamberlain <mcgrof@kernel.org>
>>>>>> Date:   Thu Mar 9 15:05:43 2023 -0800
>>>>>>
>>>>>>        shmem: skip page split if we're not reclaiming
>>>>>>        In theory when info->flags & VM_LOCKED we should not be getting
>>>>>>        shem_writepage() called so we should be verifying this with a
>>>>>>        WARN_ON_ONCE().  Since we should not be swapping then best to
>>>>>> ensure we
>>>>>>        also don't do the folio split earlier too.  So just move the check
>>>>>> early
>>>>>>        to avoid folio splits in case its a dubious call.
>>>>>>        We also have a similar early bail when !total_swap_pages so just
>>>>>> move that
>>>>>>        earlier to avoid the possible folio split in the same situation.
>>>>>>
>>>>>>
>>>>>> But indeed, pageout() -> writepage() is called *after* the split in the
>>>>>> vmscan path.
>>>>>>
>>>>>> In that "noswap" context, I wonder if we also want to skip folios part
>>>>>> of shmem
>>>>>> with disabled swapping?
>>>>>
>>>>> Yes, I think so.
>>>>>
>>>>>>
>>>>>> But now I am wondering under which circumstances we end up calling
>>>>>> shmem_writepage() with a large folio. And I think the answer is the
>>>>>> comment of
>>>>>> folio_test_large(): via drivers/gpu/drm/i915/gem/i915_gem_shmem.c.
>>>>>>
>>>>>>
>>>>>> ... so if shmem_writepage() handles+checks that, could we do
>>>>>>
>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>> index a332cb80e928..7dfa3d6e8ba7 100644
>>>>>> --- a/mm/vmscan.c
>>>>>> +++ b/mm/vmscan.c
>>>>>> @@ -1257,11 +1257,6 @@ static unsigned int shrink_folio_list(struct
>>>>>> list_head *folio_list,
>>>>>>                                                    goto
>>>>>> activate_locked_split;
>>>>>>                                    }
>>>>>>                            }
>>>>>> -               } else if (folio_test_swapbacked(folio) &&
>>>>>> -                          folio_test_large(folio)) {
>>>>>> -                       /* Split shmem folio */
>>>>>> -                       if (split_folio_to_list(folio, folio_list))
>>>>>> -                               goto keep_locked;
>>>>>>                    }
>>>>>>
>>>>>>                    /*
>>>>>>
>>>>>> instead?
>>>>>
>>>>> Seems reasonable to me. But we should pass the 'folio_list' to
>>>>> shmem_writepage() to list the subpages of the large folio. Let me try.
>>>>
>>>> Ah, yes, good point. Alternatively, we'd have to split and try writing
>>>> all subpages in there. I wonder what to do if we fail to write some, and
>>>> if we could handle that transparently, without the folio_list.
>>>
>>> After some investigation, I prefer to pass 'folio_list' to shmem_writepage()
>>> via 'struct writeback_control', which could simplify the logic a lot.
>>> Otherwise, we need to handle each subpage's writeback/reclaim/dirty state,
>>> as well as tracking each subpage's write result, which seems more
>>> complicated.
>>>
>>> I made a quick change by passing 'folio_list', and it looks simple and works
>>> as expected.
>>>
>>> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
>>> index 75196b0f894f..10100e22d5c6 100644
>>> --- a/include/linux/writeback.h
>>> +++ b/include/linux/writeback.h
>>> @@ -80,6 +80,9 @@ struct writeback_control {
>>>           */
>>>          struct swap_iocb **swap_plug;
>>>
>>> +       /* Target list for splitting a large folio */
>>> +       struct list_head *list;
>>> +
>>>          /* internal fields used by the ->writepages implementation: */
>>>          struct folio_batch fbatch;
>>>          pgoff_t index;
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index 05525e9e7423..0a5a68f7d0a0 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -1496,9 +1496,10 @@ static int shmem_writepage(struct page *page, struct
>>> writeback_control *wbc)
>>>           * and its shmem_writeback() needs them to be split when swapping.
>>>           */
>>>          if (wbc->split_large_folio && folio_test_large(folio)) {
>>> +try_split:
>>>                  /* Ensure the subpages are still dirty */
>>>                  folio_test_set_dirty(folio);
>>> -               if (split_huge_page(page) < 0)
>>> +               if (split_huge_page_to_list_to_order(page, wbc->list, 0))
>>
>> We check for split_large_folio, but we still send the wbc->list for i915
>> writepage() case. Previously, we were sending a NULL list. Shouldn't we address
>> that case too?
> 
> I guess I was missing wbc initialization snippet:
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index fe69f2c8527d..174b95a9a988 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -308,6 +308,7 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
>                  .range_start = 0,
>                  .range_end = LLONG_MAX,
>                  .for_reclaim = 1,
> +               .list = NULL,
>          };
>          unsigned long i;
> 

IMO, we don't need an explicit initialization, and 'list' will be 
initialized as NULL. Please see: 
https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html

