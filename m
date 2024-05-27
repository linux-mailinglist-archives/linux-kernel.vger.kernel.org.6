Return-Path: <linux-kernel+bounces-190079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72638CF94F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3EDB207C1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C323D969;
	Mon, 27 May 2024 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CXInjNls";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2jDLPap9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69001C280
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791903; cv=none; b=VJO4KZg6AgWthaTs1WDM3TAd+cUcJ0afrA+Wdw8/tddwpfajX3qZ1ft5uHJeX2vn5Pv1UDK+QRTGY3cxPOyDJFWMIlJ2ptc/PgQOlL7br/zoX5fQaqbIWblQKW7wWLgE/Z5k1fWg1bD78lftPeKPuVvVJPTNpZxEok9HDijI/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791903; c=relaxed/simple;
	bh=2oQpWTGgHoIvmlUI0T2VUPsPGRoIQcWGzo9lRoqvLO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XKsOWaRfJNQ0psrPlpDU2j+gVkZS3H0QaKpbpGEvuUUpn3N0er0FV64IzlTViwaQN/kqQyZCynQfnHLVv5+K6/HyNECywElCAc6kT8oFEZjYwcT6m8x1pcxAFyl/kgf5JjgeXVc2xwgX9OAu2tnx7dib4TtDbsDWN3NnBF8eAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CXInjNls; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2jDLPap9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faZjTsv+SGR99qiNy2FGhpUimYqF+o8TpUza4h+et4E=;
	b=CXInjNlstcc74giVMtUIAFkGOIr/rwb12FGVEPVkah0V5U0zzsYR1ug5cwCn5aV/8abLKR
	C8NGw9PrR1DQrpipmy1yPaEf8H2qXheQ7cLvqaB4WXdbVIJsJQSktjL1e2ahiLG/35cjYi
	AM6wa4qOR+pbS1Ba+6PbtQyQGfeRHvNX85VH4YQYzVvRBldw3l2ClErVptR1D7lj4faWik
	y6IbH6TxHrCvnTQX83fyCbWFer1bt3+p3ehd+1vrlwmQRykYsOXo56/NPY+e3Xg/jHOtL8
	WFW3eu0F1BfdDIhf9BspcuhSXNRBNJUmEHjHKm6Qo0lvhVYa0kR5x9G58TH2rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faZjTsv+SGR99qiNy2FGhpUimYqF+o8TpUza4h+et4E=;
	b=2jDLPap9QvTZ+rVZTHJUOWoWDd6mM4BBmQR69Ykti1UHBGhYs1PCmGdSy12sBpoXEAvpw6
	ICMFSFzZ0YDvirCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v6 05/30] printk: nbcon: Add detailed doc for write_atomic()
Date: Mon, 27 May 2024 08:43:24 +0206
Message-Id: <20240527063749.391035-6-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
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
index 54b98e4f0544..3291cc340f1a 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -285,7 +285,7 @@ struct nbcon_write_context {
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
- * @write:		Write callback to output messages (Optional)
+ * @write:		Legacy write callback to output messages (Optional)
  * @read:		Read callback for console input (Optional)
  * @device:		The underlying TTY device driver (Optional)
  * @unblank:		Callback to unblank the console (Optional)
@@ -302,7 +302,6 @@ struct nbcon_write_context {
  * @data:		Driver private data
  * @node:		hlist node for the console list
  *
- * @write_atomic:	Write callback for atomic context
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @pbufs:		Pointer to nbcon private buffer
@@ -327,8 +326,34 @@ struct console {
 	struct hlist_node	node;
 
 	/* nbcon console specific members */
-	void			(*write_atomic)(struct console *con,
-						struct nbcon_write_context *wctxt);
+
+	/**
+	 * @write_atomic:
+	 *
+	 * NBCON callback to write out text in any context.
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


