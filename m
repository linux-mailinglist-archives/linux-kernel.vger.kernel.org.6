Return-Path: <linux-kernel+bounces-279160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241BA94B9BD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACE42823E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00866146019;
	Thu,  8 Aug 2024 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r+ZfxkTD"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEDC189534
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723109704; cv=none; b=ZEA5qePJX159FhB04VZi53bUQGjJrYgNFayntZCLnYmgvAEmWOC6dF1MkdVgnGpC3QKgw7CDRqOydeWptT2yI2IOMySM8cBFbbYUrL685Vy43lK+agUA7JrBe3oJmkRYnGd8AqGFd8prxcQPlWuA1M5l0avFKvjavBGSXafVeh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723109704; c=relaxed/simple;
	bh=jWAk9dnimi9lsaUFu6QbWN6ydvn7QxSgIgZBX3RdvRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYdwDQK7sH8UzchWZylDOCg5v8MWsjebldSjx7lBHpbUAFBfdFIku805897KJgY7Hh+mYif70DxskZfJx25mC1MJSLG8zqE167SAOwDFSIOREOTu/FAILStkuu1et1Sre9KeB/O8pxvj7isBYs91lclhiUv92VjkCRcK7rtjImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r+ZfxkTD; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723109693; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CYZUkN6Dk5FACgRDchc3nuHoz3YHR1Byzw4EmSPjYDE=;
	b=r+ZfxkTDJxFq7B8hbwDwP1+i8Y4IACzki7obO1Bkm30dvQ78X/KO+b2OYzjHu/ufWR9yVlTq4eEzUmNEdWQv3eQwYjgADjriHTsbbYtwG2OvsnDsAtQFRfMPwfbb7pO9OpS+aAgLGrUrQjMXE2Vby5TC4oFGgNXqbnZXmCPJJts=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0WCM4TAX_1723109690;
Received: from 30.97.56.61(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCM4TAX_1723109690)
          by smtp.aliyun-inc.com;
          Thu, 08 Aug 2024 17:34:51 +0800
Message-ID: <1c4e67f1-caf5-4913-857d-b9cfbc30321e@linux.alibaba.com>
Date: Thu, 8 Aug 2024 17:34:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] mm: vmscan: add validation before spliting shmem
 large folio
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, chrisl@kernel.org,
 ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
 shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com,
 da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>
References: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
 <8a8c6dc9df0bc9f6f7f937bea446062be19611b3.1723012159.git.baolin.wang@linux.alibaba.com>
 <9b45a0dc-fa12-428a-8702-c7690c26aedc@redhat.com>
 <770190a2-3938-4ba9-9aaf-7320b34addf4@linux.alibaba.com>
 <03a7c798-7a0d-4873-8fcb-8940d8dadc00@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <03a7c798-7a0d-4873-8fcb-8940d8dadc00@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/8 16:51, David Hildenbrand wrote:
> On 08.08.24 04:36, Baolin Wang wrote:
>>
>>
>> On 2024/8/7 23:53, David Hildenbrand wrote:
>>> On 07.08.24 09:31, Baolin Wang wrote:
>>>> Page reclaim will not scan anon LRU if no swap space, however
>>>> MADV_PAGEOUT
>>>> can still split shmem large folios even without a swap device. Thus add
>>>> swap available space validation before spliting shmem large folio to
>>>> avoid redundant split.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>>    mm/vmscan.c | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index 31d13462571e..796f65781f4f 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -1259,6 +1259,14 @@ static unsigned int shrink_folio_list(struct
>>>> list_head *folio_list,
>>>>                }
>>>>            } else if (folio_test_swapbacked(folio) &&
>>>>                   folio_test_large(folio)) {
>>>> +
>>>> +            /*
>>>> +             * Do not split shmem folio if no swap memory
>>>> +             * available.
>>>> +             */
>>>> +            if (!total_swap_pages)
>>>> +                goto activate_locked;
>>>> +
>>>>                /* Split shmem folio */
>>>>                if (split_folio_to_list(folio, folio_list))
>>>>                    goto keep_locked;
>>>
>>> Reminds me of
>>>
>>> commit 9a976f0c847b67d22ed694556a3626ed92da0422
>>> Author: Luis Chamberlain <mcgrof@kernel.org>
>>> Date:   Thu Mar 9 15:05:43 2023 -0800
>>>
>>>       shmem: skip page split if we're not reclaiming
>>>       In theory when info->flags & VM_LOCKED we should not be getting
>>>       shem_writepage() called so we should be verifying this with a
>>>       WARN_ON_ONCE().  Since we should not be swapping then best to
>>> ensure we
>>>       also don't do the folio split earlier too.  So just move the check
>>> early
>>>       to avoid folio splits in case its a dubious call.
>>>       We also have a similar early bail when !total_swap_pages so just
>>> move that
>>>       earlier to avoid the possible folio split in the same situation.
>>>
>>>
>>> But indeed, pageout() -> writepage() is called *after* the split in the
>>> vmscan path.
>>>
>>> In that "noswap" context, I wonder if we also want to skip folios part
>>> of shmem
>>> with disabled swapping?
>>
>> Yes, I think so.
>>
>>>
>>> But now I am wondering under which circumstances we end up calling
>>> shmem_writepage() with a large folio. And I think the answer is the
>>> comment of
>>> folio_test_large(): via drivers/gpu/drm/i915/gem/i915_gem_shmem.c.
>>>
>>>
>>> ... so if shmem_writepage() handles+checks that, could we do
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index a332cb80e928..7dfa3d6e8ba7 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -1257,11 +1257,6 @@ static unsigned int shrink_folio_list(struct
>>> list_head *folio_list,
>>>                                                   goto
>>> activate_locked_split;
>>>                                   }
>>>                           }
>>> -               } else if (folio_test_swapbacked(folio) &&
>>> -                          folio_test_large(folio)) {
>>> -                       /* Split shmem folio */
>>> -                       if (split_folio_to_list(folio, folio_list))
>>> -                               goto keep_locked;
>>>                   }
>>>
>>>                   /*
>>>
>>> instead?
>>
>> Seems reasonable to me. But we should pass the 'folio_list' to
>> shmem_writepage() to list the subpages of the large folio. Let me try.
> 
> Ah, yes, good point. Alternatively, we'd have to split and try writing 
> all subpages in there. I wonder what to do if we fail to write some, and 
> if we could handle that transparently, without the folio_list.

After some investigation, I prefer to pass 'folio_list' to 
shmem_writepage() via 'struct writeback_control', which could simplify 
the logic a lot. Otherwise, we need to handle each subpage's 
writeback/reclaim/dirty state, as well as tracking each subpage's write 
result, which seems more complicated.

I made a quick change by passing 'folio_list', and it looks simple and 
works as expected.

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 75196b0f894f..10100e22d5c6 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -80,6 +80,9 @@ struct writeback_control {
          */
         struct swap_iocb **swap_plug;

+       /* Target list for splitting a large folio */
+       struct list_head *list;
+
         /* internal fields used by the ->writepages implementation: */
         struct folio_batch fbatch;
         pgoff_t index;
diff --git a/mm/shmem.c b/mm/shmem.c
index 05525e9e7423..0a5a68f7d0a0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1496,9 +1496,10 @@ static int shmem_writepage(struct page *page, 
struct writeback_control *wbc)
          * and its shmem_writeback() needs them to be split when swapping.
          */
         if (wbc->split_large_folio && folio_test_large(folio)) {
+try_split:
                 /* Ensure the subpages are still dirty */
                 folio_test_set_dirty(folio);
-               if (split_huge_page(page) < 0)
+               if (split_huge_page_to_list_to_order(page, wbc->list, 0))
                         goto redirty;
                 folio = page_folio(page);
                 folio_clear_dirty(folio);
@@ -1540,8 +1541,12 @@ static int shmem_writepage(struct page *page, 
struct writeback_control *wbc)
         }

         swap = folio_alloc_swap(folio);
-       if (!swap.val)
+       if (!swap.val) {
+               if (nr_pages > 1)
+                       goto try_split;
+
                 goto redirty;
+       }

         /*
          * Add inode to shmem_unuse()'s list of swapped-out inodes,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 277571815789..cf982cf2454f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -628,7 +628,7 @@ typedef enum {
   * Calls ->writepage().
   */
  static pageout_t pageout(struct folio *folio, struct address_space 
*mapping,
-                        struct swap_iocb **plug)
+                        struct swap_iocb **plug, struct list_head 
*folio_list)
  {
         /*
          * If the folio is dirty, only perform writeback if that write
@@ -676,6 +676,11 @@ static pageout_t pageout(struct folio *folio, 
struct address_space *mapping,
                         .swap_plug = plug,
                 };

+               if (shmem_mapping(mapping)) {
+                       wbc.list = folio_list;
+                       wbc.split_large_folio = 
!IS_ENABLED(CONFIG_THP_SWAP);
+               }
+
                 folio_set_reclaim(folio);
                 res = mapping->a_ops->writepage(&folio->page, &wbc);
                 if (res < 0)
@@ -1259,23 +1264,6 @@ static unsigned int shrink_folio_list(struct 
list_head *folio_list,
                                                 goto activate_locked_split;
                                 }
                         }
-               } else if (folio_test_swapbacked(folio) &&
-                          folio_test_large(folio)) {
-
-                       /*
-                        * Do not split shmem folio if no swap memory
-                        * available.
-                        */
-                       if (!total_swap_pages)
-                               goto activate_locked;
-
-                       /*
-                        * Only split shmem folio when CONFIG_THP_SWAP
-                        * is not enabled.
-                        */
-                       if (!IS_ENABLED(CONFIG_THP_SWAP) &&
-                           split_folio_to_list(folio, folio_list))
-                               goto keep_locked;
                 }

                 /*
@@ -1377,18 +1365,21 @@ static unsigned int shrink_folio_list(struct 
list_head *folio_list,
                          * starts and then write it out here.
                          */
                         try_to_unmap_flush_dirty();
-try_pageout:
-                       switch (pageout(folio, mapping, &plug)) {
+                       switch (pageout(folio, mapping, &plug, 
folio_list)) {
                         case PAGE_KEEP:
                                 goto keep_locked;
                         case PAGE_ACTIVATE:
-                               if (shmem_mapping(mapping) && 
folio_test_large(folio) &&
-                                   !split_folio_to_list(folio, 
folio_list)) {
+                               /* Shmem can be split when writeback to 
swap */
+                               if ((nr_pages > 1) && 
!folio_test_large(folio)) {
+                                       sc->nr_scanned -= (nr_pages - 1);
                                         nr_pages = 1;
-                                       goto try_pageout;
                                 }
                                 goto activate_locked;
                         case PAGE_SUCCESS:
+                               if ((nr_pages > 1) && 
!folio_test_large(folio)) {
+                                       sc->nr_scanned -= (nr_pages - 1);
+                                       nr_pages = 1;
+                               }
                                 stat->nr_pageout += nr_pages;

                                 if (folio_test_writeback(folio)) {

