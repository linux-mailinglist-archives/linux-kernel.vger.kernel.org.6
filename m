Return-Path: <linux-kernel+bounces-259249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55ED939324
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCCC11C215BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0881C171E4B;
	Mon, 22 Jul 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WN3UZcOi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eWrJEZT0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D5716F84F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668794; cv=none; b=tLQjZCxp0TcJtAGNvmsFYOMynX5zRiGF2q+PibwMw2tYhm2W55ptPED0ArD22pLdKX3DLcvlRENm4RSPN+mFpWbKRmJ+U77vfGgi+rhsSzA3ofUTUTqipXrOPR5GXwa6dGGwFaQ6sLtyZgspXukgE4w9GqBgwOkEhsC9TRfY/ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668794; c=relaxed/simple;
	bh=/untUGqgWj7u1xNK27SnwZK+1Wi7DgI+H3CTKmZxgh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZHrGX2T1Pc+0I7y1l9fMjfib3fxH20p7WwI/Gd7N11jkYazMwF4IX+VxHMyzqDyuVpUcx/q8G2C9jWnKyEUl+iSigu+Gq6V2rcVdE4qSXE+K+3qCaMxid3UwlHBThGDl6eougKucJS2PdJBQFIuvSgzBixFcfnTyn2DraCIHTeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WN3UZcOi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eWrJEZT0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGWVpENfq2/1/DjvkU8D8YMK8kxj1xPH74B4frVV15Y=;
	b=WN3UZcOiyjpvItIeqo+EjCIhJJdrCctRPeK6P2O36S4vedPq4ChV5iU8WsoQHO462W+G6F
	7jIkpviwYWMX/QHE3hCM7TTXy6n6dgHPn+z64ryAWnyTOhizrxH9CcCV3w5jWxof2kMCb8
	K+X9PlWVnzX+YVnjsFDitkEKwCchDvH14LBdjfIQ8eHB8AByj4uwQkC0dywXbmQF0afwJ3
	Y4xPS2LhSaimzlJs8LAywlelIVZE2eB93CD7Oi9WzjhA/iPAaUdUwVZ9GASuNx5hj5P2SH
	gbAr28YEecThufOoNRIZiDV57b5vLxnJ0J+IYuCXZ/2TXaMmDwk+//f5bdSRQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGWVpENfq2/1/DjvkU8D8YMK8kxj1xPH74B4frVV15Y=;
	b=eWrJEZT01j4DxfxnxWbDbbNBJSj1P2itrEaxcYwVHNCw3H8GHJB5fqHBDXQrt2DXyRbXQi
	XDy8yc/TkdWEy6Bg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v3 13/19] printk: nbcon: Show replay message on takeover
Date: Mon, 22 Jul 2024 19:25:33 +0206
Message-Id: <20240722171939.3349410-14-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
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
 include/linux/console.h  |  2 ++
 kernel/printk/internal.h |  1 +
 kernel/printk/nbcon.c    | 26 ++++++++++++++++++++++++++
 kernel/printk/printk.c   | 11 +++++++++++
 4 files changed, 40 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index b8fb9fb24cbf..fde565e127b6 100644
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
index 66321836c3fe..a4e7b40458b2 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -321,4 +321,5 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 
 #ifdef CONFIG_PRINTK
 void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped);
+void console_prepend_replay(struct printk_message *pmsg);
 #endif
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 8cf9e9e8c6e4..2a61f2c68ddc 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -938,7 +938,9 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 		.pbufs = ctxt->pbufs,
 	};
 	unsigned long con_dropped;
+	struct nbcon_state cur;
 	unsigned long dropped;
+	unsigned long ulseq;
 
 	/*
 	 * This function should never be called for consoles that have not
@@ -976,6 +978,29 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
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
 
@@ -1706,6 +1731,7 @@ bool nbcon_alloc(struct console *con)
 
 	rcuwait_init(&con->rcuwait);
 	init_irq_work(&con->irq_work, nbcon_irq_work);
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_prev_seq), -1UL);
 	nbcon_state_set(con, &state);
 
 	if (con->flags & CON_BOOT) {
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 89210a21cc50..6c9c0a42adf3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2849,6 +2849,17 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
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


