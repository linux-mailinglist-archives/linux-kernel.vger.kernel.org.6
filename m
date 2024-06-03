Return-Path: <linux-kernel+bounces-199836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA1B8FA67C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D4628ADD9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC601411E1;
	Mon,  3 Jun 2024 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e6gwfjl+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="04ih2jog"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8F13DBAC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457104; cv=none; b=M3d6sNYhssDJhCKCyyYu9pnZj3pq92MzJi4/js5IOeY7Fy066S0028ocIlZUeu/SwP37ErGzSFW0TllfiwqBMBOI3JQAcdhd42QnMJrfOSJkouGTGDftU89hwouoibdPEXjq5x1Qth/zepE9ItcO2iIpw+kFBbRcAT8urOcGeLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457104; c=relaxed/simple;
	bh=C1k4nrK1iq4FjzW78Pvi6zuZX9GDxOVMSJk36U/8Zes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sQCl2LA+nMgqpkez5THlqYpX3od8X6WhYctCZJvZOVYa3yeZQ5SNeSkHP3c64lXbuNBnizQ6uFFIMJ0upzSMqfqslWnCRKOgJkP901Vqa5B43Msfi61u2x7mGQ6SdIQQsglEubU6ed6CIbr3XuTYjpqDj9HaUpeVBVkA6kK6+Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e6gwfjl+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=04ih2jog; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/pSuGQVGxMFZfKH/E+GtrVGnqXqVv7X9AWkemvHQKk=;
	b=e6gwfjl+AQxvQFqUY15qKWXJbRzYRogpvkE20qtFNxeIszR4xKA60jCPoR9oiHgrC8cOUt
	QDXuBFpnGB1rDlUTJw4puKC91/e7K23Xj6xydqwUrrvPQORuH2fXKkDt1haI4qRDmrv2LX
	LO/DlWu6DRIj0Gsji9yuLQaDI2fgVLc014e96NwSZjdlSXC6ymt/LxxEJ7be0PbTFHIVWf
	gDhj97MB7KMi5ohN8q7PeWa/a4ACAFXXgAiyywpI0rPNBvC7TmtbnOlGgSBbh4jcdv7lvv
	TsmqIeH3sQ4zNY1KYAOVO4QxIpa2DzyiqMzTPWSey58iGyA86dZpuK3yj/uQiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/pSuGQVGxMFZfKH/E+GtrVGnqXqVv7X9AWkemvHQKk=;
	b=04ih2jogpo2jd8gP+ByGzyWb1xIsroVU3p4E9ly6g5W4Da1VRPWgacUZAqjkYvro6Xc7Jb
	ryDTTLpnoEn4F6CA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 17/18] printk: Avoid false positive lockdep report for legacy printing
Date: Tue,  4 Jun 2024 01:30:52 +0206
Message-Id: <20240603232453.33992-18-john.ogness@linutronix.de>
In-Reply-To: <20240603232453.33992-1-john.ogness@linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Legacy console printing from printk() caller context may invoke
the console driver from atomic context. This leads to a lockdep
splat because the console driver will acquire a sleeping lock
and the caller may already hold a spinning lock. This is noticed
by lockdep on !PREEMPT_RT configurations because it will lead to
a problem on PREEMPT_RT.

However, on PREEMPT_RT the printing path from atomic context is
always avoided and the console driver is always invoked from a
dedicated thread. Thus the lockdep splat on !PREEMPT_RT is a
false positive.

For !PREEMPT_RT override the lock-context before invoking the
console driver to avoid the false positive.

Do not override the lock-context for PREEMPT_RT in order to
allow lockdep to catch any real locking context issues related
to the write callback usage.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ea2d66152256..5e9778f69206 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2980,6 +2980,33 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	return true;
 }
 
+/*
+ * Legacy console printing from printk() caller context does not respect
+ * raw_spinlock/spinlock nesting. For !PREEMPT_RT the lockdep warning is a
+ * false positive. For PREEMPT_RT the false positive condition does not
+ * occur.
+ *
+ * This map is used to establish LD_WAIT_SLEEP context for the console write
+ * callbacks when legacy printing to avoid false positive lockdep complaints,
+ * thus allowing lockdep to continue to function for real issues.
+ */
+#ifdef CONFIG_PREEMPT_RT
+static inline void printk_legacy_lock_map_acquire_try(void) { }
+static inline void printk_legacy_lock_map_release(void) { }
+#else
+static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
+
+static inline void printk_legacy_lock_map_acquire_try(void)
+{
+	lock_map_acquire_try(&printk_legacy_map);
+}
+
+static inline void printk_legacy_lock_map_release(void)
+{
+	lock_map_release(&printk_legacy_map);
+}
+#endif /* CONFIG_PREEMPT_RT */
+
 /*
  * Used as the printk buffers for non-panic, serialized console printing.
  * This is for legacy (!CON_NBCON) as well as all boot (CON_BOOT) consoles.
@@ -3035,7 +3062,7 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 		/*
 		 * With forced threading this function is either in a thread
 		 * or panic context. So there is no need for concern about
-		 * printk reentrance or handovers.
+		 * printk reentrance, handovers, or lockdep complaints.
 		 */
 
 		con->write(con, outbuf, pmsg.outbuf_len);
@@ -3057,7 +3084,9 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 		/* Do not trace print latency. */
 		stop_critical_timings();
 
+		printk_legacy_lock_map_acquire_try();
 		con->write(con, outbuf, pmsg.outbuf_len);
+		printk_legacy_lock_map_release();
 
 		start_critical_timings();
 
-- 
2.39.2


