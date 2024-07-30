Return-Path: <linux-kernel+bounces-267583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96950941313
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF8828465B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354419F48B;
	Tue, 30 Jul 2024 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOLYhGPe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D7418FC6E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345876; cv=none; b=Eaf06S99VgrOHPc0pxtUmTNPvB1IaUBhZbTBiOiCs6G9AbNFlG8DdW4iPD6xEq0V3UDLUSwUNUns6Ls1cGMx/acYbCw45ASuMrK0Zd622sgJDrpj9dFnNJWYVDhyv2VASz2qnVeodJNyesJsZjmikk/Oec71XY8PjcgLol87rhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345876; c=relaxed/simple;
	bh=4oNqRZEK8kaLBB6dWn3L9RZ4qdkJlvQ2wbzgXFlr2gA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Hpm0tjasL9q0NAqO7aJj83hBfp4BSYQOCh/DiQsaMf/Dk3P1SVN8VtES6APRyD1kEPYrjhoqqq62mnMQNscBjMGM5QqXqjAWDE3X/wHXfO4F5LDljXN0k4/3MUgZk5Omg0tw96tgrgBuCTCPuQp4LVj6NEt7c0jF9qgcF11lX0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOLYhGPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCD4C4AF0A;
	Tue, 30 Jul 2024 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722345876;
	bh=4oNqRZEK8kaLBB6dWn3L9RZ4qdkJlvQ2wbzgXFlr2gA=;
	h=From:Date:Subject:To:Cc:From;
	b=NOLYhGPe4EuHTiZvgDkc84FMkO/57w/yIdF2mG/Jg2jvA78Qdw5Vy7yfl8FdiXCD2
	 dTJv0iYSy+bCWq/LU8P1FdvnAcdvhogKTSCJ1nNp18q+ZatF8h/BQCP8Xcfd01qDq/
	 nQofbpV3RRbop+8kp3sW9LK6VOKTdYojdm/nXPcKDXRnFg+UZ4Uh/0vP2K5d1HPTjR
	 kgjs2Xp7pZUsCXQEBTzJi/VAIBZSOuGoFVnYDcQe3ctzH80ThcDDOvR6qQNJak/f/S
	 ozQU3fucGgnpgUqKQvm3y4XpZHU+SaOwHbZEmJjeIT6YVjXrZav4LvG9wzFwvvkUP0
	 R44RhRt/RCL6Q==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 30 Jul 2024 14:23:47 +0100
Subject: [PATCH v7] arm64/fpsimd: Suppress SVE access traps when loading
 FPSIMD state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-arm64-sve-trap-mitigation-v7-1-755e7e31bdd7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGLpqGYC/43PTWrDMBAF4KsErauiGf1n1XuULBRr7Ig2dpCNS
 Qm+e+VAa4pBdPkG3je8BxspJxrZ8fBgmeY0pqEvwb4cWHMJfUc8xZIZCpTCCctDvhrFx5n4lMO
 NX9OUujCVFkeyhMbIxinPSv+WqU33p/1+KvmSxmnIX89XM6zX/6gzcODRI1GEiE7rtw/KPX2+D
 rljKzvjRnmQNQoLBedIbSsdgoUdJX8pgDolC6Ws9Y0vlHJyR6kfSglArFGqUFqRiNYFGcjvKL1
 RSugapdeBaFpCDZra/UCzURp9jTKFalBIeyYTGop/qGVZvgH79xNpOgIAAA==
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=9613; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4oNqRZEK8kaLBB6dWn3L9RZ4qdkJlvQ2wbzgXFlr2gA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmqOmRpRYPMlElCVmyWjz4D752wfnGsPs7B6tUsgpt
 mjTXczOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZqjpkQAKCRAk1otyXVSH0N66B/
 4qM/31Y2kFw7U1BIR0rBHGli6868tM4AOIJrfg3xiLx9SnF+HUdrMkROdZSbTiIIgJkpilQvov5lmL
 +lUs1Gej02G7S2TOCgHHN5jLEbDSB3Atahaz4idzGbLGSV8zG/2mq4wv9N8VKn82fEOG6sVqyvvqlS
 kQnfw2cgb4ZznA2D+jhQ4Pg2b+iNnXeW1yUSxCIILsqmNYPK0cPF5IDQMjzGr87rvEOfsqV5qVEFBE
 OIiHZRiaF9uM6uIW7qIXiXxrFwKy0dhQuVkpVHXQlmLyYDDcdQtaHqnh70ZWT08UpTfVFavLHvGE/M
 2RJ6afzXSUnb9ZdAQsD0r7p2VbKfes
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When we are in a syscall we take the opportunity to discard the SVE state,
saving only the FPSIMD subset of the register state. When we reload the
state from memory we reenable SVE access traps, stopping tracking SVE until
the task takes another SVE access trap. This means that for a task which is
actively using SVE many blocking system calls will have the additional
overhead of a SVE access trap.

As SVE deployment is progressing we are seeing much wider use of the SVE
instruction set, including performance optimised implementations of
operations like memset() and memcpy(), which mean that even tasks which are
not obviously floating point based can end up with substantial SVE usage.

It does not, however, make sense to just unconditionally use the full SVE
register state all the time since it is larger than the FPSIMD register
state so there is overhead saving and restoring it on context switch and
our requirement to flush the register state not shared with FPSIMD on
syscall also creates a noticeable overhead on system call.

I did some instrumentation which counted the number of SVE access traps
and the number of times we loaded FPSIMD only register state for each task.
Testing with Debian Bookworm this showed that during boot the overwhelming
majority of tasks triggered another SVE access trap more than 50% of the
time after loading FPSIMD only state with a substantial number near 100%,
though some programs had a very small number of SVE accesses most likely
from startup. There were few tasks in the range 5-45%, most tasks either
used SVE frequently or used it only a tiny proportion of times. As expected
older distributions which do not have the SVE performance work available
showed no SVE usage in general applications.

This indicates that there should be some useful benefit from reducing the
number of SVE access traps for blocking system calls like we did for non
blocking system calls in commit 8c845e273104 ("arm64/sve: Leave SVE enabled
on syscall if we don't context switch"). Let's do this with a timeout, when
we take a SVE access trap record a jiffies after which we'll reeanble SVE
traps then check this whenver we load a FPSIMD only floating point state
from memory. If the time has passed then we reenable traps, otherwise we
leave traps disabled and flush the non-shared register state like we would
on trap.

The timeout is currently set to a second, I pulled this number out of thin
air so there is doubtless some room for tuning. This means that for a
task which is actively using SVE the number of SVE access traps will be
substantially reduced but applications which use SVE only very
infrequently will avoid the overheads associated with tracking SVE state
after a second. The extra cost from additional tracking of SVE state
only occurs when a task is preempted so short running tasks should be
minimally affected.

There should be no functional change resulting from this, it is purely a
performance optimisation.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v7:
- Rebase onto v6.11-rc1.
- Only flush the predicate registers when loading FPSIMD state, Z will
  be flushed by loading the V registers.
- Link to v6: https://lore.kernel.org/r/20240529-arm64-sve-trap-mitigation-v6-1-c2037be6aced@kernel.org

Changes in v6:
- Rebase onto v6.10-rc1.
- Link to v5: https://lore.kernel.org/r/20240405-arm64-sve-trap-mitigation-v5-1-126fe2515ef1@kernel.org

Changes in v5:
- Rebase onto v6.9-rc1.
- Use a timeout rather than number of state loads to decide when to
  reenable traps.
- Link to v4: https://lore.kernel.org/r/20240122-arm64-sve-trap-mitigation-v4-1-54e0d78a3ae9@kernel.org

Changes in v4:
- Rebase onto v6.8-rc1.
- Link to v3: https://lore.kernel.org/r/20231113-arm64-sve-trap-mitigation-v3-1-4779c9382483@kernel.org

Changes in v3:
- Rebase onto v6.7-rc1.
- Link to v2: https://lore.kernel.org/r/20230913-arm64-sve-trap-mitigation-v2-1-1bdeff382171@kernel.org

Changes in v2:
- Rebase onto v6.6-rc1.
- Link to v1: https://lore.kernel.org/r/20230807-arm64-sve-trap-mitigation-v1-1-d92eed1d2855@kernel.org
---
 arch/arm64/include/asm/fpsimd.h    |  1 +
 arch/arm64/include/asm/processor.h |  1 +
 arch/arm64/kernel/entry-fpsimd.S   | 15 ++++++++++++
 arch/arm64/kernel/fpsimd.c         | 48 +++++++++++++++++++++++++++++++++-----
 4 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index bc69ac368d73..ec39381101fc 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -140,6 +140,7 @@ static inline void *thread_zt_state(struct thread_struct *thread)
 extern void sve_save_state(void *state, u32 *pfpsr, int save_ffr);
 extern void sve_load_state(void const *state, u32 const *pfpsr,
 			   int restore_ffr);
+extern void sve_flush_p(bool flush_ffr);
 extern void sve_flush_live(bool flush_ffr, unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
 extern void sve_set_vq(unsigned long vq_minus_1);
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index f77371232d8c..7a6ed0551291 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -164,6 +164,7 @@ struct thread_struct {
 	unsigned int		fpsimd_cpu;
 	void			*sve_state;	/* SVE registers, if any */
 	void			*sme_state;	/* ZA and ZT state, if any */
+	unsigned long		sve_timeout;    /* jiffies to drop TIF_SVE */
 	unsigned int		vl[ARM64_VEC_MAX];	/* vector length */
 	unsigned int		vl_onexec[ARM64_VEC_MAX]; /* vl after next exec */
 	unsigned long		fault_address;	/* fault info */
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 6325db1a2179..617dd70cafd7 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -85,6 +85,21 @@ SYM_FUNC_START(sve_flush_live)
 2:	ret
 SYM_FUNC_END(sve_flush_live)
 
+/*
+ * Zero the predicate registers
+ *
+ * VQ must already be configured by caller, any further updates of VQ
+ * will need to ensure that the register state remains valid.
+ *
+ * x0 = include FFR?
+ */
+SYM_FUNC_START(sve_flush_p)
+	sve_flush_p
+	tbz		x0, #0, 1f
+	sve_flush_ffr
+1:	ret
+SYM_FUNC_END(sve_flush_p)
+
 #endif /* CONFIG_ARM64_SVE */
 
 #ifdef CONFIG_ARM64_SME
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 77006df20a75..f2eb32372c5b 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -354,6 +354,7 @@ static void task_fpsimd_load(void)
 {
 	bool restore_sve_regs = false;
 	bool restore_ffr;
+	unsigned long sve_vq_minus_one;
 
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(preemptible());
@@ -365,18 +366,12 @@ static void task_fpsimd_load(void)
 	if (system_supports_sve() || system_supports_sme()) {
 		switch (current->thread.fp_type) {
 		case FP_STATE_FPSIMD:
-			/* Stop tracking SVE for this task until next use. */
-			if (test_and_clear_thread_flag(TIF_SVE))
-				sve_user_disable();
 			break;
 		case FP_STATE_SVE:
 			if (!thread_sm_enabled(&current->thread) &&
 			    !WARN_ON_ONCE(!test_and_set_thread_flag(TIF_SVE)))
 				sve_user_enable();
 
-			if (test_thread_flag(TIF_SVE))
-				sve_set_vq(sve_vq_from_vl(task_get_sve_vl(current)) - 1);
-
 			restore_sve_regs = true;
 			restore_ffr = true;
 			break;
@@ -395,6 +390,15 @@ static void task_fpsimd_load(void)
 		}
 	}
 
+	/*
+	 * If SVE has been enabled we may keep it enabled even if
+	 * loading only FPSIMD state, so always set the VL.
+	 */
+	if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
+		sve_vq_minus_one = sve_vq_from_vl(task_get_sve_vl(current)) - 1;
+		sve_set_vq(sve_vq_minus_one);
+	}
+
 	/* Restore SME, override SVE register configuration if needed */
 	if (system_supports_sme()) {
 		unsigned long sme_vl = task_get_sme_vl(current);
@@ -421,6 +425,31 @@ static void task_fpsimd_load(void)
 	} else {
 		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_FPSIMD);
 		fpsimd_load_state(&current->thread.uw.fpsimd_state);
+
+		/*
+		 * If the task had been using SVE we keep it enabled
+		 * when loading FPSIMD only state for a period to
+		 * minimise overhead for tasks actively using SVE,
+		 * disabling it periodicaly to ensure that tasks that
+		 * use SVE intermittently do eventually avoid the
+		 * overhead of carrying SVE state.  The timeout is
+		 * initialised when we take a SVE trap in in
+		 * do_sve_acc().
+		 */
+		if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
+			if (time_after(jiffies, current->thread.sve_timeout)) {
+				clear_thread_flag(TIF_SVE);
+				sve_user_disable();
+			} else {
+				/*
+				 * Loading V will have flushed the
+				 * rest of the Z register, SVE is
+				 * enabled at EL1 and VL was set
+				 * above.
+				 */
+				sve_flush_p(true);
+			}
+		}
 	}
 }
 
@@ -1397,6 +1426,13 @@ void do_sve_acc(unsigned long esr, struct pt_regs *regs)
 
 	get_cpu_fpsimd_context();
 
+	/*
+	 * We will keep SVE enabled when loading FPSIMD only state for
+	 * the next second to minimise traps when userspace is
+	 * actively using SVE.
+	 */
+	current->thread.sve_timeout = jiffies + HZ;
+
 	if (test_and_set_thread_flag(TIF_SVE))
 		WARN_ON(1); /* SVE access shouldn't have trapped */
 

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20230807-arm64-sve-trap-mitigation-2e7e2663c849

Best regards,
-- 
Mark Brown <broonie@kernel.org>


