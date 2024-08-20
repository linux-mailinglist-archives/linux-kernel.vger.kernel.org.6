Return-Path: <linux-kernel+bounces-293355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F3E957E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCE71C23E51
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F39121C170;
	Tue, 20 Aug 2024 06:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="snba0Nqs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fh7uuq4/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF52C201277
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135419; cv=none; b=Yoc/Ye3B3n6IqQNZMO/mXVILnDUsCqzwBQu4WOJWwGtsA+HdhUMhQf5o3LRElQGp4IKy7ifvq38E20nYJk+Pf/rq84HA4MYjKgZmHrG93/sJDdLXBg+nTCaGomp3DtfjxIibwMJp7EOeTuMG74c2lAGlPPnbBg676iWwxflBeiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135419; c=relaxed/simple;
	bh=pwTIo+fYghnjAq1fBdjhRfHLqBM+KSgt9OuNkliVRNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iEPi+rI9G4IUeq9u+rdjmNbnrMgujZoVeCZyYKZs7NvnDxFgqSmaNOANP3WEc4GonvtXTclRQj764mWpdyrsoygIyhzunOMYBkHoOu5QVmak9jJr2KSe8qRQwHXkY9lVi7fv1wAe4yEH7ptAHIoG+BbrZ8KxrBQ6UHQmE56EPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=snba0Nqs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fh7uuq4/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ss4nYdGIizePGNcX+CjQ5hd4s2JUY1XMtNgYvddWyM=;
	b=snba0Nqs3QpSQyuRFQo5KwOAYw3ZD2zOXzEXk5yJLQ0ThEj2z3GB5VswyU+291g9h7oXJQ
	//vTuo8b1r3Iyz+F04Wii1OK0I4tfGVMiWRkzJT8QpspqO4OEwDzAJ1sCjv0LmzbWOILPs
	gwmtCoHf7QmoeBFA4QKiIzi3Femvd8NwOy1FUpF4LJW8J43YO5I1+DEDLp9JqM271Fvtry
	hA5zURPiYsarbP8ylW7Oi/dVUbu+zpzTt9s4h9J83bJC4Kamhua+lqDt5/mJlgpI+by/+P
	PwxKU3ddVPFcGwIaSRuVSteEdJeziol+Athw+Kij61T5Me5I6VWUyNSUTP/XsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ss4nYdGIizePGNcX+CjQ5hd4s2JUY1XMtNgYvddWyM=;
	b=fh7uuq4/Ic9loQIbJ0NHcdQinl6gQHy5YOF439glnSiaEDARcTWsuam3GxN4KMRyAIrrfi
	KIhVhJtC6LSJlIAQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ryo Takakura <takakura@valinux.co.jp>,
	Joel Granados <j.granados@samsung.com>,
	Lukas Wunner <lukas@wunner.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH printk v8 29/35] printk: Coordinate direct printing in panic
Date: Tue, 20 Aug 2024 08:35:55 +0206
Message-Id: <20240820063001.36405-30-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If legacy and nbcon consoles are registered and the nbcon
consoles are allowed to flush (i.e. no boot consoles
registered), the legacy consoles will no longer perform
direct printing on the panic CPU until after the backtrace
has been stored. This will give the safe nbcon consoles a
chance to print the panic messages before allowing the
unsafe legacy consoles to print.

If no nbcon consoles are registered or they are not allowed
to flush because boot consoles are registered, there is no
change in behavior (i.e. legacy consoles will always attempt
to print from the printk() caller context).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk.h   |  5 ++++
 kernel/panic.c           |  2 ++
 kernel/printk/internal.h |  1 +
 kernel/printk/printk.c   | 55 +++++++++++++++++++++++++++++++++++-----
 4 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 2e083f01f8a3..eca9bb2ee637 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -200,6 +200,7 @@ extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
 void console_try_replay_all(void);
+void printk_legacy_allow_panic_sync(void);
 extern bool nbcon_device_try_acquire(struct console *con);
 extern void nbcon_device_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
@@ -286,6 +287,10 @@ static inline void console_try_replay_all(void)
 {
 }
 
+static inline void printk_legacy_allow_panic_sync(void)
+{
+}
+
 static inline bool nbcon_device_try_acquire(struct console *con)
 {
 	return false;
diff --git a/kernel/panic.c b/kernel/panic.c
index df37c913b010..93096d5abcc7 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -374,6 +374,8 @@ void panic(const char *fmt, ...)
 
 	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
 
+	printk_legacy_allow_panic_sync();
+
 	/*
 	 * Run any panic handlers, including those that might need to
 	 * add information to the kmsg dump output.
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 7679e18f24b3..6b61350a3026 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -154,6 +154,7 @@ static inline bool console_is_usable(struct console *con, short flags) { return
 #endif /* CONFIG_PRINTK */
 
 extern bool have_boot_console;
+extern bool legacy_allow_panic_sync;
 
 extern struct printk_buffers printk_shared_pbufs;
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e30107d216a5..fc3f8970eea2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -471,7 +471,9 @@ static DEFINE_MUTEX(syslog_lock);
 static bool have_legacy_console;
 
 /*
- * Specifies if an nbcon console is registered.
+ * Specifies if an nbcon console is registered. If nbcon consoles are present,
+ * synchronous printing of legacy consoles will not occur during panic until
+ * the backtrace has been stored to the ringbuffer.
  */
 static bool have_nbcon_console;
 
@@ -483,6 +485,9 @@ static bool have_nbcon_console;
  */
 bool have_boot_console;
 
+/* See printk_legacy_allow_panic_sync() for details. */
+bool legacy_allow_panic_sync;
+
 /*
  * Specifies if the console lock/unlock dance is needed for console
  * printing. If @have_boot_console is true, the nbcon consoles will
@@ -2330,12 +2335,28 @@ int vprintk_store(int facility, int level,
 	return ret;
 }
 
+/*
+ * This acts as a one-way switch to allow legacy consoles to print from
+ * the printk() caller context on a panic CPU. It also attempts to flush
+ * the legacy consoles in this context.
+ */
+void printk_legacy_allow_panic_sync(void)
+{
+	legacy_allow_panic_sync = true;
+
+	if (printing_via_unlock && !is_printk_legacy_deferred()) {
+		if (console_trylock())
+			console_unlock();
+	}
+}
+
 asmlinkage int vprintk_emit(int facility, int level,
 			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
 {
+	bool do_trylock_unlock = printing_via_unlock;
+	bool defer_legacy = false;
 	int printed_len;
-	bool in_sched = false;
 
 	/* Suppress unimportant messages after panic happens */
 	if (unlikely(suppress_printk))
@@ -2349,17 +2370,35 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
 		return 0;
 
+	/* If called from the scheduler, we can not call up(). */
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
-		in_sched = true;
+		defer_legacy = do_trylock_unlock;
+		do_trylock_unlock = false;
 	}
 
 	printk_delay(level);
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
-	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched && printing_via_unlock) {
+	if (have_nbcon_console && !have_boot_console) {
+		nbcon_atomic_flush_pending();
+
+		/*
+		 * In panic, the legacy consoles are not allowed to print from
+		 * the printk calling context unless explicitly allowed. This
+		 * gives the safe nbcon consoles a chance to print out all the
+		 * panic messages first. This restriction only applies if
+		 * there are nbcon consoles registered and they are allowed to
+		 * flush.
+		 */
+		if (this_cpu_in_panic() && !legacy_allow_panic_sync) {
+			do_trylock_unlock = false;
+			defer_legacy = false;
+		}
+	}
+
+	if (do_trylock_unlock) {
 		/*
 		 * The caller may be holding system-critical or
 		 * timing-sensitive locks. Disable preemption during
@@ -2379,7 +2418,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
-	if (in_sched && printing_via_unlock)
+	if (defer_legacy)
 		defer_console_output();
 	else
 		wake_up_klogd();
@@ -3292,7 +3331,9 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	if (!have_boot_console)
 		nbcon_atomic_flush_pending();
 
-	console_flush_all(false, &next_seq, &handover);
+	/* Flush legacy consoles once allowed, even when dangerous. */
+	if (legacy_allow_panic_sync)
+		console_flush_all(false, &next_seq, &handover);
 }
 
 /*
-- 
2.39.2


