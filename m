Return-Path: <linux-kernel+bounces-227431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D46915119
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47091F25F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889E019D8A1;
	Mon, 24 Jun 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SkCxa4B3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tsxt/pp1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A5519D076
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240862; cv=none; b=Sz7UfJtJqOvEOn46EzT/OIyr7NdhAXm0Gj4tuPGx7EWomqMpVonR0hk8eYkgcoT17Zr2TnZJyNooU8T2zf7LhFcDLAttHZpBFc4zIUDsCnTfDbxiJvSvaJ3y53ckXBH8vkHhZN3+P82EhuqQEqYiKQh3tEKmnl0i+vT4QCqpIHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240862; c=relaxed/simple;
	bh=ALyMCnPuofxu9ffvPlOcV1t2j2NwHcomo3j39FHLctU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m1D3kTuYeUPrqIrl/h7PjxCGfkbLWadOPzxdIb0eAJjZJD0tVX8GCyvztVB7nryUnexhGYQreWKZqas8klzaTo7g1DAYVovnSWOg8ssjQEiIWcxGqaTaUCOqaAnQohq23pq5RpDDiippW4IXk28cYw72UgX1Tz8lhAyEZTmVamw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SkCxa4B3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tsxt/pp1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719240858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjbihVcK59OxT8itrX6DwAUHPlbzLTEjwCtwqlkepCk=;
	b=SkCxa4B3j8G2Gg3BJL0idiyzmLruXC9Z2IRCnPx2SzSaMhDg69/LMaqd6t0upQKiNBb+50
	8BbJELU/gDlXlheCstF/i+hokcT0vWAax0I4NPwG+xt7mynbs42KZcEMZDEwuhb8v53cHc
	phsz8yfj3oneIBsY2N3c/jhe/QSmbPyPGFOwtVZe+6UwKYQ367OjQHbPvOYtUVua6HT/0C
	W7WdggDfSrBEyp7W25oazjEjbZ1hCrWze0WbMD/TUwG+CgyfpGY1CIrbMEjGWazV3JxKGn
	P2e7yOi1on0HEUnNNKijiLexPT4rttYjWRr9K9wSkz2KqP2n9Pz+E0s4HYGByQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719240858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjbihVcK59OxT8itrX6DwAUHPlbzLTEjwCtwqlkepCk=;
	b=tsxt/pp1zL6CmjT2y6aMnOXFcTZWQJccl5x6eNMUDU/l7UD7glOgawL0crqnJE78CjWxjY
	5PhdscQxhkkRmnCQ==
Date: Mon, 24 Jun 2024 16:53:56 +0200
Subject: [PATCH v2 4/5] timer_migration: Fix possible race in
 tmigr_active_up() in setup path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-tmigr-fixes-v2-4-3eb4c0604790@linutronix.de>
References: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>
In-Reply-To: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>

Frederic reported the following possible race:


		  [GRP0:0]
	       migrator = 0
	       active   = 0
	       nextevt  = KTIME_MAX
	       /         \
	      0         1 .. 7
	  active         idle

0) Hierarchy has for now only 8 CPUs and CPU 0 is the only active CPU.

			     [GRP1:0]
			migrator = TMIGR_NONE
			active   = NONE
			nextevt  = KTIME_MAX
					 \
		 [GRP0:0]                  [GRP0:1]
	      migrator = 0              migrator = TMIGR_NONE
	      active   = 0              active   = NONE
	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
		/         \
	      0          1 .. 7                8
	  active         idle                !online

1) CPU 8 is booting and creates a new group in first level GRP0:1 and
   therefore also a new top group GRP1:0. For now the setup code proceeded
   only until the connected between GRP0:1 to the new top group. The
   connection between CPU8 and GRP0:1 is not yet established and CPU 8 is
   still !online.

			     [GRP1:0]
			migrator = TMIGR_NONE
			active   = NONE
			nextevt  = KTIME_MAX
		       /                  \
		 [GRP0:0]                  [GRP0:1]
	      migrator = 0              migrator = TMIGR_NONE
	      active   = 0              active   = NONE
	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
		/         \
	      0          1 .. 7                8
	  active         idle                !online

2) Setup code now connects GRP0:0 to GRP1:0 and observes while in
   tmigr_connect_child_parent() that GRP0:0 is not TMIGR_NONE. So it
   prepares to call tmigr_active_up() on it. It hasn't done it yet.

			     [GRP1:0]
			migrator = TMIGR_NONE
			active   = NONE
			nextevt  = KTIME_MAX
		       /                  \
		 [GRP0:0]                  [GRP0:1]
	      migrator = TMIGR_NONE        migrator = TMIGR_NONE
	      active   = NONE              active   = NONE
	      nextevt  = KTIME_MAX         nextevt  = KTIME_MAX
		/         \
	      0          1 .. 7                8
	    idle         idle                !online

3) CPU 0 goes idle. Since GRP0:0->parent has been updated by CPU 8 with
   GRP0:0->lock held, CPU 0 observes GRP1:0 after calling
   tmigr_update_events() and it propagates the change to the top (no change
   there and no wakeup programmed since there is no timer).

			     [GRP1:0]
			migrator = GRP0:0
			active   = GRP0:0
			nextevt  = KTIME_MAX
		       /                  \
		 [GRP0:0]                  [GRP0:1]
	      migrator = TMIGR_NONE       migrator = TMIGR_NONE
	      active   = NONE             active   = NONE
	      nextevt  = KTIME_MAX        nextevt  = KTIME_MAX
		/         \
	      0          1 .. 7                8
	    idle         idle                !online

4) Now the setup code finally calls tmigr_active_up() to and sets GRP0:0
   active in GRP1:0

			     [GRP1:0]
			migrator = GRP0:0
			active   = GRP0:0, GRP0:1
			nextevt  = KTIME_MAX
		       /                  \
		 [GRP0:0]                  [GRP0:1]
	      migrator = TMIGR_NONE       migrator = 8
	      active   = NONE             active   = 8
	      nextevt  = KTIME_MAX        nextevt  = KTIME_MAX
		/         \                    |
	      0          1 .. 7                8
	    idle         idle                active

5) Now CPU 8 is connected with GRP0:1 and CPU 8 calls tmigr_active_up() out
   of tmigr_cpu_online().

			     [GRP1:0]
			migrator = GRP0:0
			active   = GRP0:0
			nextevt  = T8
		       /                  \
		 [GRP0:0]                  [GRP0:1]
	      migrator = TMIGR_NONE         migrator = TMIGR_NONE
	      active   = NONE               active   = NONE
	      nextevt  = KTIME_MAX          nextevt  = T8
		/         \                    |
	      0          1 .. 7                8
	    idle         idle                  idle

5) CPU 8 goes idle with a timer T8 and relies on GRP0:0 as the migrator.
   But it's not really active, so T8 gets ignored.

The update which is done in third step is not noticed by setup code. So a
wrong migrator is set to top level group and a timer could get ignored.

Rework the activation of an already existing group in setup code after
adding a new top level group and use memory barriers (as already used in
tmigr_inactive_up()) to be sure that child state updates and group state
updates are ordered properly.

The update of the group event ignore bit is now ignored. But this is fine,
as this bit is only required when queueing the event into the timer queue
of the parent group. As this is always the update of the top level group,
it doesn't matter.

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Reported-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer_migration.c | 49 ++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 0e1c53dac390..7971512a60b0 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1448,6 +1448,37 @@ u64 tmigr_quick_check(u64 nextevt)
 	return KTIME_MAX;
 }
 
+static void tmigr_setup_active_up(struct tmigr_group *group, struct tmigr_group *child)
+{
+	union tmigr_state curstate, childstate;
+	bool walk_done;
+
+	/*
+	 * Memory barrier is paired with the cmpxchg in tmigr_inactive_up() to
+	 * make sure updates of child and group states are ordered. The ordering
+	 * is mandatory, as the update of the group state is only valid for when
+	 * child state is active.
+	 */
+	curstate.state = atomic_read_acquire(&group->migr_state);
+
+	for (;;) {
+		childstate.state = atomic_read(&child->migr_state);
+		if (!childstate.active)
+			return;
+
+		if (__tmigr_active_up(group, &walk_done, &curstate, child->childmask))
+			break;
+
+		/*
+		 * The memory barrier is paired with the cmpxchg() in
+		 * tmigr_inactive_up() to make sure the updates of child and
+		 * group states are ordered. It is required only when the
+		 * try_cmpxchg() in __tmigr_active_up() fails.
+		 */
+		smp_mb__after_atomic();
+	}
+}
+
 static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
 			     int node)
 {
@@ -1522,8 +1553,6 @@ static struct tmigr_group *tmigr_get_group(unsigned int cpu, int node,
 static void tmigr_connect_child_parent(struct tmigr_group *child,
 				       struct tmigr_group *parent)
 {
-	union tmigr_state childstate;
-
 	raw_spin_lock_irq(&child->lock);
 	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
 
@@ -1551,21 +1580,7 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	 *   executed with the formerly top level group (child) and the newly
 	 *   created group (parent).
 	 */
-	childstate.state = atomic_read(&child->migr_state);
-	if (childstate.migrator != TMIGR_NONE) {
-		struct tmigr_walk data;
-
-		data.childmask = child->childmask;
-
-		/*
-		 * There is only one new level per time (which is protected by
-		 * tmigr_mutex). When connecting the child and the parent and
-		 * set the child active when the parent is inactive, the parent
-		 * needs to be the uppermost level. Otherwise there went
-		 * something wrong!
-		 */
-		WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
-	}
+	tmigr_setup_active_up(parent, child);
 }
 
 static int tmigr_setup_groups(unsigned int cpu, unsigned int node)

-- 
2.39.2


