Return-Path: <linux-kernel+bounces-199826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF388FA66D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188E528527F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABFE13DDB9;
	Mon,  3 Jun 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qV+sNGum";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Odj4u7ry"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2CC13D2B6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457101; cv=none; b=ctYBUu8ZCn1ukvgVt7Ni7jgguVvbphu7GSvqv+wivIC62r1CLmYtKsI9xVrQvS/KGgf72EOgQXDule8c5FQVLsoBf+B8TR/DANru7GvSZCSy9QqPAa/6kz6z4+h2ALw5Gx413sbHcssaMJqHKTOr1KGq9LsvnxNF0SjQaOPL0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457101; c=relaxed/simple;
	bh=nJLUOO0kFbQq0mpsWpx/7kA8MXGjckBsDAJO8NTpM6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=imtgu7wmBanP3AWaxQE586I36OTGsMNELklUYS+u6GmFDqr2ISclFRi/V8cAPBrT2HHqa5WZuFW2I0eBMCy8Aq1zGwunHWkmbDWIPNWEyWbkesEF0cfaOAMqPrc9t2OskqCtw3aP0GBwFTLrNxTFhMqodduJ1o1di7Fs2/Sq3tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qV+sNGum; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Odj4u7ry; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dj4gOrMYbFMlZqhfQ1sjWqCRmrh47Yb6HFMI47V4kYM=;
	b=qV+sNGumgD9wkX7Nv8ydFkhKqx9YqMjfbJ8zEq9ngIMylq4Ev76annalIm9kksCu5+HfFe
	0bcAvNygHFrlh7zvE6jGtoYi4KYzHR6sp2GJqMGu4+lF98mLP5nURHdvjCePu++MhXEeQR
	SLGZyZwKYcgvKGBF+HG6MkWwVeoJJ2e4LTiABIe2yitQ6PUE8unOk6yizO38mtQowL4qcU
	9PsiFmgPDTouoagtWYmpOL4GKX04VPKBBCzyeD243BnH7Ige0D9N2YZjYxPZob2j3psozW
	9Ps1+Vvpi5MKDkaLpT92WQmSiwqeCRTqDALqIpGCWPsv5WIYC/IHDsBkHhK1nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dj4gOrMYbFMlZqhfQ1sjWqCRmrh47Yb6HFMI47V4kYM=;
	b=Odj4u7ryDDsbcjDhjQhN0ZkCrkfM7T/t16qNZj1P56qCxrpCFxqIIbSVXKctpwrhWkRXmg
	t4hFUzIaZ+YnuQDw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 05/18] printk: Atomic print in printk context on shutdown
Date: Tue,  4 Jun 2024 01:30:40 +0206
Message-Id: <20240603232453.33992-6-john.ogness@linutronix.de>
In-Reply-To: <20240603232453.33992-1-john.ogness@linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For nbcon consoles, normally the printing is handled by the
dedicated console printing threads. However, on shutdown the
printing threads may not get a chance to print the final
messages.

When shutting down or rebooting (system_state > SYSTEM_RUNNING),
perform atomic printing from the printk() caller context.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/nbcon.c  | 5 +++--
 kernel/printk/printk.c | 7 ++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 89b340ca303c..19f0db6945e4 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1297,7 +1297,8 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 	 * context must flush those remaining records if the printer thread
 	 * is not available do it.
 	 */
-	if (!con->kthread && prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
+	if ((!con->kthread || (system_state > SYSTEM_RUNNING)) &&
+	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		stop_seq = prb_next_reserve_seq(prb);
 		goto again;
 	}
@@ -1639,7 +1640,7 @@ void nbcon_device_release(struct console *con)
 	 */
 	cookie = console_srcu_read_lock();
 	if (console_is_usable(con, console_srcu_read_flags(con)) &&
-	    !con->kthread &&
+	    (!con->kthread || (system_state > SYSTEM_RUNNING)) &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
 	}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 137bd9a721c4..b58db15d2033 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2389,12 +2389,17 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 *
 		 * - When this CPU is in panic.
 		 *
+		 * - During shutdown, since the printing threads may not get
+		 *   a chance to print the final messages.
+		 *
 		 * Note that if boot consoles are registered, the console
 		 * lock/unlock dance must be relied upon instead because nbcon
 		 * consoles cannot print simultaneously with boot consoles.
 		 */
-		if (is_panic_context)
+		if (is_panic_context ||
+		    (system_state > SYSTEM_RUNNING)) {
 			nbcon_atomic_flush_pending();
+		}
 	}
 
 	if (do_trylock_unlock) {
-- 
2.39.2


