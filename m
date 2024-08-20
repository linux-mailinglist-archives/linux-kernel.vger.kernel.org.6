Return-Path: <linux-kernel+bounces-293354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F49957E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C831F2110A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0D516C68F;
	Tue, 20 Aug 2024 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="juNbXAua";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sNIzAPgA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE8201243
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135418; cv=none; b=smQLH8Ae3UWywdgJgKGVNSquP0MYA/m52Y2ZNdlfTocdJjJkYHVK8EMoLdwIKxqZgFwl/tFm8TjfZdWofD9l6x/Q6Ez824ZvB7KB4h1Xr7E0wbj9z2ukx71fZZ1k95JEMU51gUbPEXvvUC2Zia7NqahBAb6tEtBdJADKdadWGCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135418; c=relaxed/simple;
	bh=xonm42n90zZ29F6yRGU0AFCxjsV7Mk4EpLgBWk9kQgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jc5c3VsntD6Yw64226KvaPzdDVFrDg/BkT91xEDHGSJSb6sRtffj4nqC6ZCWO2kwmrbBLnpXByRPwIqTfj03+IA3UI5hgafVOMWe7S15Rtp6+SfQ70kRS13KLGwmWQ3wVeYTccKpkD04qlJkqxaeHVMBC/AEk7yfOdljoX+K2vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=juNbXAua; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sNIzAPgA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcFEXaJYTYGsZpKvXs7bOCRFRB2kcUdYt04UDfwxzAs=;
	b=juNbXAua97izEGIUgE85kW3/MMtFMgOapKLAexwoEiuRbHftKBHXZRi1zwYRgCcZS7U/Ve
	OJRBI7VH5LCrKqjsAF6o7H6vK75u+j22YZ3zpmRTIAolO75CgU1iIm9TR9KaQvbuc2qVLI
	8B6x7b/LTQoyj8UqkcZyOy01S0CfcwJ2NXbgzedL8cxL6kDcSu+sVz7QBBy/pUM9xUqflJ
	vcqI5DxOwrSK59YaYTRfSq8jKw5cP0q/ic2M2PD0UUgak6n7zp4yF+V107i+37eURR4xkD
	ZT2YFfc2KJhoggt7vJVHTm/8NO6lB7vPw2C8d/sCWdkyMs8Ih/xellZmL577aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcFEXaJYTYGsZpKvXs7bOCRFRB2kcUdYt04UDfwxzAs=;
	b=sNIzAPgAIZwIyqFg0NefqIs4klb07mqUc9BBPoE0qNr2fa2T3kxaUnr+n6cIVfM5yA0YSY
	jalytWZz01QOuYAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v8 28/35] printk: Track nbcon consoles
Date: Tue, 20 Aug 2024 08:35:54 +0206
Message-Id: <20240820063001.36405-29-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
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
index b3ddcf39a53c..e30107d216a5 100644
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
@@ -3638,6 +3643,7 @@ void register_console(struct console *newcon)
 	init_seq = get_init_console_seq(newcon, bootcon_registered);
 
 	if (newcon->flags & CON_NBCON) {
+		have_nbcon_console = true;
 		nbcon_seq_force(newcon, init_seq);
 	} else {
 		have_legacy_console = true;
@@ -3718,6 +3724,7 @@ static int unregister_console_locked(struct console *console)
 {
 	bool use_device_lock = (console->flags & CON_NBCON) && console->write_atomic;
 	bool found_legacy_con = false;
+	bool found_nbcon_con = false;
 	bool found_boot_con = false;
 	unsigned long flags;
 	struct console *c;
@@ -3785,13 +3792,18 @@ static int unregister_console_locked(struct console *console)
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


