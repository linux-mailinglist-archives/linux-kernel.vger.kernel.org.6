Return-Path: <linux-kernel+bounces-309039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C895296657B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F631C22EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB1D1BA269;
	Fri, 30 Aug 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kMCW+jqk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m1FVKtSJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12001B5EB4
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031769; cv=none; b=LWUR1sD0WfVdlRc1FBBtXl7d9lyfOMmxCVBf8iyjCMUgQiaS1sxjs5SkQSBetc0y+woU/FjdiAMGVRRjB4N2dl/s2lSj02HAspznOghbvGxK5+h64ua8g3UNq/SS76RI/jjQiyBeb3Ort6NCFHouSZQ/gTjge0gfHP4fIGrfIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031769; c=relaxed/simple;
	bh=uxefz0lFBZn8bfR+v64SgJv36gK2bXfpv4eZUpX70h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fRUszXQo/BjNN2wK1FzcBTNToTMobOKAYAGGeFiDjM4vO+u+qUtgTsw9UEnGr8WJe5vE1hZ+KNHu8y8065QXnQKAp3PUtdbj+WPFm9ZAw8cvwAVYuU3/h+DIGEaBXqNGXcv88TAi/a4NgGgxym9EBrKu7qORw3kDaKQyjMN5nsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kMCW+jqk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m1FVKtSJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725031760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aar3kyXyxhY3P8EcLLnuSG7SHnPmwjk2CsjtEu1FQHs=;
	b=kMCW+jqk+Bfu7HGOjkapur36cVg7OB24kdbkJyOSAwPuNQqYKBTZHP9t40T5yGZZR2qLr4
	oTv+k+Euw+5aZUjQJiKz2QoXIcplxaT63BoCb7C1D4fyEnIrljRAgaAcDADJNvdudcSezy
	6hss659Xd/eW4xnUDx4o6JiNP0fP/XvD/WWDGuP0Ch1+/QIURSpkNz4AlqnRrLx+KQnZp2
	pdZoG6SF6nki5EfHnCo6+SO1xoKMeDtOj54p8xvKmfNKMMMsxDpGL7XZxmK3+INQnhSjmp
	LGLSefp5c+7X81ZKNb5YH1CGHGyGy7ipLWBt0TLcNNgc3zZL+6aHmVsOX+wQDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725031760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aar3kyXyxhY3P8EcLLnuSG7SHnPmwjk2CsjtEu1FQHs=;
	b=m1FVKtSJ3LhJrdxBrxa2ksM+7pUlpqxyrQMIJKTMRkRl5LoHC7yyV4KrKKS/ss+TQJpFC8
	c3plcFpycAoMdMCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 10/17] printk: Provide helper for message prepending
Date: Fri, 30 Aug 2024 17:35:09 +0206
Message-Id: <20240830152916.10136-11-john.ogness@linutronix.de>
In-Reply-To: <20240830152916.10136-1-john.ogness@linutronix.de>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
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
index b9378636188e..ca1dcf892891 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2843,30 +2843,31 @@ static void __console_unlock(void)
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
@@ -2888,6 +2889,19 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
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


