Return-Path: <linux-kernel+bounces-309037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA30966579
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E2E1C23224
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F53E1B9B5A;
	Fri, 30 Aug 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m+tKLmij";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nVf41HDp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1511B790D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031769; cv=none; b=quXb6+y/9zmv5QE/3Oh/Ucl4VDRGoZwDVd4CfEZxsI71ln0MPJJyz1kI6byNiP9MdaSavdJsSX/CkSVQL3GBdO/tvOIljy/4MSQ+NUJpf108zFVoBeJwSjKm2nMH0ghxSPC+wZbK8yadOmkI/OXWQ4axm7yaeli3Z3f/VlONcoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031769; c=relaxed/simple;
	bh=febIYAM5vIRVW3oul4SfxzgPr5QxGQCshZCHHjI8lGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S7CN6bdQeVVHxUZIwaFTl7FbwXCY+2K1Te4tFCGxIDZUOCu5pKJ6QkRkihHmuBSLLNPcrkTfzAESMQMV0Y+4wvVcs7V0WgLvTp+5LeNflk/oO0gsyf72diAXdgroZLlO3zpu640vyKqiEhbRB6ePTZGDSgXG8TBK3aOW/xv/WL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m+tKLmij; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nVf41HDp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725031759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SW2mDi81ohzukBzY1YP+ImgLBDt2qqho9NcptWHgjCk=;
	b=m+tKLmijpoktM0RPwF4ktmdHfIFsCG9q7GypDT/l10CVOUzzyz734YYF4RzpseaHYsG5Xy
	sCgVU5BoR/N+6BDm5Iu9kZlDNFHHJiqCfXL3KKZF3fPlq8aVs8IwaNcTQiMsuJJpu0ucAr
	OCm4mkMFMVBRenb+aqwOwTHlo/h5+ziyQFl/4dIQvhOshdoxRpHgC0hzm68/c8OCFucCmS
	vezQUMBU1G5ZgMzKoMRn+ha90xPcp2SOZfbPdQgsyK9kofLNrfrHJYUBcv8uI71j4oiKOa
	Q0328h7qyOGFU0ZSu+W+6NW1ZZUdoP/SEoxmJRd1WqbZoZwzYSw0HIeJX84Wvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725031759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SW2mDi81ohzukBzY1YP+ImgLBDt2qqho9NcptWHgjCk=;
	b=nVf41HDpfytlSC6TPLBwHTAs7gQtjf9Q3/+CGypsqZQ9gGt4mVxMv8vAXvrM0nd+rGGz2w
	YnPsoqJuwJev7zCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 07/17] printk: nbcon: Relocate nbcon_atomic_emit_one()
Date: Fri, 30 Aug 2024 17:35:06 +0206
Message-Id: <20240830152916.10136-8-john.ogness@linutronix.de>
In-Reply-To: <20240830152916.10136-1-john.ogness@linutronix.de>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
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
index 40d00e92494c..807ed6221022 100644
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
@@ -1317,45 +1356,6 @@ enum nbcon_prio nbcon_get_default_prio(void)
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


