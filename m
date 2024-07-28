Return-Path: <linux-kernel+bounces-264684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DCF93E70F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 18:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E222C1F22838
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 16:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9FF1369AA;
	Sun, 28 Jul 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VySlUyLl"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D1379949
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181773; cv=none; b=be7yLudpImEsRNaUWW7lLUa9zBCdT5TdBUrbDuElslr3IUQiMwHmC1Rm3yMSQSsT8TzFi85LpHasqilvbrXvkGv2AO6E+fEzQ0yGjzJb78mUe3PkTbjv7bM9rI6q5gcQBuyXGmASX7BeOB3J0QXH/1IxW9AaueBklPCdHVh0QLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181773; c=relaxed/simple;
	bh=maqzGLV+sYrXpdZ7VzLPu8G6cFVD5SsERpz4MgzAgm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=awO7LZ8ua+mYtPVcjYvCMYstltGL6oI82B2HwegKgT+q8Wn8yyO8jOpZpRhCzuKXYcE/BGgXT5i7l18eTc9KZJHpgrSJ4EovPl/0d77qvxuhVR6YIaxX/EA6/vFfatIagf9MZ2w4GRHBMjVzedavYn+2kZr6UA5N9jQNXS6JWWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VySlUyLl; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722181761; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WgYmjMqCjYqawZ/h4czTOK84/E4VgAwzs1x+AoLE7Eo=;
	b=VySlUyLlwDcwKeiv6OzHsVJfpKj8QDVnMAjq9GMU84x+g/+jY/TOxAuwgvdQMQIa3Tx37BOgNTsgllxjaezmAp1NKdPbSt5C9jh8fC/A6Gtaz/u/E/qLtCftNKCtZUwVwpqQqkM3BkyTJ3w+AMWnX6sfaQm3jWooYJpfpbro3Xc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0WBRR1Kv_1722181756;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WBRR1Kv_1722181756)
          by smtp.aliyun-inc.com;
          Sun, 28 Jul 2024 23:49:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] mm/migrate: fix deadlock in migrate_pages_batch() on large folios
Date: Sun, 28 Jul 2024 23:49:13 +0800
Message-ID: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, migrate_pages_batch() can lock multiple locked folios
with an arbitrary order.  Although folio_trylock() is used to avoid
deadlock as commit 2ef7dbb26990 ("migrate_pages: try migrate in batch
asynchronously firstly") mentioned, it seems try_split_folio() is
still missing.

It was found by compaction stress test when I explicitly enable EROFS
compressed files to use large folios, which case I cannot reproduce with
the same workload if large folio support is off (current mainline).
Typically, filesystem reads (with locked file-backed folios) could use
another bdev/meta inode to load some other I/Os (e.g. inode extent
metadata or caching compressed data), so the locking order will be:

  file-backed folios  (A)
     bdev/meta folios (B)

The following calltrace shows the deadlock:
   Thread 1 takes (B) lock and tries to take folio (A) lock
   Thread 2 takes (A) lock and tries to take folio (B) lock

[Thread 1]
INFO: task stress:1824 blocked for more than 30 seconds.
      Tainted: G           OE      6.10.0-rc7+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:stress          state:D stack:0     pid:1824  tgid:1824  ppid:1822   flags:0x0000000c
Call trace:
 __switch_to+0xec/0x138
 __schedule+0x43c/0xcb0
 schedule+0x54/0x198
 io_schedule+0x44/0x70
 folio_wait_bit_common+0x184/0x3f8
			<-- folio mapping ffff00036d69cb18 index 996  (**)
 __folio_lock+0x24/0x38
 migrate_pages_batch+0x77c/0xea0	// try_split_folio (mm/migrate.c:1486:2)
						// migrate_pages_batch (mm/migrate.c:1734:16)
		<--- LIST_HEAD(unmap_folios) has
			..
			folio mapping 0xffff0000d184f1d8 index 1711;   (*)
			folio mapping 0xffff0000d184f1d8 index 1712;
			..
 migrate_pages+0xb28/0xe90
 compact_zone+0xa08/0x10f0
 compact_node+0x9c/0x180
 sysctl_compaction_handler+0x8c/0x118
 proc_sys_call_handler+0x1a8/0x280
 proc_sys_write+0x1c/0x30
 vfs_write+0x240/0x380
 ksys_write+0x78/0x118
 __arm64_sys_write+0x24/0x38
 invoke_syscall+0x78/0x108
 el0_svc_common.constprop.0+0x48/0xf0
 do_el0_svc+0x24/0x38
 el0_svc+0x3c/0x148
 el0t_64_sync_handler+0x100/0x130
 el0t_64_sync+0x190/0x198

[Thread 2]
INFO: task stress:1825 blocked for more than 30 seconds.
      Tainted: G           OE      6.10.0-rc7+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:stress          state:D stack:0     pid:1825  tgid:1825  ppid:1822   flags:0x0000000c
Call trace:
 __switch_to+0xec/0x138
 __schedule+0x43c/0xcb0
 schedule+0x54/0x198
 io_schedule+0x44/0x70
 folio_wait_bit_common+0x184/0x3f8
			<-- folio = 0xfffffdffc6b503c0 (mapping == 0xffff0000d184f1d8 index == 1711) (*)
 __folio_lock+0x24/0x38
 z_erofs_runqueue+0x384/0x9c0 [erofs]
 z_erofs_readahead+0x21c/0x350 [erofs]       <-- folio mapping 0xffff00036d69cb18 range from [992, 1024] (**)
 read_pages+0x74/0x328
 page_cache_ra_order+0x26c/0x348
 ondemand_readahead+0x1c0/0x3a0
 page_cache_sync_ra+0x9c/0xc0
 filemap_get_pages+0xc4/0x708
 filemap_read+0x104/0x3a8
 generic_file_read_iter+0x4c/0x150
 vfs_read+0x27c/0x330
 ksys_pread64+0x84/0xd0
 __arm64_sys_pread64+0x28/0x40
 invoke_syscall+0x78/0x108
 el0_svc_common.constprop.0+0x48/0xf0
 do_el0_svc+0x24/0x38
 el0_svc+0x3c/0x148
 el0t_64_sync_handler+0x100/0x130
 el0t_64_sync+0x190/0x198

Fixes: 5dfab109d519 ("migrate_pages: batch _unmap and _move")
Cc: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mm/migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 20cb9f5f7446..a912e4b83228 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1483,7 +1483,8 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
 {
 	int rc;
 
-	folio_lock(folio);
+	if (!folio_trylock(folio))
+		return -EAGAIN;
 	rc = split_folio_to_list(folio, split_folios);
 	folio_unlock(folio);
 	if (!rc)
-- 
2.43.5


