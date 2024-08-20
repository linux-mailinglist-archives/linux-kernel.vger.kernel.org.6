Return-Path: <linux-kernel+bounces-293327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A73957E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203551F23FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3AE1DC490;
	Tue, 20 Aug 2024 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WDaQ1yGw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UmWC5hFl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B916D328
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135407; cv=none; b=B93RLKYNOiUeQjg1kzF1+hm515qZDInRsFiUGqKYrjahYoo8xzjZ1V0BcBSMW8u7WwZvMO+Mn2ABsWSxDtjdsJc5LVwuJBhmo1KHtYUXHTDj+J6TzZRerT1jB90pRgJwv5le+uQGYgXW01mRkOxqxB1+sFoYfub9oVLYReC0U7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135407; c=relaxed/simple;
	bh=/zXyECwJ24yVKiKm9ClPQraJ6bOEderu+A2o4qh+5pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3145Srh335EmK2nqoaz5Z6uFUr2k9WGHL6n1n7qOMhrLgSg2qbH3mV45QPpqPlvTsAMpHEi46wrEQzpCbt46sZQO4tG4mR+zpk7+QUbISu5gXFJCADiJpjUTk9vbT+03lbyL+9Li3jH72Sh1rvaAeif9OKFxfIhm0H4/qMxN6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WDaQ1yGw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UmWC5hFl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWYO3aoDm+pDCxULMrrDPcU4dFyD7eXtyilSOBY/XvE=;
	b=WDaQ1yGwBCVvLu3GHY39LQrJiF8ga2/n+TRBTDvvmCI8Y3qYksfqDxVeqs0Nxi+0cCPmBR
	/IzcsfaFs1hNbqkIhkJ6tzhv7vnRjm9FfNiRGb5MKwShXDg2bae4AW9ilmkbVKXfRd2/zF
	JXHhvqe5wtFQ35JnA4opyYn+3jyBD3Y+CH3Ahu3kC9Wmrv5NZwrBPA/aG/1os8o/KzfMvZ
	RpPPzRruwMhZghCOwErAGU1sTLg4s2KoZ+29qeEbyjuZpVk+RZOjbA7tA5RSEFccSTW1s6
	z35Pl7hUR+E2QlHL8pROyfQjjfQtsgI6h6iyZ+LBz91FzWYEOcP2WEkqF7wtKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWYO3aoDm+pDCxULMrrDPcU4dFyD7eXtyilSOBY/XvE=;
	b=UmWC5hFlsk+FflXSUWh1uWkZX+2v/PV9oTiZi4IF6CpsW9wGkDBP1xDNgJGbU99ZAEB4d2
	WFCPb3WgsiGZShCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v8 02/35] printk: nbcon: Consolidate alloc() and init()
Date: Tue, 20 Aug 2024 08:35:28 +0206
Message-Id: <20240820063001.36405-3-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than splitting the nbcon allocation and initialization into
two pieces, perform all initialization in nbcon_alloc(). Later,
the initial sequence is calculated and can be explicitly set using
nbcon_seq_force(). This removes the need for the strong rules of
nbcon_init() that even included a BUG_ON().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  2 --
 kernel/printk/nbcon.c    | 37 +++++++++++--------------------------
 kernel/printk/printk.c   |  2 +-
 3 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 19dcc5832651..398ecb40d279 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -75,7 +75,6 @@ u16 printk_parse_prefix(const char *text, int *level,
 u64 nbcon_seq_read(struct console *con);
 void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
-void nbcon_init(struct console *con);
 void nbcon_free(struct console *con);
 
 #else
@@ -96,7 +95,6 @@ static inline bool printk_percpu_data_ready(void) { return false; }
 static inline u64 nbcon_seq_read(struct console *con) { return 0; }
 static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
-static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
 
 #endif /* CONFIG_PRINTK */
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index c8093bcc01fe..670692dc9b10 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -929,17 +929,22 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 }
 
 /**
- * nbcon_alloc - Allocate buffers needed by the nbcon console
- * @con:	Console to allocate buffers for
+ * nbcon_alloc - Allocate and init the nbcon console specific data
+ * @con:	Console to initialize
  *
- * Return:	True on success. False otherwise and the console cannot
- *		be used.
+ * Return:	True if the console was fully allocated and initialized.
+ *		Otherwise @con must not be registered.
  *
- * This is not part of nbcon_init() because buffer allocation must
- * be performed earlier in the console registration process.
+ * When allocation and init was successful, the console must be properly
+ * freed using nbcon_free() once it is no longer needed.
  */
 bool nbcon_alloc(struct console *con)
 {
+	struct nbcon_state state = { };
+
+	nbcon_state_set(con, &state);
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), 0);
+
 	if (con->flags & CON_BOOT) {
 		/*
 		 * Boot console printing is synchronized with legacy console
@@ -958,26 +963,6 @@ bool nbcon_alloc(struct console *con)
 	return true;
 }
 
-/**
- * nbcon_init - Initialize the nbcon console specific data
- * @con:	Console to initialize
- *
- * nbcon_alloc() *must* be called and succeed before this function
- * is called.
- *
- * This function expects that the legacy @con->seq has been set.
- */
-void nbcon_init(struct console *con)
-{
-	struct nbcon_state state = { };
-
-	/* nbcon_alloc() must have been called and successful! */
-	BUG_ON(!con->pbufs);
-
-	nbcon_seq_force(con, con->seq);
-	nbcon_state_set(con, &state);
-}
-
 /**
  * nbcon_free - Free and cleanup the nbcon console specific data
  * @con:	Console to free/cleanup nbcon data
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 93c67eb7ca9e..a47017c932be 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3618,7 +3618,7 @@ void register_console(struct console *newcon)
 	console_init_seq(newcon, bootcon_registered);
 
 	if (newcon->flags & CON_NBCON)
-		nbcon_init(newcon);
+		nbcon_seq_force(newcon, newcon->seq);
 
 	/*
 	 * Put this console in the list - keep the
-- 
2.39.2


