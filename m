Return-Path: <linux-kernel+bounces-273629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB95946BA0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20421F21C92
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCA01F947;
	Sun,  4 Aug 2024 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jQNbmIkU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DCyfti99"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D44A930
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732713; cv=none; b=JyGUN57n31HHPvAc7r9daJ5UcI0kiEDUv6GF3dl4tYnIps8w73fPhzOX7jELo9ke0Up27oXH8kMU35zJUNBf5HvWqB8zu5cVMIGVfr9aSRiFobLsL97Fds+00gsNQVGha+Wi1YBiaDKUQ2P/VUOVyH09y+PsBt1i6w9tTh9KfZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732713; c=relaxed/simple;
	bh=EE0q3hdpnMtsse57YJgp4zis2zjcR6z0zeU0j659B84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mK9ZfOGU1gTyL92SLRNYjO1KigeW8SSnfkDnQYK4f4pV7ZMBWkJUvYgssuWFDQ9UoRUK9PLrnAa7+++228vj6Vpt32n0tTF17/oxnYXNdtxT9p5oCt30a9ynL7CeKNE/kqcP2VsVQ7oOc5cyXKEqJI5HPhbkevhIEqdr5x/5oG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jQNbmIkU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DCyfti99; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tk3o2TzJsqHT2V8VmhzoN1L6WaQ5SSmi/WNwun+0Gss=;
	b=jQNbmIkU2VQS4oUQUmd3IuYRYJ4dx5rt8gWGlhP7JfX1+S8PH+wxm+YZpkoaXvFBikcC2i
	o5Ci+srLl0//3Vs1RG72lDBpfHBeT2oBUziQUFfidbIZHS/EHcPYrnwkPA7Wc5PWf6CAqr
	83ja8qRGECpiUG96MhYOa981mp8Nz1o41d8jl7RChMW/f0cSWI4oagYbp6io7sIDhMgRQh
	gu4/XdRcopwf1CW2H5DOM+4qb77OTFoKYZBR/1dZf+psOMRDHYs0l9+tIDWiP+MwBzBGIu
	DTe9EFt8yhei7GunKKNUWRX0NuWndOUVeRLzcBRQbcrbR+FWYgHYgf2C+6gruw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tk3o2TzJsqHT2V8VmhzoN1L6WaQ5SSmi/WNwun+0Gss=;
	b=DCyfti99YHcIKVVzy+RqUXbFZY9zAAH05CHg5HtOcJPVJsLPnYIUg6/jQmfjZSwEf+jw4o
	a24pRIyshAEVIqCQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v7 09/35] printk: nbcon: Use driver synchronization while (un)registering
Date: Sun,  4 Aug 2024 02:57:12 +0206
Message-Id: <20240804005138.3722656-10-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
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

Note that the driver-specific locking is only needed during
(un)register if it is an nbcon console with the write_atomic()
callback implemented. If write_atomic() is not implemented, the
driver should never attempt to access the hardware without
first acquiring its driver-specific lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6ac333938ffc..7027f0868ef4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3548,9 +3548,11 @@ static int unregister_console_locked(struct console *console);
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
 
@@ -3637,6 +3639,19 @@ void register_console(struct console *newcon)
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
@@ -3661,6 +3676,10 @@ void register_console(struct console *newcon)
 	 * register_console() completes.
 	 */
 
+	/* This new console is now registered. */
+	if (use_device_lock)
+		newcon->device_unlock(newcon, flags);
+
 	console_sysfs_notify();
 
 	/*
@@ -3689,6 +3708,8 @@ EXPORT_SYMBOL(register_console);
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {
+	bool use_device_lock = (console->flags & CON_NBCON) && console->write_atomic;
+	unsigned long flags;
 	int res;
 
 	lockdep_assert_console_list_lock_held();
@@ -3707,8 +3728,18 @@ static int unregister_console_locked(struct console *console)
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


