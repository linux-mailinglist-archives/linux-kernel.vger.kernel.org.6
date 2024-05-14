Return-Path: <linux-kernel+bounces-178281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F458C4B62
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 05:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DE61C20D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D405B64C;
	Tue, 14 May 2024 03:06:04 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B177D17C2
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 03:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655964; cv=none; b=VHEzUI8j0VC3XUUJ3fwxv0oj/buKrAJtNcY8rP5RCyr2ic+UpzqYu1QbZQQXf6TX288zulBCOcZcdjYz1b3WIuxfT01tjUTv/JX0fARTLFJ9JZo/UOTfyI1YRZ/JlsWn1cfBYMkd9mm5gjrABu9s2ARvxeQeIagbguJ6Yjz2JYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655964; c=relaxed/simple;
	bh=o2d1JoV821tq0V9HXFMEP8TcS85tU86xIDaBNcMvLGU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MizkVQc1/me+2hy+mu1BkgsOdgEuD7ZV47g+vitSslOWTJ14ZBRzOKAPA5uRpb5/4jN/950wE1G155AOE166S/HYhTHkyD9RD7ZDrngDn5i2IdZCEzfotJomxmcyVn4r5e/DYBqu2jFbU6Ie+F8uiBIcIKluIGLuLeaPM92RI+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Vdh3p7237z1S5Vc;
	Tue, 14 May 2024 11:02:30 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 2BE5E180080;
	Tue, 14 May 2024 11:05:58 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 11:05:57 +0800
Subject: Re: [PATCH] mm/huge_memory: mark huge_zero_folio reserved
To: Yang Shi <shy828301@gmail.com>
CC: <akpm@linux-foundation.org>, <nao.horiguchi@gmail.com>,
	<xuyu@linux.alibaba.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240511032801.1295023-1-linmiaohe@huawei.com>
 <CAHbLzkrXRYMj3S+h+zUrrezYrgQYWELcHKmz-VZ=9g0K-o=iPg@mail.gmail.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <94ddebf2-8cfa-b1bb-2241-49f672186946@huawei.com>
Date: Tue, 14 May 2024 11:05:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHbLzkrXRYMj3S+h+zUrrezYrgQYWELcHKmz-VZ=9g0K-o=iPg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/13 23:34, Yang Shi wrote:
> On Fri, May 10, 2024 at 9:31 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
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
>> hwpoisoned folio leading to VM_BUG_ON_PAGE(page_ref_count(page) == 0)
>> when releasing huge_zero_folio.
>>
>> Fix this issue by marking huge_zero_folio reserved. So unpoison_memory()
>> will skip this page. This will make it consistent with ZERO_PAGE case too.
> 
> If I read the code correctly, unpoison_memory() should not dec
> refcount for huge zero page by calling put_page_testzero(). The huge
> zero page's real refcount is actually maintained separately by
> huge_zero_refcount. It is different from the regular refount in struct
> folio, see get_huge_zero_page().

Sure. Huge zero folio should be skipped in unpoison_memory(). It's not supported
anyway. I marked huge_zero_folio reserved in order to let unpoison_memory() skip it
by folio_test_reserved(folio) check. But as David points out, the use of PG_reserve
is limited, so I will find another way to fix the issue.
Thanks.
.

