Return-Path: <linux-kernel+bounces-190086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F208CF956
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F62281401
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5614460269;
	Mon, 27 May 2024 06:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UVvJlZf1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JXD5w1ZA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BAF1CF96
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791905; cv=none; b=kplCDCB5zCvzkYiAoq6YyuKIXDZuZMz9se6e/7/oHHg82vDnyFqVXTB2sgzw+O+BH6wD3YqAnqy8zXP6Gp7XVxUsw2NkTtfBOkrMuqv8jw9LyMolea8zAWfZrY9R0yt8x0jNoYnP54r8duMb5XBRBqnlpuIJc6rG6eLwoFHv5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791905; c=relaxed/simple;
	bh=9IRHpvinAh1d0SKWvTSQyp/656+eUEtvBM0k7wl+q4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bFpR7mUnFKVeYJ77Ag7Va8LLcaP21Q6LNfnLO5As9GDxOi2LBVtsssL3ng9GLHqjT/W2RpVjROsaddd3+jGzxYb283dc4QWj2IkzzEr/OjdGdrCizozaxHnccwRa3PMpmG1tUiDl+zyanF1OMdNALriUEujpMBWEQZQINzJuews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UVvJlZf1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JXD5w1ZA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JYsgzUBKNSoyIJpFAn5k23z+tzPLez2hQ3LL73VvEsw=;
	b=UVvJlZf1Ix8GJCGVepNmNnQnqR3cqAgUx2uCMG2nxritVkBYYHMEWYCmHl/Y5YyO8koK5M
	qpR7wHuiuf873zUhpoQwt3T77PlpN8+LUqmP89gEqbB3oqgST/VQMwsRvhA+gPtO06cgeh
	Hy44BzrEijnpBcVQXHe/5Tp1WO0Oj2Bvti5T7A31+LCjy9mnzYUuVrJbPLA7MSGxpPhGi+
	o8oSZ297+aJXF9vIQ3slR6FRsT9cEEoskRhAfeAGneFXyzk2iV/9g8EM4TBaGmT7TE1B1+
	4T+DnEbp2k8CEGr5c2CnyLEjX5QR4gxtnx7eTBimhz5uqXAocIsFwaBvfvrTKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JYsgzUBKNSoyIJpFAn5k23z+tzPLez2hQ3LL73VvEsw=;
	b=JXD5w1ZAkRnO0p7taARGBF8OaMOl86njRlkDLZIJT2RfWPtAgcvPgxVu6Sv7vJbg4vwX5B
	vMcwAelSVBxjvsDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 07/30] printk: nbcon: Use driver synchronization while (un)registering
Date: Mon, 27 May 2024 08:43:26 +0206
Message-Id: <20240527063749.391035-8-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Console drivers typically have to deal with access to the
hardware via user input/output (such as an interactive login
shell) and output of kernel messages via printk() calls.

They use some classic driver-specific locking mechanism in most
situations. But console->write_atomic() callbacks, used by nbcon
consoles, are synchronized only by acquiring the console
context.

The synchronization via the console context ownership is possible
only when the console driver is registered. It is when a
particular device driver is connected with a particular console
driver.

The two synchronization mechanisms must be synchronized between
each other. It is tricky because the console context ownership
is quite special. It might be taken over by a higher priority
context. Also CPU migration must be disabled. The most tricky
part is to (dis)connect these two mechanisms during the console
(un)registration.

Use the driver-specific locking callbacks: device_lock(),
device_unlock(). They allow taking the device-specific lock
while the device is being (un)registered by the related console
driver.

For example, these callbacks lock/unlock the port lock for
serial port drivers.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4480ad2f198e..75f64efaa53c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3448,9 +3448,11 @@ static int unregister_console_locked(struct console *console);
  */
 void register_console(struct console *newcon)
 {
-	struct console *con;
+	bool use_device_lock = (newcon->flags & CON_NBCON) && newcon->write_atomic;
 	bool bootcon_registered = false;
 	bool realcon_registered = false;
+	struct console *con;
+	unsigned long flags;
 	u64 init_seq;
 	int err;
 
@@ -3537,6 +3539,19 @@ void register_console(struct console *newcon)
 		newcon->seq = init_seq;
 	}
 
+	/*
+	 * If another context is actively using the hardware of this new
+	 * console, it will not be aware of the nbcon synchronization. This
+	 * is a risk that two contexts could access the hardware
+	 * simultaneously if this new console is used for atomic printing
+	 * and the other context is still using the hardware.
+	 *
+	 * Use the driver synchronization to ensure that the hardware is not
+	 * in use while this new console transitions to being registered.
+	 */
+	if (use_device_lock)
+		newcon->device_lock(newcon, &flags);
+
 	/*
 	 * Put this console in the list - keep the
 	 * preferred driver at the head of the list.
@@ -3561,6 +3576,10 @@ void register_console(struct console *newcon)
 	 * register_console() completes.
 	 */
 
+	/* This new console is now registered. */
+	if (use_device_lock)
+		newcon->device_unlock(newcon, flags);
+
 	console_sysfs_notify();
 
 	/*
@@ -3589,6 +3608,8 @@ EXPORT_SYMBOL(register_console);
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {
+	bool use_device_lock = (console->flags & CON_NBCON) && console->write_atomic;
+	unsigned long flags;
 	int res;
 
 	lockdep_assert_console_list_lock_held();
@@ -3607,8 +3628,18 @@ static int unregister_console_locked(struct console *console)
 	if (!console_is_registered_locked(console))
 		return -ENODEV;
 
+	/*
+	 * Use the driver synchronization to ensure that the hardware is not
+	 * in use while this console transitions to being unregistered.
+	 */
+	if (use_device_lock)
+		console->device_lock(console, &flags);
+
 	hlist_del_init_rcu(&console->node);
 
+	if (use_device_lock)
+		console->device_unlock(console, flags);
+
 	/*
 	 * <HISTORICAL>
 	 * If this isn't the last console and it has CON_CONSDEV set, we
-- 
2.39.2


