Return-Path: <linux-kernel+bounces-259254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA44939326
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFEE1F225C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5FD172BAE;
	Mon, 22 Jul 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="flsDpmlf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ecCKxN+K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0EA16F83A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668795; cv=none; b=f88tJqtNuz61sERaCzS0HaMoFeSGvHPood07bMi+lcgXtwr29Ryxloj8RCLhwuLuBjg+3dQbgM49ZuThjn15fNU5L2ZZv79sUlLweXly/2jtrjguSdAwTJONjm8RVP0wViIPmNlr74WlGhUlL9yuAPT4JRBvvp4Gei2kJ7WEta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668795; c=relaxed/simple;
	bh=8CT2LEVHc07jzisDnWd0LQOE1K28cGvDJ6CINR5Lmmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dc/EW7hq1PVm1IKqHq/T+9ApJMXJR6odgNWD6PlKLM+jmaa+b7KmcRg1raP4mm1NFpPH4PzAOZshAfwQ5MoxxFLPvesQQgzo4JtjlFG3q6dgEgxseA0nGOy5dEElGRuhMoBMBIDLDS6nU+WWt113lj5thler5ZhNcD3uJk7M6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=flsDpmlf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ecCKxN+K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ol3S252804F7HDMU9xAB5UfdY7U+NwrMoiN/KMkNHk=;
	b=flsDpmlfbYyOVKvPp+jSsRaSGXeb8JVnERs8jrhHd/Hv/qfp4PUxZCBXhiUtbsZHimpJVI
	a60p09yZyOg1/qadd0MdbEtzW1QRSop2l18d6f8KfosvdkYx5acej2Soj3z26hGQwApmeg
	JRq+HsIuO02atJOqRWX1IeyLGRo21ory/LLC7TyOSumznH3O25CrtV4WGwJbRtU3TWumbB
	/T+b6QND/NfSo1aPFaz/VkNwTHpdWI6tv7BdmgCrV5+n59LgKKmrcrvHi1iooUyC5SRlYn
	SGi3pR2JTbS3qx1/mu4kgfwM2An7XHdwyljDaxuRNhFLzgnlO2FYzKS4RhYBmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Ol3S252804F7HDMU9xAB5UfdY7U+NwrMoiN/KMkNHk=;
	b=ecCKxN+KOVDUf9haQVJtJYsBuAGcc10iHlzpeHcEQArS3GHT4UpxHffSjzUK+Vkd83elMU
	9sgBPZBftRxmadDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 12/19] printk: Provide helper for message prepending
Date: Mon, 22 Jul 2024 19:25:32 +0206
Message-Id: <20240722171939.3349410-13-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support prepending different texts to printk
messages, split out the prepending code into a helper
function.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 620c02b069bc..89210a21cc50 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2790,30 +2790,31 @@ static void __console_unlock(void)
 #ifdef CONFIG_PRINTK
 
 /*
- * Prepend the message in @pmsg->pbufs->outbuf with a "dropped message". This
- * is achieved by shifting the existing message over and inserting the dropped
- * message.
+ * Prepend the message in @pmsg->pbufs->outbuf. This is achieved by shifting
+ * the existing message over and inserting the scratchbuf message.
  *
- * @pmsg is the printk message to prepend.
- *
- * @dropped is the dropped count to report in the dropped message.
+ * @pmsg is the original printk message.
+ * @fmt is the printf format of the message which will prepend the existing one.
  *
- * If the message text in @pmsg->pbufs->outbuf does not have enough space for
- * the dropped message, the message text will be sufficiently truncated.
+ * If there is not enough space in @pmsg->pbufs->outbuf, the existing
+ * message text will be sufficiently truncated.
  *
  * If @pmsg->pbufs->outbuf is modified, @pmsg->outbuf_len is updated.
  */
-void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
+__printf(2, 3)
+static void console_prepend_message(struct printk_message *pmsg, const char *fmt, ...)
 {
 	struct printk_buffers *pbufs = pmsg->pbufs;
 	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
 	const size_t outbuf_sz = sizeof(pbufs->outbuf);
 	char *scratchbuf = &pbufs->scratchbuf[0];
 	char *outbuf = &pbufs->outbuf[0];
+	va_list args;
 	size_t len;
 
-	len = scnprintf(scratchbuf, scratchbuf_sz,
-		       "** %lu printk messages dropped **\n", dropped);
+	va_start(args, fmt);
+	len = vscnprintf(scratchbuf, scratchbuf_sz, fmt, args);
+	va_end(args);
 
 	/*
 	 * Make sure outbuf is sufficiently large before prepending.
@@ -2835,6 +2836,19 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 	pmsg->outbuf_len += len;
 }
 
+/*
+ * Prepend the message in @pmsg->pbufs->outbuf with a "dropped message".
+ * @pmsg->outbuf_len is updated appropriately.
+ *
+ * @pmsg is the printk message to prepend.
+ *
+ * @dropped is the dropped count to report in the dropped message.
+ */
+void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
+{
+	console_prepend_message(pmsg, "** %lu printk messages dropped **\n", dropped);
+}
+
 /*
  * Read and format the specified record (or a later record if the specified
  * record is not available).
-- 
2.39.2


