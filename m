Return-Path: <linux-kernel+bounces-190089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF5F8CF95A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E8B1F2135B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5679713AA4C;
	Mon, 27 May 2024 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="prLPqaXY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lwTrE/7f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1903C4597F
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791906; cv=none; b=Zs3C6ElnveA3IiK3V+FlVJiCDW4T8TPyzb/OAfZu2LiGh4nOsVaCizB6MOWPYQMA/xWxD7M/NB2HSiC3RlGDlUF7PCG9hAlVPg9K8BJZW0mUnGXkYhyAko4rn9H7qXtHcVybxQ6LUqV/CdsWiWNmoOy8SLvtAAyRmyNzjqdF5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791906; c=relaxed/simple;
	bh=lwK7GcrDHEjSCVMCl6fH9fAyvwP+TuECoQz0KJrspIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EBYGl4ntQRRvgVilhe451W31T1vIuSGV4+Ag3wrZY9ENLc1On4imuynLOmXQMYsNxzByvf2h7t7waML3aeX8LTdClYFFscXYCvJjnqOMqHknRxoT4epbEHh8zt87a5fRr8EUZr+rULC5xrCKRAhnrBVt/tXqtkSMfxOO7LcGxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=prLPqaXY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lwTrE/7f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIB/C0kn4U7fgTEgQsG7CoHVIr2JrRBBOwabsQzPu5A=;
	b=prLPqaXY/YwLg18ps2ATzjroIHoOJyl8e1ibma8O9cTQJXRP1Cjk7ZMBB35DbQ3cej9yn3
	QEYGg8eXC+VR9BWb/xHw/E6fJSLCuiK3ZbbsrOHap1+tWwtHTgptypGdjem+0WVGVOoYjL
	cjGAVLVl8fmf7PLV9ykK0xNc3a5050fUPSb4TPuJdggKzIP0x3VOHfNF7Vm+9PkXoF86rj
	Ci9CEUDg7eqa7v8pjgvNHZ8sJ+GvXtrRoBH+70niNlohmEHCzmLet13UysEOhsuuK+65qE
	I/YOZC1f0tB4LqduIji/xSVfhY550Q+eNjdBCDuIMUnlUlHu0tsWH3MMrhbwJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIB/C0kn4U7fgTEgQsG7CoHVIr2JrRBBOwabsQzPu5A=;
	b=lwTrE/7f/XOHeBAl3/9gxDZ0udiSbhCfuTHx0npOCRd/B6GNSbaE9lDbrS1YK53WdAKlXq
	6GjO2SQO18TgYlBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 16/30] printk: Let console_is_usable() handle nbcon
Date: Mon, 27 May 2024 08:43:35 +0206
Message-Id: <20240527063749.391035-17-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
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
index 339563dd60bb..943e8f083609 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -87,6 +87,8 @@ void nbcon_free(struct console *con);
 
 /*
  * Check if the given console is currently capable and allowed to print
+ * records. Note that this function does not consider the current context,
+ * which can also play a role in deciding if @con can be used to print
  * records.
  *
  * Requires the console_srcu_read_lock.
@@ -101,8 +103,13 @@ static inline bool console_is_usable(struct console *con)
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


