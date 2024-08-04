Return-Path: <linux-kernel+bounces-273627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0920946B9C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391D51F21551
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2121BC46;
	Sun,  4 Aug 2024 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RgwL9/6z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v7nDEcLf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C408468
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732712; cv=none; b=IwHCXWRImoY2qj2V4E/nKOUZM7fKCWF9oL9LucL8jEoC/NTQWVchmks/jGAEuVS4rG2u6LTYSvHnNuxmBNoAXwJFD8AedyQfVQAVXzQ9VfTydZGznag0LSKB7nNJAVi69UV1n7SnYNeDkxbzCIbdtG5AEuVCQXzdDfuCghxd7Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732712; c=relaxed/simple;
	bh=FFxAFuODw+P+vrod+fHArz08EUy3UXy/c6t6YmdCMUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADl4TIKEdvvhNjlnMe4/9WQCglGS1VzKSGB4NbM0GA2R+AF18bWbez4xqPC9rCiwoUi8mDeAD1rMmN01O22/6xx8m5ddEIQ/LTe+qdEio33rH/u21L2DA94de7z4HuWc9EwGRV+y7mZZMopaoWhi9h27NJgycoKGoLOigoM7Kc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RgwL9/6z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v7nDEcLf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+BHmAGsXXsVX201InINqOhrOXKGiIRskQiXRQc9sOc=;
	b=RgwL9/6z7cCHBxyrKRS2f+q/jfH5uptCubY7v3aNvmmMfL+KxXyh0B3IEtuF2mk9g267Vu
	KFgPBYwlbyJHFHC61NyLVH/5kZW0kpyL8YtYqPESZZsRGafW1ef63zfnqWXPj6qfpLp4HO
	okXGyhnaI0p9vQvmJw+Hh9nHawa/p9XbQAgqGLshhijEzCgo/wyaeoonoVbGnEBvkKiKC1
	VuzmUgLUyMa4uTOrApW4eYThvUlFan2BlI6y6LCsyndyabE+3ncwgh+g3Tf/JCMUeWUyHy
	nc2NRKLSRTgcCfgvFdN0qzsHhY7/DR03pqdohBOEgXMt/66VwmbrpkGmWU0Tyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+BHmAGsXXsVX201InINqOhrOXKGiIRskQiXRQc9sOc=;
	b=v7nDEcLfDI+K1ORUBfBf136sOdXfAtLZxVt0NSQKMjBE/Asi7z6nWxUo+oZDpw5Z5jOZ0l
	bh/cm66n3SWTVKAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v7 06/35] printk: nbcon: Remove return value for write_atomic()
Date: Sun,  4 Aug 2024 02:57:09 +0206
Message-Id: <20240804005138.3722656-7-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value of write_atomic() does not provide any useful
information. On the contrary, it makes things more complicated
for the caller to appropriately deal with the information.

Change write_atomic() to not have a return value. If the
message did not get printed due to loss of ownership, the
caller will notice this on its own. If ownership was not lost,
it will be assumed that the driver successfully printed the
message and the sequence number for that console will be
incremented.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h |  2 +-
 kernel/printk/nbcon.c   | 15 +++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 31a8f5b85f5d..577b157fe4fb 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -345,7 +345,7 @@ struct console {
 	struct hlist_node	node;
 
 	/* nbcon console specific members */
-	bool			(*write_atomic)(struct console *con,
+	void			(*write_atomic)(struct console *con,
 						struct nbcon_write_context *wctxt);
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 931b8f086902..f279f839741a 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -885,7 +885,6 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	unsigned long con_dropped;
 	struct nbcon_state cur;
 	unsigned long dropped;
-	bool done;
 
 	/*
 	 * The printk buffers are filled within an unsafe section. This
@@ -925,16 +924,16 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	wctxt->unsafe_takeover = cur.unsafe_takeover;
 
 	if (con->write_atomic) {
-		done = con->write_atomic(con, wctxt);
+		con->write_atomic(con, wctxt);
 	} else {
-		nbcon_context_release(ctxt);
+		/*
+		 * This function should never be called for legacy consoles.
+		 * Handle it as if ownership was lost and try to continue.
+		 */
 		WARN_ON_ONCE(1);
-		done = false;
-	}
-
-	/* If not done, the emit was aborted. */
-	if (!done)
+		nbcon_context_release(ctxt);
 		return false;
+	}
 
 	/*
 	 * Since any dropped message was successfully output, reset the
-- 
2.39.2


