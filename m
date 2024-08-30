Return-Path: <linux-kernel+bounces-309035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7FF966577
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180111F243E0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770311B78EF;
	Fri, 30 Aug 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hKDbQ038";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fnvtt2md"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465E1B530E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031766; cv=none; b=G2sM4Ngr9HxGuPwmAxTxCxsqhn0imrod29FtA03SW3+jZ7z099dHZQnBNpfZ5jdhV3Ls3O26lIeM545+prVKpa1kO0ZXiQI37DL1SeSQus0KYMEZJ5H0qJvusbISNYpKJE7h/l+eQJ8cd6TQmXvghabc6Hpd9BqnmFzstYMqvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031766; c=relaxed/simple;
	bh=hO2oomLoxf/bUX1WgRwfUv7yEovKt+lixG0W+vCa7/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsiw+zrXUi7N7mIkF8y+u1UrKJMLHVOJgeox5XyoWbd3ae2aZ3FW995qdUI+IdtXI/std05wcfTUvE4vROPKBIr1e2TbA7z7mekMoBjT+rnXtmo0K52fqaD29/eJIFuiHFqLukIfjiep0+EWx5piiPUalOqNXRJ2ciHK5IXvHTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hKDbQ038; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fnvtt2md; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725031757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRZKVWxZPmNsRkG/dsm1SB0+wvFuf66EXj0bGb54vtI=;
	b=hKDbQ038rtQMA1MXO8/bSU5ehFwp36irJdrpevbNNMnlzO/oJH4XS7P4wEHVbUXPdQRjgx
	Cc0J0QTz1YRcqpg1XR7v+7QWIr3zUsvZPs8p6VZ3LEdjmP4bjgoLBCGxhtZcPHXWciAwjD
	Y81T2jnMxNVkJQuE9VNCxFUBqAtwUlStHpZGRgVdGsE/uCAXpQKzgsStqrZFQSsXLEb29k
	iQaxMgwnOlLjh4fE4+/4y2eGLvJN1zonA/SKKUBz+HQ6BYI31ikMX374sp3u723bWhvV//
	ni/heZrk3bZzF7azpIML2jjGpvTNHmk8I69dYPJT3dCH9OrA+MNnjU1EwcKDUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725031757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRZKVWxZPmNsRkG/dsm1SB0+wvFuf66EXj0bGb54vtI=;
	b=Fnvtt2mdCesnnxOjBO5o3L/b/geUE3V/4c0FjtkM9AXX/EfftTA4rzsGzpHOexfE/maPu4
	xpVZdGzhzK0YqbAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 03/17] printk: Flush console on unregister_console()
Date: Fri, 30 Aug 2024 17:35:02 +0206
Message-Id: <20240830152916.10136-4-john.ogness@linutronix.de>
In-Reply-To: <20240830152916.10136-1-john.ogness@linutronix.de>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
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


