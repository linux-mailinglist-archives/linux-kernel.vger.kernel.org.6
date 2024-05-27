Return-Path: <linux-kernel+bounces-190093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C558CF95E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79414282650
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFA813B7A4;
	Mon, 27 May 2024 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KZNl70bT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JNIciXcu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D18D4D59F
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791907; cv=none; b=pLOJTiBpSCZqnuWtIVlCQtbondFeszO3ejVOD6VkIaHRDqCiBUgSxLw1/Bug8XOGJCssi5KciM5+A9Gl3TXE11Ux6LgPj/IohVTazuzlRAJRUwf+ItgswGQb6Mx+d5Fz+q2YfOPYFEZ9QfongnoEGSa16Am812D7kGAatm9YDuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791907; c=relaxed/simple;
	bh=DV9ePIcY234r7QPwO7jt9B0pkqMHFxrafa8XBXbKkPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=naYBRB8ro1MXhQThpkIN66NmpKUxh8BB7HGc7YO6klW5qnzid0kwegTQaU6MgNkS5V0TaP08Lqd7IU702GBrqj2d3U3BDnWiPx22IUCm4djfvfW3pncIZ5eA/nXGVC8Qg4Ga5o/RQ00SJEuFhQKTF4nfKT0Weron2GoQGLkefuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KZNl70bT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JNIciXcu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0n6uVNwgqq5puIfDGgLjiBT2iercsin9z76FjHNuAQY=;
	b=KZNl70bTXp3m5cAe4kEfJH3PCw5hX0Q2wMhL7Zf0gm0JtHOdurXk8hEaou0OLQJpFNpV9O
	sLfmU5igFuVN2udrqNtgbvXyiSAu0gmKheimHZqfuoXbHy9dzQZRJoYRO8r0CcDLts4twE
	jefpNob5YvXlBW2aMVQRc4qeMvVI0LJmT2HRQJND+RYnLKd7zKZekcPgKwGcMOxEe1tdmU
	jUf6qs4B0jIV/SEdvyLskU1+Y9C42bSE9iqC1i74q97MKFIL4udoMjbJsAL4L86019Emeg
	+3pXeqIPGayKMcaufJjvND+sY+hY3qbLct+QL0KQjYkC7P4bYkGNk55lULNY1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0n6uVNwgqq5puIfDGgLjiBT2iercsin9z76FjHNuAQY=;
	b=JNIciXcukcyoUBLMA80RT7SOX69DQH+bX7og5NEQJRhSR3LcOgqb2w+6N7ijbLOcwJ7O0j
	veNZzIXA3a70DIDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 20/30] printk: Track registered boot consoles
Date: Mon, 27 May 2024 08:43:39 +0206
Message-Id: <20240527063749.391035-21-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
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
index 56d2377fc97f..d81d541558fd 100644
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
@@ -3512,6 +3520,9 @@ void register_console(struct console *newcon)
 		newcon->seq = init_seq;
 	}
 
+	if (newcon->flags & CON_BOOT)
+		have_boot_console = true;
+
 	/*
 	 * If another context is actively using the hardware of this new
 	 * console, it will not be aware of the nbcon synchronization. This
@@ -3582,7 +3593,9 @@ EXPORT_SYMBOL(register_console);
 static int unregister_console_locked(struct console *console)
 {
 	bool use_device_lock = (console->flags & CON_NBCON) && console->write_atomic;
+	bool found_boot_con = false;
 	unsigned long flags;
+	struct console *c;
 	int res;
 
 	lockdep_assert_console_list_lock_held();
@@ -3640,6 +3653,17 @@ static int unregister_console_locked(struct console *console)
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


