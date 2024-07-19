Return-Path: <linux-kernel+bounces-257336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13AB9378B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B918B210C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB3C143751;
	Fri, 19 Jul 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z0UftRws";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c9cVUck2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F025783A19
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721396905; cv=none; b=Bpi5c7WRaU1SBgyjNlmqjrJw+/lOjKPvAsDlgYjh5TSq9E3OWGzouosUhYgsHi86EoCxb2azBRfoxkJ6Fsa77ms6q8601amYEB6RRPh/LTUObfF5JVEiYN7UhoxIuJ1uwkbKsndq+wufDgq9F1pEAkor+yaAqIlL48dLZUGxUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721396905; c=relaxed/simple;
	bh=Aku1tMYQ2TFzDPMj7f7dJtjdKgYQkFi7E52usGS+0ZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vhu+ImJOnNPGZPaEZeW/Z5jHLiqj7K/ViBmNz6MEfwzFEJvRinMvUYONjIddpor/upOcHCOOuST/AjpFXGo6EyZWBsDzLp7IjY4H89wyCeFCH93l4GvB/eiSQXJPs7OImCTok7HUFGr8wCvNYxMLn3pUT3xMErCPoCPq5F0uAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z0UftRws; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c9cVUck2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721396899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtcLDM3fP1UfLCmRAHG0Ni80kSd60xifqpKLB9KhsrA=;
	b=Z0UftRws7880efnAQIIVeJejsfAtRVXEdGWx/FyKVGASezgJ0ZVG3IpbiCPfgXw13kFAHl
	22zpGVds0b1kZL2KzxUauzSiDMB2f0JlIwqg3TQdthJyckOysH03KUsr5I2vfI2Xhn8bej
	28Fc/5Qrs8gkEZKlN/cgCw36Y/IOWk2DHKxbV0z0LHV75m2Qx36R1t4JpTSDNvWI9/Ug4P
	fSjrIJIy1U8EuvPNp7cEx5g4w4vp/xdBnSi4IhWFFVkqiwcprTwQgfJiR+5TaDylmLq7+n
	lMyDT04VLJerhi6NmaY1bEFJEKd9/ntc0hXLAG1hA4qZgss3AQ4MJhN3Qatilw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721396899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtcLDM3fP1UfLCmRAHG0Ni80kSd60xifqpKLB9KhsrA=;
	b=c9cVUck2dXPDwBcQBxx/ZGDKqtA4R/UssmSosXZV2sYhd/R25g33kmlbbiulwEmtJo59tQ
	D8Lf1mUJa6zZPjCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH printk 1/1] printk: nbcon: do not require migration disabled for nbcon_get_cpu_emergency_nesting()
Date: Fri, 19 Jul 2024 15:54:18 +0206
Message-Id: <20240719134818.3311665-2-john.ogness@linutronix.de>
In-Reply-To: <20240719134818.3311665-1-john.ogness@linutronix.de>
References: <20240719134818.3311665-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since entering emergency state disables preemption, there is no
need for nbcon_get_cpu_emergency_nesting() to explicitly require
migration disasbled. Either the current CPU is in emergency state
(and thus preemption is disabled and the nesting level is not
zero) or the current CPU is not in emergency state and the nesting
level must by definition be zero, even when migration is enabled
and the current CPU could change. The current CPU could never
change to a CPU that is in emergency state.

Reported-by: Juri Lelli <juri.lelli@redhat.com>
Closes: https://lore.kernel.org/aqkcpca4vgadxc3yzcu74xwq3grslj5m43f3eb5fcs23yo2gy4@gcsnqcts5tos
Fixes: 46a1379208b7 ("printk: nbcon: Implement emergency sections")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/nbcon.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 6e9e24aa0a7f..ef6e76db0f5a 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -943,8 +943,14 @@ static unsigned int early_nbcon_pcpu_emergency_nesting __initdata;
 /**
  * nbcon_get_cpu_emergency_nesting - Get the per CPU emergency nesting pointer
  *
+ * Context:	For reading, any context. For writing, any context which could
+ *		not be migrated to another CPU.
  * Return:	Either a pointer to the per CPU emergency nesting counter of
  *		the current CPU or to the init data during early boot.
+ *
+ * Allowing migration enabled for reading relies on preemption being disabled
+ * while the current CPU is in the emergency state. See also
+ * nbcon_cpu_emergency_enter().
  */
 static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
 {
@@ -956,7 +962,8 @@ static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
 	if (!printk_percpu_data_ready())
 		return &early_nbcon_pcpu_emergency_nesting;
 
-	return this_cpu_ptr(&nbcon_pcpu_emergency_nesting);
+	/* Open code this_cpu_ptr() without checking migration. */
+	return per_cpu_ptr(&nbcon_pcpu_emergency_nesting, raw_smp_processor_id());
 }
 
 /**
-- 
2.39.2


