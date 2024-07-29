Return-Path: <linux-kernel+bounces-264995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE093EAFA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578931F21FDC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0760741C6D;
	Mon, 29 Jul 2024 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NYPINvmJ"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403BD14293
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219197; cv=none; b=ED+z5JFzKqQxM4WMZKT2s6fCtxc/2L/2hcEn6HAGG7pTrwWK0Il05ts+mheQIkIghvwGjgsoQB6DjAjGIdsRrB6Bas+/pfVU8jVbHtv/J7IJAVE5Ny9DU8eWlSFragO8aeQIYJhvf9dDRwTFbn8IAovGFi+qj4GSyd/zXXpbEV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219197; c=relaxed/simple;
	bh=saRzDzb72d9prGKO0LKRmQf9WX98H6mWYUS/SDPr7IM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrU9WAN+3okGba2E5mHpsp9w2yxoTIOlIYbnNotEbWvFImdJAeZAMU9K0iO5EaMx0jmDFXKmfVSSqMtlqXJ7kzzS5371ZS5xdtFrzf+nZJ8eK/B2krqzsTbk+5q6TyMf3h5fE1MPJyQdN3YffmpUsqJdN+sFx8xPRibJlTZUvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NYPINvmJ; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722219191; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MRCm7n66FO+9l/wEfF3ozr0nEPDyX9jY+ChFJjsEldM=;
	b=NYPINvmJn1YgbtIkFlCT6HIerp4EQG4o/nf1Uixx8g1j3/mKXoI27gzZ8mGaxkwgmqXp1yDcA9F7Owg1+K0YxOLmI+8B5P1Z3F/9UlnPcmNqAE1SZ1DpIwiTfRg1c9KpCrQhS+5kysS4/ZX5OnrjEPv2kqlKtaVp2iibt8ZoZ30=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0WBSZeMA_1722219186;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WBSZeMA_1722219186)
          by smtp.aliyun-inc.com;
          Mon, 29 Jul 2024 10:13:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] mm/migrate: fix deadlock in migrate_pages_batch() on large folios
Date: Mon, 29 Jul 2024 10:13:06 +0800
Message-ID: <20240729021306.398286-1-hsiangkao@linux.alibaba.com>
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
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/20240728154913.4023977-1-hsiangkao@linux.alibaba.com
changes since v1:
 - pass in migrate_mode suggested by Huang, Ying:
     https://lore.kernel.org/r/87plqx0yh2.fsf@yhuang6-desk2.ccr.corp.intel.com

 mm/migrate.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 20cb9f5f7446..15c4330e40cd 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1479,11 +1479,17 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 	return rc;
 }
 
-static inline int try_split_folio(struct folio *folio, struct list_head *split_folios)
+static inline int try_split_folio(struct folio *folio, struct list_head *split_folios,
+				  enum migrate_mode mode)
 {
 	int rc;
 
-	folio_lock(folio);
+	if (mode == MIGRATE_ASYNC) {
+		if (!folio_trylock(folio))
+			return -EAGAIN;
+	} else {
+		folio_lock(folio);
+	}
 	rc = split_folio_to_list(folio, split_folios);
 	folio_unlock(folio);
 	if (!rc)
@@ -1677,7 +1683,7 @@ static int migrate_pages_batch(struct list_head *from,
 			 */
 			if (nr_pages > 2 &&
 			   !list_empty(&folio->_deferred_list)) {
-				if (try_split_folio(folio, split_folios) == 0) {
+				if (!try_split_folio(folio, split_folios, mode)) {
 					nr_failed++;
 					stats->nr_thp_failed += is_thp;
 					stats->nr_thp_split += is_thp;
@@ -1699,7 +1705,7 @@ static int migrate_pages_batch(struct list_head *from,
 			if (!thp_migration_supported() && is_thp) {
 				nr_failed++;
 				stats->nr_thp_failed++;
-				if (!try_split_folio(folio, split_folios)) {
+				if (!try_split_folio(folio, split_folios, mode)) {
 					stats->nr_thp_split++;
 					stats->nr_split++;
 					continue;
@@ -1731,7 +1737,7 @@ static int migrate_pages_batch(struct list_head *from,
 				stats->nr_thp_failed += is_thp;
 				/* Large folio NUMA faulting doesn't split to retry. */
 				if (is_large && !nosplit) {
-					int ret = try_split_folio(folio, split_folios);
+					int ret = try_split_folio(folio, split_folios, mode);
 
 					if (!ret) {
 						stats->nr_thp_split += is_thp;
-- 
2.43.5


