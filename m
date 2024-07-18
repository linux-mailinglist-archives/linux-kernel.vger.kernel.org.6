Return-Path: <linux-kernel+bounces-256080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6499348B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0056FB218E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A090745CB;
	Thu, 18 Jul 2024 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1k2KjYbE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QRwn0Jpr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B0B2CCA3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287528; cv=none; b=ofr5xfG/qd/H39IGd6iw+zGkbJ2xU2NAL3efpfAsNModeCH5IrAE9pxsVFUPCAeUgnTQ0VNGEaJoWguKTzQ283cOxKyCUYR69Rp3NXnFuBC+07scqTMVb+t/Yox8nyOQshkpUVMeERFaG/HDmvnARR/JAk8b+MeIQHrdhH6En4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287528; c=relaxed/simple;
	bh=dVlEsiq3WpoVPVRfCi0y480MQYxzoni0zWm4l4dNPXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uVjoiJjHJX9/lXUNzCFORVl0gAe+cFxUqXWjcO1j2sjbTyewdIp9XmWEqJJIX/8gZ0MG90ld0QARBWMmknCUU1nBUFsUsXazgrQrvG5mXvioB1trgNxM3omaHm5cV0JVmV6NYSd+LX6XXXKga+6+CiYqYVuXwt3DTRbeqw6Fbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1k2KjYbE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QRwn0Jpr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721287515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IybnAjkns1vo3Yzo3bcVZRByBGhG1dccIwYMdpc8U4k=;
	b=1k2KjYbEruhgnRkMGc+fTzVnCfrCYYWxDBPCoA2H32uwWPy6jQ+90Tl9f8IPFh8qI3be30
	2Hlcb2wWlka1WPH/Vk+t0hifP4Qr3dvgy4ZKsw0iv48HtUqmH2zDOdupPsifg69OBDWzKz
	v0xclbLFmczkREQCD4atrrOqGHhH/aJwChRUjzL20AhhXG+4i/DE8fUJq8sNA60J64YvdP
	GLAvzTeDHid+YOR+4zB/MLG47zU5kmVlaTbAJxpzAPJDyTTXAKPbk0ZfnlKmQEzpdZnLa+
	yO5Eg1gyAqUqDRMHWXImsY9rmKlkm+TKU0NCYnqLqTq6uEAppCE44I3ZfG/g0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721287515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IybnAjkns1vo3Yzo3bcVZRByBGhG1dccIwYMdpc8U4k=;
	b=QRwn0Jprs3oJwRX0qlQ2u32cf1z1/mfAfoIeUyD1znjZ/wfDzLIicGCS1lcyKCgiu37TJ6
	QbVyS0G2rWX/tDCQ==
To: Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Omar Sandoval <osandov@meta.com>, linux-kernel@vger.kernel.org, Petr
 Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, kernel-team <kernel-team@meta.com>
Subject: Re: [RFC PATCH] nmi,printk: fix ABBA deadlock between nmi_backtrace
 and dump_stack_lvl
In-Reply-To: <93155b2ccafa43ed4845ae450451c6b8e27509cc.camel@surriel.com>
References: <20240715232052.73eb7fb1@imladris.surriel.com>
 <87plrcqyii.fsf@jogness.linutronix.de>
 <93155b2ccafa43ed4845ae450451c6b8e27509cc.camel@surriel.com>
Date: Thu, 18 Jul 2024 09:31:14 +0206
Message-ID: <87r0brkvqd.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-07-17, Rik van Riel <riel@surriel.com> wrote:
> I think that would do the trick. The nmi_backtrace() printk is already
> deferred, because of the check for in_nmi() in vprintk(), and this
> change would put all the other users of printk_cpu_sync_get_irqsave()
> on the exact same footing as nmi_backtrace().
>
> Combing through the code a little, it looks like that would remove
> the potential for this deadlock to happen again.

Let's see what Petr has to say. (He'll be back on Monday.) He might
prefer a solution that does not result in deferring printing for all
cases. i.e. allow the console_lock if it is available, but avoid the
spinning if it is not. Below is a patch that would achieve this.

John

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index dddb15f48d59..36f40db0bf93 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1060,6 +1060,8 @@ static int __init log_buf_len_setup(char *str)
 early_param("log_buf_len", log_buf_len_setup);
 
 #ifdef CONFIG_SMP
+static bool vprintk_emit_may_spin(void);
+
 #define __LOG_CPU_MAX_BUF_LEN (1 << CONFIG_LOG_CPU_MAX_BUF_SHIFT)
 
 static void __init log_buf_add_cpu(void)
@@ -1090,6 +1092,7 @@ static void __init log_buf_add_cpu(void)
 }
 #else /* !CONFIG_SMP */
 static inline void log_buf_add_cpu(void) {}
+static inline bool vprintk_emit_may_spin(void) { return true };
 #endif /* CONFIG_SMP */
 
 static void __init set_percpu_data_ready(void)
@@ -2330,6 +2333,8 @@ asmlinkage int vprintk_emit(int facility, int level,
 
 	/* If called from the scheduler, we can not call up(). */
 	if (!in_sched) {
+		int ret;
+
 		/*
 		 * The caller may be holding system-critical or
 		 * timing-sensitive locks. Disable preemption during
@@ -2344,7 +2349,11 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 * spinning variant, this context tries to take over the
 		 * printing from another printing context.
 		 */
-		if (console_trylock_spinning())
+		if (vprintk_emit_may_spin())
+			ret = console_trylock_spinning();
+		else
+			ret = console_trylock();
+		if (ret)
 			console_unlock();
 		preempt_enable();
 	}
@@ -4321,6 +4330,15 @@ void console_replay_all(void)
 static atomic_t printk_cpu_sync_owner = ATOMIC_INIT(-1);
 static atomic_t printk_cpu_sync_nested = ATOMIC_INIT(0);
 
+/*
+ * As documented in printk_cpu_sync_get_irqsave(), a context holding the
+ * printk_cpu_sync must not spin waiting for another CPU.
+ */
+static bool vprintk_emit_may_spin(void)
+{
+	return (atomic_read(&printk_cpu_sync_owner) != smp_processor_id());
+}
+
 /**
  * __printk_cpu_sync_wait() - Busy wait until the printk cpu-reentrant
  *                            spinning lock is not owned by any CPU.

