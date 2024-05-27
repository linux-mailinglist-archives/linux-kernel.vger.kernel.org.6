Return-Path: <linux-kernel+bounces-190090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC43F8CF95C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0183282333
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EE113AA59;
	Mon, 27 May 2024 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHuqOGJW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NK4ijYFW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1676E4594D
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791907; cv=none; b=ues1e2eJWLxFI7abIm6LkQUZCbynKfXfsVdQhw2xyictFrnXtn8xTT+Gi0PqSZPnRbZGMInkX436S+6JhfdRCx3jfpJQ4SSRMTS4FbwSbCAmIkaOQ921s1o/XkFGeU06u4bKrIYnhM5zKncFSEjHiZ4dJ1fPXoZPLVb3i/OfbGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791907; c=relaxed/simple;
	bh=4TqYg9C9M7bVyQVBRTlOYVbfQwj4hBnVKOPQn39lBzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KS1kc8RT9Lhfx9ILfIvXhJWvzSbECPHS/6mcYgCmqsBwx5ON2BRFli+B7u2oEqCoLOuBK9OqSuTpRiFwajvb1cSXhq1KprPfhR5DTAXCDBnP7+1Mj/xgBy+6v6PW6XSlP6bZZLuKRgv4RBk4ejiIjA/aQWJwvOQDF/2srs9TmVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GHuqOGJW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NK4ijYFW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAfJ0/ArpyBrKdvlxG2JN5Vl00RCt4dDRQpqktRYYBg=;
	b=GHuqOGJWM0mKftTjKcJZFWer07OfurTQzkE2xHi9zx93nnmXVS4hW7PfaXl07TmhDxWjXc
	lMPDWaSCycf9iIbsh3/lZ+NN5cCuUWKXpqBW49osTb3gffPbTNA0aARqoHAPTyvgvZ+Gqr
	eoVCxn7oQV4xsOszXIT/qQa2HKhILG3YPcM/8xp3aTwzs9CZvVSSV9FM6AQkcZBc7ugqMH
	FYBOSqhjIspUcyMpmZV3qnEu51WqN3zmNv88SdPN21dhsBxwDrkN/uuYYpFtG1+7QKzZL7
	zT+iqgZ9+AAj2icfNMIHX/z8trqf/8D4W7U3uko3qU5UIBwq6zczM9tdwwtRJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAfJ0/ArpyBrKdvlxG2JN5Vl00RCt4dDRQpqktRYYBg=;
	b=NK4ijYFWANDnGQrJZ+jdRFOKCqDon2eMqGJl5Vzuj6lF3XPUvJ2r4BvTb7q2eQNhQJK3HF
	lhCY06fcUasuigAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 15/30] printk: Make console_is_usable() available to nbcon
Date: Mon, 27 May 2024 08:43:34 +0206
Message-Id: <20240527063749.391035-16-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move console_is_usable() as-is into internal.h so that it can
be used by nbcon printing functions as well.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 32 ++++++++++++++++++++++++++++++++
 kernel/printk/printk.c   | 30 ------------------------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6c1d01eabf3b..339563dd60bb 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -85,6 +85,36 @@ bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con, u64 init_seq);
 void nbcon_free(struct console *con);
 
+/*
+ * Check if the given console is currently capable and allowed to print
+ * records.
+ *
+ * Requires the console_srcu_read_lock.
+ */
+static inline bool console_is_usable(struct console *con)
+{
+	short flags = console_srcu_read_flags(con);
+
+	if (!(flags & CON_ENABLED))
+		return false;
+
+	if ((flags & CON_SUSPENDED))
+		return false;
+
+	if (!con->write)
+		return false;
+
+	/*
+	 * Console drivers may assume that per-cpu resources have been
+	 * allocated. So unless they're explicitly marked as being able to
+	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
+	 */
+	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
+		return false;
+
+	return true;
+}
+
 #else
 
 #define PRINTK_PREFIX_MAX	0
@@ -106,6 +136,8 @@ static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con, u64 init_seq) { }
 static inline void nbcon_free(struct console *con) { }
 
+static inline bool console_is_usable(struct console *con) { return false; }
+
 #endif /* CONFIG_PRINTK */
 
 extern struct printk_buffers printk_shared_pbufs;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 75f64efaa53c..3947702b7977 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2697,36 +2697,6 @@ int is_console_locked(void)
 }
 EXPORT_SYMBOL(is_console_locked);
 
-/*
- * Check if the given console is currently capable and allowed to print
- * records.
- *
- * Requires the console_srcu_read_lock.
- */
-static inline bool console_is_usable(struct console *con)
-{
-	short flags = console_srcu_read_flags(con);
-
-	if (!(flags & CON_ENABLED))
-		return false;
-
-	if ((flags & CON_SUSPENDED))
-		return false;
-
-	if (!con->write)
-		return false;
-
-	/*
-	 * Console drivers may assume that per-cpu resources have been
-	 * allocated. So unless they're explicitly marked as being able to
-	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
-	 */
-	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
-		return false;
-
-	return true;
-}
-
 static void __console_unlock(void)
 {
 	console_locked = 0;
-- 
2.39.2


