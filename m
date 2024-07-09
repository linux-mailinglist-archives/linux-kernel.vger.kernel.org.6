Return-Path: <linux-kernel+bounces-245768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BB992B8F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B313D1C234E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FF815749E;
	Tue,  9 Jul 2024 12:03:11 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C728B156F45
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526591; cv=none; b=hTVGW+4L89ugM1aXWGxszGG5Sbj3x/Yf9ltJq6dUKddczIwwgv4Qz7i/i+zhkN/8MfvzQzxw5kh85tem7XiKLje3a1sJbCuJ9HqslHcoW4IqlAPJqFj2FkC0gxWlhdZ6zr7Cm6HLgwXHmaHLKXrGIrvrpFWiGTcPP9EEDAgkmeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526591; c=relaxed/simple;
	bh=1T7XXFEjJHde71OZCvZH01GVRsYLohPr7Cc7VeQO0Fg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i2Xy47VmFiWf8Lfc8NIovpOEkaeFPsM9Qxy4RL9daHSq0Tz0oJMUScumtrF7LIVEd/SXUDJtaEYxWuWqIcGHFj3UsNdFglE+hSamgaV0GwzOR7ezyqLYiNr5TIdhGK36gP7DqeqAtHtQ8xmnnJsIFLkbqN5bjbBpqVostAkTk7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WJKJQ0VBgzxVnq;
	Tue,  9 Jul 2024 19:58:30 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 30D961402C6;
	Tue,  9 Jul 2024 20:03:04 +0800 (CST)
Received: from huawei.com (10.173.127.72) by kwepemd200019.china.huawei.com
 (7.221.188.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Jul
 2024 20:03:03 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>, <hughd@google.com>,
	<willy@infradead.org>
CC: <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/hugetlb: fix kernel NULL pointer dereference when migrating hugetlb folio
Date: Tue, 9 Jul 2024 19:58:41 +0800
Message-ID: <20240709115841.4098393-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200019.china.huawei.com (7.221.188.193)

A kernel crash was observed when migrating hugetlb folio:

BUG: kernel NULL pointer dereference, address: 0000000000000008
PGD 0 P4D 0
Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
CPU: 0 PID: 3435 Comm: bash Not tainted 6.10.0-rc6-00450-g8578ca01f21f #66
RIP: 0010:__folio_undo_large_rmappable+0x70/0xb0
RSP: 0018:ffffb165c98a7b38 EFLAGS: 00000097
RAX: fffffbbc44528090 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffffa30e000a2800 RSI: 0000000000000246 RDI: ffffa3153ffffcc0
RBP: fffffbbc44528000 R08: 0000000000002371 R09: ffffffffbe4e5868
R10: 0000000000000001 R11: 0000000000000001 R12: ffffa3153ffffcc0
R13: fffffbbc44468000 R14: 0000000000000001 R15: 0000000000000001
FS:  00007f5b3a716740(0000) GS:ffffa3151fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000010959a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __folio_migrate_mapping+0x59e/0x950
 __migrate_folio.constprop.0+0x5f/0x120
 move_to_new_folio+0xfd/0x250
 migrate_pages+0x383/0xd70
 soft_offline_page+0x2ab/0x7f0
 soft_offline_page_store+0x52/0x90
 kernfs_fop_write_iter+0x12c/0x1d0
 vfs_write+0x380/0x540
 ksys_write+0x64/0xe0
 do_syscall_64+0xb9/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5b3a514887
RSP: 002b:00007ffe138fce68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007f5b3a514887
RDX: 000000000000000c RSI: 0000556ab809ee10 RDI: 0000000000000001
RBP: 0000556ab809ee10 R08: 00007f5b3a5d1460 R09: 000000007fffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
R13: 00007f5b3a61b780 R14: 00007f5b3a617600 R15: 00007f5b3a616a00

It's because hugetlb folio is passed to __folio_undo_large_rmappable()
unexpectedly. large_rmappable flag is imperceptibly set to hugetlb folio
since commit f6a8dd98a2ce ("hugetlb: convert alloc_buddy_hugetlb_folio to
use a folio"). Then commit be9581ea8c05 ("mm: fix crashes from deferred
split racing folio migration") makes folio_migrate_mapping() call
folio_undo_large_rmappable() triggering the bug. Fix this issue by
clearing large_rmappable flag for hugetlb folios. They don't need that
flag set anyway.

Fixes: f6a8dd98a2ce ("hugetlb: convert alloc_buddy_hugetlb_folio to use a folio")
Fixes: be9581ea8c05 ("mm: fix crashes from deferred split racing folio migration")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: <stable@vger.kernel.org>
---
 mm/hugetlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6282dd9e37e3..4e288757da19 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2173,6 +2173,8 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 		nid = numa_mem_id();
 retry:
 	folio = __folio_alloc(gfp_mask, order, nid, nmask);
+	/* Ensure hugetlb folio won't have large_rmappable flag set. */
+	folio_clear_large_rmappable(folio);
 
 	if (folio && !folio_ref_freeze(folio, 1)) {
 		folio_put(folio);
-- 
2.33.0


