Return-Path: <linux-kernel+bounces-199820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B948FA669
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BF11F235F0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FC213D2A4;
	Mon,  3 Jun 2024 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oghpHSL8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nfih29kq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FC483CD6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 23:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457098; cv=none; b=BnFI+ldy/U4X+3MXH0aXgrDpdUBPLbW06QDtpyK5gFJSQCbMQFsQizllMZLNR/sgG7AtPI49n8snsipQXOLPA902L+SvT1XLs+50DiCIFwznc3OJFtTWEHgYRTX0NDFWhtqxmgCVDqwy8C78C9R54deKOTsAcI4SNp1CNU9C2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457098; c=relaxed/simple;
	bh=cECa+3SjdlOTE2gX/SC6RHnlgdcMpIyIzBaHEsoCoOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dwe+wQqqVRlI00fELzY9FbXyQN6VgZgtY2eQ4swd0TbzgJ/YhhvLwvu0JyyoL493gd4/VxVh5Z3HIDtdN1PA2/9bm4f3IqgAKJaWhAQisDO+B28QIIJcUIB5oLflbZuaI8HIjjU2YTsSr9FvCo8w2DsjfNY99c91hJuoi9PpGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oghpHSL8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nfih29kq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MagFz0dSmih1ouwvcZhD1e4AjKfdqWGnWa+U9V8bzUA=;
	b=oghpHSL8Md05RhYJnw+s1/rEBskGHpRL4CtGg+kzqFfDlUBPBUbXvFvvl0np/HA07I5S7o
	Od0/3yUeJPufENXQ8eWiiHYzTJRQvXsx1XIi/wsw2i5aD3sCVRhDkEDUftJDwOtU5i9/aS
	eefYElhpq6uQD0ikIcd11yH9w5a9KhBypdBBiAnvKMfC1suHySxT0cggNRbhGll2+zrDH+
	RdNvJDsSXEypdV3NJ1lHJxAvFDCEIcJJIwevnlxLM0zRWiq6YGoCdDHuVc9wuCT/Jcoqc2
	99/UJZIr7Wky6r4Xob7JxbxrXmTLMnt3k8rThBBHTzlNu38voBNEUs5W923DTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MagFz0dSmih1ouwvcZhD1e4AjKfdqWGnWa+U9V8bzUA=;
	b=nfih29kqBhIy6PnEMCliMKzgUbUGMU03eZS9z2x6RzAbHs4eVTWrXtMSWx6XjxW67QOxEh
	zXbOOy2vhPeJUOBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Sreenath Vijayan <sreenath.vijayan@sony.com>,
	Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 01/18] printk: Add function to replay kernel log on consoles
Date: Tue,  4 Jun 2024 01:30:36 +0206
Message-Id: <20240603232453.33992-2-john.ogness@linutronix.de>
In-Reply-To: <20240603232453.33992-1-john.ogness@linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sreenath Vijayan <sreenath.vijayan@sony.com>

Add a generic function console_replay_all() for replaying
the kernel log on consoles, in any context. It would allow
viewing the logs on an unresponsive terminal via sysrq.

Reuse the existing code from console_flush_on_panic() for
resetting the sequence numbers, by introducing a new helper
function __console_rewind_all(). It is safe to be called
under console_lock().

Try to acquire lock on the console subsystem without waiting.
If successful, reset the sequence number to oldest available
record on all consoles and call console_unlock() which will
automatically flush the messages to the consoles.

Suggested-by: John Ogness <john.ogness@linutronix.de>
Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
Link: https://lore.kernel.org/r/90ee131c643a5033d117b556c0792de65129d4c3.1710220326.git.sreenath.vijayan@sony.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/printk.h |  6 +++-
 kernel/printk/printk.c | 77 +++++++++++++++++++++++++++++-------------
 2 files changed, 58 insertions(+), 25 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 69f40a71c438..784d2298f4cf 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -195,6 +195,7 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+void console_replay_all(void);
 void printk_legacy_allow_panic_sync(void);
 extern bool nbcon_device_try_acquire(struct console *con);
 extern void nbcon_device_release(struct console *con);
@@ -279,6 +280,10 @@ static inline void printk_trigger_flush(void)
 {
 }
 
+static inline void console_replay_all(void)
+{
+}
+
 static inline void printk_legacy_allow_panic_sync(void)
 {
 }
@@ -295,7 +300,6 @@ static inline void nbcon_device_release(struct console *con)
 static inline void nbcon_atomic_flush_unsafe(void)
 {
 }
-
 #endif
 
 bool this_cpu_in_panic(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b4a202591e06..b3fe1b6d7dbd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3201,6 +3201,40 @@ void console_unblank(void)
 		pr_flush(1000, true);
 }
 
+/*
+ * Rewind all consoles to the oldest available record.
+ *
+ * IMPORTANT: The function is safe only when called under
+ *            console_lock(). It is not enforced because
+ *            it is used as a best effort in panic().
+ */
+static void __console_rewind_all(void)
+{
+	struct console *c;
+	short flags;
+	int cookie;
+	u64 seq;
+
+	seq = prb_first_valid_seq(prb);
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(c) {
+		flags = console_srcu_read_flags(c);
+
+		if (flags & CON_NBCON) {
+			nbcon_seq_force(c, seq);
+		} else {
+			/*
+			 * This assignment is safe only when called under
+			 * console_lock(). On panic, legacy consoles are
+			 * only best effort.
+			 */
+			c->seq = seq;
+		}
+	}
+	console_srcu_read_unlock(cookie);
+}
+
 /**
  * console_flush_on_panic - flush console content on panic
  * @mode: flush all messages in buffer or just the pending ones
@@ -3229,30 +3263,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	 */
 	console_may_schedule = 0;
 
-	if (mode == CONSOLE_REPLAY_ALL) {
-		struct console *c;
-		short flags;
-		int cookie;
-		u64 seq;
-
-		seq = prb_first_valid_seq(prb);
-
-		cookie = console_srcu_read_lock();
-		for_each_console_srcu(c) {
-			flags = console_srcu_read_flags(c);
-
-			if (flags & CON_NBCON) {
-				nbcon_seq_force(c, seq);
-			} else {
-				/*
-				 * This is an unsynchronized assignment. On
-				 * panic legacy consoles are only best effort.
-				 */
-				c->seq = seq;
-			}
-		}
-		console_srcu_read_unlock(cookie);
-	}
+	if (mode == CONSOLE_REPLAY_ALL)
+		__console_rewind_all();
 
 	nbcon_atomic_flush_pending();
 
@@ -4447,6 +4459,23 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
+/**
+ * console_replay_all - replay kernel log on consoles
+ *
+ * Try to obtain lock on console subsystem and replay all
+ * available records in printk buffer on the consoles.
+ * Does nothing if lock is not obtained.
+ *
+ * Context: Any context.
+ */
+void console_replay_all(void)
+{
+	if (console_trylock()) {
+		__console_rewind_all();
+		/* Consoles are flushed as part of console_unlock(). */
+		console_unlock();
+	}
+}
 #endif
 
 #ifdef CONFIG_SMP
-- 
2.39.2


