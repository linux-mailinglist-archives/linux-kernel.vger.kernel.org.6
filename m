Return-Path: <linux-kernel+bounces-273641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A607946BAA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB26282433
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F4455885;
	Sun,  4 Aug 2024 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tcYQapjb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pu0zK38+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F61CA96
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732716; cv=none; b=TuhPkU5H2fUXrTBOp8m7M5a7MbinPCYDusb6wn8ih9fAg4MLyYN7JYwBr+QeDp5Tv0EIAL+GX+rAE6rNlEOJxnGrnLTCEw3/MA5OIEwhJWOqpjjzVfOcrGMkuYpIQNBvlh77ZrIqp6U0SQv5EDNfEMu9YKojOyJOAF9C/jFCCdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732716; c=relaxed/simple;
	bh=2yEvvgpxPi0fwOxyRUTE8YI5U24mFJe3k3lvFNTEOko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKonIe2rkvTDuTHmJhraCT4VEly0HJDCG+XgPWnZhlcZVLO+B0xOkBs9QGqK6hZO67AoDdPnf80WfHSpi9YN/Oqc5U/X4JiCc+bu8/cFWVXek5tgvCGxyR/mIRVlaQcC9q896tPd1cCtN96ecxx91to9hI7Bxe1o0PFHLMYQliA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tcYQapjb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pu0zK38+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0TVA7p3xKgsnI7/AR/VPpgrXQpo502eMwZ3DcBfU8s=;
	b=tcYQapjblWWPpK2I3B5GxWbVqr9xfAg9xa9wRNpzoodFolwzkQn50HY3W37ov16biu7i4G
	AETe9dzXkMoESbDGXOD495tquBFgVsovSFPIP1opURRQ6lmCkp/rQcRqk+ssxV1IbvCbtG
	afdRnhHP0V8tr3ljiE8VRX5aPinXZTbcFjLPNSXh8Ei7fuUL16pQfaSzXsU8czEoKZD5so
	9ErmY7EnPCX3qfWNEjk++aLaGEbImWGfirrZ0EekfHE/7RwxIitNqyQ6f5Fdhgtfgx1NYH
	k+O1/CJr/ntu49zoMwXzRV8KyPmNt24tL0q0Vefb215KrK1Wh/DlTlvPiZlZ/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0TVA7p3xKgsnI7/AR/VPpgrXQpo502eMwZ3DcBfU8s=;
	b=pu0zK38+Wmn+pB9Q4HHZuqE003yrjBv31deZk9vcfnIDlfId9Pnu+rNFkiBOqyOBbKoQV6
	1AcXn4ryH5igbBAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v7 21/35] printk: Track registered boot consoles
Date: Sun,  4 Aug 2024 02:57:24 +0206
Message-Id: <20240804005138.3722656-22-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unfortunately it is not known if a boot console and a regular
(legacy or nbcon) console use the same hardware. For this reason
they must not be allowed to print simultaneously.

For legacy consoles this is not an issue because they are
already synchronized with the boot consoles using the console
lock. However nbcon consoles can be triggered separately.

Add a global flag @have_boot_console to identify if any boot
consoles are registered. This will be used in follow-up commits
to ensure that boot consoles and nbcon consoles cannot print
simultaneously.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 92703249221e..be4b9c491d8d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -463,6 +463,14 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 /* syslog_lock protects syslog_* variables and write access to clear_seq. */
 static DEFINE_MUTEX(syslog_lock);
 
+/*
+ * Specifies if a boot console is registered. If boot consoles are present,
+ * nbcon consoles cannot print simultaneously and must be synchronized by
+ * the console lock. This is because boot consoles and nbcon consoles may
+ * have mapped the same hardware.
+ */
+static bool have_boot_console;
+
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
@@ -3610,6 +3618,9 @@ void register_console(struct console *newcon)
 		newcon->seq = init_seq;
 	}
 
+	if (newcon->flags & CON_BOOT)
+		have_boot_console = true;
+
 	/*
 	 * If another context is actively using the hardware of this new
 	 * console, it will not be aware of the nbcon synchronization. This
@@ -3680,7 +3691,9 @@ EXPORT_SYMBOL(register_console);
 static int unregister_console_locked(struct console *console)
 {
 	bool use_device_lock = (console->flags & CON_NBCON) && console->write_atomic;
+	bool found_boot_con = false;
 	unsigned long flags;
+	struct console *c;
 	int res;
 
 	lockdep_assert_console_list_lock_held();
@@ -3738,6 +3751,17 @@ static int unregister_console_locked(struct console *console)
 	if (console->exit)
 		res = console->exit(console);
 
+	/*
+	 * With this console gone, the global flags tracking registered
+	 * console types may have changed. Update them.
+	 */
+	for_each_console(c) {
+		if (c->flags & CON_BOOT)
+			found_boot_con = true;
+	}
+	if (!found_boot_con)
+		have_boot_console = found_boot_con;
+
 	return res;
 }
 
-- 
2.39.2


