Return-Path: <linux-kernel+bounces-190097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D40AB8CF960
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 819CFB20DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DB713BAFB;
	Mon, 27 May 2024 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IYnxPmd2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B9d0IiLJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00F12AAE6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791908; cv=none; b=iwIisfBmw5Mc+tK3VTz5yp6HbJOm8GDgQl9kHYtsZ+Jduli2pRhJIR95Ub0+jUw4QE3UNijfN/QHtmnqlSs1H0abkijkB7Hn1FDa7O11ntL80SnXIkSZ35wihf+RvoF0IudfIxBzMwSWEyGp3zJ7+Mllbyw07eGNeoTrVWhZfLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791908; c=relaxed/simple;
	bh=4RKVEs781vKO0XLRQyJczCVpAjrrp4EbG79nkZ1ZXBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3LFh1htRLhdT3GxlxiWQhzNQNloMBgir6AiapIw05hUiBwZIC5+OJxtf8+Ku6qfqExlFWe0x6csGteMlM1CEMfoez1lNpAnTkYH0mQrBzo05Wz0idbWJ6re71vySa9XD+8JpaiqeZGct5ND2XynA9uEV0Qa1fxnhG2cDUAXaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IYnxPmd2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B9d0IiLJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaCLvchcvldjjGnfBDp+6tSZmLspUlNMwrj30z7kttw=;
	b=IYnxPmd2VzZl9g1Sy+Tbnx0TEjAnkRUOmm6s7igNYD7p3bC+Ya4frAuiIYIcDQl1IO7+mK
	EaAPqsRrnn+PdqVV44Ok74KWM7JgabqNxDyFB9irJTqPeg+rRxmSQvwMGJBPbYGjDNa+2T
	o7XdqVn9n+MQGjDOIJkjhEclJul0l7La1AElPG9aDz9R3ZbtQvAXmdgEdWT3spLd4zr3Fq
	4a05ft4Go58BeXoWkV/nb8smlvcVW4Bk3rhMa/UqhZR9ARK0iX2qbqDnV327RZW7OJHR2k
	vmJQr98L/0LW7tyRujgUQXIfzVChw2C15FJwYKnfFOTmMfZ5GA1UqUQx37k5Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaCLvchcvldjjGnfBDp+6tSZmLspUlNMwrj30z7kttw=;
	b=B9d0IiLJkMQZ2ejaVeCbflIRbOdSV1af2Q46SU963PBGq1EvNiuJrCFhEhaqCsEhJKh77C
	3NMwCY1Wl+CzJkDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 24/30] printk: Track nbcon consoles
Date: Mon, 27 May 2024 08:43:43 +0206
Message-Id: <20240527063749.391035-25-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a global flag @have_nbcon_console to identify if any nbcon
consoles are registered. This will be used in follow-up commits
to preserve legacy behavior when no nbcon consoles are registered.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f00192df84f0..d087711242de 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -470,6 +470,11 @@ static DEFINE_MUTEX(syslog_lock);
  */
 static bool have_legacy_console;
 
+/*
+ * Specifies if an nbcon console is registered.
+ */
+static bool have_nbcon_console;
+
 /*
  * Specifies if a boot console is registered. If boot consoles are present,
  * nbcon consoles cannot print simultaneously and must be synchronized by
@@ -3538,6 +3543,7 @@ void register_console(struct console *newcon)
 	init_seq = get_init_console_seq(newcon, bootcon_registered);
 
 	if (newcon->flags & CON_NBCON) {
+		have_nbcon_console = true;
 		nbcon_init(newcon, init_seq);
 	} else {
 		have_legacy_console = true;
@@ -3618,6 +3624,7 @@ static int unregister_console_locked(struct console *console)
 {
 	bool use_device_lock = (console->flags & CON_NBCON) && console->write_atomic;
 	bool found_legacy_con = false;
+	bool found_nbcon_con = false;
 	bool found_boot_con = false;
 	unsigned long flags;
 	struct console *c;
@@ -3685,13 +3692,18 @@ static int unregister_console_locked(struct console *console)
 	for_each_console(c) {
 		if (c->flags & CON_BOOT)
 			found_boot_con = true;
-		if (!(c->flags & CON_NBCON))
+
+		if (c->flags & CON_NBCON)
+			found_nbcon_con = true;
+		else
 			found_legacy_con = true;
 	}
 	if (!found_boot_con)
 		have_boot_console = found_boot_con;
 	if (!found_legacy_con)
 		have_legacy_console = found_legacy_con;
+	if (!found_nbcon_con)
+		have_nbcon_console = found_nbcon_con;
 
 	return res;
 }
-- 
2.39.2


