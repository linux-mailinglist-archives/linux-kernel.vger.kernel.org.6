Return-Path: <linux-kernel+bounces-256715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47DB93526B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519C91F22078
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 20:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB7A145B0B;
	Thu, 18 Jul 2024 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="ci72MnmL"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E091E3F9FB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721334377; cv=none; b=F+SxdHDnR1AQYG8v1/p/iI1Zpm4f2OxhXCtMM/jpOH6blyHvihKaSanpnlFVc9w+tGsw1EAfhPoFH6EU7MfYgmJp5OiBEvQ0FzGTT6G/qZ+R7EfRTE6YYP3Kw/1m1bedcn8QIDi7GatxfcUgAysYg+Y5wXC4lalQIhnh+9kDzyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721334377; c=relaxed/simple;
	bh=z65fb54O+0j1GYss3wIFmmqrsCu8Gq6RivV0437pPhc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kooiephmtv1SeXOZSfN2tsaFsjM445f9xJ6r1wECta2E29wC9K/KVeEpq7YAK3fCbpXgy71T+p1QeC19D1sTDzKOEjrAERZ/0jALuc3Af1HuaKzjFIS/AeNmbmykSdoQVAOJko0LV8QJZ8IQjBgnWpqpY7nkIt/pPlGqIoSl+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=ci72MnmL; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79f1828ed64so44745085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1721334375; x=1721939175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tDdEWNLIeahR3clrZ+r1H9Gi/QI7QyEeXV2Rx/AdJpY=;
        b=ci72MnmLd19FViTFNIo39+ZVihduvU8jCwcJP00Vy3d+5fiaI8aCAHej8MpNneYe6a
         pDy8rj2kZmvbDgHaVI8eDnRgnhz/ud0zk6EWDe7G6Y4gp4vfDrRZUaTocAVagrktBKLE
         q/5ViTGNKOY/MVgV3Peeqy7dwvBpQ7sv1dv/xZjxOyUdCj7H2+beG2u17uTpXsPcDdx0
         vlc7u2CN+EbumxjjuNZgy8zgLwuP7+jFWgg7NVziU3P1gk0hHZuzi33WsYcA+ZKcyQl1
         PZGYrRMe5i9ywUAXlE3Lc0Jn8ZB0pJx3H1dtgQQdOHXm1/QavvFpnzqbNm4m5ySI59Dj
         lE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721334375; x=1721939175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tDdEWNLIeahR3clrZ+r1H9Gi/QI7QyEeXV2Rx/AdJpY=;
        b=XMOqosqHiDRw06Eim4LdJxhxpXVyslTFASUJWmADOpbVRxtAbgrVuill13LXwJBWh4
         G5Frn1vNhl57PQAwPfgC8M2pikOwCwsqxdrh89NXy5NAIPAWXUF3UWPb8T2iQTwwQjbC
         2v6pAgylVORXTpqBzQ+tgckFknSEJuob6IemnQTUbkKJg1so3ESP84UyuX0Wtru2UZiw
         n90x/0lKQiZvxtDmVW5j82ANX7fCsZZYrakZjJUPeg62XOPpAV/ljAWSvitUN6Ss1dw3
         cR+1nCzqGAXdlnzOvbAWUN905wtrMi6oS6+LPYPNPIfN8f0wkAgtSvtZtY9aOxDdcKyu
         btew==
X-Forwarded-Encrypted: i=1; AJvYcCUlB96J5/SXJ8GuWwXVG50WmvnSsPojIBdpOTIbR4LpPH4uszPCdF6bf9eaML6CletNmRFcY2vX7xWTA0Ks6gKlVXVCWfC6u/iEBiyi
X-Gm-Message-State: AOJu0Yxg3JJXmRqpl8sprchKQ9J03ILhPnBXoe54HnDFc1SjigajPs/7
	fNQK2yw4a7h+0GGcEOQNEgiwoHOA4JJf9YqvfR2rkS3FOp+HDEnkAdrWup2L5S4=
X-Google-Smtp-Source: AGHT+IEAxi2p4A1XvCZgPQ5sle9fdjFSN0zY7t4+4YKSPayhY2upm/Zqu6bZnQy3N+IzhBhrfMNvHg==
X-Received: by 2002:a05:620a:4446:b0:79f:10e6:2ee with SMTP id af79cd13be357-7a19390cf4amr211568385a.41.1721334374688;
        Thu, 18 Jul 2024 13:26:14 -0700 (PDT)
Received: from soleen.c.googlers.com.com (197.5.86.34.bc.googleusercontent.com. [34.86.5.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1939800d5sm60610085a.129.2024.07.18.13.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:26:14 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	jpoimboe@kernel.org,
	pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev,
	peterz@infradead.org,
	nphamcs@gmail.com,
	cerasuolodomenico@gmail.com,
	surenb@google.com,
	lizhijian@fujitsu.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	vbabka@suse.cz,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4] vmstat: Kernel stack usage histogram
Date: Thu, 18 Jul 2024 20:26:11 +0000
Message-ID: <20240718202611.1695164-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of the dynamic kernel stack project, we need to know the amount
of data that can be saved by reducing the default kernel stack size [1].

Provide a kernel stack usage histogram to aid in optimizing kernel stack
sizes and minimizing memory waste in large-scale environments. The
histogram divides stack usage into power-of-two buckets and reports the
results in /proc/vmstat. This information is especially valuable in
environments with millions of machines, where even small optimizations
can have a significant impact.

The histogram data is presented in /proc/vmstat with entries like
"kstack_1k", "kstack_2k", and so on, indicating the number of threads
that exited with stack usage falling within each respective bucket.

Example outputs:
Intel:
$ grep kstack /proc/vmstat
kstack_1k 3
kstack_2k 188
kstack_4k 11391
kstack_8k 243
kstack_16k 0

ARM with 64K page_size:
$ grep kstack /proc/vmstat
kstack_1k 1
kstack_2k 340
kstack_4k 25212
kstack_8k 1659
kstack_16k 0
kstack_32k 0
kstack_64k 0

Note: once the dynamic kernel stack is implemented it will depend on the
implementation the usability of this feature: On hardware that supports
faults on kernel stacks, we will have other metrics that show the total
number of pages allocated for stacks. On hardware where faults are not
supported, we will most likely have some optimization where only some
threads are extended, and for those, these metrics will still be very
useful.

[1] https://lwn.net/Articles/974367

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---

Changelog:
v4:
- Expanded the commit message as requested by Andrew Morton.

 include/linux/sched/task_stack.h | 49 ++++++++++++++++++++++++++++++--
 include/linux/vm_event_item.h    | 42 +++++++++++++++++++++++++++
 include/linux/vmstat.h           | 16 -----------
 mm/vmstat.c                      | 24 ++++++++++++++++
 4 files changed, 113 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index ccd72b978e1f..65e8c9fb7f9b 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -95,9 +95,51 @@ static inline int object_is_on_stack(const void *obj)
 extern void thread_stack_cache_init(void);
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
+#ifdef CONFIG_VM_EVENT_COUNTERS
+#include <linux/vm_event_item.h>
+
+/* Count the maximum pages reached in kernel stacks */
+static inline void kstack_histogram(unsigned long used_stack)
+{
+	if (used_stack <= 1024)
+		this_cpu_inc(vm_event_states.event[KSTACK_1K]);
+#if THREAD_SIZE > 1024
+	else if (used_stack <= 2048)
+		this_cpu_inc(vm_event_states.event[KSTACK_2K]);
+#endif
+#if THREAD_SIZE > 2048
+	else if (used_stack <= 4096)
+		this_cpu_inc(vm_event_states.event[KSTACK_4K]);
+#endif
+#if THREAD_SIZE > 4096
+	else if (used_stack <= 8192)
+		this_cpu_inc(vm_event_states.event[KSTACK_8K]);
+#endif
+#if THREAD_SIZE > 8192
+	else if (used_stack <= 16384)
+		this_cpu_inc(vm_event_states.event[KSTACK_16K]);
+#endif
+#if THREAD_SIZE > 16384
+	else if (used_stack <= 32768)
+		this_cpu_inc(vm_event_states.event[KSTACK_32K]);
+#endif
+#if THREAD_SIZE > 32768
+	else if (used_stack <= 65536)
+		this_cpu_inc(vm_event_states.event[KSTACK_64K]);
+#endif
+#if THREAD_SIZE > 65536
+	else
+		this_cpu_inc(vm_event_states.event[KSTACK_REST]);
+#endif
+}
+#else /* !CONFIG_VM_EVENT_COUNTERS */
+static inline void kstack_histogram(unsigned long used_stack) {}
+#endif /* CONFIG_VM_EVENT_COUNTERS */
+
 static inline unsigned long stack_not_used(struct task_struct *p)
 {
 	unsigned long *n = end_of_stack(p);
+	unsigned long unused_stack;
 
 	do { 	/* Skip over canary */
 # ifdef CONFIG_STACK_GROWSUP
@@ -108,10 +150,13 @@ static inline unsigned long stack_not_used(struct task_struct *p)
 	} while (!*n);
 
 # ifdef CONFIG_STACK_GROWSUP
-	return (unsigned long)end_of_stack(p) - (unsigned long)n;
+	unused_stack = (unsigned long)end_of_stack(p) - (unsigned long)n;
 # else
-	return (unsigned long)n - (unsigned long)end_of_stack(p);
+	unused_stack = (unsigned long)n - (unsigned long)end_of_stack(p);
 # endif
+	kstack_histogram(THREAD_SIZE - unused_stack);
+
+	return unused_stack;
 }
 #endif
 extern void set_task_stack_end_magic(struct task_struct *tsk);
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 747943bc8cc2..73fa5fbf33a3 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -154,9 +154,51 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		VMA_LOCK_RETRY,
 		VMA_LOCK_MISS,
 #endif
+#ifdef CONFIG_DEBUG_STACK_USAGE
+		KSTACK_1K,
+#if THREAD_SIZE > 1024
+		KSTACK_2K,
+#endif
+#if THREAD_SIZE > 2048
+		KSTACK_4K,
+#endif
+#if THREAD_SIZE > 4096
+		KSTACK_8K,
+#endif
+#if THREAD_SIZE > 8192
+		KSTACK_16K,
+#endif
+#if THREAD_SIZE > 16384
+		KSTACK_32K,
+#endif
+#if THREAD_SIZE > 32768
+		KSTACK_64K,
+#endif
+#if THREAD_SIZE > 65536
+		KSTACK_REST,
+#endif
+#endif /* CONFIG_DEBUG_STACK_USAGE */
 		NR_VM_EVENT_ITEMS
 };
 
+#ifdef CONFIG_VM_EVENT_COUNTERS
+/*
+ * Light weight per cpu counter implementation.
+ *
+ * Counters should only be incremented and no critical kernel component
+ * should rely on the counter values.
+ *
+ * Counters are handled completely inline. On many platforms the code
+ * generated will simply be the increment of a global address.
+ */
+
+struct vm_event_state {
+	unsigned long event[NR_VM_EVENT_ITEMS];
+};
+
+DECLARE_PER_CPU(struct vm_event_state, vm_event_states);
+#endif
+
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 #define THP_FILE_ALLOC ({ BUILD_BUG(); 0; })
 #define THP_FILE_FALLBACK ({ BUILD_BUG(); 0; })
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 735eae6e272c..131966a4af78 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -41,22 +41,6 @@ enum writeback_stat_item {
 };
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
-/*
- * Light weight per cpu counter implementation.
- *
- * Counters should only be incremented and no critical kernel component
- * should rely on the counter values.
- *
- * Counters are handled completely inline. On many platforms the code
- * generated will simply be the increment of a global address.
- */
-
-struct vm_event_state {
-	unsigned long event[NR_VM_EVENT_ITEMS];
-};
-
-DECLARE_PER_CPU(struct vm_event_state, vm_event_states);
-
 /*
  * vm counters are allowed to be racy. Use raw_cpu_ops to avoid the
  * local_irq_disable overhead.
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8507c497218b..642d761b557b 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1416,6 +1416,30 @@ const char * const vmstat_text[] = {
 	"vma_lock_retry",
 	"vma_lock_miss",
 #endif
+#ifdef CONFIG_DEBUG_STACK_USAGE
+	"kstack_1k",
+#if THREAD_SIZE > 1024
+	"kstack_2k",
+#endif
+#if THREAD_SIZE > 2048
+	"kstack_4k",
+#endif
+#if THREAD_SIZE > 4096
+	"kstack_8k",
+#endif
+#if THREAD_SIZE > 8192
+	"kstack_16k",
+#endif
+#if THREAD_SIZE > 16384
+	"kstack_32k",
+#endif
+#if THREAD_SIZE > 32768
+	"kstack_64k",
+#endif
+#if THREAD_SIZE > 65536
+	"kstack_rest",
+#endif
+#endif
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
-- 
2.45.2.1089.g2a221341d9-goog


