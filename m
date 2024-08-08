Return-Path: <linux-kernel+bounces-278808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14CA94B51A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1892C1C219FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDB710A0D;
	Thu,  8 Aug 2024 02:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gR4k/6B2"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671E66FD3
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 02:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723084591; cv=none; b=JWes92VztHBudm/6CLM+gmR9DbOqYd5F1YE+eGOnMZzkjJb3Ml0tZnf2uSbZ4laXcATDxE+qQVSM2k7weC3uUYQqpNavfepFwXMjbNxPaHl66vtE17HPxuNP/NbqJXhfd7nqhwlp1gOG3QnNhtk+Nn6h6105Q920eprIF4eG4Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723084591; c=relaxed/simple;
	bh=LzDaylF58Y5zN7ATdNqsblRv3CaCo4hRcpqI3f1QiPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRpBzAqF31xm8gmUQ2ZIFUzytc31bFf0nbtlY+zogKhK012f5HzZYi8AI8CXEjtmLoyGJD7S/a+fB4vFU2Jm/BmhPS/ThDToRgTNVici34plVNNtHMwqhlrcD99zndDBk3M9HgSU6mFf+xuz1tZouqLFwl7lUq7wComGHEtmmo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gR4k/6B2; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723084586; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sHZf1TKI4hLp1MRx/aWYi50im0zJyFHjeew/2bwGL58=;
	b=gR4k/6B2PncpDA61CpkDVjhib30iFxIA5YbnEMJ9D/xm6lTPdqsR/0OUfKCZdhiRz7oTKeCC8rFM+r7XP9XRBCkfraj1ELYEkV883pXDIz7xaUx4k+nG5lF1lvrpaddZqlQRswkq+8x1Q9WH0ZNfauoH4Y+0w8hFZlEzlCEOcqA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032019045;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0WCKj0tT_1723084583;
Received: from 30.97.56.61(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCKj0tT_1723084583)
          by smtp.aliyun-inc.com;
          Thu, 08 Aug 2024 10:36:24 +0800
Message-ID: <770190a2-3938-4ba9-9aaf-7320b34addf4@linux.alibaba.com>
Date: Thu, 8 Aug 2024 10:36:23 +0800
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <9b45a0dc-fa12-428a-8702-c7690c26aedc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/7 23:53, David Hildenbrand wrote:
> On 07.08.24 09:31, Baolin Wang wrote:
>> Page reclaim will not scan anon LRU if no swap space, however 
>> MADV_PAGEOUT
>> can still split shmem large folios even without a swap device. Thus add
>> swap available space validation before spliting shmem large folio to
>> avoid redundant split.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/vmscan.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 31d13462571e..796f65781f4f 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1259,6 +1259,14 @@ static unsigned int shrink_folio_list(struct 
>> list_head *folio_list,
>>               }
>>           } else if (folio_test_swapbacked(folio) &&
>>                  folio_test_large(folio)) {
>> +
>> +            /*
>> +             * Do not split shmem folio if no swap memory
>> +             * available.
>> +             */
>> +            if (!total_swap_pages)
>> +                goto activate_locked;
>> +
>>               /* Split shmem folio */
>>               if (split_folio_to_list(folio, folio_list))
>>                   goto keep_locked;
> 
> Reminds me of
> 
> commit 9a976f0c847b67d22ed694556a3626ed92da0422
> Author: Luis Chamberlain <mcgrof@kernel.org>
> Date:   Thu Mar 9 15:05:43 2023 -0800
> 
>      shmem: skip page split if we're not reclaiming
>      In theory when info->flags & VM_LOCKED we should not be getting
>      shem_writepage() called so we should be verifying this with a
>      WARN_ON_ONCE().  Since we should not be swapping then best to 
> ensure we
>      also don't do the folio split earlier too.  So just move the check 
> early
>      to avoid folio splits in case its a dubious call.
>      We also have a similar early bail when !total_swap_pages so just 
> move that
>      earlier to avoid the possible folio split in the same situation.
> 
> 
> But indeed, pageout() -> writepage() is called *after* the split in the 
> vmscan path.
> 
> In that "noswap" context, I wonder if we also want to skip folios part 
> of shmem
> with disabled swapping?

Yes, I think so.

> 
> But now I am wondering under which circumstances we end up calling
> shmem_writepage() with a large folio. And I think the answer is the 
> comment of
> folio_test_large(): via drivers/gpu/drm/i915/gem/i915_gem_shmem.c.
> 
> 
> ... so if shmem_writepage() handles+checks that, could we do
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a332cb80e928..7dfa3d6e8ba7 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1257,11 +1257,6 @@ static unsigned int shrink_folio_list(struct 
> list_head *folio_list,
>                                                  goto 
> activate_locked_split;
>                                  }
>                          }
> -               } else if (folio_test_swapbacked(folio) &&
> -                          folio_test_large(folio)) {
> -                       /* Split shmem folio */
> -                       if (split_folio_to_list(folio, folio_list))
> -                               goto keep_locked;
>                  }
> 
>                  /*
> 
> instead?

Seems reasonable to me. But we should pass the 'folio_list' to 
shmem_writepage() to list the subpages of the large folio. Let me try. 
Thanks.

