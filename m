Return-Path: <linux-kernel+bounces-302571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2414960070
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54AB11F2221A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB2C15534E;
	Tue, 27 Aug 2024 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zJDbFaZJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XsWMBLoe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286513774A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733822; cv=none; b=AwaSCTPc6TfRpr6szGYOw712SQeVLi90Xafw6e3wWY6IsTzE6spvjQHdWqjMmnmC8Yq/7MEzRy+NhN5nUqffSMrXr0ujod2Bon6ELfCf/LiWKCcW1NEdBVfYqeGbwjkZ5hUJK1HOthIjZe1f7ctpQ6mh+wQMiYfnYXii9EQB4mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733822; c=relaxed/simple;
	bh=7eegQmt3hEyn9H+Al+bhIAM7Wh9qu2cgC0jacH9a938=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=doD9KUmAcgahq7Fuf9F/pTqOZ7qESkNMma2+bsyngLa//aKioETZwLcCSLLj0esbskz/PDkzR6rJDf8nRiK2HlmwXTyKtJyPsUK9Dn5OSNYvpfvdZcP8Lsq479ySQxgwGReIp2CwS6DWFTdppQG2id/dYtj+6s4SkIkEgniOUHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zJDbFaZJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XsWMBLoe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724733816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBCZPlALTUwtzeChOhHUyuQr3VmHSlElSg8MX8Xo0ts=;
	b=zJDbFaZJ3dor3p75i3vrjy8vn53rVPJvK711P1koDURg4YtUzdlx6iI5EnkRDXGukdRUXZ
	KjiOCvirDiIvBHJZa3k+guxbqvTFeJbT0TL+elKNwtpMfY6Yq7UXsnDcy/Ept/JEfcVi2a
	DBetpfMmfJLr85Nh2h8nH243MUUtowPSnrnf5x9sVocoxNf/I1ixotK+YqVXp/H0k9PTWb
	glmid337CfeXwOgq6d/hcDilql0DPvi9G9o5EpSDP3u1yMeRFp7Fb40wd4KJN3jHcH1TgP
	mdI3tMtbFqVg3B6shZJeiYmk01Pzra82Gy0rkMx9yuM781fPT+fZFsa4MVz1aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724733816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBCZPlALTUwtzeChOhHUyuQr3VmHSlElSg8MX8Xo0ts=;
	b=XsWMBLoeQUxGzuv/QtRub+Re0AAfP0QV2Ek9wUlbhYm5ehv0Gl0M0E2gD6Bi0kcY/4hZY1
	5ByFdUKUilsRXYAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 07/17] printk: nbcon: Relocate nbcon_atomic_emit_one()
Date: Tue, 27 Aug 2024 06:49:23 +0206
Message-Id: <20240827044333.88596-8-john.ogness@linutronix.de>
In-Reply-To: <20240827044333.88596-1-john.ogness@linutronix.de>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
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
---
 kernel/printk/nbcon.c | 78 +++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 64ddb038f205..16e7d992b054 100644
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
@@ -1311,45 +1350,6 @@ enum nbcon_prio nbcon_get_default_prio(void)
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


