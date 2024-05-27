Return-Path: <linux-kernel+bounces-190080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D5A8CF94E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0171F21086
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4663EA72;
	Mon, 27 May 2024 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sWqQnTrc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L2NgUy/X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38032224D1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791903; cv=none; b=E5gwVujxe8byuPT8KWASbF3qb0Z6gZEKJVt3e7ps2z3QVrScZY/UfBReHLOqKnSojrSviS3GdLFiIS4NSMQIqeUbQjR7g0UcnYUSXJlOhjtb2tlM+WbzVxoZNtMFivaS4A8USneXg7ZeP+TCNLzJtTURbqr4/sDWZ/+241I4WIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791903; c=relaxed/simple;
	bh=axuNSOvCefXcmGgJa7oB4htrGdCQVV47smWqzTggUFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dYOk6FqmHQQttRMdo24gErITJz5QLqvoEgm5NPG9oBGCV0Uv6SuT9g9LYGz4KpQg+Ay5Y8qmP0bVyvSkvsK4jVkuRX6fLLnDPu4S09wp6WvwQVkJPetiPXxxfUOJ5KMr9GP+q+FpLG51l1BXzlyuaFZCZ5pJEv/LcEPc8k9da8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sWqQnTrc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L2NgUy/X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LjCfsdgyf7GkeZyIQRXWJVLAkjljpAa6X7oN+BZvyM=;
	b=sWqQnTrceODO+INDu27A0Twd5g9PL6uCSqYw7uIqk7lqjflRUYy8aeZThDHJi8bvok6r1w
	pxC5kWIcZh9S2fGSRTlD87PdomHuDPTZWjUjRiPuzRJVoXNE/dsjE3ofF58Z2KqY7VoCMK
	HuPf9klnpD6Pt/4bvYBeRVOA4ZA3E9dV6MMxdZlM82ShSe7Xm7R0Mbe9F2fzb2aMktDoOp
	UM1Nv+G+7inulNUican3Szs332LZDbsEPGgzVzI/zkBI1v2gY53ftSxC6G2OHjVDCMX1kp
	1spA1wHmqSutZQsrtpWsX50uUIUhfg8NAXpAEM73ERIxjDdWwdDbUddk4hHLeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LjCfsdgyf7GkeZyIQRXWJVLAkjljpAa6X7oN+BZvyM=;
	b=L2NgUy/XBJuRceM8c2cC4vVv9ZgRuTSnQG1gnLXL93wthMHAzsivf0k7e9T1rAlRIdpwhm
	4KvWkuPvufCmlpAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v6 10/30] console: Improve console_srcu_read_flags() comments
Date: Mon, 27 May 2024 08:43:29 +0206
Message-Id: <20240527063749.391035-11-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was not clear when exactly console_srcu_read_flags() must be
used vs. directly reading @console->flags.

Refactor and clarify that console_srcu_read_flags() is only
needed if the console is registered or the caller is in a
context where the registration status of the console may change
(due to another context).

The function requires the caller holds @console_srcu, which will
ensure that the caller sees an appropriate @flags value for the
registered console and that exit/cleanup routines will not run
if the console is in the process of unregistration.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 33a029d976c3..aea4f5aa4a45 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -428,28 +428,34 @@ extern void console_list_unlock(void) __releases(console_mutex);
 extern struct hlist_head console_list;
 
 /**
- * console_srcu_read_flags - Locklessly read the console flags
+ * console_srcu_read_flags - Locklessly read flags of a possibly registered
+ *				console
  * @con:	struct console pointer of console to read flags from
  *
- * This function provides the necessary READ_ONCE() and data_race()
- * notation for locklessly reading the console flags. The READ_ONCE()
- * in this function matches the WRITE_ONCE() when @flags are modified
- * for registered consoles with console_srcu_write_flags().
+ * Locklessly reading @con->flags provides a consistent read value because
+ * there is at most one CPU modifying @con->flags and that CPU is using only
+ * read-modify-write operations to do so.
  *
- * Only use this function to read console flags when locklessly
- * iterating the console list via srcu.
+ * Requires console_srcu_read_lock to be held, which implies that @con might
+ * be a registered console. The purpose of holding console_srcu_read_lock is
+ * to guarantee that the console state is valid (CON_SUSPENDED/CON_ENABLED)
+ * and that no exit/cleanup routines will run if the console is currently
+ * undergoing unregistration.
+ *
+ * If the caller is holding the console_list_lock or it is _certain_ that
+ * @con is not and will not become registered, the caller may read
+ * @con->flags directly instead.
  *
  * Context: Any context.
+ * Return: The current value of the @con->flags field.
  */
 static inline short console_srcu_read_flags(const struct console *con)
 {
 	WARN_ON_ONCE(!console_srcu_read_lock_is_held());
 
 	/*
-	 * Locklessly reading console->flags provides a consistent
-	 * read value because there is at most one CPU modifying
-	 * console->flags and that CPU is using only read-modify-write
-	 * operations to do so.
+	 * The READ_ONCE() matches the WRITE_ONCE() when @flags are modified
+	 * for registered consoles with console_srcu_write_flags().
 	 */
 	return data_race(READ_ONCE(con->flags));
 }
-- 
2.39.2


