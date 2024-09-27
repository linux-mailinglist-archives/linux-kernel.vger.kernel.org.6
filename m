Return-Path: <linux-kernel+bounces-341490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FDE9880CA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF721F2271D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E026818A6DD;
	Fri, 27 Sep 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lDl6umro";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1c+LurNi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7285E1B1D70
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426941; cv=none; b=pFa9EGu08TtpwuljvKdLC4bsK1mKQZTctY9go24nxRZ9zod4rZZKzV6skYp3cLqa5gNIyT5ga6/yn6TXJTbr5BT7DXjud2OCeMEhfbnbLm5+uOk/b2F/TmZGNr3dFPxd7kFo1Y41h4sKIlMX3dZ5idtjmJZ9K6tTSAgbkN7jP5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426941; c=relaxed/simple;
	bh=PEewBGulmZPu8ZHmUN61qpWbDO61m5TTGTWBqYAmiHk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=FKLorChlxDGLGcrBeOiWBoOMYWUrQLYcbyNYhdoJIOUTcxnqQftCId5SXvwhw+3xuZGFJlnXGJ5IMImXIsdgVL2DjwfMCLxJhm7Xbsj73eoONKcU8FAJjOZTM1cBHFdP+BZALO5OajdSKZrPSyaMlBr7xD8T5NFDsyzzS72QzHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lDl6umro; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1c+LurNi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084817.817985972@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nrmvUR0qb/rc4yHapT27FFgcyIjEIsAuloH4m+uCF3Q=;
	b=lDl6umroqt5gVInyd2xf630fxe1xOesJxiPOhOMAGovmIQVcNhH6YnT098Z774kwICgZBO
	yEmt3rYwRj4NnScjY/3f0oIQHfHxDQDuxHfipVV6RnMsOQkFrvVvKpLnFSXVamiYlAGTSR
	MTE0NboyBlYaTk1MG5cUzMf5KKk6wcp4xF3fKU0GuGdYn6huliw3n8btIn8QtqYu/ZG3P/
	5rmFyHYZu1Hhb8eppp3czNeP2fHCMGM7DDFVKDNiMNhPf4QrdqKo03o5q14jFKuk2sRsQv
	ehndz/6h9CHeZ3Hh2DdlTJGCS/arUe4zmQ9nFhnv4LxfD6EcL7OJa/iwVSfUhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nrmvUR0qb/rc4yHapT27FFgcyIjEIsAuloH4m+uCF3Q=;
	b=1c+LurNiqb+61JWPQOnr5+rjYlcW/d4t8V2CKcOHU5ZWy6SthzluriNRMYnFO0opHigplx
	HFM8DN90bVFtq6Bg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch v4 15/27] signal: Add sys_private_ptr to siginfo::_sifields::
 _timer
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:48:57 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

On signal delivery collect_signal() copies the queued siginfo into a caller
provided siginfo struct. The posix timer signal delivery code then uses
siginfo::si_tid to lookup the timer in the hash table.

That's required today as the timer and the sigqueue are separate entities
and have different life time rules.

The sigqueue will be embedded into struct k_itimer to address a few issues
in the posix timer signal handling, which means the life time rules are
not longer separate, which can spare the lookup.

Due to locking rules posixtimer_deliver_signal() cannot be invoked from
collect_signal(). The timer pointer could be handed down from
collect_signal() to dequeue_signal(), but that's just overhead for the
non-posixtimer case.

There is room in the _sifields union for an extra pointer which will be
used later for storing the timer pointer. This field is copied with siginfo
and cleared before the info is delivered to userspace like the existing
si_sys_private field.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 arch/x86/kernel/signal_32.c        | 2 +-
 arch/x86/kernel/signal_64.c        | 2 +-
 include/uapi/asm-generic/siginfo.h | 2 ++
 kernel/signal.c                    | 6 ++++--
 kernel/time/posix-timers.c         | 4 +++-
 5 files changed, 11 insertions(+), 5 deletions(-)
---
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index ef654530bf5a..34ce839ed4ff 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -456,7 +456,7 @@ CHECK_SI_OFFSET(_timer);
 /* compat_siginfo_t doesn't have si_sys_private */
 CHECK_SI_SIZE  (_timer, 3*sizeof(int));
 #else
-CHECK_SI_SIZE  (_timer, 4*sizeof(int));
+CHECK_SI_SIZE  (_timer, 5*sizeof(int));
 #endif
 static_assert(offsetof(siginfo32_t, si_tid)     == 0x0C);
 static_assert(offsetof(siginfo32_t, si_overrun) == 0x10);
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 8a94053c5444..dd96b7f3f60c 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -462,7 +462,7 @@ static_assert(offsetof(siginfo_t, si_pid) == 0x10);
 static_assert(offsetof(siginfo_t, si_uid) == 0x14);
 
 CHECK_SI_OFFSET(_timer);
-CHECK_SI_SIZE  (_timer, 6*sizeof(int));
+CHECK_SI_SIZE  (_timer, 8*sizeof(int));
 static_assert(offsetof(siginfo_t, si_tid)     == 0x10);
 static_assert(offsetof(siginfo_t, si_overrun) == 0x14);
 static_assert(offsetof(siginfo_t, si_value)   == 0x18);
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index b7bc545ec3b2..702d7d3ca117 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -47,6 +47,7 @@ union __sifields {
 		int _overrun;		/* overrun count */
 		sigval_t _sigval;	/* same as below */
 		int _sys_private;       /* not to be passed to user */
+		void *_sys_privptr;	/* not to be passed to user */
 	} _timer;
 
 	/* POSIX.1b signals */
@@ -146,6 +147,7 @@ typedef struct siginfo {
 #define si_tid		_sifields._timer._tid
 #define si_overrun	_sifields._timer._overrun
 #define si_sys_private  _sifields._timer._sys_private
+#define si_sys_privptr  _sifields._timer._sys_privptr
 #define si_status	_sifields._sigchld._status
 #define si_utime	_sifields._sigchld._utime
 #define si_stime	_sifields._sigchld._stime
diff --git a/kernel/signal.c b/kernel/signal.c
index a857f6628e77..0aa01eec5e2d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3410,12 +3410,14 @@ static int post_copy_siginfo_from_user(kernel_siginfo_t *info,
 				       const siginfo_t __user *from)
 {
 	/*
-	 * Clear the si_sys_private field for timer signals as that's the
+	 * Clear the si_sys_priv* fields for timer signals as that's the
 	 * indicator for rearming a posix timer. User space submitted
 	 * signals are not allowed to inject that.
 	 */
-	if (info->si_code == SI_TIMER)
+	if (info->si_code == SI_TIMER) {
 		info->si_sys_private = 0;
+		info->si_sys_privptr = NULL;
+	}
 
 	if (unlikely(!known_siginfo_layout(info->si_signo, info->si_code))) {
 		char __user *expansion = si_expansion(from);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1c2f6090b767..9d7e02db4157 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -289,8 +289,9 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 out:
 	spin_lock(&current->sighand->siglock);
 
-	/* Don't expose the si_sys_private value to userspace */
+	/* Don't expose the si_sys_priv* values to userspace */
 	info->si_sys_private = 0;
+	info->si_sys_privptr = NULL;
 	return ret;
 }
 
@@ -505,6 +506,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 
 	new_timer->sigq->info.si_tid   = new_timer->it_id;
 	new_timer->sigq->info.si_code  = SI_TIMER;
+	new_timer->sigq->info.si_sys_privptr  = new_timer;
 
 	if (copy_to_user(created_timer_id, &new_timer_id, sizeof (new_timer_id))) {
 		error = -EFAULT;


