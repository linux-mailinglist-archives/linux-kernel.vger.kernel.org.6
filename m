Return-Path: <linux-kernel+bounces-263267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 715E193D37C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67781F21119
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9538D17B4F6;
	Fri, 26 Jul 2024 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n8g3FroI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NCaHCTwF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69A2B9DB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998220; cv=none; b=aOOc0QKJZb3sVRq/hBHlo6PMKR52DnBsFmOfaK5i0yOk9NmgykEk8wfgtGIAAASzrLlBo5oaROCJekgzt9R/IKhI6MOn03Bqmc0NYO8e509AfL6vmJapd24KNYJrviTpb06BnVxeCa5qeKEEeSjGbmN3Y3/HnIotSruY+YcVXA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998220; c=relaxed/simple;
	bh=S6oSBn0u5ZntATecYHDwg19u+PF0J1hC48Ei+RBovCk=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=agBlVwf6OtEfHD1IWSQJ6ucFOkiYViUKr/QsXMsUTmYRIr0gnP0pI7RmVXsOwtmUUljNv/RwEHr/YjqB1i0kSzUZGlOE245IYR06S2b0Wy3cm7HC6h/WANCNV+aV0XCvxkjMt7J3ob9gT8b6vquW1SIdLoW376dwsT5Nvt1UXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n8g3FroI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NCaHCTwF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721998216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lm6NHHkyx83Vh0PP9Wqx15R0XEeosTEw5zLWh3XmVa8=;
	b=n8g3FroINZ4xa21QKM3ReyQJqhu+Wat4e0IRwCO8tmCsC+5Sa9JOX8PfIxAPBPZygoICHG
	1duPhumVD46lmWE9n7z7sWCdK5qdlIDFOS0fx7VeasSUBimQNJzwrwJiSeTfmrEZDCBCJq
	bIsdJipuFvMNwMsikTe4CPelFb2RxBnkR62MQcE3tWj4tO/78UkKTzp0WyDXUok5A7IzYY
	7mNuHbtGW0hDyTLLDWk5hsmsMuXo7NV8ukGE6FwjH8kWm2VbPblQFG2atU4uNp6vyjLqyF
	eRaxYHfXQTaYqOK7RPKKhj35ZsNaxuqaj/GSP+ZDQcXZta7+JAjOe2Y5h9aCJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721998216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lm6NHHkyx83Vh0PP9Wqx15R0XEeosTEw5zLWh3XmVa8=;
	b=NCaHCTwFgrlAlG/zDOWRedbg5YE10sMbUq/KNXPN+q0IC8MEd0MNnXhXyf+EMK1jh3Xsap
	YuhlPDtsPEO21MCQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>
Subject: [GIT pull] timers/urgent for v6.11-rc1
Message-ID: 
 <172199775390.111438.14770629919964816083.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Jul 2024 14:50:16 +0200 (CEST)

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-20=
24-07-26

up to:  f004bf9de057: timers/migration: Fix grammar in comment


Fixes and minor updates for the timer migration code:

    - Stop testing the group->parent pointer as it is not guaranteed to be
      stable over a chain of operations by design. This includes a warning
      which would be nice to have but it produces false positives due to
      the racy nature of the check.

    - Plug a race between CPUs going in and out of idle and a CPU hotplug
      operation. The latter can create and connect a new hierarchy level
      which is missed in the concurrent updates of CPUs which go into idle.
      As a result the events of such a CPU might not be processed and
      timers go stale.

      Cure it by splitting the hotplug operation into a prepare and online
      callback. The prepare callback is guaranteed to run on an online and
      therefore active CPU. This CPU updates the hierarchy and being online
      ensures that there is always at least one migrator active which
      handles the modified hierarchy correctly when going idle. The online
      callback which runs on the incoming CPU then just marks the CPU
      active and brings it into operation.

    - Improve tracing and polish the code further so it is more obvious
      what's going on.

Thanks,

	tglx

------------------>
Anna-Maria Behnsen (8):
      timers/migration: Do not rely always on group->parent
      timers/migration: Move hierarchy setup into cpuhotplug prepare callback
      timers/migration: Improve tracing
      timers/migration: Use a single struct for hierarchy walk data
      timers/migration: Read childmask and parent pointer in a single place
      timers/migration: Rename childmask by groupmask to make naming more obv=
ious
      timers/migration: Spare write when nothing changed
      timers/migration: Fix grammar in comment


 include/linux/cpuhotplug.h             |   1 +
 include/trace/events/timer_migration.h |  16 +-
 kernel/time/timer_migration.c          | 393 +++++++++++++++++--------------=
--
 kernel/time/timer_migration.h          |  27 ++-
 4 files changed, 224 insertions(+), 213 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 7a5785f405b6..df59666a2a66 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -122,6 +122,7 @@ enum cpuhp_state {
 	CPUHP_KVM_PPC_BOOK3S_PREPARE,
 	CPUHP_ZCOMP_PREPARE,
 	CPUHP_TIMERS_PREPARE,
+	CPUHP_TMIGR_PREPARE,
 	CPUHP_MIPS_SOC_PREPARE,
 	CPUHP_BP_PREPARE_DYN,
 	CPUHP_BP_PREPARE_DYN_END		=3D CPUHP_BP_PREPARE_DYN + 20,
diff --git a/include/trace/events/timer_migration.h b/include/trace/events/ti=
mer_migration.h
index 79f19e76a80b..47db5eaf2f9a 100644
--- a/include/trace/events/timer_migration.h
+++ b/include/trace/events/timer_migration.h
@@ -43,7 +43,7 @@ TRACE_EVENT(tmigr_connect_child_parent,
 		__field( unsigned int,	lvl		)
 		__field( unsigned int,	numa_node	)
 		__field( unsigned int,	num_children	)
-		__field( u32,		childmask	)
+		__field( u32,		groupmask	)
 	),
=20
 	TP_fast_assign(
@@ -52,11 +52,11 @@ TRACE_EVENT(tmigr_connect_child_parent,
 		__entry->lvl		=3D child->parent->level;
 		__entry->numa_node	=3D child->parent->numa_node;
 		__entry->num_children	=3D child->parent->num_children;
-		__entry->childmask	=3D child->childmask;
+		__entry->groupmask	=3D child->groupmask;
 	),
=20
-	TP_printk("group=3D%p childmask=3D%0x parent=3D%p lvl=3D%d numa=3D%d num_ch=
ildren=3D%d",
-		  __entry->child,  __entry->childmask, __entry->parent,
+	TP_printk("group=3D%p groupmask=3D%0x parent=3D%p lvl=3D%d numa=3D%d num_ch=
ildren=3D%d",
+		  __entry->child,  __entry->groupmask, __entry->parent,
 		  __entry->lvl, __entry->numa_node, __entry->num_children)
 );
=20
@@ -72,7 +72,7 @@ TRACE_EVENT(tmigr_connect_cpu_parent,
 		__field( unsigned int,	lvl		)
 		__field( unsigned int,	numa_node	)
 		__field( unsigned int,	num_children	)
-		__field( u32,		childmask	)
+		__field( u32,		groupmask	)
 	),
=20
 	TP_fast_assign(
@@ -81,11 +81,11 @@ TRACE_EVENT(tmigr_connect_cpu_parent,
 		__entry->lvl		=3D tmc->tmgroup->level;
 		__entry->numa_node	=3D tmc->tmgroup->numa_node;
 		__entry->num_children	=3D tmc->tmgroup->num_children;
-		__entry->childmask	=3D tmc->childmask;
+		__entry->groupmask	=3D tmc->groupmask;
 	),
=20
-	TP_printk("cpu=3D%d childmask=3D%0x parent=3D%p lvl=3D%d numa=3D%d num_chil=
dren=3D%d",
-		  __entry->cpu,	 __entry->childmask, __entry->parent,
+	TP_printk("cpu=3D%d groupmask=3D%0x parent=3D%p lvl=3D%d numa=3D%d num_chil=
dren=3D%d",
+		  __entry->cpu,	 __entry->groupmask, __entry->parent,
 		  __entry->lvl, __entry->numa_node, __entry->num_children)
 );
=20
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 84413114db5c..8d57f7686bb0 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -475,9 +475,54 @@ static bool tmigr_check_lonely(struct tmigr_group *group)
 	return bitmap_weight(&active, BIT_CNT) <=3D 1;
 }
=20
-typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, void *);
+/**
+ * struct tmigr_walk - data required for walking the hierarchy
+ * @nextexp:		Next CPU event expiry information which is handed into
+ *			the timer migration code by the timer code
+ *			(get_next_timer_interrupt())
+ * @firstexp:		Contains the first event expiry information when
+ *			hierarchy is completely idle.  When CPU itself was the
+ *			last going idle, information makes sure, that CPU will
+ *			be back in time. When using this value in the remote
+ *			expiry case, firstexp is stored in the per CPU tmigr_cpu
+ *			struct of CPU which expires remote timers. It is updated
+ *			in top level group only. Be aware, there could occur a
+ *			new top level of the hierarchy between the 'top level
+ *			call' in tmigr_update_events() and the check for the
+ *			parent group in walk_groups(). Then @firstexp might
+ *			contain a value !=3D KTIME_MAX even if it was not the
+ *			final top level. This is not a problem, as the worst
+ *			outcome is a CPU which might wake up a little early.
+ * @evt:		Pointer to tmigr_event which needs to be queued (of idle
+ *			child group)
+ * @childmask:		groupmask of child group
+ * @remote:		Is set, when the new timer path is executed in
+ *			tmigr_handle_remote_cpu()
+ * @basej:		timer base in jiffies
+ * @now:		timer base monotonic
+ * @check:		is set if there is the need to handle remote timers;
+ *			required in tmigr_requires_handle_remote() only
+ * @tmc_active:		this flag indicates, whether the CPU which triggers
+ *			the hierarchy walk is !idle in the timer migration
+ *			hierarchy. When the CPU is idle and the whole hierarchy is
+ *			idle, only the first event of the top level has to be
+ *			considered.
+ */
+struct tmigr_walk {
+	u64			nextexp;
+	u64			firstexp;
+	struct tmigr_event	*evt;
+	u8			childmask;
+	bool			remote;
+	unsigned long		basej;
+	u64			now;
+	bool			check;
+	bool			tmc_active;
+};
+
+typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, struct tmig=
r_walk *);
=20
-static void __walk_groups(up_f up, void *data,
+static void __walk_groups(up_f up, struct tmigr_walk *data,
 			  struct tmigr_cpu *tmc)
 {
 	struct tmigr_group *child =3D NULL, *group =3D tmc->tmgroup;
@@ -490,64 +535,17 @@ static void __walk_groups(up_f up, void *data,
=20
 		child =3D group;
 		group =3D group->parent;
+		data->childmask =3D child->groupmask;
 	} while (group);
 }
=20
-static void walk_groups(up_f up, void *data, struct tmigr_cpu *tmc)
+static void walk_groups(up_f up, struct tmigr_walk *data, struct tmigr_cpu *=
tmc)
 {
 	lockdep_assert_held(&tmc->lock);
=20
 	__walk_groups(up, data, tmc);
 }
=20
-/**
- * struct tmigr_walk - data required for walking the hierarchy
- * @nextexp:		Next CPU event expiry information which is handed into
- *			the timer migration code by the timer code
- *			(get_next_timer_interrupt())
- * @firstexp:		Contains the first event expiry information when last
- *			active CPU of hierarchy is on the way to idle to make
- *			sure CPU will be back in time.
- * @evt:		Pointer to tmigr_event which needs to be queued (of idle
- *			child group)
- * @childmask:		childmask of child group
- * @remote:		Is set, when the new timer path is executed in
- *			tmigr_handle_remote_cpu()
- */
-struct tmigr_walk {
-	u64			nextexp;
-	u64			firstexp;
-	struct tmigr_event	*evt;
-	u8			childmask;
-	bool			remote;
-};
-
-/**
- * struct tmigr_remote_data - data required for remote expiry hierarchy walk
- * @basej:		timer base in jiffies
- * @now:		timer base monotonic
- * @firstexp:		returns expiry of the first timer in the idle timer
- *			migration hierarchy to make sure the timer is handled in
- *			time; it is stored in the per CPU tmigr_cpu struct of
- *			CPU which expires remote timers
- * @childmask:		childmask of child group
- * @check:		is set if there is the need to handle remote timers;
- *			required in tmigr_requires_handle_remote() only
- * @tmc_active:		this flag indicates, whether the CPU which triggers
- *			the hierarchy walk is !idle in the timer migration
- *			hierarchy. When the CPU is idle and the whole hierarchy is
- *			idle, only the first event of the top level has to be
- *			considered.
- */
-struct tmigr_remote_data {
-	unsigned long	basej;
-	u64		now;
-	u64		firstexp;
-	u8		childmask;
-	bool		check;
-	bool		tmc_active;
-};
-
 /*
  * Returns the next event of the timerqueue @group->events
  *
@@ -618,10 +616,9 @@ static u64 tmigr_next_groupevt_expires(struct tmigr_grou=
p *group)
=20
 static bool tmigr_active_up(struct tmigr_group *group,
 			    struct tmigr_group *child,
-			    void *ptr)
+			    struct tmigr_walk *data)
 {
 	union tmigr_state curstate, newstate;
-	struct tmigr_walk *data =3D ptr;
 	bool walk_done;
 	u8 childmask;
=20
@@ -649,8 +646,7 @@ static bool tmigr_active_up(struct tmigr_group *group,
=20
 	} while (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.=
state));
=20
-	if ((walk_done =3D=3D false) && group->parent)
-		data->childmask =3D group->childmask;
+	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
=20
 	/*
 	 * The group is active (again). The group event might be still queued
@@ -666,8 +662,6 @@ static bool tmigr_active_up(struct tmigr_group *group,
 	 */
 	group->groupevt.ignore =3D true;
=20
-	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
-
 	return walk_done;
 }
=20
@@ -675,7 +669,7 @@ static void __tmigr_cpu_activate(struct tmigr_cpu *tmc)
 {
 	struct tmigr_walk data;
=20
-	data.childmask =3D tmc->childmask;
+	data.childmask =3D tmc->groupmask;
=20
 	trace_tmigr_cpu_active(tmc);
=20
@@ -860,10 +854,8 @@ bool tmigr_update_events(struct tmigr_group *group, stru=
ct tmigr_group *child,
=20
 static bool tmigr_new_timer_up(struct tmigr_group *group,
 			       struct tmigr_group *child,
-			       void *ptr)
+			       struct tmigr_walk *data)
 {
-	struct tmigr_walk *data =3D ptr;
-
 	return tmigr_update_events(group, child, data);
 }
=20
@@ -995,9 +987,8 @@ static void tmigr_handle_remote_cpu(unsigned int cpu, u64=
 now,
=20
 static bool tmigr_handle_remote_up(struct tmigr_group *group,
 				   struct tmigr_group *child,
-				   void *ptr)
+				   struct tmigr_walk *data)
 {
-	struct tmigr_remote_data *data =3D ptr;
 	struct tmigr_event *evt;
 	unsigned long jif;
 	u8 childmask;
@@ -1034,12 +1025,10 @@ static bool tmigr_handle_remote_up(struct tmigr_group=
 *group,
 	}
=20
 	/*
-	 * Update of childmask for the next level and keep track of the expiry
-	 * of the first event that needs to be handled (group->next_expiry was
-	 * updated by tmigr_next_expired_groupevt(), next was set by
-	 * tmigr_handle_remote_cpu()).
+	 * Keep track of the expiry of the first event that needs to be handled
+	 * (group->next_expiry was updated by tmigr_next_expired_groupevt(),
+	 * next was set by tmigr_handle_remote_cpu()).
 	 */
-	data->childmask =3D group->childmask;
 	data->firstexp =3D group->next_expiry;
=20
 	raw_spin_unlock_irq(&group->lock);
@@ -1055,12 +1044,12 @@ static bool tmigr_handle_remote_up(struct tmigr_group=
 *group,
 void tmigr_handle_remote(void)
 {
 	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
-	struct tmigr_remote_data data;
+	struct tmigr_walk data;
=20
 	if (tmigr_is_not_available(tmc))
 		return;
=20
-	data.childmask =3D tmc->childmask;
+	data.childmask =3D tmc->groupmask;
 	data.firstexp =3D KTIME_MAX;
=20
 	/*
@@ -1068,7 +1057,7 @@ void tmigr_handle_remote(void)
 	 * in tmigr_handle_remote_up() anyway. Keep this check to speed up the
 	 * return when nothing has to be done.
 	 */
-	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask)) {
+	if (!tmigr_check_migrator(tmc->tmgroup, tmc->groupmask)) {
 		/*
 		 * If this CPU was an idle migrator, make sure to clear its wakeup
 		 * value so it won't chase timers that have already expired elsewhere.
@@ -1097,9 +1086,8 @@ void tmigr_handle_remote(void)
=20
 static bool tmigr_requires_handle_remote_up(struct tmigr_group *group,
 					    struct tmigr_group *child,
-					    void *ptr)
+					    struct tmigr_walk *data)
 {
-	struct tmigr_remote_data *data =3D ptr;
 	u8 childmask;
=20
 	childmask =3D data->childmask;
@@ -1118,7 +1106,7 @@ static bool tmigr_requires_handle_remote_up(struct tmig=
r_group *group,
 	 * group before reading the next_expiry value.
 	 */
 	if (group->parent && !data->tmc_active)
-		goto out;
+		return false;
=20
 	/*
 	 * The lock is required on 32bit architectures to read the variable
@@ -1143,9 +1131,6 @@ static bool tmigr_requires_handle_remote_up(struct tmig=
r_group *group,
 		raw_spin_unlock(&group->lock);
 	}
=20
-out:
-	/* Update of childmask for the next level */
-	data->childmask =3D group->childmask;
 	return false;
 }
=20
@@ -1157,7 +1142,7 @@ static bool tmigr_requires_handle_remote_up(struct tmig=
r_group *group,
 bool tmigr_requires_handle_remote(void)
 {
 	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
-	struct tmigr_remote_data data;
+	struct tmigr_walk data;
 	unsigned long jif;
 	bool ret =3D false;
=20
@@ -1165,7 +1150,7 @@ bool tmigr_requires_handle_remote(void)
 		return ret;
=20
 	data.now =3D get_jiffies_update(&jif);
-	data.childmask =3D tmc->childmask;
+	data.childmask =3D tmc->groupmask;
 	data.firstexp =3D KTIME_MAX;
 	data.tmc_active =3D !tmc->idle;
 	data.check =3D false;
@@ -1230,14 +1215,13 @@ u64 tmigr_cpu_new_timer(u64 nextexp)
 		if (nextexp !=3D tmc->cpuevt.nextevt.expires ||
 		    tmc->cpuevt.ignore) {
 			ret =3D tmigr_new_timer(tmc, nextexp);
+			/*
+			 * Make sure the reevaluation of timers in idle path
+			 * will not miss an event.
+			 */
+			WRITE_ONCE(tmc->wakeup, ret);
 		}
 	}
-	/*
-	 * Make sure the reevaluation of timers in idle path will not miss an
-	 * event.
-	 */
-	WRITE_ONCE(tmc->wakeup, ret);
-
 	trace_tmigr_cpu_new_timer_idle(tmc, nextexp);
 	raw_spin_unlock(&tmc->lock);
 	return ret;
@@ -1245,10 +1229,9 @@ u64 tmigr_cpu_new_timer(u64 nextexp)
=20
 static bool tmigr_inactive_up(struct tmigr_group *group,
 			      struct tmigr_group *child,
-			      void *ptr)
+			      struct tmigr_walk *data)
 {
 	union tmigr_state curstate, newstate, childstate;
-	struct tmigr_walk *data =3D ptr;
 	bool walk_done;
 	u8 childmask;
=20
@@ -1299,9 +1282,10 @@ static bool tmigr_inactive_up(struct tmigr_group *grou=
p,
=20
 		WARN_ON_ONCE((newstate.migrator !=3D TMIGR_NONE) && !(newstate.active));
=20
-		if (atomic_try_cmpxchg(&group->migr_state, &curstate.state,
-				       newstate.state))
+		if (atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state=
)) {
+			trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
 			break;
+		}
=20
 		/*
 		 * The memory barrier is paired with the cmpxchg() in
@@ -1317,22 +1301,6 @@ static bool tmigr_inactive_up(struct tmigr_group *grou=
p,
 	/* Event Handling */
 	tmigr_update_events(group, child, data);
=20
-	if (group->parent && (walk_done =3D=3D false))
-		data->childmask =3D group->childmask;
-
-	/*
-	 * data->firstexp was set by tmigr_update_events() and contains the
-	 * expiry of the first global event which needs to be handled. It
-	 * differs from KTIME_MAX if:
-	 * - group is the top level group and
-	 * - group is idle (which means CPU was the last active CPU in the
-	 *   hierarchy) and
-	 * - there is a pending event in the hierarchy
-	 */
-	WARN_ON_ONCE(data->firstexp !=3D KTIME_MAX && group->parent);
-
-	trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
-
 	return walk_done;
 }
=20
@@ -1341,7 +1309,7 @@ static u64 __tmigr_cpu_deactivate(struct tmigr_cpu *tmc=
, u64 nextexp)
 	struct tmigr_walk data =3D { .nextexp =3D nextexp,
 				   .firstexp =3D KTIME_MAX,
 				   .evt =3D &tmc->cpuevt,
-				   .childmask =3D tmc->childmask };
+				   .childmask =3D tmc->groupmask };
=20
 	/*
 	 * If nextexp is KTIME_MAX, the CPU event will be ignored because the
@@ -1400,7 +1368,7 @@ u64 tmigr_cpu_deactivate(u64 nextexp)
  *			  the only one in the level 0 group; and if it is the
  *			  only one in level 0 group, but there are more than a
  *			  single group active on the way to top level)
- * * nextevt		- when CPU is offline and has to handle timer on his own
+ * * nextevt		- when CPU is offline and has to handle timer on its own
  *			  or when on the way to top in every group only a single
  *			  child is active but @nextevt is before the lowest
  *			  next_expiry encountered while walking up to top level.
@@ -1419,7 +1387,7 @@ u64 tmigr_quick_check(u64 nextevt)
 	if (WARN_ON_ONCE(tmc->idle))
 		return nextevt;
=20
-	if (!tmigr_check_migrator_and_lonely(tmc->tmgroup, tmc->childmask))
+	if (!tmigr_check_migrator_and_lonely(tmc->tmgroup, tmc->groupmask))
 		return KTIME_MAX;
=20
 	do {
@@ -1442,6 +1410,66 @@ u64 tmigr_quick_check(u64 nextevt)
 	return KTIME_MAX;
 }
=20
+/*
+ * tmigr_trigger_active() - trigger a CPU to become active again
+ *
+ * This function is executed on a CPU which is part of cpu_online_mask, when=
 the
+ * last active CPU in the hierarchy is offlining. With this, it is ensured t=
hat
+ * the other CPU is active and takes over the migrator duty.
+ */
+static long tmigr_trigger_active(void *unused)
+{
+	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
+
+	WARN_ON_ONCE(!tmc->online || tmc->idle);
+
+	return 0;
+}
+
+static int tmigr_cpu_offline(unsigned int cpu)
+{
+	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
+	int migrator;
+	u64 firstexp;
+
+	raw_spin_lock_irq(&tmc->lock);
+	tmc->online =3D false;
+	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
+
+	/*
+	 * CPU has to handle the local events on his own, when on the way to
+	 * offline; Therefore nextevt value is set to KTIME_MAX
+	 */
+	firstexp =3D __tmigr_cpu_deactivate(tmc, KTIME_MAX);
+	trace_tmigr_cpu_offline(tmc);
+	raw_spin_unlock_irq(&tmc->lock);
+
+	if (firstexp !=3D KTIME_MAX) {
+		migrator =3D cpumask_any_but(cpu_online_mask, cpu);
+		work_on_cpu(migrator, tmigr_trigger_active, NULL);
+	}
+
+	return 0;
+}
+
+static int tmigr_cpu_online(unsigned int cpu)
+{
+	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
+
+	/* Check whether CPU data was successfully initialized */
+	if (WARN_ON_ONCE(!tmc->tmgroup))
+		return -EINVAL;
+
+	raw_spin_lock_irq(&tmc->lock);
+	trace_tmigr_cpu_online(tmc);
+	tmc->idle =3D timer_base_is_idle();
+	if (!tmc->idle)
+		__tmigr_cpu_activate(tmc);
+	tmc->online =3D true;
+	raw_spin_unlock_irq(&tmc->lock);
+	return 0;
+}
+
 static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
 			     int node)
 {
@@ -1514,21 +1542,25 @@ static struct tmigr_group *tmigr_get_group(unsigned i=
nt cpu, int node,
 }
=20
 static void tmigr_connect_child_parent(struct tmigr_group *child,
-				       struct tmigr_group *parent)
+				       struct tmigr_group *parent,
+				       bool activate)
 {
-	union tmigr_state childstate;
+	struct tmigr_walk data;
=20
 	raw_spin_lock_irq(&child->lock);
 	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
=20
 	child->parent =3D parent;
-	child->childmask =3D BIT(parent->num_children++);
+	child->groupmask =3D BIT(parent->num_children++);
=20
 	raw_spin_unlock(&parent->lock);
 	raw_spin_unlock_irq(&child->lock);
=20
 	trace_tmigr_connect_child_parent(child);
=20
+	if (!activate)
+		return;
+
 	/*
 	 * To prevent inconsistent states, active children need to be active in
 	 * the new parent as well. Inactive children are already marked inactive
@@ -1544,21 +1576,24 @@ static void tmigr_connect_child_parent(struct tmigr_g=
roup *child,
 	 *   child to the new parent. So tmigr_connect_child_parent() is
 	 *   executed with the formerly top level group (child) and the newly
 	 *   created group (parent).
+	 *
+	 * * It is ensured that the child is active, as this setup path is
+	 *   executed in hotplug prepare callback. This is exectued by an
+	 *   already connected and !idle CPU. Even if all other CPUs go idle,
+	 *   the CPU executing the setup will be responsible up to current top
+	 *   level group. And the next time it goes inactive, it will release
+	 *   the new childmask and parent to subsequent walkers through this
+	 *   @child. Therefore propagate active state unconditionally.
 	 */
-	childstate.state =3D atomic_read(&child->migr_state);
-	if (childstate.migrator !=3D TMIGR_NONE) {
-		struct tmigr_walk data;
-
-		data.childmask =3D child->childmask;
+	data.childmask =3D child->groupmask;
=20
-		/*
-		 * There is only one new level per time. When connecting the
-		 * child and the parent and set the child active when the parent
-		 * is inactive, the parent needs to be the uppermost
-		 * level. Otherwise there went something wrong!
-		 */
-		WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
-	}
+	/*
+	 * There is only one new level per time (which is protected by
+	 * tmigr_mutex). When connecting the child and the parent and set the
+	 * child active when the parent is inactive, the parent needs to be the
+	 * uppermost level. Otherwise there went something wrong!
+	 */
+	WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
 }
=20
 static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
@@ -1611,12 +1646,12 @@ static int tmigr_setup_groups(unsigned int cpu, unsig=
ned int node)
 		 * Update tmc -> group / child -> group connection
 		 */
 		if (i =3D=3D 0) {
-			struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
+			struct tmigr_cpu *tmc =3D per_cpu_ptr(&tmigr_cpu, cpu);
=20
 			raw_spin_lock_irq(&group->lock);
=20
 			tmc->tmgroup =3D group;
-			tmc->childmask =3D BIT(group->num_children++);
+			tmc->groupmask =3D BIT(group->num_children++);
=20
 			raw_spin_unlock_irq(&group->lock);
=20
@@ -1626,7 +1661,8 @@ static int tmigr_setup_groups(unsigned int cpu, unsigne=
d int node)
 			continue;
 		} else {
 			child =3D stack[i - 1];
-			tmigr_connect_child_parent(child, group);
+			/* Will be activated at online time */
+			tmigr_connect_child_parent(child, group, false);
 		}
=20
 		/* check if uppermost level was newly created */
@@ -1637,12 +1673,21 @@ static int tmigr_setup_groups(unsigned int cpu, unsig=
ned int node)
=20
 		lvllist =3D &tmigr_level_list[top];
 		if (group->num_children =3D=3D 1 && list_is_singular(lvllist)) {
+			/*
+			 * The target CPU must never do the prepare work, except
+			 * on early boot when the boot CPU is the target. Otherwise
+			 * it may spuriously activate the old top level group inside
+			 * the new one (nevertheless whether old top level group is
+			 * active or not) and/or release an uninitialized childmask.
+			 */
+			WARN_ON_ONCE(cpu =3D=3D raw_smp_processor_id());
+
 			lvllist =3D &tmigr_level_list[top - 1];
 			list_for_each_entry(child, lvllist, list) {
 				if (child->parent)
 					continue;
=20
-				tmigr_connect_child_parent(child, group);
+				tmigr_connect_child_parent(child, group, true);
 			}
 		}
 	}
@@ -1664,80 +1709,31 @@ static int tmigr_add_cpu(unsigned int cpu)
 	return ret;
 }
=20
-static int tmigr_cpu_online(unsigned int cpu)
-{
-	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
-	int ret;
-
-	/* First online attempt? Initialize CPU data */
-	if (!tmc->tmgroup) {
-		raw_spin_lock_init(&tmc->lock);
-
-		ret =3D tmigr_add_cpu(cpu);
-		if (ret < 0)
-			return ret;
-
-		if (tmc->childmask =3D=3D 0)
-			return -EINVAL;
-
-		timerqueue_init(&tmc->cpuevt.nextevt);
-		tmc->cpuevt.nextevt.expires =3D KTIME_MAX;
-		tmc->cpuevt.ignore =3D true;
-		tmc->cpuevt.cpu =3D cpu;
-
-		tmc->remote =3D false;
-		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
-	}
-	raw_spin_lock_irq(&tmc->lock);
-	trace_tmigr_cpu_online(tmc);
-	tmc->idle =3D timer_base_is_idle();
-	if (!tmc->idle)
-		__tmigr_cpu_activate(tmc);
-	tmc->online =3D true;
-	raw_spin_unlock_irq(&tmc->lock);
-	return 0;
-}
-
-/*
- * tmigr_trigger_active() - trigger a CPU to become active again
- *
- * This function is executed on a CPU which is part of cpu_online_mask, when=
 the
- * last active CPU in the hierarchy is offlining. With this, it is ensured t=
hat
- * the other CPU is active and takes over the migrator duty.
- */
-static long tmigr_trigger_active(void *unused)
+static int tmigr_cpu_prepare(unsigned int cpu)
 {
-	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
+	struct tmigr_cpu *tmc =3D per_cpu_ptr(&tmigr_cpu, cpu);
+	int ret =3D 0;
=20
-	WARN_ON_ONCE(!tmc->online || tmc->idle);
-
-	return 0;
-}
-
-static int tmigr_cpu_offline(unsigned int cpu)
-{
-	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
-	int migrator;
-	u64 firstexp;
+	/* Not first online attempt? */
+	if (tmc->tmgroup)
+		return ret;
=20
-	raw_spin_lock_irq(&tmc->lock);
-	tmc->online =3D false;
+	raw_spin_lock_init(&tmc->lock);
+	timerqueue_init(&tmc->cpuevt.nextevt);
+	tmc->cpuevt.nextevt.expires =3D KTIME_MAX;
+	tmc->cpuevt.ignore =3D true;
+	tmc->cpuevt.cpu =3D cpu;
+	tmc->remote =3D false;
 	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
=20
-	/*
-	 * CPU has to handle the local events on his own, when on the way to
-	 * offline; Therefore nextevt value is set to KTIME_MAX
-	 */
-	firstexp =3D __tmigr_cpu_deactivate(tmc, KTIME_MAX);
-	trace_tmigr_cpu_offline(tmc);
-	raw_spin_unlock_irq(&tmc->lock);
+	ret =3D tmigr_add_cpu(cpu);
+	if (ret < 0)
+		return ret;
=20
-	if (firstexp !=3D KTIME_MAX) {
-		migrator =3D cpumask_any_but(cpu_online_mask, cpu);
-		work_on_cpu(migrator, tmigr_trigger_active, NULL);
-	}
+	if (tmc->groupmask =3D=3D 0)
+		return -EINVAL;
=20
-	return 0;
+	return ret;
 }
=20
 static int __init tmigr_init(void)
@@ -1796,6 +1792,11 @@ static int __init tmigr_init(void)
 		tmigr_hierarchy_levels, TMIGR_CHILDREN_PER_GROUP,
 		tmigr_crossnode_level);
=20
+	ret =3D cpuhp_setup_state(CPUHP_TMIGR_PREPARE, "tmigr:prepare",
+				tmigr_cpu_prepare, NULL);
+	if (ret)
+		goto err;
+
 	ret =3D cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
 				tmigr_cpu_online, tmigr_cpu_offline);
 	if (ret)
@@ -1807,4 +1808,4 @@ static int __init tmigr_init(void)
 	pr_err("Timer migration setup failed\n");
 	return ret;
 }
-late_initcall(tmigr_init);
+early_initcall(tmigr_init);
diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
index 6c37d94a37d9..154accc7a543 100644
--- a/kernel/time/timer_migration.h
+++ b/kernel/time/timer_migration.h
@@ -22,7 +22,17 @@ struct tmigr_event {
  * struct tmigr_group - timer migration hierarchy group
  * @lock:		Lock protecting the event information and group hierarchy
  *			information during setup
- * @parent:		Pointer to the parent group
+ * @parent:		Pointer to the parent group. Pointer is updated when a
+ *			new hierarchy level is added because of a CPU coming
+ *			online the first time. Once it is set, the pointer will
+ *			not be removed or updated. When accessing parent pointer
+ *			lock less to decide whether to abort a propagation or
+ *			not, it is not a problem. The worst outcome is an
+ *			unnecessary/early CPU wake up. But do not access parent
+ *			pointer several times in the same 'action' (like
+ *			activation, deactivation, check for remote expiry,...)
+ *			without holding the lock as it is not ensured that value
+ *			will not change.
  * @groupevt:		Next event of the group which is only used when the
  *			group is !active. The group event is then queued into
  *			the parent timer queue.
@@ -41,9 +51,8 @@ struct tmigr_event {
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
@@ -59,7 +68,7 @@ struct tmigr_group {
 	unsigned int		level;
 	int			numa_node;
 	unsigned int		num_children;
-	u8			childmask;
+	u8			groupmask;
 	struct list_head	list;
 };
=20
@@ -79,7 +88,7 @@ struct tmigr_group {
  *			hierarchy
  * @remote:		Is set when timers of the CPU are expired remotely
  * @tmgroup:		Pointer to the parent group
- * @childmask:		childmask of tmigr_cpu in the parent group
+ * @groupmask:		mask of tmigr_cpu in the parent group
  * @wakeup:		Stores the first timer when the timer migration
  *			hierarchy is completely idle and remote expiry was done;
  *			is returned to timer code in the idle path and is only
@@ -92,7 +101,7 @@ struct tmigr_cpu {
 	bool			idle;
 	bool			remote;
 	struct tmigr_group	*tmgroup;
-	u8			childmask;
+	u8			groupmask;
 	u64			wakeup;
 	struct tmigr_event	cpuevt;
 };
@@ -108,8 +117,8 @@ union tmigr_state {
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


