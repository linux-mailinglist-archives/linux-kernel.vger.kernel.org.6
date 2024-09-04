Return-Path: <linux-kernel+bounces-314961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46B396BB90
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA6D1F23394
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757D184A21;
	Wed,  4 Sep 2024 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wBscBqek";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j1/qMuiv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789351D67B1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451540; cv=none; b=mrfZsOYM26RICAppvqv0r10TlfFkE2x/23F+nDjsyrAhmyrXSRQBodlpYBhM2Zv+vkEO8G7WWhsZRwbrzEKh4MQGPsRe9h6OBZXOWfqO7c/U8KIzzGxTmHrYCZtS1MikprdBHPoP8W1BNcv3AGsTszE88Y186i12VLEpP7tVt3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451540; c=relaxed/simple;
	bh=hO2oomLoxf/bUX1WgRwfUv7yEovKt+lixG0W+vCa7/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OErf0IBJygb6jtR93aZb+sB9ERQbisow27FwPuo10CcUu0T+TwCTJKM674RdkpicrYL8214/Hc4eYP73Qi43pvZMARWr/3rNuL1OXIcvK7x9pkcVg2FqZXLkKnXmvKfJ727WyJ9fzVGr3x+E+Zp/RviDAlWB4esmkCOLPpPvHQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wBscBqek; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j1/qMuiv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725451537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRZKVWxZPmNsRkG/dsm1SB0+wvFuf66EXj0bGb54vtI=;
	b=wBscBqekqbUTKBDwi5lQXelbsMHR1/wu5d9skipfD6izU2Al2sZ3Xj1nhuJckeD1J99hWn
	xsB8OP9gkpD6WGg2Fz6w+h0Mkkndz65uWzhPUUEBZeAteV65p94HrpPjBmqBZpzplXwuRE
	5cwQr4em6szMSK1XwEuHCx9c+naKiXGya7hVnMobyoUKJPEAKUkj7RDxwqwsg0eTRt70hD
	Gwkeuk9P6vwFuyyHwu/6uJMPbgZF3dMI4SysDW9pULg7RWG691E8PhSB2kAluyc7yZH/Ad
	+7gN6hfglDw5xGwJnB7qAdx7QjJ9P8aRAiB0g0xELGhOHLcv0zYsk9a1phTGnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725451537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRZKVWxZPmNsRkG/dsm1SB0+wvFuf66EXj0bGb54vtI=;
	b=j1/qMuivH2B6W8O9kk951XpJxx2OurhTlvpHkyAuVo1mhB0gs0LYl4GrrmWVQCmLILwMKp
	26rt4cN/HsSMqhDw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 03/17] printk: Flush console on unregister_console()
Date: Wed,  4 Sep 2024 14:11:22 +0206
Message-Id: <20240904120536.115780-4-john.ogness@linutronix.de>
In-Reply-To: <20240904120536.115780-1-john.ogness@linutronix.de>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
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


