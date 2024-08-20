Return-Path: <linux-kernel+bounces-293344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA50957E31
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B164285972
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92541200127;
	Tue, 20 Aug 2024 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nKm8Gldk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nbVpZjzk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A3116C86D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135414; cv=none; b=oqFvaNFfHm24xexfPEMuIjDDMQQz421EiNqp/6uiiHY/YqIkTPzhuB3r9jEhuVa/AuffxlG+apkUojle7A1qdZCbY6uCuh0NtY4w5neHR2DtnXvLfFW0RFNt8n4GzGzDRa9d9UinlALQAgixtwBWOi5Ur616oFOB9LZJoS3Nak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135414; c=relaxed/simple;
	bh=/1fC2MDpEWd2pUlfHW4UNXW6hcss05zFf6RJFQQGxiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=owmp1f3Rvr4MDQW2sgslLB/+ic1Qd5kJvIUa9FPyHxh14SSuNsWYFp7Bmyv1+OcgBmemn8kecdTE52bU/kJAnhHR0x4r2DNhlKKFlf+lipAYvgU7VU5x0RhZgqjH+8bgot2Fopwzp0b/HblhJcyXXAZPQEwGZbkM26Xdd7+55zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nKm8Gldk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nbVpZjzk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OkGQHNfVXtcl0EJbdL5BCwdq4g/JjMGFkJn6O0f7o4c=;
	b=nKm8Gldk3llw6al4y1UMH6/scTnaw3KEEeq0+3K9Ee9er9GQbqKwmq6mVvdAzkV/jFKbRZ
	53DomcBhfOKJbY1L7RAXaWubNKo0SQ+ffrph07RVAu2+oJ6zh+jDv91TyQhkY1ODn/Dg75
	lU1yo4f6uFrcs/1o2p9OnmCyAGxDLnsCQ2bjyJwy2D61CM8yE1QaDteeUCB6/AC7uEer1D
	BG6vXwFub6FgAAR439fMa6VuLF8kCegPVzy168uWoem97mNrlNpGaKOLXbutJ4ZGAdgDv4
	ahiJDokR8gu2U8uCJg7rRfwNatpFCpIoVehMsxo/zMzpAdzlYIaFPsrBXVG3tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OkGQHNfVXtcl0EJbdL5BCwdq4g/JjMGFkJn6O0f7o4c=;
	b=nbVpZjzkpYWpF6tluNwC0AGYCd9do12lyxx16JQOeUhwOVfOex4vPdudXj9+JCuZGke+i7
	cNOP1JaM3j3WOQCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v8 19/35] printk: nbcon: Add helper to assign priority based on CPU state
Date: Tue, 20 Aug 2024 08:35:45 +0206
Message-Id: <20240820063001.36405-20-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
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
      activities, is hard-coded to always use NORMAL priority.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/nbcon.c    | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index fe8d84d78f1c..72f229382cfa 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -83,6 +83,7 @@ u64 nbcon_seq_read(struct console *con);
 void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
 void nbcon_free(struct console *con);
+enum nbcon_prio nbcon_get_default_prio(void);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -136,6 +137,7 @@ static inline u64 nbcon_seq_read(struct console *con) { return 0; }
 static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_free(struct console *con) { }
+static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 
 static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index e8ddcb6f7053..c6a9aa9f62f6 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -973,6 +973,25 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	return nbcon_context_exit_unsafe(ctxt);
 }
 
+/**
+ * nbcon_get_default_prio - The appropriate nbcon priority to use for nbcon
+ *				printing on the current CPU
+ *
+ * Context:	Any context.
+ * Return:	The nbcon_prio to use for acquiring an nbcon console in this
+ *		context for printing.
+ *
+ * The function is safe for reading per-CPU data in any context because
+ * preemption is disabled if the current CPU is in the panic state.
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
  * nbcon_alloc - Allocate and init the nbcon console specific data
  * @con:	Console to initialize
-- 
2.39.2


