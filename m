Return-Path: <linux-kernel+bounces-360105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C335999476
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2E81F246F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2020B1E3773;
	Thu, 10 Oct 2024 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B54KG3J9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFB51E2841
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 21:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728595703; cv=none; b=ghybKYaax0v0+F5bwaQucA1omISitGtvhCxigZi9vXWOlZzK4nukJzj6qLH4pwaomNXJFCXWZAH/ZKvGsNmek31aF3nSuHvdpQ/tplnH2gykoMOOdxXolEXeV6XlK2ZZLuwMqI1RMfb2iyMnJEThO3UJKzYEFoAo82j2E6VZK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728595703; c=relaxed/simple;
	bh=psNcz1hzx4eVjeh0OKKrjZTxBlu4CJaYduRwBIFql8M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JAomY34CMEJZ5npuQB+Qy5mN3ZaJPu+gXhft/kF7J0y4ioHR8gUpgDbZbDO7g/ZNQXLYOhk+N2AW064XZSxrup6SewKPt3FxVOcSqxakz5hOK8nG6ytygwP7TRxpI7WpScOQcbNwN1OAbZenp44duhgZuGAkXGGYiM62w2g5ifQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B54KG3J9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6dbbeee08f0so37246907b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728595701; x=1729200501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QlhYD6q9NouOCiJ7DjFXx6k51jTyDvbLVUqRaotVSIs=;
        b=B54KG3J9Une7vD7Vv0xeUE7bhI7vtYKkLyHpFN1kiJ2YVUs5dKU6HxlSdJsIwOYbvC
         1plF0+UKMy9DnBGxqLXC0GVpkxv13CXU75zGtr/mnXbqonyK9L2mOQ9WphtY3NdnL8kP
         dL3C67fLjm349LuvP1vJzu9riqfBGWUZLby33liVR8f7Iu5k//1JZU/qcJ+8ZoPjAmP3
         jRwig7ujvZqoQNtURFRU9hBxBcoUZZ4sbZXd+gw03psfqpathBXTfBl5NWa1IgzC07DY
         A8NhUtCZ+40+gG2sq4EqkbUZ/DIsQQzMljd/DeceG5dMebC5AbwibQl2Zk1BD05ptS3e
         wxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728595701; x=1729200501;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QlhYD6q9NouOCiJ7DjFXx6k51jTyDvbLVUqRaotVSIs=;
        b=P/cyaFTPqmESLgwsPY7XBoMBMPXZxvhQl3Ne3VkqKiWk0dGz2MSJTls50zr09/PqfK
         1n6cLycWz6Rj49Kd/uvU1WlXyq0NPOt85F1FGBJHzQ5tLgDp4RH7KJ0xWnNhKeTQmTth
         Zmn+JV3MWl9C6PdUO+kNEkew7y7hTaMCvq8U//CnwbFOWvSKRL+u9H+ycaHdg/E2MZWv
         vWzhfesCo/axhbIHf4ZPPA0jsr+qU7e9yK6UIGchkCA1wb3AskQy0ucbHC+fkXiaNw4H
         m23SzqOSqegEcTNDAQwyjH/YMWDNUDPey4/a6s6ymHoNa4ACkh02jL8lMF7Gz1OUILur
         ZIxQ==
X-Gm-Message-State: AOJu0YyZAgx0BtVKq1HLJjybHNNbs6Teoamh8KrNKn92GhLT6sNwybCa
	KWACBdMwHvW+3F6KmUhwfUSKA4yo3HpwiJSRaD6luL3HEIgk2hZfcqBcawJog5806+wnGdBZ8ej
	teKutT5iQKkWMnzmTNYfD00kJFav0uXka+u4Ffjkg5bWotQ7+gcpLyZuNiR8XuoO5dptk/HCBBF
	SzgdT60Yz7u3A9seDS2x8ZL/2NMLnJZbiTgCrkvi+EzNll
X-Google-Smtp-Source: AGHT+IGSsxuFu0sH6JPJFBG2daeJ2pbCAf/cUJF+sY7MH4hVll61k4ev/eRQqgqRT6q9FI8EAPr5iB5NQiwk
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:b228:0:b0:e28:e8c4:923c with SMTP id
 3f1490d57ef6-e291840ddd7mr13191276.4.1728595700383; Thu, 10 Oct 2024 14:28:20
 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:28:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010212813.2125851-1-jstultz@google.com>
Subject: [RFC][PATCH] lib: stacklog_debug: Introduce helper tool for
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
 include/linux/stacklog_debug.h |  13 ++++
 lib/Kconfig                    |   8 +++
 lib/Makefile                   |   1 +
 lib/stacklog_debug.c           | 110 +++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)
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
index b38849af6f13..3a90b9d4f8de 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -725,6 +725,14 @@ config REF_TRACKER
 	depends on STACKTRACE_SUPPORT
 	select STACKDEPOT
 
+config STACKLOG_DEBUG
+	bool "Debug tool for logging and later displaying stacktraces"
+	select STACKDEPOT
+	select STACKDEPOT_ALWAYS_INIT
+	help
+	  Enables debug infrastructure for logging unique stack traces at
+	  a specific point, which can be later displayed from userland.
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
2.47.0.rc1.288.g06298d1525-goog


