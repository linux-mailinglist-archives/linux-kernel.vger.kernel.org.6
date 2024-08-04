Return-Path: <linux-kernel+bounces-273625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32289946B99
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95DF280E1D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89F5BA45;
	Sun,  4 Aug 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rJ53UuNi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hsLl1jXS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F42EDF
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732710; cv=none; b=cKNs8psNpy0F5pXwalA9kRO37VEC+EIH5EnvoENBs0ZjW9GRhyCjVVAE9krMTsiaGGaravZKPxXohbwcrfZ4zucV+71RsXvwSRpvTWwOpo15SGxJ1AzGjQSST0KzD+ktu4EM+sjrCmE8qPsAfWT6xtVVEJAgUf2dHTsznf95QnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732710; c=relaxed/simple;
	bh=MmS9l1LDp+ZDFdiI+E3/QxHSD/My+JgIhfsgei30hKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iFaC0wEVFO5Yj6S9VltULWFulh+dvGkE3sniApWCqX8Fj4CrMFrL25lCAmw6r7ANsPAaKA5GkDv2jbp8TDQ9YzOG78Owg+jW6Snw1P095qg+hCG78zFOwdxXjJs2c93iOLzhLqUJ8UkhnYARA+k/G/TFWNocJ+lNYHdQpuMPXYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rJ53UuNi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hsLl1jXS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3KyagiId8+wbYT3p1n8TW2nOqh9sHrCzp4zum5DTowE=;
	b=rJ53UuNi6Br+wwaO+mJzTv19Z4lmb27+t0mRQNHO38H6VmBrNfbntOHnuFlbqF4PGUGgP4
	4sqAoi0boHLesIEP7M08453xBO8Z++MSbXj7XpSRFRIsOju7OmZKjM7kNUFYYIlrIU3WL6
	lXaSYIldKNfv7DVJ5efdrh9wp8473AN/yiDZ5k+fRQso2KVHEQb6fcjqPB9ZPy9hCkbfzp
	/vVS0Kk+6+WOkaqokvxox50AQcJpVwqEfEf2XYrj5H2Ft+GPQBpCMfaTdpj2XYohYDeu9e
	S2i27a/hVkYwN62WgY/uVfxkP/y7iIYWszdmps72HQoccZt7N6QvCqa8NtPXhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3KyagiId8+wbYT3p1n8TW2nOqh9sHrCzp4zum5DTowE=;
	b=hsLl1jXSY6BUTAkpTiWqTzm+hUbFvhLWEKKTka2mprGDLal3FqxEGkbb7SFz7sguumgCL0
	JStR1GpL+fDGayCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v7 03/35] printk: Properly deal with nbcon consoles on seq init
Date: Sun,  4 Aug 2024 02:57:06 +0206
Message-Id: <20240804005138.3722656-4-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Mladek <pmladek@suse.com>

If a non-boot console is registering and boot consoles exist,
the consoles are flushed before being unregistered. This allows
the non-boot console to continue where the boot console left
off.

If for whatever reason flushing fails, the lowest seq found from
any of the enabled boot consoles is used. Until now con->seq was
checked. However, if it is an nbcon boot console, the function
nbcon_seq_read() must be used to read seq because con->seq is
not updated for nbcon consoles.

Check if it is an nbcon boot console and if so call
nbcon_seq_read() to read seq.

Also, avoid usage of con->seq as temporary storage of the
starting record. Instead, rename console_init_seq() to
get_init_console_seq() and just return the value. For nbcon
consoles set the sequence via nbcon_seq_force(), for legacy
consoles set con->seq.

The cleaned design should make sure that the value stays and is
set before the console is added to the console list. It also
unifies the sequence number initialization for legacy and nbcon
consoles.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/nbcon.c  |  3 ---
 kernel/printk/printk.c | 41 +++++++++++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 670692dc9b10..776746d20fc0 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -172,9 +172,6 @@ void nbcon_seq_force(struct console *con, u64 seq)
 	u64 valid_seq = max_t(u64, seq, prb_first_valid_seq(prb));
 
 	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __u64seq_to_ulseq(valid_seq));
-
-	/* Clear con->seq since nbcon consoles use con->nbcon_seq instead. */
-	con->seq = 0;
 }
 
 /**
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 15c61c9ea87e..6ac333938ffc 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3448,19 +3448,21 @@ static void try_enable_default_console(struct console *newcon)
 		newcon->flags |= CON_CONSDEV;
 }
 
-static void console_init_seq(struct console *newcon, bool bootcon_registered)
+/* Return the starting sequence number for a newly registered console. */
+static u64 get_init_console_seq(struct console *newcon, bool bootcon_registered)
 {
 	struct console *con;
 	bool handover;
+	u64 init_seq;
 
 	if (newcon->flags & (CON_PRINTBUFFER | CON_BOOT)) {
 		/* Get a consistent copy of @syslog_seq. */
 		mutex_lock(&syslog_lock);
-		newcon->seq = syslog_seq;
+		init_seq = syslog_seq;
 		mutex_unlock(&syslog_lock);
 	} else {
 		/* Begin with next message added to ringbuffer. */
-		newcon->seq = prb_next_seq(prb);
+		init_seq = prb_next_seq(prb);
 
 		/*
 		 * If any enabled boot consoles are due to be unregistered
@@ -3481,7 +3483,7 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 			 * Flush all consoles and set the console to start at
 			 * the next unprinted sequence number.
 			 */
-			if (!console_flush_all(true, &newcon->seq, &handover)) {
+			if (!console_flush_all(true, &init_seq, &handover)) {
 				/*
 				 * Flushing failed. Just choose the lowest
 				 * sequence of the enabled boot consoles.
@@ -3494,19 +3496,30 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 				if (handover)
 					console_lock();
 
-				newcon->seq = prb_next_seq(prb);
+				init_seq = prb_next_seq(prb);
 				for_each_console(con) {
-					if ((con->flags & CON_BOOT) &&
-					    (con->flags & CON_ENABLED) &&
-					    con->seq < newcon->seq) {
-						newcon->seq = con->seq;
+					u64 seq;
+
+					if (!(con->flags & CON_BOOT) ||
+					    !(con->flags & CON_ENABLED)) {
+						continue;
 					}
+
+					if (con->flags & CON_NBCON)
+						seq = nbcon_seq_read(con);
+					else
+						seq = con->seq;
+
+					if (seq < init_seq)
+						init_seq = seq;
 				}
 			}
 
 			console_unlock();
 		}
 	}
+
+	return init_seq;
 }
 
 #define console_first()				\
@@ -3538,6 +3551,7 @@ void register_console(struct console *newcon)
 	struct console *con;
 	bool bootcon_registered = false;
 	bool realcon_registered = false;
+	u64 init_seq;
 	int err;
 
 	console_list_lock();
@@ -3615,10 +3629,13 @@ void register_console(struct console *newcon)
 	}
 
 	newcon->dropped = 0;
-	console_init_seq(newcon, bootcon_registered);
+	init_seq = get_init_console_seq(newcon, bootcon_registered);
 
-	if (newcon->flags & CON_NBCON)
-		nbcon_seq_force(newcon, newcon->seq);
+	if (newcon->flags & CON_NBCON) {
+		nbcon_seq_force(newcon, init_seq);
+	} else {
+		newcon->seq = init_seq;
+	}
 
 	/*
 	 * Put this console in the list - keep the
-- 
2.39.2


