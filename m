Return-Path: <linux-kernel+bounces-199830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D0D8FA673
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A206B282E82
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC98513E3ED;
	Mon,  3 Jun 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DHV8Zwi6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="unMpXQQf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF913D606
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457102; cv=none; b=sf7j+WkxXUX/c6I+PhNelzMV5V+BtFPkNl3Do3htRYapE3lghbyDYO46YzJFZI2zZmndRKpgsTdb0dZ+1KoL622PE51BkxQcbY/Ck97X4C+SxpQGrx5pcfz11C89XJZV8YqBkrEftCPIvfdstcudyPHDoKw4ndB3VEJ5kIcObWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457102; c=relaxed/simple;
	bh=zCdEe8+RH4XlG7eBx9a3rSWZHIqYz7vbbkZgHROBGK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cJv0baMvbPGlg7QNeWp1aIs+pambcAjZXS6UZSi8jTo9Ri2x3RHCC/bs3HTv0gUrwMf3KBIq0n+Q0ii/19k2dv5rTA+cXhR+H7F6bWwb/beJI9101Bo8kOlrboo6WeiQFEb8cpygWNN2dnS271N7u89xdV5ont9yTwY2d/tqv5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DHV8Zwi6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=unMpXQQf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSPbGXrcPCHiCR0e1KtRGjSW0V56pt20H3Bnio+pcfI=;
	b=DHV8Zwi6y4rTdb9NOOkhROyJ4R4g2iCWZHE83mUWDGdEAN87ebE3cnzLGhO8hHWJGrzl6K
	7mvj17Gu10Thx+hvdO4vkkam24FDvzYgnQm47mO+xKKzTQwf+/to7uYDTlHAFiSK8EqeLp
	8yWsPk4lCq/7nLlkHRoATl5G9mIyRyQRySKwngeYSqay+nF1YjNyWBm2FRV7KH/vwlstnc
	S3o3sIotQk+NhUZsZPKteTPlxX98GtTjxjOLLDMNaHTRbpo2eeJHwRQCu1bILU5W0nfWGb
	AeeWbSMxQTCpPco2KLF7OfRCIwM9Juqr9Eee7nq4HIAB0tPrJDTpXFWF0Z/8rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSPbGXrcPCHiCR0e1KtRGjSW0V56pt20H3Bnio+pcfI=;
	b=unMpXQQf6Rr8AddTHoAqNxnxTkclhT2pnume2VqwfVqUZTbKWj/ltvZQFRQek6vYXqTH7M
	TReXtirtTJ5bBRDw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 11/18] printk: nbcon: Show replay message on takeover
Date: Tue,  4 Jun 2024 01:30:46 +0206
Message-Id: <20240603232453.33992-12-john.ogness@linutronix.de>
In-Reply-To: <20240603232453.33992-1-john.ogness@linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
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
---
 include/linux/console.h  |  3 +++
 kernel/printk/internal.h |  1 +
 kernel/printk/nbcon.c    | 24 ++++++++++++++++++++++++
 kernel/printk/printk.c   | 19 +++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index adcc1a74aeee..9927f08ac054 100644
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
@@ -445,6 +446,8 @@ struct console {
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct nbcon_context	__private nbcon_device_ctxt;
+	atomic_long_t           __private nbcon_prev_seq;
+
 	struct printk_buffers	*pbufs;
 	struct task_struct	*kthread;
 	struct rcuwait		rcuwait;
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 5d4722310850..9e027e08918d 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -233,4 +233,5 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 
 #ifdef CONFIG_PRINTK
 void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped);
+void console_prepend_replay(struct printk_message *pmsg);
 #endif
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 480a0ced2708..8c92b076c745 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -866,6 +866,7 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	unsigned long con_dropped;
 	struct nbcon_state cur;
 	unsigned long dropped;
+	unsigned long ulseq;
 
 	/*
 	 * The printk buffers are filled within an unsafe section. This
@@ -891,6 +892,28 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
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
+		 * not be from the previous owner.
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
 
@@ -1631,6 +1654,7 @@ void nbcon_init(struct console *con, u64 init_seq)
 	rcuwait_init(&con->rcuwait);
 	init_irq_work(&con->irq_work, nbcon_irq_work);
 	nbcon_seq_force(con, init_seq);
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_prev_seq), -1UL);
 	nbcon_state_set(con, &state);
 	nbcon_kthread_create(con);
 }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fcbf794a0aaf..cf0d612329bf 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2867,6 +2867,25 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 	__console_prepend_scratch(pmsg, len);
 }
 
+/*
+ * Prepend the message in @pmsg->pbufs->outbuf with a "replay message".
+ * @pmsg->outbuf_len is updated appropriately.
+ *
+ * @pmsg is the printk message to prepend.
+ */
+void console_prepend_replay(struct printk_message *pmsg)
+{
+	struct printk_buffers *pbufs = pmsg->pbufs;
+	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
+	char *scratchbuf = &pbufs->scratchbuf[0];
+	size_t len;
+
+	len = scnprintf(scratchbuf, scratchbuf_sz,
+			"** replaying previous printk message **\n");
+
+	__console_prepend_scratch(pmsg, len);
+}
+
 /*
  * Read and format the specified record (or a later record if the specified
  * record is not available).
-- 
2.39.2


