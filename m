Return-Path: <linux-kernel+bounces-190084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D47C8CF953
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F991B209BD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1AF5427E;
	Mon, 27 May 2024 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="agGKEwd/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m/ZUIGyO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56A2207A
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791904; cv=none; b=ShmFq2hNhFSs0SG6HR8VGoierBJtBaORH7gL1KMKAOF5RQde6R093XbzyTH1BEPIjIkXE5DFnAYfPWxzrSh8GOzUG/wCDOGhHKDljuYiFt1EzHo4MocjTj97sAb29hU/XWtLMEJqCJCWVmF/GV3lIpKLGJjVNetOjW9+WCw0jJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791904; c=relaxed/simple;
	bh=Cp5rG2YqPtZnpO861UnOvSpwJyI1madSjKWclzZ6Pcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EcKLU6OerpQ8PcNt9JWkQgVzScn/GmO3r0UTx/Bvnv2XFydp8rkR/TNwQC7Kwl2ouc9O72Xv32DSX7Frh0aQnDHFlVHSH3TirQ2lhZjYKbB2jYg5APWaCToRUooLf4kSzLBnpskxwMTdLpzYubwL01Xt8Q734JV+vjHPk+if5dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=agGKEwd/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m/ZUIGyO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wlf6KcDO+RSt0m5hbX6TLMb9vXVt0E3+gB/34zgqmT0=;
	b=agGKEwd/5fTzX1tubGtH+Jy8oH9yozoGwAv8td9G594TX6uoVFJAr7uczrJsJrdUOMRiqC
	waK+FscwvHvw2HQ5y1L0CEsIeYWlSiXv4Xa/G29tPO8N8/GQR6XmQ+2j72Wx5pcI+GyHz0
	fo+g0DykcgZRqbHW2iN2SyQo9POlo+1CGAdd+3/TzSnrSQHQOyUFdJaLAYhECcaR9BCNwF
	D40qm+sH8WsmrC/dPgUxSjhgaxjHwIRgAaGciJNw/b/9RsAYjd7148ZYv3GPOdqlB770GF
	mErv7SAANhT6La5KnazQn3bC+H/NjmFO9HUT6GE3dExLdp9l2yMhN6wdWnIypA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wlf6KcDO+RSt0m5hbX6TLMb9vXVt0E3+gB/34zgqmT0=;
	b=m/ZUIGyOEL3+DYWkTlxmJaeWLcE2Y/e4gAgBK7pXnEs41qlDYHmlV1v0M/0kPymyeOlGl/
	SOPfMt7tfcWGTIBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v6 06/30] printk: nbcon: Add callbacks to synchronize with driver
Date: Mon, 27 May 2024 08:43:25 +0206
Message-Id: <20240527063749.391035-7-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
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
index 3291cc340f1a..33a029d976c3 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -354,6 +354,49 @@ struct console {
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


