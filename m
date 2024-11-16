Return-Path: <linux-kernel+bounces-411534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE689CFBA3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31E61F21925
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F274A2D;
	Sat, 16 Nov 2024 00:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1hr6GmYm"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091B01FA4
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 00:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731716611; cv=none; b=KZeUSYy6B2vMdOw4QX766fOcwCa5KB/kV/dsdW9eBOdXLNLWmpC72cTNYbZkeJnPYtA30bKXr9297X2d4eSDyBOHJFEmFygCktnbio3k5Olf1wMx2Bu9cJnVgfkQetdSSuUOaGTULUSvo80FxPZKg+AsmXneotOJue60Emt9PgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731716611; c=relaxed/simple;
	bh=ThfM49seT36ShoQmc4VDUbcgkvLxGti2aAgI6hzoie0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=K8fyBHMv4dAjd3lDuC7v55YXoTPFJ82yhVaq1C0gg2C5HVSrKMcJ9jOYIv/v9VOlmkNgLF/kwuvFT1rps4p5dtf9/foJlTOLk0BUmYgCdcgXkpVvlbzeEF9wmgiNKAWO/i8v8aD1QMd+xz30Awy9yDCxzc6hhivz55DNL7ma6Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1hr6GmYm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21159b15562so16515445ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731716609; x=1732321409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8/PJntpvS80At3uXBJQS3gJiMTy4hYHZsHn0NNsIenw=;
        b=1hr6GmYm28sl6q5sJ046EXz4O6CUhYE5XPEq2oeLJ5Q9PAOI6+kvqCLQje1NjfCg6Q
         Kf/44+Pi8uzBF0d11rlu7KzU2WD9QRmUddYmW+ispm9fnskFt3NUkTe2WIzyvS3JPWAN
         JokR7MfBqkK4BBWWXSfb1lNZH84quNsV8qvZK557CWvB/qaL6Apct4XhllNRCQrrm8Ka
         MmJFkf8CN0YmS9cUi+wlMZRd4O3q9WdwRW3BHc9jcwiUufdJNX5NrRaISVYIQg0ITYIR
         nbNpzW5EoxbNU9ts+7yMG7CSoAooGZ+Qtmuz5Ade1fbJMncHL6DI6VKgAzQGQdNIcsa7
         C0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731716609; x=1732321409;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8/PJntpvS80At3uXBJQS3gJiMTy4hYHZsHn0NNsIenw=;
        b=JnX8SmX1jO9Ite0WQCuWfi+SNdoYajFuKhZ/tUKq8/c0FSFioScso9jT7quYdKJzzF
         BmQsc+dMgdfrv5ck1fgCMH+VLcE4ROdJHqSRmD1CbpgMJC8L42M2zBi7LWo7Fim9jr+a
         UOGJJgnVXbVR62h4uC56cKX1QaRaY0bfz/Kw8WxA5rI/NyE0lMowW0bhPYsJ80Iybezz
         o1Fom/cZaRjjR+HQpN6HYMtgCiMDCGFhZoKxdzroF+rCdyGfFWayCM0VpYNT4EHxOhQ7
         okrPfo+Hray5ITsFVooffi8z/i/lLbIFA2P0dORIFXyo2yahhrKB0hvb9nxtefIR2qoi
         K9yQ==
X-Gm-Message-State: AOJu0YxikSUb0tCTDGxKhyYceGGIVfevBSlu8sxyo936iAREuyMlrqWS
	V8YfI1lmVQU5qGYjVDK2d9fviCegk98ak0pCmMtS3v+PJV0WQKZnAUHzJvj6mkBP7z1D1XTKxZT
	TqxmemzcijvVk0gUonZHcAj1yiXVIPmowVKDzVriEFYGTI8nQSCnfZIWy9p7QNFZdnGUAS2uCjV
	AfTGrqOYpqFomgy9XePzDX82/hsuaYS2kw0gUmgCITNXfN
X-Google-Smtp-Source: AGHT+IGU8VXrhCvWMXSl1UyE/U3Yc5oah5iBrkLw4el4cmAlxA46pN5eRBAs++3dZJQ6MvaWpqaLvN+Tnk6B
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:903:120e:b0:20b:7c00:5e3d with SMTP id
 d9443c01a7336-211d0ebc0a0mr123725ad.5.1731716608693; Fri, 15 Nov 2024
 16:23:28 -0800 (PST)
Date: Fri, 15 Nov 2024 16:23:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241116002322.1035417-1-jstultz@google.com>
Subject: [PATCH v2 1/2] lib: stacklog_debug: Introduce helper tool for
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
2.47.0.338.g60cca15819-goog


