Return-Path: <linux-kernel+bounces-273624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803C2946B98
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BA4280ED7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8B5B653;
	Sun,  4 Aug 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EO3EMh9Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A3O34kiQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B3EDB
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732710; cv=none; b=pkrR/dVjKble229PaEtqpi5fhhwgKOF3LioJaZ7QooG3/0QAHjdbyl+S/bEKnvcvmzzxS0QFPkNrOQm1T2HspRsTJDA102/lb8UcH4ESFy/dadDJE7vXq+sEd/DGm0twBWoKQNvI+bqS/v/XQgWRDYW4SKseZ/qQou7oEv2EiXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732710; c=relaxed/simple;
	bh=UQEDErLI4jcCnZVu0rwmOPRYJ2gt07XxfjlThqg5euI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QEdRA7XLBHQapZdGDC3oEYoNeKtutPy38z5F7vi1bu90sXAgoc9AZwFUqakEXsI9AGt1ioI741yHe5Y3+QEhmlJqZE68PAzrrIETJMHDm80CpdvPqQ2HYrfFD6rU0C0YUoUip6J0OW6YymAz6dJr8oFTtfi56nCVgYSRZYpW4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EO3EMh9Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A3O34kiQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayf4o19E2VctcrSLOsJe8upAlNvXm11HIiyOTvRvMPY=;
	b=EO3EMh9Y1vpWMEeVBSKR2VNzkTLDLp0wgRoQyQ8fLhC2JgG3pw/6nkAwuApzT95e8Da4RL
	PZGPcQAQa5Wc227NyqY05gOgEwH3PBC9jY51r8phR+Yv6HTleP/34mzwgpYD7AcY3SC4ma
	FaDRLITxUnotQwH+zxFCFYThOIFrXlAnVIKlNxK/4xYaTnBYeuRpSAeq2p5qcGrccUQDzJ
	s2MoT2wjsPAXr6+C7tmvYEojdlwjoVPVp0x+lml9wxNTr4sR0Wj+189zCxOshrNxuSRU53
	EYHxhzw6uQi2m6vGZaj+mTtkWJdRrBf5aU5cO1x+gt66Ovn88yRz8nQp+h6pjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayf4o19E2VctcrSLOsJe8upAlNvXm11HIiyOTvRvMPY=;
	b=A3O34kiQr+VCGjDVHap+so5q9joWvJLcMNlg5Z8JYlxUODEOfTkUht18GdEBl7C1rDpB4z
	Pze3XAHFLvRYSDAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH printk v7 04/35] printk: Check printk_deferred_enter()/_exit() usage
Date: Sun,  4 Aug 2024 02:57:07 +0206
Message-Id: <20240804005138.3722656-5-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Add validation that printk_deferred_enter()/_exit() are called in
non-migration contexts.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/printk.h      |  9 +++++----
 kernel/printk/internal.h    |  3 +++
 kernel/printk/printk_safe.c | 12 ++++++++++++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index b937cefcb31c..eee8e97da681 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -161,15 +161,16 @@ int _printk(const char *fmt, ...);
  */
 __printf(1, 2) __cold int _printk_deferred(const char *fmt, ...);
 
-extern void __printk_safe_enter(void);
-extern void __printk_safe_exit(void);
+extern void __printk_deferred_enter(void);
+extern void __printk_deferred_exit(void);
+
 /*
  * The printk_deferred_enter/exit macros are available only as a hack for
  * some code paths that need to defer all printk console printing. Interrupts
  * must be disabled for the deferred duration.
  */
-#define printk_deferred_enter __printk_safe_enter
-#define printk_deferred_exit __printk_safe_exit
+#define printk_deferred_enter() __printk_deferred_enter()
+#define printk_deferred_exit() __printk_deferred_exit()
 
 /*
  * Please don't use printk_ratelimit(), because it shares ratelimiting state
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 398ecb40d279..dc8bc0890fd2 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -53,6 +53,9 @@ int vprintk_store(int facility, int level,
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
 __printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
 
+void __printk_safe_enter(void);
+void __printk_safe_exit(void);
+
 bool printk_percpu_data_ready(void);
 
 #define printk_safe_enter_irqsave(flags)	\
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 6d10927a07d8..4421ccac3113 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -26,6 +26,18 @@ void __printk_safe_exit(void)
 	this_cpu_dec(printk_context);
 }
 
+void __printk_deferred_enter(void)
+{
+	cant_migrate();
+	__printk_safe_enter();
+}
+
+void __printk_deferred_exit(void)
+{
+	cant_migrate();
+	__printk_safe_exit();
+}
+
 asmlinkage int vprintk(const char *fmt, va_list args)
 {
 #ifdef CONFIG_KGDB_KDB
-- 
2.39.2


