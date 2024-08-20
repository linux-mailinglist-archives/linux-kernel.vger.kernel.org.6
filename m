Return-Path: <linux-kernel+bounces-293333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5D5957E25
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5661F24132
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1D71E4EF5;
	Tue, 20 Aug 2024 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eANkyAuz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dgMs8GNB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56451DF68E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135410; cv=none; b=ePVYCXelCoNRd+fOyETz9vzixwlc0XavTxCZ/1Yo7GfH8sMHkPx5fpnZKQbC7xePtzMm4CuX3w5e8o3Hl6xpWrnrk5YJdV0Ik4HFgL0H01lFjwOL+kimwEaCvOq1odx595xuWet5dSrDlF0FOqwh8Rs9jBcIznjN/aKilyP6r3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135410; c=relaxed/simple;
	bh=EDZTvXwEbVltvzWiR3w06E4l6cPYTqndaJgbM1Hw2PU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+Esbr3lMumPItQJDXfgSoY3HE9w1BKSivxtr9l8QlvOS5fNqDJqMXzZ/FrT6qfmZQke80bkLxID0RJKgNvj3oOd+abYQbGdJXpNV+fiVCpJ/DAIfnynYd17JJsytMwlibkd0qEFZPPeM8umpuC8rOO8ZjsPQwye5Ceri64kFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eANkyAuz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dgMs8GNB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bDb4TIFgrH7FWlQUHsoHZtB4NW70NgpQfMLaM/Fw3fU=;
	b=eANkyAuzEhlZNxl7Hd0NZuKC+egFpIdmABmv1/xip9zou2WqI5smXCppbV+iapPojqNwwg
	7/P0GIPwATZnEiAFmwTtI4QlSLsYqfJ4NXw8qx3DnHCwJJdK2yFXJdSVj55llyRVGKDkqH
	hbC96RrlmYWN8M6SA5CYp0v05dE0e/0eryIBdfRI1yBtFThloIH0r7U+J/ftL3FCklE51Z
	It7anMg/LjU6LK1jpAaZ3G9mfXSX/l/F3xk/GQhsnSTNnMp2RCG4eVAPuw8I7ddrzFiccF
	QuN3km7UKtDYQTpmQNsM9M0rC5u+u1l80Kd6dNl+UOlO06sO9VM5mCF1aSpIhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bDb4TIFgrH7FWlQUHsoHZtB4NW70NgpQfMLaM/Fw3fU=;
	b=dgMs8GNBFRrXrgn+LLhaCMe+ETeh8NeF4SLzFBfNUzboKwaDgh8SayTbwARgEMCyZZ2DFD
	DIqTBkNYPjyR+eCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v8 08/35] printk: nbcon: Add callbacks to synchronize with driver
Date: Tue, 20 Aug 2024 08:35:34 +0206
Message-Id: <20240820063001.36405-9-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Console drivers typically must deal with access to the hardware
via user input/output (such as an interactive login shell) and
output of kernel messages via printk() calls. To provide the
necessary synchronization, usually some driver-specific locking
mechanism is used (for example, the port spinlock for uart
serial consoles).

Until now, usage of this driver-specific locking has been hidden
from the printk-subsystem and implemented within the various
console callbacks. However, nbcon consoles would need to use it
even in the generic code.

Add device_lock() and device_unlock() callback which will need
to get implemented by nbcon consoles.

The callbacks will use whatever synchronization mechanism the
driver is using for itself. The minimum requirement is to
prevent CPU migration. It would allow a context friendly
acquiring of nbcon console ownership in non-emergency and
non-panic context.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h | 43 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 35c64ee3827b..46b3c210b931 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -372,6 +372,49 @@ struct console {
 	 */
 	void (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
 
+	/**
+	 * @device_lock:
+	 *
+	 * NBCON callback to begin synchronization with driver code.
+	 *
+	 * Console drivers typically must deal with access to the hardware
+	 * via user input/output (such as an interactive login shell) and
+	 * output of kernel messages via printk() calls. This callback is
+	 * called by the printk-subsystem whenever it needs to synchronize
+	 * with hardware access by the driver. It should be implemented to
+	 * use whatever synchronization mechanism the driver is using for
+	 * itself (for example, the port lock for uart serial consoles).
+	 *
+	 * The callback is always called from task context. It may use any
+	 * synchronization method required by the driver.
+	 *
+	 * IMPORTANT: The callback MUST disable migration. The console driver
+	 *	may be using a synchronization mechanism that already takes
+	 *	care of this (such as spinlocks). Otherwise this function must
+	 *	explicitly call migrate_disable().
+	 *
+	 * The flags argument is provided as a convenience to the driver. It
+	 * will be passed again to device_unlock(). It can be ignored if the
+	 * driver does not need it.
+	 */
+	void (*device_lock)(struct console *con, unsigned long *flags);
+
+	/**
+	 * @device_unlock:
+	 *
+	 * NBCON callback to finish synchronization with driver code.
+	 *
+	 * It is the counterpart to device_lock().
+	 *
+	 * This callback is always called from task context. It must
+	 * appropriately re-enable migration (depending on how device_lock()
+	 * disabled migration).
+	 *
+	 * The flags argument is the value of the same variable that was
+	 * passed to device_lock().
+	 */
+	void (*device_unlock)(struct console *con, unsigned long flags);
+
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;
-- 
2.39.2


