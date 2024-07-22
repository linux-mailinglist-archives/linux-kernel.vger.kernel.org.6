Return-Path: <linux-kernel+bounces-259243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDBF939319
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1992728283D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C40916F8FD;
	Mon, 22 Jul 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YjLvp1yp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v7EacWjs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA2016F0D8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668791; cv=none; b=jd12RkK0dYcTVEV+dh79v5pRhxEJmeEnt3jaf5BFYQIapKFXNQw9y0ng5ZapFYeH5kR/Mqtuj4CuhKOGJUtnE1gzpjdbySQSteUrNjqtRdWgQXr0CQbt2erhppK5SEVE7I5ZZAuyQH7dfPAd+ene7EAAEQhTct3ETiyemc9mXu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668791; c=relaxed/simple;
	bh=5wwxTBxiZ7aMHtCFtvCwkcsfy/4aw/2gv7yrLlc3+rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i2GoEArKi48H4QkZy1WeeaOEJ21c9mWDgF/OHA6OFxt5fqrFihECFVF8jOIokWJic8maCMYwyQfJE6pdtyc65NLmLZK3fubeq2MEmnb+r62l2Nrw+8eDBvDCjCrnOKRA5EDdVbhOAf4sLp5obzEA9rNB4qxEtc9SCWvjLa8HJuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YjLvp1yp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v7EacWjs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMfQdp4S9HasIDYxwBw+l30b818McatDGhM1+M+Ppvw=;
	b=YjLvp1ypdfw7lxYGRAkoOfoAIF4avkFLB6d+Jyos6h7N77UTvVsBKL9OhDs632hDndO9zM
	vCvLJDLGKq8EQ622NcGZouDCagqJdYujin1QYIm8DvAb0CErlAq0Fii71eT8sCGiqvzJkd
	08iceLmxN+G+OQaYbW+GvdEf7c/CajFAj0qadymVT4HAqNAwuPj/+OI4yhULH8woVYV8CJ
	L7xDtA7DrmWA5hbN9Ki2J+FUUL09ysRn9dFr+dnJd8fDFdTEAxFAQc3Nh/F4d6dUbgBaub
	S4L8Zx9uFHAqGjnE7eFKcsteXHAKTc5QypfwkwTjN1cYGomDGG5Kuc8RpevaXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMfQdp4S9HasIDYxwBw+l30b818McatDGhM1+M+Ppvw=;
	b=v7EacWjsU2/JbBJqAYUlLxYC5gMKr7sNv1oUqMqbOfNJYShnAoqM+FnBLXjNwNTOpnIRIv
	beJYHgvPs7UKX/Cg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 06/19] printk: Flush console on unregister_console()
Date: Mon, 22 Jul 2024 19:25:26 +0206
Message-Id: <20240722171939.3349410-7-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
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
---
 kernel/printk/printk.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 39db56a32c5e..82440b1f0d1e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3727,11 +3727,16 @@ static int unregister_console_locked(struct console *console)
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


