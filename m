Return-Path: <linux-kernel+bounces-293346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3498C957E32
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62D728494B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6201DF68E;
	Tue, 20 Aug 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OX8jcz2R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rIu+esqJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17681E4F0D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135415; cv=none; b=f2XncbNEBJAXdPBiIKwx2O421L8M13i6hb6RASrRR3HW7JS829RFmf2Hi1qXMqu9/VGrbQwNx+bbeTPDEVBPPM4WC5X95B4wbLO5ylDWPO+NPR7dizDMawJ4BbYhKfz4KdO0KX/G6f22CVhat0nw3+mhRysKWJcK4vmyzEr6uSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135415; c=relaxed/simple;
	bh=Ov5T451CRpMNZDviwPZPsNDiuJcBYgBNHBKPViE70gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hEkPg/Wq9lzMVf+/n9x9p5O36QbLlZAkKSxRBwFuIenDOQA9WbDNJ+Eb02wgSzLACzLIGjn4hR35ISJqkPJDMNztmnPTI5FtGqusJts3GvPp+TzODst2kq2lUOttVCTDZ8GQSb0PGn/ULqAEcY6CvMwVKqSTEY0BK++bg3ZmdDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OX8jcz2R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rIu+esqJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIvGXSI9zL3LqtnkQPrC0V491Iai+TRLLKit8ny2zJg=;
	b=OX8jcz2Re13tjvuvykH6DmTSr/jvfVQfvRxATAYHZcokgyNB1gGRGnnayj3DOGta0u/zeU
	6U2kFC88Bdxg8M7OZ+X9TE69ztA0pAsZxIIt4p/F3bbW4QahHJfNikkms97EXWKzuynR7J
	DVZhpAripBFK27WIiGWD3ifyQ0NG3lSbZ/w5xRsuERWLCYUWqt3dWmVJCTmMRhsoXSVcTZ
	kOcG4xB75T1cd+jJ8YKHbYjZNZx8Z1m5tRAcn1ljrTpyMNDz4LM2zTekQl8nQMtwx2yJCP
	IJNB4aRVhCuDxMBnUCELkLIY3LY8vT3z1yX60wTiIj8OPPMMvxN0DzMQb1wMcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIvGXSI9zL3LqtnkQPrC0V491Iai+TRLLKit8ny2zJg=;
	b=rIu+esqJj4I/N+UlV8r0wTRCMbX4hFMBy+GW9gZy/ahQvbx3rhDrX/xHS3DvymrJ1Sd64Q
	zkbeXmnvQUXf+/Dg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v8 17/35] printk: Let console_is_usable() handle nbcon
Date: Tue, 20 Aug 2024 08:35:43 +0206
Message-Id: <20240820063001.36405-18-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nbcon consoles use a different printing callback. For nbcon
consoles, check for the write_atomic() callback instead of
write().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 5d9deb56b582..448a5fcd5228 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -86,6 +86,8 @@ void nbcon_free(struct console *con);
 
 /*
  * Check if the given console is currently capable and allowed to print
+ * records. Note that this function does not consider the current context,
+ * which can also play a role in deciding if @con can be used to print
  * records.
  *
  * Requires the console_srcu_read_lock.
@@ -100,8 +102,13 @@ static inline bool console_is_usable(struct console *con)
 	if ((flags & CON_SUSPENDED))
 		return false;
 
-	if (!con->write)
-		return false;
+	if (flags & CON_NBCON) {
+		if (!con->write_atomic)
+			return false;
+	} else {
+		if (!con->write)
+			return false;
+	}
 
 	/*
 	 * Console drivers may assume that per-cpu resources have been
-- 
2.39.2


