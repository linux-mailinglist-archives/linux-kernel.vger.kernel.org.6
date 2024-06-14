Return-Path: <linux-kernel+bounces-214149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14241908038
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C1B1C21785
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243BE1C3D;
	Fri, 14 Jun 2024 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eGWo8Zva"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3F236C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718325931; cv=none; b=DWZPrQpZnXLNjZlfuZzmk0VUMA8bINttu2pl6qcuVBUs672i1D0FfShX+QPwmEwK4vYqF3IvIn7hEiUMV5mCEH9ZTFkyHI3pNZmHuwMARhUJKxrnOLUR6ExVuG0suBCBjq37GQArYuW33GJVWpa0p6fGFBCt52xI9SgHfeU1yoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718325931; c=relaxed/simple;
	bh=+jMS/xbYOImcqZhfvBmN0HrXors2OJkh7ZVEIcwy8Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYzU99bLcl3uuC88wqQ7CoXvlPVFtCZNPwy4eJWWZR1tkE4+6r0NAWNa3pLkeYO7qj7188Io2OEBDN87iMtzqxDndcQTv+VIr3v73vn/BbrUUBeLIx3gM9seKbcRQ6B37/04w604Czt0iyadypvGdC++u3S6vZSRJvswzzl/SYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eGWo8Zva; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718325926; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BSHGNJJW9QoXcHWB3k8CQMWS0eij0PY1paTcRNlGmA0=;
	b=eGWo8ZvauAbAiOEB42aoHczSD2QWUGLKEI9iCMrc0DlsBFcIs69CKpdlBOoY+au162myxfeI3n+uVV+4s0bKJxWjlMbmZeyOI9Ue4pg9qbYvbsDQnNBccTqWwBSTUybKXhOKYRDRCUfXDYt70ndnrIjNjkHTb54ldhCJdZiVDWI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W8PHSgM_1718325885;
Received: from 30.97.56.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8PHSgM_1718325885)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 08:45:25 +0800
Message-ID: <03b1c415-b86b-482c-ae9d-f8d0730fafbe@linux.alibaba.com>
Date: Fri, 14 Jun 2024 08:45:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: fix getting incorrect lruvec when replacing a
 shmem folio
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hughd@google.com, hannes@cmpxchg.org,
 nphamcs@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <3c11000dd6c1df83015a8321a859e9775ebbc23e.1718266112.git.baolin.wang@linux.alibaba.com>
 <CAJD7tkYj_+edtqxTWH6Hmakv48Fx0GMUWwvU82L-V8SxmNg2qQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAJD7tkYj_+edtqxTWH6Hmakv48Fx0GMUWwvU82L-V8SxmNg2qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/14 06:24, Yosry Ahmed wrote:
> On Thu, Jun 13, 2024 at 1:21 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> When testing shmem swapin, I encountered the warning below on my machine.
>> The reason is that replacing an old shmem folio with a new one causes
>> mem_cgroup_migrate() to clear the old folio's memcg data. As a result,
>> the old folio cannot get the correct memcg's lruvec needed to remove itself
>> from the LRU list when it is being freed. This could lead to possible serious
>> problems, such as LRU list crashes due to holding the wrong LRU lock, and
>> incorrect LRU statistics.
>>
>> To fix this issue, we can fallback to use the mem_cgroup_replace_folio()
>> to replace the old shmem folio.
>>
>> [ 5241.100311] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5d9960
>> [ 5241.100317] head: order:4 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>> [ 5241.100319] flags: 0x17fffe0000040068(uptodate|lru|head|swapbacked|node=0|zone=2|lastcpupid=0x3ffff)
>> [ 5241.100323] raw: 17fffe0000040068 fffffdffd6687948 fffffdffd69ae008 0000000000000000
>> [ 5241.100325] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>> [ 5241.100326] head: 17fffe0000040068 fffffdffd6687948 fffffdffd69ae008 0000000000000000
>> [ 5241.100327] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>> [ 5241.100328] head: 17fffe0000000204 fffffdffd6665801 ffffffffffffffff 0000000000000000
>> [ 5241.100329] head: 0000000a00000010 0000000000000000 00000000ffffffff 0000000000000000
>> [ 5241.100330] page dumped because: VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled())
>> [ 5241.100338] ------------[ cut here ]------------
>> [ 5241.100339] WARNING: CPU: 19 PID: 78402 at include/linux/memcontrol.h:775 folio_lruvec_lock_irqsave+0x140/0x150
>> [...]
>> [ 5241.100374] pc : folio_lruvec_lock_irqsave+0x140/0x150
>> [ 5241.100375] lr : folio_lruvec_lock_irqsave+0x138/0x150
>> [ 5241.100376] sp : ffff80008b38b930
>> [...]
>> [ 5241.100398] Call trace:
>> [ 5241.100399]  folio_lruvec_lock_irqsave+0x140/0x150
>> [ 5241.100401]  __page_cache_release+0x90/0x300
>> [ 5241.100404]  __folio_put+0x50/0x108
>> [ 5241.100406]  shmem_replace_folio+0x1b4/0x240
>> [ 5241.100409]  shmem_swapin_folio+0x314/0x528
>> [ 5241.100411]  shmem_get_folio_gfp+0x3b4/0x930
>> [ 5241.100412]  shmem_fault+0x74/0x160
>> [ 5241.100414]  __do_fault+0x40/0x218
>> [ 5241.100417]  do_shared_fault+0x34/0x1b0
>> [ 5241.100419]  do_fault+0x40/0x168
>> [ 5241.100420]  handle_pte_fault+0x80/0x228
>> [ 5241.100422]  __handle_mm_fault+0x1c4/0x440
>> [ 5241.100424]  handle_mm_fault+0x60/0x1f0
>> [ 5241.100426]  do_page_fault+0x120/0x488
>> [ 5241.100429]  do_translation_fault+0x4c/0x68
>> [ 5241.100431]  do_mem_abort+0x48/0xa0
>> [ 5241.100434]  el0_da+0x38/0xc0
>> [ 5241.100436]  el0t_64_sync_handler+0x68/0xc0
>> [ 5241.100437]  el0t_64_sync+0x14c/0x150
>> [ 5241.100439] ---[ end trace 0000000000000000 ]---
>>
>> Fixes: 85ce2c517ade ("memcontrol: only transfer the memcg data for migration")
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/shmem.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 99bd3c34f0fb..4acaf02bfe44 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1908,7 +1908,7 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
>>          xa_lock_irq(&swap_mapping->i_pages);
>>          error = shmem_replace_entry(swap_mapping, swap_index, old, new);
>>          if (!error) {
>> -               mem_cgroup_migrate(old, new);
>> +               mem_cgroup_replace_folio(old, new);
> 
> The comment above the definition of mem_cgroup_replace_folio() needs
> to be updated with this change. It mentions that it is only used in
> replace_page_cache_folio(), which is no longer true.

Indeed, will update the related comments in v2. Thanks.

