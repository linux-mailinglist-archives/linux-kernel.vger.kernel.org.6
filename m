Return-Path: <linux-kernel+bounces-512957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDE5A33FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4723AAA15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BAE23A9B5;
	Thu, 13 Feb 2025 13:01:45 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319B221732
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451705; cv=none; b=DKKXMeshsjewoKBhZtv3dp9A4wjO0urNCF03s+ASn2DZ0iFghJCHkzNcAWU0RAgh4J0lgOUm7qHPg4P6ToRn1eMQ+j+lqG5u/If2LHboENdt4DsMtW5NCbqEnibN6QUbUjt44T0tTDVF3GbvsYW6yZ2z6BJ3I6AUEzQ0to8GgaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451705; c=relaxed/simple;
	bh=sypRHtkrJIT4rcWElWoHc/gyLu99NISS9qLQraFpv98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bE6bX8dQZ3rlgVwe7XvTindamTqfZuhgAx/Xc4UVToek8BOrtRWtpCiL/rxBDkfp8wv4wFeZNXu1SBAS2lfil6Rf7IYVvvxeRZiJsZUOJ9ehjwLuJ/hzONZ609MrsfaZwfTRg576TlHkm/6rjMTfHQYWaCtfpV7DxJfYujKyDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YtwFs1rQvz1V6fb;
	Thu, 13 Feb 2025 20:57:53 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B738140202;
	Thu, 13 Feb 2025 21:01:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Feb
 2025 21:01:39 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <tglx@linutronix.de>, <peterz@infradead.org>,
	<luto@kernel.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kees@kernel.org>, <aliceryhl@google.com>,
	<ojeda@kernel.org>, <samitolvanen@google.com>, <masahiroy@kernel.org>,
	<rppt@kernel.org>, <xur@google.com>, <paulmck@kernel.org>, <arnd@arndb.de>,
	<mark.rutland@arm.com>, <puranjay@kernel.org>, <broonie@kernel.org>,
	<mbenes@suse.cz>, <sudeep.holla@arm.com>, <guohanjun@huawei.com>,
	<prarit@redhat.com>, <liuwei09@cestc.cn>, <Jonathan.Cameron@huawei.com>,
	<dwmw@amazon.co.uk>, <kristina.martsenko@arm.com>, <liaochang1@huawei.com>,
	<ptosi@google.com>, <thiago.bauermann@linaro.org>, <kevin.brodsky@arm.com>,
	<Dave.Martin@arm.com>, <joey.gouly@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <xen-devel@lists.xenproject.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v6 6/8] arm64: entry: Refactor preempt_schedule_irq() check code
Date: Thu, 13 Feb 2025 21:00:05 +0800
Message-ID: <20250213130007.1418890-7-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213130007.1418890-1-ruanjinjie@huawei.com>
References: <20250213130007.1418890-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200008.china.huawei.com (7.202.181.35)

ARM64 requires an additional check whether to reschedule on return
from interrupt. So add arch_irqentry_exit_need_resched() as the default
NOP implementation and hook it up into the need_resched() condition in
raw_irqentry_exit_cond_resched(). This allows ARM64 to implement
the architecture specific version for switching over to
the generic entry code.

To align the structure of the code with irqentry_exit_cond_resched()
from the generic entry code, hoist the need_irq_preemption()
and IS_ENABLED() check earlier. And different preemption check functions
are defined based on whether dynamic preemption is enabled.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v6:
- Update the commit message.
- Hoist the IS_ENABLED() and need_irq_preemption() check earlier.
- Merge the 4 pathes.
---
 arch/arm64/include/asm/preempt.h |  4 ++++
 arch/arm64/kernel/entry-common.c | 35 ++++++++++++++++++--------------
 kernel/entry/common.c            | 16 ++++++++++++++-
 3 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 0159b625cc7f..0f0ba250efe8 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -85,6 +85,7 @@ static inline bool should_resched(int preempt_offset)
 void preempt_schedule(void);
 void preempt_schedule_notrace(void);
 
+void raw_irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
 DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
@@ -92,11 +93,14 @@ void dynamic_preempt_schedule(void);
 #define __preempt_schedule()		dynamic_preempt_schedule()
 void dynamic_preempt_schedule_notrace(void);
 #define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
+void dynamic_irqentry_exit_cond_resched(void);
+#define irqentry_exit_cond_resched()	dynamic_irqentry_exit_cond_resched()
 
 #else /* CONFIG_PREEMPT_DYNAMIC */
 
 #define __preempt_schedule()		preempt_schedule()
 #define __preempt_schedule_notrace()	preempt_schedule_notrace()
+#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
 
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 #endif /* CONFIG_PREEMPTION */
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index dceef4cb140b..1b4936d4cf6e 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -281,19 +281,8 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs,
 		lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-#define need_irq_preemption() \
-	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
-#else
-#define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
-#endif
-
 static inline bool arm64_preempt_schedule_irq(void)
 {
-	if (!need_irq_preemption())
-		return false;
-
 	/*
 	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
 	 * priority masking is used the GIC irqchip driver will clear DAIF.IF
@@ -576,6 +565,24 @@ static __always_inline void __el1_pnmi(struct pt_regs *regs,
 	arm64_exit_nmi(regs, state);
 }
 
+void raw_irqentry_exit_cond_resched(void)
+{
+	if (!preempt_count()) {
+		if (need_resched() && arm64_preempt_schedule_irq())
+			preempt_schedule_irq();
+	}
+}
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+void dynamic_irqentry_exit_cond_resched(void)
+{
+	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
+		return;
+	raw_irqentry_exit_cond_resched();
+}
+#endif
+
 static __always_inline void __el1_irq(struct pt_regs *regs,
 				      void (*handler)(struct pt_regs *))
 {
@@ -585,10 +592,8 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
 	do_interrupt_handler(regs, handler);
 	irq_exit_rcu();
 
-	if (!preempt_count() && need_resched()) {
-		if (arm64_preempt_schedule_irq())
-			preempt_schedule_irq();
-	}
+	if (IS_ENABLED(CONFIG_PREEMPTION))
+		irqentry_exit_cond_resched();
 
 	exit_to_kernel_mode(regs, state);
 }
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index b82032777310..4aa9656fa1b4 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -142,6 +142,20 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	return ret;
 }
 
+/**
+ * arch_irqentry_exit_need_resched - Architecture specific need resched function
+ *
+ * Invoked from raw_irqentry_exit_cond_resched() to check if need resched.
+ * Defaults return true.
+ *
+ * The main purpose is to permit arch to skip preempt a task from an IRQ.
+ */
+static inline bool arch_irqentry_exit_need_resched(void);
+
+#ifndef arch_irqentry_exit_need_resched
+static inline bool arch_irqentry_exit_need_resched(void) { return true; }
+#endif
+
 void raw_irqentry_exit_cond_resched(void)
 {
 	if (!preempt_count()) {
@@ -149,7 +163,7 @@ void raw_irqentry_exit_cond_resched(void)
 		rcu_irq_exit_check_preempt();
 		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 			WARN_ON_ONCE(!on_thread_stack());
-		if (need_resched())
+		if (need_resched() && arch_irqentry_exit_need_resched())
 			preempt_schedule_irq();
 	}
 }
-- 
2.34.1


