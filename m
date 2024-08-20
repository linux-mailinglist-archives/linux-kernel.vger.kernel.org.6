Return-Path: <linux-kernel+bounces-293329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 625B3957E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC5D1F22DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B39F1DC463;
	Tue, 20 Aug 2024 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="atJnOERl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4D/axHLO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E7A175D5F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135407; cv=none; b=WfkNEtmcOgy5VDzzYebNZHWzgDYoiXwwtRagdJOMkjV/D8/oR3mBqUq3O2NYTqkIsuxCOqMQyde8mEzMlVi6hzPI+FyynFfgcvzkyapu03TZNbKE8TrcorYhu86CVO0S4zohuQkHJugEsGNNjTfaA+a5yHkh6mINLhNCAEfWyv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135407; c=relaxed/simple;
	bh=UQEDErLI4jcCnZVu0rwmOPRYJ2gt07XxfjlThqg5euI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7UCueHsISYYhkOnuyRvyy8XwyENLTCOdTd02a6sOLSgRPsbcn6zGvDi2/nOKbUAktGyF5wW/wtVVjPjHqI/hGVeyZU9Ry6djOZP3OlFWqMogazpt8FgfWv2r7UwMYgv+BJ7qnV3C4ZfFOGGFj6ZDe1WYnJSX/3WSjwZHJ8KGxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=atJnOERl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4D/axHLO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayf4o19E2VctcrSLOsJe8upAlNvXm11HIiyOTvRvMPY=;
	b=atJnOERlwUGvGbo992WNoLusRzRcieHOVpGYQgOG6Cfa2TMJ1zi9e3TwkWhHVnRHNnZIJ+
	7f/2wxDhR3qd/67JYPYPDdCPiSuWEBdYtGf+3gqfPae4jrOC0iZ936fsGnumJYlpEmmRSc
	3HOvWJTlsDWnHTPbmdEmwna8Oga4oEX1xuXHVYfGAtBArlaIX1ENeX6jOLXjzt2OfYNGKd
	7a8fCbCoSSKv278bTfOZWI3lDtAcAET3n1N74pcFP91gplK1U9RnbJa2HL3kNnIKVUUydq
	BJDfYzrkMp9NSG2QbbV0L6H5blbvOZuBYWIhRGf5alhNLw/e8ebp1o1D774FPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayf4o19E2VctcrSLOsJe8upAlNvXm11HIiyOTvRvMPY=;
	b=4D/axHLOKz18WlVWDKtKKHYCavM6COWRGclgYciTcmqhjes4iqGsYSpG50o8Td4GtKU9IU
	RHH0QAA0sz8MqLCQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH printk v8 04/35] printk: Check printk_deferred_enter()/_exit() usage
Date: Tue, 20 Aug 2024 08:35:30 +0206
Message-Id: <20240820063001.36405-5-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
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


