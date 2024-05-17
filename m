Return-Path: <linux-kernel+bounces-181774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CAF8C8125
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F7B1F220DE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 07:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BF614F65;
	Fri, 17 May 2024 07:02:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE57010A1B
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715929320; cv=none; b=HOJ58Xgbmm4cN1tD7x0I9St59VjBp8CXKXaCa++2FPc4vMFr4tC82mtDM77KSfOi4oA4gsi6nv+4HoH8b7p9gguDghNf9oQFfuO6a/sRepsK47wpCPYKL0jCuUBvKoTJfQ4D/86WGPiFpxwpT3xs1j/oBy6khuYZbTUcVhuIhf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715929320; c=relaxed/simple;
	bh=kAYjYYsJ6/944CRMmlWAvYHZSEQ2PMTd1Ly9WBMLWW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+5pugDCRlFcLg4ahLE+cKoV9YCYiIQEc44SPFR649gbOpi7LKQdNNp437ENm3TshEHffEmXi2pnk3Uv10XUhkmjhd6/bbgNhuTpTKDUqi661r1m+lIvQ+epfoS5ePki6stUQt4l2/n6R2GmLm9KXXWXMISx2j3+irS9T5PbYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB8731424;
	Fri, 17 May 2024 00:02:20 -0700 (PDT)
Received: from [10.163.37.42] (unknown [10.163.37.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 833643F7A6;
	Fri, 17 May 2024 00:01:53 -0700 (PDT)
Message-ID: <ea14ad49-b094-451a-8e4f-560010868930@arm.com>
Date: Fri, 17 May 2024 12:32:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/huge_memory: don't unpoison huge_zero_folio
To: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc: shy828301@gmail.com, nao.horiguchi@gmail.com, xuyu@linux.alibaba.com,
 david@redhat.com, osalvador@suse.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240516122608.22610-1-linmiaohe@huawei.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240516122608.22610-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/24 17:56, Miaohe Lin wrote:
> When I did memory failure tests recently, below panic occurs:
> 
>  kernel BUG at include/linux/mm.h:1135!
>  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 9 PID: 137 Comm: kswapd1 Not tainted 6.9.0-rc4-00491-gd5ce28f156fe-dirty #14
>  RIP: 0010:shrink_huge_zero_page_scan+0x168/0x1a0
>  RSP: 0018:ffff9933c6c57bd0 EFLAGS: 00000246
>  RAX: 000000000000003e RBX: 0000000000000000 RCX: ffff88f61fc5c9c8
>  RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff88f61fc5c9c0
>  RBP: ffffcd7c446b0000 R08: ffffffff9a9405f0 R09: 0000000000005492
>  R10: 00000000000030ea R11: ffffffff9a9405f0 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: ffff88e703c4ac00
>  FS:  0000000000000000(0000) GS:ffff88f61fc40000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000055f4da6e9878 CR3: 0000000c71048000 CR4: 00000000000006f0
>  Call Trace:
>   <TASK>
>   do_shrink_slab+0x14f/0x6a0
>   shrink_slab+0xca/0x8c0
>   shrink_node+0x2d0/0x7d0
>   balance_pgdat+0x33a/0x720
>   kswapd+0x1f3/0x410
>   kthread+0xd5/0x100
>   ret_from_fork+0x2f/0x50
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Modules linked in: mce_inject hwpoison_inject
>  ---[ end trace 0000000000000000 ]---
>  RIP: 0010:shrink_huge_zero_page_scan+0x168/0x1a0
>  RSP: 0018:ffff9933c6c57bd0 EFLAGS: 00000246
>  RAX: 000000000000003e RBX: 0000000000000000 RCX: ffff88f61fc5c9c8
>  RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff88f61fc5c9c0
>  RBP: ffffcd7c446b0000 R08: ffffffff9a9405f0 R09: 0000000000005492
>  R10: 00000000000030ea R11: ffffffff9a9405f0 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: ffff88e703c4ac00
>  FS:  0000000000000000(0000) GS:ffff88f61fc40000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000055f4da6e9878 CR3: 0000000c71048000 CR4: 00000000000006f0
> 
> The root cause is that HWPoison flag will be set for huge_zero_folio
> without increasing the folio refcnt. But then unpoison_memory() will
> decrease the folio refcnt unexpectly as it appears like a successfully

Small nit, a typo in here   ^^^^^ s/unexpectly/unexpectedly/.

> hwpoisoned folio leading to VM_BUG_ON_PAGE(page_ref_count(page) == 0)
> when releasing huge_zero_folio.
> 
> Skip unpoisoning huge_zero_folio in unpoison_memory() to fix this issue.
> We're not prepared to unpoison huge_zero_folio yet.
> 
> Fixes: 478d134e9506 ("mm/huge_memory: do not overkill when splitting huge_zero_page")

The target commit looks right.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Cc: <stable@vger.kernel.org>
> ---
> v3:
>  Move up is_huge_zero_folio() check and change return value to
> -EOPNOTSUPP per Oscar.
>  Collect Reviewed-by and Acked-by tag. Thanks.
> v2:
>  Change to simply check for the huge zero page per David. Thanks.
> ---
>  mm/memory-failure.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 16ada4fb02b7..a9fe9eda593f 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2546,6 +2546,13 @@ int unpoison_memory(unsigned long pfn)
>  		goto unlock_mutex;
>  	}
>  
> +	if (is_huge_zero_folio(folio)) {
> +		unpoison_pr_info("Unpoison: huge zero page is not supported %#lx\n",
> +				 pfn, &unpoison_rs);
> +		ret = -EOPNOTSUPP;
> +		goto unlock_mutex;
> +	}
> +
>  	if (!PageHWPoison(p)) {
>  		unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
>  				 pfn, &unpoison_rs);

This patch applies on latest linux-next but not on latest mainline as
is_huge_zero_folio() is absent there.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

