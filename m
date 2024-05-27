Return-Path: <linux-kernel+bounces-190077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2667F8CF94B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BBA2815BE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD160182A0;
	Mon, 27 May 2024 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fnA+IPe/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vr52uL51"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948B620DC5
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791901; cv=none; b=jJFLUIgm8tvYX0PdEEfOMCzJllYTrqlaHZ+hbpAzvJIsZZljly8mgRFlP0daBT+hC5K/O/4VQkCaBIWuDyRKc4o+RZirlFcbatdt3zxHxMdkJjbTqQnp5NpYexjDoFS1Tr1qZjVOEASWCSJu7U8TZ7c0xUNZK681DEyCsbbdv3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791901; c=relaxed/simple;
	bh=F5yMd/Q52Xd1F+9PcUxxTx8TRVI/tWIKRAO76Ya7FwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bztvnmqSxNSpobZoxdjk7XTbSXewT/GQ+PxVQ+AE7OW+IEQwvydtJiWordbcSYrYk3kcUL54yF6avjkJzfkHIHu+dSicXBpMJQ83WSDT9CerpSVebD36nZ5o5vq3zEdGByOH6S1Px3iCIKgv3I4VrDblfVSCwZg62t+BPb7Sp6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fnA+IPe/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vr52uL51; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VsgKp/Om0/JiwS4Uevm5ldbUKWaIwX/fMexuAWRWLGk=;
	b=fnA+IPe/lpYa287E7ZsW7l10DvrTTXSfg+TWp7ojrCR2athlPwGKd2hzt1Xhk/WzQ3VoMo
	Ll15ZgMmOmDjPC9RTAm/4quZCq2T9nB4hmnrVqyn4mf129auIcrCktr7+KawmSkJfQZ6kO
	KnDT1embVlmIvGt1i0hPAW1dFczHV5dX2NqcUa2FhpwmYDun678uXAD68iuLrDauUhR605
	BMAQV0aJYrpfGuho/eVvdVq2oRh9C1GSlb5CgWxfDyGKapPAs434Fg+rHSEJ/jlnwn5YQQ
	lYINC5XSrQSUqxGw9GS4WjbJ70CTTcQPb34q4OLIbAq5/ZLNPuhGnw9bWdGxaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VsgKp/Om0/JiwS4Uevm5ldbUKWaIwX/fMexuAWRWLGk=;
	b=vr52uL51GA4DNZfZpMUSY6Qb/GQiQ8FL9v0Qat5w1oWY6pje7KAy/A8hEeMi+6XgwUutes
	aRbddOa3hXL3XRAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH printk v6 04/30] printk: Check printk_deferred_enter()/_exit() usage
Date: Mon, 27 May 2024 08:43:23 +0206
Message-Id: <20240527063749.391035-5-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
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
index dbbd202b1cb3..6e1f055afef6 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -157,15 +157,16 @@ int _printk(const char *fmt, ...);
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
index 739b82adc383..831f95f26d48 100644
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


