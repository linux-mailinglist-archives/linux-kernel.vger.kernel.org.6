Return-Path: <linux-kernel+bounces-250106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F7C92F450
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0851BB21B69
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C93AC8D7;
	Fri, 12 Jul 2024 03:17:48 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC438C0B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720754268; cv=none; b=ITY3qTZv+dkceMaKHxwmIdXPUv+kKx/B4vYqmIckLBvEzBk+HQOD7Tbg2csYAaBRKvxEUPiuK+MA4zbwnEAhynT+EVg1h4QkiRGElVjpgm2gEdNlZQlaGawhcqDUAg59OpwxMU9362LROJFzAWORcB4KZRwVspMVpCutnJqxOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720754268; c=relaxed/simple;
	bh=wKaF5l1dx+R5sG0MMIZb0tHr9Pcg1um8n4IFlhsUwJ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LZuQm69E765Ihgm7X1bw9dSU+g47GjIvh4bfkkaxwiFSGP/HVyPM0wrppWTFs8XhNSMZEoxvkgWuVSwg1YWjRUFOtKAly7SmKCUPEzJnXEWu5CEHAOUmh6wJuDqMXHk3yfepsd/cfhyBFUh+tVwqS3hpY0YdiYL5lR72Xu64iuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WKxVd2l1Dz1T67S;
	Fri, 12 Jul 2024 11:12:57 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 2547818009B;
	Fri, 12 Jul 2024 11:17:42 +0800 (CST)
Received: from huawei.com (10.173.127.72) by kwepemd200019.china.huawei.com
 (7.221.188.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 12 Jul
 2024 11:17:41 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>
CC: <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mm/hugetlb: fix possible recursive locking detected warning
Date: Fri, 12 Jul 2024 11:13:14 +0800
Message-ID: <20240712031314.2570452-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200019.china.huawei.com (7.221.188.193)

When tries to demote 1G hugetlb folios, a lockdep warning is observed:

============================================
WARNING: possible recursive locking detected
6.10.0-rc6-00452-ga4d0275fa660-dirty #79 Not tainted
--------------------------------------------
bash/710 is trying to acquire lock:
ffffffff8f0a7850 (&h->resize_lock){+.+.}-{3:3}, at: demote_store+0x244/0x460

but task is already holding lock:
ffffffff8f0a6f48 (&h->resize_lock){+.+.}-{3:3}, at: demote_store+0xae/0x460

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&h->resize_lock);
  lock(&h->resize_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by bash/710:
 #0: ffff8f118439c3f0 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x64/0xe0
 #1: ffff8f11893b9e88 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_fop_write_iter+0xf8/0x1d0
 #2: ffff8f1183dc4428 (kn->active#98){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x100/0x1d0
 #3: ffffffff8f0a6f48 (&h->resize_lock){+.+.}-{3:3}, at: demote_store+0xae/0x460

stack backtrace:
CPU: 3 PID: 710 Comm: bash Not tainted 6.10.0-rc6-00452-ga4d0275fa660-dirty #79
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x68/0xa0
 __lock_acquire+0x10f2/0x1ca0
 lock_acquire+0xbe/0x2d0
 __mutex_lock+0x6d/0x400
 demote_store+0x244/0x460
 kernfs_fop_write_iter+0x12c/0x1d0
 vfs_write+0x380/0x540
 ksys_write+0x64/0xe0
 do_syscall_64+0xb9/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa61db14887
RSP: 002b:00007ffc56c48358 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fa61db14887
RDX: 0000000000000002 RSI: 000055a030050220 RDI: 0000000000000001
RBP: 000055a030050220 R08: 00007fa61dbd1460 R09: 000000007fffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fa61dc1b780 R14: 00007fa61dc17600 R15: 00007fa61dc16a00
 </TASK>

Lockdep considers this an AA deadlock because the different resize_lock
mutexes reside in the same lockdep class, but this is a false positive.
Place them in distinct classes to avoid these warnings.

Fixes: 8531fc6f52f5 ("hugetlb: add hugetlb demote page support")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
v2:
 move lock_class_key into struct hstate and use __mutex_init per Muchun.
 Thanks.
---
 include/linux/hugetlb.h | 1 +
 mm/hugetlb.c            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 98c2c1106500..b84da6f6ac40 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -649,6 +649,7 @@ HPAGEFLAG(RawHwpUnreliable, raw_hwp_unreliable)
 /* Defines one hugetlb page size */
 struct hstate {
 	struct mutex resize_lock;
+	struct lock_class_key resize_key;
 	int next_nid_to_alloc;
 	int next_nid_to_free;
 	unsigned int order;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 45fd3bc75332..926b89e165bd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4670,7 +4670,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
 	BUG_ON(order < order_base_2(__NR_USED_SUBPAGE));
 	h = &hstates[hugetlb_max_hstate++];
-	mutex_init(&h->resize_lock);
+	__mutex_init(&h->resize_lock, "resize mutex", &h->resize_key);
 	h->order = order;
 	h->mask = ~(huge_page_size(h) - 1);
 	for (i = 0; i < MAX_NUMNODES; ++i)
-- 
2.33.0


