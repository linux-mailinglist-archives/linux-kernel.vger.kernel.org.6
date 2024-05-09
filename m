Return-Path: <linux-kernel+bounces-174061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE3D8C09D5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106111C217CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2829B146A78;
	Thu,  9 May 2024 02:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m0rQ3P5a"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475C7380
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 02:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715222380; cv=none; b=Yk9i0vnVT44pquw7J+tkcmnckBAMY+vwCyuQyzYVwq75+xFDi6nsbe5EX0xaHoEymP687VfeDPcyzJ0nVNzW7IQAwC9Dnl3vvOuFQsskff7bzzkj4vDak1v7mcYUTV/egu4rNchCpxhCX2WtuULCj150iaK/nXOTkp5BVRJgJSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715222380; c=relaxed/simple;
	bh=sS0PWwSVmuY6ke3uD6YjWPykPsFgxqa8lQhRYGi2Vq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=og+s8NZjZ0AnQt/O5u3k9wpEfzWOTTzEO++9kzK28+5aomrc/5Jr4eCMkDWICxc4AECIfdIOKtXQlGUkzNfp+JJNcNsxSo2m0WxAZl5emTphGnOPoC3ZRKMXjUM9kiCHo7KBHkj3YSr/S57O1n34FyvntLzNB/pRtNvOVoOfQDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m0rQ3P5a; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715222374; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GmlupQEObKD3hcpHsT80fX0O66yCosUf38s2RUlYQ0I=;
	b=m0rQ3P5aZfnpT/UyC+KgxEHsMm2T3l2169NDY8EUboiOq1n2ookzSVngOzCuuHwKPGfB7CT6gSvJ1zKaZ/b6VvB/CcX3nQ1cGrsycwmF6hbL9c25M4LWOPwQDQVKTNLCnegp5pI8DXb7nPUdLXhgM4ZrJ9r4IW0RhIQe/5JtWo4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W65JQwU_1715222372;
Received: from 30.97.48.191(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W65JQwU_1715222372)
          by smtp.aliyun-inc.com;
          Thu, 09 May 2024 10:39:33 +0800
Message-ID: <20d782ad-c059-4029-9c75-0ef278c98d81@linux.alibaba.com>
Date: Thu, 9 May 2024 10:39:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>, hailong.liu@oppo.com
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
 lstoakes@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 xiang@kernel.org, chao@kernel.org, Oven <liyangouwen1@oppo.com>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
 <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2024/5/9 10:20, Barry Song wrote:
> On Thu, May 9, 2024 at 12:58 AM <hailong.liu@oppo.com> wrote:
>>
>> From: "Hailong.Liu" <hailong.liu@oppo.com>
>>
>> Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
>> includes support for __GFP_NOFAIL, but it presents a conflict with
>> commit dd544141b9eb ("vmalloc: back off when the current task is
>> OOM-killed"). A possible scenario is as belows:
>>
>> process-a
>> kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
>>      __vmalloc_node_range()
>>          __vmalloc_area_node()
>>              vm_area_alloc_pages()
>>              --> oom-killer send SIGKILL to process-a
>>              if (fatal_signal_pending(current)) break;
>> --> return NULL;
>>
>> to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
>> if __GFP_NOFAIL set.
>>
>> Reported-by: Oven <liyangouwen1@oppo.com>
>> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
>> ---
>>   mm/vmalloc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 6641be0ca80b..2f359d08bf8d 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -3560,7 +3560,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>
>>          /* High-order pages or fallback path if "bulk" fails. */
>>          while (nr_allocated < nr_pages) {
>> -               if (fatal_signal_pending(current))
>> +               if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
>>                          break;
> 
> why not !nofail ?
> 
> This seems a correct fix, but it undermines the assumption made in
> commit dd544141b9eb
>   ("vmalloc: back off when the current task is OOM-killed")
> 
> "
>      This may trigger some hidden problems, when caller does not handle
>      vmalloc failures, or when rollaback after failed vmalloc calls own
>      vmallocs inside.  However all of these scenarios are incorrect: vmalloc
>      does not guarantee successful allocation, it has never been called with
>      __GFP_NOFAIL and threfore either should not be used for any rollbacks or
>      should handle such errors correctly and not lead to critical failures.
> "
> 
> If a significant kvmalloc operation is performed with the NOFAIL flag, it risks
> reverting the fix intended to address the OOM-killer issue in commit
> dd544141b9eb.
> Should we indeed permit the NOFAIL flag for large kvmalloc allocations?

Just from my perspective, I don't really care about kmalloc, vmalloc
or kvmalloc (__GFP_NOFAIL).  I even don't care if it returns three
order-0 pages or a high-order page.   I just would like to need a
virtual consecutive buffer (even it works slowly.) with __GFP_NOFAIL.

Because in some cases, writing fallback code may be tough and hard to
test if such fallback path is correct since it only triggers in extreme
workloads, and even such buffers are just used in a very short lifetime.
Also see other FS discussion of __GFP_NOFAIL, e.g.
https://lore.kernel.org/all/ZcUQfzfQ9R8X0s47@tiehlicka/

In the worst cases, it usually just needs < 5 order-0 pages (for many
cases it only needs one page), but with kmalloc it will trigger WARN
if it occurs to > order-1 allocation. as I mentioned before.

With my limited understanding I don't see why it could any problem with
kvmalloc(__GFP_NOFAIL) since it has no difference of kmalloc(GFP_NOFAIL)
with order-0 allocation.


Thanks,
Gao XIang

