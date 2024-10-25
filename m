Return-Path: <linux-kernel+bounces-382383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D969B0D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CCBFB25B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF01F7566;
	Fri, 25 Oct 2024 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKuT2j9Y"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EA57E792
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880451; cv=none; b=n4CsH330BPO5SJ7m3uCaUAf69kzH22a6fh6P0xS6Q0KGBmxPKb/4vAPDoaE3NriIMf+BLgE3SyTnqsPK3KPGl3999Bw1cweHOtUxYPRg8r6q3phD9ZPthvT69e+wa2mh81cIe6PqoKKSsKB2b07ajVIkaiah20AKeI2ZNrsNYAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880451; c=relaxed/simple;
	bh=3z3AyZRuhZsakHGPnuPB27QLtrSflVTOiR+Sx0mO1KU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SzMep8/J4kyb9rpP/rvgLrA7IdfVAw4cV798j1ZMiU6hkmXgs63Hr6VlD8dO+BAemdeXUY7N8eylI8vcnfmHN+iY561Gu1apqiH4RPntjcF7mGZj001L0PVRyhU/hBvT70DLtSSEf3uRe0dPS1Agh3ZmUSSGR/C63UTxgwTOvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKuT2j9Y; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28edea9af6so4422654276.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729880448; x=1730485248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8/3oXaSKqLlLUfss7qMBeZhrZdhme3UQ3I1K/P7gFys=;
        b=JKuT2j9Yy4dO4hBiCzonHjY474vkN/6whtTeiP27jw4FhXaVBI4CNxVJkpQYJHNcjj
         hUsWD+5qEKwSpjoDl7qj49snoo9yKjVibI6JXsAgZGMNd4poH7HWT3Y1I9fRmJ1DrX9r
         Nlbcj4cvVK5EDMoKcsUNhMV2gWX16c7o0QM8BSd7qljD5ohQeE/QJALiD1vY8mHDj6ly
         jyS4j1xmTlPuv0xkkx6tYXE36oSl+wbH6hAUUfhtrra4Vj/oKDvPpnXNddRJeaXqKtsM
         sC0ON8CMluQR6jh+RfDSdi1g+Sey9mJJCv6/veZRgF5dz4f4qp1EzamMcgqvIuy9dzsz
         45KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729880448; x=1730485248;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8/3oXaSKqLlLUfss7qMBeZhrZdhme3UQ3I1K/P7gFys=;
        b=q3nQjAlEvBi7ZMGhASM+YHeL9SNiAR4JPf3pDtR27Z54zHcQ4JoV5LiVQv0EsQrL67
         vBBZ600QbgiAGHTi+bcFtiVM4bIjC/FqrBp1/SeKxKh7nI9i4S88F7xMBoGrLMndRhuR
         3mH3s9NepVQjn3D2rCBPsIa0g8urxD/V1XsojxnsrGu0QmbA/DmVIPU74bCned54abT+
         4BvZCUxv/oO1KkZYZUW05ZT82vWwXE24WAra8syDzoHlJvymZ8fqpj8DtFqMKWKK15sq
         952rBwgx0eU2ZOEqrc1nBv0Lfw9xYh6e1tBDqa5wXW/O7XwT+66F6/675nxcYd7e/9ax
         Kvvw==
X-Gm-Message-State: AOJu0YzS60ISZVyN9qPFEPPp7X5VP0SHdwqJdTW2t59hMbFRyK0u4aIe
	mESETNDYtjW+U3sBypiveW7kC5PLAR5ReRt5qjhFqLS886nKW7pWFtLvVrz2CG3aemF+TPgwV0I
	eYjnfcwnUoTL+Exm3oRwvVp7NjghXQur8vluGB8VjRHB0S5EJBmPDey26tjbfBDbZMLH6OpsLRq
	Da0gvk5niFFawdF5f/8BJ0WFLDT1IiVB7YaivZtOV5Hg7D
X-Google-Smtp-Source: AGHT+IF7Vdpf6iMBP73vkisQuSuGLF2d361nZN4JyFHmnM5hb124jCWGieZU+JLL0K7ii3vTp9zinZQGE/EL
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a5b:f0f:0:b0:e2e:2cba:ac1f with SMTP id
 3f1490d57ef6-e3087bd5414mr2645276.6.1729880447600; Fri, 25 Oct 2024 11:20:47
 -0700 (PDT)
Date: Fri, 25 Oct 2024 11:20:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241025182042.131384-1-jstultz@google.com>
Subject: [RFC][PATCH v2 1/2] lib: stacklog_debug: Introduce helper tool for
 collecting and displaying stacktraces
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

When debugging, its often useful to understand how a function is
called and the different paths taken to get there. Usually
dump_stack() can be used for this purpose. However there are a
number of cases where a function is called very frequently,
making dump_stack far too noisy to be useful.

This is a little debug tool that utilizes stackdepot to capture
unique stack traces and store them in a circular buffer.

In the code, the developer adds: stacklog_debug_save() calls
at points of interest (as they might with stack_dump()).

Then after running the kernel, the developer can dump the unique
stack traces from the buffer via:
   cat /sys/kernel/debug/stacklog_debug

This is pretty trivial, but I've had this hanging around for
awhile and recently hit another case where it was helpful, so I
figured it would be worth sending it out for feedback as to if
others thought it would be useful enough to merge upstream or to
possibly rework into stackdepot itself?

Feedback would be greatly appreciated!

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Add dependency on STACKTRACE_SUPPORT as reported by
  kernel test robot <lkp@intel.com>
* Expand the Kconfig help to include basic usage
---
 include/linux/stacklog_debug.h |  13 ++++
 lib/Kconfig                    |  16 +++++
 lib/Makefile                   |   1 +
 lib/stacklog_debug.c           | 110 +++++++++++++++++++++++++++++++++
 4 files changed, 140 insertions(+)
 create mode 100644 include/linux/stacklog_debug.h
 create mode 100644 lib/stacklog_debug.c

diff --git a/include/linux/stacklog_debug.h b/include/linux/stacklog_debug.h
new file mode 100644
index 000000000000..d88f05d7000a
--- /dev/null
+++ b/include/linux/stacklog_debug.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _LINUX_STACKLOG_DEBUG_H
+#define _LINUX_STACKLOG_DEBUG_H
+
+#ifdef CONFIG_STACKLOG_DEBUG
+void stacklog_debug_save(void);
+#else
+static inline void stacklog_debug_save(void)
+{
+}
+#endif
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index b38849af6f13..17eb0f8d30db 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -725,6 +725,22 @@ config REF_TRACKER
 	depends on STACKTRACE_SUPPORT
 	select STACKDEPOT
 
+config STACKLOG_DEBUG
+	bool "Debug tool for logging and later displaying stacktraces"
+	depends on STACKTRACE_SUPPORT
+	select STACKDEPOT
+	select STACKDEPOT_ALWAYS_INIT
+	help
+	  Enables debug infrastructure for logging unique stack traces at
+	  a specific point, which can be later displayed from userland.
+
+	  The developer adds: stacklog_debug_save() calls at points of
+	  interest (as they might with stack_dump()).
+
+	  Then after running the kernel, the developer can dump the unique
+	  stack traces from the buffer via:
+	    cat /sys/kernel/debug/stacklog_debug
+
 config SBITMAP
 	bool
 
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..5a07573be73c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -264,6 +264,7 @@ obj-$(CONFIG_IRQ_POLL) += irq_poll.o
 
 obj-$(CONFIG_POLYNOMIAL) += polynomial.o
 
+obj-$(CONFIG_STACKLOG_DEBUG) += stacklog_debug.o
 # stackdepot.c should not be instrumented or call instrumented functions.
 # Prevent the compiler from calling builtins like memcmp() or bcmp() from this
 # file.
diff --git a/lib/stacklog_debug.c b/lib/stacklog_debug.c
new file mode 100644
index 000000000000..72ffbacee4b7
--- /dev/null
+++ b/lib/stacklog_debug.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014, The Linux Foundation. All rights reserved.
+ */
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/vmalloc.h>
+#include <linux/stackdepot.h>
+#include <linux/debugfs.h>
+#include <linux/stacklog_debug.h>
+
+#define STACKDEPTH 32
+#define BUFSZ 4096
+
+#define LIST_ENTRIES 512
+DEFINE_SPINLOCK(stack_lock);
+depot_stack_handle_t stack_list[LIST_ENTRIES];
+int head, tail;
+
+void stacklog_debug_save(void)
+{
+	unsigned long entries[STACKDEPTH];
+	depot_stack_handle_t stack_hash;
+	unsigned long flags;
+	unsigned int n;
+	int i;
+
+	n = stack_trace_save(entries, ARRAY_SIZE(entries), 1);
+	stack_hash = stack_depot_save(entries, n, GFP_NOWAIT);
+	if (!stack_hash)
+		return;
+
+	spin_lock_irqsave(&stack_lock, flags);
+	for (i = head; i < tail; i++)
+		if (stack_list[i % LIST_ENTRIES] == stack_hash)
+			goto out;
+
+	stack_list[(tail++ % LIST_ENTRIES)] = stack_hash;
+
+	if (tail % LIST_ENTRIES == head % LIST_ENTRIES)
+		head++;
+
+	if (tail >= 2 * LIST_ENTRIES) {
+		head %= LIST_ENTRIES;
+		tail %= LIST_ENTRIES;
+		if (tail < head)
+			tail += LIST_ENTRIES;
+	}
+out:
+	spin_unlock_irqrestore(&stack_lock, flags);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static int stacklog_stats_show(struct seq_file *s, void *unused)
+{
+	char *buf = kmalloc(BUFSZ, GFP_NOWAIT);
+	unsigned int nr_entries;
+	unsigned long flags;
+	int i, start, stop;
+
+	if (!buf)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&stack_lock, flags);
+	start = head;
+	stop = tail;
+	spin_unlock_irqrestore(&stack_lock, flags);
+
+	if (start == stop)
+		goto out;
+
+	for (i = start; i < stop; i++) {
+		unsigned long *ent;
+		u32 hash;
+
+		/*
+		 * We avoid holdings the lock over the entire loop
+		 * just to be careful as we don't want to trip a
+		 * call path that calls back into stacklog_debug_save
+		 * which would deadlock, so hold the lock minimally
+		 * (and be ok with the data changing between loop
+		 * iterations).
+		 */
+		spin_lock_irqsave(&stack_lock, flags);
+		hash = stack_list[i % LIST_ENTRIES];
+		spin_unlock_irqrestore(&stack_lock, flags);
+
+		nr_entries = stack_depot_fetch(hash, &ent);
+		stack_trace_snprint(buf, BUFSZ, ent, nr_entries, 0);
+		seq_printf(s, "[idx: %i hash: %ld]====================\n%s\n\n",
+			   i - start, (long)hash, buf);
+	}
+out:
+	kfree(buf);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(stacklog_stats);
+
+static int __init stacklog_debug_init(void)
+{
+	debugfs_create_file("stacklog_debug", 0400, NULL, NULL,
+			    &stacklog_stats_fops);
+	return 0;
+}
+
+late_initcall(stacklog_debug_init);
+#endif
-- 
2.47.0.163.g1226f6d8fa-goog


