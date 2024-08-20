Return-Path: <linux-kernel+bounces-293350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6222E957E37
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17C5B21F30
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9597B205E37;
	Tue, 20 Aug 2024 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R4I6msnB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qpw12DAe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE1D1E673D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135416; cv=none; b=SKVfQAzMn+Mm4/py/xjkHZRcxTRQT80F4oeXz/G80Lu9e7emC13VQ84/gVdKlCr0WLjnlumX0aGcVeS/LYGRPAZ4dNT97MK62M++BxkLU9PPpInCsyS+dTWGjCGBbtqDRoZvXWiN34DIaTMMKLjmnvjwxDNyRklgp6WAWrcCNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135416; c=relaxed/simple;
	bh=u9R7V3SWQh4dmn1pSZNOeucL24uhkignFIHV1liGHqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gWfr7/BIeuhyo/nujMf2f1SBbQ1MjfoY/my+MAyCOYBCSjePdRTGd8obJbekdEUd0Y3pQs6ldtwwE+/gBXPRntqqwH/JKotahezu1w3tfoHf0P0yZKIm0dHWAH9AN5h3pZczsjorBhGE3E6M6VwrwWoP0Zp0p/xfVmkb0A1dcnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R4I6msnB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qpw12DAe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZ7lcLITjsiBQ4lYUcMFDLnTqm2f8z4kC29R9dC04Os=;
	b=R4I6msnBEhKMjZh7d7BpAVfxq5eL4zFvzVItBKHJA+75W7pshgNXqZMMMlHQl5zCPpxOPb
	MrATOywOSk+WYbwQSL+5KlR+ay+OPIuYHJN+RVkVwzKWOOLR7gTMJSgfw8l4DAbXO23cX6
	bVCX39i1WYX/9vmKXem0SUyKBzROUtbrEHYH0BwS4WOjCudtyJOqeRHEy1mbsxzS6TMLy9
	k8uRMGMaWCBMv2M5xKhWdwQxoqhgtjeRSwvwoJjtUvK3c2UnGhOOHVoSqvX5fXhpssYf5R
	/tM7XbYvlothMdt/YhEJXhntLxFF3q584hVe7bhHl3jkuvMR99y94xr0T2ZMBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZ7lcLITjsiBQ4lYUcMFDLnTqm2f8z4kC29R9dC04Os=;
	b=qpw12DAe/xUV5ZLzS9chq97XVydU76WUpW5uYo/H+2QNH/V/v+ThApof9GC1dqUn5vNYQ4
	Bquw0ccAQl+eGJDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v8 23/35] printk: Add is_printk_legacy_deferred()
Date: Tue, 20 Aug 2024 08:35:49 +0206
Message-Id: <20240820063001.36405-24-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
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


