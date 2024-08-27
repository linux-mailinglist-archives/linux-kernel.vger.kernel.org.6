Return-Path: <linux-kernel+bounces-302577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7733960076
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785371F22368
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0456E195811;
	Tue, 27 Aug 2024 04:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YSLQze48";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cWUHrWtD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B9D154423
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733824; cv=none; b=g7mt0Zy37C5anE+zjalQXypSUGe/thL+QfGBzcTZfPQgHL63QQUTDNFgd8JE9qDhBtEfRZPIWb45uDtM6eaqed+ZGFBJarUEhFYfJ5AjtNQ8EUI05Fi1xA1zXInJ/pxeXmvrrtsb9zX4up1ZitUlflgL4/MH8oJQRXdAQtE/n3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733824; c=relaxed/simple;
	bh=tAYGQiWA14h9cQbPx+3XGy/Lgh/XuW9AdX1hiU1vzXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V32LuavnkK05eC0O9LKGNbZm8+tOBufWQp7WXqF0xWrX5iYChXAiQqna5CyGM6dJ+cbolpjTrsAcqBYWcuLFO4r28MZDhrW173uUZgZhWCLeyIFIqXKsr+e58DOw4tyuF8TaMa7ak220tskvyZwE3WBUtaYmdRmGpyPDXTIxnGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YSLQze48; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cWUHrWtD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724733819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LI8DUg3IwQtyCHgTvsHuVrVO9wJnv7kQ0WO+Ps9C198=;
	b=YSLQze48OWAKZyUOYLP5NPUNVJAQH7vn+g4T7upbeBN+Wwb9lDFy1klvTex8LNF5XGjDsB
	vSATRHF5bmgscGn7heaAbeWBPlqWBiXbwGkNRg3Ps6wQMxcV5Weg3tBl7MKDzDqYSdMreF
	/m2S2AeN9EzBGWUC3mIzbYhFn9ry5WIGTR8Tv1c5PUBvvWi0J834fQqIm//5jw+UxkL8Ch
	BVq2uhct2vJTZpjK5lxzn0hAno2VDL+ktaKlERjy/XMJVrjEYjkDLIJL/EasoNwojU5x9R
	gLI9EBnjRY99qxso2gfXmc79baHxQhE/ADePXqB3NGatG7ko933C2XOlOY/JIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724733819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LI8DUg3IwQtyCHgTvsHuVrVO9wJnv7kQ0WO+Ps9C198=;
	b=cWUHrWtDTr/j4Ag0O4DFdHmtHKJwMN8J8NR/TgpX+qWPaNjXe5GMmYXv/oCPsAy9bVuSz2
	QSgjTQ786sXk8mBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 16/17] printk: nbcon: Assign nice -20 for printing threads
Date: Tue, 27 Aug 2024 06:49:32 +0206
Message-Id: <20240827044333.88596-17-john.ogness@linutronix.de>
In-Reply-To: <20240827044333.88596-1-john.ogness@linutronix.de>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is important that console printing threads are scheduled
shortly after a printk call and with generous runtime budgets.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nbcon.c  | 6 ++++++
 kernel/printk/printk.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index d3a018919046..32a383c4f62e 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1312,6 +1312,12 @@ bool nbcon_kthread_create(struct console *con)
 
 	con->kthread = kt;
 
+	/*
+	 * It is important that console printing threads are scheduled
+	 * shortly after a printk call and with generous runtime budgets.
+	 */
+	sched_set_normal(con->kthread, -20);
+
 	return true;
 }
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4220abe86296..ed4a3cb00095 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3554,6 +3554,12 @@ static bool legacy_kthread_create(void)
 
 	printk_legacy_kthread = kt;
 
+	/*
+	 * It is important that console printing threads are scheduled
+	 * shortly after a printk call and with generous runtime budgets.
+	 */
+	sched_set_normal(printk_legacy_kthread, -20);
+
 	return true;
 }
 
-- 
2.39.2


