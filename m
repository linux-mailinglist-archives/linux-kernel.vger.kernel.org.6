Return-Path: <linux-kernel+bounces-293349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F78957E36
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D162F2858EB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3F4205E2F;
	Tue, 20 Aug 2024 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IGphuTM6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QzAQD7yb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63DD1E4EFD
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135416; cv=none; b=ZVOCwXbYryimUtMePnPIapsLYasjyL1q2FxbuC/xC01ffE+QST1TJ7u6Cu42eFqK2jevbOrcU99w3CnL/4FkOguFNjB4CogqYgonD8X2KT7Kmr8HwsS6CEY5mGIrV1SvKSKXfCT9pVA+Jgk+qLKr1foRm+UMIThJFkugAuQbL/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135416; c=relaxed/simple;
	bh=aTHeGsgFQ1oTZmqvTIRdrSLxIs4LNKBXCo+yqGQfh6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hJBTc6l48CJj3qjZ0+5i161k5sVLLpFF7uxm7mBjm1NZ/Po93cJpOJiUYggNwu6DmtaWtpJLgxPhRJPiWXGYSLeeaDx7aHaNq16dSbgwHM0X+gfDQPKoWhHVi4VtckL/S1Kgj13TZTDct0SvrLRlsB6wyqAxmOYOVqdJjZc3WfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IGphuTM6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QzAQD7yb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XD7B+/16cYPalF/Yi3kcRavUJdqN2zR/cQDyDLYlxY=;
	b=IGphuTM6jm9Gesw4nDQhHi/RhHbZMKUXnOTtuCplY2wLH1kWff5zLlrh69A4/0xDiXGpVe
	NyF4GCdng5WpRZ25qD9AO3k2KLGWLCmasRoYxfOIrurbfpOcKRMXOZpO7uewh2LHNGg3vd
	w9HGHjNKKB2kae59nf12G3wX3HY0ZGm1Mvj+TDFHpo45JWlCdvYNKBu0RTnNqFL01dYuTN
	zFQ5ruARBYlAaS9l1KrIaFFlA+17qa+iTRXB+/87mIVSN0BaFWB6QUVjWFBtD4W6Kfvit4
	VzHs7Eppu2g9FHbxA+FnWOfF04hqjb9soanII9oJTi/BxZLLj3hki4nW42L5lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XD7B+/16cYPalF/Yi3kcRavUJdqN2zR/cQDyDLYlxY=;
	b=QzAQD7ybCh/2W2KsJ8OlG7iaJ+84zkUu/YM4H1MdH/ANXSgX2BeevDspqhjoSA27CVElJL
	Tt3xH4rx1JuJrbBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v8 16/35] printk: Make console_is_usable() available to nbcon.c
Date: Tue, 20 Aug 2024 08:35:42 +0206
Message-Id: <20240820063001.36405-17-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
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
index ccb916688178..5d9deb56b582 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -84,6 +84,36 @@ void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
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
@@ -104,6 +134,8 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_free(struct console *con) { }
 
+static inline bool console_is_usable(struct console *con) { return false; }
+
 #endif /* CONFIG_PRINTK */
 
 extern struct printk_buffers printk_shared_pbufs;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4cd2c50dd06d..b9c8fff9a493 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2767,36 +2767,6 @@ int is_console_locked(void)
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


