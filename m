Return-Path: <linux-kernel+bounces-434858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0EB9E6C0A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3168287E3E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868CF2116F9;
	Fri,  6 Dec 2024 10:18:27 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8DE210191
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480307; cv=none; b=c0jziWHMVewY4etwWme0VKy0l64YLchXVgU3mSwkb0JiGwNv6yUEtJg126xB8t7/5soIEN4Eq1K1yv8ur7+z5p770fR0y1owxO7yn8kwcJaXbpovmjFjK2yxRbNzTTesAt+hr80Z+3Io4KPA5D1jNG3jzPtizcePWLYGAUHgc90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480307; c=relaxed/simple;
	bh=uELSP/OBp0SjmqRUcOzKoyI+fyb8P3aGzsJbnsOhRas=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLuUhKLvt8iM3R6zba56F1r9st1ujDG7bGEju72PHvFx2dw6TJueWHbHjECsqmzNu1QQSEP64co0gAUaHBQoh9vlQaiGvwfx1ObJ15JaqZH6x18giIjBF9jM9J/7BWI5gXv3B3wIgAeXys8s4UA0SgzQY0jI1BS9gy+1K3pJuro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y4Rwz4YPxz1kvQ9;
	Fri,  6 Dec 2024 18:16:03 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id CA77B1A0188;
	Fri,  6 Dec 2024 18:18:22 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Dec
 2024 18:18:21 +0800
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
Subject: [PATCH -next v5 13/22] arm64/ptrace: Refactor syscall_trace_enter()
Date: Fri, 6 Dec 2024 18:17:35 +0800
Message-ID: <20241206101744.4161990-14-ruanjinjie@huawei.com>
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

The generic entry syscall_trace_enter() use the input syscall
work flag and syscall number.

In preparation for moving arm64 over to the generic entry code, refactor
syscall_trace_enter() to also pass syscall number and thread flags,
by using syscall_get_nr() helper.

No functional changes.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/syscall.h |  2 +-
 arch/arm64/kernel/ptrace.c       | 20 ++++++++++++++------
 arch/arm64/kernel/syscall.c      |  2 +-
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index ab8e14b96f68..6b71d335c224 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -85,7 +85,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_AARCH64;
 }
 
-int syscall_trace_enter(struct pt_regs *regs);
+int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags);
 void syscall_trace_exit(struct pt_regs *regs);
 
 #endif	/* __ASM_SYSCALL_H */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index d0d801a4094a..48bb813e0ef6 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2353,10 +2353,8 @@ static void report_syscall_exit(struct pt_regs *regs)
 	}
 }
 
-int syscall_trace_enter(struct pt_regs *regs)
+int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 {
-	unsigned long flags = read_thread_flags();
-
 	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
 		report_syscall_enter(regs);
 		if (flags & _TIF_SYSCALL_EMU)
@@ -2367,10 +2365,20 @@ int syscall_trace_enter(struct pt_regs *regs)
 	if (secure_computing() == -1)
 		return NO_SYSCALL;
 
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		trace_sys_enter(regs, regs->syscallno);
+	/* Either of the above might have changed the syscall number */
+	syscall = syscall_get_nr(current, regs);
+
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT)) {
+		trace_sys_enter(regs, syscall);
+
+		/*
+		 * Probes or BPF hooks in the tracepoint may have changed the
+		 * system call number as well.
+		 */
+		 syscall = syscall_get_nr(current, regs);
+	}
 
-	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
+	audit_syscall_entry(syscall, regs->orig_x0, regs->regs[1],
 			    regs->regs[2], regs->regs[3]);
 
 	return regs->syscallno;
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index c442fcec6b9e..eb328ee1423c 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -124,7 +124,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		 */
 		if (scno == NO_SYSCALL)
 			syscall_set_return_value(current, regs, -ENOSYS, 0);
-		scno = syscall_trace_enter(regs);
+		scno = syscall_trace_enter(regs, regs->syscallno, flags);
 		if (scno == NO_SYSCALL)
 			goto trace_exit;
 	}
-- 
2.34.1


