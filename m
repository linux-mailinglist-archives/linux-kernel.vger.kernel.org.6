Return-Path: <linux-kernel+bounces-199829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAA88FA66E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB056285C11
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3726F13DDC4;
	Mon,  3 Jun 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x4a20jNB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1NBbkf+i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F56C13D527
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457102; cv=none; b=j0PJrm38rBJcQp894xV2wXuzT9UbeomW9oQ344JgdHpTX+Uw3yumQR+Q8QH+TnN/64gxEdjXEWNKsZZxE0FOhikyUsCh8l8DJYeR9TbQLm5hifFpLKg/N/LsmrZtJ57CqlMcv06qOVcT1A+1z15Phdhiavd7fMg1JzgTJSoJhC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457102; c=relaxed/simple;
	bh=WzH60LE1JHbgrXr8Xp82kiXt9WKVqavSDQunTGSY/BU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dJ9WlNnDhMU3IbJAclWD1qBUU3IEqzsx3TtTCElk8s2F4I5AEyUj5F5qKNdjibk9pXpHBk4dYLfzzHmcv1ONncdUe9rBzQnrPO6oAb0wEt3qs7Fh+tn1cAxCwcEAnei3yxOjLgRT06VHHkol8NzTzu96Bf0Zc2loProPC9aiHWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x4a20jNB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1NBbkf+i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4oYaY6vh/25J7oqncloRHx8iudin+UX3Lw2NmnwW3ms=;
	b=x4a20jNBcfTKskpVL5KHWROuttjcpcX9tuRFrAxhpqJvysj3BpITSI3LI5MksQG8UC/ZVE
	hmt/ArLodPuOT19k+28sEMGnIHip8R3+WT2VASeDwvPDC8WK71e6hsWi0Yg7s5Q+j/Jpmk
	k87wrYYYXwmhwEYc/VvAz/6esle6+SWdyDY5R+pdxV6GWC8N6GEVvTbhqTSEm7PCCZ+DRM
	Omj50ebW4B1vY2HnwMmpb8P8YB37y4J0H7aTbjeRftEMr2zD8VwE+SwgLIJ2ivtzxTjRHR
	cFvp9EE6C+mVEStIeGKBzF3pY180Pm3LAe0N8T05FXw5K7KiygnjQaTKFkbEsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4oYaY6vh/25J7oqncloRHx8iudin+UX3Lw2NmnwW3ms=;
	b=1NBbkf+i0YZ7KR/qAerh2MAF+2aJNWczX8I9aHGeefDlnwTeWaxLrslvmjJF2/eDBxeT3H
	vuAejtit7IH6uPBg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 10/18] printk: Provide helper for message prepending
Date: Tue,  4 Jun 2024 01:30:45 +0206
Message-Id: <20240603232453.33992-11-john.ogness@linutronix.de>
In-Reply-To: <20240603232453.33992-1-john.ogness@linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
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
---
 kernel/printk/printk.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4613f9145a8e..fcbf794a0aaf 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2806,30 +2806,25 @@ static void __console_unlock(void)
 #ifdef CONFIG_PRINTK
 
 /*
- * Prepend the message in @pmsg->pbufs->outbuf with a "dropped message". This
- * is achieved by shifting the existing message over and inserting the dropped
- * message.
+ * Prepend the message in @pmsg->pbufs->outbuf with the message in
+ * @pmsg->pbufs->scratchbuf. This is achieved by shifting the existing message
+ * over and inserting the scratchbuf message.
  *
  * @pmsg is the printk message to prepend.
  *
- * @dropped is the dropped count to report in the dropped message.
+ * @len is the length of the message in @pmsg->pbufs->scratchbuf.
  *
  * If the message text in @pmsg->pbufs->outbuf does not have enough space for
- * the dropped message, the message text will be sufficiently truncated.
+ * the scratchbuf message, the message text will be sufficiently truncated.
  *
  * If @pmsg->pbufs->outbuf is modified, @pmsg->outbuf_len is updated.
  */
-void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
+static void __console_prepend_scratch(struct printk_message *pmsg, size_t len)
 {
 	struct printk_buffers *pbufs = pmsg->pbufs;
-	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
 	const size_t outbuf_sz = sizeof(pbufs->outbuf);
 	char *scratchbuf = &pbufs->scratchbuf[0];
 	char *outbuf = &pbufs->outbuf[0];
-	size_t len;
-
-	len = scnprintf(scratchbuf, scratchbuf_sz,
-		       "** %lu printk messages dropped **\n", dropped);
 
 	/*
 	 * Make sure outbuf is sufficiently large before prepending.
@@ -2851,6 +2846,27 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
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
+	struct printk_buffers *pbufs = pmsg->pbufs;
+	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
+	char *scratchbuf = &pbufs->scratchbuf[0];
+	size_t len;
+
+	len = scnprintf(scratchbuf, scratchbuf_sz,
+		       "** %lu printk messages dropped **\n", dropped);
+
+	__console_prepend_scratch(pmsg, len);
+}
+
 /*
  * Read and format the specified record (or a later record if the specified
  * record is not available).
-- 
2.39.2


