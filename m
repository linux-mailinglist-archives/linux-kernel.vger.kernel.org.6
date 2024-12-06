Return-Path: <linux-kernel+bounces-434852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A69E79E6C07
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CCF1886EDC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB427205AC7;
	Fri,  6 Dec 2024 10:18:21 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3E20370E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480301; cv=none; b=ML1QSi1T7YoUgM8lY7SYpEk49uuo2rGkWhU+6FT559xBPiZBicvrsByCAh1+BoPXItv1I8m/riSsX/Z9c+9SlnOc7lfH1U5QMtOEFibsY1wOwX1aqBd7YZo61CZoYicEiQ+EHzWolvpw5RFxCgDyJsQl9u34RrI1X5+6dDLEbrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480301; c=relaxed/simple;
	bh=ORaEWNYQq1V+fMAvc4CPDGyD/Zi7TnK9zWVVeGQvQCg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRnJgpvUADPDPQHrdoMRPkfh+8ZDwoSag+uFBwRIwOqgKuhMdsdHHvu27/sf7EfYA2+RA0SUssT73vw5oXl+14YvKRv/C+CCJ0sCBFwhhGLhK2yz1/WVdC/kdJfeyO2Mtlcg7Xt1SZlF2BbG35T4hb//TqeXyvm4GXufQXzflHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y4Rws4GZ2z1kvVr;
	Fri,  6 Dec 2024 18:15:57 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id C093C1402E0;
	Fri,  6 Dec 2024 18:18:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Dec
 2024 18:18:15 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <tglx@linutronix.de>, <peterz@infradead.org>,
	<luto@kernel.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kees@kernel.org>, <wad@chromium.org>,
	<akpm@linux-foundation.org>, <samitolvanen@google.com>,
	<masahiroy@kernel.org>, <hca@linux.ibm.com>, <aliceryhl@google.com>,
	<rppt@kernel.org>, <xur@google.com>, <paulmck@kernel.org>, <arnd@arndb.de>,
	<mbenes@suse.cz>, <puranjay@kernel.org>, <mark.rutland@arm.com>,
	<ruanjinjie@huawei.com>, <pcc@google.com>, <ardb@kernel.org>,
	<sudeep.holla@arm.com>, <guohanjun@huawei.com>, <rafael@kernel.org>,
	<liuwei09@cestc.cn>, <dwmw@amazon.co.uk>, <Jonathan.Cameron@huawei.com>,
	<liaochang1@huawei.com>, <kristina.martsenko@arm.com>, <ptosi@google.com>,
	<broonie@kernel.org>, <thiago.bauermann@linaro.org>, <kevin.brodsky@arm.com>,
	<joey.gouly@arm.com>, <liuyuntao12@huawei.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH -next v5 08/22] arm64: entry: Use different helpers to check resched for PREEMPT_DYNAMIC
Date: Fri, 6 Dec 2024 18:17:30 +0800
Message-ID: <20241206101744.4161990-9-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206101744.4161990-1-ruanjinjie@huawei.com>
References: <20241206101744.4161990-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200008.china.huawei.com (7.202.181.35)

In generic entry, when PREEMPT_DYNAMIC is enabled or disabled, two
different helpers are used to check whether resched is required
and some common code is reused.

In preparation for moving arm64 over to the generic entry code,
use new helper to check resched when PREEMPT_DYNAMIC enabled and
reuse common code for the disabled case.

No functional changes.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/preempt.h |  3 +++
 arch/arm64/kernel/entry-common.c | 21 +++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index d0f93385bd85..0f0ba250efe8 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -93,11 +93,14 @@ void dynamic_preempt_schedule(void);
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
index 029f8bd72f8a..015a65d19b52 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -75,10 +75,6 @@ static noinstr irqentry_state_t enter_from_kernel_mode(struct pt_regs *regs)
 	return state;
 }
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-#endif
-
 static inline bool arm64_need_resched(void)
 {
 	/*
@@ -106,17 +102,22 @@ static inline bool arm64_need_resched(void)
 
 void raw_irqentry_exit_cond_resched(void)
 {
-#ifdef CONFIG_PREEMPT_DYNAMIC
-	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
-		return;
-#endif
-
 	if (!preempt_count()) {
 		if (need_resched() && arm64_need_resched())
 			preempt_schedule_irq();
 	}
 }
 
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
 /*
  * Handle IRQ/context state management when exiting to kernel mode.
  * After this function returns it is not safe to call regular kernel code,
@@ -140,7 +141,7 @@ static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs,
 		}
 
 		if (IS_ENABLED(CONFIG_PREEMPTION))
-			raw_irqentry_exit_cond_resched();
+			irqentry_exit_cond_resched();
 
 		trace_hardirqs_on();
 	} else {
-- 
2.34.1


