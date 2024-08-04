Return-Path: <linux-kernel+bounces-273636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF2F946BA7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D87B21E52
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786F544C76;
	Sun,  4 Aug 2024 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xHVfOPKN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mWJr5YiA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26F519470
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732715; cv=none; b=qI8rUUZGAp3JNWoREetZkWroP9hOPB3l/5qPmpt7wbA0T+Udcqqi6+8JVGL+Hd219GaWypkrc0H7ngvPdREoHSsUQ/6nQfVK0XKueRUDPE7vV4wS5hMGmH7KneP13kIY5gTEc9Vfn35EEABVf19sT6E1IKM2xrblqizvvHK57iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732715; c=relaxed/simple;
	bh=Ov5T451CRpMNZDviwPZPsNDiuJcBYgBNHBKPViE70gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eybfKVMgu9S872jmaIumhiEHTqRQN1x959TE3/SsXnwNvt0So9t/+ZcvuHjH1XEkyb2a9h95GeZntUovFfGYn1qOGy6aMTqM5pdAPWdg523Pfd8uW9pwOEZthNkZr5ZIxAWXYLMr/O7AfLRX3nU/DE5kJTuC3UINWmmNhcetsxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xHVfOPKN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mWJr5YiA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIvGXSI9zL3LqtnkQPrC0V491Iai+TRLLKit8ny2zJg=;
	b=xHVfOPKNjTQzcqRuLdxwA9LkG8+GCGmjmiL/RYaVYIWWtASK6FdKbeCYyA9txT+VIUiuI9
	fuwhBYcOJk7wlPhgkXPRn/15JMCAenw2jfZ52t2+ijGmvYhcpaS9K6d9WsNMSVNR9+Pey+
	4YpeG5TzEDNpzPYu3SdPU31htAJr4t870Jcs3WpGkPzzF9HP5gxMtGOl3uw40rXy0OyTdu
	CsqD4f+HIrf63XOWXiJHtQhhkCV9/VnlyLQ6Bym06ICCWfySPdT+A1tRgbBcyn15gXHzbo
	Qlo7KjK94L29GcthRGiQzMVZmWVBKxdoF2XH3azk7NuCmJ+1ak8fLo91I/hr8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIvGXSI9zL3LqtnkQPrC0V491Iai+TRLLKit8ny2zJg=;
	b=mWJr5YiAamoJP+/EYI7lwo0JVoowG+VwS8RkaY38zS+uRCXJWjHkRgxbcf/6BDhJeVgZSj
	EKmo4i6zkttdIqBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v7 17/35] printk: Let console_is_usable() handle nbcon
Date: Sun,  4 Aug 2024 02:57:20 +0206
Message-Id: <20240804005138.3722656-18-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
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
index 5d9deb56b582..448a5fcd5228 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -86,6 +86,8 @@ void nbcon_free(struct console *con);
 
 /*
  * Check if the given console is currently capable and allowed to print
+ * records. Note that this function does not consider the current context,
+ * which can also play a role in deciding if @con can be used to print
  * records.
  *
  * Requires the console_srcu_read_lock.
@@ -100,8 +102,13 @@ static inline bool console_is_usable(struct console *con)
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


