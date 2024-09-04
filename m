Return-Path: <linux-kernel+bounces-314973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D2D96BBA2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5C9289946
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7441DA0F5;
	Wed,  4 Sep 2024 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BultgAMM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pXTNSqSa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088B1D86CF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451545; cv=none; b=O6GrJ9JknICNOwQOMReK53Et5qpghqPcCFZkfF+H1b5VTnOxGOnvXUzozDbWmdrQ8iOe9mX4chTtb0Bfo+V6solXztFEjOTafUoQPJdOzoqHny5P9crD+THSJmwByqaLlJFxaHo0ybMWHy+KnTsndg/pSZefrVuWkgmGlT2mi1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451545; c=relaxed/simple;
	bh=sHSHHeqiwQ9YyiIBcZ7gPm0V0NpoQnvRWx5JDy8B2H0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WYApT7OzpZx/7XE96Xs3jMezJEZnFcOpFKi99PkhcGRrt4AmrVSgSixg+VQcWddxbfl5JZ2bjPx+Pbc/eFUfy2jNihsFgGX+1Ojfq57DlXWHjnyhmPetibar6gE0xWwjt5wDCbw0QWrllJt2+fvB3m5aA+1loDjz5zVRKv2kogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BultgAMM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pXTNSqSa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725451540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pssUMyVvmFvYT06a6ZnerXY0wPX0oasx1ORdEmVcAU=;
	b=BultgAMMSDtG/p5udzH+AbLKlbKZPgtMAeCarhNn/XybqLBRHuO0v+O4+h9ifkFWok7+Nz
	iL+kz/ix5VPkTvZOJ6IkJZaOc4ug/d257cvdHYxlC8oMqFdeXWhiQNth1RkvqoO2hE/0zO
	VJzTlEu5T+H9BDcenKxtJoHseOccDfIhllAy89FdNh2+XL1xWR/v/20JHTHMqpOyWM+1UX
	LoimD87ZSrsX+P5YeokIzRF4PpJPDZaSmwh+/5GwnwBBc0liJBHYIXakveyYxxOm+wnjmJ
	D5hchbA67GFkN6ApFtXUP5TOi10wWouWv4cUp4m3lwsMuAbRlluE+1AIA3GYjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725451540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pssUMyVvmFvYT06a6ZnerXY0wPX0oasx1ORdEmVcAU=;
	b=pXTNSqSa63MLJbQj+lCn92h2c5UgtHTN211wpm8CDVxJ1DtSbL8zTJsXrahRe9XDhEs9C3
	cTRgbnG3ae6rv5Cw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 10/17] printk: Provide helper for message prepending
Date: Wed,  4 Sep 2024 14:11:29 +0206
Message-Id: <20240904120536.115780-11-john.ogness@linutronix.de>
In-Reply-To: <20240904120536.115780-1-john.ogness@linutronix.de>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
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
index 149c3e04c2b5..e9458569bcfd 100644
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


