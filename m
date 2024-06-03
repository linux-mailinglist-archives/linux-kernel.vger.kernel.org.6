Return-Path: <linux-kernel+bounces-199822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C5F8FA66B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B451F21CF2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E836513D517;
	Mon,  3 Jun 2024 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u3XmvNih";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="idnfsnZA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEB483CDC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 23:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457099; cv=none; b=E/rMNqjraj5SBJDnuO6DlDqzWUbkRktEwftGQIcKv91pqV+tmsKjBCCcQpeqHzOi82xE9+4/hm9WmDfM0wpeZcWrSwu7ZoW+SweVu2kT4bJUDUgNgkUpLCQ8jHs55NEkArVWLk4ua0+3mPp1WCZPpHQZr6T+NtTofXCgBosF5Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457099; c=relaxed/simple;
	bh=H5QlAlECNprYLrNRQeJIyWXcYhJVcMnspTIa3/fXvfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=okvEblFU87IERi9ztQDw1JCugn1KpdfSr/ZoMrpDpnXF3YdbtgOyLRn8h5x879G8Olm43aqr720e517uizBbeUxrmJCnEJWCxQ3HMCYk/GWz2ePrrV/rpiGLmCG33eZ6v1EgR4YM7s8TJhUZg0SOP4h2DmPziGQRv1W3QtHV7Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u3XmvNih; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=idnfsnZA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BpQSbTrOL8EbyodmIDDlAP8Rc/tLKsI5HokOE/M69OM=;
	b=u3XmvNihKfrTxt4EoQtYUJsuYjXE9hrnlrkGwC8oi5dPhZEZoo+BD0bMYRbKkQ2wfbGrw8
	CbHEqbVfKDlwlIU912YM5Ebt9TsT88kdQh3nwdP/8fXh/b4AyGzCdpUQ8bPRqJ1A0Np95b
	2zGBW0muzJxj1OdGhTHliF8MKC2zKrIz/x5FEp/opogVJq1u9w1jool9UfbtvQmmmDNzFW
	pxsm5gM9sNtd2IGb+pcGF48Buy4Pl16e/KBWhuCPJJg6Fnf3WTsL0yTSgL/ifgE8izYnxp
	6R7p7kF1EouwY8SLN+oszSahfCV4Y9UnyF3iBhxNjA2WlaybaDcWQKYfrVb8Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BpQSbTrOL8EbyodmIDDlAP8Rc/tLKsI5HokOE/M69OM=;
	b=idnfsnZAzIcpW0ceZivFHDsf4DDEHPTdcve0XifhuamXG2AIo9ODP2Idg46NYZIP3ki8TH
	05qXqfi/T9mHp0Cg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Sreenath Vijayan <sreenath.vijayan@sony.com>,
	Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
Subject: [PATCH printk v2 03/18] printk: Rename console_replay_all() and update context
Date: Tue,  4 Jun 2024 01:30:38 +0206
Message-Id: <20240603232453.33992-4-john.ogness@linutronix.de>
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

Rename console_replay_all() to console_try_replay_all() to make
clear that the implementation is best effort. Also, the function
should not be called in NMI context as it takes locks, so update
the comment in code.

Fixes: 693f75b91a91 ("printk: Add function to replay kernel log on consoles")
Fixes: 1b743485e27f ("tty/sysrq: Replay kernel log messages on consoles via sysrq")
Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
Link: https://lore.kernel.org/r/Zlguq/wU21Z8MqI4@sreenath.vijayan@sony.com
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/sysrq.c    | 2 +-
 include/linux/printk.h | 4 ++--
 kernel/printk/printk.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index e5974b8239c9..53f8c2329c30 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -452,7 +452,7 @@ static const struct sysrq_key_op sysrq_unrt_op = {
 
 static void sysrq_handle_replay_logs(u8 key)
 {
-	console_replay_all();
+	console_try_replay_all();
 }
 static struct sysrq_key_op sysrq_replay_logs_op = {
 	.handler        = sysrq_handle_replay_logs,
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 784d2298f4cf..20e1942f63ae 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -195,7 +195,7 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
-void console_replay_all(void);
+void console_try_replay_all(void);
 void printk_legacy_allow_panic_sync(void);
 extern bool nbcon_device_try_acquire(struct console *con);
 extern void nbcon_device_release(struct console *con);
@@ -280,7 +280,7 @@ static inline void printk_trigger_flush(void)
 {
 }
 
-static inline void console_replay_all(void)
+static inline void console_try_replay_all(void)
 {
 }
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b3fe1b6d7dbd..5dcc05e1aa56 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -4460,15 +4460,15 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
 /**
- * console_replay_all - replay kernel log on consoles
+ * console_try_replay_all - try to replay kernel log on consoles
  *
  * Try to obtain lock on console subsystem and replay all
  * available records in printk buffer on the consoles.
  * Does nothing if lock is not obtained.
  *
- * Context: Any context.
+ * Context: Any, except for NMI.
  */
-void console_replay_all(void)
+void console_try_replay_all(void)
 {
 	if (console_trylock()) {
 		__console_rewind_all();
-- 
2.39.2


