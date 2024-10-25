Return-Path: <linux-kernel+bounces-381477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FE99AFFB6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D258287B17
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F33204F9E;
	Fri, 25 Oct 2024 10:08:57 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875032038A2
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850937; cv=none; b=mlMzHnqxgMIdO7sTlySX07zDSjn1cD3okT5eTMvEkoE0s9XBbUb/leGnx/hHuo99PiJTLsR7tGTyMPUNYxPEd+Rdq8/ns7PWNkm47zP1RagriwSc6qeg4ofjOkNMsriyxYGF6NiKTXfDWwJQmDZv2JYvcSyB7tYz9i5KoGKY/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850937; c=relaxed/simple;
	bh=7evoTh19wJPUUGn+APPEiPtALN4zxV5WuwrZZIwIru0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/zD5UkCdxxAa1vR66g5JNxpVVhZNo0F+/dwafBFwPIEEeoinQ30a5JRmFcVvX/yTbSh4ZjXNy1rad44vYzPgQQSh6uz3zZToBqgV8kW7W1BLmsO0i+0n3LAhTQUhNgstGhnbt2h8iHiJ6JG4eY0H0DqyM/Ab8Oh8IKv0mqdi+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XZdjf346yz10McY;
	Fri, 25 Oct 2024 18:06:46 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id E7F3D1400E3;
	Fri, 25 Oct 2024 18:08:50 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 25 Oct
 2024 18:08:49 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <oleg@redhat.com>, <linux@armlinux.org.uk>, <will@kernel.org>,
	<mark.rutland@arm.com>, <catalin.marinas@arm.com>, <sstabellini@kernel.org>,
	<maz@kernel.org>, <tglx@linutronix.de>, <peterz@infradead.org>,
	<luto@kernel.org>, <kees@kernel.org>, <wad@chromium.org>,
	<akpm@linux-foundation.org>, <samitolvanen@google.com>, <arnd@arndb.de>,
	<ojeda@kernel.org>, <rppt@kernel.org>, <hca@linux.ibm.com>,
	<aliceryhl@google.com>, <samuel.holland@sifive.com>, <paulmck@kernel.org>,
	<aquini@redhat.com>, <petr.pavlu@suse.com>, <ruanjinjie@huawei.com>,
	<viro@zeniv.linux.org.uk>, <rmk+kernel@armlinux.org.uk>, <ardb@kernel.org>,
	<wangkefeng.wang@huawei.com>, <surenb@google.com>,
	<linus.walleij@linaro.org>, <yangyj.ee@gmail.com>, <broonie@kernel.org>,
	<mbenes@suse.cz>, <puranjay@kernel.org>, <pcc@google.com>,
	<guohanjun@huawei.com>, <sudeep.holla@arm.com>,
	<Jonathan.Cameron@huawei.com>, <prarit@redhat.com>, <liuwei09@cestc.cn>,
	<dwmw@amazon.co.uk>, <oliver.upton@linux.dev>, <kristina.martsenko@arm.com>,
	<ptosi@google.com>, <frederic@kernel.org>, <vschneid@redhat.com>,
	<thiago.bauermann@linaro.org>, <joey.gouly@arm.com>,
	<liuyuntao12@huawei.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH -next v4 13/19] arm64: entry: Check dynamic resched when PREEMPT_DYNAMIC enabled
Date: Fri, 25 Oct 2024 18:06:54 +0800
Message-ID: <20241025100700.3714552-14-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025100700.3714552-1-ruanjinjie@huawei.com>
References: <20241025100700.3714552-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200008.china.huawei.com (7.202.181.35)

Check dynamic resched alone when PREEMPT_DYNAMIC enabled.

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
index 3b110dcf4fa3..152216201f84 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -61,10 +61,6 @@ static noinstr irqentry_state_t enter_from_kernel_mode(struct pt_regs *regs)
 	return ret;
 }
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-#endif
-
 static inline bool arm64_irqentry_exit_need_resched(void)
 {
 	/*
@@ -92,17 +88,22 @@ static inline bool arm64_irqentry_exit_need_resched(void)
 
 void raw_irqentry_exit_cond_resched(void)
 {
-#ifdef CONFIG_PREEMPT_DYNAMIC
-	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
-		return;
-#endif
-
 	if (!preempt_count()) {
 		if (need_resched() && arm64_irqentry_exit_need_resched())
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
@@ -128,7 +129,7 @@ static void noinstr exit_to_kernel_mode(struct pt_regs *regs,
 		}
 
 		if (IS_ENABLED(CONFIG_PREEMPTION))
-			raw_irqentry_exit_cond_resched();
+			irqentry_exit_cond_resched();
 
 		trace_hardirqs_on();
 	} else {
-- 
2.34.1


