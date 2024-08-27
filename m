Return-Path: <linux-kernel+bounces-302730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE229602A0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0905F1F21B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A77915531B;
	Tue, 27 Aug 2024 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="P6Alwok6"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB965153BF6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741929; cv=none; b=BQVRo8C4quT8XMKhQLd+f3wGbfkT1/gmwL0wZvCrx9nt3QQOYda+fhBFtnpKtV6L+vLrwOGQxR7PNqUDjkvQDTsdGXPGJlF5cace7/uxl+yrFHCd8egdWdpVTLd+ecrXF63CoEiv9HJ/9QqRouPSUp9AM0gI9QGXejsQ4fHYckA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741929; c=relaxed/simple;
	bh=8cCBudVCG5gqfk8qgkzYYW/keDsJsUtEn6KupVvzMt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esoolq/pWVKL1Bui+O4eRs+DYH7iG5+djFxfRcTlpjRY+ORi4+1AHRbNAlksNRGsSwFkOy9EIZ0S85uHzu6mbvrqxEiFCtrGYCIY17K8rydK1cfmq7LiToebM5t++cVRPI5TxPlC+hlJJVevs0lwVRMTfz2J8bSi9wD8nTd1agY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=P6Alwok6; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724741923; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=R2jZq5gOpcCxh3fyRzRIu9IKJVOLCHrHSDqAuNqGBV8=;
	b=P6Alwok6CvKPFPhGgPP8+uJhPY2B1aDU57KVajbcfZZzNhuQNc9eOVGhF9qL5NBZ7rFeGjYUxCBTcWh13go7YD/4Hu00kOrPLEEu85Ob4mcF086/9XR9nympu0k+XCF5RDqrYveLsbUkO/DvjKoBCD2Qwb1eWxaSeLbsVaCqn1c=
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WDlUe9c_1724741920)
          by smtp.aliyun-inc.com;
          Tue, 27 Aug 2024 14:58:41 +0800
Message-ID: <16327571-3031-4758-a401-2b5f19c3196b@linux.alibaba.com>
Date: Tue, 27 Aug 2024 14:58:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] mm: shmem: support large folio swap out
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 chrisl@kernel.org, ying.huang@intel.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com,
 ioworker0@gmail.com, da.gomez@samsung.com, p.raghav@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1723434324.git.baolin.wang@linux.alibaba.com>
 <d80c21abd20e1b0f5ca66b330f074060fb2f082d.1723434324.git.baolin.wang@linux.alibaba.com>
 <aef55f8d-6040-692d-65e3-16150cce4440@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <aef55f8d-6040-692d-65e3-16150cce4440@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/26 07:14, Hugh Dickins wrote:
> On Mon, 12 Aug 2024, Baolin Wang wrote:
> 
>> Shmem will support large folio allocation [1] [2] to get a better performance,
>> however, the memory reclaim still splits the precious large folios when trying
>> to swap out shmem, which may lead to the memory fragmentation issue and can not
>> take advantage of the large folio for shmeme.
>>
>> Moreover, the swap code already supports for swapping out large folio without
>> split, hence this patch set supports the large folio swap out for shmem.
>>
>> Note the i915_gem_shmem driver still need to be split when swapping, thus
>> add a new flag 'split_large_folio' for writeback_control to indicate spliting
>> the large folio.
> 
> Is that last paragraph a misunderstanding? The i915 THP splitting in
> shmem_writepage() was to avoid mm VM_BUG_ONs and crashes when shmem.c
> did not support huge page swapout: but now you are enabling that support,
> and such VM_BUG_ONs and crashes are gone (so far as I can see: and this
> is written on a laptop using the i915 driver).

Thanks for the history, and I understand.

> I cannot think of why i915 itself would care how mm implements swapout
> (beyond enjoying faster): I think all the wbc->split_large_folio you
> introduce here should be reverted.  But you may know better!
> 
> I do need a further change to shmem_writepage() here: see fixup patch
> below: that's written to apply on top of this 9/9, but I'd be glad to
> see a replacement with wbc->split_large_folio gone, and just one
> !IS_ENABLED(CONFIG_THP_SWAP) instead.

Sure. After Andrew queuing your fixes, I can send a proper fix patch to 
remove the 'wbc->split_large_folio'.

>> [1] https://lore.kernel.org/all/cover.1717495894.git.baolin.wang@linux.alibaba.com/
>> [2] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
> 
> I get "Not found" for that [2] link.

Weird, I can access the link, not sure why.

> 
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  1 +
>>   include/linux/writeback.h                 |  4 +++
>>   mm/shmem.c                                | 12 ++++++---
>>   mm/vmscan.c                               | 32 ++++++++++++++++++-----
>>   4 files changed, 38 insertions(+), 11 deletions(-)
> 
> [PATCH] mm: shmem: shmem_writepage() split folio at EOF before swapout
> 
> Working in a constrained (size= or nr_blocks=) huge=always tmpfs relies
> on swapout to split a large folio at EOF, to trim off its excess before
> hitting premature ENOSPC: shmem_unused_huge_shrink() contains no code to
> handle splitting huge swap blocks, and nobody would want that to be added.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>   mm/shmem.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 37c300f69baf..4dd0570962fa 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1459,6 +1459,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>   	swp_entry_t swap;
>   	pgoff_t index;
>   	int nr_pages;
> +	bool split = false;
>   
>   	/*
>   	 * Our capabilities prevent regular writeback or sync from ever calling
> @@ -1480,8 +1481,20 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>   	 * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "always" or
>   	 * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
>   	 * and its shmem_writeback() needs them to be split when swapping.
> +	 *
> +	 * And shrinkage of pages beyond i_size does not split swap, so
> +	 * swapout of a large folio crossing i_size needs to split too
> +	 * (unless fallocate has been used to preallocate beyond EOF).
>   	 */
> -	if (wbc->split_large_folio && folio_test_large(folio)) {
> +	if (folio_test_large(folio)) {
> +		split = wbc->split_large_folio;
> +		index = shmem_fallocend(inode,
> +			DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));
> +		if (index > folio->index && index < folio_next_index(folio))
> +			split = true;
> +	}
> +
> +	if (split) {
>   try_split:
>   		/* Ensure the subpages are still dirty */
>   		folio_test_set_dirty(folio);

Thanks for the fix, Hugh. Very appreciated for your reviewing.

