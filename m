Return-Path: <linux-kernel+bounces-190092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B60398CF95B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D792823F0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AD113AA54;
	Mon, 27 May 2024 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CeAHKzSW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g2+bdbP4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5051E2032A
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791907; cv=none; b=o9uz1DI3IRk26bTfUgsZ6dBqkxdUTNDUkwWQjYHUdEm86rVYSM/qbUUCjVTuyjxHX62YT0md5/EqlcaEmmzO67ivXoUo8+vhOGcRI25wzZrkYSI6QQV7Hh9w+iODzA24z8wt0iXw8CzVZ07+n6Z09IjMFx/erGQ/tuYEni7SY4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791907; c=relaxed/simple;
	bh=zIdDnOXlkpAr4wXXrW1lnomWo/FU9/LQB9BST474AnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CnOU06aPI9Jfi+sW/UmYCFDn/C+K9mofQqzq7RFDri9511PWKS7bl801skJXPnNvQTtAGmQeAGpmL5DwdS78zyu2LmvLpeFCGCL/dAvcxMAOjb7en5FrMLRmggIRBPr6pRLTd+LijlqZgz3AnGeby1EQTvP0op7+l/JgWYgOYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CeAHKzSW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g2+bdbP4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXVGPLDxDMAPJlIbkXd901VLd/8W6fOa0g3BKtOGhG0=;
	b=CeAHKzSW4cdqmhGzQqDTLKQs3MLS8+yqSD9TyagAHAb48WpOHu7+9d6ylcBV18Y6tAe/cC
	kZH4LhzGSyJ74JI5qnjizOS7uUi6zJnH3tqO2I9RDXFQSykhvdTUZC5BrZTUnPuhERNVsE
	W3aNLskrADDwyf5yP9/wT3J7K9MEZiKlAjWkwQQm/Ka3Qu/uCfcCrfB0jW2hLtnemwR6LP
	7m1yqNGO47ueqJpL0nOUmc/9GBSEoE2kKivVQwPBmG7rNVAH1k0Rbh60vK0OxX/wzG1JJ2
	tA6JCSqYbZNgSIPo5CteWm1bQWr6T2y9wuFg5qGMIqjXcDiLicguHXth2tESQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXVGPLDxDMAPJlIbkXd901VLd/8W6fOa0g3BKtOGhG0=;
	b=g2+bdbP45Z9sijA0WWF4y8B8XwyWGIA41osK/rA15KPnTEk1GETSpS5E79cHK9JDLyMSHn
	iAKyc36TtgC6PACQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 18/30] printk: nbcon: Add helper to assign priority based on CPU state
Date: Mon, 27 May 2024 08:43:37 +0206
Message-Id: <20240527063749.391035-19-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper function to use the current state of the CPU to
determine which priority to assign to the printing context.

The EMERGENCY priority handling is added in a follow-up commit.
It will use a per-CPU variable.

Note: nbcon_device_try_acquire(), which is used by console
      drivers to acquire the nbcon console for non-printing
      activities, will always use NORMAL priority.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/nbcon.c    | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index e2de2d262db4..5826cd4eed58 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -84,6 +84,7 @@ void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con, u64 init_seq);
 void nbcon_free(struct console *con);
+enum nbcon_prio nbcon_get_default_prio(void);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -138,6 +139,7 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con, u64 init_seq) { }
 static inline void nbcon_free(struct console *con) { }
+static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 
 static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 5c75ba28e80c..85bebea1a326 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -937,6 +937,22 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	return nbcon_context_exit_unsafe(ctxt);
 }
 
+/**
+ * nbcon_get_default_prio - The appropriate nbcon priority to use for nbcon
+ *				printing on the current CPU
+ *
+ * Context:	Any context which could not be migrated to another CPU.
+ * Return:	The nbcon_prio to use for acquiring an nbcon console in this
+ *		context for printing.
+ */
+enum nbcon_prio nbcon_get_default_prio(void)
+{
+	if (this_cpu_in_panic())
+		return NBCON_PRIO_PANIC;
+
+	return NBCON_PRIO_NORMAL;
+}
+
 /**
  * nbcon_alloc - Allocate buffers needed by the nbcon console
  * @con:	Console to allocate buffers for
-- 
2.39.2


