Return-Path: <linux-kernel+bounces-190075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B623E8CF949
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2951F21090
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B3817BB6;
	Mon, 27 May 2024 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qjZCHn5U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0KYfIqMw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF12032A
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791900; cv=none; b=BM8rlMm72zARf1V/lgi63YlgJC95AEFHUASGdCFAljPQW4tHl/FHHIzZYXh2MDcNDRmZEbVVBbKwtEux/3gyATzOu/0vko/s6fp+uHAkyoa9rpW09NxgHloCkxrc2JS8YLR6HlbReaNjxpIr7RAzkitSMjl2Z/c/i03Y0bpyQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791900; c=relaxed/simple;
	bh=uJo1oELvyDQOhiRu2SO/n1grPBTW50wUxfvcqcbXfEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h9smRKgxfMwAIKdUzfHXyEAWr0UpR2Vp37GOBwAfVhnpgFUir85mrV8asM0iUh2eRctMtbjzzUbPGb3b7KWTgLQyFDRNDU6ai2ElBZs05l3ja7HWU75uh/wBe9qvbHCN9DraKIWikWC5c+9zzXYdsS2q83EGx2pJDI/vRANI0VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qjZCHn5U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0KYfIqMw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvvXcgZvXxemT9kjJC+HVcrx0f7yfYMwgbRbPkHz9+k=;
	b=qjZCHn5U7M1e/aS5MXcWPWaLga2DddaMPm5v2wAL53N2CSM0NHGOc8ptV/MstuzjR3q1MV
	2EPpHBIKbHgN3DVAQ5dIPT1IQzD289wV15dHHfKh1bM19GmTzYFRZOVdVwnTGw/wZb0F4w
	u0Mu2qUlHMEzQyh7BxtsNc4k1UG3Em/I5y4fKzh9m8tMnLtWnerbyWmX5Vfe3CJihIU+nS
	XGI99yVXYN9L417Edk3Peq63BjzNEBSY35uvDR1o7OZs7WSC+P0JcUMT4O+sPoGexaBgTS
	CEkQ8r+PgjQQO8dfDvIaW1X8Q0JEnj0QJPKrTvkYbx9eKvvCeX2SJ0DnOTsRsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvvXcgZvXxemT9kjJC+HVcrx0f7yfYMwgbRbPkHz9+k=;
	b=0KYfIqMwqM1NEMGyZWAG/39WznOWARAFCcBbQper6Q+xOgOXXOlMPy882iwk3TYtbf5m4/
	Oz1GhITWHsjINgCQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 02/30] printk: Properly deal with nbcon consoles on seq init
Date: Mon, 27 May 2024 08:43:21 +0206
Message-Id: <20240527063749.391035-3-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
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
consoles set the sequence via nbcon_init(), for legacy consoles
set con->seq.

The cleaned design should make sure that the value stays and is
set before the printing kthread is created.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  4 ++--
 kernel/printk/nbcon.c    | 10 +++-------
 kernel/printk/printk.c   | 41 ++++++++++++++++++++++++++++------------
 3 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6c2afee5ef62..739b82adc383 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -75,7 +75,7 @@ u16 printk_parse_prefix(const char *text, int *level,
 u64 nbcon_seq_read(struct console *con);
 void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
-void nbcon_init(struct console *con);
+void nbcon_init(struct console *con, u64 init_seq);
 void nbcon_free(struct console *con);
 
 #else
@@ -96,7 +96,7 @@ static inline bool printk_percpu_data_ready(void) { return false; }
 static inline u64 nbcon_seq_read(struct console *con) { return 0; }
 static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
-static inline void nbcon_init(struct console *con) { }
+static inline void nbcon_init(struct console *con, u64 init_seq) { }
 static inline void nbcon_free(struct console *con) { }
 
 #endif /* CONFIG_PRINTK */
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index c8093bcc01fe..de260531b0da 100644
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
@@ -961,20 +958,19 @@ bool nbcon_alloc(struct console *con)
 /**
  * nbcon_init - Initialize the nbcon console specific data
  * @con:	Console to initialize
+ * @init_seq:	Sequence number of the first record to be emitted
  *
  * nbcon_alloc() *must* be called and succeed before this function
  * is called.
- *
- * This function expects that the legacy @con->seq has been set.
  */
-void nbcon_init(struct console *con)
+void nbcon_init(struct console *con, u64 init_seq)
 {
 	struct nbcon_state state = { };
 
 	/* nbcon_alloc() must have been called and successful! */
 	BUG_ON(!con->pbufs);
 
-	nbcon_seq_force(con, con->seq);
+	nbcon_seq_force(con, init_seq);
 	nbcon_state_set(con, &state);
 }
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6efb629fd976..4480ad2f198e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3348,19 +3348,21 @@ static void try_enable_default_console(struct console *newcon)
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
@@ -3381,7 +3383,7 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 			 * Flush all consoles and set the console to start at
 			 * the next unprinted sequence number.
 			 */
-			if (!console_flush_all(true, &newcon->seq, &handover)) {
+			if (!console_flush_all(true, &init_seq, &handover)) {
 				/*
 				 * Flushing failed. Just choose the lowest
 				 * sequence of the enabled boot consoles.
@@ -3394,19 +3396,30 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
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
@@ -3438,6 +3451,7 @@ void register_console(struct console *newcon)
 	struct console *con;
 	bool bootcon_registered = false;
 	bool realcon_registered = false;
+	u64 init_seq;
 	int err;
 
 	console_list_lock();
@@ -3515,10 +3529,13 @@ void register_console(struct console *newcon)
 	}
 
 	newcon->dropped = 0;
-	console_init_seq(newcon, bootcon_registered);
+	init_seq = get_init_console_seq(newcon, bootcon_registered);
 
-	if (newcon->flags & CON_NBCON)
-		nbcon_init(newcon);
+	if (newcon->flags & CON_NBCON) {
+		nbcon_init(newcon, init_seq);
+	} else {
+		newcon->seq = init_seq;
+	}
 
 	/*
 	 * Put this console in the list - keep the
-- 
2.39.2


