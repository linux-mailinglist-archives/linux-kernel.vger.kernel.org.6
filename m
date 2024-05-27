Return-Path: <linux-kernel+bounces-190101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 604F88CF96D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE711C20D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BDE13C82C;
	Mon, 27 May 2024 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ktm8CYU4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VrS+8W/X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AB413A3FE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791910; cv=none; b=l2y8VGGCiN+Man9ksfihV5mmfQoBwaJcA0NrJS9hTH+V2SyQPL89b4ml3B0FmiogDlAe5vPcmbfKrj6nOfwLx+385bfywGs1OH1+xhAZK/clif3jDatElQgXOCYn7clNM8EReytQZX/MeDvucILvwZwK1rECceiRICUnuGo3GoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791910; c=relaxed/simple;
	bh=AcaXIehwkrC7oSMnVU4pqyFIUrE3I7QOjHEIvDejEww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UwGChZO7KN5QbryyIvJKdl1xqyD53D3Xh50GRYMY4Ku/3fK40ePgN+TmTtrFN8I9k+fRU+2mr7YEqE6sq82cvHB+qVxwn5JrxSxln3Y46arVCAaXnmQDfu9x65qrHFVAKs3ojP/ziomjqZKFOXZsS8yf4eTRoSBNXfASvg0izy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ktm8CYU4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VrS+8W/X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GC3WEoPfSa5I25Dvpbsqwg+xsmG6i0ZBrHfYfar8GTQ=;
	b=ktm8CYU4+B/OYB6H08c7lFUKiyScuhcLKOrdd65GJ729nGmdd/3a5X/hXosaejHDq1h4JD
	e3gCDQbqAlxqz4DI3+OlsB6eJGdQ76g3JVnQ0vrAafr51nCqrhkGDv68C+AP4ZsMR0+A8l
	NaNrjG0yo4qJzrmkYdyqRGakgoJZWkk++EJgBKp9SHwdOo81Crc2Ftms96xYh9GY9Pnuh5
	Nj11hGu38RCXVKJkvNqkzRTPQ3eQXv4Iexq3uvuquO106j+UEVx9migX3TtpF0/TZlBYOW
	Wz7zWk6YNa3G96rk+EP8Spe8q/PcHm6u7/9varDLfuCac+sHAp0qV2RGunGv1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GC3WEoPfSa5I25Dvpbsqwg+xsmG6i0ZBrHfYfar8GTQ=;
	b=VrS+8W/Xu826Qge6TC/fFZuA8Zjqz8IsrN0hrtkJxuN3nGmF5mQr5AWdKDaJDc8aOahrqO
	cM3i8DXsyD1A4EDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v6 26/30] printk: nbcon: Implement emergency sections
Date: Mon, 27 May 2024 08:43:45 +0206
Message-Id: <20240527063749.391035-27-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

In emergency situations (something has gone wrong but the
system continues to operate), usually important information
(such as a backtrace) is generated via printk(). Each
individual printk record has little meaning. It is the
collection of printk messages that is most often needed by
developers and users.

In order to help ensure that the collection of printk messages
in an emergency situation are all stored to the ringbuffer as
quickly as possible, disable console output for that CPU while
it is in the emergency situation. The consoles need to be
flushed when exiting the emergency situation.

Add per-CPU emergency nesting tracking because an emergency
can arise while in an emergency situation.

Add functions to mark the beginning and end of emergency
sections where the urgent messages are generated.

Do not print if the current CPU is in an emergency state.

When exiting all emergency nesting, flush nbcon consoles
directly using their atomic callback. Legacy consoles are
flushed directly if safe, otherwise they are triggered for
flushing via irq_work.

Note that the emergency state is not system-wide. While one CPU
is in an emergency state, another CPU may continue to print
console messages.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h     |   6 ++
 kernel/printk/internal.h    |  13 ++++
 kernel/printk/nbcon.c       | 126 ++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c      |  25 +++----
 kernel/printk/printk_safe.c |  11 +++-
 5 files changed, 168 insertions(+), 13 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 729f7c3b10c1..f1463c1dd9c1 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -535,10 +535,16 @@ static inline bool console_is_registered(const struct console *con)
 	hlist_for_each_entry(con, &console_list, node)
 
 #ifdef CONFIG_PRINTK
+extern void nbcon_cpu_emergency_enter(void);
+extern void nbcon_cpu_emergency_exit(void);
+extern void nbcon_cpu_emergency_flush(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
 #else
+static inline void nbcon_cpu_emergency_enter(void) { }
+static inline void nbcon_cpu_emergency_exit(void) { }
+static inline void nbcon_cpu_emergency_flush(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 91bc0ee43f8d..0439cf2fdc22 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -76,6 +76,8 @@ bool printk_percpu_data_ready(void);
 
 void defer_console_output(void);
 
+bool is_printk_deferred(void);
+
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
 void console_lock_spinning_enable(void);
@@ -153,6 +155,17 @@ static inline bool console_is_usable(struct console *con, short flags) { return
 
 #endif /* CONFIG_PRINTK */
 
+extern bool have_boot_console;
+extern bool have_legacy_console;
+
+/*
+ * Specifies if the console lock/unlock dance is needed for console
+ * printing. If @have_boot_console is true, the nbcon consoles will
+ * be printed serially along with the legacy consoles because nbcon
+ * consoles cannot print simultaneously with boot consoles.
+ */
+#define printing_via_unlock (have_legacy_console || have_boot_console)
+
 extern struct printk_buffers printk_shared_pbufs;
 
 /**
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 67a2a73a1aaf..6e9e24aa0a7f 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -936,6 +936,29 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	return nbcon_context_exit_unsafe(ctxt);
 }
 
+/* Track the nbcon emergency nesting per CPU. */
+static DEFINE_PER_CPU(unsigned int, nbcon_pcpu_emergency_nesting);
+static unsigned int early_nbcon_pcpu_emergency_nesting __initdata;
+
+/**
+ * nbcon_get_cpu_emergency_nesting - Get the per CPU emergency nesting pointer
+ *
+ * Return:	Either a pointer to the per CPU emergency nesting counter of
+ *		the current CPU or to the init data during early boot.
+ */
+static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
+{
+	/*
+	 * The value of __printk_percpu_data_ready gets set in normal
+	 * context and before SMP initialization. As a result it could
+	 * never change while inside an nbcon emergency section.
+	 */
+	if (!printk_percpu_data_ready())
+		return &early_nbcon_pcpu_emergency_nesting;
+
+	return this_cpu_ptr(&nbcon_pcpu_emergency_nesting);
+}
+
 /**
  * nbcon_get_default_prio - The appropriate nbcon priority to use for nbcon
  *				printing on the current CPU
@@ -946,9 +969,15 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
  */
 enum nbcon_prio nbcon_get_default_prio(void)
 {
+	unsigned int *cpu_emergency_nesting;
+
 	if (this_cpu_in_panic())
 		return NBCON_PRIO_PANIC;
 
+	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
+	if (*cpu_emergency_nesting)
+		return NBCON_PRIO_EMERGENCY;
+
 	return NBCON_PRIO_NORMAL;
 }
 
@@ -1206,6 +1235,103 @@ void nbcon_atomic_flush_unsafe(void)
 	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), true);
 }
 
+/**
+ * nbcon_cpu_emergency_enter - Enter an emergency section where printk()
+ *				messages for that CPU are only stored
+ *
+ * Upon exiting the emergency section, all stored messages are flushed.
+ *
+ * Context:	Any context. Disables preemption.
+ *
+ * When within an emergency section, no printing occurs on that CPU. This
+ * is to allow all emergency messages to be dumped into the ringbuffer before
+ * flushing the ringbuffer. The actual printing occurs when exiting the
+ * outermost emergency section.
+ */
+void nbcon_cpu_emergency_enter(void)
+{
+	unsigned int *cpu_emergency_nesting;
+
+	preempt_disable();
+
+	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
+	(*cpu_emergency_nesting)++;
+}
+
+/**
+ * nbcon_cpu_emergency_exit - Exit an emergency section and flush the
+ *				stored messages
+ *
+ * Flushing only occurs when exiting all nesting for the CPU.
+ *
+ * Context:	Any context. Enables preemption.
+ */
+void nbcon_cpu_emergency_exit(void)
+{
+	unsigned int *cpu_emergency_nesting;
+	bool do_trigger_flush = false;
+
+	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
+
+	/*
+	 * Flush the messages before enabling preemtion to see them ASAP.
+	 *
+	 * Reduce the risk of potential softlockup by using the
+	 * flush_pending() variant which ignores messages added later. It is
+	 * called before decrementing the counter so that the printing context
+	 * for the emergency messages is NBCON_PRIO_EMERGENCY.
+	 */
+	if (*cpu_emergency_nesting == 1) {
+		nbcon_atomic_flush_pending();
+
+		/*
+		 * Safely attempt to flush the legacy consoles in this
+		 * context. Otherwise an irq_work context is triggered
+		 * to handle it.
+		 */
+		do_trigger_flush = true;
+		if (printing_via_unlock && !is_printk_deferred()) {
+			if (console_trylock()) {
+				do_trigger_flush = false;
+				console_unlock();
+			}
+		}
+	}
+
+	if (!WARN_ON_ONCE(*cpu_emergency_nesting == 0))
+		(*cpu_emergency_nesting)--;
+
+	preempt_enable();
+
+	if (do_trigger_flush)
+		printk_trigger_flush();
+}
+
+/**
+ * nbcon_cpu_emergency_flush - Explicitly flush consoles while
+ *				within emergency context
+ *
+ * Both nbcon and legacy consoles are flushed.
+ *
+ * It should be used only when there are too many messages printed
+ * in emergency context, for example, printing backtraces of all
+ * CPUs or processes. It is typically needed when the watchdogs
+ * need to be touched as well.
+ */
+void nbcon_cpu_emergency_flush(void)
+{
+	/* The explicit flush is needed only in the emergency context. */
+	if (*(nbcon_get_cpu_emergency_nesting()) == 0)
+		return;
+
+	nbcon_atomic_flush_pending();
+
+	if (printing_via_unlock && !is_printk_deferred()) {
+		if (console_trylock())
+			console_unlock();
+	}
+}
+
 /**
  * nbcon_alloc - Allocate buffers needed by the nbcon console
  * @con:	Console to allocate buffers for
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 57e190fbecd7..c623f9ce9b7b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -468,7 +468,7 @@ static DEFINE_MUTEX(syslog_lock);
  * present, it is necessary to perform the console lock/unlock dance
  * whenever console flushing should occur.
  */
-static bool have_legacy_console;
+bool have_legacy_console;
 
 /*
  * Specifies if an nbcon console is registered. If nbcon consoles are present,
@@ -483,15 +483,7 @@ static bool have_nbcon_console;
  * the console lock. This is because boot consoles and nbcon consoles may
  * have mapped the same hardware.
  */
-static bool have_boot_console;
-
-/*
- * Specifies if the console lock/unlock dance is needed for console
- * printing. If @have_boot_console is true, the nbcon consoles will
- * be printed serially along with the legacy consoles because nbcon
- * consoles cannot print simultaneously with boot consoles.
- */
-#define printing_via_unlock (have_legacy_console || have_boot_console)
+bool have_boot_console;
 
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
@@ -2412,16 +2404,25 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 * printing of all remaining records to all consoles so that
 		 * this context can return as soon as possible. Hopefully
 		 * another printk() caller will take over the printing.
+		 *
+		 * Also, nbcon_get_default_prio() requires migration disabled.
 		 */
 		preempt_disable();
+
 		/*
 		 * Try to acquire and then immediately release the console
 		 * semaphore. The release will print out buffers. With the
 		 * spinning variant, this context tries to take over the
 		 * printing from another printing context.
+		 *
+		 * Skip it in EMERGENCY priority. The console will be
+		 * explicitly flushed when exiting the emergency section.
 		 */
-		if (console_trylock_spinning())
-			console_unlock();
+		if (nbcon_get_default_prio() != NBCON_PRIO_EMERGENCY) {
+			if (console_trylock_spinning())
+				console_unlock();
+		}
+
 		preempt_enable();
 	}
 
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 4421ccac3113..f47fef701265 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -38,6 +38,15 @@ void __printk_deferred_exit(void)
 	__printk_safe_exit();
 }
 
+bool is_printk_deferred(void)
+{
+	/*
+	 * The per-CPU variable @printk_context can be read safely in any
+	 * context. The CPU migration always disabled when set.
+	 */
+	return (this_cpu_read(printk_context) || in_nmi());
+}
+
 asmlinkage int vprintk(const char *fmt, va_list args)
 {
 #ifdef CONFIG_KGDB_KDB
@@ -50,7 +59,7 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	 * Use the main logbuf even in NMI. But avoid calling console
 	 * drivers that might have their own locks.
 	 */
-	if (this_cpu_read(printk_context) || in_nmi())
+	if (is_printk_deferred())
 		return vprintk_deferred(fmt, args);
 
 	/* No obstacles. */
-- 
2.39.2


