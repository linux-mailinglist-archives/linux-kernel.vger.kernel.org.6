Return-Path: <linux-kernel+bounces-280330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E6C94C8D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED881F21DF6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E10E1804E;
	Fri,  9 Aug 2024 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jue3zfs6"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CB618030
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723173718; cv=none; b=XL1CkOqa55cYAb0508YZWOWs/HWYEO6pSn7dlRl6PsHJIKvtJEYJsewTB+glSF47SY4BIj4ZCtXdrbBW/IMGy9z4LA+DuW4epIRTAZA7/a3KiCxw+Ym1+oS18L10O5ibscmplNoz3OZvxLoe22XEbfDJlBc1qcBuY67d5EF5UAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723173718; c=relaxed/simple;
	bh=5Tt9gefz0BPZ3/0aSFv6tYoyc5qqp4i5ETjQ91j24BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCWa5p+ztPCchbdmRtF7YPZdfYwey34omKJOYZPfrXpjQuH3ojkBCNL53ROXOP5yeqJrhmFqHj3MbjGDHkBZpuRpcWIIivIbJgLaTbGZh82R+vYfFUm4+pNZoDf8+VXAtsTV43JQNUwEzEEUeuVKDME/CItYLGw18nDiL2zAB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jue3zfs6; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723173707; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=o3+daKyS6PNz4SJpNYca26OEG08l3lxmqfUQ1bbDfA8=;
	b=Jue3zfs6ATHj6xdCJaC8IPMm+6TuZMhImiks3WzK6/fWr30vKVWvBEqiH2qLDQq2iVXOTEINarnMdY1aV6xxbvImqjelrNV3RXzBcLLcf30TbO7J0OFMNJI65uI3YXED5fAD2v4aHAICKb5y4ry/RMW1P/oGOtPjfgDEr7rhUvo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0WCOQeJj_1723173704;
Received: from 30.97.56.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCOQeJj_1723173704)
          by smtp.aliyun-inc.com;
          Fri, 09 Aug 2024 11:21:45 +0800
Message-ID: <97516c66-ddb0-4bf6-a827-1b052bb5eca0@linux.alibaba.com>
Date: Fri, 9 Aug 2024 11:21:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] mm: vmscan: add validation before spliting shmem
 large folio
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 hughd@google.com, wangkefeng.wang@huawei.com, chrisl@kernel.org,
 ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
 shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com,
 da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>
References: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
 <8a8c6dc9df0bc9f6f7f937bea446062be19611b3.1723012159.git.baolin.wang@linux.alibaba.com>
 <9b45a0dc-fa12-428a-8702-c7690c26aedc@redhat.com>
 <770190a2-3938-4ba9-9aaf-7320b34addf4@linux.alibaba.com>
 <ZrS7qvQj8gP-fhrR@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZrS7qvQj8gP-fhrR@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/8 20:35, Matthew Wilcox wrote:
> On Thu, Aug 08, 2024 at 10:36:23AM +0800, Baolin Wang wrote:
>> On 2024/8/7 23:53, David Hildenbrand wrote:
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
>>>                                                   goto
>>> activate_locked_split;
>>>                                   }
>>>                           }
>>> -               } else if (folio_test_swapbacked(folio) &&
>>> -                          folio_test_large(folio)) {
>>> -                       /* Split shmem folio */
>>> -                       if (split_folio_to_list(folio, folio_list))
>>> -                               goto keep_locked;
>>>                   }
>>>
>>>                   /*
>>>
>>> instead?
>>
>> Seems reasonable to me. But we should pass the 'folio_list' to
>> shmem_writepage() to list the subpages of the large folio. Let me try.
>> Thanks.
> 
> We should be trying to remove shmem_writepage(), not make it more
> complex.  We're making good progress removing instances of ->writepage;
> just ceph, ecryptfs, f2fs, gfs2, hostfs, nilfs2, orangefs, vboxsf, shmem
> & swap are left.  gfs2 patches are out for review.

I am afraid shmem is a bit special. IIUC, ->writepages() is used to 
write back some dirty pages from the mapping by the writeback flusher 
thread, but shmem cannot be written back (mapping_can_writeback() will 
return false). Therefore, shmem can only be reclaimed through direct 
reclaim or kswapd if a swap device is set up (if no swap, shmem should 
always be kept in memory). So currently, we should still keep 
shmem_writepage() to reclaim shmem pages.

> As you can see from previous patches, the approach is to use
> ->writepages instead of ->writepage.  There should be no need to
> handle a folio split list as splitting a folio leaves the folios in the
> page cache and they'll naturally be found by subsequent iterations.

Again, shmem is special. If shmem folio is reclaimable (when a swap 
device is set up), we need to allocate contiguous swap entries for large 
folios. However, if there is significant fragmentation of swap entries 
(there is already a topic to talk about this issue), we will not able to 
allocate contiguous swap entries for large shmem folios. Therefore, in 
this case, it is necessary to split the large shmem folio in order to 
try to allocate a singe swap entry for reclaiming shmem.

