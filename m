Return-Path: <linux-kernel+bounces-264106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ADA93DF07
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595821F22F13
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4098A13A416;
	Sat, 27 Jul 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RdgnCKZ7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553E7404B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078149; cv=none; b=LYRJ7BDuC8VTpEhJ+9tXRQiKSRx8ajyhVfDOXBnkyGOC8P0kyQKhtFmUZjkQAljOA/yzoIbm6O6P9VcivJd7p2atwWjkNjY58iznofcTUT3XrU4L6+Q4J3NeVQzbP9vdoTH0RthHMoSuFOLpPEZqom/EIkfvf734kEyjomuzTLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078149; c=relaxed/simple;
	bh=gw3JP4/yaIApWvKIzw8xSsfXB6GJVNQesX3J64WYlD0=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IgZJLrQylLJCFm79q0btdQ64HdbPhrapuyqIUZoLpZJoYfNhiq1W3+6Q4NDRppfQRnniO5UoQfcVzaM1GGbRhQFnyY+k8nYkFaeqEp+1Lf84UbLvQ/9aiZI0d2GJvt9r66rq6Mlz1YyrWdX8iwLD8G1jb43DOVVSApB1Ea9anzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RdgnCKZ7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=mnMD1X1rMlybv0/z4WGvNLJsPKB2ipjRlyKJPJw/a9E=; b=RdgnCKZ7lGCtBr1mWeYG0DrL7I
	efJJNj/vUYpODp8Jf7MSSDtPKt12/k/h8GwIc8l/GDPP5UwQWDSYwfvYbzKe+3c4/sMIF2mrvDHhk
	kDRfHO9WM9pti5+ZS7DZ+xHnKvbAnh/eHoREvRZZ9VImsUq0Sz1E31oimZHhfs+OpBjyza0NyFd9d
	+I2rid3IdRwpekBaL5OMb8gn1Hzulldgc23R2qOn3iWoRW0FxbeRxbtALTKYsBmIL/gjAns4jdMYy
	HJkWazrfk/547tOuBclABs6WoH1tqoTXmVtAki2A19tSxEfhlNT0SyazM2Njg5YgK9jSFVJamq3Sp
	wlg4Nliw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBg-0000000BGJV-3v9I;
	Sat, 27 Jul 2024 11:02:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D1C803061D0; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105029.998329901@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 youssefesmat@chromium.org,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [PATCH 15/24] sched,freezer: Mark TASK_FROZEN special
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The special task states are those that do not suffer spurious wakeups,
TASK_FROZEN is very much one of those, mark it as such.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |    5 +++--
 kernel/freezer.c      |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -147,8 +147,9 @@ struct user_event_mm;
  * Special states are those that do not use the normal wait-loop pattern. See
  * the comment with set_special_state().
  */
-#define is_special_task_state(state)				\
-	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_PARKED | TASK_DEAD))
+#define is_special_task_state(state)					\
+	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_PARKED |	\
+		    TASK_DEAD | TASK_FROZEN))
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 # define debug_normal_state_change(state_value)				\
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -72,7 +72,7 @@ bool __refrigerator(bool check_kthr_stop
 		bool freeze;
 
 		raw_spin_lock_irq(&current->pi_lock);
-		set_current_state(TASK_FROZEN);
+		WRITE_ONCE(current->__state, TASK_FROZEN);
 		/* unstale saved_state so that __thaw_task() will wake us up */
 		current->saved_state = TASK_RUNNING;
 		raw_spin_unlock_irq(&current->pi_lock);



