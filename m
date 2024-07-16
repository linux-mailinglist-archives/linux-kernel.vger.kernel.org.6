Return-Path: <linux-kernel+bounces-253298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82D2931F37
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384A21F21BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B4DDDC0;
	Tue, 16 Jul 2024 03:21:11 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15A7EF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721100071; cv=none; b=M39GigtNd4VDw0y3iw51AZi1ieUQmyjVcWy8U2PNmcIUJADx4+CCT0+pJCKMqmc+NzRH7ouaP4+0ExxLgJast6RnJNggNJcHXI0tRl9ifLUrPpmNx9aPKDSnJG/0VxJve+JFt/iSzUmbWdiG0dZh4BAq+GrnVUJtW2oNnwdi0rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721100071; c=relaxed/simple;
	bh=3vCO8bZBz73tBTiEUBHnCgK+2ce4W8iLO55IEeJKx7g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n3B/W/D+2G2wq8sdamwtQe0avzIGZx2SrlICCirrcMahqs+nKkt0eDFMKvbvspI6DaGUXCjLgG0QtKs7zG6vAI8g0pMCh8X/JvWR4y+MKyuTl8yys6BI80jbMwzB2VAOxgd0Ot1mxGd9md86WnCzDNhQfdn7RKO5fC9Dkr2kkpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sTYkH-000000008Mx-0804;
	Mon, 15 Jul 2024 23:20:53 -0400
Date: Mon, 15 Jul 2024 23:20:52 -0400
From: Rik van Riel <riel@surriel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Omar Sandoval <osandov@meta.com>, linux-kernel@vger.kernel.org, Petr
 Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, John
 Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky
 <senozhatsky@chromium.org>
Subject: [RFC PATCH] nmi,printk: fix ABBA deadlock between nmi_backtrace and
 dump_stack_lvl
Message-ID: <20240715232052.73eb7fb1@imladris.surriel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

Both nmi_backtrace and dump_stack_lvl call printk_cpu_sync_get_irqsave.

However, dump_stack_lvl will call into the printk code, while holding
the printk_cpu_sync_get lock, and then take the console lock.

Another CPU may end up getting an NMI stack trace printed, after
being stuck printing something to serial console for too long,
with the console lock held.

This results in the following lock order:
CPU A: printk_cpu_sync_get lock -> console_lock
CPU B: console_lock -> (nmi) printk_cpu_sync_get lock

This will cause the system to hang with an ABBA deadlock, which
lockdep cannot detect (because the printk_cpu_sync_get "lock" is
special), and which results in the kernel panic code being unable
to get CPU B (stuck in the NMI handler) to even dump its own register
state, resulting in the kdump not containing everything needed to
get a clean backtrace of what that CPU is doing.

Omar and I poked around the kernel stacks of a few crash dumps to
figure out what was going on before we found this deadlock.

I am not entirely happy about this solution, since it can result
in NMI and non-NMI backtraces getting printed out in an interleaved
fashion, but I cannot think of a better way to avoid this deadlock.
I'm open to suggestions :)

Signed-off-by: Rik van Riel <riel@surriel.com>
Cc: Omar Sandoval <osandov@meta.com>
Fixes: 55d6af1d6688 ("lib/nmi_backtrace: explicitly serialize banner and regs")
---
 include/linux/printk.h | 28 +++++++++++++++++-----------
 kernel/printk/printk.c | 41 ++++++++++++++++++++++++++++++++---------
 lib/nmi_backtrace.c    |  4 ++--
 3 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 65c5184470f1..37b10f43bb58 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -280,15 +280,15 @@ static inline void console_replay_all(void)
 bool this_cpu_in_panic(void);
 
 #ifdef CONFIG_SMP
-extern int __printk_cpu_sync_try_get(void);
-extern void __printk_cpu_sync_wait(void);
-extern void __printk_cpu_sync_put(void);
+extern int __printk_cpu_sync_try_get(bool nmi);
+extern void __printk_cpu_sync_wait(bool nmi);
+extern void __printk_cpu_sync_put(bool nmi);
 
 #else
 
-#define __printk_cpu_sync_try_get() true
-#define __printk_cpu_sync_wait()
-#define __printk_cpu_sync_put()
+#define __printk_cpu_sync_try_get(_unused) true
+#define __printk_cpu_sync_wait(_unused)
+#define __printk_cpu_sync_put(_unused)
 #endif /* CONFIG_SMP */
 
 /**
@@ -312,28 +312,34 @@ extern void __printk_cpu_sync_put(void);
  *       CPUs after calling this function from any context. This includes
  *       using spinlocks or any other busy-waiting synchronization methods.
  */
-#define printk_cpu_sync_get_irqsave(flags)		\
+#define do_printk_cpu_sync_get(flags, nmi)		\
 	for (;;) {					\
 		local_irq_save(flags);			\
-		if (__printk_cpu_sync_try_get())	\
+		if (__printk_cpu_sync_try_get(nmi))	\
 			break;				\
 		local_irq_restore(flags);		\
-		__printk_cpu_sync_wait();		\
+		__printk_cpu_sync_wait(nmi);		\
 	}
 
+#define printk_cpu_sync_get_irqsave(flags) do_printk_cpu_sync_get(flags, 0)
+#define printk_cpu_sync_get_from_nmi(flags) do_printk_cpu_sync_get(flags, 1)
+
 /**
  * printk_cpu_sync_put_irqrestore() - Release the printk cpu-reentrant spinning
  *                                    lock and restore interrupts.
  * @flags: Caller's saved interrupt state, from printk_cpu_sync_get_irqsave().
  */
-#define printk_cpu_sync_put_irqrestore(flags)	\
+#define do_printk_cpu_sync_put(flags, nmi)	\
 	do {					\
-		__printk_cpu_sync_put();	\
+		__printk_cpu_sync_put(nmi);	\
 		local_irq_restore(flags);	\
 	} while (0)
 
 extern int kptr_restrict;
 
+#define printk_cpu_sync_put_irqrestore(flags) do_printk_cpu_sync_put(flags, 0)
+#define printk_cpu_sync_put_from_nmi(flags) do_printk_cpu_sync_put(flags, 1)
+
 /**
  * pr_fmt - used by the pr_*() macros to generate the printk format string
  * @fmt: format string passed from a pr_*() macro
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index dddb15f48d59..881d1dda6d3a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -4319,7 +4319,23 @@ void console_replay_all(void)
 
 #ifdef CONFIG_SMP
 static atomic_t printk_cpu_sync_owner = ATOMIC_INIT(-1);
+static atomic_t printk_cpu_sync_owner_nmi = ATOMIC_INIT(-1);
 static atomic_t printk_cpu_sync_nested = ATOMIC_INIT(0);
+static atomic_t printk_cpu_sync_nested_nmi = ATOMIC_INIT(0);
+
+static atomic_t *get_printk_sync_owner(bool nmi)
+{
+	if (!nmi)
+		return &printk_cpu_sync_owner;
+	return &printk_cpu_sync_owner_nmi;
+}
+
+static atomic_t *get_printk_sync_nested(bool nmi)
+{
+	if (!nmi)
+		return &printk_cpu_sync_nested;
+	return &printk_cpu_sync_nested_nmi;
+}
 
 /**
  * __printk_cpu_sync_wait() - Busy wait until the printk cpu-reentrant
@@ -4327,11 +4343,13 @@ static atomic_t printk_cpu_sync_nested = ATOMIC_INIT(0);
  *
  * Context: Any context.
  */
-void __printk_cpu_sync_wait(void)
+void __printk_cpu_sync_wait(bool nmi)
 {
+	atomic_t *owner = get_printk_sync_owner(nmi);
+
 	do {
 		cpu_relax();
-	} while (atomic_read(&printk_cpu_sync_owner) != -1);
+	} while (atomic_read(owner) != -1);
 }
 EXPORT_SYMBOL(__printk_cpu_sync_wait);
 
@@ -4346,8 +4364,9 @@ EXPORT_SYMBOL(__printk_cpu_sync_wait);
  * Context: Any context. Expects interrupts to be disabled.
  * Return: 1 on success, otherwise 0.
  */
-int __printk_cpu_sync_try_get(void)
+int __printk_cpu_sync_try_get(bool nmi)
 {
+	atomic_t *owner = get_printk_sync_owner(nmi);
 	int cpu;
 	int old;
 
@@ -4372,7 +4391,7 @@ int __printk_cpu_sync_try_get(void)
 	 * ACQUIRE from __printk_cpu_sync_try_get:A to
 	 * __printk_cpu_sync_try_get:B of this CPU
 	 */
-	old = atomic_cmpxchg_acquire(&printk_cpu_sync_owner, -1,
+	old = atomic_cmpxchg_acquire(owner, -1,
 				     cpu); /* LMM(__printk_cpu_sync_try_get:A) */
 	if (old == -1) {
 		/*
@@ -4382,8 +4401,9 @@ int __printk_cpu_sync_try_get(void)
 		return 1;
 
 	} else if (old == cpu) {
+		atomic_t *nested = get_printk_sync_nested(nmi);
 		/* This CPU is already the owner. */
-		atomic_inc(&printk_cpu_sync_nested);
+		atomic_inc(nested);
 		return 1;
 	}
 
@@ -4398,10 +4418,13 @@ EXPORT_SYMBOL(__printk_cpu_sync_try_get);
  *
  * Context: Any context. Expects interrupts to be disabled.
  */
-void __printk_cpu_sync_put(void)
+void __printk_cpu_sync_put(bool nmi)
 {
-	if (atomic_read(&printk_cpu_sync_nested)) {
-		atomic_dec(&printk_cpu_sync_nested);
+	atomic_t *owner = get_printk_sync_owner(nmi);
+	atomic_t *nested = get_printk_sync_nested(nmi);
+
+	if (atomic_read(nested)) {
+		atomic_dec(nested);
 		return;
 	}
 
@@ -4428,7 +4451,7 @@ void __printk_cpu_sync_put(void)
 	 * ACQUIRE from __printk_cpu_sync_try_get:A to
 	 * __printk_cpu_sync_try_get:B of the next CPU
 	 */
-	atomic_set_release(&printk_cpu_sync_owner,
+	atomic_set_release(owner,
 			   -1); /* LMM(__printk_cpu_sync_put:B) */
 }
 EXPORT_SYMBOL(__printk_cpu_sync_put);
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 33c154264bfe..8fff7d5b86e0 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -101,7 +101,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 		 * Allow nested NMI backtraces while serializing
 		 * against other CPUs.
 		 */
-		printk_cpu_sync_get_irqsave(flags);
+		printk_cpu_sync_get_from_nmi(flags);
 		if (!READ_ONCE(backtrace_idle) && regs && cpu_in_idle(instruction_pointer(regs))) {
 			pr_warn("NMI backtrace for cpu %d skipped: idling at %pS\n",
 				cpu, (void *)instruction_pointer(regs));
@@ -112,7 +112,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 			else
 				dump_stack();
 		}
-		printk_cpu_sync_put_irqrestore(flags);
+		printk_cpu_sync_put_from_nmi(flags);
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
 	}
-- 
2.45.2


