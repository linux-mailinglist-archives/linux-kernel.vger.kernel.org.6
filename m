Return-Path: <linux-kernel+bounces-273638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82717946BA9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAEF1C2093F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D293A548EE;
	Sun,  4 Aug 2024 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NIpd4oll";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZxqrHUmh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5FC1B28A
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732716; cv=none; b=WauvKlu4QNi9pnb9LjQ/5VtcgbGPr2O154Srx2OBgPcgGP85/rqMUJXGq9cJI7xOJNeqsBOr/5PlxXiXL/t10tKnqM4S9ef7rrB2AfY7I3fzZ0izDnynQsuvX4hlFWXFw/ak+0IeZ9Ei/2SeyWNE0lOHFymDk95ZJ/vaDqbi7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732716; c=relaxed/simple;
	bh=JFMKZtGPkrU5SIuPBdCMEj2nzyR/bidpQHk9sb/QEjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l4Hgg/FYcyCVQQmxFOlNxZr//tcc4Wz3lVkKUgHsmGqvy6chOIQ6QIjsPTRd2tTmQKOkHplkknWpPqxDQydmCPKsKhe93YP02VykUvUIk9CcI5GTbm/TuapKqj0Klw0NJleysMKXcoMqmw9x2zrZFs0Gl0TsQW8FgVIE7pajdZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NIpd4oll; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZxqrHUmh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V3J+O0K9BaumAkEip6m7BqVS+0WrsRdwTh0cSg6mOBk=;
	b=NIpd4ollVWMMPN/4Yd3Ek5Kgd2DEKwLeKrKEQc1SByi/oyorRTUUxy1zvdml1I4RpQi8eh
	3qXDaBX2uJtyGww6r39s/F4v40beFDrgHrhA34mtYntwGSeRSv7qR9xJIdsH8ZJ4AAuFIu
	M1GUEpmMK6buWTYAuiilAO3S4yOJQZ7p8AbCPvUWKpIdxdJxAYcRUVP5bSIuHQmxiSSu/0
	kJGyoMvFa//mYiMxEyCknbFd8QbE4OPQg1oxh4Cb04NgJW35tihXkSthXNUwEuej5AdhXW
	TNJ4WnheykWm0vXldeyqSi4iU9sn007zWMVmJ7OCbKqic9336ap0jGFj/coPug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V3J+O0K9BaumAkEip6m7BqVS+0WrsRdwTh0cSg6mOBk=;
	b=ZxqrHUmhPcuJG05UWRkif/Ig2bIHAAP4CIX9fI/Wa5QziHbAexLCpnK8b+Aw6gkrKRe7BU
	O9FgXuP/9HNF2ODQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v7 16/35] printk: Make console_is_usable() available to nbcon.c
Date: Sun,  4 Aug 2024 02:57:19 +0206
Message-Id: <20240804005138.3722656-17-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
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
index 7027f0868ef4..5a1fa8eebe5a 100644
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


