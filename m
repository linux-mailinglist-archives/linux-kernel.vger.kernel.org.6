Return-Path: <linux-kernel+bounces-434846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A249E6C03
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2235165FA1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F203B1FCFEC;
	Fri,  6 Dec 2024 10:18:13 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79111FCFCD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480293; cv=none; b=HvE081ewwHrXPai0KLmvxFcOdw3EhP+bP3m+FZKjsOJMNlZ2wc49WKhBPm3PW5xADzyyVhnnLBV+OrIZD7NUTSxNUeqpZ4yAMHpSrlDws3Z6nXKel11bhJBNxisp22RcWYnZY4zdv3E/w5J+e2BTtmpUX9nZj6w8r3bG7q6uHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480293; c=relaxed/simple;
	bh=IqlCJlmk1SPA0vWILXQqT7f4ZRUAS3V+HKw20kRaxao=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZGjYNY5s75R2MmwP490gKvzuu2DQDXRw8J2rq/XPcte0POSMHly6HN25ng4ns8O3derk/QjHSIt3IKsXrjrumOLJRAJbo/lZvT7wqA7J5uyjvzAVVZtWWIYez//IGHJoPUiBxBRzR9YIo2y3x7/AfaZm9MKXt4JKu9h0SM/OWxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y4Rwg75WYz1kvNq;
	Fri,  6 Dec 2024 18:15:47 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CC471A016C;
	Fri,  6 Dec 2024 18:18:07 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Dec
 2024 18:18:05 +0800
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
Subject: [PATCH -next v5 00/22] arm64: entry: Convert to generic entry
Date: Fri, 6 Dec 2024 18:17:22 +0800
Message-ID: <20241206101744.4161990-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
to use the generic entry infrastructure from kernel/entry/*. The generic
entry makes maintainers' work easier and codes more elegant, which aslo
removed a lot of duplicate code.

The main steps are as follows:
- Make arm64 easier to use irqentry_enter/exit().
- Make arm64 closer to the PREEMPT_DYNAMIC code of generic entry.
- Split generic entry into generic irq entry and generic syscall to
  make the single patch more concentrated in switching to one thing.
- Switch to generic irq entry.
- Make arm64 closer to the generic syscall code.
- Switch to generic entry completely.

Changes in v5:
- Not change arm32 and keep inerrupts_enabled() macro for gicv3 driver.
- Move irqentry_state definition into arch/arm64/kernel/entry-common.c.
- Avoid removing the __enter_from_*() and __exit_to_*() wrappers.
- Update "irqentry_state_t ret/irq_state" to "state"
  to keep it consistently.
- Use generic irq entry header for PREEMPT_DYNAMIC after split
  the generic entry.
- Also refactor the ARM64 syscall code.
- Introduce arch_ptrace_report_syscall_entry/exit(), instead of
  arch_pre/post_report_syscall_entry/exit() to simplify code.
- Make the syscall patches clear separation.
- Update the commit message.

Changes in v4:
- Rework/cleanup split into a few patches as Mark suggested.
- Replace interrupts_enabled() macro with regs_irqs_disabled(), instead
  of left it here.
- Remove rcu and lockdep state in pt_regs by using temporary
  irqentry_state_t as Mark suggested.
- Remove some unnecessary intermediate functions to make it clear.
- Rework preempt irq and PREEMPT_DYNAMIC code
  to make the switch more clear.
- arch_prepare_*_entry/exit() -> arch_pre_*_entry/exit().
- Expand the arch functions comment.
- Make arch functions closer to its caller.
- Declare saved_reg in for block.
- Remove arch_exit_to_kernel_mode_prepare(), arch_enter_from_kernel_mode().
- Adjust "Add few arch functions to use generic entry" patch to be
  the penultimate.
- Update the commit message.
- Add suggested-by.

Changes in v3:
- Test the MTE test cases.
- Handle forget_syscall() in arch_post_report_syscall_entry()
- Make the arch funcs not use __weak as Thomas suggested, so move
  the arch funcs to entry-common.h, and make arch_forget_syscall() folded
  in arch_post_report_syscall_entry() as suggested.
- Move report_single_step() to thread_info.h for arm64
- Change __always_inline() to inline, add inline for the other arch funcs.
- Remove unused signal.h for entry-common.h.
- Add Suggested-by.
- Update the commit message.

Changes in v2:
- Add tested-by.
- Fix a bug that not call arch_post_report_syscall_entry() in
  syscall_trace_enter() if ptrace_report_syscall_entry() return not zero.
- Refactor report_syscall().
- Add comment for arch_prepare_report_syscall_exit().
- Adjust entry-common.h header file inclusion to alphabetical order.
- Update the commit message.

Jinjie Ruan (22):
  arm64: ptrace: Replace interrupts_enabled() with regs_irqs_disabled()
  arm64: entry: Refactor the entry and exit for exceptions from EL1
  arm64: entry: Move arm64_preempt_schedule_irq() into
    __exit_to_kernel_mode()
  arm64: entry: Rework arm64_preempt_schedule_irq()
  arm64: entry: Use preempt_count() and need_resched() helper
  arm64: entry: Expand the need_irq_preemption() macro ahead
  arm64: entry: preempt_schedule_irq() only if PREEMPTION enabled
  arm64: entry: Use different helpers to check resched for
    PREEMPT_DYNAMIC
  entry: Split generic entry into irq and syscall
  entry: Add arch_irqentry_exit_need_resched() for arm64
  arm64: entry: Switch to generic IRQ entry
  arm64/ptrace: Split report_syscall() function
  arm64/ptrace: Refactor syscall_trace_enter()
  arm64/ptrace: Refactor syscall_trace_exit()
  arm64/ptrace: Refator el0_svc_common()
  entry: Make syscall_exit_to_user_mode_prepare() not static
  arm64/ptrace: Return early for ptrace_report_syscall_entry() error
  arm64/ptrace: Expand secure_computing() in place
  arm64/ptrace: Use syscall_get_arguments() heleper
  entry: Add arch_ptrace_report_syscall_entry/exit()
  entry: Add has_syscall_work() helepr
  arm64: entry: Convert to generic entry

 MAINTAINERS                           |   1 +
 arch/Kconfig                          |   8 +
 arch/arm64/Kconfig                    |   1 +
 arch/arm64/include/asm/daifflags.h    |   2 +-
 arch/arm64/include/asm/entry-common.h | 134 +++++++++
 arch/arm64/include/asm/preempt.h      |   2 -
 arch/arm64/include/asm/ptrace.h       |  11 +-
 arch/arm64/include/asm/syscall.h      |   6 +-
 arch/arm64/include/asm/thread_info.h  |  23 +-
 arch/arm64/include/asm/xen/events.h   |   2 +-
 arch/arm64/kernel/acpi.c              |   2 +-
 arch/arm64/kernel/debug-monitors.c    |   9 +-
 arch/arm64/kernel/entry-common.c      | 377 ++++++++-----------------
 arch/arm64/kernel/ptrace.c            |  90 ------
 arch/arm64/kernel/sdei.c              |   2 +-
 arch/arm64/kernel/signal.c            |   3 +-
 arch/arm64/kernel/syscall.c           |  31 +-
 include/linux/entry-common.h          | 384 +------------------------
 include/linux/irq-entry-common.h      | 389 ++++++++++++++++++++++++++
 kernel/entry/Makefile                 |   3 +-
 kernel/entry/common.c                 | 176 ++----------
 kernel/entry/syscall-common.c         | 198 +++++++++++++
 kernel/sched/core.c                   |   8 +-
 23 files changed, 909 insertions(+), 953 deletions(-)
 create mode 100644 arch/arm64/include/asm/entry-common.h
 create mode 100644 include/linux/irq-entry-common.h
 create mode 100644 kernel/entry/syscall-common.c

-- 
2.34.1


