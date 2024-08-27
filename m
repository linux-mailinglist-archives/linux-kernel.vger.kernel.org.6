Return-Path: <linux-kernel+bounces-302563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CC4960065
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A432830CD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE5E7F7FC;
	Tue, 27 Aug 2024 04:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MQ1zuCj6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kDS3R9wb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5C456458
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733818; cv=none; b=Dr8fcT7QTUNmNtUYHprN2FDBZ3ZcF6SVs8wro+DlWGJeAGvIkSZgBDAqtUBImr31BWY6RRGcpbyfuLPLIFttX5jNMnROHFO0mN2LNzH8jwH6H1gxdwFyNGimB8Ak5p9QhP9r1yMf86jR/TDbFae3dPAYU4lCQRT68WOogzLexzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733818; c=relaxed/simple;
	bh=hO2oomLoxf/bUX1WgRwfUv7yEovKt+lixG0W+vCa7/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AYMvsM5iuxOSz9gBjRyLPdKzbKHGze/LjI+KA+AaNF3uG31Ugl8uraBkY6o24L533U4IJQqFOZFtrTHDxMcbjLi7Fy4vpIjR0LOuYtTnnO/TROb+VHim+Q+W7t2h26hZbOw6Lgx7VpX5S8zU+eW4/ddB4iQ+mK8ySrtBBCXdbDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MQ1zuCj6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kDS3R9wb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724733814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRZKVWxZPmNsRkG/dsm1SB0+wvFuf66EXj0bGb54vtI=;
	b=MQ1zuCj6BHvtiS0v32ZNi74j/4Hhbxg/NUGtYqRLBx43SPMvEOJswDGHMrTNlMBS1lJ0/D
	o9x83rQq0t/9HUKkSmAYXq/pShiM3Zuw60UyVWsUVtoj3h7J5aGkME6dw9md47hxt51aiO
	VzSrkFDcb/+pL1DfudoR0em6BRq5VDOkavaAobGIfpTTQWZ4HB9vP16limXHmKKj78KRPG
	qes588SjaVzWHNiCbSC0SfFwYdtGIOX8rvHY2IF0oTpb+3xOTf8sF7KRNCtjQ+oiW10e/c
	oUNHnc1SfrVtrMbc7smJ0wXyQWcgJfOIsbpxYh3ys/szY/t5AKc4BfPvPJxP4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724733815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRZKVWxZPmNsRkG/dsm1SB0+wvFuf66EXj0bGb54vtI=;
	b=kDS3R9wb4qOx0/BXyHuvie1s2i76XVWrvYleWfFfJe/zyFg1EVo36MkKa3wSyBppHi64rw
	Llfht/gwPLE4oUAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 03/17] printk: Flush console on unregister_console()
Date: Tue, 27 Aug 2024 06:49:19 +0206
Message-Id: <20240827044333.88596-4-john.ogness@linutronix.de>
In-Reply-To: <20240827044333.88596-1-john.ogness@linutronix.de>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure consoles have flushed pending records before
unregistering. The console should print up to at least its
related "console disabled" record.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index acf668001096..c79e962b822a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3771,11 +3771,16 @@ static int unregister_console_locked(struct console *console)
 	if (res > 0)
 		return 0;
 
+	if (!console_is_registered_locked(console))
+		res = -ENODEV;
+	else if (console_is_usable(console, console->flags))
+		__pr_flush(console, 1000, true);
+
 	/* Disable it unconditionally */
 	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
 
-	if (!console_is_registered_locked(console))
-		return -ENODEV;
+	if (res < 0)
+		return res;
 
 	/*
 	 * Use the driver synchronization to ensure that the hardware is not
-- 
2.39.2


