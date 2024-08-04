Return-Path: <linux-kernel+bounces-273643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EFA946BAF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C102823E8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532676BFB5;
	Sun,  4 Aug 2024 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="frccwcDl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BkVqTG0j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229A1CD0C
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732717; cv=none; b=g/Uwgnfh+Mfz2Z5Rn/uw5RO59sTrys9ASXfz97G5tDFAEkvInPFkJyNtwSGs6qtfOTJfwm0bqDgO/TP9qiVlKTfsUxPoIiZ/pPhg9GvMtM+U0A2G7Vzv/ukEWdru4j8ZCx6rC5Ie8tIqZdY6gOS+ISz7WYlUd/6qVAc9RoPibfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732717; c=relaxed/simple;
	bh=vrJSfk1CYTt6iDqiThb69rXLu0bjlZT4StPtuxtDFxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FntIebZbzsku4YjKU5gCztFiCTpgnaF7zUTSoPTglbvVkFIsCcEizY0cncTSe8Ln5fY+aUZppTrfsRN/EVlEUoJuUBxnBf8n7Bz5LdtnnxhuEKezEBDkfJvBPzTYl9Qa4860ftOGS+BlyjHMMTmjeKns25Dn8r4BffYjAvraCxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=frccwcDl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BkVqTG0j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZj5ZG2mfeXAb3IpB20OPoFPVSSec5uKMpkcM9Et3fQ=;
	b=frccwcDl+ggZ5RjDmd/m0qiLCc+g7itHO5m63UMLV1Bp/letMoRX12aTULOafS+n7Au9IE
	xG0BUBcVfAouGSZfxroOl0FBvBDLiBvKtPNCSuwcw2K3MJ+1qKB+fXa8GDPXYGXV6UF97w
	qFrZx0PdNslXhHqKzmtymdFryKRUp65xTYL1c8HR5iiOr5RdgpklrKeTZSc5tK1p4Ii4Ix
	AEjX2AYYUGBh0R7DtF9+FCYQY2+vqzeJtFKuAKCRatL5PUmo24JsKku4a04EQd9VZGVmc0
	niNcXHgBg+H0YqkcS2M+2EeGizHzrvA0vA4/zS0VOqhtBfFOFtw3pmK6O5iKIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZj5ZG2mfeXAb3IpB20OPoFPVSSec5uKMpkcM9Et3fQ=;
	b=BkVqTG0jntkTD1uELEO6oyf0TSg6vBBw9zXs1CcSM+AztoXUKTNaEtTMeMsSJzE+j3UATZ
	ycNlNs/4V4AY2QBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v7 23/35] printk: Add is_printk_legacy_deferred()
Date: Sun,  4 Aug 2024 02:57:26 +0206
Message-Id: <20240804005138.3722656-24-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If printk has been explicitly deferred or is called from NMI
context, legacy console printing must be deferred to an irq_work
context. Introduce a helper function is_printk_legacy_deferred()
for a CPU to query if it must defer legacy console printing.

In follow-up commits this helper will be needed at other call
sites as well.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h    |  2 ++
 kernel/printk/printk_safe.c | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 44468f3828f3..84706c1c934b 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -75,6 +75,7 @@ bool printk_percpu_data_ready(void);
 	} while (0)
 
 void defer_console_output(void);
+bool is_printk_legacy_deferred(void);
 
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
@@ -138,6 +139,7 @@ static inline bool console_is_usable(struct console *con, short flags)
 #define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
 
 static inline bool printk_percpu_data_ready(void) { return false; }
+static inline bool is_printk_legacy_deferred(void) { return false; }
 static inline u64 nbcon_seq_read(struct console *con) { return 0; }
 static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 4421ccac3113..86439fd20aab 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -38,6 +38,15 @@ void __printk_deferred_exit(void)
 	__printk_safe_exit();
 }
 
+bool is_printk_legacy_deferred(void)
+{
+	/*
+	 * The per-CPU variable @printk_context can be read safely in any
+	 * context. CPU migration is always disabled when set.
+	 */
+	return (this_cpu_read(printk_context) || in_nmi());
+}
+
 asmlinkage int vprintk(const char *fmt, va_list args)
 {
 #ifdef CONFIG_KGDB_KDB
@@ -50,7 +59,7 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	 * Use the main logbuf even in NMI. But avoid calling console
 	 * drivers that might have their own locks.
 	 */
-	if (this_cpu_read(printk_context) || in_nmi())
+	if (is_printk_legacy_deferred())
 		return vprintk_deferred(fmt, args);
 
 	/* No obstacles. */
-- 
2.39.2


