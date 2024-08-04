Return-Path: <linux-kernel+bounces-273649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A92B946BB3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC23DB22229
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A6013A240;
	Sun,  4 Aug 2024 00:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E6Rakp/j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rdOjJbWQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F81C2033A
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732718; cv=none; b=CBy+KcQF4NNkjCv/DjMm6xWZlTcb0XzBSEV8RoyL3glcCXlVogtZMFDBWHXxRxKuCR4secYpMiDaNQdna25pDg4J6hmwIKPZuguo1xyaIOqZOJLEi80tmTecvY9hfWD6GpcMADArYPJJ/kG3i+6i34kVbhrqtG2Zs1Eft/WJ1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732718; c=relaxed/simple;
	bh=DXTUyKqM2Z24jCLnk0r9d/ubSBFi8VCoDdlVY6xX0nY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HhjyYTDdAXbq7VfAgfkRPx6UG6/H4OuoWwalApiCsa+0VwKA2GFuDZkNJQXTgJ72o4qgGPgF7AUzGKmRyRHWUtHQxUAF5nGKgLJpkqMQ4Ezkrxjpim4K0qJhpCqQkoxcqbSmA63/lno7pG5UC9Lx91zclcpqP3oOkk3rCkUmFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E6Rakp/j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rdOjJbWQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dV9290EWLNTQgmOyk6oxj7wIlktHocd6AbHZCImcmIo=;
	b=E6Rakp/jXErurOvwI7AUJOtANSPoIIF/Jw1dRFL8pmGuwSfo9+a2mWsiajujfnB6m77Jth
	y6bcDKQExnp8N0XgBRQKeyVYE7kRiANlddnzpaWq/W5cNK09yo9Dt1oc0AURKhW5Be3W0X
	zF4Sm8u91eXXXul8f8pqqM/5mNc5nXxin4P3xWhzoEIjF5yFhcivH6F46KTn7XkxZ87JpZ
	CybXPxEnLmu/IgMc1N6Eanm3FSksPPlRswLOqnJu/9HMTcB9oHIDs8Jc8SBL4pUCUspqyA
	KDOKW6K9ija6IgBhjzMgoiUAeNTOPv9pt/mICXFSQAXgwAmitBYxPeQ27d0Sxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dV9290EWLNTQgmOyk6oxj7wIlktHocd6AbHZCImcmIo=;
	b=rdOjJbWQfKoSOxS3ILWKFaT3D/wPSXCnn+o0LgMHBMcqS9Hs4UyhwqGy/IyW+S4hoZh2JV
	QXzRxClD+bHnVDDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Joel Granados <j.granados@samsung.com>
Subject: [PATCH printk v7 29/35] printk: Coordinate direct printing in panic
Date: Sun,  4 Aug 2024 02:57:32 +0206
Message-Id: <20240804005138.3722656-30-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
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
to flush, there is no change in behavior (i.e. legacy
consoles will always attempt to print from the printk()
caller context).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk.h   |  5 ++++
 kernel/panic.c           |  2 ++
 kernel/printk/internal.h |  2 ++
 kernel/printk/printk.c   | 54 ++++++++++++++++++++++++++++++++++------
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
index a58631f42e79..84488daa14ce 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -368,6 +368,8 @@ void panic(const char *fmt, ...)
 
 	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
 
+	printk_legacy_allow_panic_sync();
+
 	/*
 	 * Run any panic handlers, including those that might need to
 	 * add information to the kmsg dump output.
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 7679e18f24b3..dbda90f0dc08 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -130,6 +130,8 @@ static inline bool console_is_usable(struct console *con, short flags)
 #define PRINTK_MESSAGE_MAX	0
 #define PRINTKRB_RECORD_MAX	0
 
+#define legacy_allow_panic_sync	false
+
 /*
  * In !PRINTK builds we still export console_sem
  * semaphore and some of console functions (console_unlock()/etc.), so
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2277871e1f12..480c0993abd5 100644
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
 
@@ -2330,12 +2332,30 @@ int vprintk_store(int facility, int level,
 	return ret;
 }
 
+static bool legacy_allow_panic_sync;
+
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
+	bool defer_legacy = !do_trylock_unlock;
 	int printed_len;
-	bool in_sched = false;
 
 	/* Suppress unimportant messages after panic happens */
 	if (unlikely(suppress_printk))
@@ -2349,17 +2369,35 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (other_cpu_in_panic())
 		return 0;
 
+	/* If called from the scheduler, we can not call up(). */
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
-		in_sched = true;
+		do_trylock_unlock = false;
+		defer_legacy = true;
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
@@ -2379,7 +2417,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
-	if (in_sched && printing_via_unlock)
+	if (defer_legacy)
 		defer_console_output();
 	else
 		wake_up_klogd();
@@ -3292,7 +3330,9 @@ void console_flush_on_panic(enum con_flush_mode mode)
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


