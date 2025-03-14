Return-Path: <linux-kernel+bounces-561034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD54A60CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2CA19C40E3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415751DD877;
	Fri, 14 Mar 2025 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iStASjMG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995C61DE3AD
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943196; cv=none; b=fsmYZ1JAUiOkaNBdfJR0ROK71c85Dd1Hmplw2iuuQNODVwYSjZR9XV/kE0f+ggRdSrB7bSY7SfFHtLF9QFDbUwJio1WMMv6i1kHOT6Q5Tj+C2Kg3JS6LAknDbwZQHSevPd9E512LK11oE/odpxwX6r52wfNc+kXQV44Hgjj+Guc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943196; c=relaxed/simple;
	bh=+9n/Xsv4eq2uOVgOb3dL7uqXsixU1P8o1Q9Nc+iPAtA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QaxgBkGsDodb3wzE2kKqYJTY0g4Ro0jFLP4S4YV1aGT5+CVuOhLexcyUXW6O1DYZ8Flm91oUFrrZDYTP5KOInOIxJIPf93qQ4JbdgBOPYCrtz7BudTR0dKqT/ja+d9+HGDCFJ1JmDpmVbJnhZpdJDmqJOvqeTTBl3awmdNyabCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iStASjMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA485C4CEE3;
	Fri, 14 Mar 2025 09:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741943196;
	bh=+9n/Xsv4eq2uOVgOb3dL7uqXsixU1P8o1Q9Nc+iPAtA=;
	h=Date:From:To:Cc:Subject:From;
	b=iStASjMGK+Jl0ir6Tlnl9rpVxxaGqg4iXtX5Ll8d2muutRGllIAiWdIgX40E8Zua9
	 7XJUhXxw1ZL4iR1QDMw6inYQvEeY/FJKEB9jshOE8xq0utVk+bpaolVfhjWcnTeY11
	 4WxlIeWXzXjOzEZK7h9VVjwkUMOBBB8os/pY1cSds6TzmyauCwoHRyfGO+uOMeT6s6
	 zqp4jsiIepblGkkP6YH2p0iRj1R7f2TzzGIVZek5dQu4ZyzV/A3RU2z7gwm5fvkbNu
	 V77ZZzoPN/sUjWl6rSr4Ey9D0STTk5gYjXGSeHxbhFw6JoWH6K2nwGmOm2FFozoqMW
	 b/e8QYCVPNZZg==
Date: Fri, 14 Mar 2025 10:06:31 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>
Subject: [GIT PULL] locking fixes
Message-ID: <Z9Pxl-ItRBaAUd9Y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest locking/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-03-14

   # HEAD: 85b2b9c16d053364e2004883140538e73b333cdb locking/semaphore: Use wake_q to wake up processes outside lock critical section

Miscellaneous fixes:

 - Restrict the Rust runtime from unintended access
   to dynamically allocated LockClassKeys

 - KernelDoc annotation fix

 - Fix a lock ordering bug in semaphore::up(), related
   to trying to printk() and wake up the console
   within critical sections

 Thanks,

	Ingo

------------------>
Mitchell Levy (1):
      rust: lockdep: Remove support for dynamically allocated LockClassKeys

Randy Dunlap (1):
      locking/rtmutex: Use the 'struct' keyword in kernel-doc comment

Waiman Long (1):
      locking/semaphore: Use wake_q to wake up processes outside lock critical section


 kernel/locking/rtmutex_common.h |  4 ++--
 kernel/locking/semaphore.c      | 13 +++++++++----
 rust/kernel/sync.rs             | 16 ++++------------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index c38a2d2d4a7e..78dd3d8c6554 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -59,8 +59,8 @@ struct rt_mutex_waiter {
 };
 
 /**
- * rt_wake_q_head - Wrapper around regular wake_q_head to support
- *		    "sleeping" spinlocks on RT
+ * struct rt_wake_q_head - Wrapper around regular wake_q_head to support
+ *			   "sleeping" spinlocks on RT
  * @head:		The regular wake_q_head for sleeping lock variants
  * @rtlock_task:	Task pointer for RT lock (spin/rwlock) wakeups
  */
diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 34bfae72f295..de9117c0e671 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -29,6 +29,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/wake_q.h>
 #include <linux/semaphore.h>
 #include <linux/spinlock.h>
 #include <linux/ftrace.h>
@@ -38,7 +39,7 @@ static noinline void __down(struct semaphore *sem);
 static noinline int __down_interruptible(struct semaphore *sem);
 static noinline int __down_killable(struct semaphore *sem);
 static noinline int __down_timeout(struct semaphore *sem, long timeout);
-static noinline void __up(struct semaphore *sem);
+static noinline void __up(struct semaphore *sem, struct wake_q_head *wake_q);
 
 /**
  * down - acquire the semaphore
@@ -183,13 +184,16 @@ EXPORT_SYMBOL(down_timeout);
 void __sched up(struct semaphore *sem)
 {
 	unsigned long flags;
+	DEFINE_WAKE_Q(wake_q);
 
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(list_empty(&sem->wait_list)))
 		sem->count++;
 	else
-		__up(sem);
+		__up(sem, &wake_q);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
+	if (!wake_q_empty(&wake_q))
+		wake_up_q(&wake_q);
 }
 EXPORT_SYMBOL(up);
 
@@ -269,11 +273,12 @@ static noinline int __sched __down_timeout(struct semaphore *sem, long timeout)
 	return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
 }
 
-static noinline void __sched __up(struct semaphore *sem)
+static noinline void __sched __up(struct semaphore *sem,
+				  struct wake_q_head *wake_q)
 {
 	struct semaphore_waiter *waiter = list_first_entry(&sem->wait_list,
 						struct semaphore_waiter, list);
 	list_del(&waiter->list);
 	waiter->up = true;
-	wake_up_process(waiter->task);
+	wake_q_add(wake_q, waiter->task);
 }
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 3498fb344dc9..16eab9138b2b 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -30,28 +30,20 @@
 unsafe impl Sync for LockClassKey {}
 
 impl LockClassKey {
-    /// Creates a new lock class key.
-    pub const fn new() -> Self {
-        Self(Opaque::uninit())
-    }
-
     pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
         self.0.get()
     }
 }
 
-impl Default for LockClassKey {
-    fn default() -> Self {
-        Self::new()
-    }
-}
-
 /// Defines a new static lock class and returns a pointer to it.
 #[doc(hidden)]
 #[macro_export]
 macro_rules! static_lock_class {
     () => {{
-        static CLASS: $crate::sync::LockClassKey = $crate::sync::LockClassKey::new();
+        static CLASS: $crate::sync::LockClassKey =
+            // SAFETY: lockdep expects uninitialized memory when it's handed a statically allocated
+            // lock_class_key
+            unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
         &CLASS
     }};
 }

