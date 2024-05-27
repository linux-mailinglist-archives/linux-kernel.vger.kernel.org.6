Return-Path: <linux-kernel+bounces-190082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F94D8CF951
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741FB1C20A85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0119854657;
	Mon, 27 May 2024 06:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IFXFLCuO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n55C7AG/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B9025774
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791904; cv=none; b=iBqmBPNYOq6NWmvLNOMtYIRWUZNaESM55WO9TDp8vNjRTnOpLSKvblpGjn4QaMyEFP1lCPt+alv7Uu9MY2c6uJ+pffLiRhi34VDupkn+UXdrTQf5XWZe01//wADEgQEblAxAk7d57gMa6PaVLq6IME/R6ld9NYgMJMih1GvRdSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791904; c=relaxed/simple;
	bh=zB+R6jhg2BE6ADHCpzR6mMsmJtTlMFnZXzIpx7pfX40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBDcrFB6cEyUgbkBTfnuqGFj7fb0WDJSZM9TQ0OuVslKCntGtPNdoPXpsyDdXOno9i4cJX7SYPvbSm7mEGmfkIn1kFYe7diARQK2PVrpn0ZU8+Go0RPZDTFlP5KquM+u1rDDitXpGOXwZbuVMuuAvYEJxwbKVj8BntmqMsvr5yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IFXFLCuO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n55C7AG/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GoAnFoEDBtUewczef8goHn9wNNbG58iWoQEY2ToK04k=;
	b=IFXFLCuO9PvXtfNHNA0n3oP+uHMJIFeVM1fpRWQElecn6BnzcoIBUxI9aHeJilUXnIQ2M8
	EusljbidYDwiyd31vZMel0W3MugopB0WMHB19UCTH9ETEVMi4mg60jKagmOv47avuida7e
	bjAp8V8UHJuO8DhnA7KeLkobS/FcvFyQ/vU2D91Exrp2m1vs+lcSrflGY2GEornKInOvlp
	AyQepP3dsUmjzTn6p0pjnSStsiBUwdgD7nn5KTXNAaFyw3LapXi/WvsGFKQE5jxIMZ0FHy
	xuugRHlA3jkDMojqWK7XrfaBr+Hx04qjompiVilcU1ppnmALosqMALJAYzJHAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GoAnFoEDBtUewczef8goHn9wNNbG58iWoQEY2ToK04k=;
	b=n55C7AG/uJkfQLYGvY709d/WmgZSFNur/U83H1HlprzxNNrOxzO4/Td6va71SCXYVD8GUA
	ghlwFbKFxaL/emBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v6 11/30] nbcon: Add API to acquire context for non-printing operations
Date: Mon, 27 May 2024 08:43:30 +0206
Message-Id: <20240527063749.391035-12-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
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
 include/linux/printk.h  | 14 +++++++++++
 kernel/printk/nbcon.c   | 56 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index aea4f5aa4a45..dd3d4b5d3737 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -304,6 +304,7 @@ struct nbcon_write_context {
  *
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
+ * @nbcon_device_ctxt:	Context available for non-printing operations
  * @pbufs:		Pointer to nbcon private buffer
  */
 struct console {
@@ -399,6 +400,7 @@ struct console {
 
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
+	struct nbcon_context	__private nbcon_device_ctxt;
 	struct printk_buffers	*pbufs;
 };
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 6e1f055afef6..31f72df29da5 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -9,6 +9,8 @@
 #include <linux/ratelimit_types.h>
 #include <linux/once_lite.h>
 
+struct console;
+
 extern const char linux_banner[];
 extern const char linux_proc_banner[];
 
@@ -193,6 +195,8 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+extern bool nbcon_device_try_acquire(struct console *con);
+extern void nbcon_device_release(struct console *con);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -272,6 +276,16 @@ static inline void dump_stack(void)
 static inline void printk_trigger_flush(void)
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
index dd7c3180b335..1c03508b90f2 100644
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
@@ -528,6 +530,7 @@ static struct printk_buffers panic_nbcon_pbufs;
  * nbcon_context_try_acquire - Try to acquire nbcon console
  * @ctxt:	The context of the caller
  *
+ * Context:	Under @ctxt->con->device_lock() or local_irq_save().
  * Return:	True if the console was acquired. False otherwise.
  *
  * If the caller allowed an unsafe hostile takeover, on success the
@@ -535,7 +538,6 @@ static struct printk_buffers panic_nbcon_pbufs;
  * in an unsafe state. Otherwise, on success the caller may assume
  * the console is not in an unsafe state.
  */
-__maybe_unused
 static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 {
 	unsigned int cpu = smp_processor_id();
@@ -989,3 +991,55 @@ void nbcon_free(struct console *con)
 
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
+	if (nbcon_context_exit_unsafe(ctxt))
+		nbcon_context_release(ctxt);
+}
+EXPORT_SYMBOL_GPL(nbcon_device_release);
-- 
2.39.2


