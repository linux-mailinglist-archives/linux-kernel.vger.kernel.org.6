Return-Path: <linux-kernel+bounces-437336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B6C9E91F6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516FD1881CE5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA0C21772E;
	Mon,  9 Dec 2024 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F/eYFqhg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TVh3bosp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC647192D9C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743070; cv=none; b=JI7Ok8VxuRdCUCklCg5EstJ1Nca+KaVkWM8gIXB2fNVOGPNEuQjxWhZZGlVe+L13RUt2kvbpXK5n3ptsTeMpJGrRe86pAKw0MJQ39ZS8bN7LpLew+YZHgG1xp8yLuRdUwfErOVIKipyM89bn4Jz0AzgqusOXSzgMGrfIif7XJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743070; c=relaxed/simple;
	bh=H0vcdxtDE/OhvIno+uKyrKBGwnCEX7IcWUocKKB8r7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sDbNuO77bjNPjeX6G2q9TOhBhqXdjG2REwk/Vb2lfMBXBXlOdyYosbZA7EljSU2yTSVPnM09DE0nK8KSIlNb6PiZpoXqrvh/nCCuOvj9eruPoja6mqh0Am5mnIomRBEXXfXoXhb1waK70cIIl545WUMn1HVAy9Bccf1aCFJ0edQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F/eYFqhg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TVh3bosp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733743067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dD0VxuUtYLH78BlAYZuqFXnh64WMLZJOrnsiz/sC43Y=;
	b=F/eYFqhgLvWuBRxLZ6fONjC4Pwqn/xhat6lOoDzdnnRWMW8UwsfgOtaKI8LRblVrkRt6oy
	3RDYpg64A8uVkkSKMqbD9LEGR9Unlx7Of+gmE0u7Ti/RH+eZtxgTfoB4GAguRlNxGLnI0h
	ehl+9edZqIHUi0A8dC0pSNQFkTQ9NYiXeZaxTjSoiO35bZ1TGy+9osQfI4l2tgB9qAuAZ5
	udfGuHJfAH6odStGJardxpYS0Eugbqfs8rMpmpkxA+2erDqhe+QZuORTRgPTG96nrMkuZM
	xPoi4sZIufziXDsXxJU7rsIwcQVjroU49IL+yLASYRdHfM0gAHrHmS0taxK9MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733743067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dD0VxuUtYLH78BlAYZuqFXnh64WMLZJOrnsiz/sC43Y=;
	b=TVh3bosp1w5BkXPOXqVEGrrbPYS3pP4loKci+fRIcS8VsbLcv14IJnociMse/eM7grvv6S
	ZW8DJwYgxkZC7EBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	Rik van Riel <riel@surriel.com>,
	Omar Sandoval <osandov@meta.com>
Subject: [PATCH printk v1 1/2] printk: Remove redundant deferred check in vprintk()
Date: Mon,  9 Dec 2024 12:23:45 +0106
Message-Id: <20241209111746.192559-2-john.ogness@linutronix.de>
In-Reply-To: <20241209111746.192559-1-john.ogness@linutronix.de>
References: <20241209111746.192559-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper printk_get_console_flush_type() is already calling
is_printk_legacy_deferred() to determine if legacy printing is
to be offloaded. Therefore there is no need for vprintk() to
perform this check as well. Remove the redundant check from
vprintk().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_safe.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 6f94418d53ff..6283bc0b55e6 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -74,15 +74,6 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	if (unlikely(kdb_trap_printk && kdb_printf_cpu < 0))
 		return vkdb_printf(KDB_MSGSRC_PRINTK, fmt, args);
 #endif
-
-	/*
-	 * Use the main logbuf even in NMI. But avoid calling console
-	 * drivers that might have their own locks.
-	 */
-	if (is_printk_legacy_deferred())
-		return vprintk_deferred(fmt, args);
-
-	/* No obstacles. */
 	return vprintk_default(fmt, args);
 }
 EXPORT_SYMBOL(vprintk);
-- 
2.39.5


