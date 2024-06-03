Return-Path: <linux-kernel+bounces-199827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 499C38FA66F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3A21C21C3A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F5D13DDBD;
	Mon,  3 Jun 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WbDpZ1qA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r52PlJP0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1A13D501
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457101; cv=none; b=JJufhVEYEs3/nu8wO+EhDRmfHkVmM6ZdJat2+dCDCR4rtPHotb66zpuYHM27Pi3cxXXz8bIzlhOeJOtg5aqGpAJenKQvadII29Zgj9uEQScwWnvVsldHavPRqbVJrhhApGyVSnWX1Pw5QZf1Tn4c+lYw94GK5rdef6rzRJcGxz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457101; c=relaxed/simple;
	bh=/DV2OcitrYBM0e5R61yRVkhYgmop2W7tbmLqenGV6WE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZgrpQ1Yx7E+KG5F31lyEWcDp1NB0jL1oKbw3VGlDXXFACiW2hqWNnAK/6jrpLe/8uZhvdu1vb/e5aYziB5tBG2Fy1aGeg4eX62MmTD+DApsFBt4cQXGy2kpicLI/hXeNrSGr5jBEGWtntKW+9dpCaXAMcIXQQt9JVsWXD8P6ZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WbDpZ1qA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r52PlJP0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zsvdhza0eQIM2Wg3mYfbF9S4P/mMid6egaOJ9nhJBnY=;
	b=WbDpZ1qArIfYi2docYTDqgesViQic8j5CxcXpac0H4zE86JmZpdGGdWUFtI1GjmHftOyVQ
	5aTrtZiw0abPIeDEoNvSqRg21Xt+YP7M4jEduoBJgxpRwgy9rvMFJuwJTIFhXvBmad3CCA
	PPF30IDYXWI84u5DuLbj2Fi64MD/qnfv3nmRX6Vqh4Id3TsVWW40i+lBIQyPhGD9hc94LX
	RMEciHUj46XidYAi2FlCvELJu/YtxErqQ8TeU4JOx+dGHyHh6ZMYIHsC6Ql0okT3xQ+VOZ
	WzBqQMLdq7bGZKZB/+CkDc5DpesvyM6DO6al7lQd5LAHqp20imeEyzD7EGHNUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zsvdhza0eQIM2Wg3mYfbF9S4P/mMid6egaOJ9nhJBnY=;
	b=r52PlJP0sUKoBwwZZG0HKbQvFRtETwvyZ812y+kkrdVqZZBAST3YtRLiLvPJcaNv0kIVQW
	p9yJlxDsJ/DLpACA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 06/18] printk: nbcon: Add context to console_is_usable()
Date: Tue,  4 Jun 2024 01:30:41 +0206
Message-Id: <20240603232453.33992-7-john.ogness@linutronix.de>
In-Reply-To: <20240603232453.33992-1-john.ogness@linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nbcon consoles have two callbacks to be used for different
contexts. In order to determine if an nbcon console is usable,
console_is_usable() needs to know if it is a context that will
use the write_atomic() callback or the write_thread() callback.

Add an extra parameter @use_atomic to specify this.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h | 16 ++++++++++------
 kernel/printk/nbcon.c    |  8 ++++----
 kernel/printk/printk.c   |  6 ++++--
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 38680c6b2b39..243d3d3bc889 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -100,7 +100,7 @@ void nbcon_kthread_create(struct console *con);
  * which can also play a role in deciding if @con can be used to print
  * records.
  */
-static inline bool console_is_usable(struct console *con, short flags)
+static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
 {
 	if (!(flags & CON_ENABLED))
 		return false;
@@ -109,10 +109,13 @@ static inline bool console_is_usable(struct console *con, short flags)
 		return false;
 
 	if (flags & CON_NBCON) {
-		if (!con->write_atomic)
-			return false;
-		if (!con->write_thread)
-			return false;
+		if (use_atomic) {
+			if (!con->write_atomic)
+				return false;
+		} else {
+			if (!con->write_thread)
+				return false;
+		}
 	} else {
 		if (!con->write)
 			return false;
@@ -177,7 +180,8 @@ static inline void nbcon_atomic_flush_pending(void) { }
 static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 						 int cookie) { return false; }
 
-static inline bool console_is_usable(struct console *con, short flags) { return false; }
+static inline bool console_is_usable(struct console *con, short flags,
+				     bool use_atomic) { return false; }
 
 #endif /* CONFIG_PRINTK */
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 19f0db6945e4..4200953d368e 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -967,7 +967,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
 	cookie = console_srcu_read_lock();
 
 	flags = console_srcu_read_flags(con);
-	if (console_is_usable(con, flags)) {
+	if (console_is_usable(con, flags, false)) {
 		/* Bring the sequence in @ctxt up to date */
 		ctxt->seq = nbcon_seq_read(con);
 
@@ -1026,7 +1026,7 @@ static int nbcon_kthread_func(void *__console)
 
 		con_flags = console_srcu_read_flags(con);
 
-		if (console_is_usable(con, con_flags)) {
+		if (console_is_usable(con, con_flags, false)) {
 			unsigned long lock_flags;
 
 			con->device_lock(con, &lock_flags);
@@ -1322,7 +1322,7 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeove
 		if (!(flags & CON_NBCON))
 			continue;
 
-		if (!console_is_usable(con, flags))
+		if (!console_is_usable(con, flags, true))
 			continue;
 
 		if (nbcon_seq_read(con) >= stop_seq)
@@ -1639,7 +1639,7 @@ void nbcon_device_release(struct console *con)
 	 * the console is usable throughout flushing.
 	 */
 	cookie = console_srcu_read_lock();
-	if (console_is_usable(con, console_srcu_read_flags(con)) &&
+	if (console_is_usable(con, console_srcu_read_flags(con), true) &&
 	    (!con->kthread || (system_state > SYSTEM_RUNNING)) &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b58db15d2033..a2c4fe3d21cc 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3043,7 +3043,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			if ((flags & CON_NBCON) && con->kthread)
 				continue;
 
-			if (!console_is_usable(con, flags))
+			if (!console_is_usable(con, flags, true))
 				continue;
 			any_usable = true;
 
@@ -4018,8 +4018,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c, flags))
+			if (!console_is_usable(c, flags, true) &&
+			    !console_is_usable(c, flags, false)) {
 				continue;
+			}
 
 			if (flags & CON_NBCON) {
 				printk_seq = nbcon_seq_read(c);
-- 
2.39.2


