Return-Path: <linux-kernel+bounces-293343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4009957E30
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 014A4B20EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646DF200110;
	Tue, 20 Aug 2024 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VMm1kcXV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n4usUpw0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296241E4F0A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135414; cv=none; b=jbseACD9wWS5/X/nuQ6IkzQgg4rrdzl5nqt898r77GoxwRv1zPExXdrK+0CcxA5zQflxYv4xq6IHNU3Muk8eChqvSrB3GFXXrd20zfCAGAH856W7vEX10ba55aVWM4Iv52iAZeao17UPUrpbN3E961y2s2T4rs8R14kign38css=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135414; c=relaxed/simple;
	bh=0RZPnyZjrKgCq/B2JvV+5IoZv3PxpnW2Gr6UTo0NJdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FAi97cQdakWAJYmrEajjCp6y2NmkgcFVKxVfAkfxlKOBMAj3jeiVSZHxg2JDe7lMOZPts/z1eQWc5VeJe3Wvrx61AYczOzq46x32xKCKKM4hKEISJaroNO66KrdTJoEfRu2BZAapW0crJLPGjWw0+vKUUCC2ayzller1HkUZPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VMm1kcXV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n4usUpw0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bi+X7W1qgZUGgO1yAXM0EY0EZqFKCtqGRYBIyReHFLE=;
	b=VMm1kcXVpQYBB7etPM0G/ABIRdHzMBg9qkWGTdLlotfNB7AZPAR4oGpFn3SCz3a/sxBiX8
	kexNJwkJLx2X5ei89XUtIMl56fHzxvHzZEPec6qtDa5nOiDnXV3UD8Re7GelzOcwjeie5b
	tc66Y+EN/++mpGWmYSbsCKFJN3MkhC5hT5ywF+PWSPAmBV0WakqvUOGpwzkpWolAJKhD/6
	tylqV2WrSjJRC9+lYLFa8Uf6wJRuMg1Yx6jEzTGgzbRwRNAV6+gzKMsG2ZxP0pA3F5YSDd
	0kTRaH0kcFFPZ6I84XhAaJ92mD7Go+zh7CwqnlHdQGCoT2aA1CL9vf24ov91/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bi+X7W1qgZUGgO1yAXM0EY0EZqFKCtqGRYBIyReHFLE=;
	b=n4usUpw0f+Dl9OsyUJus9ZFFlV+1vfS3MEHh6VsRfaDW1ddMDWFzW5gn1uOI+Z5gOMC4M4
	TejQBWo1FXAPOVCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v8 21/35] printk: Track registered boot consoles
Date: Tue, 20 Aug 2024 08:35:47 +0206
Message-Id: <20240820063001.36405-22-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
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
index ffb56c2150b0..b8634a153d1d 100644
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


