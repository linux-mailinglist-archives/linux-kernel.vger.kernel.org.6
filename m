Return-Path: <linux-kernel+bounces-314965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516CB96BBA6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD62B22A4C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2203C1D9329;
	Wed,  4 Sep 2024 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r4h1jT/6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+PATdPwH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6A1D86D6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451544; cv=none; b=hyumpB2O0OsedM7K57jYCIwhiLfS7oYoE9EzRFGVD5+bLh441AYaDNdnMD56oPDeku4lm4QY1dpzjFJRqyTc/6MH74RynqvH57HODAfv/KpY3KMpusk6Zsr0VzvXHcHavoCidrAXjBEwhYAjD1Fryfy9fZZhk5Kjb3obczqtZA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451544; c=relaxed/simple;
	bh=N3y4NVSDwqF/2LlHYFmORUU/oETj12yErrcb8bDljfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKfXdTp/pmNIAfnHpbLA36BVPgi/hVcH1kQ7EmXlqSL9kfuHaFK4QeXbafS08v/PbvWkjf9N03nsqBhh4jnwTWAMzNBJj2bi1XkWXtUNyaiC9DFwhI4/NmL6r9iLubu6VC2XwgjdbGSizYmMNBiUY7+D8bJOtTIzdqxg35td0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r4h1jT/6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+PATdPwH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725451539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fDI5AMTAMNrhyTbS7cInQkYyi0gPwnB+MndWEhqxvg=;
	b=r4h1jT/6aHa5G3FoH4WHs380KGNqzXGHJsjWv6/eEuiiTUB6gPlb96zz7NKAoqZ60veFyM
	MX3E9EDCy8SeA2P4v3IGh3oWDBhaJsZWfwhIHWR1N0IL5Iy2lETPEt+iqCXvsUhjt+n39f
	8jZPn1F5DWNnqqOqldiPTlvPHhLGSIGuChFgbn1a+3ymJuHx6GDhcWeF1UGhEI162kNElG
	V0RynTRWClzji1J91cYVAAGF1zwciWpoXcS3l54QwArAf3yykmIByGdzAdwGDisqnlgFsy
	yUGGIF7RHDNGgadqJrL0jNoevaKzAwSPhf0R0RyeAeWjuGBB17LNzLaLgV49dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725451539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fDI5AMTAMNrhyTbS7cInQkYyi0gPwnB+MndWEhqxvg=;
	b=+PATdPwHKctUEoMTZaIbdrV3lWANJP7VbCCXoQPSw1ASB3RlrE/yPg/GAHqnlOo/LtcgYh
	EWxkOhyMgZ0qivAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 07/17] printk: nbcon: Relocate nbcon_atomic_emit_one()
Date: Wed,  4 Sep 2024 14:11:26 +0206
Message-Id: <20240904120536.115780-8-john.ogness@linutronix.de>
In-Reply-To: <20240904120536.115780-1-john.ogness@linutronix.de>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move nbcon_atomic_emit_one() so that it can be used by
nbcon_kthread_func() in a follow-up commit.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nbcon.c | 78 +++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 388322c74349..57a0e9b542fe 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1042,6 +1042,45 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	return nbcon_context_exit_unsafe(ctxt);
 }
 
+/*
+ * nbcon_atomic_emit_one - Print one record for an nbcon console using the
+ *				write_atomic() callback
+ * @wctxt:	An initialized write context struct to use for this context
+ *
+ * Return:	True, when a record has been printed and there are still
+ *		pending records. The caller might want to continue flushing.
+ *
+ *		False, when there is no pending record, or when the console
+ *		context cannot be acquired, or the ownership has been lost.
+ *		The caller should give up. Either the job is done, cannot be
+ *		done, or will be handled by the owning context.
+ *
+ * This is an internal helper to handle the locking of the console before
+ * calling nbcon_emit_next_record().
+ */
+static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	if (!nbcon_context_try_acquire(ctxt))
+		return false;
+
+	/*
+	 * nbcon_emit_next_record() returns false when the console was
+	 * handed over or taken over. In both cases the context is no
+	 * longer valid.
+	 *
+	 * The higher priority printing context takes over responsibility
+	 * to print the pending records.
+	 */
+	if (!nbcon_emit_next_record(wctxt, true))
+		return false;
+
+	nbcon_context_release(ctxt);
+
+	return ctxt->backlog;
+}
+
 /**
  * nbcon_kthread_should_wakeup - Check whether a printer thread should wakeup
  * @con:	Console to operate on
@@ -1319,45 +1358,6 @@ enum nbcon_prio nbcon_get_default_prio(void)
 	return NBCON_PRIO_NORMAL;
 }
 
-/*
- * nbcon_atomic_emit_one - Print one record for an nbcon console using the
- *				write_atomic() callback
- * @wctxt:	An initialized write context struct to use for this context
- *
- * Return:	True, when a record has been printed and there are still
- *		pending records. The caller might want to continue flushing.
- *
- *		False, when there is no pending record, or when the console
- *		context cannot be acquired, or the ownership has been lost.
- *		The caller should give up. Either the job is done, cannot be
- *		done, or will be handled by the owning context.
- *
- * This is an internal helper to handle the locking of the console before
- * calling nbcon_emit_next_record().
- */
-static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
-{
-	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
-
-	if (!nbcon_context_try_acquire(ctxt))
-		return false;
-
-	/*
-	 * nbcon_emit_next_record() returns false when the console was
-	 * handed over or taken over. In both cases the context is no
-	 * longer valid.
-	 *
-	 * The higher priority printing context takes over responsibility
-	 * to print the pending records.
-	 */
-	if (!nbcon_emit_next_record(wctxt, true))
-		return false;
-
-	nbcon_context_release(ctxt);
-
-	return ctxt->backlog;
-}
-
 /**
  * nbcon_legacy_emit_next_record - Print one record for an nbcon console
  *					in legacy contexts
-- 
2.39.2


