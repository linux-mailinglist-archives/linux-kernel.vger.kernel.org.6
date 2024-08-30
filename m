Return-Path: <linux-kernel+bounces-309038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A251196657A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F072285EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FEE1BA261;
	Fri, 30 Aug 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NRXfbyMF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W8DlDLpq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE911B81A9
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031769; cv=none; b=MwlM/KBTFsW3iYQ6CdUMwMIFqLTQvfVCkGNKQNHJIKLXfCXzZnv12pwCXc2DVIZXVXBlJADTp1alNrH6vv8XrZ7Lu4/bCvWSb2zbssRcDxqefAqH0rBs7MoZrqohY9WEHyROKY0ymvbjYig5fOntBWzzvAgGafA07WTPQi73JC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031769; c=relaxed/simple;
	bh=ruzArZlZHwTfGS9fsg/jLKUMRDaHRxe43i2xOb5V7ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEz6uTkjyC2KjtuFX0TH2kjadGZSdyeme3lqfhP9dhrc06T4bv/etSx/t1spIHdRT6492gdZ5snxsN02tiW55iKGDT5JOzJQ6cuaFrNKhSlO+rh/UnXFdwr74QNfsAfdEd4VQ1CsRZsdNuQSLFXEb/kPbr3TZFuTHpaZIh9pFpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NRXfbyMF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W8DlDLpq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725031758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zqmn2pFt1/sOwz2b2uJyqHM05n1+rI1nWkzMoev/7nk=;
	b=NRXfbyMFcAHLAsk/Crwn9iT4+ZuOFuAEAdNYZG6hRGI9Ejm3P0W3UhUL4HsBNWPZsbP/Kx
	U0GMMlTy1wFHg+nezMhwOSVuhxH6Un1oMMG3YU5R2K2CAOPyqygvkEIQezstCdcW51WJlD
	+Gv4R3YKWwwATQqbXuHSuMc2T/yHAwrazPNMNbQsM48qBmet2QSSUzBuOJHedE2Xi80Ylf
	vgbechKS+mvq1HLzlun2QZG/PBCFMJ/OM4CfL0qr3xop9QJiAhW5RIPVlpNoQ51C0vqj54
	SpRHVv3k/c8wM1ZGSkNJIlrEOr9rZI9SrCYfRUkB2gImZGN4r8WOrfGSkiAwTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725031758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zqmn2pFt1/sOwz2b2uJyqHM05n1+rI1nWkzMoev/7nk=;
	b=W8DlDLpqgqVtlOwtMVz1BIYuO+CC2yGAQeRthBuT0BXACZgrUjBWEj1DVEckjldDx20G0e
	VcsTS6CwxOqK8TCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 05/17] printk: nbcon: Init @nbcon_seq to highest possible
Date: Fri, 30 Aug 2024 17:35:04 +0206
Message-Id: <20240830152916.10136-6-john.ogness@linutronix.de>
In-Reply-To: <20240830152916.10136-1-john.ogness@linutronix.de>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
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
index de6faf34e114..fbf29b3a0811 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1398,7 +1398,13 @@ bool nbcon_alloc(struct console *con)
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
index bd2a892deac1..ba778e2ef28b 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -403,10 +403,12 @@ u64 prb_next_reserve_seq(struct printk_ringbuffer *rb);
 
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


