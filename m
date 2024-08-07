Return-Path: <linux-kernel+bounces-278299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C294AE72
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C603CB22D79
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E9B13A3F6;
	Wed,  7 Aug 2024 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIuuX2eN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD28136E30
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049576; cv=none; b=FUruNMhQQafJfnwnr0A2Te0wofV2SaxaJnojj11zBcGRMGuAhrmv68M/YNJf5s2m8Np6jNWnDeCI3x0/gux4gFPBfGCqpuc7xofBEejKj1e4ca/5KxzBFVSpS6CFO//ftdd2hNwlo0vsPOu4nmG9VQr6GOAWjTeQFYSZcHQqYn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049576; c=relaxed/simple;
	bh=sSQP/GxMEMdHcZwqZ9xAYRv4kUVybtVuwfJ3EdupNHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPM5j1+0Sb5TNtd6PPuxliXz+wfRqBlklGRKyB9ELQOftjCMyOZ1RN/B/3GPjaH1o5P1x2FUWgPokYT2yv0F7Q3OKtLDVYAm0WsxItsCVyJ0OkHcXov37ZgFkcfluPWLu67puXZe1na9of/jaZUbJSUfztG8+trYAPc8s0abpAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIuuX2eN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723049574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H5AkZ1JNn1mHkQXXIwq5iyVkiN6NWguYMTLGi3vp1+Q=;
	b=CIuuX2eN4eMo4mjBKXUALn+XtLuxLZKto7oRIA6XxojAB25A0wfPCUrrtHZu5URfatmV5i
	Fet5e5ExeIyrcactmYRTtHpEaamzfc5Hg0rk26oNbix9JtNrtu7XAeFmqBej/rCV2IWJ6f
	4pCSeUjHUU1D4nEhIZ3gS7LmAR84hPA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-XdAaXRelNBG3-MK1hqcXyg-1; Wed,
 07 Aug 2024 12:52:49 -0400
X-MC-Unique: XdAaXRelNBG3-MK1hqcXyg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93F19195609D;
	Wed,  7 Aug 2024 16:52:48 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.123])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D8A519560AA;
	Wed,  7 Aug 2024 16:52:47 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@google.com>
Cc: linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] lib/stackdepot: Double DEPOT_POOLS_CAP if KASAN is enabled
Date: Wed,  7 Aug 2024 12:52:28 -0400
Message-ID: <20240807165228.1116831-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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

As KASAN is a big user of stackdepot, the current DEPOT_POOLS_CAP of
8192 may not be enough. Double DEPOT_POOLS_CAP if KASAN is enabled to
avoid hitting this problem.

Also use the MIN() macro for defining DEPOT_MAX_POOLS to clarify the
intention.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/stackdepot.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 5ed34cc963fc..beeb70b57710 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -36,11 +36,12 @@
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


