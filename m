Return-Path: <linux-kernel+bounces-273640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3196946BAB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DFB282419
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC95F5588E;
	Sun,  4 Aug 2024 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TJVPaMNJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f1n8X4EU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8421BF2A
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732716; cv=none; b=QYg7Ba31SFtLbypnA6IRFnW/JCCnTUqh7I5JMybvtfB+GyQUkIxdpt8t7PFSq6Uxhxky66Q+ziLFCSmS5arlJ7UDb1BVzKt5BPBuCae94UkrCcHCpebfndl15FKqk8HGmPdzSDJvCDrGnPJTT51F5B3Gi75PeEUisY3Co/nv+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732716; c=relaxed/simple;
	bh=/1fC2MDpEWd2pUlfHW4UNXW6hcss05zFf6RJFQQGxiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iN8tEoQ+1+t8VIGWBsYNxPpoPUDA7Pm5kj/J6jZvSun3YbN3QM7lMe3tW/CfhY3M8XKmV6+YIusWxG31kRJ+E+9L/Xt+ng6kY90pEkvVAc+4QuOrGP1SItQB5iWjfeO7nPfvlnG3h1Ri5Upy/odLImmNa6YD+79wF6FasRkiw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TJVPaMNJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f1n8X4EU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OkGQHNfVXtcl0EJbdL5BCwdq4g/JjMGFkJn6O0f7o4c=;
	b=TJVPaMNJUoJxX2T/0izhLxy8bPAGhq8R9ezabK4YOoVhCAD2wuIZa6H7atkCGOrpYh4Wud
	pwpdu9xRpAL2AXTmpByfHzplPX4NN8gqjqVmFVIu2QX2csQvSWiQThRaaRHc1L/6G5e3V8
	S7KGt/F3UfUfMj36X5noQFJNYABr+r7l8I2vOKI009PTGUmuPLRdW1FHdPHigEmM4elmEQ
	3Cq5zTIOG4XUVEY5VK/M7bh2BQQnKJC0PFLraXV8hNL082hlxNZOBohGWlgs0WCIHZu+CP
	gqvcw69jveCFXLQ9MS1jxOPIQUqePyZYwEUg+30dsSHUez3OUBOnXMH3PuHmEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OkGQHNfVXtcl0EJbdL5BCwdq4g/JjMGFkJn6O0f7o4c=;
	b=f1n8X4EUp1Wv7eLUxNi2izc8ciX973txB3U7B4XLIBymk0H8vpTytJviy0iQoSk5MYzwMq
	/efLTJEU6njgXAAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v7 19/35] printk: nbcon: Add helper to assign priority based on CPU state
Date: Sun,  4 Aug 2024 02:57:22 +0206
Message-Id: <20240804005138.3722656-20-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
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


