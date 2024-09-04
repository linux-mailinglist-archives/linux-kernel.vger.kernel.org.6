Return-Path: <linux-kernel+bounces-314964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 880D696BB99
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD651C2194A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD291D88DA;
	Wed,  4 Sep 2024 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZdJm6OCM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0YOJvmnv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6091E1D86D0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451544; cv=none; b=bW6hQne6/atLlDXOZSZE0IV/YBk3wnXNrM/9nF6iMZJ9cD007c39m1L528SXEJKRFFgWPiuXFvv7JKZGP7CkAYGf3LZXqrp5PblcAfubDPoZzjKheuYQi1MU9EvVKYbZRkOAloTiznoJR1hS47QhF3CouM4B1s0TO9H/tNbMBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451544; c=relaxed/simple;
	bh=5DiK887VpuVsdWv0pAaa4eWMt9zIgcJRJ1PVYLIbvYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dj7W/M5Eiuu6moQFLGDH5hwk51cxSEMkE2LbvwiIYpUXioCye6aiuJWb3Vjv8GL1tpC6MZrDvg0ivrlSGwGdHaHUgRStHIisfA2hDu4XF/dRZWEFgdaoUR70lkK9F4pGgKkBC6npLt1B5q5TxtZ/22Tc5mb2N2YBDspui49wXe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZdJm6OCM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0YOJvmnv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725451538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7ocabgxMTf5jsSttq41NIlLaRrow5SxkoqyaH9YaVU=;
	b=ZdJm6OCMTwLaC2Cb8JgVeNJXIg5epIrH/3dQd7A88MdSygKqzd1f+dsBP1oHtS/PW9OYH5
	egxZVSxdU5gMuIU0AyUjlzSuuJ0Qs71x3njbrLVcZij3SIl7g+F7+Afjl9fsKaah1JouEl
	amvh+MiSNGZr8D0NxyULXNRrEyEFLLOOiVc5TfTs1KAae0fiPoSzGjJFw/xKR1E0GfrrmD
	a1aXYOG7WN0/Wvhzw/juEQ0QO1NJILeriOUnPYjQK77e5mY8WOsWMkA4HHqsOFTX6XKUct
	bBMHHMQ1ZEt/5m1axMXlmVjNjUXF0ifIYb1E65h5YpNGE1qII8W5evrKEpjsrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725451538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7ocabgxMTf5jsSttq41NIlLaRrow5SxkoqyaH9YaVU=;
	b=0YOJvmnvkk/NrGr3E/+kwwhrquMY5toJh9M4poOthNLN32nl/CAGAehmdT0mIk1o+2UxH3
	TcfkBZO5CkDbVDCQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 05/17] printk: nbcon: Init @nbcon_seq to highest possible
Date: Wed,  4 Sep 2024 14:11:24 +0206
Message-Id: <20240904120536.115780-6-john.ogness@linutronix.de>
In-Reply-To: <20240904120536.115780-1-john.ogness@linutronix.de>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When initializing an nbcon console, have nbcon_alloc() set
@nbcon_seq to the highest possible sequence number. For all
practical purposes, this will guarantee that the console
will have nothing to print until later when @nbcon_seq is
set to the proper initial printing value.

This will be particularly important once kthread printing is
introduced because nbcon_alloc() can create/start the kthread
before the desired initial sequence number is known.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nbcon.c             | 8 +++++++-
 kernel/printk/printk_ringbuffer.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 88db24f9a8de..bc684ff5028a 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1397,7 +1397,13 @@ bool nbcon_alloc(struct console *con)
 	struct nbcon_state state = { };
 
 	nbcon_state_set(con, &state);
-	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), 0);
+
+	/*
+	 * Initialize @nbcon_seq to the highest possible sequence number so
+	 * that practically speaking it will have nothing to print until a
+	 * desired initial sequence number has been set via nbcon_seq_force().
+	 */
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), ULSEQ_MAX(prb));
 
 	if (con->flags & CON_BOOT) {
 		/*
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 8de6c495cf2b..4ef81349d9fb 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -404,10 +404,12 @@ u64 prb_next_reserve_seq(struct printk_ringbuffer *rb);
 
 #define __u64seq_to_ulseq(u64seq) (u64seq)
 #define __ulseq_to_u64seq(rb, ulseq) (ulseq)
+#define ULSEQ_MAX(rb) (-1)
 
 #else /* CONFIG_64BIT */
 
 #define __u64seq_to_ulseq(u64seq) ((u32)u64seq)
+#define ULSEQ_MAX(rb) __u64seq_to_ulseq(prb_first_seq(rb) + 0x80000000UL)
 
 static inline u64 __ulseq_to_u64seq(struct printk_ringbuffer *rb, u32 ulseq)
 {
-- 
2.39.2


