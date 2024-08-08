Return-Path: <linux-kernel+bounces-279497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C531294BDFD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868F01F219C7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5458818C925;
	Thu,  8 Aug 2024 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3SM1eXl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619D1149DFA
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723121693; cv=none; b=loK0ABtUvnx3NWANuEZPPkWXQvuvQ4F9/93Ypf7f89oRicaY49JCNcxRS+sztkCTydEvIbW9+zNXVankDT3ls5jF/80JcsO0qqH5H8neJgkKFbhKxz9Pw9TifjH1iXZUZ3ihllmSHYn07NxJF3EabANAFauWoHW7D5M6Pr10blE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723121693; c=relaxed/simple;
	bh=5uetXJ3+L+RhLKV5z8c9WyUlwsJduAkEGBQHl3zElLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=icukFHNreMQM8Od3q0AoyPqc8QUDwF/tEXe4L12VzCMdoeCPgTBvnlnvphOaeJmK3QTVAxEUfDtbX/9LAveFqOPpyWTjMxgzAS6k+7srOvv4OBeM9EOTX+jDiCiKllydI5serjW1JLLWLOsZf7a1flxWo2q7VhXOdAVqgE4dsyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h3SM1eXl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723121690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kkdFm8UYhX2wGq7WQBwF6R5jAWfsgP28pH4c5ptM2vc=;
	b=h3SM1eXlCrbC/oR+V8fYSS+pe+t0kPgZp9hL6udOUsiWK7bSFNZNycwkG4WBcWfvzsy6NT
	3ZpetGYRi8d5TCjeihEx3zq+qkGETQihqCPYT5a2HSaQl/YFS7uavnaKnislwnoqKRvj7e
	6/3ejfpvj/IfAasBdFh1v8Y/DXoytNw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-QOiLiR0UNkmfzYsQ4Yd9pw-1; Thu,
 08 Aug 2024 08:54:46 -0400
X-MC-Unique: QOiLiR0UNkmfzYsQ4Yd9pw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B07C1944AA4;
	Thu,  8 Aug 2024 12:54:45 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.72])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4FD719560A3;
	Thu,  8 Aug 2024 12:54:43 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>
Cc: linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v3] lib/stackdepot: Double DEPOT_POOLS_CAP if KASAN is enabled
Date: Thu,  8 Aug 2024 08:54:30 -0400
Message-ID: <20240808125430.1172152-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

As said in commit 02754e0a484a ("lib/stackdepot.c: bump stackdepot
capacity from 16MB to 128MB"), KASAN uses stackdepot to memorize stacks
for all kmalloc/kfree calls. So stackdepot capacity was increased 8
times to accommodate KASAN usage even thought it was claimed 4X should
be enough at that time.

With commit fc60e0caa94d ("lib/stackdepot: use fixed-sized slots
for stack records"), all stackdepot records uses a fixed size with
CONFIG_STACKDEPOT_MAX_FRAMES (default=64) entries. This is merged to
support evictable KASAN stack records. Commit 31639fd6cebd ("stackdepot:
use variable size records for non-evictable entries") re-enabled
the use of variable size records for non-KASAN use cases, but KASAN
(generic mode) still uses the large fixed size stack records.

With the default CONFIG_STACKDEPOT_MAX_FRAMES of 64, KASAN use of
stackdepot space had been more than double than before. Assuming an
average stack frame size of 16, a KASAN stack record is almost 4X the
size of a non-KASAN one.

When a wide variety of workloads are run on a debug kernel with KASAN
enabled, the following warning may sometimes be printed.

 [ 6818.650674] Stack depot reached limit capacity
 [ 6818.650730] WARNING: CPU: 1 PID: 272741 at lib/stackdepot.c:252 depot_alloc_stack+0x39e/0x3d0
   :
 [ 6818.650907] Call Trace:
 [ 6818.650909]  [<00047dd453d84b92>] depot_alloc_stack+0x3a2/0x3d0
 [ 6818.650916]  [<00047dd453d85254>] stack_depot_save_flags+0x4f4/0x5c0
 [ 6818.650920]  [<00047dd4535872c6>] kasan_save_stack+0x56/0x70
 [ 6818.650924]  [<00047dd453587328>] kasan_save_track+0x28/0x40
 [ 6818.650927]  [<00047dd45358a27a>] kasan_save_free_info+0x4a/0x70
 [ 6818.650930]  [<00047dd45358766a>] __kasan_slab_free+0x12a/0x1d0
 [ 6818.650933]  [<00047dd45350deb4>] kmem_cache_free+0x1b4/0x580
 [ 6818.650938]  [<00047dd452c520da>] __put_task_struct+0x24a/0x320
 [ 6818.650945]  [<00047dd452c6aee4>] delayed_put_task_struct+0x294/0x350
 [ 6818.650949]  [<00047dd452e9066a>] rcu_do_batch+0x6ea/0x2090
 [ 6818.650953]  [<00047dd452ea60f4>] rcu_core+0x474/0xa90
 [ 6818.650956]  [<00047dd452c780c0>] handle_softirqs+0x3c0/0xf90
 [ 6818.650960]  [<00047dd452c76fbe>] __irq_exit_rcu+0x35e/0x460
 [ 6818.650963]  [<00047dd452c79992>] irq_exit_rcu+0x22/0xb0
 [ 6818.650966]  [<00047dd454bd8128>] do_ext_irq+0xd8/0x120
 [ 6818.650972]  [<00047dd454c0ddd0>] ext_int_handler+0xb8/0xe8
 [ 6818.650979]  [<00047dd453589cf6>] kasan_check_range+0x236/0x2f0
 [ 6818.650982]  [<00047dd453378cf0>] filemap_get_pages+0x190/0xaa0
 [ 6818.650986]  [<00047dd453379940>] filemap_read+0x340/0xa70
 [ 6818.650989]  [<00047dd3d325d226>] xfs_file_buffered_read+0x2c6/0x400 [xfs]
 [ 6818.651431]  [<00047dd3d325dfe2>] xfs_file_read_iter+0x2c2/0x550 [xfs]
 [ 6818.651663]  [<00047dd45364710c>] vfs_read+0x64c/0x8c0
 [ 6818.651669]  [<00047dd453648ed8>] ksys_read+0x118/0x200
 [ 6818.651672]  [<00047dd452b6cf5a>] do_syscall+0x27a/0x380
 [ 6818.651676]  [<00047dd454bd7e74>] __do_syscall+0xf4/0x1a0
 [ 6818.651680]  [<00047dd454c0db58>] system_call+0x70/0x98

With all the recent changes in stackdepot to support new KASAN features,
it is obvious that the current DEPOT_POOLS_CAP of 8192 may not be
enough when KASAN is enabled. Fix this stackdepot capability issue
by doubling DEPOT_POOLS_CAP if KASAN is enabled. With 4k pages, the
maximum stackdepot capacity is doubled to 256 MB with KASAN enabled.

Also use the MIN() macro for defining DEPOT_MAX_POOLS to clarify the
intention.

Fixes: fc60e0caa94d ("lib/stackdepot: use fixed-sized slots for stack records")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/stackdepot.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

 [v3] Include <linux/minmax.h"> to avoid potential undefined macro problem.

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 5ed34cc963fc..1f1673b357b5 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/kmsan.h>
 #include <linux/list.h>
+#include <linux/minmax.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/poison.h>
@@ -36,11 +37,12 @@
 #include <linux/memblock.h>
 #include <linux/kasan-enabled.h>
 
-#define DEPOT_POOLS_CAP 8192
+/* KASAN is a big user of stackdepot, double the cap if KASAN is enabled */
+#define DEPOT_POOLS_CAP (8192 * (IS_ENABLED(CONFIG_KASAN) ? 2 : 1))
+
 /* The pool_index is offset by 1 so the first record does not have a 0 handle. */
 #define DEPOT_MAX_POOLS \
-	(((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
-	 (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)
+	MIN((1LL << (DEPOT_POOL_INDEX_BITS)) - 1, DEPOT_POOLS_CAP)
 
 static bool stack_depot_disabled;
 static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
-- 
2.43.5


