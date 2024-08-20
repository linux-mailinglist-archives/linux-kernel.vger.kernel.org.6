Return-Path: <linux-kernel+bounces-293348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8869957E34
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B52B21F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D06201273;
	Tue, 20 Aug 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="okUeUWzB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3z+bt8K+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4BB1E6751
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135415; cv=none; b=P7ayyWwp/OBCVm6kJ50b7M5tXZuCHrWwIyi9ivtRnyyDCT6k/taTI3kaudARZmLf8uAiVK+nZNGQWLbHLClkDxRBWwDd5USP5FtkrAdY+V3IGtpil1z7hYmbcQjcjbVZ8IkdDuZIJW+94tq8Ixz5BQQRneT0x5OxBAC6r4VkOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135415; c=relaxed/simple;
	bh=eclHtVQ2mYH9BH2hWmbIWRAhLK0XIgGmnm9EaPB6Uvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KJo870uoRMoiSBi5346uH8ZkzsvCSo5AZpBwypoXFnuyBiffOHtp387bAKXdb5JL8vNkAYzyFiLdWhxO8U4Gg1mlcNXNQAWNRSWkcA+fzZao1+4islS1zF+uUWr91q8N7Mj35ypZbPzHC9rTqXTxhHhr/7zfyakw1Qlhpsgj8hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=okUeUWzB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3z+bt8K+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NbvEKbKCn6BdwDxwZqIMq47IszZMmd/jeB5/O0D1TaI=;
	b=okUeUWzBk8nSMNHHMt6SsO54GeZGMPQ1RXb/aWqctT6tXbagFNESsdvtAV5zLYBS8M9eyG
	qDUcwtoX7EHFCuA40F9KWi+GrPumGnOeUHV5H9hzvuBwkX/vQQds7nCHifyF5cjGFKIWpl
	QmmZ0JqlvxhaO9UYoixOvKAFLF9U2l5teIW0ICLhR4gWsZvhC/RjLZDlEE3znJ3r6w4v6f
	f/2pzJShp482H7NxTYmelJ9Ak24BfIXKXKikQq91gUSF6MtVSWzYTDViIvJ8d56ttPsnln
	Ls0bKiIE1Z2nqiuo90eGRak1R4lgiye7mjvu2LgxT4fXrtxrJRzXFDz0j8o34g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NbvEKbKCn6BdwDxwZqIMq47IszZMmd/jeB5/O0D1TaI=;
	b=3z+bt8K++1/8RXyAKm9vC3Z44cPJIXMTCPTxEC7vm3AyI39+wek0Vkng/QGY1U5GFZfi1e
	KQOCDNqbBQluYHCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v8 24/35] printk: nbcon: Flush new records on device_release()
Date: Tue, 20 Aug 2024 08:35:50 +0206
Message-Id: <20240820063001.36405-25-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There may be new records that were added while a driver was
holding the nbcon context for non-printing purposes. These
new records must be flushed by the nbcon_device_release()
context because no other context will do it.

If boot consoles are registered, the legacy loop is used
(either direct or per irq_work) to handle the flushing.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/nbcon.c    | 20 ++++++++++++++++++++
 kernel/printk/printk.c   |  2 +-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 84706c1c934b..7679e18f24b3 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -153,6 +153,8 @@ static inline bool console_is_usable(struct console *con, short flags) { return
 
 #endif /* CONFIG_PRINTK */
 
+extern bool have_boot_console;
+
 extern struct printk_buffers printk_shared_pbufs;
 
 /**
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index d09c084c9af4..269aeed18064 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1326,10 +1326,30 @@ EXPORT_SYMBOL_GPL(nbcon_device_try_acquire);
 void nbcon_device_release(struct console *con)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_device_ctxt);
+	int cookie;
 
 	if (!nbcon_context_exit_unsafe(ctxt))
 		return;
 
 	nbcon_context_release(ctxt);
+
+	/*
+	 * This context must flush any new records added while the console
+	 * was locked. The console_srcu_read_lock must be taken to ensure
+	 * the console is usable throughout flushing.
+	 */
+	cookie = console_srcu_read_lock();
+	if (console_is_usable(con, console_srcu_read_flags(con)) &&
+	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
+		if (!have_boot_console) {
+			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb));
+		} else if (!is_printk_legacy_deferred()) {
+			if (console_trylock())
+				console_unlock();
+		} else {
+			printk_trigger_flush();
+		}
+	}
+	console_srcu_read_unlock(cookie);
 }
 EXPORT_SYMBOL_GPL(nbcon_device_release);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f08bf5e82fc7..7c9f8f6e1738 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -469,7 +469,7 @@ static DEFINE_MUTEX(syslog_lock);
  * the console lock. This is because boot consoles and nbcon consoles may
  * have mapped the same hardware.
  */
-static bool have_boot_console;
+bool have_boot_console;
 
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
-- 
2.39.2


