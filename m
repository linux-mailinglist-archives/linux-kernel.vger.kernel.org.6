Return-Path: <linux-kernel+bounces-259242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25458939318
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA851C214E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B786D16F82E;
	Mon, 22 Jul 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sDFljNOu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IlIvboqv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D816E894
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668790; cv=none; b=hfqYa4rEdn0YvokqVHYCzY/exS1/VlnGBlyeknnoW1slWi2NLsu9ELXYGRP5ZQT5qcu4E/mQeRCUTeRzkab0yzpKJmi5QyYnaiZwquNJZC7dSvrzdH/ENrJZpXQAu6WF83vWgNYjCyyycYmk8JsYfj2tBcFDroANpn3Grk8Adcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668790; c=relaxed/simple;
	bh=A2eYnpHc8baJBUquJ1C2lgRQZHsDHryfmr0dAxCwRWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AOej+ub8E3IikiZHmn7DQFRuZ45P1jQy40RU7A7NYXusc8gS8mPM5ca4o2eUUPxEKBsNQG/VxYdocSHnAF88JRw/87h888iFeqzyElGeQKx9nfJdqElKk9O4fsGP77OhkG4Xj84SFPI2A28dMv7voqFq9rXk5jC995onNypaMXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sDFljNOu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IlIvboqv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onDKVSWtrdlC7pr3Dto9zggnE9buyG6ngOh1tFL4sBE=;
	b=sDFljNOuuBzGf6bHhJEQGwdNuoAO9HnH7C/pr9FGHHYz5cmNqXF3SL5a7D1KGs3wMZJlnR
	Gq7Uuu/KviUfTxpJ2vl8yhM5boe3lRBWNNXARhAvhxRmMpVc5MMec1LrpcINqWj2sKG4MT
	jxChC12CGw9Gg3fA+4xFnNoee2l2NqmecVF4qOe63xOVVCfsQIaHvg7MfSFBDvnz7ejm/4
	tMQfDvbfxG9erE8mMCNWhidvmSfc0++gBklU4n82DQBMVYQq5GikYSxb7gL/Wa72CVPv9/
	etvKDJNYhzadiaL62kmVd+v09QezP8i2iJ0SQs0oPJWjN/jfmTq4W5P1+jl4aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onDKVSWtrdlC7pr3Dto9zggnE9buyG6ngOh1tFL4sBE=;
	b=IlIvboqvdv183snpk7pJYDJOvtG4CEHQCAPgFz6GDMrbQlg5Vl5JbDvj7JAgAwpFZa7rS9
	RmmkYg2+OdnQInBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 02/19] printk: nbcon: Consolidate alloc() and init()
Date: Mon, 22 Jul 2024 19:25:22 +0206
Message-Id: <20240722171939.3349410-3-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than splitting the nbcon allocation and initialization into
two pieces, perform all initialization in nbcon_alloc(). Later,
the init_seq is calculated and can be explicitly set using
nbcon_seq_force(). This removes the need for the strong rules of
nbcon_init() that even included a BUG_ON(). It also more closely
matches the setup logic of the legacy consoles.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  2 --
 kernel/printk/nbcon.c    | 35 ++++++++++-------------------------
 kernel/printk/printk.c   |  2 +-
 3 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 0439cf2fdc22..d58f5cefbac3 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -86,7 +86,6 @@ int console_lock_spinning_disable_and_check(int cookie);
 u64 nbcon_seq_read(struct console *con);
 void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
-void nbcon_init(struct console *con, u64 init_seq);
 void nbcon_free(struct console *con);
 enum nbcon_prio nbcon_get_default_prio(void);
 void nbcon_atomic_flush_pending(void);
@@ -144,7 +143,6 @@ static inline bool printk_percpu_data_ready(void) { return false; }
 static inline u64 nbcon_seq_read(struct console *con) { return 0; }
 static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
-static inline void nbcon_init(struct console *con, u64 init_seq) { }
 static inline void nbcon_free(struct console *con) { }
 static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 static inline void nbcon_atomic_flush_pending(void) { }
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index d8388faa6500..1388e23a439f 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1343,17 +1343,21 @@ void nbcon_cpu_emergency_flush(void)
 }
 
 /**
- * nbcon_alloc - Allocate buffers needed by the nbcon console
- * @con:	Console to allocate buffers for
+ * nbcon_alloc - Allocate and init the nbcon console specific data
+ * @con:	Console to initialize
  *
- * Return:	True on success. False otherwise and the console cannot
- *		be used.
+ * Return:	True if the console was fully allocated and initialized.
+ *		Otherwise @con must not be registered.
  *
- * This is not part of nbcon_init() because buffer allocation must
- * be performed earlier in the console registration process.
+ * When allocation and init was successful, the console must be properly
+ * freed using nbcon_free() once it is no longer needed.
  */
 bool nbcon_alloc(struct console *con)
 {
+	struct nbcon_state state = { };
+
+	nbcon_state_set(con, &state);
+
 	if (con->flags & CON_BOOT) {
 		/*
 		 * Boot console printing is synchronized with legacy console
@@ -1372,25 +1376,6 @@ bool nbcon_alloc(struct console *con)
 	return true;
 }
 
-/**
- * nbcon_init - Initialize the nbcon console specific data
- * @con:	Console to initialize
- * @init_seq:	Sequence number of the first record to be emitted
- *
- * nbcon_alloc() *must* be called and succeed before this function
- * is called.
- */
-void nbcon_init(struct console *con, u64 init_seq)
-{
-	struct nbcon_state state = { };
-
-	/* nbcon_alloc() must have been called and successful! */
-	BUG_ON(!con->pbufs);
-
-	nbcon_seq_force(con, init_seq);
-	nbcon_state_set(con, &state);
-}
-
 /**
  * nbcon_free - Free and cleanup the nbcon console specific data
  * @con:	Console to free/cleanup nbcon data
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5090c0591f88..641c2a8b0a09 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3631,7 +3631,7 @@ void register_console(struct console *newcon)
 
 	if (newcon->flags & CON_NBCON) {
 		have_nbcon_console = true;
-		nbcon_init(newcon, init_seq);
+		nbcon_seq_force(newcon, init_seq);
 	} else {
 		have_legacy_console = true;
 		newcon->seq = init_seq;
-- 
2.39.2


