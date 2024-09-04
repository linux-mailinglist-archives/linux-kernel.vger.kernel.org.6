Return-Path: <linux-kernel+bounces-314968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2141196BB9E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C209628936C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14C61D9D66;
	Wed,  4 Sep 2024 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3iDicJC7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GnFHscM1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E101D86F4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451545; cv=none; b=ubXI53L8NSO9QEOxo975iRiXdcET/TdK8ZYrDadh7C7SSIdsxPJLYhLBeVOKXbup++lK+7hS/5NkZ7OM56ZDuR088js9aDkWK/t/awqiejZKxQgBoAz7/6vAazSYQ92zEjhMZJzRMz/JKMbw5bZmcmBrsZT2PmRWN/+9NAGcFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451545; c=relaxed/simple;
	bh=82ik+XLx/Or5X3RxvmWUFKEhDguV02jZbyTUBBE8YY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r3nu3LOUoQZP2pKRgerijfFOAdqXvfM07nNnFbwk/0Hc+bFuTCFA9jN7xUZOtuRpDAnNnQajE5ZhXB7Jsyo5Qj41ZRf3U3tbQOdH5CUjfcDpDWv4gFT7+dN/0uCWmlWbfWNDLnBbW6W57r4mKJTTQS+WftWymr39k2dkHXnFA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3iDicJC7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GnFHscM1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725451540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70IPAMHo8eYvIEmGzPpiT7Dq6uz2bFoVqF5ySYgyHWQ=;
	b=3iDicJC7E5eN8BH/qJYako2HydND2/hx3pZcRf8SLIcTSxo+GYcqWmL99T/uudNoritCVc
	PuKEbtd3pl6F/ghErj4q2EYRPw3k9VxQLb06jJd9OKpHmUiebkMs3f4nxguLmW0ptcnQSw
	daDOo0FMZQFHPS68Eo1Zl0yvMXZKDuFZxcBMnlyISLx6PbJSCp45I8ikC54OXptbt7gwn3
	0NiyhdGmvcW/SB2Eox0MomugrxdFLk2RZrH4thAQRKzdvPuYdT08Str8MoQa0Fl4+ONrCJ
	RlkLqD1RAQLMyO++au2XW6YWmFFzaJpQJYz/enbtPMNqLZzK9cnowx8eiI8TIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725451540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70IPAMHo8eYvIEmGzPpiT7Dq6uz2bFoVqF5ySYgyHWQ=;
	b=GnFHscM1C3vhu8coEZFJHk5cBv3gKOVZvrC6hnuWTQdridZDG7lSHNhY44jzwFgdiOwWqM
	NhK3+K7T9uuamFDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v6 11/17] printk: nbcon: Show replay message on takeover
Date: Wed,  4 Sep 2024 14:11:30 +0206
Message-Id: <20240904120536.115780-12-john.ogness@linutronix.de>
In-Reply-To: <20240904120536.115780-1-john.ogness@linutronix.de>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An emergency or panic context can takeover console ownership
while the current owner was printing a printk message. The
atomic printer will re-print the message that the previous
owner was printing. However, this can look confusing to the
user and may even seem as though a message was lost.

  [3430014.1
  [3430014.181123] usb 1-2: Product: USB Audio

Add a new field @nbcon_prev_seq to struct console to track
the sequence number to print that was assigned to the previous
console owner. If this matches the sequence number to print
that the current owner is assigned, then a takeover must have
occurred. In this case, print an additional message to inform
the user that the previous message is being printed again.

  [3430014.1
  ** replaying previous printk message **
  [3430014.181123] usb 1-2: Product: USB Audio

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h  |  2 ++
 kernel/printk/internal.h |  1 +
 kernel/printk/nbcon.c    | 26 ++++++++++++++++++++++++++
 kernel/printk/printk.c   | 11 +++++++++++
 4 files changed, 40 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 788ce9c829f6..eba367bf605d 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -325,6 +325,7 @@ struct nbcon_write_context {
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @nbcon_device_ctxt:	Context available for non-printing operations
+ * @nbcon_prev_seq:	Seq num the previous nbcon owner was assigned to print
  * @pbufs:		Pointer to nbcon private buffer
  * @kthread:		Printer kthread for this console
  * @rcuwait:		RCU-safe wait object for @kthread waking
@@ -459,6 +460,7 @@ struct console {
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct nbcon_context	__private nbcon_device_ctxt;
+	atomic_long_t           __private nbcon_prev_seq;
 
 	struct printk_buffers	*pbufs;
 	struct task_struct	*kthread;
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 8166e24f8780..c365d25b13c7 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -319,4 +319,5 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 
 #ifdef CONFIG_PRINTK
 void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped);
+void console_prepend_replay(struct printk_message *pmsg);
 #endif
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 5146ce9853a3..98440889d222 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -946,7 +946,9 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 		.pbufs = ctxt->pbufs,
 	};
 	unsigned long con_dropped;
+	struct nbcon_state cur;
 	unsigned long dropped;
+	unsigned long ulseq;
 
 	/*
 	 * This function should never be called for consoles that have not
@@ -987,6 +989,29 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	if (dropped && !is_extended)
 		console_prepend_dropped(&pmsg, dropped);
 
+	/*
+	 * If the previous owner was assigned the same record, this context
+	 * has taken over ownership and is replaying the record. Prepend a
+	 * message to let the user know the record is replayed.
+	 */
+	ulseq = atomic_long_read(&ACCESS_PRIVATE(con, nbcon_prev_seq));
+	if (__ulseq_to_u64seq(prb, ulseq) == pmsg.seq) {
+		console_prepend_replay(&pmsg);
+	} else {
+		/*
+		 * Ensure this context is still the owner before trying to
+		 * update @nbcon_prev_seq. Otherwise the value in @ulseq may
+		 * not be from the previous owner and instead be some later
+		 * value from the context that took over ownership.
+		 */
+		nbcon_state_read(con, &cur);
+		if (!nbcon_context_can_proceed(ctxt, &cur))
+			return false;
+
+		atomic_long_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_prev_seq), &ulseq,
+					__u64seq_to_ulseq(pmsg.seq));
+	}
+
 	if (!nbcon_context_exit_unsafe(ctxt))
 		return false;
 
@@ -1646,6 +1671,7 @@ bool nbcon_alloc(struct console *con)
 
 	rcuwait_init(&con->rcuwait);
 	init_irq_work(&con->irq_work, nbcon_irq_work);
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_prev_seq), -1UL);
 	nbcon_state_set(con, &state);
 
 	/*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e9458569bcfd..c27dc54f4151 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2902,6 +2902,17 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 	console_prepend_message(pmsg, "** %lu printk messages dropped **\n", dropped);
 }
 
+/*
+ * Prepend the message in @pmsg->pbufs->outbuf with a "replay message".
+ * @pmsg->outbuf_len is updated appropriately.
+ *
+ * @pmsg is the printk message to prepend.
+ */
+void console_prepend_replay(struct printk_message *pmsg)
+{
+	console_prepend_message(pmsg, "** replaying previous printk message **\n");
+}
+
 /*
  * Read and format the specified record (or a later record if the specified
  * record is not available).
-- 
2.39.2


