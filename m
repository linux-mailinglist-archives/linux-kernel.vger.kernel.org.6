Return-Path: <linux-kernel+bounces-173460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D18EE8C00AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6A31C2305B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3E91272B4;
	Wed,  8 May 2024 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cfoR1CMS"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124A386AF4
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181056; cv=none; b=R7363UqtVpJfHzOqfSSMVcDgpo2v8LP6rBvjTNYoNNGuLy7Ud6sezx/mllWQjZPs6hzpx5S3C+tD5GSjzenZN3OYs3BJh6dMUKzIWBIgX6i+U+NGrK146bsT2kOjeugRpvHf9fXLW+Qgabu19a2CN2rYReyrqpL73OFMMFiyznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181056; c=relaxed/simple;
	bh=uebZD5bjHTqePTbmDYihknZkibLWtU/4i9ce5Rjfrrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAS7EwaaMyN5O6/49OA/FSoFlE+1VnoCkc/z0QHTr907o+/XmQD1oIVX5XkxSXZykxmZ28meLNYtHd7gQO6bNw9YXI6tEgQQH2hqzKPVcS0B6HLwXKKkyGqDs9NPsHvXG2zPvQCCsVZpuZtqAecs1dqf4iwI+iqmBib78COhK04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cfoR1CMS; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715181050; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=smDSBA/vyUQe6K9lPTzzQscaImTQDfcc0mDn2ZJNNyw=;
	b=cfoR1CMSuyExqo4HD1ylsizSs+SB3n5jZjZp7rL4tFFD0xDB9ue+nzSjD3fr9KI22GMDIA7jRrpA1XkHTixdExviEhe1zhAZaUGd2ekqfl/4/1BxhjhDVSNiTwgB27LTOXB53g5n8IFaBRw7M3M0TLCrpE19bjbDAbBSC0HtcFI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W63z.gB_1715181046;
Received: from 30.25.222.148(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W63z.gB_1715181046)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 23:10:49 +0800
Message-ID: <90a127e5-d884-44b5-bb76-773a7485c2f1@linux.alibaba.com>
Date: Wed, 8 May 2024 23:10:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
To: Hailong Liu <hailong.liu@oppo.com>
Cc: akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>,
 urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com, 21cnbao@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, xiang@kernel.org,
 chao@kernel.org, Oven <liyangouwen1@oppo.com>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
 <404add29-2d3f-45db-9103-0c5b66fb254e@linux.alibaba.com>
 <20240508144321.ymnhn54daaabalhe@oppo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240508144321.ymnhn54daaabalhe@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/5/8 22:43, Hailong Liu wrote:
> On Wed, 08. May 21:41, Gao Xiang wrote:
>>
>> +Cc Michal,
>>
>> On 2024/5/8 20:58, hailong.liu@oppo.com wrote:
>>> From: "Hailong.Liu" <hailong.liu@oppo.com>
>>>
>>> Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
>>> includes support for __GFP_NOFAIL, but it presents a conflict with
>>> commit dd544141b9eb ("vmalloc: back off when the current task is
>>> OOM-killed"). A possible scenario is as belows:
>>>
>>> process-a
>>> kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
>>>       __vmalloc_node_range()
>>> 	__vmalloc_area_node()
>>> 	    vm_area_alloc_pages()
>>>               --> oom-killer send SIGKILL to process-a
>>>               if (fatal_signal_pending(current)) break;
>>> --> return NULL;
>>>
>>> to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
>>> if __GFP_NOFAIL set.
>>>
>>> Reported-by: Oven <liyangouwen1@oppo.com>
>>> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
>>
>> Why taging this as RFC here?  It seems a corner-case fix of
>> commit a421ef303008
>>
>> Thanks,
>> Gao Xiang
>>
> 
> Hi Gao Xiang:
> 
> RFC here to wait for a better way to handle this case :).
> IMO, if vmalloc support __GFP_NOFAIL it should not return
> null even system is deadlock on memory.

The starting point is that kmalloc doesn't support __GFP_NOFAIL
if order > 1 (even for very short temporary uses), see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/page_alloc.c?h=v6.8#n2896

but it is possible if we have such page pointer array (since two
(order-1) pages can only keep 1024 8-byte entries, it can happen
if compression ratios are high), and kvmalloc(__GFP_NOFAIL) has
already been supported for almost two years, it will fallback to
order-0 allocation as described in commit e9c3cda4d86e
("mm, vmalloc: fix high order __GFP_NOFAIL allocations").

With my limited understanding, I'm not sure why it can cause
deadlock here since it will fallback to order-0 allocation then,
and such allocation is just for short temporary uses again
because kmalloc doesn't support order > 1 short memory
allocation strictly.

Thanks,
Gao Xiang

> 
> --
> 
> Best Regards,
> Hailong.

