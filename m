Return-Path: <linux-kernel+bounces-273642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5569946BAE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F29F1F23AA1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526556BFA5;
	Sun,  4 Aug 2024 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S8lfFgI+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w1NxKPFO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C331CD06
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732716; cv=none; b=AGHfS8Cz89NbFSLeFRFugv9gzx4T9tW98yBQ1RhM/7gge9Imad9CXadNOzMrZ2IvbWllIGmz/a9xowejWSOCcj6T6Wa8J9EZ5rdjyHiDC8SVdREnJybdhmS+ebnwM38W6chehR42kRS7+svR6lUsER8Iii+eHRPaMkQ3JmNuqn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732716; c=relaxed/simple;
	bh=0jLUqIk/Bq5xbkFT5qKsbfWH4j7MIps3/9Afb6fdWJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfQ6f9Xw0pVK5wvlCDNul+Sf1bNsZbRMiW5MoeAqLK/emLOpqjbiWPq7lduJVS0oskjvQGbTGLIe4Al0WjZq0uRCrdMUZKOF+VbtbyKqCjZ33yS5XIaVKSvZsOLZB+murLw3pa6kPib+mUYtLT+WKnlbV6bEyNcDUB0ZaGPE4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S8lfFgI+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w1NxKPFO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITff3wOV77lXfeACa1fOZ40dYM9C+j+YBR4nrQ8pEvg=;
	b=S8lfFgI+7fm5OOjj04s745O2EA85crCjDGX+NoxzA7kFlRJ9QJqxFMK+nv0F0zM7MxNvX+
	R35f5URSodZVZDLSDKWEdhd2PEGb5Q9lIxv/t6OkLXjl6dDH09qw1u7Jc8bZGebUnyykKc
	N35E7vuteJAzr+KbpzJyM+bvW5PNmeQz12SPekdAHwbBpOCKcN9dLqyGQ/eLasfAWV81eh
	khc7ofXlsOHfxklaWtaZtxau92IMWCq8GCP3pac+a4AoiJwBLpH089cKFmZKMNMTCJIh/m
	3RyQydC+UjFI/kvnUiHMMTNNFxeAB281V736Lv2tI7I1q/ZebYdVGnMplxNikg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITff3wOV77lXfeACa1fOZ40dYM9C+j+YBR4nrQ8pEvg=;
	b=w1NxKPFOVhUev4Zt5HFXP/LJIiotO2BCUGN8ZdD15raw2hMmKat1qtQFcfNrqPaI3M4afE
	I3fCiU57YY34AeAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v7 24/35] printk: nbcon: Flush new records on device_release()
Date: Sun,  4 Aug 2024 02:57:27 +0206
Message-Id: <20240804005138.3722656-25-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There may be new records that were added while a driver was
holding the nbcon context for non-printing purposes. These
new records must be flushed by the nbcon_device_release()
context because no other context will do it.

If boot consoles are registered, the legacy loop is used
(either direct or per irq_work) to handle the flushing.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/nbcon.c    | 20 ++++++++++++++++++++
 kernel/printk/printk.c   |  2 +-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 84706c1c934b..7679e18f24b3 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -153,6 +153,8 @@ static inline bool console_is_usable(struct console *con, short flags) { return
 
 #endif /* CONFIG_PRINTK */
 
+extern bool have_boot_console;
+
 extern struct printk_buffers printk_shared_pbufs;
 
 /**
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index d09c084c9af4..269aeed18064 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1326,10 +1326,30 @@ EXPORT_SYMBOL_GPL(nbcon_device_try_acquire);
 void nbcon_device_release(struct console *con)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_device_ctxt);
+	int cookie;
 
 	if (!nbcon_context_exit_unsafe(ctxt))
 		return;
 
 	nbcon_context_release(ctxt);
+
+	/*
+	 * This context must flush any new records added while the console
+	 * was locked. The console_srcu_read_lock must be taken to ensure
+	 * the console is usable throughout flushing.
+	 */
+	cookie = console_srcu_read_lock();
+	if (console_is_usable(con, console_srcu_read_flags(con)) &&
+	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
+		if (!have_boot_console) {
+			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb));
+		} else if (!is_printk_legacy_deferred()) {
+			if (console_trylock())
+				console_unlock();
+		} else {
+			printk_trigger_flush();
+		}
+	}
+	console_srcu_read_unlock(cookie);
 }
 EXPORT_SYMBOL_GPL(nbcon_device_release);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5f5fc5df2f09..d54eae0d06e9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -469,7 +469,7 @@ static DEFINE_MUTEX(syslog_lock);
  * the console lock. This is because boot consoles and nbcon consoles may
  * have mapped the same hardware.
  */
-static bool have_boot_console;
+bool have_boot_console;
 
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
-- 
2.39.2


