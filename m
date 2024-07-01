Return-Path: <linux-kernel+bounces-236006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA5591DC3F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5428F1F213A2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E4814A604;
	Mon,  1 Jul 2024 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qoiFSwGw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5MQ/654C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1513C908
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829146; cv=none; b=b25BGWFkyeLcwatZYi21BZJSN4mVI0RZ92EnuM1brah9CXDEYLZwYPU3ffymiR6BkDTaFJMU05fq33OXjGjieS9e9x4XKZTL8z9qQdwUXsBH7A8mXldcjPum05TV1e3W1ZMX2akz8Qp511/Du8WdmFWhneK8QpxxPIrd0xF+X14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829146; c=relaxed/simple;
	bh=dT3YF+l6qUA0t/dwgPfof5qptqbcVdqreu6ctldk+0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CjTKgbsDs9ZvfD+N2R5+wd3q/0095n7MheHSQUnE/N65mJql6kdzMS1Fyo4eeL0QTxsjIlDUgg6omEA98Ju2gKLno7iJhGaOa278aM9bVC3arYsRv88G6MaRGS3na04XtytcoW3hzJoCW/8QtJcZxlP3hvc6Jz9VecyaDspE5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qoiFSwGw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5MQ/654C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719829137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1XK08QEW0DGmeu0xkDB8INwdLhY21pOj2tuCloT6F0=;
	b=qoiFSwGwjDQkkjWfGHiPdat8O0Wm0lWnr/4CCFJhV5X+bQXARPSEcHuPIWz8hMSHjD2XJG
	9c0IsqIGwA749Mcnf78jx6lfOEuZ8JQPILZKP0V0GkIYASCcxzChua5vfMAO85MIALW9A0
	f05uO4tFwAjexjOR52SurW7++dx3ewWr0GV8++4fk2tkjGuCa2FjmlDz3z4mL6m0YR+2IY
	KL28g2oYS55Wu8B7StiMwyYXFenVEH4gk2tNMe5SJ8KslQLbRFYKimBP2fbM9Joaq84r4i
	fA9e8yFTBlTIprEinSpAvMCSlNSYLI/9HeZMGd7/F4Izrr/j4D/cOpFfVQQS6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719829137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1XK08QEW0DGmeu0xkDB8INwdLhY21pOj2tuCloT6F0=;
	b=5MQ/654CXDQ8ejFGhq2LjpxZPf+uDBvcmwVCuoRR18MbE61O/arpTfbc3/1+dtuCTp1WRP
	DRHfexQau4ONsqCw==
Date: Mon, 01 Jul 2024 12:18:42 +0200
Subject: [PATCH v3 6/8] timers/migration: Rename childmask by parentmask to
 make naming more obvious
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-tmigr-fixes-v3-6-25cd5de318fb@linutronix.de>
References: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
In-Reply-To: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>

childmask in the group reflects the mask that is required to 'reference'
this group in the parent. When reading childmask, this might be confusing,
as this suggests, that this is the mask of the child of the group.

Clarify this by renaming childmask in the tmigr_group and tmc_group by
parentmask.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/trace/events/timer_migration.h |  4 ++--
 kernel/time/timer_migration.c          | 24 ++++++++++++------------
 kernel/time/timer_migration.h          | 15 +++++++--------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/include/trace/events/timer_migration.h b/include/trace/events/timer_migration.h
index 79f19e76a80b..e3c5afd1638d 100644
--- a/include/trace/events/timer_migration.h
+++ b/include/trace/events/timer_migration.h
@@ -52,7 +52,7 @@ TRACE_EVENT(tmigr_connect_child_parent,
 		__entry->lvl		= child->parent->level;
 		__entry->numa_node	= child->parent->numa_node;
 		__entry->num_children	= child->parent->num_children;
-		__entry->childmask	= child->childmask;
+		__entry->childmask	= child->parentmask;
 	),
 
 	TP_printk("group=%p childmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
@@ -81,7 +81,7 @@ TRACE_EVENT(tmigr_connect_cpu_parent,
 		__entry->lvl		= tmc->tmgroup->level;
 		__entry->numa_node	= tmc->tmgroup->numa_node;
 		__entry->num_children	= tmc->tmgroup->num_children;
-		__entry->childmask	= tmc->childmask;
+		__entry->childmask	= tmc->parentmask;
 	),
 
 	TP_printk("cpu=%d childmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index a681cf89910e..b73d89e78163 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -495,7 +495,7 @@ static bool tmigr_check_lonely(struct tmigr_group *group)
  *			outcome is a CPU which might wake up a little early.
  * @evt:		Pointer to tmigr_event which needs to be queued (of idle
  *			child group)
- * @childmask:		childmask of child group
+ * @childmask:		parentmask of child group
  * @remote:		Is set, when the new timer path is executed in
  *			tmigr_handle_remote_cpu()
  * @basej:		timer base in jiffies
@@ -535,7 +535,7 @@ static void __walk_groups(up_f up, struct tmigr_walk *data,
 
 		child = group;
 		group = group->parent;
-		data->childmask = group->childmask;
+		data->childmask = group->parentmask;
 	} while (group);
 }
 
@@ -669,7 +669,7 @@ static void __tmigr_cpu_activate(struct tmigr_cpu *tmc)
 {
 	struct tmigr_walk data;
 
-	data.childmask = tmc->childmask;
+	data.childmask = tmc->parentmask;
 
 	trace_tmigr_cpu_active(tmc);
 
@@ -1049,7 +1049,7 @@ void tmigr_handle_remote(void)
 	if (tmigr_is_not_available(tmc))
 		return;
 
-	data.childmask = tmc->childmask;
+	data.childmask = tmc->parentmask;
 	data.firstexp = KTIME_MAX;
 
 	/*
@@ -1057,7 +1057,7 @@ void tmigr_handle_remote(void)
 	 * in tmigr_handle_remote_up() anyway. Keep this check to speed up the
 	 * return when nothing has to be done.
 	 */
-	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask)) {
+	if (!tmigr_check_migrator(tmc->tmgroup, tmc->parentmask)) {
 		/*
 		 * If this CPU was an idle migrator, make sure to clear its wakeup
 		 * value so it won't chase timers that have already expired elsewhere.
@@ -1150,7 +1150,7 @@ bool tmigr_requires_handle_remote(void)
 		return ret;
 
 	data.now = get_jiffies_update(&jif);
-	data.childmask = tmc->childmask;
+	data.childmask = tmc->parentmask;
 	data.firstexp = KTIME_MAX;
 	data.tmc_active = !tmc->idle;
 	data.check = false;
@@ -1310,7 +1310,7 @@ static u64 __tmigr_cpu_deactivate(struct tmigr_cpu *tmc, u64 nextexp)
 	struct tmigr_walk data = { .nextexp = nextexp,
 				   .firstexp = KTIME_MAX,
 				   .evt = &tmc->cpuevt,
-				   .childmask = tmc->childmask };
+				   .childmask = tmc->parentmask };
 
 	/*
 	 * If nextexp is KTIME_MAX, the CPU event will be ignored because the
@@ -1388,7 +1388,7 @@ u64 tmigr_quick_check(u64 nextevt)
 	if (WARN_ON_ONCE(tmc->idle))
 		return nextevt;
 
-	if (!tmigr_check_migrator_and_lonely(tmc->tmgroup, tmc->childmask))
+	if (!tmigr_check_migrator_and_lonely(tmc->tmgroup, tmc->parentmask))
 		return KTIME_MAX;
 
 	do {
@@ -1551,7 +1551,7 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
 
 	child->parent = parent;
-	child->childmask = BIT(parent->num_children++);
+	child->parentmask = BIT(parent->num_children++);
 
 	raw_spin_unlock(&parent->lock);
 	raw_spin_unlock_irq(&child->lock);
@@ -1580,7 +1580,7 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	 *   the CPU executing the setup will be responsible up to current top
 	 *   level group. Therefore propagate active state unconditionally.
 	 */
-	data.childmask = child->childmask;
+	data.childmask = child->parentmask;
 
 	/*
 	 * There is only one new level per time (which is protected by
@@ -1646,7 +1646,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 			raw_spin_lock_irq(&group->lock);
 
 			tmc->tmgroup = group;
-			tmc->childmask = BIT(group->num_children++);
+			tmc->parentmask = BIT(group->num_children++);
 
 			raw_spin_unlock_irq(&group->lock);
 
@@ -1709,7 +1709,7 @@ static int tmigr_cpu_prepare(unsigned int cpu)
 	if (ret < 0)
 		return ret;
 
-	if (tmc->childmask == 0)
+	if (tmc->parentmask == 0)
 		return -EINVAL;
 
 	timerqueue_init(&tmc->cpuevt.nextevt);
diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
index 494f68cc13f4..3d08e611c3d6 100644
--- a/kernel/time/timer_migration.h
+++ b/kernel/time/timer_migration.h
@@ -51,9 +51,8 @@ struct tmigr_event {
  * @num_children:	Counter of group children to make sure the group is only
  *			filled with TMIGR_CHILDREN_PER_GROUP; Required for setup
  *			only
- * @childmask:		childmask of the group in the parent group; is set
- *			during setup and will never change; can be read
- *			lockless
+ * @parentmask:		mask of the group in the parent group; is set during
+ *			setup and will never change; can be read lockless
  * @list:		List head that is added to the per level
  *			tmigr_level_list; is required during setup when a
  *			new group needs to be connected to the existing
@@ -69,7 +68,7 @@ struct tmigr_group {
 	unsigned int		level;
 	int			numa_node;
 	unsigned int		num_children;
-	u8			childmask;
+	u8			parentmask;
 	struct list_head	list;
 };
 
@@ -89,7 +88,7 @@ struct tmigr_group {
  *			hierarchy
  * @remote:		Is set when timers of the CPU are expired remotely
  * @tmgroup:		Pointer to the parent group
- * @childmask:		childmask of tmigr_cpu in the parent group
+ * @parentmask:		mask of tmigr_cpu in the parent group
  * @wakeup:		Stores the first timer when the timer migration
  *			hierarchy is completely idle and remote expiry was done;
  *			is returned to timer code in the idle path and is only
@@ -102,7 +101,7 @@ struct tmigr_cpu {
 	bool			idle;
 	bool			remote;
 	struct tmigr_group	*tmgroup;
-	u8			childmask;
+	u8			parentmask;
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


