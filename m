Return-Path: <linux-kernel+bounces-302568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D03BE96006A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D441F21F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765FE153835;
	Tue, 27 Aug 2024 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UEZHoLBa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rhgk81Qj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655561386C6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733821; cv=none; b=r5SbQV+rrQfAagsd5RvqIzNDEFBdGQbadsRpJXw+kL9rz2Nppd+KdAa9ozWIBlB8YLCc0NGsuy0GuZ0OQeJhQ1rgPDCBuJZij3VYZyCyJ3OEZnU4fUftq44ERkB9z80JvAsiLp+hMISEuiwC0R3eKuvORzLIfnjQpIKZdBeg7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733821; c=relaxed/simple;
	bh=IEMoa9FR09sPw0lhjIBqmf3Q6HccXUpasdLnSiDglEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b4wY6LZwHtpWKg8eH11NDhU1oV7eMmwwLdkktURbA4C2yksru7Hj1xiyPMkp7WlbJvtbLmrS3WnJFzYOTzzp9D8rdqa8ON+/s7Ta16N3ugwFDYOHQYJQ0GvF4d1ILR161Y1Kw83njecMSbNr6JnshbnWrHz27xNJwDGJ1mqqaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UEZHoLBa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rhgk81Qj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724733815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGwR2dGA2mrkS6D1DBAcrQOGxVjlY0VD3AieVmQrH8c=;
	b=UEZHoLBaqFjcBJvRRTO1GBUFxtgaPMlUY0cHoVH2dbhUmSHF2or9ffaKX/CgWwXx3BPiQM
	r612sEGPBS2UJ+g56O94bROiSXgZDZiSQ9wa72fG3zKpIi4K3VTIg/YM5oxOESODT6X3HD
	tU/DYq5AbKDex2sPdIDTGCgiVXlObZ1K00JS1sjJYdTQ1D1Cn/iAHXZdjzGYe4ggPfQwBN
	zeN+yaZyIyOATYAjy62+gDk8JcK0jWU9WrIyvjXcMsg6739gHJTecz4Iz2boEI3Cbm9eGs
	7riiySNrWvaBfiUmyNBdnRZ6bdIaiZeQxIQNXvqKH5us2C+pJggP/Qsg6gkbAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724733815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGwR2dGA2mrkS6D1DBAcrQOGxVjlY0VD3AieVmQrH8c=;
	b=Rhgk81QjX6OXHyrXOFxnRImn864CmhI1vSwE2OwDFPD2e/QK3x+xhMN0TQivVOXVHD9uqp
	yQyUWBZjWaCnDVBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 05/17] printk: nbcon: Init @nbcon_seq to highest possible
Date: Tue, 27 Aug 2024 06:49:21 +0206
Message-Id: <20240827044333.88596-6-john.ogness@linutronix.de>
In-Reply-To: <20240827044333.88596-1-john.ogness@linutronix.de>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
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


