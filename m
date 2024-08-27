Return-Path: <linux-kernel+bounces-302705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4046960221
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2867B2115E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649B713E028;
	Tue, 27 Aug 2024 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kNJ64BAA"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D4F10A3E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741214; cv=none; b=ceKwvGGxbzQCqE4Vd4sUdAy/hac5wrLwJpH0nWIwzuI8iA17/0r94BewihyUnoOwNzvWuCuNVwbRV7tkbR2/7dzGt6hfukiMXLI8rGsL/6Y7eRtBgEcGSLzlGJ5WrEGGNUA0caGyS2ftY7o5fEjXzRKID89mnAIlB0dS7NMSf5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741214; c=relaxed/simple;
	bh=hWs0/rF72hxsC1FOrqUgtpc8B8SjmHzfMzTC6HDlfMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMoV7L7Jkjq7YOp/CphyTGF1UJ/SoaktpJsuBE96noCGFSZxjuRHf5mTBx6z4JY1l315cNAEUYygvx6iK3CWlvd9V6Jr9mf4Ne3m+BHElI+f8ZIuubaL5KfYyk+N4ijR/8oC2De8qOGYi0UAhUY7pngxHxcjPSpVaB7b6wzmGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kNJ64BAA; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724741203; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MYj42ejBei/qNh91sxn96wAtDa2ftVcX0BdcltOjqTM=;
	b=kNJ64BAAdKUAPv1E1ccn/PW+lNH5fidcVr5r02RzXuScfLRKyZTAQvpoq8nUqxCIPDnQc1Y42v1+fVzEbSDMwI5NbYA+Vu7VaWl7igYULGjN/Og7LUWZlnSci3L0FLwGjqXQD37/akXYa4i49Sd5AWlZSEadiM5H377f2mmFHN0=
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WDlZ0bw_1724741200)
          by smtp.aliyun-inc.com;
          Tue, 27 Aug 2024 14:46:41 +0800
Message-ID: <39c71ccf-669b-4d9f-923c-f6b9c4ceb8df@linux.alibaba.com>
Date: Tue, 27 Aug 2024 14:46:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] mm: shmem: split large entry if the swapin folio
 is not large
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 chrisl@kernel.org, ying.huang@intel.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com,
 ioworker0@gmail.com, da.gomez@samsung.com, p.raghav@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1723434324.git.baolin.wang@linux.alibaba.com>
 <4a0f12f27c54a62eb4d9ca1265fed3a62531a63e.1723434324.git.baolin.wang@linux.alibaba.com>
 <e2a2ba5d-864c-50aa-7579-97cba1c7dd0c@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <e2a2ba5d-864c-50aa-7579-97cba1c7dd0c@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/26 06:31, Hugh Dickins wrote:
> On Mon, 12 Aug 2024, Baolin Wang wrote:
> 
>> Now the swap device can only swap-in order 0 folio, even though a large
>> folio is swapped out. This requires us to split the large entry previously
>> saved in the shmem pagecache to support the swap in of small folios.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/shmem.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 100 insertions(+)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 345e25425e37..996062dc196b 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1990,6 +1990,81 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>>   	swap_free_nr(swap, nr_pages);
>>   }
>>   
>> +static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
>> +				   swp_entry_t swap, int new_order, gfp_t gfp)
>> +{
>> +	struct address_space *mapping = inode->i_mapping;
>> +	XA_STATE_ORDER(xas, &mapping->i_pages, index, new_order);
>> +	void *alloced_shadow = NULL;
>> +	int alloced_order = 0, i;
> 
> gfp needs to be adjusted: see fix patch below.

Ah, good catch. Thank you Hugh.

>> +
>> +	for (;;) {
>> +		int order = -1, split_order = 0;
>> +		void *old = NULL;
>> +
>> +		xas_lock_irq(&xas);
>> +		old = xas_load(&xas);
>> +		if (!xa_is_value(old) || swp_to_radix_entry(swap) != old) {
>> +			xas_set_err(&xas, -EEXIST);
>> +			goto unlock;
>> +		}
>> +
>> +		order = xas_get_order(&xas);
>> +
>> +		/* Swap entry may have changed before we re-acquire the lock */
>> +		if (alloced_order &&
>> +		    (old != alloced_shadow || order != alloced_order)) {
>> +			xas_destroy(&xas);
>> +			alloced_order = 0;
>> +		}
>> +
>> +		/* Try to split large swap entry in pagecache */
>> +		if (order > 0 && order > new_order) {
> 
> I have not even attempted to understand all the manipulations of order and
> new_order and alloced_order and split_order.  And further down it turns out
> that this is only ever called with new_order 0.
> 
> You may be wanting to cater for more generality in future, but for now
> please cut this down to the new_order 0 case, and omit that parameter.
> It will be easier for us to think about the xa_get_order() races if
> the possibilities are more limited.

Sure. I will drop the 'new_order' with following fix.

> 
>> +			if (!alloced_order) {
>> +				split_order = order;
>> +				goto unlock;
>> +			}
>> +			xas_split(&xas, old, order);
>> +
>> +			/*
>> +			 * Re-set the swap entry after splitting, and the swap
>> +			 * offset of the original large entry must be continuous.
>> +			 */
>> +			for (i = 0; i < 1 << order; i += (1 << new_order)) {
>> +				pgoff_t aligned_index = round_down(index, 1 << order);
>> +				swp_entry_t tmp;
>> +
>> +				tmp = swp_entry(swp_type(swap), swp_offset(swap) + i);
>> +				__xa_store(&mapping->i_pages, aligned_index + i,
>> +					   swp_to_radix_entry(tmp), 0);
>> +			}
> 
> So that is done under xas lock: good. But is the intermediate state
> visible to RCU readers, and could that be a problem?

In xas_split(), the multi-index entry has been split into smaller 
entries, and each of these smaller entries has been set with the old 
swap value. During the process of __xa_store(), these entries will be 
re-set to the new swap value. Although RCU readers might observe the old 
swap value, I have not seen any problems until now (may be I missed 
something).

For concurrent shmem swap-in cases, there are some checks in 
shmem_swapin_folio() (including folio->swap.val and shmem_confirm_swap() 
validation ) to ensure the correctness of the swap values.

For the shmem_partial_swap_usage(), we may get racy swap usages, but it 
is not a problem form its comments:
" * This is safe to call without i_rwsem or the i_pages lock thanks to RCU,
  * as long as the inode doesn't go away and racy results are not a 
problem."

For shmem truncation, when removing the racy swap entry from shmem page 
cache, it will use xa_cmpxchg_irq() to sync the correct swap state.


[PATCH] mm: shmem: split large entry if the swapin folio is not large
  fix 2

Now we only split large folio to order 0, so drop the 'new_order'
parameter.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
  mm/shmem.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d8038a66b110..f00b7b99ad09 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1998,10 +1998,10 @@ static void shmem_set_folio_swapin_error(struct 
inode *inode, pgoff_t index,
  }

  static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
-                                  swp_entry_t swap, int new_order, 
gfp_t gfp)
+                                  swp_entry_t swap, gfp_t gfp)
  {
         struct address_space *mapping = inode->i_mapping;
-       XA_STATE_ORDER(xas, &mapping->i_pages, index, new_order);
+       XA_STATE_ORDER(xas, &mapping->i_pages, index, 0);
         void *alloced_shadow = NULL;
         int alloced_order = 0, i;

@@ -2026,7 +2026,7 @@ static int shmem_split_large_entry(struct inode 
*inode, pgoff_t index,
                 }

                 /* Try to split large swap entry in pagecache */
-               if (order > 0 && order > new_order) {
+               if (order > 0) {
                         if (!alloced_order) {
                                 split_order = order;
                                 goto unlock;
@@ -2037,7 +2037,7 @@ static int shmem_split_large_entry(struct inode 
*inode, pgoff_t index,
                          * Re-set the swap entry after splitting, and 
the swap
                          * offset of the original large entry must be 
continuous.
                          */
-                       for (i = 0; i < 1 << order; i += (1 << new_order)) {
+                       for (i = 0; i < 1 << order; i++) {
                                 pgoff_t aligned_index = 
round_down(index, 1 << order);
                                 swp_entry_t tmp;

@@ -2123,7 +2123,7 @@ static int shmem_swapin_folio(struct inode *inode, 
pgoff_t index,
                  * should split the large swap entry stored in the 
pagecache
                  * if necessary.
                  */
-               split_order = shmem_split_large_entry(inode, index, 
swap, 0, gfp);
+               split_order = shmem_split_large_entry(inode, index, 
swap, gfp);
                 if (split_order < 0) {
                         error = split_order;
                         goto failed;

