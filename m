Return-Path: <linux-kernel+bounces-259238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F91939311
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DAF282825
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A4816EC11;
	Mon, 22 Jul 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pHKqjCrg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sJdh9Hau"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3999616DEB1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668788; cv=none; b=qmpHselnlEX2mTJm6LDDD9MvO+hRsmywE50lNN/L0LfmZcm5fG0VNAkHUoYxnczVmgDJoTjh5DujincNJexoM3omCOCNKwDwOzRWSNT3cWbb8mMhZlp8/KnKfwbSWGbHqqnJAJLDBMBNqGH6Mm8b51YUCkpS8VBhzr8GC81GQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668788; c=relaxed/simple;
	bh=CFpAKElXQ4pLm8ggHq6++kEORvpGrXhuMecgqKmNbcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g08sgdgCGrafLojfBjrsTW92jWYmVjyQDTg5Czv4YRTbPwBX0G1s11Tow3W1pOxZI+KOH0yCKarPkr02ef/5qd71Uv2U733gBzO1wv74h4tUyO9hEwPhNQLP/KS7jHlFPa8SjR0cS3xYGJ2b742oB+EUmUKRuut5MVHGwoFgkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pHKqjCrg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sJdh9Hau; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhBnGHE6CqmvVf3ZFd5i4KOYZ+QBtgmy2XGk94J87c8=;
	b=pHKqjCrg4LktkE9P2m1Lk9ZqdIycwWbtPlj27c1cGO1xcno+SMgqVUi9i6Vq+DyF4XSit2
	hY9Slu0MEEJFbjZ8Dj5OryT1N6HSjYUP2IHdGwbzmRVTr/TGHqOzxmDY9jOS//NCw/tCCp
	GKJ/pLhOQ9D/a9O50fnLkkOcv7uBvJ/YwKI/I0luoCJpoM354GN1zh2cFfpRj1Aub+SwG6
	iE7+9omMuvtSMPw4GRC+OvEUXIsJcuns5J0kHhbAp5h46aNpJ1PIH7C+HDDlMeluJ7CoyJ
	9jdnJoGZwEVACYyVdm18r9621I4Vcx5Cgf7+aAdsKtD3Qh8R29bWI1hxi3a6/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhBnGHE6CqmvVf3ZFd5i4KOYZ+QBtgmy2XGk94J87c8=;
	b=sJdh9Hau+0IjZCWQjp9RWb7/PvitxcPslbB8wHevyFNEIOjhBj74gsZxoPSZoPERS0iCrZ
	gVFD6vyIg/2FfMDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 01/19] printk: nbcon: Clarify nbcon_get_default_prio() context
Date: Mon, 22 Jul 2024 19:25:21 +0206
Message-Id: <20240722171939.3349410-2-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the kerneldoc and code comments that claimed migration must
be disabled for nbcon_get_default_prio(). This is not true.

Add the explation in the kerneldoc.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/nbcon.c  | 5 ++++-
 kernel/printk/printk.c | 2 --
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index ef6e76db0f5a..d8388faa6500 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -970,9 +970,12 @@ static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
  * nbcon_get_default_prio - The appropriate nbcon priority to use for nbcon
  *				printing on the current CPU
  *
- * Context:	Any context which could not be migrated to another CPU.
+ * Context:	Any context.
  * Return:	The nbcon_prio to use for acquiring an nbcon console in this
  *		context for printing.
+ *
+ * Allowing migration enabled relies on the fact that a context cannot be
+ * migrated to panic or emergency state CPUs.
  */
 enum nbcon_prio nbcon_get_default_prio(void)
 {
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d0bff0b0abfd..5090c0591f88 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2401,8 +2401,6 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 * printing of all remaining records to all consoles so that
 		 * this context can return as soon as possible. Hopefully
 		 * another printk() caller will take over the printing.
-		 *
-		 * Also, nbcon_get_default_prio() requires migration disabled.
 		 */
 		preempt_disable();
 
-- 
2.39.2


