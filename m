Return-Path: <linux-kernel+bounces-215692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D377F9095ED
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 05:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62161C21BE1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 03:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A123DDDC;
	Sat, 15 Jun 2024 03:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I/K+Qbk9"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D800D502
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 03:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718423417; cv=none; b=FXFcS1Nbaycc2b3XuVk8nkUpzNz/LaW9UO2GJX1o3d9JFtEqZu4ylZ8VvolPZiIiMT+Y9RJTyvhCh95xj5yIWitMnxTOTnYvRkPc+28SCOxBWQYO84yExx2ZhisfpqUB1VL93w6pRSnJryWpF9bVK9mOOLtKpJ1P73nrlPU0hJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718423417; c=relaxed/simple;
	bh=jtzSl7eCWM99+KaJ9+9rcukc22zH4iB/trYcC6ShkaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ozTeSiIuuuby6gBS1soWxjVQURVY8xs0VqOdSVdP6wDvOg1q5M40HUKHOrpdmHt5LEAj8XJlqki5dtShiiz8SQMJm4WnHAcN5cGyS1FFg2wWGwvoGex7lrUYcfSLNTUA3QIwPJhDg8dbAPH4QxZEO5NNtOGH3aKMqzq6BdUm/Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I/K+Qbk9; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718423407; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=qyDcsqG1G9+ch9xsh4NPmqEryYrFj8x1o1BGt5MbPo0=;
	b=I/K+Qbk9vTHuyzQ+AQAqMuKQmnAzFqx985JuDFu+lS/fkqGmoWgnAXLP6XgL4kJHZ8m0EtVUxhk6YwZ3CR830/58cIoRjFQIrrMufAU1mMLFl/KjouL1NHFT24SwoC0tA9dts7TXV1ym0lrkiVPHcDxrModhPXOlC5s0UaNek7g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W8SZ6-6_1718423405;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8SZ6-6_1718423405)
          by smtp.aliyun-inc.com;
          Sat, 15 Jun 2024 11:50:06 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	hannes@cmpxchg.org,
	nphamcs@gmail.com,
	yosryahmed@google.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm: shmem: fix getting incorrect lruvec when replacing a shmem folio
Date: Sat, 15 Jun 2024 11:49:54 +0800
Message-Id: <ccad3fe1375b468ebca3227b6b729f3eaf9d8046.1718423197.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When testing shmem swapin, I encountered the warning below on my machine.
The reason is that replacing an old shmem folio with a new one causes
mem_cgroup_migrate() to clear the old folio's memcg data. As a result,
the old folio cannot get the correct memcg's lruvec needed to remove itself
from the LRU list when it is being freed. This could lead to possible serious
problems, such as LRU list crashes due to holding the wrong LRU lock, and
incorrect LRU statistics.

To fix this issue, we can fallback to use the mem_cgroup_replace_folio()
to replace the old shmem folio.

[ 5241.100311] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5d9960
[ 5241.100317] head: order:4 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[ 5241.100319] flags: 0x17fffe0000040068(uptodate|lru|head|swapbacked|node=0|zone=2|lastcpupid=0x3ffff)
[ 5241.100323] raw: 17fffe0000040068 fffffdffd6687948 fffffdffd69ae008 0000000000000000
[ 5241.100325] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[ 5241.100326] head: 17fffe0000040068 fffffdffd6687948 fffffdffd69ae008 0000000000000000
[ 5241.100327] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[ 5241.100328] head: 17fffe0000000204 fffffdffd6665801 ffffffffffffffff 0000000000000000
[ 5241.100329] head: 0000000a00000010 0000000000000000 00000000ffffffff 0000000000000000
[ 5241.100330] page dumped because: VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled())
[ 5241.100338] ------------[ cut here ]------------
[ 5241.100339] WARNING: CPU: 19 PID: 78402 at include/linux/memcontrol.h:775 folio_lruvec_lock_irqsave+0x140/0x150
[...]
[ 5241.100374] pc : folio_lruvec_lock_irqsave+0x140/0x150
[ 5241.100375] lr : folio_lruvec_lock_irqsave+0x138/0x150
[ 5241.100376] sp : ffff80008b38b930
[...]
[ 5241.100398] Call trace:
[ 5241.100399]  folio_lruvec_lock_irqsave+0x140/0x150
[ 5241.100401]  __page_cache_release+0x90/0x300
[ 5241.100404]  __folio_put+0x50/0x108
[ 5241.100406]  shmem_replace_folio+0x1b4/0x240
[ 5241.100409]  shmem_swapin_folio+0x314/0x528
[ 5241.100411]  shmem_get_folio_gfp+0x3b4/0x930
[ 5241.100412]  shmem_fault+0x74/0x160
[ 5241.100414]  __do_fault+0x40/0x218
[ 5241.100417]  do_shared_fault+0x34/0x1b0
[ 5241.100419]  do_fault+0x40/0x168
[ 5241.100420]  handle_pte_fault+0x80/0x228
[ 5241.100422]  __handle_mm_fault+0x1c4/0x440
[ 5241.100424]  handle_mm_fault+0x60/0x1f0
[ 5241.100426]  do_page_fault+0x120/0x488
[ 5241.100429]  do_translation_fault+0x4c/0x68
[ 5241.100431]  do_mem_abort+0x48/0xa0
[ 5241.100434]  el0_da+0x38/0xc0
[ 5241.100436]  el0t_64_sync_handler+0x68/0xc0
[ 5241.100437]  el0t_64_sync+0x14c/0x150
[ 5241.100439] ---[ end trace 0000000000000000 ]---

Fixes: 85ce2c517ade ("memcontrol: only transfer the memcg data for migration")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
---
Changes from v2:
 - Remove the less helpful comments, per Matthew.

Changes from v1:
 - Add reviewed tag from Shakeel.
 - Update related comments, per Yosry.
---
 mm/memcontrol.c | 3 +--
 mm/shmem.c      | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a811dfff10cd..c976db6a34c0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7780,8 +7780,7 @@ void __mem_cgroup_uncharge_folios(struct folio_batch *folios)
  * @new: Replacement folio.
  *
  * Charge @new as a replacement folio for @old. @old will
- * be uncharged upon free. This is only used by the page cache
- * (in replace_page_cache_folio()).
+ * be uncharged upon free.
  *
  * Both folios must be locked, @new->mapping must be set up.
  */
diff --git a/mm/shmem.c b/mm/shmem.c
index 99bd3c34f0fb..4acaf02bfe44 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1908,7 +1908,7 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	xa_lock_irq(&swap_mapping->i_pages);
 	error = shmem_replace_entry(swap_mapping, swap_index, old, new);
 	if (!error) {
-		mem_cgroup_migrate(old, new);
+		mem_cgroup_replace_folio(old, new);
 		__lruvec_stat_mod_folio(new, NR_FILE_PAGES, 1);
 		__lruvec_stat_mod_folio(new, NR_SHMEM, 1);
 		__lruvec_stat_mod_folio(old, NR_FILE_PAGES, -1);
-- 
2.39.3


