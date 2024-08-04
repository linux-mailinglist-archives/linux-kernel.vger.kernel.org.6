Return-Path: <linux-kernel+bounces-273623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DCC946B97
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C027B1F21936
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE32D6FC7;
	Sun,  4 Aug 2024 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XjQKhG4R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7WQECTGe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EC3A29
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732710; cv=none; b=VaMlMzLqXFf4UFrqyTf7sENleo+u5y9o0BwTVRSlj4UvBoIVjqBgXpbIVrBprp41EIz1fJKh35pvRaIKp7uvuvAI08TyYSiZVZkgaT3hCn3iVgzbHeXFF0ibZE82sPJ8Q2C+7b13+0XTfasee/q0HhxoMwdOC+SkQYvGtPl1Dk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732710; c=relaxed/simple;
	bh=cQAt27LoW1Jl/nTzOAQ/jpBaNyuFpePcVMMoNmBrqfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HtKuqtkMzjKz/+EO3PCWelQ/N4cDlp5eCn6iAdiBmhv7D1xrhM+G4j20YCF43u7IVnTbOIyDbLosuUQudMbvzXujJnKvWX6VFT6l/ICZrYr2K+qUYYsNP6zKlFBRmJt6yJjMrbm42drBOAu5giu+HD+B0QqP+DPwd3HgnOxC9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XjQKhG4R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7WQECTGe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5eNYoyN0NDncqy4Z7XwPBDqj7+9dnH3bkoXiqAH1g9s=;
	b=XjQKhG4RAu4nrYJ6tqVN7Ps396l8c0kMjqyLsDiV1v/Bdet/Dm+ex8K2UZr04P8Ei2LHs8
	hT3SvpRDmUfTVaq95Ra7AhHGQqCc3e2OsQaimoWoC5fQIUSOvP8gfdE6m/TF3rPzdGZhS+
	+PnS3Ai/EsnWCxvA2jDpgaiCp7aKAKjRHQ2GbYTwKu9M9/xXR3gz3+SS3qJskjbtIuxZJX
	R5RpghgXLsl+jdBptBI8EVYaTaQFWsZBsFOe3rQErI54wcnV53KPSujf+w6YgiGeOurgiu
	3Nsqkm5ZcOSf/I6SkQC84oPS/BOxxVKCDnDrjwUo7PSVKBlx5fVDk+U07v/6Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5eNYoyN0NDncqy4Z7XwPBDqj7+9dnH3bkoXiqAH1g9s=;
	b=7WQECTGeJQVpzxY+vj3vgvOVfDGTJlzW+WEBLIqc7rom4KjIVpYD65eURq3mY4GzL1PNPn
	FkSu8xygsEc7J0BA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v7 02/35] printk: nbcon: Consolidate alloc() and init()
Date: Sun,  4 Aug 2024 02:57:05 +0206
Message-Id: <20240804005138.3722656-3-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than splitting the nbcon allocation and initialization into
two pieces, perform all initialization in nbcon_alloc(). Later,
the initial sequence is calculated and can be explicitly set using
nbcon_seq_force(). This removes the need for the strong rules of
nbcon_init() that even included a BUG_ON().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  2 --
 kernel/printk/nbcon.c    | 37 +++++++++++--------------------------
 kernel/printk/printk.c   |  2 +-
 3 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 19dcc5832651..398ecb40d279 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -75,7 +75,6 @@ u16 printk_parse_prefix(const char *text, int *level,
 u64 nbcon_seq_read(struct console *con);
 void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
-void nbcon_init(struct console *con);
 void nbcon_free(struct console *con);
 
 #else
@@ -96,7 +95,6 @@ static inline bool printk_percpu_data_ready(void) { return false; }
 static inline u64 nbcon_seq_read(struct console *con) { return 0; }
 static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
-static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
 
 #endif /* CONFIG_PRINTK */
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index c8093bcc01fe..670692dc9b10 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -929,17 +929,22 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
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
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), 0);
+
 	if (con->flags & CON_BOOT) {
 		/*
 		 * Boot console printing is synchronized with legacy console
@@ -958,26 +963,6 @@ bool nbcon_alloc(struct console *con)
 	return true;
 }
 
-/**
- * nbcon_init - Initialize the nbcon console specific data
- * @con:	Console to initialize
- *
- * nbcon_alloc() *must* be called and succeed before this function
- * is called.
- *
- * This function expects that the legacy @con->seq has been set.
- */
-void nbcon_init(struct console *con)
-{
-	struct nbcon_state state = { };
-
-	/* nbcon_alloc() must have been called and successful! */
-	BUG_ON(!con->pbufs);
-
-	nbcon_seq_force(con, con->seq);
-	nbcon_state_set(con, &state);
-}
-
 /**
  * nbcon_free - Free and cleanup the nbcon console specific data
  * @con:	Console to free/cleanup nbcon data
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b3a4c0363a96..15c61c9ea87e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3618,7 +3618,7 @@ void register_console(struct console *newcon)
 	console_init_seq(newcon, bootcon_registered);
 
 	if (newcon->flags & CON_NBCON)
-		nbcon_init(newcon);
+		nbcon_seq_force(newcon, newcon->seq);
 
 	/*
 	 * Put this console in the list - keep the
-- 
2.39.2


