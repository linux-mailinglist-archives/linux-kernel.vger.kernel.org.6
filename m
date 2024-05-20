Return-Path: <linux-kernel+bounces-183331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5078C97BF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31A61C212EB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45928F6E;
	Mon, 20 May 2024 02:11:05 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5C4846F
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171065; cv=none; b=NcGobFjbm7VS86K6lo9joFj4+ouEHKcZadk6tRtlZU0usZ+WnODAzyAG7ZOMdWwMxyuy64vB6itaUPyYQOsRcTRwJFbihKeta+jDB+w1bykcNqYfkfmdt6Cpp/PA+Zywy7MLW7kP9BBfTnPWB2esGRAaVNIZilkIXMQsbvpZqec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171065; c=relaxed/simple;
	bh=miUdmcBqKeDRj8AnGR/foiCS2IzGwHXXEpkL9eJbLJQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GMsBRqUSSKGMXyaCaUlpus634u7c4USdMKQhG9ofKbuMIF3JlOuvFGnr+r4wylBKxSyRlnBCSPF9Qggj8LmONYNqAbjiO3HAZEjrrVfMU3KIbPBgBiTqnyQFMhz+F5atVcy9Zzo9dG2gnQdvEaVO6L3Vx/IlBCeWl3G766FFa8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VjL754m2SzhZLv;
	Mon, 20 May 2024 09:48:01 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DDEE1402E0;
	Mon, 20 May 2024 09:51:55 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 09:51:46 +0800
Subject: Re: [PATCH v3] mm/huge_memory: don't unpoison huge_zero_folio
To: Anshuman Khandual <anshuman.khandual@arm.com>, <akpm@linux-foundation.org>
CC: <shy828301@gmail.com>, <nao.horiguchi@gmail.com>,
	<xuyu@linux.alibaba.com>, <david@redhat.com>, <osalvador@suse.de>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240516122608.22610-1-linmiaohe@huawei.com>
 <ea14ad49-b094-451a-8e4f-560010868930@arm.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a35c210c-13ac-751d-8733-466157718bd5@huawei.com>
Date: Mon, 20 May 2024 09:51:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ea14ad49-b094-451a-8e4f-560010868930@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/17 15:02, Anshuman Khandual wrote:
> On 5/16/24 17:56, Miaohe Lin wrote:
>> When I did memory failure tests recently, below panic occurs:
>>
>>  kernel BUG at include/linux/mm.h:1135!
>>  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>>  CPU: 9 PID: 137 Comm: kswapd1 Not tainted 6.9.0-rc4-00491-gd5ce28f156fe-dirty #14
>>  RIP: 0010:shrink_huge_zero_page_scan+0x168/0x1a0
>>  RSP: 0018:ffff9933c6c57bd0 EFLAGS: 00000246
>>  RAX: 000000000000003e RBX: 0000000000000000 RCX: ffff88f61fc5c9c8
>>  RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff88f61fc5c9c0
>>  RBP: ffffcd7c446b0000 R08: ffffffff9a9405f0 R09: 0000000000005492
>>  R10: 00000000000030ea R11: ffffffff9a9405f0 R12: 0000000000000000
>>  R13: 0000000000000000 R14: 0000000000000000 R15: ffff88e703c4ac00
>>  FS:  0000000000000000(0000) GS:ffff88f61fc40000(0000) knlGS:0000000000000000
>>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>  CR2: 000055f4da6e9878 CR3: 0000000c71048000 CR4: 00000000000006f0
>>  Call Trace:
>>   <TASK>
>>   do_shrink_slab+0x14f/0x6a0
>>   shrink_slab+0xca/0x8c0
>>   shrink_node+0x2d0/0x7d0
>>   balance_pgdat+0x33a/0x720
>>   kswapd+0x1f3/0x410
>>   kthread+0xd5/0x100
>>   ret_from_fork+0x2f/0x50
>>   ret_from_fork_asm+0x1a/0x30
>>   </TASK>
>>  Modules linked in: mce_inject hwpoison_inject
>>  ---[ end trace 0000000000000000 ]---
>>  RIP: 0010:shrink_huge_zero_page_scan+0x168/0x1a0
>>  RSP: 0018:ffff9933c6c57bd0 EFLAGS: 00000246
>>  RAX: 000000000000003e RBX: 0000000000000000 RCX: ffff88f61fc5c9c8
>>  RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff88f61fc5c9c0
>>  RBP: ffffcd7c446b0000 R08: ffffffff9a9405f0 R09: 0000000000005492
>>  R10: 00000000000030ea R11: ffffffff9a9405f0 R12: 0000000000000000
>>  R13: 0000000000000000 R14: 0000000000000000 R15: ffff88e703c4ac00
>>  FS:  0000000000000000(0000) GS:ffff88f61fc40000(0000) knlGS:0000000000000000
>>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>  CR2: 000055f4da6e9878 CR3: 0000000c71048000 CR4: 00000000000006f0
>>
>> The root cause is that HWPoison flag will be set for huge_zero_folio
>> without increasing the folio refcnt. But then unpoison_memory() will
>> decrease the folio refcnt unexpectly as it appears like a successfully
> 
> Small nit, a typo in here   ^^^^^ s/unexpectly/unexpectedly/.

Thanks for finding out this typo. And thanks Andrew for fixing the typo.

> 
>> hwpoisoned folio leading to VM_BUG_ON_PAGE(page_ref_count(page) == 0)
>> when releasing huge_zero_folio.
>>
>> Skip unpoisoning huge_zero_folio in unpoison_memory() to fix this issue.
>> We're not prepared to unpoison huge_zero_folio yet.
>>
>> Fixes: 478d134e9506 ("mm/huge_memory: do not overkill when splitting huge_zero_page")
> 
> The target commit looks right.
> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Yang Shi <shy828301@gmail.com>
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>> Cc: <stable@vger.kernel.org>
>> ---
>> v3:
>>  Move up is_huge_zero_folio() check and change return value to
>> -EOPNOTSUPP per Oscar.
>>  Collect Reviewed-by and Acked-by tag. Thanks.
>> v2:
>>  Change to simply check for the huge zero page per David. Thanks.
>> ---
>>  mm/memory-failure.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 16ada4fb02b7..a9fe9eda593f 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2546,6 +2546,13 @@ int unpoison_memory(unsigned long pfn)
>>  		goto unlock_mutex;
>>  	}
>>  
>> +	if (is_huge_zero_folio(folio)) {
>> +		unpoison_pr_info("Unpoison: huge zero page is not supported %#lx\n",
>> +				 pfn, &unpoison_rs);
>> +		ret = -EOPNOTSUPP;
>> +		goto unlock_mutex;
>> +	}
>> +
>>  	if (!PageHWPoison(p)) {
>>  		unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
>>  				 pfn, &unpoison_rs);
> 
> This patch applies on latest linux-next but not on latest mainline as
> is_huge_zero_folio() is absent there.

It could be simply replaced with is_huge_zero_page().

> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks.
.


