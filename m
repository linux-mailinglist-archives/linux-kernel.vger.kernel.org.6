Return-Path: <linux-kernel+bounces-396087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338499BC7C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA8B281637
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BC01FF025;
	Tue,  5 Nov 2024 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ySapAwcb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dg7wOHfi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A91FF7BC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794480; cv=none; b=o5oU+06mJyA6+gOVfmciKzIwf497OA4zPnDj7y+pOX+RHpcnv/ycZzgvJuFZxJeJjYTBOrfWZi9VhSt8QrLr1YNL7f+8yaGAe3WOkI7ywop1QLM+C2B+rpoS0+NpdW7IMyU45mjtz/yQZ+VB0Wofg7NI3giNkrrOg8smFA16skk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794480; c=relaxed/simple;
	bh=QbkYyBRpF2fRHXbLBtaHVxyHhn+tHgWPBmgUfEHCP8g=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=BXbpl6g3j0haW5Ipn59+J0iInGb6U/duQJkGTTbKhwWVel2WwKVboyHpq74D6KlTWdrHRKJUH6tCHzyQfePFva3BUdYXwwocZrtMwd8or1sDlHMGShuEnvL1BeZOoC8nGquZ+u3+QFepH+bxvVyE8zAsXe5L3YOjgVMNXX4ISnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ySapAwcb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dg7wOHfi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241105064213.238550394@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730794476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TiCPSJPjhxv84/X/5NCXjuUQPwnLD0doUBLiN4iWfDA=;
	b=ySapAwcbKaoe5Lkb6hgF2QOXzU0l7zzMf1gI9/pLnRdIoa9f7UPEXYZXB/fPjZnSj4mxLS
	Pi52WzS0TNLvo2EGCMGJph6WAKPhJxdKVLb7CNLZGvBrqpw1VvVeCbY9wDy4qjuJy56yw1
	bJ3ZxAaLQDxo6v4QtuOtsGiziuN5w4NI5PIZq7BP9S6B2TDCgOXsr38DXzyBm2uqUDeAen
	HZPk9NXdiXM5ARxtb5fUXjKu6ECm+xQeuyqsLGuD/Ri57hvdc6RuacvW53SCYGdmZys8Du
	pDy5TxuFDsK3vOR/xq2yUfH+tRnNpnAX6sTImOjTZ1SiWL58q+BZwKWB9DOW2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730794476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TiCPSJPjhxv84/X/5NCXjuUQPwnLD0doUBLiN4iWfDA=;
	b=dg7wOHfidFZsW9E/Uuen0UvV5tYn5Ha6JSA52vs2/UmjhsFAtGReiOyHDx2wlnETekZ+xj
	0wo+FPKs1Cg0KTDA==
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
Subject: [patch V7 05/21] posix-cpu-timers: Use dedicated flag for CPU timer
 nanosleep
References: <20241105063544.565410398@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  5 Nov 2024 09:14:35 +0100 (CET)

POSIX CPU timer nanosleep creates a k_itimer on stack and uses the sigq
pointer to detect the nanosleep case in the expiry function.

Prepare for embedding sigqueue into struct k_itimer by using a dedicated
flag for nanosleep.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 include/linux/posix-timers.h   |    2 ++
 kernel/time/posix-cpu-timers.c |    3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)
---

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -42,6 +42,7 @@ static inline int clockid_to_fd(const cl
  * @pid:	Pointer to target task PID
  * @elist:	List head for the expiry list
  * @firing:	Timer is currently firing
+ * @nanosleep:	Timer is used for nanosleep and is not a regular posix-timer
  * @handling:	Pointer to the task which handles expiry
  */
 struct cpu_timer {
@@ -50,6 +51,7 @@ struct cpu_timer {
 	struct pid			*pid;
 	struct list_head		elist;
 	bool				firing;
+	bool				nanosleep;
 	struct task_struct __rcu	*handling;
 };
 
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -596,7 +596,7 @@ static void cpu_timer_fire(struct k_itim
 
 	timer->it_status = POSIX_TIMER_DISARMED;
 
-	if (unlikely(timer->sigq == NULL)) {
+	if (unlikely(ctmr->nanosleep)) {
 		/*
 		 * This a special case for clock_nanosleep,
 		 * not a normal timer from sys_timer_create.
@@ -1493,6 +1493,7 @@ static int do_cpu_nanosleep(const clocki
 	timer.it_overrun = -1;
 	error = posix_cpu_timer_create(&timer);
 	timer.it_process = current;
+	timer.it.cpu.nanosleep = true;
 
 	if (!error) {
 		static struct itimerspec64 zero_it;


