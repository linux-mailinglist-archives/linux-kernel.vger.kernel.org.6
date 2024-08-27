Return-Path: <linux-kernel+bounces-302567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3EB96006C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9301C219D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A14153BED;
	Tue, 27 Aug 2024 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EpUQzoTF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1jj/IdKz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF3138490
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733821; cv=none; b=ey8TdH9JP4yxZY2j0RP5OgPdeJaSoGDvd8PsFHyCK24JWc1U9b/uwlmLBqZ+32+rz4qiwjVjESpQuyISUOnRf9N9k2m3JltTaf0PPLpbmSaY/osfwlni+W+2APjhwIJuXKQvzOI5Y6BQDGVqeTLkSkEqER1O9v7t8Rzyokpr5jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733821; c=relaxed/simple;
	bh=77nORTXpI1q4KDBhB66CLINRXF3REoaPCkl5EJvjm9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ER1nMunP7A2ZbEkLOCWoEIVozXpmEOTZA41Ozjs1DZAP7k7wTijZ6R8EDwzky4/d8xNHUXKFQwddNXHIuQhssRjX4Ml0q/jRoRnTiAZNU5Ed5aVdYCIEDSYcFq05o3tiAllDpvVo+hBWcnJJEfJyIe0Wj1gJErUupZw+Xt5JmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EpUQzoTF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1jj/IdKz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724733817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrB6oXwNT8+Bqp3Goa78TH7hK15/gLFUczJKrHMn7MM=;
	b=EpUQzoTFCPot6l9kNIc61iMjdwyxymI1459e5YFxtgN73jhndCnok8QtDYBIlJF8rA1jNm
	qK5u9pBAHqBK0NWxkhJc9xtTtP1k6QuDgx27nI0EUiQEDq5LIid2ZUHJOlKrEe6w9RKvrh
	LVjoKOBelxaiDNUT8RUiQx05CYKLDbZ9eTeh02Zk/uIbifvkQzvLU8EC0vLnoLgiYM44Br
	G02R/IbEBCsqY9KOOf+HzXoLZiry7n/H2+pkeavnltFmL6YglhCkp38cFBVDDI7rSDoEri
	83f+LLHQSO1XjuJm0rT8EmGUUje8+oyf61thBMhCEz7WhD7AHPgSqnCRlXKPEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724733817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrB6oXwNT8+Bqp3Goa78TH7hK15/gLFUczJKrHMn7MM=;
	b=1jj/IdKzMTaJKs7gRMGq3gFIHMY0GHPR4hVy8NYyTU4BPPMtpf1c0zWRjw35rWnYKpc74e
	1ylfRVNhit+sulAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 10/17] printk: Provide helper for message prepending
Date: Tue, 27 Aug 2024 06:49:26 +0206
Message-Id: <20240827044333.88596-11-john.ogness@linutronix.de>
In-Reply-To: <20240827044333.88596-1-john.ogness@linutronix.de>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
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
index 0d45d82a7c79..fba923730af9 100644
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


