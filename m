Return-Path: <linux-kernel+bounces-240146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F132B926995
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9036288A61
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89718191F6A;
	Wed,  3 Jul 2024 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tasPHS4G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+jD0jxRZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD9A18E769
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720038688; cv=none; b=Y2+5zNC+fT3KXp6rxd6VJzc76tZEPknWLlIb06htpZjNndf/OviSVHH936K8m9klUQqQh9WwWGNlwP4Pr2WPU1KxmnUx/L5dCGhZyaZ5FsWlbYW9MazL6yU/CbExg2TD6DPv/wKsbFKam+WmSy84viyOFJExh5Dh6oL2Qi0h1PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720038688; c=relaxed/simple;
	bh=5fv8l9O4A2MphWSqKSmb1GWSd/cHEoAMK/fXSGu+joY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lu6JdavHuu2ZgkJ6uXO01pH5nH3bTBNHPPmfqQHd9fun+rvusilRpL83bI/Q6840ORVyPJBKYUA7wY3bv2svCdMSvCye+nygURKqdxpBkHZ1aj5wkGWYbtGs9gPVlun60qPrJg/PuDIFVTAtdDhfSjO+M84hXXhucU7NBFtwBT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tasPHS4G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+jD0jxRZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720038685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjYhz0CfgpUPF4SvozOlgcJFnE5KhXTKsUxMrTVXDfY=;
	b=tasPHS4G2fQSeHyNi/Aal+V5DfJsvLqVRtm5i2TSApd3+r7ujz1YbVYCEsAl032R+cbXjq
	toevnRdq2KEFBungpJYOCeLgNS8ETK1Ut35eSh20SRnMjrnbt1rXtqcASNphEe4K2nsFLj
	tXpUTc5SeUJzuuMICCllcQ+EF6HuXuNKs87NUHBclGNSUtxl3KVmLbP3G+YCwYyBSpB1JM
	I5h5r1RunOovADM4c9NT3g3r4wM++0pntADyq6KpWSZVlIyqPoI06g1J9vYI4QFFUc/S9m
	lTgWDRhOR4fulAmMZVYXmd6gUgtt45WdZyq5+HvuaPkB18Z7SNTe6ta1SmnKUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720038685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjYhz0CfgpUPF4SvozOlgcJFnE5KhXTKsUxMrTVXDfY=;
	b=+jD0jxRZncxk9Zi4gdqfKtoSFIFH6AszmToFXpq/YJzPYlz7se+xv5LiEZtLF6oLOH/nhy
	SXS9JgU4ER2Ca2Dg==
To: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v4 6/8] timers/migration: Rename childmask by groupmask to make naming more obvious
Date: Wed,  3 Jul 2024 22:31:15 +0200
Message-Id: <20240703203115.9028-1-anna-maria@linutronix.de>
In-Reply-To: <20240701-tmigr-fixes-v3-6-25cd5de318fb@linutronix.de>
References: <20240701-tmigr-fixes-v3-6-25cd5de318fb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

childmask in the group reflects the mask that is required to 'reference'
this group in the parent. When reading childmask, this might be confusing,
as this suggests, that this is the mask of the child of the group.

Clarify this by renaming childmask in the tmigr_group and tmc_group by
groupmask.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/trace/events/timer_migration.h |  4 ++--
 kernel/time/timer_migration.c          | 24 ++++++++++++------------
 kernel/time/timer_migration.h          | 15 +++++++--------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/include/trace/events/timer_migration.h b/include/trace/events/timer_migration.h
index 79f19e76a80b..f1a447f43f72 100644
--- a/include/trace/events/timer_migration.h
+++ b/include/trace/events/timer_migration.h
@@ -52,7 +52,7 @@ TRACE_EVENT(tmigr_connect_child_parent,
 		__entry->lvl		= child->parent->level;
 		__entry->numa_node	= child->parent->numa_node;
 		__entry->num_children	= child->parent->num_children;
-		__entry->childmask	= child->childmask;
+		__entry->childmask	= child->groupmask;
 	),
 
 	TP_printk("group=%p childmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
@@ -81,7 +81,7 @@ TRACE_EVENT(tmigr_connect_cpu_parent,
 		__entry->lvl		= tmc->tmgroup->level;
 		__entry->numa_node	= tmc->tmgroup->numa_node;
 		__entry->num_children	= tmc->tmgroup->num_children;
-		__entry->childmask	= tmc->childmask;
+		__entry->childmask	= tmc->groupmask;
 	),
 
 	TP_printk("cpu=%d childmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 1fb930537f33..9ff61f9912da 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -495,7 +495,7 @@ static bool tmigr_check_lonely(struct tmigr_group *group)
  *			outcome is a CPU which might wake up a little early.
  * @evt:		Pointer to tmigr_event which needs to be queued (of idle
  *			child group)
- * @childmask:		childmask of child group
+ * @childmask:		groupmask of child group
  * @remote:		Is set, when the new timer path is executed in
  *			tmigr_handle_remote_cpu()
  * @basej:		timer base in jiffies
@@ -535,7 +535,7 @@ static void __walk_groups(up_f up, struct tmigr_walk *data,
 
 		child = group;
 		group = group->parent;
-		data->childmask = group->childmask;
+		data->childmask = group->groupmask;
 	} while (group);
 }
 
@@ -669,7 +669,7 @@ static void __tmigr_cpu_activate(struct tmigr_cpu *tmc)
 {
 	struct tmigr_walk data;
 
-	data.childmask = tmc->childmask;
+	data.childmask = tmc->groupmask;
 
 	trace_tmigr_cpu_active(tmc);
 
@@ -1049,7 +1049,7 @@ void tmigr_handle_remote(void)
 	if (tmigr_is_not_available(tmc))
 		return;
 
-	data.childmask = tmc->childmask;
+	data.childmask = tmc->groupmask;
 	data.firstexp = KTIME_MAX;
 
 	/*
@@ -1057,7 +1057,7 @@ void tmigr_handle_remote(void)
 	 * in tmigr_handle_remote_up() anyway. Keep this check to speed up the
 	 * return when nothing has to be done.
 	 */
-	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask)) {
+	if (!tmigr_check_migrator(tmc->tmgroup, tmc->groupmask)) {
 		/*
 		 * If this CPU was an idle migrator, make sure to clear its wakeup
 		 * value so it won't chase timers that have already expired elsewhere.
@@ -1150,7 +1150,7 @@ bool tmigr_requires_handle_remote(void)
 		return ret;
 
 	data.now = get_jiffies_update(&jif);
-	data.childmask = tmc->childmask;
+	data.childmask = tmc->groupmask;
 	data.firstexp = KTIME_MAX;
 	data.tmc_active = !tmc->idle;
 	data.check = false;
@@ -1310,7 +1310,7 @@ static u64 __tmigr_cpu_deactivate(struct tmigr_cpu *tmc, u64 nextexp)
 	struct tmigr_walk data = { .nextexp = nextexp,
 				   .firstexp = KTIME_MAX,
 				   .evt = &tmc->cpuevt,
-				   .childmask = tmc->childmask };
+				   .childmask = tmc->groupmask };
 
 	/*
 	 * If nextexp is KTIME_MAX, the CPU event will be ignored because the
@@ -1388,7 +1388,7 @@ u64 tmigr_quick_check(u64 nextevt)
 	if (WARN_ON_ONCE(tmc->idle))
 		return nextevt;
 
-	if (!tmigr_check_migrator_and_lonely(tmc->tmgroup, tmc->childmask))
+	if (!tmigr_check_migrator_and_lonely(tmc->tmgroup, tmc->groupmask))
 		return KTIME_MAX;
 
 	do {
@@ -1551,7 +1551,7 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
 
 	child->parent = parent;
-	child->childmask = BIT(parent->num_children++);
+	child->groupmask = BIT(parent->num_children++);
 
 	raw_spin_unlock(&parent->lock);
 	raw_spin_unlock_irq(&child->lock);
@@ -1582,7 +1582,7 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	 *   the new childmask and parent to subsequent walkers through this
 	 *   @child. Therefore propagate active state unconditionally.
 	 */
-	data.childmask = child->childmask;
+	data.childmask = child->groupmask;
 
 	/*
 	 * There is only one new level per time (which is protected by
@@ -1648,7 +1648,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 			raw_spin_lock_irq(&group->lock);
 
 			tmc->tmgroup = group;
-			tmc->childmask = BIT(group->num_children++);
+			tmc->groupmask = BIT(group->num_children++);
 
 			raw_spin_unlock_irq(&group->lock);
 
@@ -1711,7 +1711,7 @@ static int tmigr_cpu_prepare(unsigned int cpu)
 	if (ret < 0)
 		return ret;
 
-	if (tmc->childmask == 0)
+	if (tmc->groupmask == 0)
 		return -EINVAL;
 
 	timerqueue_init(&tmc->cpuevt.nextevt);
diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
index 494f68cc13f4..154accc7a543 100644
--- a/kernel/time/timer_migration.h
+++ b/kernel/time/timer_migration.h
@@ -51,9 +51,8 @@ struct tmigr_event {
  * @num_children:	Counter of group children to make sure the group is only
  *			filled with TMIGR_CHILDREN_PER_GROUP; Required for setup
  *			only
- * @childmask:		childmask of the group in the parent group; is set
- *			during setup and will never change; can be read
- *			lockless
+ * @groupmask:		mask of the group in the parent group; is set during
+ *			setup and will never change; can be read lockless
  * @list:		List head that is added to the per level
  *			tmigr_level_list; is required during setup when a
  *			new group needs to be connected to the existing
@@ -69,7 +68,7 @@ struct tmigr_group {
 	unsigned int		level;
 	int			numa_node;
 	unsigned int		num_children;
-	u8			childmask;
+	u8			groupmask;
 	struct list_head	list;
 };
 
@@ -89,7 +88,7 @@ struct tmigr_group {
  *			hierarchy
  * @remote:		Is set when timers of the CPU are expired remotely
  * @tmgroup:		Pointer to the parent group
- * @childmask:		childmask of tmigr_cpu in the parent group
+ * @groupmask:		mask of tmigr_cpu in the parent group
  * @wakeup:		Stores the first timer when the timer migration
  *			hierarchy is completely idle and remote expiry was done;
  *			is returned to timer code in the idle path and is only
@@ -102,7 +101,7 @@ struct tmigr_cpu {
 	bool			idle;
 	bool			remote;
 	struct tmigr_group	*tmgroup;
-	u8			childmask;
+	u8			groupmask;
 	u64			wakeup;
 	struct tmigr_event	cpuevt;
 };
@@ -118,8 +117,8 @@ union tmigr_state {
 	u32 state;
 	/**
 	 * struct - split state of tmigr_group
-	 * @active:	Contains each childmask bit of the active children
-	 * @migrator:	Contains childmask of the child which is migrator
+	 * @active:	Contains each mask bit of the active children
+	 * @migrator:	Contains mask of the child which is migrator
 	 * @seq:	Sequence counter needs to be increased when an update
 	 *		to the tmigr_state is done. It prevents a race when
 	 *		updates in the child groups are propagated in changed
-- 
2.39.2


