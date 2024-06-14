Return-Path: <linux-kernel+bounces-214323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB82C9082C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46447B23B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B798F184100;
	Fri, 14 Jun 2024 03:52:46 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EBC181D0C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718337166; cv=none; b=DylZrmkYHcedieUnbGZQlzzJkZcRgWC6wu6enGly/+jPb41Y83FPx/0DUalEt0i1pvt6ynprHQn6ws1BctoWMoeC9FLRbSZu2nnwMEOmXPRiH1EeOzluzKy2JlLqihRtSf0uiWoBR5NcYe7VO7jKlm/c6bdwPdRYhSZDfm2MMBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718337166; c=relaxed/simple;
	bh=ADZTH5v9ErWP1nQYtWH2qAgEhHG4OtuRtMFGVdtWJ+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGjoW41N1g5brWpCVvC72WLzjh4VrkCKclWRlblyWEOeIlqOH48tefa8qPVvdjKrmBQxQ9/WTFU7y2dMDo70kgbC4oCiigeb0hGEruW7fzInUOeSu9EIJd707TiySjqZjmod2E5SNQmFCpoa/cd9Kl5ItaBHnjCaW2WDaiC6k1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W0ldQ0jZmzPqhv;
	Fri, 14 Jun 2024 11:49:14 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 08F181402C8;
	Fri, 14 Jun 2024 11:52:41 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 14 Jun
 2024 11:52:39 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <ryabinin.a.a@gmail.com>,
	<glider@google.com>, <andreyknvl@gmail.com>, <dvyukov@google.com>,
	<vincenzo.frascino@arm.com>, <maz@kernel.org>, <oliver.upton@linux.dev>,
	<james.morse@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<mark.rutland@arm.com>, <lpieralisi@kernel.org>, <tglx@linutronix.de>,
	<ardb@kernel.org>, <broonie@kernel.org>, <liaochang1@huawei.com>,
	<steven.price@arm.com>, <ryan.roberts@arm.com>, <pcc@google.com>,
	<anshuman.khandual@arm.com>, <eric.auger@redhat.com>,
	<miguel.luis@oracle.com>, <shiqiliu@hust.edu.cn>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <sudeep.holla@arm.com>, <dwmw@amazon.co.uk>,
	<joey.gouly@arm.com>, <jeremy.linton@arm.com>, <robh@kernel.org>,
	<scott@os.amperecomputing.com>, <songshuaishuai@tinylab.org>,
	<swboyd@chromium.org>, <dianders@chromium.org>,
	<shijie@os.amperecomputing.com>, <bhe@redhat.com>,
	<akpm@linux-foundation.org>, <rppt@kernel.org>, <mhiramat@kernel.org>,
	<mcgrof@kernel.org>, <rmk+kernel@armlinux.org.uk>,
	<Jonathan.Cameron@huawei.com>, <takakura@valinux.co.jp>,
	<sumit.garg@linaro.org>, <frederic@kernel.org>, <tabba@google.com>,
	<kristina.martsenko@arm.com>, <ruanjinjie@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kasan-dev@googlegroups.com>, <kvmarm@lists.linux.dev>
Subject: [PATCH v4 10/10] arm64: Migrate idle context save/restore to logical interrupt masking
Date: Fri, 14 Jun 2024 03:44:33 +0000
Message-ID: <20240614034433.602622-11-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614034433.602622-1-liaochang1@huawei.com>
References: <20240614034433.602622-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)

This patch is part of migration series, replaces the low-level hardware
interrupt masking operations used during CPU idle context save/restore
with the new helper functions starting from local_allint_, it can ensure
the compatibility with future FEAT_NMI feature.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/include/asm/cpuidle.h   | 24 +++++-------------------
 arch/arm64/include/asm/daifflags.h | 17 ++++++++++++++---
 arch/arm64/kernel/idle.c           |  2 +-
 arch/arm64/kernel/suspend.c        |  2 +-
 drivers/firmware/psci/psci.c       |  2 +-
 5 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
index 2047713e097d..b4e230fc8a7b 100644
--- a/arch/arm64/include/asm/cpuidle.h
+++ b/arch/arm64/include/asm/cpuidle.h
@@ -5,32 +5,18 @@
 #include <asm/proc-fns.h>
 
 #ifdef CONFIG_ARM64_PSEUDO_NMI
-#include <asm/arch_gicv3.h>
-
-struct arm_cpuidle_irq_context {
-	unsigned long pmr;
-	unsigned long daif_bits;
-};
+#include <asm/daifflags.h>
 
 #define arm_cpuidle_save_irq_context(__c)				\
 	do {								\
-		struct arm_cpuidle_irq_context *c = __c;		\
-		if (system_uses_irq_prio_masking()) {			\
-			c->daif_bits = read_sysreg(daif);		\
-			write_sysreg(c->daif_bits | PSR_I_BIT | PSR_F_BIT, \
-				     daif);				\
-			c->pmr = gic_read_pmr();			\
-			gic_write_pmr(GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET); \
-		}							\
+		arch_irqflags_t *c = __c;				\
+		*c = local_allint_save_notrace();			\
 	} while (0)
 
 #define arm_cpuidle_restore_irq_context(__c)				\
 	do {								\
-		struct arm_cpuidle_irq_context *c = __c;		\
-		if (system_uses_irq_prio_masking()) {			\
-			gic_write_pmr(c->pmr);				\
-			write_sysreg(c->daif_bits, daif);		\
-		}							\
+		arch_irqflags_t *c = __c;				\
+		local_allint_restore_notrace(*c);			\
 	} while (0)
 #else
 struct arm_cpuidle_irq_context { };
diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 01c7123d5604..f60f933b88e3 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -84,9 +84,9 @@ static inline void __local_nmi_mask(void)
 	msr_pstate_allint(1);
 }
 
-static inline void local_allint_mask_notrace(void)
+static inline void local_allint_mask_notrace(unsigned long daif_bits)
 {
-	asm volatile ("msr daifset, #0xf" : : : "memory");
+	write_sysreg(daif_bits, daif);
 
 	if (system_uses_irq_prio_masking())
 		__local_pmr_mask();
@@ -97,7 +97,7 @@ static inline void local_allint_mask_notrace(void)
 /* mask/save/unmask/restore all exceptions, including interrupts. */
 static inline void local_allint_mask(void)
 {
-	local_allint_mask_notrace();
+	local_allint_mask_notrace(DAIF_MASK);
 	trace_hardirqs_off();
 }
 
@@ -172,6 +172,17 @@ static inline arch_irqflags_t local_allint_save(void)
 	return irqflags;
 }
 
+static inline arch_irqflags_t local_allint_save_notrace(void)
+{
+	arch_irqflags_t irqflags;
+
+	irqflags = local_allint_save_flags();
+
+	local_allint_mask_notrace(irqflags.fields.daif | PSR_I_BIT | PSR_F_BIT);
+
+	return irqflags;
+}
+
 static inline void __local_pmr_restore(arch_irqflags_t irqflags)
 {
 	/*
diff --git a/arch/arm64/kernel/idle.c b/arch/arm64/kernel/idle.c
index 05cfb347ec26..69b8aa30273e 100644
--- a/arch/arm64/kernel/idle.c
+++ b/arch/arm64/kernel/idle.c
@@ -22,7 +22,7 @@
  */
 void __cpuidle cpu_do_idle(void)
 {
-	struct arm_cpuidle_irq_context context;
+	arch_irqflags_t context;
 
 	arm_cpuidle_save_irq_context(&context);
 
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 559f1eb1ae2e..ff6ac032b377 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -99,7 +99,7 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	int ret = 0;
 	arch_irqflags_t flags;
 	struct sleep_stack_data state;
-	struct arm_cpuidle_irq_context context;
+	arch_irqflags_t context;
 
 	/*
 	 * Some portions of CPU state (e.g. PSTATE.{PAN,DIT}) are initialized
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index d9629ff87861..b5089d4d9478 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -471,7 +471,7 @@ int psci_cpu_suspend_enter(u32 state)
 	int ret;
 
 	if (!psci_power_state_loses_context(state)) {
-		struct arm_cpuidle_irq_context context;
+		arch_irqflags_t context;
 
 		ct_cpuidle_enter();
 		arm_cpuidle_save_irq_context(&context);
-- 
2.34.1


