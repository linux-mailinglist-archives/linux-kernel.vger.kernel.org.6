Return-Path: <linux-kernel+bounces-512951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FC6A33FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E0A168CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC6621D3FF;
	Thu, 13 Feb 2025 13:01:41 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C382E1A5AA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451700; cv=none; b=iNWR8XCE0RBa960n15ozuYjTuM1u0tMLeOKITX6LSkTZ0MhMWcyboCV7TEUUrJ6YB8z7ltWUgnNNxmaVtfToksX4yJD1khra1SNZuG9E6cm5CwApywvp3pI18eu2t/p9IaRzqlf2R/blObi/g1mR56tRiNyQqY9u5UMplH/Jm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451700; c=relaxed/simple;
	bh=KvSQ1mhHbzdjBYaZFoG9oQkYb3OLr1N4RbEZ2BIeTjs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fNBXvs6gPzwOKg5tfdhWimACb02m0aaurYR5X263bf//f3cfhOb3zXpNZ9ar+iBQvPwvUyAZ+8NXfGGf7pItZaT8IKcj04eQBZKVOHhLxoh4YUYljVvfAfycuKUXS92j7dXLVEur78XLzX5PwhhpRwgjdAHL6bDmdo9zX5ZwJco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YtwFk0ckFz1V6dk;
	Thu, 13 Feb 2025 20:57:46 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id E5DB3180042;
	Thu, 13 Feb 2025 21:01:33 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Feb
 2025 21:01:32 +0800
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
Subject: [PATCH -next v6 0/8] arm64: entry: Convert to generic irq entry
Date: Thu, 13 Feb 2025 20:59:59 +0800
Message-ID: <20250213130007.1418890-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
to use the generic entry infrastructure from kernel/entry/*. The generic
entry makes maintainers' work easier and codes more elegant, which will
make PREEMPT_DYNAMIC and PREEMPT_LAZY available and remove a lot of
duplicate code.

This patch series split the generic entry into generic irq entry and
generic syscall entry first, and then convert arm64 to use the generic
irq entry. arm64 will be completely converted to generic entry in another
patch series.

The main convert steps are as follows:
- Split generic entry into generic irq entry and generic syscall to
  make the single patch more concentrated in switching to one thing.
- Make arm64 easier to use irqentry_enter/exit().
- Make arm64 closer to the PREEMPT_DYNAMIC code of generic entry.
- Switch to generic irq entry.

Changes in v6:
- Rebased on 6.14 rc2 next.
- Put the syscall bits aside and split it out.
- Have the split patch before the arm64 changes.
- Merge some tightly coupled patches.
- Adjust the order of some patches to make them more reasonable.
- Define regs_irqs_disabled() by inline function.
- Define interrupts_enabled() in terms of regs_irqs_disabled().
- Delete the fast_interrupts_enabled() macro.
- irqentry_state_t -> arm64_irqentry_state_t.
- Remove arch_exit_to_user_mode_prepare() and pull local_daif_mask() later
  in the arm64 exit sequence
- Update the commit message.

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

Jinjie Ruan (8):
  entry: Split generic entry into generic exception and syscall entry
  arm64: ptrace: Replace interrupts_enabled() with regs_irqs_disabled()
  arm64: entry: Refactor the entry and exit for exceptions from EL1
  arm64: entry: Rework arm64_preempt_schedule_irq()
  arm64: entry: Use preempt_count() and need_resched() helper
  arm64: entry: Refactor preempt_schedule_irq() check code
  arm64: entry: Move arm64_preempt_schedule_irq() into
    __exit_to_kernel_mode()
  arm64: entry: Switch to generic IRQ entry

 MAINTAINERS                           |   1 +
 arch/Kconfig                          |   9 +
 arch/arm64/Kconfig                    |   1 +
 arch/arm64/include/asm/daifflags.h    |   2 +-
 arch/arm64/include/asm/entry-common.h |  56 ++++
 arch/arm64/include/asm/preempt.h      |   2 -
 arch/arm64/include/asm/ptrace.h       |  13 +-
 arch/arm64/include/asm/xen/events.h   |   2 +-
 arch/arm64/kernel/acpi.c              |   2 +-
 arch/arm64/kernel/debug-monitors.c    |   2 +-
 arch/arm64/kernel/entry-common.c      | 378 ++++++++-----------------
 arch/arm64/kernel/sdei.c              |   2 +-
 arch/arm64/kernel/signal.c            |   3 +-
 include/linux/entry-common.h          | 382 +------------------------
 include/linux/irq-entry-common.h      | 389 ++++++++++++++++++++++++++
 kernel/entry/Makefile                 |   3 +-
 kernel/entry/common.c                 | 176 ++----------
 kernel/entry/syscall-common.c         | 159 +++++++++++
 kernel/sched/core.c                   |   8 +-
 19 files changed, 766 insertions(+), 824 deletions(-)
 create mode 100644 arch/arm64/include/asm/entry-common.h
 create mode 100644 include/linux/irq-entry-common.h
 create mode 100644 kernel/entry/syscall-common.c

-- 
2.34.1


