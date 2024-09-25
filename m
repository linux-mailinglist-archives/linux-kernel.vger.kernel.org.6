Return-Path: <linux-kernel+bounces-337954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9342C985166
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8412847EA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FF914A4C1;
	Wed, 25 Sep 2024 03:23:37 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4886149013
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727234616; cv=none; b=jbeKB9Iob+FSYT2WmIVJM1yU7eCYujG5JkxqwQpZc64a1wdHwgIgYh1C21W2L0c9LqmtdYeDNyPjhxUBpdxpis3NB7nVPzTtfc/I/v0L1KnT1W3+lD70vK4oJuTbDt9dZ19Jzngc3JBL5KTwG0N7fwoZl0zKBAO+DpvXoPwUTSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727234616; c=relaxed/simple;
	bh=iBC4PsIF39LsPCctoHAWgZuRwBa7EwtIWQ0wmdIAhAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCWk2NSgtMiHMZyhg90UTniNfMhLZ7EK49ehDoNipZ+FV4wprEkPki8mKplZqUHVzE/8p+ga8v8oR8AugiWGsl8Wi1jqNlOujuBPY6MBk1XqsRwWgTg4nESwlOvGlj0SROk57DfKnr0e1GsQqWbEpnh/8dzsg9vLNzoylpp7Qo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 48P3N88G053972;
	Wed, 25 Sep 2024 11:23:08 +0800 (+08)
	(envelope-from fangzheng.zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XD20r40LZz2Mx63v;
	Wed, 25 Sep 2024 11:15:24 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.72) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 25 Sep 2024 11:23:05 +0800
From: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David
 Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman
 Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <tkjos@google.com>,
        Fangzheng Zhang <fangzheng.zhang@unisoc.com>,
        Fangzheng Zhang
	<fangzheng.zhang1003@gmail.com>,
        Yuming Han <yuming.han@unisoc.com>
Subject: [PATCH 1/2] mm/slub: Add panic function when slub leaks
Date: Wed, 25 Sep 2024 11:22:55 +0800
Message-ID: <20240925032256.1782-2-fangzheng.zhang@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240925032256.1782-1-fangzheng.zhang@unisoc.com>
References: <20240925032256.1782-1-fangzheng.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 48P3N88G053972

Perform real-time memory usage monitoring on the slub page
allocation paths, ie, kmalloc_large_alloced and alloc_slab_page.
When the usage exceeds the set threshole value, the panic function
will be triggered.

Signed-off-by: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
---
 mm/Kconfig | 11 ++++++++
 mm/slub.c  | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 09aebca1cae3..60cf72d4f0da 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -255,6 +255,17 @@ config SLUB_TINY
 
 	   If unsure, say N.
 
+config SLUB_LEAK_PANIC
+	bool "Trigger panic when slub leaks"
+	default y
+	help
+	  Detect slub leaks by monitoring its usage in real time on the page
+	  allocation path of the slub. When the slub occupancy exceeds the
+	  user-set value, it is considered that the slub is leaking at this
+	  time, and a panic operation will be triggered immediately. Uers
+	  can enable and set leak threshold by using the kernel command line
+	  parameters "slub.leak_panic" and "slub.leak_panic_threshold".
+
 config SLAB_MERGE_DEFAULT
 	bool "Allow slab caches to be merged"
 	default y
diff --git a/mm/slub.c b/mm/slub.c
index 21f71cb6cc06..91049f87ab98 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -42,6 +42,9 @@
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 #include <linux/sort.h>
+#ifdef CONFIG_SLUB_LEAK_PANIC
+#include <linux/vmstat.h>
+#endif
 
 #include <linux/debugfs.h>
 #include <trace/events/kmem.h>
@@ -218,6 +221,15 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
 #endif		/* CONFIG_SLUB_DEBUG */
 
+/* Internal slub_leak_panic definitions */
+#ifdef CONFIG_SLUB_LEAK_PANIC
+#define K(x) ((x) << (PAGE_SHIFT-10))
+static bool __read_mostly slub_leak_panic_enabled;
+static unsigned int __read_mostly slub_leak_panic_threshold;
+static long max_slab_count, temp_slab_count;
+#endif
+
+
 /* Structure holding parameters for get_partial() call chain */
 struct partial_context {
 	gfp_t flags;
@@ -2424,6 +2436,21 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
 	if (folio_is_pfmemalloc(folio))
 		slab_set_pfmemalloc(slab);
 
+#ifdef CONFIG_SLUB_LEAK_PANIC
+	if (likely(slub_leak_panic_enabled) && slub_leak_panic_threshold > 0) {
+		max_slab_count = K(totalram_pages()) * slub_leak_panic_threshold / 100;
+		temp_slab_count = K(global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B))
+				+ K(global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B))
+				+ K(1 << order);
+		if (temp_slab_count > max_slab_count)
+			panic("SLAB LEAK: %s(temp_count %6luKB > max_count %6luKB):\n"
+				"%s gfp_mask=%#x(%pGg), order=%d kB, oom_score_adj=%d\n",
+				__func__, temp_slab_count, max_slab_count,
+				current->comm, flags, &flags, order,
+				current->signal->oom_score_adj);
+	}
+#endif
+
 	return slab;
 }
 
@@ -4212,6 +4239,19 @@ static void *___kmalloc_large_node(size_t size, gfp_t flags, int node)
 		ptr = folio_address(folio);
 		lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B,
 				      PAGE_SIZE << order);
+#ifdef CONFIG_SLUB_LEAK_PANIC
+		if (likely(slub_leak_panic_enabled) && slub_leak_panic_threshold > 0) {
+			max_slab_count = K(totalram_pages()) * slub_leak_panic_threshold / 100;
+			temp_slab_count = K(global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B))
+					+ K(global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B));
+			if (temp_slab_count > max_slab_count)
+				panic("SLAB LEAK: %s(temp_count %6luKB > max_count %6luKB):\n"
+					"%s gfp_mask=%#x(%pGg), order=%d kB, oom_score_adj=%d\n",
+					__func__, temp_slab_count, max_slab_count,
+					current->comm, flags, &flags, order,
+					current->signal->oom_score_adj);
+		}
+#endif
 	}
 
 	ptr = kasan_kmalloc_large(ptr, size, flags);
@@ -7443,3 +7483,39 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
 	sinfo->cache_order = oo_order(s->oo);
 }
 #endif /* CONFIG_SLUB_DEBUG */
+
+/*
+ * The /sys/module/slub ABI
+ */
+#ifdef CONFIG_SLUB_LEAK_PANIC
+/*
+ * What:          /sys/module/slub/parameters/leak_panic
+ *                /sys/module/slub/parameters/leak_panic_threshold
+ * Date:          Sep 2024
+ * KernelVersion: v6.6+
+ * Description:   Used for slub memory leak check. When the user
+ *                successfully allocates the slub page, it also performs
+ *                statistics on the total slub usage in the system.
+ *                When the usage exceeds the set value
+ *                (threshold * memtotal / 100), it is considered that
+ *                there is a risk of slub leakage in the system at this time.
+ *                A panic operation will be triggered.
+ * Users:         userspace
+ */
+MODULE_PARM_DESC(leak_panic, "Disable/Enable slub_leak_panic");
+module_param_named(leak_panic, slub_leak_panic_enabled, bool, 0644);
+
+static int slub_leak_panic_threshold_set(const char *val, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, 0, 100);
+}
+
+static const struct kernel_param_ops slub_leak_panic_threshold_ops = {
+	.set = slub_leak_panic_threshold_set,
+	.get = param_get_uint,
+};
+
+MODULE_PARM_DESC(leak_panic_threshold,
+		"Upper limit value of slub, expressed as a percentage of memtotal (0 ~ 100)");
+module_param_cb(leak_panic_threshold,
+		&slub_leak_panic_threshold_ops, &slub_leak_panic_threshold, 0644);
+#endif /* CONFIG_SLUB_LEAK_PANIC */
-- 
2.17.1


