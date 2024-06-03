Return-Path: <linux-kernel+bounces-199828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814D48FA672
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87191C20B4A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E33A83CDC;
	Mon,  3 Jun 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cf/WNiPf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aRZRf3JJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7713D514
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457101; cv=none; b=s3o6helxLTpnovVu2k17iEX2dq97N/gqpfkB198N9ZBlFSb6TiGfRFYDlaDGfdFNbtusbnHQFnoUGxx67rzHXMqKyN3JxcmJkf9aCg7AwNvVV0zbQr00il+bQi1ABMjZNRvzJ48eexe5hUqI8FNBdLOxSUiMuZOhGArkUAqYXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457101; c=relaxed/simple;
	bh=0C4dgeMH1ETa6qI9bAimpP79piYd69dT3io4/eKnesI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oCKvKPWKZev2PFePevg7chkmx1fTHsSjbHyQc/DhJAlptifjlhzmC4r2gzelLweM37b3D5CpXsZb3tPUqWwYO2E7OfCuKAyR4SM792983wnbuogJzTI/EFNLIp/QLpKrIbTFbjk67qjs/HU6R6c4lJVLijsC1AzNYSuUlKAqZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cf/WNiPf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aRZRf3JJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ji2vckRR4GEO79DzWO5vikRvAUqQwqYX0LChtt8+KCk=;
	b=Cf/WNiPfWk/c2NUVJioPZfMvn734wrwsRmyytNh284GH/uMvneFJoeLKu0CPIkNO962IpN
	GqiskNPnw6NpIj2LlBSJY3uCTTNxjL56me7to9K05+V7FWAwVL8kdGpjAmMRNzCnXzg9aE
	KCGRs/KNEIin0B8USkbG59aA1pM3ggt6vjwNDIdGgcS6wUKseA0xa1tIOcIPnq0K3TC5T4
	dwtSVdZzYiqqY5pBeSvBsHrps4Qitw+DCr7LtT3plNLmGecRRz2KtODr946ULNoXey08L3
	lq78UeuTs4tFOVvqib8vOAKBwDEdG2f6bqH7DPv5SbN5C49xexbZejL8pP/HQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ji2vckRR4GEO79DzWO5vikRvAUqQwqYX0LChtt8+KCk=;
	b=aRZRf3JJDumguiJ5WAHM/E8orw//pK6WDfVRhubwshWKW5ZJtcOL9qdSHgeFrUb/XFIsS6
	OhzmNEXN0tZnGDCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 09/18] printk: nbcon: Start printing threads
Date: Tue,  4 Jun 2024 01:30:44 +0206
Message-Id: <20240603232453.33992-10-john.ogness@linutronix.de>
In-Reply-To: <20240603232453.33992-1-john.ogness@linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there are no boot consoles, the printing threads are started
in early_initcall.

If there are boot consoles, the printing threads are started
after the last boot console has unregistered. The printing
threads do not need to be concerned about boot consoles because
boot consoles cannot register once a non-boot console has
registered.

Until a printing thread of a console has started, that console
will print using atomic_write() in the printk() caller context.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/nbcon.c    | 18 +++++++++++++++++-
 kernel/printk/printk.c   | 14 ++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index b2b5c10a4321..5d4722310850 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -48,6 +48,7 @@ struct printk_ringbuffer;
 struct dev_printk_info;
 
 extern struct printk_ringbuffer *prb;
+extern bool printk_threads_enabled;
 
 __printf(4, 0)
 int vprintk_store(int facility, int level,
@@ -161,6 +162,7 @@ static inline void nbcon_kthread_wake(struct console *con)
 
 static inline void nbcon_kthread_wake(struct console *con) { }
 static inline void nbcon_kthread_create(struct console *con) { }
+#define printk_threads_enabled (false)
 
 /*
  * In !PRINTK builds we still export console_sem
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index f60d47b5db8a..480a0ced2708 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -213,6 +213,8 @@ static void nbcon_seq_try_update(struct nbcon_context *ctxt, u64 new_seq)
 	}
 }
 
+bool printk_threads_enabled __ro_after_init;
+
 /**
  * nbcon_context_try_acquire_direct - Try to acquire directly
  * @ctxt:	The context of the caller
@@ -1542,7 +1544,7 @@ void nbcon_kthread_create(struct console *con)
 	if (!(con->flags & CON_NBCON) || !con->write_thread)
 		return;
 
-	if (con->kthread)
+	if (!printk_threads_enabled || con->kthread)
 		return;
 
 	/*
@@ -1568,6 +1570,19 @@ void nbcon_kthread_create(struct console *con)
 	sched_set_normal(con->kthread, -20);
 }
 
+static int __init printk_setup_threads(void)
+{
+	struct console *con;
+
+	console_list_lock();
+	printk_threads_enabled = true;
+	for_each_console(con)
+		nbcon_kthread_create(con);
+	console_list_unlock();
+	return 0;
+}
+early_initcall(printk_setup_threads);
+
 /**
  * nbcon_alloc - Allocate buffers needed by the nbcon console
  * @con:	Console to allocate buffers for
@@ -1617,6 +1632,7 @@ void nbcon_init(struct console *con, u64 init_seq)
 	init_irq_work(&con->irq_work, nbcon_irq_work);
 	nbcon_seq_force(con, init_seq);
 	nbcon_state_set(con, &state);
+	nbcon_kthread_create(con);
 }
 
 /**
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 457c01311a95..4613f9145a8e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2389,6 +2389,9 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 *
 		 * - When this CPU is in panic.
 		 *
+		 * - When booting, before the printing threads have been
+		 *   started.
+		 *
 		 * - During shutdown, since the printing threads may not get
 		 *   a chance to print the final messages.
 		 *
@@ -2397,6 +2400,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 * consoles cannot print simultaneously with boot consoles.
 		 */
 		if (is_panic_context ||
+		    !printk_threads_enabled ||
 		    (system_state > SYSTEM_RUNNING)) {
 			nbcon_atomic_flush_pending();
 		}
@@ -3742,6 +3746,7 @@ EXPORT_SYMBOL(register_console);
 static int unregister_console_locked(struct console *console)
 {
 	bool use_device_lock = (console->flags & CON_NBCON) && console->write_atomic;
+	bool is_boot_con = (console->flags & CON_BOOT);
 	bool found_legacy_con = false;
 	bool found_nbcon_con = false;
 	bool found_boot_con = false;
@@ -3824,6 +3829,15 @@ static int unregister_console_locked(struct console *console)
 	if (!found_nbcon_con)
 		have_nbcon_console = found_nbcon_con;
 
+	/*
+	 * When the last boot console unregisters, start up the
+	 * printing threads.
+	 */
+	if (is_boot_con && !have_boot_console) {
+		for_each_console(c)
+			nbcon_kthread_create(c);
+	}
+
 	return res;
 }
 
-- 
2.39.2


