Return-Path: <linux-kernel+bounces-303084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFAD96072D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FA4281057
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3316619F49D;
	Tue, 27 Aug 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TYFvP4eE"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3293019E827
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724753430; cv=none; b=USIfFefdesSTQ9Qfbgw75iiyt6/4AIH9mL+4tg70fpv7rspnRdtdVQbvTaKQToBJ6GfX9LFcA2Cu8O7KEMWTGiIV+9IoUAJetUW+yNaWVn/lOfUDl2tKmtt1depZa0ufzSUQq9ln0aBJ43D/T2WNPdVXKNp+UP0NMQiXs7xkqDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724753430; c=relaxed/simple;
	bh=gPRcIzAMNr+JeXIECog1DfT2gR0VRMcaIqns7lUrzPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0yiJC1IHKX4BQ2WLcGWa1178TdDj5BpLbE+BVecVrkawHRv1tG7eI8rq3CTvVgCHwSiZdb3Dkb4s/CYhKo9bWP1ZW+pZ0zvrbrOj8C+34blSpGW0Y/PEyicVFIM9YjkJlfLEkf7qt/NcvuSI2bvQ+y4cCFuZSNp3VaGrLrn3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TYFvP4eE; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724753419; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ou3bjpEChI48ZQpT6TYUHo44QIRK5xoY4E0swvvgkLA=;
	b=TYFvP4eEhWXt/JFKAs4aDfDox6LlBx5V6mvs2/zgkIk2f3tZytpjV1hboNSOrXkCdPuKVdEAPGNypjEIT/BL4DhJBhJmig0GRN5eQbBngFAEoq/ECy2VLnNBSjT53Jihw5TvVCBPMI7TKfNndLu5OgEaTsD3uNoattQ1lFIZU3E=
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WDmBZfY_1724753417)
          by smtp.aliyun-inc.com;
          Tue, 27 Aug 2024 18:10:17 +0800
Message-ID: <3c020874-4cf3-418c-b89b-4e6ed158e5b9@linux.alibaba.com>
Date: Tue, 27 Aug 2024 18:10:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] mm: filemap: use xa_get_order() to get the swap
 entry order
To: Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
 wangkefeng.wang@huawei.com, chrisl@kernel.org, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1723434324.git.baolin.wang@linux.alibaba.com>
 <6876d55145c1cc80e79df7884aa3a62e397b101d.1723434324.git.baolin.wang@linux.alibaba.com>
 <d3dc75e2-40a7-8439-734c-19d83707164c@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <d3dc75e2-40a7-8439-734c-19d83707164c@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/26 05:55, Hugh Dickins wrote:
> On Mon, 12 Aug 2024, Baolin Wang wrote:
> 
>> In the following patches, shmem will support the swap out of large folios,
>> which means the shmem mappings may contain large order swap entries, so
>> using xa_get_order() to get the folio order of the shmem swap entry to
>> update the '*start' correctly.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/filemap.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 4130be74f6fd..4c312aab8b1f 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -2056,6 +2056,8 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
>>   		folio = fbatch->folios[idx];
>>   		if (!xa_is_value(folio))
>>   			nr = folio_nr_pages(folio);
>> +		else
>> +			nr = 1 << xa_get_order(&mapping->i_pages, indices[idx]);
>>   		*start = indices[idx] + nr;
>>   	}
>>   	return folio_batch_count(fbatch);
>> @@ -2120,6 +2122,8 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
>>   		folio = fbatch->folios[idx];
>>   		if (!xa_is_value(folio))
>>   			nr = folio_nr_pages(folio);
>> +		else
>> +			nr = 1 << xa_get_order(&mapping->i_pages, indices[idx]);
>>   		*start = indices[idx] + nr;
>>   	}
>>   	return folio_batch_count(fbatch);
>> -- 
> 
> Here we have a problem, but I'm not suggesting a fix for it yet: I
> need to get other fixes out first, then turn to thinking about this -
> it's not easy.

Thanks for raising the issues.

> 
> That code is almost always right, so it works well enough for most
> people not to have noticed, but there are two issues with it.
> 
> The first issue is that it's assuming indices[idx] is already aligned
> to nr: not necessarily so.  I believe it was already wrong in the
> folio_nr_pages() case, but the time I caught it wrong with a printk
> was in the swap (value) case.  (I may not be stating this correctly:
> again more thought needed but I can't spend so long writing.)
> 
> And immediately afterwards that kernel build failed with a corrupted
> (all 0s) .o file - I'm building on ext4 on /dev/loop0 on huge tmpfs while
> swapping, and happen to be using the "-o discard" option to ext4 mount.
> 
> I've been chasing these failures (maybe a few minutes in, maybe half an
> hour) for days, then had the idea of trying without the "-o discard":
> whereupon these builds can be repeated successfully for many hours.
> IIRC ext4 discard to /dev/loop0 entails hole-punch to the tmpfs.
> 
> The alignment issue can easily be corrected, but that might not help.
> (And those two functions would look better with the rcu_read_unlock()
> moved down to just before returning: but again, wouldn't really help.)
> 
> The second issue is that swap is more slippery to work with than
> folios or pages: in the folio_nr_pages() case, that number is stable
> because we hold a refcount (which stops a THP from being split), and
> later we'll be taking folio lock too.  None of that in the swap case,
> so (depending on how a large entry gets split) the xa_get_order() result
> is not reliable. Likewise for other uses of xa_get_order() in this series.

Now we have 2 users of xa_get_order() in this series:

1) shmem_partial_swap_usage(): this is acceptable, since racy results 
are not a problem for the swap statistics.

2) shmem_undo_range(): when freeing a large swap entry, it will use 
xa_cmpxchg_irq() to make sure the swap value is not changed (in case the 
large swap entry is split). If failed to cmpxchg, then it will use 
current index to retry in shmem_undo_range(). So seems not too bad?

static long shmem_free_swap(struct address_space *mapping,
                             pgoff_t index, void *radswap)
{
         int order = xa_get_order(&mapping->i_pages, index);
         void *old;

         old = xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
         if (old != radswap)
                 return 0;
         free_swap_and_cache_nr(radix_to_swp_entry(radswap), 1 << order);

         return 1 << order;
}


> There needs to be some kind of locking or retry to make the order usable,
> and to avoid shmem_free_swap() occasionally freeing more than it ought.
> I'll give it thought after.

