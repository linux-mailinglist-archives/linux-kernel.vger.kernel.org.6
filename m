Return-Path: <linux-kernel+bounces-293334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D882A957E26
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62FDF2856FD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCC81E4EFB;
	Tue, 20 Aug 2024 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xdo6AlvH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XW8Z0UF3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A41DF68D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135410; cv=none; b=MnM/w+661kip3FCCzA9Q2Zwrdf6dBVWvTeNfKg40QeAgPlzq9GBmxjh1QLbOld7Znf0Hz6f/G4970XfOw9oN222vrQSGypPgEV965IVV99TphoyZ7fvbQMyhrFo17frg4e/ahHf44b/sNtojo84AagDIvnwnix9a+TCG9b5ntOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135410; c=relaxed/simple;
	bh=yKnV19hWrNK0IoLPABXMEmiKhLFF62eNhWtKhGQNusQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kMYI7L8XGOD93zZY3EpPTk7eX3t2mgo9VUKGHqRnzYM2yOd5+tVmtTb1FXaSm0fuvb2wC7ddvR5ABhcxAm1lEsR/KlWXvTOZ756t0lDL4UnqrzecVDhUbHaKs4Pz5qcNOx53abJTTNH1ZEU10p8yex7lh4DwV6+THoRzel9iziE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xdo6AlvH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XW8Z0UF3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPd6uvFKDkpD+NeIatYE77JXVT2eZZGIALZo/fK24kQ=;
	b=Xdo6AlvH19YCwP7XJAHFm6ZFC5VBNECNkxGYMbLCEDH6AtHscjH2eQxmOWATtPPoYrumWE
	lsttcM6hIyQS3AkH3429rYtJTjXPXoHCgxEUqWwhkhx6HPjsa600qooSmhP9Ev6NqbO7gB
	x36Cs3iMf41ptfbhQgvCxPLHc4pNL+IfpXZpsZXIzhCqpiFWT/HFywHgQWoFG6UN4TecSX
	Lvm064M4UVNw7fv//kVd+sVQjaCoY8UusJmX9kI6kZYDl0E8WTP8Lui5oBm+jjAd2WUKJE
	LrHJHTLTucVzDBj3plJjanaWa/SLNA4mbx1muamx3bM00lrIQ2livSEgJwr3oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPd6uvFKDkpD+NeIatYE77JXVT2eZZGIALZo/fK24kQ=;
	b=XW8Z0UF3aYwGQi2PNQ2mKtbJO2JUdfu8egbAEmceuzXEjskJje5QHIP7TLx2rLByg4NkeJ
	oDo9Eu1CtKWp5+Dg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v8 07/35] printk: nbcon: Add detailed doc for write_atomic()
Date: Tue, 20 Aug 2024 08:35:33 +0206
Message-Id: <20240820063001.36405-8-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The write_atomic() callback has special requirements and is
allowed to use special helper functions. Provide detailed
documentation of the callback so that a developer has a
chance of implementing it correctly.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 577b157fe4fb..35c64ee3827b 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -303,7 +303,7 @@ struct nbcon_write_context {
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
- * @write:		Write callback to output messages (Optional)
+ * @write:		Legacy write callback to output messages (Optional)
  * @read:		Read callback for console input (Optional)
  * @device:		The underlying TTY device driver (Optional)
  * @unblank:		Callback to unblank the console (Optional)
@@ -320,7 +320,6 @@ struct nbcon_write_context {
  * @data:		Driver private data
  * @node:		hlist node for the console list
  *
- * @write_atomic:	Write callback for atomic context
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @pbufs:		Pointer to nbcon private buffer
@@ -345,8 +344,34 @@ struct console {
 	struct hlist_node	node;
 
 	/* nbcon console specific members */
-	void			(*write_atomic)(struct console *con,
-						struct nbcon_write_context *wctxt);
+
+	/**
+	 * @write_atomic:
+	 *
+	 * NBCON callback to write out text in any context. (Optional)
+	 *
+	 * This callback is called with the console already acquired. However,
+	 * a higher priority context is allowed to take it over by default.
+	 *
+	 * The callback must call nbcon_enter_unsafe() and nbcon_exit_unsafe()
+	 * around any code where the takeover is not safe, for example, when
+	 * manipulating the serial port registers.
+	 *
+	 * nbcon_enter_unsafe() will fail if the context has lost the console
+	 * ownership in the meantime. In this case, the callback is no longer
+	 * allowed to go forward. It must back out immediately and carefully.
+	 * The buffer content is also no longer trusted since it no longer
+	 * belongs to the context.
+	 *
+	 * The callback should allow the takeover whenever it is safe. It
+	 * increases the chance to see messages when the system is in trouble.
+	 *
+	 * The callback can be called from any context (including NMI).
+	 * Therefore it must avoid usage of any locking and instead rely
+	 * on the console ownership for synchronization.
+	 */
+	void (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
+
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;
-- 
2.39.2


