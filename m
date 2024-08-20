Return-Path: <linux-kernel+bounces-293331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2770D957E22
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF88A1F22DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD23A1E3CC0;
	Tue, 20 Aug 2024 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tnpZu/vA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dGFox0hz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B31DF668
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135410; cv=none; b=oMbhl12hCgS//i6Dd6hKplYUiLSPfpxN45Qj1yht41NK/8/BgZbwxb3RMb/zVUgskdt1X0WrVyTRU4EYMSroM+eQAbilYAGWIdVOoVHiR7547/5J9m0UBrY3wKiAQYayd78mvpvgK9Rq/3vsOrDamqh+PbKk8kyupX3EHgP/yDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135410; c=relaxed/simple;
	bh=FFxAFuODw+P+vrod+fHArz08EUy3UXy/c6t6YmdCMUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eNl3Zvz507DtoR4ywh2TucDfLMYlFxA1uJjpQw2ogerW/EvKMWoRPq2qPo/MPMf2Rf9CCL15KmH0nZGC45HdZBVJd2X3gDSf2JXPpUY4xlakCXdMcN1/wSGg6FV9HCJa2vp6bQgire2JhbD+v+8oLQY8L+JvMPoQgrgNIc3swP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tnpZu/vA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dGFox0hz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+BHmAGsXXsVX201InINqOhrOXKGiIRskQiXRQc9sOc=;
	b=tnpZu/vA0I7Ua6RPUpZRAByX/oAsk/xKfpsoMuuVoFGpNVrySBMqOOFMOX2UkL7BzF0TzS
	vWlR8S9QBCg4V6lqAmrva+MyB0l766/dxua8OVYKKOeHBwODpQtFa2W9gxj0CgiQdzBzjQ
	tINh2bmKL+mnSIoXqMdvGU9qBnHoGOG9VDN6KaiLLkYblYgt9Lq2Nog6O+6Ibu8xzWTnMp
	NtHN03NSIr1K8HzEyOctAX2ft7OTdoh02i3AL0DaHm3I6KMoY3HtJPd58M65EeBZmxy9AP
	ihpatlvbbq5rB51UIxusQKTN5LkoxVmG2id2DlcJvfMCLcQBizq24EQwt9MOpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+BHmAGsXXsVX201InINqOhrOXKGiIRskQiXRQc9sOc=;
	b=dGFox0hzjR/7GSRyhhu5LqfYSy2PlZasfy1ZwiD17b/ANZ5v1GHdj+o5LjcCzDVB4tWZ2D
	ED9oJV3sIREs3UDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v8 06/35] printk: nbcon: Remove return value for write_atomic()
Date: Tue, 20 Aug 2024 08:35:32 +0206
Message-Id: <20240820063001.36405-7-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
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


