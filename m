Return-Path: <linux-kernel+bounces-195698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651358D506B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2686F2893C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1E63FB88;
	Thu, 30 May 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="DMCVF4Ja"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38B84436C
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088585; cv=none; b=scIz34K0NEnVaIHiB2/tunlNJoIAzwbd9jMyVgXey0uBE/8fzwDy6UN+W40LlR9uIqOLv4jQshiGaRi9XjLh7xJ3tq6L5AN7JV2Y4/IwTnb1IEsFoK/YPijIw4cjnzktaRGxS5FHxwkIIcJ+6UreUxF/qihZ7yOtGhMI1Ksp4Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088585; c=relaxed/simple;
	bh=QRQK97kctUv8Z36b3LCxSV/fHwTXyeRjgbeLYPW44sk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rvZdVqsGBQMlwZ6nSVAr7iiI3T/0TLb3RXL9iedpHRXTV7GNihvvkQgIO885eFVfpoPb5X2BlxelIByrMNQJDte2JmuAM5aYmuKi9nuxj3LvlMryR67JsrTY9gIt5NE5zudqDAmBLHCtn+al+5qDsWR99PTgX/BfrTAv7cEJ1+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=DMCVF4Ja; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43f87ba7d3eso5817481cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1717088583; x=1717693383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GTLV5QmShTqCTYzxTlMofJsJKzIK7ET6QLwG+tAy4z0=;
        b=DMCVF4JaynLaAe4/GUOG4V5hrRYYKj7MdrJlvnwz0qKPOg0obz0T7TVXInDjECYRTv
         Td7PvlZsAlDMe8iJAZjp7GsAk0hfzsIuIW7tHBns1PFNtzt9eS/Gn0yj27yv0kmrYi5T
         YGLXwezMvyDEv6sffy3+dIf7ngviLPCv3t7WeQMSF655htpfjnsRqtyfSBWp+YeFagdV
         7SCxpwpt1fhEsxCFMltJf9otqMYin5kXy1WgCwJhnYfo79LDTuZ+C2tr4sINNIxUW65W
         IinAhAaezfkNBme3PMr0ALBx/Li/98QkozvQ30NbLhaR6pRYUG4xY/atbOxMDTJjLOyb
         Ii+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717088583; x=1717693383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTLV5QmShTqCTYzxTlMofJsJKzIK7ET6QLwG+tAy4z0=;
        b=XQS8m0TNtC9bvyWSVAv56D/1LMwy2PimadW8nytgpRT+NfvaQQj6Ota0aPSOwIlwrY
         AipFprN+c767p1ByplpEKRyeJyW6gHfjEjZ4SLeOW7fDGX/Lp8qF2ZgGQeQq6rvnRA0t
         fa0vOjtRJvzzsIePcsJK+gk/WGDKLmLwN7HJBOIvIZaiQDM3uCCcaKfb8dkhOpzrYsok
         FbfoX20w/VoL3arhFAI1Zs9HH3JPFg8JWsJD56d3TQ0+GkCtq2EtzfuCSJaxsTO7MGZ7
         jFG0ILAloH6LiQI86oV7wHLQSNqy1tWvLXAUj/Kg/2QY8zmVuGrPBVIwEFRYfQxjLVRG
         clvg==
X-Forwarded-Encrypted: i=1; AJvYcCW2G26gFfiyfaJFqDNzMbTUsjS9ecza/YZwL3vwIV5SCHqlmBKFMuKGJRrlVKUtsytK6b5exsaCukkFvhJ8Ab5YTWdPdHyY4M/cGIta
X-Gm-Message-State: AOJu0YwEJtaDSSyQ39xEQO5p3wr4WzOcqtLOiDYnkxU8imQzRo/qSCgy
	pm7LDf0K5du4G/G/q/oBhWAHSpLwfXNYGHExJDfxqfV2sEpxCC980FP808061po=
X-Google-Smtp-Source: AGHT+IHPvnNez1b8QMr2tHO4qBHGqnytcfamCabGQnUX7Dc40fCrRQaqXIjmVXNfmAz1d6NjPQltCQ==
X-Received: by 2002:a05:6214:a0f:b0:6ae:ff6:4d28 with SMTP id 6a1803df08f44-6ae0ff64ef4mr22210636d6.2.1717088582766;
        Thu, 30 May 2024 10:03:02 -0700 (PDT)
Received: from soleen.c.googlers.com.com (128.174.85.34.bc.googleusercontent.com. [34.85.174.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a73e425sm132406d6.24.2024.05.30.10.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 10:03:02 -0700 (PDT)
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
Subject: [PATCH v3] vmstat: Kernel stack usage histogram
Date: Thu, 30 May 2024 17:02:59 +0000
Message-ID: <20240530170259.852088-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
Changelog:
v3:
- Changed from page counts to power-of-two buckets, this is helpful for
builds with large base pages (i.e. arm64 with 64K pages) to evaluate
kernel stack internal fragmentation.

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
index 343906a98d6e..18d4a97d3afd 100644
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
index db79935e4a54..21932bd6a449 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1413,6 +1413,30 @@ const char * const vmstat_text[] = {
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
2.45.1.288.g0e0cd299f1-goog


