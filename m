Return-Path: <linux-kernel+bounces-293340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C46B957E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D656C28581B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E961E7A55;
	Tue, 20 Aug 2024 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f8PqN4CG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yp4wqWfq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5950B1E213D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135412; cv=none; b=N1OON5iu6kkSKtgb+T5nN/4FexCwDXn7oDkcVNcCHw1km52NRxjtZACOmVr5/6fe4KxDj5BqMS9i0vQUn+0bTlz3fkQhdye9sxCUZxkXj8mGlAy0KUmzUkywK/AyHPRg7md5MylZhNMmaa+ZdZPUhjr5nLYq8VP2Rk0bpmJO4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135412; c=relaxed/simple;
	bh=QrBIkTvCOFhbSOQNQYQPWRvBsOkZIQIhjIsflOZGoeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nXGO9ye4GMCVOnr/oCPMY+HbN6WOb6Amv5eFl5G7U1QOAuN+4Ha1BjEZZ1xtrImNY3Y0qIrNx2L5Nf41Q39k/D1mXgboDBuuiGKFB2NtW5tHGurfbSe0V12tX+ZdOUlc4+i8UlVNL2G0LbpLN6RqtSy7HSh7vc0jW8K9cdDU4XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f8PqN4CG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yp4wqWfq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KrenqVQnJa79mERVlAxgaQwwNijaZMJDRB7NmktjWzw=;
	b=f8PqN4CGkSxRXdJqj6el2puORd08oV0SkOYaHbcRSSwnX/MreUxQKkE+mAiHZXVR7/55jw
	DfuK/5BTls6CUxAtC0HuiPJmAoJ7JXlyZfzTeWnVJzCd70WL0QmrUVNRFDfgN/SAcOhxVj
	UI/Fvd6sM9DQ/Q8q2j+Ve2i8K5HZjo0/NV6Kf1ir6AExEKhEjmcgKRq6/MtyrYXwoKDYLK
	WJQpSJgEYlXCoj/DukE1RKav1gMntzR6Z4K2r38MtjtN203n5ykGX2MiEz3l7O2fuGfVIT
	xOUaN+KQ9A2ueA5/s1x3iEBSqMsV9TGehQBbGWnfRbHHrkzXWjZRJwNEFneOoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KrenqVQnJa79mERVlAxgaQwwNijaZMJDRB7NmktjWzw=;
	b=yp4wqWfqrUG2L44+KGipgCLF/b2K5T6ZfI9m4QODdmjfN3jKu3NkUJATBLLsFPUisKZKEb
	/kIUYAcnOQH5YeBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v8 13/35] nbcon: Add API to acquire context for non-printing operations
Date: Tue, 20 Aug 2024 08:35:39 +0206
Message-Id: <20240820063001.36405-14-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide functions nbcon_device_try_acquire() and
nbcon_device_release() which will try to acquire the nbcon
console ownership with NBCON_PRIO_NORMAL and mark it unsafe for
handover/takeover.

These functions are to be used together with the device-specific
locking when performing non-printing activities on the console
device. They will allow synchronization against the
atomic_write() callback which will be serialized, for higher
priority contexts, only by acquiring the console context
ownership.

Pitfalls:

The API requires to be called in a context with migration
disabled because it uses per-CPU variables internally.

The context is set unsafe for a takeover all the time. It
guarantees full serialization against any atomic_write() caller
except for the final flush in panic() which might try an unsafe
takeover.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h |  2 ++
 include/linux/printk.h  | 14 ++++++++++
 kernel/printk/nbcon.c   | 58 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index aafe3121b74e..3706f944de46 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -322,6 +322,7 @@ struct nbcon_write_context {
  *
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
+ * @nbcon_device_ctxt:	Context available for non-printing operations
  * @pbufs:		Pointer to nbcon private buffer
  */
 struct console {
@@ -417,6 +418,7 @@ struct console {
 
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
+	struct nbcon_context	__private nbcon_device_ctxt;
 	struct printk_buffers	*pbufs;
 };
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index eee8e97da681..9687089f5ace 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -9,6 +9,8 @@
 #include <linux/ratelimit_types.h>
 #include <linux/once_lite.h>
 
+struct console;
+
 extern const char linux_banner[];
 extern const char linux_proc_banner[];
 
@@ -198,6 +200,8 @@ extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
 void console_try_replay_all(void);
+extern bool nbcon_device_try_acquire(struct console *con);
+extern void nbcon_device_release(struct console *con);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -280,6 +284,16 @@ static inline void printk_trigger_flush(void)
 static inline void console_try_replay_all(void)
 {
 }
+
+static inline bool nbcon_device_try_acquire(struct console *con)
+{
+	return false;
+}
+
+static inline void nbcon_device_release(struct console *con)
+{
+}
+
 #endif
 
 bool this_cpu_in_panic(void);
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index f279f839741a..61f0ae6a4809 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -5,7 +5,9 @@
 #include <linux/kernel.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include "internal.h"
 /*
  * Printk console printing implementation for consoles which does not depend
@@ -546,6 +548,7 @@ static struct printk_buffers panic_nbcon_pbufs;
  * nbcon_context_try_acquire - Try to acquire nbcon console
  * @ctxt:	The context of the caller
  *
+ * Context:	Under @ctxt->con->device_lock() or local_irq_save().
  * Return:	True if the console was acquired. False otherwise.
  *
  * If the caller allowed an unsafe hostile takeover, on success the
@@ -553,7 +556,6 @@ static struct printk_buffers panic_nbcon_pbufs;
  * in an unsafe state. Otherwise, on success the caller may assume
  * the console is not in an unsafe state.
  */
-__maybe_unused
 static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 {
 	unsigned int cpu = smp_processor_id();
@@ -1011,3 +1013,57 @@ void nbcon_free(struct console *con)
 
 	con->pbufs = NULL;
 }
+
+/**
+ * nbcon_device_try_acquire - Try to acquire nbcon console and enter unsafe
+ *				section
+ * @con:	The nbcon console to acquire
+ *
+ * Context:	Under the locking mechanism implemented in
+ *		@con->device_lock() including disabling migration.
+ * Return:	True if the console was acquired. False otherwise.
+ *
+ * Console drivers will usually use their own internal synchronization
+ * mechasism to synchronize between console printing and non-printing
+ * activities (such as setting baud rates). However, nbcon console drivers
+ * supporting atomic consoles may also want to mark unsafe sections when
+ * performing non-printing activities in order to synchronize against their
+ * atomic_write() callback.
+ *
+ * This function acquires the nbcon console using priority NBCON_PRIO_NORMAL
+ * and marks it unsafe for handover/takeover.
+ */
+bool nbcon_device_try_acquire(struct console *con)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_device_ctxt);
+
+	cant_migrate();
+
+	memset(ctxt, 0, sizeof(*ctxt));
+	ctxt->console	= con;
+	ctxt->prio	= NBCON_PRIO_NORMAL;
+
+	if (!nbcon_context_try_acquire(ctxt))
+		return false;
+
+	if (!nbcon_context_enter_unsafe(ctxt))
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(nbcon_device_try_acquire);
+
+/**
+ * nbcon_device_release - Exit unsafe section and release the nbcon console
+ * @con:	The nbcon console acquired in nbcon_device_try_acquire()
+ */
+void nbcon_device_release(struct console *con)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_device_ctxt);
+
+	if (!nbcon_context_exit_unsafe(ctxt))
+		return;
+
+	nbcon_context_release(ctxt);
+}
+EXPORT_SYMBOL_GPL(nbcon_device_release);
-- 
2.39.2


