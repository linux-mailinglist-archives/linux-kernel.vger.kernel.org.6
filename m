Return-Path: <linux-kernel+bounces-512955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 385AEA33FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9483AAF62
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265BE25777;
	Thu, 13 Feb 2025 13:01:45 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F17221720
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451704; cv=none; b=fl/TAhkeSbyPtnDMqGiVl7wkidk9jS41Qgm4G5UIe0ak6B2o6Qhvfp8LojXf7oYGQ1XhKTVvmIVmOVqRWaEB5m6GykIBARB7GVLRQWGHj6cPqUCUojEw68kPuHb0Z/+l2t6YeOKXAlx0/JXVtzNTHf21CixhIZQZu3evQNkjK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451704; c=relaxed/simple;
	bh=kNBtBl/O1S5LGKY+VSAno0uOTcxxwHXG1EaqmK4MovU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjLfhvfOOyi4bveBim7dJ896+zQGC6m5NqMlLyNpFdIrCYJNmF75k2I/vmiVZMaMM9YQAJqr9vhowX265gCmQV5hBIrcQ2YcYnLQctV8NHNwGsGtWUX78uKLVwHzSnxhUovJtnUKWnVCOjikUj20WzpDzWM77L0J+ES3dIcc9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YtwF20b00z11Pxg;
	Thu, 13 Feb 2025 20:57:10 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id BBD2618010B;
	Thu, 13 Feb 2025 21:01:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Feb
 2025 21:01:37 +0800
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
Subject: [PATCH -next v6 4/8] arm64: entry: Rework arm64_preempt_schedule_irq()
Date: Thu, 13 Feb 2025 21:00:03 +0800
Message-ID: <20250213130007.1418890-5-ruanjinjie@huawei.com>
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

The generic entry code has the form:

| raw_irqentry_exit_cond_resched()
| {
| 	if (!preempt_count()) {
| 		...
| 		if (need_resched())
| 			preempt_schedule_irq();
| 	}
| }

In preparation for moving arm64 over to the generic entry code, align
the structure of the arm64 code with raw_irqentry_exit_cond_resched() from
the generic entry code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v6:
- Update the commit message.
---
 arch/arm64/kernel/entry-common.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 8e597d32433d..94e4132213ce 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -289,10 +289,10 @@ DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
 #define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
 #endif
 
-static void __sched arm64_preempt_schedule_irq(void)
+static inline bool arm64_preempt_schedule_irq(void)
 {
 	if (!need_irq_preemption())
-		return;
+		return false;
 
 	/*
 	 * Note: thread_info::preempt_count includes both thread_info::count
@@ -300,7 +300,7 @@ static void __sched arm64_preempt_schedule_irq(void)
 	 * preempt_count().
 	 */
 	if (READ_ONCE(current_thread_info()->preempt_count) != 0)
-		return;
+		return false;
 
 	/*
 	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
@@ -309,7 +309,7 @@ static void __sched arm64_preempt_schedule_irq(void)
 	 * DAIF we must have handled an NMI, so skip preemption.
 	 */
 	if (system_uses_irq_prio_masking() && read_sysreg(daif))
-		return;
+		return false;
 
 	/*
 	 * Preempting a task from an IRQ means we leave copies of PSTATE
@@ -319,8 +319,10 @@ static void __sched arm64_preempt_schedule_irq(void)
 	 * Only allow a task to be preempted once cpufeatures have been
 	 * enabled.
 	 */
-	if (system_capabilities_finalized())
-		preempt_schedule_irq();
+	if (!system_capabilities_finalized())
+		return false;
+
+	return true;
 }
 
 static void do_interrupt_handler(struct pt_regs *regs,
@@ -591,7 +593,8 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
 	do_interrupt_handler(regs, handler);
 	irq_exit_rcu();
 
-	arm64_preempt_schedule_irq();
+	if (arm64_preempt_schedule_irq())
+		preempt_schedule_irq();
 
 	exit_to_kernel_mode(regs, state);
 }
-- 
2.34.1


