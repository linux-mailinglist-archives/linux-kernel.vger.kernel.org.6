Return-Path: <linux-kernel+bounces-208604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37E8902722
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0FF280A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537FD14B973;
	Mon, 10 Jun 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QX8uJJ6V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OhxydISX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9449A15821D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037778; cv=none; b=DstuGeyrI/e7X77TmsCkt0qYSpkqlp5UiPTBBE3dNB4OBKiwUx+Ic569N+sAwL3YsdR3bs6L704bxHDlbbhCpOfUkzvgx1NSsmvD53PWY3ClDASRtNPxEy7SsDmuQwUWUBFK/vmC2ZXwT3xTGluPcoWFnPuYCLubBPF/gm9pdYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037778; c=relaxed/simple;
	bh=VuquKDx1UsylcAk0iwg0hQ5NDYGE0CpOTQXupRp5l1M=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=NnyuvRm+eEMi2XqWu10EOa9ooKvbRUjidk8rWqWufwDQTR8Zu1zI7Kk4qOIuD7tRTwGBT3D8y4mThnWhm4M6j9f7KqxKiFVNi/5IfKx++I66pv0Qx6CAXJQy09Flhnobc6hW9sqLch/2wujnYTMgOH+pAAkIxVTiqrSuAlBGvQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QX8uJJ6V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OhxydISX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164027.926962477@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kwIYt4xep4FzC+R5XhsxRfT1Fdua37YGd826SHbkkcY=;
	b=QX8uJJ6Vv8iiiUqeXSYU6qutpZ+o7ryozONkf3I6dZtPidyobtZkl9RRUBttpuCcF68oNc
	jb9lPTksgXF/DH1mUp/yT+99zLiA86OyXKANvwGy0Nkb7ZAI2ozXfTGJNnFu9XglXV6xkw
	51goLntckyr3hzoicOnORel5BwTH0a+XzNbIn/xX+UUiJmksmBgq7RfXeXB/fg9Eqw0PZE
	lS6oSo9LDAcHOpao2f1y/35w1YmLipb85qN2cvISm21otRu5kWehmaY0G5Y8icM4i4xMJq
	8ZW8X83ojDM2uNyULVcsZ89GUbGif5+PrgSnLsFOnNnUvHC9eNTJGAo5FGGPMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kwIYt4xep4FzC+R5XhsxRfT1Fdua37YGd826SHbkkcY=;
	b=OhxydISXG87NqC4EK1/W1c1161/o90rCuI4nDF6Z8aqTq/SBtptollKdzInAr+y1G7cZwy
	7Y04AnxviBvNRfBw==
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
Subject: [patch V3 39/51] signal: Add sys_private_ptr to
 siginfo::_sifields::_timer
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:53 +0200 (CEST)

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
---
 arch/x86/kernel/signal_32.c        |    2 +-
 arch/x86/kernel/signal_64.c        |    2 +-
 include/uapi/asm-generic/siginfo.h |    2 ++
 kernel/signal.c                    |    6 ++++--
 kernel/time/posix-timers.c         |    4 +++-
 5 files changed, 11 insertions(+), 5 deletions(-)

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
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -456,7 +456,7 @@ static_assert(offsetof(siginfo_t, si_pid
 static_assert(offsetof(siginfo_t, si_uid) == 0x14);
 
 CHECK_SI_OFFSET(_timer);
-CHECK_SI_SIZE  (_timer, 6*sizeof(int));
+CHECK_SI_SIZE  (_timer, 8*sizeof(int));
 static_assert(offsetof(siginfo_t, si_tid)     == 0x10);
 static_assert(offsetof(siginfo_t, si_overrun) == 0x14);
 static_assert(offsetof(siginfo_t, si_value)   == 0x18);
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
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3406,12 +3406,14 @@ static int post_copy_siginfo_from_user(k
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
+		info->su_sys_privptr = NULL;
+	}
 
 	if (unlikely(!known_siginfo_layout(info->si_signo, info->si_code))) {
 		char __user *expansion = si_expansion(from);
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -289,8 +289,9 @@ bool posixtimer_deliver_signal(struct ke
 out:
 	spin_lock(&current->sighand->siglock);
 
-	/* Don't expose the si_sys_private value to userspace */
+	/* Don't expose the si_sys_priv* values to userspace */
 	info->si_sys_private = 0;
+	info->si_sys_privptr = NULL;
 	return ret;
 }
 
@@ -505,6 +506,7 @@ static int do_timer_create(clockid_t whi
 
 	new_timer->sigq->info.si_tid   = new_timer->it_id;
 	new_timer->sigq->info.si_code  = SI_TIMER;
+	new_timer->sigq->info.si_sys_privptr  = new_timer;
 
 	if (copy_to_user(created_timer_id, &new_timer_id, sizeof (new_timer_id))) {
 		error = -EFAULT;


