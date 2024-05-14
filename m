Return-Path: <linux-kernel+bounces-178283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE82C8C4B64
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 05:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824621F219A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9EB64C;
	Tue, 14 May 2024 03:07:26 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F65CAD55
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 03:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715656046; cv=none; b=NJYA154MgjMVjAFkSLNKTN0dxNQKlMk7EWhiiWoPTLeGYoR5ZbFTS70vuH6BzT5h+ezwo3Szv/h8cvz1NIVHsmNY6qhf2BP6tL0I1+UT/0mTVUWJi6ECeWnAEB+KImQG3GuQ4fDoCMj9rJI+sX8i4Mg37psiq1pCO2pd3O9h8Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715656046; c=relaxed/simple;
	bh=F2njWTEw3+KoYOErxyCM/MJ9L27NSzGQk1yLIS0vnZ0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QxHSu09YsM60EObkUcLX+n8/OUwfu8NeTdv7ztvhVdIy3x5TKcUz/v8AZcZG4OlEQJjr/vcJQsuF5J1JQ3IkS3kx9y3+YVARPf1Cl+jDCSO0F2W7yggoic7n4lOLHIl+twFLPXLOzzCydt8rBR6UmC4/k1QT3Dr80SOFC1hVjBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Vdh5T5p1Zz1RJPr;
	Tue, 14 May 2024 11:03:57 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id BB218140360;
	Tue, 14 May 2024 11:07:19 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 11:07:19 +0800
Subject: Re: [PATCH] mm/huge_memory: mark huge_zero_folio reserved
To: David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC: <shy828301@gmail.com>, <nao.horiguchi@gmail.com>,
	<xuyu@linux.alibaba.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240511032801.1295023-1-linmiaohe@huawei.com>
 <1ca64fc3-1b96-466e-aa25-a8f9f6805edc@redhat.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2b5e2b42-7fa6-ab51-494a-0414d1c75290@huawei.com>
Date: Tue, 14 May 2024 11:07:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1ca64fc3-1b96-466e-aa25-a8f9f6805edc@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/13 23:40, David Hildenbrand wrote:
> On 11.05.24 05:28, Miaohe Lin wrote:
>> When I did memory failure tests recently, below panic occurs:
>>
>>   kernel BUG at include/linux/mm.h:1135!
>>   invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>>   CPU: 9 PID: 137 Comm: kswapd1 Not tainted 6.9.0-rc4-00491-gd5ce28f156fe-dirty #14
>>   RIP: 0010:shrink_huge_zero_page_scan+0x168/0x1a0
>>   RSP: 0018:ffff9933c6c57bd0 EFLAGS: 00000246
>>   RAX: 000000000000003e RBX: 0000000000000000 RCX: ffff88f61fc5c9c8
>>   RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff88f61fc5c9c0
>>   RBP: ffffcd7c446b0000 R08: ffffffff9a9405f0 R09: 0000000000005492
>>   R10: 00000000000030ea R11: ffffffff9a9405f0 R12: 0000000000000000
>>   R13: 0000000000000000 R14: 0000000000000000 R15: ffff88e703c4ac00
>>   FS:  0000000000000000(0000) GS:ffff88f61fc40000(0000) knlGS:0000000000000000
>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: 000055f4da6e9878 CR3: 0000000c71048000 CR4: 00000000000006f0
>>   Call Trace:
>>    <TASK>
>>    do_shrink_slab+0x14f/0x6a0
>>    shrink_slab+0xca/0x8c0
>>    shrink_node+0x2d0/0x7d0
>>    balance_pgdat+0x33a/0x720
>>    kswapd+0x1f3/0x410
>>    kthread+0xd5/0x100
>>    ret_from_fork+0x2f/0x50
>>    ret_from_fork_asm+0x1a/0x30
>>    </TASK>
>>   Modules linked in: mce_inject hwpoison_inject
>>   ---[ end trace 0000000000000000 ]---
>>   RIP: 0010:shrink_huge_zero_page_scan+0x168/0x1a0
>>   RSP: 0018:ffff9933c6c57bd0 EFLAGS: 00000246
>>   RAX: 000000000000003e RBX: 0000000000000000 RCX: ffff88f61fc5c9c8
>>   RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff88f61fc5c9c0
>>   RBP: ffffcd7c446b0000 R08: ffffffff9a9405f0 R09: 0000000000005492
>>   R10: 00000000000030ea R11: ffffffff9a9405f0 R12: 0000000000000000
>>   R13: 0000000000000000 R14: 0000000000000000 R15: ffff88e703c4ac00
>>   FS:  0000000000000000(0000) GS:ffff88f61fc40000(0000) knlGS:0000000000000000
>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: 000055f4da6e9878 CR3: 0000000c71048000 CR4: 00000000000006f0
>>
>> The root cause is that HWPoison flag will be set for huge_zero_folio
>> without increasing the folio refcnt. But then unpoison_memory() will
>> decrease the folio refcnt unexpectly as it appears like a successfully
>> hwpoisoned folio leading to VM_BUG_ON_PAGE(page_ref_count(page) == 0)
>> when releasing huge_zero_folio.
>>
>> Fix this issue by marking huge_zero_folio reserved. So unpoison_memory()
>> will skip this page. This will make it consistent with ZERO_PAGE case too.
>>
>> Fixes: 478d134e9506 ("mm/huge_memory: do not overkill when splitting huge_zero_page")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>   mm/huge_memory.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 317de2afd371..d508ff793145 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -212,6 +212,7 @@ static bool get_huge_zero_page(void)
>>           folio_put(zero_folio);
>>           goto retry;
>>       }
>> +    __folio_set_reserved(zero_folio);
> 
> We want to limit/remove the use of PG_reserve. Please find a different way (e.g., simply checking for the huge zero page directly).

I see. Will drop this patch and find another one.
Thanks.
.



