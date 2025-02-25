Return-Path: <linux-kernel+bounces-530341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3951EA43248
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A1E170A55
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52296AA7;
	Tue, 25 Feb 2025 01:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gbw6aLh2"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C964C80
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740445685; cv=none; b=FKFcPUZ6n4GaML5aSVj5IGyjeArgg/p1NmsGXIZqgSOpoVvdtPdxauPCpbEaUAJQrDDqNwUlN3NP4JROHsN3VrrFTK7SLChRsPMgxLWfqlhOP09vSpepAKLSiXhpQyDzT7KJZqrhq8EVqu/TkoXJZ2LyEFFK41RFuug7c3giI2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740445685; c=relaxed/simple;
	bh=7UXe6PQ+k+DXt1HcYt79O8/jWjPY0utaycDeUQcQEz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcPzRp6ceUwe/+7LUrFB3Y7j6SoGaSappTbjA3C3y9wDEsdObQddZB5Jz21rUKn2hmCNFib5Fo61Tf5VTSRSb8WeTMi97X59IEmBXOEbb55VT+WakxTW3vHUn5ecjbp+wmHu4URcAx3ndwVY8E0o/jfUZAnkOneyAFGsraMM42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gbw6aLh2; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740445679; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2wtspKnVg9vRGSfU0IMP9tf/T/MZmprrqJBQEvw5r2s=;
	b=gbw6aLh2J/RLqODuf2HWULB0IFsoFNnntmZ9osEJVtMpyimDRfRl4aMx+UVOUTnbGvEqEnESi9/nlioW78PtXFbOvdVNrNsTF989Hd6WqMb0UoxGtQ++3S18BccuybPbmnZ6ET6MH7Y79IhTW5h4diYWU/5x/B3VCtu3ldCZUpI=
Received: from 30.74.144.116(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WQCd.v6_1740445677 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Feb 2025 09:07:58 +0800
Message-ID: <c50aeb15-d0a1-4eaf-9d14-05c4f2a9f2aa@linux.alibaba.com>
Date: Tue, 25 Feb 2025 09:07:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: fix potential data corruption during shmem
 swapin
To: Kairui Song <ryncsn@gmail.com>
Cc: akpm@linux-foundation.org, alex_y_xu@yahoo.ca, baohua@kernel.org,
 da.gomez@samsung.com, david@redhat.com, hughd@google.com,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ryan.roberts@arm.com, wangkefeng.wang@huawei.com, willy@infradead.org,
 ziy@nvidia.com
References: <731904cf-d862-4c0e-ae5b-26444faff253@linux.alibaba.com>
 <53e610af72302667475821e5b3c84c382da4efbc.1740386576.git.baolin.wang@linux.alibaba.com>
 <CAMgjq7D=TKC68PoMhLsJd24_sH5eyJ=o6PsDe6Ne4tAMOi49gw@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAMgjq7D=TKC68PoMhLsJd24_sH5eyJ=o6PsDe6Ne4tAMOi49gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/2/25 01:50, Kairui Song wrote:
> On Mon, Feb 24, 2025 at 4:47 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Alex and Kairui reported some issues (system hang or data corruption) when
>> swapping out or swapping in large shmem folios. This is especially easy to
>> reproduce when the tmpfs is mount with the 'huge=within_size' parameter.
>> Thanks to Kairui's reproducer, the issue can be easily replicated.
>>
>> The root cause of the problem is that swap readahead may asynchronously
>> swap in order 0 folios into the swap cache, while the shmem mapping can
>> still store large swap entries. Then an order 0 folio is inserted into
>> the shmem mapping without splitting the large swap entry, which overwrites
>> the original large swap entry, leading to data corruption.
>>
>> When getting a folio from the swap cache, we should split the large swap
>> entry stored in the shmem mapping if the orders do not match, to fix this
>> issue.
>>
>> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
>> Reported-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
>> Reported-by: Kairui Song <ryncsn@gmail.com>
> 
> Maybe you can add a Closes:?

Yes. Hope Andrew can help add this:

Closes: https://lore.kernel.org/all/1738717785.im3r5g2vxc.none@localhost/

>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/shmem.c | 31 +++++++++++++++++++++++++++----
>>   1 file changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 4ea6109a8043..cebbac97a221 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2253,7 +2253,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>          struct folio *folio = NULL;
>>          bool skip_swapcache = false;
>>          swp_entry_t swap;
>> -       int error, nr_pages;
>> +       int error, nr_pages, order, split_order;
>>
>>          VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
>>          swap = radix_to_swp_entry(*foliop);
>> @@ -2272,10 +2272,9 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>
>>          /* Look it up and read it in.. */
>>          folio = swap_cache_get_folio(swap, NULL, 0);
>> +       order = xa_get_order(&mapping->i_pages, index);
>>          if (!folio) {
>> -               int order = xa_get_order(&mapping->i_pages, index);
>>                  bool fallback_order0 = false;
>> -               int split_order;
>>
>>                  /* Or update major stats only when swapin succeeds?? */
>>                  if (fault_type) {
>> @@ -2339,6 +2338,29 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>                          error = -ENOMEM;
>>                          goto failed;
>>                  }
>> +       } else if (order != folio_order(folio)) {
>> +               /*
>> +                * Swap readahead may swap in order 0 folios into swapcache
>> +                * asynchronously, while the shmem mapping can still stores
>> +                * large swap entries. In such cases, we should split the
>> +                * large swap entry to prevent possible data corruption.
>> +                */
>> +               split_order = shmem_split_large_entry(inode, index, swap, gfp);
>> +               if (split_order < 0) {
>> +                       error = split_order;
>> +                       goto failed;
>> +               }
>> +
>> +               /*
>> +                * If the large swap entry has already been split, it is
>> +                * necessary to recalculate the new swap entry based on
>> +                * the old order alignment.
>> +                */
>> +               if (split_order > 0) {
>> +                       pgoff_t offset = index - round_down(index, 1 << split_order);
>> +
>> +                       swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
>> +               }
>>          }
>>
>>   alloced:
>> @@ -2346,7 +2368,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>          folio_lock(folio);
>>          if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
>>              folio->swap.val != swap.val ||
>> -           !shmem_confirm_swap(mapping, index, swap)) {
>> +           !shmem_confirm_swap(mapping, index, swap) ||
>> +           xa_get_order(&mapping->i_pages, index) != folio_order(folio)) {
>>                  error = -EEXIST;
>>                  goto unlock;
>>          }
>> --
>> 2.43.5
>>
> 
> Thanks for the fix, it works for me.
> 
> Tested-by: Kairui Song <kasong@tencent.com>

Thanks for testing :)

