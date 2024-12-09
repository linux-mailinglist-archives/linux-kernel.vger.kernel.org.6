Return-Path: <linux-kernel+bounces-437337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 141569E91F8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F481882002
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD429217F47;
	Mon,  9 Dec 2024 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P/l4gnta";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wXt6538H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23552147FF
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743070; cv=none; b=LSCQdsfPMchVjx9/gCbDd165rEVpkTi90BEq05nFWW3RvTzKUsJ4KDCQVr75lVI2iQclvnXNoXxkn3ddj69+sxfBt4rsrS89ZzTzLXmnDd+lrLmuEMyKXLLfwz2DOFYk/7qp02GsCrUeGSyQ+Rwd0Oo4pZqjBRtcGIsd6OABJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743070; c=relaxed/simple;
	bh=i+uI6vDvHiu2cxVhdbDSZwLCaYezDQ9AuiAVOkeGRjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OmFrOmYzpRuQaGcd/XUuqnff/8o146YxakhEB+iLLPDC8Zjb0+DBcSO74Vudd1fE0P2w1LktTWICDMN90coRDj7+yNGujrhgjGcytq+yt1yqybJ36gsohAugjd1xcZrvoMo4Ohe/DkuCXKH8/yciUhfMIxzQBixAnwgPJoguU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P/l4gnta; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wXt6538H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733743067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4xSReb061DP5Oa/lvV3ZmZXQhBGXIzCkpePreX41ZE=;
	b=P/l4gntaMzTlHYkpeGzQHuSY0gVAVDCPOzucD7/CCkWmEomqxALpw+n2xVT4kArCITOn0H
	NE/L8cLnE3XzFJQM2wr4t1QpEVWE2xlUj7ASl5V33rOY+9NlGHJefHT2UpWIEGXXqr1TZj
	RoqIMUgBsQpF6Zwhhy9wWunlRVy+Cp8GSexgwx9AmC1za5EavNlHz7Dsy5+bUUkHV+oj6V
	ok/nf8oVR7x14/9KSTd7NgVnHKJY9D9BzngGOVBjvO83XDxgD0qfBbPkIFy64Qaz1+Bq1G
	OgBwQyxsUggBpJjTP+akkIAYntDWmRiTFC3cWnQHU9OLHjkpPUPPJoE44p8ZeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733743067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4xSReb061DP5Oa/lvV3ZmZXQhBGXIzCkpePreX41ZE=;
	b=wXt6538H8GmSTZRvLo6jHQptilUp2CUG5foSRIJ+YnR3NwsqT/J+VgdkHfb999alG7HTJF
	w9xS+ZlVElAAQUAQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	Rik van Riel <riel@surriel.com>,
	Omar Sandoval <osandov@meta.com>
Subject: [PATCH printk v1 2/2] printk: Defer legacy printing when holding printk_cpu_sync
Date: Mon,  9 Dec 2024 12:23:46 +0106
Message-Id: <20241209111746.192559-3-john.ogness@linutronix.de>
In-Reply-To: <20241209111746.192559-1-john.ogness@linutronix.de>
References: <20241209111746.192559-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation of printk_cpu_sync_get() clearly states
that the owner must never perform any activities where it waits
for a CPU. For legacy printing there can be spinning on the
console_lock and on the port lock. Therefore legacy printing
must be deferred when holding the printk_cpu_sync.

Note that in the case of emergency states, atomic consoles
are not prevented from printing when printk is deferred. This
is appropriate because they do not spin-wait indefinitely for
other CPUs.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Fixes: 55d6af1d6688 ("lib/nmi_backtrace: explicitly serialize banner and regs")
---
 kernel/printk/internal.h    | 6 ++++++
 kernel/printk/printk.c      | 5 +++++
 kernel/printk/printk_safe.c | 7 ++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index c6bb47666aef..a91bdf802967 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -338,3 +338,9 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped);
 void console_prepend_replay(struct printk_message *pmsg);
 #endif
+
+#ifdef CONFIG_SMP
+bool is_printk_cpu_sync_owner(void);
+#else
+static inline bool is_printk_cpu_sync_owner(void) { return false; }
+#endif
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d27a64d58023..0856a77c4b7a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -4916,6 +4916,11 @@ void console_try_replay_all(void)
 static atomic_t printk_cpu_sync_owner = ATOMIC_INIT(-1);
 static atomic_t printk_cpu_sync_nested = ATOMIC_INIT(0);
 
+bool is_printk_cpu_sync_owner(void)
+{
+	return (atomic_read(&printk_cpu_sync_owner) == raw_smp_processor_id());
+}
+
 /**
  * __printk_cpu_sync_wait() - Busy wait until the printk cpu-reentrant
  *                            spinning lock is not owned by any CPU.
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 6283bc0b55e6..32a28f563b13 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -61,10 +61,15 @@ bool is_printk_legacy_deferred(void)
 	/*
 	 * The per-CPU variable @printk_context can be read safely in any
 	 * context. CPU migration is always disabled when set.
+	 *
+	 * A context holding the printk_cpu_sync must not spin waiting for
+	 * another CPU. For legacy printing, it could be the console_lock
+	 * or the port lock.
 	 */
 	return (force_legacy_kthread() ||
 		this_cpu_read(printk_context) ||
-		in_nmi());
+		in_nmi() ||
+		is_printk_cpu_sync_owner());
 }
 
 asmlinkage int vprintk(const char *fmt, va_list args)
-- 
2.39.5


