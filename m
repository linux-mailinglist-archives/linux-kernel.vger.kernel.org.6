Return-Path: <linux-kernel+bounces-273633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B60946BA3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9801F21C88
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4D723741;
	Sun,  4 Aug 2024 00:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o2knPv2O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jwGce3Bp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F55101E2
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732714; cv=none; b=ZNExkmwzP39qHrHGkZrdn/fiT9UBgPpY+o5LEskFx+G8yrkPDV2XJzRSJ3ht85pRQroidQfCCeN4YwiT42+DLlrIOya9Bs3GIonAQwlvJSj5y5Za3B2MAbvDTHl1TCBIAmlLqgBxvNrOCfssVxZNwwZFkzSlyywc6j0CBl5Bbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732714; c=relaxed/simple;
	bh=xskXJgvQkL9boiz0qHQhuIq5j2Sph2J69H53TzZn0Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PjvI1QQGRMeyoHqyNoTW1OmrZy2JV/dzz54xEtNg+NTIM+LkUg99UrPYDODDFo2GgK/xNEZQVAA3yD9ZwifCQyrV9XZwHOqIlnl53JTs66hz61C/KiKy23mJpoPfWdqPudMobBCesS6R0XFBUyUL6Zf0YtF00IFpFlRPU16xqws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o2knPv2O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jwGce3Bp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwbQtuej4PvTHWMkC5NdE4fWdsHI6OVBAXHJhUAhxgw=;
	b=o2knPv2ODupxt0w6IPv+C41rDoRXAO3+WRgx/cnXiSuk+cELO9IQDSdechtQtxwPpczxUQ
	r2dVkD9E6+IDMMronxrNkLFtpvmUiaiTbx8KlkA7S7x69dJgnnuMPjt62kI5MfNBJt+geO
	Nyc8BXAHDLhNi+kasfYaM9+5AbxoYNqfqGOmbbmzb49dbhJDSPe7aoklCPQaKvQi7fvVTe
	ZXQDJVSK2NUX3yaxOlOKILtg2fIAS2BYwI+JGPyICO3P2Z3luy4HJ11nyiJwlLZc/1NNvF
	7Vptc18LL10mrPaxZPQ2xbZKOSLqrPHICLlr3bZPI1hcm+eXasdTsEBphVQVxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwbQtuej4PvTHWMkC5NdE4fWdsHI6OVBAXHJhUAhxgw=;
	b=jwGce3BpNzv/1rm5BzNr9zVaV66kAqtGXYZR346KRHP11dTKIblZbbGSUjMgg1Yj2C1WRD
	9cy2ehZwi/w05kCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v7 12/35] console: Improve console_srcu_read_flags() comments
Date: Sun,  4 Aug 2024 02:57:15 +0206
Message-Id: <20240804005138.3722656-13-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was not clear when exactly console_srcu_read_flags() must be
used vs. directly reading @console->flags.

Refactor and clarify that console_srcu_read_flags() is only
needed if the console is registered or the caller is in a
context where the registration status of the console may change
(due to another context).

The function requires the caller holds @console_srcu, which will
ensure that the caller sees an appropriate @flags value for the
registered console and that exit/cleanup routines will not run
if the console is in the process of unregistration.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 46b3c210b931..aafe3121b74e 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -446,28 +446,34 @@ extern void console_list_unlock(void) __releases(console_mutex);
 extern struct hlist_head console_list;
 
 /**
- * console_srcu_read_flags - Locklessly read the console flags
+ * console_srcu_read_flags - Locklessly read flags of a possibly registered
+ *				console
  * @con:	struct console pointer of console to read flags from
  *
- * This function provides the necessary READ_ONCE() and data_race()
- * notation for locklessly reading the console flags. The READ_ONCE()
- * in this function matches the WRITE_ONCE() when @flags are modified
- * for registered consoles with console_srcu_write_flags().
+ * Locklessly reading @con->flags provides a consistent read value because
+ * there is at most one CPU modifying @con->flags and that CPU is using only
+ * read-modify-write operations to do so.
  *
- * Only use this function to read console flags when locklessly
- * iterating the console list via srcu.
+ * Requires console_srcu_read_lock to be held, which implies that @con might
+ * be a registered console. The purpose of holding console_srcu_read_lock is
+ * to guarantee that the console state is valid (CON_SUSPENDED/CON_ENABLED)
+ * and that no exit/cleanup routines will run if the console is currently
+ * undergoing unregistration.
+ *
+ * If the caller is holding the console_list_lock or it is _certain_ that
+ * @con is not and will not become registered, the caller may read
+ * @con->flags directly instead.
  *
  * Context: Any context.
+ * Return: The current value of the @con->flags field.
  */
 static inline short console_srcu_read_flags(const struct console *con)
 {
 	WARN_ON_ONCE(!console_srcu_read_lock_is_held());
 
 	/*
-	 * Locklessly reading console->flags provides a consistent
-	 * read value because there is at most one CPU modifying
-	 * console->flags and that CPU is using only read-modify-write
-	 * operations to do so.
+	 * The READ_ONCE() matches the WRITE_ONCE() when @flags are modified
+	 * for registered consoles with console_srcu_write_flags().
 	 */
 	return data_race(READ_ONCE(con->flags));
 }
-- 
2.39.2


