Return-Path: <linux-kernel+bounces-574523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC26A6E65E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57BDE3BAE04
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8191EFF9D;
	Mon, 24 Mar 2025 22:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GtwRpZB1"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12721EF09A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853795; cv=none; b=S0/8pe/bnwWnwFGIRAcBfraY9PGGzRUKI82XKQxhwtEJnm30m7PjzR32T6etuakGemHOhlsk9297f+TXrQcNaYc4ytdddjXCSlD7LzBpdGHfoHucBtBh3LmUmexltLhl5y/pd56beQRLzlnF5r6KlQk3Hwi2KU8MeunzhQzr6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853795; c=relaxed/simple;
	bh=mjAVo0laEj0YedW2kUkFe7ptRqxSDqkwDdnRJi4OMT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MwlcqqgtkN20kx8C703UKTVuzfUTfkWtROGU80zrfkj8LsYRzhKrU4eiOSDZZ/M2M5GRwKjVRu8VrnUw6UcGMb9Hv/e7cufTg96qfZiNtzXVQxkbxOWK8jJMOwCE6NzpKBiPaTYTOs+25vZspuyZGcpoN+4wj8f2fr/igLnM4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GtwRpZB1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2254e500a73so58633745ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742853793; x=1743458593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HrFPQxQVCxFCJ5eIn/lb4rFAO8+JMUT5L57UjQpjJz0=;
        b=GtwRpZB1bdcjUojqHXC0i1YgFaZ3EGunn2cD5Q82AHYa6CrgECXiEtyYkMBpeROGuA
         RmbvYuoUxdjAALKNdfByZhpis+hKkTU6JUMe+quN1cHyjwHgAN8deNZkgIv3z5yZWiKL
         T4iM6MxW3qoW2CQoSFjBvdZac9lcLJa+mElJC5FlT+9iSE1mOMhwLapOQbhNFaCFW2kH
         WMnBZhBCDHz9o5x35ApX3//wG0kTYw0TgRdaccTEwp4lCFZ/CkQNZjJSUgYPYiwMWceo
         NUvVKVRkMqx+3eu5bjWU2Xn1G+UzOteOFZJ+B8++7Xy2gOCVsV7yPmDSmL511/GVjQqf
         xnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742853793; x=1743458593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrFPQxQVCxFCJ5eIn/lb4rFAO8+JMUT5L57UjQpjJz0=;
        b=WAA0KG7EioTdPx4XPjtbWbs60la4SEEgxNKy3DY0G7pCxYbtyEtebce1VtFeKYx3oA
         h5v6rUdB8TCenkylawj/2cs+mb+HZtRwQXJgSjk6RBBvey3padtQNDNreI2uDRNSrVwg
         NGps8ubwsN0KeCWEp16949UAq7mIddMtqd4YHxJNXSFU6b59VrYxbxitZ/KGjk78+dek
         wQzx4gS4Ola3CNyorm3Zk3TLoJTtjCrIq1yervOv8Li3+oxzLkkONzh3kVBE+FhZa2YA
         KQzBxmd7SRWY+9wzafcOPJBrNzJ3SfCEtzkTfbbzGSBSmbNjj6I4m7TzxR9vQKLbqwKn
         OAuA==
X-Forwarded-Encrypted: i=1; AJvYcCVztMDLDwAmGslxm8NHfZOeoYnawwyT4CxUikc9qoLZ4wOLblo6o0FNi1g5xGRm+FJoWiIMzrmRK9nxZ2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHS9KmYXLt4rPGpmZM8w4nmdwvZMlPIuuJuyvz6v//cmSqlBKu
	dzG7HLTBtxNpXBUrwnOUc3gMcS2LjG3b4QLAs8qYqnGLquNr8mAmGwE3JXBZIlnaMifsma6xbO1
	vsmkcVp/mCw==
X-Google-Smtp-Source: AGHT+IFZ5gFWS0tV3e6VWZdQngRJrAWzxvv1iFdLvWy/bvzelevqq81SzyHG2/91MA2Kj/yFZ5fNgitHPoeVag==
X-Received: from pglu36.prod.google.com ([2002:a63:1424:0:b0:af2:22fe:cfb3])
 (user=kinseyho job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2585:b0:1f5:7eb5:72c7 with SMTP id adf61e73a8af0-1fe4300f7d1mr23507348637.29.1742853793076;
 Mon, 24 Mar 2025 15:03:13 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:03:01 -0700
In-Reply-To: <20250324220301.1273038-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324220301.1273038-1-kinseyho@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324220301.1273038-3-kinseyho@google.com>
Subject: [RFC PATCH v1 2/2] mm: klruscand: use mglru scanning for page promotion
From: Kinsey Ho <kinseyho@google.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: yuanchu@google.com, AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com, 
	Jonathan.Cameron@huawei.com, Michael.Day@amd.com, akpm@linux-foundation.org, 
	dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com, 
	gourry@gourry.net, hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com, 
	jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com, 
	kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com, 
	liam.howlett@oracle.com, mgorman@techsingularity.net, mingo@redhat.com, 
	nadav.amit@gmail.com, nphamcs@gmail.com, peterz@infradead.org, 
	raghavendra.kt@amd.com, riel@surriel.com, rientjes@google.com, 
	rppt@kernel.org, shivankg@amd.com, shy828301@gmail.com, sj@kernel.org, 
	vbabka@suse.cz, weixugc@google.com, willy@infradead.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net, 
	hyeonggon.yoo@sk.com, bharata@amd.com, Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a new kernel daemon, klruscand, that periodically invokes the
MGLRU page table walk. It leverages the new callbacks to gather access
information and forwards it to the kpromoted daemon for promotion
decisions.

This benefits from reusing the existing MGLRU page table walk
infrastructure, which is optimized with features such as hierarchical
scanning and bloom filters to reduce CPU overhead.

As an additional optimization to be added in the future, we can tune
the scan intervals for each memcg.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 mm/Kconfig     |   8 ++++
 mm/Makefile    |   1 +
 mm/klruscand.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 mm/klruscand.c

diff --git a/mm/Kconfig b/mm/Kconfig
index ceaa462a0ce6..ed0fa8f2551e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1366,6 +1366,14 @@ config KPROMOTED
 	  Promote hot pages from lower tier to top tier by using the
 	  memory access information provided by various sources.
 
+config KLRUSCAND
+	bool "Kernel lower tier access scan daemon"
+	default y
+	depends on KPROMOTED && LRU_GEN_WALKS_MMU
+	help
+	  Scan for accesses from lower tiers by invoking MGLRU to perform
+	  page table walks.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index bf4f5f18f1f9..eb7b76db3b33 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -148,3 +148,4 @@ obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
 obj-$(CONFIG_KPROMOTED) += kpromoted.o
+obj-$(CONFIG_KLRUSCAND) += klruscand.o
diff --git a/mm/klruscand.c b/mm/klruscand.c
new file mode 100644
index 000000000000..a53d43c60155
--- /dev/null
+++ b/mm/klruscand.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/memcontrol.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/random.h>
+#include <linux/migrate.h>
+#include <linux/mm_inline.h>
+#include <linux/slab.h>
+#include <linux/sched/clock.h>
+#include <linux/memory-tiers.h>
+#include <linux/sched/mm.h>
+#include <linux/sched.h>
+#include <linux/kpromoted.h>
+
+#include "internal.h"
+
+#define KLRUSCAND_INTERVAL_MS 4000
+#define BATCH_SIZE (2 << 16)
+
+static struct task_struct *scan_thread;
+static pfn_t pfn_batch[BATCH_SIZE];
+static int batch_index;
+
+static void flush_cb(void)
+{
+	int i = 0;
+
+	for (; i < batch_index; i++) {
+		u64 pfn = pfn_batch[i].val;
+
+		kpromoted_record_access((unsigned long)pfn, NUMA_NO_NODE,
+					KPROMOTED_PGTABLE_SCAN, jiffies);
+
+		if (i % 16 == 0)
+			cond_resched();
+	}
+	batch_index = 0;
+}
+
+static int accessed_cb(pfn_t pfn)
+{
+	if (batch_index >= BATCH_SIZE)
+		return -EAGAIN;
+
+	pfn_batch[batch_index++] = pfn;
+	return 0;
+}
+
+static int klruscand_run(void *unused)
+{
+	struct lru_gen_mm_walk *walk;
+
+	walk = kzalloc(sizeof(*walk),
+		       __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
+	if (!walk)
+		return -ENOMEM;
+
+	while (!kthread_should_stop()) {
+		unsigned long next_wake_time;
+		long sleep_time;
+		struct mem_cgroup *memcg;
+		int flags;
+		int nid;
+
+		next_wake_time = jiffies + msecs_to_jiffies(KLRUSCAND_INTERVAL_MS);
+
+		for_each_node_state(nid, N_MEMORY) {
+			pg_data_t *pgdat = NODE_DATA(nid);
+			struct reclaim_state rs = { 0 };
+
+			if (node_is_toptier(nid))
+				continue;
+
+			rs.mm_walk = walk;
+			set_task_reclaim_state(current, &rs);
+			flags = memalloc_noreclaim_save();
+
+			memcg = mem_cgroup_iter(NULL, NULL, NULL);
+			do {
+				struct lruvec *lruvec =
+					mem_cgroup_lruvec(memcg, pgdat);
+				unsigned long max_seq =
+					READ_ONCE((lruvec)->lrugen.max_seq);
+
+				lru_gen_scan_lruvec(lruvec, max_seq,
+						    accessed_cb, flush_cb);
+				cond_resched();
+			} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
+
+			memalloc_noreclaim_restore(flags);
+			set_task_reclaim_state(current, NULL);
+			memset(walk, 0, sizeof(*walk));
+		}
+
+		sleep_time = next_wake_time - jiffies;
+		if (sleep_time > 0 && sleep_time != MAX_SCHEDULE_TIMEOUT)
+			schedule_timeout_idle(sleep_time);
+	}
+	kfree(walk);
+	return 0;
+}
+
+static int __init klruscand_init(void)
+{
+	struct task_struct *task;
+
+	task = kthread_run(klruscand_run, NULL, "klruscand");
+
+	if (IS_ERR(task)) {
+		pr_err("Failed to create klruscand kthread\n");
+		return PTR_ERR(task);
+	}
+
+	scan_thread = task;
+	return 0;
+}
+module_init(klruscand_init);
-- 
2.49.0.395.g12beb8f557-goog


