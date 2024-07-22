Return-Path: <linux-kernel+bounces-259255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05077939327
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC471F224EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31FA172BBC;
	Mon, 22 Jul 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LtLU6zht";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="65c+mN8D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8F16F8F9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668796; cv=none; b=eYYvZLXajRyY6FQrFUCDbIGQH2kzwBXd3K9qU+hqt1jbUOKW9WJJCEh5JXC510t2mUr+zx/vqBfQSlO5pvpJ1IykiGQI25B73nieiYQmB1TkieLqS+P2NGPflaqVA/36Eqs+6NvlzVDnev/CFL1RANzwyrgfXDQDnCVMPVdOJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668796; c=relaxed/simple;
	bh=W6SIiSzGnRiYJ39aU23hut4hEAWhLT07CX45s0R0uU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMfhPEfOMq/40mwJFPMbkjow8+egMChCYrbuf0lvAi69/J10ijlcJhreOw3Nv+EiXXYylwFvDxwjnAX6iaQQVi5UmX44KdOpzbYKrIkOlUb/f7ywMgjv1alhSqGiaTAtopE7KeTbZiOzvVdvxy8EAih4jV3qP2UJQNTGkXBLjZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LtLU6zht; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=65c+mN8D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctkIXtNtNGPOayfCp8EFtN+ArVTwSQWPWs4qM/qfgSo=;
	b=LtLU6zhtLEzBkYmUpkD9ERBErasUIQnFadM73HbtOlzNbeCzJsuZOryAcQleB6+28WnhtZ
	IvJUrUAAiDSMH29YSN+OWHDgi2hBhTmYezsf/I1ppU38aMf5lWNcgadmrh7EFxHLcoyJni
	HPjVHe/PsKnHwdi4czVJ0yo8P5JfLPEAzkUXnay6dBWBamSW/IbvQULVPfXX57de3U++mp
	7TFT1wKqh5/TOQGhKN+qLaiWpOz4hxnU4cO0C1/xAMj7OlxXcYiRsU+hL8CAfWM6r08fQY
	rEbhQtKIY/vNlXine6unXrGoJWxQBIQU04MY3zH52GIoR5u2arxZ0Q6xYYPskg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctkIXtNtNGPOayfCp8EFtN+ArVTwSQWPWs4qM/qfgSo=;
	b=65c+mN8DMD/xf6Yv6qMRHfKvvAS6u+8SdFJMN6WfuqgTDMbzrd7m4S8vEcFMefOX+maxvB
	0eh/pKMmk4ushYAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 18/19] printk: nbcon: Assign nice -20 for printing threads
Date: Mon, 22 Jul 2024 19:25:38 +0206
Message-Id: <20240722171939.3349410-19-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
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
---
 kernel/printk/nbcon.c  | 6 ++++++
 kernel/printk/printk.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 2a61f2c68ddc..e34e5c5a7843 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1260,6 +1260,12 @@ bool nbcon_kthread_create(struct console *con)
 
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
index 6f70d3a7153f..36087a6d579f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3504,6 +3504,12 @@ static bool legacy_kthread_create(void)
 
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


