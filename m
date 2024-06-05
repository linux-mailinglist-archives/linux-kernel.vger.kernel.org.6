Return-Path: <linux-kernel+bounces-202147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65A58FC857
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463761F26FB2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A4218FC94;
	Wed,  5 Jun 2024 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yL8gTGBk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l/McjD6p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6AD268
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581098; cv=none; b=dDm1LWhrjSK8dZgW5rIxnOz/UoVHEf/cL3gZm5Ef6P5vZJ35Og4+Wzf3Uy/WCofmujWXFrIWuaC2TBtYiczTefmJhpnic7s0onikOYfO4K6akRTUJ9hRLNvhJg4Ulo8hM5fsxQEU38ifMe4B/m4kz7yXWlmscRVSuqoKJpbf3GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581098; c=relaxed/simple;
	bh=6OJT5ZN++te2WoJcUN6WngMunIIobFOiHdfduMnT8Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mvdfdM9qd+QeZPG9/N6bZ7WfAUaDlNHDl/9FBNiV1pEhMsJG2CtgEtsOhYhNTfc4WJWMupmwpPHxPLqW4UiYttcLsYz5dY8SbVSUV7vaJPKEWlp/EZK2YVD3dUIThSvQhqeYm/LuPj5GYDTEL19OCyEzImgP8Zjq29nCKjsnM18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yL8gTGBk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l/McjD6p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717581095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0QM4N2NR8SUu7foXmQ7iHQLEtg2Qof8D3BqkfSR4DCM=;
	b=yL8gTGBkwxSPBEbq2EskIGxGiGeeLjoStgQeyA4j4ggcoUhkcb0KS/mQ65ZMReKDI5zbG6
	R8cfzgdgApyNJWz/QL609za2a9hPXvCnbhZW+qt/M286xLGb3O+SQzhO6EJRhcpgqbD50d
	R0ewQvp+idlEk1Tt3Js/GX6737xIbN4ycWJCrZ5/svdYP9q+ZcaJpXyyl5BnOrYkcbcJQS
	Om3j17xteD45rK/Ytf+SYycRsXoBoSQ6RvSJeUw5vxMZXgeUK9TZf+jiXzDELxNKyOIsJJ
	wbp6SVY+gJKMjS0+M4NQJNOn/kof4FrHRSv6yKa2Uo9+XEv176ZH36pHVkOS8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717581095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0QM4N2NR8SUu7foXmQ7iHQLEtg2Qof8D3BqkfSR4DCM=;
	b=l/McjD6pYbZx5aZjRrYE9/fgstU6SPk2RCP5ZlWUCxXRxMzp/hAEZIQWWbVMFZxMzFnYLu
	0UvpgmHgd624XwCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
    Steven Rostedt <rostedt@goodmis.org>,
    Juri Lelli <juri.lelli@redhat.com>,
    linux-kernel@vger.kernel.org
Subject: [PATCH linux-next] printk: nbcon: Fix nbcon_cpu_emergency_flush()
 when preemptible
Date: Wed, 05 Jun 2024 11:57:34 +0206
Message-ID: <87zfrzvhsp.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

nbcon_cpu_emergency_flush() can be called in a preemptible
context. In that case the CPU is not in an emergency state.
However, in order to see that the CPU is not in an emergency
state (accessing the per-cpu variable), preemption must be
disabled.

Disable preemption when checking the CPU state.

Reported-by: Juri Lelli <juri.lelli@redhat.com>
Closes: https://lore.kernel.org/aqkcpca4vgadxc3yzcu74xwq3grslj5m43f3eb5fcs23yo2gy4@gcsnqcts5tos
Fixes: 46a1379208b7 ("printk: nbcon: Implement emergency sections")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/nbcon.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 19f0db6945e4..39eb369880d9 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1443,8 +1443,19 @@ void nbcon_cpu_emergency_exit(void)
  */
 void nbcon_cpu_emergency_flush(void)
 {
+	bool is_emergency;
+
+	/*
+	 * If this context is not an emergency context, preemption might be
+	 * enabled. To be sure, disable preemption when checking if this is
+	 * an emergency context.
+	 */
+	preempt_disable();
+	is_emergency = (*nbcon_get_cpu_emergency_nesting() != 0);
+	preempt_enable();
+
 	/* The explicit flush is needed only in the emergency context. */
-	if (*(nbcon_get_cpu_emergency_nesting()) == 0)
+	if (!is_emergency)
 		return;
 
 	nbcon_atomic_flush_pending();
-- 
2.30.2

