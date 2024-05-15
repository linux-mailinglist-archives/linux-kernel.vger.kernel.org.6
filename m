Return-Path: <linux-kernel+bounces-179355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92DA8C5F31
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A025E282DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 02:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFDF3D549;
	Wed, 15 May 2024 02:39:14 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9663D0D9
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 02:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715740754; cv=none; b=kDvc6w3G1VuS8Y5VqSYxEM6w/6D685/dyec4UUvkzPm60HR9wtfvg90dFa7GezImVdHes1qTd0GmOfT4iTgfC9wfGsoXD/xNwNqRiTl3oWjv2cONx5Djpd+wAMng+X/uk8TWHhYuNdFazVGBPQsqSAJVSpXaKU1UvSEzw7gS2Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715740754; c=relaxed/simple;
	bh=5iSS9sXfbHYU0cpJ/xFgcqmUkP2JVSCYu+CyTFpzZkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OmqNwqobsLR3jt60RiarPRatGhieUukajpHkOVZ8Dxi3KdjXQIaJmvYkOUVoJRUr8afHX6fRl9zbXqUq9vsDU8e/umee9bLadrCI4z4PhQ++q3juNfBHHO/rGv8GvX5RSQDtMVfxmX7Rfu/udh9ddrInzbZyMmURgahF7c3QAa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VfHR24Qq6z1ynTf;
	Wed, 15 May 2024 10:36:14 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D8BF140154;
	Wed, 15 May 2024 10:39:08 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 15 May
 2024 10:39:07 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>
CC: <shy828301@gmail.com>, <nao.horiguchi@gmail.com>,
	<xuyu@linux.alibaba.com>, <david@redhat.com>, <linmiaohe@huawei.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mm/huge_memory: don't unpoison huge_zero_folio
Date: Wed, 15 May 2024 10:36:07 +0800
Message-ID: <20240515023607.870022-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

When I did memory failure tests recently, below panic occurs:

 kernel BUG at include/linux/mm.h:1135!
 invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 9 PID: 137 Comm: kswapd1 Not tainted 6.9.0-rc4-00491-gd5ce28f156fe-dirty #14
 RIP: 0010:shrink_huge_zero_page_scan+0x168/0x1a0
 RSP: 0018:ffff9933c6c57bd0 EFLAGS: 00000246
 RAX: 000000000000003e RBX: 0000000000000000 RCX: ffff88f61fc5c9c8
 RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff88f61fc5c9c0
 RBP: ffffcd7c446b0000 R08: ffffffff9a9405f0 R09: 0000000000005492
 R10: 00000000000030ea R11: ffffffff9a9405f0 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: ffff88e703c4ac00
 FS:  0000000000000000(0000) GS:ffff88f61fc40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055f4da6e9878 CR3: 0000000c71048000 CR4: 00000000000006f0
 Call Trace:
  <TASK>
  do_shrink_slab+0x14f/0x6a0
  shrink_slab+0xca/0x8c0
  shrink_node+0x2d0/0x7d0
  balance_pgdat+0x33a/0x720
  kswapd+0x1f3/0x410
  kthread+0xd5/0x100
  ret_from_fork+0x2f/0x50
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Modules linked in: mce_inject hwpoison_inject
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:shrink_huge_zero_page_scan+0x168/0x1a0
 RSP: 0018:ffff9933c6c57bd0 EFLAGS: 00000246
 RAX: 000000000000003e RBX: 0000000000000000 RCX: ffff88f61fc5c9c8
 RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff88f61fc5c9c0
 RBP: ffffcd7c446b0000 R08: ffffffff9a9405f0 R09: 0000000000005492
 R10: 00000000000030ea R11: ffffffff9a9405f0 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: ffff88e703c4ac00
 FS:  0000000000000000(0000) GS:ffff88f61fc40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055f4da6e9878 CR3: 0000000c71048000 CR4: 00000000000006f0

The root cause is that HWPoison flag will be set for huge_zero_folio
without increasing the folio refcnt. But then unpoison_memory() will
decrease the folio refcnt unexpectly as it appears like a successfully
hwpoisoned folio leading to VM_BUG_ON_PAGE(page_ref_count(page) == 0)
when releasing huge_zero_folio.

Skip unpoisoning huge_zero_folio in unpoison_memory() to fix this issue.
We're not prepared to unpoison huge_zero_folio yet.

Fixes: 478d134e9506 ("mm/huge_memory: do not overkill when splitting huge_zero_page")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: <stable@vger.kernel.org>
---
v2:
 Change to simply check for the huge zero page. Thanks.
---
 mm/memory-failure.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 16ada4fb02b7..68bc8d7ff53d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2558,6 +2558,12 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
+	if (is_huge_zero_folio(folio)) {
+		unpoison_pr_info("Unpoison: huge zero page is not supported %#lx\n",
+				 pfn, &unpoison_rs);
+		goto unlock_mutex;
+	}
+
 	if (folio_test_slab(folio) || folio_test_pgtable(folio) ||
 	    folio_test_reserved(folio) || folio_test_offline(folio))
 		goto unlock_mutex;
-- 
2.33.0


