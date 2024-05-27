Return-Path: <linux-kernel+bounces-190087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451998CF958
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D271C20AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7D660DCF;
	Mon, 27 May 2024 06:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sMp6+EjY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+bsIqBG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41639AC9
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791905; cv=none; b=P1+0t+Bn3SPPctq4u88bM7owtk872uPv4XMW2fN8A++6v1sHBCdEIlZHbSQ9vhQFkG6pPynS9pgsnQBPVCeLXyeObvGFhDKJEyawCuVyBoukhii5dlaIfo7lTVCqBdC0SheChQMqpkSkbtfK6VK5zpr/icpRpk+m+qr89gLRwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791905; c=relaxed/simple;
	bh=e+s5yp9kuOUcSKomNwvNgs7LuhomtVTH2kEePY50ErY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cPKt40vtaZcgz4+uNBtazTVa6uMTr55nn7qUY2rYsJPv1JlJEHbN0fqs5VZDm5zjJ/+UOxlKc/kItu/z2eRI7tjbTj5e7AObczGDXsZzenYgynzvWUVg6h1c2pUlAkq7RFfVN77nF3A08beMHzzo5VA5g8JJCMAZk2fj6S7rCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sMp6+EjY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I+bsIqBG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpkOnoEtjNOpdOq64j/1rkP+WasLftMlBbDsyMeeGFk=;
	b=sMp6+EjYeS6YAY8SgyjF5e5BXoJxOg4s7avGTViMvziV0zJ7G+yUbtCWn4sU/v0vRqCov2
	ZKAaEAT7RtL4kLaDAJqQrQdULBaq3Tdi0Oxj3QMBRp/qvcynfBhI3rjlezvV2pzBCupVDj
	TGrxOuVwDqAsERWrk9Dp4LHpr/6jHWRTOepLEJA8OuB65VhFWC4X2Z/9hhyWo2uxXgku0I
	ri3omk2qAcp+QO9OkwuwAsjzHm/+lrbyHZSm1LBY0RsRSdeACNq8LpQGO4Ugap+lzf7hxU
	bhfJEe0EWoJR9gWsOVW4onT3Bgg9Ab0GBJjXAu4wEOf1lHheqd9PtepDAfTH3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpkOnoEtjNOpdOq64j/1rkP+WasLftMlBbDsyMeeGFk=;
	b=I+bsIqBGpA1zIjFTPZZYJf+8xCoHy4GUJF1NxokOLusl4kQi/uAQRjr3mrc6c4+p5gailH
	DzNeZXV7TnfptnDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH printk v6 14/30] printk: nbcon: Fix kerneldoc for enums
Date: Mon, 27 May 2024 08:43:33 +0206
Message-Id: <20240527063749.391035-15-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kerneldoc requires enums to be specified as such. Otherwise it is
interpreted as function documentation.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index dd3d4b5d3737..729f7c3b10c1 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -137,7 +137,7 @@ static inline int con_debug_leave(void)
  */
 
 /**
- * cons_flags - General console flags
+ * enum cons_flags - General console flags
  * @CON_PRINTBUFFER:	Used by newly registered consoles to avoid duplicate
  *			output of messages that were already shown by boot
  *			consoles or read by userspace via syslog() syscall.
@@ -218,7 +218,7 @@ struct nbcon_state {
 static_assert(sizeof(struct nbcon_state) <= sizeof(int));
 
 /**
- * nbcon_prio - console owner priority for nbcon consoles
+ * enum nbcon_prio - console owner priority for nbcon consoles
  * @NBCON_PRIO_NONE:		Unused
  * @NBCON_PRIO_NORMAL:		Normal (non-emergency) usage
  * @NBCON_PRIO_EMERGENCY:	Emergency output (WARN/OOPS...)
-- 
2.39.2


