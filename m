Return-Path: <linux-kernel+bounces-350891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7A4990AB5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7AE1C21446
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974C1DACA6;
	Fri,  4 Oct 2024 18:06:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2B11E2843
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065206; cv=none; b=rvdT9ECJ3ekcecguFKzNraD6YQnHcRyRwq0TbdlZW3N4xnt1nDCYjA7fj2s8k/vqXUh39eZN0t/sp6TbakZOISUm/durUhX1f69mnWVGyPLoks7PuwtBGzSoRWLaqwY7Zqb02n8lc1CRGXDHKYWMPn3tA8op/QFwKKlT3XtqZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065206; c=relaxed/simple;
	bh=/Cm8Jsp+TDAwXLYrsf6MkuZDZFuL2n5jGvcqaJRvJco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kXrVWY8+Omt1jtOzoqnuEen9SysOM7yDoD87Yt1zVwWhM9EQ+pt3BGoyM78MBP7LU33SHGDnPqJRE4xErafQRvNidMU5dRpGBBUPTfGXjFvfij9We61yDahR5BhKNdDnbayXpYaHftMcCHY+9MLFV9cdErWa/1+TMygoFsHHkiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 199F2339;
	Fri,  4 Oct 2024 11:07:14 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 765823F58B;
	Fri,  4 Oct 2024 11:06:41 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v5 31/40] x86/resctrl: Rename resctrl_sched_in() to begin with "resctrl_arch_"
Date: Fri,  4 Oct 2024 18:03:38 +0000
Message-Id: <20241004180347.19985-32-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241004180347.19985-1-james.morse@arm.com>
References: <20241004180347.19985-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resctrl_sched_in() loads the architecture specific CPU MSRs with the
CLOSID and RMID values. This function was named before resctrl was
split to have architecture specific code, and generic filesystem code.

This function is obviously architecture specific, but does not begin
with 'resctrl_arch_', making it the odd one out in the functions an
architecture needs to support to enable resctrl.

Rename it for consistency. This is purely cosmetic.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 arch/x86/include/asm/resctrl.h         |  4 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 ++++++------
 arch/x86/kernel/process_32.c           |  2 +-
 arch/x86/kernel/process_64.c           |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 6c1446ce43da..22e508c10059 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -177,7 +177,7 @@ static inline bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 ignored,
 	return READ_ONCE(tsk->rmid) == rmid;
 }
 
-static inline void resctrl_sched_in(struct task_struct *tsk)
+static inline void resctrl_arch_sched_in(struct task_struct *tsk)
 {
 	if (static_branch_likely(&rdt_enable_key))
 		__resctrl_sched_in(tsk);
@@ -214,7 +214,7 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
 #else
 
-static inline void resctrl_sched_in(struct task_struct *tsk) {}
+static inline void resctrl_arch_sched_in(struct task_struct *tsk) {}
 static inline void resctrl_cpu_detect(struct cpuinfo_x86 *c) {}
 
 #endif /* CONFIG_X86_CPU_RESCTRL */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ee9c3e4ee889..f77fab859c35 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -353,7 +353,7 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
 }
 
 /*
- * This is safe against resctrl_sched_in() called from __switch_to()
+ * This is safe against resctrl_arch_sched_in() called from __switch_to()
  * because __switch_to() is executed with interrupts disabled. A local call
  * from update_closid_rmid() is protected against __switch_to() because
  * preemption is disabled.
@@ -372,7 +372,7 @@ void resctrl_arch_sync_cpu_closid_rmid(void *info)
 	 * executing task might have its own closid selected. Just reuse
 	 * the context switch code.
 	 */
-	resctrl_sched_in(current);
+	resctrl_arch_sched_in(current);
 }
 
 /*
@@ -597,7 +597,7 @@ static void _update_task_closid_rmid(void *task)
 	 * Otherwise, the MSR is updated when the task is scheduled in.
 	 */
 	if (task == current)
-		resctrl_sched_in(task);
+		resctrl_arch_sched_in(task);
 }
 
 static void update_task_closid_rmid(struct task_struct *t)
@@ -655,7 +655,7 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	 * Ensure the task's closid and rmid are written before determining if
 	 * the task is current that will decide if it will be interrupted.
 	 * This pairs with the full barrier between the rq->curr update and
-	 * resctrl_sched_in() during context switch.
+	 * resctrl_arch_sched_in() during context switch.
 	 */
 	smp_mb();
 
@@ -2931,8 +2931,8 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 			/*
 			 * Order the closid/rmid stores above before the loads
 			 * in task_curr(). This pairs with the full barrier
-			 * between the rq->curr update and resctrl_sched_in()
-			 * during context switch.
+			 * between the rq->curr update and
+			 * resctrl_arch_sched_in() during context switch.
 			 */
 			smp_mb();
 
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 0917c7f25720..8697b02dabf1 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -211,7 +211,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	switch_fpu_finish(next_p);
 
 	/* Load the Intel cache allocation PQR MSR. */
-	resctrl_sched_in(next_p);
+	resctrl_arch_sched_in(next_p);
 
 	return prev_p;
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 226472332a70..3f1235d3bf1d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -707,7 +707,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	}
 
 	/* Load the Intel cache allocation PQR MSR. */
-	resctrl_sched_in(next_p);
+	resctrl_arch_sched_in(next_p);
 
 	return prev_p;
 }
-- 
2.39.2


