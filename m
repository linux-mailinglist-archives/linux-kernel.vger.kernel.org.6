Return-Path: <linux-kernel+bounces-273628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E798946B9F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D4E1C21317
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EFD1EEE3;
	Sun,  4 Aug 2024 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Og0oJwZY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b4Peb0Nb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC6A945
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732713; cv=none; b=WAZCCm53JSDNmkYUujP3klPKkfwUfr20o8bWcJlKlfacntiT4shwtQafvhG8wHr4c7r4+GdDbh7KZxRFgaxiRR6w1gxluJyzvhg/KfDHEWndS9bfH8ODxYQQokxtzVttQ8C1TjAD+YOVgVVptOAHjHv8fdmZNwv8xqnnsY1/0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732713; c=relaxed/simple;
	bh=yKnV19hWrNK0IoLPABXMEmiKhLFF62eNhWtKhGQNusQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fxr2pPoQcW05r/wcM/FldLut44if4Phx/d2X1dA53+otO3IqIx4yZz6PAakWBjK/8rDKNpRYaGj3iE/BqvPEWoNT24RZerZ3DFmfNnlR194mY9nbszdZLfy7ieEkl+869ptukxW7FmY6xnqJ3GimdJl8PVWejLTUdQSRjxmKUgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Og0oJwZY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b4Peb0Nb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPd6uvFKDkpD+NeIatYE77JXVT2eZZGIALZo/fK24kQ=;
	b=Og0oJwZY+/flKszHsaLxWZaLm830NyeVlhL5LGnLgopzinmcRJqr16ROg7Rw88c0E62ByH
	OrVSJqpNXN8xFz/0rWsB5Bk0XSZdwYUVZFEXcmCeTv7isHBbip056jIWmpjtBEGTdCfmeO
	XvpUuH7xDQCtAijBz2wWggPgcG2MTECtIduk7Z+jzL4phrIQ9c0H32JzDXRx4oWz5bEADu
	7Z/uTW4AAcrnXsZDEgaKFnejOMfN0yvJGQt8W+qZkLu+6eSouxNQM/xz3HCM67KxIcFf1I
	fFnzMi4cu/eghv6ILTeIjEO3SBmm9Xj9J6kkPYJUR9gSrW2dku0S49l3znVzxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPd6uvFKDkpD+NeIatYE77JXVT2eZZGIALZo/fK24kQ=;
	b=b4Peb0Nb1MuH3i2HxwW0oXnkYZ4vm2xny95eEi3ro/UtwIZGH8HG2KNOPKY5ISmB2xZmCw
	vVZhugfIUCCL45DQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v7 07/35] printk: nbcon: Add detailed doc for write_atomic()
Date: Sun,  4 Aug 2024 02:57:10 +0206
Message-Id: <20240804005138.3722656-8-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
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


