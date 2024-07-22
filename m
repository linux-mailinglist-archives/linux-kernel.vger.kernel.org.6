Return-Path: <linux-kernel+bounces-259248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CB5939320
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60C11C214DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989FB16EB6E;
	Mon, 22 Jul 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LVI0YCpS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nr0Ev5lA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8364716F858
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668794; cv=none; b=uFgXxcsd5XJAVQ01G1LlS4UO34eg8liyAVNmqKpQytfjfyYH1uaaBvlsrMETU7tIW2t4nSCEeZdMr5CkLK+h45j0bzib34aUkHS+jShnQ+r/S/ufYDa7m6eTcpbrvbrEMPovfEbca2qFT/dAppsBK6aTZBtt7uS8oup4AXh8/6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668794; c=relaxed/simple;
	bh=z7t14psmClgJPnrTS3FePajFlnKKHKwtWJNjr7MCP1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FM3G36GFTuaH9Yp3Sp2fUnIPb4qfHafc0J0usNNl6oDT4hYS1KmDZlK+pPWOz9b5h9y1P/DYz17KMIzCl9Bg7yPgIjCSr4H0SR3OlrIS0BtAnCeQ81cciyQaZLD0YyV7GR85kXUftTpRTXKsVZmhHT0UY4TbY1PZd6hqTDgRZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LVI0YCpS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nr0Ev5lA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1Oi5xduOOsbRA26g1GCX0jTw6STXCrfhNtn4TB0hdM=;
	b=LVI0YCpSL9I1KBnrkiAR0INdJoXK/Sq526h65n+QWQ7ck0WfByqWc0GEXTfS1C53mNAYlZ
	FDwEF4nPf36/Nff6f5rVjm9fflU2YOuQQRIkVTTr1oxD7mYSRQZiMOFRpngtd/PwXs1ebU
	dW134/IbvXeOOiBHIKfpTTD+bDkzdOSnySI/R0GgHgvgFlXI88YUvIpnXM+/MhgNyXWqUc
	1x//+hifZxsPiO4HoRj9O52dUqpJ4e6+vltatPPgJ48uq4EjK1YFzilLkWs+tP2gy5sek5
	AndsNTCgcFYxehP8nK/gXArKGz69LW5DHClQInx3kBTJd/XOui/yfEtBZ6ctGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1Oi5xduOOsbRA26g1GCX0jTw6STXCrfhNtn4TB0hdM=;
	b=Nr0Ev5lA1l6yOdYsZpivtRACyCdi1xMSpjGFWy994/l9f4UW70seNUklBcQ4gco7Ju7P0T
	jqvYkzuEV20ZTPDw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 14/19] proc: consoles: Add notation to c_start/c_stop
Date: Mon, 22 Jul 2024 19:25:34 +0206
Message-Id: <20240722171939.3349410-15-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fs/proc/consoles.c:78:13: warning: context imbalance in 'c_start'
	- wrong count at exit
fs/proc/consoles.c:104:13: warning: context imbalance in 'c_stop'
	- unexpected unlock

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 fs/proc/consoles.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index e0758fe7936d..7036fdfa0bec 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -68,6 +68,7 @@ static int show_console_dev(struct seq_file *m, void *v)
 }
 
 static void *c_start(struct seq_file *m, loff_t *pos)
+	__acquires(&console_mutex)
 {
 	struct console *con;
 	loff_t off = 0;
@@ -94,6 +95,7 @@ static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 }
 
 static void c_stop(struct seq_file *m, void *v)
+	__releases(&console_mutex)
 {
 	console_list_unlock();
 }
-- 
2.39.2


