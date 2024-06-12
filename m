Return-Path: <linux-kernel+bounces-210972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2E2904B81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C370C1F22D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9372A167D87;
	Wed, 12 Jun 2024 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xZun7ONV"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A2D13CAA7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718173403; cv=none; b=DxJaCrPcuBb6SKDwQA2VzCGSerfgpSFAcnTcFPZllFnMMR4UYzhtupv41dVmxi/7eKoFcUh7znKIn+fkKHnnlDC26auxqWL+8NnAK3qs2sf/s22N3lPyhPORAOLMF27Xqoqi6CucAzYQ4Aq7CfCmn2sCrdkVcZvsnUvMM4h8748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718173403; c=relaxed/simple;
	bh=icd9nxjBubTTVN7BCWPA9XGhyGP3xyxo01FV3QQfzoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToRGzowA3dK3ZVvhadHMQmJ7C476P5LZ/R8SZpCx5+cCLhZFK7RN/kbULOz2S6cwDBqSOg77s3hPb6BVyrbAK16/Td1ANWcYwDpBOxFPNAS8KmcfiyPu2BaFMS5WY2DTKrXtTn9KJpsHLwi69cshvc1PjsPf+DHn4XvixwMo7rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xZun7ONV; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718173398; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VkbxeyTbzZHZmW5pIOy78DIOXXvghz5goTacRzjkGcY=;
	b=xZun7ONVSp59YHlaF88XlpNhvWvx/mKEtjYh0DtNHEnG8liZK5fDiONRvL6q5kop37pXvLyRsjefAGf5CYStfFI/p7O4D+773IYlMrvwVK5QjfdgY+6d+dA89bxHCZ061BFx4Z0a7O8maFVRYtQ1ttftealY+/zXVBj435jTUlI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W8J9Tpa_1718173396;
Received: from 30.97.56.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8J9Tpa_1718173396)
          by smtp.aliyun-inc.com;
          Wed, 12 Jun 2024 14:23:17 +0800
Message-ID: <3d8087e4-ff84-48cc-823a-a6ce2a3c76b4@linux.alibaba.com>
Date: Wed, 12 Jun 2024 14:23:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] support large folio swap-out and swap-in for shmem
To: Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
 wangkefeng.wang@huawei.com, chrisl@kernel.org, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
 <7477de0e-e5bb-529d-e2c0-cabd0d39fb5c@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <7477de0e-e5bb-529d-e2c0-cabd0d39fb5c@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hugh,

On 2024/6/12 13:46, Hugh Dickins wrote:
> On Thu, 6 Jun 2024, Baolin Wang wrote:
> 
>> Shmem will support large folio allocation [1] [2] to get a better performance,
>> however, the memory reclaim still splits the precious large folios when trying
>> to swap-out shmem, which may lead to the memory fragmentation issue and can not
>> take advantage of the large folio for shmeme.
>>
>> Moreover, the swap code already supports for swapping out large folio without
>> split, and large folio swap-in[3] series is queued into mm-unstable branch.
>> Hence this patch set also supports the large folio swap-out and swap-in for
>> shmem.
>>
>> [1] https://lore.kernel.org/all/cover.1717495894.git.baolin.wang@linux.alibaba.com/
>> [2] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
>> [3] https://lore.kernel.org/all/20240508224040.190469-6-21cnbao@gmail.com/T/
>>
>> Changes from RFC:
>>   - Rebased to the latest mm-unstable.
>>   - Drop the counter name fixing patch, which was queued into mm-hotfixes-stable
>>   branch.
>>
>> Baolin Wang (7):
>>    mm: vmscan: add validation before spliting shmem large folio
>>    mm: swap: extend swap_shmem_alloc() to support batch SWAP_MAP_SHMEM
>>      flag setting
>>    mm: shmem: support large folio allocation for shmem_replace_folio()
>>    mm: shmem: extend shmem_partial_swap_usage() to support large folio
>>      swap
>>    mm: add new 'orders' parameter for find_get_entries() and
>>      find_lock_entries()
>>    mm: shmem: use swap_free_nr() to free shmem swap entries
>>    mm: shmem: support large folio swap out
>>
>>   drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  1 +
>>   include/linux/swap.h                      |  4 +-
>>   include/linux/writeback.h                 |  1 +
>>   mm/filemap.c                              | 27 ++++++-
>>   mm/internal.h                             |  4 +-
>>   mm/shmem.c                                | 58 ++++++++------
>>   mm/swapfile.c                             | 98 ++++++++++++-----------
>>   mm/truncate.c                             |  8 +-
>>   mm/vmscan.c                               | 22 ++++-
>>   9 files changed, 140 insertions(+), 83 deletions(-)
> 
> I wanted to have some tests running, while looking through these
> and your shmem mTHP patches; but I wasted too much time on that by
> applying these on top and hitting crash, OOMs and dreadful thrashing -
> testing did not get very far at all.

Thanks for testing. I am sorry I haven't found the issues with my testing.

> Perhaps all easily fixed, but I don't have more time to spend on it,
> and think this series cannot expect to go into 6.11: I'll have another
> try with it next cycle.
> 
> I really must turn my attention to your shmem mTHP series: no doubt
> I'll have minor adjustments to ask there - but several other people
> are also waiting for me to respond (or given up on me completely).

Sure. Thanks.

> 
> The little crash fix needed in this series appears to be:
> 
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2053,7 +2053,8 @@ static int shmem_swapin_folio(struct ino
>   			goto failed;
>   	}
>   
> -	error = shmem_add_to_page_cache(folio, mapping, index,
> +	error = shmem_add_to_page_cache(folio, mapping,
> +					round_down(index, nr_pages),
>   					swp_to_radix_entry(swap), gfp);
>   	if (error)
>   		goto failed;

Good catch. I missed this.

> Then the OOMs and dreadful thrashing are due to refcount confusion:
> I did not even glance at these patches to work out what's wanted,
> but a printk in __remove_mapping() showed that folio->_refcount was
> 1024 where 513 was expected, so reclaim was freeing none of them.

I will look at this issue and continue to do more tesing before sending 
out new version. Thanks.

